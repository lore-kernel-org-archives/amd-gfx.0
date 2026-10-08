Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E645ACA6015
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 21:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442F910E390;
	Thu,  8 Oct 2026 21:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dsDHATJg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770BE10E390
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 21:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD+Q6K3ql7wlqmVGzjCS45LDpQCFvbw0L5zL2Rw9+ZFFm0IyfIM3vWuR8WGkTlBdesrVD3tp+qhj8skRi+ai76kxg0HcOAdMSntsbsrookYzt1t01HyXOb9kq3WCQOA8HXQj65MsQkZ1CbaZYNcUVYTIsjl6WEupXqYwD3Ibbx56XWRkU1baPbSj1xYVDVhIbFO7mobRuWCO4Y3BY9ivpJ1mDpEQSqyqrei5KrYoDx7kEgNQHWZC/tICBt+C+Z9Oylu2A0oS4i9RGW+JU7GdjVfrGf+xi9wW3PmuNvVdPqN7/BGSuCGiBEAaZ7pdQYUA2LN5jLlR4J2BnRFIEXEN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaTFxeYoVd1+SsRyj+6HAZysAOY6X8Kovo6VfItUFtI=;
 b=QqcpgpUa86gSM6SOlLYhCmpQ5xn20xrgG8U8RNdyyVpRs93OJB7cQL/NTLtxUJHxPGPkk0QB/HpoHMvzd3b9fmaTdbyNFeKFFdYyLjr6yX3/Gx/uboQ/OXCWnQ838uQegI4HjJTOp/n0Soggc3PenXJSYGCRy8JzocT1wRnJA/5jto/4yfR4C+ODFPQEdcdR5jkBIebecW6Iq0kTFuYnUqb8ZLzSivnrCQCVs6BjqPzkLTXVF05T1/nRyD2LParoD8ebHZfEp7LhQXvDb9ty1MFImW1Jg2AtQGyzH4cJP1zizq2FR/o7sGRRu3bkEkwdVD3Sjci0STHUGql9tSQGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaTFxeYoVd1+SsRyj+6HAZysAOY6X8Kovo6VfItUFtI=;
 b=dsDHATJgpWKqoqQ8MCiM4oo8u3oj3yk83TcRwbffZXp6bDCqmsXGje0J8zKIgfdQ9DvWmEJfuNYh+5XF/R1ryLY3ERYzeIAqd64M4pxb/IRfl4nrgDxsKy89lYNLdXkqAS9+1LTQ8ap145dyeJOHz+jBi8CPLLWgC8UTwHXc734=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by LV1PR12MB999328.namprd12.prod.outlook.com (2603:10b6:408:3f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:31:57 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::3f) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 21:31:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 21:31:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 16:31:52 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: UALink add debugfs selftest
