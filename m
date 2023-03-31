Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB765C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7777210F339;
	Fri, 31 Mar 2023 22:44:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878A110F33C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkFHJ2rPElO9WT0azqXVdfFKFRDAWYW4Xo7aPFVIB0d0hlAoVWy3BaY8CZ84Li5DHgHbEMxfEBbING5rxeQ9P1L6R2f3G/Dr68GOHC6BJltFMCHJnTEbyDC5USkKeMz8Df+U6CCQRv7r54lSqa0JN4APiQsUdt1enSR2VMYIHX4TUEQ5VEvZKnqOxFpV4y+x0x69yDH/0zEUeQr9/1kuDwXXfxQ0KpjbN/CWEc7hi0ek2NW/4XR/B2D9Cb9lIH5IOg7HpCea2GlgzZYD3Y40FMkgWNLdOSSlMvZtDJNJuro5vWXRq8vuDPt3LE+hXEA3XTboE98/uP9r167zo7jRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vumvc3sergrEGqRTAEGE3PMRD+lZKvoIb8wVSmWc1uU=;
 b=HzmU8MRlU5S5/R8USiQRmMLdIfyi+iQSIybC4q3ieR14kUNAKTrqE7YdkU+8t+FU3tYSB32UWxMLNlNHHoDpI5rJVivTZtBFLgSBwLJSwhips8UZ+u3lCucy0QVUKxxG6XrYppZwqPj07KQKmrkqj5XWQbMuf2Ew+59/0NpEW8SK5J809WGuWA6cRMkdyBI8Q99ooOVo2+JzZyBgmr0K4eNAmaniN38+zUGYAspgpVGv1MqzCf7rkmKXTtCGwilCXYeVn0QWKWdotDvRSeKNjoSVdreJzjHclfWhGa2tBz1AjQsgD82vNJdxndZNXVGpeT3I4lWlX34Dz3E3STb+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vumvc3sergrEGqRTAEGE3PMRD+lZKvoIb8wVSmWc1uU=;
 b=VWHvuNu2NWoyqV9qmdDwjnkDNMuHKlNj8BarYbes22Xg0eacaEZfPlihXr4ThyoJYHjRj5UqmxqREV40BwlzX3fejACstQxDVEOMpPmHtI+Sy/RnH0ffYhMpvRr5aoYzo3O1R0E5c19AXXq7BydfsAHq1m7oqfPNNs/OFWV1peQ=
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:44:42 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::2e) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amdgpu: Add query_ras_error_count for sdma v4_4_2
Date: Fri, 31 Mar 2023 18:44:18 -0400
Message-ID: <20230331224425.8755-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 98181068-650a-4110-6e9c-08db323984b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGTr9Ch2NcFiPwuNFTGHCK7rV+omIH6WN95hB9WKSxWeoTl7fbu2Dm9zGsUfxGtt9sele5YTtPF39wuFdMSl0ZGRjiYqqdZ/eLVBcgeTZR4iOD1UnGIZVemPZcdvQ/A9X7Le9M2xw7j/OqVELRkNQhUS8GsVXRIP90eRESci7e6yHx6S0d5a8eDPlIamxmDSpU3o07N4c6peBA+Bi/17LkXMTMskwlcDtO8IBtcTRYq8TCpN3ejXcpa6Bf/jl0afvbh1NczM5thRgbo8HeAsSEvXWAQBh/3DFXI9cPPOxDABqrZu51fOckSNgsCV/sYnbd9pPvjQNlklotny1ZOMNERyEQzHS5WF6lcmPx/g+XXv1mBLNfmFM4TW5X0G2+1908x5zF24i3j1MskWgF2Ntv9ZViW890RQyeKz4pwmWPfnR+gw0dk3gs1Z658plhgdtPZMcD86RoSlzVuF9WrAmsNXrmZNiulFBpoO/t342TNQs3ls1jjaN+KG5JYzPLWj20Oa8RMK/Ir3+RulRbhCBqsQ10bqW/nFKA2LTsZ23OlI7ZTn3ieyoKq7O0siN3X4aJ45yxjg3IB1gJfeVp/DJB6uHbWPc6sH2CzbARlrKH7ZVxyWb/7vI8EYc68gNuZ/M6zbNcKvgfkp+AdF27hh4MSjsRN5WTc+l6KeLu9Spt/CKfY2WdQPjEtsNUPZH4x8QjafHqT3SqtYUl3s/UM/PaTmUeNmkeSI8wbGI+I0Mms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(186003)(82310400005)(6666004)(16526019)(1076003)(8936002)(36860700001)(5660300002)(86362001)(478600001)(54906003)(41300700001)(316002)(2616005)(40460700003)(47076005)(70206006)(70586007)(26005)(83380400001)(336012)(426003)(81166007)(82740400003)(36756003)(2906002)(4326008)(356005)(7696005)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:42.2698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98181068-650a-4110-6e9c-08db323984b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add query_ras_error_count callback for sdma
v4_4_2. It will be used to query and log sdma
uncorrectable error count and memory block.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 28 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 64 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 62afb282a3ff..513ac22120c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -62,6 +62,34 @@ struct amdgpu_sdma_instance {
 	uint32_t		aid_id;
 };
 
