Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD21C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EE810E8C8;
	Wed, 18 Jun 2025 15:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NQYfTWSt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3137B10E8D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiXhA3u9/ABLWJJz8+SnUtgCqmToxQ/QBLYKaO4ePH95NiciBr6iWrmsN/Y5fmvUs2rIusVMnxqAnDNUDtrCPeyvYgR/MxOc84sdgnnQYajPstRL3yuESX5PDKL5KHu9k1nq6y86seHvYz86nFY8uo3p+OtnUDuBU8OKN5GZbU8prFNE28jXPNuf8CvZNzZw8UHGmQF/qo1UcrUdgLkQLQuVkCoMhDukFgkH9HpbleyUoEQ0jSZgoaXR+pxdfT6mH0WPejqKkbjchl0dwdWdDDOnadBaLrPnvMeVaz1mDvX5bzeZ/VKkHWj67wGWAckx48xmWowAXePSawO7ckoLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8KcN1f3o0rNO8azvb/B+v8jsl/xr3qrgkY3rsvx6Lo=;
 b=ko0K9B6Tee1Uz6ShjX0eg5KiVF0xFuVIo06wQsndoZ/7mtylGhJJHhcM0s7mP1WyjqbuPl8dLYubj7JYWyv9toYXAHYNb7dlt0+LvNEgTvC1bmGpxGM6qkbMn4HR6m221XxDDzg3H6rXU+x+CwJGqgQEc3OanXMTXOb7tTW0lVlsmQgB6w3mgmUPqTeM2f+aTXayKxWyicyZ4hdkPDWWkv6lXz3rc1buUGGYLtVmQdqsWP7PHHuR13EmIYZMJP8vguttaJzrUQzfmuhJ3tSrIXF0x/+ED3FisZTbcIW3TxjwsJR6XcWiW1L56gTIbF+q1rdcEhCiR5W9tFDUTx3t8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8KcN1f3o0rNO8azvb/B+v8jsl/xr3qrgkY3rsvx6Lo=;
 b=NQYfTWStLvEcjfM7pydYkpu4GjVVjFW0RLIdCypLJa1qUsDlfQ9oO4eRvvgRngJKwZr/9fxBw1/XkvhixziknMw3PYROS3Yfaaxg+CXE2ImJojdAtWK4y9njxd01JWHr++pPXaOcSbHXZ1NhljBsWM8RDtdxJPNfqaLpSrFi2Fo=