Date: Thu, 8 Oct 2026 17:31:37 -0400
Message-ID: <20261008213137.2169455-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|LV1PR12MB999328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e087b9a-9fc7-4013-6a1f-08df25839484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ntHl8CF/sxv5WGAfrgwwU8bI8qHZR5K3muCmJvj32j3RHe5uiXQpcdAaBPewu7a0dzDnmY/6hj1aFH3I1XHiUtmYKA9FSiDn4FrE4m8IUxwQZiow/w7pzKjDrIM44mxHrfSrGCUuiWRFVUy2sFZJ76sCGRvfTOAl1g0tpNOBynX52zlTJuEGiUuzVvlMim4mZWyf4cDsAU9HWhS5qwTgvYhEyTPVYkF8yaKYL0/nTESRkM4qFEr5v5iVuHQeUnv10NVsvfoN3PvjyNUDrejXI1MT00dfo2xWtvttKr+An1HO8M3Xg9KPz+tLNyAy6h0XzLs7A8GhlQE+ERn/xdLYlJV2NvriDFAytKcCE06UPVsQFecLataEG6JiyfEVpjibXbSPEZmXd7roWgVl+wtFCmldFyerM0+kqZiCKA8aQ2TPtv+ux43qZap9/xOctbl2VYmIz6+SmauMpOevKPwLpd38JIbUFQz5k8NZzoYIASSzfQ+NLbSNcmlYeMCS8BBSbyEx2vRxD3PpAYcDz6VImTdPWqiJ47In+ba0aDob5NNDMVhWsjMM171uLlhHTzblAOs3ckcoVPb8mThGCGvDaxDrRxUePGkhoH8n+x+RPpWKIk5FZBblvfDgLKGuuuXnL2B6zwXpn8buwzBuHlA4NE4v2KBlnHA8kyAfMLZPiG/nZ+t47wdPiHHbaN0gTCRT/JmNO28eSCNtz1bkH0pa+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g0Tx3XcDbR2lWV1H8EAO0aIzh8APCC8GIZKC9YFAgcQTDNOyDcAv+EsL3Bcnygsh2AmUp4G6o7vl/nqGiw6wb07hiffYMDUYtP2OIHZ0qTesuo1BGiMLnPTnVTRJQIS1o8xGNfy7HiEkF2IrkcnDJUDb7LXOFLeGizxOvin+6byYbhTdz/M804MuwDKIoGVs2S4pkE3C4bGWiWL417suPylEijx2ZXMXsRF9kKkXu/SqCgoq+GxeGO8RdMquyw9Zah6vi4i4E91dcXDd77GdPAcajkGGg/SaZ6U6TJG42806sFek8M8XSpA97puaf+pM3H33bkyk2rpTcn48gm61iHIEXe8EpWU0n8gXgBNFm0VpHAVlwsvTCgPpsoSdHQw3i831JQvn0JRHlYpX1el69IZLS0FBkJOcR7OtLRcUxdZjr0yAAXSwLWaG7yHHPn37
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 21:31:57.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e087b9a-9fc7-4013-6a1f-08df25839484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999328
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

Add debugfs directory "amdgpu_ualink_test" with one entry per test, to
trigger UALink selftests without userspace application. remote_accel_id
and test_size are read/write, the test entries run on write.

Add helper functions: ualink_simple_rw() for remote VRAM R/W,
ualink_remote_shootdown() for TLB shootdown, ualink_send_hello()
for handshake, ualink_update_interrupt_wb()
and ualink_update_shootdown_wb() to read writeback results.
Use lsdma by default, can select sdma with command.

v3: Replace the single entry taking a test number with a debugfs
    directory and a named entry per command.
    Resync the ring pointers in ualink_send_hello(), the local wptr is
    stale after a vpod reconfig.
    Take peer->lock to update the writeback address and selftest_mutex
    to read the test parameters.
v2: Fix typos and issues from copilot code review.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 215 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c   |  49 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c  | 231 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h  |  14 ++
 5 files changed, 509 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 35cbd358c28c..16af55905ee2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2148,9 +2148,191 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+
