Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66441D41D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187B810E641;
	Tue, 12 Nov 2024 19:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lhXxGx6G";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C146510E63F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds07LsH+c1A+HPxNIJHuwjqv25+RO5Ix6zYCkwj25OjxNIhtlenrtr0hQIYiqGuBawsecmNT9rMZB0P7BOjbbgDB7QpCo71MSLW2L98WIomCDDuHaNv+CJQNEubzTjbFoKmD3ikUC0tWJCxcw16vqGeiOJ9QidbvAnqoxc0v+eXyU0Ysp0sbTuGRrL3LZh3ahoEBXBvOn8lK9CDc8aDEqOYF+8js5ZOs81RWpXsU/ldMW1/8Eivlbi8Y7I1yICNrnU3Zbc1IZbvivuC//K7kmUx7YJdEXZHLoJxoqlG0eD74FH3D+QQHxprZx8J8J84dVkiA1CUv7tG3UOVW0IMoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH8nvk5k85l7xqX9xoXYzq5NuIUtWaUnLyXHvKLMuYg=;
 b=WSNlCbP2tQB/FL7lgZq3aXRudc56/S4tZTAW4FHaxgGhfq6A+6PgSBiRleYZMJqflG3GXbteQOeYfcXLwBnwyP7UU0U55tHsA481f3hiy4FJxQxqasuBtn3M3yIJzA2tB+hIIQVzWKfzDJzAobhmcoB4FaefsFqDpAhiO8LP0SWq74o3Lyh+8tzDj7tFTwBgGjSniDAUxxJx+0bhUIPw5ypKCq+E9op4Bnrx7LPXCvE/oNKZFuPx+cEoSXyMCR3IOUSOic/ksHR07BqldS2gmuwQxl1KeVzS4oxrgtsFYZIzpCzGhNX6sGoH1wGGQiXm8O692VSOtThFv9sPIOOR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH8nvk5k85l7xqX9xoXYzq5NuIUtWaUnLyXHvKLMuYg=;
 b=lhXxGx6GIy74yRR35pnPREUUpmxrUEPrV37Hbwy6eG/MaIOxro0ubFCu55q2/BlIcc8f/xm74J36RZIb84w6aUOAKRdKW+3BY/o3i3Alf3C0VAYxiPpCr9a1+ivwYbRV4UCj1s4xGO0IgJBGWgJq1PJTGz16L1l0UEJ+l+AZmDA=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 19:58:29 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::c9) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:28 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:25 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 9/9] drm/amd/display: 3.2.310
Date: Tue, 12 Nov 2024 14:56:04 -0500
Message-ID: <20241112195752.127546-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ec1ee2-5d43-4dde-4db5-08dd03546089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xOK7f5gXZdVNi0WWGSwJJnbsxZecepE4fudcWaTvDkWZvwBELFH2iZCndH4X?=
 =?us-ascii?Q?5QyAt8gTTA7qlQt04A2i40bQUEMiOEa0jUHVXh5LCflHBq4Qpa8t9RIqCuBz?=
 =?us-ascii?Q?QiV1fmWgyYySunF9MddrWgnAA81KVBR1bMDGusXMElu99osU0SdcmYYaUBva?=
 =?us-ascii?Q?4if+ZTj/vl7PVuKn5yWz7C4xNrmLJz1g9AwaqBRtAiA20p4GVRD42FTe8AuH?=
 =?us-ascii?Q?WJ+EWW5ABKMu7G77gTKtUGDRSSPkYWAxzgOtnQWW1UAR+QpTUU2L5zgWOcDc?=
 =?us-ascii?Q?oZrAeBSM2kCLNB4DzKVif80JIsbigyrl3MLxO7cxoBvSXZYWzSYpC/q7e+Ds?=
 =?us-ascii?Q?R0DuAnM0incmPAJQbD8t/FLeWTZFMn4erFCk2xSTIDaA6qKhkpOSNjoye8Di?=
 =?us-ascii?Q?nr5sUXRIN09oIwj2RZJ0b7A+P2roADTMHal+GSim4ZGfWUK4QfdSwcNWPDmk?=
 =?us-ascii?Q?CSPRjuq2HL3H2FOePHD0jwMw4xKXx8bTKIK+uQbVh13PosqvbCiq8cpCaC0C?=
 =?us-ascii?Q?8jW6J5mgjs8tCbkt69yWkWKNHlJlqxA6StXJQ2uGO58zg2iWakebfY+/BkIQ?=
 =?us-ascii?Q?ABnBukEDfOFvnL8Nm46O2UM/m+45JI+iJ1Q8og0KCsyVKTgPSYfsXilU4VC1?=
 =?us-ascii?Q?b0SiwvOBNS5E0Uo76WHlbfQ06MqtzhgpjXZCGjeKlsX9ufwHZQHpqgffovjm?=
 =?us-ascii?Q?/QXc8+8a0/DBXzFI72fHKLPmzwB3EhUEe/Fv5Uvl9KRHDnwzijyYz6eVIB3t?=
 =?us-ascii?Q?iiwuw5nuP/qydDT1wHXIZBGHCMqIi6zxtxw6fSVakpZllNdEmVvPdj3X7oYQ?=
 =?us-ascii?Q?SAwcWgz7w2Tiiqa6TeGxVNB4fWCtn2Y8Vy4WbPBc9mdZOrHR+wCuHkKAdz0i?=
 =?us-ascii?Q?e6ehymFZxWFbSn4EqOfUsJWoPya/fGdqeFWNWiA7wVNxqAYOQJZtk6aFuMq8?=
 =?us-ascii?Q?pty9cEql55yCWe9YP3L+mEm4ER6notQudcM5KlQOAbNuZFkMyjn27whlQrwF?=
 =?us-ascii?Q?dwgJ8KHUkVhL/aXgnclSZg/zL/Lcb9/tjN2bKzGEbyvxcM6Oz/nwCjT0o29h?=
 =?us-ascii?Q?0ULH5PNyAeqJzHDqyApGZBchSoJN/FPp8Ohp1t4NeGJ1coYZWMDYVtCIEeEj?=
 =?us-ascii?Q?yx2Xee9VFXQ/vHBmoBDUSKbg1G8/CQvSo3s7pPz3rjTGQer7EErw7I9kYSHS?=
 =?us-ascii?Q?TuFEqC0TkPzlp+uDisfv+KFfboPlI/I6H4bQla6XU57ey0UMfkBwWYOF5yL8?=
 =?us-ascii?Q?9qoZX2lU5Zg9MfaWnKfK2IXL32jMVo8bfcoeuYRgkky4xTtaZBlWTWDZFNo3?=
 =?us-ascii?Q?ZzFPUStNMqrYwq9au7/wsyVbUgMzZTXG7nTlB2iCXv7oXZhUuwnii+bsKhCk?=
 =?us-ascii?Q?K3OIgS/CdM3nB/JLkCyy14G+BloJxvDTkunY5g8LFG3qI/QGRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:28.6663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ec1ee2-5d43-4dde-4db5-08dd03546089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- DC core fixes
- DCN35 fix
- DCN4+ fixes
- DML2 fix
- New SPL features

Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e143fab00a86..104051935884 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.309"
+#define DC_VER "3.2.310"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.46.1

