Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182DBC43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 11:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F4B10E485;
	Tue,  7 Jul 2026 11:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQaUcTct";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8A910E498
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 11:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViTODYqCnH53hCakvKkQHv/bnk2ygOJRiM9Ja3ODblhA8wP99gmhI1Bc9hJnBlNG1qrAv8Ke68vsDXgYFgzS9X6Fz7xQEKI9aBgCW4RZMiaxaCmh8E5Sbkbfje3tQ8fawc1N6bod14CppPfQ2wZ9ldjj9uSlSCmkXKwA/NpJbqkvUo4nwLvtZvQzPFDgRxyUGHiIuJAGuZEqx6mFGu8AEx9gZPo9Y4wp5+WK65MD+z9TlXpy/NcHEjzX71xlwvmQn0YdRDA/7aoo8RjcZepcJYaztw7Xx1L/GJKt4p8foUU6XS9OzaSqXiYAPKpNtpnICTlDD6rw43yE0pJ0t6iDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RkQP9fmJjAhkRUUVvb7zgssnpZAnZDAgKck7hu23tI=;
 b=A8XPUSnOeiY1MmNNl2OXYj+NTYCbObYbR0vfTlx3TyNk76DtsnOA8Nzz3znxkTlZxiccZXkOj3Yahpl1rELcbyv5Pa94KB/M7XgOvbmjcSeuPNnVK1ixQmlmRfVl9WwY9GSj/jJYgpNUlrGc2Or3g2cxxTJCKfNFDwtt7UH6PbJT1+ErIhW3tN7Czd9RxBxcrEmDWMy9M0v+x8KcDn3Th4GpqZiL/o5Lv6Ha8mIPsrGI0gVrmkC4Ft0SeyRv1B5G8pH/ch8cQkv2Wb6X11pVe0NYVIwvI2H+FD2a5JJZJ5puM6DEjplv+3vrOWOPKfAjBhSw9pRJW66jUgaI70Bx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RkQP9fmJjAhkRUUVvb7zgssnpZAnZDAgKck7hu23tI=;
 b=YQaUcTct6t5KlmAO+voFGmYgwJGu7wr5u4jNysSWvxdKSiyX+LHQWhkK4qe5nZX4rqZTE+dMvDmCBA5sTpfguj60fVWeYHEpW4CfD/nLxSsLecOLugAEKHZlBNrlb/XA2D5+mKTAYoBqVonbigYjFguBA25/6PN8M/EJ601ItZs=
