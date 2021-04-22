Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B93C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 16:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C1613F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 16:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C1613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9416E0E1;
	Thu, 22 Apr 2021 16:13:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A516E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 16:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKenOkh1TcthlshzuftqCN6YIqRku5ndPrrZtsx2W6kluxdHQy4LD+5u73sS1GpXKUmHVUSYf2SgVZNjLt2/6yHz1Ac9ldugLuknlIC/D+0zhWsXbhx4ZENzilisYhpYffbC8Ofl8T12CZvlFjS+smyVOXLRDs6fv/XgW01IcgimU6mQETjd35Uv79NuUqpaEvYnxJPVVK1vm66DqPueKpaF3B0qZIer8UheKn8enF5ViSy4FpPgARvja3J0BiR/yJJjoxb+Lj1oiaBuNSpKqgEHsdcGavlM3xS+AHximralA6EFpywdpox8Z8BG2c2r3fG60Ur1roix7XcgU120NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CiJft+th/1H+EDZySJ3vxLM6meIsMgjSwCe/pji2dE=;
 b=KSwOYNlTvUHQQ0jeTL3A9lYj6YD31+m/UgL1K8JO9QA5oQTYAnUEDV13bZdcQn1uttHW9j/FtVUmH7XPHJfLX7pEq0Al6iopXIugNiiLJQubZG7g5ewE01eLTnbkiO+LZvnarF+iQjF5r9RY0srPPMHoQLoh3USJSLD5OquWW9/iPr2nczAgeT34KNGojn3rWPeXM5uy+OekoPRzgTG7O+S+PCa9gJepTAxRWsyGp7qjq1bCod6WNiRTxhz44nRBb5raW1ctXE697okuhY4k/Dpci8VOiRO+y56RABS56wcr/KxesIYaultbgbF9UjrO6VokVYZA2/PN5yBWhN32jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CiJft+th/1H+EDZySJ3vxLM6meIsMgjSwCe/pji2dE=;
 b=byerYmVn+U9jflyF3vjAzvcMDAQAlSfr0J5u2WdVS476uc5nC3q1m2/oBMOk6B9O2B/jjhck0M2Lu2BryrL4V5+m2dcEwpa9FsLe/EOfpVr4jhRVKwamIZC5E7uSlqPHEdKZbnUmJhAJRSWArcdRwg7XrNV1obhItIZoeSikY5c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 16:13:06 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 16:13:06 +0000
Subject: Re: [PATCH 2/6] drm/amdgpu: cleanup amdgpu_vm_init()
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210422154003.4048-1-nirmoy.das@amd.com>
 <20210422154003.4048-2-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2b855a1c-d9c3-12fc-d3d2-3c590ce9b149@amd.com>
