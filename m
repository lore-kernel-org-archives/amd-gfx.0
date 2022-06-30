Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF6CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013A310EC70;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C22510F8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5scOgVhOyWY07kxTZzRvyn1kSmtfTstLVUnhVWPLP7MGr+b7PF/w/QOruqZOfzfMazvdXD0pHiZu5UixYMTiXY+HHSS1fIiu0ECtw5W/71zmKnQ4XTOA9GmQSCDBaNOpcxDB5EP/S+Xx+L8ri3Y+TEFp7dqplO16htbMQgmRAxnQT5m8qL3WYyFWX0BUz2iCqnAYcjLXUhnStqqy6KeV37a8a0CgWkrievcdh18gwgBUfXGzzLkVyQViyYKq5sfX0DuKuApPAJx5WxFJ7O4DT/JAauOHBpkBC+RyyHROmieJiL+fiKzuXluGJDN/pIJ743hScKG/9Ft59B7VMBzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0+/rtAD4OnKpI6VW+dy7HmwTdYsVNMYicOLylVbM88=;
 b=L0+eWMON6He+ajmsk0Prf/JRuBB8n4isA3AVZXwc4ITQfrR6gmD8XRsDdOvbdxsIPCNckgyVJQhX4/FrrGjD0MfiG8T5CJSwGA4oIe/R983iGrw0uHXS4mRYU2dwCafKj8s7+anDMesyAU9JQIce47TFqieekWBoZGN7NtrBRDIejt7NDX5qdlZEuo3OuzbNGogsYHSlnLkMEtdfT8wezM4p4u1znWX7WZnDNBBKovIs90Od4uRPqQW40syL4Otqrpmkl4RctmRuhZdibKpTpqBfp+ve6jU+ysjJN13e5lbQKBP2SuwgGQIwTTlZ4lc4UjhxqCQBw+Eqlu4XkLaW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0+/rtAD4OnKpI6VW+dy7HmwTdYsVNMYicOLylVbM88=;
 b=yJRX0n7qmoxHYT0VerAcYGj6yn0hOKJw+PcjMiRV8PwJCBYqp0QIEOIPK/jjm1MhL1lPH2siTyL3ubgLhUwSvB9+ZxZcOIteCCpGTxxDJhnyf6XNbZnCMc22EIHfhs3U+E1FRlhU2gEtHmzGUfzbSJFjE4UOXvWNqwKxUBrbc9A=
Received: from BN6PR19CA0118.namprd19.prod.outlook.com (2603:10b6:404:a0::32)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:15 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::1a) by BN6PR19CA0118.outlook.office365.com
 (2603:10b6:404:a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:15 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/40] drm/amd/display: disable otg toggle w/a on boot
Date: Thu, 30 Jun 2022 15:13:08 -0400
Message-ID: <20220630191322.909650-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd4a693-8393-4a1c-5ede-08da5accb94d
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xij/BZDZy6QXDLTLLflabWLHjatm3LqRA3KS0BzhQ+lbbbBWHt9rnKCl8dZcVex0p9287ASLEOety5Z50rhNW7T55sJdSwdoj/uPFRPiwR5INn/D2XPAt92moF94yjc7jJ8/2ORdzzYHPB7QOgr8aIkNCYBKgGtMi9oJKp2+IEwzK5A6eF8XR1pY+4HhO8Fg9/dpQssKlo7jXvOrMYOqdxhKFOnawMPLAEFKt5X4DXT+5H8uq2lJLUqSch5NvtL+9MImjiKa271g7D3LmD+aFwdcVMXTjy8PVqYfuZhWXq8UPc1iLEuMaTEZUYgX9u2FbXTIHhaEMYA2tx9qQg/Twm0JRLIUbGMd1BRlQyyrrNdt13RsKPV5/LvPGHD6zVPIIL26UU2xYs0mQlvQ6wvm/q7J0qxoiC920Z7P8ATQVbISyOnEnqBpYonDKi9/37FJNOfW3SqVTldB53oLK/IwP5u0GgjLS8XDts5iLogzf1t3iWKWqcqNRgs6cVBRxQV3E08aV0pYST+EASY7PVXtD/sD+w+Hl/7lPTkwdVboVu2nboN/erFAW/3dkfTr7WnDLcgrVNZt2zDEXuQxOIwMepE5IusllnWhmeU4Z2h6Gh2NC7+o3xW95u+ss0fkgvfQYA5nJR/OTfNkozn768vKsFEaWJhpTKBc88lOm8zyZzDCSZlQfrxxCuph717mBT/LMBJypKzGAmWVjqKUpbnhKrkt5HxCK8sAO9m7RHqVnn+jP69fmaf+A1erDOJuPbzW87c+Lx0LODORO0kvG0XPdKf925KyVxgVSrLKN+JBl8rDukOfbjza3iackIBoLaDzPAORuIRl6VQzJYXepBqkHWyolK/498QqWCOL77XpWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(16526019)(186003)(36860700001)(426003)(40480700001)(47076005)(478600001)(336012)(83380400001)(356005)(40460700003)(82740400003)(81166007)(2616005)(8676002)(4326008)(1076003)(316002)(6916009)(70206006)(70586007)(5660300002)(7696005)(26005)(82310400005)(41300700001)(86362001)(8936002)(2906002)(6666004)(36756003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:15.4405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4a693-8393-4a1c-5ede-08da5accb94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This w/a has a bad interaction with seamless boot toggling an
active stream. Most panels recover, however some fail leading
to display corruption.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index f4381725b210..36b0cd47c1c7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -173,11 +173,14 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn315_disable_otg_wa(clk_mgr_base, true);
+		/* No need to apply the w/a if we haven't taken over from bios yet */
+		if (clk_mgr_base->clks.dispclk_khz)
+			dcn315_disable_otg_wa(clk_mgr_base, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn315_disable_otg_wa(clk_mgr_base, false);
+		if (clk_mgr_base->clks.dispclk_khz)
+			dcn315_disable_otg_wa(clk_mgr_base, false);
 
 		update_dispclk = true;
 	}
-- 
2.25.1

