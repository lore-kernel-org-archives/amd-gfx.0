Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E672C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373AE10EBE9;
	Fri, 14 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sX9TyO69";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5EB10EBF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbM2P2DhgeqGU8n9Ci/CGBCqDBCLZp9PFlnK9j/PE4TStQCL7bXrgu0LKDNOnYVjBRevwnV95DXm8QNi53UxCPXi+bSgsctWJWnoVU5JCiUs8gu6ZxKhCGZwvbS/lLn5mfl8a36oe6FHQt1Bz5/62/wwatzFEUWSp6l8VAKjfpyVrVYK9vDISew/2HnIfsT2oYkPSVcN7m1Fk9KXbMYso6DNJqmMysU7eeb/WGKU2jUsBCoZMiJ/s+127INIHsOHz+7zRphmeGR1VH4hv5/ZwzerKpTlTlIS9jQjT5wObHMiK1Cv+uVzhaEfg/HOjYn+N6FSNy15JJbwICBNYrRb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jlo6///4+EsC2WTurCgX7ph5MgDB2YBYRdMf7vAqbc=;
 b=tEGuxQy9Q/vpivrCgYbyB5qdj8MxbJHd8HSTfCcGgDJG8zJmQolhP9s4fANN3Mbe0F8B538ZE6shxg+bqdEzSZSKny1UseCEtRxIvZRqh3ufxvRkasHr2zWVvvz9Dui2AfOG5WlKIAVEHkpyinSjnEAyoqLNTXChW+linpaD+a8pJCnGomPQqqnM08on0uT3DpmWij3S7WOeGCN9QXh4Mjs8+FUFGYxcHN6IjXE6xA6Wjbf6WKyeKcWWgWGzBjo5whoAGj+vcnhTHwTXNb2Q2vMFY/pZgK4obcM2awTIY9bknwBBKmYybuKWfOoY6I1gdlDMNp+I/BET/gmwL+cN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jlo6///4+EsC2WTurCgX7ph5MgDB2YBYRdMf7vAqbc=;
 b=sX9TyO69WuhRBWY5et9bBEB/RlaSg8A6cmDJM2UjDU6j/dW9AZUdVBGCRYHllfqlQfUh3j9/6MTMtiV96pJyd4GJ3Ojnj0nc8TdWy/nJwizyCVFQFJZFszeoH8eJE1yRHjKqH66I0zYA339tdgcDqcHQCV8KnRuC+OpTetAg6h0=
Received: from BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 08:08:04 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d5) by BL1P223CA0020.outlook.office365.com
 (2603:10b6:208:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:03 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:08:01 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2 09/12] drm/amdgpu: add mutex lock for cper ring
