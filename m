Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5025C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 18:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B5210E032;
	Wed, 12 Oct 2022 18:40:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979B110E032
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 18:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjWypDe2B6KAhxGKluNmFp5RyMzwCf3YNSsdPbQKyQnaSjYruj4lZNBDGEJtptC/5R0iTYrSKZmmMgrFRf7RhxnWrGUg5f7rfX5BxG1kEGMmRMB1BbK+ZysLEo1+DinWZP5LICZK3UKpmQhRxWqTB4fxWjiDS4zLCXBJZYtDOAUcFDVW3bfI2D8TEMLXvPR0mzDdbA+fA2unZQzBDisMavuWWxOs6tOvVpRulCOjQv8JtiOsHJlbUc8ZGffmt/AD9qRLaEh1uVMPWldH9yPh9PeVnKBptaFmkMztY6r4Q3BGcxqALvfS2mhyNoJVtV+fnRD4nW1jdFx+SiQ56V6ySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF5ZVpgTrZngR8G+SyTreYPQcNAZZt/vgmnBDH0bvUw=;
 b=FlPtRvyNnsom3Crr2ar4hsaySM/bkiv11vXMTSulV2eBD5y3HqJxr6TmePFZ+R4cscdNnROnLT11VVAvwBoalFqyyzLzwQPdHehb5kVAgoeGtKznAaXAepa8kWbiaRD+0znjXzqaWKTXf7xq9tc4963U9ESYmrNWxIMYVT9VQcvxw+JPUGe2pLdDfp7TDF6gfKyGERP6jOPhxs9DTSj4+NUOy27x/aX+m9ezT86QWGAEma8dkDfWOBc+12vHGrmH+1zaWCkKKwcyJhqOxur+/lIRtrBhxqqwohdC0RKh2X/ZjIYH7Lip+gZZ1PHxV5mOKPcsERU/rBN1xzhKEqPF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF5ZVpgTrZngR8G+SyTreYPQcNAZZt/vgmnBDH0bvUw=;
 b=hJmB5ZwMg+h0heAeHqrPGbT+SQmq8ADEq5Pdzsj9qAn+WjlK0BWh4saQ+NZJkMmWeB4mwdLBMqLm76ylsv+mMZ+BvEqR4gbV6mmk+dsf0T6yU8JmKHlfG8YlajQ3ERUyaT3m1zTi3odOfXuLRY4JMx3Twf7D70sKvuWemRfUcNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 18:40:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f9a4:8620:8238:20e8%4]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 18:40:30 +0000
