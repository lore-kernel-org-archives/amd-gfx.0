Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5CCC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 08:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACA010F04B;
	Wed,  8 Jul 2026 08:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XM21+iWi";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAFD10F042
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 08:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKLkwB1hkUXbxHXeKPJ62zR9eULJLzjl2OISbvPxZ4kkB9qIjgPBk9s88LcphBAIhXywFU4qAoIxGJ6NARLs3pHU5+LdM2VKbEvbpJmnJ0edk3WxRJjwG1StPUh/qRvfQ+VW9DCBLUcmw3nHGTJZFH3/kVnRAoOFWIFDCKC3CTX2Xp2bOKbtBCSIYC67u4hObFktXDAe3bQLufc2QO2T1EgyTG4XbR2ZmWG7gz2aiJLSq6gzUR6cCtCEHQ42LWaV26LE0aqTojAX4Fpsf7nISW+xMThAASzrTs4/RIXPKHOPueub+B0jthps24LbIvzY8jGRWlz2MuDQMOR7TVnoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9WcmI2kKSptBJiwXOwCWoq6PDeRt9gqei1eX5XvFUU=;
 b=p9OE+jAuP5UlYiE3+CEdEWwJFqICiI/1Ifgf2az6mzI1h0CU7TXdtfAq8jZp5B7Ozijs0AGyxIbQTX83h15Vr/pJJaQgO5VWBZqB3NluH+KSM+1CclZyqzwMPV2AEoAsOS4iYVX20y3RU49RihRUN91QvMI8R7OQ4tRCZP1Irbp1CQd6b4zKXcau2riyqYWjpBTGk/kHm3FmiPNaWCQWLHAAMtFlr/eOXAPfW6uwulXS1ovN8S5Olh+cwiHCNS8c1gPwbhFxgLN1u1ntJ3w0AjRWQK6aGkEQ18yBnueMe6hbiEmdkfoRA2lH+VUBNV3uxVQ2cUk15okOlFnXGbDQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9WcmI2kKSptBJiwXOwCWoq6PDeRt9gqei1eX5XvFUU=;
 b=XM21+iWi/GTK0RqsDUb7lLsD2ZLIT4Jsvg+C7N4EQpSTxZQvwGmz9Yudvp4V48LZA2r+4AdnT3Eg10fElLWITzQmu47NSFDNslvU6PHnEwDKtGjQc/yO5qtX9Pz9U+VqRKy+d7Rx5NS6RK4McSDKqWmvJehZl7sthG8/aYBvf2I=
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 08:30:57 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::1f) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 08:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 08:30:56 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 03:30:53 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Emily.Deng@amd.com>, <HaiJun.Chang@amd.com>, 
 <Victor.Skvortsov@amd.com>, <Lijo.Lazar@amd.com>, chong li
 <chongli2@amd.com>, Cursor <cursoragent@cursor.com>
Subject: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov
 mode
Date: Wed, 8 Jul 2026 16:25:04 +0800
Message-ID: <20260708083035.186400-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cca6f0-c72c-4eeb-40d7-08dedccb3b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: qe2vwBXK16ZUynL64G3IDDSBzDgv5h6J/TAH63Bovo6GnSttSwiNRyqv0qdytm4J/8GaMTKs28+o06FtODoaqXBo1sOdy+1LuuQdXlWOm3VHIN7E+bNWBR+YQaHnTq1AtOMJZN3qwwqFV+DFm3ojh//wvzU+GrcFVPxGlrcBO1o8D1Ac0d4X3b3JqiThvE5p+s9as+7QOyZBDkKWDd7JhGJNUfx6isRgwb7OkdR2dvzCbwi2mictKsqppMSm9Z7M7Uw5B1huW4N2E4l9o87LVSQRK8hN3SXLMYFF7ZSgAlfmyiC5l4+UB5zLEOEhOHxFXTcbAUb0DtKdGlWWzVWfNCETTz9+H9JV8voq5sX+o3GeWOmBoayMpYqbbKwQEJZT/8Oe780D3xXzZgSzRQQqnHSvLF7fbiYEmA0wmjhuL+fzZhl68/PIBP+UjUIGSujJGs5TZncEGBaijnmkWgWmCvGAHmAimRy4u3eU+Nc2ayyVCv6Y+q1/H7guUhIrSyj8GEdirvGjtkVzUppXwuDMwCx73G7VxCx7n/PP5D//Sjl887FVS/WY1VNK4pk5YO/ZPwnzGG1NKOv4YVzsmZNv2LGV7rRdeH4MBiQkx3PrIk2hz2+Qw+bzJCkxeRCVl/woWA+JyQjVtKt9/PtK1xv3LbU0DC1stNqy7NA/DlaRQ9sEtTQFkthLi1UJ/sr2xOMDtjmnN4s6JLUsT1eDCcIGrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CGRJ2q9Y2JR3DJdhcjcg6qR6qz0Mp0glFvNWCH1S6PlqejwzEKMeUHuDto91F+ZILFqr6b8yLnAjrcDHDeLte+dSvXXzWQjsPubcJfhgPnH82KT7g9l6yXiYCQxiD5x32kB1hzn922kacC9dKXLIuwvttf2uDdAeDezmiJ6ZclMPSz1TLieV96LrfUrVpNviTB4UUfUAHgAf4/hBXyGu01DpVyEkQZaNxacmWbjiCtqGYyHlmL21p5ic9kox8LQ5Mycd0n8LEa+yytPCsF6Ku8b4oZLuUoUptdwidCTWTRmuzzVqrDwl7GbeD2oxCVw6jti68mX6BDQc0GxTeulJMZDImQ/IUmFSmkD7+3XJ/tahGUcsXlj4h4R8zDk0wvbclb7abYmLfID+sUq0vrg1SM3N1ovdQoUpPhguW/hx7uxZvw/ix+mmiMjJtzrRApw8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 08:30:56.2322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cca6f0-c72c-4eeb-40d7-08dedccb3b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

