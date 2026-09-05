Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A7C79F8B
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F4110E5D7;
	Sat,  5 Sep 2026 10:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLnRwd1t";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BD910E5D7
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMnEQrzZk1y5Eqe0W0pVPLu+agkN84MZcOrBabGqIpnzvW6HmWIQWuIYOwQvW/cazfccn/nzSXzZnSBFQnyoV70SdDTuWjDOIVE+nQhycWYkdGbv/UNOU0XKcIBU0GMOl4PVEH1dBOZ4y2DvnH0eMQjcXts9x9sap0Bs9n3NhoMD5/GMUWzBBEQ61fjutAY6tL/idlfaCXHwfFC7WbJNwDiBVk6yZi2j8udf32mZUwN5PU4+N4tRp+Bg5z0X7jVWdopxA9HaJog1ZRFVjTAETkZEhY1KtJebIpfZisHJoB7jeFYyWZ4nn9+on6jQjR5IjickoPBc3sRlN8+hxUogew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgjluXx7WkZbBYvrc2XdscXkP89APLqOHbnxYpe4X8M=;
 b=Oh1dxWNvbH7E+bk0P9ES+t+ODSMtmFLouzbtfJSS5YvlkprndEn5FLuOQFtq9rrrs11hcUC54EMk4O1eW4+7kKL3kRgDX0OgraPs6xjmr/cJsNmqbWkWmwCYl5kcXm8HyqkHtoUTNc8X3CPyN9jh4d9jGlLsaunByGeOvgEiki/hn6bqk27U3TpxsKR2xK6moFSKUk/gN6a47Sv5lURN7IWLag5maUC1pgIeWmQ82Z62pLt6aQrohziWHtJfH6gF8ERl4j6ImcQyPOHU6VapT2WYmIPTQRRsOJZj7hG1a+Wf/OF+c3FQWNUHQ7YcDobvuUWJ1WOF2npUYEGK1YLfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgjluXx7WkZbBYvrc2XdscXkP89APLqOHbnxYpe4X8M=;
 b=LLnRwd1tVzHxU9S1Hl0tifro+uEUS3mCAE0r2tfX3Z8L3F/tnvSnRGaf0gAqQczlyF4yi2SMWAMk4ZFWtLMWB0kui119/cjGGniMoR3sQB+LiBjLndD1oBC0LRuVvhgT0CS0uMNq40cyycFn3qFEXpMIEWXjGSjw8S6q/OMP+RU=
Received: from CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::23)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:11 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::33) by CH0P223CA0025.outlook.office365.com
 (2603:10b6:610:116::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:09 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:08 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 04/13] drm/amdgpu: Add nbio v4_3 doorbell layout
Date: Sat, 5 Sep 2026 18:05:29 +0800
Message-ID: <20260905100538.12877-5-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: f11e315b-22b4-43cc-6e00-08df0b354f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Ptvl8LcHNkUp8YYNbpIVluccB1ONbU21BEMDSippSJb2ExEeNNHZS36Wy5jdS2iAs1lT7i98W3gsx1Waa9LviLzcUBYuTaDOYq5+AAyMiKbVJjO9P0lp7fkz3uohpjdNiXE62mBDj31eG5jlAtfL83oHOS2o5pnYP46anLh/3vOMmxQiemXGIHdZwUrR0dhYGnS24zjpaJY1MKAkmuQ3QYcHRECCcYIWfa3EeHKLJtDjuaGHOQvqNeJk8wvOr7JZFBPx9ULtjs7k4mu5H+seGn5i/hrgTvKuKR4HIl5LKDXV0ozYY9BlFwHkr7c038R8OtAlvk1UMIMsye9rjmRFA7+kafKRTpA+ytxIqR6ohnvfpbWTv0e/sGJkcdpTlW9acW8TQKtJNpPKysMX4rs6krnbJP+TvBF0loOHOht2zYAsDe0dOA5od9mEBxmTkhGdsUXHSdMmYE41rB9s2q1LNsYUePLjG46DLz+viz2TfC1EjFewFMC8XuFZGBtF+5SXnZgFw/iI7IRr0Gj1ULcW+JYZ30qgssjZ6KxJ7Ps0pm3cj1du8YW2szoLDhILlGbu0JmuWk2PygOznTCB+Jp4OR3jBzt/JtXSj7T5wIep1jfFpobwq9JnB/MmEMX5bWM6XMpdjvn2x0OjhIt8zImo1Qkq2bRIw3dzHc87Fw9Tx5gSg6Dyd/bnxBb7Y7l6qWnKeFJUP3cGLYJkJOsY4465gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5u0Gv1khYG6R8iWPDZ9t5oV56EPC61JBrQJUMryJ2lygyLjAQ66ogR2bcrtf5QJAl+TJrEXiSbutpaForG4+XDmUv2ls8DuQzRnpkWI3mlJ5jAqZRFcaw/IqLIvNfiW14cTuCXIe+ttJBfqiUjeDaWydw/UZBqF/6d+vM1qkFTrT7CslFCU8pYwUXSNgiijgz5DuBax4SkQRarkpS+q3TXlJ1UFwc2cJXbgSWlTHCATW89w0KMSM2qt+FD7yCrx796o+s+Xp21BEoWAP9rKMC0Je9Dqk6gVj8lSeXKc/diWOCaaAAKN6JfiXu96Ttk/TRlNf8yRLQRHWRVZNQVSd6ht4HJfR1FqWOdUXmORGqe47u3aINhNZE2/0myYe9pKOpiY8XNJ2zPfHkdWJwSyWWUbM0lU/P809paEy5f+2n+gkJC61xfIMhGR+bgMcy7Z/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:09.7310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11e315b-22b4-43cc-6e00-08df0b354f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

Describe the nbio v4_3 doorbell entry ctrl
field layout and initialize the CP, IH, SDMA,
RLC, and VCN port and register assignments.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index a66e3073aed8..6d12324ce663 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -28,6 +28,81 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static const struct amdgpu_nbio_doorbell_layout
+nbio_v4_3_doorbell_layout = {
+	.ctrl = {
+		.enable = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_ENABLE),
+		.awid = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWID),
+		.fence_enable = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_FENCE_ENABLE),
+		.range_offset = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_OFFSET),
+		.range_size = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_SIZE),
+		.disable_64bit = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS),
+		.deduct_range_offset = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET),
+		.awaddr_31_28 = REG_FIELD_MASK(
+			S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE),
+	},
+};
+
+static void nbio_v4_3_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbio_v4_3_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_0_CTRL);
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
+	entries->entry[0].ctrl_reg = ctrl_base + 1;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = 1;
+	entries->entry[0].port = 2;
+	entries->entry[0].ctrl_reg = ctrl_base + 2;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC];
+	entries->num_entries = 1;
+	entries->entry[0].port = 3;
+	entries->entry[0].ctrl_reg = ctrl_base + 3;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+	entries->num_entries = 2;
+	entries->entry[0].port = 4;
+	entries->entry[0].ctrl_reg = ctrl_base + 4;
+	entries->entry[1].port = 5;
+	entries->entry[1].ctrl_reg = ctrl_base + 5;
+}
+
 static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -337,6 +412,8 @@ const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg = {
 
 static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 {
+	nbio_v4_3_init_doorbell_entry_registers(adev);
+
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(4, 3, 0)) {
 		uint32_t data;
 
-- 
2.17.1

