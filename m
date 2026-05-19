Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0436CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FD510EAA4;
	Tue, 19 May 2026 07:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07qslaNq";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7B910EAA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 07:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETEZor0N7h3ApKTXq+tLk92tNks7KAaPucWdkHBKH2gabGi4fVAKxXJ6pWfqfHj0y5KlzeeVlBDtaZSHP3gfNz/BmuoJATHCDeV2S1mharWOQjeaq32y3s661ABL76OVNZ6DhBnherogNkQSNKnNCku+n4jBY5nhZcYk4zvb7S2fACDkNIfU3oHziybIAZq7D5X4jFM5qeqnlaRCYDptmQvks6fBHHIQWAHgugXLgRY7badrIMNAo6MoqWBGgzSSt3hXnqMKZpkQpgSqr/4UJQLusFlMwf6bRRdQyUHB0lGZgJVuBnOdhpkl8D+zXgy5O1zMdloggyxYt3Vd/C5Z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udTLlnVcVO1IHGtYXEfs84pIO27gBcY6Q9pXmGnKR9c=;
 b=VhQnDPpn3GkQY2MfbPrC18J0Qp8tdNd87f9Xf0noC+c5xjAz5++tRb0NQ1ttV0oMMbRxrgv5A5ZRMCu95M67OGw1I8cuRIiPsXJHGqFm4KJp2/UAyXLXvM5szUyzz41vhITX+3+7ntwmN+Keg8TrgpOlmQlP8rO7hljBZOrjs/o+HjTeHoz25RUmjwYLXfee2THkbMgGl8zIx6zKhIH9WuqLGHlFhdoN3bvJaFpkLV2y0ACYIpJW54/i6k8PgqgMncoRqYsCXvT4WaoRGb+PI6ArqWIFc6WTdHIdeDRSZkfZlg5uACckVvR3Qo9GCuLdx1s8ljzpDgOUB5aKxeglOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udTLlnVcVO1IHGtYXEfs84pIO27gBcY6Q9pXmGnKR9c=;
 b=07qslaNqwL0kv99yYO2D9jtzdI/gAmKbCOb1faR03RZFIxhtEV/QYCns9+A992R486EsoNv0eLtzPL/rLPw4rqeY/lQIBvYQOSF/qf6c1KlyS8hgoyorxXHl6CcRUNBdIPdVu7OdesAnOoI22YBKPIFfdVkr8BbV0u5EhTYmiS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 07:00:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 07:00:53 +0000
