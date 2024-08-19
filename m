Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3BC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE7C10E0A3;
	Mon, 19 Aug 2024 19:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyhbVvkR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC9610E0A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szpwo96tkyRvnuIeyInNQ4Bm1mAXcMP7+lDyekED3HdQeJb20bAqbYKiaW4Ds14iR/1Xj0+ggtKD8aKvflY7/c/FQ7A4Mtgx81irbqJ+jDGFzeeFW7CYvvmqVyVoZtKvKdetcTv0VTecoaSo9mPczYwd0x3ClfpSEYsoTQdTTyRQd+tA0AHXzW9ghv/dA3r8xNP+l0LtZ4APpgBvcoYzP383t3c22jsj63MigwPMZKMeLCRoz8an8FDN/4vvCLdv+HXGEv8VCTmxlkeAE5yzc79Z5KVsES+2vmcMg7HB/3MnpsX9wffyHg9k2efY1NrzJgBIVEodbNboAD5R5bEW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC0mxRhHyHLDteYngIuqZdoeXC6rsTA+rvsqSu2LuE0=;
 b=RfKA6wBZ0ovoAWlxC1l+PML5oP3+mJoQSDmQnG+xyBdxkSmRYf0cJFcnlqPr2MXg5j1AoluRz6YGLG53TgzRuDOvQslQ4bSuVu6fx7BDLUhqSHDRbzWOsL16Xi0ewUCqutaTHD5OchkUZ19CnZvMY6Tzv8HARBuiOsjxtu14zOc1WAu+U5+edcRDJgbiML8R0fvTtXi2h24XStDW7E46fMLFhCUF21cjb73bMm/0fI2PLdtfe1qtcNAnfBXLa2wUW5PeB6eGQaqh2lleQZp/P1rV9+WUGYSl3z0sm2f5oGvIwXUGqHURYeJIi12EwXfNAqfdkoAM69K5G3Nt+E67DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC0mxRhHyHLDteYngIuqZdoeXC6rsTA+rvsqSu2LuE0=;
 b=pyhbVvkRj4KKM//lD2hTxTJ1mGSlMuPmUYmYyIMSR6H4YexWXT0CveMSns9S4XhqE8oaaTjXkm3ktBW2G+zkfJMtnFdm/KQBFK5ptnEsUb5xskNbPMLsvTBLmyuAhUSEMsMDi6TwjjPVsGT+gbkrxbpLhvtANFz7hZp473mfnR8=
Received: from CH2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:610:38::14)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:22:54 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::ee) by CH2PR05CA0037.outlook.office365.com
 (2603:10b6:610:38::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 19:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:22:54 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 14:22:49 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 1/5] drm/amd: Introduce additional IPS debug flags
Date: Mon, 19 Aug 2024 15:22:13 -0400
Message-ID: <20240819192217.18799-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e85525-8cce-4e4f-72b1-08dcc0845306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/NeCXq7nD35LGJkrRFrX+eRkNbtu4LgmIpGPUnT+ga/Qn5UvEa1bKFIbM51+?=
 =?us-ascii?Q?JoSrzAoSsHhQxBQcOlAVTxS5zZdF4qt3brGZ6XLR1JPtCj8qLoEfrJH5n/bI?=
 =?us-ascii?Q?GiAgK+T4g8AvrvxUiTg7M12KkNhT+uZU0aKnW4kboXhYT6/MMj324STaLvHC?=
 =?us-ascii?Q?9SmUbw3Q1/iJj1lO8azHiMHS0xc5AdObY3Gx4kD7L8vVWCEvgAe4BzMCw7Sw?=
 =?us-ascii?Q?aCBlNHj++p2su91dGrR46s88uzIxliv7eCUgb7DYWdhBR4JERnh9JHWp1JVU?=
 =?us-ascii?Q?O/qlHHXs0zdJqgNgiKi00vqfr0VHXoj8+Bh0r9HWoRNO0N3YkuRHQFy8PGIp?=
 =?us-ascii?Q?y8HMXi1wEfkjnpxwm2TrPO0xCeznZpF9kqPPggHtYgY+nPLWGYl7cCjDzU2E?=
 =?us-ascii?Q?HVYwBxIKnUdteV5FHh29LyX3OZs68+F9Ba1B573tOwg636+hoNE73Hvol5CY?=
 =?us-ascii?Q?WSNOWmVidwiTu1LIS806KhxLvZYlDYzcT2pPztOuftJlrCoEiCFbmN8qRHvk?=
 =?us-ascii?Q?xrbgLiCJ7HDkFuotlp27UgiCWD4DXrak7i4SRR8mmi7E3zekoJ6rcV+uyUug?=
 =?us-ascii?Q?tLT9SQEKl9k06t2BrhR0iUAuLz8i8HVcos0hQeMaINwscZoRt9VeOME5XhX1?=
 =?us-ascii?Q?Lbwz1S8Dd7qofG8cwlbfacmQ/h9c/6nsA/SaiBrtk1RfBPir4cqDrclyP3cG?=
 =?us-ascii?Q?mv3vUqG2Uj2juJjWtNJJT17+08uMjU9x+dERUsaQ6LcUWhyrmWVbocAUcoB+?=
 =?us-ascii?Q?bYPoizjcGihh41WYLtah7DsUsTvh2FCO4aWp/ZFA3xVV6QpQyf6XFtBi4E4w?=
 =?us-ascii?Q?LSQ7T0ZGFCg7IgMckul/wtBJCBb9umGygTB4wqCA6436H/6GCNhQW1+M+muz?=
 =?us-ascii?Q?IpSLfAh3+OSQmBCI/SYxRnTr/7ud/PpVA3aaRbZi4R3Z05oEhALDpPZQ+Bzs?=
 =?us-ascii?Q?uJ8wo4jHVFtfwyYvfcT62nVocnp7ofC1WlTB9SHBlV4zBdFCeHXHCebsnGUe?=
 =?us-ascii?Q?LhlUcbHPhRmWUMS80MLAsRCPDKYY09pTviRFnjfGnV/6kUhL7knqTvR3zqrF?=
 =?us-ascii?Q?ljV/FqzA6YRxsCk2jAZkMc6d+BJBcjmnHnWhztKSqzeDq281NAp49Xf/3MJb?=
 =?us-ascii?Q?6JaoymFm78lnfxZktQxOqu+XMWrijRGhL+Z6PnzQYmdPMTqckoxDrsO1PqMU?=
 =?us-ascii?Q?7kYEw91ZWudjCeHgtczXeEO5ns0K+n+SXDzS6FsUuNQ7fg+SqFHX8qLV0pG7?=
 =?us-ascii?Q?kWbqDcIuIWAWM4rngtJ+6ME4EE7cVJCP9ZJsKDgwq7ihaMEKMFeg+ZpnaU7d?=
 =?us-ascii?Q?LnUwZtioDD7IcOnx5xa2XDI224nuMCtUWTAC5bTQ6mn/N5sxdTACMC+inVyd?=
 =?us-ascii?Q?DGFU37VjTce/c/EGOE0LOGvGFyUqrYoNUattLSQLxNTgOnLRFj+nDMFlMmy0?=
 =?us-ascii?Q?fKjyULBYbqgohRipCAJPtGQflLOQfTSf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:22:54.0134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e85525-8cce-4e4f-72b1-08dcc0845306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Idle power states (IPS) describe levels of power-gating within DCN. DM
