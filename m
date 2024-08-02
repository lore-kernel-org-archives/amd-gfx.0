Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06ACC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 16:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8763310E094;
	Fri,  2 Aug 2024 16:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvtdVLg1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A70A10E013
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 16:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j06Jfrm70yOgxa6fXYnQFKx5goeDKDPbBsuOSUHO0+m8/8FrTEb1BmayLFYzEE1FKftPSGPHh9hagKpzys/C1yxUJIPJgsz9wLtMv1MCXygBTSVONu51qV7aKhjeLipI/MqkCaOKf4Ww+7Bz3sDf0HrACDxu6ls0NdDDApog8fI4NWoQZPiS2HT1hfRwcO0NRVEqUBn94ilzypu1WdiZDcIhtfTBS2tk/H2vjRrvoMLWX8ViqAycegSWPtBEz0C4C9eIPGiJ0C20Un8imsOtql6UKocsQzyDbGbqOES8z+ukk13vARj+Pfz9OL3G+ed2cOoJhq9WIj86o2fbbEDfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbmLiTeKGyNs6WcoDVisEiEVyHvRWzb6UxBPSJ2f8Dw=;
 b=IBVg2cup0lzmMfuFbWkq6YK2nmTdHk2cU93jv8ApIhPpLVObc2BShy44QxPy+hnbIHAPRTNTzKTW5bKrhIe0dhqBXgStueoGu3fuukB+bm7Xde2geBNOS++x2PVwe1kizXW0Jo1nRwqwNjW2ftxOvTxR6DbDvoIzMBaV/tw6VTmCoUf5OohA2FL715TxjNRjvHqvesclwLwH+KL7hy/zdwvtF1qZk3tFo/I0Pjr5+V0izozo4UKxGihP4rkdijjpVTeF+316kISG4IgKoLhfeNXmBdRzUvV43Y3GWH+7LIouCqWvZ9mt0mt+glJMN3i5ChDFN28J6bSWn4F9aHufuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbmLiTeKGyNs6WcoDVisEiEVyHvRWzb6UxBPSJ2f8Dw=;
 b=KvtdVLg1ETDJVV19IcbYXiBkSkeCvpRTZjK2WJPZ4gSQ8GWWwdK5Wza1uTCA2iriEigtHXDeqjI7QawMKD+Ce516z1l4XgcuAFeTVhspzM0IFs2UkC4NQhmk+AuFh/EsbYHdP86rGEFHFklNOnSm0nuLKx/MPQZLA7ULw4MCOfw=
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 16:38:34 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::59) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 16:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 16:38:33 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 11:38:32 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail for
 gfx9
