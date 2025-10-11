Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5933CCCD185
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 00:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2C610E2A4;
	Sat, 11 Oct 2025 00:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AM0NgeR6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB97D10E1E7
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 00:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7G1LqSU7lKMvk1QhWgT3EzDRxTEmDcWPJPV0LXE1cKlOh0q9itK9EqNwtld+Lv7Lxpt0TLC+vS+A3nHAq7M8OoO58NLLTGMir/RR3J89j2BDFpmSdSmE+eY2I5qAiGf0cPBkIPxAinfMkKVwa1v1OWUEIaXzFv8xni+xp8ZREVKLvOGGY5S3jopr7KOSRmxeB84cYWRL+vm/a4mMYohzULh2XmIpN3TAr0HJ7wcT+GbdNgVNgsR7Rb/T7rUTkS6O0CcKgulQWgo7UYNy6F6/x1RyZSLF0Kwch38iKdva0Zet5ZXyhVGmsiKS/WDb4dK4aPwxkMyPJCbctyCgMpReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdpYJueF7IfR2eBR/4TbFm0O1CUnZCXbhgqwl2/tq5U=;
 b=Xi/6qXvvnBu6deUvyHNA3NT1XPcdvY89SDJiVdMAfnT/RCbvarbs4vDN7AtSIekWulHyr85TC5MTs0fupTZG5KRCmrLofaST6dWN8Gg747S+BGTk4jnpC+gXzvforeU91tgsUq+CdzDBG1M9AQcMZC3oilT8RWY7jDKBf5RMNQeMd8IMJ1EO7ia+x7tvsRKj/3yyiYQ+KtmNhSW4CbOnweAnlWTTo+S8Vr6QM9pBb1p+YUwdLD+wqyaL4fzFNG6WkeJFxsKQIIzxi5OWHqGbtcK6XgqJJbX2RpA9puShEMBf5grxdEI99kEFZSG0zbDZGDBxSXBlNGZM8Vsh42zn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdpYJueF7IfR2eBR/4TbFm0O1CUnZCXbhgqwl2/tq5U=;
 b=AM0NgeR6mCn40JMJAgu2trJzvqIX0mFSMjr7ZmUkJ3yCPa0DEwfJrrwPr6ZZ1ZZvlxlGq1DHyZgI1VxrKlfEW6pc6XtmGsoGusflNHYz4wmTm+EAmLpYQaDM99GqzMbhE4wynDB4ZQ3qa0gU50qBwcMeDpoVu1KwGvMonPRLDug=
Received: from SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::9)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 00:37:37 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::b5) by SA1P222CA0121.outlook.office365.com
 (2603:10b6:806:3c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 00:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 00:37:37 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 17:37:35 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Peyton.Lee@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v2] drm/amd: Check that VPE has reached DPM0 in idle handler
