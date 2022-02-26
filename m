Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2B4C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8905010E2C1;
	Sat, 26 Feb 2022 15:42:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1703C10E2C1
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl1GMSPQqLskvFtZ/tN6NEg5K1n/WH6y7qm9uEoX/5LPHUKfnEZBMTTSEBMKSt7ZGK6ViJLpwOef+q5XqSo2g+aV01KwYSbgIGoaIch63KMFA3qDnzKUSHCHomm9jgWGj8Ewu6pcRlytGFilhiVgEI778r1gDEbFHaX3ULnCSnoncW8NN9xErbPbrSm6y2UuRI9dLqXS83K9QiKFVQpTpjOf2uuZSWFBkAG0i6dYVCQZRMOhCmeF89HQZKvZuboC2Ww+5bsYv9qf3CmIo100EBsdX2KcNksaPWBV2AYNHwOGeM+WEDZG9grzYx2KftqY9Egq7pRPoysMygDy1CONqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqKDsesR6dWIVUJmX16szgCKD+deC1occwwKrlXX6gQ=;
 b=e5znVI/nbevWmzLxmhD5U4dbxUyfIHwRYN4AplXDKTGszfsKG5JGWVWX5Px9apBiUI/CjtuRrHZ7+Mqyq4tJe/M+kJQHxTK172V3B7FzDmmCWzoE1AqjrVK/SjHHsVZrIFTaSNdqpLy1T5TRxgOm00gELGx2fpUclLubg1/iP5amziUiJnW+9xNMHmlASgVPOpHMp8GJeQ5VfYODD/QhzEHgvw/JrmWcRewrcBwa556S+usoHY7N4SEKn78Z5Y5F96fqaeosiEwbslmXIq8c+90hcH1Bszvo0afn6tFkJdSrEPZ8bW12ZUEVGcJfYotcM61XDzy0RaQGoLnPjlT4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqKDsesR6dWIVUJmX16szgCKD+deC1occwwKrlXX6gQ=;
 b=htAaPdgQJoRNPuxZRTcdeYdpNhPgsUR2AATqeEPz0mg1kUiBkw6TllWxjmiEYS/e64gCfaqr+pGZuHyf9mh/to+u+PJ4uQUVXNxsKXauXkmwowkd62cSn84ZFi1azwHx0fOXi7H6BtuyVFUr0TcrDvmv7Ma1Itk96h55QhX6uoM=
Received: from BN9PR03CA0477.namprd03.prod.outlook.com (2603:10b6:408:139::32)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 15:42:32 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::23) by BN9PR03CA0477.outlook.office365.com
 (2603:10b6:408:139::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:31 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:27 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: [FW Promotion] Release 0.0.106.0
Date: Sun, 27 Feb 2022 07:41:15 +0800
Message-ID: <20220226234117.3328151-13-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c55c01-e25f-4f06-86a6-08d9f93e9a31
X-MS-TrafficTypeDiagnostic: DM6PR12MB5008:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB50081A587F376134D37C1921F53F9@DM6PR12MB5008.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfJQFST2vT/DAkFCXcVYWM27EKvMjsy/5x3PT3gmVPt4ImVFytxomvPXbANDUgPTaaCUWT8MshB6vpW05PAP0V1yM2Dm+cR6hSVzSMEZmSl3GkSeyMiW2QPcAfjv2Hp1wKJBrsoR1KNmldBhT2l5CDH0CHQ9r6jjFxuUAq7UDuN4Rjx8V1aw6cDmEs5b9fzAy/c0i/3bJAC4QNNtVmp3ih6hwKlbUI3HfjdBRW7zak6oBRiuawt+XiVe7UoAp6W0/KOfHYacDbJuvmjVOBJwYkw9Vw1NaO3Us6NSeg9edANctEHqEVFKczxQeueTBm7t59yUjE2jM2jIbs3kwBuCyrwpI/+fIkysGRUnlTc2kpqq4YikRCj+u+7eKGI25CIuOdf3w9V/ht2HDlV1tQLWviK/wxDuoUWkkx7taTzU00Xzj91wI4i2sVw7FxjumtyvrgghH3pBPv5LDhS0u4bdr6bycmXjVGkmMEy1oN5NK+UvIMWPmKGpYLBNqIdvwWZ1HSQZ2jRkEJxL8tzAhGxIi3Salp9z9Gq6krk6FiXGzfvMzAyR3KLYiwVD9N1iknmTbji51/APBBz25t4ORh0hBPnkZNm/Hb9v3aBey/ScSD7yu5CkqG4Z3ScYdnsPFNLyRwFq6igedOCr2ZyaQGzc5UZyNQjKqVSAo2363hlH3S21O+P5vgb0MCNL02OTRaTfBhQnKA91WoMLILkndiqAiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(26005)(8936002)(7696005)(6916009)(54906003)(356005)(8676002)(81166007)(4744005)(186003)(70206006)(70586007)(1076003)(4326008)(508600001)(36860700001)(83380400001)(316002)(2616005)(47076005)(36756003)(86362001)(40460700003)(6666004)(5660300002)(426003)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:31.9080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c55c01-e25f-4f06-86a6-08d9f93e9a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index da93087132b0..9835153ef538 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -46,10 +46,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x1422ef84
+#define DMUB_FW_VERSION_GIT_HASH 0x082bd4c8
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 104
+#define DMUB_FW_VERSION_REVISION 106
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

