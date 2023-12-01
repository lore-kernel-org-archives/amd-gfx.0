Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3EAC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395F910E89F;
	Fri,  1 Dec 2023 13:29:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BAD10E88B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB3bkIvgXCwpWo2FT3GKNyoIYHt98NILBdebBmW6XQkwndOlVTr2GTwc7QuE0+OqXIDXunGyh7jY2m4R+J/94CWl0yani+MXPXMNWqvLb3s/zDP2FvAfyuCombuUeFKyWbcF6QN0GCdhLFTbPm7ajDNJIUXjwHeqXSp1cKZOPbu2fsxayk6t1WtQrv54+JIC56JThB2UJMejYzF0gRhNmV864CxCWgB/QXxdm1+6ZDrzjCmlYUY/LLr+Levcpd+ZhpmL0BFo5mDEGQ1s4FsdRKFuxQ3LhkdAOl/fEgGeAKdQSiB0GgB8aOdBvZPI756/lCS0Wyd6TKAofl86TI3PSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gioZeL+/Y+KvEKNOhox/5ua3wDyGsgACx3msJBPQbAQ=;
 b=cB5ybK928LWVfPt5TRr3+2eGOLggtxhJL3l5xcySmeJCSbfod5FFzVAgIZRf/wXPKuesNJStSj5lZdNfDgoYtLfo9iW/KgehK1+KRi1j11UEs73FgZyN/260qZ1Cp5AAunF1/N2OgrjDZeNpGKSQHkZoHClGJJA+bSz0zH1lMGEz56Afq9yS3iSwVqkRYA73dPI2OtbSjkKdVSGEgcWG6Y1iVi9ThFo2esO4XJpgZ/8cWuPFhobsDzzH1FW6uHQoRoEpFN5CM6cx9SKIb5z38vBoNjNy4onTxaUJzMl6HbTwEjKXJTFopI4C27AhpqRaQk5bBfUnesPPIHoUwZ2E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gioZeL+/Y+KvEKNOhox/5ua3wDyGsgACx3msJBPQbAQ=;
 b=sNdwQD3XwDX3eo3GTZ2JWeY0oeLduajfh9jBINqlJlduU7FPKN6Z8J14PFMTrW9RJ7SMt3dX+o7aTCv1takbjQ1VWcocgQhB3EuUh2MjdolP764GmlA7W2ym+RcLR4g3XRM9lQGKUN3/0Ckc/GcQ8YYcoiTM/ZoaRMMkirUhk6Y=
Received: from CY8PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:44::28)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:34 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::fa) by CY8PR19CA0019.outlook.office365.com
 (2603:10b6:930:44::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:31 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 42/47] drm/amd/display: Add new set_fc_enable to struct
 dwbc_funcs