Message-ID: <a9291a50-9151-4e10-ae17-f0bdff9a28ac@amd.com>
Date: Tue, 19 May 2026 09:00:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0
 as needed
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
 <20260513163043.8725-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513163043.8725-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a84a165-5db0-4f0c-22c1-08deb5745de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: 7ox4gKKZ87AHM3cZxBTB4IEEkOUNsF44brBUjUq7x4/5yVBHebvSOfimfmTsBQKQwZg08VMxA2zq7Tdsi5UkwduHL7Kb7HIx6jJg/TgLBIdREEBMMsRY71JryzW9sltb0QVOWzZh4oNjUj/8Lr0wIFA/nqgly3lX0Gdu6pyMNOb6MWsBlR1OgTe9RyyYnC2fIfNZPuRxxgIStadnzrGKg6ZcoI+SNY5JU3+pqHZL7eDIZ51BQMxbcrd/YgvHqdA18IXftWpKJQu1GguNH6y+H8OBrECEl5Ei5uyZkzaoA0OjLwmikiajtflSR/fA5LK5x48yHuA8QEJIejq3MGJKOiV3/jANzRFFPKAtHEPNXWUlOsPMy1EKn/fc4t3ORtbP0lY8bFZNdtpyg1VSPUhrMYPzli8rotKoWNqrqbnG/KN5+mDnK0BeFpi5pS1jmBycm1+E6ZYZqsnjCSy66eeHLXQrEmMLNI2/fTpO+AYIzIRE0bCrXN/WuoOlA2B4xWwnYLRVgotSIq0T/cMeqR/wbtNqnCyjFEH2KG6ylgxdhw07Fy1YzsFl5jHzonjGtxQ7t4+WpeGlfqCJNDtYvcZvAuN4hkX7iPrA9/lKgdqcAeAjh9AbPtK/30ks5cUZlQaqic25FzUlGcMcwc42EcSIGNZ2f2tXi1gS7GRPVYfjo9Vt88bQI4bF12Jm0lshBgbW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBQd3h3Y2xmYWtybEhPVmFhMC83Kys5N3RGQXljM2hXUGVWekJwYUZYbWoz?=
 =?utf-8?B?cVJ3OVVidE85TEkwK3MyRER6S2VUMm5KdEZvTHp6SkNNRSs0ZnZ4VHpsREVy?=
 =?utf-8?B?N0czQkZOMnkxY0NKenI4Q2dSeXdtbHNsZlhpMlk5aGEvR0s0Z255c0VIMm1S?=
 =?utf-8?B?YlRHamZJczBvUlY5blVGVnlTNkxoSE1NeWRKTk9nd3V1aDNTMC9RQmJwekMv?=
 =?utf-8?B?Z3M2dkNtNlpPNHBLcTZheUl6dXhpTzB3TWl2MFIvTXc4a2JyT3RVYnBYUUpC?=
 =?utf-8?B?UzhadkIzQ2pkdkFrRmZqYTgrUkFYR2pVbkpDdEVnUWU1eTdYK3J1VFB3SVpO?=
 =?utf-8?B?TnNZMlorVzMyQkpoMWljRWkrcngwdjhLMnkvdlVuaWVHTC9zRTB0WWt1cS9N?=
 =?utf-8?B?bjQraGx4KzFJcDdMVDBrNlQ0UjRQdlBFM09hRU5UMUpXVDB1TmRtLzBuKzJN?=
 =?utf-8?B?MkdHVkZ6VG9ybG8ydGx5aEJCWXhOcVNzOE1lWnFjMnlneGpZbmxZd1JRNWp0?=
 =?utf-8?B?S1ZFd2U4aTBsZVRkVlZqL3pKejJBN0FkQjJSU3V1TWhON0lDbTUvL0JuT3k2?=
 =?utf-8?B?OVkwdjBtOXNqSE1JemlHdGJFVzZxWnBVUUVJVWhySzllYURqaDZlWVY4SGd4?=
 =?utf-8?B?Rm8wUlR0YWVTTU1pT3d4ckVkY2ltb0dSMWw5MEZ1UHpVK21LdnQ5UFRmNGdx?=
 =?utf-8?B?SGFJV1Y0enhmYTcrUEFITUdUVzE4NmZ5REUyVStTM2F3SlJsemRJZ0g1Yjlk?=
 =?utf-8?B?cUUxSmNZQVM0aVlvSWdnQzBjdkVJU1BjeGdLVzErRm4vZlZrWHpwWnlZV3or?=
 =?utf-8?B?dFF4c1lSdStLZnpGam5CRkNYTldHcU96R0NrSnlpeGlCamVmWmVlNW9wVGZk?=
 =?utf-8?B?cGVDSHV5bXQ2M2k2MUV3bnkyb2pZYVZPNmlJQkU5UHN3UUQza1NjQ0VRaHUr?=
 =?utf-8?B?QkxNTXBnazJaYmFGSjI0NG15STZGcmYvZnpzQi96c2NBYU1mZWdGNU9qNjZR?=
 =?utf-8?B?S3FVVWpuUThycGRhbmwrMUE0WGJ1Q2VPcGxWSkFFK0RzQ1U0RXNCWGpMdmYv?=
 =?utf-8?B?aSs5MTdJNmFWTnRoUjdOcWpxdTFsNUp5MUV4V2pLK0VJdjdyL0RHRVRNdkZP?=
 =?utf-8?B?NnVmTU9WMzhEMk03ajZCQkVMczFKMDhnTW5xZW9zaUxlZzFqUlpqODNIWmxO?=
 =?utf-8?B?VEZPVCtha2JMcTB3alpYVlVmUnRYTWJyN25QWm9EcDBycU9sbjBJWFIwSFZ4?=
 =?utf-8?B?VVhXYm1wcHh0WVRrNnltQUdFTnFvOUh1Y3l4NkZCbHZoTWd3OW0wc1gzeWpu?=
 =?utf-8?B?Zis0VTZ0M0JRWmhtS3VYNHljMWFrU1I1amZhSVUrcG9rWU9NY1h1L3E0aFND?=
 =?utf-8?B?RzFsd3JoaEZVVjVNZUZaS1N1TjM4ZHZBN0NvTnoxdk13djdJbmJId1c3ei93?=
 =?utf-8?B?cFFkemhqWnYzNkFPVWhtK05FVnQ1L3BINU1vZkJCVVhJdks3YndFWUtyMnhQ?=
 =?utf-8?B?am5sNXhVZ0IwY1hUNmY2WEpCaHk0bXgyNm1RelBLZmdhZ1N0bE93dzdVdjYz?=
 =?utf-8?B?S0tEeHdwNnQvaTFEOWdTV040RERSUW82ZG9haWtxN1lNUWRMRFZ0NlRDdExV?=
 =?utf-8?B?VndvaW1JVzBySVdZY2h0V0pBam5uK3VqSkpkSnkvOUllWVNDNlVWT2I3ZXdo?=
 =?utf-8?B?dGdpK3hLTU5YejVqL3BEVHhQREN2UVNYY29oVXNrblI5WnV4cmFYQWlTQ05w?=
 =?utf-8?B?OThlTVlqcjhOSXRlQUhkazduWm5tekR3enBPeWQ4a0ZndkgwV1JTc1hDdkpB?=
 =?utf-8?B?eDA0YUxCVHlaSUFqV3NGN2l6dEF5Um9td1N0c3IyNThBYkcvSWcyUFZycFFS?=
 =?utf-8?B?ZzdENUdTY1BZTk1qbGM3NFF1enc4MFhWdzFHK2UyajVLOVVrY0ZZMVJhSlFV?=
 =?utf-8?B?TEY1Sk16WWlRckdyUFVoM1J0S2Nza3VFSWw1bVpVTUQwV3F6OSt1b3lrOGIz?=
 =?utf-8?B?c21Wa05sVFphZnE2NHNpVENrQ3F5UlpxNFoxWVdKM0lOTTB2WUVBTG5lQnpP?=
 =?utf-8?B?Qno5dWptaXNydlV1TXJUNXZpZHNTbDRtZGQwR0xDT0txT3l4OTFGMEV0d0pv?=
 =?utf-8?B?dUJKam1RdnUxdEM4VjloejY1UFhNbXBqQU9pcFhiL012Vm40L1hVU0J4UE1E?=
 =?utf-8?B?S3NUU1dCcWhHYVlSWHdKcWhndmV0V0pSNEk2aFBCVXdTeVhMQm5tWElUTjV2?=
 =?utf-8?B?K3JRbTFScWpyQW5rU2hoWDlnbUtLNGlQZUU5QnBCK1FHdmlGeVkvaEZXY0pI?=
 =?utf-8?Q?yqN2RAgedQwH8edhKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84a165-5db0-4f0c-22c1-08deb5745de4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:00:53.2249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPTzWbcKbJG8Ezv7QK2InoUvJ6grwjfdXZBHOGvp2mZW0LO1ZHFUr8Qilh4O8A/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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

