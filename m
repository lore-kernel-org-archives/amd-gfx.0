Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17BDC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 06:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3287310E346;
	Tue, 30 May 2023 06:51:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714B310E346
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 06:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0QqY4ZaKkH0plcdVHj5W31d14VWezLJTAVYKiIUPjU6Fn205yIl3jkpzEbnZ4Omro5zEb4NG6oqLo4ukCb88XK/rymzDU7YDZ7pmTPz6tusPbVsrXL6P7BonxFZLTLxlx5bXsAGs+qdN+sbWjl4xvsC7J5q4b1trhdhrMuDvvLHCz+PDorlx17kIu3ECRvs2bvtyaevgnY9sY3IeuhjZxnCpdoPW3PrIS+NLqCb3pZGRisA9xiOTo8Ra0oYmA8PAIu/6Ipk7OBzU1hxFGwJhkvCa/PoDDkMKp26CtlnxcZwp8HTwCs3fa2XOmZBBNfVGW8KsFPasrDDv5NTKMKIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtURHZbWAl7BqIYy8CueQRf0BLCCGzfhwOjHRUhtrrg=;
 b=I2SvYhPm8P+s35/dzPk9JxkRlGEIG8hNeatoAZcLfVb0k3bGv3lQLGxciORAkNY4sPhqZS5StbuHfFRbIJMoUz2N2Tm3kUmNsVcBDMZoPRx39OwV5grjTw/7jVruVK+6oT30etMtYHbMEDJ/sBL58Omh84hUJvUNdc+ZmVdDtbgYl6vtxAqMY2y60Y63DpEc4dxB8j28PXqBmfRCFs8b26di6GiHM/svdfHxOKC4o4dpn0+D3sNStp//GCPIR7EoS3wk/+L2YmKQIIrlhbr7TkYnRLnh1FoiGGJDyscGWBGfs3b+XGKeWcwVsQ3jnIydz6dITAE7Rnrtim3gn9iepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtURHZbWAl7BqIYy8CueQRf0BLCCGzfhwOjHRUhtrrg=;
 b=ZH53X1ETUv8fa4M67RVO4URMN/vGbdzD5HrS0trZpA5X2BD2cgcT0w1V/aLx/3FHVuNrtsDA4SkFhIeH6QNF0MvTNCAFJUY7S4ilLbWi3bZ+faDjWJPCqdh84eCmfL20j9wIxFv7FOcu+g6frFWfCLxbUTgzpCzbdK5tte24YkQ=
Received: from BN8PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:94::42)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 06:50:57 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::1f) by BN8PR03CA0029.outlook.office365.com
 (2603:10b6:408:94::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 06:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Tue, 30 May 2023 06:50:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 01:50:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Initialize xcc mask
Date: Tue, 30 May 2023 12:20:40 +0530
Message-ID: <20230530065040.573148-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 308ce48a-1b76-470d-692a-08db60da38bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53rDYjDU0VX4vo17cDxPDV+ACsrc7KxQC/Sxz968Zpwi+kqGTU3aGr9q3iwEttZrZmlqrovoxLlR0/T00pCldlyBgw9kK6TC3nUbjetuZItSYYKcr5cyUthitYy5vLhEBLv9GE9CNrrZUkpmu7t8ISNULlxCK7/6QBGM5yT2DFhbzAYmdNlNgNHPm6VuNn9Kf9xBuzMYyD8r3Z8CmHfdU7u3fG19RkUY8YcYRzsvE3LdgdgM1z/sVJmwYzG9UhL1rbkEpY3pUhbIk+kgnScoqfEPyUJBbM9hE9LBOz+YkciRfxnLn9ssQVkLo300zyd41bVhB2dt5EapUmZjXOu06WU1FgE9XA6lyIViP4T6jeQbADD9DhOV+0CCkaEnTo5I/zfzQ1sRVUTdWa7VQFVaAq2JphXiQwgKHkJ4B9E3qw/chQ5VgPFqQqDggn10uOvwT9+jyBxgJj44sgjvFdIwg6XPZ0bzpBeMCDAJNWQSm/nMDvIQvJvZGvmhnbN9lXEFB1TgBXhUlRt8eYVbCx4qvFUvm1I0o2pp+ObCNgOtRS9YCagpyXSWdSnPcBWuH7AXSmjxpZPSpSJPvlFZEXZBNHSi6J6NLVsBTL6wZ0fTqBjBfTvO+hzFLXPdqfgjhgDzXP9W9dnCVZUveTXMm/s0xWWedSbRwshdfec5Ljb69dPIijVtbIBgblF5HggxbLRxiXPwKednnz1NiWcLwSwffVtR1IOBWuNBlPfwiTbhXQahNYmBHCc/A3aPtqN1wBDasw0O9E+JThp73rcZhJgHRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(186003)(2616005)(2906002)(54906003)(336012)(426003)(478600001)(26005)(1076003)(16526019)(44832011)(47076005)(40460700003)(36860700001)(8936002)(7696005)(86362001)(81166007)(8676002)(82740400003)(41300700001)(356005)(40480700001)(6666004)(70206006)(36756003)(70586007)(316002)(5660300002)(82310400005)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 06:50:57.3597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308ce48a-1b76-470d-692a-08db60da38bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For ASICs which are not initialized through discovery, initialize GFX
cluster as 1.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 809558c718e3..da6caff78c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3028,6 +3028,7 @@ static int gfx_v6_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_gfx_rings = GFX6_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  GFX6_NUM_COMPUTE_RINGS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0f0c12bbe228..20fcd86a3e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4179,6 +4179,7 @@ static int gfx_v7_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_gfx_rings = GFX7_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 2f1ef75e126c..51c1745c8369 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5262,6 +5262,7 @@ static int gfx_v8_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.25.1

