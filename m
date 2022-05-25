Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD989C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4633B10E666;
	Wed, 25 May 2022 16:20:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EB410E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibd9cqkInogJw2J6ObkYUQ82WRTGidvITYvPz6s4NAaeyosvZGtDe99PkRIbWRpTTrC7Z28AXgHBE3EiZHl8x4vXION+4UFcyWkHT3NMlBvW4/as/yRkiHesyaognhZtu1EBKpZwHYGN+/N/t6Kjq10sykteYgPFObEV1P3JvBxPvAi9FqFofagdjuCNOycZxQt2Xktw0rXh3B63ob6HHN2zQUNWQVjQVn6VD6tz6Sj4nIZw9dlqQj2O9/uAlBDZ+GQJoO9Eo26U1JPCEhPDfODbw89OSWKrBFuGu+W9wxdhxI3YGIVto2T7mHeos55LKWWrZC5v3D94kaRk3wkCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHGUkCTNaR7ccHtVANLA3VC0GtEqBqWI9fpL9k2Tg9k=;
 b=KhI8wecL8+5tmDq6CyGHpH2eQPlj35DeCqDR7rUXWW+mVccHOlUOQ1qyS5K8wC//TFQwlJs3dPBDSFfgN8wpxuHXmP9b4yNCW2n23OfhOq7dsfFBVvgY9jQ6Rm/qu0GUYBNQM3xiFX/ZBz65GoFpVNiMQTxT1FtrYDRPC2LUMzb4tVt24yzOjYzVW9f990cMNgXaJ87PM9C5Bj7wvJhkH2dnh9ZrFK0y0iAea9yKyhvvBdAhswZIW/HenF0laiUvaTmnJEVI9OdDDcxAU8G+snE6K82LrMGn/5hSKCcULw8FWgWrknGL899SDY9pf9IB195A1tOS2uEYnsbX/A9APA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHGUkCTNaR7ccHtVANLA3VC0GtEqBqWI9fpL9k2Tg9k=;
 b=0keNqZN82FNfDD4c1XduBOm687vcuqHBEKvArAomzKm99xwgWVts4S1W4hRClmJUNwantlgK+0gauz3iI6c8DChp6sCOO3JGtb0laiZwLBFVQJaKKwNSrqiOzM1zkV7sibCPTY8teTUlxceGzdo6Eua8LH5A8omr7JCMW8H8i5c=
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by BN8PR12MB3585.namprd12.prod.outlook.com (2603:10b6:408:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:20:03 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::d) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18 via Frontend
 Transport; Wed, 25 May 2022 16:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/43] drm/amd/display: Add DCN32/321 version identifiers
Date: Wed, 25 May 2022 12:19:02 -0400
Message-ID: <20220525161941.2544055-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae325a9-adb1-47db-b5f0-08da3e6a6c7a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3585:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB358526568AF50115D6917673F7D69@BN8PR12MB3585.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJHJ5pbGovSHLA4XiZE9gxGx5gUvfL4lCabNB8MN0xcS5UvQfS272/e5+bW4oeE6hnwLL0mNDlJCDRCC8DLKUiWalnG3OgjVVTKu2ujfj/1ZLP90WwoqJGsqk14EZFP6cu6xb/zonpfDv1e6fkNP8K+Brc4OF0kEl4bdQjPnn4ksT4Fc1iz0564KU4lztjEwvK1Gz7ezi0WeAKx1WrOjW+6s2APywBKs0Q/fWC2nsuEjhfgRaZpxZuyBcmnp61+8QqdyJwhPwSmL0QePrarxg5r4/qoL1ns5x2GKhsHAW9xNvdkUIiRKCAgatL7Dd7jZLnL3qvFe6pR4yDYcof2wkHyywskASX0t0YK9jIgrrNn7KpohnsoQItrZxJT2tyBEefy/p1CLUP++m0kHItcWbCEH5IJtLLSgwNJWqIksv8NPYtKwWuNX8nmyYjHWCaEgmh9mAEJAeeMPLIv6o6sDwA/y8rkV2Hu2MficozkaJwYwd7T3TZCy2tNOU7qKwt2FrJNWMm7ftFhbH8/DIrb3wClOFGMaNAEIsv6ET1Ka7ybHMfmHjHOnIPJSQ1TkQKtQtmUGPiG3OO7tFwLAffX+/w3ZIfdGMQWrKSgCTQ2neA23kS9Ft13AtyykbyXpY6J4oZdgd8P6FAhZAJsFp98QrTf//7AjRCesI7ah4NJaU2ssV4UowXonb+K0QWr8rmCTuFMOdW50d29dLeuxKNmj9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(6916009)(7696005)(70206006)(2616005)(316002)(186003)(336012)(426003)(36756003)(86362001)(1076003)(47076005)(16526019)(54906003)(508600001)(40460700003)(36860700001)(82310400005)(5660300002)(2906002)(8936002)(81166007)(356005)(70586007)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:03.2689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae325a9-adb1-47db-b5f0-08da3e6a6c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3585
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add DCN3.2 asic identifiers.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 2 ++
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 8 ++++++++
 drivers/gpu/drm/amd/display/include/dal_types.h   | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index f5cb8932bd5c..7dbc9fb55459 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -100,6 +100,8 @@ enum dmub_asic {
 	DMUB_ASIC_DCN31B,
 	DMUB_ASIC_DCN315,
 	DMUB_ASIC_DCN316,
+	DMUB_ASIC_DCN32,
+	DMUB_ASIC_DCN321,
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 310f8779db67..11391eead954 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -247,6 +247,14 @@ enum {
 
 #define ASICREV_IS_GC_10_3_7(eChipRev) ((eChipRev >= GC_10_3_7_A0) && (eChipRev < GC_10_3_7_UNKNOWN))
 
+#define AMDGPU_FAMILY_GC_11_0_0 145
+#define GC_11_0_0_A0 0x1
+#define GC_11_0_2_A0 0x10
+#define GC_11_UNKNOWN 0xFF
+
+#define ASICREV_IS_GC_11_0_0(eChipRev) (eChipRev < GC_11_0_2_A0)
+#define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_UNKNOWN)
+
 /*
  * ASIC chip ID
  */
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index bf9085fc5105..775c640fc820 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -59,6 +59,8 @@ enum dce_version {
 	DCN_VERSION_3_1,
 	DCN_VERSION_3_15,
 	DCN_VERSION_3_16,
+	DCN_VERSION_3_2,
+	DCN_VERSION_3_21,
 	DCN_VERSION_MAX
 };
 
-- 
2.35.3