Received: from DS7P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::12) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.14; Tue, 7 Jul 2026 11:35:00 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:25e:cafe::76) by DS7P221CA0030.outlook.office365.com
 (2603:10b6:8:25e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 11:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 11:34:59 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 06:34:57 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Emily.Deng@amd.com>, <HaiJun.Chang@amd.com>, 
 <Victor.Skvortsov@amd.com>, chong li <chongli2@amd.com>, Cursor
 <cursoragent@cursor.com>
Subject: [PATCH v2 2/2] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
Date: Tue, 7 Jul 2026 19:30:18 +0800
Message-ID: <20260707113423.159063-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a93407-5ed1-4bd9-b37a-08dedc1bc71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: KRhmml4Y0/Pqop3J7S6fLb8qDlEmI83ndnkY5ShL++OA/WNCylaAbCp/2iOcagqi7Cv6Tkuy4aHEMSWqOOTrTRUQ1SlrbOZD4u12Bm7+186bAmMdYN6u0WTeJ2EGppDnQi7zhRgrD+ag2m6Gj7U6gWe0cGjCviiWxrzUcmTK+QQmeK1NwYbl7siH6KqMuBHmBiT1QRpVGBREX6TC23ZneztZmNkhuC63pHeRXT/AkB7wu5k4tlB+yyRLzeQv4a0KxmO3UEpbzD/Omr7izSU7iKqXY90gN6T5sxZVc/BY3Y1MpHzdC+IsfVrG4FZxy661xTi1UNVK6a3pcIOnTu/rUDxzdrDoGmum6MWPGMwoeDHiO5w6KXJmN/Vm8q+LUuITkA5ma3RckVRMFTf8O2xAW4cm7uZ7FZvBv6gFiM3hbbNppIHWFlRLAEb+Amgfr9oqeEn2alOJYkLKMaHDXwDxzx/GTGroDYklvB/4P4ZrDPws1BZbZOkWJLuZunMylvytHoWroYaiGqB1Yv7bNCXyR39FLLf6lwhXVePptxECP8OpnlXfjB2tbYnUMTQtNRxjJ/kM6SAIcik+O7V/mpKkDbMztQZEKhXZW+OWVPhNoYXm48Ci6KTTBu9KxAoT1+t0/Y5ndwZNUNJmJ0z5pHnAQLOI+kmOYDPmuoFHMWCmyWbTH5GaUWEi6cqgTpcWEDSsERpH3clgwFcwV3uVScL7OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 30/LszfIdQc4XK2mAL5aQwRRfQmJQGB8dugTlo6f/p0xEi2ZVG1anMhdRblAr+oHb/kz4j+PUTOpx8DpwUYCpJsj7lJne8QqkOGwzElhgecR9rP/KxqKdy53jQj68pjYQligszACt2cf8AlUvPLpnZqNAlUEqCHjpvXP+Sxd0xeAWp1t0CM3Lzv7D8Ow3J86iE/YkVGJIsi31utB8AUSP4hypLQsi29Kiim/uOE1Fi+xXUhYVulut++rmmFLiCCmg2QVrf4NWQv8/oXXeN4UOupqWA9kL5N6WrXEhJZWGPo3RP5mdPlQv9cSsNKXwuGCnlaaxYXRFWmcjiFkB7cb3X7zDMHkUberGa2fqvDl1+RodDFpm/wuvUoGPqej4rco0ez5xcBnlBOI6fy46e/lmFKQi8eU3ITS9+MkhD8MYT+NJbBdMl/63Qpl7JUkr1bN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:34:59.5339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a93407-5ed1-4bd9-b37a-08dedc1bc71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Some legacy ASICs do not support amdgpu_virt_request_init_data().
On platform ESXi, the PF can access VF VRAM only after the VF
enters full gpu access mode.
Only move the full access request later when the required conditions are met

v1:
Move the initialization of non-GPU resources
out of the full GPU access region during AMDGPU device initialization

background:

After the amdgpu driver sends GPU_INIT_DATA to the host SR-IOV driver,
the host dumps the IP discovery/VBIOS/PF-VF exchange data into the VF FB.
The VF can then read these data blocks without requesting full GPU access.
This is the purpose of the GPU_INIT_DATA event in the SR-IOV init flow.

However, during ip_early_init, TTM is not initialized yet.
The current amdgpu driver therefore falls back to reading these data
through MM_INDEX/MM_DATA. That path requires register access,
which still needs full GPU access.

As a result, even though amdgpu sends GPU_INIT_DATA and
the host prepares the init data early,
the full GPU access window is not reduced because
the guest still needs full GPU access to copy the data.

To fix this, use amdgpu_device_read_fb_via_bar0() to copy
the init data from VF FB before TTM is ready.
For this early copy, the guest no longer needs full GPU access
so the full GPU access request can be moved later.

Signed-off-by: chong li <chongli2@amd.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 +--
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 610d82b79de3..ec353f4dd0d2 100644
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
@@ -1973,6 +1977,17 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 	return parent;
 }
 
+static bool amdgpu_device_delay_full_gpu_access(struct amdgpu_device *adev)
+{
+#ifdef CONFIG_X86
+	return adev->virt.req_init_data_ver > 0 &&
+		(hypervisor_is_type(X86_HYPER_VMWARE) ||
+		hypervisor_is_type(X86_HYPER_MS_HYPERV));
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_ip_early_init - run early init for hardware IPs
  *
@@ -1987,16 +2002,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
 	struct pci_dev *parent;
-	bool total, skip_bios;
+	bool total, skip_bios, delay_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
+		delay_full_gpu_access = amdgpu_device_delay_full_gpu_access(adev);
+		if (!delay_full_gpu_access) {
+			r = amdgpu_virt_request_full_gpu(adev, true);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
@@ -2159,6 +2177,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (amdgpu_sriov_vf(adev) && delay_full_gpu_access) {
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






>Re: [PATCH 2/2] drm/amdgpu: improve the amdgpu device init progress in sriov mode
>On 7/1/26 07:53, chong li wrote:
>> Move the initialization of non-GPU resources out of the full GPU 
>> access region during AMDGPU device initialization
>
>As far as I can see that won't work like this.
>
>There are a lot of steps which require full GPU access.
>
>What exactly is the justification of the change?
>
>Regards,
>Christian.
>
>> 
>> Signed-off-by: chong li <chongli2@amd.com>
>> Co-authored-by: Cursor <cursoragent@cursor.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 610d82b79de3..c2ce4659ddc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1994,10 +1994,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>  	amdgpu_device_enable_virtual_display(adev);
>>  
>>  	if (amdgpu_sriov_vf(adev)) {
>> -		r = amdgpu_virt_request_full_gpu(adev, true);
>> -		if (r)
>> -			return r;
>> -
>>  		r = amdgpu_virt_init_critical_region(adev);
>>  		if (r)
>>  			return r;
>> @@ -2159,6 +2155,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>  	if (!total)
>>  		return -ENODEV;
>>  
>> +	if (amdgpu_sriov_vf(adev)) {
>> +		r = amdgpu_virt_request_full_gpu(adev, true);
>> +		if (r)
>> +			return r;
>> +	}
>> +
>>  	if (adev->gmc.xgmi.supported)
>>  		amdgpu_xgmi_early_init(adev);
>>  

