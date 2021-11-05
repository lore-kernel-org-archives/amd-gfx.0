Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76706C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F59A611EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 14:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F59A611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2BB6E8DD;
	Fri,  5 Nov 2021 14:09:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CD16E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 14:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVtvGbM5PKwYuAYElypF40fm+1H84gO5HDQIOrP/zrJt2D0WqHS0UL9Aa1nZqj6RRdmRNkJ+FD3Rwq3GFY60L/9+sCwJkZq5xrkZdMvaU5yX0oGJK9/tizF2FHYnJzlRMaZTkS/aduvvcOrAlHNeD3qOyixdkmxkeatpeAURWlG9nrmlSS5nYyMVx8Kxq4cIcZeg9Msbp9GYlmfDktrISU5fou7RotZzBSzFldv1Mhk7zZONO9k9psMAyISypE07QhMk06gY6mGGWhb93IGnjxXqBL9td4zornzo4VsgXMrRvszcRJ4ePjpKQG9zHMNR+nL0D6M/ydpvfExCB1OQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbFoVe6MHiAuYzTgspAANuSqgEWzVaxBCeDM03TGbzI=;
 b=f5a7Pr7P8EAKSvfJSPEA/UfpAsaEZpA0tHHXw2ulAYKW/oo0nvNeeFhWZP62SQGaFrEMJ85nSHGqEZBQ/B0xOjSapCiA7I7xG+zO1/8o+NPy7yuBDgmygzTe2Gf0Xbnh9UNrqXbXY7cwE3YDC5iDg6AeogrRL4a3mcIbiaJmjoexkgxkYrHn+//+zlkMOG/Gwp8qxaZIWJ+YhkffZ0tLmKwbbSiAeekrvgdj8QEJkC7Qxf6vSlqNys7zJ75aVoCEVzbYhB44EDkKTWwsfNBcEhzOXTm7q01XzSDM513LZeIOsloSYeIscH8Lzo4Nb57UK8WqbmIeJPMPk0bGvSCd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbFoVe6MHiAuYzTgspAANuSqgEWzVaxBCeDM03TGbzI=;
 b=vPzc//Rl+FFPkzWMWDH2b/9YpxVtcrvVgwObzswlLqP6vjWxzebhQLjVOcF+ZSxFWmXX2x+lxECom7NNy5fCRIKysWad+gg0Tmrq+iBcm0dI/NYuxkaLB3+1lsuT2b8WjS0hN4563xAnvSJF4+jqcuDyFDNNNK+uFX1SpAPLrG4=
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 14:09:35 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::ae) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 14:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 14:09:35 +0000
Received: from linux.fritz.box.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 09:09:32 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 2/3] drm/amdgpu: add HIQ eng_sel to KIQ packets
Date: Fri, 5 Nov 2021 15:09:11 +0100
Message-ID: <20211105140912.3638-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105140912.3638-1-nirmoy.das@amd.com>
References: <20211105140912.3638-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45a684a4-7715-47c6-2f9c-08d9a065e577
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4068AE42A7F502FC7FC61FE98B8E9@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8BORHqQT3QZhlHicaUtIiXJCmhAq+hrGyDG3N2AWbm6dBFLlPRbK05KPqLsWfdrnEp4vQIIf/SBWD6u1eVfCUHOfSao2jaomM+t6LcICHWVCTW9dqwKAsVmWIhCJXNNjX4DvLYlsqJuUtr1eaOYp3txDUiJ+psLpnNXsN8zoOwU9mfHLmXIQz4o6op22dyF0tI/xuY3KlGSMni68RhJJP2nnfOH/W1kffYgP4i17kPIJ2EYOuNafnnv9aCB8j/fSYs3ZGjDTPV9zBmece0RuWYB/d2DNbfgxOforUwQr6VhbG0U8hjY2LoyK6T8IORjJ5D9wSGudskCauuv5WT9E6LCieq3qR29G3R8Ck2gvurKRnDzoqJGiQvmEVLHXv/vH3hfZrd8C1v0libApTmY+q23oPJS8dFR8X3M4BjglIE5lm4UzYohGStOPEfSD4bvIxckdI/s9tdNfy303pSjD4lgdfMhrhd4uZExW+P7kdyBX2LhT/IGvYVY29UeUJ15bwg+VbXRxl+f7GSD09R6I1m617xIvdvLS86IQmpaDvcEhNyBoiSx65HSOS6Uv4oUJVbRd/XAouuRApj/txx4bMpl17zL2QkzCrKtmtHv8SEA8ltJS27i78ST0is5Z8W76FhgQjkBCLVNKJu/2wowT1pFtna935ZmiH40lbkV8shrxIf7yGZq0fbdvmlH2vb79MCwz7maQEfUws1eOKkIg+LFo6FkZZCKhVNf++v75Sc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(336012)(70586007)(70206006)(4326008)(83380400001)(26005)(86362001)(2906002)(8676002)(5660300002)(186003)(356005)(16526019)(8936002)(47076005)(6916009)(1076003)(81166007)(36860700001)(82310400003)(36756003)(6666004)(2616005)(44832011)(54906003)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 14:09:35.0011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a684a4-7715-47c6-2f9c-08d9a065e577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow KIQ to map/unmap HIQ MQD as well.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 ++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5b8cb76e35a0..053a1119ebfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1010,3 +1010,17 @@ void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_sta
 			(adev)->powerplay.pp_handle, state));
 	mutex_unlock(&adev->pm.mutex);
 }
+
+int amdgpu_kiq_get_eng_num(struct amdgpu_ring *ring)
+{
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+		return 4;
+	case AMDGPU_RING_TYPE_HIQ:
+		return 1;
+	default:
+		return 0;
+	}
+
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4d9c91f4400d..88d942b1ef08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -373,6 +373,8 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL << bit_width) - 1);
 }
 
+int amdgpu_kiq_get_eng_num(struct amdgpu_ring *ring);
+
 int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg);
 void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 90a834dc4008..538130c453a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3633,7 +3633,7 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 				   enum amdgpu_unmap_queues_action action,
 				   u64 gpu_addr, u64 seq)
 {
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = amdgpu_kiq_get_eng_num(ring);
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
@@ -3660,7 +3660,7 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 				   u64 addr,
 				   u64 seq)
 {
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = amdgpu_kiq_get_eng_num(ring);
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
 	amdgpu_ring_write(kiq_ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f944bb11298..2b29e42bde62 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -847,7 +847,7 @@ static void gfx_v9_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 	struct amdgpu_device *adev = kiq_ring->adev;
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = amdgpu_kiq_get_eng_num(ring);
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
@@ -877,7 +877,7 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 				   enum amdgpu_unmap_queues_action action,
 				   u64 gpu_addr, u64 seq)
 {
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel = amdgpu_kiq_get_eng_num(ring);
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-- 
2.31.1

