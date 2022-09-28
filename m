Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BABDC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8BB10E9CB;
	Wed, 28 Sep 2022 19:41:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E7410E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7KD/KTDh1QRDyEAlkV6NWuFbK8uZLR6Zrvi1V6uG2oySHihlKGB6I2nbio3XP2CMEu/p1XrUQua17a2MUXCJ4Y4huRoknioyL0SzT0hlZ2dfi0KoO7nZbGLKsHVTcClZ2J9Dd5aK/IdQN/hbyhitrNIpIYzjufs+O0kmThBLKFp2ctgGHDohgmtmqins4F93rpXZMFXZaZjTZSTSl5YQvdXs6O0Wom3ZYYRdIa6YX38sWG19TkBHRNNwXf+bOxGRipwxX7QfydwJ6LkiYc//bfC7GECv+9ljym2jdGYVz0kLO10Ufh1YedIyaO5d8x6N+2Ri6kaOTWPpXDqSTkq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH58G7rTZhK9z6of7V3j093D4A2tP5GX/QtVJd6BwZE=;
 b=d3MqGsuBgalInbmrQZLZ08SGU6UtLR/D+EntJSTC4pu3QVs7zjXF7Yff0jtPt4++T1fDMJsPIppFz8gk9LY/NeY135sq/d7+d9R/UN6FZLAQQi3kOfnLQQ5SdDkK2dO0HcUFb6usspZxWUAH/VGaUShw93o5ZV92ejH/AHPn/SxsHbSPLu2r4FJgCtVrAd4J3cHxpr5MCAbVzTnOkOasNbk0+I6ZJ1yw5RLQsaWYizzuB5QLb8M3kdCv4L0mYJvdHtxHscUg5kK5FekA9ojXXclrVj8PsiYB5G9WTGSZeHcGxiiT8jWhw1NLQQZyTu/WbOse5RQyg5q5zYQqHGEimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH58G7rTZhK9z6of7V3j093D4A2tP5GX/QtVJd6BwZE=;
 b=rxP3Giihi5bH5b90xw5dQhZPAdHyG9XWcErMQc4PFaT6IkdaCLwhMmnxQNOqdlf3LU00mtj2HJmhjoeQ2SPYnafFYxqf/sAATJqHVzZws6sL+QVcTdBo4wdtaLBmZ2PUqGbg1PwpV0HXinA+XiXnJA1pLStSZIe85GqJGjJl2io=
Received: from BN9PR03CA0961.namprd03.prod.outlook.com (2603:10b6:408:109::6)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:09 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3a) by BN9PR03CA0961.outlook.office365.com
 (2603:10b6:408:109::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:09 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:07 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/36] drm/amd/display: skip commit minimal transition state
Date: Wed, 28 Sep 2022 15:40:06 -0400
Message-ID: <20220928194028.144879-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbbffd4-82c5-4eff-863f-08daa189644b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaR5a2KfhkrepQiuOfft9bG1eGHEU9fx1MSWrbvtfRJR8lJYK/aR6DCN6m849gs8WgynsTqc04xSirFDFC7ypgg7CtdYRXj1NcC+JbIlfeD2v7wco4CEma+oNxk6DOoY77fbNymEQT/R/yD9sM6jlQhvp466U0E37Ip6qaRF0uDw3k0K2eGaSOMAsKNeFIuOZyAYSvX0B/FBEKGtYRMUXHxeuhT+3GOaInhHDg2C6FVRDwbmQFc7GbFjiCVvqq+C0gqYhZ8gBjHhWVivQRXqq+Amhg36h34d0pWaDp9U2OGq+/uQV+N8h4tJZjo9kV5JQW9tW+Jbs7vpkrRiKaIHDb+vXDpm6cfIpXmftB30nUd1ReVEoWEFAL86JZ4bMKDLeMNC6dXQjLywJ9wyNu8J0HPEN8v6DFPVVcvgWnFsL7xcyZUBnOfp3FRT1vbduV2IO0Okiitbku9iKfgILOPR2kaLIk418+um1RcJlVOqbdz7ra+rxrz6SU4qXgOVCq76eDX5mqGMWXz9/5VBk0hcFFmGafaAL1/0w6XZOQDsPs36tdjIKjUychg53FTmSRr4OQTo+CgIYzQ9zMvu82SgXuWtn9Lv6JvBE1jDOoE9x8Wc7iPuIABwbSkZ+lSC/bp9fYGYDjkcQSUBai7i1P84/7HrwklhgH0MYKNAK62ZJYa6yL0Da4eyWqzb236kqf/Id3Q7ZM7l5GJ+PVd927VVlYOLpbo/jmIsj98pxsy8YhFTVcgCz1ZVpId1w0CWJrAYhok9t6WRvh06UsEvf1Wo53zuWLsAfFSEqvPMcA4+EnJ2rV5gexQ0XP2A0qy/ZTblCBD7M3XBAyyaGY25FanX9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(81166007)(82740400003)(36756003)(356005)(40480700001)(186003)(82310400005)(1076003)(16526019)(5660300002)(7696005)(40460700003)(2616005)(336012)(26005)(478600001)(83380400001)(41300700001)(44832011)(47076005)(426003)(8676002)(54906003)(2906002)(6916009)(316002)(4326008)(70586007)(8936002)(70206006)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:09.0984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbbffd4-82c5-4eff-863f-08daa189644b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Zhikai Zhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
Now dynamic ODM will now be disabled when MPO is required safe
transitions to avoid underflow, but we are triggering the way of
minimal transition too often. Commit state of dc with no check
will do pipeline setup which may re-initialize the component with no
need such as audio.

[HOW]
Just do the minimal transition when all of pipes are in use, otherwise
return true to skip.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9b7c6bac4760..1508679873d9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3635,10 +3635,30 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	bool temp_subvp_policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
+	unsigned int pipe_in_use = 0;
 
 	if (!transition_context)
 		return false;
 
+	/* check current pipes in use*/
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &transition_base_context->res_ctx.pipe_ctx[i];
+
+		if (pipe->plane_state)
+			pipe_in_use++;
+	}
+
+	/* When the OS add a new surface if we have been used all of pipes with odm combine
+	 * and mpc split feature, it need use commit_minimal_transition_state to transition safely.
+	 * After OS exit MPO, it will back to use odm and mpc split with all of pipes, we need
+	 * call it again. Otherwise return true to skip.
+	 *
+	 * Reduce the scenarios to use dc_commit_state_no_check in the stage of flip. Especially
+	 * enter/exit MPO when DCN still have enough resources.
+	 */
+	if (pipe_in_use != dc->res_pool->pipe_count)
+		return true;
+
 	if (!dc->config.is_vmin_only_asic) {
 		tmp_mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-- 
2.37.2

