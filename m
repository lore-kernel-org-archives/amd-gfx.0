Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06FDC7EE22
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 15:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF4A10E16F;
	Mon,  8 May 2023 15:29:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED66010E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 15:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDgq6IRQPWSH4SnI9U50F3vRWAfk8cgYiHa7qK3u0uPMTZwxxskwr8zblMxys9GrHdrwVHfnFw7f+eFEHRy7YpCOgOTXhnHfPGC4+yItmiCdRWn2/2t7xRHZWOUTtCahw2y9xSvQiGo6nk0CRAKRa8ZMd+SMBIsKR2+4WobkCEF29MDmhsydxDaXRBwZNYHbQg6b5+s0GSTzNLUyGKDC2C0IN+XL37OGtWrCGyGF1OFCMaqcsCWumn46TlPg88Fg7w4QJK/dO3Qlq1fbvsTyDxJ/dUxOe4XswvmJpMPxu835U1B5Bs57dcz3X+QcOsl7LOZtyfpPWzZFTp6VAg6g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWoNCGvFOsiBd9IVvGLU7qBGwWPZI5EUicxWANlazJE=;
 b=TLhnmca/I0mbV97Cuin7uOmaWsxG17PwvNwUyZTdxvtXJjHuHu3Rr6Yt1PcDFaoMn/eC7w8m8xi9aPgp8WyJIhLqUFhEhZ/tkb+LoiVWL8Lmgh0qDQDb+fC8oYd8PUUZYirpAYGDqZ1TcEJYUWmhfrjdRviB1buLZPHkT9qLbwWxHSw0St/MCiSAu8B2Dwfx2TemsLLexSOHvgQIFBydyP3Xct0bP6mdCNY+5D/UsHK6htq7V6qxx9o/3EtKTv1w/+1yfiqB5dzQrU79JvKiMMIYWkjbRFZ3JSWVJ6GjFVDG4QNTpmNl+DO6arUXPe0tQyoHAiWygPrS7MvzIYZYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWoNCGvFOsiBd9IVvGLU7qBGwWPZI5EUicxWANlazJE=;
 b=3nC1EvuofZ5v5efFnJlhrCpatxYhMca0OdfGyToQ3hntIoitVN0Y371VkyxKpw6mLtOMRqZMsoCdZ3g/lOCmHBe9uhmdS0fG1pzOEwQ4iGrSCDhFXoirJdwZd9qDSl0dcGsxu0/3frFveuj6tB+grFw0z8N/x4xgkwW8y1P42qI=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 15:29:48 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::4d) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 15:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 15:29:48 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 10:29:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Date: Mon, 8 May 2023 20:59:29 +0530
Message-ID: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0e626e-b8f7-47a1-f1e9-08db4fd90f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsk5rto5UW2RkELSNuuSEGXWcqIaG6JSHiPqA5MSmsr+0HqSRha/JG71IKyzvn/TUq9We0wbnxJBkk5FTpZPG1eGZ0I6BrInt28aTPIfcK+C/CdhHSAFHtuJ2f7dbxM59EJf9yLyAPSu3hnvOzS6Z2cuI5oMY6EQiK7lnJyh7B+3GKpWcCtOc/R345QpBKiOucLEl9BIsT1CRUWVnIt4ipuWh602ZEnO6Cl+VEobaNysFoiJQwU460Fh+qhGFCxZzme7Rdzl0s1GndxyQbyxg6kDV4xjm7HIqO8RUAn6AT5DfUzhkV1g8/KHpJYGF+Fr/vuN0gRu5ietGKVXO+2uiYFrsjSaUlV4+e22IIpZpBRZPwVULKETcs0UhXcn/kFh8KGgSjmPIkitsMuiRA1kkZSx+udgfHgdMcMS/XxG6w/aoZTU9MiSVowxiilwHVMs+KOwc9wPY6SAOBmAHihX67zd9GhkSZ45ww+OLsCmPpDTFCZJu/RvEebiBDj+0eDYyqGYjijMpm4hLE1Lv61wMo7S7GwtF+0mG9n8xPl6/ps2htVJnEZJGYAxCqjIbNXzNcjGs1JcWUAxYlGMGkb1ZKqVn4OSQfJRGA02kl5XB0S2q9tIDH8WBg/cStGkZFMeYpWzxIpm7OG7tfFy+pOk2RpMvMlv779LOmb6VMufqlpHYdhNzC5l5EMQJK0JJb3raRutMoFA9AdRfwdAn9xkXS/heAds4Befb2vrnBg9GgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(54906003)(110136005)(316002)(6636002)(4326008)(70586007)(7696005)(70206006)(478600001)(356005)(82310400005)(40480700001)(8676002)(5660300002)(8936002)(44832011)(2906002)(41300700001)(82740400003)(81166007)(186003)(16526019)(2616005)(36860700001)(26005)(1076003)(66574015)(47076005)(336012)(426003)(83380400001)(6666004)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 15:29:48.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0e626e-b8f7-47a1-f1e9-08db4fd90f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index c96e458ed088..049e9976ff34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -242,19 +242,18 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_encoder *encoder,
 		if ((dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) ||
 		    (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP))
 			return false;
-		else {
-			/* HDMI 1.3 supports up to 340 Mhz over single link */
-			if (connector->display_info.is_hdmi) {
-				if (pixel_clock > 340000)
-					return true;
-				else
-					return false;
-			} else {
-				if (pixel_clock > 165000)
-					return true;
-				else
-					return false;
-			}
+
+		/* HDMI 1.3 supports up to 340 Mhz over single link */
+		if (connector->display_info.is_hdmi) {
+			if (pixel_clock > 340000)
+				return true;
+			else
+				return false;
+		} else {
+			if (pixel_clock > 165000)
+				return true;
+			else
+				return false;
 		}
 	default:
 		return false;
-- 
2.25.1

