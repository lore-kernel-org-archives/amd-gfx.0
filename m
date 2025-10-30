Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DD1CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 20:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8FF10EA5D;
	Thu, 30 Oct 2025 20:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dL7hgX3K";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A4710EA34
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 20:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJddAoO8MsJT+HunmeybJKgT6RNlEjuxePQWjXMz15tGR93Iydc5nP+7m2A6sjWm/uK2ml+nPtbRjdsy5qLTZ+lHZ2OQTR4pKioOEjLmSD634yNJ6U0Z/UD0PBVfiC4AKcU6ZPCcal5gA4yrV/7aAa6/HpqUDzIceGjkexyRs2k5k0LWoQ9wwDFWjui+um1Ay0q+nsAOcD6Dp4HXI8J7SH2utiqhI4YUZBaBYqzBBxSltXqg0GIWNjdlqZEtpHgfXEtXTeHSpVkr7i/Z7Z6IKXCTALzlvSmE2U0IA254a2UJRTXQWF8Pozgmc+NwqZZNE3/Fz4+VnHYZeqsff1bRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1mMVYUW6QrJkBGXp0rPASnJ+7b3c53JdgrN5O/N4xE=;
 b=bFwAxzpNZFQ4viXrE4x2FHw+po8w2nrhrbOxD2/zOQqIoxUa07Jfihlb1xKGuivFtw9UqsQc1sSv2cu3HPWh5xN5o3CBKVHdidvpyzt5ARwYEKt2TMS9a2S7PTEVVpNVey7O/4LjUcobNVURH4RgtJWZMVpdxtF+WKpGouHndE7kf9ldOXp7VKzZ6kaDfvfpMyUauEGwyWg3chuLq5uOZdTBWgn/eKruVHrvPBj4ovdT1A0qskfevv0OcBfsXafPISN3FZR2Gp/9KZVG7ptlHuyZVsR2WgGDtFT/CDmOIKer7W/t+VKdVtkrrI0H4Ck1bLZtHAdpbk/ifQJUP8WoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1mMVYUW6QrJkBGXp0rPASnJ+7b3c53JdgrN5O/N4xE=;
 b=dL7hgX3KjazRMlv9ahYSqXNQpTfVV3NOAON04OBtAPV3Tt7JOcZR38ZFPXW4sCuRqgOBKPQmGlt7NyyzTZpMqgj5z2chYMjoCHcXgPit2f22BPI90kWWCzkIJa1gtHjvBxcui7pHSYiWhddjPMO20UHC1F3HLHD9dlIX/qFzdPA=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 20:51:10 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::b4) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 20:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 20:51:09 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 13:51:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add initial support for mmhub v4_2
