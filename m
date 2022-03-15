Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9195110E3D3;
	Tue, 15 Mar 2022 07:10:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB3910E3D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOcvcFvKMDmuxNubdZuMX776/+BnUrg2OYkgnIAF+SS5XSnekD7qLN4g8DzLOFEdvvb9xCCnxk9EMqfNOi+J2TWRvWKxguyIZTDRitZwnL475VZjEU00bz+6fxg0XKw6D942jN1pagWnv+w2g3cBQb5ti/PEshGUbDDEFGzbXxtheWyezD/xeheSPIZtTSv8gDAmPff04duQj/ID4pRUXIbAaFdXDI7lcMZVOnUW3OJFa8nQwg4WQ496sWu7zPBfOIBWHpZ7HC03Ks+bEdxlcwewyNE5kdRkpQYGzSQtlqmm7twchP52QDKvTh7veno1LHHo3LfFdk2LD5HJGoBOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFwaJZ6myxYz34nqPINTbnhiiDqDzxCQj7sw09nQNqY=;
 b=Dgn7ZFPPHEUrFftyzK7jgnhoHCcXrklxPBxHVWGZ1yMM0iHSgyKXIfV/L01oeA1VY6CpTQvPkB2GVRUky3tnQBZ4wAbMaq8KjGwckeDwVBVmITk7q1eI9eVOCrqRObnayoTLOaRzbSHTaKVQR+KI//v39J4ed1HI88uaFEl27JIax6yxzuGgZZpB0c06PA/GANGxRg8XLn0mvibFrOeawvQrglLqYX1/AeU/w35EhTR7VNSGVa1V4ZSW4WC/LrIUsZuYNKkIKNqVRisp57sPsgO2OuZbMEPnlEQI0ZOtb6kleit7STzu6Rxt5IbZY6sAPYKG8bys8fLNQcohJDoymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFwaJZ6myxYz34nqPINTbnhiiDqDzxCQj7sw09nQNqY=;
 b=Z1pDOmHwn0N9b5/VO2IRd5osNcNUKp1J1zF3TTZ4V7ZsKJWix3J3S/RXRHcpBnh41sIHXuEjcHo0g+tkKB1EmZCv78U/d61Jw2uS2Q6NzXk8CNKDFgrHifHfC3ZVwZRtzCpQ+KP5q8o2IIStAr71ezxH019URE8Z/ik86c+y1PI=
Received: from BN9PR03CA0636.namprd03.prod.outlook.com (2603:10b6:408:13b::11)
 by BN6PR12MB1441.namprd12.prod.outlook.com (2603:10b6:405:11::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 07:10:05 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5c) by BN9PR03CA0636.outlook.office365.com
 (2603:10b6:408:13b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Tue, 15 Mar 2022 07:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 07:09:59 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 02:09:57 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown stage
Date: Tue, 15 Mar 2022 15:09:13 +0800
Message-ID: <20220315070913.9046-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81be75fc-4ae6-4ccf-f9de-08da0652d16c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1441CAFE3E7B34DF486D3784F1109@BN6PR12MB1441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL3q+tE719p0aUphHMd2poCE4EwlW0RVXv1polhfA0UEIq20g5sEqKH58aRV6t5yawmw7ujjpzF5VizZEUZY/84kRbhTi8y8u2ZBT94p06KnVicJUbl/gyInXG2grCQ3HJ+KP1ku9G1ixKZrBIae/JtlIx3NOItU6AXGAlwMXKhvk7ludUd4SKFNw0rJ2wbWTwDw/HMDPXYfTkIxi08Wdo/9hUEsWtOmF1QpYKLETuHeBAMTbPtOOvZltRThRdintYZuYwC9z1DA4RUmrNPt/WdHkNTxZ7xa1RmImUmVSCgbU1vsu1mXPGZloWeiBqXup9dhz/3VrxG66Ia9Utl9hCnPYgVgTM3GfF59xM+NWOYbbGKfjVOZD2f9V5I4v3ui36VLfvOZpkfNPnHRBAG5r/dCpF04TUcxf9/aPI+W3g+D0BbEbvf08tfwlBwQqlEiUSPCcvrseR5bPXwFFy6oy5I5Jvm9SCfyOiInAgGLHBRcMslkLO5Yw+LRBLsvPNcokcjic3+Xwt3oFsFJbllGEnv3Qu+A5DZcWwnGQCNFIpFjQBLD9L4wbwbkH5J7/EwwsmPHHb6NEeXOXNq1Jo3vYFUhhUA7vgHJsqEs70j2AIkbh+Ixbl696CEBtbJETFufuS9u9QSQpPM/ju2QKo184xvUhpz+zgXeEBFtPyccjqjUGN6WeKi4r9IkK5P4pxh0keJ+ewjhsTSnUrv9fb9SbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70206006)(70586007)(6636002)(316002)(40460700003)(508600001)(110136005)(81166007)(356005)(86362001)(36756003)(47076005)(2906002)(36860700001)(186003)(1076003)(2616005)(16526019)(426003)(26005)(336012)(6666004)(7696005)(5660300002)(8936002)(44832011)(15650500001)(82310400004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:09:59.6386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81be75fc-4ae6-4ccf-f9de-08da0652d16c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
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

Fixes: e7e7c87a205d("drm/amdgpu: Wipe all VRAM on free when RAS is enabled")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 23c9a60693ee..ed1a19be4a54 100644
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
+		!(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
+		adev->in_suspend || adev->shutdown)
 		return;
 
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
-- 
2.17.1

