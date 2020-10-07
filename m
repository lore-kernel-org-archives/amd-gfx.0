Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C21C4363D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8765820789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KNIZVOAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8765820789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224AC6E8E2;
	Wed,  7 Oct 2020 12:42:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99006E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr5wzGQ3MiaSo/h9qOY8ZHW4MHLBgjGrp0yKFwMV79KnePsJPtiQJM5d3UBroGrqv0owEyqO/XBJ6sgJ30QKyUR4PtLX68YJNHbGLPI2Yrd7tNJ6Rk+U/SwyZjCLaJ9NrfyRMnLAB++SVL7085nD1sigvszEidBjETtQwTKNgoshX5l/bByi6BReMwFI7ACNhkk8vNXfakSOfA4r2cTKC6HhICva9+4NuO7aOrZHig4DqlGbdXvZ9kwhQvzEfHR6EgbDhsRqQv6GL3lbi8WmJV3h4NJVN3vcoN+FvaSA/ljW7t9/Fg3jE+Uml2GdpgzLnsuZBWBKbduvlvvaM2kVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOg9US0FxZRbfPmTuekx6oj/wStwbOFh/CvDWsxrpg=;
 b=PArjbZpTw7fFtvwKgW0yBLOWs3QT1Jp1dp7ivm2EZhAkf89ufI+Xyw8xhDlyTyAzPZZLcAGDt0A+KFbhpQOjdavI+a9qKkOOnZbIi7uhFrp6AD6i61vvaFq7DL7b4ocYJpu7Xrp/XrMBfcAdvYFD9DWYmgwLvP2VGEIoNobvmjStcruQI15Ut5aaRoBNxvWULob4HrkgxXxcJwZJ63cTq1f0x+VQeK7nDvG8l5croawCnml+Go9LvpsyM2d0aFuSP83K3Ll0qSTLCYbFIq7lvfSm4ipzZk9S4Wjy2veMcDIn+bXkx02PvnNJVmam6GEZLjIFY0sl4NP69xtXWLzxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZOg9US0FxZRbfPmTuekx6oj/wStwbOFh/CvDWsxrpg=;
 b=KNIZVOAOcWmW/9ojwrm+Gp/ISWuCnefbEisMkZ4A8pWuZLCCXXtoKEAfvw8fvw8KHWqgF8UUaN4QD9zru5IMxT1tPVca5Jse2UvgmE0I16HKgoL+O30dGkJGbSxc4pD46QHYNlg4maJdZf/x1uwO22S2QFgyo/bbVbzcDCglOmE=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by BN8PR12MB3217.namprd12.prod.outlook.com (2603:10b6:408:6e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 7 Oct
 2020 12:42:38 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f6) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:38 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:37 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: [FW Promotion] Release 0.0.37
Date: Wed, 7 Oct 2020 08:42:22 -0400
Message-ID: <20201007124224.18789-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c73572-74a3-4541-df36-08d86abe795e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3217:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3217B72AC0EC17354A8016E08B0A0@BN8PR12MB3217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORKZycVcm877BlFK9cS4RTJzapzkFsDRqgznCPXlByrvXB22JYuOP7iqPPhVXz//FABfaDWeckgIQLWoJtw2vqs9TFxZ85tI2/xUE+hMCiFNFO2rbZ82BWSskkFz60ZjB7XoLuPmVA35wi6RVGRcVCBCql6FWiE4MNaoH3wHi0qWX57br8SmWLwhVI8rmXX7glulsMlWWFiqiRqdE9FC0/IoJ5NC4ePuJXciPMu/qQ4wxSxc4p1AI+LJawLKaL5R/RKitHYgcftsjz8wyaeIMG8uzzYvqh79OliJTOULotLYsyXWfsoSyON5b+IYrf+SsxQmUzdiED7uHayTUFQ+RVqOaUnCfjEQuC5FR6S9mr/Z5o8E7t7g3V2O7g02nqMcoGmWH/C4TV5DOAgFjj++bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(82310400003)(6666004)(54906003)(4326008)(8676002)(478600001)(316002)(83380400001)(8936002)(86362001)(2616005)(186003)(81166007)(47076004)(1076003)(26005)(7696005)(36756003)(336012)(2906002)(82740400003)(6916009)(70206006)(426003)(70586007)(5660300002)(4744005)(44832011)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:38.3967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c73572-74a3-4541-df36-08d86abe795e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3217
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

| [Header Changes]
|    - Add GPINT to change timestamping mode for traces

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 26a4c6caf606..e6166a4ba71b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x959f9d769
+#define DMUB_FW_VERSION_GIT_HASH 0x1893cb959
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 36
+#define DMUB_FW_VERSION_REVISION 37
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
