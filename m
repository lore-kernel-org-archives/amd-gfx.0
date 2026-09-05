Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70001C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E210810E5E3;
	Sat,  5 Sep 2026 10:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ramCBGh+";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390E610E5E3
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyzNHIq1Tx5BLqFpca+4uAQ4QeNkMWAf1VErdlbxDtT2VlQPGxBnUmwsdfgIG5PNeXTAzAzf+Y8DCNHBvOEDbUTiGcav0elIWqE41sPGf74lhuRtBsJ3Xd+D/+eD2fn/AmmQN8f7T7EwnJIztcXQNvhqlfkk7zIh2++zKD2oCtdbIChhp+4M9i55PLkk0WkbTgnXf1zp31Ij9KDq5muMKnfbRshVqboBPeeQNA+9BHVZhOEapNUhceQJqebbc2Pb0xK8kTBNOyfMm1eK4fTabL+f1IxDzx/q+5Iq6Zjl6i78hBcLhBwgYE2FzaX6+K8OIc4B2hStW5SRKW2guCCzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh/ppcTw4QbwD/dy0dKmSHbSaTeuU8Fwpi67G9hxI28=;
 b=XD2Honfmarjppj7wsoSF1RuSATSr7xrIf4JKOxMj5xmKorNHzcTG07aZAKRWymU9NEIu4L6Ml6y9rf6wpr1fOJiTqq70Em6arB/7AaCcyHtSREm/6G9eb9fKeTUQzURF66QyUvr4WrThrHMU57c59AwoiWzYfbrbv3e2rlLybgz9YOb73JbXXy455Km135pTbe/Wmvealmh6Nf/JHk1b79G+90v433CvlygXrDgkaFqu0Sh5spHzuNnvpVZdg0dOO32oafPiEVqRKo2I6h+0Dt7Co4E0bCbnxwWLyD5CBaCOINXUNnPHrbCIfSN+HavNOsrwGlvZreoUkX7zR6an6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh/ppcTw4QbwD/dy0dKmSHbSaTeuU8Fwpi67G9hxI28=;
 b=ramCBGh++OGvn6z8vfejFTwz9AgMZ9DQsUW2llOE7RKx9f3o1Z0I65v1wiK3i5nHu2UCWqmdWzEcTvg4IxuKqT0+Vjwa17ipfZC5dGCuhadeoqdfDbHACSdtBxsjJgb1YZw980C8EFC4rtFDSSkA9S0e1QntXcb3KVqnfmBfaK8=
Received: from DS1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:8:44a::10)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sat, 5 Sep
 2026 10:06:22 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::2d) by DS1PR02CA0024.outlook.office365.com
 (2603:10b6:8:44a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:21 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:20 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 08/13] drm/amdgpu: Use common doorbell helpers in nbio v7_11_5
Date: Sat, 5 Sep 2026 18:05:33 +0800
Message-ID: <20260905100538.12877-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: b402b74a-4d65-4fb1-05f6-08df0b355639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6R6QqMlZ7zhEbK9laXlQ3xusTehTc1UnD419IbAdbx1kNqt48MUUeCqetToql8upr+jhVlGhdQsywKLkNdbOokLIdFSupNF/xL4nRTIh6JyZP0FgENS8RCpIPMcDnkX9VVD0JCfqCISz1RksHg1Amg6iNmjVvMw23zuxHpXYFu03yn80V/K6eCECaVqgPpFm9wQdbEm1aagu2j6tdux+h/V69cW7ZBY2QDXS4b7kvjDCgRKyOj7xL+Nk78YLvmICS5PdKOSq6Sn4M54+i3HI2Ltnjq9XQ5/3iNeMwsUivDa+ssNLCDZ6DGhCPbdZF9X00ZK5sme3uAgGBpa+dp4ubrIM+us9Owsxynqbi/D8YAiFepv7+HkIA4R8UGeOT2RPtGariLvLhtnfKxI+DcR89DcuGoEG3mDOc6PTPwjcxKXuCB2Hm2awIXHfPBpIKAGDFucP0ylUHcRfWsGgRs3t8YeO5CqrFzm5/IjWRxD7JA/iKGswUHpvWCU+cz4CtA+rhpku8j6JD59Pv6APzXlygSJTICNfbP6xsymtapJkbGbNYxQlBYq+NqsojHYYtU62D+CqnHzChRjrl+TnIgMTZ0p5j+veYUfmtfy6BKVtTUhVU6mFjZ1bUAQ/RjgtC4XvKgXQhBuTWw3KEIw1ft/C+c2xudt7/4kv5b1uHbS/e2ognhC1toq01iE27kE6WKCVrTscGHQ8/L0+7NaD+V9riA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yF3siDJG5oxZImKRLkyQnq43QeSIBQ55Q52srYm5O1l/qij86s4U7CMSU8GC/48GstwZm39nh4NtF0WJyfBhtg2DwzMtLsTR19i5xn1ZvI5HL2AgsD8Q//ZgVfHfdnYuu8QIRhBMYietAtkdVG2izB/+agysMldpqCMRdEw808lcd02nIJN6qdcYnCsHTUjc/PJZKAZxGa8iPODjXfjds85vDn3UEQ+DwRzgsfMN1mhCUqHO3Wb+8LkH/osw3KNHGQcjwI1YR51nW6iPzgl25pQV+D+3VWWIfL7n9wqBxFQOk0Bap3GMBNVJ6QVl7veyehLOm6QLiQDBrFGk4zNKh4OprHG3oxjAZoEdRtc17Jm6yVdBUKBMXwFgoM04o+910VYhatYt2KswCDh7vmUuFkJfeW7dCAwffsylphu5Ia3mfA1fCfYURQJzAYrq2HiR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:21.7150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b402b74a-4d65-4fb1-05f6-08df0b355639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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

