Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37483E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 05:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA5A10E58E;
	Mon,  6 Jan 2025 05:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eYAE9Cd8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1292810E58B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 05:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3EiEedHyoangQayUoxJnP7/7s6eyDrLdf4lJflzaePhO45g2/SCFSrcZ//dAUIkSjJf3SSc2yB4VDGQ5IXLNr16ZWK0YB3/RoIk5LkpVKZH/RQkRq5uudi9kKwy/g3cjAEszS0wIgg1LzTlSN+eSkDr+H62BLxaZqpZpszIBOgCOKnns0PH8/eWnDXkE3AEfo/OjFB7XqtlQuuaRgQfRmJwZXrVhQSnydhTsRnA1VyHqCmGyr4ww7E5JZwJugpPQ3B9eAkuJSZ+wW422EVnXA/OyeLH8Z24cGdAfDpxRJ7UNUNBuuMqYV4UvCA43/Ao9Lfk7udNqiQrTPuBd/pSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZsnpLmOLt/U8B2CY34r+rpUvifI3Dp2wK4iAxYgdM0=;
 b=XUDpUYbM4KWHAJonq1oHzu/VV+Kp7RDA+/eNODDzVp9o3OgnJfT6wIHcAyGxeRkdBhEr877o1+ZJtjVbnmr/rzE2FfUdWdjGJ8Px/e6IRztIUKVv2bP3Lmplfxju3Xz7KEUdgS/7SLbPAG/MzDp3sa7pzzQiEyxIh6bGgJtDfCN8k4EfZOeF2DxeNdGRFzMNhyLzBdsMXl7ocZMVhr77Z0NWLwVEHlGsYrN24gof0WGEr0Cl6rzNIkw4ntv9qayk6ZRBuKeexRS84mXkguPWntfcTIrWdr35lWtwr3eq+IMcO0bLxu3tt64es8TU00Kq1qWg+b09qRvJ14ZrGSN+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZsnpLmOLt/U8B2CY34r+rpUvifI3Dp2wK4iAxYgdM0=;
 b=eYAE9Cd8Z3qgK0ApHeQ6CiFsTDmdZq7iFVlJjWJ1lfVGbeVzmrPiHdY5Ul/YFFawBC3nBf/bR/enhUnGsmUI5Sv8x8vQMvCC0ScFyh5c8DYUBzLmKkvvYnegj++TNPVd0hJe/d4aJcb8wv6CB5yy4InTt6n4MmpM7OE/uFXBhcQ=
