Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B9C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901CE10E300;
	Wed, 28 Feb 2024 21:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cag41Jrx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2216210E300
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjXVLmNUh3E22FK5t9UsSRodI6BG8S3kNr4QOAhF8i/HpipEfA/9nB9m9YV9oL1IDJA+MhwEZ9oXT0zx0U4cXW11/nOJR4cZdJFB0a+tBeFgknjv24vWmRqSdDFFmfm++5Wk+uCNUzzvTN2lSvosSN6fOvCPGu+/DAvyfElv0qbYYRirvAjZPdIR2Dr5VeBZP+LAcpJExPegtqRoH1iBARVOxOn4/ve5ekmsl8j+P1JsLJFka0xb/V2BcFTQvxUWO6T03ksxnonGsnjHeTsQmeBPBlXY8R6aMeh+lmIDuErmaAzWgab1PqjmK80IOm8m4YPYkyQ3jM018K7YDzZc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxHiSOR75vI0MyZB78cEdlGZ1cFG//NLMG3KYQk+U40=;
 b=LFDiVNKol5fIjJpuNrGMuLOjpv8hyD5Mq2TxV8XwLlhqMn4HIgQ9MYgOY8Rco2aQVn9Y1nVyshHpZ1+9afISlbk8TVHWIjDsr1ruuRtTc26q8ofqEoC0/VEUizFa5ZSwUpZm/CVjbo6nZXTkZysC7DdkclJqtECoOJinLAKhsFkKkQMOrj3hp98aR4QJ/esmthlKzc8AhT8j9DnKvvMY1ytBNoUNWLMCyib13tfJrOX8ZUjrrEnLIddk5pU/dfouNjqhwy5/bIBPoqcnLTCZEMou63KlDSlLc3jvaquU8aMmZ/GZ9jJ8UC+0WVN793kG0h9vNKFEZfvqQiJ0jjEguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxHiSOR75vI0MyZB78cEdlGZ1cFG//NLMG3KYQk+U40=;
 b=Cag41Jrx9gk9hOBgFHLiXiYVxxgwwWa1PZcl6EISePRbnZrS/2hRZtUjDgyxRtNKQjRm76/fgJRrtOoW6kzcHJPurL0AR2I7BtgIhPDD+eByGeax+Bs33BJaesTJzNb/m82AMK335MbrPlKport0CZe83LDIl9pzIyzpQXrly2Y=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 21:16:54 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::f5) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 21:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:16:53 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:16:52 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 1/6] drm/amd/display: add DCN351 version identifiers
Date: Wed, 28 Feb 2024 16:16:32 -0500
Message-ID: <20240228211638.36109-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e05312-4655-425d-6d8a-08dc38a29658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4z7PQI2BFj16uR2QAuQhZ0tJlKOqxl0mTNSgtVdLUobiycQ+oovk/4jX0xi9C62EfSqdTgUnQTCMbbSR1ZYFPvch4roYr+pS4DZ5RnOxOZIj1F9mwzqENmsqpXy0yPRET3nctV1bJ4Ytqkg32zgTsYZivdnJBaXZY0K/+6fvcRIJeYvnQAPYaBzyb7QNV1SrMdFdpjMb1YJyoYkRknsVkiCzs/WV1LbptpuxTl3r3FPO1tAmpj4FTypYiYt8fIU41eOzw9TmBz884AQyaaCZFUYhDQChlspnOVmPAJPSq0VCcDdFv4mOtpxw3tSXVzedOI8yMvO+h2d5YUR8KyQGi7dnRvqWkN+4uh+6RStv9gA5G7C7vH6SzsL82w/slqXOCnzcyCIIFVQ2ahgYZHCN5dgW+ZANJTmRaGfOaIDLMVNLKRgZx0BNq3xRVQgqBCDSr9aO1coQN+q37IN7a4V9yxfv/INRnNe1JYvSi9an7d6/wfQwTWrCS8BCQhrD99KP2G2Vk0E4+nkr4Ocg65qPCov68P2DjWKW7qop34QxdFc4BfMOx8PYLf3M+oEsMG/aUFXPFKU0e/JkCYXUV784n1Q2jk3d1kW8gaL+lflh/BtlTbZt32RRYK8u/frjdgCvsg7X2DNlHp9e7SZ0I/dWSzX9DwHFjMpgCj1ixqHgzYaBT7NeFJGvUW9UEd1EGOArpdwJaRoFr6GiY1teJe8K4++ZPJG9t1RqCp7xgmTbX3lK7v+bPKhvhEWTpAYbkVM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:16:53.6909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e05312-4655-425d-6d8a-08dc38a29658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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

Add DCN3.5.1 ASIC identifiers.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ff2a65e67bd4..7785908a6676 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -112,6 +112,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN32,
 	DMUB_ASIC_DCN321,
 	DMUB_ASIC_DCN35,
+	DMUB_ASIC_DCN351,
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e317089cf6ee..c9ec46c6b4c6 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -250,11 +250,13 @@ enum {
 #define GC_11_0_0_A0 0x1
 #define GC_11_0_2_A0 0x10
 #define GC_11_0_3_A0 0x20
+#define GC_11_0_4_A0 0xC0
 #define GC_11_UNKNOWN 0xFF
 
 #define ASICREV_IS_GC_11_0_0(eChipRev) (eChipRev < GC_11_0_2_A0)
 #define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_0_3_A0)
 #define ASICREV_IS_GC_11_0_3(eChipRev) (eChipRev >= GC_11_0_3_A0 && eChipRev < GC_11_UNKNOWN)
+#define ASICREV_IS_GC_11_0_4(eChipRev) (eChipRev >= GC_11_0_4_A0 && eChipRev < GC_11_UNKNOWN)
 
 /*
  * ASIC chip ID
-- 
2.43.0

