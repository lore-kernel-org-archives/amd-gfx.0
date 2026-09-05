Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0DEC624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB0C10E5D9;
	Sat,  5 Sep 2026 10:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqrheAzb";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E4010E5D9
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be6XxrlOMlZC0A+W6PVMCSMTZPJ7JsjE46flDmFLUoPWi1o4G5POu2/PySqX1IXEOlnVhowgUOxcvDLwRjHToyPzyVNBzJwbrIJ70fp5aexYQExbPKMdYuzPTRY1t5X7ZaxnFim0CVAj+lV31gj6LSjNNxOHpcFvugXXgU8EPJEyWO9HKBZy9EOS1S91awMwmtGKrFud3Ie2cLRFHPYKedbOszvRHt6pmd+u4g/IRzp3C3H1wDsN8k9yNgfbZYTnVtwUeNx9CDTvjkOm7FGcZ3JYqaDuZknbYQdbvq6MhTZWpNXh/XfqQbHVxY/KCqCWbTjPPR6UbO/XwgTIywxsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmjg9Gq5ASh6iaJdNxIZ5DhTfDH8kxOPi9+jUkR0lEk=;
 b=MzxX4wkfD6uhZp0xcBYE11/DENoUQGXCVgrFSvqfdEh0DIvbiNUaxGOrG638B/w3i4wJxyGop7AFZ78eJvgdu3+m6bRjCytlOnjHtYjRsrYWGLYUieU7WaUCGZ64vXEEt/bCKI6vNSwV48mm67nac//fn/NUXP+UyQgNmikTgDPLKef25BgDK7BuMo6zNF63hqMElHusONV8qp69gIhWNYiQ5Wfw653dhNU8iT3EF7W2nSJ6DcFKfPe+Q7oULSUY2M7UZ+HNLt+H3UoHQxTiBgFQ+xICv+/eAm/FU3u8bLjdb8wXAi43u4vEOxtMxVkqtDJK61HxB+t+mZeVenxjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmjg9Gq5ASh6iaJdNxIZ5DhTfDH8kxOPi9+jUkR0lEk=;
 b=dqrheAzbjdSnmd8joOGpoMVjpkkV00YjVRTB/XN/mnNtARAILw4Fb3ex0ruUrn1iepqm2Q51eXX8B//Rk2O0oun4uX4VXGoAsKnwule8TfSjmzbbFPfNglAapjnlwTYdaPUDh6VvTKIWVwyLj1p6ciSj6T82qhCL1KWOvAhKK3M=
Received: from DS1PR02CA0028.namprd02.prod.outlook.com (2603:10b6:8:44a::9) by
 SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 10:06:19 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::76) by DS1PR02CA0028.outlook.office365.com
 (2603:10b6:8:44a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:18 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:17 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 07/13] drm/amdgpu: Use common doorbell helpers in nbio v7_9
