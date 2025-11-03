Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB58CCF9FE
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 04:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CCC10E317;
	Mon,  3 Nov 2025 04:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0PoAimji";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773D410E317
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 04:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt4DMULuqMGmYh+oegvoMAfIBA0O/nNzMK0lnLHxGf2ByzT7w6MxIf4SCQTD9QQa6Lx7ehOP7o2qKSQjeMRTaSaQXqR9xO+mDQIGa94yXWZO49Nqu7iG9RfMPd+Ed0MRyqJ+edjTJs1lIj/FYnKLLSG/mHEgo7nPa0ixhajIAPykgo1kMYkRSjwUY/W7Ohh2w1EFD2L8vWhCCZgqgBumkU/FFOnqgUXDIZK7PbgRBnz2c5aseoto+SJOx8diKw53AEHz+nUT9Y43Suj/xrZOhK1alR//nvmlgAEoF6D30/0xDM0mf1U1Dh6S9cqRawASUqg6aYLhDYJaKMPX0z9COQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EL/tPXwMkDCmVQMYUEJ63evZ1nEYGWN9V8NLEyemz0=;
 b=jnpuXlPrrFBjeNIDazW/wAYNlybIJ8F89eE1EO7Wu1J7TpY+OgRxqNaJlAqADznON8TUX6rMo67zGD+cLxB0zVfWzinmQUEB8OIsfKSlVun7T+MhByeB52keqstr50lRcA7nU6SsnX9ghoO12t/dVEvR1VU+1UgyjAGKIdYDQ9bu54TKTajRTAcTG2txPGG7R1di3QeaB+rCD8uY/HJ8k9XhUJitXMj2cZEEnHZuwiKnAt3LQBRTH2PRQAfNQM9Pn7XWCFUIUZFunmLYOhWAOMrxdTRiRbGYCZATunLyKfJowVoW4Ub4qWpgJ+Je9zaKh/WyJ7CcxKhMOAZcYC8Www==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EL/tPXwMkDCmVQMYUEJ63evZ1nEYGWN9V8NLEyemz0=;
 b=0PoAimjiFHNygzocCN2BAi36J76g8HuVO/wZIwXKhCcOIZnJaTebGye1cXGt8sYGyNfG/C2v5hcj4nEY4ZI08RczM6AHKS+ozRE94/XpSKy6fuX8lcqv/QHeH1/hpwOIQoNVjx0BpEqbcNcU2SqfbxHR4Et9gItqx5EW0Oe7avs=
