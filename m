Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20286ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5390010E837;
	Wed, 14 Sep 2022 05:15:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2456810E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1V1pahxw8Dz0RTjaeV8A6CPz6a2PMr8bSX+HM1eqn16jutrq39Hb5pScsGrlGJWbZpxGGLNxoLcPg2Ve0LD4fkJzlcAg9VuRz1N1USRVjc2QebCw9zf71MM1sk2oCigw8piuiPbRuwcDzBqZvKJAhueacq86Y7gEABJLgcdd1MB2GrBN6PkwpeQQBBdNrYFtiABocwyvP+rparWQSnmlYCu10iaWgLfNQeV3i6/TP5ErN0vvhA11ZPxtxJxahcqi1xTZ18oT4y2NylqG3QuwJVJu9iJm+CCz+kbesLLUaGLaHHcWUnHjstLtL5u7mUgywYsV1oJ6Lx5QHQyZGo0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=jgOxMguLrWrQcv7EEFb3yEfZrgCj1LIGsx5EQT4XYdPGrD/GsN1/A2K7Tfff13VqoGZjvyLumyr5zVvsvPjEpvOwazfJB3U0AiXY19SdzfSx81EHxjkg+EEXKIEUQ9EUfWPQTTtm6YTfs2e7WlCV4f/sps2C3ds1mJMD8f3tgIZ1ITRHuLbE5xPiAnqlxa0ZMoEmP01oz6ZdxlKscYmnAQVkIXDNBhyjO47ipFgkM9b6q7TQtkSUxgMqdMfkLwSO93SBY7HplCUFhjc2wniv2FYgbAsX/hnVGsrHZ/Byn4ts5Orvrdr/0njETJ/5Ge0tMJ0co+1gWhVFbxNrGV5JCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=R6NiR6ZEO0zYztAawkL8c355ocinbuPRZpfnXJXf97frqWWMBBUpFNneoRp7PxrAiMXmAAZwNfPvLhsmqs+9RqJ8lB5vnCRquywckNJJTz6ptiF3waaynup2giZaT5XaugNWKlp8VQMsIQZvaiud1fDRjV6hBbgEpJxvXZKfsPw=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:15:42 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::73) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:14:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 18/47] drm/amd/display: 3.2.203
Date: Wed, 14 Sep 2022 13:10:17 +0800
Message-ID: <20220914051046.1131186-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b21ecf-3d63-497f-9565-08da96102b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bofvtk6jYuUXtmPX0wuJ3ycq48CvtVPoThBWLqrlzbbF61BOebPXVXuoqkli1yQoXVGQfI4T1bDvpThVb0vwmbUY0muZX62hBb/v4tB2LPCCVBCB72tzxnz9CL44/zOJkr1D34b/pqcBuVpu9mohQmJYinBpE2yT2bor844yz1XEMgN3Tdbv4vKLMW5VDvX/OmKltSHVx5ZFchcaaae4VZASj2t7nTRf07SuphTXDev8Cq14bI4wx2o4uM1Jvf4QUNQwCG3h4cj2JRzEAN2s/RlrA0ydWQTLr1DEx2xLcB25ur+OaXi4Nv2hjW8oIMZFCCj54VY1hhsUQ92V9QO3qNPfxFu6H+mhRdlUDilVS/Mt+wdsvO4NRgCVeW+m7fAKg9tSC5lmWGb3w2xrjSfXRlIpSLsrTrpK74zImZIPF8hDpW26TTVsoY5AkVnvX3po7K+jCRGWlm1TPcHOF6MOJp+w4kUfdxy6/TbGpNIxl3XWcMPRYYnDFGOFz3Zft1FDRZVk9RNt6ZEtkZAUiw9ohQ49e/k2mLj2mZjHEVioc+vbegOBSC7z64rxnoqoqyOdMLo0OaIW3iMbiaupUrNSEiPcschdhQOTtg/I7OQZIgHhRrRZyIv0LqA/CDW0JfT4nAwaS8G+CertqYj7bXllxzIXCMDrQyCgkE9p4GgcpKtLqmVdwAtYeuPdqF7KVgz/QJX154V5BtskQuihyP6guRajqnH85xW0sGEWKd1M5khnopsGDIJKuYLU+545YotzZpojz3EsKI6yXUPSEMlH0b5RERCDQzgT0C4HbcODbDqBOZN4GLyumnMU6O8+PHul
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(8936002)(82740400003)(36860700001)(6916009)(426003)(40460700003)(26005)(8676002)(1076003)(70206006)(478600001)(7696005)(70586007)(186003)(4326008)(86362001)(81166007)(40480700001)(5660300002)(6666004)(2616005)(82310400005)(54906003)(47076005)(36756003)(2906002)(336012)(316002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:41.3308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b21ecf-3d63-497f-9565-08da96102b39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

This version brings along following fixes:
- Port DCN30 420 logic to DCN32
- Remove some unused definitions from DCN32/321
- Remove dp dig pixle rate div policy from dcn314
- Fix dcn315 reading of memory channel count and width

- Fix SubVP and ODM relevant issues
- Fix pipe split, MPO and ODM relevant issues
- Support proper mst payload removal when link is not in mst mode in dc
- Assume an LTTPR is always present on fixed_vs links
- Rework recent update PHY state commit
- Add debug option and logs

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index af726ffeb0d5..7adb27b2a6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.202"
+#define DC_VER "3.2.203"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