Date: Sat, 5 Sep 2026 18:05:32 +0800
Message-ID: <20260905100538.12877-8-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2090df1b-a0d1-4dee-d166-08df0b355494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|6133799003|10067099003|11063799006|22082099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: oaE28KFnsAfve8EDxTZX7voH0cEby9EDPAxvi24YCGjQlHBKBdOvcN5tnMbp01tLIEvYs6Pfx5byo+XfnDb9P7fstyndugkDiM0SOyKhT9sX0ek0l3cEPrt5hqroCkXh2Bj4+QD4CGOrP7MYKKV7AKySJSjqtq3T6UHtp0qw3/Aj27Kv59rdT9kBym2sefLXGvvBUkcGaxLGZmu/Ys8sucv3wPjukM9yOyAmiBBH1YMXp56SMEwCd1rGN8xQO4w/cLeWU7djbuLl31m7HG6AK7ywsCpy6YwPMLmWsgsubCgfaD+Eu0a1Fr71LRUhNLLzZZ5iSZpNJjpxlIq8zQSmvw7fW1nYPqlGFlbfpPjcFaqo1PbW4MydxLNxyRS9f7nfh4UIxFX5Kodfa/EcxO8GChIZOSX/cA/rfwTvFoehUS4Q5CV9LsVEQJrb5GMnyXBkOh2a307EwO5aVQy8DoJz3xbzj/ICaQkgGWDh8X6MPgHtWV3ZurwLuFiJr5NufWd1QscgXkpLLOB+ASNRhx6VJbzeBJj11KQY5BpmbhXexEa/ToOydQtOY/N8GwRC3fDsOu6yJTpi3uolJ/0z+/PP0jhC8d8733gGA7o9Vj0SEy24mnQbPilGeB0j+XzfjjyLpOkXtUoT0A4+dPuotNy9Af/GB+z+1ILHm+66jERJtcUKYStsdoGw2QxIVKtVH1x477oNZx+lJJjGUBAGD/V02Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(22082099003)(56012099006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j8fKpW4clY5qMlDSLc8okfWDJcu+v91dQ4ctuOHRC6xV2uiw2vSHBDp5UsesAJi3rez9vjBYt6LAcI9tLr67XSWRr7Q4t10uscRt59h66lhRhpeKtXQ8k1CbQNZv61QFochoz2L4HeeTVQwS468lYUT8ktU1KeHF2bsCI7wrA1gFSqlA0V9l7LhejT+ek3FtOHuVIFWfNa7TteRjfFjMFclZDcNoLIJ/N/x9yKEoIpB6l1Q490Y/aXN3lMByvJEHN+JdSfYseyEUsg2enkq+FENM/elrF8aqnNmEiexwoVj6XGozrUY70d3tGLY/oPyvtul42shERrj5AFLo++Ylgq5ATPWt6HTBO0v24cQBdRAUjaoY+29TfOYxRnLKTPpneb2aTUxmzm7Twd6OCdD2EqpL1nwvnB1OWJpZH+mER/py8pJKNSZnh8XSrsGPhr45
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:18.9484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2090df1b-a0d1-4dee-d166-08df0b355494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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

Describe the nbio v7_9 S2A doorbell layout and
client-to-port mappings, then build and program
the IH, SDMA, and VCN entries through the common
NBIO helpers.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 377 +++++++++++++------------
 1 file changed, 204 insertions(+), 173 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index bdfd2917e3ca..6fe57075a954 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -31,6 +31,131 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
+static const struct amdgpu_nbio_doorbell_layout
+nbio_v7_9_doorbell_layout = {
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
+static void nbio_v7_9_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	static const u8 sdma_port[] = { 1, 2, 5, 6 };
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base, dev_inst, local_inst;
+	int i;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbio_v7_9_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(NBIO, 0,
+				     regS2A_DOORBELL_ENTRY_0_CTRL);
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+	entries->num_entries = 1;
+	entries->entry[0].port = 3;
+	entries->entry[0].ctrl_reg = ctrl_base + 3;
+
+	/*
+	 * Unlike IH, SDMA and VCN use global SMN addresses. Their callers invoke
+	 * the callbacks once per available instance to cover all AIDs across the
+	 * die.
+	 */
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = adev->sdma.num_instances;
+	if (WARN_ON_ONCE(entries->num_entries >
+			 AMDGPU_NBIO_MAX_DOORBELL_INSTANCES) ||
+	    WARN_ON_ONCE(entries->num_entries &&
+			 !adev->sdma.num_inst_per_aid)) {
+		entries->num_entries = 0;
+		return;
+	}
+	for (i = 0; i < entries->num_entries; i++) {
+		dev_inst = GET_INST(SDMA0, i);
+		local_inst = dev_inst % adev->sdma.num_inst_per_aid;
+		if (WARN_ON_ONCE(local_inst >= ARRAY_SIZE(sdma_port))) {
+			entries->num_entries = 0;
+			return;
+		}
+		entries->entry[i].port = sdma_port[local_inst];
+		entries->entry[i].ctrl_reg =
+			regS2A_DOORBELL_ENTRY_0_CTRL + sdma_port[local_inst];
+		entries->entry[i].use_ext = true;
+		entries->entry[i].reg_inst = adev->sdma.instance[i].aid_id;
+		entries->entry[i].ctrl_reg_base_idx =
+			regS2A_DOORBELL_ENTRY_0_CTRL_BASE_IDX;
+	}
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+	entries->num_entries = fls(adev->aid_mask);
+	if (WARN_ON_ONCE(entries->num_entries >
+			 AMDGPU_NBIO_MAX_DOORBELL_INSTANCES)) {
+		entries->num_entries = 0;
+		return;
+	}
+	for_each_inst(i, adev->aid_mask) {
+		entries->entry[i].port = 4;
+		entries->entry[i].ctrl_reg = regS2A_DOORBELL_ENTRY_4_CTRL;
+		entries->entry[i].use_ext = true;
+		entries->entry[i].reg_inst = i;
+		entries->entry[i].ctrl_reg_base_idx =
+			regS2A_DOORBELL_ENTRY_4_CTRL_BASE_IDX;
+	}
+}
+
+static u32 nbio_v7_9_build_doorbell_range(u32 range_offset,
+					  u32 range_size, u32 fence_enable)
+{
+	u32 doorbell_range = 0;
+
+	doorbell_range = REG_SET_FIELD(doorbell_range,
+		DOORBELL0_CTRL_ENTRY_0, BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
+		range_offset);
+	doorbell_range = REG_SET_FIELD(doorbell_range,
+		DOORBELL0_CTRL_ENTRY_0, BIF_DOORBELL0_RANGE_SIZE_ENTRY,
+		range_size);
+	doorbell_range = REG_SET_FIELD(doorbell_range,
+		DOORBELL0_CTRL_ENTRY_0, DOORBELL0_FENCE_ENABLE_ENTRY,
+		fence_enable);
+
+	return doorbell_range;
+}
+
+static void nbio_v7_9_program_doorbell_range(struct amdgpu_device *adev,
+					      u32 entry, u32 doorbell_range)
+{
+	WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_0,
+			     entry, doorbell_range);
+}
+
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -75,160 +200,80 @@ static u32 nbio_v7_9_get_memsize(struct amdgpu_device *adev)
 static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size)
 {
-	u32 doorbell_range = 0, doorbell_ctrl = 0;
-	int aid_id, dev_inst;
+	static const u8 sdma_awid[] = { 0xe, 0x8, 0x9, 0xa };
+	static const u8 sdma_awaddr[] = { 0x1, 0x2, 0x8, 0x9 };
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_size = doorbell_size,
+	};
+	u32 doorbell_range, ctrl;
+	int aid_id, dev_inst, local_inst;
 
 	dev_inst = GET_INST(SDMA0, instance);
 	aid_id = adev->sdma.instance[instance].aid_id;
