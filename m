Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048C4C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E20E10E7F9;
	Thu, 26 Oct 2023 14:20:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5018C10E7F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3sa9QxBQKoyX5LT5N//9frTMaHXCus8PWL3/irtOLhPAFq14fNN8yktrSpwG9EcqjVNBS6qV8kX0RRHm2rnT5cHXXQE1wSCL9iYcvvU1eIjN+2ISqnO/ARUXCASwvnzMH8fltynwvEqb6GS78m8HO+ad6bd5Dn5Uqe6ivZPfvXLW88HIlZn+cms1TyCYGaDOYIMTJ0NY62g78ghFXnc7QerXU62SwjF/dVc1hDee/p/ZxRYiqu9w4NoxkVP7iIreslqxyPjGZmghq0UsygsSgnyLy1eKCdAglDROeZtSTXXQ8LyjEN41fHY9bBrFRU21ejtOg7Cx43Mkgd0p+qBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUmZccLrb2vHUatPtG38K6X1wED4ABitIbRsF4VTIfo=;
 b=SdGW/Va/k6EcTCrkBtOQzQXUBa5DiSgmG63/dODAogK79cnWKfGqFuT9AC708PmULMO4xyvgaJOZJM4BVQJqxhfbMOIE4o10D7gc00egRrYB/yFYGg2pKccRrtN5Mw1lN8SZPVFYe1ORr1i1+U1kQoihywu840D9E7rRGdaVCpcdf4riApJ/ugXLs/GJGbfTnAS79Uim1lG11vHzFPBrXyjzVbSuGFxJqAcDWzK/61uNwlbwqaoj+TeIlKIFIBfXVw8JmcvNMl5ladDcj8bMW9UsBKk54Fm+8aEC+3xsNsYqaM/no45Nk1yTEsihD8ttcPE2HDcrglpt3KV0Jgw6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUmZccLrb2vHUatPtG38K6X1wED4ABitIbRsF4VTIfo=;
 b=zrfNoJo8v1oOeXFy5hFoJbu4cpl3u1Yfd0TLiAaUkmptEYn+r6zOql03wfOxo0qNpowpuL5ACkvyAu1MFg0Nm7eN+O/RFVSUI7IcKCrZFrF4CO56l+l10VkSc3gB3qFQY8gOT+4nb0KtkIp79+ZcSmmBXH9AzeeqrmJpokBDcc4=
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:34 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::27) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:32 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:31 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/25] drm/amd/display: decouple dmcub execution to reduce
 lock granularity
Date: Thu, 26 Oct 2023 10:20:00 -0400
Message-ID: <20231026142020.67861-6-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 81009d0a-ab2a-474c-8bb3-08dbd62eb78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsfgjbhHvA5QrzGogef3BHYKL4r8S9rA9hTNdELviCjZh4MCQNZGVtT2g6j43quydHUKO04TEHS3pdq6LYsVh3f2yMn5pCEfdqu8u9KMSHphV1l4ymJjnZVtrd4UuJ45sSLC5pg/o94V+G47k5ACJcAtVwI4Gu71PwvtFQF4tg+IBoA4WYzyBHQSXPgwvsNdEjJZoxmb01rr7W8TLFJvcAKiYSlC5hS8slt8XP02oM0dfma0T/j8/GCJwtFEwoqKGRemlL+pO4d446rVI4g3IWFHpQilQjGCJoKs6yo5tXkXFsbNyYgUf0Inu/mAefLhrsQAyET4a9a1zrWJqgLJjca2awEoyJgt05HWFpLuZcLRBKKADOEYPt1l+uluTCLWDDzEU9aAuoGbwSg1V+iWgUlcTossT/h3LjzgBjw8VW4TUCsvs6U61poGBFmDjUFpWaPafeeMm08F/594sHtRUz8CKOP2mP/+7fNBpSursNswmzS91cPjEJAkfxrbmC51ruPV74uxc2DjdRikOZu3KTUa6BSgk7pGb7Ub4t8pb7nkCDACT/EzvnwVrCjKMgBpeDkNGHt/4rElzHiHJmyIIuFkYqruBO8Gt3ikvN7Kf0gRtGYZuVSZEG8uaCBeFNHypEK3eDwcc6XaDAjY6ztIBuH6Jmf/wZ0jvpCVRDdpo/9YXMDUmbJ/pi21fmAu79FcK06kteL53/yzgDrokQbEjlE9tqQDqzxLP3wrwWakvzzbTnvZ3NU2Xu94eg/LXyzBa/5vriyLnHe49Kw3aV5MgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(81166007)(47076005)(41300700001)(2906002)(86362001)(5660300002)(82740400003)(26005)(356005)(1076003)(336012)(426003)(36860700001)(36756003)(2616005)(40460700003)(40480700001)(70206006)(6916009)(6666004)(478600001)(54906003)(8936002)(70586007)(316002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:33.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81009d0a-ab2a-474c-8bb3-08dbd62eb78a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: stylon.wang@amd.com, Josip Pavic <josip.pavic@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, "JinZe.Xu" <jinze.xu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "JinZe.Xu" <jinze.xu@amd.com>

[Why]
On some systems dmub commands run at high IRQ, so long running
commands will block other interrupts.

[How]
Decouple wait_for_idle from dmcub queue/execute/wait.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: JinZe.Xu <jinze.xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 74 ++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h |  8 +++
 2 files changed, 82 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ba142bef626b..e4c007203318 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -120,6 +120,80 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dc_dmub_srv,
 	}
 }
 
+bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
+		unsigned int count,
+		union dmub_rb_cmd *cmd_list)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	struct dmub_srv *dmub;
+	enum dmub_status status;
+	int i;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dmub = dc_dmub_srv->dmub;
+
+	for (i = 0 ; i < count; i++) {
+		// Queue command
+		status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
+
+		if (status == DMUB_STATUS_QUEUE_FULL) {
+			/* Execute and wait for queue to become empty again. */
+			dmub_srv_cmd_execute(dmub);
+			dmub_srv_wait_for_idle(dmub, 100000);
+
+			/* Requeue the command. */
+			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
+		}
+
+		if (status != DMUB_STATUS_OK) {
+			DC_ERROR("Error queueing DMUB command: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			return false;
+		}
+	}
+
+	status = dmub_srv_cmd_execute(dmub);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
+		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		return false;
+	}
+
+	return true;
+}
+
+bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
+		enum dm_dmub_wait_type wait_type,
+		union dmub_rb_cmd *cmd_list)
+{
+	struct dmub_srv *dmub;
+	enum dmub_status status;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dmub = dc_dmub_srv->dmub;
+
+	// Wait for DMUB to process command
+	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
+		status = dmub_srv_wait_for_idle(dmub, 100000);
+
+		if (status != DMUB_STATUS_OK) {
+			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			return false;
+		}
+
+		// Copy data back from ring buffer into command
+		if (wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+			dmub_rb_get_return_data(&dmub->inbox1_rb, cmd_list);
+	}
+
+	return true;
+}
+
 bool dc_dmub_srv_cmd_run(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
 	return dc_dmub_srv_cmd_run_list(dc_dmub_srv, 1, cmd, wait_type);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 31150b214394..d4a60f53faab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,14 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
 
+bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
+		unsigned int count,
+		union dmub_rb_cmd *cmd_list);
+
+bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
+		enum dm_dmub_wait_type wait_type,
+		union dmub_rb_cmd *cmd_list);
+
 bool dc_dmub_srv_cmd_run(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
 bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int count, union dmub_rb_cmd *cmd_list, enum dm_dmub_wait_type wait_type);
-- 
2.25.1

