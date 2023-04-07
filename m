Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF22C76196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 05:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C9510E24E;
	Fri,  7 Apr 2023 05:38:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A105510E24E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 05:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1h2BZ6Meujij3cxlgCQi+8DL0Z4ce0h7UGWNIMijBHtiWLUMvHSvxr+wNKDIaX2xVQMcB8vgT9Sv95a4uSiQHXDU3p1iUjDeDDZBoL4rLT+BvLJIIZkPGvysTvIzU2w2fT7xNFq3yed2LBhywABwKUogKonYJxmKNNvMchZtdiHlG0Hmu4iVAx+mxp2BRb8jxJ2Wa+3u0JIYve2vXKFPwtBJ08EyYFnFHVmuUCyiKK7xZWybP97qzPc/bJFs8c/nHdJkkVRsz9KENCtLo8kk0tDmTQBduqCh3uNK1LR46fU+V8RfeYTijUiz+MypADknaEzqQDtQEaKRIyhzadPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pnZblWSq0RF5b6zfgS00p6bwW4j7+2G1f2A/jRANpE=;
 b=XGtOZFvuoSCGiMn0gFV31ue/JsHCay2e1S3awLJCNMSrCyGYugkoYXnmGz3CE7pGt935PnZmO3HYeI5R2PNR1e9K9u1DYcx/fX30ovaesHqtt1EYDuCncG2QMjUTQ7QHvfyz9VjeSFFbjNPZhHkj44QrfKbGNVkb4cN32amtoz5+QDv8FT0yex0OM1tkpul3ShlVsaLwJiWqqNVuIq1BHQnnlgZMnG4pg91Cuq4mba7ga+ZM95LKNASaWiCDbEF0j9qjAFxsKVlZhTP50g3WbQRcAKKbzjpmEAXUlHDSYlK2R58zUJxQDWbFKzCtP9vwuCNxS4rSl+D6EGpBCGka7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pnZblWSq0RF5b6zfgS00p6bwW4j7+2G1f2A/jRANpE=;
 b=P2Ki4+TADz5K+QwU3bFQHLsDKd5gCNr3aRt6e37HUXmhjFjIqEOoEd5qb8O65jC0GCyTNmpal840Dl77T9jikBgesaPIf4kVnn8yBa95uGG+fiGsHToS7sSYJtkPs0jpq/OVZ1Vtt0pW2fkVfP1gGW+WZINE0ql8psKmygE/5Qw=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 05:38:28 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::eb) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Fri, 7 Apr 2023 05:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Fri, 7 Apr 2023 05:38:27 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 00:38:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 22:38:26 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 7 Apr 2023 00:38:23 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v6 0/2] Send message to PMFW when SMT changes
Date: Fri, 7 Apr 2023 13:38:20 +0800
Message-ID: <20230407053822.157046-1-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bdc251-2c7a-4e60-f3e9-08db372a505f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WaxA/LkyDpoGFHTJNvLJgkrYJQk8SYDfNuvWzNIBeAlSG46cohmApoGND+WHVTYyKnulK4iKdPJnPxkqcjD/KG1KuYLzaA7+5O0Ydg2BvcjQGsqetOIVTMft9Pjsr3Pf+Yslqtvr7Y16WjYIzQ1AP3NfoeLCGDizQxToz7yw+l32aHnzxb+WCTqT1Xr/6FSt3XG/1mfPXubE30AoQE+Sycag57jzoO0mMQDAAxH4Xm5aBUAZ50sjtebmd9up3SBOl8ZibaTVZq88j+/Ru5VVMs8Sq3rYD65ajEBRjNeo6iVcW3JGOoLiUPyrffCGH/jab3ivg0ReD2IvGoktv5y+ZYDWF5t/F6gQV/GXWPUpCH4I7VVB7V2bAa/oeX6rG6pEshsZZ2awOMiPt2YferonagCam6AINi5SMMkn0AxGa4+viZJAfLIb7AaUInDorgVn4681MG+0NFaEG4TAEa3M99BeL9P6x9Ap3HcbIyzSOxGVMLSM3wkal6bLuSgIWk9/CDh7GF8uWqMJ2gRUAcNQdOhiJqqKNyVNcGsMtKx6ti31XF1g0u/Hy/lwjw/42aLIzBQpJuBhF6EndFVt9tR/eyEYf8fonH3rc0DSqj0hYrHl7bXtVd5zIos/f3P/glJ+fRa4wx/rnAtUgE6zmxHONGDioOntwbn2BiYDeU2Y6VxhEFxXlxOC7Qors5UBT2LZv6Xpsb4w9ZVyVY81DcAoaEM7HjMN3b5ibu2tZBiktI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(8936002)(41300700001)(40460700003)(7696005)(82310400005)(2616005)(426003)(336012)(83380400001)(47076005)(316002)(110136005)(36860700001)(6636002)(54906003)(81166007)(82740400003)(356005)(36756003)(5660300002)(15650500001)(8676002)(4326008)(186003)(478600001)(86362001)(70586007)(70206006)(1076003)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 05:38:27.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bdc251-2c7a-4e60-f3e9-08db372a505f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the SMT changes on the fly, send the message to the PMFW
to notify the SMT status changed.

Changes in v6
1./ Update last_smt_active only when the return from
smu_set_cpu_smt_enable() successfully. 
2./ Use smu->adev->pm.fw_version to check smu version, if it is not
assigned, get the smu version and assigned it.
3./ Remove the redundant error message print.

Changes in v5
1./ Add a new vangogh_fini_smc_tables() to accommodate the timer fini
and smu_v11_0_fini_smc_tables(). 
2./ Move the version check of SMU version before initializing the timer.

Changes in v4
1./ Since we didn't find a good solution to handle the case that
manually offlining all the SMT siblings using
/sys/devices/system/cpu/cpu*/online to disable or enable SMT.
Come up with a new solution, add a timer to poll the SMT state
periodically, if finding that the SMT state is changed, it invokes
the interface to notify the PMFW.
2./ Move the generic code to smu_cmn.c. 
3./ Add PMFW version check for this feature.

Changes in v3
1./ Because it is only required for Vangogh, move registering notifier
to vangogh_ppt.c, then remove the patch 2, and the number of patches
decreased to 2.

Changes in v2:
1/. Embed the smt notifer callback into "struct smu_context" structure.
2/. Correct the PPSMC_Message_Count value.
3/. Improve several code styles and others.

Wenyou Yang (2):
  drm/amd/pm: Add support to check SMT state periodically
  drm/amd/pm/vangogh: Send SMT enable message to PMFW

 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 ++++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 +++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  5 +++
 6 files changed, 92 insertions(+), 3 deletions(-)

-- 
2.39.2

