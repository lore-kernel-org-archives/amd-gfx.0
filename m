Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D36C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755E961105
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 755E961105
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEF26EA49;
	Wed, 13 Oct 2021 15:06:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18F26E9FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2Y9LpkUog4FQZhpCk0e5iLyq335G9a9dkJi3fz8BuyHReCcUVBOfY96UDWKKkjTz2yDYi7qI8p1KhbM267SDuGrkB7bnnEUiS5iXgicXAGjksVWQeChoRMGQDVORlwRhZ0IvMQOTHIaNtJrervtSGieh6edruw4GU+O6TIGdLo1DagtdqjSuS7e74SpucGun7+mbj5CbuYEDSsDK0X3KnQAhz/2KcMM79FuqsgAhM93cLja1MbS0R/QDCSiZtDYK3+OUeIPgNQ3ws+2oycW/NXdanlV+dXa0gikch8MilslpFHhoamnGdx5RD1/w6Q0CkPkkkfuH85Xn9mJ48EYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtkUZQVBUts23qAsT4Os5eFfx+z2POEHRcUtOR0IaZo=;
 b=PMMKtjbTJJcGC/2tnRI5gHFxaJkQv20twKeny56c+Mbh2jGe3zjbeebrpas7ESoO1zzGRHq51Vq/9PkvYyiw98+Y6vjwL2h+UfDzjlX/V7z8Y5o5WicPWZ1hhKTGbXICIz6jnRRrdgONi3lsE561tD10wiqQRzxTqcGYAqUKKXiK+Ysr+ORP9pY6iH6aUyUnSLwgLA720ICK9xhEwQK4rK5vNvNpp98MESwXwrRW8bA3VWA9VJgznw0MmpgHokR/F0iac/287WaaC1D80xI0/OpoYvHIF4NXyzPT+bK71ELbtXlBOP5psaYuPDFRVqQpVQDR9CLdGvT769FN9fugKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtkUZQVBUts23qAsT4Os5eFfx+z2POEHRcUtOR0IaZo=;
 b=ingeVCOUQq+S3knxAOKH5UOZ9nQvFtfTreHE5Qz8qXzPlrV53EVLXBFkkbr8gI6EZntICUL3vA3m0kM6zPARxRigjampRpmVCPt8L/CJcSu0G+fPro1K2AVn9Cw9sHXWksgE4MTKSqItId2pDlt08yp34W7NUcrMSyJc+D60PLE=
Received: from CO2PR04CA0144.namprd04.prod.outlook.com (2603:10b6:104::22) by
 BN7PR12MB2722.namprd12.prod.outlook.com (2603:10b6:408:2e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Wed, 13 Oct 2021 15:06:21 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::76) by CO2PR04CA0144.outlook.office365.com
 (2603:10b6:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 15:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:06:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:06:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/nbio2.3: use original HDP_FLUSH bits for navi1x
Date: Wed, 13 Oct 2021 11:06:07 -0400
Message-ID: <20211013150607.1580288-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbf6f93-424e-4b21-ce18-08d98e5b0419
X-MS-TrafficTypeDiagnostic: BN7PR12MB2722:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2722FD6B08580E82602ACA47F7B79@BN7PR12MB2722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sb/2doeduFyjlW4QQypoLgPmJU6Hxn04Zq6FBusn+u6gpo65bevOlESLKn7LGxX3Z5NeKz9oBSe3X5zBZqTMMEpUByVz/InlEFGoo9oETH5BQknM+PY8T7S/NyeTh/70Tty24YNGjXFRza1FSCqCeKmLcYRvZnzyJliLEtg5hsR68o5KT7Z1mi0zl+4eedHe+Yng7KVTqCFZQtwJCdp/jDSRckAI0EBZliSCeewvzbPh3vgGbTuPkHdrPOQEjwgLu6D9OIi7YCU8VAft2EOnKYY0TTUYdyD3Vfy0f5M+4JueWf2qCHsTQN5xSfDkQR9UmT+wUARmQtO4kZT13nENvpOft6ZNcyX3p9fC2osZDF800jfZdBKOWTeXNSzASsn1sLgEw0oStcwAGwfpYCdRI5HTVqVud7ZmMV8nMx5jzF5C93pgYO/tW3rthQUvbipt4/9wlBZy0BvWezn4pTAGcQOfgApRe9HY5Cylcq+IpKOmEEV7J4x+TcCxy4zvn+YDmAYrtXAzf4o9jdwLFnYTSkBQf5cJPsNiuyqYhfLy7FihBMCMa1m7bqytbL+/OzpZ53mnH66fyS5+9hZ3vxS8eV0r+u/mUQzsO+jjdwTEBbdoPZ56TO2/1Vakh+QgQ+OxAFK4QGGL0edxsLUTKFumQyDbWOIXI+1vjfR82UNdjaxOM1EUE36S0qiRpI2IKRl5kgUfAC2JbqsyO1s6HzwQwZKTYoC8rgJGVD66Cz9//GENb/UQyyW1DOGC5d9hm7F5+0Q0BBbiwWfKaWb5VSTJ0maKQDN7Fiv4H6JKasx4gTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(6666004)(508600001)(2616005)(36756003)(70206006)(1076003)(5660300002)(36860700001)(70586007)(86362001)(16526019)(47076005)(7696005)(316002)(26005)(8676002)(4326008)(336012)(81166007)(82310400003)(356005)(8936002)(186003)(426003)(6916009)(83380400001)(32563001)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:06:21.0074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbf6f93-424e-4b21-ce18-08d98e5b0419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2722
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

The extended bits were not available for use on navi1x, but
navi2x only have 2 sdma instances so we won't conflict with
firmware anyway.

Fixes: 468e994c41ecb3 ("drm/amdgpu/nbio2.3: don't use GPU_HDP_FLUSH bit 12")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h        |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4228c7964175..9645b95b9c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1133,12 +1133,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 3, 1):
 	case IP_VERSION(2, 3, 2):
+		adev->nbio.funcs = &nbio_v2_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+		break;
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
 	case IP_VERSION(3, 3, 3):
 		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg_sc;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 79bf6b381862..4ecd2b5808ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -314,6 +314,21 @@ static u32 nbio_v2_3_get_pcie_data_offset(struct amdgpu_device *adev)
 }
 
 const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc = {
 	.ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
 	.ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
 	.ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
index a43b60acf7f6..6074dd3a1ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
@@ -27,6 +27,7 @@
 #include "soc15_common.h"
 
 extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg;
+extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc;
 extern const struct amdgpu_nbio_funcs nbio_v2_3_funcs;
 
 #endif
-- 
2.31.1