+	local_inst = dev_inst % adev->sdma.num_inst_per_aid;
 
-	if (use_doorbell == false)
+	if (WARN_ON_ONCE((unsigned int)local_inst >= ARRAY_SIZE(sdma_awid)))
 		return;
 
-	doorbell_range =
-		REG_SET_FIELD(doorbell_range, DOORBELL0_CTRL_ENTRY_0,
-			BIF_DOORBELL0_RANGE_OFFSET_ENTRY, doorbell_index);
-	doorbell_range =
-		REG_SET_FIELD(doorbell_range, DOORBELL0_CTRL_ENTRY_0,
-			BIF_DOORBELL0_RANGE_SIZE_ENTRY, doorbell_size);
-	doorbell_ctrl =
-		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
-			S2A_DOORBELL_PORT1_ENABLE, 1);
-	doorbell_ctrl =
-		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
-			S2A_DOORBELL_PORT1_RANGE_SIZE, doorbell_size);
-
-	switch (dev_inst % adev->sdma.num_inst_per_aid) {
-	case 0:
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1,
-			4 * aid_id, doorbell_range);
-
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWID, 0xe);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0xe);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-					0x1);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_1_CTRL,
-			aid_id, doorbell_ctrl);
-		break;
-	case 1:
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2,
-			4 * aid_id, doorbell_range);
-
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWID, 0x8);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x8);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-					0x2);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_2_CTRL,
-			aid_id, doorbell_ctrl);
-		break;
-	case 2:
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3,
-			4 * aid_id, doorbell_range);
-
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWID, 0x9);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x9);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-					0x8);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_5_CTRL,
-			aid_id, doorbell_ctrl);
-		break;
-	case 3:
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4,
-			4 * aid_id, doorbell_range);
-
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWID, 0xa);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0xa);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-					S2A_DOORBELL_ENTRY_1_CTRL,
-					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-					0x9);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_6_CTRL,
-			aid_id, doorbell_ctrl);
-		break;
-	default:
-		break;
+	if (!use_doorbell) {
+		nbio_v7_9_program_doorbell_range(adev,
+			1 + local_inst + 4 * aid_id, 0);
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	doorbell_range = nbio_v7_9_build_doorbell_range(
+		doorbell_index, doorbell_size, 0);
+	fields.awid = sdma_awid[local_inst];
+	fields.range_offset = fields.awid;
+	fields.awaddr_31_28 = sdma_awaddr[local_inst];
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+			adev, &fields, &ctrl, NULL)))
+		return;
+
+	nbio_v7_9_program_doorbell_range(adev,
+		1 + local_inst + 4 * aid_id, doorbell_range);
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }
 
 static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
 					 int doorbell_index, int instance)
 {
-	u32 doorbell_range = 0, doorbell_ctrl = 0;
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0x4,
+		.range_offset = 0x4,
+		.awaddr_31_28 = 0x4,
+	};
+	u32 doorbell_range, ctrl;
 	u32 aid_id = instance;
 	u32 range_size;
 