Describe the nbio v7_11_5 S2A doorbell layout and
existing client-to-port mappings, then build and
program the CP, RLC, IH, SDMA, and VPE entries
through the common NBIO helpers.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c | 256 +++++++++++++---------
 1 file changed, 158 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
index 0ea6e091a24c..47db8f87d72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
@@ -28,6 +28,83 @@
 #include "nbio/nbio_7_11_5_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static const struct amdgpu_nbio_doorbell_layout
+nbio_v7_11_5_doorbell_layout = {
+	.ctrl = {
+		.enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_ENABLE),
+		.awid = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWID),
+		.fence_enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_FENCE_ENABLE),
+		.range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_OFFSET),
+		.range_size = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_SIZE),
+		.disable_64bit = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS),
+		.deduct_range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET),
+		.drop = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_DROP_EN),
+		.awaddr_31_28 = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE),
+	},
+};
+
+static void nbio_v7_11_5_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbio_v7_11_5_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(
+		NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL);
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP];
+	entries->num_entries = 1;
+	entries->entry[0].port = 0;
+	entries->entry[0].ctrl_reg = ctrl_base;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+	entries->num_entries = 1;
+	entries->entry[0].port = 1;
+	entries->entry[0].ctrl_reg = ctrl_base + 2;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = 1;
+	entries->entry[0].port = 2;
+	entries->entry[0].ctrl_reg = ctrl_base + 4;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC];
+	entries->num_entries = 1;
+	entries->entry[0].port = 3;
+	entries->entry[0].ctrl_reg = ctrl_base + 6;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE];
+	entries->num_entries = 1;
+	entries->entry[0].port = 5;
+	entries->entry[0].ctrl_reg = ctrl_base + 10;
+}
+
 static void nbio_v7_11_5_remap_hdp_registers(struct amdgpu_device *adev)
 {
 		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -72,42 +149,31 @@ static void nbio_v7_11_5_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
-	u32 doorbell_range;
-
-	if (instance == 0) {
-		doorbell_range = RREG32_SOC15(NBIO, 0,
-					     regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
-
-		if (use_doorbell) {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_ENABLE,
-						       0x1);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWID,
-						       0xe);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
-						       doorbell_index);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       doorbell_size);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-						       0x3);
-		} else {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       0);
-		}
-
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xe,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	if (instance != 0)
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }
 
 static void nbio_v7_11_5_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -115,48 +181,54 @@ static void nbio_v7_11_5_vpe_doorbell_range(struct amdgpu_device *adev,
 							int doorbell_index,
 							int doorbell_size)
 {
-	u32 doorbell_range;
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xf,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0xf,
+	};
+	u32 ctrl;
 
 	if (instance)
 		return;
 
-	doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
-
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWID,
-					       0xf);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       doorbell_size);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
-					       0xf);
-	} else {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       0);
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance,
+			NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance, &ctrl, NULL);
 }
 
 static void nbio_v7_11_5_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	fields.awid = 0x3;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, NULL);
+
+	fields.awid = 0x6;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC, 0, &ctrl, NULL);
 }
 
 static void nbio_v7_11_5_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -191,39 +263,25 @@ static void nbio_v7_11_5_enable_doorbell_selfring_aperture(struct amdgpu_device
 static void nbio_v7_11_5_ih_doorbell_range(struct amdgpu_device *adev,
 					 bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range;
-
-	ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_ENABLE,
-						  0x1);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWID,
-						  0x0);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
-						  doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  2);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-						  0x0);
-	} else {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  0);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 2,
+	};
+	u32 ctrl;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }
 
 static void nbio_v7_11_5_ih_control(struct amdgpu_device *adev)
@@ -310,6 +368,8 @@ static void nbio_v7_11_5_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	nbio_v7_11_5_init_doorbell_entry_registers(adev);
+
 	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
 	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
-- 
2.17.1