v2:
Some legacy ASICs do not send amdgpu_virt_request_init_data().
Only keep the full GPU access request early when request_init_data is not sent.

v1:
Move the initialization of non-GPU resources out of the full GPU access
region during AMDGPU device initialization.

Background:
In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN
and places early initialization data, such as IP discovery, VBIOS, and
PF-VF exchange data, in the VF FB. The guest should then be able to read
this data before requesting full GPU access.

Before this patch, the VF still requested full GPU access in
amdgpu_device_ip_early_init(). At that point TTM is not initialized yet, so
the normal VRAM aperture mapping is unavailable and the guest falls back to
MM_INDEX/MM_DATA register access. That register path requires full GPU
access.

Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(), for
the early init-data copy instead of MM_INDEX/MM_DATA. This lets the driver
delay the full GPU access request until after the early init data has been
copied.

Signed-off-by: chong li <chongli2@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 610d82b79de3..ac66796e8634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -38,6 +38,10 @@
 #include <linux/apple-gmux.h>
 #include <linux/nospec.h>
 
+#ifdef CONFIG_X86
+#include <asm/hypervisor.h>
+#endif
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_crtc_helper.h>
@@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
 	struct pci_dev *parent;
-	bool total, skip_bios;
+	bool total, skip_bios, early_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
+		early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
+		if (early_full_gpu_access) {
+			r = amdgpu_virt_request_full_gpu(adev, true);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
@@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (adev->gmc.xgmi.supported)
 		amdgpu_xgmi_early_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 9a40107a0869..340703d89d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 	} else if (req == IDH_REQ_GPU_INIT_DATA){
 		/* Dummy REQ_GPU_INIT_DATA handling */
 		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
-		/* version set to 0 since dummy */
-		adev->virt.req_init_data_ver = 0;	
+		/* Version is set to 1 since GPU_CRIT_REGION_V1 */
+		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
 	}
 
 	return 0;
-- 
2.48.1

Hi, Christian and Lijo.

Sorry, I made a mistake.
Host access to the VF FB is not platform-dependent. After the host driver
sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.

I borrowed an ESXi server and tested this patch there. 
The amdgpu driver works normally.

I rewrote the background. Is anything still unclear?




