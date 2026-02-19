Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDFDC531E9
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 23:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E582210E33F;
	Thu, 19 Feb 2026 23:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eVSyV8xR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F510E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 23:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe8NS5oUSfrOqi5v9g4HiVE3s/sKzm3PEXgSPUkzjwcB1qASgu3H+oxYgMHyqHLAzx/6g8K7nsAAGJ+rH28pfRXk6Ld7cOYpUdh9007wxiB/baCFFEhuVcRBfGwIcLi6wOpfYKTjOYUO9C1fbauSSCNEkIAydA34iF5YN/WbpTyPjR/AbSaYLUL0+uPvMnO1ETDiyql+dnh/92SXn5Rs1D/isYJ1ON8dWW71NKPtZlsMiQqDTbZ68zZ+OLdggX30u0l8kAsQcGko71CRPOQ+nrPyIyguVFr5fQQGkc2OrdbhKnZIqtNtXglJXgWJsRmFrwnkSqBEazRjMWsGv/MTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vns61sX99QQXACB6p860zMHIjhLW8mMqhB2Ah40lAYY=;
 b=UlUPCrgX3P+wY+r5u4DvsuP8CO407xf1YNGm/jfHl79w7c4SVSSKI6JxxMhWwYkySEllf9A4NqFq3zq2sIRB/E1O8T3pYV3wRCa/CTZH7Fy4Abs872vbzvDSKWLog8Y+goqK5+TZQPnCl3e738CUvD3ZPtJys2AXqWJFurmMcLAnUXUKMHq5XuTC8K/LECK+i/gGKzHlxu7sFfeGx5AshI8KmA2oki/LQ1I565LTkGunlIqz3ubb1aKstLmQlf6Cce3DQbh0oxIoh3WRIrGTiHAaGgY3f1AEwBmsHRtY6uwyUqqcYnvAn0qBTlmijlVX6oqnQLs2x1jFH/sDiTiQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vns61sX99QQXACB6p860zMHIjhLW8mMqhB2Ah40lAYY=;
 b=eVSyV8xRnXpz0FrMSeOXNSCvLKn+GOg/Ht8tzo8WYSOHjPzkC9ok+5DzIqXwMJRblnliwiv6F32xhjsj5BoJtWzTEVQwKjW3j6drez1qHgF6teMbR9cW8cajbsyc4LZs3SROWoLHD1q3/w/rKWxlwKv8dEGUrZCbT/VLNGedI0Y=
