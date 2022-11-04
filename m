Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78E6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 15:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D240610E8A3;
	Fri,  4 Nov 2022 15:40:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B6010E891
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 15:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBUu3ud2UcvtVbKihrJleaACgfRDzjLaqZZXH0Uuhbv2jynEyAuut4m4zAWEHFe9ZUSbmkmfH3xyfc3OjS/VCzqdvQyl40lBmpO6HFUAuWIvFQ7pCc+dHWxN5YSEBFqC4SRmqlj8mODU4D5gGu0lS5uaverN/Kl9uNUMacSORJV55AFdu19Zq+OmYXqxHbkJt4azbEnMhqH0GZW+Mebfs4Y4tXlS6dQatW6DZsB3pL2q4DXmu2gfxIo1PrwFiwjYTNPSaI4ZERKK5rSvUg/a+vLA/aLk1jT1sdEWqvIromw6Eeo8H5hKG80an2td5Pjk+elYyHNol+mpQ04Cr4/RBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJCGvhGcM34nkQDZeTZOkcALX6/FSFW0CHG1Mz9qZcM=;
 b=ADDfVSAWJYcffJsnFlpLh1ZmX+0eruUBY6JjrFGhNDzH9ZXGOymYoShGx3Gpzn0OGhy4Lpli41m5l5DoW9wlPFl0QkqD0rLRmCsfpieJ3wW0okhQFd4EBT5dvUo7p64jywX8bSXhsbFZdytvzZHMqY5c4jewRuvatp4M+kxXNYN74SffHhmvdjRIgKPBa30UQvx6oegPd/IqFLJjUgB2EEDX9EDyjEVRulX/X9AAFFg9XQ9xHWw6a5zLGKMXHK5JB2ECRgY6dhe06h3FLGuNj1EMC5s6e0DTrVamI9J9DaU+a4F6pVOoToD6iHGJ01RM9oAsj4vj8OlXaHYRF8eyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJCGvhGcM34nkQDZeTZOkcALX6/FSFW0CHG1Mz9qZcM=;
 b=osX5ZnRjnuLKrjuIcepoQhSCrKnBJfj+63Ku942es3UZQGQd2GEZHkNkCJl+4HGU9AhQxwVablviP7+iQ+1e8oXV+BoGSiY3v7z2ho3zO0aKMr9rU+U0y2c/bGCx+GX2ORFbQYkev6ZUEV0gus368OLXAYJDBOIyQRijNsLgR20=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:40:49 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::11) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 4 Nov 2022 15:40:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 15:40:48 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 10:40:47 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Inherit coherence flags on dmabuf import
Date: Fri, 4 Nov 2022 11:40:27 -0400
Message-ID: <20221104154027.1019315-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: b70511e0-b7fc-467e-9fac-08dabe7af27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OE1WzLim403IW703Elz72CFC57UCfJ1R8muDeCbhagXwFKlZka9H+49+Qf7GQkemIved5LUyv9GLHWWkUs1sfdXzwS7bWU+GPmAfDTyWwK1k11/SxBOQ2IfrwR90Jpq43c8MjN9OCCjPkN6EC6mzdsnSxcDZzXWLZDrVdOj0bbbaH/GIQBktQDbuOMokgHTplIJJ2bZSHyFfbIr2m1J29Lz4VFtGGpdzdmPViEEEfBLMHq0F6i8IZiqWguS4cv7tOiOLilBXkmZVSfxXNf9YeSS6J9ct8UxBAHZtKfpkimYECI5B6HUsrjkWZ4h9pRG28OgtJ49jWgKaGrcrltW92DtFaVhvzBHUC4ImwxyCzLJopCebbuOvHnOqW5Vm9TH7TC7LRphgw1sEJXY84RXB7PKAtVFptliWfw7fp4JU6zTjh3QheayIAQ/QYTU/5xZ81tllXTe3iaagPx8H+CeZSNVjwgUfGT2y8j37kyr15KgPNmua/lR5uvyM3VGd8pt+fa0qV8zAVag+10qEsb1GXVitApCmaVeGJC+kiS8A+Dtp5NCPmxdfMuKjeXOyu2eaZ/WCOh1FcNSO/DoUCKaII3fjyfnm+og8qF05mgVl9im1lWumptnE+uIjVVwPs84HHSIrwS/T+uu+89DArmPlDl3INo6mbrAGOc9GdEYiS2AhZn1xvUlZLGgJulcctCGGll8usV1paiWTCJrMNUZ7jYOJwQdG9FK8xlguH/r1IdyNAVHHOqQPG7/v1zr9+BflyWbCE4Z6unGPdlQ29g5lDfb2jnmzxOyH3GUxlOQBcFQ2S0wlWCTn813KMJ/ITp8+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(356005)(83380400001)(47076005)(82740400003)(81166007)(86362001)(36860700001)(2906002)(5660300002)(8676002)(70206006)(8936002)(316002)(70586007)(82310400005)(41300700001)(2616005)(7696005)(16526019)(54906003)(26005)(186003)(1076003)(336012)(6916009)(4326008)(40460700003)(6666004)(478600001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:40:48.8612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70511e0-b7fc-467e-9fac-08dabe7af27e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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
Cc: Gang Ba <Gang.Ba@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When importing dmabufs from other amdgpu devices, inherit the coherence
flags from the exported BO. This ensures correct MTYPEs in the GPU PTEs
for multi-GPU mappings of shared BOs.

Fixes: 763fbebb20e1 ("drm/amdgpu: Set MTYPE in PTE based on BO flags")
Tested-by: Gang Ba <Gang.Ba@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 7bd8e33b14be..271e30e34d93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -328,7 +328,9 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
 		struct amdgpu_bo *other = gem_to_amdgpu_bo(dma_buf->priv);
 
-		flags |= other->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+		flags |= other->flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+					 AMDGPU_GEM_CREATE_COHERENT |
+					 AMDGPU_GEM_CREATE_UNCACHED);
 	}
 
 	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
-- 
2.32.0

