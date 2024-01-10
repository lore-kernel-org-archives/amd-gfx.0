Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086D2C47077
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883E510E550;
	Wed, 10 Jan 2024 02:41:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A201D10E550
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc5YaMuCBfgrTdXwGNkS4NND3+ploISpb5+QziGgHyfv1vDXu7T05J3cJN504nVRNB89ilpzpzkiNI4icnWX6ADzapiQfBNQ97SJyumbZJBU029rmGL7MUKT4K8iE+Ggff4B+NZEvgRKe65kXWJQth5BsdKxaMe3Jx7HmTKT7aOP3tI+b4/sdmuFQqu9mymnJFpZVf9AEYIFmRg0Gyg85ZF9JtNY6urWYE342zar/ss4df0OxUg8ZpvRZSrJhJwcAFdJWb2utdRczUq9p0J6KGv4+vwdroIzxG1yxGSHQlmdRGjufMF3zU/csyGymSPNilt9r6VSKcEbJ+UpxpLyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofsR4emV90fTc3oWOVbRvOMXY9vinF/PNS3EJeaBGp0=;
 b=mIk3GL0wD8hHyUlZyV0iTpYzpauqSYo8li2bIgQSdpOSUzaX43igXm68LtRIAg5bPTY8mavhXfjlYSZvKXlCyghBkQVRDsO1jt9rThwZX59WSQ6ucXbjcCiGUH0P8U/H1RP+ZybbAbmQ5Di3hBS9svFXCVX3geGc0A7OARZ4ebeTmoHPUk4XFL+kJeztxewuAAKVYX+kZsr1EcRDCVfJjxMeD+CUF5qBUNjraiCsGcTALaPC1d4Na9p0Zk5IE1b8XlFpNitK9QG9M4LeHCreNgcuejpiwNruQlPVzEmiyh+lVnszxDXcLHuFzDi3+Wugv5sKJDf64EdpIVfdWGdM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofsR4emV90fTc3oWOVbRvOMXY9vinF/PNS3EJeaBGp0=;
 b=FKsn9AuQFSpH1puXmxwI797nxaR/t13oG78oFyzWraMVd6CYkTJbatoL/qolPvAOBtV43yrTI3bSvPOR+MwNn/OfJ100OIbjYGCPzt9f2La7hP0ErJUpgxSCVxAnvSpAIhJTlt+NXDoQrPcdEoS5WfCSW4ttiRiA5e/jgORqyS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Wed, 10 Jan 2024 02:41:39 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:41:39 +0000