+enum amdgpu_ualink_test_cmd {
+	UALINK_TEST_SW_INIT,
+	UALINK_TEST_SEND_HELLO,
+	UALINK_TEST_REMOTE_SHOOTDOWN,
+	UALINK_TEST_FLUSH_TLB,
+	UALINK_TEST_READ_LSDMA,
+	UALINK_TEST_READ_SDMA,
+	UALINK_TEST_WRITE_LSDMA,
+	UALINK_TEST_WRITE_SDMA,
+	UALINK_TEST_UPDATE_INTERRUPT_WB,
+	UALINK_TEST_UPDATE_SHOOTDOWN_WB,
+	UALINK_TEST_LSDMA_SELFTEST,
+};
+
+/* commands talking to a remote accelerator, remote_accel_id must be set */
+#define UALINK_TEST_NEEDS_ACCEL_ID					\
+	(BIT(UALINK_TEST_SEND_HELLO) | BIT(UALINK_TEST_REMOTE_SHOOTDOWN) | \
+	 BIT(UALINK_TEST_READ_LSDMA) | BIT(UALINK_TEST_READ_SDMA) |	\
+	 BIT(UALINK_TEST_WRITE_LSDMA) | BIT(UALINK_TEST_WRITE_SDMA) |	\
+	 BIT(UALINK_TEST_UPDATE_INTERRUPT_WB) |				\
+	 BIT(UALINK_TEST_UPDATE_SHOOTDOWN_WB))
+
+static int amdgpu_debugfs_ualink_test_run(struct amdgpu_device *adev,
+					  enum amdgpu_ualink_test_cmd cmd)
+{
+	u32 remote_accel_id = adev->ualink.test_remote_accel_id;
+	int r = 0;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	if ((BIT(cmd) & UALINK_TEST_NEEDS_ACCEL_ID) &&
+	    remote_accel_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev, "set remote_accel_id first\n");
+		return -EINVAL;
+	}
+
+	adev->ualink.selftesting = true;
+
+	switch (cmd) {
+	case UALINK_TEST_SW_INIT:
+		if (adev->ualink.remote)
+			amdgpu_ualink_sw_fini(adev);
+
+		dev_dbg(adev->dev, "load metadata init MPNHT firmware\n");
+		r = amdgpu_ualink_sw_init(adev);
+		break;
+	case UALINK_TEST_SEND_HELLO:
+		r = ualink_send_hello(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_REMOTE_SHOOTDOWN:
+		r = ualink_remote_shootdown(adev, remote_accel_id, 1UL << 30, 1,
+					    TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_FLUSH_TLB:
+		ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+		break;
+	case UALINK_TEST_READ_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, true);
+		break;
+	case UALINK_TEST_READ_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, true, false);
+		break;
+	case UALINK_TEST_WRITE_LSDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, true);
+		break;
+	case UALINK_TEST_WRITE_SDMA:
+		r = ualink_simple_rw(adev, remote_accel_id, false, false);
+		break;
+	case UALINK_TEST_UPDATE_INTERRUPT_WB:
+		r = ualink_update_interrupt_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_UPDATE_SHOOTDOWN_WB:
+		r = ualink_update_shootdown_wb(adev, remote_accel_id);
+		break;
+	case UALINK_TEST_LSDMA_SELFTEST:
+		r = adev->lsdma.funcs ? amdgpu_lsdma_selftest(adev) : -EOPNOTSUPP;
+		break;
+	}
+
+	adev->ualink.selftesting = false;
+
+	dev_dbg(adev->dev, "ualink test cmd %d remote_accel_id %u ret %d\n",
+		cmd, remote_accel_id, r);
+
+	return r;
+}
+
+#define UALINK_TEST_ATTR(name, cmd)					\
+static int amdgpu_debugfs_ualink_##name##_set(void *data, u64 val)	\
+{									\
+	return amdgpu_debugfs_ualink_test_run(data, cmd);		\
+}									\
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_##name##_fops, NULL,		\
+			 amdgpu_debugfs_ualink_##name##_set, "%llu\n")
+
+UALINK_TEST_ATTR(sw_init, UALINK_TEST_SW_INIT);
+UALINK_TEST_ATTR(send_hello, UALINK_TEST_SEND_HELLO);
+UALINK_TEST_ATTR(remote_shootdown, UALINK_TEST_REMOTE_SHOOTDOWN);
+UALINK_TEST_ATTR(flush_tlb, UALINK_TEST_FLUSH_TLB);
+UALINK_TEST_ATTR(read_lsdma, UALINK_TEST_READ_LSDMA);
+UALINK_TEST_ATTR(read_sdma, UALINK_TEST_READ_SDMA);
+UALINK_TEST_ATTR(write_lsdma, UALINK_TEST_WRITE_LSDMA);
+UALINK_TEST_ATTR(write_sdma, UALINK_TEST_WRITE_SDMA);
+UALINK_TEST_ATTR(update_interrupt_wb, UALINK_TEST_UPDATE_INTERRUPT_WB);
+UALINK_TEST_ATTR(update_shootdown_wb, UALINK_TEST_UPDATE_SHOOTDOWN_WB);
+UALINK_TEST_ATTR(lsdma_selftest, UALINK_TEST_LSDMA_SELFTEST);
+
+static int amdgpu_debugfs_ualink_accel_id_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	*val = adev->ualink.test_remote_accel_id;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_accel_id_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (!adev->ualink.info)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	if (val >= AMDGPU_UALINK_ACCEL_MAX ||
+	    !test_bit(val, adev->ualink.info->vpod.active_accel_bits)) {
+		dev_err(adev->dev, "invalid remote accel_id %llu\n", val);
+		return -EINVAL;
+	}
+
+	if (val == adev->ualink.info->ppod.accel_id) {
+		dev_err(adev->dev, "remote accel_id equals to local accel_id\n");
+		return -EINVAL;
+	}
+
+	adev->ualink.test_remote_accel_id = val;
+	dev_dbg(adev->dev, "set remote accel_id to %llu, local accel_id %u\n",
+		val, adev->ualink.info->ppod.accel_id);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_accel_id_fops,
+			 amdgpu_debugfs_ualink_accel_id_get,
+			 amdgpu_debugfs_ualink_accel_id_set, "%llu\n");
+
+static int amdgpu_debugfs_ualink_test_size_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	*val = adev->ualink.test_size_dwords * 4;
+
+	return 0;
+}
+
+static int amdgpu_debugfs_ualink_test_size_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val < 4 || val > 8192)
+		return -EINVAL;
+
+	guard(mutex)(&adev->ualink.selftest_mutex);
+
+	adev->ualink.test_size_dwords = val / 4;
+	dev_dbg(adev->dev, "test buffer size %u bytes\n",
+		adev->ualink.test_size_dwords * 4);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_ualink_test_size_fops,
+			 amdgpu_debugfs_ualink_test_size_get,
+			 amdgpu_debugfs_ualink_test_size_set, "%llu\n");
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
+	struct dentry *ualink_test;
 	struct dentry *ent;
 	int r, i;
 