Received: from SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 05:58:42 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::c2) by SN7PR04CA0181.outlook.office365.com
 (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 05:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:58:40 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:58:38 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix incorrect active RB bitmap in setup RBs
Date: Mon, 6 Jan 2025 13:58:08 +0800
Message-ID: <20250106055810.3785461-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cfba82-aa50-45aa-8910-08dd2e172b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xca7FER6JylvVfatN3WohECgoFSu79VF9M1yUPFk2Z43fWaxgsSKx25K6ZqL?=
 =?us-ascii?Q?66T3GQlUjVQ6KxrW6lEWmRWv1IDZdBsODEguA8QvKIxPe69404ajdYT45XPE?=
 =?us-ascii?Q?4dxeyYPvyS6Y5xPyY+KHO3V2FBls5U7XNKvbnKS02S81KEF2PJ3XrpD6v3hl?=
 =?us-ascii?Q?EhEirPJSlPDTDQqb5xptJot6ifyHrinBTI7c+G/xTBkA5aHZZ6gsVrixiC0x?=
 =?us-ascii?Q?lBM4sUWDk7xmaKoxYba8K+21JqAPcjWsBAmYs9/NZEs9NKt7yZWkXldAP6mz?=
 =?us-ascii?Q?0wWB8FcmdVmM7BBx07gVtagLmZ09OI+mYR26i2a1qvam4+5Fxhr6TwHMx3ap?=
 =?us-ascii?Q?S+p9YhVnThy8mEblp4Xqq4N794vzqBjee5YVianFEsrnIDx0LUjPU6c2oXrR?=
 =?us-ascii?Q?3DXKQN2zzTfE5EV23Ef6I2h412xYVz2bc50yPtaLmL3WrQSnhPLg/XcaD526?=
 =?us-ascii?Q?DtuKFwrBP1C605akX3E4TNmLzXN8Q8koEw5SyRwuLw4CUOw9QVYyyLB1DgS/?=
 =?us-ascii?Q?XJOeUcgHbs0TP8fL+nE9t6/cUxrPRyzCD0hzPo+GVnQtlPLEJVNQI79/gbRD?=
 =?us-ascii?Q?BK9MDSWtU83Bwn8t57clz1Cs47N+fCpKdvIX2fth+ht3EsRBZGWqwhzeDN4z?=
 =?us-ascii?Q?TQgnKaSRtdyRQnQATpHZsQSHOchESAzj0OzXtENhpo1wfz5RMOwHIgsAKe6w?=
 =?us-ascii?Q?c5LgpLpb9HEhKDhrz3gjiZ9q71dgv08IqrtA1YoOv8U1EmZhxIM5NuSu7mCW?=
 =?us-ascii?Q?HlwwM4TJ9+oAEoCRvOmLO1LKSs61HO4zXbB7noGnvLlV0uGNgyXvbdKIVkRa?=
 =?us-ascii?Q?TrlThpezAP/356ay4KI/aizrkGIbRbvkwc7dMozWG96f85Dr7MCu1WBNddpY?=
 =?us-ascii?Q?Kddt0vWtlTBrdyEbxx5mYsJqCpXVKwthyIKMlw1Nc4cxOy5xpjyeccpOnEEI?=
 =?us-ascii?Q?vpd/BsDcptYFimpTMqbZT/Wv81LQtkJsicdAZIW+TyLpfxGlomWXzNY9ke8i?=
 =?us-ascii?Q?f2mq+0WxdOYrVxGK4N+/kHD0NUJwF/4cZziyCpJm51wFMZYtsjE+B14NEpwr?=
 =?us-ascii?Q?wv3+yAETTxc6CMma+gnlX/7yHsCD81wPRRuAX1tbuMs6oJlV7QVnUl1OMP9E?=
 =?us-ascii?Q?NnFBcrLdUDc/qzoOHtRKtohSxXLei+RjHZNy83V22TyXkCHzR447DN2C0h2C?=
 =?us-ascii?Q?H7vGObEZtFv+QTesx1KSzzxAA75BxUB9Rh7gDHVqjGrvpD1TEIZtJ+0XCzrI?=
 =?us-ascii?Q?GiKM81r5cPG7i4/Xn4KprsTXrVoheZ3N7mgEoYnYtHwopk13Ta0a6bNRGa4o?=
 =?us-ascii?Q?1hml5YX16kvdc1UxSjS9ms9KFsj5lBp/ueMvTkMObSWc5sW2n+O+Tp8NDk0V?=
 =?us-ascii?Q?trCiddd5kxwg7Fi9JupG5V2YVm44OBBGAsQXhsCo542HHbZ613BIklkJzcNI?=
 =?us-ascii?Q?/8FC7DkmZE/xacwzUDmzmurr2qD1QcjXPMDNb7gekDq5KDjIsfoM2KBYFpNl?=
 =?us-ascii?Q?EI6l43DgUeje7Yc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:58:40.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cfba82-aa50-45aa-8910-08dd2e172b90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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

The RB bitmap width per SA may be 0x1 for some ASICs.
Use the actual bitmap of SA instead of 0x3 to determine
the active RB bitmap.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1f9279f69712..25641677cae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1914,6 +1914,7 @@ static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 
 static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 {
+	u32 rb_bitmap_per_sa;
 	u32 rb_bitmap_width_per_sa;
 	u32 max_sa;
 	u32 active_sa_bitmap;
@@ -1931,9 +1932,11 @@ static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 		 adev->gfx.config.max_sh_per_se;
 	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
 				 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_per_sa = amdgpu_gfx_create_bitmask(rb_bitmap_width_per_sa);
+
 	for (i = 0; i < max_sa; i++) {
 		if (active_sa_bitmap & (1 << i))
-			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
+			active_rb_bitmap |= (rb_bitmap_per_sa << (i * rb_bitmap_width_per_sa));
 	}
 
 	active_rb_bitmap &= global_active_rb_bitmap;
-- 
2.43.0