Date: Fri, 14 Feb 2025 16:07:16 +0800
Message-ID: <8ba05b3bcd65178d643dd092814e1143cca15531.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e03878-d601-489e-eac1-08dd4cceb4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yOoHavEPqSTGZrW8Osf8JLDT+aQ5By1GN5NwAh7WDHqEUG9jZkhtzE+AmPP1?=
 =?us-ascii?Q?kALqrJvw0AMmPdxOD+MyDlEpV+QobPKKOiozzG5ieYoOxAHhnGcmipdXSm/1?=
 =?us-ascii?Q?Uv7v9iuSuJ95SD2NX5FNU0m2UViLAf3CM4hoslUz/8y5j25kDa/WgtlmXe7O?=
 =?us-ascii?Q?xqelR9arJooabPH9MOkv+dOaotIDNuGf3BGVw9oNnLLPqX6ascCVEHu9PUiV?=
 =?us-ascii?Q?iVJrznZHgP0vXnzzBsHHRXqMZkfSiMFZoQUBEeM/icu6fPt/hMDE5oroiEWl?=
 =?us-ascii?Q?N0ERvAt1aCCwRTOFJT7Uk5rwnMggQrwD3HOUGwJKKQt8KrVLNJpIE2B9eplg?=
 =?us-ascii?Q?seNvBTKKjYKtSH7C5QDv4DO/R/raSqwpZ4c3Rb1snTIpRcPm52XVIEGbwaNB?=
 =?us-ascii?Q?/HnmtYyYH3iZnNb07QS+snB+IqWnYx7ki59EeIqIHa94Ye2pm9Vr2AB/Lwdp?=
 =?us-ascii?Q?6TNbzPQzpU8jCs7scZwcnNgspPjnYvVrVGjHKDsOJDZfU4f8Ss/QksVQWmQA?=
 =?us-ascii?Q?j6rY/5GKdPaEcvCr0qi08FpycDSB5VZjO/FIoGzo3nC8eQP04slMcXaSxtHi?=
 =?us-ascii?Q?veCwg5YLMPNEuJdDg0OvgZ/6EXc6hV2LonO9vxWrIX7zaANLJKpD4FXOLgtF?=
 =?us-ascii?Q?ZS9eF72t1rPTKNn+lT9bH/8Rf39HPZMF/1kOArDGJSZ4BayS9OAwpbkAZ5Ij?=
 =?us-ascii?Q?jDBMnS2GtvPAVa48Tsy21fMMyt9T/sJAAjtfd28JXekalpcHX2bXjk1wtFAs?=
 =?us-ascii?Q?Lj5x+y8dM4toUVs5M/EW0uAFCEKmcad/e/+3Jo5xM6be/zd9quEG5J9xLuaT?=
 =?us-ascii?Q?FZIhMFGKvC/P3KxHUbgmm2tCN8ozLaTlUbjGVUOPF4UbXQBaDRRhKb0GRy1l?=
 =?us-ascii?Q?Gx6fNys0lePd8/RT3oxo8AX0PgSRsXKsNM0m56zGKDPWVtAfP7pJPih21sBh?=
 =?us-ascii?Q?07l+jbhfMxRp87DZ6gma3f0Ib1YA3of009f0I4CI89HDMs4/+IpYdAVvwIYI?=
 =?us-ascii?Q?i9oNPiRACf6Xt8FBK6e8iMQdQ2qExn0itEePcw9hdTBdxmO0KyT4K7fr5hsy?=
 =?us-ascii?Q?LnHL56EcRJDqQIgcYXmqXixvEIhrDF7Tn9cq8DidbnM7Lw+hniRFSA2RSVG+?=
 =?us-ascii?Q?d7qfiu9hJvmODLdzCKMN7WrdpABC5YbL7u9Ij1KdGUzkge9b5fOVXWEoUH6W?=
 =?us-ascii?Q?5+QNjsuSx8y2HkptMnfvFrFwV2GpLt/eFUe6kR6nvHy1VVmSAEiLINI5/UZ5?=
 =?us-ascii?Q?Z4dLLA1VYaSmee54aCIALEL0wmPdWTxzH/jDxIYXqhZGq0NvkArVhscBLD92?=
 =?us-ascii?Q?L4WLH0G9cjTffVCuxztyYNGUJEO/K0tczBFbsrPtXsDzHkSEg6lOr3PpAwDj?=
 =?us-ascii?Q?ue6/DVWyHLBrMuZ3vrHz3KkLWwtPPiSEhuAN9zh/ieumZ3ovF5P/rYl4PHD0?=
 =?us-ascii?Q?YUCYvHYe6YexW3rhZ15YVgEpIz+70J9YbyFbMEjDbD+9gn+a5WDllp3Ti8RP?=
 =?us-ascii?Q?8qiOrxN+wbl/uWE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:03.5933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e03878-d601-489e-eac1-08dd4cceb4cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

From: Tao Zhou <tao.zhou1@amd.com>

Avoid the confliction between read and write of ring buffer.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 21 ++++++++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 64624b8b0cbc..c14742eb4d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -423,6 +423,7 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 
 	wptr_old = ring->wptr;
 
+	mutex_lock(&ring->adev->cper.ring_lock);
 	while (count) {
 		ent_sz = amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
 		chunk = min(ent_sz, count);
@@ -451,6 +452,7 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
 			pos = rptr;
 		} while (!amdgpu_cper_is_hdr(ring, rptr));
 	}
+	mutex_unlock(&ring->adev->cper.ring_lock);
 
 	if (ring->count_dw >= (count >> 2))
 		ring->count_dw - (count >> 2);
@@ -480,6 +482,8 @@ static int amdgpu_cper_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &(adev->cper.ring_buf);
 
+	mutex_init(&adev->cper.ring_lock);
+
 	ring->adev = NULL;
 	ring->ring_obj = NULL;
 	ring->use_doorbell = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 1fa41858f22e..527835cbf0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -63,6 +63,7 @@ struct amdgpu_cper {
 
 	void *ring[CPER_MAX_ALLOWED_COUNT];
 	struct amdgpu_ring ring_buf;
+	struct mutex ring_lock;
 };
 
 void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 510fe1ad0628..5293eef4f0dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -510,13 +510,18 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 	result = 0;
 
 	if (*pos < 12) {
+		if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
+			mutex_lock(&ring->adev->cper.ring_lock);
+
 		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
 		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
 		early[2] = ring->wptr & ring->buf_mask;
 		for (i = *pos / 4; i < 3 && size; i++) {
 			r = put_user(early[i], (uint32_t *)buf);
-			if (r)
-				return r;
+			if (r) {
+				result = r;
+				goto out;
+			}
 			buf += 4;
 			result += 4;
 			size -= 4;
@@ -547,12 +552,14 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 		while (size) {
 			if (p == early[1])
-				return result;
+				goto out;
 
 			value = ring->ring[p];
 			r = put_user(value, (uint32_t *)buf);
-			if (r)
-				return r;
+			if (r) {
+				result = r;
+				goto out;
+			}
 
 			buf += 4;
 			result += 4;
@@ -562,6 +569,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 		}
 	}
 
+out:
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
+		mutex_unlock(&ring->adev->cper.ring_lock);
+
 	return result;
 }
 
-- 
2.34.1