@@ -2261,6 +2443,39 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_ulong("amdgpu_ualink_drop_msg_bitmap", 0600, root,
 			     &adev->ualink.drop_msg_bitmap);
 
+	mutex_init(&adev->ualink.selftest_mutex);
+	/* 64 bytes test size by default */
+	adev->ualink.test_size_dwords = 16;
+	adev->ualink.test_remote_accel_id = AMDGPU_UALINK_ACCEL_MAX;
+
+	ualink_test = debugfs_create_dir("amdgpu_ualink_test", root);
+	debugfs_create_file("remote_accel_id", 0600, ualink_test, adev,
+			    &amdgpu_ualink_accel_id_fops);
+	debugfs_create_file("test_size", 0600, ualink_test, adev,
+			    &amdgpu_ualink_test_size_fops);
+	debugfs_create_file("sw_init", 0200, ualink_test, adev,
+			    &amdgpu_ualink_sw_init_fops);
+	debugfs_create_file("send_hello", 0200, ualink_test, adev,
+			    &amdgpu_ualink_send_hello_fops);
+	debugfs_create_file("remote_shootdown", 0200, ualink_test, adev,
+			    &amdgpu_ualink_remote_shootdown_fops);
+	debugfs_create_file("flush_tlb", 0200, ualink_test, adev,
+			    &amdgpu_ualink_flush_tlb_fops);
+	debugfs_create_file("read_lsdma", 0200, ualink_test, adev,
+			    &amdgpu_ualink_read_lsdma_fops);
+	debugfs_create_file("read_sdma", 0200, ualink_test, adev,
+			    &amdgpu_ualink_read_sdma_fops);
+	debugfs_create_file("write_lsdma", 0200, ualink_test, adev,
+			    &amdgpu_ualink_write_lsdma_fops);
+	debugfs_create_file("write_sdma", 0200, ualink_test, adev,
+			    &amdgpu_ualink_write_sdma_fops);
+	debugfs_create_file("update_interrupt_wb", 0200, ualink_test, adev,
+			    &amdgpu_ualink_update_interrupt_wb_fops);
+	debugfs_create_file("update_shootdown_wb", 0200, ualink_test, adev,
+			    &amdgpu_ualink_update_shootdown_wb_fops);
+	debugfs_create_file("lsdma_selftest", 0200, ualink_test, adev,
+			    &amdgpu_ualink_lsdma_selftest_fops);
+
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 05bc281216bf..1f83d9b69135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -97,3 +97,52 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
 	mutex_unlock(&adev->lsdma.lock);
 	return ret;
 }
