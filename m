Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F56C36004
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F303210E56A;
	Wed, 19 Mar 2025 17:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYbVIEij";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D12F10E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxSLNqOk6VHO0dvRDIYq53W26WUzDMbx0vM//4s7l8j7TMcxTy9GVW4//pWcrO1TVPzpg4P5ZocaTJs04cr+Svt9QXDiYciYG07TqofCe9I8K3krSQEhV82k2GY5mgEkAdOZsY0g3FGEtLtRMPx8TuhZ2EZff47t2N3diVTfQrmiiXFYHAoAQHPmBRcjxD7KvfAi/k6NbcWdCZgrAlUipkUlf32jpctuiooOLfHwi9SUKCH0U8hdBDmuho+B6Yk/Sp6/5wK4cc8pn8zAdr3XnznF0vgRAakn49d05lnSgiWn6tjGsHlwqZw6t2XQ+c7eHJuFvFUUPvymrKoVWpEIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZufLZZtBLozIDVMvXT85g5hSop7gRHNCex/v2P3+fs=;
 b=OoKVKqgQmokcvWf2iqek9L9ZeB8GC7n/5h+nZi1rvjw6ZSgoz7hn4BEGSMJm5ahuVLpjdzBDA50rVm72/XPjaVRrzfX8ER+pUodcw8Ot4MNkwUS5+QceVJwkgqLnoX+sS7mW9nVoQdb88nhbuzqsPknv5Kpq6omu2M7q7GuglxAAVDViTNnAaMrO9Htu2Uv8LbHV2Eq08N/hHj9qGLK6TcFh3/ig0mNvzGhz5JYd5nmGp4p793qG/IiDUuqeuoGCIWslIgJGNXKo6illso9tbMBTpnDkNYH11qKNJe8wfPGRT6uo4yIadYyWJ0KLif6K1OaxeNdA3aMtsBpSamWAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZufLZZtBLozIDVMvXT85g5hSop7gRHNCex/v2P3+fs=;
 b=gYbVIEij2dWBbn5ouYtSo0HZh7yKGeIQ947dgl69zZsAI/UMkMEMIS0foVsV7tSFUchsbnzbwdVWHRbVtfQCRTE1PVrZPR9+f1Xl2FP0t+WZ9PkZatk6hANVtTXXxgkdFMdgHoaKMmS1OG8/ZBDxuFGuS6o3k7FUOHzOCN3z3xI=