>On 07-Jul-26 5:25 PM, Christian König wrote:
>> On 7/7/26 13:30, chong li wrote:
>>> v2:
>>> Some legacy ASICs do not support amdgpu_virt_request_init_data().
>>> On platform ESXi, the PF can access VF VRAM only after the VF enters 
>>> full gpu access mode.
>>> Only move the full access request later when the required conditions 
>>> are met
>> 
>> This is adjusting the driver to the hypervisor and not the hypervisor to the driver.
>> 
>> If the existing init order doesn't work on ESXi then that is an ESXi problem and needs to be fixed there.
>> 
>> So still absolutely clear NAK.
>> 
>>>
>>> v1:
>>> Move the initialization of non-GPU resources out of the full GPU 
>>> access region during AMDGPU device initialization
>>>
>>> background:
>>>
>>> After the amdgpu driver sends GPU_INIT_DATA to the host SR-IOV 
>>> driver, the host dumps the IP discovery/VBIOS/PF-VF exchange data into the VF FB.
>>> The VF can then read these data blocks without requesting full GPU access.
>>> This is the purpose of the GPU_INIT_DATA event in the SR-IOV init flow.
>>>
>>> However, during ip_early_init, TTM is not initialized yet.
>>> The current amdgpu driver therefore falls back to reading these data 
>>> through MM_INDEX/MM_DATA. That path requires register access, which 
>>> still needs full GPU access.
>>>
>>> As a result, even though amdgpu sends GPU_INIT_DATA and the host 
>>> prepares the init data early, the full GPU access window is not 
>>> reduced because the guest still needs full GPU access to copy the 
>>> data.
>>>
>>> To fix this, use amdgpu_device_read_fb_via_bar0() to copy the init 
>>> data from VF FB before TTM is ready.
>>> For this early copy, the guest no longer needs full GPU access so the 
>>> full GPU access request can be moved later.
>> 
>> You are just explaining the chicken and egg problem here instead of giving an actual justification.
>> 
>
>I guess there is no other technical reason to disallow accessing FB using visible BAR range. The only reason of going through HDP indirect path could be because the offsets could be outside of visible range. In SRIOV case, if host driver guarantees discovery offsets in visible FB range, there is no reason to disallow that.
>
>Thanks,
>Lijo
>
>
>> Regards,
>> Christian.
>> 
>>>
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++++++++++++++---
>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 +--
>>>   2 files changed, 30 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 610d82b79de3..ec353f4dd0d2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -38,6 +38,10 @@
>>>   #include <linux/apple-gmux.h>
>>>   #include <linux/nospec.h>
>>>   
>>> +#ifdef CONFIG_X86
>>> +#include <asm/hypervisor.h>
>>> +#endif
>>> +
>>>   #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_client_event.h>
>>>   #include <drm/drm_crtc_helper.h>
>>> @@ -1973,6 +1977,17 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
>>>   	return parent;
>>>   }
>>>   
>>> +static bool amdgpu_device_delay_full_gpu_access(struct amdgpu_device 
>>> +*adev) { #ifdef CONFIG_X86
>>> +	return adev->virt.req_init_data_ver > 0 &&
>>> +		(hypervisor_is_type(X86_HYPER_VMWARE) ||
>>> +		hypervisor_is_type(X86_HYPER_MS_HYPERV));
>>> +#else
>>> +	return false;
>>> +#endif
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_ip_early_init - run early init for hardware IPs
>>>    *
>>> @@ -1987,16 +2002,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   {
>>>   	struct amdgpu_ip_block *ip_block;
>>>   	struct pci_dev *parent;
>>> -	bool total, skip_bios;
>>> +	bool total, skip_bios, delay_full_gpu_access = false;
>>>   	uint32_t bios_flags;
>>>   	int i, r;
>>>   
>>>   	amdgpu_device_enable_virtual_display(adev);
>>>   
>>>   	if (amdgpu_sriov_vf(adev)) {
>>> -		r = amdgpu_virt_request_full_gpu(adev, true);
>>> -		if (r)
>>> -			return r;
>>> +		delay_full_gpu_access = amdgpu_device_delay_full_gpu_access(adev);
>>> +		if (!delay_full_gpu_access) {
>>> +			r = amdgpu_virt_request_full_gpu(adev, true);
>>> +			if (r)
>>> +				return r;
>>> +		}
>>>   
>>>   		r = amdgpu_virt_init_critical_region(adev);
>>>   		if (r)
>>> @@ -2159,6 +2177,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   	if (!total)
>>>   		return -ENODEV;
>>>   
>>> +	if (amdgpu_sriov_vf(adev) && delay_full_gpu_access) {
>>> +		r = amdgpu_virt_request_full_gpu(adev, true);
>>> +		if (r)
>>> +			return r;
>>> +	}
>>> +
>>>   	if (adev->gmc.xgmi.supported)
>>>   		amdgpu_xgmi_early_init(adev);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> index 9a40107a0869..340703d89d6b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>>>   	} else if (req == IDH_REQ_GPU_INIT_DATA){
>>>   		/* Dummy REQ_GPU_INIT_DATA handling */
>>>   		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
>>> -		/* version set to 0 since dummy */
>>> -		adev->virt.req_init_data_ver = 0;	
>>> +		/* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>> +		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>   	}
>>>   
>>>   	return 0;
>> 




