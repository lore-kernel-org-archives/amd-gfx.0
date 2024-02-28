Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6280C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 06:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F6910E5A2;
	Wed, 28 Feb 2024 06:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzDX6Y5f";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4516010E5A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLjPTU1IMCHPXXEjskIKO0+zmSftviUofytI2QU1Jaeqs8cgpBIYUz9dNBqqpKbBKT3vkMyYGeXmc0MYq8VPgl0BuVPG+zpXFNJulbHIsdi3aI6ARZex1oLLra9QN6Ffe9Vmdmz4sE3M6taqjZAn2Kgwkk5KKlCHRJ+8TCYhaOjIOoLsbhNN8gA+ylamYEglwYPK+0GmyQ3rghzrP7nrJVfTFYNSj2YpbF9PoOsc4/auH6pELI90MScw4AVzduvwLc0g7vOa0ySRI+534UdpOYDDmB2cFVuyBFeWYFlhH0Xgvf45zN42V9zRPW1ifgMIElMUMIS9bo8G5vFONh/XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUL5aAD1vEeYGIoa+CmLj0/jnMJjLOzYk6r9ZdGtf4I=;
 b=TOUDLpE1z6PACsEmNEsT2msZ6iqFryNBLmr6Prsf7H6hjgKxpRM2zqF+IRxCtxSt9DcrxCPHJe3V+DgyON67vt/FIOVKHiRjBWBGc9y1yCvxCj/8nRC0d1Ux9IDH8vM4z0t3HXWQF7JIuU90k+vszhsDCdzTozaQLT37gslSxVasJG55XvKd0cJztVw89seKeQCKy4g+Hw7fqHdMRs9bK99kNC03vGotqZsSFTpDE+OVPLmV3HYgBfw2ww65LpbMI9Ehqm8Fokxu5fhA5gHskMFuRGgbGxEtj1El7vUvKr5F+BMuLYiT2M1/sgB5UmfyyMEu7B5HFOosoXqFGrAJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUL5aAD1vEeYGIoa+CmLj0/jnMJjLOzYk6r9ZdGtf4I=;
 b=pzDX6Y5fE8XsU0jzBw05vFQpM4pSMVilhrrnWXTeR6w6VM7AfdbVZt9mtpbt/1EfYvCgjqAzF9Z7UKeMLEvcS3liaKFd7+82PB3ZYVrCAmQnp2Gn2z8wgZLkkkgwuSB4TMmEtCJ+ZAkdSURuciEONEjfFCTTqmIHSSVOT3mcIsA=
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 06:51:58 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::f0) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 06:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 06:51:57 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 00:51:55 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix esm reg mask use to get pcie speed
Date: Wed, 28 Feb 2024 14:51:43 +0800
Message-ID: <20240228065143.2103613-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: b442defc-ba4d-41c3-0bd2-08dc3829c1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMMtB656hjcRwnk4DC3tVRYTA34a+FFjqJn6G8Civ4u1wwc8OeguEqCsjsLi0nOwjR9KqWKZbo06YFwBIKNjto/LmRh6s74Wu8kb/UadJ8vMiYyNT73ACHnEgSlVrQ7TG8UAlHaMFIpFe5ofuem5Hy7+APZQ8glOWE8Ag0jYKekc5RDrR4NeOxv09iHiLIEnNZZKOnUck6XelMY3f2tgee6le7bhehi4UldqNsTlx+NZ7LxFRdWNGEF7UG7XD4kdl6mVGe0D00pZoXSJikYdSTlWu1B5M5Acht+ffXsEw1V55CXuQnLHh3MsOfKBzYL5KZMTv+Udiw2zfWBhKhoW3hTgSN2zcmd4mepq90M+ojaf42G9CCxzX/XR0NJWyK9W3pz2Gmendkk4bB2Bfv/FNsn+iW0eBe4a9Zk//3ATj7k6VJUlizDltyf18A85g9IOrZznMrFy1XG6pwVGcbSyFm+zjrtxTUVKmfScD4g1g52XWq9F2LYrz+WLfXiI2OYy+XpqWQOPg0LnMaDHchfSNqXKnY2aIVblPDMToOcfoqlNu9MGOZeUxLxJdVI6Ng8Tkkgy+TuZf779QVyJz/H9S+g20ft0i6F/bjuOeuU6HlUjWaQf++40Y7KNrOmbPxBuySqwFETHKQ1wCffh8ZMsyhiu+cFlsEF+hrgncCA6FRDEMw5CoeF2d57V9A4StQde8nSXhDsdwamwH4mJPabveJg19AKRvai/uZW+9/AvWrQ8kXk19WIli3jbwTJiPy8e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 06:51:57.6184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b442defc-ba4d-41c3-0bd2-08dc3829c1d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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

Fix mask used for esm ctrl register to get pcie link
speed on smu_v11_0_3, smu_v13_0_2 & smu_v13_0_6

Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support (v3)")
Fixes: f1c378593153 ("drm/amd/powerplay: add Arcturus support for gpu metrics export")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index bcad42534da4..1d96eb274d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2272,8 +2272,8 @@ static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (uint16_t)(((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v11_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f122ef49106c..0467864a1aa8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1683,8 +1683,8 @@ static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	return smu_v13_0_get_current_pcie_link_speed(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 69c64bc6e2dc..744c84f3029f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2148,8 +2148,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 	/* TODO: confirm this on real target */
 	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
-	if ((esm_ctrl >> 15) & 0x1FFFF)
-		return (((esm_ctrl >> 8) & 0x3F) + 128);
+	if ((esm_ctrl >> 15) & 0x1)
+		return (((esm_ctrl >> 8) & 0x7F) + 128);
 
 	speed_level = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
 		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
-- 
2.42.0