+
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev)
+{
+	struct amdgpu_ib ib;
+	int i, r;
+	u64 gpu_addr;
+	char *p;
+	u32 size = 128;
+
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, 2 * size, AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r)
+		return r;
+
+	gpu_addr = ib.gpu_addr;
+	p = (char *)ib.ptr;
+	memset(p, 0, 2 * size);
+
+	for (i = 0; i < size; i++)
+		*(p + i) = i;
+
+	dev_dbg(adev->dev, "copy src 0x%llx dst 0x%llx size %d bytes\n",
+		gpu_addr, gpu_addr + size, size);
+
+	r = amdgpu_lsdma_copy_mem(adev, gpu_addr, gpu_addr + size, size);
+	if (r)
+		goto out;
+
+	p += size;
+	for (i = 0; i < size; i++) {
+		if (*(p + i) != i) {
+			dev_dbg(adev->dev, "data mismatch expecting 0x%x but read 0x%x\n",
+				i, *(p + i));
+			break;
+		}
+	}
+	if (i != size)
+		r = -EIO;
+
+out:
+	amdgpu_ib_free(&ib, NULL);
+
+	if (r)
+		dev_dbg(adev->dev, "lsdma selftest failed r=%d\n", r);
+	else
+		dev_dbg(adev->dev, "lsdma selftest passed\n");
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 34e92aaa4617..f0a5eeb3529f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -46,5 +46,6 @@ int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
 			  uint32_t data, uint64_t mem_size);
 int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
 			  uint32_t reg_val, uint32_t mask);
+int amdgpu_lsdma_selftest(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..94caaa9ae417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5284,7 +5284,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
 	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
-		return -ENODEV;
+		if (!adev->ualink.selftesting)
+			return -ENODEV;
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
@@ -5333,6 +5334,14 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		remote->rb_gpu_addr, remote->rb_cpu_addr, adev->gmc.vram_start,
 		adev->vm_manager.vram_base_offset);
 
