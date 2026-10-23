Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE4606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CC4sF57g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AEE112C7F;
	Fri, 23 Oct 2026 17:13:17 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B06210E639
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 14:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAuRZ19FH+ARig/Ucp5/fKL8HJIE2WxAm4DlL+KPW7dHT+9oqMNQcV2Xnu6A4s67FzPVAEBQo6s5T0nqrrDF041fvU7/2H/xQ1bpiQgStXZcv4xCKF+4XKBUmJuLYSG+sklSfzbX/tiWXnq4ElYbva5IroU610oW4YQh1XcAWxUd61NfKJUooT/q30ffLcXYJTJSOxNY3fnN4ooZ4yjZlRealc7dA7arpMQPujyyFntpO1bH+dBil19Uf32CRRcvvTxBrTzu5+s1PuyPQrSL75kLA/JbK63u55hvFg2mjqs1nfGsbe/V2PPgFJ/pe1AKnSqkP53KbjIfOd0Jt6iXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbSw6852lNTUyPG+Y5I//WjzWWPrRK4p+TKan2bAsRs=;
 b=TuMaYGBirh0/YF9U3wFl3XEHihy+UV8bJIJbgxNcWChB36psrXhKm6vqL9z0sPfH6oIl3JSlto8qUOU+bDuGT4C5xCrn8CP5E7PlbhUKSgIRL4WAFM0A5U12MK9jdtLE+HczlM+rS4nSnALGJpicfi9K/oc0IMVhwHNxffD0PBHu9egODg9PgttGjKyxdy3ThfHTLJCVs+iwQMrzBPT8nb4heDeQmU4gQaUmAx8McpH4wjRDIPiWLmT8EZi55RpeV4wuDQ6BjYP3JTHzYRxNHDPP2WVgPc709B9lgIIjvAOuRozfyuezIfTCZPH871YDO2rR0+zYUba7839BaTg6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbSw6852lNTUyPG+Y5I//WjzWWPrRK4p+TKan2bAsRs=;
 b=CC4sF57gC1WciLXpGRu30IWlKghd5kvlOM/nUeO4L2foLl6efhxnB5j/2wxVTUt3ABRFxSatIATX+w/xDOuiFDCh7S5Y/jmSofEAcpuj0VgTW8Mx/Pv+tteOcuhrXTOhHNB6mRNt8XBuSOXQGdhUUN8LwcU4e2W1MeJuBSIRreA=