Message-ID: <6c52d487-9364-c9b3-6615-37db13acacdf@amd.com>
Date: Wed, 12 Oct 2022 14:40:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Danijel Slivka <danijel.slivka@amd.com>
References: <20221012132011.91886-1-danijel.slivka@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221012132011.91886-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 234b7d0d-02d8-47d6-2fb8-08daac813d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKEU8+eSYiI6LuDMFO85+74yywU0jPBQfTFi87L4f6FUWsXFPAU6ZfCOCmNCSNEa0ODfTmkoF/rCrD9J4DlLUcC0JmYXVrJlay1BZtqVTVYiBdbR00PHKamc9M4FYihVKQYavM1Mjbx03ZYXjs1zD8fPwe4Vnh/Nr0GPszZhZFOjCafO7HG38qiU38eBWg4Wph5SDn8+6UHp3IAvufNhruhIepii4xmEDbYOC77jmY0VaXhFDYcjXviTxgmhbMyyjWXiCi0hpNU4J3WsDUwyZ7ga3EruXdbk2fGq98ZGJGkm6as9Wzoz2z2MfRKTXIN/iSLQYHhFX9UhVGrPN3cO7YuGEWX4SnS7yhx+1YbI39sxlDesePdyCObBetwC0aTE7KWYePR0LsxScsWe/EzrS0kXVTkdb2fF9GLhQ9trRUmVfSDeLw7cOiYKvgDwbH5IBr7I23TteVO+EEAlnzzBBOwNpyTyl3o8FIQXQKdzPCxCShj7r5rDC7iftYIVvvJmMEreezaVa7LDZ7nY425rBclunHinlxPQYFV99FTR4mmgp/eN7IVny0I46IUqzJ9hP6UB8qdoO0B17S8v3mpkcMHmZ//D20F12haPD9qSc/v2PdOM9MLvSnHUqgCMNjwrJkjfrR3pMUdVnOtliJRBlkymFRtWQ3bDqsxGZ7rfDcaGE8+ls51fG+vcHnhXJa/Sf0FPcUIEbt74HflknwU5uBG/c3yyt54+FcpjFHRXbFush3fkKuzR36zCl0qgC96AJVsBeBYbakjiVzpL7ytnp/zPL20ktl+nl2KhgW28LXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(37006003)(6636002)(478600001)(6486002)(8936002)(6862004)(5660300002)(41300700001)(44832011)(316002)(36756003)(8676002)(66946007)(66556008)(66476007)(38100700002)(6512007)(26005)(31696002)(83380400001)(2616005)(186003)(6506007)(86362001)(31686004)(4001150100001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk94MXIvazl4ZVMwQ0VWaXk5SktiTXNJMmJibkZXbTgva0pBVEI3RS93SEpR?=
 =?utf-8?B?bnZ1M1JtRG9zWFNwTmJqQmdzTW5sc2VDUUJPaWM3VURMQW9PbzFkMnNDa2Rw?=
 =?utf-8?B?OGgyNTdYRFBkV090M0tBM2w1ckNwZkNpNExjb1NTbk9oTWd3d2xET2lBeURz?=
 =?utf-8?B?bUs1a2ptdlpjYU5xc2YxNzFqdnJqZFdhN2xZTDNqQ2VGQWw1bUhKYjNJKzBw?=
 =?utf-8?B?cjdPbU5HbnVwTmdlV3ZLdWwzcWx6VG42TUJFZlNKV1p3aFQxelJnZGdYVUtx?=
 =?utf-8?B?STRnV3hEU1RGQVJiaXNXUW9LbGRWL1pXaEZpZ0gwUlRNbDdHaTJrK2FZb01B?=
 =?utf-8?B?cUQzVWZWaHhhR3cvRWdCbGs0enNVQU9iUkVOMHdUUGlRdEc2OU5DeWdoM3Jp?=
 =?utf-8?B?dGtzQ2RyU1hHTURHaGE5YU9UOEJPc3g2eDJpclJDcFhuRFpackF4TU9lMHc5?=
 =?utf-8?B?eC9OWTJqUUVFS3BUdUl1NFdzcmF1L0tDdzRQaG1QUWFuN0xIam40NDRZTHh0?=
 =?utf-8?B?eTlNVWJEUzZtV2lOdllDWklicGlzVVRPNkNmOWdTREZQKy9SYi9UVC9JRE5L?=
 =?utf-8?B?eVB6ZVExTEFNWFgvZ2wxUDhBWEFYNkRvRlZhaTFSNDBXd2hwcmRWUXQrVVZJ?=
 =?utf-8?B?dGFMMFJUa1Y0Z1dHNGV3T1dvQXErenBhUGFQSVhoUUVWdUlmRGNienQwODYx?=
 =?utf-8?B?ZlZXQVU2TWEzRUp2OTc0S3lyNXZqS0xzcTdVci80QVdXNmlDMkZVc0dnTGJO?=
 =?utf-8?B?ajA1cHkzcFhrSE9KSE4vZ05Zazd2UkVIZ3QzUWdyc1BWdlhSVWxRWFhnaWc1?=
 =?utf-8?B?RGk5TlUranRodEZ1MDR3UE1tWndVZGF1SUZRU0Y1aHpBTTZQcDBkQTNIazds?=
 =?utf-8?B?VnBNMjM0SnpLREhDcDZaSG9YWVM2SStJLytEOWVpaThaeU13NVBGdDU4a0h5?=
 =?utf-8?B?V0lDR0MrbGlhbkpMaHd4a1ZkZnZhZ1p5WHJvZWNCZmZnRFovV2JyUFc3R1pT?=
 =?utf-8?B?NndudHQ3ZHZoMkp0dkRNbTIzQ05Ha1NmNElKK0ZYVnFxaCt0TlhGTldUQVNq?=
 =?utf-8?B?RHIxT0Rnam5WYkJ6d01EWWNWakVxUERPZEszaU5mSmpxZjlVZnJhUFdMZ1p3?=
 =?utf-8?B?QWRsMEViTXl0WXYyd09KTXdueU9jOUhIWDAxS3lTQVJoOUlnRkc0ZTNEeEk5?=
 =?utf-8?B?d0RGUC9pbnRpZjBvZERSR3hPQ2FaQjFERUlySmx4Rno3MnVVZmlHeld4SUph?=
 =?utf-8?B?d2ZkS1JnNWhFckt2U3lGUnRZK1RGZ3hkRTgvQWFLeC80SVFLNStCVzM2eXla?=
 =?utf-8?B?dDlFSmxYeW9xUjRCWHpUWHNuNkU2bDNHMnpCL0ZsdU5nY0VmTC9MZ3VaV2VM?=
 =?utf-8?B?SjRjN2YrMmwvYks5dlgvYmQvc25nL3JTYjRURXB4UldhdndOOXFXbGttemdp?=
 =?utf-8?B?MEVHR213L05aeG5RSWMxMEV2RXFkTUpZZ0pZMmlqeEVzUEdvaFVGMDRobC9r?=
 =?utf-8?B?aTZ6UXJadTR0K1E2UjFjV2Z2SEJxeVU0cS9pTXRBQzEvek8yMHZKaW5OMUJ6?=
 =?utf-8?B?UU9aNWYzd3RUVG1hemtlL3E1Y1FSd1piK3pGVTVJKzNEdXR2blozY1pTTFdo?=
 =?utf-8?B?SWttaTBVdmZmUyt6UTVnQ3hqcnUwcW4zbzdNWDdVRWVGUU9yVG90RXUyTzRy?=
 =?utf-8?B?aTRGbmFtZ0RkQ1BSSWxSeEk2THlUckIwQncyZWtkcHc5Q2IzcnhiNStpZW1B?=
 =?utf-8?B?T1ZXbEhKY2I3L3hEM1BNWUVZT0ZtWUVCblRIVXZGMXRraEx3ckRIQ2drc3g4?=
 =?utf-8?B?N1ZtSmhPN2xvalRrVmtrbXdlL1ZaUlZ0UFdHMVlrZzJnZ2hzdW5kVi9WOXVj?=
 =?utf-8?B?ZkhudG5YUDRIQXMwOUNqS3dzYjIyUmVuWm1yemwzV3k5K2RJN2FsRG5wY3lP?=
 =?utf-8?B?RHd2WXB6dFR2YWZRR3Fjb3JGUWFINUQ1UDhZMDBjbGJsai9yQWI5V3R0SVo1?=
 =?utf-8?B?dEFTNzdiMFE1Wkl2ZG0xTGY3N2hWem5pd0JIOTBaWjlBaFpuODZleVdZOUpC?=
 =?utf-8?B?b2ZZZjE3OE5PZTdFbituR0lHZTVvQW1vMC90NTNnQVN6U2t6NXBFYS9xNVF2?=
 =?utf-8?Q?1JViqq2DTLkOpOygryL9IqtKh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b7d0d-02d8-47d6-2fb8-08daac813d3c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 18:40:30.5709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXyhQaVboTCQTRhy9ktsvhByVzzMiAfVB3jd4U6qs/ufIj4RX5XfXqcC3j+HXVBooi4A3TK0+iGU4ApFFIX0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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