and DC is responsible for ensuring that we are out of IPS before any DCN
programming happens. Any DCN programming while we're in IPS leads to
undefined behavior (mostly hangs).

Because IPS intersects with all display features, the ability to disable
IPS by default while ironing out the known issues is desired. However,
disabing it completely will cause important features such as s0ix entry
to fail.

Therefore, more granular IPS debug flags are desired.

[How]

Extend the dc debug mask bits to include the available list of IPS
debug flags.

All the flags should work as documented, with the exception of
IPS_DISABLE_DYNAMIC. It requires dm changes which will be done in
later changes.

v2: enable docs and fix docstring format

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 Documentation/gpu/amdgpu/driver-core.rst      |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
 drivers/gpu/drm/amd/include/amd_shared.h      | 75 ++++++++++++++++++-
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 467e6843aef63..32723a925377e 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -179,4 +179,4 @@ IP Blocks
    :doc: IP Blocks
 
 .. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
-   :identifiers: amd_ip_block_type amd_ip_funcs
+   :identifiers: amd_ip_block_type amd_ip_funcs DC_DEBUG_MASK
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dd8353283bda3..a18ecf8607232 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1864,6 +1864,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
 		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
+	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS_DYNAMIC)
+		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
+	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
+		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
+		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 	else
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f5b725f10a7ce..745fd052840dc 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -61,7 +61,7 @@ enum amd_apu_flags {
 * acquires the list of IP blocks for the GPU in use on initialization.
 * It can then operate on this list to perform standard driver operations
 * such as: init, fini, suspend, resume, etc.
-* 
+*
 *
 * IP block implementations are named using the following convention:
 * <functionality>_v<version> (E.g.: gfx_v6_0).
@@ -251,19 +251,92 @@ enum DC_FEATURE_MASK {
 	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
+/**
+ * enum DC_DEBUG_MASK - Bits that are useful for debugging the Display Core IP
+ */
 enum DC_DEBUG_MASK {
+	/**
+	 * @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting
+	 */
 	DC_DISABLE_PIPE_SPLIT = 0x1,
+
+	/**
+	 * @DC_DISABLE_STUTTER: If set, disable memory stutter mode
+	 */
 	DC_DISABLE_STUTTER = 0x2,
+
+	/**
+	 * @DC_DISABLE_DSC: If set, disable display stream compression
+	 */
 	DC_DISABLE_DSC = 0x4,
+
+	/**
+	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
+	 */
 	DC_DISABLE_CLOCK_GATING = 0x8,
+
+	/**
+	 * @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU
+	 */
 	DC_DISABLE_PSR = 0x10,
+
+	/**
+	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
+	 * if mclk switch in vblank is possible
+	 */
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
+
+	/**
+	 * @DC_DISABLE_MPO: If set, disable multi-plane offloading
+	 */
 	DC_DISABLE_MPO = 0x40,
+
+	/**
+	 * @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA
+	 */
 	DC_ENABLE_DPIA_TRACE = 0x80,
+
+	/**
+	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
+	 * does not default to it.
+	 */
 	DC_ENABLE_DML2 = 0x100,
+
+	/**
+	 * @DC_DISABLE_PSR_SU: If set, disable PSR SU
+	 */
 	DC_DISABLE_PSR_SU = 0x200,
+
+	/**
+	 * @DC_DISABLE_REPLAY: If set, disable Panel Replay
+	 */
 	DC_DISABLE_REPLAY = 0x400,
+
+	/**
+	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
+	 * If more than one IPS debug bit is set, the lowest bit takes
+	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
+	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
+	 * precedence.
+	 */
 	DC_DISABLE_IPS = 0x800,
+
+	/**
+	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
+	 * *except* when driver goes into suspend.
+	 */
+	DC_DISABLE_IPS_DYNAMIC = 0x1000,
+
+	/**
+	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
+	 * there is an enabled display. Otherwise, enable all IPS.
+	 */
+	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
+
+	/**
+	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
+	 */
+	DC_FORCE_IPS_ENABLE = 0x4000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.46.0

