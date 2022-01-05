Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 18:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6C410E3F2;
	Wed,  5 Jan 2022 18:21:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4CD10E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 18:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6m0nzwvS9dVIYkslCK2xFrRj6vVY8N/vh3Vgul/NyYJvHiW41ubRT6GwdNQs/vMbw3I0N9tF2C0xOb3sx2k7dvIbtgCJ3RXfypDwIEBxrdEd+XOb/1OcWXO23okJsPI/X1+Bvd3VaHygBZXeLj6ivhpNbPVuBWeX9hZnGSlwFa+GYSu0va+nT7/XIsvEjOX2d4DfREUGgWPD2SRM5DQcJV1xwjqeYiPz7T3+R2SEltorLCVHLUOuam+w/cJJv+xDy8anT+fEoqXixkWXVtaNV8wPgoHLX0RPMmpg3Hdn41gVwJqUP24TlikV1/Y5M2Jqs5Lpqs66AXi/2RciyYUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dkmpGjYmBBVOSWfKVyR9I399L4CTxtrnB90XzFP6Tw=;
 b=AuK3ZfQursSTYYHsANxLCkDF7iofnkn8N8am3j68O5ODiVkpyKEPDkCvyPjgMav3jab5zhM+XRNJyTr9SkzXehrFbRmTiq7PwXxhIKey2hA2dpEqKD66PoWrhCNtJ1rzvm1YQkvh5YOha3lYuKwpBd3479OGHr7eOlqaWNxmMrmhd52RtnKETALBaWL7d1gcZ4KOocZx6y4+2UdMA2WuZegygo1095n07cXsoCtPURzEN/byq7do/r+TzSmgNjQDZPSzs+m/IPWuc+IoeEM4QrM4F19EcI2o/PUEY+TKdaXOK+PWYhe9h5NmQK26Tjw5acmawI+mZwxgLXo8CmEDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dkmpGjYmBBVOSWfKVyR9I399L4CTxtrnB90XzFP6Tw=;
 b=Je60YlamRhamSV5UKuDHd8wN2Q3Pl1XilDBXpwQOowlO7d+YINeWIeE0GHAF51bN7jQB1lXE/UJWmJt+Sipy2elT+X9lc8pFz9pUWINKBqnR2jjLU3W+5YHah9OVwYhTarCvsCmlajaonSmPZJrTmBinMJFGV8lv+1RKmjXVZqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by CY4PR1201MB2485.namprd12.prod.outlook.com (2603:10b6:903:d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 18:21:41 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::5b5:cbda:260b:7c39]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::5b5:cbda:260b:7c39%9]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 18:21:41 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not
 unplugged
