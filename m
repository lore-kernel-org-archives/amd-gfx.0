Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BAC07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E74621D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ar86KoG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E74621D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B6C6E95C;
	Thu, 10 Sep 2020 13:48:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A926E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaOFkQK2CTMTUxAT/+Xq+99Ox8otVFrpD5QDV+SOwX2j0TFqJnUVWMXXvkGvVs/eMXcgSU2LxLjsmtuSSIxGBHddPUPAP02DB1Ezy3nNt2vEXtogmb6pcKma1tPjWUpN3mBB2I3uLlFagtbO00Py7egrhiVL1HRos8ptedepGBPgr4jC+r1C30uuspL5NqJPdqzpgsyZs1PWl+C4xnY/HM3QvoC0dXeV1EAByKzRNoavOJqdo1oAoEDqW64i0393bwWUEwLq1PoRnzp4VY+kXFjKp96iq+OePzPm7N2BlLEmwLWAlhygK6o4ptVf6bzRcyU9u8JkXr3QMTbbqIu1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEE7nNmSlgu/vIzBcEOZsT6iVqNDflvlfv4k7pxJ7KM=;
 b=kBYUP2zQSLm7S1iKmzk3/R5wuf2e89wK/n/izawOqXST/RzEtLV4LqH+xkdWCcgdaW/vm9iKYv3PqFGt8+ZH7xEJL7Xu9YhejU2lJRZuT7qiuFNpzuG4qV1oSDU7a3pb+WYJpjoBO5PzZwaPOG7SEvdjsjNXN7CUkBoIoZcFl96FtZbU1qRWsyWBx63He6AfHqj/VqCZw8iL0U3VeQNbVwj8nX1Gu1FNvGFNhKYsp9tD55Ml5kPXBUfMY9oxnhD5ytcOUJ4RaIGTO2jpxNsbwv+95IwRCCrdEDG5ek3PGydQSVexex5C6hPpbZlwRXFGAXftjESjVVITqID2EPPcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEE7nNmSlgu/vIzBcEOZsT6iVqNDflvlfv4k7pxJ7KM=;
 b=Ar86KoG7Y1+pUwtAFCbS69wPK0EqTh6H/3Tfli00MoRbmGiJMS3vCPJn0QBAxu8SzcRdHU+4A8vTmGb6meDaH82wg5SIFm/w6YupgF+91NcatFNrUk6KQWan/G/DDK/sj5OlXP4UtrVs3LDgEaVNyLSEmunzJLfGMUS+A2CEXl8=
Received: from DM5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:3:151::34)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:56 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::67) by DM5PR19CA0024.outlook.office365.com
 (2603:10b6:3:151::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:55 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:55 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:54 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/42] drm/amd/display: implement notify stream mask
Date: Thu, 10 Sep 2020 09:47:12 -0400
Message-ID: <20200910134723.27410-32-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82fbcb1a-1242-4028-1834-08d855901f22
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1288A3A76495EBA846BF78538B270@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giBuvdwq5Bsd8625M2ctqVYPlrBH/w5RP9QYh0h/aBnRjykMz/x9Pcvi13/AotFJtzgen3jwrSKKpJdzbmbp394wSHsUkBON8V2JyXf63dLjmDUUMo+2okv1I5hwma0+HmJxdmOQK94QmLDE0O2UFX8+gWkorYPWzciIia0OUePQ81n5b/KTzEAbfekzAKVrRqTdkzTZWkPjBDb5o2P9pYbT4xL6C+/n3d9fwMnOqNwUbZnAXvof+ACxXZ5OObDFvZbpmpT6r9SpmaaecUTtf+2F3yan88l9TS6U3JDgFqfj06Y3+1JZEg6Zou5EIWnzs5N0S1uGBup6bGFeBfya7+tJEDDJpZBbTQzz+GCJ0qYsreTEqAxJDIp+D0gqOvwhRB9lulnTlZolAq694+2EFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(356005)(2906002)(7696005)(336012)(81166007)(26005)(86362001)(36756003)(426003)(4326008)(82740400003)(47076004)(478600001)(186003)(1076003)(6916009)(2616005)(8936002)(70586007)(6666004)(70206006)(44832011)(316002)(82310400003)(5660300002)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:55.7905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fbcb1a-1242-4028-1834-08d855901f22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Send stream active state info to DMUB

[How]
Implement GPINT to notify stream mask

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c       | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 16 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h   |  2 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h    |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ce5303c76b11..1190c58275c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1246,6 +1246,19 @@ void dc_trigger_sync(struct dc *dc, struct dc_state *context)
 	}
 }
 
+static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	unsigned int stream_mask = 0;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].stream)
+			stream_mask |= 1 << i;
+	}
+
+	return stream_mask;
+}
+
 /*
  * Applies given context to HW and copy it into current context.
  * It's up to the user to release the src context afterwards.
@@ -1362,6 +1375,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.optimize_bandwidth(dc, context);
 	}
 
+	context->stream_mask = get_stream_mask(dc, context);
+
+	if (context->stream_mask != dc->current_state->stream_mask)
+		dc_dmub_srv_notify_stream_mask(dc->ctx->dmub_srv, context->stream_mask);
+
 	for (i = 0; i < context->stream_count; i++)
 		context->streams[i]->mode_changed = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index eea2429ac67d..b98754811977 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -132,3 +132,19 @@ void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
 		/* Continue spinning so we don't hang the ASIC. */
 	}
 }
+
+bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
+				    unsigned int stream_mask)
+{
+	struct dmub_srv *dmub;
+	const uint32_t timeout = 30;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dmub = dc_dmub_srv->dmub;
+
+	return dmub_srv_send_gpint_command(
+		       dmub, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
+		       stream_mask, timeout) == DMUB_STATUS_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index a3a09ccb6d26..bb4ab61887e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,4 +56,6 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
 
+bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
+				    unsigned int stream_mask);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 3ec1d9dd1670..1daa563c8ff4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -397,6 +397,7 @@ struct dc_state {
 	struct dc_stream_state *streams[MAX_PIPES];
 	struct dc_stream_status stream_status[MAX_PIPES];
 	uint8_t stream_count;
+	uint8_t stream_mask;
 
 	struct resource_context res_ctx;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
