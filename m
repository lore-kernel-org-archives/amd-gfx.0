Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 12:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD3010F166;
	Thu, 25 Apr 2024 12:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4RzmxOp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7894D10F166
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 12:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8uEKsiYrfIlzY0F0z7H8jcGKvgQe+gx7daqj6DxBWwINasxjX39/jo1UBAqz7Xt2cieSffVsrAyRcsWTuZRHZ+FguMj5+XGEjCxjk05GDYtshHpdt7CjcDEPnHQDsKvnJ44k1czWgf7cI4l4cdojiPhUy5D2P/W6ffJyWv1eKM3Cs/R0s4Q5ptmHNJoQKmqrn/EbfyJS8umcDPJke8HL6ckkRvS+FYM6Db+7jSLwjPT6Ux6FMZSrChB5SEb/l21gDqmua7lsqvKHna9SSRoXIlBL902x3JC2xgo48yVSuG/wexEA0XPQ/IzfrLirDWwlHKNAYMyPHI6sJg4LTDrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpqlS9exiqrUXSyBZmMRzlCXp/GixAc/S5hX5N1BMHI=;
 b=FFbuyRCkv3iZY4h7tcm+cGkjD5lfT/JGtd/GD6dck8B0QF1qlYaaoQQrEQ8fFBIwTjSj8GqKRfpKiajOuRRiE6jBQn8S0Bgn84s5ryxe/AnJ/pF1vYcB8cbM0LF6guMctVGjTuE2XD3yN1nZOQ6xZ5dRYppLxa5l9rvLsr9Qgksi2OzF+It1vecMOcXRnoBm4y/+nju33iz6IwlgmkPWhE4qUfj4IQqSmRHyK/arxXoKYX830jI57YIV1q+Xx6ve3ghITxltt+DQA7VJWffI87SRYyuAxYUTh6IQ8OzesWm6fTpa1FHP8EPAMOa5EEhsDZ4eH6ylxv6png7b6NBLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpqlS9exiqrUXSyBZmMRzlCXp/GixAc/S5hX5N1BMHI=;
 b=E4RzmxOp/u1eE5zDhcAsievb/9ks6meNHBklKbC8EkMJ/CxwnXAjc9BHFz827haHtD+4jc0jGkXXaYCDs3jmjo77WEyldA+1RQX8TaiecAjDIz6zLYWBbzYCNXhO2UIslEelROi4lXidvc3eR8mN+Z56xgFjsJQH1KpkaVonYrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:39:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 12:39:27 +0000
