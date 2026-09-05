Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B28C624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5507010E5D4;
	Sat,  5 Sep 2026 10:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1/dyKXbW";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4905A10E5D4
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLktt1UlUvh3RI/bRB3ZzPmllz1U1UhslxtTD61qIQL4yzYY9/W0lbMjruqrQMPOnwPiACaRYmOwmq4fos+7QPsZEFi82hCT58tULN28jKGvpxV00jilqHP37QW3c4e1JGxKNQ2QYGeALlGg8hk3xLMy/Y06xWK4Ak2KLkcPjZqUQlK2DtHK3PaFtFxMx2jwIV4Ad0v8UeDjTZ12SS+xsYBuJSSZvrj4pPlRpRMcsJamN89H201JMVkpFVvwFHQpr/3vWP1WcSi2YZLL6aowM910DLCXZb5esQ/8ubix2WRWyVKtBWVrR88fg9Un5ggbySu6bljVc4z/gkPIBjADNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X45aGi1ZhhNxvayRFVyCK10x2jgM4rFauPy5XfOsvMQ=;
 b=FgL4UNZwv6niMCsc/yQIx77tQsy3KsJKfUWpjb+xQGFbm7aJ1WWow07m89yJ5mHvl9/aqX3NqEoFF5c1zYC9oxifsyIiZhjglLKKcq/MEiH6GrMRu6ZOUbq+FGPw3rY78ojsKo+tQZfeGukMz/UQCqWKc+vdYnRqxb6rACLi6BFqQaemRHxAADwMU2X3tQVU7Kvs07d2LLt+4XB2SIwAJJwRXUSBUqZ3ojrJKrBLfrUbmCe+FgLBhfK+NqZTGGwrrei4Qm9e67h5/tWmjt8nGQFZZ9TyRah4o0TakVpCBOIK9gK8HEJmlKD9Q8N2s6sYJWK3mOjSY0iXudrlssgHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X45aGi1ZhhNxvayRFVyCK10x2jgM4rFauPy5XfOsvMQ=;
 b=1/dyKXbWs5rn3g2x5oc0MvsoSLPMszqyYPGe2chRPneWyl1+wX51UGnxS8KQOGM8MBCrTHSNgJzAcfRe1peowS9oGKS0iKgXio0pz+GCzupXNCW+YzMVOa2sa+WKbZNrMy0RxaMNZt6jMsEgxhNjE8ddxdvJaiN74y466UfCQtM=
Received: from CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::20)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 10:06:04 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::6b) by CH5P223CA0011.outlook.office365.com
 (2603:10b6:610:1f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:03 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:02 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 02/13] drm/amdgpu: Add nbio v6_3_2 doorbell layout
Date: Sat, 5 Sep 2026 18:05:27 +0800
Message-ID: <20260905100538.12877-3-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b32ea2-cc62-49e0-0244-08df0b354b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|3023799007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: iI9+K+YonjBOnwJQn+HF0YmftuNCYB3YoFGQVR5G5woTdA7hef5GyDUGFqj5BU3LYhvYLimaJhxVGiNaXWDzidrTahMbBw8s3kr0qDZdrnkOm0iQ7HzfQRi5bVfyfzEZ/TtAXKB0vDaeeJJgggC3lD/9mv2bvRWNEfbue+lESyHNtAZ6X6KKoW0Hp2/d6n/ysSe4tecHfnMN3s4zwh+0pQ/WbKv2xjFBPmSkqS+2QsXld08Y32xc9YhmX9n99977BrU8ImgKjACd2yWmjZyjP+BQzoXUaUksetgGbypTUXWpbbThtkUWCFoA24/uaxBpDL1wlJEpCdf/7w6L67BJOQArnd0DkvcEPAvpBE+8E9556d0QWdZNRK7YKIi07VvIwtNBpLH1mWtcKC0TxR1N8ov/pxIRMmTYtIkZDtHZj1CQ5qcBG4fgI8tMiw+Hk/3PpWw9GY3i9zG0d9k27/IXsa9p0Lz13V2YdQSkXU1vec1DT72rWt48v07SZktpBjKqVZ2M1Edg+RU2LV7ryOB+IamQeQQtOkAqleZO7/l+FZbQB/gC0bRRx/+tQSRstHWUFiO7z//pCg6ZAstxkxD3KwdbnQ2zAljh+8KoWeB/Qm2v2lcz2jFcWZqiRb7H85qD3h6Ep4LTzcvsjFaJOtU85Qmy+Y0+c0y8GA8l2lsIYu/sb5CG9E5JlfI1FBWAfMCUpmSmL15eRu34tT0GzEwF6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fVHGmdHvuQW+8HPEkyPJvnfOmkOlaq4oRXWhw5t/tSlt+tGsXHAJ2rr+7b5g/GHo8hN3Q4HkoSqM3H1JPhn4+hw8NDio/ZuXq4cxcg9VIuxsxka+o+FOpKdvSuF8K9gCRcrCfAyM7RF7MQwa2PC76jwg3Jq+p1rbkCTew3rXt+/cikpQHn63N59dv5sTbyeR6vroHQo/NkjL2B17quKd7Xa51jicrBuIXw2+9uVZE0eUH6hGQqsAbaC+gvwI9bqVIMGHge1eXD1EwHaIU93JaPDYtOI8r84Htf9XH3ZfV2OkKmRh/3heOzsZ0cVSpYnlkA4hOXXiwRquZMCV0pvA2SHD1qv7AHSukQWRF6l3ISeUzZTMHbKww23Ws4Xxtc7J9qKi0gOGNsBcSb1sXe9q4YO21AXbI6jJ4V7WbpxIsWPCWBX22u+wJNy58sYWbwCq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:03.6588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b32ea2-cc62-49e0-0244-08df0b354b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

