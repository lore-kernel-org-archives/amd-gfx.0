Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBC6CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D9410E26B;
	Tue,  4 Nov 2025 13:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5H48dKGE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013029.outbound.protection.outlook.com
 [40.107.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6F210E26B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS261+Ij4lpSRMqIgsba76UsnUNgMxkvIhtQ0WnHv7OIabBtnNHTWk+VGTuTrmnLRPAkTVt406HKVOGihzA/Z1BkkYMJ/qQeBlWxUJwi8pGYoOebedeNRRmyxd14BbWg083vmmGM4yFctvpMEF/0DWWH0PMVoxsC0TQGk8xcsgwDV29XCFTe/lo90ISr4jL8VwUr5/4Gvon9NH/mDZbMiZ/n9o2sqMenruT5jS1CZkEJW9eaeODBifMxD9ljJ17iClkRt58R1UWfYBCG8/z1oyGzh1rCYlF/4372KzNTMrcpHeFTP3+qTAXMxcLDXM8UGnlrOmWAswMydKD7G3oGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaUMsJaSPOCxfKiXICgu80sqNyqpVqBEhEpOVbd6Ll8=;
 b=cMfjkwayyOc97TWilmMlEa4V2tbRtoQNxEf06jP5ddCgZxp855rswDWD01CV+LTXERWtK9TqJ2AQO5hOExwvxdCFdZRG2/lF5YNNAUoHLcSEy8n7n1jBrL9BVHIAgZE1N/DxXXXVEz8tZgiMJlnUOkGOWcJ9Gdwv7ou+Ra399H4UksZlHm0tqwrVqlMy1jBpv1zliV1/q9KCe3f6JwDpLE3nVUDOUymOsvfpJ9kYv/qUu77j1Amxtdb+JmSwcVXWNesNO0z0nfk6aJ9s//xnAbbqUsXxfqzOKV1nJHhFA08ZnIXQkZzw4cQvuVWzF8lTzHvQmMV7l4wT+Bw9NQOYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaUMsJaSPOCxfKiXICgu80sqNyqpVqBEhEpOVbd6Ll8=;
 b=5H48dKGEzlPGQt5e4qhdi7cmL2r8ECVnx1J5QwOrz7Ys8dTGGXqtFO7Q+vGF1kVmyvJ79OLMZUilzt38f/e1lB9f60PHxxXhBKGDRwV9Bk++FTKw3lCRomPLkbvGIQ0WxsubNQuDApFqwnlB4qg97h27yx+1XPJgwb9pR26ms7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:32:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:32:10 +0000
Message-ID: <9011b1da-c7d8-40a8-81a3-f5ec6d2c60d6@amd.com>
Date: Tue, 4 Nov 2025 14:32:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103222333.37817-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: c63c03e4-212a-4e8b-04c7-08de1ba68e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHF6QS9WTzJQREo1MjlhclB3cDVGVmY5aEpxVjVRWHFhakVjQ0YrYmZmRGR1?=
 =?utf-8?B?ekZHWXN2WVNNOE5RMlpQZEZvWXZmM09FK0x2c2JocFhXMEUzOEd1QkdlR3Zn?=
 =?utf-8?B?bFZIMXNJaGtndDZCVUhKZDdzS1lzdGlOUnk5Z2l3QTNIazRGSmhMWlJXYkFj?=
 =?utf-8?B?ZnpmLzUyQXA0SWhMNWtmaE1peDEyY3NCSWNtZjBKdFRVZm9vT3hKTk9CRk1z?=
 =?utf-8?B?b014SUIvbk92ak43SkVpakNsYWRUNGNoUWg3Qk1KWmVsRjlzRjRWbEhndnc2?=
 =?utf-8?B?UFlibDJrQ25pWll6Z09aczJnQVgrS0swb3dSVERSVVIvaXpqV2lzT3kzUHFy?=
 =?utf-8?B?RWRUVkFnWVNvNjhSM2JsZTlXNnBEYW9sRmJOaFM4RkhnK2lEN3htZ28vT0tj?=
 =?utf-8?B?YXVBaTdKVk9MVXhydDhBWithaHp3NG8vZFBUc1lVQ3hCOU9qQi90M3Nua3dH?=
 =?utf-8?B?cVo2YW1PZU1SUkFiVWVMdmZoQTk5T1U2dERjNTBuSDcxRGY3ODROK013d093?=
 =?utf-8?B?TWlVbVIwSzNwSjQ5OW5uam83MmdEM0JsLytWRS9Ld1M5YVV4TlErQjRzdkhn?=
 =?utf-8?B?K0o4UnI3bEhZWjFrb0cwSmZ5SEU1c01WZ0RyTTVOU1l1bTY0Y0c1WjliaWt2?=
 =?utf-8?B?L2VEZTRVVUNXQmJ0cVQ1amZYSlloTk1Jd01FTmt5Smh5V2ZDOXp1MnZuVStt?=
 =?utf-8?B?VUo5aTErUmNNT2FabHBlYjRoRUNtV2VWakVLdkZvL3pxRHZPZzNWeEQ3cXNB?=
 =?utf-8?B?K2VzM2UrNVVkMkhEQ1VKeldWTGg5VjAzbFpock9Sd3R2Qm84U0E2Z01iU3My?=
 =?utf-8?B?VlYxaDBISHBBbFhCeHBhUkNZS1JOMUdjMkxMOXp5L1FsbEcwSWhnSGJQR3lv?=
 =?utf-8?B?M3ZjVEFHWFdsM1JjWklZVjA1UDlESzdRdHplZjk5Nkl0L2YyU1ovZEtXVitX?=
 =?utf-8?B?WUc2VEJ5OFdaRmhCU08wNkg3VXBkanRhYTNlbXFYQWlNZ2g5ei96U2JiMUpk?=
 =?utf-8?B?aWw2NWtpd3B3MmJvTUdkYnBqeTV2amhCbDNJNkNNVDhaNHN4VjNvTHRWUlBx?=
 =?utf-8?B?V1VzcmJPN2tSQmtCNGRXUDdUWWN5QXU3dUQ1RVJZLzB6d3ZpcFZzYndxRHdP?=
 =?utf-8?B?RVlFcjBLcUswZHpWQXQ2U0h1VWxHb3ljTVhSeHdOQW5sbEl1NThEU0Vaak1q?=
 =?utf-8?B?clZMYlc0V3BLRm5OaEo1eXd5RVFGOElNUmoyQVVSYkZHVURucTM5RDFYSjFh?=
 =?utf-8?B?R3dHZm1RRFFvRnF3NUhzMnJFbmxKSmNVTkw1LzJoYXJZRURyaDR0amJFd0Yz?=
 =?utf-8?B?SUpvaXRZdVVvSU5mZU1uWkpickczWmhpbyt3ZEhGTy8ycjZCeWVmc1Z5Rysy?=
 =?utf-8?B?eGFnR2U2TUw0Qml2M1hhRnFHNUNXcFlrdStVVGF4TE4vVEJkdW1OM2VKTzhU?=
 =?utf-8?B?VXZuNjlDNVVPYkxtZzZvWDhYK1RLWkFZWmUvQWd6R2lhcktMYzJENWoybXlp?=
 =?utf-8?B?WkNIR1VMM0kyMmRhaGVUVSt6R3lOdVNDbXpVb1VJVGxkSDNHbGovcTFVR2JL?=
 =?utf-8?B?NzIvMG1nb2M0VVRmeFdCSWo2dkE0Wkl1VWtwTmFoK2Q3R3FKSVpuZVZpd3hu?=
 =?utf-8?B?aXJMYmtCeXZDU2RqdlVianorNVhZUDNhZXJjQWtuc05qN2tsV094L3JEMGh0?=
 =?utf-8?B?Q2pKY21TQUc3azVNeUp3ZUh0dzNSUDZoV3JtakN2OC9xUkYvVGs2K2JlaFRq?=
 =?utf-8?B?NFhJT2pDQkIxZ2UyMm5FQ3ZORExZQmo1YWVCVmZHQmZXZXl3SGhRR2RxT2RY?=
 =?utf-8?B?czZabjN3MmlnelZFTzA4NjVXU1Z4cWJINlBQRHF6T1d6RVlFYi81TGpwdmg4?=
 =?utf-8?B?UENRTWJpTVJ0NXNPcFZxUEliY01hV251VzJTTnU3SFI0ZFcyamZXZzMyK1pk?=
 =?utf-8?Q?CY8+xbowwmyvvIC9p/wBsvZ+O74WDPRL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFlTFpuNzc0eU4xTVlxVllKL3kxNmdXUGNPRXllcEdiWDlUcmt1NHJmZ3Ur?=
 =?utf-8?B?cEthSHZDZ3FoTTZpSitQMk9qZWk1R2Y5ck95eUFreDdUekRYL0ROekYyTllZ?=
 =?utf-8?B?VEdaVnBnOUtuODd4Nnh3cHRMeXcvV0xycHlCbERnUmVHTW9MMVNnMFZwMFIy?=
 =?utf-8?B?d09yOXdBa1M3b0dvNXZkWlNENSs0R0dVc3hRTHF0bTk5VGoyYWpjdjhGMXlw?=
 =?utf-8?B?N2YyWjg5bVBseFBDWFk0VitkVUh4NGhDN25HZjFmUGRjQnJBK0tJbEgzbGxz?=
 =?utf-8?B?Y0tsSW1RSStDck1rektIdWxOUzV1Z0thWXRoSEN4d0dNMEJJeGxlMVRVcXl4?=
 =?utf-8?B?UUpXVFNJdzJuZnAyRWZBM1lnQnZKTDlGNmpCMmZjM0dWRGRwTXpwVVIrOUxI?=
 =?utf-8?B?L0VhM0JDRFFGT0FhY1I0Ny9uRjR2M2JUcSt2cEc2M3R1THpQdXVTNXhUVUJy?=
 =?utf-8?B?YXc0OURhcS82TW56andGM2x6NG5kQUEwZStleUtiaXNXNjJCenpnOUg0MGV6?=
 =?utf-8?B?QUJ6R0hzWDdqRVFUNkhiemtmalllOG42Lzd0bGxsQkFtbFo3dy9EdHZYTUkx?=
 =?utf-8?B?UWRPbUd5Umt3UDQ2MmFkdWhYWXBaajc5ajhnTGcxZHlCQURrSkZmdTNQcU96?=
 =?utf-8?B?cTdvOTdXdlNYdmd3YWpZU0lpc0hQRHozZWxob3l0bnphUTR0YTAyTFpKeXhz?=
 =?utf-8?B?ZnpmRysyTHlvRzJwKzNncHRXNW5SUGtudUdSM3NRbERkZERYSzlSclpXd1F1?=
 =?utf-8?B?RnEyck9rZGJyMWtMQWVyZGE0TXVOaFdVa0s2cE02QmhBbGY1bmxxcXA1MjVE?=
 =?utf-8?B?UWtUSlFyd0FjYlg4QWJsUy9aTG44eEk2ZVlRN3BaY3ZBbkppS25velY3R0lD?=
 =?utf-8?B?Q0gxZWpmYjJnTlBCT1phTWh0VGVDN0tQK0NqRDNOengxZlV4RFo0OWh0QTZm?=
 =?utf-8?B?ZkhZTXR4Ym9iejdZN3lSZjNNVW1IZTdidXdsWHRqdktvWDl3NW96NTNBTVQ1?=
 =?utf-8?B?VTlyU0J1MThtZi95d2p2aFpib1RPVU5MOGNBUUtTV2NvTDJPQjVqdWVoandm?=
 =?utf-8?B?K1ZkVGlINGFHc2lRT3Vkbm5qOW5CLzlsR0RwR2dFckJtWjZtN1Fna1pRZGJL?=
 =?utf-8?B?aEc0YlpOQ2JqZ092QVRoNXlFYmZiaWFrNzlHTm9CZjdxTWw4WE1ia09VOGpp?=
 =?utf-8?B?MmlMWUVWNWVrZSszaGJjbFVLT1I4RUdDV2ZjVWtUTWJBNk1GTWJYS3JKeHlR?=
 =?utf-8?B?bnA5ZEdmdmZSSElQV0ZYcDFHZUFxdTJNcTl5bzlHb2NCY1hOQ2VwTGdvWmtu?=
 =?utf-8?B?RzRNUXd2VXVTSnRhd0hjcTdZVmJkSnZROTk0cHMxaG5yMEZtOVFnTndMb0dQ?=
 =?utf-8?B?a1BMZWZESUoyS2JuS1kyQjhOelc1UC9Ya005dlUrampuN21oUnlKSnErWEZL?=
 =?utf-8?B?YnJoRW5QdUhOeEFNbHFSbXdSUU5uenBBQ1Vka0hnelM2dkgvaTVmaE1TeE1z?=
 =?utf-8?B?VnNUSTJSdy9DQTlJMG1jN25oMmNnanlNYnNORUFidkx3NmxtOTZDM2ZBQk9N?=
 =?utf-8?B?UzdmUzIwbis4bmlyZ1RWWE9PRUMxMlQyQTliMk03NnlkVmFaSFp0SzU2ZGtN?=
 =?utf-8?B?dTlSVUd3dFp6Q2JDSG94V1JGeGxDS2J0UUNlbTZrOUk3c0syZ0Y0R1lzTU1H?=
 =?utf-8?B?aTVKUTIxQWZBcWhYeGZhRDh5RUFiWlNoNVVJS2JBWm9PZjVXT1IwcGVrMXAx?=
 =?utf-8?B?VGMwU3U2Vkcvb0dkNENpeWRWay9waG5sdWRHRXhiVU9kL1hMMmpsT1JPV3Nx?=
 =?utf-8?B?MWxVcW5nQTkrbStET2Y2bERZR25PeWM2dFFTZ0gyZi9NSS80Rm9EN2NvTVV3?=
 =?utf-8?B?ZlNmSjBjRjd0YUNuOWY4dGR5SzZJM09uS2pHbmsyMC9pRXEvTWZUWUc1SGI1?=
 =?utf-8?B?b3FBQ3I2ckp3WllNalFMNDdUVFl6VzlzbmV4c2FCVHd2SG9pbEwxNGQ1K3I0?=
 =?utf-8?B?NVQrMFJzRnhSbmk3cWpYL09qcHlsdGp3T3ZSWHZtQnRIWE5XaHdZbjczNkEx?=
 =?utf-8?B?RVdKZDlHMzlTNDZ0aFVYeHlXSitPOHZCZUFOdW8zVk5rZmZzd1BRN1FZTFlU?=
 =?utf-8?Q?TcRJe7Bz8csttQehQVfCHSi4z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c03e4-212a-4e8b-04c7-08de1ba68e91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:32:10.5961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaJq/QnDfqbrLGIbqDCs+AWyzWrh9YsA5Io6ZGTciYhshg1nP14ADDv+TGTgJrDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

On 11/3/25 23:23, Timur Kristóf wrote:
> Binds pages that located in VRAM to the GART page table.
> 
> Useful when a kernel BO is located in VRAM but
> needs to be accessed from the GART address space,
> for example to give a kernel BO a 32-bit address
> when GART is placed in LOW address space.
> 
> v2:
> - Refactor function to be more reusable
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 36 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  3 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 83f3b94ed975..d2237ce9da70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -367,6 +367,42 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>  	drm_dev_exit(idx);
>  }
>  
> +/**
> + * amdgpu_gart_map_vram_range - map VRAM pages into the GART page table
> + *
> + * @adev: amdgpu_device pointer
> + * @pa: physical address of the first page to be mapped
> + * @start_page: first page to map in the GART aperture
> + * @num_pages: number of pages to be mapped
> + * @flags: page table entry flags
> + * @dst: CPU address of the GART table
> + *
> + * Binds a BO that is allocated in VRAM to the GART page table
> + * (all ASICs).
> + *
> + * Useful when a kernel BO is located in VRAM but
> + * needs to be accessed from the GART address space.
> + */
> +void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
> +				uint64_t start_page, uint64_t num_pages,
> +				uint64_t flags, void *dst)
> +{
> +	u32 i, idx;
> +
> +	/* The SYSTEM flag indicates the pages aren't in VRAM. */
> +	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> +			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
> +	}
> +
> +	drm_dev_exit(idx);
> +}
> +
>  /**
>   * amdgpu_gart_bind - bind pages into the gart page table
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index 7cc980bf4725..d3118275ddae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -64,5 +64,8 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>  		     void *dst);
>  void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>  		      int pages, dma_addr_t *dma_addr, uint64_t flags);
> +void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
> +				uint64_t start_page, uint64_t num_pages,
> +				uint64_t flags, void *dst);
>  void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>  #endif

