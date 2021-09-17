Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D1EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624BC60F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 624BC60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD176EE85;
	Fri, 17 Sep 2021 19:26:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D59B6EE81
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbnqjoyop3YEqPzKK2L2vammDDkbpPiA4g5IaHiEUBlzO17RefP0ZNgCmapoegGpK1IeeIZR7DfL6LsWFbAM/bNt6W3WKeUJ/2XnPXyogA6IN5vUMyqupDkJZOCoB65wj0h4M2o37Hh3Ao4mh0h5WBCSn+heSZ5LzI0fgB6C4XdHe7Tf+KiL56hw6cVU29uRXB+T/fzOmxZq3B7YpHcckcdVEP5aa9s9UvmLNuk4JsVakXE6wEarXgUEeVt8wRYGYfd6yOBxatVfBP7bin4YM5GKEhzkTUyvrI1emXKANa75L6FHHnl1ytsdmbOjHNmichcKy3uuJN3pXPKh8S9+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hfvfSmWLcrkHQwaY4Z6jnK6kphQ0B4IkBLRP2RL7D1E=;
 b=Wq5fcS3u1w+//AJb0ExL425Lv9SWiMsxsfDl2X9bGUzY89m8Zcv8XVkZ1juNgDNj56m6C/wQHmz0kX5HMTTP25OFXThwDrbUtbNIN22YjUkpPrOQXtF6Ca8Q4E1iFxsmosohCAsFVQfdeluttpidGlsvNpSiFcjg870ju38QcmqFPXC36d0jFIZV8rnKF9tyl7C/h1Vh0NbBlEJ3IoweT8a5m5tPpDXzAS6nMre0pM5kv3Zu2NT5+UgJAGJhR8dRsnVAex3B3XLdElhnld2kA3gfYsZWGiv83+tDR7aJYAP0Twi2/Po9RtOScIwg3EF4TWEJhorQ2r5dStNdav3ULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfvfSmWLcrkHQwaY4Z6jnK6kphQ0B4IkBLRP2RL7D1E=;
 b=q0pT2XGuJb0RLmvY8tYQVziL2NRjf5gHIXs/Eb2XYI0pXq+8w11nLmGqh9+WrwhrHIKpn9eojbLHEq1PUhm6fcy9F0lt0A1icKPpVl7oAovgCwI44c3pZOK/xA/tgqvnRwBqMXLenourCg5pZHjR79tevfjCXkxq2G0rqiQQYaI=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by MN2PR12MB4989.namprd12.prod.outlook.com (2603:10b6:208:38::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 19:26:02 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::1f) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:26:01 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:26:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Aric Cyr <aric.cyr@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 15/18] drm/amd/display: Fix null pointer dereference for
 encoders
Date: Fri, 17 Sep 2021 15:25:21 -0400
Message-ID: <20210917192524.3020276-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178ecc22-c2a3-4bf6-50c9-08d97a10fc42
X-MS-TrafficTypeDiagnostic: MN2PR12MB4989:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4989E3EC7479BD9B58A3297098DD9@MN2PR12MB4989.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsvp83CBXUASOjzxmH0+zHbFS9E29wZjWENpLC6pFASdkCTWA0EyM3uV7vAGE+kgQ7lXd7ElWovF2AFChjphE97ulbeRAGMYW+wMNi4fsNWzrxcnGhKOV3qsjx49wCvLLOhnpEpxvwpcuFNZFnDIpMkHklHVVrLyydYf6hBFv1SSqBo/yixfxyyUvOOFoQFhnhL0aIs69TRHIsMIMv+PvBRq66PB9jD/5ir1Yx2hyGK6h9zgdpaHHypyI9XF7uuXqRxxC53wqW9vpFg7WFToxw1xrBA9FMpF3MjLbJiu7FrE/oHhwQWSuGUBHYIBFwYPkiNME0CKpoX2nZWpodLw4VS7Hg5tDLPJzgKig89sq7eLrir2B7rktxoGZVogSVUnyhn7jTq4p7U03Wyhath4Xjdr/cMf4x7XboZt3SParhfyjKgTGILjNo2buC95c4IfsuhAwrUT6AEp2xxsSF5EV3hlcON4B28AQKDDAVNytu+fhtLEMjAQZMoB557AFmllPY+7vucLXQquFQSOEp3LWyeui2qMwdDIrgknJKXV+mk3e2bIBmuSqkdi8MN5Z6PZnIqiS5wXOrfjUIunazE854mWQw2ZYNpkdZF6jhN1cF4PRlV392PO5iWAqxlB36cKbWHXA381BKWlu5aK2hbJcbPTl64LbcXbbtAfgg4JqspaGUaNgn0iFbDLnd7s7ypW+xFFbp9uqtbEUd5kqcq8bAfOqZDOS/ixlLxKfhZQBBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(70586007)(356005)(6916009)(81166007)(36860700001)(4326008)(316002)(8676002)(426003)(36756003)(2906002)(2616005)(54906003)(86362001)(5660300002)(82310400003)(16526019)(478600001)(26005)(47076005)(186003)(8936002)(1076003)(83380400001)(336012)(70206006)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:26:01.9436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ecc22-c2a3-4bf6-50c9-08d97a10fc42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4989
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Links which are dynamically assigned link encoders have their link
encoder set to NULL.

[How]
Check that a pointer to a link_encoder object is non-NULL before using
it.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 938bfd8761d1..d6454d80311e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5684,7 +5684,7 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready)
 				link_enc->funcs->fec_set_ready(link_enc, true);
 				link->fec_state = dc_link_fec_ready;
 			} else {
-				link_enc->funcs->fec_set_ready(link->link_enc, false);
+				link_enc->funcs->fec_set_ready(link_enc, false);
 				link->fec_state = dc_link_fec_not_ready;
 				dm_error("dpcd write failed to set fec_ready");
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e1edbfa761f1..c5e2b4f138fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1587,7 +1587,7 @@ void dcn10_power_down_on_boot(struct dc *dc)
 		for (i = 0; i < dc->link_count; i++) {
 			struct dc_link *link = dc->links[i];
 
-			if (link->link_enc->funcs->is_dig_enabled &&
+			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
 					dc->hwss.power_down) {
 				dc->hwss.power_down(dc);
-- 
2.25.1

