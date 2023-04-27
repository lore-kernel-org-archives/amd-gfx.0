Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5639C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F8D10E22A;
	Thu, 27 Apr 2023 15:27:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B250E10E22A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwaqiWEwtG6+uTjVJ1tGVDG+9Sz12q8D6FIZ7+x2KSV2t+mkLqKnpf4jtv7q9iVashGFEJun20dYeBUY+XWuthe9nVerGdPvYoU/W4TKh92xwDJtSLA6Rc4CnodcQTGx7Fyw1DOn/OaafBFky16Opl4AZyUCSrzP4i8y3JMVgYwJ/TTyytVAZS6xQoiXr5XlNjfW0uyNo+Wcw0aT4OkfLyRx2uHGATBxeMRYAbXZttBiFQA2SpfxtlLCLw+HzS/lf+DPk49JHeE6rjCZgZ+doPEmViBphVkFlukfa/0PVEAADufEYX9hCGUOTd6bkHFK9hmYlTutLt/QJ69Uj/65/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZl/DUF8oERbeDATHgY9qb/kr4jPGyRaK6p+rT/bX7U=;
 b=VHCXU9wX8y4SRIYKAlu6kY4irUSG1ke8gxRUvaDa37ICXBKPmRco7PNtoZG9m5dlLOca1h4mx/BNwiGmPY7ZCtg7SkmDRnevvWcqMBba03Gr0TEhdDFd9xSrbxvM4PPEKrDgHyoKe8eqJmgOmHSGisDGDjjeyo6o5LA2E05AS8cIT5Y8r3cDoy2oYXNu6wW1IWLzWzQU8f95NRUcNAvbSziBFkvlCaofgjk+rHb3BQaFoz7SJShMw30FN5jo8DBkGwa329Jxih4dRIkqglvlpXxv/HhVfPRNjdoqrN9aSzLqVHlB3hIcpg4kr5fSV0koYmqf6oNYKM0sdfqRuQ8fCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZl/DUF8oERbeDATHgY9qb/kr4jPGyRaK6p+rT/bX7U=;
 b=wszAI2ylJNoYyioG1Rnh81VWcaVSkEDVVv/B4H6Dp02Uo25iU5+kfC6K6tH6iW9VmjTfCz3baEqLMobOxJO2Tl0kYX8FctF3Cxy119H9PG6hZiYILY4I03dCBfOZmgBwSTyoun2xjlHgMIsstnurEWN7WgQ3OZWPKUVFq0ocpEo=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 15:27:33 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::ea) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amdgpu/gfx10: use generic [en/dis]able_kgq() helpers
Date: Thu, 27 Apr 2023 11:27:01 -0400
Message-ID: <20230427152709.7612-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 475d13c1-e7c3-4b80-d0d9-08db4733ec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpI+Gss5qw0ofBxnBwabITsWDmTxaUtD9l8odRf9J2x7fBDc2IydqISV9/MhR6SPFeoadiFFDXNBCCJCVs/rSQLUzPvL3fTiD+u/QJo4esXhUUsQaS7hxokv6pc9V/fcw6dUkui7+7/ajexoKQlhdyLJ7P6hlXehBpkTGS7IlzpZkONXGNESYlaJgakRX10nZt1Zx8HbviNhRVXCYEP0t/5X6S9JrLO0MRdhFt0SSogogWTUh+6Wjoez9C1+u0V6HgczDIVWZovoownT31OUlayqocD3Boe5m0jAOzwmczKaPFtFf98k4rE3orGVX63D4tt29MICNm9GaDSKhXFyA5FKrTbUBdBeOft1/srsK0U4YkuXRC9I0YtzBtp0i6j8zYuJ6WoSLXDZosyzJ8nbOFyyp4hQv6jLr01S95BevHepaAfwG4WK5MNvpOt9zjWYsu/V7PBPdYaqBOGcifd2XoUEFssKhiI6VkrUBI0/UMrv9vLDJpyTCV3BotBSY2NO4H1BVsFXmKw111pJCgSTxZzw3gE/ux/tkqPJ4NOS80uKeU/P+Gn0dNfcUoGjKAY9WN/8A273GY+bcK7jJ1eBaVwCzM3D+fF+VsGHOEoSxLrcdjBX6xIYHtv3I46YtmzbvUW+i8u603X5zVdf6omDSmwLn22Gmu4FpuCHr/Ohfug/4lZzXiNdahBTtV4qQp+nwp994N/ml89IVh+ISeUWn5GsDFv8ei3rYE0uF9be5Cho2/7JVT7GbkMjlRuw9wKT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(82310400005)(86362001)(2616005)(426003)(36860700001)(336012)(47076005)(16526019)(186003)(83380400001)(26005)(1076003)(356005)(81166007)(82740400003)(40460700003)(8676002)(8936002)(478600001)(54906003)(7696005)(40480700001)(6666004)(316002)(36756003)(4326008)(6916009)(41300700001)(70206006)(70586007)(2906002)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:33.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475d13c1-e7c3-4b80-d0d9-08db4733ec10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And remove the duplicate local variants.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 48 ++------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 25be4485dcd5..24d7134228b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6462,28 +6462,6 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v10_0_kiq_enable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
-	int r, i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
-		return -EINVAL;
-
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-					adev->gfx.num_gfx_rings);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.gfx_ring[i]);
-
-	return amdgpu_ring_test_helper(kiq_ring);
-}
-
 static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -6507,7 +6485,7 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = gfx_v10_0_kiq_enable_kgq(adev);
+	r = amdgpu_gfx_enable_kgq(adev, 0);
 	if (r)
 		goto done;
 
@@ -7178,28 +7156,6 @@ static int gfx_v10_0_hw_init(void *handle)
 	return r;
 }
 
-static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
-{
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int i;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_gfx_rings))
-		return -ENOMEM;
-
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
-					   PREEMPT_QUEUES, 0, 0);
-	if (!adev->job_hang)
-		return amdgpu_ring_test_helper(kiq_ring);
-	else
-		return 0;
-}
-
 static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7210,7 +7166,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = gfx_v10_0_kiq_disable_kgq(adev);
+			r = amdgpu_gfx_disable_kgq(adev, 0);
 			if (r)
 				DRM_ERROR("KGQ disable failed\n");
 		}
-- 
2.40.0

