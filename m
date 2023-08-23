Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36160EE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC13C10E46F;
	Wed, 23 Aug 2023 16:04:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5542510E46F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnlgG6Ltr1jjXcxpGMptBOAOa/LfY7s9FCyOEg2g/ENjl5BL23KNS+jDxTbCCV2qXeWaFNt0tuPqLO80YSel3MYyHl7nGlWWTgfpDfilqQrIIUR/K2p6Bf3Dfh/AHLxYezKR/SBjJecjoumMIh6cL2XZ3U1Dqws4UP/LGxjUIzJf8IRfa7IgZDkKIGQpXsbQvm8bW7aCAFrJ70VgKMa8TgihconrKmEzz5+L3Pj2K0gaWOVf472WI6lROjF5qSMADdvotTLIhgGAK3icYAawvSMFatMJzA144pmoGuONPCbWb8xQlpallQlh8LoM1iaEhhqApo959gCAWNV/ZmBgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDuDLwnt5x57f0U3slCxZqUngWRcDcCPBfEHnTDc8C8=;
 b=IMyToNNm3HMBItJ1UuoYrN7prixSou1n6qt6drOle/c7rzV7xNIxqLrpiGuo6dWs+KwAOrtEvuHKJMRbGtlBr3DpUQSx2CZRzK/6BUmWle5ebj5fRQ37ymlVi4qtYyGHvZFTrKpUU+pSAfEVvq/4dpW+iYkHcX+nZ5/AGnR8eIcIk7xMGeEsntllpAkK92tw7mGlCPvxQDHKVYV57mShsrOpqUag6TdoVY/eMNT1lvZe6h0VQWSDdU6rMoWo4YmbPk0di9NDQkpH041L90w0V5NnMuW/y9za1WZJYo1tSdaM0tWvTsrcY7OauejmO2qNNvtyB2B2BLXWrX+z543wpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDuDLwnt5x57f0U3slCxZqUngWRcDcCPBfEHnTDc8C8=;
 b=RKMPnp2z77MXGoQsAhVk/e6C0ViM4010Oe9AyDCxhPH4gyzeoJ9DdEPRAR4OOq0NFzR10UB96mKnLATgKVK2b5sTIqGyG7OTVuBYHRK2kTWRB8RfkKnVeYKc1wft9Y8BoG/EdRYQCmou9A3E7mFcNuWGZLIydP1z9hr7Rkmi+a8=
Received: from PA7P264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::11)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:50 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::dd) by PA7P264CA0106.outlook.office365.com
 (2603:10a6:102:34c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:39 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Fix incorrect comment
Date: Wed, 23 Aug 2023 11:58:19 -0400
Message-ID: <20230823160347.176991-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6394c35f-6395-4d09-e0ec-08dba3f2ad22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dBTPlJPguNdcsctzQYNhCPgdyHd8RVnSRWsEBbtPneOJ7HBEuWekyDYkysAW9SpvPiysX2mp6ZqIobfr8oo6+csjuIg4TRpNfXCmQjL+l2uqqDmOUxi4SaKtdGxxaDC3lrWnzrvbS27ux6q7bVU+nto/sG/Ix9i8Hhk9qHCpniGkNY2dEbSG1Gfs2MvIu3ug/WTkLymJIk5dsuPI3brTswGWohUv1miavkV8N1GVGUlsGMqTdSNEMPcf/Dnrr0AYcPLaM6ikgUSRD2f8chBNul9E1S1t4MGEoS7Z7E8mviCG+6rfpI+2R4esXLF0C4TewZ2oKQaXjBzv0UD4mfbGeMgEmA9rxwH0WSJ/+tzSm1gllIe6+N29CoUltK5Z9ljKMBcf4W+iAMKb+oLHedsSVRE9eTeoVsMnY0dgzf/uIUcagxBtG4iNgoYYFbgJemRlDae2rvZ2TBPj74NV1sAqcGGLCYArv57KIi1sox8PuvRh9miuxwtNPtt3xq5PW2Ht12H9pRQZQUZr6uUgyy+KK1H4hE8cfgi3Rk39+WnjQqVGvfkkFhBcgZKb3oAPjPbpX5bbfipW/pVhRv3y2Re2F+4Rb+M/7xyY3DbwZUq/qooHlIXlbpYAqW/FNgt3chYBPdkAvkalSuNyZFX18XeyB9gzqOaGd3F/fvzSiIZmTfC/M16jvovg7ziRTalWrQexePKstx3bNsD+3z1Rl9bAvrZnVC7ACFh5WIWzdAULZMeAsD7akMRbbo1SyP+hKCQvlnRAa9orzzZtCUVN3S+GBcoWgNzuCC1f9vy7zz61vysdjOVYjFS5KeUGYgWDL0C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(36756003)(426003)(336012)(16526019)(26005)(86362001)(83380400001)(2906002)(44832011)(5660300002)(1076003)(2616005)(82740400003)(356005)(81166007)(36860700001)(47076005)(40480700001)(8936002)(8676002)(4326008)(6666004)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:48.4745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6394c35f-6395-4d09-e0ec-08dba3f2ad22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Fix incorrect comment about hardware capabilities debugfs interface.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b5f3b33b625d..0c4dd922cfaf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3606,8 +3606,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
 /*
- * Returns 1 if hardware supports MALL cache
- * 0 otherwise.
+ * Prints hardware capabilities. These are used for IGT testing.
  */
 static int capabilities_show(struct seq_file *m, void *unused)
 {
-- 
2.41.0

