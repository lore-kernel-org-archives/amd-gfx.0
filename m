Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B3D116E5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66F010E9EC;
	Fri, 25 Oct 2024 02:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0e6ubJT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483CD10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W39WCTUG/6ICBp6SX+POuSpUrEROruwAlPdNsOp1XYIAHyl6mXijutT+O90ajlJUcaOO+PkyDwK/BX/zMeui0t9nKB2edxsGN5GS62Lh9n3xNXzfvfo91S1I8S/mzEnZ+sCc3Hhnsunbytg3g4ytOgDkrRfbu7gqF+H0X3AkXq+GHhkdPEHVcIXo6IEisP2T1L8sqzHW2z3pxLi97mJ/Q17Yo3Tb/oj8VXAaN6ZnaAHAQfylfrQRLcudQ35ZukhriRq+7M/qIH+s5bpjJ27QXIuHz9T1S/h4i9DgKwQ4q3c2echY1Vc9b6SMxslNHwWQh7wW6r5r2ci+XviZ3RklEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr4MnYRjwitYzOcnLMh5JN7HC55GiGl+eVnLrWkKEVw=;
 b=I9XQ0FEjD1hHMSvcEo3cM0r+cVRb2X9QOtXn0+zTIQABDWPrPVIPE9DiU2BZtqfKF/Bl1mFV3ntPen4it03+DHz8MMa6nTb+pJ1HlyakCz8jnsxcRAQJoW5jCuHeuTdqPiANVvOu0rTLG92e2oAHs3UZQYVkIGoNJ2IeNae7rzGe8LB9Vi4LSPIJ+UEArCyzJSqbKo+jPe1Vao46dl9PX9kMRAbjspRtTakDUE+XW6TXGCM5N4/ZG5k41qQjUTqgBj1zSxWkaZMEyUyk98msmnvsQxR0irpPFPUVrL/wRF7WDTvCN/9/BYDvnIdfM8r2nb38MDYHlvU/YIvXnFpsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr4MnYRjwitYzOcnLMh5JN7HC55GiGl+eVnLrWkKEVw=;
 b=d0e6ubJTF7pHXytc7WN1+jMLpMxXHk3UNoz0zbIdG3YGCMe7H4SMeKLppsqZkLJGJIoNL4wBxMO9DxTOJSt0NrNgTepcUlpcCA/dC7CHCWuC+aQhJM3R27v7ORV3itrNl9XhXuN+wrCKP0TiRZQmVdG3gWUGzW/ZahIGf1pklyE=
Received: from DM6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:5:15b::16)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:25 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::30) by DM6PR18CA0003.outlook.office365.com
 (2603:10b6:5:15b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:20 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 25/29] drm/amdgpu: resume for each vcn instance
Date: Thu, 24 Oct 2024 22:35:41 -0400
Message-ID: <20241025023545.465886-26-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: da17bb23-d81f-47f4-17fa-08dcf49dd1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQKqHMOtmuCX26GN0x6uhjBcIe7/2+0MGO9QK7PielExYwVDj5pUqrrmPByl?=
 =?us-ascii?Q?D3tmFB8tS6we+TiyjP53NOBiruenILr3rtKwnBMbGKzXved6mMHCc4WXYCH+?=
 =?us-ascii?Q?6aVgudUedXvjSZ+NrlFjwKTXdxBOiJ6kzrA6mEmqcNWwtFMLfW6XMT18Nm1d?=
 =?us-ascii?Q?NRCmJko5cO5XA6JqPvteD0ovp134s4EFhEU0CDF2BgZwwfXrXcmJcqVVe/GW?=
 =?us-ascii?Q?CRMod72j9KkyWI3fl3uF5414TtAhBd4LRWd7eQx0Tzcw9wx/5/760rU+1Ira?=
 =?us-ascii?Q?/7czONTdpD27i4Gss5cxp6G/7R0G+xmGLABPY+jZDLqAI20Yxj5JHv7HjbJf?=
 =?us-ascii?Q?aQPP0ApMAI8zwqxH+4+6qf1Unr8bMlw9vBNXkbA0B94d4zuw0LgfmZPIWs4A?=
 =?us-ascii?Q?eM80KibUzPlNcszzy+1CFT/9aZmVZR93Fhd8VjDn758j57V2pqH7ulhF5nk/?=
 =?us-ascii?Q?v+3Yknay9cRlv5heZoLlwLqFIKhrEUJnVNoF75laZxNTGYQUMY3xFfYzKhUU?=
 =?us-ascii?Q?GAIWHs0qXzM2NCEeJu0eATuVycHuraHzHNciLDFhvrbFnd24baQWW5YaLQ0v?=
 =?us-ascii?Q?Pr7cPRLZItLVkuYCdU/FWBD+8blW2O/bPRDQMujWPDpN8yehetKvzXgp3aGK?=
 =?us-ascii?Q?TNA0uVKRkaJnPLXAjihSpqexwoAFIQ80sXje6Ttkw+4MkVLYK1G1Jzq4HkHl?=
 =?us-ascii?Q?+7LwoRnJsx+QCZWdFBFl6aYB8+ml9HkdBXkyd+qrhBYdrRxfZqUjxwWHPnPU?=
 =?us-ascii?Q?8sn3Ppmbfl2FNfHm2gwj20Z63bA7GEwkJVXj7hEgEyB2c26AldaTQj2ph7NB?=
 =?us-ascii?Q?t8yviEQm96ybhYr/q/v47cRhYR+UUYcOsJPbPWlSO/x3fd0dIDykVZFZ+Hsr?=
 =?us-ascii?Q?QywbN0+PNitYSh0QB4thLYMs/Qrk4dIopUM22FEqq13bZGzk/Ks9DECTOUO6?=
 =?us-ascii?Q?KyuINTgpY11exYAPwZ9pVthdRCCBShCv1c/9NGeR2z+MgwwJqdFlp5qrQ+30?=
 =?us-ascii?Q?+p2V0LcZpPU5LxjJzJbv3sTBLTYTFtqR1a1ONky71OL2liFkeJGoLY9nfUvL?=
 =?us-ascii?Q?feGnNkLc6CN6kos1AxL4VIjMIlWNqlUOW7Ld/JJRKnHFdfRFGbBST5J2btI6?=
 =?us-ascii?Q?u5+bpUMd9P9zkTYD99M/UG1/8ddO6c/05gkbVNrKblTKiTnybivjgjA7BOmu?=
 =?us-ascii?Q?GvAmi088L4+Wrg4xd7C9ZRlPpsJ3VDzf4SaZW5ie/tuprUmx2IED6rKMZ+34?=
 =?us-ascii?Q?IymLIkc6pAHkCfCGCivZuQ6c0fksSKXZ6qd97r31GAGl93GBtQCViVjMaPaS?=
 =?us-ascii?Q?aNGjT/yx2WcCgdy2OQga5aSmv0aeAN+f76zj/5Fd5NrG9Fdsx9FGQfqYmjUe?=
 =?us-ascii?Q?GoyR0HtpP4PCcPOIPGSmtMZmZ9UhhftFtCK6uLUJTzNKO0YQhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:24.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da17bb23-d81f-47f4-17fa-08dcf49dd1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_resume(), and perform