Date: Fri, 1 Dec 2023 06:25:38 -0700
Message-ID: <20231201132731.2354141-43-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|BL1PR12MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0374e5-137c-4ab1-b1b4-08dbf2718e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udQPUmihbjyGn3hRtizu7Ll2htCEa9WDe8MGOCsHiocRLSn+TxsDXFXoDihkPBEOcuPIcF5W1ie5E2Y8Z/ultej1T/aPAv5iRynG7b/HAp0iE4jgQ4aoh1YIO5TcSJAcUrUTINl+NoEtEldgNURefhX/ToCSE8+bk//5FozgwQ3J47W6ezw/+QmbET9RR+aHTp5lcdwRNIyDGLnfjcbSflGNwMFdjuwHh0AGdIHmzhb07/F2NsBsh2VOBIOm4qEdDARsLbYdbLnBOnoMVkgfjRUt5Eaf6WM8SBZ9YNdMlvD3I/2/l92twC2py19gR0KGduCpv5ExlPi0AWEkeA+1RSo9H/ibq+tlmOgDxzNGKAPx1pF2cxmz5iipl6HX0cNeQjVSiamObB+mN9+ASiOFEOoMhAhm3g7v8S6a9fbTQdTyJUi0RB69Xw3KPlKEDbHYee2f7it2UhKEunhMkLW8umbX7Bm1XzY7vY9j3cWCWtRm72+MzMVtR7QV1SQpqQFkgLZX6zb+y9dRP/V+rTf+kSSdw0u1vZT3v9zKxLdXcu568VnZ5cQFOhq5W7y55XO240D0k/KbLkdJAfxfl6vP/fyR47ldD9zijJ/8BmZYRS2bAI3FCazPxD/o5AZ+fA/TjunHrKdFGERRj7ReFmwujdTmOBED/q92+HLDHY+6xEMFdL2Lr3v1A73LtOK4GvqboS8WQ+LxC8oAMXO8qts8gWBH0nh/ldNo7dhkvh8bhFh0GJbZvMt+zhs5i54lqG+AGq2D9fgu/DiOYPdKZMTg/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(86362001)(26005)(70586007)(70206006)(54906003)(6916009)(356005)(81166007)(82740400003)(36756003)(47076005)(36860700001)(83380400001)(336012)(1076003)(16526019)(2616005)(426003)(2906002)(316002)(478600001)(8936002)(8676002)(4326008)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:33.9692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0374e5-137c-4ab1-b1b4-08dbf2718e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add a function to enable and disable DWB's frame captures.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  | 23 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
index 0d98918bf0fc..1b9d9495f76d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
@@ -130,6 +130,28 @@ bool dwb3_disable(struct dwbc *dwbc)
 	return true;
 }
 
+void dwb3_set_fc_enable(struct dwbc *dwbc, enum dwb_frame_capture_enable enable)
+{
+	struct dcn30_dwbc *dwbc30 = TO_DCN30_DWBC(dwbc);
+	unsigned int pre_locked;
+
+	REG_GET(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, &pre_locked);
+
+	/* Lock DWB registers */
+	if (pre_locked == 0)
+		REG_UPDATE(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, 1);
+
+	/* Disable FC */
+	REG_UPDATE(FC_MODE_CTRL, FC_FRAME_CAPTURE_EN, enable);
+
+	/* Unlock DWB registers */
+	if (pre_locked == 0)
+		REG_UPDATE(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, 0);
+
+	DC_LOG_DWB("%s dwb3_fc_disabled at inst = %d", __func__, dwbc->inst);
+}
+
+
 bool dwb3_update(struct dwbc *dwbc, struct dc_dwb_params *params)
 {
 	struct dcn30_dwbc *dwbc30 = TO_DCN30_DWBC(dwbc);
@@ -226,6 +248,7 @@ static const struct dwbc_funcs dcn30_dwbc_funcs = {
 	.disable		= dwb3_disable,
 	.update			= dwb3_update,
 	.is_enabled		= dwb3_is_enabled,
+	.set_fc_enable		= dwb3_set_fc_enable,
 	.set_stereo		= dwb3_set_stereo,
 	.set_new_content	= dwb3_set_new_content,
 	.dwb_program_output_csc	= NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
index a5d1b81e768d..332634b76aac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
@@ -877,6 +877,8 @@ bool dwb3_update(struct dwbc *dwbc, struct dc_dwb_params *params);
 
 bool dwb3_is_enabled(struct dwbc *dwbc);
 
+void dwb3_set_fc_enable(struct dwbc *dwbc, enum dwb_frame_capture_enable enable);
+
 void dwb3_set_stereo(struct dwbc *dwbc,
 	struct dwb_stereo_params *stereo_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 86b711dcc785..729ca0064e94 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -188,6 +188,10 @@ struct dwbc_funcs {
 	bool (*is_enabled)(
 		struct dwbc *dwbc);
 
+	void (*set_fc_enable)(
+		struct dwbc *dwbc,
+		enum dwb_frame_capture_enable enable);
+
 	void (*set_stereo)(
 		struct dwbc *dwbc,
 		struct dwb_stereo_params *stereo_params);
-- 
2.42.0