Describe nbio v6_3_2 doorbell_entry_ctrl and
doorbell_entry_ctrl1 field layout from IP register
header and initialize gc, ih, vcn, and sdma
port and register assignments.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 100 +++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index a40a13ca1011..4f5a5f310905 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -26,6 +26,57 @@
 #include "amdgpu.h"
 #include "nbio_v6_3_2.h"
 
+static const struct amdgpu_nbio_doorbell_layout
+nbio_v6_3_2_doorbell_layout = {
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
+	.ctrl1 = {
+		.target_port_type = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1,
+			S2A_DOORBELL_PORT0_TARGET_PORT_TYPE),
+		.target_die_id = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1,
+			S2A_DOORBELL_PORT0_TARGET_DIEID),
+		.target_port_id = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1,
+			S2A_DOORBELL_PORT0_TARGET_PORT_ID),
+		.override_poison_data = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1,
+			S2A_DOORBELL_PORT0_OVERRIDE_POISON_DATA),
+		.disable_4k_page_decode = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1,
+			S2A_DOORBELL_PORT0_4K_PAGE_DECODE_DISABLE),
+	},
+	.has_ctrl1 = true,
+};
+
 static u32 nbio_v6_3_2_get_pcie_index_offset(struct amdgpu_device *adev)
 {
 	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
@@ -71,8 +122,57 @@ static void nbio_v6_3_2_mc_access_enable(struct amdgpu_device *adev,
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
+static void nbio_v6_3_2_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base, ctrl1_base;
+	u32 i;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbio_v6_3_2_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(
+		NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL);
+	ctrl1_base = SOC15_REG_OFFSET(
+		NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1);
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP];
+	entries->num_entries = 1;
+	entries->entry[0].port = 0;
+	entries->entry[0].ctrl_reg = ctrl_base;
+	entries->entry[0].ctrl1_reg = ctrl1_base;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+	entries->num_entries = 1;
+	entries->entry[0].port = 1;
+	entries->entry[0].ctrl_reg = ctrl_base + 2;
+	entries->entry[0].ctrl1_reg = ctrl1_base + 2;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+	entries->num_entries = 4;
+	for (i = 0; i < entries->num_entries; i++) {
+		entries->entry[i].port = i + 2;
+		entries->entry[i].ctrl_reg = ctrl_base + (i + 2) * 2;
+		entries->entry[i].ctrl1_reg = ctrl1_base + (i + 2) * 2;
+	}
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = 1;
+	entries->entry[0].port = 6;
+	entries->entry[0].ctrl_reg = ctrl_base + 6 * 2;
+	entries->entry[0].ctrl1_reg = ctrl1_base + 6 * 2;
+}
+
 static void nbio_v6_3_2_init_registers(struct amdgpu_device *adev)
 {
+	nbio_v6_3_2_init_doorbell_entry_registers(adev);
+
 	WREG32_SOC15(NBIO, 0, regXCD_DOORBELL_FENCE_1,
 		(0xff & ~(adev->gfx.xcc_mask)) <<
 		XCD_DOORBELL_FENCE_1__XCD_0_DOORBELL_DISABLE__SHIFT);
-- 
2.17.1

