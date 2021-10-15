Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C82C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32C260C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C32C260C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BD66EDAD;
	Fri, 15 Oct 2021 18:44:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBA36EDAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP6WHov5uEx5gCl3XiJ0qtO7jxTvpSxyArzKI2taHZfiyf08pH8JQxwmA6zG8NHNP7MbWgVkfgj2lyZsM8DToU5J1I/Ts4TAMaQhKpQ2MMb6BO64LAgBvfSK9twu1kZykT/wx/s5X6qskXb/kycZatXjFYUnCvoP99riTaeqMS1Ix2Ww/oyj5GLFpE3/a1M1Zxwb6IFPDLBwe16bK13FScoDa3dzwQkr5+67ESTAPlBsOMj4KiGTaLehNricA9Ep2swXRjGSsjkHHMI+ZT9o0W6aKtyEO+9C0TpiC/+NMQEC5Rv3nupQCASNLrab8P/7uKW63PLzVrEp8/aDx6l/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGg7eW3szUnYyOtn4a0INy4g+yv8qgUIG+UqeKcnzno=;
 b=M61IwedySChTbRTOiiyu0Vqg9YoaMwN7kSH4NlIVbuDvYR167LgYCAQdsAU7J8hJwk+NYy7AC6IdzFr6EiZ3Q0KpuPMKgSg87apwyi/hbG4TzA7n/vvA6wHe+6DCqurxrcBnHpP3Q++4nvlSt14/NseMyK4CqzgkON0mfZr9uJh8JwG7Mv5WDj6U6DME1p8bblvTYEiSPg4nTIrwksYpAzUfwRLzN/3Hvdu6Sq6MiFt7walPHN+0+elNKyUBo4dTOPQSiHEkyKSJkM7N4+oVQ+DRy2pNwW94HGuF+1HtC7+TlaySNflATMydgK6MFBgst0FVrYrOdHCseFKWJECqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGg7eW3szUnYyOtn4a0INy4g+yv8qgUIG+UqeKcnzno=;
 b=Mga0+fpTwvGowvxvJfq9CTqJE6WuGna4CHoSFFKzZvkzjrzjKfV+XYn4XmFfMrNs3Kzkma2CQvycvotH2JRkVPeR9VKazUtjhejNIa2XFAn9JioQNhYrpN7pMpkmRrLlGmAxfRQWtwNZNimjxG+FBtoJ5tOVlOXLoyq40p61Bic=
Received: from DM6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:5:80::18) by
 CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Fri, 15 Oct
 2021 18:43:55 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::9d) by DM6PR08CA0005.outlook.office365.com
 (2603:10b6:5:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:54 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:52 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>
Subject: [PATCH 06/27] drm/amd/display: do not compare integers of different
 widths
Date: Fri, 15 Oct 2021 14:43:11 -0400
Message-ID: <20211015184332.221091-7-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a792ad-6196-4b20-f5a8-08d9900bbda0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119F56E281CA5FB6670F470F5B99@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4sIWS4yOK9KSWJX7jhoRVj9iugMALIuI5yOfCKp7fJwtSt2pknPxwxomO+W2IDzJ7qgaq17iGT4m1yUQtVCg8giioN4rP/VDdoUTxhRHXzscW3030IpSzMZa6qjm3rA0nKftcs0lD3HljbnP+KAavnKecxxZq6E6GEhswMHStzKUog08jmSfKV3fw4FfuGwVt0kjw3DSjzrq4cAIixLi4Mwcgpz/xG/hC3X+ozFR0+pNKLzIXAOHXSVx+GNg7dcmxL384KI3TKSdUrslrdBrErrt/7BpZ2XgzYNDwhm0B98qTq8+uNXGWlvNBiIQNpmlDr0r+wQijr+185b30P1z9cplST+jwj5DVr9FaV/tYYWVQChBMP/RpApZfz8jm9KrXPz/FMdBVvjZRwib3XEG69GJGoeJTazubBrJw5qJpWj06GA2PxKdoG4Wyt9GGBZZTN+P4eSAIirgHIBEXbJE1uBANopqMkZ258xwKb+sxDB6H6atZL8v5ScVfvU7SQfQsuYOZ/I6uy/27z4VrAu/Jkpd1R/Vpf8sE5xPKf0MohO7jLYIZvzo829Y/3tkKmuCo/wLVf0LYgnibRo39NYmJfU6+ZFPU+mHyJTzOrYUFv75xXlbQR6+gdj3NMgfC6qFmlLd9pmaHylk0Yx9nLf4ckrrGicHsm6Izm1MlgIx/Emqwe2I4dw30gbQ0bppJQo+kTQCyRQz/B4hS4Dedw1n9QNfYTnf0zpBh4Fpd/Invc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(70586007)(508600001)(316002)(1076003)(8936002)(6666004)(186003)(70206006)(47076005)(54906003)(26005)(44832011)(8676002)(81166007)(2906002)(6916009)(356005)(86362001)(4326008)(426003)(336012)(83380400001)(82310400003)(2616005)(5660300002)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:54.9318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a792ad-6196-4b20-f5a8-08d9900bbda0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa11a2b094ba..d54592b573e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3439,7 +3439,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
-	uint8_t i;
+	int i;
 	enum act_return_status ret;
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -3531,7 +3531,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
-	uint8_t i;
+	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
 	DC_LOGGER_INIT(link->ctx->logger);
 
-- 
2.25.1