Received: from CH2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:610:54::21)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 04:06:48 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::cd) by CH2PR11CA0011.outlook.office365.com
 (2603:10b6:610:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 04:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 04:06:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 2 Nov
 2025 20:06:47 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 2 Nov
 2025 20:06:47 -0800
Received: from banff-cyxtera-s81-2.ctr.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 2 Nov 2025 20:06:47 -0800
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <lijo.lazar@amd.com>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <Qing.Ma@amd.com>,
 <Owen.Zhang2@amd.com>, <amd-gfx@lists.freedesktop.org>, Samuel Zhang
 <guoqing.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix gpu page fault after hibernation on PF
 passthrough
Date: Mon, 3 Nov 2025 04:05:58 +0000
Message-ID: <20251103040558.1547518-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 07913019-8b04-4581-7a3c-08de1a8e6915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QjBQrycrujFjgPm1p7hTTXq+2EYHSrb+QVxIczg0dkOWLQbO0v2nv3Zn42nD?=
 =?us-ascii?Q?YTRyZJUA0YYpzyiCzYcIJwCy9PG+rA8uiuC/O3/6crooWo1KjAcS/dM+J9hm?=
 =?us-ascii?Q?ztPVfPYvBNOvAF1iAaXL/wmQloBvwP5I3lMXKKU44rIhEtSC8N+37wKpYB9W?=
 =?us-ascii?Q?wCQWU9m9o78lBQcUw4g0GsIG4+6ChX77PF61dHzjp9h/l0Ar0yE9Eigma/ss?=
 =?us-ascii?Q?VLm3OlmIXIZBXZBOO9Hj3MxTK/kAr6u5Sq77w7XU6CzBk+KVKBk830GlngRV?=
 =?us-ascii?Q?N2obMAA3DbJFCVYruCKwZeDh/WqItLIs94ba5Rk2/abTQaw6gX/BMcEj7ckp?=
 =?us-ascii?Q?glgE/RM3h4l5CdDDIBjsjOmyyXM2P8B6tY1X+4I85sH0z2zU7Jq5LkXMdOGR?=
 =?us-ascii?Q?/Q9R6ZdhuTGhkLOaEB6sI1QlVhZb60evhqYckcQ//6WHLMtHlCV2fOZSauD8?=
 =?us-ascii?Q?O6d6KtkXPn0TlRg9CdzufkYCJmbm5G+wv0OR3+xehK02d3hJvDHgjjB2s+iC?=
 =?us-ascii?Q?mws5FkB9/XVMHuccAnSrc9kYV67E3vapzQ3a61q4En5yI9OQKfRZUEC/SR3Z?=
 =?us-ascii?Q?MCI9IVVWnRgFdo5hiRPcfHybY/9AjMr2OYEFgBWJHvdfSWpeGrcMaCQHeATy?=
 =?us-ascii?Q?InUs56/u0CaGJ7w+0ygj4NgBaL57UIQHRCDapm3E81gp7/6gVaEpHWTxd8mu?=
 =?us-ascii?Q?kxo5kqUlW93GzL7K2D6s0WcoV40CePCkxAPBBlDsIgWy1LDXh/DCTuFLj+Qw?=
 =?us-ascii?Q?XyB2iy+wXcvee10ZEXMXK8DBflQ3jHvsM6Z3qZW9zIYEdTWCb59ZZQKKswZd?=
 =?us-ascii?Q?GyChJqBmcFSHKGnM/xEqahHilyW9l1mF6Ot+nM6lY0qjOldxrX4mQ5gW3u4x?=
 =?us-ascii?Q?OI6aU3jzWcuQaPelOtmeu4sf7jJU9eJ39L1sHsPSSCQzcOKlwan59/r05Ej2?=
 =?us-ascii?Q?fNjXm0BIzLPgHUP6U/XyB66OUN7yLrjhfDnfgREDnboeBb8YOHeDVukAuuI1?=
 =?us-ascii?Q?vOpLjcQiW0MbSfGeobHIeIReBcFtb0E7IK7s3nsQnHwp4nvufAGm9b2lGQCc?=
 =?us-ascii?Q?ssRb1zegamN8JURM+2RF76yaSyjdg5S9iSPKvs1YbUif4whgcvagmv5/lyg2?=
 =?us-ascii?Q?42ZmV9bD8mB7s+yUzCLaI8ZtCHWEAHW1KUWV95w8NL2Jr8wdaf8JZrdAuzIM?=
 =?us-ascii?Q?5wBwOr2XqHqihsWVOd5IBZJrrhPWT1IJ+pMyg+ap5H5OWbugRT5pPKo+xCfC?=
 =?us-ascii?Q?zAXlRZpwNyAJLtUohHwp90vunZcWNw5WzZS8O3EexYrPhgids+ZyBTn/2clJ?=
 =?us-ascii?Q?WAnGExLCKon2BdCTuzGcHUZ3TIBkWEPVmY/m9hNbfm7T/jSdaWc9hfeC2rLP?=
 =?us-ascii?Q?9xjN59E8R/RMK3iSfcnF7/0RPvSWivbP5v97ckh81eVeV/IbleoQQtRlFzfo?=
 =?us-ascii?Q?ZbNUNruhz47R6nRzT4juniiD6E69QrpQmL3JrMjC44LtgU3vt7il8/M6r3Se?=
 =?us-ascii?Q?b+tFPx1O76tAlIfH/JVvivsTytFLdQGNDdHRa4avhTOnJMcjhoXTB6bdYo2I?=
 =?us-ascii?Q?wIgXcLY22XPFBHrL52k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 04:06:48.3348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07913019-8b04-4581-7a3c-08de1a8e6915
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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

On PF passthrough environment, after hibernate and then resume, coralgemm
will cause gpu page fault.

Mode1 reset happens during hibernate, but partition mode is not restored
on resume, register mmCP_HYP_XCP_CTL and mmCP_PSP_XCP_CTL is not right
after resume. When CP access the MQD BO, wrong stride size is used,
this will cause out of bound access on the MQD BO, resulting page fault.

The fix is to ensure gfx_v9_4_3_switch_compute_partition() is called
when resume from a hibernation.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 811124ff88a8..75357e8a35b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -407,7 +407,8 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		return -EINVAL;
 	}
 
-	if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
+	if (adev->kfd.init_complete && !amdgpu_in_reset(adev) &&
+		!adev->in_s4)
 		flags |= AMDGPU_XCP_OPS_KFD;
 
 	if (flags & AMDGPU_XCP_OPS_KFD) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c4c551ef6b87..a12c72213a79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2291,7 +2291,9 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
 
 	} else {
-		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+		if (adev->in_s4) /* Restore if resuming from suspend */
+			amdgpu_xcp_restore_partition_mode(adev->xcp_mgr);
+		else if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 						    AMDGPU_XCP_FL_NONE) ==
 		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
 			r = amdgpu_xcp_switch_partition_mode(
-- 
2.27.0