Received: from MN2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:208:234::6)
 by DS4PR12MB189445.namprd12.prod.outlook.com (2603:10b6:8:53e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:47:40 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::9f) by MN2PR16CA0037.outlook.office365.com
 (2603:10b6:208:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 14:47:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:47:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 09:47:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 09:47:38 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 09:47:38 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Redirect imported dma-buf mmap request to
 exporter
Date: Fri, 23 Oct 2026 09:48:13 -0500
Message-ID: <20261023144813.1220394-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023144813.1220394-1-xiaogang.chen@amd.com>
References: <20261023144813.1220394-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|DS4PR12MB189445:EE_
X-MS-Office365-Filtering-Correlation-Id: 048534ce-d409-4f37-b9ad-08df311495fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|10067099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0y4X2eH3Y/6S2+qY8I032u3KJfcM/TonoSolWqlMq9ydgnCdZlOmKKLQOpldDkuMCnvuYLajYT3JP5R3Vks+ymGGZiCePLRJAhIzucqEuUgFn5OVcCJeKNh18fdqXjGmqPXYbqNECJpl9e+WC4vA1bg+mlokbDlyTFLQMMuAyommB1Xv11d52a0HoYjixq7XA/dIYVq/w++4S58bG6mr0G7jmsEcqTs3sn7G2ieQXjs5D2kVvxhiP4934uqoi/IWmTVM80jJj9IE/C1luZ7bii+uUfijvNO+T8lNCgnUz3heNkZGu0sqWiKnOwskk/IaCHAyJvHgYsoLtQFQLS1SqFUEZPY3ApNPkY+n+3tl6aoHLUXdogAm7kyuJGWcksbTQxBvbdmIbC3Bmb40/xbx8pGIFSrg+j8XLZ67hWKeJoRJqAt1EgZ+Ip8zfiJD1+sr/Az3B7lqWJ6CUqSg/U/qfz+AVIGnfFHuC4W1FTRgjcwnLSSq1ryqOl+APdOeLFBqwR9SNMj0fRLfnY7G3CmnGWc97ywfWpYQCUxS/DUiJzSsfwgURlFD08XqVc8ydY31BihBt0B5vkzpezBqBLxklvMRt1RqdbMIcCZoRU7CPMVScvaHO8XVtTXK2aa2xc8vpWX4xEyhbkNm2HBGgLtO9fkBR5RUynanhkO8XgAcakRJG0cN23yD/hqvWBY76nZwchG5S3pMmGy5fWOs4xdeGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oh4yJ9o1Db+SBiZvdttmFkTr62oyzzzdgOFY8evglbVTVypkH1NEqVapYjeCzdh+IEtpnVymjJGrcwIh6BVJTeHN1krV1FDia9W2fanfQL2FAWKijCiAFcpzZiOZOFdoZ6UsOHX45sFkxgPsKblh3kYoea4PdNunywmEpYqCK72XKGvpiAYYejHRzX85sRUQHOL7zp307vAdUm+/dLHs2KnLv8yGJYzci30Mv/mQoacAaBk/rjSAidQMQ7/nsa9A8P6b9aGotxu2aQKnnJVKrfHtphdIyesRuiNViPHK+hFrwfiaS5Yy18Os5dTEqSAXq0FUM5caiUbxn4SatS78f6uhzon0uViWpGfjltlKf/W5lCyMz/XV2XTSvAOxEGDKiSwNd0ydCLjpjBRXqRBRJGBh8bzzEjCFrLJL0p1MaZFlQNoyzf6OCaN7yT0eFTwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:47:39.5083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048534ce-d409-4f37-b9ad-08df311495fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB189445
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xiaogang Chen <xiaogang.chen@amd.com>

The imported GEM object with ttm->page_flags TTM_TT_FLAG_EXTERNAL set and
without TTM_TT_FLAG_EXTERNAL_MAPPABLE set,is only a GPU-side handle for memory
that belongs to the exporter. TTM refuses to build a CPU mapping from it
because those page-table entries would point to pages drm driver does not own.

amdgpu_dma_buf_create_obj creates GEM object for foreign exported buf(not
generated by amdgpu driver) belonging to this catagory. The pages, when GPU
needs them, come from dma_buf_map_attachment on the exporter's scatter/gather
table. The exporter can move or revoke that mapping through move_notify.
A CPU page-table entry installed by the importer would keep the old PFN, and
the importer also does not know the exporter's caching mode or whether the
memory is CPU-visible.

This patch redirects foreign imported dma-buf mmap request to exporter. The
CPU mapping is created by dma_buf_mmap, which points the VMA to the exporter's
file and calls dma_buf->ops->mmap. The exporter's fault handler will fill
page table.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4e4814caf61a..d872b4bcb5fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -369,6 +369,26 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 static int amdgpu_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	/*
+	 * A foreign import (udmabuf, for example) does not own the pages.
+	 * Point the VMA at the exporter so the later CPU fault uses its
+	 * vm_ops. dma_buf_mmap() resets vm_pgoff and holds the dma-buf file.
+	 * An amdgpu dma-buf stays on the TTM path below.
+	 */
+	dmabuf = obj->import_attach ? obj->import_attach->dmabuf : NULL;
+	if (dmabuf && dmabuf->ops != &amdgpu_dmabuf_ops) {
+		ret = dma_buf_mmap(dmabuf, vma, 0);
+		if (ret)
+			return ret;
+
+		/* Exporter vm_ops will not drop the mapping reference. */
+		drm_gem_object_put(obj);
+		return 0;
+	}
+
 
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
 		return -EPERM;
-- 
2.34.1