Date: Fri, 2 Aug 2024 12:38:13 -0400
Message-ID: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: b7faec89-ea57-45db-5188-08dcb3118cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+VgP0Iog1k23cm0JYcO36VLMa3IqTZzjsLNsrT78cjB51qzHZGZvPWbjjJp0?=
 =?us-ascii?Q?Vy332eElpiYheOLaOiEZuNSUjizaCrLgnDjQ47FQWro6CAed9H2Q0G1ZyxIV?=
 =?us-ascii?Q?JG6pd8KanbcPv3koIYfiECB+WlD5GzWyHElbSNO4ija7sYipHxB1jPdJV6ZU?=
 =?us-ascii?Q?OBN/2QgL3eO/MF+6QEee18LbQUxXKZ4wEXjQ/4XxmDcdWXYSGrkd+AFWzSjS?=
 =?us-ascii?Q?8KNJr+ZY8I8EIyFO/EluFNOJPKYJoPnOtvbKlTovXykAWUcJBoC69eiXvwC6?=
 =?us-ascii?Q?OsdN37lM9GMs3VExwqOJCMf/0ygP8xmIB/CtsmWE1tFgLjYxB9bCd83iQBg6?=
 =?us-ascii?Q?1mVUlLIpRdD04iq4XsiK8I685zqc4UJ8Dffskl6Z4v1w+NT6rBmnWOaqPQrv?=
 =?us-ascii?Q?aRUBcrEdDZZk/fftndDG4rX5a1eZOsDchcxnCsoPRk91KZpnTUT0SXv8shcM?=
 =?us-ascii?Q?fB4N28+v/8j6M3kE81kD00QrUu/GgiQ4Fk2lFNuMvP7ivkbW9tOmpHg1uh3Y?=
 =?us-ascii?Q?N164EJT9Rflk5sbYU0nqIUD2+VenPYeyIfnTzG9fERxemMj4kbbdNsDl+4lO?=
 =?us-ascii?Q?PUILR8A4SuGWMQ1NxOlYFE4Ch4bCZMEm9yua7B8mpWj+5uvGqkHio4INg1GR?=
 =?us-ascii?Q?InKx4/CVWn8eFF9KadGUr6rScB2y6B6onEOfP7Zlltz9c6cIYxA04WsL8n+e?=
 =?us-ascii?Q?AeZ9dnXQgXc5My332Ck3Qz2uhinMEn2WQDSTmTBwq3mYoQNosph3sa7rABjD?=
 =?us-ascii?Q?gMalf5w8rag8AtcUXFFOdQ8GHwhAjtB3P/dgTTbEU0urtjxV2u8B6QrjwSeb?=
 =?us-ascii?Q?P7ta5H67IwnTkWVHX31dja4ZNwXLh80ZlD+dlr1cpLBO8tLJjVQ/XAxAnFts?=
 =?us-ascii?Q?067c8wKJw0dfGl6ICaFgUAPTPfvfl9P4DGRtVSGik1qkkiShu8NY8XzHMlCT?=
 =?us-ascii?Q?RLmW/vPFNI5QKH5EuBQ5zxspnRDq+qvh4NHYkTNyXb8fH2A0mxcTy9kj5BSO?=
 =?us-ascii?Q?mCwOJAX79dGex0z50I1u1ZEHgqSctu1F5J7TA00oBSrlXroVtooo04gxkNe8?=
 =?us-ascii?Q?Pc4L55CnL3W3ehdzUY+fjakAD/9lQEyuSm122McnSP+iq2sLq1ICQEOUjALa?=
 =?us-ascii?Q?RRYBA6A+xKy/hMkhGm9FvZGl19T8Q3VFoAf0qcq8EonINXrnxkpgroGggIa/?=
 =?us-ascii?Q?gH2zdCprxnNLkf2KvF/KhJNoP9P37wCxXLWF5Gs19lxdxZTzVu9G5xsgNV2b?=
 =?us-ascii?Q?z7w5JihPPMBdjDcmJeNfSfiCdgPN9ljPZEIQ6MOavWjTETgPhRL0c4TmQ55H?=
 =?us-ascii?Q?PRdZdGQcSmFzSGcaFaqcOCanewGvVPBk7Y+Lufu3+tMm5QoFx+pDbU4A8yQq?=
 =?us-ascii?Q?Ea7DuMtaqvwNcL8hxoo+W/VOP6WX5FjblEKYLveMO8Oaygrv0yDkj9QeQgAC?=
 =?us-ascii?Q?HkeoiQo4P94/HrT91IL8hZiEWzAuZiHt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 16:38:33.5722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7faec89-ea57-45db-5188-08dcb3118cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

If queue reset fails, tell the CP to reset the pipe.
Since queues multiplex context per pipe and we've issues a device wide
preemption prior to the hang, we can assume the hung pipe only has one
queue to reset on pipe reset.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 46 +++++++++++++------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 32f28c12077b..c63528a4e894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1173,12 +1173,30 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	return queue_addr;
 }
 
+/* assume queue acquired  */
+static int kgd_gfx_v9_hqd_dequeue_wait(struct amdgpu_device *adev, uint32_t inst,
+				       unsigned int utimeout)
+{
+	unsigned long end_jiffies = (utimeout * HZ / 1000) + jiffies;
+
+	while (true) {
+		uint32_t temp = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
+
+		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
+			return 0;
+
+		if (time_after(jiffies, end_jiffies))
+			return -ETIME;
+
+		usleep_range(500, 1000);
+	}
+}
+
 uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 			      uint32_t pipe_id, uint32_t queue_id,
 			      uint32_t inst, unsigned int utimeout)
 {
-	uint32_t low, high, temp;
-	unsigned long end_jiffies;
+	uint32_t low, high, pipe_reset_data = 0;
 	uint64_t queue_addr = 0;
 
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
@@ -1202,25 +1220,23 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 	/* assume previous dequeue request issued will take affect after reset */
 	WREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_COMPUTE_QUEUE_RESET, 0x1);
 
-	end_jiffies = (utimeout * HZ / 1000) + jiffies;
-	while (true) {
-		temp = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
+	if (!kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
+		goto unlock_out;
 
-		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
-			break;
+	pr_debug("Attempting pipe reset on XCC %i pipe id %i\n", inst, pipe_id);
 
-		if (time_after(jiffies, end_jiffies)) {
-			queue_addr = 0;
-			break;
-		}
+	pipe_reset_data = REG_SET_FIELD(pipe_reset_data, CP_MEC_CNTL, MEC_ME1_PIPE0_RESET, 1);
+	pipe_reset_data = pipe_reset_data << pipe_id;
 
-		usleep_range(500, 1000);
-	}
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, pipe_reset_data);
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, 0);
 
-	pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
-		 inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "failed!");
+	if (kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
+		queue_addr = 0;
 
 unlock_out:
+	pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
+		 inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" : "failed!");
 	amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
 	kgd_gfx_v9_release_queue(adev, inst);
 
-- 
2.34.1