-	if (use_doorbell) {
-		range_size = (amdgpu_ip_version(adev, GC_HWIP, 0) ==
+	if (!use_doorbell) {
+		nbio_v7_9_program_doorbell_range(adev, 17 + aid_id, 0);
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VCN, aid_id,
+			NULL, NULL);
+		return;
+	}
+
+	range_size = (amdgpu_ip_version(adev, GC_HWIP, 0) ==
 						IP_VERSION(9, 5, 0)) ?
 						0xb : 0x9;
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
-				doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				range_size);
-		if (aid_id)
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-					DOORBELL0_CTRL_ENTRY_0,
-					DOORBELL0_FENCE_ENABLE_ENTRY,
-					0x4);
-
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_ENABLE, 1);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_AWID, 0x4);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x4);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, range_size);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
-
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
-					aid_id, doorbell_range);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_4_CTRL,
-				aid_id, doorbell_ctrl);
-	} else {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_SIZE_ENTRY, 0);
-		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
-
-		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
-					aid_id, doorbell_range);
-		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_4_CTRL,
-				aid_id, doorbell_ctrl);
-	}
+	doorbell_range = nbio_v7_9_build_doorbell_range(
+		doorbell_index, range_size, aid_id ? 0x4 : 0);
+	fields.range_size = range_size;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+			adev, &fields, &ctrl, NULL)))
+		return;
+
+	nbio_v7_9_program_doorbell_range(adev, 17 + aid_id, doorbell_range);
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN, aid_id, &ctrl, NULL);
 }
 
 static void nbio_v7_9_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -265,44 +310,28 @@ static void nbio_v7_9_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 static void nbio_v7_9_ih_doorbell_range(struct amdgpu_device *adev,
 					bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = 0, ih_doorbell_ctrl = 0;
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
-				doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				0x8);
-
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_ENABLE, 1);
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_AWID, 0);
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0);
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x8);
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0);
-	} else {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-				DOORBELL0_CTRL_ENTRY_0,
-				BIF_DOORBELL0_RANGE_SIZE_ENTRY, 0);
-		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
-				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_size = 0x8,
+	};
+	u32 doorbell_range, ctrl;
+
+	if (!use_doorbell) {
+		nbio_v7_9_program_doorbell_range(adev, 0, 0);
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_0, ih_doorbell_range);
-	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_3_CTRL, ih_doorbell_ctrl);
+	doorbell_range = nbio_v7_9_build_doorbell_range(
+		doorbell_index, 0x8, 0);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+			adev, &fields, &ctrl, NULL)))
+		return;
+
+	nbio_v7_9_program_doorbell_range(adev, 0, doorbell_range);
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }
 
 
@@ -435,6 +464,8 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	u32 inst_mask;
 	int i;
 
+	nbio_v7_9_init_doorbell_entry_registers(adev);
+
 	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
 		0xff & ~(adev->gfx.xcc_mask));
 
-- 
2.17.1

