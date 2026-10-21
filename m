Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79815606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OFXQHPtV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D90F10E207;
	Wed, 21 Oct 2026 14:59:52 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EFA10E207
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 14:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXFhfMBYxDK5tbvbs00fZlbhT5n5v2dFVwXbp+VSfJJ2It4vNhS5f5gQl1OonwlYagq2whQsnNGHMNSSMJ9sjTe8icVIqm2w7jqPrQ5bfrDjbhshrYJsD6lT6vQpERTlTWXs0e3VBRlhtXgs1K89mAivJLOavu4cwXsdnu+fBr7PAVc+f4QY3sebThEdju+XeeHiDrZO2NABKaLo90FiPOtztq4A7VPR9F6+W0nscij24lcJQKIiWCpN95J8WIiIFLtlNO6c/DP4y8T6LvoYWEUnC4f2Fu/wxGDTVz1ykjHzCjiIbKg5BmppdgR6KznnQQosEO23aXKKQIii+Asatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26yRRlLmhiOubcJANGjXzEXkRWzpNWijReV1WSliV3g=;
 b=STtmCEvGsryyuMN/9zJP29Ok1AL0RJ6GnFCg3Izd1q28XaX51HDjrXj1l4dKFJohdGBnnbhRoO6CNTyGv1naWSQX8RhQRcpW/1H17ERmHEtHFVC6sPO6nY+T4bKC5xer2DdCN3LVijxsZBoVBV4brZySFriKrVMYChG22+9pyV1Xfaj0YVzKOxQEYzhukE6qWwpHluCYp9YGmn7iPVp8D9ycbpiJ5DBKE0j717pB92d1no3X4v3ao45mXswaA3BclNvV73wagxlLUeeSjPeQoCeJjuX6NFrgoK+6bQ3nwgfEx4SFqLlBgXL5VTcRJM8ZkVQVHLfPIVvpAdT+FhW4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26yRRlLmhiOubcJANGjXzEXkRWzpNWijReV1WSliV3g=;
 b=OFXQHPtV8jIQ/Tpl4t/g1obgkQeMTw8KAm4q/Chy1tcQfVoQULUpkktxO6HhGOUOn/CYAqhRfbdaMO/eJ94e0zXZ+VCcAKB4bHK1moH3TRIu3+DQHzTye/i6kLFS/v7k0Zn5cRSAZ7IzHQQvfqNU3MoGhRFDkoX64NLY1U2UZGk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) by
 SA3PR12MB995558.namprd12.prod.outlook.com (2603:10b6:806:511::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 14:59:40 +0000
Received: from DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8]) by DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:59:40 +0000
Message-ID: <68670994-917d-40d8-8e4b-2a5dd15aea08@amd.com>
Date: Wed, 21 Oct 2026 10:59:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/vcn: cancel jpeg idle work on ring test
 failure in reset post-helper
