Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27946ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5796D10E7F0;
	Wed, 14 Sep 2022 03:31:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE4510E7F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbovfZ05SkLYdrrglVT3Mq44aSwKAs3tuYrBXDlH4s50q39w5lqKzO3OlV2+iR300yD15ws/Jpv4zG4tKq4z72bvaPWIOx5XerddzDUGbO2fqssY3YM8qTQa8XIsh50gFf0s1y3b2+1Xy0wKMdlXC83qKmg2Ge61gsS3/QZCn94igT7Eood99pK8dL4V8QalV/OIxJ22kDBvzB/JWNJMGj8J3e30oKQTwCmCZWByaN38aaAXxfXzePPx6k/VdbQjvKCURC9etXGnh1sImK9sAIqZxZwq2q2bs5em4l0AhBxrHOImuXX0YCGfq+8n7uGUHs4yuxToavlvOkHBr3x46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=UywWgi/zGpzybC6XJSAq/PCu9NXN/1/SBpYSyN8FZdfhjUruOKCRdisqVyZpIiaILTo72BsGboE1NlGB7LeVoO2CB1y9y0wG1d+PxmP/CJv0zXPD3XaY8k7CbOEeRdkypV+zz+mDgjQlVp3lcII6eb5PpokuYow4AlqJ5Gt2PI5AfQhtFGs8k6M4qmJHuN0LaDuXXFp1s98vMTuvnmXd+wlyZFM5fAO5n5YCzd2imVxQEhOK0iyRwSPDIE/Tfgr4RcdhkgHvQZGblYHGJp2wHL3GHhTQbRsr8IOq9aoptWSAXjePuGeCDUdrlmEpvYD9/ZTD0x6CKQwzi8VA8dqm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhGaA47242r+vkyMiiDfyo6d/C+r4oCiOUoepY+SWiI=;
 b=apdqnXAWyTOOjLq6XMh7p1lXewVQxXpp6/77WIlTOIHxJh1Q1UL7b+QZS/MudpujLyj6TR8Ff5ypM6s2OCDy77w8SuEXxeCg78E1DZlllNAnI1cIG6Tuz9fxr/SDVlSSCqVkMRRoTkC5BNzyPRf160fmGvJMtPVfwvJVQix0Sig=
Received: from BN6PR17CA0045.namprd17.prod.outlook.com (2603:10b6:405:75::34)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 03:31:39 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::f4) by BN6PR17CA0045.outlook.office365.com
 (2603:10b6:405:75::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:31:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:31:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:31:06 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:31:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/47] drm/amd/display: 3.2.203
Date: Wed, 14 Sep 2022 11:24:12 +0800
Message-ID: <20220914032441.1075031-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH0PR12MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: f64a95df-d5d0-4782-dac8-08da9601a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XklXQPcUB0Kx42akdFtkFFzmN4sf1DbjDcbDATwLKTqlrYo9XykXcX+dN/S4OZ9kQKaR6o1DzD0gID8HU6fYLo/9jn/ZZeZHMBCcpdB461yHS3ifh5bQqjMF6tdioF8kt1/XwxwcBjgy7IY8p66igecDbF3efuUS2e0z1+NP6KiPWLJzwVYGPf6xP9F2TqB2BI9vfM+aFrW+z/EefNgpXyeJ6RssYbZzRLuJDMFvye32LtlV4hc/5jUHw5jOzT6HLDQwib9nyZ5RNNO1F/zCMai0yeK128VvbB1Xnd4dLy3k9rVMOh55XXzkXMpvqOm++M+OaCvfey5wtlogg2MeUh/jp018DBM3pGIb4kLhOnn0mx8br5KXVKhsCqeSoCj6MUNOP9RB2xpleGTAaZAI3YI4/OM/K6KqjWN4ryiaRid+7tNzhU7AZsOY1rwNFbDQLAB9hUBlD3FwR+/w3SS54Z+pUwgpHRHDI19OrzDVjOdg4299P63iMuygJH/HonlzmGzKkbK0WKmiuOOL8WoDRfUcsemhVOohfOBwc+xg7bAwhcArNcIZrn0fVll5brGdyQuqJGGynLmpSkluY7kKiWLVSgZ4y3GjG6+MuMPyxB06eONUgxPRpYS99UC5Q3MaehcdevfLOmMOJxeKhmMq3zcmTZmaIFM1j9IsLkeg4wLZ/2G0s5EQnc1uj6IqDi4bJ+JGQkGug292Cq1vyQcwho3/4M8GMYojboe5wKX/71yivuOE13KCPqODoDWYY0wq5/6VQMXE4Cfzr7zuihJFy+EHbM0GKyVn4t4CEhqiOwNblUS7+VHgUihOFJnq6e1e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(70206006)(26005)(4326008)(86362001)(2906002)(36756003)(82310400005)(47076005)(186003)(40480700001)(54906003)(82740400003)(40460700003)(2616005)(8676002)(6916009)(6666004)(36860700001)(70586007)(316002)(81166007)(336012)(1076003)(356005)(8936002)(83380400001)(426003)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:31:38.6923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64a95df-d5d0-4782-dac8-08da9601a241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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

