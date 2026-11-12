Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB488606A887
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tmYIQbWm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C12112216;
	Thu, 12 Nov 2026 16:44:41 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80178112214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 16:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0VYBW/+t1DQSth9b2qIQLQsDM9iJIO6tZHxs8FLTTm6Sjplc3NTuv6hp4bvYkoi0HaJ7CyiNOVcVjSdZVLdvgBf4BnM7GkLRvlJi9GODCgB38uZ/+gr+kdi2vCo0oV0TpiAiXHi3t4g70CZgSI3owpciSK+NHZ/wRXIh9hdPqdJcnWquC+wXN7IK3QaRc9QNqdFH4bSBOzMLAvjXOwQVcIwvquTJ60jHVSRjbj/eGLFQmuneR+YiMPxaPZ6Z85JG+JB5n97LzV9iGJ89gisBqIgKy3B+lbGUU09z2BaP5meXOd7HNqKFjpTRkqO/UNFbfVOH5Kz5rBur1VbUdCyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6G/KeHK/YFoniLUxnIKkSPIdpS+AhscOgl1vpwCm4M=;
 b=vTpXkNWvsppbHgZ/4QJDNRG0A5MoAnF2lruyn3nCVMF2gFX+2OSNrPk3iFn9K6AT6pj6J9r+mGMDkejAnLPPURgpSJaictInxCw7b/5m5X0w/jpTA/nKOsrrgtJSvH+GySj4NV7f0coAzpHP7XXgcdJ7Gs2Iju1RlJZGPiEQnK0+cUNG0NFxkhzhpjNqPp1yskEIFdXBbsuGRijak4RWHBm6jXpxyDEYRf2k6imzJ0ZiaBpE697RybRviA4R20TG2yTpAwEXFWETP/79LfZ5YHe/IyyQHwDc6fDq6Eiuy91+WjiPdV2dfb/Uq/YFCXrrqKCrgKLXE0Fp6CbfuUA+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6G/KeHK/YFoniLUxnIKkSPIdpS+AhscOgl1vpwCm4M=;
 b=tmYIQbWmVWpnMok580F7+ufxbKAcpCXFf+Mp00wgYZlfvmrajAa1RstyNhxMS5LnfVf1Aop7/wgyO1NGtF85gPPBiMpQGnz5BRurI+Lt45uRdzSrN1PVsmdkmEnXQKGKOP6CZh63i/ZIUlJ0dpp6KYBsUpHghn9BL50UwzgzP6w=
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:44:24 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::61) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Thu, 12
 Nov 2026 16:44:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:44:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:44:23 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:44:22 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/uvd: stop using amdgpu_bo_fence
Date: Thu, 12 Nov 2026 11:44:08 -0500
Message-ID: <20261112164408.1748006-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112164408.1748006-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: f11a8d55-7272-457d-27c2-08df40dc3567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|4143699003|56012099006|11063799006|10067099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1rFr19CH6q9hiGE1HMH2rIVekGx6Sg3j+8EEDPpC1BYMdje6qDt22NvBW7g8rGz56wuIjSnjeH1l4h+GivmY3guVH7LzMEoH30pYEXSmBiENgWS3H0/kp+Bsh67FxlLU3uhxSjxJWRvmSzIFwlzEI1UC17tkcK5d3xhD1pAeYQU4vmrHQpoYuXWV0ujraUQVJHKr0Zqu1GVavs5/W8AUaTkDZUCeG/r54/bjl///qmjda9jWxQX5jk7rqJOG++r1FUIMqd5iUxCgP8biC4jZIpMUzRSiO+07wAEuYZJHGcDQ0ANyUIv4osvq8jDvkFcitEBGEIlDiCw9W09hG7ohekqn1AwALyOD6jxHBZ98DstnMlDhvm2nZ3nQjuGw7CJ9Y6+OPqaLRUP7eC1uS4WfShVuM6tNn1jL8xDKeKhxV4dPZSh1h0bTNbofJPIg7K9aZPvUWHOhVMtjUw1tmsHJWPw+1oyS/matQeDeQd9ac8XirZZAWlhw2/2qNyK6VekbK91Ep9jdRD8g3xjJGX7Hvo0/xx10Jfdq3jhtCxbyht/riRSteVsBEiOJLjD7jjcWoGcJm7yWSMcyNAsqmVdeFBaVy1D1eBPaVLykyqFbmrG8gFnSWKfl+DnilNI2jWNIO6sBVckXdghlumqRkTnsZ8W1kfTvQrWd0qEF0KBwkcEdjvMXS5YQDPfqQUVdSFyZDyUnh/9xjNLCBVFzngO5hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(4143699003)(56012099006)(11063799006)(10067099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A2P/D5Zj4yuZasc9JuOaNlKmudkay8p0dGXn6KvydrTyueI1Q0xTIc0ovxl0WEUPuBMlgsY2s1EqJDDiGcesNHRgHeDT1b7ezHOO0bgTPSKUAd8tdGT9MNNjrIycWyE5gorn9YpnROsD51O0+YfCMmQs+vOghpFIDjFbueZQfhhZkqN4F6235X5dvVp+nlF1ctyzVSwvFPeBnol8pgjgAP77qEEwnW3B5J8U+/vyBb7BDaMd/eQjMxkz8uX//xlH9nEv1YT9Rt5cO2xD1Pf1q4iszz6JJqRAJtkXZTtwB0j+qmHKCUhJYwT/U0xgp7TBb0dCp8LPiDq96ANIpng+2NrlMz7TuBHTzP0u10ffufKRiES6it5EM/se5Be+DpfUyOscor3FkdRZsvY5AW/W3/XB3J15BIEgfAA55Qe9UNHRx3LeqQLqqprh+fNJI3sW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:44:24.2384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11a8d55-7272-457d-27c2-08df40dc3567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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

This helper is deprecated since it is incorrect in most circumstances.
This was a circumstance where it is correct but it is the only remaining
usage, so get rid of it here to remove it.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d88dde859615..9570db033b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1154,16 +1154,24 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 		if (r)
 			goto err_free;
 	} else {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			goto err_free;
+
 		r = drm_sched_job_add_resv_dependencies(&job->base,
 							bo->tbo.base.resv,
 							DMA_RESV_USAGE_KERNEL);
 		if (r)
-			goto err_free;
+			goto err_unreserve;
 
 		f = amdgpu_job_submit(job);
 
-		amdgpu_bo_reserve(bo, true);
-		amdgpu_bo_fence(bo, f, false);
+		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+		if (r) {
+			dma_fence_wait(f, false);
+			r = 0;
+		} else
+			dma_resv_add_fence(bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEEP);
 		amdgpu_bo_unreserve(bo);
 	}
 
@@ -1173,6 +1181,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 	return 0;
 
+err_unreserve:
+	amdgpu_bo_unreserve(bo);
+
 err_free:
 	amdgpu_job_free(job);
 	return r;
-- 
2.56.0

