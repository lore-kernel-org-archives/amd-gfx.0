Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCCF61106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBCCF61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC5F736AA;
	Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C09173620
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSj1eOKSD03YkbMvRDv43Xrz7aFK+06pyOit+M4r+C0z4Mu+m/binre5Zbs5J+jnhlq1NmRdbU4IVZTQY1UEerEBhqGe008sOnb5RNGakayi1szZDenTfsGOKcsTuMwgwIsnyeY21JApYTT1nRS44LxiDbqrzezVviDRbSLJYqH5YS1/v2HLX5fmD3n65U+DXt9m1NhRFD418BH2O5fVxutW+RmfnhlzvFOsBJSH9phkzcGMzFFhzWu1Bhei6aG00s6GtcdV0yMTe4nf9rMmdoAlSXb+GrVKOlXaHD4gdphWByOVgiTkloUXF8bKyiAz0EaBFpclSZjnwjaQJsFjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/II0Te7tKak2yuN72WM06ZxQcv59LSlldDr99CULXcw=;
 b=HClGx7GJy6zmLXo0yODJI0jeA7SapoARCk1wBrRFcMCO9Ari5Kvwzm3L6Kf0mfIk9VZZ6qQB5HrNxkzTUlLuGkW/NTbA6LI2l/RGIWXk0psU0n11Xl7A4razK9BO9G7uVfmP8H0tYZRgsl8EbibF4kC51pdnG3O+ZQcBOzfmDOF6of+IjiDoLUxz9fbTI3Iz8BiB1i31TJYaPEKm205AwGqcKuPDt4UzPdgMEwF/9LMT3utC2sHNEAHvSOodjuv9FKaNbNa5eACZi044kzQBVweCvL3K8eM+lBuuuDO6mb7ciIW0Vi4rtmt4x0kD7g+KltjPm9taeWkXrt8EhZtcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/II0Te7tKak2yuN72WM06ZxQcv59LSlldDr99CULXcw=;
 b=aQT3VTbnUb/yUa18Bw1NIGy8SObeRTDnAl3zBuwRqsod0hsdL9zsOjI03YdxW8SDNZNCtXITB5vbQcb7P+/IYJBxNyumjTPH8EoNs2/6jl7TThlXekQ2+K2UKmHKzrbDB5gZjBmtnGe6rs4gIMoI6H1kI9QRQmpu+G/+tlX0Ja4=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by CH2PR12MB4008.namprd12.prod.outlook.com (2603:10b6:610:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 20:52:28 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::7d) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:21 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:20 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Pass panel inst to a PSR command
Date: Thu, 4 Nov 2021 16:51:55 -0400
Message-ID: <20211104205215.1125899-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c620f7f-a21d-40ef-d919-08d99fd502ff
X-MS-TrafficTypeDiagnostic: CH2PR12MB4008:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4008EC959A4F1D0A3A684602EB8D9@CH2PR12MB4008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAHiSfxZNLb9+b97lJlfRBrAuDD0bIBkmkSn6UR5iGZz/U2LoXEYQe6hvd3aPsWX/fxY65+txrBW/dbfMVlltW3Rg0hF14vPfibo+uBWoI1zYAh5I5MOQZkafa4YTJLhL6mPzHASdyIiPtY7UxikY0pohdRZNsP4Rq3NvCu+MSL0iNfwIyf+DE+kjfL4jn8oxNrKnr3GzY0m0b1ZZncUZ7XNCsCYEZrbE5QpNV8SZL2EAcQgU03euQZ9GawVXzoKg47XCVBMYEUVUQCQvrJRttDyGoH4TQkOOlc4K9ie0czbGB35zWTZMFVskGb1j+r83uve/J1GyYVq/N6h65L/n4/zzgP3cwSG5dgExvwS+tukyP1vJ4ZMbnzsr6Wk93oFwE94dnnj5JujrOmOEWlwQIJWs8zZbOKozL2nN2ktc80mMaRDnit5+CohA/RjBuagr2Pm1M0hrmZ8zeQY9kMKYv1Y92pgOu9g7uv5oY36vki5e4QWoTmWEcJaYvCFWW5/hgvkatB0PTksYUMolPtzrTQMT3w8z3dqkiAM+sGEn4x6FMEIOgCqzjuZctZCRI3jFSLh6msEbI69GNkn4LN7/GxAGkRuCgv72N/y0m6qIy7ptKhM6vTE3SaTL/vNVKsSyLhPdB2tqrrEf62Cfl+p/bq2JcQkCkZ0vdAwkN1wEp18SyAl8GiHeULceUWMup/82q/xbg6OUnG5BOkBYgGQ2ddWBJRZn24qBDnLiL+EUt4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(26005)(47076005)(36860700001)(4326008)(82310400003)(2906002)(7696005)(83380400001)(508600001)(1076003)(8936002)(70206006)(70586007)(54906003)(186003)(2616005)(86362001)(5660300002)(6666004)(316002)(336012)(6916009)(8676002)(81166007)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:27.6008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c620f7f-a21d-40ef-d919-08d99fd502ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4008
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
PSR set power command wasn't setting panel instance
and command version which caused both streams
to overwrite the same PSR state.
[how]
Pass panel instance to the set power command function
and to DMUB and set command version enum

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fe2b4b1d80f9..b4cdf6d43965 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2997,7 +2997,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 		link->psr_settings.psr_power_opt = *power_opts;
 
 		if (psr != NULL && link->psr_settings.psr_feature_enabled && psr->funcs->psr_set_power_opt)
-			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt);
+			psr->funcs->psr_set_power_opt(psr, link->psr_settings.psr_power_opt, panel_inst);
 	}
 
 	/* Enable or Disable PSR */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 90eb8eedacf2..e9c0ec2ec4ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -230,7 +230,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
 /**
  * Set PSR power optimization flags.
  */
-static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt)
+static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -239,7 +239,9 @@ static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt
 	cmd.psr_set_power_opt.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_power_opt.header.sub_type = DMUB_CMD__SET_PSR_POWER_OPT;
 	cmd.psr_set_power_opt.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_power_opt_data);
+	cmd.psr_set_power_opt.psr_set_power_opt_data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 	cmd.psr_set_power_opt.psr_set_power_opt_data.power_opt = power_opt;
+	cmd.psr_set_power_opt.psr_set_power_opt_data.panel_inst = panel_inst;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 5dbd479660f1..01acc01cc191 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -46,7 +46,7 @@ struct dmub_psr_funcs {
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
 	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
 	uint8_t panel_inst);
-	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt);
+	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
-- 
2.25.1

