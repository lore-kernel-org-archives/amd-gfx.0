Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4873606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pkVYN0FH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F98010FF86;
	Wed, 18 Nov 2026 19:03:16 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C051510FF80
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+SxVwSU+5zPLkBQm0A4NaiI4UN7jUHG5cwiM8dGlELJju0UUU82rlfAArYYhbU603Y3cV751Q6gH89H6alRNABxz3EqsLDTUMitCl0A8JUzDsNrWXTv8ufHNJgPHNjHhBcBWfo+pDdb/sIm/o2eF/vw6IpTBZS1/Au3GgFGczoUAP99UJYhYFM+1HgE/oFBqkq5l24Sxdo1foz+eNebd9Ny8utoJhksyI0rSUzoNIuYaU+ScovcPO2eDQtXbESkAFZWdsPLC6TQW8Jt6wm4SXmd7uZzfx4Pmda+BPQVihwgwgTLrbaz+mevwmjcguGFEw8GGXeKdALWoTRWRsSKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kRPCtvMBJ6l3ZnM3vRHJRqNk4tb9uJyutS04v4fQz8=;
 b=h/4A9/i2uspiY82pf0mIvJtMBEgKgTeSKHT15Vk0c6oIfmFFqULvUOeaMgyP3agL5NvLMtSGmxXragTy+1LVtOmDq8ay3zlSHlEU7Dj4aRLG/R2M4+j0V0/IJn+z2MJPzId32wogchw/UbtvdVyjgNVHzfpkJWaT479QUiXtKljzWR6dBV5BkWu9jwLDDmw8bCHwsxMyafiQUtU18pjA1TpvsHXPTffTeCSdY7WWW81MFjPMDJiR2ZJA1sSRBJw9RQCS2XX7cpLYO7TVESftuKkMhVQO8Us3Q3pcsqJjtpyGKMWjA0KlVBtE5heYFqzsdzDyAL1/zSYEZNykBISobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kRPCtvMBJ6l3ZnM3vRHJRqNk4tb9uJyutS04v4fQz8=;
 b=pkVYN0FHXcN7VZBS7OonoraZVvfZYLmo/32ACWtib0pL0IsnUEjEzM5qs0nRGGj2CdIn+mT9sLJegTdxN+AcXzScEgi4npmcO8FRlVDXn8ln362Fb9hj2Ue/U04va4TSBl7OckDjjzO0hrdqtaPOegDbY6RR1EVGdLlJbCJhIqU=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by SA3PR12MB239779.namprd12.prod.outlook.com (2603:10b6:806:5a5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 19:03:07 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::c) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 19:03:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:03:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:03:06 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 18 Nov 2026 13:03:01 -0600
Subject: [PATCH v2 3/3] drm/amdgpu: release WC memtype and MTRR when
 amdgpu_bo_init() fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-superm1-amdgpu-memory-leak-v2-3-38365f37bd5a@amd.com>
References: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
In-Reply-To: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|SA3PR12MB239779:EE_
X-MS-Office365-Filtering-Correlation-Id: e785005f-1b71-4527-d3e7-08df45a694a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261021123027099003|10067099003|261022105027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 9ejhWTUMhVBFDvoMeGcsQnN3RmiDOk3HmfaLzhXBs/r0i3SAxPX+8u6zIxKaRzrpAfHGabe0xJau4HOIYNABbEY1LLRzVDsisKUuEgxcGDh6X5Rx27uL6AMlImq8+GXcuZxKvKk+JwCJ26s1wXNX1JPoqpcpLU/ZRS3T2c7jAaSLq/YIClJ2h8HazFRBFdGuX1wqDlKEsHAlTXM8/RmxC65b2tNBMMK1SKsJeC0Of/y1CX5Ivi++eH2Bc+u9yJ/VDRd3y2aEPjwsdIrfpXVFzeqlnEKynB41tY6HKEWEwjHxkjCUYXRX787Sr58GEUqib2jGoURCzLADkeAsP3mtyMdcRlLAIOk77Eic9yree3LswRd7Topim7g4r1X3w9GdvveN4md7DD6P55P6j9qTHwqUpVtGElBQ/iqxbR+X/lVL7WyqxK4eUW6HO9PdRs/VNV2mLXo91MsnF66/13NnoKS6cR+PBQnt1JsozYh+3GzG53bMWfZH21b19dV+HyAn4N32WYkAGQPtW8Ek9FEVz60lQS99gO5oefSDtrqScUnkVjf8a3u01Q48tmtQz/WPmwwSXIFeVYRuj+ge8+5A5pGWTLGuXpS3fyZp3tsFoVTcmidMGiCxJYc0JzdZde/5aZyQ40EfmvnKeBaTOL6EmbNQIWThGL6LrxcyI6STnKIh3VjuJ4pshTFE3413rik4FLdl0GO78YqZel3wiR0G8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(261022105027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y70TMypgGtnX06BjR7vWJaUiXV/HQi/1V9aUoEmeNX9lTmiLLW/4wUlYx8VwZDOIgztHb1ze4ZT49zT89x8owdqQM+KliLEk/f0Kex9jBUXq6taBXjw3Nca0tHu3h/Hwve9K0Llt6mW2QKxSnC1ksUoTFDZXzPaTFGkDcsIX63QY1FxXIkxH81NRfo/bcqezG2GKL175Gdg+vAAFk6YMJM1NGEyH6NZ2SkDMxkJNZnPvgfwH3B2HgQQo0CgXQikM3F68YJ/vPe6aAhzCiPSc/Bz7jIn5/CDqJpo1xzpZSBlUQOAwl4LCyTLyRNUchK5ZaizUHhhnB84zOwuS7uubZ7rMbrWiYyGb44BUxs69PAZiFJokchLmem/MqotA5/1ITK1TTvZ+Bp9bQmkOwYI/3PfFWzLs/RzOvJiLwcNGkbgYjxINYrI/PerWz3XtsB2d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:03:06.9989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e785005f-1b71-4527-d3e7-08df45a694a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB239779
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_bo_init() reserves the WC memtype for the VRAM aperture and adds
an MTRR before calling amdgpu_ttm_init(). If amdgpu_ttm_init() fails,
the GMC sw_init callers just return the error and GMC's sw_fini is never
run, so amdgpu_bo_fini(), the only place that drops the memtype and MTRR,
is never called. A later rebind then reserves the same aperture again
with the old reservation still held.

Undo the memtype reservation and the MTRR in amdgpu_bo_init() itself when
amdgpu_ttm_init() fails.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4651f2d437c6..e28d7619187af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1130,11 +1130,13 @@ static const char * const amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
-		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
-				adev->gmc.aper_size);
+		r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
+					       adev->gmc.aper_size);
 
 		if (r) {
 			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
@@ -1151,7 +1153,19 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 		 (unsigned long long)adev->gmc.aper_size >> 20);
 	drm_info(adev_to_drm(adev), "RAM width %dbits %s\n",
 		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
-	return amdgpu_ttm_init(adev);
+
+	r = amdgpu_ttm_init(adev);
+	if (r) {
+		/* the caller does not call amdgpu_bo_fini() when we fail */
+		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
+			arch_phys_wc_del(adev->gmc.vram_mtrr);
+			arch_io_free_memtype_wc(adev->gmc.aper_base,
+						adev->gmc.aper_size);
+		}
+		return r;
+	}
+
+	return 0;
 }
 
 /**

-- 
2.43.0

