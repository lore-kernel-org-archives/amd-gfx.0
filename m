Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F00C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E4210EFEE;
	Tue, 26 Apr 2022 18:27:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86A610F0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFHqczXaWuLIUHqFBgVnKLY++70rKHadlPoBrSDzbG+hagdXJ/MzV4mnOOZphe5amaPAGiHN122KSwniNtG7vHu/AQST/wNo2WLo3qYYA6EDeRtlySN5MBIMD+s51Z9iV/pAu3Dg9T7hFMvS40pOzqQ44H3nzyeIFnrDHCqCREuKNA9VW8rsm6FY/TuJJz2v0oqzZbjNcgnPg3CbYdOoRVwh3q1GvoM91CEs/4F11bMEa8hr55b+cXDte6VvUmv7LDFC9lhR85RXJcbZ2vHHZn/+Hi/8GcRZy14ZwC5T5t8cFzFYbI1fxwSB/7hVLXzhfQ0sEuc+L8NL6G30GbgxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9dk8a7m1ZxTyCmIbcMdnf0wad9kS0Ba/Sb7NtT1tOE=;
 b=QUOTgKnWnrWIZR9IsJ1K0z2R7PvnAfvgXDrDq4nK5biV78z3J2LNvXf6nRB8PN3g9LDasrB9tZ7AAeZX5S3scj4LpPTqyiXm1JNY1spW6rtdTo5O3vpqLbg5SMXjRrjFO8TMBGEYUlYYkeSrnJkiYwzTKk27FcvbrAcXFmTdWLSL4JYwkDRdd/UTlMNkuqo/3s7zRUW5GMF6qccRJzHCZeYpDtoSqAB+EVK8DnCPUh1nsIHS6+ypXwGCOEsnxYBjuC1vAKU61bVSh4flQR6Bl6l2wdkYVQmJxMWKp4vilamWSpjDwq/bYLwPeaZqEWqJ6TwcrBXNZMZMwqNcu/4exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9dk8a7m1ZxTyCmIbcMdnf0wad9kS0Ba/Sb7NtT1tOE=;
 b=mpt7luz9wmDFyJlMy9Fiq/Wg8sqnZLA1M1jmRLfM8OmlqblbFvFOAeveCQcYitWQUolOVv/DkIG0a6qK6+JDTCVh5PJKmUKul8TMvXNNCKlRh2nixhgdoExZ9EyVyzjkXB59L0cjgs5S5FjEmtcU9KTjs6wyH8CcEgA5JbJJ4U8=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by MWHPR12MB1197.namprd12.prod.outlook.com (2603:10b6:300:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:27:50 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::9) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu/discovery: move all table parsing into
 amdgpu_discovery.c
Date: Tue, 26 Apr 2022 14:27:27 -0400
Message-ID: <20220426182728.3006737-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14544be2-a174-47d1-d49e-08da27b27889
X-MS-TrafficTypeDiagnostic: MWHPR12MB1197:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11978C9F57C0F54FC8144BE1F7FB9@MWHPR12MB1197.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC9jdMYO7yLcBnzJESdCwJ8Vs88ppXDd3VAF3nLAwvjIxueC3q8UYvWzzwu9wt0UF9Apqwnd6BADhwG1TWYiaXxRXHzuUhr5sT6wBfJTx8ZM6Y+ALyq/Yl4hs9Xe3AIF/ywYmwCZaUbeTHcZj8VcZB7WMvVAxAEBYCHlntUwyjvPq5NG7YaJtaSOYQGojDI3VS20XDBlDjwTAao4tgYZDobExeAk/bErrIL/WBQqEwUmmOeh7gfjw3/6tV9pJisY9d6bqi1oWlgiRY8SJSQE+RFfIQAsaatiMzWq5l39XHngj0UpQc2fuISJKV4xGI/13QBM9UnNFURzARp7opxZZa6x4Ve2ZcwM7EFcn8VyKEj22EWRpc/+1GtiFXkbS//d/+w460I/tJYbi7vhdLvJPRdJ8McXR3Wh+aLMMD5vGA/ZrrVLoj8y+13M1Av96HKJX6KsHsuYVZd9XWBHG6yLo70Rk3aWeqt/YyBp7x09DDp2PMIt1kPOOEZlPv3MDpsIM+VH0/NNLoEkyUVPM7RNO1aOD83wWFn8bgoGFsiCLOGxv783SXVuRO9j7dj7WgLsWMPAS7cGB8bmx2R5kCtTvObZID7wFWB0dPySlmGjWJh0rZimE+8TUkdGcJjzO7f7pCZX5/76NUK7qJT9qD8j2NQa2TnvqtEeiVmpvsnjsvyErn3qrntW2fpuD5hxi0O4mxUpJknTX7+KW5ddYldT9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(7696005)(36756003)(83380400001)(508600001)(82310400005)(336012)(40460700003)(70206006)(26005)(6916009)(5660300002)(36860700001)(86362001)(8936002)(81166007)(47076005)(426003)(2616005)(2906002)(1076003)(4326008)(8676002)(6666004)(16526019)(186003)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:50.5682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14544be2-a174-47d1-d49e-08da27b27889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1197
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

