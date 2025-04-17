Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB59C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 14:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3C410EB3B;
	Thu, 17 Apr 2025 14:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbMWf7UJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B6010EB3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 14:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5QYAe+W4RT0kq7wvqxJc3Q0LxsvJgRbmOB/HV4rcuBdE3wd+kI24SkSOexLWEHEFoS14CdwCZir2SfGEeHbNKpmHEDmbNHSDA1brHSSeUKbr+RIXX8YgOyMK5BP+hKjd5DGUhnGa9H4HZf8CU4NdnVuSYps6ck1k/hGFCKJ2zqOnYcQwC10cf+ZzoKsffDPSRNy5ZyKU1hdAefB2DXJlPL5L3NA7/BjHO3VFALylxIUXUJi44X4lGEOKvi2jSKVSJn/1xWaG/jkjs/va561a894zbex/BOiKzrVN31T2FEmSQfY41SfJT8iToM3/uwKZz29dHQmoHucK1gbeZg1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6f3RY4ADuYbIVVI5T+X7ab0U2kC8iEejJIJe0LkFVg=;
 b=XX2H6OpIO5SjbpVt9H2hXOE5GE5X6DethDJPHt+uVpYBavMElpF78ian5BFFnT+3Gmf8rDFFsXVwqR7/oMr3d2oGn9qXkwZZPBYt4wUvM0qYCZ+6wTOQYpyTPlfjf5Qd4GwgqxkuWHIPgD4BQVMkB+WWSdSor0KGF9HujKdIWyDDFtkYlDaQ7BNzUki/98S+LAK5GyjQN8czfmV+/RdAZnC8rwUu8/H5HNnlKJVS5aItwDJi8722jnoc3M5a6oSHE2aW6tMFXNbJ3TaIneWunZygmtlG8Z2bBpfmdvG1a0HQYm/D9JkguM3Ua1/KWTTzjOyW5voU9OjZCstY+Eb30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6f3RY4ADuYbIVVI5T+X7ab0U2kC8iEejJIJe0LkFVg=;
 b=xbMWf7UJSJm+dPaif/MECTUpp2Im/M/oOMilWDdR1JusmmPvx3SlDO9TDEvZG1UwqEq2BznN4uftJrD+grV2a+GAYwpY0GDZfyWsKN21Q3hSgYgS8VhgyXJ4KnznUJ9/NZffldHyo642SB6jrnnGwwGC6K+elu5GvV2u74xDoKw=
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.37; Thu, 17 Apr
 2025 14:52:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::27) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Thu,
 17 Apr 2025 14:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 14:52:20 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 09:52:16 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu: Optimize DMABuf attachment with XGMI