Date: Thu, 30 Oct 2025 16:50:51 -0400
Message-ID: <20251030205051.590971-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030205051.590971-1-alexander.deucher@amd.com>
References: <20251030205051.590971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e232b9-4ea1-4b89-dde1-08de17f60e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kcEF7PusTf7o1JLG/Q/S8CwxIWih5H3EXJ7Y4G/K0R2ddpF12Zi9BfwWOffn?=
 =?us-ascii?Q?K4d8iUd7PEMb81J+HR3Ghb9DHlqIXKm4mmUaDCsw7LLZBosugwsvY2IIyRVg?=
 =?us-ascii?Q?fTy5b8gMmfZzsharL0pvPPhGeDjp/6NxKto0bbJpPQLPtTw300i+VlSSSpPz?=
 =?us-ascii?Q?gJLD0TLUkUqFWg7iGy/vwN12eta3gOIZBPwLBngy6UOq5K1cFLMwB6pVn4dD?=
 =?us-ascii?Q?KrXe0EaqfYatC9IDcAOeusiRpmZ90DT4ZOedqMCKFDtL8c3IkYb21/EqV3TO?=
 =?us-ascii?Q?8ADlZ/1It1IMIdI6bCFqys4H1O3EhJPWo8jdA+e02t30cHrlOHnTYN6YUooP?=
 =?us-ascii?Q?wLfODsf7eDYZrip+ABKGLk2G3gh8gNOgfs0vZukU+hI76zZLEDsILjL7PV4k?=
 =?us-ascii?Q?B6VB+vtCtSAPej0laxJG4cfxDlAO5RC8tRPnmNWRg2uq8KJQyBWtAKs5+/EW?=
 =?us-ascii?Q?AjKdBQLibGgxy71MYeU9MloH0HWkdW2hunEvt9X5EzMg1h4QbdEelfEtCA2A?=
 =?us-ascii?Q?JYgmdoJo/GRXLtSGJQVpEuR21qHy/NsniatEjxL6tbXaUOGk0vjMExLfuQaP?=
 =?us-ascii?Q?hdxq5JvSvPpe7gWBiWTMDkRO7NNG2HBfNRjZI2asnALvee+vAG1gLjveCNKR?=
 =?us-ascii?Q?sSZhbxJkcQkwACPuJPcIX0/B7ywDQ7D3CarVR591RaeGPD6yeMdpbx8tClQ9?=
 =?us-ascii?Q?U7EpnPQ6jAFTkyygb24XTpAqCjgAWoxMFavUPhXKYOWzLqUzNToQuLAxqZge?=
 =?us-ascii?Q?a/5JuGTuV11zU+A5spB3qPKMHcoFy45uQ6QZrkjBlYx91OSulvKtDQLpA4zq?=
 =?us-ascii?Q?vbqc+ro3mJiifYqcCAgByfGWGxLxdpHAD/ZCTpcTI4s6GzhhOSNrqqb9+319?=
 =?us-ascii?Q?VrzmOjKdgm/nneyqUQauuQMGTE3wP5By7KUz2X8Ak1F8Fu33leNFcwQFaevx?=
 =?us-ascii?Q?oKIX/oLjCOUV+oQycj2jjKi9pVb1Tvk51MFy9wa3AFs8nzprurrRuQTA0t5u?=
 =?us-ascii?Q?ulKu/AiZpPMXgh2OTTq5S6JbNJ0vPSCFaFwnU6YjmLFhR2k0nRgGQkIWCXzR?=
 =?us-ascii?Q?tUNmAAToZKwUXi2xcxtC0vEIpG5HBQpROy3i6K/v3ULfZZjHYKegRi/H+L8t?=
 =?us-ascii?Q?aBtWmXAKD1Ag7MVAnMZYEO8RnhOad+yu0fhjg7++rEI6jPjiKstNrMsOA2wJ?=
 =?us-ascii?Q?3ItY6DyKnhNkb5ppOGPlPahrNKGmC/QdiSx85nwpZe/XtPq7x5hxcHR2QjhC?=
 =?us-ascii?Q?2QWXokt5p/dGhbLZ1KkK+gT0EiFETS3Hv6D0Z6y4Rf/d2BCgxSCHUJO21A3o?=
 =?us-ascii?Q?wlq7lnXHwMmcWvVn7CjMpmKAcpx6KEJgZx89LulqB1re1Pk1oQQ6RBoLU3Fo?=
 =?us-ascii?Q?mqveF7ktSfRqqp28E/jgnsk5dwm/+Ks5ecHZBcEEMj+7seMkK7PpsF1n4Hxj?=
 =?us-ascii?Q?fIfEuFK4rEr5coKVq2bgcreqvaFQ21yyV3XH+2xuxDVrHCvp3LlBfNr0ayA/?=
 =?us-ascii?Q?R+HMRLPPhd+LzNZEsoCeKXVbr5dHoLTfSyKbmqs5fnxogFlJkCjC+1OD3USS?=
 =?us-ascii?Q?hx9GAb9c1gkwSzEPa6A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 20:51:09.7888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e232b9-4ea1-4b89-dde1-08de17f60e1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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

From: Likun Gao <Likun.Gao@amd.com>

Add initial support for mmhub v4_2_0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 915 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h |  28 +
 3 files changed, 945 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 1fc75f46b4273..ad9ec94fcb088 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -104,7 +104,8 @@ amdgpu-y += \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
 	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o \