Message-ID: <7cd37500-8633-4030-aae3-9b532d60b501@amd.com>
Date: Wed, 10 Jan 2024 10:41:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the warning info in mode1 reset
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240105060525.579292-1-Jun.Ma2@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20240105060525.579292-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 60222f0c-0f29-4deb-765a-08dc1185ac13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXUc/0uUt1Mwj8IdM4QGMAsV5TKq/6L3U1y32JYXkXArFy1UjQP0RCu4ZYZmHG7NdUH2mnnCw7+fhTizdQMZLMF6XI1UtkotUinY4mwhk9GPGeIbbq2g2jtB08qYSBhC4CvX4jZXWw3cJ4nTVGmmDuB45DzLZkwx17WBBtaBOTxUVzHxzIBrFo/pwAO0rKSzurQcyKrUZIKjMNTndSUs7Ji+Atp6FUnDmkjPwvTEQv3VVxMC9CCWASK3i0fUrOYNt8BIzQAUfuttfYVDnIpVEIv14FqdztvOTPd7Q+AYYhY/BhzeuyiCqzDog67yE+4OTwXJSCADN7Ztt+KYBuagxuEjDmzI1sh0/CTvczGPq6Li259TVpcbSwZxSFOnjcVCC7uKfDjfQd4SWiA0KTX63xAy4mosvCCaLitkv050rfMTBnY3MtPmXRpcqiCjZrrJLCSQdOtjkB0evtyFJTALFeO/wvBzaAAKdWeQr8Wu2UlDsVyXHZXQXmYsNNbHNieA/wdrfRCechMpxrgF7L7c9G9YMj4w73yQQgg0vpVv7Y8CyXiEnBPdB4DEpyuj2H2HN0kiLMfD+NMhT8VDNHA4j4UVpyshAwXVrJ55VyoeiVOq/SMu3aeqcvLUcTsdog0dEge/rx6PPTZftjxaKt52uD++hroksSdWECi2C03kN7J0Blhrfx40jNLpwvStsR8z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(66556008)(66946007)(66476007)(316002)(4326008)(8936002)(8676002)(478600001)(26005)(2616005)(83380400001)(31696002)(6636002)(2906002)(5660300002)(41300700001)(38100700002)(31686004)(6666004)(6506007)(6512007)(6486002)(53546011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1Z3c1dXVXNuMFcrWE5oc3RlU21DV0xCVVpRTlpyenFBNlo2aXFqYVN5M2Iw?=
 =?utf-8?B?Nm1DTkNNNjA2UWc1Wk1GK3V2Y0t3RW04b1lFc1JnYW8rc2s3Q3FnUDNCUVNT?=
 =?utf-8?B?U2dVWDA2Y1IxQkNQeU9taWdBS1VCY1l0Q0FBa3VSdEU3S3llQzl2WXEyZ2VK?=
 =?utf-8?B?K21DbnN2d3U1bnpnRmpUcnp2OC9ETnhSUjVrRHNWZWdWYzRaR29GamtYSGhp?=
 =?utf-8?B?dlVpWnN2alpHeHlPUnV4VzcyVnRHelMyZE9zTGV3d3VjZ0U0aXE3dFQzTmk1?=
 =?utf-8?B?VTcvMER6bmxLVThKaTROeDkxeFc3cXdmTGovWDRDcGNUcUkwc080QmxIY2NJ?=
 =?utf-8?B?RkpFZE1PWUVOc0pMRnR6YWZIOXM5dGZYaDJETHR1S0tnNnp1SkJ0N245M2dU?=
 =?utf-8?B?U1U5clZPdFRHcU13ci9ROFArbFVVMTdyWWVvQXZUdzRtMHgyYnlzYVI1bjNG?=
 =?utf-8?B?Mko2UW40VnJqRkZyVEw3RnorL2RRZTlFR2lXUXZwMUh2U0NGaStweTBodHg1?=
 =?utf-8?B?QktwOWJUN2RtVjUwaHFmWEpaTzMxSjNIL1MvbzhIT3ErTDZwcHIxM1RXcGd3?=
 =?utf-8?B?MUJxenBJblZKN3p3czFkd0xzZTVGY2dZaTVsYkxjd25qRjhiTUt4TFg1aHVD?=
 =?utf-8?B?dk9SNVR4MTJScUZrMEpxaW5LYzZ1R0lUbG1GaUlnT2NWMVV5NGRmK1BMeHdY?=
 =?utf-8?B?MkVOREJxR2FrMTZpZ3pLUmxHdmZQaXkxd3VoU0NtUXNqZ1lEZWJ1U0RleDVN?=
 =?utf-8?B?bzRIbDl5M2Z1ekZudno1V0FjNEtVc3h0d3BXbkF1NStkS3hFQ1hWTTdLNjJa?=
 =?utf-8?B?Zzc1eXkvd3Bhb0VTMmQvSlJ3TUNMK2tmdFJRa1h6SE5sNFZySzZUT2Q2M1Nu?=
 =?utf-8?B?UnRCQ2sySXlDVFVMclh5dEZuRjVEK1ByWmQzaWc1UnFybzlUWTlvU3FLaElC?=
 =?utf-8?B?NER3OFk4Zmd0ekRJdnpJUlNTak1laTZLemY3MTluZ1g1RU5vSGZoMzQwbnBy?=
 =?utf-8?B?ejVKMUs5ODJ5d2g5cW53d0tOWXlFZXhaUWE3NDhHc3BKUGJZVXA4UWQ1Z29m?=
 =?utf-8?B?SXA3YmcwcjNsdUNFanRQekpnS1EvY3hvWWh3VGI5MkJDVUVWVmRCdnFBcXE4?=
 =?utf-8?B?YmVMcjFPMUJxWlRUV0tuVXNnUzZlTjJOenNpQ0xkNFRrSlg2V2l5N0pXYmxx?=
 =?utf-8?B?NUlUOFVmS3YvN1oyUnQ4MzFSQWp0WVI1SnE0K3YzTHgra21tZWRKbXA5TDJa?=
 =?utf-8?B?dmU2NW9oa2E5UnlvTXc4c2dSaW54eVJEWXB5M1pSL1dBVzN1NGVFUkdXa0lk?=
 =?utf-8?B?R1lPc25HYXNvWEp6SE0zQzNkb3Bvc1N0V2x0TGZ5c2RrYWp3eVFXNHBxclJL?=
 =?utf-8?B?T3hPZ2xOU0dFVFFic3BsR2lDeFpCSzhBM1JxcHQyMWNXNjBIODBMTjV3d2hy?=
 =?utf-8?B?cHpicFJrOWdzc29BNnczU1lBSlhGVGdKRGRSTDVWNHhXZmdkeG1mOUJpdHJ3?=
 =?utf-8?B?V1VXcHNsblZldDl0NXFTT3FEL1gyQlBlLyttOWVRT3J2S0FEYVIrSkFSQkI0?=
 =?utf-8?B?WE5yN0JzcTBKNVBVdmxMQlVvZXZvVGU0YmJ5MzdLWFB2S3pNN2RHZEFZSjBi?=
 =?utf-8?B?T3lidzNoZ2EzTk0vQnk4aGFYeThiTWkzNzBiSVkrMnAxV0UzUEkvcVdaaGFD?=
 =?utf-8?B?bk04NXVvWWdaVU1TaXlTdjhnYWEwT2xoVE1wbnpKb2p6T2d5bTZMTnZCS1N5?=
 =?utf-8?B?N1hSRW5NY0d3ZkFzUXVDSUR6REpDOXhpMWk1S3F2a2x6TnBCRHkybTdFSEVt?=
 =?utf-8?B?ZGp1eHowUGNJekR5TjFzbWJMZUZrVExwU3Bmc0xLanhRaGw0YXN5akE1UnNG?=
 =?utf-8?B?dUpQTzduRzVLREJMS3ZzL3E5eUc3MW5BRVFHYUJkVklaNHMyUk9QNlNtZzR3?=
 =?utf-8?B?eGpDL3NtL0k3R0tocnBuSCtYWnNhWUFEcm5UMzZhZ0lQdmUxRVg5SjN4cmFB?=
 =?utf-8?B?QzhQZk0vVFNPb1hEQ0dudXVFZWpxWXVLQ3lVL3Nubk1DU0ZHTUgreDNRdzIz?=
 =?utf-8?B?MDhIa0llbnZsVXpJVHlJRUh0SEd2czJJTU00WGg4WHFYUmlZVmNhNFBsVktO?=
 =?utf-8?Q?yXSQ3VoUqW+tb2rrSJ9OYw1dZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60222f0c-0f29-4deb-765a-08dc1185ac13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 02:41:39.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVPoW1Gym0I5LSaHO/eg96Cf1E8N/A3Pw5VZ/6Iikyjy/lfYZmNxj5LCe/ZBWRdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559
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

ping...

On 1/5/2024 2:05 PM, Ma Jun wrote:
> Fix the warning info below during mode1 reset.
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  ? show_regs+0x6e/0x80
> [  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000005]  ? __warn+0x91/0x150
> [  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000006]  ? report_bug+0x19d/0x1b0
> [  +0.000013]  ? handle_bug+0x46/0x80
> [  +0.000012]  ? exc_invalid_op+0x1d/0x80
> [  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
> [  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000007]  ? __flush_work.isra.0+0x208/0x390
> [  +0.000007]  ? _prb_read_valid+0x216/0x290
> [  +0.000008]  __cancel_work_timer+0x11d/0x1a0
> [  +0.000007]  ? try_to_grab_pending+0xe8/0x190
> [  +0.000012]  cancel_work_sync+0x14/0x20
> [  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
> [  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]
> 
> This warning info was printed after applying the patch
> "drm/sched: Convert drm scheduler to use a work queue rather than kthread".
> The root cause is that amdgpu driver tries to use the uninitialized
> work_struct in the struct drm_gpu_scheduler
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> 
> v2:
>  - Rename the function to amdgpu_ring_sched_ready and move it to
> amdgpu_ring.c (Alex)
> 
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 14 +++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b1d5f42249f..d0d82e69b034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5700,7 +5700,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
>  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> @@ -5776,7 +5776,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!amdgpu_ring_sched_ready(ring))
>  				continue;
>  
>  			drm_sched_start(&ring->sched, true);
> @@ -6265,7 +6265,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>  	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  		struct amdgpu_ring *ring = adev->rings[i];
>  
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!amdgpu_ring_sched_ready(ring))
>  			continue;
>  
>  		drm_sched_start(&ring->sched, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 41266bc99345..9555d5532d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -636,7 +636,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>  		DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
>  			      ring->name);
>  
> -	ring->sched.ready = !r;
> +	if (!ring->no_scheduler)
> +		ring->sched.ready = !r;
>  	return r;
>  }
>  
> @@ -719,3 +720,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)
>  	if (ring->is_sw_ring)
>  		amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYPE_DE);
>  }
> +
> +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
> +{
> +	if (!ring)
> +		return false;
> +
> +	if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
> +		return false;
> +
> +	return true;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index bbb53720a018..fe1a61eb6e4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> -
> +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
>  #endif