Received: from CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:57:26 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::b9) by CH0PR04CA0015.outlook.office365.com
 (2603:10b6:610:76::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 17:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:25 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Actually do immediate vblank disable
Date: Wed, 19 Mar 2025 13:55:14 -0400
Message-ID: <20250319175718.2578234-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc308e7-8eb2-4ecf-f032-08dd670f8250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6tHBd3Bo9tKCHI+gqPAydx4WdXdO2NVmX1dlUiXn/QgDyI/DZxdh1tFoNsBU?=
 =?us-ascii?Q?7VC6HGeaLPzIWmtTUP1y+GecEPayPHthXDhHhk+doNwj9sltEbONyIgefFdt?=
 =?us-ascii?Q?5vU0nXW5PIzYU/o9tDnc82XZoxMyS8TC5K861PeaMOOshxIwbyCjLAsfGyEu?=
 =?us-ascii?Q?T+hjX/etaJFbIsFvn8yWppEZtxYoJSfhBLh+givwm6iEm60Zw5U9TtMQUadm?=
 =?us-ascii?Q?neLpK6Btm7chSnIqFM8nl8wNL+K4VfK+XF5ENwNjQWUvNDKCZ6wAD1enYd2J?=
 =?us-ascii?Q?aaC+LEYonlqoJJboOx7QWU5wl1URBPnB69ERWcsuOdMQtZBEtaj3a4e2nB83?=
 =?us-ascii?Q?gyLX1It2ODiEnHo67AYRC1ebAh7xkU8L430LjvqtFniZ5H5UhY/2QSoZq0WS?=
 =?us-ascii?Q?/6E77JFTE7B8O8OAhoH79BAnO49MGx8Ep7xym90rGmexzDLAvRe9ZL/rIFnt?=
 =?us-ascii?Q?GFWac1CDbGG22k6EUAIqOlvlmRsTdzJIk1FZQNmgagVGHCTgPrN2AlB1SCqC?=
 =?us-ascii?Q?J6r2mMH0g+0bg/gHmGW/7Z3KuePntxruE7+mtCI0XfdVZIEcFMdGygcLU6sD?=
 =?us-ascii?Q?FhCqQ5lBBiesansSRX5euScdcIRzpbm+4T99br4JsQBWep5/p2dUqJRFdowX?=
 =?us-ascii?Q?Vvw6uRpG+R/jKZq5DziQCD0vXvzLiPkcC6usvQSZ9kDWcxJmN0uJEdOzHbWi?=
 =?us-ascii?Q?K2RJrlINmoiQLhKtdwjsk6X0uk4oKWca+sgFxX/l10xQr0yhtPJ21leV7e98?=
 =?us-ascii?Q?sqt+aUhUcpw+4Z6XzX9L+wZpoOXTthSdtmdTII0DR6o3S/DRqT3xcLxd1tql?=
 =?us-ascii?Q?DliMgGormW0QhZPQsRihy0j6xPffOrG/OKY8kTeE6d5Z+wvhMXWxShztXVjc?=
 =?us-ascii?Q?OkmLAeK64L1kGS5KW1g1Pjw4AKqDUK6SXTam6k0xhdwtrrcZEGusRQoXWH8F?=
 =?us-ascii?Q?u8aLoZfsK+HOVpUe7OoMcepguXK3J6VKL7pg8ljxOzEnXA1IngMRIOF/chV4?=
 =?us-ascii?Q?GUVGnpEI+dBZFEUM5wLvwvHiqDvqFR59HoaMiAx+mhxc6N1SqLTh7bOs8r34?=
 =?us-ascii?Q?7mHe8STuVgLr21VmcpU4eQqr6zolqVhsuSt/nBFHuh8hQ04u7wRqpOm/knzn?=
 =?us-ascii?Q?3uE6OoxBShlLAUBphNb5SAXa/lvV0HdwiJQs9mhzEvmS0zh1O/LStjNSydEj?=
 =?us-ascii?Q?l/EX7V3EfooI08fpMCqOQMrMMn6GrIvb43FIDizO0UBtNPfoMvZjtGzjkwOa?=
 =?us-ascii?Q?p3Xb+RK7/kY26t1jhKLhrBUWy9+hKlvaTFlvcexLsW7ActhHjFHTS54PZMyn?=
 =?us-ascii?Q?YHFPM+Jr4AAHXwldCVfSMoSfSctOwaUAZUoUVojB38BsnRt6dW4OxrOZT4Gf?=
 =?us-ascii?Q?1MHWHekjNX4BvzkhQzMW4xf8TuN8di8YI0oqQjOtzZJdwnb1DIks7V6OTRcb?=
 =?us-ascii?Q?q/g+uHcrq+k4Bpk8P5xP/DPbXvH5ZUNjrVBDexZQJlsD6F2+qjAcAYmY45+H?=
 =?us-ascii?Q?LqBqH66HwySmhE4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:26.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc308e7-8eb2-4ecf-f032-08dd670f8250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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

The `vblank_config.offdelay` field follows the same semantics as the
`drm_vblank_offdelay` parameter. Setting it to 0 will never disable
vblank.

[How]

Set `offdelay` to a positive number.

Fixes: e45b6716de4b ("drm/amd/display: use a more lax vblank enable policy for DCN35+")

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 684f131e5c4e..469d0039a54f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8733,6 +8733,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 
 			config.offdelay_ms = offdelay ?: 30;
 		} else {
+			/* offdelay_ms = 0 will never disable vblank */
+			config.offdelay_ms = 1;
 			config.disable_immediate = true;
 		}
 
-- 
2.49.0