Date: Thu, 17 Apr 2025 10:51:51 -0400
Message-ID: <20250417145151.1275415-4-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417145151.1275415-1-felix.kuehling@amd.com>
References: <20250417145151.1275415-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dedec9-6c6d-454f-bf88-08dd7dbf749e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ne2prR3kPY9jciTSiYsnif3LCKQtoLpNr2fLGGt7Uu8dkVe4gKCplLfqG3VE?=
 =?us-ascii?Q?qIhnG+c2TNYWfdGMEb6yGO2lCpfwXhhXeNmcMIYxR65YnEPk4bj3V36/zuEd?=
 =?us-ascii?Q?ZOcfTIv/KjReXtX/cJOYurSdCRnnTEWZxQD9NDwPy2VhW5JdnhTbyKDiLLHp?=
 =?us-ascii?Q?c7lFDUZgKTr0yKx+ZL7cVX50jjpiy+RLribgQ6OxPP3NdHoc5K6l9ecwL+2e?=
 =?us-ascii?Q?kEgXFOuZbyAdsIzKMFyeHASHUa8120VvOvG7Vxw9HsLJliCcFLLW2C1eRa2R?=
 =?us-ascii?Q?71f9UOoGS2OHVwXno8oIs7f/PqjvswvpaPc8bqzJrLKGGnyDYwJC7Dzujifb?=
 =?us-ascii?Q?b0j5TgRSfh++t8r1/rjkrFWgQt2cesfVrZC3dKBFEns1ZS1g+08feLi/EGZz?=
 =?us-ascii?Q?xlscBqdVjV8lMOupg+Pp/gQAjcymAi2481d9YG+kZ3llH27ZS8S4r20Con8D?=
 =?us-ascii?Q?qNnvTHif2HoN7pXTLO+1v1bdxbNCOxdP5LHNLWtFDcuvvlqRSxy1Zqa9tMIO?=
 =?us-ascii?Q?iUkltG2XjHdTccZNGYusxnfjuSro1hH7QExFWNOxOPVveBqsnb6s2qWjbuvb?=
 =?us-ascii?Q?jN9XWI5SWiq8TlwhPCnkOm81tx0dBuZecB39fYtMYqJxuczxujW39glq3J5K?=
 =?us-ascii?Q?K5tOsGwkRycbQDSkWZ6izcxlczhliK9P/NuGVFOSVDvupfVgz2aWx9BkJbiS?=
 =?us-ascii?Q?DDnNcKwr7f+z+1d8w0Xo4QTs89+a7GvumdGMzG70gYfHhIxbwcMxTxkzSXf5?=
 =?us-ascii?Q?4mT/rUMJIB6EUtazSaBegIhRvlFP7vBRPrNFF5N+/rc8C/fylF6gEVinXc0P?=
 =?us-ascii?Q?ibR+kJ76H226AN4uOWkLI1bfCr/XJCM7rF3RW43h8QGkqg+tFshvXjD3KgRp?=
 =?us-ascii?Q?I6DstnZgjx1l0gtNr2v0TQ7nbRqgr7rUMURrwyDRvlSNDorBATg1/rvQ/FGW?=
 =?us-ascii?Q?24hZ2qxn1YA+SAYJ1U96MAXA8MNwMpm0QsvLORhN9QLIV/rwXhpBs1HSa9sb?=
 =?us-ascii?Q?tZZVxBBqBgG5psmQiAkquoMtdEoz64fM53vyyQhv0ehIQwdEpHJHOO+Rsinp?=
 =?us-ascii?Q?HSshBOfnL2PBpiLZ5QOjGqnMkKXGbfm4f7QBcY1kpQ4lafvppW4s587zLrgh?=
 =?us-ascii?Q?B7dPU8ahEMcjHi39BzdFv8MkZR7xv05UzOFUBGrNyGaiO4d55l3kiyjKMZ8/?=
 =?us-ascii?Q?tvqOQVE2+0zVIU20YP+mZig3ZMNu9q1SNvukSOayw2LgX7akfFuphMaM0nU3?=
 =?us-ascii?Q?Z2T5rrhcuLDLL8R9EnOE49CTVml8uL25jv+i2zddb9uX0sLOXUOLhUFM70Pc?=
 =?us-ascii?Q?A4G5tT9JgGDVz8H0LnhrXaMlZVeO+s8NUG9CRYlScmPQ9WOHBo0qTLVbX0NP?=
 =?us-ascii?Q?7qIW9YcjYOlPepOZy74+Gp62r9PqitSIJCP965NVbFb9SUA6HNP6rQ+KeOn5?=
 =?us-ascii?Q?PD3pVH4HGtwWR8InknnfbDoqmJ/38R+BxpNSpuVxYZ+BwhyfIbBVo26pVvlW?=
 =?us-ascii?Q?8Khygf0piy29kIPRckmY4Byax8rsqZiLzXg4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:52:20.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dedec9-6c6d-454f-bf88-08dd7dbf749e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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

When peer memory is accessed through XGMI, it does not need to be visible
in the BAR and there is no need for SG-tables or DMA mappings.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e6913fcf2c7b..266aa1434471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -146,6 +146,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 	amdgpu_bo_unpin(bo);
 }
 
+/* Dummy SG table for XGMI attachments. It should never be dereferenced. If it
+ * is, it will be caught as a kernel oops.
+ */
+#define SGT_DUMMY ((struct sg_table *)1)
+
 /**
  * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
@@ -162,9 +167,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 					   enum dma_data_direction dir)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	bool is_xgmi = amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct sg_table *sgt;
 	long r;
@@ -176,7 +183,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
-			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+			if (!is_xgmi)
+				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 			domains |= AMDGPU_GEM_DOMAIN_VRAM;
 		}
 		amdgpu_bo_placement_from_domain(bo, domains);
@@ -199,6 +207,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
+		if (is_xgmi)
+			return SGT_DUMMY;
+
 		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					      bo->tbo.base.size, attach->dev,
 					      dir, &sgt);
@@ -230,6 +241,9 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
+	if (sgt == SGT_DUMMY)
+		return;
+
 	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.34.1

