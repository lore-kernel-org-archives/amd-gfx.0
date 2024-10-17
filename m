Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A88D3C52C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 19:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D933B10E214;
	Thu, 17 Oct 2024 19:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QjE6p8LR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7536210E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 19:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWCWfn6/HLfuaAwxNsakrEQ729q1gAeTkTsln2Gp8MZKW7eWz3U/MYLz8RwBHowvdp3fsaA3i9a3blGU1tChM6oQugcQfiTodgA3JsWLCC94hTOsrIY/1QxgGZy+cXmlp2KFdkTxDFrz7yQAWCB5rQT9+VuMsyRh2qCP5DFHI33g1rnAgOW9UN0d8b7eLYBcbS4CBk3cZ/QbX87PH6kDbNhbOjsOeceapXPsJQXUAde+TOS0kY2E7IVYIArl2NPV9z4fzAC9hZsEvKawUUViGnFNXa55+SXQY/DnVff8WNWy6LgXIJQsjdIUzHvG6BHt8oo6LwgNFyF2UwSuwohnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyyf+V9CJG9aXjNxBUcZgHjU75PXkI21EwHf+SoIiqQ=;
 b=BN3EAS8ZeKkafy/F/X4+6PVHsI+q2jQghKLLKYlfCg0HIDEL/FHD/7Ip89RCUoLRNsU13exb0M+TPItHl7iuwnzZ8xuz8YLvnIqXRU1jZDmxq8a6TY1teC5n9ancbKf2VVlBKMHLMBZVL9Gpt3PmmwEoZWIJFZ3bPQteR+an5+DpUv4CcjGcXwWyTqDsz5FbkDarc0cuHQJHfQRra/5YYdrETNtR1HjJxIBW8TCzY0RJsFM1WF8yX1SLKca6LSh7KkaVWmbMXgKyK+Sl8Ib9aopA4gfL3e6ZbTnWe4GnILkNFSy1K0eZSqI5zdEEl4MIsqUW5hI6Pk4HDE5gBAmWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyyf+V9CJG9aXjNxBUcZgHjU75PXkI21EwHf+SoIiqQ=;
 b=QjE6p8LR324VRBNpwooO3tlxAmhIpjfUw6g8I8BCXc/9LGzCY1YuvoQxr/bGCi+0gBM7ohq5bHQwLwea9rXU3f7EqlMhE9+QIe/8m/Bh1LfBgoj0E1wEResy11Yh6O59y+qjGtvRklWcC/K5xGMt6ux6v2ancxTugWjg71vUGXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 19:00:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:00:18 +0000