Received: from BLAPR03CA0085.namprd03.prod.outlook.com (2603:10b6:208:329::30)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 23:24:48 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::7f) by BLAPR03CA0085.outlook.office365.com
 (2603:10b6:208:329::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 23:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 23:24:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 17:24:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 17:24:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 17:24:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: don't set queue priorities for kernel queues
Date: Thu, 19 Feb 2026 18:24:33 -0500
Message-ID: <20260219232433.31453-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219232433.31453-1-alexander.deucher@amd.com>
References: <20260219232433.31453-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d243224-9ed6-4aa8-046b-08de700e1310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zgp6qwMIKoyxdVtSCDkTmkm3tOYo/3Kyc4SnffX3QAYGtoJbmv3sQtEor6X?=
 =?us-ascii?Q?Vs++DVQjC9vt2FuBP2euzuLFjr7wD4mRA170uAlyFtYnRYIp+iNLeeofh94b?=
 =?us-ascii?Q?K0u1EtQrxpi/2tHWTjRjiNhK6vLv9anPGe06CfABj3ljgFYOWmaBWZtT1VFw?=
 =?us-ascii?Q?1IR7/jqO5nvjFtzzL1HkdBb/p4Xyp1ukf3e3xZwiXbjt8ziqHLAQl//XUS9J?=
 =?us-ascii?Q?Ik670KjQ+bmzljO69zzO/hlhZRQZlDCsRAXf2C4hauDfDJFowTVY7fsa/6Jv?=
 =?us-ascii?Q?HP69fTMZf+uFxjGRQrNWmzrhEnIkmNpf7U0+/Ho/loNbbn86Nh9858D+KZgc?=
 =?us-ascii?Q?LbE00z5qQntqmF4uN1aL230yY4o7shzcHY/r5Om73I7X3jzujrxBV1oKVBv2?=
 =?us-ascii?Q?G+zVTnH0vcs8EbHf3/5T+Kb/V//Ap7c6VQwBdNl0kNWgtsoHMcahMuMkdH+P?=
 =?us-ascii?Q?kTdgLHFL1vEBs7wrUKS5fikmMWMH8apAWjZKzgdKuz/foFIbyKuKbwvCn00p?=
 =?us-ascii?Q?rZgEKUT+Uj0cyo9nKsTxRhQikbN09VFXkKk7H547Ok18HF9z6C9cvn/dQCt5?=
 =?us-ascii?Q?RV1D1n8dioAv+5IkborsnSIC2qw/QBHd2Mts2Pfq8d8xJmcpIBeO/iWgiPUh?=
 =?us-ascii?Q?y7qwanRH5Jzpt3uWtyrvzKhwxinUMPzk7BbYSlDzsqPueNzkN+PF8HSWxud2?=
 =?us-ascii?Q?5MvkpvKP7fmGAbVunnHtQ3KACH9JLIxeB47i0T8DgyJ+46+WcjoreMxpfdC/?=
 =?us-ascii?Q?46qKQvywGuZ05CgEcA4wAf5+R02jAJsEwGPzGPdh65oY1d/HShlfOvk98PAG?=
 =?us-ascii?Q?iMymcX2vIGKOXheLCJ2tbCWx4vzc7TMOnw5TNFsvh3OvIsxZQkdmrGC67f64?=
 =?us-ascii?Q?gkj6StHAUwmLWukAR0Xexaa1ljFUPUM7XQx/ck5/5Hn688RLYkA8IlBVWHT6?=
 =?us-ascii?Q?KZlQ5rBqqzuwMEMIS8Sk5MLo5v6xl+4v0w1Ilp9Lp26YFYUAdxkycp0Zermp?=
 =?us-ascii?Q?EiNvjff/LbhwhwzDi90BPucutOVXpTlp8YqGCwOyrDc7p0g+WSlNhLVTdPO/?=
 =?us-ascii?Q?cKR4POAKhLdyjs9Qnc2ksNvcCQmYudfQ6PBg2QMD14lDy0QMMeGVs+rzxKno?=
 =?us-ascii?Q?aUWx05sGCAZfEGKpSG00XE/A6eYft0DKVCc49loy98TA/yjcYyMTYHR03WBI?=
 =?us-ascii?Q?OdzngADAqR6s+2xpXHKX4m0VWmlwu8FfbcvkIwSY0iBWM7Sw9pEGSX5CCBVs?=
 =?us-ascii?Q?KiOueieHOorZRnE9xVW9b/SOqxwhifmi3XBKcb7CeeYOcn6xBKeo2APOAO77?=
 =?us-ascii?Q?TUVNvwQMLIi4VnHfm+mtqGLM3x4fckvap+wJTLa8Pj6a6bWHruCqE3hAUmAO?=
 =?us-ascii?Q?bLIyLVSKCQ+vX8+BqwetxCONh6ZatUdrbJq0ARTSKmm5gNhLFItuMQZZ8qqR?=
 =?us-ascii?Q?UjJrq4Y/gE4mVchttw+Qy/1r1ojMTtI/54EYDW9LP/c8oWORwXh79UfJeW54?=
 =?us-ascii?Q?TR5V6wEU3rSWlIn6DlPcp8TGsM64lRKjcJNifHRc6Fgt+hZuY0ijhhOQ5Q9h?=
 =?us-ascii?Q?8cTB5awN9ig+p8nTinD78gV/QLimAmPySAt0qW8M7KfGLgIy41isCr4EeV9Q?=
 =?us-ascii?Q?llGwkHDy6pp9E8reitvnAasro1+KQ46Ss9Gi6dW5Epr3Nnd14FO2Y1nAP6jt?=
 =?us-ascii?Q?I6bNSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JbTO4KcaYpR+lYOtNdgCoTP6MA4HvoAgSglQ+3lKS/Z3F/3h7bySQTWxvvJhYkQcpVCyUCdSNxC+r1xVsV1G28D7m+2/MFxQfTLEHaZYuCIkBDNAlj6fqbjZQREEwLljU5ouvbYW96F7TLJzG1D+0MTIsk/T8JjkYa+2c4J8+mS1cz9X6qLi4C+PVCpz2WUUu6UcPcL0NQghfpLRfmlyulFpxu4kcu2v/IK9yaIfEQrScTBf1WV6Gy0+JaiKA/U2dm382ZsLPqYSR9lDWJ+zbVrROKPt+BIpKRUpG+54K//h3blXuaiT0n54+CxSAQOaFlyKbVAt9H0loO4gthsmEj8COV2BYXLiQvob+PrMD/xKm4Cr0ylQPEYvX0iKRlySaGiGgv6SVe/f+EcXZVVkuj7j/Chlj8ndqidIh3KjlnwbRL/ltfSu40uM2sekVM5J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 23:24:48.4425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d243224-9ed6-4aa8-046b-08de700e1310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622
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

Align with KFD and don't set queue priorities for kernel
queues.  This can result in starvation of lower priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 129ad51386535..805f1f29a3c25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -800,10 +800,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
 
 	prop->allow_tunneling = is_high_prio_compute;
-	if (is_high_prio_compute || is_high_prio_gfx) {
+	if (is_high_prio_compute || is_high_prio_gfx)
 		prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-		prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-	}
 }
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
-- 
2.53.0

