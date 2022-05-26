Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4B5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E4610E569;
	Thu, 26 May 2022 18:02:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B74010E569
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=If+VpzT0RDtrAeIRDRb642cERqIrsXKOiuEtFQcFTSpsH68ynr7OSwfd5F7Dhj8kI+VAA7+rKnfbyQG7Y5ujxaBxXQHuu3GG1PWTsdoQN94PsulRdrIw0fbWvOMITpFyL7BnnaCoa3iUOpl730ij7WkucE+9RdxSaGV08epW60SlgZiI7KRMM0IYnG8nZRx6mpZcus1Ugjt1bNlBUH4bLm77YAzd8y3/nyyPDR/6GFd6ZFQGj7wdBlYrI2AaFwYMXjMZDyI6kcphEPKgSRTjn2Ls/MsYS8KCBcakXAOwnODzBuQ0WxH0pM/KXuB+ayAJo8DAvWA9DYxdko2KYxWDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izg/ceU1wZ6B3cD46m9XAeTHA2ERrHWB4N3OOVW7tSc=;
 b=E3+8Yb/Qc4Y6IeNzk2ehBWDFmW7QMylApRoWFRq+amV7fIYNNlYf65U1XpJdGu4ITYFHODJ0eww6xt5Kda/5QTOo0/BFHLqTjgkg8rvlUFIl/rkP0hQaDin+ji29SNBeQnVt0FTHg9F1S2U86JVgvU4YLUzwfpBlPynVuAQ4qLyH2REeJyYFWs2yfYpH6mcKyt5Ju+PUyVH3+MbYpr3pjLgrOpbQm+6/sZF7lhCPJCLGHD9js/+MLZ6nnqM13mOkLCFde2lnRoSe32qQYJsgDAq5CrRzDMCXQuP0W5AjeNSGvIW/OkVgz9zN+NxDPd5apb1AUaNZ/B50dTGlsBg6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izg/ceU1wZ6B3cD46m9XAeTHA2ERrHWB4N3OOVW7tSc=;
 b=v2L/RkU4tfbizlc6xdokkCfjnbYGfOCk0BIMNFUYs+u0NG2y/Q7bBVsrYwK8w66kUs1LwUAPaUmc4/Ht2E8M7VXnnWma1eVaNNWvOlXt8HIH650g6e9+0OucNhYM8LoXHv8UtwLbg9BHvG+bQ3Tl+D2BlPJ0e5u5y/s2H2BK+nc=
