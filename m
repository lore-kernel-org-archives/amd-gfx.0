Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BB9C61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7359E10E3D5;
	Wed, 22 Feb 2023 06:41:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D8910E3D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFFz0nmCM2erNTwSSOlK9jvDDLuB54EPC7rHq6faVSbXRQllA2QgxrXZ1TX7hKDUlV86jlbRlgNAZEMzkDL/7rVj4EYZPKjtPP+R72M51Jold6hQXCg0oDyp2pzqCCUI1GU27M4KnJpIp8rThKZ2fuA5QrPIDXr1quiH4ALY3gMI9HBiQ66GfVAzNRhhavkm5cS60k6B+winXHq5VSQLrvmrMfiAuotFNFGz3twnP+tKur3vgGIQjWlfBj0m/85B374+vnZcbBaNiQ7rySXR2G5XFubLhgzAm0vGpEyV5LGl0dKmLP8QljuxONQfkY4BDuaXTEMUY/q29F4AoQtCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA93J9KWaccZXc85Rt/fJH+2IaJGr2YzL2oB0c83hpw=;
 b=WpeN1+momK23LXTHUiFh6WiKvN8eYH+uZeKDY3clukCKt60pSBGikmDQ4m8pjbH6GJupIzquumtWuoXb3HsJ4/AuLNuSeP7f6w7qG0FkLU4fh2w8uMm5QUSQquD4zOQc+9g7v74IYoZrLF8grk8oICJ+jLjxL2SpkU18rvju4ppmsp9iYjGguj0Y6eSsgSRFShbs0fV2b/RmgYtqNVZsT7YhPDvUuTUh9HVXFzpFZnKUU+woLwZg/dhFjr0XLTpJRkjZBo95RNbEA3DmRx3/3lXu90myPdDnex5duZhwMGO55rAaZC2tNSBlUNP3Qg0yiGQKLJAR/3b2eXRDaCXVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA93J9KWaccZXc85Rt/fJH+2IaJGr2YzL2oB0c83hpw=;
 b=m2l0TtQHzwo882Aq44ZvIzqUaz7mpEz+Jf42N8Pwl4y6IEC45fN6XFm346vo9izLES3Kyk0Wf1N41oe4bZN7PEkPdS2wegtnZAkrbU7hxI0sVNzZheBQxVTfdzbwD5jdQNbEnIXa4IPg7R/kyWz65hOywxYxZ/qXGoZLZirfFpc=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20; Wed, 22 Feb 2023 06:41:42 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::d1) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:41:35 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] Revert "drm/amd/display: Do not set DRR on pipe commit"
Date: Wed, 22 Feb 2023 01:40:26 -0500
Message-ID: <20230222064041.2824-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e3208d-5d80-4e99-7a08-08db149fdbd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uj6kXc8uq3YeM790vr6Y6VKqHIi7va9YmdszWCI8RprmJBqjgbVQ3FZ2OJzC2kvlH3un+WOMr1UOT4GnP36MSe2nGbeOq162YYKdYMT3VrgI9MyuMn1jmd8QUtsFfgDrbkiUCJBO8lTZZroAoBxGDG6dxDielwK1B28kn+IBv92dPsCwaDLu9znj+aWXhEOy+Qq+bAb15/oQialZ5UlNHN307x/GlVNB522QrCTAg15lifgXyNWahVBEwCemWk7JkexyvULl22fyyhgXcla6ZLFNfdw6dM9ESh0V0T3ZpJWCkqCRVkwH9Ms95iQGgaCBzrutxxc0mnmDrkhWWEL732FHswfOZRojW2gtZyqhGYWWyhPRpJTKwAF78LV667T3frER8WyzQvi5QQ9TKzmsh/gyJ0+2NqbJK/ELVfmGAAcTdvUFh+HLRNI9IL/T03ECMYGI33NLn+A1Cht528yX2E6friOxbWxHP4LsdfAVWyLCJuVS8Qwr4IviJfl50a4oXYl1vQo9iqa7j1JS4Sxao+N3PdsCq5KXG0WaPGm7/cfbJsSTmqxrP8Kpqm3lQuF7YU/8JasAvOJFV/kPVSDbSxWRT7gKqdeqvtXi2IChLaFehajpHR3JYPad+Qr9gQ3UYTZucFwVEIBnXv+wment/zp2RWtNcbYlfeFJRLDzGq4Ug9560UT6+msC55ryw7g1pyHtqrQ8Nia9ihDKQc34t5kgmyeftjkcK8hd8b4HIBc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(16526019)(26005)(6666004)(186003)(2616005)(336012)(54906003)(1076003)(478600001)(316002)(4326008)(81166007)(2906002)(70206006)(70586007)(8936002)(41300700001)(8676002)(6916009)(44832011)(82740400003)(5660300002)(36860700001)(40460700003)(40480700001)(36756003)(82310400005)(426003)(47076005)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:42.2832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e3208d-5d80-4e99-7a08-08db149fdbd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit 723a86ab744043dadf9ff40b34be81efa78895e5.

[Why & How]
Original change causes a regression. Revert
until fix is available.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index df787fcf8e86..3b4d4d68359b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -998,5 +998,8 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc,
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching, context);
 }
 
-- 
2.34.1