Message-ID: <871b2ee7-4221-4223-b2ea-243f7cedcca6@amd.com>
Date: Thu, 17 Oct 2024 14:00:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation/gpu: Document how to narrow down
 display issues
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20241017034244.223993-1-Rodrigo.Siqueira@amd.com>
 <20241017034244.223993-2-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241017034244.223993-2-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 307d1c02-9727-4f53-a2e1-08dceeddf12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anFxV0tTQzdjZGloVFJ1QVdLRVdtdDVTbEZ4cUdZN0d2bGV6V1h2ZFpoRld5?=
 =?utf-8?B?OHorL2c1YmI2MU9WNFRuTlpMWlo3djUvdkU4eDVmM0JRU1VwZnZaUFNuWDl3?=
 =?utf-8?B?elU5Yi8wektQdVJ4TFFWcEU5cE5ZcWlqNjNXQWVNSUxMaGFzd3lUbUxFVlA4?=
 =?utf-8?B?YlliY3FmZTNQYzBKR25YdG1kd1E1UU1Ibmp4VXh5SVJ3NUxLWkdzd21qOCtN?=
 =?utf-8?B?Nno1UGZFdTF4UU1lMEY0SVh5L1Q1cHlqMzZYZ1J5ZjNxcGJKaXBaUHpRSkgx?=
 =?utf-8?B?d3dEaTRQWi85bmUzWWJwNnI0bWN0Ri9lZVZadVBvZXlJSmU0Q1NYbEMyc0Y4?=
 =?utf-8?B?azNJNG1qeHJGdWJESzZDZEszV3dqK25sRTExUS9jRm5GeWJpZXNGL21TRWo2?=
 =?utf-8?B?WXE5Um1WK3BZcVRjQ1ZuMFBlZlNRdEtETnJjTENXS0Y5S2RzcmpRWXVxdjM5?=
 =?utf-8?B?dm1WaHMzaVpRZHd1OXZoQWtmQTc5U2NQSTZySkJHdHlzUHF6OHE2Q1o0dlVt?=
 =?utf-8?B?WVphMU1kcUpsdEtlUHpKbm5GK1hobU4zSHJ2R0VyTzY4VCtESnRYSWpiNWZC?=
 =?utf-8?B?TlBhQmV5aUs4VGhpalE3cW1pM1hoOEdOd1VOc2hIQ0Qzb1RSd0lkMnJsNzdX?=
 =?utf-8?B?bDlzRW1MWkNHd3MyMkRHY1lTK2xSUEhwR2NrS1VXaTB1ZnhwN0UranF1Zzho?=
 =?utf-8?B?b1FDYSt0Ym91T2lveDBNejNqTXViTDVxSUdXNCs3QTJlcU5pdEZOTmNVdWM3?=
 =?utf-8?B?UEZiZm14eWpVbHRYaFM3TzJ1Vkt6THk2aTZQdVdvRmtjbVkwZlFYRm16OUdI?=
 =?utf-8?B?eDlSZ3hsOHJQbHRpaVFlVFIzelhLVlp4aFlYWWowcXgrYldxU1hFWWtpUld5?=
 =?utf-8?B?Qjc2SXd5VjJ1TTM0RjhnZGNINzlOb0tEdTlJUWVkVjEyVVpnZFhOT1l4aWdy?=
 =?utf-8?B?bUFuVmNjS0l5UHRySEZBdjlQRThSeXFvOWV3UVpKWEp6S1c1UXdiVU9pNnVT?=
 =?utf-8?B?S3lFUlBaMEJIcEU4ZkdKaUFuQTlDV052OS90bWNWZ0ZyRG0zSTNwTXhObitr?=
 =?utf-8?B?Tko2NEQvNmpOb08waDh1WmRDamVSMittMjdxWjl1bjBJWEdOQnJweGx0VmJV?=
 =?utf-8?B?cnRtQjlxbFZ1RXMvMllpbjdKbkdDZTdsQzdXOGFvZ2R4NDEvdUZ0ckhtK3Mr?=
 =?utf-8?B?SjhFQkZocEtYY3NSb0tRVi9EL0djamg4dnJ2bzJkcXg4TVE0c2VPT01waVVu?=
 =?utf-8?B?QjM0ME1ydGxoMXdaQ0tTRGFGZUR5WmNVcFNlR2xaOUZsb1ZobFFIN0JEQVN2?=
 =?utf-8?B?ZE1tSUdPR2hXQ1MzTU5yQXViVGUvL1hjYkhrS0l6Y0VjWURFa00vQ3FaQWdy?=
 =?utf-8?B?VXJyUnkzenNMK0JKNDA2VHNwKzJSRVk0bG1UZEtEcUJKeVZnQytXYkwyTjdB?=
 =?utf-8?B?UzdjdnloMTdsRVh2WmQ0dkxWS1A2alhyVHNHN3J0YkZzdDRFck9OMHArRTJN?=
 =?utf-8?B?U1BFVTRnRVg3Tk4vTFVybDJ6OGtsRDJ4MGVEMkl0cjZoTXVCcDkvYWVxcERS?=
 =?utf-8?B?NE5YWnBIcWFKNVU5RlVnK0lJZzdIR3VwKzVXc09uWGh1VDhkdWFIMGFwK3NC?=
 =?utf-8?B?RnpKbXN1aW9rRmc2SGczQnJydUNoNnAvMWljTHBDYXJqenhBRHBFWUErZFdU?=
 =?utf-8?B?ZEZ1ZlpFdU5nYlBaQ0R3UGlrRE56UjJQV2JEckpoaU8vQVFhL1lqdVBGWjMw?=
 =?utf-8?Q?RDM+2mxZfze4llkhLIWrP3TbMAYrjzJAwyy/dHS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpEOG1yRnRRQWhLdTRhRFU4T0dEcUp2NkdmcDVQbkF0cnppc0wrYlJEalkv?=
 =?utf-8?B?Mlo5RFdZNG1uYzJnRGk4bUJVd1djL0NubG5sMlJJWnRKYjJueUR6Um45d0Ju?=
 =?utf-8?B?TlNaVDRaaDdqMnliWENsV2JmTWwyM0tIdStxUkJzNnBZM0Y4bXk2aW9jY0Zi?=
 =?utf-8?B?dVJmRHlHWlY4V01IVFB2MHFmRXNtSWQrNW4xRUQwODltbXphOVllTEp5RXRz?=
 =?utf-8?B?TVFhRWxSNlFXL0VvSVE2Y001QmhjMHV4Zkc2dXJidnl0YUYvTTJHaFZISVZX?=
 =?utf-8?B?WkdjeldtQkltTmRWdnpBeXMrMkh2ZG1zYkNERy9uMmNIS3F1OHBaRERJOW05?=
 =?utf-8?B?V29sU04rY3lRVmR4aU9zZzljY1VFY1VWWlJYVlNvVE1KSXA0VEJodHFtSnda?=
 =?utf-8?B?Sk1OZkpPY3JPR3dWZnV0OHFHZnJsKzZtc2RqOFQxSEo4aXYrQ1k5V3Bhekx2?=
 =?utf-8?B?c0crN2dYR3dlQ1JmVFp1L0hhRk1LcExKS2VVOTVqR1I2dmZTUVF5TCsvaG5Y?=
 =?utf-8?B?anl0NDV5Z1YwaWVYb0FBd2c1a3BEQzY0VTRzbzNqQU5pdDI4RWxXeC9vcDdZ?=
 =?utf-8?B?eS9lU1RxYysrc0Vjald1L0FZV1NoYko3Rm1pY2owSytscTdjVVV5blV3YWRt?=
 =?utf-8?B?d21va0huZGY1ZXh3d0tGMTNNblMxaE1EYzBvY1RLWVhKeThNMUZaUXp4Q0cy?=
 =?utf-8?B?bW85OVBZUlI2NTB5eisrOEN5WXBFTUFFVlAzVzB2YWZlR1BLM2lwa0t2QmZm?=
 =?utf-8?B?ZnVXWHd5bWwzQ2JZK2MzenMrb0NQVWNMQVFvYStNcjRIVTZtQVJ2Qm40Rmc0?=
 =?utf-8?B?M2VRVjF5a3M0R1FQTVVVanF0TU1JOW94ZmE3Wm1yTUt1cVpxZ0VucU1pQkJJ?=
 =?utf-8?B?MzQxNWp4d2g2M2ZWL3lCa1o4VlM1a1c3d3ZnZWJuSS9lV20rNUVzVXZmK3Mr?=
 =?utf-8?B?eTRwM3hSUkRzVUFraVJyZXh1MW1KYmVQNVo2NzU2cjJGZmYzclRLS3d3bG10?=
 =?utf-8?B?R2M4SW5CYk5XM2tvNk1oOUdCZ0IzZVBTWHFxZVZjWm9FajlDcVNtNm5tV2Ju?=
 =?utf-8?B?OTRYdTAzMkRTdU5VREZWNVFDRUtWVWVFaXc4cnBmYzZqbW1JaHc3bzZvcUUv?=
 =?utf-8?B?bDQzNW9GelRDZFh2YXBqMXdnK1M4bWN6ZkpRczd0M0V4Tmgwc1Yxd2xtdHlh?=
 =?utf-8?B?aktCdmFtU1RIZmNUbGEvcWNrYkNYOGlsZ1lkVHVtQkRjdSt1YkR3ZGdsdmh3?=
 =?utf-8?B?SStKMzFPYStabnptYXk2Nnd0clhRRHkrSjdkNVNMakJJbTF3WDU1ZWd6NHRG?=
 =?utf-8?B?Y3hnTStJM21kRlZlSHMrY2gwRWlPaytkdm4xUkVMYitsWWFseW8yanFSbFRK?=
 =?utf-8?B?TUszZlRDN1F6RVErUUVYK0xrb1RnSktoUTJmNHJGUjAxaHR3dFU2TDgxeXdV?=
 =?utf-8?B?Mm55QnJFVWRKSVRNNm52NjlxZXBWeGZKUzVOZHdpT1ZldXljQlozZllLam9M?=
 =?utf-8?B?VUFneHhRc2hBR2ZkbG80em15ZW1tRXFHc3FMeG4rTW9YMG5PKzdtQ1Q2eG5r?=
 =?utf-8?B?RzV1aFdzcng2Wm90VVZuNkp2dEhMY2RUWEdBdTlJTGFGdFVQZDBtMWlIWHBH?=
 =?utf-8?B?eGo0UEY5RjNicmFUVXFLOVpNa0p0ZEhpNHlVRTZhNXhmeE9ocmhtYWJ5RmNK?=
 =?utf-8?B?OG1aNWE2TGdRZG9YcGpxVitXU0pMWkdMcjZYZlA0QkQvZjcraXFPVWtTZFVp?=
 =?utf-8?B?eWVNODFBWHJHa0NkN2dZbFUwNktPMlpaQVVUazZ2Q2lmaDJmT1NrbGdaUmF2?=
 =?utf-8?B?VjNkV2lqQXdqOTBQWmc4azg5UzUyeDBWVGtsaHUvU3ZleUJjNjNCT3R6NEx2?=
 =?utf-8?B?VDRPOUFaakJuQXNDaFByaVFHUG4zUk1XZmkxRnNZS3pOZC95bWZGMTFtMS9x?=
 =?utf-8?B?bVBOVWJLcGNycEFSc1lsMUlYNU4wTFdYNW04Ri9rNXNkTjJPelVDd1RZMnNy?=
 =?utf-8?B?R2hEdGcySXhVQjNoM0FTUko2TWovY081eTkvNlArV2k3SWQweDV4MSswWTkx?=
 =?utf-8?B?Zm9TS2RwNVVpVmd6cDZTeWdLRnF1MzlJSklyNmFNWnd4bGhmMXpEcWNTWHlj?=
 =?utf-8?Q?IS5ZopAJfuHPI1JbziCWH2El0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307d1c02-9727-4f53-a2e1-08dceeddf12d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:00:18.2964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6FMvl566avtCzIY0Yln+j3+Aqk3YxMaDr4+p+HSqkm/JXl4ibvLMVarQTZCSoDfU0PoQtwwEdzZh6eGV9JdGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/16/2024 22:34, Rodrigo Siqueira wrote:
> The amdgpu driver is composed of multiple components, each of which can
> be a source of some specific problem that the user/developer can see.
> This commit introduces steps to narrow down and collect display
> information.
> 
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/gpu/amdgpu/display/dc-debug.rst | 187 ++++++++++++++++++
>   1 file changed, 187 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/display/dc-debug.rst b/Documentation/gpu/amdgpu/display/dc-debug.rst
> index 817631b1dbf3..013f63b271f3 100644
> --- a/Documentation/gpu/amdgpu/display/dc-debug.rst
> +++ b/Documentation/gpu/amdgpu/display/dc-debug.rst
> @@ -2,6 +2,181 @@
>   Display Core Debug tools
>   ========================
>   
> +In this section, you will find helpful information on debugging the amdgpu
> +driver from the display perspective. This page introduces debug mechanisms and
> +procedures to help you identify if some issues are related to display code.
> +
> +Narrow down display issues
> +==========================
> +
> +Since the display is the driver's visual component, it is common to see users
> +reporting issues as a display when another component causes the problem. This
> +section equips users to determine if a specific issue was caused by the display
> +component or another part of the driver.
> +
> +DC dmesg important messages
> +---------------------------
> +
> +The dmesg log is the first source of information to be checked, and amdgpu
> +takes advantage of this feature by logging some valuable information. When
> +looking for the issues associated with amdgpu, remember that each component of
> +the driver (e.g., smu, PSP, dm, etc.) is loaded one by one, and this
> +information can be found in the dmesg log. In this sense, look for the part of
> +the log that looks like the below log snippet::
> +
> +  [    4.254295] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1002:0x0E3B 0xC8).
> +  [    4.254718] [drm] register mmio base: 0xFCB00000
> +  [    4.254918] [drm] register mmio size: 1048576
> +  [    4.260095] [drm] add ip block number 0 <soc21_common>
> +  [    4.260318] [drm] add ip block number 1 <gmc_v11_0>
> +  [    4.260510] [drm] add ip block number 2 <ih_v6_0>
> +  [    4.260696] [drm] add ip block number 3 <psp>
> +  [    4.260878] [drm] add ip block number 4 <smu>
> +  [    4.261057] [drm] add ip block number 5 <dm>
> +  [    4.261231] [drm] add ip block number 6 <gfx_v11_0>
> +  [    4.261402] [drm] add ip block number 7 <sdma_v6_0>
> +  [    4.261568] [drm] add ip block number 8 <vcn_v4_0>
> +  [    4.261729] [drm] add ip block number 9 <jpeg_v4_0>
> +  [    4.261887] [drm] add ip block number 10 <mes_v11_0>
> +
> +From the above example, you can see the line that reports that `<dm>`,
> +(**Display Manager**), was loaded, which means that display can be part of the
> +issue. If you do not see that line, something else might have failed before
> +amdgpu loads the display component, indicating that we don't have a
> +display issue.
> +
> +After you identified that the DM was loaded correctly, you can check for the
> +display version of the hardware in use, which can be retrieved from the dmesg
> +log with the command::
> +
> +  dmesg | grep -i 'display core'
> +
> +This command shows a message that looks like this::
> +
> +  [    4.655828] [drm] Display Core v3.2.285 initialized on DCN 3.2
> +
> +This message has two key pieces of information:
> +
> +* **The DC version (e.g., v3.2.285)**: Display developers release a new DC version
> +  every week, and this information can be advantageous in a situation where a
> +  user/developer must find a good point versus a bad point based on a tested
> +  version of the display code. Remember from page :ref:`Display Core <amdgpu-display-core>`,
> +  that every week the new patches for display are heavily tested with IGT and
> +  manual tests.
> +* **The DCN version (e.g., DCN 3.2)**: The DCN block is associated with the
> +  hardware generation, and the DCN version conveys the hardware generation that
> +  the driver is currently running. This information helps to narrow down the
> +  code debug area since each DCN version has its files in the DC folder per DCN
> +  component (from the example, the developer might want to focus on
> +  files/folders/functions/structs with the dcn32 label might be executed).
> +  However, keep in mind that DC reuses code across different DCN versions; for
> +  example, it is expected to have some callbacks set in one DCN that are the same
> +  as those from another DCN. In summary, use the DCN version just as a guide.
> +
> +From the dmesg file, it is also possible to get the ATOM bios code by using::
> +
> +  dmesg  | grep -i 'ATOM BIOS'
> +
> +Which generates an output that looks like this::
> +
> +  [    4.274534] amdgpu: ATOM BIOS: 113-D7020100-102
> +
> +This type of information is useful to be reported.
> +
> +Avoid loading display core
> +--------------------------
> +
> +Sometimes, it might be hard to figure out which part of the driver is causing
> +the issue; if you suspect that the display is not part of the problem and your
> +bug scenario is simple (e.g., some desktop configuration) you can try to remove
> +the display component from the equation. First, you need to identify `dm` ID
> +from the dmesg log; for example, search for the following log::
> +
> +  [    4.254295] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1002:0x0E3B 0xC8).
> +  [..]
> +  [    4.260095] [drm] add ip block number 0 <soc21_common>
> +  [    4.260318] [drm] add ip block number 1 <gmc_v11_0>
> +  [..]
> +  [    4.261057] [drm] add ip block number 5 <dm>
> +
> +Notice from the above example that the `dm` id is 5 for this specific hardware.
> +Next, you need to run the following binary operation to identify the IP block
> +mask::
> +
> +  0xffffffff & ~(1 << [DM ID])
> +
> +From our example the IP mask is::
> +
> + 0xffffffff & ~(1 << 5) = 0xffffffdf
> +
> +Finally, to disable DC, you just need to set the below parameter in your
> +bootloader::
> +
> + amdgpu.ip_block_mask = 0xffffffdf
> +
> +If you can boot your system with the DC disabled and still see the issue, it
> +means you can rule DC out of the equation. However, if the bug disappears, you
> +still need to consider the DC part of the problem and keep narrowing down the
> +issue. In some scenarios, disabling DC is impossible since it might be
> +necessary to use the display component to reproduce the issue (e.g., play a
> +game).
> +
> +**Note: This will probably lead to the absence of a display output.**
> +
> +Display flickering
> +------------------
> +
> +Display flickering might have multiple causes; one is the lack of proper power
> +to the GPU or problems in the DPM switches. A good first generic verification
> +is to set the GPU to use high voltage::
> +
> +   bash -c "echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level"
> +
> +The above command sets the GPU/APU to use the maximum power allowed which
> +disables DPM switches. If forcing DPM levels high does not fix the issue, it
> +is less likely that the issue is related to power management. If the issue
> +disappears, there is a good chance that other components might be involved, and
> +the display should not be ignored since this could be a DPM issues. From the
> +display side, if the power increase fixes the issue, it is worth debugging the
> +clock configuration and the pipe split police used in the specific
> +configuration.
> +
> +Display artifacts
> +-----------------
> +
> +Users may see some screen artifacts that can be categorized into two different
> +types: localized artifacts and general artifacts. The localized artifacts
> +happen in some specific areas, such as around the UI window corners; if you see
> +this type of issue, there is a considerable chance that you have a userspace
> +problem, likely Mesa or similar. The general artifacts usually happen on the
> +entire screen. They might be caused by a misconfiguration at the driver level
> +of the display parameters, but the userspace might also cause this issue. One
> +way to identify the source of the problem is to take a screenshot or make a
> +desktop video capture when the problem happens; after checking the
> +screenshot/video recording, if you don't see any of the artifacts, it means
> +that the issue is likely on the the driver side. If you can still see the
> +problem in the data collected, it is an issue that probably happened during
> +rendering, and the display code just got the framebuffer already corrupted.
> +
> +Disabling/Enabling specific features
> +====================================
> +
> +DC has a struct named `dc_debug_options`, which is statically initialized by
> +all DCE/DCN components based on the specific hardware characteristic. This
> +structure usually facilitates the bring-up phase since developers can start
> +with many disabled features and enable them individually. This is also an
> +important debug feature since users can change it when debugging specific
> +issues.
> +
> +For example, dGPU users sometimes see a problem where a horizontal fillet of
> +flickering happens in some specific part of the screen. This could be an
> +indication of Sub-Viewport issues; after the users identified the target DCN,
> +they can set the `force_disable_subvp` field to true in the statically
> +initialized version of `dc_debug_options` to see if the issue gets fixed. Along
> +the same lines, users/developers can also try to turn off `fams2_config` and
> +`enable_single_display_2to1_odm_policy`. In summary, the `dc_debug_options` is
> +an interesting form for identifying the problem.
> +
>   DC Visual Confirmation
>   ======================
>   
> @@ -76,6 +251,18 @@ change in real-time by using something like::
>   When reporting a bug related to DC, consider attaching this log before and
>   after you reproduce the bug.
>   
> +Collect Firmware information
> +============================
> +
> +When reporting issues, it is important to have the firmware information since
> +it can be helpful for debugging purposes. To get all the firmware information,
> +use the command::
> +
> +  cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
> +
> +From the display perspective, pay attention to the firmware of the DMCU and
> +DMCUB.
> +
>   DMUB Firmware Debug
>   ===================
>   

