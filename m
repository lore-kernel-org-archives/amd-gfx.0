Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC7FC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB92910E418;
	Mon, 23 Jun 2025 16:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VmWuYz26";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBCF10E40C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD/tAx4g3ek4GLKwZuDqJAJKibkas9hZ0wytNSHU2NAWIJoq5P397f3FqykuwLkb1H6pCJrE86VeXxgDa4btqVIqBfdimo4jtlwVK4QRJAJoFMpub/2feybWlr+blPqn+rX0zkAGmWK4zW7kJEhCp0pxEjVtnvIjsapYUB0T446UyjcDeWfQbwAEjkv9nGqlsqJj1Nk58TSCcwIOA7odVNl90dthFi9V/7xBSlBuQsXrMkgsJisFjP8rUOeiGWNaehGEb5cSuKOygqrFYZkDja8m00XwYs8uOlBozsCvPX4R2luZpCVutdJL5jTmpDvM2DjGUgvzDHTDDm536wSrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbXBmnhUlG1NFBNAWW+uElNatQ8H2UBmb++n+4hLUjc=;
 b=d2hTHVrBFlPIuJ6mPOPlgDvughYU4KcD0MkEqL3/S7te2xdaFergRGBwtJRHv6uekKTR3GYIfsrtj6Yn6zEuh0cPVepccTJge5FayN8z3kLQdHY9RonsoXbRjh5f7CRwK/yHE49PmXECRN+VTwJqvuOCN79Luo4pS+t/QBAX2aRu7NF58QPPgAJd/JPuaV9JVXT3YcwxG0UigQxLfV2bexyDuSBEpTUl+GC/vT5jHLT71ildqK6XDHqUpy+MwVsJqutgq5XBGvOGmN2Lqge65TOcRUb3AWFRNUWgK7QXMoEzJ0IlFzbJGJddeZ8QK9bEN+JouU1cxi9272t+5B/ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbXBmnhUlG1NFBNAWW+uElNatQ8H2UBmb++n+4hLUjc=;
 b=VmWuYz26BVz8E18rDreuCW4mh+6bhR7IO2rdAGHnrs34WfJj+EX73lQiW1ANX/n5ZklXgNsmRB1PVwOXd6rJwuWzWWgsnp69REPLoh3w8KcjkWN/FklhPcH2uCz1HXXYec0Xqh85SMgD5WKaL97PNxQbtP4bEfNfGy3IbzWHPH8=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 16:15:02 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::2c) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Mon,
 23 Jun 2025 16:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/31] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:18 -0400
Message-ID: <20250623161438.124020-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bdbe5b-5cb6-49fc-fe93-08ddb2711bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cRjoN9vBX2Ba2VocPE+MRzGoLIuJMSRU1/+WT1Bq5oBiptdGlNAeDTiOEN3S?=
 =?us-ascii?Q?qcCSojrmRHPNKqFzHIuCdPRGvDIwscVcXglIBl/ZqV1n5uln1T7wli3im1ls?=
 =?us-ascii?Q?G3hrIzW0cpdAQi+Z1S8+U1Us7QdbNSSB3EPJKxFKqpU2gfupfLT3lnBVLSgO?=
 =?us-ascii?Q?Dlpy1B4/a84NhD4qPUVCLh8gA6byStcFMpeYEiqngv23viNRgOqXqgRRNN5E?=
 =?us-ascii?Q?8QtNrW1LSCClC4gGHVUrFCp6Oh8ZfDtKH673doJWDWAotB6mMvLtBK1BO/Gh?=
 =?us-ascii?Q?s7xQnsV5pTQlVv0RgqjSe1Epfsj7pLIo/XDOsQ0mMyx6olU3zCE5qqdYZ8ZH?=
 =?us-ascii?Q?enz5eI89o+g6WMH6PxUPqhHXVBkOR9MCgtJywpcNZeTAQEyYxUBTmngvLEe2?=
 =?us-ascii?Q?LO5Mfdb8ei+adxRjLUNvap+qADMeOERsdgocPwKimqKRsvmg7u5l2s6jn8Tn?=
 =?us-ascii?Q?nQh6q9E0PGiPfgYgXjCYEB97GQnknOb7/d71iLJcpJMAvnTtk7/Wm4rbGJuD?=
 =?us-ascii?Q?y0z5hGg4jvG8TjZztMaVZhP/NsM7ht2HJXI/5eGg4+ZBIGqbYuk5vt0VAVc9?=
 =?us-ascii?Q?95kHiYCRfsYIFFsC4XUOhGvs+S1gs+jGHvQlXuDlJBhZRy7wHs4WQMa0Rkul?=
 =?us-ascii?Q?uUL7GM5onOAgLwH2iMTqeCEazehj4mbwQioc1kC+dsGZ7guHXkRVQ2a9udfu?=
 =?us-ascii?Q?fJvVJrI/qxK3FYKn23I+GHnqWXC9d5CSOtqxKxdN657BxoVuapU/yalT5kSW?=
 =?us-ascii?Q?c2xtQoW5JR7GBEgx8cdSoGGXGA3odR4ENOC5zNrqaL9rIrLeQCicwuQE0c/X?=
 =?us-ascii?Q?zicdrheYhaV7fUY8YxYOJcfro1JTOgHNxC4TR+WSEA1/SlL8ciwlDuH3N3VC?=
 =?us-ascii?Q?PRiHMzAZppc6irdstZPdAW3psbua9p8Jma4VdC+WzDkK7wHMNjS2wTObqjfQ?=
 =?us-ascii?Q?ojFDLZF83cbTvziCO4MG/b3DMZCDkL1zmqoZv2HgqRpGbTtW9oOmLXbV0bUY?=
 =?us-ascii?Q?r/9eMU4Heic1MjNAPnQ9m2gOvMAujLr2juaJTduIAdudDuq6TXtkMXbofYTa?=
 =?us-ascii?Q?EFwnHNS4NWz/aAXpRPbh26rLJTnMijuUGntS+L7ihyYe79+Am8AsXD0peYiG?=
 =?us-ascii?Q?8aIw4KD5aRCPYLc6F6JXNcGwSST9oXRJ0u4/TUSr4EEgCL7L4AZvogry5+GS?=
 =?us-ascii?Q?fdwkFdo8CuLxx18lOh7IC5IzasXWEUf2FeuOUaLbeY9Dw51K8WlFQ7C5H9HB?=
 =?us-ascii?Q?m3uE+UP4xUqDvvFbnEM6x4MpERHuoE3dvvhZvOxBdjzqupjzxeezKM/nb/yB?=
 =?us-ascii?Q?69xGDg5/dhejCu08iOMeH7aHdZH+Nu/5m5ew1ueGUB5LcygcxdsKEEtSW7UL?=
 =?us-ascii?Q?hxKwi5BtJzzg3rdVvaM8RMePvzAYhiclr5XbUu4H85nloaq8Kq5eZ77BVxKV?=
 =?us-ascii?Q?azdNRFgTLsSkXvQq1LajO94UrpRhRzzD/iJ2xcvQNTPi5cckhYfvwkRjbKbM?=
 =?us-ascii?Q?E+k0+SDR8qlQ8CjAqVN/EZ5wrKFpr7jx6Ywj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:02.6152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bdbe5b-5cb6-49fc-fe93-08ddb2711bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dcec2d07841..04b2e3def5098 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6283,21 +6283,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6821,7 +6806,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -6844,12 +6829,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -6992,7 +6972,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -7013,12 +6993,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -7254,7 +7229,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7296,7 +7270,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

