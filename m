Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD06C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 13:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B3410E7E1;
	Fri, 30 May 2025 13:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGEBtVbC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E402C10E7EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 13:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU+e4S2K9ojHkxkj8Qf9a4yY+O6reJcT+vgZEdlvZuKPrNzPfmbUcBxF9Eub3+oFtlwna1dAfKgD1e56xy1ToL6xi6ysyRq/vtBb/VKsp/3KX/0eLLn250UOSvQAAW9dCiw6fc+5FF5z3C4MhoQaB24XFQDrWx2BKILi+aHvKQWtbTof7tQCn4hfo+hdkSMBqTzorZkcVnp2j23IjJi3o8TMgnnHFVLQaw8x23qWi3/V7QVva5AZnGWIj1dWne/EFPTiwlldG88awgAYMT3knRpDk6xnlGTjU7V27GJ9AEWCTRaRnHjMFLrIaA0v0iHlXwjTyb17J4K48fk8W3HOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18c6M8Y1Quv3NIfgmhRDXqMi1ncw2XoKyQnul4aYe6Q=;
 b=pzwtMYZpU6fOt51+oxjYRvEbrWBTBl+bW2GrKu5kKJcQT25RW66IUoS9a0F8CqQSAdUeH3uHlqGl0ebsdT8bl+NhNBySyDAn8vLHXuv/oV14duuTKOFkcpoQrYZP+ys5nmgLY4orzl7QKTxABpPgBVN3T6vgHBi4fdtFRfEiZb43ZH3wHwQgoZKq59/AcriJwgMmQUIp7Xa7EhJ7xUePC88wvSOGPAOFU0Tz/sIw74EbI1V1NvNBDmhbCwwOMARNvQ4hyx9yRUhtBMEqR45/YdyIwdjP98muWyWO3/5mHVgNrLP8gI3HYcJv8+YRP/6mxLQ1PIO5YwWxZbNMAAweMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18c6M8Y1Quv3NIfgmhRDXqMi1ncw2XoKyQnul4aYe6Q=;
 b=GGEBtVbCuBwB3/TFgc+dsigMET0gz2yT/HYxM4hqV7UNZNOXUWIV+46FJjNGd97RcGkJTlWsJvXZ3P0MgeCMu7UpVEWGGOR1EtYqAm+ZcU3v0qif8G+ZBGvpNmZBEukUbvYjg6dggSsTKooSZ5mQTvapohukYnIBoRhZCiftjaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 13:35:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 13:35:49 +0000