Message-ID: <c2327261-e425-493f-bdc8-d3b57819834c@amd.com>
Date: Thu, 25 Apr 2024 14:39:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix out-of-bounds write warning
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425100027.637016-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa7bcb4-a739-4318-15ff-08dc6524bee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHI4WXRjV1VmazZQRS9GNWs4Uy9BNWJvT3hadGFvaFg5QTk4dm1vR0dpWUpI?=
 =?utf-8?B?Z0FqOExCM2hBM2dLMVl1YkFZaC9EUmU2cThnWnljQ2Nucm9nOWhadUtOSXJa?=
 =?utf-8?B?anllNm5Jdkc2ak1VQVNFcTc0NE12UUg5THpSS1F5TkIvVzR1UkRYblhmK1I0?=
 =?utf-8?B?ZWFXT2xhMjMybHVtRUNwVkVxaXJ3QzJReVJ5eHQ1Mk9saDg5MU1IdVBvVmdM?=
 =?utf-8?B?SFNtMU9Qd2JTaHJ0bmh2Zi9xNkhIZFpTUFpzOE1NS0ZDVVFUTTg4ZVJKbHNU?=
 =?utf-8?B?czFuUFgydDFYV1ZlQWJBTm1hVFl3V0ZPcFdnWEQ2SnM0NHBteVV0K1BzQ3lj?=
 =?utf-8?B?YWRhVVBkck50RmNPVzlkaitrR0NVWmZ5U1psUmFFallKc0RqRkx0NlZJelZ5?=
 =?utf-8?B?Mkp0c0VXYmFrbStHbnZpaTcxdzNQUmZHbHdBZ0xLKy9saFd2ejRnR3F0RURL?=
 =?utf-8?B?aDBFUm5PaXFMMDIzV0Q1WlV6bTh3YmhpdkZ0RGRSUmIyOGF0Sy9sMFpWVEVy?=
 =?utf-8?B?b3VKSzZTMEtQZWpTaWdUMGNSby9oc09hbWc0cEJnaU1Ed3ZDaWxWTTlmRTgw?=
 =?utf-8?B?YitacVlRQ2hJVnRjTG8zb1Q0Zzh1RVlwZS8rZWFMVjBLMkIwRVZWNzlRR0I3?=
 =?utf-8?B?QkNDRVJzV1lRaWw0S3d5bDNyVmR1TkoxcWZub1dOaFR3a281YkhXUlhFcTB0?=
 =?utf-8?B?VG9sSFhFdk15emE0MVJBTlVyRFgxaVMyRUdiWUh4cFJOUFNxL3BZYkRmdUIv?=
 =?utf-8?B?d3dxZEo2Y0U1VVdKS1p0S0xxMHhiQW9TRkl6TFBPN05iQnZuM1FGSXo4Nlli?=
 =?utf-8?B?UzA5QmJKdURuZTJ5TWJpRXZmNkxDbVIyVkNMOVhPT0JGQUNuWnRrek04TTdk?=
 =?utf-8?B?OHl5b2NVdjNYYjVSYWxTc2YvTDQrRFU3TFBkTG1IZGFPWklHWHNxYTI3NSsy?=
 =?utf-8?B?VmRoZEdCdzFqZXlwYXZya0cyZ0F4R3VZMlZoZTJ2ZHhxbnhTSWdxZTVzV2tF?=
 =?utf-8?B?Qkt4Slh6WFo0Z0d1WS9SMzBMcU53b2JvQVFIMVZZNmJGaVRzY1FaRlRxcUdl?=
 =?utf-8?B?S1N2YzBVQjQwclZaS1g5aVJpb3FjbWVlQXRkMTdUQkpIcGZzdGFrcnE1V24r?=
 =?utf-8?B?bS82bGlsbEh0Q0pueEk0dW5yVnVnUDVscmkyQ2pkeVZEb3p5Tm04TjlVY203?=
 =?utf-8?B?K0VZS2pEblFxelhkQjExRElIU00zRFh5UFZyT2V5S3JadDJmVlIzUnR3YWUz?=
 =?utf-8?B?ZFlWcXQ1VWw1TVd1U1JuL0MzNzdzT2QyNVkzT3BQYnlkaTB5U1poS2hBd0RS?=
 =?utf-8?B?MCszRUZmNW1JSmI5RCt1aCtaSjBhVWdwTktpT3J0WDR3cktTNEQxY1o3UXRo?=
 =?utf-8?B?WksxcWZ5UDFYVjJvUUhXWXg3WitNa0J6TVp3U2poT21EZXNaZHFJUTIvRW9m?=
 =?utf-8?B?MWwyQldLWVg2K3ZleFRMQitISjhzK2JsaXpKbnNJU0ZmeUxnKzBFZGxVbVBN?=
 =?utf-8?B?MlpKVDEzb3BvckdYSHk3S0x4WDJUdU0vblpIc2VaZlQ5azRrQlEyaTBWOGI5?=
 =?utf-8?B?M0RlbFNRODlRUEJrVXQyUmpyd3hucDV3WTc0ckFWUVdNeHdrR1FKWUl3cW5Y?=
 =?utf-8?B?TVlXM25xT3RFWWJWL2t1RE5tZnBBak8xMjR4NG4wUVNuTEZwSlExZEYwTVAr?=
 =?utf-8?B?Qjl1enBERjYvTExtMFduV1hhenlvNUJPSjZsYU14T0VKMTJ5d0VBNCtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHM4MEVZdXROZFVoT09WNkY2MGVoajZZVStQRUVmdno3WUJUeW9tVmd1Uldk?=
 =?utf-8?B?Rk9rUmVXc201WGQ1Z2pEdEY4VStJK1M1RkJkWm1DMzVETXhDSTRiczlHckY5?=
 =?utf-8?B?S0lQYkx1WVlTUXlWS3BPcUczU1BtWkdBZlNkUVJacVNpSUxMeUtWaXNlYmdy?=
 =?utf-8?B?ZSs0MU16dEtQbGliNXZEQ0d3M0FaMDIzL3dLcTRMdkQ1N3dGQzU4WFVVQkp3?=
 =?utf-8?B?WEhScXJ4OHovdXVSbmVndm5LZm95WDVoR1JNOU82VTA3TXlDZ04zaEl3bFhB?=
 =?utf-8?B?b09PRTRUcUdPUStvaWNXc3ZDTmNWNVIwemJnSHBZRkJKMFk1U1U5S1N6Z09G?=
 =?utf-8?B?bFpxNk83ZW9yU1h1TEVSKzkzL2tGQ1RjanNvUE9nY2JRVHp1Q29yQjdLRGNt?=
 =?utf-8?B?OWZOK3pmUmprK2RibDY5NGZCQ0p3aTZUTEYrQ1lXbGRnUDNnU0VVelVqZ0Fn?=
 =?utf-8?B?UThTQlJvZGhZMFo2UXRmOFlub2Y0bkNtWTJhS0o2WFlmZWZIK0RpQkdLeGVS?=
 =?utf-8?B?WlVFeXRpdjByNnZnVEppaWwwcTh5ZTdRTE5BMUNQVk1sREZTTkVMVnJjNFpi?=
 =?utf-8?B?MWxYdTA2K0Rjekpjd0x4eEFKL1F3bWdRc1kxMmh4SlVUVDQvRDY5dnhnOWVp?=
 =?utf-8?B?K0tuQTM4MjBtRDRKR2wwd0RrRzZmdUhoeUYxTWM2Z0hxeVB4ZGpZdVRCK0RX?=
 =?utf-8?B?aWlSM2czeVJaMzNKcTVXUlBoaDRacHYvSkNFMDM1c0NSc3MrcW1waVIvYzNS?=
 =?utf-8?B?dEhIWUw4bDdsS3FFTzhXUURkN1M0amR6V0dOZ09kc2NpamxiZkRlM09BdUpP?=
 =?utf-8?B?WmhJKzRaNDQ0eFRoOU5Xcjg3a2Q5UnVUQU1ab1dCK1pxTTQyVHJ6aXJJODRJ?=
 =?utf-8?B?WUliZllyaXdpOVU1ZDFPdFVPM3hseWtUb00rNlNoSmxENWRqYzkzaC82M2Na?=
 =?utf-8?B?SU9rWDFzQ0dya1Zab3pUZDNZSDNQUjVsblVyblZ3V294aEhRb09ES1FQSDFv?=
 =?utf-8?B?eDdwZ0NWNjJBOXkvMXBwYko5SEZuTGVYTng0RWlOY016YklwaXloYnhiaWFn?=
 =?utf-8?B?QUUxbVJXMmhJL1Q5U2lscU9mbXZtUzJGRVh1OGJ2SW4zL3pVSU9TaGU0b1ZJ?=
 =?utf-8?B?eDVEMThrdXBFb0R2SkdYcjBRT2g2b3lENnQ3Ni82Z3c5aXFIZDhnYWlxNzcv?=
 =?utf-8?B?M1dOQnpEd29UemlESzJRKytKenpaSXo1dlF3dVMwNHo1QjN6NHIvU0dKN2ZM?=
 =?utf-8?B?VitKY09aZWQrUjBYdGdXNmkzejJGejRENkxSRFFnd0VsWkxTd3J5bTd6TDd2?=
 =?utf-8?B?NUgvblpwc3M0c243WThISmNoNmpFWHhPUFZwRTg3Wi9oQWUvTHMrejNhcDNC?=
 =?utf-8?B?R1FRQndIcmY1MUZYcDVnVGgybUYrcXZnTCtTUFpzSVZNSS9qNVp1MW51WVB6?=
 =?utf-8?B?Wm9FNTFTYW4rcU9SYVI3Qll4eVBvRGg3c1ppcVRZc0pDeklPN2h4MEZRT2VK?=
 =?utf-8?B?THlGQWc0c1cvWHFtT3BHdWRhZHl6Qmpqa2pqWmZibWVQL2pmS1hQa1I0NDY0?=
 =?utf-8?B?S2puV2FCME9HdTNCNEQvbUdvRVRQWTdtL1VsQWhPeUxxUkJUcnVadWxXTWZM?=
 =?utf-8?B?bGRON21COWtYaFVYaVU4TFgrTklXV0pmbVdTNzg1MW10SUNhcHFIUVNvWjZY?=
 =?utf-8?B?ek1RUENySURsaEZNQlFNK1loTHRNUDhoQTBOTjEwZHFLeDh3MlIrcFZJendj?=
 =?utf-8?B?NmVjTTI2L2swSGpvdVFhSXd4SUErNkRtaWRTREkwUU5hRnF6MUZ0bzkybnkz?=
 =?utf-8?B?RExqMklmTkRxUlFoeGl6UTF6TU5LcU1XR2hOOVVXNDRwWUdOMkFvNjhXVGtS?=
 =?utf-8?B?Vit0MkJVUUJmZVhlTENQM2hPdktta2kvOU0wWjh4ZmVuWUhqaGRIdEw1VmNr?=
 =?utf-8?B?T0xSWFdNRHYrWnNuaERhTER0ZHEwVzNpN2lLYUFsbGJvRzViUVpMSU1HSFdO?=
 =?utf-8?B?dVU1QUNLckt6NE10Mi9CRjAyMk12Z0JqRlhoMDFuQUs1YTFlcUp5SmE4cG4y?=
 =?utf-8?B?RDQzTndoc0hVWTBSMFhERnlKL1BOVTNuOTMxVWFkYmtsdjAzZDkyUFRmR2h0?=
 =?utf-8?Q?PxPmb/pQB6VDC6YJs68PaNxza?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa7bcb4-a739-4318-15ff-08dc6524bee8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:39:27.8473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XxHpe2/ocpqhrfGA+fnsCiJajJG10wDrhMixJ79oEqHVzMW+gjwiSfjTTJYXPih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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



Am 25.04.24 um 12:00 schrieb Ma Jun:
> Check the ring type value to fix the out-of-bounds
> write warning
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..1e0b5bb47bc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -353,6 +353,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	ring->hw_prio = hw_prio;
>   
>   	if (!ring->no_scheduler) {
> +		if (ring->funcs->type >= AMDGPU_HW_IP_NUM) {
> +			dev_warn(adev->dev, "ring type %d has no scheduler\n", ring->funcs->type);
> +			return 0;
> +		}
> +

That check should probably be at the beginning of the function since 
trying to initialize a ring with an invalid type should be rejected 
immediately.

Regards,
Christian.

>   		hw_ip = ring->funcs->type;
>   		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>   		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =

