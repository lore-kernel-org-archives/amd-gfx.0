Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8FCEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BE210E6A2;
	Fri, 23 Jun 2023 19:41:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A702610E69E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axra//tW4FbP8K13ZvEXcVA2ejuLQDg1HZZ+dfed4nJLoUVuhmfWL8yApcWd1uytO3nxbLn7phJDturEbIcZpzYql/6BztA2+rlfd13yK9Ab3zMyi32gjZEvrBtqD0HuKNLoNUsMmbGdGGbnZK5RML4Ecc6rMPwlncgWr6VpAjuXQz+WhNKDYWp9PieqSk/tsbcHXVLzX4lJuN9fdxKHTwwboOPzPWJi5UEQ+ycyFcmGGRtwC2qnMDZE2pP1AcqJV7LBosYlZwlzyiK4vEreArOXm3kLNbhSZlxxFv3AvJyWbeFgzjlrYrOum6G7fja3iNM1i9RvsTUIVBqpJryqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJUv6WoXWSItL1xk7ro1LRxDHBhnH/tn3rpIfs7n4aY=;
 b=cawR4bnMoU48O2lnkn7ga2hNnAwMhmLfY18Xj0Dtumza6EHSme+7RtbFGByaEdV22p5AOLkTeSi7zQ59n8UGc+0t2dmvFyXo/d0dsqWJUHI66u5XGawDjpTHOFLnh5weLbRvjdNXjAokf+dnlNyl6fYvC8t9S2xmnUG1M13dSZg9MM48JEeYJ02dYymOGySlPt9YCbZuzPwjI/8a6/WyDq3b2oulNMElBBlK0sGiZ01fidYJPkutz/f2xQXn7h6b6g++Ulw4mjTWkLnVRc8iahjIpK37n7Yy8SP6Ni17L5QI/HdEgmc2QoBUgtE8Z5DQyMv+zIZ3WC+7467wlLCuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJUv6WoXWSItL1xk7ro1LRxDHBhnH/tn3rpIfs7n4aY=;
 b=eWWSeP8o8rneB11HPIotkX2KOsu+wT9YU1dmd7MvFxQTWMx00/WJZrDO1wjc6JmbboOuHB+bIaBB9w7LuNgpX41ySeBRyJIXpXa6Ztq/DTz8cueeDsdtrRt+G0pgPd3KAmqiHGbiYq2qsaNzrCmcBTWaytYSpvl6/fjDFoq8zvo=
Received: from SA0PR12CA0008.namprd12.prod.outlook.com (2603:10b6:806:6f::13)
 by DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 19:41:05 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::6c) by SA0PR12CA0008.outlook.office365.com
 (2603:10b6:806:6f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 19:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 19:41:04 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 14:41:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/4] drm/amd/display: Set minimum requirement for using
 PSR-SU on Phoenix
Date: Fri, 23 Jun 2023 10:05:21 -0500
Message-ID: <20230623150522.32494-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623150522.32494-1-mario.limonciello@amd.com>
References: <20230623150522.32494-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM8PR12MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e71a3c-7b6b-40fa-4245-08db7421c889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCUFHbzE3asYkG4ShYAU4G9b7hG0/IsVcCCBBNK+kRi0lhSDg4rkulI8e4h+wcaznPZE8w1Iquk3A7huCTIoiKOlI3x+T3PyE/ETnnJ/zA3pFfsbk1sX+tFdwebnkxISvDjSB5n1Hr3puqHqF0L+3zzEIB9pEURQ9dUwdzWi2FI4/Zjpr5/+ZSUhq+QTt9iAAkSn6hR/m0wSfoj2UH3zzy18hcjHY4oLodZm6QSo0f2KGqQz27XRB+dpiK1q/xOMNV9qEra2mFzhtMXpS+UB/hXYddzKQ4qP6UqfezibOrqft7AYS9mW2czT+d9A8UVSd6UE4ESAfC1U+eDh4KTX16L0+48HFvqtvv++tovzWAu60WNJKv49DivBWv6H8FJbXoLgyGMl7lzKjI7KQcLiO9XjXE5S5b71lxKnLlVReZCn5D01tOEKZaLlLrdK/RlF/DsyPjveKCER1jTG5S7jc0wehAh/ZhKrgdCNny8JP1Cp/V26jrPxPEHc8jB6BPQFsT7NdXSaQk/wzovEzrYv3Rf2sT1vjH3lB0l1aMoYLDvZ14TPuuEZAHJiJ1y8FxKEed6jPYmcXDoEngxokF1NASJxftdnIBUpQ7fXszgZMBNDY8WhZKHVpBy1QndbFg9VDW4bUp2Q2TBcS50+b1UpA0zCJX9TAex2mbfAznk48zMs0HuGx+FF3cpCrszeZxgJrbgNcAuoAKUA5plLGlOLiCR87x2va70DdIII7llH457MSM/FSBPVXyxW6dXFyvWiIQ+zb/ygbKJx9w7qoPFAtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(7696005)(82310400005)(356005)(6666004)(82740400003)(81166007)(2616005)(426003)(1076003)(16526019)(26005)(336012)(186003)(47076005)(36860700001)(86362001)(54906003)(41300700001)(40480700001)(316002)(478600001)(70206006)(6916009)(70586007)(4326008)(36756003)(5660300002)(8676002)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:41:04.9769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e71a3c-7b6b-40fa-4245-08db7421c889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same parade TCON issue can potentially happen on Phoenix, and the same
PSR resilience changes have been ported into the DMUB firmware.

Don't allow running PSR-SU unless on the newer firmware.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
    * Fix a s/dcn31/dcn314/ mixup
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c | 5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
index 48a06dbd9be7..f161aeb7e7c4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
@@ -60,3 +60,8 @@ const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
 	{ DMUB_DCN31_FIELDS() },
 #undef DMUB_SF
 };
+
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(8, 0, 16);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
index 674267a2940e..f213bd82c911 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -30,4 +30,6 @@
 
 extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
 
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 7a31e3e27bab..bdaf43892f47 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -228,6 +228,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN316:
 		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
 		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
 		} else if (asic == DMUB_ASIC_DCN316) {
-- 
2.34.1