To: amd-gfx@lists.freedesktop.org
References: <20261020152701.18355-1-leo.liu@amd.com>
 <20261020193212.19760-1-leo.liu@amd.com>
 <20261020193212.19760-2-leo.liu@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <20261020193212.19760-2-leo.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::22) To DM4PR12MB6278.namprd12.prod.outlook.com
 (2603:10b6:8:a4::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6278:EE_|SA3PR12MB995558:EE_
X-MS-Office365-Filtering-Correlation-Id: e80fb4a4-fce5-40ae-cea5-08df2f83ee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|10067099003|11063799006|4143699003|261009220027099003|261009223027099003|261009221727099003|261009223327099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: f9u59wG1T1mNWPkNkOz+FDH5diiPrDwJs4Ew65S6wvdOnlWz3+SDmnZxYi1m3rLBoRmbtkMw1euqbXwPW+bDSkje1N8w4/VlutdUoSnJrX6WUy206tULLBMOau83QT0pRUsGAF8ebGmMZoC7TWC1TKnGJNWTyCtysBGoSKP4CFmsCKCBgPzWIEhW0WDjJK3rlnta8joMGiRpnQS1vzU0e5obJ+bYGiWQVT0G6ytFtPV2vvmTBlHxoL/E6ajKILDlh5LyE+vmkRSXg7BZppbpJ+8cm/i+G3hRhpwngukFBbRFyhfWB5NGnOOW0fxDuoaurmrfU3k8ZjNIlHZy4U+m0sN9AU4KYMRgx8C6ba882auV2TH6p+bCW+HRKEdW63OFk0r//tkb6FjcDM4FGFaUQ5ZeFifKgzIYp+qHaESlUnyAOCMAI5Q8Fav0Let2HOP+Z06isNUcoZCJ88krDi08tPc/MkHQmryJn1vH8p5SZAxekN5v79il//zg9cJO31kR0GtKC6PNE5y0p6UxKwym7q5a2xC2caLVyyfkEzE5lBv5NaIfzavQVucgvziHj/Khdxd6V7qNUvCymvxKLjZkhH5VBaZEOaYQO+xuOTYzPMp6sn4+byn8fdz/tLOMxoS2RITFAJgyR/2wwlUVMY2cD4snxy2qdF6+CQD8YUS+9UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009220027099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDIrbHRpVUgrWURRaFJqbjJxQUp4U3pURmcyeHdGQTRkZzVrN2tMVnprNUNQ?=
 =?utf-8?B?UFR3ZkNXWm4wbnpGTFB4QjYwT2dZRmVHdmVQOU5oYTN3Q2p5NXN2OUdIK2ZG?=
 =?utf-8?B?RjFDUHhsSDczNTd5M2ZYRzZrT2VMd29tZUt1QmlJeitHYXQ5ZDBYMEFqbUJQ?=
 =?utf-8?B?K0gwaS8yV21SaHBydG82M0FjVXVHeFFUMU4rQnNuaStLdnkydldIeEs0aytS?=
 =?utf-8?B?UTlvVEV5NnFRK0w3ZlZmeHIzdnJvK1FCSW1Tb1lWODMrY1Z6Tmp1d2tuRXo3?=
 =?utf-8?B?ajVJRHFvVCtIYmw4NkZTUVFUdFh3d1p2Qm5LWWNvY3A4Sk1SLzhLYTFyZ2FG?=
 =?utf-8?B?eFJZaXJTa0RsNW9RNS9sRGhPMnN6b0JNVTA0b0Qvc2lrSXFhejc0ekNGY1lz?=
 =?utf-8?B?bTBSYUJsRG93MlpyMWk2aXBBWHJNUTJ2eG9DaGNwUGlPZk9wRkJtYlpCZGdN?=
 =?utf-8?B?UDRYZDhXZFZCOGxBOVJiSlpOcWRhQnNNaDdoOHRJUTArT1o1RmhudytHa05N?=
 =?utf-8?B?SFhpTzUvNlZkZGJEVUJJMnp1OFpvSXFJWkQyLzdGK0xSS2tEMnFEcnpiWldV?=
 =?utf-8?B?aStrV0pFSkpyNFZxY29Pd0JwRFFpNjJxQ3lwNHJzTUluVDE0dFV5dUkzN2tt?=
 =?utf-8?B?TzcyUjdqS0tsTjZCYzJTdTdPOTAyNVlkaFI0Ly8zWExRRE5NeG5PejRob2kz?=
 =?utf-8?B?U0J3ZnVsaDlJRUJyQ3lnMHZWL0FxdW9aSzNTWjVMbGxOZFdqMHB3QkpSdkI3?=
 =?utf-8?B?b0dNNWhxMkF1L2oxWmsyV1J5TjZlSmFBR2FYcXlDbHpaNCtacFRWOXVVNk0z?=
 =?utf-8?B?NEU5aEFuVFJKQ1cxbXlqNXhUMkJJVEVGVXdKelN2aXZiSHlRMzR1dG40Vy81?=
 =?utf-8?B?ZkVZZFJRb1FxM054S2Q3cW8vY1RYM1dpK1U2NG9EbEdwR2hCRW9NU1ZlWXdB?=
 =?utf-8?B?TTRCTENPWmhUeWxtMXFiTys2OTJtclNUWis3N0I0N0lSTnc3MVlzblBzQU9R?=
 =?utf-8?B?M1g1Ynpya0pqWWZiKys2ZXBiVjlCY1Y4RDdtSEhpWDFqS0dZZEl4WjJUcjYy?=
 =?utf-8?B?bzFEVDNzeStHMGNjMkNQcVhCOE5uQWZIeG5YUjZYMWk1SjJud3EydTkyMW9Y?=
 =?utf-8?B?bllPSk1SV1dGZXI5Yyswc0NidUU1R085Q2lrU1BmUFhrTEIrMEJEMHY0eUpj?=
 =?utf-8?B?b3pEc2FUYkFtOXllR2dNQkp0WFlFeFdlUHdGUUNsR0pMWGJ0WVFvd2xqSlcw?=
 =?utf-8?B?WC9HNWcxSHdGOVNDME4wUk1GUFQrMXhiTjJmYzNXWUkxZnUxZmFZL0dVdURt?=
 =?utf-8?B?bTJ1a3p1aWl2emVKcVYxTjE4azBGTUJyc0NZdXBTbmd6MHlpOGtXTkhaVnhO?=
 =?utf-8?B?YzkweW9Qd3JteGgrZ09XMFBEaGVRL1pJRjBjN3lYajlLVnhBdUxIQm1YV1NG?=
 =?utf-8?B?QmtOVzdJQ3dtc3dFZFFLcmVUYzlwMi9wRTVwNG5BSHpPdzJnLzlDSEExNFNE?=
 =?utf-8?B?dEU0UDhEMnpPMnJHQnZKTGlvTzc0a2N4Z0ZGLzI0M2pJMlhsSHZESzVMZWZ1?=
 =?utf-8?B?bllGNGkwa0ZsTUxhR0gyMlZQVkpLbXFpdkJUN2J1UWNGaG5pWXQ0aXk2UkhB?=
 =?utf-8?B?aExWR1ZOdk04a0k5K1A5RDNNaW9wbFZKUEdXY1Mrc1RJc2RGTy91V29Ob0lu?=
 =?utf-8?B?NUlZd3padEZkbFgvZkJCMnVCUmhFeElkMzFqY1JuMkt5cUlmTFAzQ3VDMEcz?=
 =?utf-8?B?a2tJS3J3NkFGRlhhckNGeUdkMzhzbGhja254bVIyWU9qRmcyemVTSGR6d21Z?=
 =?utf-8?B?VDBOdVVrelhiVDd1YTdvSXU1dWJqbVZuNk9QSmZPc3FCWCtuRlcrd3daYXhL?=
 =?utf-8?B?NVhSd0dmeGpBUVcrT2dySkI4V3A3dzBIZG80cjFLc3dHY05IZi9yNEtSTS9V?=
 =?utf-8?B?QXN5TmZKdlRKdmw3UEtmSnR5QU5kVmF3N3JlNmhMOFJXOUgzMGJGc0JWR0lR?=
 =?utf-8?B?NHFYai9hek9QWFUrTkFRTGVSMjJMUVZPM05nSndRMExzSXpFSXJqb3JpMlVS?=
 =?utf-8?B?ODhTZHRwZmQ1SVNhZzBiMXRLMFZ5VkdCZm5qVCtrUTZHZEdRUFlDUXVsQmNG?=
 =?utf-8?B?MGN5RkhoSUVacXlOYVdDZTdEdE5SMmtjdDhsZXZ6RE14clIvdFlIbU9uVkZo?=
 =?utf-8?B?MnkyVW5IN3A1dytKZGZFbGkyWUdGMmVzUjFNR29UeDYwSWFDbHNoSjU5dURt?=
 =?utf-8?B?bWM1MitjeDg3K3JETCtXN0xCWGhYNWlvZWEwQTZBSVdoU2N6dmIrb2lJN05Z?=
 =?utf-8?B?MEFjaGRidTUvYUlDanRwSWVRUUxPb212QkdkSGJmcm4wMDR3YTFCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80fb4a4-fce5-40ae-cea5-08df2f83ee8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:59:40.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANvZ3NbbDx2WCQM/rUFIq7p1OKdtCgwFxhrpvoIp1X69gS+0PiCYM2HRhSVYZRRd47uBHyjbFuSkr2BTErr3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB995558
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 3:32 PM, Leo Liu wrote:
> From: "Liu, Leo" <Leo.Liu@amd.com>
>
> When amdgpu_ring_test_helper() fails in vcn_v4_0_3_reset_jpeg_post_helper()
> and vcn_v5_0_1_reset_jpeg_post_helper(), the JPEG idle work scheduled by
> amdgpu_ring_commit() inside the ring test is left pending without being
> cancelled.
>
> Although the subsequent GPU reset triggered by the ring reset failure
> will eventually cancel the idle work through hw_fini(),
> cancel it explicitly at the point of failure for cleanliness avoid
> the work firing against a partially-reset JPEG instance before
> GPU reset completes.
>
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 56fabca78ea4..78fa111c7112 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1720,8 +1720,10 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
>   				VCN_JPEG_DB_CTRL__EN_MASK);
>   
>   		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> +		if (r) {
> +			cancel_delayed_work_sync(&adev->jpeg.idle_work);
>   			return r;
> +		}
>   
>   		drm_sched_wqueue_start(&ring->sched);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index b35db4cc6aee..e634839d7e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -1366,8 +1366,10 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
>   				VCN_JPEG_DB_CTRL__EN_MASK);
>   
>   		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> +		if (r) {
> +			cancel_delayed_work_sync(&adev->jpeg.idle_work);
>   			return r;
> +		}
>   
>   		drm_sched_wqueue_start(&ring->sched);
>   

