Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D79C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 05:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB0910E949;
	Fri, 10 Mar 2023 05:04:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EBD10E949
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 05:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZMXcJj+2A9WN/7lWpdvsacuZYu3IWbihusQpbmfviaieM8jG+/ZSaFRq29UBbrBYcU/vgGPHPbl+z/coAgVrBOAWl7+PdYxk6TUDJD+jiuXwgxkjUi+q1zeJ02/1rKVgwcYAlBVjcQnOn7wvUaRGhqFsBIye7bhK7H5Ems+IAok3Di/n6ZzCfJMfHZ+D5NEdkgGyszl0eQzy8EB55WGCIYKDFu8MBEumPyGbVd+I4hQgNN1nfS8kgNk77fj0tiEEqIZ+o5A4oTfpX1ZLdYpYMSfLzpH6pVL5pcFABZhem/e8vm6dTwj2XJivDLuH5apnvuGKS4XWTUYcAScvxPhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7YZrZOxrn0lyBdlhGt4ldT5x1ces53EteVl4iDTQPI=;
 b=NP+xtmYPabTbumb/981xMzTIdmlPbhTqUYDxRs8O3CmJyjV7UXkynXhAsNSZ9ErH2eoGv3vNf4AkpBe7XzYh/Ryb70DeK5w/t0/9h2lwlOLSRyJCFaF5+hVpenTq1cWw9zaRj+nq2PaRE2hxE+iLmf1FSZTfNRnuACjEbmOxRZCyIbJaOvVCRLUpcXE/hTUK+jx3PSvygSDZDSN6vbQaMJQ/cNjC1AVucShuPwv9+tubeqEorUkzd2vuyx00TX4sWUO1sWCKHn7wmaQZ4MCajmcscd9Mf5CsRrEgh7mVMCE+YaMeXJg65+zPw0Qu6hRdptTeSaAbFB6fsWGk6MbRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7YZrZOxrn0lyBdlhGt4ldT5x1ces53EteVl4iDTQPI=;
 b=BnFEl+HA4DqVqoWAOu0wNOOXxdpKNDgiYQFMW2+XgWG48HqzH1vz9hzsODk0YsynholswAC/8ZTWRpwSRLID5CHvUihQEiUE0EcMnsZFMe3iW0ddqH5v4bpRLiX7Or+TviTM4Z2AoLWLjuUXuOWgNqb3YJ90gqqiFwhKVrEQI9k=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:04:15 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::8e) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 05:04:14 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Mar 2023 23:04:10 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <evan.quan@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: drop pm_sysfs_en flag from amdgpu_device
 structure
Date: Fri, 10 Mar 2023 13:03:42 +0800
Message-ID: <20230310050342.2902820-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 57252149-f37a-472a-1a36-08db2124e530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUPFiUaC7cKM6CDnYV+y93JZSALbZ22ko7heS+WpHbCmboLjt9iW/BSoMOgmVn5aalu/nigtVQ8sxWA0WzarqwngjUhLUaKUIY7TMpz6OReR/clsB+6qlPF7yvI2kHZuUwG+nmGk2q+lP1LSZBJAUMK36nwx8rqlAdapLDPSYvyJKZPQsctqD11119ExTGbjOt5d9FbN/vFQDFhvs4vx31bQLhH0EBe4TjRNUBK8EvOmdZBk53oZMvO9WFaCf+2HAaZvJneFV+6MzAz7SuICIeIQO9wyhuNpZMzQSfriVF+V2GF5TRhlvF6mYrFUmYP0Tm3i3XUg+vATShVnwETzQykiupY1gpCc4l56gcCzHstlZnQnZbvBN9nYLi17b0e21L3no9bHEsOo9C4iBoeSxneahYe+YLlrQlvr/ayA70GHzp6MO1WFhIB2di5vA1LZ3csi+Mi2y8rX0B63uWalaCMeZEatBvw6cTyoV10tsZCqS1cwHKptuluJ7E+ZyXuPZuQH6idIXVt60BzTP3c+kUMrFRG0+hat5fmODowSBBvMWcJDWtWb1ODeitcMicTuOOMVP7H8wxtxXLgINq7YUbTXpF+9WFNrDunT3WZ4Di8b85vg8PBSQJpUG9//dbd3Do4uBzxh+6O/IPt5D3M1+OmhRXJ45hXh19yYHgn7XqoMqSXMZdrVqHKX/mQa2xOLv1d1cUTNFvoK7tkmHzBy/eQnw4t+O/rZu1t/OpeR1Hv51/KgN1PalMH4/WvTgutG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(110136005)(6636002)(41300700001)(478600001)(316002)(4326008)(5660300002)(2906002)(8936002)(44832011)(8676002)(70206006)(7696005)(70586007)(81166007)(82740400003)(36860700001)(26005)(356005)(40480700001)(86362001)(6666004)(186003)(16526019)(82310400005)(2616005)(1076003)(83380400001)(426003)(336012)(47076005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:04:14.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57252149-f37a-472a-1a36-08db2124e530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pm_sysfs_en is overlapped with pm.sysfs_initialized, so drop it
for simplifying code(no functional change).

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 164141bc8b4a..386729cc45d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1023,7 +1023,6 @@ struct amdgpu_device {
 	bool                            in_runpm;
 	bool                            has_pr3;
 
-	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
 	bool                            psp_sysfs_en;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da5b0258a237..41ef3368556b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3864,11 +3864,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
 	r = amdgpu_pm_sysfs_init(adev);
-	if (r) {
-		adev->pm_sysfs_en = false;
-		DRM_ERROR("registering pm debugfs failed (%d).\n", r);
-	} else
-		adev->pm_sysfs_en = true;
+	if (r)
+		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
 
 	r = amdgpu_ucode_sysfs_init(adev);
 	if (r) {
@@ -4011,7 +4008,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	if (adev->mman.initialized)
 		drain_workqueue(adev->mman.bdev.wq);
 
-	if (adev->pm_sysfs_en)
+	if (adev->pm.sysfs_initialized)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-- 
2.25.1

