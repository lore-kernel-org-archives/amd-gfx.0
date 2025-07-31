Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E42C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 07:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B3A10E709;
	Thu, 31 Jul 2025 07:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OSkLhOoL";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244AC10E709
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 07:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2r7RRzHHYCwl4xyJO5yVZI/4LwzmxZ6i2goAyUm0/hW9wv9rRZrpO6dbWmRsxvryOPM1byZfCkodFyMofY1WUMotrcIfG1VJrjSH3O+eJhm8Rav05tKNOEunDY1K5Wh5sI8v6fyuG5zr/b+43KOwbArKCnzbB0S/5ZhSfWWSJHBjcC4+tGbGkl89Zf3cq64N5jV2o+yvGoAkLnPaNYcj7hmM9zwBxcyfNwPNzUaR8nTZnc9DVxKh6MofxsNXga6HQOZsFYvB0y/Xy/5mDuaWLr3x5xC9S7i4KvSC/C9dXpAeFcE0LoqvrPswa5HhT7+Un8xTYGy+l05x4JYf7no7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYxSXl0mr7Fma/3Xt8XRkywxO8UHf1AKGHrvD23UWP4=;
 b=mfR90vYQUriWFS2f8Tk8KSE+e2/I1z5mC3MJ1DdNZfuHOOisrhB3URYjww8L4oLoBa/g9t8hwcN2SNOJOKnhCDvkHcOaHKtgwp9JB5dIQrbAocy4tw0//DYtOWmekrOyx5Uistkc1c60CjxZ9u24vf7M0Tg9BGXa3C+I80nWPZS6A/ONWEgYrM8F1ABVgvOOAz4fUudiFnzV6TK+j+L0Jm3CNIsxiPKBzoxvHMur7c5aqVw0mUQ1lCIo+jjoN12UwTRHmj9bYbFezV4UWGGeHeNZX4XB+kF7u8zCyoEuGEMn8xvj8u8y1Gpjog3MPKm8ynCiCONgZSEFSfrzwuQ8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYxSXl0mr7Fma/3Xt8XRkywxO8UHf1AKGHrvD23UWP4=;
 b=OSkLhOoL/bd0iKY59v8tIsCBH3iufxDzzuYRvAwgjUu2fiCLgcclpGb3vnI3kTI7yaaFFdtR84kFHRrgMj1OEe6d+oWQE1cwojQPaB7/KPi9ltlfIAHIjMOp1DMBNFcCG8POcGt1ohB1l7A/WdXUyia1L33rtVige/MM5tLNGx8=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 07:18:56 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a4) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 31 Jul 2025 07:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 07:18:56 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 02:18:53 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Stanley.Yang@amd.com>, Xiang Liu
 <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix jpeg v4.0.3 poison irq call trace on
 sriov guest
