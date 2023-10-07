Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DECE81E14
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 03:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCC210E0EF;
	Sat,  7 Oct 2023 03:53:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B1610E096
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 03:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMEHPeItkfldDgytZDg/TJWYCfeFYUWp9GEY2ma4esdMYEF8XICbaN1wYHXI3d7EWmkSF13ZdMoxQm7EGATpPeUgyv0bqUhAPfPsliGQAY6mBABqLq0kKhcjaNEFC1hOBSNeZaN+oCrCqEJvAqCwBIatcGON4+/J2TA+wd4In1pCgFcLUBnSmvWpujzK83cxf6Q8W/OgfmEHQUL68f2SO0O72R9zbfx+8DqqZN4UuqmRNcWmsrtF8eT+U7abwU8oM0L/FmyHyANh/d9QH+ItNTrab2Hoc7tULXNrqAHHaEIFPqZ++Gi1cZOnvJtRLehxkxEf5KyU1QxNMQwH84Edkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RAcSH5a875slEf2MbieOSCztzVOw+2PAbCgmKTuhlA=;
 b=Z+uE1bcLfpKdCWOjDQOVN4E2fEWXfELg8q26s+j0bE3o4VrRpNiOwRRLu0Xs+XZto9zS3Jb7ReAQI6fXuZZr3xCnZtylXWfJlIJlZXsAYvnyYcDBaBrQPt5AO7f132opnXQxn8v/1N1oJEV5S66983WjXsgiZgaiFPvjHBV20FmSrgPGNxW3cVLCPapEjxolgTX19J6dyR/JFrOMEt2JZG6qgeLOYzugkOxVip0NzftY+QmDu8FZUuzqx/5Qxt+vHJEyMBJG8wUfO3Bsa32/JC1n/YDB8MAtOBRFSqL3TGXW6n+OgvaLq6nPs3N14fqhqWFFW2qm3bYnXI9GfAvx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RAcSH5a875slEf2MbieOSCztzVOw+2PAbCgmKTuhlA=;
 b=aySvIFZ9+sC7aaY21JLnIwXpRxRolQhFJ+LSOJTIOFJ2gAM3kGv6Vu/2lzyz8kTrC28YrAwRJa/0tppNRDsGvEwnY0kn7p72Q+Z7JVuD0ErnNYd2ToO7HuvcBI4oHTqIESZB3kHA2BvV/VAHUdJafzP4MySVImdiGEdPh+Fo0EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 03:53:00 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 03:53:00 +0000
