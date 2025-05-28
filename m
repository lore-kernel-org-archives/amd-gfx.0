Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF000C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4335B10E6B0;
	Wed, 28 May 2025 17:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kqm2zgkH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D8110E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDr1Iwoow8C8fC64q6sLjrLP234xQDyBVt+gwdU2hKpMYyGaEXEYLV/BFn/U6J0IcDPD7/7VAvv0xmT05ELsr14OZptux2qKs1uWcmpHBxpP4EJVFwMaf+Sy5/g+kszj/ibTD7vXLtVdHdYQ9OnNtsIIG+SVNsAtJrCYytXKaujiSDWg4NYTdwFKnLIpYqIF9j9aqQ9WqkRZT1H/ZohhjUNIFSan36GJyCKfEMmrbcdc9NvGQ3Jx4msXEIj+cRudURO6IEqszmJ+PO8ZpLdR5dMF1PmrERWGVF64VFSBOoOiUZdcJjlfTbvsMAGPiv9UvxmBDSUh4nLz88+kr04lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YPDBGKYB1erOyQY+mJr4UtqOgW8hQ3/pCzra39sprQ=;
 b=rsCXx5ZrTEnreIHvImXSiMdt8iQ9NdM4dxtAgxfmJ+WU0eEck9tRMfMkLfxrJBFfKOsCzh+yD4G+SDw2H9oupVIbNcC241/gHK9Mhr1ED1W4Bn5YPraXgUVxaK61IJmzp7lyOhbo35dHYTOpbcfeCy2a6j/eGIHQWrUHgs1lHN15g3XbyIPATL6l0NQXi+AAjZPlkw1nzCk4PZnzSL6HQfTNoV1Hg470KRQBw6nB/CpCTdp5H/IxWiNoAFEux+gXMEdmSOm1io8E/tM4baiojZNsJdUEynhnS3E2V/z8k9nH6Vzcsc+wZRJtmc4Siyg8OevtCeo/P8rLoOeZVztYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YPDBGKYB1erOyQY+mJr4UtqOgW8hQ3/pCzra39sprQ=;
 b=Kqm2zgkHmQWHhqI4LIxwwx93OqGrrPJipKrBnOU1eWDGD55GQuhaUp6fpNTlKx7SF89126KilHSady+npN5blapn0DSOgkARwkI+19Ktrw+NSPGoxfthQAvAW4TaoU76/YZsvVTiHghthWw2PRlKVZg9p1NwMyinC80D8c8IT/U=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 17:28:24 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ca) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Wed,
 28 May 2025 17:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/16] drm/amdgpu/gfx11: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 13:27:55 -0400
Message-ID: <20250528172801.34424-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9fd2e6-b9bc-41bd-2e92-08dd9e0d0caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FAOKIxGtKQ7YLWfvtg1M9Ov/3socj6nml1g8zpbVT8tOOPwQYFAooH7HOqkp?=
 =?us-ascii?Q?qzs4orfssUlVZ2E+88Gj116QbffHB9+uX5CfG44HjSkJxSx0PTSUEqetq6RW?=
 =?us-ascii?Q?4YrpVQrpl8dQ1a5PpFRcqfFRKXROLaRvzrVFj9Wxz369pX5dyxam/zn1Tqnf?=
 =?us-ascii?Q?+UC8xRjTAYH07aglFpRsrJOwmryOzHu5Yonesi5Ds/39zyA5LMiarRWBWsJx?=
 =?us-ascii?Q?ql3IfzRA27BkEvctYhEp5VacmrVqX45PKA+q1zApZpgNrCQyfwwN490alAss?=
 =?us-ascii?Q?YujKIzAXcAvZ0ytKxW4gwQVhiS/YSR/m5tfaONQ1FEB1IvXvCMNsEpDm11Pb?=
 =?us-ascii?Q?1Ta90TFT0Xzslr+hWyraJXehheAaN63qDZPfpPQozAyq5rDNfWZ3Jt5Y0J/1?=
 =?us-ascii?Q?+F4ccmv77y98tl79cnbQvEJ+jqHMuR/sfVH5DerceE8l42MnM/2yFE2nHLaQ?=
 =?us-ascii?Q?wPEamHIn1u+I3mAvYJXpQ8PCzhN+D2cW7WTw20K2lrUH/iaTqvTWVBpWtD5Y?=
 =?us-ascii?Q?MnY2nBe3rtFOUP0cN2MZh2ZNeeu5KHM0EPvrPiCHI22JdVozex/x8zJ0Fqbp?=
 =?us-ascii?Q?DwyJNzCW28jASsWVg/9tXQnrIjSmR4SN9icj7B4JfbBLklZq4aC3vF+XzZyE?=
 =?us-ascii?Q?HFcxg1KBLMARKF6PlSHrY9mBpCghAwx/GVbLB2GB2gJ4CEBG/Vak2zS1SY2K?=
 =?us-ascii?Q?1eJClhU9jFaJA2iti9lVrpXK61whAmZm2Og+rZ//qZk0Bj1YcA7Dj/ScXIvt?=
 =?us-ascii?Q?7HHIVmhmsv/4SnEas1GpezM1zjbQ/pfcpzd6BCwclYog4dW9wcPA8W8Hvfkl?=
 =?us-ascii?Q?kmQhowOW0J/WkBP/8P00urOkfB8CYs18jniDF4wWE43+z6xb0uiiRyP9My5f?=
 =?us-ascii?Q?RGAAUxlmBCQq/ehg92jhTMOx3hjc7MCoWUJdI6NgPjGwjIWyNqmUWoNkLL5T?=
 =?us-ascii?Q?wqYrYvCojuxoC5uiAikYNTGX/M2B3aVPH7fwlmedZMQHij4Vlcy6P8kshDq5?=
 =?us-ascii?Q?VvLCRUmmSj9X0ZoN4YTb0mGJdu6mQHbkt/3pQoLDxdXnun7a4vPOZFoXJi5B?=
 =?us-ascii?Q?lDhvtQ4Q+abpHZaUCVl+HGSxmKliNnwogScYWlgjo9kaU3NbDqrwJFg3lCg6?=
 =?us-ascii?Q?dQZ50Kora58acLcRDJsNkl6jxt5FI7aFtz8TMOgUmv364ULrtczPnlVJMd1o?=
 =?us-ascii?Q?A4aK/3jOOPyg0AaVqXzFsNZ6CaYgRd/mtAYxSTl27C7vtgpxXePVeMsWXQ6G?=
 =?us-ascii?Q?nkZzAyWbivjf/ACzTfmR8tJ+hXHJHHhd17Jn5c06yzt6A2Kt9kT5b/t9LFrE?=
 =?us-ascii?Q?38mAVbiUgRqYY8ufFWWwJ325lb3WeKnL5dS5ktcD28l/G6Xd7alGNNWnneW2?=
 =?us-ascii?Q?mQ5JDn47/REF8jARUdTAKhbuWm6Y44iY3f/9UCELOQ4ZIfpG/FvZlEux0czU?=
 =?us-ascii?Q?i2d3x6NkwMrs2IpTGrOGiGxs8faGRWQnEvxDz8LiDdyMEiP3YAcoHNvHhv6w?=
 =?us-ascii?Q?XFKFxsqk5WlVcHYtakOL6n7EuqXYdUAH6U2k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:24.0410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9fd2e6-b9bc-41bd-2e92-08dd9e0d0caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39374c87738b3..218bd4d77e859 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6818,6 +6818,7 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -6844,7 +6845,21 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7240,7 +7255,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