Date: Fri, 10 Oct 2025 19:37:22 -0500
Message-ID: <20251011003723.209074-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: de32d071-e3ee-45e8-6668-08de085e6077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ysb4dgbgcIRyLDhcYLl1/CDCGjBhYENc7hi8+S+UxDmcaDcihTkytggcnLYz?=
 =?us-ascii?Q?Dcaled3kI+UP65KaJMOIdchFyPEMV+txqq0wkylB9KQs8jvQvdn174q+fNA7?=
 =?us-ascii?Q?0bN+eStDq4AHkMDwqGnHFZhqzUHgfSKTw8BfqAISSG+HdobIASTMGJoS+WmS?=
 =?us-ascii?Q?HhLPbPUwKiQikhXrJbKUZUQJaWJMrpNjjh5tvjJjjKTgs4VN0rmPTMLHL1NM?=
 =?us-ascii?Q?LFZuus4fZLN4+y40ojYtxjpFaGxIuxmFHXBxLDRKWZaJAtU7VaqYoM1NxBXv?=
 =?us-ascii?Q?2VQQH9ITFfCsxb7Ix56AxjI53dw7EdTlPIXKusDounudhLuDVQ4dnoMWISpK?=
 =?us-ascii?Q?0QwGsEZ8K4r0SdHfno+y+5w+tuIMK8NTHXtFUiOIGsrekF/P4yPqn+g6BbcV?=
 =?us-ascii?Q?Zz/b5Kaf5f9dPdfW+NsXAbzfNkpATKoTfWv90NTbo6Fh3jDlQjx+1oUT7meC?=
 =?us-ascii?Q?6idcmyekI50xo0MHNiX2Ve0QCfnoom0fAiy24o5emqTe9LNEuwCzIVexymN0?=
 =?us-ascii?Q?5S8nqiYGiguNf167uHiNvl320Vw4DnLbaalucfvidzGiuUEVRIEa8nuIkzac?=
 =?us-ascii?Q?dOKDp5s5cBrCZG1+Cy8SnmhrHEnpahzM/Mnl9FNbe1bTRG5Q8JyjZOK8o972?=
 =?us-ascii?Q?Za2OKx6v8WFkxBunkKHTcVZ7aVC2YCd+vc0oY05KB6W9IvmyjdIKS4IqiYpy?=
 =?us-ascii?Q?uHmYLP7neaszQZi12eVGlcqe13AWm97SxETc3HBXLdUUOlXSivYZ3gE3oWl2?=
 =?us-ascii?Q?WmqEi8/2Ha+kFpotHFlO3Omizm8XURiCnYweJUZ1rKtM9LxClB1zz6p5EuGm?=
 =?us-ascii?Q?t6VcwPfRv4kiBex3LCrN9GXGhUkx4cUfLZUDmDXWcq2u87yJ+zXDL6PfvodS?=
 =?us-ascii?Q?IV3QLkQh4dchIv/d7NejGzFEmGA7qCE7tEcPDcaS6D8h88aI1+mgtlCCPinq?=
 =?us-ascii?Q?LUx0ehQmnpyNjOqJYLQhkMBSzXxWXthcy/Eaiqd/077DDFPQUJMBZQeNOX1l?=
 =?us-ascii?Q?Ly1NULaVb0AfqAbM28w7dyAqPjhXGP9OwxEDtitzmfuUNptrGmAhqBieMKrF?=
 =?us-ascii?Q?KGp2CFnaabv9PsQetEWuTULbEZ8ApzGhuMKDw22HJCbz57AAcCuFqpA8ld8e?=
 =?us-ascii?Q?MQqrq+8L7yPI3GnT6ZXPREZebhW9ntQ1nohvINYHTpKt4WAYzORvV3C/9skN?=
 =?us-ascii?Q?/yC/S4CqZmDMFGovkaeGga89sAEa8KvMoba6YdooJeqnfxSp/7bI+8hz9zSy?=
 =?us-ascii?Q?zHttH6zB7w32T3DyQwH6RRSd++OJkbgKMrhjdkjorPUcK6Ts0Qa778OifB6w?=
 =?us-ascii?Q?dtwhLVGyA487dkL17cRopdD1+5EFZ3FDTd7vcp0yRqozeRrSq7lFjHWOl4pk?=
 =?us-ascii?Q?JbPVuVlCoczpV/wOUx5QJSk1cef55JUuy3Swcx4Olsdsl04WKSYo+GVoti5X?=
 =?us-ascii?Q?b7D7bNJuC3W4IItbVGe+/J0g2X7uyti9txznWOtAuylTfV0CXG13JQm6h77T?=
 =?us-ascii?Q?3cAlZqyIJutCx2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 00:37:37.0956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de32d071-e3ee-45e8-6668-08de085e6077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

[Why]
Newer VPE microcode has functionality that will decrease DPM level
only when a workload has run for 2 or more seconds.  If VPE is turned
off before this DPM decrease, the SOC can get stuck with a higher
DPM level.

This can happen from amdgpu's ring buffer test because it's a short
quick workload for VPE and VPE is turned off after 1s.

[How]
In idle handler besides checking fences are drained check that VPE DPM
level is really is at DPM0. If not, schedule delayed work again until
it is.

Cc: Peyton.Lee@amd.com
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Drop unnecessary spurious dpm_level variable
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 474bfe36c0c2..9065d799c2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -326,11 +326,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, vpe.idle_work.work);
+	struct amdgpu_vpe *vpe = &adev->vpe;
 	unsigned int fences = 0;
+	uint32_t dpm_level;
 
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
-	if (fences == 0)
+	dpm_level = adev->pm.dpm_enabled ?
+		    RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv)) : 0;
+
+	if (fences == 0 && dpm_level == 0)
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
-- 
2.51.0