-	gfxhub_v11_5_0.o mmhub_v4_1_0.o gfxhub_v12_0.o gmc_v12_0.o
+	gfxhub_v11_5_0.o mmhub_v4_1_0.o gfxhub_v12_0.o gmc_v12_0.o \
+	mmhub_v4_2_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
new file mode 100644
index 0000000000000..5e1d5e986f191
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -0,0 +1,915 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "mmhub_v4_2_0.h"
+
+#include "mmhub/mmhub_4_2_0_offset.h"
+#include "mmhub/mmhub_4_2_0_sh_mask.h"
+
+#include "soc15_common.h"
+#include "soc24_enum.h"
+
+#define regMMVM_L2_CNTL3_DEFAULT				0x80100007
+#define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
+#define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+
+#define MMHUB_NUM_MID						1
+
+static const char *mmhub_client_ids_v4_2_0[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[5][0] = "DCEVGA",
+	[6][0] = "MP0",
+	[7][0] = "MP1",
+	[8][0] = "MPIO",
+	[16][0] = "HDP",
+	[17][0] = "LSDMA",
+	[18][0] = "JPEG",
+	[19][0] = "VCNU0",
+	[21][0] = "VSCH",
+	[22][0] = "VCNU1",
+	[23][0] = "VCN1",
+	[32+20][0] = "VCN0",
+	[2][1] = "DBGUNBIO",
+	[3][1] = "DCEDWB",
+	[4][1] = "DCEDMC",
+	[5][1] = "DCEVGA",
+	[6][1] = "MP0",
+	[7][1] = "MP1",
+	[8][1] = "MPIO",
+	[10][1] = "DBGU0",
+	[11][1] = "DBGU1",
+	[12][1] = "DBGU2",
+	[13][1] = "DBGU3",
+	[14][1] = "XDP",
+	[15][1] = "OSSSYS",
+	[16][1] = "HDP",
+	[17][1] = "LSDMA",
+	[18][1] = "JPEG",
+	[19][1] = "VCNU0",
+	[20][1] = "VCN0",
+	[21][1] = "VSCH",
+	[22][1] = "VCNU1",
+	[23][1] = "VCN1",
+};
+
+static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base;
+
+	base = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+			    regMMMC_VM_FB_LOCATION_BASE_LO32);
+	base &= MMMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
+	base <<= 24;
+
+	base |= ((MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
+		  RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+			       regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
+
+	return base;
+}
+
+static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+			         regMMMC_VM_FB_OFFSET) << 24;
+}
+
+static void mmhub_v4_2_0_mid_setup_vm_pt_regs(struct amdgpu_device *adev,
+					      uint32_t vmid,
+					      uint64_t page_table_base,
+					      uint32_t mid_mask)
+{
+	struct amdgpu_vmhub *hub;
+	int i;
+
+	for_each_inst(i, mid_mask) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
+		WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, i),
+				    regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+				    hub->ctx_addr_distance * vmid,
+				    lower_32_bits(page_table_base));
+
+		WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, i),
+				    regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+				    hub->ctx_addr_distance * vmid,
+				    upper_32_bits(page_table_base));
+	}
+}
+
+static void mmhub_v4_2_0_setup_vm_pt_regs(struct amdgpu_device *adev,
+					  uint32_t vmid,
+					  uint64_t page_table_base)
+{
+	uint32_t mid_mask;
+
+	mid_mask = GENMASK(MMHUB_NUM_MID - 1, 0);
+	mmhub_v4_2_0_mid_setup_vm_pt_regs(adev, vmid,
+					  page_table_base,
+					  mid_mask);
+}
+
+static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device *adev,
+						     uint32_t mid_mask)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	int i;
+
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v4_2_0_mid_setup_vm_pt_regs(adev, 0, pt_base, mid_mask);
+
+	for_each_inst(i, mid_mask) {
+		if (adev->gmc.pdb0_bo) {
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.fb_start >> 12));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.fb_start >> 44));
+
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.fb_end >> 12));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.fb_end >> 44));
+		} else {
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				     (u32)(adev->gmc.gart_start >> 12));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				     (u32)(adev->gmc.gart_start >> 44));
+
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				     (u32)(adev->gmc.gart_end >> 12));
+			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				     (u32)(adev->gmc.gart_end >> 44));
+		}
+	}
+}
+
+static void mmhub_v4_2_0_mid_init_system_aperture_regs(struct amdgpu_device *adev,
+						       uint32_t mid_mask)
+{
+	uint64_t value;
+	uint32_t tmp;
+	int i;
+
+	/*
+	 * the new L1 policy will block SRIOV guest from writing
+	 * these regs, and they will be programed at host.
+	 * so skip programing these regs.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for_each_inst(i, mid_mask) {
+		/* Program the AGP BAR */
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BASE_LO32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BASE_HI32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BOT_LO32,
+			     lower_32_bits(adev->gmc.agp_start >> 24));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BOT_HI32,
+			     upper_32_bits(adev->gmc.agp_start >> 24));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_TOP_LO32,
+			     lower_32_bits(adev->gmc.agp_end >> 24));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_TOP_HI32,
+			     upper_32_bits(adev->gmc.agp_end >> 24));
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+			     lower_32_bits(min(adev->gmc.fb_start,
+					       adev->gmc.agp_start) >> 18));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+			     upper_32_bits(min(adev->gmc.fb_start,
+					       adev->gmc.agp_start) >> 18));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
+			     lower_32_bits(max(adev->gmc.fb_end,
+					       adev->gmc.agp_end) >> 18));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
+			     upper_32_bits(max(adev->gmc.fb_end,
+					       adev->gmc.agp_end) >> 18));
+
+		/* Set default page address. */
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			     (u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			     (u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				   regMMVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
+
+	/* In the case squeezing vram into GART aperture, we don't use
+	 * FB aperture and AGP aperture. Disable them.
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_FB_LOCATION_BASE_LO32, 0xFFFFFFFF);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_TOP_LO32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_TOP_HI32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BOT_LO32, 0xFFFFFFFF);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_AGP_BOT_HI32, 1);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+			     0xFFFFFFFF);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+			     0x7F);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
+	}
+}
+
+static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
+					   uint32_t mid_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, mid_mask) {
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				   regMMMC_VM_MX_L1_TLB_CNTL);
+
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+				    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+				    MTYPE, MTYPE_UC); /* UC, uncached */
+
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMMC_VM_MX_L1_TLB_CNTL, tmp);
+	}
+}
+
+static void mmhub_v4_2_0_mid_init_cache_regs(struct amdgpu_device *adev,
+					     uint32_t mid_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for_each_inst(i, mid_mask) {
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+				    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
+		/* XXX for emulation, Refer to closed source code.*/
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+				    L2_PDE0_CACHE_TAG_GENERATION_MODE, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+				    PDE_FAULT_CLASSIFICATION, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+				    CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+				    IDENTITY_MODE_FRAGMENT_SIZE, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL, tmp);
+
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL2);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2,
+				    INVALIDATE_ALL_L1_TLBS, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2,
+				    INVALIDATE_L2_CACHE, 1);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL2, tmp);
+
+		tmp = regMMVM_L2_CNTL3_DEFAULT;
+		if (adev->gmc.translate_further) {
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+		} else {
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 9);
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+					    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+		}
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL3, tmp);
+
+		tmp = regMMVM_L2_CNTL4_DEFAULT;
+		/* For AMD APP APUs setup WC memory */
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+		} else {
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4,
+					    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4,
+					    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+		}
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL4, tmp);
+
+		tmp = regMMVM_L2_CNTL5_DEFAULT;
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5,
+				    L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_CNTL5, tmp);
+	}
+}
+
+static void mmhub_v4_2_0_mid_enable_system_domain(struct amdgpu_device *adev,
+						  uint32_t mid_mask)
+{
+	uint32_t tmp;
+	int i;
+
+	for_each_inst(i, mid_mask) {
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				   regMMVM_CONTEXT0_CNTL);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+				    ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+				    PAGE_TABLE_DEPTH, 0);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_CONTEXT0_CNTL, tmp);
+	}
+}
+
+static void mmhub_v4_2_0_mid_disable_identity_aperture(struct amdgpu_device *adev,
+						       uint32_t mid_mask)
+{
+	int i;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for_each_inst(i, mid_mask) {
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+			     0xFFFFFFFF);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+			     0x00001FFF);
+
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+			     0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+			     0);
+
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32,
+			     0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32,
+			     0);
+	}
+}
+
+static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
+					       uint32_t mid_mask)
+{
+	struct amdgpu_vmhub *hub;
+	uint32_t tmp;
+	int i, j;
+
+	for_each_inst(j, mid_mask) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+		for (i = 0; i <= 14; i++) {
+			tmp = RREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
+					          regMMVM_CONTEXT1_CNTL,
+						  i * hub->ctx_distance);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+					    adev->vm_manager.num_level);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
+					    1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    PAGE_TABLE_BLOCK_SIZE,
+					    adev->vm_manager.block_size - 9);
+			/* Send no-retry XNACK on fault to suppress VM fault storm. */
+			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+					    !amdgpu_noretry);
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_CNTL,
+					    i * hub->ctx_distance, tmp);
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+					    i * hub->ctx_addr_distance, 0);
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+					    i * hub->ctx_addr_distance,
+					    lower_32_bits(adev->vm_manager.max_pfn - 1));
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+					    i * hub->ctx_addr_distance,
+					    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		}
+	}
+
+	hub->vm_cntx_cntl = tmp;
+}
+
+static void mmhub_v4_2_0_mid_program_invalidation(struct amdgpu_device *adev,
+						  uint32_t mid_mask)
+{
+	struct amdgpu_vmhub *hub;
+	unsigned int i, j;
+
+	for_each_inst(j, mid_mask) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+
+		for (i = 0; i < 18; ++i) {
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
+					    regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+					    i * hub->eng_addr_distance, 0xffffffff);
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
+					    regMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+					    i * hub->eng_addr_distance, 0x3fff);
+		}
+	}
+}
+
+static int mmhub_v4_2_0_mid_gart_enable(struct amdgpu_device *adev,
+					uint32_t mid_mask)
+{
+	/* GART Enable. */
+	mmhub_v4_2_0_mid_init_gart_aperture_regs(adev, mid_mask);
+	mmhub_v4_2_0_mid_init_system_aperture_regs(adev, mid_mask);
+	mmhub_v4_2_0_mid_init_tlb_regs(adev, mid_mask);
+	mmhub_v4_2_0_mid_init_cache_regs(adev, mid_mask);
+
+	mmhub_v4_2_0_mid_enable_system_domain(adev, mid_mask);
+	mmhub_v4_2_0_mid_disable_identity_aperture(adev, mid_mask);
+	mmhub_v4_2_0_mid_setup_vmid_config(adev, mid_mask);
+	mmhub_v4_2_0_mid_program_invalidation(adev, mid_mask);
+
+	return 0;
+}
+static int mmhub_v4_2_0_gart_enable(struct amdgpu_device *adev)
+{
+	uint32_t mid_mask;
+
+	mid_mask = GENMASK(MMHUB_NUM_MID - 1, 0);
+	return mmhub_v4_2_0_mid_gart_enable(adev, mid_mask);
+}
+
+static void mmhub_v4_2_0_mid_gart_disable(struct amdgpu_device *adev,
+					  uint32_t mid_mask)
+{
+	struct amdgpu_vmhub *hub;
+	u32 tmp;
+	u32 i, j;
+
+	for_each_inst(j, mid_mask) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
+		/* Disable all tables */
+		for (i = 0; i < 16; i++)
+			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j),
+					    regMMVM_CONTEXT0_CNTL,
+					    i * hub->ctx_distance, 0);
+
+		/* Setup TLB control */
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, j),
+				   regMMMC_VM_MX_L1_TLB_CNTL);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_L1_TLB, 0);
+		tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+				    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j),
+			     regMMMC_VM_MX_L1_TLB_CNTL, tmp);
+
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL, tmp);
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, j), regMMVM_L2_CNTL3, 0);
+	}
+}
+
+static void mmhub_v4_2_0_gart_disable(struct amdgpu_device *adev)
+{
+	uint32_t mid_mask;
+
+	mid_mask = GENMASK(MMHUB_NUM_MID - 1, 0);
+	mmhub_v4_2_0_mid_gart_disable(adev, mid_mask);
+}
+
+static void
+mmhub_v4_2_0_mid_set_fault_enable_default(struct amdgpu_device *adev,
+					  bool value, uint32_t mid_mask)
+{
+	u32 tmp;
+	int i;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for_each_inst(i, mid_mask) {
+		tmp = RREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+				   regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+				    value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+		if (!value) {
+			tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+					    CRASH_ON_NO_RETRY_FAULT, 1);
+		}
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+			     regMMVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
+	}
+}
+
+
+/**
+ * mmhub_v4_2_0_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void
+mmhub_v4_2_0_set_fault_enable_default(struct amdgpu_device *adev,
+				      bool value)
+{
+	uint32_t mid_mask;
+
+	mid_mask = GENMASK(MMHUB_NUM_MID - 1, 0);
+	mmhub_v4_2_0_mid_set_fault_enable_default(adev, value, mid_mask);
+}
+
+static uint32_t mmhub_v4_2_0_get_invalidate_req(unsigned int vmid,
+						uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	/* Only use legacy inv on mmhub side */
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, 0);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+/*TODO: l2 protection fault status is increased to 64bits.
+ * some critical fields like FED are moved to STATUS_HI32 */
+static void
+mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					      uint32_t status)
+{
+	uint32_t cid, rw;
+	const char *mmhub_cid = NULL;
+
+	cid = REG_GET_FIELD(status,
+			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
+	rw = REG_GET_FIELD(status,
+			   MMVM_L2_PROTECTION_FAULT_STATUS_LO32, RW);
+
+	dev_err(adev->dev,
+		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
+		status);
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+	case IP_VERSION(4, 2, 0):
+		mmhub_cid = mmhub_client_ids_v4_2_0[cid][rw];
+		break;
+	default:
+		mmhub_cid = NULL;
+		break;
+	}
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		mmhub_cid ? mmhub_cid : "unknown", cid);
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+}
+
+
+static const struct amdgpu_vmhub_funcs mmhub_v4_2_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v4_2_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v4_2_0_get_invalidate_req,
+};
+
+static void mmhub_v4_2_0_mid_init(struct amdgpu_device *adev,
+				  uint32_t mid_mask)
+{
+	struct amdgpu_vmhub *hub;
+	int i;
+
+	for_each_inst(i, mid_mask) {
+		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
+
+		hub->ctx0_ptb_addr_lo32 =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+		hub->ctx0_ptb_addr_hi32 =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+		hub->vm_inv_eng0_sem =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_INVALIDATE_ENG0_SEM);
+		hub->vm_inv_eng0_req =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_INVALIDATE_ENG0_REQ);
+		hub->vm_inv_eng0_ack =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_INVALIDATE_ENG0_ACK);
+		hub->vm_context0_cntl =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_CONTEXT0_CNTL);
+		/* TODO: add a new member to accomandate additional fault status/cntl reg */
+		hub->vm_l2_pro_fault_status =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_L2_PROTECTION_FAULT_STATUS_LO32);
+		hub->vm_l2_pro_fault_cntl =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
+
+		hub->ctx_distance = regMMVM_CONTEXT1_CNTL - regMMVM_CONTEXT0_CNTL;
+		hub->ctx_addr_distance = regMMVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+					 regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+		hub->eng_distance = regMMVM_INVALIDATE_ENG1_REQ -
+				    regMMVM_INVALIDATE_ENG0_REQ;
+		hub->eng_addr_distance = regMMVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+					 regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+		hub->vm_cntx_cntl_vm_fault = MMVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+			MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+		hub->vm_l2_bank_select_reserved_cid2 =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i), regMMVM_L2_BANK_SELECT_RESERVED_CID2);
+
+		hub->vm_contexts_disable =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i), regMMVM_CONTEXTS_DISABLE);
+
+		hub->vmhub_funcs = &mmhub_v4_2_0_vmhub_funcs;
+	}
+}
+
+static void mmhub_v4_2_0_init(struct amdgpu_device *adev)
+{
+	uint32_t mid_mask;
+
+	mid_mask = GENMASK(MMHUB_NUM_MID - 1, 0);
+	mmhub_v4_2_0_mid_init(adev, mid_mask);
+}
+
+static void
+mmhub_v4_2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	uint32_t def, data;
+	uint32_t def1, data1, def2 = 0, data2 = 0;
+	def  = data  = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMM_ATC_L2_MISC_CG);
+	def1 = data1 = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regDAGB0_CNTL_MISC2);
+	def2 = data2 = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regDAGB1_CNTL_MISC2);
+
+	if (enable) {
+		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
+		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+
+		data2 &= ~(DAGB1_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			   DAGB1_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+	} else {
+		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
+		data1 |= (DAGB0_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+
+		data2 |= (DAGB1_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			  DAGB1_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMM_ATC_L2_MISC_CG, data);
+	if (def1 != data1)
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regDAGB0_CNTL_MISC2, data1);
+
+	if (def2 != data2)
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regDAGB1_CNTL_MISC2, data2);
+}
+
+static void
+mmhub_v4_2_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					     bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMM_ATC_L2_MISC_CG, data);
+}
+
+static int mmhub_v4_2_0_set_clockgating(struct amdgpu_device *adev,
+					enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)
+		mmhub_v4_2_0_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)
+		mmhub_v4_2_0_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE);
+
+	return 0;
+}
+
+static void mmhub_v4_2_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	int data;
+
+	if (amdgpu_sriov_vf(adev))
+		*flags = 0;
+
+	data = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMM_ATC_L2_MISC_CG);
+
+	/* AMD_CG_SUPPORT_MC_MGCG */
+	if (data & MM_ATC_L2_MISC_CG__ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+
+	/* AMD_CG_SUPPORT_MC_LS */
+	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_LS;
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v4_2_0_funcs = {
+	.init = mmhub_v4_2_0_init,
+	.get_fb_location = mmhub_v4_2_0_get_fb_location,
+	.get_mc_fb_offset = mmhub_v4_2_0_get_mc_fb_offset,
+	.setup_vm_pt_regs = mmhub_v4_2_0_setup_vm_pt_regs,
+	.gart_enable = mmhub_v4_2_0_gart_enable,
+	.gart_disable = mmhub_v4_2_0_gart_disable,
+	.set_fault_enable_default = mmhub_v4_2_0_set_fault_enable_default,
+	.set_clockgating = mmhub_v4_2_0_set_clockgating,
+	.get_clockgating = mmhub_v4_2_0_get_clockgating,
+};
+
+static int mmhub_v4_2_0_xcp_resume(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool value;
+
+	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
+		value = false;
+	else
+		value = true;
+
+	mmhub_v4_2_0_mid_set_fault_enable_default(adev, value, inst_mask);
+
+	if (!amdgpu_sriov_vf(adev))
+		return mmhub_v4_2_0_mid_gart_enable(adev, inst_mask);
+
+	return 0;
+}
+
+static int mmhub_v4_2_0_xcp_suspend(void *handle, uint32_t inst_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!amdgpu_sriov_vf(adev))
+		mmhub_v4_2_0_mid_gart_disable(adev, inst_mask);
+
+	return 0;
+}
+
+struct amdgpu_xcp_ip_funcs mmhub_v4_2_0_xcp_funcs = {
+	.suspend = &mmhub_v4_2_0_xcp_suspend,
+	.resume = &mmhub_v4_2_0_xcp_resume
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h
new file mode 100644
index 0000000000000..4ea6de7ac7ae7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __MMHUB_V4_2_0_H__
+#define __MMHUB_V4_2_0_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v4_2_0_funcs;
+
+#endif
-- 
2.51.1