To: Leslie Shi <Yuliang.Shi@amd.com>, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20220105042344.988200-1-Yuliang.Shi@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <36b4daf3-c18f-b860-4f82-646731be9fc2@amd.com>
Date: Wed, 5 Jan 2022 13:21:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220105042344.988200-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b94e82b-7610-4ca8-1872-08d9d078389b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2485:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2485CD81AC60A6C84D6A6E45EA4B9@CY4PR1201MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is2DeNm9UWtFAT4ZJfsZBfbQZaaVY4CB7Ho6f1sz7FrQYnnm3CnqpP7Q9tSNiahB4vQvP+nwb0IgwohFvJBhYqp5R371YkkpWJA8fcpOid7Bo/6yain2yaNQDL2hKMKgksSkZ/F6IC+5y/cub1K9v4g9g0U4V5wdHl9Ui2KF3JAPOnzmq2AZpy+dm06mGZYjT96ZfxLAkXcRKcTckGqxHhSv6wM6IzDafOH21FuEWLhwJ+kecNeYX/e7rOw846jJXqKSo7C9+tEdoJMyRSle8+DtTT7+Duv0jqHl5rO+pm0U8wWF+RHrNvPsqQ66xAon4Pdudc4DHnmCFyfZyiBP8pN0G7f+MuhZcMq7lwu0g9i156O7eHiX+96eL89wtiV7xY6u9VSBZMGgQvabE6EUOXwds1zc9O8cMGVz87r/wEvh0z67oD2TWoQgEmSjWXrC/MjngSESU1SumWIFLr9sSo7MJBVvn3jHxyZaxx6Y+idY0NAxYRYYfAiUXHe/2Z6AbRn9N1UZM7C9EFkG4yNbltvi+icYVLs3yu7oIxXPH+gEdllAL31wJo1MQMmBEsaKPefb+SRULw3LJR4ls+U4gjwOi3C1J7HmUkC2nxliAltJ5WJHD8GC61Fk+i7gaoiMZemUbi7nLLT++86YXUNEPuw8zpEabhoDUv+/t+c8JPIFGhilNUVEJfLTdKUkQ2PV091XxiL93d8RD9vQt1/VVe+SmUKRa823910A7D1diYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(53546011)(186003)(6666004)(6486002)(36756003)(6512007)(66946007)(83380400001)(86362001)(2906002)(316002)(508600001)(6506007)(31696002)(44832011)(66556008)(31686004)(8936002)(2616005)(66476007)(4326008)(8676002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUYyVTNZd0dHRlBoV21nSUNGUDdlNzFFdzlFTklWTm1pS3NzOWF5blAwNW5N?=
 =?utf-8?B?MFd2MXFNRDk1dEVpSmZTRkQzRmRHdW1aOHVJMWl1MFR6aTR6UGdiYUJvRVVL?=
 =?utf-8?B?ZDhNMlV6V1ZLTjQ3ZzhtTEVsVEsyK2JpSExBR3ZFakRleTc5enFBcHVJNHdU?=
 =?utf-8?B?ckMxUE5iMkFXcGFOQkJ0QnZjWFRLZGJQTWF6c3JXR0ZUZGlsOVhGSkFXUmdL?=
 =?utf-8?B?cEMvWkNrNmQ5d3ZHL2ovOTlwNG42R3lIa3VTL1k4Qm1xTjJ0WFRmb2s4QjF2?=
 =?utf-8?B?UUgwUU1Sa0RoK1RnZ0NtQzJqT05QQmNVMFpSc1hQQ2REdVUyNFNydUVocGhO?=
 =?utf-8?B?TnpPSnl2MEpXdGs1N2R0RnNMa0RrMURySkFuRnRDQU4xT1BGOW9zSmdpVnR2?=
 =?utf-8?B?Z3J0VUZoTE1PNDViNEpkWmxReitBd2NPUHVrZlNxRnpxcno4VWN2MExxRVh4?=
 =?utf-8?B?cndWbjZ3S1FvcWpydW1UUW1VR2xqalFXWFZ5MStWZ2pFa2R6b0VtTDMrMFc0?=
 =?utf-8?B?K2Z3aEpOMUg1U0t0MVFOZE9wMHR3ZXE3VE42dmdJTXZMTlMyRTc1Ty9RYXht?=
 =?utf-8?B?alhSTCtZUWQyNlVic0hoOHZaaG12MEdqWGl3eTJJcEpOWVg4VlZpYTR6VStG?=
 =?utf-8?B?dlRVYVRyY1V5U0lIZWdnS1JMSTNwdXJvaWJ6YlNSS0lBa3FxRVo2MmVCeU9v?=
 =?utf-8?B?dGNrMVJjKzA4TUFxamxubnVqY0huVnNmSitFN0tRWis3M1dBVi9TUFRaQ3hD?=
 =?utf-8?B?ekswMkxYcnFwNTc4NG82b2xlTlhtenRRaHUrUzE2eERvM2NiWUZRUXc0ZTFl?=
 =?utf-8?B?aWRmUmg3S2JoNHgvV0Zwc0VKdHBCV0lxZjVQdEtSWlJCMFVaaE9MTWdOREUv?=
 =?utf-8?B?NlNBaXFkVVNKVzBqVHg0anhzSlkvdXYvSW1jUzhYL3VOWFVQbDBXT3ZYZ3Iz?=
 =?utf-8?B?OWVOWm5yUmQ2Q0RCalU3anRXdm5sZFAzM0ZtM25HV2NWUmpLR1ZRT1lReUM2?=
 =?utf-8?B?KzdVWUp1aU00Yk9JWXNrdFM3cGxwOXJ2VERTcHF4VVozZDVMNytOUU9mTFMx?=
 =?utf-8?B?dFduOE0rUGxjSm1vNEErajlNOXgzVTlhVzU1SEtyOFBIN1JSRGo2VGNYc3VG?=
 =?utf-8?B?N21JUWFZV2tIUEpCZ1pxVkdRSFBTQ3Foc0p0RG9kUlM1ZkpiOTVaYVE3ZVlE?=
 =?utf-8?B?N2lFV29EVnAwakdTdUJiL3pFOWkrQXhyTExOQUllTURxY3NFOHNYZzh4a2dl?=
 =?utf-8?B?THptVi9WQWwyUlhLL0thL1czS09vZ0t6WEtIMWZqZkdNcGpWTCtXcHpLWjRS?=
 =?utf-8?B?Ym1tQlkvYmpTeUlqNE5iaklndkFYb0xWdlFvTTNNenBJeHVLR0M5THJQT3lp?=
 =?utf-8?B?T2Q5WE1ZaTNKNHIvNE1JL1lPNE1DdTF2TDlmdlBYdFVJeUtFMDNndWMrVFBl?=
 =?utf-8?B?MjJwRnBUKzZxMWNDMUJSNS9hUnk5dGZlSXp2QndmRVF0RUdVckdKSDgzenkv?=
 =?utf-8?B?SUlBZDdZam9XWkEzL3h5N3g0S3Mrb2cxS1VhL1FWRjlYY3ZCeHpvczAxdXIr?=
 =?utf-8?B?R2UvN0FXRVg3cUU0Z1lMbkhYS3JKTXRmWjJ0aE1id0ZMSmRER0M5NENzemxW?=
 =?utf-8?B?VWtCS08vN3hZRG8vN2I2Z1lTNE9wOEhPUTZPS0cxVWNTMlk4Z29EL3I5WkV3?=
 =?utf-8?B?aVMwNnBQOEFnWkRSK2gwN1BJL3hyZzJvaW82K3A2V09yVGR2eTNDUGxpV0ww?=
 =?utf-8?B?T0krRnJVK0lyeldScWVZMW9xUWdJVlQ4NDRLb3dKMnMwYXl6a1ZabW1pQUVU?=
 =?utf-8?B?Q3JQZXRqWkVnMVZZdEVDWUIra2Z5SllKZHBuSUVWOGVwUno5ZFRrL2F2V1NV?=
 =?utf-8?B?MFJncnBJdDByY3FvYWlQSmRpV2xVQjYwdjBocW5zT3MwZGZEdEdOWVlENkph?=
 =?utf-8?B?MXN5R0Y1UVFJYnR5aGFMdjlNU28wSVdRUkpqV1dQTTBrK0IzQStrclU5WFNI?=
 =?utf-8?B?ZGlFV3h0d0Jtc1d0ZDR1QzdCOE9tbU52SlB6ZElrd21ibE9wSTJQOExlVGNt?=
 =?utf-8?B?a21tZlBpVFdtTDVmQ3RFcFhCUytFMGJpSUVpRnh4S1c2alRYRVBnZzNQT2p5?=
 =?utf-8?B?bUpvTVNGSFBPWDZXMi9PT0MzenpoVVdLa3kwaU9ES2d6S0JDNmRRR0ZTMTJJ?=
 =?utf-8?B?TDlRZkY0K3I1NHRicHpIUTRDUGJGN21IaUI0MzVrRVovSEM0eWpybFI5UzJU?=
 =?utf-8?Q?L/g1o/EWzqoFOmgBuZxKBaznF46pw/elqc2rBEUbeU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b94e82b-7610-4ca8-1872-08d9d078389b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 18:21:41.6008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IqOkncqhQ4zE25vQtIJXkAXd4xNhNGaaWt9+sbj45bWvtDaIHbYmex9r2FSjkoVA+GqLd082PqnRTCzOCJ9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2485
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-01-04 11:23 p.m., Leslie Shi wrote:
> Patch: 3efb17ae7e92 ("drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
> is unplugged to prevent crash in GPU initialization failure") makes call to
> amdgpu_device_unmap_mmio() conditioned on device unplugged. This patch unmaps
> MMIO mappings even when device is not unplugged.


I don't see the 'call to amdgpu_device_unmap_mmio() conditioned on 
device unplugged'
part in this patch

Also, please add 'v2:bla bla bla' part in patch description telling what 
was done in v2

Andrey

>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 +++++++++++
>   3 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 412f377f80b1..16dc16c860cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3832,6 +3832,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   {
> +
>   	/* Clear all CPU mappings pointing to this device */
>   	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>   
> @@ -3912,6 +3913,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   {
> +	int idx;
> +
>   	amdgpu_fence_driver_sw_fini(adev);
>   	amdgpu_device_ip_fini(adev);
>   	release_firmware(adev->firmware.gpu_info_fw);
> @@ -3936,6 +3939,14 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>   		vga_client_register(adev->pdev, NULL, NULL, NULL);
>   
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +
> +		iounmap(adev->rmmio);
> +		adev->rmmio = NULL;
> +		amdgpu_device_doorbell_fini(adev);
> +		drm_dev_exit(idx);
> +	}
> +
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		amdgpu_pmu_fini(adev);
>   	if (adev->mman.discovery_bin)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 156002db24e1..ff9dc377a3a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -33,6 +33,7 @@
>   #include <linux/slab.h>
>   #include <linux/dma-buf.h>
>   
> +#include <drm/drm_drv.h>
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_cache.h>
>   #include "amdgpu.h"
> @@ -1061,7 +1062,18 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_bo_fini(struct amdgpu_device *adev)
>   {
> +	int idx;
> +
>   	amdgpu_ttm_fini(adev);
> +
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +
> +		if (!adev->gmc.xgmi.connected_to_cpu) {
> +			arch_phys_wc_del(adev->gmc.vram_mtrr);
> +			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +		}
> +		drm_dev_exit(idx);
> +	}
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 367abed1d6e6..ea897feeddd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -42,6 +42,7 @@
>   #include <linux/dma-buf.h>
>   #include <linux/sizes.h>
>   
> +#include <drm/drm_drv.h>
>   #include <drm/ttm/ttm_bo_api.h>
>   #include <drm/ttm/ttm_bo_driver.h>
>   #include <drm/ttm/ttm_placement.h>
> @@ -1801,6 +1802,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   {
> +	int idx;
>   	if (!adev->mman.initialized)
>   		return;
>   
> @@ -1815,6 +1817,15 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   				      NULL, NULL);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +
> +		if (adev->mman.aper_base_kaddr)
> +			iounmap(adev->mman.aper_base_kaddr);
> +		adev->mman.aper_base_kaddr = NULL;
> +
> +		drm_dev_exit(idx);
> +	}
> +
>   	amdgpu_vram_mgr_fini(adev);
>   	amdgpu_gtt_mgr_fini(adev);
>   	amdgpu_preempt_mgr_fini(adev);
