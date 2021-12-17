Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A9AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BE510E6AE;
	Fri, 17 Dec 2021 21:24:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD2210E699
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeZqCV20E405bxpxOsE43mHNY2eXz1acvC+p+B7WJoDFQwLva8FtDcwNRHB2Va4TuGHixxPoatLsvV3sIclCLzIR6/qcqdOpsEI6DQOtmoSz1iwrSdGRV4iPs16CwcD5WQ4FRDmincc3FNutQOBwCzuNew7O+3nZuIk7+ozQ+vrFM+m+WT8iJsNx3rYoNneQC1roK3HB52Iseyphx1oxdYyQh3wnV5wi93KNtFmA7X11UUioPuqYG4TIqyJeWEpfsxvp+/yoiOmbXRnSWu90zVq8rqxTgJS3NDRvQpNFiArzZhtWP0VzlVBMxoa7mUE1D+rniqWV4Ea20+c0SjWEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HDY74dWg+sZp9WpHROJTrYHY6dKC5an3MWXDnDWjUA=;
 b=OSf/kbxB3ogpAcOhpGT+75KxYKt9slaYJIDBQWnyWTFDYAjKlMaUnYm1tv4r2fwvth+3V1BpXdtKa/Oi4rzN0VdYgXtq+SKavS3IcCuz77OFHXuaIyI8/NX+pmOPfrHzCQ69jd/V3Cpd/fNtlNEdwDUZI2G/HkVYt8s93ewqtu/HnJPi9phBH7rnNDOb+v7s4QhFQFbg7mYA8eSbPY6zNgKXMQLkGePKOXZuz8xb1jBnjKjcOn2ZOLCUByZqPqe40hByyrhGdJFXRu5IqTpPz7+LZFBSNg7nhd5VYIS2+dCfIM2SFhUpzSVNaqdkqgItpmM5UJ6AYSJTDF1tOIZ5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HDY74dWg+sZp9WpHROJTrYHY6dKC5an3MWXDnDWjUA=;
 b=WxCJRrPOllRkgXZQOVoKHmif+ekhhbc8h5YDwXtR8QQoq+VfPMDBwWhe4Q/IwZzxj/4xGnv/9/08yfM83VI/OPytrDTo4b5wXj6Zk3/sALZ3XE8nFw6euWWVNYNnsOfHsAQRUytqRDNH4M5KkxRbkFPR6CUIBI526SXUtFWgP+4=
Received: from MW4PR04CA0265.namprd04.prod.outlook.com (2603:10b6:303:88::30)
 by MN2PR12MB3581.namprd12.prod.outlook.com (2603:10b6:208:c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 21:24:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::66) by MW4PR04CA0265.outlook.office365.com
 (2603:10b6:303:88::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:38 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:36 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: [FW Promotion] Release 0.0.98
Date: Fri, 17 Dec 2021 16:24:01 -0500
Message-ID: <20211217212407.3583190-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83bb3e60-0711-4ce9-1dd1-08d9c1a3a1cf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3581:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3581C507FF7AABBD3CF4020598789@MN2PR12MB3581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlywK65iUKUeRAvEUHapu4o0AHh1qh4fc8UgI6dX5vVDhKBSBqxYClWVF514nMZFvwwb7zpGgMLPagvlpMYlu0P6cXtrsExJtvOo3xMdQ0SuvBcVdBYJgXDP2Qo7YEP5kLXlSetXKZtk0bC+3V0d6Vp4CXcnj7HRQQOyD9/vOMXeHSIyu2h+Ru7w6zJYyd5XQwetIQ3j60ZQQg4Cb9IYHfmKxaEaovTgoG7dHnpnjwR0fnlU7XvC8YSWulNhPtYdAdSBJJvCxli3N2rl28zyGomT1FVJ+sd7FwVfaM/cMQeNltFkUxjA3ASXp3E2ST490usI9/botzsSZtJiqe7Nf1GHzIQc1NjMh2sCJ8sQcAkScjrnQRikDuHHqsUH/f2opnb90jlcjIuVyndjt8fszg7ZCPogGzzyclzsfyfxN6q/yPrP+ibC5joQvclEvjXMPnRBMURp0rHLz8dbMOvozbnLyuyBLW1u5zA4QNb6sCbmZJmhEkKJN0QT49RGK3Xk4vYw/umvpCcBkTUH1SDu+zJCNs84Bdnq9SLvYmplEqeHEbpQRPnykRdcRcED1Fu0uTzu1vmkbJ0jqeh/GgjdrmGe4WxbjX64+ZWf9rz9yJlYGws/rrbdutyp+5OB1zjNKfEXJHoYjU2d8mLHJyhXHFCzP+Hmn8E/jJvRi7+Ul7E/jZbtCCuyVnPoDxS8wvUn4MEFCOrokBQX1DH2QHV8z71Uc1ac8o5H2KEf2DYc+YN0GiXtmlnJprgLzSN8ZZBytogvjb8aiXFVnyVms26L8VcXxMhEZxrwxyElaBO6NTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(508600001)(356005)(316002)(2616005)(86362001)(2906002)(186003)(426003)(16526019)(8676002)(82310400004)(4326008)(54906003)(1076003)(336012)(36756003)(8936002)(5660300002)(26005)(4744005)(47076005)(36860700001)(83380400001)(40460700001)(6916009)(70586007)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:38.6614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb3e60-0711-4ce9-1dd1-08d9c1a3a1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3581
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a4fd61609190..d18762e02509 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xc99a4517
+#define DMUB_FW_VERSION_GIT_HASH 0xbaf06b95
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 97
+#define DMUB_FW_VERSION_REVISION 98
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

