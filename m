Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E340C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34BC60E0B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34BC60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DAB6E92A;
	Mon,  7 Jun 2021 16:47:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91866E845
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwbUDQq+fR2m0ADRAKv0jBc15moyNrAPu5YYbgrdUwCR6tds5ST8fc9/dIo0QBDIVG3ZGfwHlEuyxThTLIYE7dgg2OKyR6i9nsa/HmrxTaO9icsoL2QDun+PTL/9YZz2ykWiP02SCWvmOLgF0E8a50T7KNw6CQIjXq0VJi2WVkQ8p59vhM7WzIQSgCE12yWidtOCtK5LeDgVA8GhH1Jv192z4rcg6AeHa7lKPucPnWOp7F/+Z8i8BWiuuYbUJHta8g2MXSnPUo+sZ0Tv0Vt34LoKdXMI8p1Ghv+7SH8DEQ/PKFqiQoTTFACJJXRRnRfiXfUGr7ZnXA61u0TsJq5/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r12WcotU0cFti+N8zBJR5LRIRssnTDrp6Dv/bCwMz00=;
 b=fvFwieXJpDPUvVdD7MxXTpkITx+Z6uV628GuFTPqH2BKfkzC5sqrUFrz8qM1j6ODR8/WkRBFjTfubqojPXHvwuI2YtjX+uug7W7qMEjn8RIM4w4v63EO1nwuwdMhZb0jLCDnMiJl3nCIFdGF/NwnFLx5s9QUmJcP/61E8bDKFUjCmM3bFYgSBBuWdnprFWkxNV1v4EzYkNgDkM43bcYN9ssZ8c7ozBVKEPdthlK+0Nu3xUlxNGIlSICp+pleW9QBuW948Wm2+2XabOL0rewvRtc0/QutQUqmu/GmeYiIcj/7WTSiSCufcQTRGhBC0VKuxMVbvCEQchQNrb7FMSIZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r12WcotU0cFti+N8zBJR5LRIRssnTDrp6Dv/bCwMz00=;
 b=NDmBUo6EzuZimNAbEfDWnFoM2r5+QWqxGPalQRX9dbrSDYFBImlrko9ncf7HSUSyBnSRlJtMGo/70uUZPIePsAJMZ06wGfb7uD1MvchOsFcyO5k15Zdiu2VSnk0OkF/5/Am8P1kYriroCXd4WMngdKSi6FCIpbHjJAQyAFl+FMk=
Received: from BN9PR03CA0215.namprd03.prod.outlook.com (2603:10b6:408:f8::10)
 by DM6PR12MB3417.namprd12.prod.outlook.com (2603:10b6:5:118::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:47:50 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::96) by BN9PR03CA0215.outlook.office365.com
 (2603:10b6:408:f8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 16:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:47:49 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:46 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/30] drm/amd/display: Trigger full update after DCC on/off
Date: Tue, 8 Jun 2021 00:46:45 +0800
Message-ID: <20210607164714.311325-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155ce07a-ca14-4d53-54c5-08d929d3fc56
X-MS-TrafficTypeDiagnostic: DM6PR12MB3417:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3417E35455C7CCA249CCA329FF389@DM6PR12MB3417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QY9QDX44R7cFG0dqOdYOeL+nKrOgpgLkzj6d+3kmv7X+HkOQ4fkeWldrFeX9yskNcd9wnAuvCfXcSbXCIIDn3BKVC0uotGmrXBWszycO1h9Dewmae3lqA+bsyemN/yLO46x8a8crulKJjWoNllAC7tl9lwIPgSKY15/NQkTr6gC6DOmRQntMvkmy5yD2LZmWfpP9THTC4g/eYntOnLBuUuW8YkeCllIhUChCNCLSKea5A5ckCJM+LBWyU0LsPJTE+EBxUFcWJY9YpYtD9bUBBbfwaakmDRo4uXOhgNuyAgeHVEQ799V4DS+GDx5KobfVOqW7Dl90xZIoBG5WK1r+bg6IsbR4d5m4gkh3Ri8lXEzhaJ0Ho9KuoRiq1NDRMLwePcDJ97fIGc1fdgzEP/Lc391ZYAsJ/mJOX2qGwHhqsptqpb3h3YzToXPnQEa2rOF1Ox2FoDdD78xWHYA+nMCj7CEYh9tIV51ibnr+6L5guDobJhxO/+V1iF+Pe89OzYlraHgCY26rHpv0O+4vaQI3wgd/dvilGYF7Yb+ZnfiUKibwc+oQXKMsjqpCx5QWVJfXZpXpkDz6yMijV3BFSXBE1koq22+7SZReD+euUlraa1xI0pwO+Eo9ZcDqq8TSKid+JLhLEmjr1YfCJ4iU1pCPtOrU00kmQZvZlP9Pcyd4UC8X8VV4tmiw0GPt1J9YG+2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(8936002)(82740400003)(316002)(15650500001)(26005)(426003)(16526019)(186003)(82310400003)(1076003)(70206006)(44832011)(70586007)(36756003)(356005)(478600001)(4326008)(6916009)(36860700001)(47076005)(5660300002)(86362001)(54906003)(7696005)(2906002)(336012)(83380400001)(2616005)(8676002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:47:49.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155ce07a-ca14-4d53-54c5-08d929d3fc56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3417
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
During DCC on/off, stutter period is calculated before DCC has fully transitioned.
This results in incorrect stutter period calculation.

[How]
Trigger a full update when DCC changes between on/off.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 34c207f92df9..156ba8d3d4dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1918,8 +1918,13 @@ static enum surface_update_type get_plane_info_update_type(const struct dc_surfa
 	if (u->plane_info->dcc.enable != u->surface->dcc.enable
 			|| u->plane_info->dcc.independent_64b_blks != u->surface->dcc.independent_64b_blks
 			|| u->plane_info->dcc.meta_pitch != u->surface->dcc.meta_pitch) {
+		/* During DCC on/off, stutter period is calculated before
+		 * DCC has fully transitioned. This results in incorrect
+		 * stutter period calculation. Triggering a full update will
+		 * recalculate stutter period.
+		 */
 		update_flags->bits.dcc_change = 1;
-		elevate_update_type(&update_type, UPDATE_TYPE_MED);
+		elevate_update_type(&update_type, UPDATE_TYPE_FULL);
 	}
 
 	if (resource_pixel_format_to_bpp(u->plane_info->format) !=
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