Received: from BN6PR19CA0104.namprd19.prod.outlook.com (2603:10b6:404:a0::18)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:02:20 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::6c) by BN6PR19CA0104.outlook.office365.com
 (2603:10b6:404:a0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:02:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:02:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add CSDMA reg offsets for NBIO v7.7.0
Date: Thu, 26 May 2022 14:02:07 -0400
Message-ID: <20220526180208.3045014-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee6ac9a-27bf-4d6d-80f5-08da3f41e0c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42496B5A2636D42CE857A814F7D99@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqurx9JKmQZjTyfLOOZtMx6EApLGs//xlrYx8T714W9Tk334y8ZiQt6aSXof22HxCPVxbrY27rXE41ujhcdzBkJKiuR1L7kAec9GJPyUhwaXdbaRiLhNgpd+5RGKme07/ebcPwfYd9R34/ypSF44ABsrYG8ql2m0PwjNWVgm1OxX3QakAr1fBISZJuPZX2imN1rPoRWUofZynrywNMo+rvHvNCCWUZQpkpi5KZLZ7b42NnVTxIxm2zTRAJF/dWSbA71By4B9M1L3K5iMV/5ru2RCEXHbIx08ADoMRN8f4LeTCo+U76zfuCbRsTB6ZYBW8BjHAryq3V0DrvjdyIWr5hvv93404vY8pKb844nEzTkkrv7MyhI/undmsx8JvmME2vyMCoAWVAVI3B/0EI9bMUFXVMtc7XWhfcrV6JGdT5H/jZGFA4eu47Ft4D2PiWUOFqrLPhkK89DxcqWfZBy3mGGrhapuDY/2sbZS/QyOCjOlyTqZvQYFH67+R2H36BXUhSyaQj8HOs0+O8hBItVtx5QF7s5ZP6Y4Uakfyau9J8Xzeintu1nVdvTJoJP+km9v7Ib7lI5x8OXJqdzj2PNtuINj2yJrrSwGFB9bcjJJQ7pC35n3w94HvX4wqYyOIGCglTCMZwTz5tDdhtKsj2DsiXIaxQvrWuvGcyI2mFhgYxAxTaUGkeZdmm1ZnrqhXHmIrj47CQqzEACJ9fDp7haFkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(5660300002)(6916009)(316002)(81166007)(2906002)(70206006)(70586007)(8676002)(4326008)(8936002)(7696005)(356005)(2616005)(26005)(16526019)(336012)(186003)(1076003)(40460700003)(47076005)(508600001)(6666004)(36860700001)(86362001)(36756003)(82310400005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:02:20.1857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee6ac9a-27bf-4d6d-80f5-08da3f41e0c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will add CSDMA reg offsets for NBIO v7.7.0

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h  |  4 ++++
 .../drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
index 162d9017b238..2ed95790a600 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
@@ -4005,6 +4005,8 @@
 #define regGDC0_BIF_VCN0_DOORBELL_RANGE_BASE_IDX                                                        3
 #define regGDC0_BIF_RLC_DOORBELL_RANGE                                                                  0x4f0af5
 #define regGDC0_BIF_RLC_DOORBELL_RANGE_BASE_IDX                                                         3
+#define regGDC0_BIF_CSDMA_DOORBELL_RANGE                                                                0x4f0afb
+#define regGDC0_BIF_CSDMA_DOORBELL_RANGE_BASE_IDX                                                       3
 #define regGDC0_ATDMA_MISC_CNTL                                                                         0x4f0afd
 #define regGDC0_ATDMA_MISC_CNTL_BASE_IDX                                                                3
 #define regGDC0_BIF_DOORBELL_FENCE_CNTL                                                                 0x4f0afe
@@ -21535,6 +21537,8 @@
 #define regGDC1_BIF_SDMA4_DOORBELL_RANGE_BASE_IDX                                                       5
 #define regGDC1_BIF_SDMA5_DOORBELL_RANGE                                                                0x2ffc0efa
 #define regGDC1_BIF_SDMA5_DOORBELL_RANGE_BASE_IDX                                                       5
+#define regGDC1_BIF_CSDMA_DOORBELL_RANGE                                                                0x2ffc0efb
+#define regGDC1_BIF_CSDMA_DOORBELL_RANGE_BASE_IDX                                                       5
 #define regGDC1_ATDMA_MISC_CNTL                                                                         0x2ffc0efd
 #define regGDC1_ATDMA_MISC_CNTL_BASE_IDX                                                                5
 #define regGDC1_BIF_DOORBELL_FENCE_CNTL                                                                 0x2ffc0efe
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
index cc3f04cfdbf7..eb62a18fcc48 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
@@ -31641,6 +31641,11 @@
 #define GDC0_BIF_RLC_DOORBELL_RANGE__SIZE__SHIFT                                                              0x10
 #define GDC0_BIF_RLC_DOORBELL_RANGE__OFFSET_MASK                                                              0x00000FFCL
 #define GDC0_BIF_RLC_DOORBELL_RANGE__SIZE_MASK                                                                0x001F0000L
+//GDC0_BIF_CSDMA_DOORBELL_RANGE
+#define GDC0_BIF_CSDMA_DOORBELL_RANGE__OFFSET__SHIFT                                                          0x2
+#define GDC0_BIF_CSDMA_DOORBELL_RANGE__SIZE__SHIFT                                                            0x10
+#define GDC0_BIF_CSDMA_DOORBELL_RANGE__OFFSET_MASK                                                            0x00000FFCL
+#define GDC0_BIF_CSDMA_DOORBELL_RANGE__SIZE_MASK                                                              0x00FF0000L
 //GDC0_ATDMA_MISC_CNTL
 #define GDC0_ATDMA_MISC_CNTL__WRR_ARB_MODE__SHIFT                                                             0x0
 #define GDC0_ATDMA_MISC_CNTL__ATDMA_MISC_CNTL_INSERT_RD_ON_2ND_WDAT_EN__SHIFT                                 0x1
@@ -119765,6 +119770,11 @@
 #define GDC1_BIF_SDMA5_DOORBELL_RANGE__SIZE__SHIFT                                                            0x10
 #define GDC1_BIF_SDMA5_DOORBELL_RANGE__OFFSET_MASK                                                            0x00000FFCL
 #define GDC1_BIF_SDMA5_DOORBELL_RANGE__SIZE_MASK                                                              0x001F0000L
+//GDC1_BIF_CSDMA_DOORBELL_RANGE
+#define GDC1_BIF_CSDMA_DOORBELL_RANGE__OFFSET__SHIFT                                                          0x2
+#define GDC1_BIF_CSDMA_DOORBELL_RANGE__SIZE__SHIFT                                                            0x10
+#define GDC1_BIF_CSDMA_DOORBELL_RANGE__OFFSET_MASK                                                            0x00000FFCL
+#define GDC1_BIF_CSDMA_DOORBELL_RANGE__SIZE_MASK                                                              0x00FF0000L
 //GDC1_ATDMA_MISC_CNTL
 #define GDC1_ATDMA_MISC_CNTL__WRR_ARB_MODE__SHIFT                                                             0x0
 #define GDC1_ATDMA_MISC_CNTL__ATDMA_MISC_CNTL_INSERT_RD_ON_2ND_WDAT_EN__SHIFT                                 0x1
-- 
2.35.3

