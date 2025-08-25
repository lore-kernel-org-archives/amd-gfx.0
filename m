Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF6CA0EFF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 01:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D102110E229;
	Mon, 25 Aug 2025 01:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dj0IHKNr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620F210E229
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 01:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrG9v88gZK1jf2d9sAcqPNW/SSDM4oyiy+8P4809dpoKh2PTW6eKUL4iiXspD98u2Gwb6NGqia5A1TO9fLsKleYoI1nIL2NtEvXkYWR54Z251EZ057cls9jMwQKoC2djU4M3pAbC+ICWBkwj74rwJtbogABjWsbK3TYRHkbWqgDE9toJlCTC2GOaZ3/Uqz03+U0XeY0kuUpzUC21XKIfzEHEEujxlpDEidtXjtVh61i+Fl7D+Uz+SG+rEhR8ioiIMxNubfCowUmvd0XI5DaQqvyUp1aoABbjX+RYnB/utLFXFnY1E9MCpoupRJ/Q8uwizMtQAN8DUH/xqe8I6+dZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiOkg9O8a3wTkiG2RpjXGKCA23BMTA/KacmAX842xKk=;
 b=JkR127lHIN0f0yJSysezIUYe0klNtbaT70AeixpHR9ECyZKBxmNGulyQrPoKJWxwEjNMBO7GIFia76cxrc7GJj0tLoX0COJFSEbQlQMT5k+/9qatqhlKEhumqHXA2ZbmUAzMkQkMi736VbzMKyFZ83oHte58Urx7jcq72xgeromCL71UfLq7CFFk6CSgR6r21rO8ArMkSd6M6PJPT2UIMuIHO+eZ4/roeiWvtyY2RdvDlDPYIHEEYTwQOAYiJspitZwx4M2TXTJd7wO87UkhgGneMy9a5GNtf+ZwcpnQEe9wigZWlLvz6fGgvACY74XSGSBW0fCk8b/2Gp7P6ZZD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiOkg9O8a3wTkiG2RpjXGKCA23BMTA/KacmAX842xKk=;
 b=dj0IHKNrs9/iQvjnXC4NiSokdUoEVl6olWiTANaYOaOzNfb/ZHG4ojm3AIw9+EvmnwV9K2nDBBpvHQTQRwGq4JiigGHWxe8XjKzyyUgJtjs/5vdwvym8ufB9AjS7guJaUOvnkXsSJurM/eZ/o9KDgyGYKrrqG4uWnikXBqF+JdM=
