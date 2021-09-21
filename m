Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8B061184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F8B061184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7966E6EACB;
	Tue, 21 Sep 2021 18:08:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479B46EA82
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg8trYeqfA0ygmeON800R/A2qKlM9shujnu598fAN8uOioegK/NqI4z80Jt6tL92Ru+g9Kug+DKO36KhIolsRyTmbjuv3DkUsHXRtnmvqOJR7k+BL1jjg54vMKHKQIqzjP3WwztFvjHCVf6JZTb7uPfByzDwz5BUnSF67K/ERY/TdLIwfPlcSlFfNsCMM6uHaiU7VnnQoGg89T4YUnBTzbaKi1qfVunV4pKhNJKTQVU/5OIpWedC594xYyC/m87jA3AVtSAGL8vAnozLrQQtiSdgRn1EQ+DT434ZkdLCQi1xUvhswKhO8Vwa1++mfYXQDsl6ud+YA95V9rtq0nJpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=30BbG0lnhW6trpTduYHAthhRQsPBJo+lgNRfmdUsKMw=;
 b=FZ9D3tHfQzFQ2WtT7MgVtWm8jlWP73fW0ZhMuOUhzQTaqZZtVpr4K3qkgI3+rEmmXU023CZFfeug+pxo1MhCWZJn5Cka5L6/duqGMaaZF93fMW3w9fiwoA49k+CSNQPGi96lC1J8hiqz3Wi98r/xr6ZH2OquRDnq7nOeaVdchfQl98fA0Bmfw43cK/wdKu+pygLDwTFw7QZyysr3ciV1qhHT/nAk6wyOTVERvDOYj54QLNM0K5I52WKdiTIrUn22r4+qW9g+8lNJ490XeewlqsAwhgwUjDoQgdoHjHJijw2X6biE10KilOUsYcsYsEDZCu64i9s8XXcK/bSNghZlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30BbG0lnhW6trpTduYHAthhRQsPBJo+lgNRfmdUsKMw=;
 b=g8487phAgcyxmvAL+I0EW29781dzUdqeBbM2xdZR5MO1CAib804eHNxMcGIItz7m9amFiP8dIXFy3Vx5g/sbNUeEb0UYLM+d6mSKi5p8rlExwGy356xyIHUgPowI7PFqFrp1fRFTcBCTh5BEpVHijumSczp+Iesb0Qk8N9grjaw=
Received: from DM3PR14CA0129.namprd14.prod.outlook.com (2603:10b6:0:53::13) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:08 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::4e) by DM3PR14CA0129.outlook.office365.com
 (2603:10b6:0:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 56/66] drm/amdgpu/vcn: remove manual instance setting
Date: Tue, 21 Sep 2021 14:07:15 -0400
Message-ID: <20210921180725.1985552-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea38b71-c07f-41c5-aba3-08d97d2ac3f7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1321C506BD577BBBF9B697B2F7A19@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ka/boXzYgNUHmCv0zOT4m3mC/fFNyZrv7vP9RSLq6Gg2BxtEUvfWi0b0yo4Ct9grCWW+onHsWLQV/X+M9kiESCgQG6Mt4GpZo+soAWDn5n/Vy3zfM/OsAFMyVRknSsX7Fjjy7B+dvle9Dx6QLMAx0OOHc2otM394cJcC0F+sb3yR7MBhRGTQT1kbztBu+ABAjRoM0wW3By4UStV9SUDaWGqiXVPp8qBHyiD6gmO8gLmXtxZF1MVuIQJ1jlva2qp7/ipA5K4b5L9vnyf9djWgfnC6yxichkTCfoiNZb2gR2IhiNfD09de8W9JZUk4r73HRVwhhBmgYmZT+5el/4WeJFGsovVPhSLA+fiN8FsxoX2puScPGlmJx3Uqb+YU0XZXXYl+b9ViUs6oMBqky5q8rMlop+b9Ot0Vwx6NUZ0NJPZblkmCPRTuUo+0ThK43YOWVnJAyz+PsRCDEKei7Ok2lD8MHchibLJgouXUShvAN/3/5NIXC0hHv8vYWHK44/0pTf1d2+jn/1w39a5ijNooFHFJCOqOw0nRbBgmqCu6GJ3gR+2dhfx24V4FrQ0HaTHHlCpasbjbEPl/s4cy5EZL54XiPw2ILB8+eSEIdRE3X+gECgvn9u24xTQXuKa3jIOPhNOIK7CD00sCDySxxYPQoRvCOTRvgKVna0FMOrDKy6P9BtXqUK5DIv/XOhdNgyoZFWA1n1RFQniIfQuM3/M6qTcvgNfyMsbcPBx+h9oG8fU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(26005)(36756003)(6916009)(36860700001)(8676002)(356005)(4326008)(82310400003)(6666004)(81166007)(1076003)(316002)(426003)(70586007)(5660300002)(2616005)(70206006)(83380400001)(508600001)(186003)(86362001)(8936002)(2906002)(336012)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:07.8713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea38b71-c07f-41c5-aba3-08d97d2ac3f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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

Handled by IP discovery now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 +---
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6c11739270c1..ad0d2564087c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -66,7 +66,6 @@ static int vcn_v1_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->vcn.num_vcn_inst = 1;
 	adev->vcn.num_enc_rings = 2;
 
 	vcn_v1_0_set_dec_ring_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a03c0fc8338f..43f46ab07dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -69,7 +69,6 @@ static int vcn_v2_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->vcn.num_vcn_inst = 1;
 	if (amdgpu_sriov_vf(adev))
 		adev->vcn.num_enc_rings = 1;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b76d96559029..e9758969fbe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -83,7 +83,7 @@ static int vcn_v2_5_early_init(void *handle)
 	} else {
 		u32 harvest;
 		int i;
-		adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
+
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ef36ee0f3a5e..a81d834ea0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -98,7 +98,6 @@ static int vcn_v3_0_early_init(void *handle)
 		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 0)) {
 			u32 harvest;
 
-			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
@@ -109,8 +108,7 @@ static int vcn_v3_0_early_init(void *handle)
 						AMDGPU_VCN_HARVEST_VCN1))
 				/* both instances are harvested, disable the block */
 				return -ENOENT;
-		} else
-			adev->vcn.num_vcn_inst = 1;
+		}
 
 		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 33))
 			adev->vcn.num_enc_rings = 0;
-- 
2.31.1