Am 2022-10-12 um 09:20 schrieb Danijel Slivka:
> For asic with VF MMIO access protection avoid using CPU for VM table updates.
> CPU pagetable updates have issues with HDP flush as VF MMIO access protection
> blocks write to mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
> during sriov runtime.
>
> v3: introduce virtualization capability flag AMDGPU_VF_MMIO_ACCESS_PROTECT
> which indicates that VF MMIO write access is not allowed in sriov runtime
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 6 +++++-
>   3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e4af40b9a8aa..9c765b04aae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -726,6 +726,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>   	}
>   
> +	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
> +		/* VF MMIO access (except mailbox range) from CPU
> +		 * will be blocked during sriov runtime
> +		 */
> +		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
> +
>   	/* we have the ability to check now */
>   	if (amdgpu_sriov_vf(adev)) {
>   		switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index d94c31e68a14..fffc224ff03d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -31,6 +31,7 @@
>   #define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a virtual function */
>   #define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pass through for VM */
>   #define AMDGPU_SRIOV_CAPS_RUNTIME      (1 << 4) /* is out of full access mode */
> +#define AMDGPU_VF_MMIO_ACCESS_PROTECT  (1 << 5) /* MMIO write access is not allowed in sriov runtime */
>   
>   /* flags for indirect register access path supported by rlcg for sriov */
>   #define AMDGPU_RLCG_GC_WRITE_LEGACY    (0x8 << 28)
> @@ -297,6 +298,10 @@ struct amdgpu_video_codec_info;
>   #define amdgpu_passthrough(adev) \
>   ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
>   
> +#define amdgpu_sriov_vf_mmio_access_protection(adev) \
> +(amdgpu_sriov_vf((adev)) && \
> +	((adev)->virt.caps & AMDGPU_VF_MMIO_ACCESS_PROTECT))

The ACCESS_PROTECT flag is only set for VFs in 
amdgpu_detect_virtualization. So I think you can remove amdgpu_sriov_vf 
check here. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +
>   static inline bool is_virtual_machine(void)
>   {
>   #if defined(CONFIG_X86)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 83b0c5d86e48..2291aa14d888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2338,7 +2338,11 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	 */
>   #ifdef CONFIG_X86_64
>   	if (amdgpu_vm_update_mode == -1) {
> -		if (amdgpu_gmc_vram_full_visible(&adev->gmc))
> +		/* For asic with VF MMIO access protection
> +		 * avoid using CPU for VM table updates
> +		 */
> +		if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> +		    !amdgpu_sriov_vf_mmio_access_protection(adev))
>   			adev->vm_manager.vm_update_mode =
>   				AMDGPU_VM_USE_CPU_FOR_COMPUTE;
>   		else
