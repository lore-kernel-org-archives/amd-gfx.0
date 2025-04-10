Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929CC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 11:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB46710E970;
	Thu, 10 Apr 2025 11:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKknqdtp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2983910E970
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 11:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtEBgzGDUuwTE1GJePGmO+jXstq/fxbCzdKG8XLpD+HnKxC/H5prrCQ/KCMms1B+6s5iUyLxcH4tljyfonywZp/q2mmfCBtCuODyuNakAaj39Df24dA2qKFfVItWjwBNryXPT3jdk+5oasTUiefqpERKTtE1JxHA0a5NMScDkJWZGBHdAbcd5tMZI33YfqOxfI4kpUpN9qlxiQHa2w61lkedHhKbWtjnMsU+rjt4OhYeLSipmwty8fByZfJGjPnzpTq2L7m9XrUYH/DRzFog93uek1zQauN8LqmOoSu+O3Oep4TqkrLoI6WfNFq0do9m2hQnUr9tmW6cBTU5e/So3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRkGHei9gIJpzHkKjel/HBu7/62KE7fwr7owPr/ABpQ=;
 b=nX1sTDktCCUcJ26SLsoq5v8C3c3NFDLkyZE8bjP7YLjsBNyHwhQxDM6zIEwSQx2bytV8OEwvNR/gMc3uWJ6seIVbXWPGOQPvUXEQuWbwTTe6JN8ZgoBTMnXkHE7V0cmibmzesZmMIXe1m8eyYGB9nyEg+8nac4KOnEGOF9lm2gozVbvNcA5r39lw86e/Ce87NGmorkk35fVNJCL9zGztjp0awjvkx2heYE0Dq5bSAdvz3VuUzT+r24avFjxns9Gd9nDyd/Bc9LFd4rrH3gBcy7vivTmitsNlI6GgxcWB3/AZPq8EuzJnPdI4k8UtqCc5j/IBBp7Q4+onwpN/QPDUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRkGHei9gIJpzHkKjel/HBu7/62KE7fwr7owPr/ABpQ=;
 b=BKknqdtpBU0eb3+WvaxlYogDZXBrpYodsalm6PJx/7yG+lwK5JEL3VjFnNvl0VPVt4uOqNw1CJOZubE69QnNtuaVDeCo2hxjy3YRMJc9EODkI5ZaANDH1asxNaJ49Aesqn+UJ3pP+y4dmI61JtK5uVdgCPxc/fW/j6ihSF2JqlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 11:42:53 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 11:42:53 +0000
Message-ID: <c7e9820d-0b94-4b64-9351-0c58ecac240d@amd.com>
Date: Thu, 10 Apr 2025 17:12:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Add fw minimum version check for usermode
 queue
