Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0AC43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA53F610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA53F610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14716E084;
	Fri, 16 Apr 2021 14:34:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B524F6EB84
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/v5NDGzo2Ic5tKdKXg7eHyh2d7du7wp5Pmr9qFrCfOdvEzKfPSh1oopJWIaUSjT/IWPiw9j/TXsYgd9TAvpUtqj7AWYZwip/TZVJpd6Tm1UFbuOkfJ8HIpr+8cOL68TATvxcIaz5mPR5vBdP0bci4UdOl0+l7rvRfn5ptEuUaNwjI6iCy3iD5+0hXRpqUKe59jy0YekGMX7zzmMNssS4P2IRGLlod31P/R9jt3IfazTTNHdq84/DpPoBih+v8r+paxI7ntMwgCyAEYsdZtExVfUwRGWlDJjJnjgBg3spRa5f5rMnnLUrad1MVzJJa7OW8P1H9KfWGs7T81sWxiHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je4NK0oZjC6BNdt1D2wjqDWFeqHBMFNXOaB3BFsStEU=;
 b=bs+P69HN+SdbLwc8LCpbUOdPg5ddPXz/iHmZh8DFZZDFWDuOYNwGT6HRhs3Fne9VE2yHIkt6+l3oEnJZPvPHyyLJtYUmt0ZJACiEJGoGspBmLpjyOFRVHB+jxIP9vaczJvaXdWh5fJfUHWKWdzqr0IS0PuABbdRqIx6yP97v6T9NE53z1RBUa9DtLYq/I6MYjNFH0aUBYF8hgTz48I/YNJL8SNWYdWqXJGDJ+q4fgAsY/2HA86/v0w/qp2jZjC/7plszNHPCcVHfZPr0ABtu83dYU7XgYq3h5f+rkICyGsxUHB0NwzwcXlCkCU+uZ/h0qN6yRFdwr6lw8GPeNoGPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je4NK0oZjC6BNdt1D2wjqDWFeqHBMFNXOaB3BFsStEU=;
 b=Kzaz7gbzoScqXy5Wyan9Vxolj/afACgk3PmZGmUegKxlbBW841PuPMeioLeUtV6tCmhgbSYQR9nA4Z7T9zN3BS8gChRyBXM4c/h6ilx85ZhICRtDmyDub/C5QQDW5Yx8meqqUVYWrRp4JAchzvzVdRvfM92yXFo3iCn64mlIqfs=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by CH2PR12MB4645.namprd12.prod.outlook.com (2603:10b6:610:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 14:34:28 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::73) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:27 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: disable seamless boot for external DP
Date: Fri, 16 Apr 2021 10:34:03 -0400
Message-ID: <20210416143417.611019-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db9df48-d4f0-4cae-33a2-08d900e4bd7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4645:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4645E46726BA77E38D9605F18B4C9@CH2PR12MB4645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XGx/jFYP2Clvoiec437SSfeSE5rVg6vT2Uq0cinUbc440DfZ4ei4/hd4125lL5vK1ZDUeZFoTWSBFqasgWn5ydNKDlFVRAfeJNRhH5xvMCdDYdFDgPjAoGFmoFWzFFNng81VCc1+/ysACFP8ae9fGR4Mr48I7+6acjnhbW4in4anvlJMvuP50tz3Yka619hfG+Cw7MjnV/FjyTdAOlx6P3RJCFndlx41NFJ/g81Ow92Yt7A8V2RgbO+TJabbAgoibYkoqHMxes4z2+CGg7bqowXrn4/pet1CfGcBpMq2ARmNr631Awrlj2PGGc9dxhH4+vmpLp+zJSNAh5ANQ1yJY1hvKaYYII682pNbKWAAECRusJvIoSwoCURzkZ63tdHZsC/V2KCNqpNbzp7o993kJlvLR7zBsGdjdCtPwi52JlVoENIiaiYmbccDSgZ/rlWB2sCW6cpYtxe8gO5lZrt4YctqS3rxu53MKGQ/STXNnxQcojT9p4vrceMd3SOWgzlmjpuCJc5qYN3GYTy7/vuDjpn0lb9YzErhn1OcG+BdHF/Byqd6Yu7E86L4CZnamTRqGgZTvLfk8otFEHv4uS1M+Ipfq7elZXhiZNX4uS9tFFSe9uFhESOaLeanJCpBA7P/RYXF0ohkrcr8+/8s2VJahPEqwN2Hoz1bO98qMZFio1/eNteh6L5iNZHL1oYx3B/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(54906003)(81166007)(44832011)(6666004)(4326008)(186003)(36756003)(36860700001)(356005)(6916009)(8676002)(86362001)(7696005)(5660300002)(70586007)(426003)(26005)(316002)(1076003)(336012)(8936002)(70206006)(83380400001)(2616005)(478600001)(82740400003)(2906002)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:28.0894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9df48-d4f0-4cae-33a2-08d900e4bd7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4645
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Anthony Wang <anthony1.wang@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Wang <anthony1.wang@amd.com>

[Why]
Primary feature use case is with eDP panels.

[How]
Fail seamless boot validation if display is not an eDP panel.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 724ddce8aa41..ee4970491d7b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1323,11 +1323,10 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	struct dc_link *link = sink->link;
 	unsigned int i, enc_inst, tg_inst = 0;
 
-	// Seamless port only support single DP and EDP so far
-	if ((sink->sink_signal != SIGNAL_TYPE_DISPLAY_PORT &&
-		sink->sink_signal != SIGNAL_TYPE_EDP) ||
-		sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	/* Support seamless boot on EDP displays only */
+	if (sink->sink_signal != SIGNAL_TYPE_EDP) {
 		return false;
+	}
 
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