Message-ID: <c276c601-2b16-4772-8f70-a327c0ff6177@amd.com>
Date: Fri, 30 May 2025 19:05:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drm/amdgpu: add user queue reset source
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: bd53cd5d-80c2-4eef-f416-08dd9f7ee36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1UxZ0hocWpCMDlRREVlRzJlRWdwU3hwcEJQN3QwdDR2WGZvcHV6dG9pQi9J?=
 =?utf-8?B?Y016cWtlcVRRY3JkazlkalI1WWtXSHZWYkppYitXWTdHcitFTjhMWmRwTlBM?=
 =?utf-8?B?dStVMjVZNEEwRjkyeXIvbEhpZC9VNkdqdFM3YXoxSGtMMm9XQjh6TFovSVdt?=
 =?utf-8?B?a0RvMi9URVQ2RHZzUjNsbUlzcldtcjFBUXhyeEtUQStWS3NXNzRyYWtBRmpm?=
 =?utf-8?B?WW96SmVJQkNNOEZlSFYvNHByTnFBRWxnTWxyaEFLZ3NvNnNmNVE0TTc1R1RI?=
 =?utf-8?B?N3FUMDNHeTlJWVI5TzJrRXlEZ2hQRDZtWU1tNEkySEx0V2ZKVk9scGs5bGdP?=
 =?utf-8?B?b1dlMVIzTnI0cWxLdThiRGhjd2JIRTJOQmhwNUhjb0cxWTZEc1djTmRqSEs5?=
 =?utf-8?B?ZFNmUEtYck5iam5LbjdTVnBhQlFlRGIxenpFVXlOSFRjNWxxL2dtV1VVMk92?=
 =?utf-8?B?SlArb24wSDVHOVUvS2lYVDhHNkhoYVNPcVN6aGt4UTJYT2ZIdWFHNkt2Z2dT?=
 =?utf-8?B?OFJBSzgxSjVpQ2JUWVorSURWUk1IOUNnZVRzTFlZZHFHd0svUWZzMlgrYVJl?=
 =?utf-8?B?aEpQNjBQNHBHbmJ2MWpURjVZTEMvN0dXYUdVZzlOeFlCWUUwNHpONUxVd3cz?=
 =?utf-8?B?Z0pDUTA1MXR3U01oSmhEUmQ5ZXY0dTA0YzEwbnU5TDdXbGJWRDB3ZFFFOWU4?=
 =?utf-8?B?Vnlpb29yNlJmdStMMkNQcUtnWnhaWGV0c3dibFZIR3VPRU1UM1MwYW8yQ1FF?=
 =?utf-8?B?OCt5YjRCQW93VThFRlhIWDBTRG1CQUJVdU5IcytSUzYyRC9paUdHejVyMWc1?=
 =?utf-8?B?NGw1bWM0VS9KYVhHNnl3WjlnL1I3TjY2cDBscE1GL0VFTGNYUm0rMndZaUcv?=
 =?utf-8?B?N3k2V1hsdXpGbjZlWGU0R3YyOTRVRjV3dzU3NW4vQ3hNQnBmTVRNc1p6TVVr?=
 =?utf-8?B?OWtTNWUvZHZ2bXBHNkpOQVJIN3ExakRqOVpHQ01zVWd3Tnp0aGpYVXBSMDhj?=
 =?utf-8?B?aXNjd0l5WStvUjNnUVV0L1kxNTdja3BhQWl6eUlUNW5RU2RXV0JtOGJKUUth?=
 =?utf-8?B?cVpNWjNuQU9kNVZRUWp6Q2xPbkhwUnlUUW4zNXFQQlR1RnlsemcyeUl0WWZ4?=
 =?utf-8?B?RW9XMng5bWs1T2d0RVFsbkZsTEtwMDB4NEFEZDZudHBYNzhuWnFlZGRiSlJH?=
 =?utf-8?B?VUxsbDI3N2RUaTNKVFQzbThTczdpUGNKMWRyNjJTNndabHErMGtwMm1weWFV?=
 =?utf-8?B?NVE0QVkzZ3B2clpNRVdtWmhhZ1BFcDRkT3g1V1BoT3ZoTHRDdmRvZHNTT3J2?=
 =?utf-8?B?c1V4THB4Y2EyU0pCQ3htL29HTlVPKzZkc2RjR3J2ZWF5TDk5czF2ZHhwTC8r?=
 =?utf-8?B?VzBoNDdYSFFqQWR1ZE1Qem5xK1BPVWZZcDg3OHRLcW4rdnN4a2w2WGNSQnFW?=
 =?utf-8?B?b2FpRXYyWTRnNUs4ak5HL2VjOTNwdXBwbEt6WWVKdytsUmlSTHBod3A0aUow?=
 =?utf-8?B?c2h5QkFNNDM3TitjVkpRSnN6SlhISWRWRkwzYVhwOVFOS0pONWtZd2E3THJS?=
 =?utf-8?B?SHRzUWJHa0dVYXJzRVJnZ3NxZEYvVThiVXJ1UTAvZXhOcjJjU1BTeUd1R0NK?=
 =?utf-8?B?bjhJUEhPWTJrVllmN1NtQ2M1U0JuQlBnaHFWM2JhelJOam0yTHlKUk41OGNn?=
 =?utf-8?B?OC8rR2tVZHptd1VWVSt4SDBKSDhvelJ0WkZqcVJLQmpaeHJXaHhmNUc3OXRp?=
 =?utf-8?B?TzRQS3Bad3lQQ0NESEFYNFNoWW8xZUhyNTlrbzl2U3V4cVFIcjIyMzNmeGNJ?=
 =?utf-8?B?N2VYc2hDdUVDV1owckJaRGRIVVpJTjVGeVZjZUxUc1RUdVg1L1pLSjFDMVVE?=
 =?utf-8?B?TnRRcGV4U1Zid3h6UE5BREFCUU5MdjNHTUNQdXY1QWQ1R3NuYkFTdE5NNEg4?=
 =?utf-8?Q?QM8IcAFRTIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUdCZ250UUtobzM3bEpySlIwUlBUK042NVFBemRzNU5lVXV5dWM1TitNd3ND?=
 =?utf-8?B?Z20rSnVWeU1rSnJOTEppYmp3QjJSekw2QnQvaGhTZnJmRkU5SksyQkNiMGh4?=
 =?utf-8?B?alpUMUlxUWR6UzY4WFBFbXpXOXBTVU45c05sY3pjQno5Y1l3SWxFQkFiL0R6?=
 =?utf-8?B?TkJSdE43NkRSYkR0VUZPKzNzRDhYWGNEVkNRRzk0dXhGWDBkODdva01SMHQv?=
 =?utf-8?B?ZnZLdi9NY2pDVlJTeTNNVGx3VVVSYVRLNmpnRmE3QXNqdm5kM3hZMXFLS3Fp?=
 =?utf-8?B?aEorcGV4c0RoMkVPSDlTM0RveUx2WmpNc09rOXd4Y0kxbXlZMFI3LzIwTEVY?=
 =?utf-8?B?TXBxY2FsbXNOWGhOdXdmVFRIZXZZUk8vU1JYSnNoSDFGNUg5eHpmcnEwQytT?=
 =?utf-8?B?ZUJkYnFXWi9yWVBoVDlGNDA5YTJyWElaak16MzR4VnBEOStWcXk4d2lyYURw?=
 =?utf-8?B?M00yejkwRzl6QUFUSi8zeXZhR2dlRG8zNDBYM2ZPbDYrUXhxdWFaN3NRdERK?=
 =?utf-8?B?ZW5wRkx6bE5uZ1V1ODBOS3BzQXdGZkhnOEhXMzYrallGeUxwdUR5SEtVazFm?=
 =?utf-8?B?UDBBejY4RW1wYkszZE5NSlhSMGJDR0xKbFl0ZUVZcFdnMWRQUlF3c1NBdTd5?=
 =?utf-8?B?cUFJbmw5ZzJNLzZjMWxuY0VTNFdobjBZbllKalNCWjN1b0dZS1h0RUhGbjNj?=
 =?utf-8?B?RUdNV0FuT2tDL0w4QU1rOThYc3hLYlAwbU5uSzlCYnY1Qlh5c0dCaWd6NVZM?=
 =?utf-8?B?b0g4ZE5ZZEdPTzVoRFBhakFFeldSUkFVaC9yVUZVcEI2V0JCOGRJam9JTHhx?=
 =?utf-8?B?ODlKUVZFeXpxcXNJUk9BUXRUWmVuQXZXTUFGRjVTV3VIbTk0RytHQTJMM0s0?=
 =?utf-8?B?TDZUclI4TGk5c09ZdHJlSExmY2pueEU4eVk5ajJ2K0R0TTlOeHlUMDVxOWRo?=
 =?utf-8?B?T0oybFRXUkRlUityMGJSbWxjeWRqZHdIZUpYL3gvdUp0TUhYMHB1ME5lQ1NN?=
 =?utf-8?B?TVZEa2hYSFoxVk4rNmdTTndYVGxKOS9ja2J0dkVxdjVqQTMxRmcxaW1Ia0FY?=
 =?utf-8?B?dXY5bDgrRjBCQ0xwNW83ZDF0YlVoSzYxKzFFRFptdVRPOCtBNDRiemZWVk1Q?=
 =?utf-8?B?WlpDZktMOUFNVjlYSStBYTFHUVJjcGZaZEVQK1JyRWI5TnlacFBjUm1hRGhq?=
 =?utf-8?B?ZzVpQTRBNHJ3UCt6enBOZDlKZSs0U0RtZ1EreHp5bDRvTWZvOE05R21EZ29E?=
 =?utf-8?B?c3VMSDFJR1ZEUU93WUFwRUFMMk1pQjhHWmV5RWN3aWtaSUFUTmJpb3VINjht?=
 =?utf-8?B?VmQ2dVl6RGVoRkhoRElrUGR4SW40c2N3d0xSOGxlVFAwZjVub2Y1cEJtZUxL?=
 =?utf-8?B?U3oxU0J0cW9jdzloalp1bGllYUgyU1lhejNPalJTL0RxbEljSWZxZkVDOWNO?=
 =?utf-8?B?NlQrS3dCbmF3Wk9iamdXdTRjT0RpQ1FOMUxYa2RNaVhMeHdkdVRFTnZzVDRE?=
 =?utf-8?B?cmxIS01CZnZzOXQ3Ymc3bWNKNytWY2tHMFhVV2kwQmIvTElrb3ZEZ0xrUDlX?=
 =?utf-8?B?ZjdTWFhSdENhbU10NVpMdy84SWh5TG8vNkFjWjFiVFBZUHJUQVlWbkNyd1V3?=
 =?utf-8?B?Qjkwem1zbzBTK290a2lqbXZWMlpYMGlhNXM0dnRrRjZTdTFRelZMQ2VrMHlw?=
 =?utf-8?B?dGE3TytiUUdUL1NmZ1VmUUpCUnZJeERaQjBNZUljZnlRcmRMY2FCMWcvaWlO?=
 =?utf-8?B?VG1uUEwxMnR5VDMvNWdJVnRFQys3eVlNTG1JYk0yWExER1paZzZXMU5YcUNt?=
 =?utf-8?B?M2x3a0I3TkRXUytadlkxKzRkM3QyRWoweUNGNDQ4Z2t0WWN1aDdHUXllb0I4?=
 =?utf-8?B?aVRZdnY3bk1zUFlqMyt3akd0YkdwNk1oNVQ5cUNnUUVwbG1HakFxUmNHc0c1?=
 =?utf-8?B?ZVBMbmk0YzJHWXpqaktoZmxPQ0tMbXA1MWFqU0ExQmFnM1VIUmx1ODNQV2Uz?=
 =?utf-8?B?Y041K1VCeHJKbnoxc3NzYzZ0dkZoTzJjSmNmM2pTVUZjWXdGZE5RM3FYR1I3?=
 =?utf-8?B?OEdvMENGbnB1QmQ5RlVEbFdaWXJka2o5Z1k5SGVMKzVSOHBJZTBNUE0zeXQ2?=
 =?utf-8?Q?AAAfGmY5YyfVqx14rsLCzE4KB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd53cd5d-80c2-4eef-f416-08dd9f7ee36e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:35:49.1258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSzy8OJoTROXxHCzWW0/bwfQylab1nLymbIR34c4NKOZqdj2Q2rkWeW1HY9h3uT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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



On 5/30/2025 2:30 PM, Jesse.Zhang wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> Track resets from user queues.
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index dabfbdf6f1ce..28c4ad62f50e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
>  	case AMDGPU_RESET_SRC_USER:
>  		strscpy(buf, "user trigger", len);
>  		break;
> +	case AMDGPU_RESET_SRC_USERQ:
> +		strscpy(buf, "user queue trigger", len);
> +		break;

This in itself is not that helpful. Not sure what data can be inferred
out of this.

Thanks,
Lijo

>  	default:
>  		strscpy(buf, "unknown", len);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139b..ebcea44dd743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
>  	AMDGPU_RESET_SRC_MES,
>  	AMDGPU_RESET_SRC_HWS,
>  	AMDGPU_RESET_SRC_USER,
> +	AMDGPU_RESET_SRC_USERQ,
>  };
>  
>  struct amdgpu_reset_context {