Received: from SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) by DS0PR12MB7632.namprd12.prod.outlook.com
 (2603:10b6:8:11f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 01:19:07 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::d2) by SN6PR2101CA0022.outlook.office365.com
 (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.3 via Frontend Transport; Mon,
 25 Aug 2025 01:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 01:19:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Aug
 2025 20:19:05 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 24 Aug 2025 20:19:04 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Date: Mon, 25 Aug 2025 09:15:40 +0800
Message-ID: <20250825011903.1382954-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d4a1be-30e0-46d9-cfe3-08dde37562f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kLFvqdjAcIOanQkjKXOVm5f8aMxD6gk3nUFAoUMNfNBLrhfDnzYwqe7Ou3hI?=
 =?us-ascii?Q?0Vi73pCMZVE+M0JDiZsDS8sAkGSEs9wAmHGDDAy21R/inbyFQCTVTSfsQ6W3?=
 =?us-ascii?Q?tLQKn2LDtG52JIg8MWmOILO7QrVadODkYhI4rbPhBRM9jMMKVXowIvcqA6CQ?=
 =?us-ascii?Q?0GYmViiSII6P+Ua0CRQiS7TIdF9c0WCaX4XPGvZQ7h7fp7s1adxkHXE5Hvx1?=
 =?us-ascii?Q?NX1JByqDfBUsssW1QAnXjIVR75OF8Q3xVOp3V5X+R7f34srbl+QqKqhdJHB3?=
 =?us-ascii?Q?DO31vJFCWGdpbFq6O0mLjO3acm8mtvOub93ltRLPgGjMAy84xNLr+Gzy/9bv?=
 =?us-ascii?Q?M3zzpLBmPajYVY6YawvU9lUcW2Yu+hrKaQ3mrUHXYF85MHTnh21SaD8Dyod1?=
 =?us-ascii?Q?+GUfWxLk4DCF79U8/QOF40e/7ZvQYOfp76pen6DTkIFX634goZb5GNMPAz5F?=
 =?us-ascii?Q?JsZznWKQLV9Yemw9NgfzudiEVD+pr4uglsLk9OQfJZT0FEFyYKzhbMUz2R0Q?=
 =?us-ascii?Q?88MXJHn+Wd++steHkSftG3QTrRgHDTSkaKymXOj5Pjxu1/TXvcikcx8gWiV1?=
 =?us-ascii?Q?mE6KcRi6ubBK3ekNOmhoWJhjxSLWXZl2Hf2GqTMcTlLi2Y6RAMl0mdzTEGhm?=
 =?us-ascii?Q?XrnYsCO9c4qvSzrebt9o7Hg11i5pv8ZMGc7yAHRA7hZ0akcGFKK1oXMnxidj?=
 =?us-ascii?Q?q2yVrZ3RL43ivQGaWfeTuDizqYUlCxC1DS+6A8V5YpaGBGIQaRtscS9TZZvx?=
 =?us-ascii?Q?B1Hcwp4cDQtJNTEcaOIzvP/bdQomCIRfTN3HWZuyxUOfkOyKN0oS1GlhYOTp?=
 =?us-ascii?Q?ssFH0T5rU9GHTUnntB8kBWXoju6uwmWY3hRzAVFl2QYLvMvvZMc5MM5OmGz/?=
 =?us-ascii?Q?u2n4LDoqOSPFY1RxrZCkkmz6PMiM+A77lTKFDWi2eCfOuDI7A2Gd8VYOavBK?=
 =?us-ascii?Q?a1HdXBJBYWnIfkgVdduFTZbc0lxL+8E3i8yQ0Y4mq0oMf/KfYea1otkmPkOU?=
 =?us-ascii?Q?FvXFM6c6eg9g9n+P/uiNMKTYlEGT7JFvGW2CtEyKqFbJOru9KPSzeC23wKnV?=
 =?us-ascii?Q?Yu4c6KsZkmwQvPMa28wmPG/2GFGYZ65vFiNqCAp+pY8MvDs5deKRcoSWNUiL?=
 =?us-ascii?Q?b0EFeO8gxqo5YnetpmLe6VpCCu/9Pu5hHfHBkAAMWkfrQARpnNaKcGjaeDWL?=
 =?us-ascii?Q?7bL1VJLsL/KkxnMsDz8qjoIX+gZXKrgIhIVvIMifi3IOOipZriSwksYT5sli?=
 =?us-ascii?Q?2M9FK4m8G8mWGvvMLxREuHQSAhwL70yOt4tbwpwpVYRlANfNqp+QEb8aiHci?=
 =?us-ascii?Q?78eYri6pmWScu4+2LxHOj1fREC43DbGP0nmtJFzKnNOXk/c1t96yY2666bvk?=
 =?us-ascii?Q?NyayU26YSmgaz0TPTD17kDiSznAhSL5R51RTVgsF7gxO3iPCkzX8IPC6f9Xl?=
 =?us-ascii?Q?YHa2s9Cbam/eQSLsSAD47Ck44p3TOs1paYklzsYWXQYrreqaDjt2LupYS5a1?=
 =?us-ascii?Q?16zLY486g053G1scZ5heDssCrF9ltFr3uZTu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 01:19:06.6501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d4a1be-30e0-46d9-cfe3-08dde37562f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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

Fix a UBSAN shift-out-of-bounds warning in amdgpu_debugfs_jpeg_sched_mask_set
when the shift exponent reaches or exceeds 32 bits. The issue occurred because
a 32-bit integer '1' was being shifted by up to 32 bits, which is undefined
behavior.

Replace '1' with '1ULL' to ensure 64-bit arithmetic, matching the u64 type of
'val' and preventing the shift overflow. This is consistent with the existing
mask calculation that already uses 1ULL.

The error manifested as:
UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c:373:17
shift exponent 32 is too large for 32-bit type 'int'

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5d5e9ee83a5d..2c84f69b5bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -370,7 +370,8 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + j)))
+			dev_info(adev->dev, "%s[%d] num_jpeg_rings:0x%x #### \n",__func__,__LINE__, adev->jpeg.num_jpeg_rings);
+			if (val & (1ULL << ((i * adev->jpeg.num_jpeg_rings) + j)))
 				ring->sched.ready = true;
 			else
 				ring->sched.ready = false;
-- 
2.49.0