Date: Thu, 22 Apr 2021 12:13:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422154003.4048-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Thu, 22 Apr 2021 16:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 519d8964-725e-428b-17af-08d905a98374
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157D90D9E16A8227636575B92469@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrAmsV2Go+NwcHfQrnHt8OHVIEDrdUcZI72Sb8HKwV0dFAF5OqRgHjRqOEvIVRPwTzc/NYBm1m/vzqGwwbGbpzyOjZBN6dF90/NDHmK8mY2MnGbGMywAJooGEITwrXy5Ajq0NJ13bUkxw3KObuxdDXF3LgQcnRCFrm/Wr/X41u0UvAAhfeFWCrVs/bPlcSHzl9gVfkgoEcpJSrdOIf/IvrA4tW6eOJf6l47vonOyvd5suMNKW7ivfpSpsPef/AlAmSeuOGdR9skDrEMHDWWk6JKCwyYuyZnhZFy3U9o+Qr6GA+AOT1hKLV0sRDgAZ2GY8BZbYIMhdTvo0YLEK28/5i4ja4tSl0tnGbKsm+RqeGE/MJ9nqfHxeNM66aUmOvdbYf/x7Za8VAeeyPZ9UbFynG2J9bsZVoMAWT8A0g66WorbLI6BGXnRnB5vYd3ftQDFlggix2w6gtajZAktY2ua/il/pqiV1zA9Q/j6tVKpGZ2prAb+QMdYX0B97D+1OEPJivhnYAbLp3w1kjekXrwE96KhlXPTtFbZtYPpRnYZ/o+I+PwDar/lfXw16pz39NkxiEPpyDivTre2ehZEbI7s87rmQy8Op/GpFkREaZOSte8LGKgCr9xE865libawiHgHrPDMiVF5pWSehM6+5N1O8zF4LiVXoD3KvGd58OrmCPnP7mo+BNuHhAZ61CfNNtTa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(2906002)(6636002)(478600001)(5660300002)(83380400001)(36756003)(38100700002)(4326008)(316002)(186003)(16526019)(66556008)(66476007)(26005)(16576012)(44832011)(8676002)(8936002)(31696002)(31686004)(66946007)(6486002)(86362001)(2616005)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEp1NXNReHNnb2tBd2tmZ3RnN2NRMGFXVEtlVnJRclRGcEpYYzI2bHAwYk1C?=
 =?utf-8?B?M1pSNHhhRjJ4OVhFMS9yeWVoRTNLUkR1aUhjeDByaGRUVldwTnZ1RkRVTkhs?=
 =?utf-8?B?WGhHRDd4Wm0va0R1ckhpT0hRNWpNQnNGTzRQZDI5cHJPRExHMUI4NGpJcHQw?=
 =?utf-8?B?N0NBZ2JHemdKUjQ1NmYzOS9oVFV6MTJxYlh1YzRmSmFnejhpY3JRT1VTdzB1?=
 =?utf-8?B?NTdiVFJacnVHTmJXTUQzNTJmSzltSTJ5aTV2c0dSR1FGVEVEU3FsUE1yaC9m?=
 =?utf-8?B?TU5yTG41dWhyVkQvNUNVbDNFNDlROXFHT1pITktEL0ZzM24wd2FabCtmWGEv?=
 =?utf-8?B?dlMyTklNOXNaZ2dRTzhwbUYzNktaVjlxTFcyQjduV0N5WmxKbEhqVGlDaUUy?=
 =?utf-8?B?aUYrQXUzKzRIVDBJa3RsUUk4VWNBTEIrckVHS2E3bkNUbm4xL2ZsaVdLeUxY?=
 =?utf-8?B?OU1LTXRFWEdhbERVRG8wNThCT1dvVEl1cDZINXgxbmZJcjl0dFNOSFI0cHRx?=
 =?utf-8?B?eE92bUxBbFBKMEpUUjhLakZ0R3R6eXNFOEllb2k3VCtTTU8vRWZjbTZDbWc0?=
 =?utf-8?B?aXowbGhrTWJBcUZiOHlOWkovcUN5elg0M0xCRmN1WEFXaFhoUzMxbWp0emo0?=
 =?utf-8?B?dHlnVWN1b2pKczlXUGdtRFdEajJ0TTJYVEdacWhqdlpudlZGcFExUmgrd0Z3?=
 =?utf-8?B?U1JKUi9CZm5iaXJhWDdIZlBMckdFRE9hRGY2YjVmQ1VpUFVjaFFtOWJQd003?=
 =?utf-8?B?N2pyM1VOQkI4VjZRL3czRnlaNklRaWxUQk1ZTytGOFFCTkM2eFlvbFMzK0o2?=
 =?utf-8?B?NG9oK0FoOFRxdFRnT2JXM2MxUEdKRVk3YnJITUpYNmVSUlRZZ3lDYUhLSXVI?=
 =?utf-8?B?RmVUQ3RtY0hERU1mUlAxRFZ2K0hhb1Awby9LWUtYL0RubTVrSzNtUEVBR3Va?=
 =?utf-8?B?UnA3NUg1SHN2aDI2WUJZYlA0Mk9YUituUC9oM1BpRDBDbnJsSWxDWGZUVXJG?=
 =?utf-8?B?RkNab0pEdG4yaVRYZlRLZW1pVlhHRkR4VUJUVndCMXBJNFRDWURGM3hXQWlj?=
 =?utf-8?B?cTFKelpZN3hpdTVBRXZBMTRudkorMUJhRE5HOWVYcTZ4akIrUURoWUx5aFNQ?=
 =?utf-8?B?akZzYVNEbzRQV3g0Q0Q2QURGQ3dlMFhvV3laYmNHdGRsQnJuWnY4eGNqWW1K?=
 =?utf-8?B?M2tYVW1hSzJsR3ZBY2NKWnQ4SlhGMFlyRFdBalFhY1hrV0d1VUx3c1ZFdUpw?=
 =?utf-8?B?QjFIdVE0dk5WVzM3SEJpdC9ObDN1ekoyM21mdUdTTEdDc0dYWXU3OGkxMm52?=
 =?utf-8?B?aWJwNFV3cjBMQ1lVTkR4MjVxdmJFNzh1b0wzNWtEVUtlNlZXQWhwbnFUUVQ1?=
 =?utf-8?B?ZHpGbUlXZVdLdDB2TC9TTUUza2xkNTU2Y2QzZ1F5ZVpRaUtQRWFtdWg5K3pW?=
 =?utf-8?B?cE1aaFl2VWxzRy9ZZmNwVStVUnF1bklkTkZ3dHdxb1NHM2xyNmtST1IzSXlE?=
 =?utf-8?B?VlJxV3QxMDIwZkh6WFlxSS9UQTBoWHNwdGcxbTRXK0lQM2xidHRzVDROYXc3?=
 =?utf-8?B?ZTd6eTF0emYzZkFHQlFpU3pmWDh1UVE0SHZuUUl3V3JlSmFSeFBNZk5yUjFm?=
 =?utf-8?B?Z2VsUlA3bHpLVXhWa0NJdCtCS2ZON3dCN01mWnBqcTMvUW00Zm5lOUJMM0t5?=
 =?utf-8?B?UWt5N1BURElQNTBZc1BXQktnTGRVb1Z0enRvVkF6SVdBSlNaU3gydGxtaVlh?=
 =?utf-8?Q?0EEQZI5OW0vUjBRK/ihC7mNpbi1emUCdLkQJp5P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519d8964-725e-428b-17af-08d905a98374
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 16:13:06.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPaxpZXxid9G9WH86lLp7Uet1cdXwug8rllcK+U3x3ocMYlr6uIpq7T9IuX53Un3NceGRSfqSOmpNQjA4Fn7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-04-22 um 11:39 a.m. schrieb Nirmoy Das:
> Currently only way to create compute vm is through
> amdgpu_vm_make_compute(). So vm_context isn't required
> anymore for amdgpu_vm_init().
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