+enum amdgpu_sdma_ras_memory_id {
+	AMDGPU_SDMA_MBANK_DATA_BUF0 = 1,
+	AMDGPU_SDMA_MBANK_DATA_BUF1 = 2,
+	AMDGPU_SDMA_MBANK_DATA_BUF2 = 3,
+	AMDGPU_SDMA_MBANK_DATA_BUF3 = 4,
+	AMDGPU_SDMA_MBANK_DATA_BUF4 = 5,
+	AMDGPU_SDMA_MBANK_DATA_BUF5 = 6,
+	AMDGPU_SDMA_MBANK_DATA_BUF6 = 7,
+	AMDGPU_SDMA_MBANK_DATA_BUF7 = 8,
+	AMDGPU_SDMA_MBANK_DATA_BUF8 = 9,
+	AMDGPU_SDMA_MBANK_DATA_BUF9 = 10,
+	AMDGPU_SDMA_MBANK_DATA_BUF10 = 11,
+	AMDGPU_SDMA_MBANK_DATA_BUF11 = 12,
+	AMDGPU_SDMA_MBANK_DATA_BUF12 = 13,
+	AMDGPU_SDMA_MBANK_DATA_BUF13 = 14,
+	AMDGPU_SDMA_MBANK_DATA_BUF14 = 15,
+	AMDGPU_SDMA_MBANK_DATA_BUF15 = 16,
+	AMDGPU_SDMA_UCODE_BUF = 17,
+	AMDGPU_SDMA_RB_CMD_BUF = 18,
+	AMDGPU_SDMA_IB_CMD_BUF = 19,
+	AMDGPU_SDMA_UTCL1_RD_FIFO = 20,
+	AMDGPU_SDMA_UTCL1_RDBST_FIFO = 21,
+	AMDGPU_SDMA_UTCL1_WR_FIFO = 22,
+	AMDGPU_SDMA_DATA_LUT_FIFO = 23,
+	AMDGPU_SDMA_SPLIT_DAT_BUF = 24,
+	AMDGPU_SDMA_MEMORY_BLOCK_LAST,
+};
+
 struct amdgpu_sdma_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index dca0beec0252..925ca6218a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2071,3 +2071,67 @@ struct amdgpu_xcp_ip_funcs sdma_v4_4_2_xcp_funcs = {
 	.suspend = &sdma_v4_4_2_xcp_suspend,
 	.resume = &sdma_v4_4_2_xcp_resume
 };
+
+static const struct amdgpu_ras_err_status_reg_entry sdma_v4_2_2_ue_reg_list[] = {
+	{AMDGPU_RAS_REG_ENTRY(SDMA0, 0, regSDMA_UE_ERR_STATUS_LO, regSDMA_UE_ERR_STATUS_HI),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "SDMA"},
+};
+
+static const struct amdgpu_ras_memory_id_entry sdma_v4_4_2_ras_memory_list[] = {
+	{AMDGPU_SDMA_MBANK_DATA_BUF0, "SDMA_MBANK_DATA_BUF0"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF1, "SDMA_MBANK_DATA_BUF1"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF2, "SDMA_MBANK_DATA_BUF2"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF3, "SDMA_MBANK_DATA_BUF3"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF4, "SDMA_MBANK_DATA_BUF4"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF5, "SDMA_MBANK_DATA_BUF5"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF6, "SDMA_MBANK_DATA_BUF6"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF7, "SDMA_MBANK_DATA_BUF7"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF8, "SDMA_MBANK_DATA_BUF8"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF9, "SDMA_MBANK_DATA_BUF9"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF10, "SDMA_MBANK_DATA_BUF10"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF11, "SDMA_MBANK_DATA_BUF11"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF12, "SDMA_MBANK_DATA_BUF12"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF13, "SDMA_MBANK_DATA_BUF13"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF14, "SDMA_MBANK_DATA_BUF14"},
+	{AMDGPU_SDMA_MBANK_DATA_BUF15, "SDMA_MBANK_DATA_BUF15"},
+	{AMDGPU_SDMA_UCODE_BUF, "SDMA_UCODE_BUF"},
+	{AMDGPU_SDMA_RB_CMD_BUF, "SDMA_RB_CMD_BUF"},
+	{AMDGPU_SDMA_IB_CMD_BUF, "SDMA_IB_CMD_BUF"},
+	{AMDGPU_SDMA_UTCL1_RD_FIFO, "SDMA_UTCL1_RD_FIFO"},
+	{AMDGPU_SDMA_UTCL1_RDBST_FIFO, "SDMA_UTCL1_RDBST_FIFO"},
+	{AMDGPU_SDMA_UTCL1_WR_FIFO, "SDMA_UTCL1_WR_FIFO"},
+	{AMDGPU_SDMA_DATA_LUT_FIFO, "SDMA_DATA_LUT_FIFO"},
+	{AMDGPU_SDMA_SPLIT_DAT_BUF, "SDMA_SPLIT_DAT_BUF"},
+};
+
+static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
+						   uint32_t sdma_inst,
+						   void *ras_err_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+
+	/* sdma v4_4_2 doesn't support query ce counts */
+	amdgpu_ras_inst_query_ras_error_count(adev,
+					sdma_v4_2_2_ue_reg_list,
+					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
+					sdma_v4_4_2_ras_memory_list,
+					ARRAY_SIZE(sdma_v4_4_2_ras_memory_list),
+					sdma_inst,
+					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+					&err_data->ue_count);
+}
+
+static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
+					      void *ras_err_status)
+{
+	uint32_t inst_mask;
+	int i = 0;
+
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for_each_inst(i, inst_mask)
+			sdma_v4_4_2_inst_query_ras_error_count(adev, i, ras_err_status);
+	} else {
+		dev_warn(adev->dev, "SDMA RAS is not supported\n");
+	}
+}
-- 
2.39.2

