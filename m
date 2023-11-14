Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1980FC54FA0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 23:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706F510E4E6;
	Tue, 14 Nov 2023 23:59:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A1610E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 23:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqLu3ClAny2KmAyNYfrJB7Yy4Dlm5ev6zym6oskAH5gj4RsBD124NAW4hsFBNQv/TKKhl2N6yQSaghXKzftRIZNAIxtqW9Vdu04Lkg93w34GvPzFwXlGcZUmW2qYvQlsV+RPRGt69qOo+38KPI63M/Vn/bK/dI8VMJhuS6pOOVXjeoUOHTYW/3pcJRnLlfkxBmv4IBYMYM8OV8RZfAW4DM2BXukmtpvXoZyejsswDG7u795pKLSI2X6yTeGaEKqkyETgEJ30MSvxK+7o8pVHKuJaxSOA81YJPX25KcGHnPUnybjG+JwPq9ZpJE3FiSKE4sDxWPc7Mhb3oC1ucrn1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gXL1SAZtFb9NJXKKC/eJdQNuzzoCFsVriiKbqub5uw=;
 b=Q30dM9nrUTti/bcuyK0zZB4dKe427jGCOci1TNze4jA7cXR62ijcLWThtLyjVIjKLjfVTgKfJvQdE3R7oEPJuNW350eY6f1oGCaDbFHQglaYiT51sIJytGSqW1QsXmnbwCWvP1Do7a94lTte9n/nvnTS+K+uN6lPThEN2N3ajQI0CAIhOltWlQ9SZbXy1NClDfo9XniSL2x6nslGFDsbnCyfLFFFWEookNYEKn5LQH+PeG6gNOcAS7DZQQ59sIWx//kVZ9U4dlidClicpMcYLwgNZ1aJhgmo3w1vRPjF1vWSkyA7FmcO/KFyexxS91v6H84qCs+CUmmCBfyYYX9tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gXL1SAZtFb9NJXKKC/eJdQNuzzoCFsVriiKbqub5uw=;
 b=lvCZwEjKEqZX0jjlmo6/5ZTa53/3uXlntEjWvC9gX9MUITCyR8PJFmVTmFrI01BxtNBJPe9MXKp49Bze556GBrSDVP8sElX54WpwOOgqEG6MH2qO5jIjLT0h5G7jgk/k1hAM4Nhdq4NBjbP/kRAUJpWHcIg0CXedi3ItRUwQPg0=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Tue, 14 Nov 2023 23:58:56 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::d7) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 23:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.17 via Frontend Transport; Tue, 14 Nov 2023 23:58:56 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 17:58:55 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix mca ipid socketid decode issue
Date: Wed, 15 Nov 2023 07:58:37 +0800
Message-ID: <20231114235837.2262938-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: e7850aa3-a8ef-4716-16d5-08dbe56da9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZLG8/W6dZ51FUYYcFlqzqRR9OBrSPyBjnfSVMDr5frQQ+dRkfRyvrwrt/DZn6BPCtW6b2FU26PLjUbHhCYzJ+iUaOqSaBhVe6JBs+BpdutzpbJX4pYZEGj9ESg1HX19ayvk5xXLXXlOqKdemb16Ze3sNdDahdip1Ri2WVCa74+UI7gDCJZwAOcc5KXmdP2pMDQF1TVM3n+ck0kXgPpMVSx/3OI7xIUGE/BfCZNeGbaP/TtboUYdGhbsZN86IilV+xSVgpmE4sNR4xLBkfsbgAYlESBIaISmxsqitmSc2cOX+4ZP1PjCi4Hwj0Pgkn9vCQYQH58dCyTNXq6O7N3zQ9jb9CXFl0OtsWUikkv8y1hymroNigcEgos3MMbqVNGYjfZX0Dx9dOJm3ncdFP1fD+rr3cYFzk+CE3PV1U7H/0OMRxa/lTUmiwAMqUE2Q/qHdUUc4I9OA1ycHjHymqbawdcOBAYhZBXD+aJd12NkVr+OGt3Se0l/C0WmTx6CPU6rfKBdLt7X0T3GjDdcxyWNsbXWPBkxZn+H37Ui6CG2gmBkYlT69QrCg9bkUZ9vHJujLV19svN/GbtQLbNUKWafCeskPHXNA62oN1gBfMbv2vH0BUlcw3hMnDKscy1E6X6LqyD1JZEgyyew7w4Ed4BPw4NI2jGDdHpHEUAx+WSsUDUJ0GgDLjvki+w5fYs5ACPa3DcBYmKd1wByw+rgFWqZRqryqL7ROCSzBRnFln8xvDtx1IANHkO4ArZhk1jEZIp7MwhRBFLFBDWQiqgKJSaA1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(336012)(16526019)(26005)(1076003)(426003)(6666004)(7696005)(2616005)(36860700001)(83380400001)(47076005)(5660300002)(8936002)(8676002)(4326008)(41300700001)(2906002)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(86362001)(36756003)(82740400003)(81166007)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:58:56.7752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7850aa3-a8ef-4716-16d5-08dbe56da9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix mca ipid socket id decode issue

Fixes: 610259215805 ("drm/amdgpu: correct mca ipid die/socket/addr decode")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6daa8ee49035..d4e312003181 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2410,7 +2410,7 @@ static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struct mca_
 	instidhi = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
 	instid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
 	info->aid = ((instidhi >> 2) & 0x03);
-	info->socket_id = ((instid & 0x1) << 4) | (instidhi & 0x03);
+	info->socket_id = ((instid & 0x1) << 2) | (instidhi & 0x03);
 }
 
 static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
-- 
2.34.1