On 5/13/26 18:30, Timur Kristóf wrote:
> When the fault stop mode isn't AMDGPU_VM_FAULT_STOP_ALWAYS,
> these bits should be programmed to 0.
> 
> Program CRASH_ON_NO_RETRY_FAULT and CRASH_ON_RETRY_FAULT
> always, to make sure to clear the bits when we don't want
> to crash.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Can you re-order the patches to put the already reviewed ones first?

I have a bit of doubts if if patch #2 is correct, but that one here is clearly a bug fix which we should merge ASAP.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 14 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 10 ++++------
>  9 files changed, 38 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 8fdf66ad265c..3c6c20e529a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -449,12 +449,10 @@ static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 84344c67013a..9234a66a439a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -454,12 +454,10 @@ static void gfxhub_v12_0_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index e505aaf8b447..82ee96b5ef4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -633,19 +633,17 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
>  		tmp = REG_SET_FIELD(tmp,
>  				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
>  				    OTHER_CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value);
> -		if (!value)
> -			tmp = REG_SET_FIELD(tmp,
> -					    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
> -					    CRASH_ON_NO_RETRY_FAULT, 1);
> +		tmp = REG_SET_FIELD(tmp,
> +				    GCVM_L2_PROTECTION_FAULT_CNTL_LO32,
> +				    CRASH_ON_NO_RETRY_FAULT, !value);
>  		WREG32_SOC15(GC, GET_INST(GC, i),
>  			     regGCVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
>  
>  		tmp = RREG32_SOC15(GC, GET_INST(GC, i),
>  				   regGCVM_L2_PROTECTION_FAULT_CNTL_HI32);
> -		if (!value)
> -			tmp = REG_SET_FIELD(tmp,
> -					    GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
> -					    CRASH_ON_RETRY_FAULT, 1);
> +		tmp = REG_SET_FIELD(tmp,
> +				    GCVM_L2_PROTECTION_FAULT_CNTL_HI32,
> +				    CRASH_ON_RETRY_FAULT, !value);
>  		WREG32_SOC15(GC, GET_INST(GC, i),
>  			     regGCVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index c8a615147904..2b20b86236be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -403,12 +403,10 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
>  			WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>  			EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +			CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +			CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index afc8c6a6f1bb..182cf3994512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -516,12 +516,10 @@ static void gfxhub_v1_2_xcc_set_fault_enable_default(struct amdgpu_device *adev,
>  				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
>  				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -		if (!value) {
> -			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -					CRASH_ON_NO_RETRY_FAULT, 1);
> -			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> -					CRASH_ON_RETRY_FAULT, 1);
> -		}
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +				CRASH_ON_NO_RETRY_FAULT, !value);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
> +				CRASH_ON_RETRY_FAULT, !value);
>  		WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  		tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index a27bb37b2a11..35ef43137f1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -418,12 +418,10 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index db56f7a61d61..c6b610c48540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -449,12 +449,10 @@ static void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 97585c7b879c..0d8b8980898e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -446,12 +446,10 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index 72f24372a4e8..766dc0ce738b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -434,12 +434,10 @@ static void gfxhub_v3_0_3_set_fault_enable_default(struct amdgpu_device *adev,
>  			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
>  	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
>  			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
> -	if (!value) {
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_NO_RETRY_FAULT, 1);
> -		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> -				CRASH_ON_RETRY_FAULT, 1);
> -	}
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_NO_RETRY_FAULT, !value);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
> +			    CRASH_ON_RETRY_FAULT, !value);
>  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
>  
>  	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);

