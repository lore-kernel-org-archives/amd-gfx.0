Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F354C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E408F61186
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E408F61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558B96F380;
	Thu,  4 Nov 2021 20:28:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB496F380
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRDiIjGjBtUrQXcfw2jaSao7sx5FnQATqyIbboFZTxf9xsUMYLS6U/TxG7KT9GETchRxzvSsbrJ+1Gq0Kkafxc+/99JJb9rYfUXUnHdEyJBVWHN0MdtnQQUqR1Q5zGIr/dGLwD3w6ncrIlhldnR0vOlCcANJwdA17ebqzEBlXPj6W6t+Nk5lxgrsPzMID8G3MmxDh8UuTOUqk3EiEzMEDP3znbUYLBPop5e2srdMNPFe5GAktWRWwU2Kf4Ligu4ToF5MwC9TZVfisaho+aEkFwXQc+k4b7eRVi2+cZO3WPrJZuPHmWl4wt9hiKc5DBjh0Spk/IfFeMm11baoiLvIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfpMHhHmxQSLiclFcqdwLJvY1IoytCEn0NkQbvUPeng=;
 b=neZFhK7U+pM9ujZ/UJc4UWKm0AwdHXetIFmVsxnKbeOMwmy98dIYydw996f2beNa/RquhU7F8UNlQ8Qicvy9gLSCD0S31bfcxRPvAk53lAclGD2aAIN/mB3+lbY65a9qnHy6t6ZUm+XAiVdfnFnKXhGrCWNGxh6LRu1GbiUXfOLQtE/oE+LvEXMErCVF/WrC/oukf3PY2Z8Jey58jNT6b59Vbb7d1tvAb7AnLgZw9ztksHrfqdFVAK744/q20/pyI3Ra9mi8nmwOee41xToSOw3Q3Eq11aU/Y5sDodVmCcgHEYzpCcvtpxSjNMdvO6aYzOZw+HE4Al6E+gFOjcZaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfpMHhHmxQSLiclFcqdwLJvY1IoytCEn0NkQbvUPeng=;
 b=khIOSfCS/U6YyeAC54E2oz50PkZuGrH1iL8+dCVV2ycUCIzW69KrsEUJmM/Y1kIp4ltIH10V3B8wTEaF5gS7jV6yp38oyWFmFy/+keqomjbCdGeQThAumf6YkZ+3K4PU+AcXulCNkq2pHX50QydbqSaVgE9W/7yYX+JkPBorwj8=
Received: from DM3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:0:50::27) by
 MN2PR12MB3072.namprd12.prod.outlook.com (2603:10b6:208:c5::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 4 Nov 2021 20:28:36 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::32) by DM3PR03CA0017.outlook.office365.com
 (2603:10b6:0:50::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:28:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:28:34 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Fix MMIO HPD flush on SRIOV
Date: Thu, 4 Nov 2021 16:28:13 -0400
Message-ID: <20211104202813.1518402-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d43a49-e4cc-4390-95a8-08d99fd1ad80
X-MS-TrafficTypeDiagnostic: MN2PR12MB3072:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3072A8EEC0B1257B16BD9132928D9@MN2PR12MB3072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZzYaX9OGt2C9IJ3VqrosUxcZj/4xMYXVpVibngCJ3jRPBsyUSgIWlofoeGzNJ5TQIf+hYReAOgjAPg6uaHmSJ4ZzQVqX/dflnvLSaKkj8js6w92iPqPtRUO3vOmajkKCbUs399YHHzQn70C8Enoxn8busBSHWLes1q1mCBODQ0/jzqbyGoL2VgE8vTT5Seu2m9u3P4ORQQJORsZf7DLztq1oNAANtLeRBAzU3ZArciCQqs0bwjtuWSpaXmiaiidGvmzAWmndvhEYGM+Hsrz2gkmMJXwlDuc3OAXlZ4E3b7EABEKZLxFNa+SK8WtGNsxm4o1uf5ygN9tOJiHJXV0Wz7RMm6sjwryAv2aO9GPqvv7+/huIB/V71RevlT8ZgxacY20MSTThqBq+fzivbs1xzlXpCf/1j3Ms4JYyChVHtacd0kG95JpczQw5LH27LaLRNgUg03GGdLLzilYZxmgnT77Zb65iosewTkdcqGI+U7bIYDs+ODVLX9UgAV0zKtoDBVwY6rmhqnzc7cqiM/tXifsfqK9tCH+0QPL3vpo24efTeoOMoAjbf/O91ChrA2GKYxjv71EZ9/f8D+JriCuGKBgEKoOetWAuX4Qn9iIl2vrWcPYLsPtKBvfvbx3vAjaUVgL8hFzJ/VeogbmOBauhCYXwpSi3z5AiBRcslw0lFuwSPktUD1xuPnmirwUVaVrTVxbL8kI2KN07lOf3MUoM5f7M0SnXS7sLQEfDcwjspc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(508600001)(70586007)(6666004)(26005)(70206006)(1076003)(8936002)(5660300002)(8676002)(7696005)(316002)(4326008)(36860700001)(6916009)(82310400003)(16526019)(186003)(36756003)(426003)(83380400001)(47076005)(336012)(2616005)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:28:35.6652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d43a49-e4cc-4390-95a8-08d99fd1ad80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3072
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
Cc: bokun.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The HPD flush registers are not directly accessible on SRIOV. For kernel
usage, use WREG32, which uses KIQ on SRIOV. For user mode, don't allow
mapping the MMIO register on SRIOV.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c      | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 83f863dca7af..98e644088167 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -632,7 +632,10 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_
 
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev)
 {
-	return adev->rmmio_remap.bus_addr;
+	if (amdgpu_sriov_vf(adev))
+		return NULL;
+	else
+		return adev->rmmio_remap.bus_addr;
 }
 
 uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index eecfb1545c1e..ff4c99566404 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -41,7 +41,7 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 5793977953cc..5384e70e31b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -32,7 +32,7 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 }
-- 
2.32.0

