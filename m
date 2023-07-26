Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA30C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 19:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1A510E4B1;
	Wed, 26 Jul 2023 19:32:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147B510E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 19:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj9lL5FdSIjohVMh6+7bPXc3ixTa4loGn7uCY70s8M9mn6va+uZw7N3kxbPCb/ogbjzJgfF2G/9Bx1NaynqJp4T237cpE7nThMd9tIXzaXg5TRB6QMhuVfxmIkYV7WLw/4Plz0y4TUt1yK3j2lzHgO/IUqTo3HC1pCbMOY/LfxnLn3PzFUI6i3QQ26Hy+dJsqA+nPCZ8HhjqYeAVNl5iS0uZriU+5XTKbcmJVjmHGwxKWtzJzuQwA3Dm6k9YVuRKVqrV2i9bNqI9fjVcjarBompOcGK/4A5Fb2Qyaq6uMB00TL6c9qR9mcn1EmE0/24G4AB+447RY+uzH9cpWDPiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E18a4kcGeAqhCJKy66ZD3pPRBh7O8Jjq55vgdJG2wss=;
 b=T/LknbKv/QGV5VV//2mdAxQzI0WHWHJ8Yq012KVn9rfUTqzOI/kA29MSYzYHp9xiLtKin6LhILEnVST07WlfiKisPkIo7nFn4Bu2cKqV0EGlrTx+g1tx767CAD2gen6JeFSiq+yzZZkohZC6jQAbA3yz08j34dN3fd/JUAOP9UqJDKMN+T+Kzo/zSvfHIBoErNKBvQRvY5r0OruDovxjW3zt3SUbDvkXEEeIAqdf8iuRn4dOUUAdwNQZ5uThW+JjxvcHmALd5LNCaei3QM7NZSiiwGIZlD3Kmwq391PkIcSQyvsswzam+Hpol9QnUmt5k4L9Ww4CIo2YxG3YY2bWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E18a4kcGeAqhCJKy66ZD3pPRBh7O8Jjq55vgdJG2wss=;
 b=E+kC1NyPOOVwymxZcjKAXFAvyTSC9gefEkueuJcLr9yKwJIGZGbAMCVXjyCcsWUsmytIETPIvJQbc1fZwZyEu27KbKTwuhcfb74VWSTxkyNN2iL+ehVS3Vq6Z6fha8kuc5shMs11lxAwMdR9Yn91QIDvuWIEVOCsF9X+FpJFH9w=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 19:32:18 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::83) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 19:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 19:32:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 14:32:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 12:32:01 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 26 Jul 2023 14:32:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/display: Implement interface for notify cursor
 support change
Date: Wed, 26 Jul 2023 15:27:44 -0400
Message-ID: <20230726193155.2525270-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
References: <20230726193155.2525270-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ae4bc5-d980-4874-f80b-08db8e0f0646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xN83jo/VVfmK0BEXnzq3yvH3FNEZbQyGA+wS200cPgviLdqcJyvLhVxfeKKCDMRVNg/n+zgK9QtbmTBx9q4y8YFBxuRfCjqmLp2/ypqcOcwebxVgoUwwh40GbyRpUMXa3BhI30+b+p4d4UgmtkFNRY5xVIU3ABmZv+2hUmAiaeKyTNs5B9kkBRgh9owGYKlkkKdjXo70r8lyvMbZlOYPtM+Yqs66H4Wh5PCx1p2UzfMk/GUSGcJnF12ACaowoe314cqugOPMD2JU4d7LFP65RFLgUgwGhA65FDNRVWcASWzuVZy1jf3ZnxBn01MBVB4d1po40YHPfWAcRwA4HJLJqYAY3zIcNtnBBsvbe3eTKSOEIocMm29bfyrpok1sIMgpeYWqU7Hjmou7+LtcvENksIXkSOlT4IoTsn+1qTFQF+wr78OG6oiEfOQfiKkOwKeLeLdVYZxyg1Yu3S1068u4I8hudooJW/XpJ5fnJzMgP/vGCTxwecFuGWAtKUB3VPhf0hCPFiRfSrhW7eIuvf1JK1nx2Vcgf1YGVUhPagkuWm1NDOxCysEdfYKjjVzcwXkj0w35w/P2lIZ0d1ONGwGUZNhQwnxD58stAwQjhpwEdqjxzwNDQm+W8D6X0Mkm2jB2a5pUSrj/82ts9JZcGsl+iF2odvsrw/btFSvoAjdwcyqW4qGd8uyYkQ/VOT4fsi7Mnwe+ba2jDCIKvS59nprxrROQfjZdQl6PyeZGDnDkIM8wZNS74B32fuasDOJrrvBbMhvf9pAHGax8bwtwDX6kkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(336012)(186003)(47076005)(26005)(2616005)(36860700001)(6916009)(83380400001)(6666004)(70586007)(4326008)(316002)(426003)(5660300002)(8676002)(41300700001)(8936002)(7696005)(70206006)(44832011)(478600001)(2906002)(40480700001)(54906003)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:32:18.3556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ae4bc5-d980-4874-f80b-08db8e0f0646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Add new interface for notifying OS of cursor support changes

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7cac14f493f6..dfd31b169412 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5337,3 +5337,17 @@ bool dc_abm_save_restore(
 	return false;
 }
 
+void dc_query_current_properties(struct dc *dc, struct dc_current_properties *properties)
+{
+	unsigned int i;
+	bool subvp_in_use = false;
+
+	for (i = 0; i < dc->current_state->stream_count; i++) {
+		if (dc->current_state->streams[i]->mall_stream_config.type != SUBVP_NONE) {
+			subvp_in_use = true;
+			break;
+		}
+	}
+	properties->cursor_size_limit = subvp_in_use ? 64 : dc->caps.max_cursor_size;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index eadb53853131..0b704f1a32a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -908,6 +908,14 @@ struct dc_debug_options {
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
+
+/* Generic structure that can be used to query properties of DC. More fields
+ * can be added as required.
+ */
+struct dc_current_properties {
+	unsigned int cursor_size_limit;
+};
+
 struct dc {
 	struct dc_debug_options debug;
 	struct dc_versions versions;
@@ -2276,6 +2284,8 @@ void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 
 void dc_print_dmub_diagnostic_data(const struct dc *dc);
 
+void dc_query_current_properties(struct dc *dc, struct dc_current_properties *properties);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
-- 
2.41.0