I believe you can also remove the AMDGPU_VM_CONTEXT_* #defines from
amdgpu_vm.h. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
>  3 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 39ee88d29cca..07e8a7c28561 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1114,7 +1114,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		dev_warn(adev->dev, "No more PASIDs available!");
>  		pasid = 0;
>  	}
> -	r = amdgpu_vm_init(adev, &fpriv->vm, AMDGPU_VM_CONTEXT_GFX, pasid);
> +
> +	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
>  	if (r)
>  		goto error_pasid;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f95bcda8463f..577148a4ffaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2782,8 +2782,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, u32 pasid)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>  {
>  	struct amdgpu_bo_param bp;
>  	struct amdgpu_bo *root;
> @@ -2817,16 +2816,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->pte_support_ats = false;
>  	vm->is_compute_context = false;
>  
> -	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
> -		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> -						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
> +	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> +				    AMDGPU_VM_USE_CPU_FOR_GFX);
>  
> -		if (adev->asic_type == CHIP_RAVEN)
> -			vm->pte_support_ats = true;
> -	} else {
> -		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> -						AMDGPU_VM_USE_CPU_FOR_GFX);
> -	}
>  	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>  			 vm->use_cpu_for_update ? "CPU" : "SDMA");
>  	WARN_ONCE((vm->use_cpu_for_update &&
> @@ -2844,8 +2836,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->evicting = false;
>  
>  	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
> -	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
> -		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
>  	r = amdgpu_bo_create(adev, &bp, &root);
>  	if (r)
>  		goto error_free_delayed;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 848e175e99ff..7f07acae447b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -379,8 +379,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, u32 pasid);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>  void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