To: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com, shashank.sharma@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250410112917.13725-1-Arvind.Yadav@amd.com>
 <20250410112917.13725-2-Arvind.Yadav@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410112917.13725-2-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df4ebef-1ca0-4956-9232-08dd7824d469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZPdUxNZ1BRc2N3K3V5dTdIQ2o1ZmlrV1RvNTkwREM1NmpqUEQ5MWZoVVFU?=
 =?utf-8?B?Nm9sTG1lNDJEWUJiV0hxZ2YydkwxR3VDRmJocE5aYk5RY0daS0tSd0NpME9S?=
 =?utf-8?B?OWFFNy9aWFNwd2JHSVlkaEFZa1Q3ZDFqc1ptc0pLbzB4Z2FvVnBtVElqblNk?=
 =?utf-8?B?SW0zWXhBanJ1bVNjVUNBQVNnbWl3TDdic3ozSVZrR0pnOVMvRlRpRmdYR2NU?=
 =?utf-8?B?SFFBdndmNW9kSFlOWHhCTktrLzhSTEI2cjVwVmdyMCt0MTNHakN5TjZoSUlJ?=
 =?utf-8?B?eEd0WmlINzhmWjhJQTJBU29FVUN6d1NpYXZtRVVEbWR0NG5lR1BKREx3bEgw?=
 =?utf-8?B?Wm1PQTNPTUJLL3h4SDZpc3F1M1RDMGt3emRodUVtK0pnSnlNNURuY2pBTE1m?=
 =?utf-8?B?NzNVL3I3RmkzYTZSUHRLS0grQWdNS0lFY2ZNYWtUdHdMdXpRVFBSMlE4dnpD?=
 =?utf-8?B?UnV0aHNzOGc5ZXZrYVYraVRqZ1dpdGZ3N1NjUUVMMzY5dVNCeU1HRE9WUXBa?=
 =?utf-8?B?WGxiZVI0RVA2T1QvRlRYTmU3SXphSFZUVTNhYUE0QkxiTVI4cldnaDQwTXd1?=
 =?utf-8?B?YUN3L2ptZDhsL0tGaHFSV29PaEEyQU5HeFFtZkJxRTFEZStaSjRFYisrRHZH?=
 =?utf-8?B?aG1wNHhPMEV1Y0gwY283T2JiaHl1UTlialNoeG5wYnd6VmU5ZmFtNmpGRjhm?=
 =?utf-8?B?V3VjZEJOMTRNQ1hINm5BSjNqdG5ZVXl4MHhWRmVOS1VHOVVKb1JuSHpBN3g0?=
 =?utf-8?B?NUdzam9CVkxQTGxFdzN5K0xQYW9GQy9EdHF5MXIxbUdjdDlVNU9HcnRwNXE3?=
 =?utf-8?B?b0U2ZmsyZWdBczA1cjBnQ3prNUw5dkg0VjZ1KzN1U0hZcUptM2hmanZTVHd2?=
 =?utf-8?B?aXhvb211N1JKa2tqV0lyRDZuTGhtZmpJWkdjUmJpVEpaSTJ0THJEdlJqaFlu?=
 =?utf-8?B?VDBUTVpoK3VIYXR3RXJ5aFVmR01FOUVqeDhia01EWXdEYzVNTWRFamNrdVJD?=
 =?utf-8?B?QXlGUUNaQWdtTkUyUjRoSnFuay82aFFOYzR0NUkvcGpHc1IvdDErU2NQQXlt?=
 =?utf-8?B?UDNrTHhYUC9TTjhWWDgzb0JxQS9rSWk2TW15b3d6NGZDWXlSYWRMM2ViTWhP?=
 =?utf-8?B?UFcxcXgva1RucVE1MzJBSURFRW4xM1FlM2FxU0JyUmlwYk9GaEU2N2dKbFNJ?=
 =?utf-8?B?WTF0TkhmbW52aXEveWl2WWhRT3B1dzdGRDJISXlDVzgrZFdVcURKYnBSc0Yw?=
 =?utf-8?B?UXE5QXQ0UkZreE92dDRaMU02UzBNK2RqL1ZXdzl4enpwNnJhemRyQkR4THBt?=
 =?utf-8?B?QWJkNUI4d2RqbTR5WitRaU5iRVczNGN2dU1LZmZpM1RqZWw3RWZUWHFYUzJu?=
 =?utf-8?B?TndjUGZmRTdTWGVoRnZUQWhZT3U3djVvbUZyYmYxWXpPU2VNZWFYVkJFaFRC?=
 =?utf-8?B?eFhGa0ZBeXZnTTJ4dnNxckgvZ2pRcW5scGRFMkJsWjZSQWFVUEhBenRqdjQ3?=
 =?utf-8?B?azY3SHh2TEp6THlzekFOMzR2MTVreWdxdGFNMmh1Y1dnSFBJMGE1T05BSmE0?=
 =?utf-8?B?Y3ZSdG9KMDdUMG9IbUd6L2x2ZllLdlFNdmd4cW1OQjY1S0lpdU44QTlOanBa?=
 =?utf-8?B?YjdHUFNRZzYrVWJFY2Y2RUJwY0d2WWZnTGdoTWcrM0grUnRoNDBRY2FtVTVm?=
 =?utf-8?B?cVhGVzF4eUtUSjJsZUkxZHpMcVhDOVdZTHNSNm1hVnNsbXhoc3d3aGxmYXE3?=
 =?utf-8?B?UWRJdGxWZE1CTlpMTnZoOVBEeFlxN0xPbjhqa3hDc3IvTEsrVkVrTHYrTXJD?=
 =?utf-8?B?MkpsSXpJNVZpcFdVc3I3WTBSRHNZVS9kOWtla3FEcnN3Zm1pSXpyaGd0aUhi?=
 =?utf-8?B?aVhGT09Ea3JxSmNSYTlUbFhkTHdncHVnRUptNXhkMjFiOXhTaHZTV3FqTjdq?=
 =?utf-8?Q?eKzIi5ManK0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJNYXBPTjFQaUtSMTM1WjZWc3d4YkJtRjc3L1puZVA5QTFZeWJGWnpabWNO?=
 =?utf-8?B?MjlkNTNJYUhXcisvSUp1U3R0TnRJdVk2MDU0V0hyVzVXaC9SWjlVQnV2UmFH?=
 =?utf-8?B?Vk5ObjhwbW9XQkJvTXZHMzhtejhFaW1nZjBjV1FYeGhmbEZyN0drdi9HVVJ4?=
 =?utf-8?B?VFZJZkxTYnFaS3ZjZnlSTEtjbFZtY3RIV3R6YnMvMS84cGMrUloycnBQRmZv?=
 =?utf-8?B?clRmN2ZVSlkwQXc1Q0dIZjBUMklockVKTGhqa1hLZkZRUE1vN3g5bmh0T1lZ?=
 =?utf-8?B?eUpnVWFxMU1wM2VSR3U5NmZ3c2dhSTlaUTYyRXM2R0o3OCtlSUtmd1N6YmVU?=
 =?utf-8?B?RmlDa1gwWDBpTXdoYytyWlJwZUZyd1N0UFQ1NHlxZDczcmoyRjR6MlVETksv?=
 =?utf-8?B?RzVkM0J4cmtDNTFRSjB6Mm9pRDNqdkUrVmVweFVmUVlpWTZiQ0JMR0EzVnF3?=
 =?utf-8?B?Tjg5ZDRRQVljKzJQQkZ6VmpzMVBucGx2bzg1S093S1dpN2IyUldzbVA1bDNM?=
 =?utf-8?B?TDVZL0R6TWw0NitCYWJtbnB1Q3J5Z2FiVW50dHBzMzVPVkdrVW9wOEQyVFNJ?=
 =?utf-8?B?VmltVlFmMWVvOUJoWGFLRkV0UUdMNmFBWFRTQXNKS3QwMnRLdGx1SlUyaXU2?=
 =?utf-8?B?aHRKbXR1TXBaYzZ3eGRidDM3bHVRTjN1V05ubU11enpwUkFVUEdkK0xzNGtG?=
 =?utf-8?B?K29JR0xkeDNrcS9od1h1WXIvTG9UdU9zVXh2RW1XZG9LSld2aTdEZ3MwTmdL?=
 =?utf-8?B?bGtybjNub0xDSXVhbVhpRUR5YW10d3o1eGJGMEZZUUVFKzBoaUV1TUdRSGE5?=
 =?utf-8?B?b3FpWlVIeVdtOFNZejB1Y1daeUhkb29SZzBkNjNqTys1Nlp0U0FjbFZ6c2dC?=
 =?utf-8?B?OGRtTjNLaTZMNVgxd296bjAyVW1KZWxReDNEcnBlY0VtcFlmb2F2bk9rNjRM?=
 =?utf-8?B?aFU4WXhJelBqUmpaZFJpQm41Z2cvR05kVW4xelFMMTNIOHhpc0tITmJpL1g2?=
 =?utf-8?B?MkowTHY2QVZGVEhCaWl1MEt4eHI4Q2VoRXIzTEN1V01WZzE2cU1RVHRIYmlU?=
 =?utf-8?B?K1lVamYrQ1VHTkJRTmlHYkQ5amxOdFBJVmQvbGYvTUlKbzh1MTYxNitSemw1?=
 =?utf-8?B?Ky95R09nZWdNMjNlQnlHWEpJWXVTbU5yRUtENmIzU0FDYzlqUk12b1JQb1dH?=
 =?utf-8?B?UklNZ2x5YTkxS3htMHcybHh5WVl2ZFB5UjJUMHM3dXpTaGlQVEhpd2RuMkNW?=
 =?utf-8?B?N3lBTkpOTWl4c3djbGR3MWljYW52d0E2RDVvTjVMTm9mSG1kTWFXV3F4VlpY?=
 =?utf-8?B?Z1ZoaGhLT0V6aWNvY1V1S29sSmVkSlhWbEZDRFQ5b2hVaGQ4K2tkR2dRWnpa?=
 =?utf-8?B?cjRYMmFhajh5VVNWNGNnNXBKeGNHR2w2b1lkMGVqZDh3ZGZWTEFhdHduUkxQ?=
 =?utf-8?B?V253M0JoQ2FLS1lHMnpZdDZMR1k3Y0xYWG52VDZaVlA2N1AvUXVKaHZ3c1dw?=
 =?utf-8?B?VkNLY29NTDE1YjlQZk82SDhVMDNtZll5anljLzFmRlhXMXpCclQ5ZTYwbmZU?=
 =?utf-8?B?b2pmci9hTGJNZjM3VUU2b0doV0k1b1lOeHRWVTRqU2t1b0VjYlQweGMwYitL?=
 =?utf-8?B?cTd2K1dVWlJFbzhWQ2JoSEZUalIwaVMwNHlKSFhtNW9hWW9TWU0rWnZqN3pu?=
 =?utf-8?B?QlZTTjQvRXE2aXRibDUvWEJrS2tlWitPcUNGQnBGczE0ODZQeHZDK2prVDJD?=
 =?utf-8?B?K1liUERIOEd2ZEVGckNEYlYvWDZLM3FqMkpqdXltbFZKcTBhd0d2ejFnUk9E?=
 =?utf-8?B?VVR3MmczZmt3ZkUwR0pmMzVYdEwrS3p3Tlh4SEY2OVBVYzdQSnc5ejR1V0Vm?=
 =?utf-8?B?bm1haXQxVUJHMTdsQTVJWnBxdHc2L1lHRUNzNm9JMGpuOEp5ZjZEWllORzZX?=
 =?utf-8?B?aEpOc3MrL0RSMzFINVpQbnMvMWlQa0dZNnZDeEZ4VXdQam5lRmJOOFNtckg4?=
 =?utf-8?B?RU5Cb3o1TDhGdFN3UnBnL1ZVSlRVMS9ldjNQbjhobFZJNmNDd1Ixd0hURFpC?=
 =?utf-8?B?SWFEUVVPZWxGNDUyZUpJQkQ5TDBXTlZNbm1Sa055bFJnQ2c3ekFhN2xQUTMr?=
 =?utf-8?Q?q4bcmMrs/6Qr96Gcb2Lx5Nf6F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df4ebef-1ca0-4956-9232-08dd7824d469
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:42:53.7112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muXj+31F0TxKxGd0KxOCDzBq40DCko7v3AtBj3vi8rc4dV4cAbhT/niEM2yIqr9W2rEOTbWRcIqhyyx4wKf6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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