Date: Sat, 7 Oct 2023 11:52:49 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Yifan Zhang <yifan1.zhang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: add hub->ctx_distance in setup_vmid_config
Message-ID: <ZSDWEW0ZvYT8PhFn@lang-desktop>
References: <20231006085059.3269316-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231006085059.3269316-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 580fe1bc-368b-462a-d4c9-08dbc6e8e649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHG8/MiIaL8P9b9wKRKPzADJJ2i1kBZDNW0Qd2BwP2AfIaY4QU2ti1FfWSdUwuN2jsevYKeaKogDUD1Zu6ESAXlY1UH0/cAmQZZn2GRromdpMIjg1i2c7FrE/ueflXHF8JVfqHe9lUK5tXai2B4Z/IsIYhtSqsyN5IHtBWvwBkZ/PmybgH7mv6XxWj/OUpXQh0wzpflXlx5X1JEsElRUlDM9Sc+xzI0/+EBGjmExomnlKAv0mPQ/EeEz4iPA1avNJp66TgWGWg01+27pHRg6w6EX3tZaBOEak3tM8TBtUXvKuHdfGwB2trvOrIQ+zpE5sXIAYP4nSnx6fDAngL5qKAV0pL8qmBz6NuzyrNe6p1HM7l16un36tXlt6/noAAM6E4q07gLONT6tuu6XGOijIzSlfvK3QXgQa7BwqfzoNohIROnie3pzED5IicnnPorAeUndoVUwnC3ZfVVewcv+hvOkoTEIcOsHA2H27zcOlW/aXbv/+h9oBSBXeALVsmpqnqdjIV4sZm6XgKUDcOwwYp0H4WAt4GUCDb+Iaid6foca434OMpWoiWH6nSeZTEJh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6506007)(6486002)(6666004)(478600001)(6512007)(38100700002)(26005)(86362001)(30864003)(2906002)(83380400001)(33716001)(4326008)(316002)(41300700001)(66476007)(66556008)(6862004)(66946007)(5660300002)(8676002)(6636002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QCGVuRBGbMAS8ECQQ/kaxA25l5PVf8sQTvopZHuE6CGQ02/0OKGy/F/gwH?=
 =?iso-8859-1?Q?KT32IxplHVCOIpv9j1LikhsPy67GQ7L2+k/zd1Y1HDreVKn/bT0DPkkxfx?=
 =?iso-8859-1?Q?6FJOhXwXxkHKWkmRnwGrlSvvu8RScAwi2uGbBKyF/t7Jrs/lbaEFoIHesD?=
 =?iso-8859-1?Q?v2ohPzNBUha3tGWCLzRzLNhLQBnp4sCYz69G8xX4fNiaXqULXUjPGjdqZ3?=
 =?iso-8859-1?Q?mCplw7W7zSTLwm1/IFiNDrXXc9En6100urMWrmubRnxX1W9n1fx08QJpK7?=
 =?iso-8859-1?Q?kBVTBffok4KIjYD/vypx5nm8sGsReVCg5aTgfDGPfzWcmZXDzI/odj/q4C?=
 =?iso-8859-1?Q?jiTt9KWHxo/KmzUehZBZkTgriF0RPqkgx9MpFwtbavYVcEV5ZlEwm4TGma?=
 =?iso-8859-1?Q?e6n5riMmH+oQ+2IINfC8yEHojKjBritqSqGjljAMtu5ViGM7FVDuZuJ0nS?=
 =?iso-8859-1?Q?aPLw4stXEPDzipo1IjakX5ebpAZBlIETOuhihvie4GigPOIk50PcAxvzSV?=
 =?iso-8859-1?Q?rLz26Anp9XVvCnUx4+6HX2ZjBcT7YYh3I2sf6nAcMZF8BgnxeWV8pVcj0G?=
 =?iso-8859-1?Q?zed6KgplyU8ZS7aNRCdW3Vuv7fr99sisNHYBF7U5XJ+vG6mZxeWkVU4Z1i?=
 =?iso-8859-1?Q?6Ywr9xWfPX0Ch0HVcEaP4/0YpGptIgwE9Vqebx+/FkCtw/0n0vRG75C+ka?=
 =?iso-8859-1?Q?ePyX7QOCMAoeUoWBUqF05Sl5Lu7jEjFqbzZ2yEuH6mB9zsxfQ2KCvhIwAA?=
 =?iso-8859-1?Q?9T9fDC7rpL2jW02tkm+Fhz+5nRzt5JrzgKQfVTB6sz1zYW3kaEHCxr3odD?=
 =?iso-8859-1?Q?LsHFLgy2hAJsgyOcSB/uOT512KDubg6EtVVTneV+37JoQ3vFGijJkYhZcg?=
 =?iso-8859-1?Q?xprLZ0a2c1sykdTTarx8DNdLtD87C2NoE2Iu6fjYs5kwnHHqBe5rCXhBUX?=
 =?iso-8859-1?Q?0s4O+5W2PG2aNoxBjtkn6tKHQb/sFdrzeeNGc3qlHtbUgF881n5iI6sjAc?=
 =?iso-8859-1?Q?OqwwGk41EdBu7SJ8Agq99niJXQjgyJoCbUKskbECOAyJHKhLrHDTOenk8z?=
 =?iso-8859-1?Q?kTSqMFonsADjcsBhL+fkg3lDgJlWRz5rQD3E9abNtDRkhMtM9Xgm7jg8Z4?=
 =?iso-8859-1?Q?pEUosFdXRL6UV04ASnYlMhIXD45KyFYZ9hl8Ck8V/5d3SGXTW6F+RhZ57b?=
 =?iso-8859-1?Q?Vwt3MefHIVchNyWeivPEpWqb1sV4/wMAG1iM5rbb/94PAn3bW4QiiOKj6Z?=
 =?iso-8859-1?Q?ExWsb7nops5Ni0MunbTqlfyu3HzrTviSQN3RePQ2iojG1NTeaR7NBHMGxJ?=
 =?iso-8859-1?Q?3Po/QFMUgRK8NJGzcKwZ1VFXl+HndMupWXWX9Llzg/CL4AqW82XjEMpaty?=
 =?iso-8859-1?Q?o67igFS0/0S0RsHe24HVyzMyo6HtSiU17zMrjvfGuNAZuvTDkxDz1q23PZ?=
 =?iso-8859-1?Q?q4clIWQF1WqvfLzNJQU/zH4LX0p5d1N3SRUTINPZoUtS77go0PtvHCxMS/?=
 =?iso-8859-1?Q?T/6p+ApY1EoDN4xHMGCa5W8H3mCFXxm/6sbNkHsQFf+g+mI+tUwoQtDJTK?=
 =?iso-8859-1?Q?EI7+2wrKCEuj1cj1gkxK8N+f3e3DQmjjP7BPBqVVF24Fu2ax7mh/bnxQQ9?=
 =?iso-8859-1?Q?yT5PTuZ0oZDDQYi1C5F+jwAPLWIC7sYpef?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580fe1bc-368b-462a-d4c9-08dbc6e8e649
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 03:53:00.2317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dai3FkxHWojG7YB0h51j2OVbNX7wA3R4DsGNc6sSqvb0v8+1vaeXZdnNmqwJTF/DXmtEJBlycpFjW3Tqy/WT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/06/ , Yifan Zhang wrote:
> add hub->ctx_distance when read CONTEXT1_CNTL, align w/
> write back operation.
> 
> v2: fix coding style errors reported by checkpatch.pl (Christian)
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lang Yu <lang.yu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c     | 2 +-
>  17 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index bcb6ba03cead..f9949fedfbb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -297,7 +297,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index cdc290a474a9..53a2ba5fcf4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -260,7 +260,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  		block_size -= 9;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index ff60670b8464..55423ff1bb49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -329,7 +329,8 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>  	for_each_inst(j, xcc_mask) {
>  		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
>  		for (i = 0; i <= 14; i++) {
> -			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
> +			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
> +					i * hub->ctx_distance);
>  			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  					    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 8521c45e8f38..793faf62cb07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -287,7 +287,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index f829c441640a..cd0e8a321e46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -296,7 +296,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 89ff7910cb0f..abe30c8bd2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -294,7 +294,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index be1da5927910..b3ef6e71811f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -299,7 +299,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index fb91b31056ca..843219a91736 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -242,7 +242,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  		block_size -= 9;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 9086f2fdfaf4..92432cd2c0c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -274,7 +274,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
>  		block_size -= 9;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 784c4e077470..2c0419faf8d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -344,7 +344,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
>  		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
>  		for (i = 0; i <= 14; i++) {
>  			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
> -						  i);
> +						  i * hub->ctx_distance);
>  			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>  					    ENABLE_CONTEXT, 1);
>  			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 37458f906980..02fd45261399 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -367,7 +367,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index 4ddd9448e2bc..5eb8122e2746 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -285,7 +285,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 9627df8b194b..7d5242df58a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -323,7 +323,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index 77bff803b452..134c4ec10887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -310,7 +310,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index d1fc9dce7151..f0f182f033b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -315,7 +315,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index 3d80a184ce6b..76b12f015d1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -303,7 +303,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
>  	uint32_t tmp;
>  
>  	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>  				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 5718e4d40e66..1b7da4aff2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -308,7 +308,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>  
>  	for (i = 0; i <= 14; i++) {
>  		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
> -				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
> +				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i * hub->ctx_distance);
>  		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>  				    ENABLE_CONTEXT, 1);
>  		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> -- 
> 2.37.3
> 
