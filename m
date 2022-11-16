Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F8CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 16:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019D210E4DC;
	Wed, 16 Nov 2022 16:41:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BDC10E4DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 16:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKZ8jcbulXVamenMM1fwHjU6lcIQ222svM/w0mYdvHDu8LCAML7allJ6zyOS6N40zR9FmGuof9W3KKNN3REoZWREaG3SdnXhUNfLqOE8UBuQ/h7cRWDAIc+irNx8BBkOlrDveCl16dG7C5fZPCShmMakGT3HE4LJnPlYMr/Iid+RuORBvzj/ldZ+39HLqgvAbIsxJb7B2Klck9rfQe64S0XSFfM3rZ2tI1V1Zgpe7JUYGrkNWJTerljprCKXjYahEiaASZyfW/dxdKPGOBK3UzFt7w3+Z5FJean+daclNhWVTOHYEf9T0ST5Fj5ytORl8j1eVdiVtDLtw1OpVIzwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j/UBkXTLgxpBEdpyv5+QdT1iJqe1hI8ab0sU1PFQyk=;
 b=OEwcFZ6N/tc/qKFoU9vF75ActVZRo1Lm3PvRranqe0XbPIHODdJxN8bQ7TJPdZvRGrjk1PztvGVrwZYTprjtkTuy+/y4/1ROcq9ynhvmxCv/pnlIID97PbIcqVIRx9aO5DxE+dYDcViCIbGWMMfb357fGI24vOB4M2KvS1Oe3xn/8pPYiw/rF9A0k/LTj9pxTWeh4BiBCmWwgs6nJk36QJjc5qpr+Yyu2GGFH4EbbFg8/6pzHv/XykUOpin7yXnZ4pnVYOSDhX67sc0VwotnQ1m5mgGyQzrRiKK6Ejbwr0pp88XybsNDXuSli+d9gAih6NWm6b/AlXrLjIxnh0Cqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j/UBkXTLgxpBEdpyv5+QdT1iJqe1hI8ab0sU1PFQyk=;
 b=g8sstc6ZAoWNIqP56TIPBkgzb0VCXHNC6UQlZnD9hxITPeTJwaBzOMqr397LRJShgK8uYXGEkRiBX6c0Rij6SZDGGnaotNcsSXm5buyM9mx/utkBawik4yuPacTYiBDrZDjb/1J0njj9D6M12qdq9qW8HaVRqHK/gGcjQgLmFd0=
Received: from BL0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:91::37)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 16:40:57 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::f0) by BL0PR05CA0027.outlook.office365.com
 (2603:10b6:208:91::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 16:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Wed, 16 Nov 2022 16:40:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 10:40:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/psp12: move ih_reroute into ring_create
Date: Wed, 16 Nov 2022 11:40:41 -0500
Message-ID: <20221116164042.2830086-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: a8960ac4-faf4-4a9f-58fc-08dac7f15639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYCRNSg61FCEtRnvxBXInuVWldTDp+cMjMNl2piCnNVwd53rGrnVCAWzZ7OwdEKknfTjM1aUgFLf4BLh/NKEi3r3zfKrbViChzoFyBjTxzlBDLGlbKcVSNLtehbHmqgCD6oyLiXmLCyJij+PpaWwdifPvqJ1Bl+fPmFbvUjxil18RRvU+oTUpbDFIkvjPpTirQ3xvYg5+wnGq4zWw9XMNWvCFWRpeo9jPh5rMIM+w67zD3qk9Cg4AQ7hlehO87ZhcWSOxJUE3sgqTMxdAGdsrh2s7iYvFidzMoqMLQDX3eMYQkPSsMmeQnfOBe108awfjluhLXr971FZN4+hoq/vhs/GGXv1bF04D91tIhQDygAAjUh1eHTV4uxHrtMIk2j4Hkp8VhfsZmkg3+khPLhtluP5QVA9sZXk/tu0SKgCvtqTuGFdbG2nyTGlljotiGtYdD2mZji1iPQZs5Ar6D7qwma1r/Eq/POjS99+ZsHlGPLUvrbECvOpTLT8BNravuw5TRJZLn/mVORxhlMUcJYnuWSJhEhfckHSoDscjqoieDjE6nsN9qR/95a6wcfrmVYrO1921j/4KmqXThlnmDr7ON1gDHdxKjg6o6mGGgiN8AxF7oi3X2zkftRqxppWOnWd1vgwxuS+L3GtNj5qTcTURj/nkBpr8b1vN4iq8GPYbfk1xK1nL/nrfRPCSrev+6kx1c+oHxDDRC/J+5D/5OHrFs/gt/HsetBEG9nirfS0MHSg87+IdSQehk/d2COEBQo59ijVJZfNdQPMk8pnj9RetW7UKkEunQyZ9WT5t1jq++5mx07U49VbEHNxmBeyzohU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(36860700001)(356005)(82310400005)(81166007)(86362001)(40480700001)(6666004)(478600001)(7696005)(5660300002)(8936002)(316002)(8676002)(6916009)(4326008)(41300700001)(70206006)(70586007)(2616005)(47076005)(426003)(186003)(83380400001)(336012)(16526019)(1076003)(2906002)(40460700003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:40:57.3521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8960ac4-faf4-4a9f-58fc-08dac7f15639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This matches what we do for psp 3.1 and makes ring_init
common for all PSP versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 0b2ac418e4ac..d7dd84090c09 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -243,8 +243,6 @@ static int psp_v12_0_ring_init(struct psp_context *psp,
 	struct psp_ring *ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	psp_v12_0_reroute_ih(psp);
-
 	ring = &psp->km_ring;
 
 	ring->ring_type = ring_type;
@@ -272,6 +270,8 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
 
+	psp_v12_0_reroute_ih(psp);
+
 	if (amdgpu_sriov_vf(psp->adev)) {
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
-- 
2.38.1

