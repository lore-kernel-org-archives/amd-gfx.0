Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D1BC43217
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D197360F23
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D197360F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37E6E8EF;
	Tue, 28 Sep 2021 16:46:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF36F6E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgKNxsB2StY8OP44VTMEMCUT1gtraefjFpHtRKdws/0VYXot88645Zwma6qukbouU2RPnDiSWjAcUs6S9r9ch0MDk8kfIIyiKCNgLW7WI/zZgGQzmyrHtK7GQzDshh2B7dJD7BSDJdWa7SzxKu3dBUe99j5+iT9vhhCyx1irAWUOSCntyYVmu7P3jl/PcynVTCHYZemQxCpm+m6DaFzkI7oLSTohFNS4bIWKI7YeUqjG1QOA81EC8NnL3f3rBHfu6TVgbOsMmdhDb2bWbwTmt2iYJwtJJPfYaVpuLslPztqLS8VscsGMW7C0jSWoqTZIRj03Gt1JdlDq4lqB5rv3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MYooWEQauJFp4BxFIHMyIYsP71qyYGKxgSkxk9RQCa8=;
 b=BA2301QILEk+jm4cS14iVkM359329lGzuf+1pDS6bFCjFSluR3c5o14Qmx3EIsyQ2LvEgNu38n0MTk0vJbTsXorkeL9zSDjsTGbwn3aZNOok089ukAkD7vXzazfxTiougvergLTvXdXkire49s76xUeybO72O1uoaZAhxYEJx0mdKZT+y6EDiv2mWF9lK4uAJXGntffPQVLFKZ2z9HGldRl6D2o4ew64sKi3hHKsf9vuSFvXSDuYyTZmtiDqZ4oux1JwWq86u07QQoJBiMpNuX2HlnDn4uzLfhqKBfIuKP1ix1pidWO9I6HuI+jPt/Be6t+g8CJBKO6qfPKspIhSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYooWEQauJFp4BxFIHMyIYsP71qyYGKxgSkxk9RQCa8=;
 b=aWOZOIKjV1xEjXXq/tcGVB0JbYvrvy94Cq+/8LCgHYrTN/rwQ8j+vMbabJvt198FRFxdG4kj9zEBHrip4cUEOk562bLBjn+4wunKjsObywAtKo9iRycITMMImiVSCHh6QpCKvhfblUAoyN4lOJk+25qP9yeftldwc0CvFGL7lK4=
Received: from DM6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:5:14c::37)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 16:46:39 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::93) by DM6PR11CA0060.outlook.office365.com
 (2603:10b6:5:14c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 61/64] drm/amdgpu: add support for SRIOV in IP discovery path
Date: Tue, 28 Sep 2021 12:42:34 -0400
Message-ID: <20210928164237.833132-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3575896-2cf9-463e-5bb6-08d9829f8aff
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3993AA0A2873748C65A04997F7A89@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D580HM1VUevQy7sNNGQqqSatA0lTaKPR78Z/qSnjPqBxwHocu5T+4ApQ87rPkGT5Bs84hE4EpP9ewCQC0OMh+8qaA+cLOYfsUi+0mPzIqs57U23xJk37fGQi0LJs2UrBjtSS6lwAx7wp5z+qkg0oJW6EeS+9JVHP5YQ8Hjjv0YOU/VvQX8nicfltjad1EW002y0LcNh3m03uAK8O0q7v3rsMCepa58A3AKW//IJZN9E/JD+3Rc6vnfMRHv/IHWtHhwtq2pZ7sFusthDZEHNkTb+Y/fWhAW4DnnXLeu6EXBD0VStu3SPnuip4bNp51gmAkU0NwCE+VuSFYDULI2RGWFjE3tvgTM7GUenVtCPWTUWSElhM4gQG6E+C02rEWOaLOI6hW2D95BN1NWtKvSJTccGpOlb9Q0fyV67ahZh5bIDEdexuqy3WFzsRiCDSt/5wlycH0ZI/pSsSyjjYkmoppjfyQKD/hfFjSDPPUDlH2ajQ4jKTNrGNr76zpD8a3yOz7nWfD0N9ql9jReE5Xbm/oLVyDTt2K1e27pI/E1ttwNHcZv6MjfzpmDjbHgdizZucxQYidqIe8j6U7c/L9OvSd86slvz34EIy82rVdRsqSSPB7dMxyST3+MaSkkbeCpr9KS5nigK1jK89ciqxJ8cGnelsHsSB0Zrxp+IHDB7pjXOYEA2q82AvpP9cgL8P8A1wsLMr/NL2672drgCayq/xUrBinPPO7k0d0Z9j9x24BA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(83380400001)(36860700001)(82310400003)(47076005)(1076003)(356005)(81166007)(316002)(86362001)(26005)(7696005)(16526019)(186003)(5660300002)(2906002)(6916009)(336012)(8936002)(70206006)(4326008)(2616005)(8676002)(36756003)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:39.2168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3575896-2cf9-463e-5bb6-08d9829f8aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
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

Handle SRIOV requirements when adding IP blocks.

v2: add comment about UVD/VCE support on vega20 SR-IOV

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d9c2a7210a1b..091ded38545f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -820,7 +820,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		switch (adev->ip_versions[UVD_HWIP][0]) {
 		case IP_VERSION(7, 0, 0):
 		case IP_VERSION(7, 2, 0):
-			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
+			/* UVD is not supported on vega20 SR-IOV */
+			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
+				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
@@ -828,7 +830,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		switch (adev->ip_versions[VCE_HWIP][0]) {
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 1, 0):
-			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
+			/* VCE is not supported on vega20 SR-IOV */
+			if (!(adev->asic_type == CHIP_VEGA20 && amdgpu_sriov_vf(adev)))
+				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
@@ -860,7 +864,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+			if (!amdgpu_sriov_vf(adev))
+				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
 		case IP_VERSION(3, 0, 33):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
@@ -1202,14 +1207,24 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = amdgpu_discovery_set_ih_ip_blocks(adev);
-	if (r)
-		return r;
-
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+	/* For SR-IOV, PSP needs to be initialized before IH */
+	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_discovery_set_psp_ip_blocks(adev);
 		if (r)
 			return r;
+		r = amdgpu_discovery_set_ih_ip_blocks(adev);
+		if (r)
+			return r;
+	} else {
+		r = amdgpu_discovery_set_ih_ip_blocks(adev);
+		if (r)
+			return r;
+
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+			r = amdgpu_discovery_set_psp_ip_blocks(adev);
+			if (r)
+				return r;
+		}
 	}
 
 	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
@@ -1230,7 +1245,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+	    !amdgpu_sriov_vf(adev)) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
-- 
2.31.1

