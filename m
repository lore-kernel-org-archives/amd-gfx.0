Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5664C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B6110E488;
	Tue, 15 Mar 2022 07:54:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F22D10E48A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxj2GvXYZcDsG7zDsBb2+7zO8BHdtM1vq/qM9CKoND207UF9jCCnr3TwVqVrSpkWnVfeiaHe7yciXrKfAkqj2EfQ2JXWRwEKjdchZoalxTVwblKOb7TbPIXLNqBQ7XxORPmQEMX8pNixyjxvvAf+wfVxiljM94FHLCtS1TVsgp79bjchZtBd6t9c1BmpFVeezxv9Wtd3P9FpJ2b2NkTolLMVz70iOraQg+hVnNs8cV11Iapz/eDbJ3mU8191act1QdozR7+Jkk+/gsxuTn5aA7jK8UrJCOG1stXdaIVhabXMDC/ewYLnHN3+UaEfTn2hVkbMFA9xLWa2B+4edOoB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3aPm4cEmW0riSPZVMDYhcMSnWi8sLTJ0pPLxZWzAOI=;
 b=ogX3mkhrimd5jXWjVZquoaXaIbpuJP1TUDIgO2uj+eX4rDGMItJXrSk+vvFBHkzJEnZQyHUAXq7G1AuIb2GJgXhx2MJx02vv5hDdU1W+oCYOiuxt6ygcdeCnUSsBuUCh7k26KYXm7g98oMdvx/TyY/WaWtrz37DznJ7gorrIZOtgZ4XN95vuWEqxzXDVyq8X9qhZ1zM8cAgIHjhCbcDnUoSEuIl+7PoMpwVlhIBfd3K0wq3S+ULlmpq8GYTbF1oIIDM9KMgB4WjLLiHDtuS9ODCLV7V6erTWKomC/deQWpKkIzr1P/FViWI794xm+vXmTDjeafo1I6BMFLQ7NARGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3aPm4cEmW0riSPZVMDYhcMSnWi8sLTJ0pPLxZWzAOI=;
 b=FByPmOum4x0iuoIfgsGRE4tBti6dYlKyBOVldsRRpIu318DEZs5yHHLd3mCT/C6gmZoNO25NOXGvrTqpCvBdaobvepdeBGbgYz5wueqIf8o33KDffroMydWvlzK7TtqCunBdWB+C3O2k2dtbpLUY58DNmJ7kQwIWDIHBTNLHXXY=
Received: from BN9PR03CA0167.namprd03.prod.outlook.com (2603:10b6:408:f4::22)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 07:54:55 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::a7) by BN9PR03CA0167.outlook.office365.com
 (2603:10b6:408:f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Tue, 15 Mar 2022 07:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 07:54:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 02:54:53 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown stage
Date: Tue, 15 Mar 2022 15:54:39 +0800
Message-ID: <20220315075439.25634-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67cbb9e4-4541-4812-74e1-08da06591832
X-MS-TrafficTypeDiagnostic: MW4PR12MB5601:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5601D6CE9D4ABEFE7655910FF1109@MW4PR12MB5601.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpNotDBifYNVrbQ8tDrw6oUgx71e1R+qB9JeBPjSEqneEfWHDEzXpHGZt3sIAsvIH8ECYCTfwh7KmCAdzpVDUu871vNkHuZtZgLAKrNTC484yoCw8e+lfJ6nkUeIkV+IGigC64O30JSaH8lboZm6Px+23ygb6/Y4dSJBMoObZVPR0MOrpLdjqhFv/ZE66HR4pxyRFd473PbmWVWYuTJU1wkB8qlYEk45il/HIfXShd2cqbWY0lvyywWLwdFsP01cOR95BE6WFvBfKGEN61x41tNSURHhEuEm7Qn4bPWvCFolq8uxc6obB8p0SSYeFrxF5Ud8h1zQ97VirCRjUOinhoOooDf5ZfkpNj4VChEtdyTRuxknreA2dFgd9r/dlZjdgbdPoaZ3mmIWcO9GtP3FAyjMVzF9US8Skg2CaxO24bKLFr9VJoo2QQhi9CJ04LZ9WM9L8HhUPfDVrNL3Z63t0KIvZtB0qDfsbfikSJSKTJqDDo7qtDKqSWOJioZ/LXuv2pmpAa7VeoIosNDZ4eo7bqBjIJK/6VrqjsoHfGExVbPsuiJigNjlvVIzOzdGG4zUKMo5p2QS4vyhJsl0oFwwTIqd2SBND2pSVmLdXmUwBVTQXmuvwmAOFVLkjai7Pe2AXfJHw32aAJU9BwD7NyS/FDu2J8s2U5RJFBC2jtWdIt0PQZ/F+9iWO5pjbJmYJ1fK02egub1vt1o8KGEqkWnEHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(16526019)(1076003)(26005)(186003)(7696005)(356005)(81166007)(8936002)(5660300002)(2906002)(36756003)(15650500001)(44832011)(86362001)(82310400004)(70206006)(47076005)(4326008)(70586007)(8676002)(36860700001)(508600001)(6666004)(2616005)(66574015)(336012)(426003)(6636002)(110136005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:54:55.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cbb9e4-4541-4812-74e1-08da06591832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

On GPUs with RAS enabled, below call trace is observed when
suspending or shutting down device. The cause is we have enabled
memory wipe flag for BOs on such GPUs by default, and such BOs
will go to memory wipe by amdgpu_fill_buffer, however, because
ring is off already, it fails to clean up the memory and throw
this error message. So add a suspend/shutdown check before
wipping memory.

[drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.

v2: fix coding style issue

Fixes: e7e7c87a205d("drm/amdgpu: Wipe all VRAM on free when RAS is enabled")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 23c9a60693ee..c712d7f5e8a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1284,6 +1284,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
  */
 void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_bo *abo;
 	int r;
@@ -1303,7 +1304,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
 
 	if (bo->resource->mem_type != TTM_PL_VRAM ||
-	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
+	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
+	    adev->in_suspend || adev->shutdown)
 		return;
 
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
-- 
2.17.1