This data has no dependencies, so encapsulate it all within
amdgpu_discovery.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 29 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  6 ----
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 13 ---------
 4 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2e77362b32da..bbd5c2570e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1926,11 +1926,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	adev->firmware.gpu_info_fw = NULL;
 
 	if (adev->mman.discovery_bin) {
-		amdgpu_discovery_get_gfx_info(adev);
-
 		/*
 		 * FIXME: The bounding box is still needed by Navi12, so
-		 * temporarily read it from gpu_info firmware. Should be droped
+		 * temporarily read it from gpu_info firmware. Should be dropped
 		 * when DAL no longer needs it.
 		 */
 		if (adev->asic_type != CHIP_NAVI12)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a676685c103c..0c359ad9fd63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1046,7 +1046,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 
 /* ================================================== */
 
-int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
+static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
@@ -1212,7 +1212,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 	return -EINVAL;
 }
 
-void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
+static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	int vcn_harvest_count = 0;
 	int umc_harvest_count = 0;
@@ -1257,7 +1257,7 @@ union gc_info {
 	struct gc_info_v2_0 v2;
 };
 
-int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
+static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	union gc_info *gc_info;
@@ -1271,10 +1271,8 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[GC].offset);
 
-	if (!offset) {
-		dev_err(adev->dev, "invalid GC table offset\n");
-		return -EINVAL;
-	}
+	if (!offset)
+		return 0;
 
 	gc_info = (union gc_info *)(adev->mman.discovery_bin + offset);
 
@@ -1363,10 +1361,8 @@ int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[MALL_INFO].offset);
 
-	if (!offset) {
-		dev_err(adev->dev, "invalid mall table offset\n");
-		return -EINVAL;
-	}
+	if (!offset)
+		return 0;
 
 	mall_info = (union mall_info *)(adev->mman.discovery_bin + offset);
 
@@ -1400,7 +1396,7 @@ union vcn_info {
 	struct vcn_info_v1_0 v1;
 };
 
-int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
+static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	union vcn_info *vcn_info;
@@ -1420,10 +1416,8 @@ int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
 
-	if (!offset) {
-		dev_err(adev->dev, "invalid vcn table offset\n");
-		return -EINVAL;
-	}
+	if (!offset)
+		return 0;
 
 	vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
 
@@ -2037,6 +2031,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			return -EINVAL;
 
 		amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_get_gfx_info(adev);
+		amdgpu_discovery_get_mall_info(adev);
+		amdgpu_discovery_get_vcn_info(adev);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 3735c535d27d..8563dd4a7dc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -28,14 +28,8 @@
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
-int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
-void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
                                     int *major, int *minor, int *revision);
-
-int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
-int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev);
-int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3ee7322081d2..fde6154f2009 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -701,25 +701,12 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 
 static void soc15_reg_base_init(struct amdgpu_device *adev)
 {
-	int r;
-
 	/* Set IP register base before any HW register access */
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_RAVEN:
-		vega10_reg_base_init(adev);
-		break;
 	case CHIP_RENOIR:
-		/* It's safe to do ip discovery here for Renoir,
-		 * it doesn't support SRIOV. */
-		if (amdgpu_discovery) {
-			r = amdgpu_discovery_reg_base_init(adev);
-			if (r == 0)
-				break;
-			DRM_WARN("failed to init reg base from ip discovery table, "
-				 "fallback to legacy init method\n");
-		}
 		vega10_reg_base_init(adev);
 		break;
 	case CHIP_VEGA20:
-- 
2.35.1