resume ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 60 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 +-
 10 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 50047c636904..c4e1283aa9a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -335,47 +335,47 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 	return amdgpu_vcn_save_vcpu_bo(adev, inst);
 }
 
-int amdgpu_vcn_resume(struct amdgpu_device *adev)
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return -EINVAL;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return -EINVAL;
+
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].saved_bo != NULL) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_toio(ptr, adev->vcn.inst[inst].saved_bo, size);
+			drm_dev_exit(idx);
+		}
+		kvfree(adev->vcn.inst[inst].saved_bo);
+		adev->vcn.inst[inst].saved_bo = NULL;
+	} else {
+		const struct common_firmware_header *hdr;
+		unsigned int offset;
 
-		if (adev->vcn.inst[i].saved_bo != NULL) {
+		hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
+				memcpy_toio(adev->vcn.inst[inst].cpu_addr,
+						adev->vcn.inst[inst].fw->data + offset,
+						le32_to_cpu(hdr->ucode_size_bytes));
 				drm_dev_exit(idx);
 			}
-			kvfree(adev->vcn.inst[i].saved_bo);
-			adev->vcn.inst[i].saved_bo = NULL;
-		} else {
-			const struct common_firmware_header *hdr;
-			unsigned int offset;
-
-			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
-			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-					memcpy_toio(adev->vcn.inst[i].cpu_addr,
-						    adev->vcn.inst[i].fw->data + offset,
-						    le32_to_cpu(hdr->ucode_size_bytes));
-					drm_dev_exit(idx);
-				}
-				size -= le32_to_cpu(hdr->ucode_size_bytes);
-				ptr += le32_to_cpu(hdr->ucode_size_bytes);
-			}
-			memset_io(ptr, 0, size);
+			size -= le32_to_cpu(hdr->ucode_size_bytes);
+			ptr += le32_to_cpu(hdr->ucode_size_bytes);
 		}
+		memset_io(ptr, 0, size);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index be681bcab184..75cfdb770672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -487,7 +487,7 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_resume(struct amdgpu_device *adev);
+int amdgpu_vcn_resume(struct amdgpu_device *adev, int inst);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a3845e7747b0..77f9f34eaca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -156,7 +156,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -331,7 +331,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8e943d1fae17..87293bb777d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -161,7 +161,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -359,7 +359,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9ca07e56b052..62266db72531 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -191,7 +191,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -436,7 +436,7 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a25d2b9784be..d29c49d061d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -174,7 +174,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -468,7 +468,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fcf7b23cca90..509dc6b5f43b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -182,7 +182,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -396,7 +396,7 @@ static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ece9b1df2743..070cf516f365 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -139,7 +139,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -355,7 +355,7 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f1ec632a9eb8..ad9e67d9134d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -144,7 +144,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -347,7 +347,7 @@ static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index fdfb3084d54e..9999c8094920 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -128,7 +128,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vcn_setup_ucode(adev);
 
-	r = amdgpu_vcn_resume(adev);
+	r = amdgpu_vcn_resume(adev, inst);
 	if (r)
 		return r;
 
@@ -311,7 +311,7 @@ static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_vcn_resume(ip_block->adev);
+	r = amdgpu_vcn_resume(ip_block->adev, ip_block->instance);
 	if (r)
 		return r;
 
-- 
2.34.1