Apart from minor comment LGTM.  Also lets wait for Alex to review the 
series.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 4:59 PM, Arvind Yadav wrote:
> This patch is load usermode queue based on FW support for gfx12.
> CP Ucode FW Vesion: [PFP = 2840, ME = 2780, MEC = 2600, MES = 123]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 3d87e445270e..c31c96fc13f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -69,6 +69,10 @@
>   #define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
>   #define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
>   
> +#define GFX12_ME_FW_MIN_VERSION							0x00000adc
Alignment issue here.
> +#define GFX12_PFP_FW_MIN_VERSION						0x00000b18
> +#define GFX12_MEC_FW_MIN_VERSION						0x00000bea
> +#define GFX12_MES_FW_MIN_VERSION						0x0000007b
>   
>   MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
> @@ -1383,6 +1387,15 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static bool gfx_v12_0_is_userq_supported(struct amdgpu_device *adev)
> +{
> +	return (adev->gfx.me_fw_version >= GFX12_ME_FW_MIN_VERSION &&
> +		adev->gfx.pfp_fw_version >= GFX12_PFP_FW_MIN_VERSION &&
> +		adev->gfx.mec_fw_version >= GFX12_MEC_FW_MIN_VERSION &&
> +		adev->mes.fw_version[0] >= GFX12_MES_FW_MIN_VERSION);
> +}
> +
> +
an extra empty line not needed here.
>   static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	int i, j, k, r, ring_id = 0;
> @@ -1418,7 +1431,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(12, 0, 1):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
> -		if (0) {
> +		if (gfx_v12_0_is_userq_supported(adev)) {
>   			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
>   			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
>   		}