Date: Thu, 31 Jul 2025 15:18:36 +0800
Message-ID: <20250731071837.77141-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc41531-0cea-4621-7571-08ddd0028310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E61KUpja58+idYXXKlcHOzeqOYMpggKhYaiDyRH/r4/7EoE0EywNvehheH11?=
 =?us-ascii?Q?AvteqWjfhjsuJkJoJd+1wmURf8I3TRBSxyb39QdLGqTNVETrWUL8b0xfgZLK?=
 =?us-ascii?Q?Zm9A2ewXNV0mUxYu8z7t0teoF58GGoqCY59YbneNLmVLT7wmM88Xq0ETTR5z?=
 =?us-ascii?Q?gHArBvIiM5R4FQeNXkm3JObyrRSyT+KrGLIXTdigRh8ItS9IxXRUikB+KXGj?=
 =?us-ascii?Q?yaXS7/qqnkwX8w44o7PUz2sZctJgWUT76YkeSon64bnCSdpLZvmmGPvTWFVi?=
 =?us-ascii?Q?uBUyO3gR5u5k8tIxZz32MRM1k4dwk5rZF0t3TMJmLgm5syd3acxkk08J7X4M?=
 =?us-ascii?Q?cU610fejbT6MdSZAngF80YczA60RlLapaW9UiI0MaKm8yOugYoS1vvLqCC+V?=
 =?us-ascii?Q?+KE4f0Y66xqpPtf62Jw4l0NxpB3S+4WbFre1Clrv6d/UltC+Xy4G/T5a3Af+?=
 =?us-ascii?Q?ebEx+yIPUNG9AfHGrYNw68eNq9vtk3MGxtQ0KfpKO5MZYBHXnaXKaBPko9jJ?=
 =?us-ascii?Q?FxU9PgksnvVdFjeZG/aMv7VGqIeQKb1POe0EqjIq41Pb8TCuJc2JlP5KPhFP?=
 =?us-ascii?Q?QnDtGyE3e1U79+wug4QFWE5zBghkOcLAVYIZyKdVku12K7PI4KpaxP8kqDmJ?=
 =?us-ascii?Q?sloKlq17JWo+YjvXsyFnHUunkAY8GjZVnEzKqD47AGHdf0bugaCDcZJUUPaE?=
 =?us-ascii?Q?STpHQdcX74gEEG8XHUA8FWuYOvRxJyWAt2IZFV7vyWZE1mRmDR5M1bWh/qQD?=
 =?us-ascii?Q?Z1H0F0leRtE1wI/6nEKH/wZUSdAuYU93DJg2jA9ErzBeYc40tyM8nqYafwUt?=
 =?us-ascii?Q?W0BwvDgPcpYeKXyzT9M1MM1BUwZ0w5yOlQheZLNNrtiv/KviJWc/2qKaDZ2r?=
 =?us-ascii?Q?PGju7s52GUvpcYApBYlpNiHnZ89AYf/2SbPKPA32/wlGoEG5sYTgasxy5eHB?=
 =?us-ascii?Q?BL8/Q+uAsl22pXIESN0UVHc6EKalVTqwsD1OmjqRVdFDSvqwButfIlio+QFV?=
 =?us-ascii?Q?qMhWSCNxlgwZF5cXUvHDT6VtiVd8zDTVrUd6U34jgnVkC1riwNvKNBBpQU/s?=
 =?us-ascii?Q?1WRD1dZXHBz4/k/bPaPPIdBYX83S4nBMiTeWJWh0+qw3EZuTtjL4w64M0NDs?=
 =?us-ascii?Q?ly3EZWY7NX6zD6r6Zbihw23nxooYvPTDp2G+y7hheRCf5RPf7CT4B9ums4sa?=
 =?us-ascii?Q?GrV7XDVnLlk7nDFktjlwdo3NmmcgG1Y8cGHWJMrJZslNRC1Jx57I4GV0C7p3?=
 =?us-ascii?Q?jmkiE8HktpNJFXkKPQmo1j7m84f1pkONVOsmG5svIAIrGojEyGYjFwm292EP?=
 =?us-ascii?Q?ozZ/idmUfpZSvesADjeMUqdpzLCdVdmF3bh8fM+WJ9Aa4/JuP2GYJcGs6yMY?=
 =?us-ascii?Q?KCbglJ+YyBfceriVB9WtyfhIY/6d6JxY2kLEoHSVpTu3v5jQAJGnVivPJb5w?=
 =?us-ascii?Q?Lqt6ytRAgHcENqsDSR3/OvYFv90qSvMnJvjaRopO4IVlAKWi0KdF/1XgzDev?=
 =?us-ascii?Q?klD81FDSTfiv6opaIEK1d0vbaW40ErTdqSBE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:18:56.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc41531-0cea-4621-7571-08ddd0028310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

Sriov guest side doesn't init ras feature hence the poison irq shouldn't
be put during hw fini.

Fixes: 810a6a2de64d ("drm/amdgpu: Register aqua vanjaram jpeg poison irq")

[25209.467154] Call Trace:
[25209.467156]  <TASK>
[25209.467158]  ? srso_alias_return_thunk+0x5/0x7f
[25209.467162]  ? show_trace_log_lvl+0x28e/0x2ea
[25209.467166]  ? show_trace_log_lvl+0x28e/0x2ea
[25209.467171]  ? jpeg_v4_0_3_hw_fini+0x6f/0x90 [amdgpu]
[25209.467300]  ? show_regs.part.0+0x23/0x29
[25209.467303]  ? show_regs.cold+0x8/0xd
[25209.467304]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.467403]  ? __warn+0x8c/0x100
[25209.467407]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.467503]  ? report_bug+0xa4/0xd0
[25209.467508]  ? handle_bug+0x39/0x90
[25209.467511]  ? exc_invalid_op+0x19/0x70
[25209.467513]  ? asm_exc_invalid_op+0x1b/0x20
[25209.467518]  ? amdgpu_irq_put+0x9e/0xc0 [amdgpu]
[25209.467613]  ? amdgpu_irq_put+0x5f/0xc0 [amdgpu]
[25209.467709]  jpeg_v4_0_3_hw_fini+0x6f/0x90 [amdgpu]
[25209.467805]  amdgpu_ip_block_hw_fini+0x34/0x61 [amdgpu]
[25209.467971]  amdgpu_device_fini_hw+0x3b3/0x467 [amdgpu]

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b86288a69e7b..a78144773fab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -444,7 +444,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 			ret = jpeg_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG) && !amdgpu_sriov_vf(adev))
 		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
 
 	return ret;
-- 
2.34.1