Received: from BLAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:32d::10)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 15:55:15 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::a2) by BLAPR03CA0035.outlook.office365.com
 (2603:10b6:208:32d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Wed,
 18 Jun 2025 15:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:02 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:55:02 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Promote DAL to 3.2.339
Date: Wed, 18 Jun 2025 11:34:01 -0400
Message-ID: <20250618153936.6472-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 0731b409-33a5-4437-c504-08ddae808415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9n7vKjK2VS8PA2RS1vKbS4q9+vH3m5LxPnBuZw+17bhmVwuexWHFeJX/QeF?=
 =?us-ascii?Q?3ymP02SMsX7f0na/o1ifRBv4dz1dYYfulYSA9H8JMfj6ZBqA9R4nKibI5jJB?=
 =?us-ascii?Q?h0fHl9N0+YBU3MsT79WBg8s0RcZuKET31XJcLSkNfICSRvWweIh0IT3tETrw?=
 =?us-ascii?Q?Ky44tTIRLRUo1O0K3KrzCM6gAebkUETTDz2Txg9RlgZg1Cmbdkp5uDv/LWmS?=
 =?us-ascii?Q?HfnDJMFeI3jgE64nNRRNhE/idbijj9R8ur2dXKukywQBTmhrRebXw26gMuFu?=
 =?us-ascii?Q?aHvhf0Y8Ibfb3UCEgiUWskNL0d5RALCrFHqBT+iOLLfHnShCEwT1Z5/1Dcbj?=
 =?us-ascii?Q?gojm2fYi+curwjDdWofShp6KouNtEheaYVwtzR64tgJf9n2d1jfuX1YkJP2K?=
 =?us-ascii?Q?QBXDJu76DR0aOGXbXFlddIxGcJoUTBr6hHKjwA4MQnv890gGQwzKs9txKjda?=
 =?us-ascii?Q?2lx4r/Q0QaBF0ErSuHEaneqefO88zvNgneiMKbalehc3fkreFXAiTKwP+6ue?=
 =?us-ascii?Q?6M3/Y12R+Dx+UESwBOxLImXeF9A+eFNiHfpDJU4aFCNaV6hKpk+lWPuZMyrM?=
 =?us-ascii?Q?u5EpglMuDp0VGZZa1oYeurDw8XA2lKGUIF+yr/XTifJgTB+5yRHaaqpW1FHE?=
 =?us-ascii?Q?9tY3Tu0KOVQJTackOC5AdIyA6qHwKLp6V3wLC/GeGbt4+LsowCmHeXSEmkWv?=
 =?us-ascii?Q?TIymo+dcQyIRA4lxeKcsLAlgSWiComgI8Ckis2LgJWNeK1uQukeWZt7VJ+PL?=
 =?us-ascii?Q?i7GMoXdewtZssvyaL1moovbju/D2AlD1q+lz37gxq3/vjm/38VmFUp0vvisG?=
 =?us-ascii?Q?xoe4BIQ0uVQ7PW5i4aG1ssIcn4Cnv/DdDSzsG83WUaurfwpQWn81g0Qcz4hr?=
 =?us-ascii?Q?EON1dn2ttp4BtFxAYt360fvN+yDMmAL8Lw1wXrWErppOkaCwK3Nr8CigcrX+?=
 =?us-ascii?Q?6G+n5Clv+4A6O7q1WiHUlj3Y0jfts4gG/mXgVHAgY5G6cM/Vx72fp74tP5Mf?=
 =?us-ascii?Q?uZBHCY1DnCk1gGYpIFeBv9iTJdHBHrY38CQRNiQ9rTUuHQntU0xvg1ujKgoL?=
 =?us-ascii?Q?KPruH5Tm5fEXTauoLF9ktgLZmahhx+j99VL8ih07JgjuaW+acM9BdNkpiILI?=
 =?us-ascii?Q?Ey0wxfzKzvOSLFRFBO5EBdCEKp4RzlEMkBMSo0UlNu/8XfsZ+wuNOuuAQCqQ?=
 =?us-ascii?Q?fT+B8aapmSkdTVx2JWc+KQcXhGre7rJrSqNbdDibMmxgqARPY3l6wiRN46Xo?=
 =?us-ascii?Q?JHqkDn9GTXTA1QM+IMzmsvH1JV3TOflIZFALGZMhX4OjMXQTQtdI7vID0Y/F?=
 =?us-ascii?Q?tDEMVEjcujkGIxCy9FWodcXzmsk4f7hgaRPijEHB+DNmKQBxo3VKkkdIpXzv?=
 =?us-ascii?Q?i6v1drJ+sTPekL/dwSFIDO9XQL1r2nzwdFoXRV4d5He9f5EshhdaeBWGfGqO?=
 =?us-ascii?Q?kWwBjNC1ZwNTJgczztJJHvFoWNTj2AgM4DV4A2Tc4/a3tHyvZD4O8IhL0sDP?=
 =?us-ascii?Q?9kWxwzevAJgF+yUMOrzKSNQwvw8r0Ej9F6wj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:15.1101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0731b409-33a5-4437-c504-08ddae808415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary:

* Improve USB4 bandwidth validation
* dml clock calcuation with EQU Prefetch included
* Tweaking udelay time to fix "failed to blank crtc!" error
* Add LSDMA support to DMUB
* Fix Coverity issue

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f5df271c8d1a..c35978214e38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.338"
+#define DC_VER "3.2.339"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