+	if (adev->ualink.selftesting) {
+		u32 *p = remote->rb_cpu_addr;
+		int i;
+
+		for (i = 0; i < rb_size / 4; i++)
+			*(p + i) = 0xdeadbeef;
+	}
+
 	/*
 	 * address aliasing mode, shared wptr pagee left is not enough for wb data,
 	 * wb status and rptr, alloc another BO, and then alloc npa address and map
@@ -5402,6 +5411,8 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	r = adev->ualink.msg_ctl->send_metadata(adev,
 						    remote->metadata_gpu_addr,
 						    AMDGPU_UALINK_ACCEL_MAX << 8);
+	if (r && adev->ualink.selftesting)
+		r = 0;
 
 out:
 	if (r)
@@ -6387,11 +6398,229 @@ void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 	adev->ualink.remote = NULL;
 }
 
+static void dump_buffer(struct amdgpu_device *adev, u32 *src, u32 size_dwords)
+{
+	u32 i = 0;
+	u64 p;
+
+	dev_dbg(adev->dev, "buffer 0x%px 0x%x dwords\n", src, size_dwords);
+
+	/* at least 64 bytes dump */
+	size_dwords = ALIGN_DOWN(size_dwords, 16);
+
+	while (i < size_dwords) {
+		p = (u64)(src + i);
+		dev_dbg(adev->dev, "0x%016llx: 0x%08x 0x%08x 0x%08x 0x%08x\n",
+			p,
+			*(src + i),
+			*(src + i + 1),
+			*(src + i + 2),
+			*(src + i + 3));
+		i += 4;
+	}
+}
+
+/*
+ * With or without MPNHT FW running, write to remote ring buffer
+ *
+ * Write 16 dwords (64 bytes) to ring buffer, don't update wptr and ring the doorbell
+ *
+ * Dump VRAM content check if remote writing is done correctly
+ *
+ * assuming ring buffer is located at VRAM offset 0x60000000
+ *
+ * root@atitest-MZ01-CE0-00:/home/atitest# cd /sys/kernel/debug/dri/0
+ *
+ * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# echo 2 > amdgpu_ualink_test
+ *
+ * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000001 00000002 00000003 00000004	................
+ * 60000010: 00000005 00000006 00000007 00000008	................
+ * 60000020: 00000009 0000000a 0000000b 0000000c	................
+ * 60000030: 0000000d 0000000e 0000000f 00000010	................
+ *
+ * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# echo 2 > amdgpu_ualink_test
+ *
+ * root@atitest-MZ01-CE0-00:/sys/kernel/debug/dri/0# xxd -e -g 4 -s 0x60000000 -l 64 amdgpu_vram
+ * 60000000: 00000002 00000003 00000004 00000005	................
+ * 60000010: 00000006 00000007 00000008 00000009	................
+ * 60000020: 0000000a 0000000b 0000000c 0000000d	................
+ * 60000030: 0000000e 0000000f 00000010 00000011	................
+ */
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 test_size_dwords = adev->ualink.test_size_dwords;
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 seq, ndw, ndw_copy_cmd;
+	u32 *src_cpu;
+	u64 src;
+	int r, i;
+
+	if (!remote)
+		return -EINVAL;
+
+	peer = &remote->peer[remote_accel_id];
+	ring = &peer->interrupt;
+
+	/*
+	 * 1 sdma copy command to write data to ring buffer
+	 *
+	 * sdma linear copy command is 7 dwords, align to 8 dwords boundary
+	 */
+	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+
+	/*
+	 * 16 dwords data
+	 */
+	ndw = ndw_copy_cmd + test_size_dwords;
+	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
+	if (r)
+		return r;
+
+	mutex_lock(&peer->lock);
+
+	ib = job->ibs;
+	ib->length_dw = 0;
+	src = ib->gpu_addr + ndw_copy_cmd * 4;
+	src_cpu = ib->ptr + ndw_copy_cmd;
+
+	seq = ++ring->seq;
+
+	dev_dbg(adev->dev, "src 0x%llx to npa on gart rb 0x%llx seq 0x%x %s %s\n",
+		src, ring->rb_npa_gart, seq, read ? "read" : "write",
+		use_lsdma ? "use lsdma" : "use sdma");
+
+	for (i = 0; i < test_size_dwords; i++)
+		*src_cpu++ = seq + i;
+
+	dev_dbg(adev->dev, "dump test buffer data\n");
+	dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
+
+	remote->use_lsdma = use_lsdma;
+
+	dev_dbg(adev->dev, "use %s\n", remote->use_lsdma ? "lsdma" : "sdma");
+
+	if (remote->use_lsdma) {
+		if (read)
+			r = amdgpu_lsdma_copy_mem(adev, ring->rb_npa_gart, src,
+						  test_size_dwords * 4);
+		else
+			r = amdgpu_lsdma_copy_mem(adev, src, ring->rb_npa_gart,
+						  test_size_dwords * 4);
+
+		amdgpu_job_free(job);
+		goto out_unlock;
+	}
+
+	/* SDMA commands copy from ib to NPA */
+	if (read)
+		amdgpu_emit_copy_buffer(adev, ib, ring->rb_npa_gart, src,
+					test_size_dwords * 4, 0);
+	else
+		amdgpu_emit_copy_buffer(adev, ib, src, ring->rb_npa_gart,
+					test_size_dwords * 4, 0);
+
+	amdgpu_ring_pad_ib(&adev->sdma.instance[0].ring, ib);
+	WARN_ON(ib->length_dw > ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+
+	/*
+	 * wait sdma done
+	 */
+	r = dma_fence_wait_timeout(fence, false, HZ * 10);
+	dma_fence_put(fence);
+	if (r <= 0) {
+		dev_dbg(adev->dev, "remote sdma fence wait timeout %d\n", r);
+		dev_dbg(adev->dev, "use lsdma for testing afterwards\n");
+		remote->use_lsdma = true;
+		r = -ETIME;
+	} else {
+		r = 0;
+	}
+
+out_unlock:
+	mutex_unlock(&peer->lock);
+	if (read) {
+		dev_dbg(adev->dev, "dump remote read data\n");
+		dump_buffer(adev, ib->ptr + ndw_copy_cmd, test_size_dwords);
+	}
+
+	dev_dbg(adev->dev, "ret r=%d\n", r);
+	return r;
+}
+
 int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id)
 {
+	int r;
+
+	if (!adev->ualink.remote)
+		return -EINVAL;
+
+	/* vpod reconfig leaves the local wptr stale, resync it first, same as
+	 * the handshake does before sending HELLO
+	 */
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id);
+	if (r < 0)
+		return r;
+
+	amdgpu_ualink_reset_peer_rings(adev, remote_accel_id);
+
 	return amdgpu_ualink_send_hello_msg(adev, remote_accel_id);
 }
 
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type)
+{
+	amdgpu_ualink_flush_tlb(amdgpu, flush_type);
+}
+
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type)
+{
+	if (!adev->ualink.remote)
+		return -EINVAL;
+
+	return amdgpu_ualink_remote_shootdown(adev, remote_accel_id, addr,
+					      size_in_pages, flush_type);
+}
+
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev->ualink.remote)
+		return -EINVAL;
+
+	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
+
+	/* Update interrupt completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_REMOTE_INTERRUPT);
+	return r;
+}
+
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	int r;
+
+	if (!adev->ualink.remote)
+		return -EINVAL;
+
+	guard(mutex)(&adev->ualink.remote->peer[remote_accel_id].lock);
+
+	/* Update shootdown completion write back address */
+	r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
+					    RB_TYPE_TLB_INV);
+	return r;
+}
+
 /*
  * The low bits of handle_lo carry the message-header field on the wire.
  * Strip those bits and splice in @acc_id to recover the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..52bcbf1b1107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -333,6 +333,12 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* true for selftest driver path, ignore FW error */
+	bool selftesting;
+	struct mutex selftest_mutex;
+	u32 test_size_dwords;
+	u32 test_remote_accel_id;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
@@ -393,6 +399,14 @@ struct amdgpu_ualink_mgr {
 int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
 				 unsigned int client_id, unsigned int src_id);
 
+int ualink_simple_rw(struct amdgpu_device *adev, u32 remote_accel_id, bool read, bool use_lsdma);
+int ualink_send_hello(struct amdgpu_device *adev, u32 remote_accel_id);
+void ualink_flush_tlb(struct amdgpu_device *amdgpu, u32 flush_type);
+int ualink_remote_shootdown(struct amdgpu_device *adev, u32 remote_accel_id, u64 addr,
+			    u32 size_in_pages, u32 flush_type);
+int ualink_update_interrupt_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+int ualink_update_shootdown_wb(struct amdgpu_device *adev, u32 remote_accel_id);
+
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
-- 
2.50.1

