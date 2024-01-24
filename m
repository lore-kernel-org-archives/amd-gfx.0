Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA029C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA9310F63A;
	Wed, 24 Jan 2024 07:02:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D8210F639
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyYw4/gUeOwEnwQPh7Jo/9ZRKHethK6pVSbiDHjA3hZelQh9tsuRiJkVKYqMgiYKclLO8H1p4VsTt6O9b8mEx5eyV7gijU3yTiZJx5IVSXQP3o3UXoKp7xxRL2ptmZl0+OevZlySTFZIH/KF1ys/thpY+6WcnzYPs/dsNwciM1zre99CHnCBPmwClUrxvtDeBKNZoyWAhG0UJRPoF1a9+DCKZnVHVkS8BjnM5BEs29rgKrKIHk6LTid5MJr9PDfNiRCTKUW1nMd/EL/E+cIzY4nQr+q7XBhWTyiQHJsDE4Lv2Shr/VFRK4PmTqeIrH0BlfUSxsZkkA9gfTlSwkWoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd9862Uyct1ffcQ2rZNlcrARc791UhwPrdgZAlkQNI0=;
 b=HdVh+e6aRB9doG6zDGEY+v1Q0o47wHKYeJl74ga6jvYlAaiXJ82m/nGonbGWvEoZ7WHWOnWoRDSzcd5Xy9/ZFDLdAi8TKmrPdbYu41kTIjNFcCFdA0j5rfkxcJFQV/6TTVKSAghIeIgpdmtosRcQlt7HbI10t2Q6MiyrLmGAvANbpHodFvvVusX88UeQmW4xQpc6gCAr4dnrPVq4cXn4YyFeE28twGftPCrABP0tbaOMyt/pmTsDplqZJbFmNcX7VPL683BCdEaJCpca6fsWpwy8fyfKBqwrtO4WkCsgjhTLnKyjsWmxoXD5sA7BwAFbDov1ZaMtN5RX6Zb21K8khA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd9862Uyct1ffcQ2rZNlcrARc791UhwPrdgZAlkQNI0=;
 b=g7NJocjHtNZwZ1U9MyuKo21UyMaFbmeUL8ooDkTSGWSUqJYLhuU3c1/XA9/DUwlg+peLxPv+u5AMo7JtcD0GnIWxUc5bE0FUIhwAX3oxwXRLyyOcwvFWe1mAwVkhRPcjOBUi5WcwPlZrWEjYCnw1e6o6X/rCwKDVYtaKxapCtds=
Received: from MW4PR04CA0060.namprd04.prod.outlook.com (2603:10b6:303:6a::35)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 07:02:21 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::f1) by MW4PR04CA0060.outlook.office365.com
 (2603:10b6:303:6a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:15 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:12 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] Revert "drm/amd/display: initialize all the dpm level's
 stutter latency"
Date: Wed, 24 Jan 2024 15:01:39 +0800
Message-ID: <20240124070159.1900622-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 118b7a41-59bb-4dcd-0d9c-08dc1caa693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehNNsZ3FFCSsyDU1elxliUrmX6+au46BRekp3aAKawHxdANlQyTK6ujVo7Z5HxDMFn8HX+NPWbSMvq1SFcIlGcrGGhip4LXkm1xdIAz9Q6gehvtABch+/51vXxqLa1P//dj26juvHUaQMKyd2XPPpCN02H9o7D4GoXGYdVex7tp82xJUx4FLRlu7m/aolHv0/NcZPlsQRIJcAjceF1798u/vV2QTxDjdzklPMSyJtnHqIYAIAE183OMyKaVJcrxLvGWOclegOBnr647mldlJU953JMXljqRouUtfZbg6GHKvI9Z2mg2Cv3HN9FPraXxrJi1uz6/SG9on6DirjPJcTc1Slzc5etoXWlL2wnr7hFBvWtTa/Ran7E2EwlScEPC/+2tlxVtQiGH3YqPIPfwkx0kJmLT9I5PYIcmsGyBNc5xvy97+fIpJBAR0OcyUbuUv5jhC4YvqxyhS2z0bRjd+oNWGPCEm7QtwMBgTlIeDE8keAG/UJamRS/+0f1CQ/bkoh5ufzuGjM9x7EY192/OBTdW65qc03DqohV4BOtfzsUcJ5lJte5qDNAMyuWfYeym1t+l+Hb9isiQEc7sZ1383RoE2d8npow6FcKGgdzuAE3LfejD4LR//7mqx/rYDnwRDpDmQI5/FblhTqqvH09qhWoLoQwjpN6qX6Af7/cjwo0ATmW7Z3NJfmXqb7kRh4tLxTk4qV9skRHgLAeq2ZEmoIF7G4nRe3B1TKeTwodYwliVGYnBpvUW6x+6X8vXBIrTrWVStjDqwUP4grQyOmHmnAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(82740400003)(70206006)(47076005)(86362001)(36756003)(2906002)(41300700001)(81166007)(36860700001)(356005)(54906003)(316002)(8676002)(7696005)(70586007)(6666004)(426003)(2616005)(5660300002)(478600001)(4326008)(1076003)(8936002)(336012)(26005)(40460700003)(40480700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:21.3766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118b7a41-59bb-4dcd-0d9c-08dc1caa693c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Revert commit beca01e909cf
("drm/amd/display: initialize all the dpm level's stutter latency")

Because it causes some regression

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 64d01a9cd68c..8b0f930be5ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -341,9 +341,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		break;
 	}
 
-	if (dml2->config.bbox_overrides.clks_table.num_states)
-			p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
-
 	/* Override from passed values, if available */
 	for (i = 0; i < p->in_states->num_states; i++) {
 		if (dml2->config.bbox_overrides.sr_exit_latency_us) {
@@ -400,6 +397,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
+		p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels; i++) {
 			p->in_states->state_array[i].dcfclk_mhz = dml2->config.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz;
-- 
2.34.1

