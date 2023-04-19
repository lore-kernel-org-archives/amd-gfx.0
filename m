Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959BCC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 12:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AD410E182;
	Wed, 19 Apr 2023 12:13:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E67410E182
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 12:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8rgPQcSITjcRy/oWh3ZSQ1thcTIk4DlBuKeUYaKui5MT8YRAPk+0HKzHvUfV9YIQAiZxIbgaRMRDfAM58fYAJTwvhqZCF6VlcuI/h9zc8YoXL68L89LsGeTklouS5jZBoS+w6hD5m53jrNIMN/VvMsDj5PplWCHFKCYyOtWIP4PJyokfstRxs33nc9Prv5wBlUMOw9ui+zkUUz/04kcGbGoP8Ao2R+nt5d4vxXlV5pJ2ZFceuu6HZgpxZkcZ9MuqVF68FBJrZNWiMynK3cgUTJHEJ3K2uhJMs2xCEe0qHSpeocMIn6AKwscFLm26vUgVfk8a5vPcH0+UBq78k9z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cZ9zI7Mljsn8JuCQYo3aKl8cXWINhsqWGpCvZcXu90=;
 b=hy1sgXdLoJ3B3dVYCiHAI0dPT2U5g4PY0uIUexxpWhqhsMHobRvWFA0o0DkwNp0LLaYjHYC9hHJY25U30ahOr6/0Q9nTyZD21vPGTiZHSxYngXhMJTyrBFl9iaxxsHE0MXsus6FPkXdEkzEAnI7lA8f78+BUg1mc9WQJH5bpGiVPo0fTNTE2vmxh2fNey3U2JRiiJEKjmuab0F1Gqw47sPVy8I2F+o2r4pM7j4vwP57+U6+o1J5xmwcujEFg9sz6rMvcVdf6iQsbQpIvVSjRriFu8jP0OY4sUROMRabb7wjr3WQ3zCrNQUUckI8wT322U+N0aKBdrnwjj9o70JOdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cZ9zI7Mljsn8JuCQYo3aKl8cXWINhsqWGpCvZcXu90=;
 b=OgsL3zxDv7CmPeAaZMj6ZqsgrEtdr3sf67J+aBN9Gz6n4jIdkqRR8iEQFf5fWiFQjeNrxH5O1KozFXvvugJmSGFon0xMpkdR8Mhp95ySUrRlHMsSMM/oPEsWFJS1a9p8D8h91dQFymrOT2hwftLs6x/hZWnZaXHedmqWklQMebI=
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 12:13:14 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 12:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 12:13:13 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 07:13:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Jerry Zuo
 <jerry.zuo@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>
Subject: [PATCH] drm/amd/display: Remove unused variables in dcn21_hwseq.c
Date: Wed, 19 Apr 2023 17:42:52 +0530
Message-ID: <20230419121252.187132-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: d2996930-2247-4689-aba8-08db40cf731a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8TbpjAN9FUa+9TlyJy8LGxl7/VuLONL7rRN4Vp9a2lJcMrmALSSQqeG46G6KvEuPPGYtYxVkf90iouHhZAXMG2IUBoFgRyDZeONM5RFeUyhgxM3Sf3j5nPPIqWlZ0vYkRHAuxGrBN+abnb8HTZtukAs4j61PVn7odLsRxMxquq36giYHD00rpBHtOQpHEgD2f1f73EA3Zv1uEVwXALOr6bA+dvU/zZZlXi+JfGoMp5uNN7ELxv0H3tHi1PTgZjVyQypqQO5CSJhipG39/nSGe3UesqzGvQ51pk2BG+4C7lnFUieKFU8PNXAqF9u65FUAyhLiJOAwNbxaF6HU26GKU1Qt2Tov4BaHU9GpsN/+6Up5WtlDCJZ22WtEOM+/VQoX72WgSYzE5jyLiQ5+RPGoCUTqLO0QSamiT8N7124eSv6oKZo9suf3N8TEbleAP5WOZ1IX/MzTQq9DoeNYEQN/BWu4Tqv1a8oSWCoL4NjGINlPJPUvZCXNUd1/7TK5NsMKD2mNjmv7qLLzhQINSDz8e17YXkizLz1KYShEGXh2Kk0vtZIRJLhH3aYEBW6+XSJwCYQQIUg3juXwfn3aajsNKWJPV2hqrD2Ys41AN8xNH3TCF0jtgUbk7h10d7/e33mTZYu+6KkWpjulpQxeE2zM43Bd9O9exw9r3IcNf90cOZ6uV9EWe77ByaK+Ev/AwWtLY0YMquH4DMDcUq5VcismLZS+QyUSa7LfFO+8xGtP3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(82740400003)(41300700001)(6636002)(4326008)(70586007)(70206006)(40480700001)(81166007)(54906003)(110136005)(356005)(186003)(40460700003)(2906002)(16526019)(36756003)(1076003)(26005)(83380400001)(426003)(86362001)(336012)(47076005)(82310400005)(2616005)(5660300002)(36860700001)(7696005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:13:13.5186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2996930-2247-4689-aba8-08db40cf731a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the below compiler warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:229:11: warning: unused variable ‘otg_inst’ [-Wunused-variable]
  229 |  uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
      |           ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:226:20: warning: unused variable ‘cmd’ [-Wunused-variable]
  226 |  union dmub_rb_cmd cmd;
      |                    ^~~

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 55a464a39529..43463d08f21b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -223,10 +223,8 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
 {
-	union dmub_rb_cmd cmd;
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 
 	if (dc->dc->res_pool->dmcu) {
-- 
2.25.1

