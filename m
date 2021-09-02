Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D510C432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 11:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47682610CD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47682610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 775B36E4FF;
	Thu,  2 Sep 2021 11:45:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D72A6E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 11:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIBLUTnQjzrss7pMWg65uXUC5+xoROyJrm1W+rnEpIiiTy+Wg2DnreaA0RN8WxXfFc35kAQRRZhvJfak1aloYMz9wpPM+15urtQJdekaB5vxne5/YWo6yBgB/F3CKfNZoLFi5bnG1lYIhp9Kb3IoPGx9UYv1kgSBlcuHuMcl/T3yr2o9yOizb9SA4MwifyJGwS6KPL7UDE74IerE8qzwLXwfNmGxVqQECBUoY4vbcWpPpgW0nCwCc6W83aPJqrGzt8H+42jyxyySv3ds+Egxsk9GjZubt0twuuAHH3qPQAmkK+SxUIpTplWwN+J9zisfMzVAGf5Z6YBJ1i1091SyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9znkKbFDEskyjtKllPDvNAmywsIYKdo8G1rlPWSe3N0=;
 b=Yu1XS6KzijNvk+Jo9W2he5l6HhfmuTC3Ia9GmVRIIC5iCFgL1f9KoHnJVlccEINcxabqqKT1SgCB/6nuMwBllCiQVezTidNvqZSQCnh7I8id2VPcMZIQ/FPC+WXRgzL93/8DEG825jExfdZl2beOCIl8tiVcT+uTfN01ZKNOp5nNKeGgkBl5f2bzOWG+lUmKdSTpLH59KohnUk7ulSSCXvhAmOFrwArwFMppeVjwd8EN9CoR7FChofcKytR9jvcq+dXoOUx8nsQ8QuoZmA2OtDKLnp96JYl7qjW0cW2fS1GfXyUU7n9ythRpP4gN1FvgDSARZ5vn+9ftWyRiQ3pSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9znkKbFDEskyjtKllPDvNAmywsIYKdo8G1rlPWSe3N0=;
 b=O7gwT2eF624E5VbQR1m9ojU8uQZZ6FYoDKObZGlpmkxQOpXBbwSKvxSNvZAQ8sZ42ZzK+XkwgbVgobPIL/GCBX4FvT4GyaxZYas/L13TgSQMMnMYTgEfNyjWsUm6yt99kHnMsAhG+kC2vU6fK+qVfkhEJ3mC36iw6rlUXoDX+5M=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by BN6PR12MB1892.namprd12.prod.outlook.com (2603:10b6:404:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 11:45:12 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::66) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Thu, 2 Sep 2021 11:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 11:45:12 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 06:45:10 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/2] drm/amdgpu:  use IS_ERR for debugfs APIs
Date: Thu, 2 Sep 2021 13:44:58 +0200
Message-ID: <20210902114459.3866-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f5ee466-aad2-4367-655c-08d96e071f81
X-MS-TrafficTypeDiagnostic: BN6PR12MB1892:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1892E091D635C3187434C5998BCE9@BN6PR12MB1892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DA9WbCUVhWMFA1pMnA1+luEQCP9v8KQIg9VWbttYy6z4dUMnjWHj+fE3Z5wyfcMi7RGYLTFNq9RuzXcV9B/GVfn0GokDAt7L6TYnMBhki/3KxrUJzdOhfOwsYltABLlVYKnUhyTOfc2Px5882/sCyDDF63JFFNQff+jA4I6xYTbTu33ugdbS0nkZEXj8ltEhHDBlvkwH87QxyqsC8MgBDsotQje0gvSEmQZXC9a64O6Wy7ASB8V+M/dGxI/MC4Texu395M6ds+x+uRchxIEClCVLVIpP5DNgTL5PrKrkER5FIuyHJ9LhK5ZuL3GFhuHXeV+DVKq7maNza5m8yHWkm+npGFNDT4TD41kKYbCXAxQQ2V2Kat0WimmOfcc+Kn4XN9KERv2OXiopsuKnd1GBMcaYwVZs1ZTQAq4ZxtwALZdiiyGDuWzH9De5vNYfB1OohJ677I+w9pFXTWBSdLsYFE6YhOffDPLLJ+nXFodEJOviXij3rj5xaX/pmbYD1db19ISot37MjHP0i9p0z/W0eaDZFOj9EK++ixEgbMmfBYEkX6BngfDNGadgE19BiIzL2ByJ4u3DqxdKgQVQlMOgYc4/dd65p5uMs/nKK3VXRz9J1Q55tnsu7YvF1t6EDlEErsc8J3asJYNmVQvSnU8AjrrjOzQNqBsGYHdsg8shPBn/pg/CK7ST2xZYm9UZ5jhzEUHZCa0ieXP+O+d2ryYnNcZlp0Wp0vOY7C7TIWFBUOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(316002)(81166007)(2616005)(70206006)(36860700001)(54906003)(1076003)(82310400003)(44832011)(336012)(86362001)(2906002)(83380400001)(966005)(4326008)(6916009)(426003)(186003)(26005)(508600001)(16526019)(8676002)(7696005)(47076005)(8936002)(36756003)(5660300002)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:45:12.1096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5ee466-aad2-4367-655c-08d96e071f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1892
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

debugfs APIs returns encoded error so use
IS_ERR for checking return value.

References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index d256215ab2c7..077f9baf74fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
-
-
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
-	if (!ent) {
+	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
 		return -EIO;
 	}
 
 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
-	if (!ent) {
+	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7b634a1517f9..f40753e1a60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	ent = debugfs_create_file(name,
 				  S_IFREG | S_IRUGO, root,
 				  ring, &amdgpu_debugfs_ring_fops);
-	if (!ent)
+	if (IS_ERR(ent))
 		return -ENOMEM;
 
 	i_size_write(ent->d_inode, ring->ring_size + 12);
-- 
2.32.0

