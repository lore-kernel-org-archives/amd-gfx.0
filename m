Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB8FC3065A
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4863710E265;
	Sun, 30 Jun 2024 14:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bxmMq+P";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD3410E291
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbz/QNk4iRFLhi2fWrfMm7ieQq2JnmQzT2qgLXQWVqCbB/ZeJgXM9oozxkuYJhNk21i7ngTK7ic/qSkv3eCguMDYSOC2NlBYK88uqcbxBM8h3ISSIQP9uCcUjl34DsUwMnRIsunAZjEfpXrlTsEeaV85cXnnYZu2zuC6W7YPliIrZQAM3ARJ9/ZbV6CxpbpstzVvNrduPGtnhRzrhTOnx8XnzWa68mLuAT5AdSOHEgC8Fg69BmFo6pqe8DLIcf1k4Y3HeMGt6fRSsuATmtcrh7AvAY8bhHy+ZY2hweOjdZ6+zS4Hti7y6r7M3MqDDE92eTC9vOGovMpz3CSfclMD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwyZTiZfUCij1srgVfVJRA/h6+ABoUv0FyzITzMyZ4Q=;
 b=WnI8R4oBTqQY1jlojrcAfphe/siHpOXExELO2Gyjfl5t4qyO6xLGIE4GiBNhzqHr8xdHwkFOEckZTSUFz1oZecbOWNM+42+yYbbCG9dgrKU3WAztW4pAY7q7/8gK5nhNWxm+bVkAc4bNuhk3Q6dcxnVRt7jxmA6EbWPAEjATQjQ24120UQ30D/y62vUo76xBsE6IVCkL70v3ZU98tklVAnefMCTTyFxo3KP2Gahc3kMHO6rgF0RIWbxHG48kK9sinla1uj84ZzVf9/vbFEjkOsXiUk1IrWQrDgKqHJJ6hRe+hVJ1twyZ9ztJnzGphHVOr5yMditi9Otq8OEsSrdGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwyZTiZfUCij1srgVfVJRA/h6+ABoUv0FyzITzMyZ4Q=;
 b=4bxmMq+PMA8fv2NoC/LXitz+EtE8i6bAyIlkXWyrk7KBlOIAnSJCIxyiPFQbhpSZaJwv8acao7bat2c6pVnIO4C8p2cpmDBnjR9KPOJQgjfpb1yuvOzdVQODz4qfEb0CMTQT/kfORIqOMw2urA3XTDJW8FaLeB9IlDANNgzyVT0=
Received: from PH8PR20CA0008.namprd20.prod.outlook.com (2603:10b6:510:23c::18)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:59:34 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::a7) by PH8PR20CA0008.outlook.office365.com
 (2603:10b6:510:23c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:33 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:31 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: add firmware for PSP IP v14.0.4
Date: Sun, 30 Jun 2024 22:58:31 +0800
Message-ID: <20240630145831.2023399-7-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0126b1-1e15-4534-cfef-08dc991540a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXSLBIkdoKOBQ03cqnm4xGUCifgkGwElfRz3CrZCueiF4svoQEzRkNIQdfbw?=
 =?us-ascii?Q?s+bEsFc+vNz/9iiPK6S/PslyoZTDqJrCoUQq4Gncx+/WXrj31zws+8E054wR?=
 =?us-ascii?Q?avmnm5Ll5ingR3U9AXXGiyvF9ca8QsQ/qBb9nAybH4P+spkm8OlC/yYOgmqD?=
 =?us-ascii?Q?5kQci46aG21miBKwRFTd+CTmG3fx6xamTegv0CD44dcjVDUv9oUuEQjttHX/?=
 =?us-ascii?Q?UtYtIrbuBpNwWn5NKzjoellQssum/WyVXsCmKe4CSJsJysw+V9ZdGjSIwDAI?=
 =?us-ascii?Q?4UdjuGfyIDB9+RiaAUmikg+FQaiGgfPtTDQgzKETylm0GKYtwigqufNP9GZF?=
 =?us-ascii?Q?fMOARnySvcojUuDV32QrNdiNS5pXTwHZCPDssZYvh7cqBywYTOfh8i/YZnnn?=
 =?us-ascii?Q?l+D6RVpg91lUAjINSkFtcuPXV2TK51j5CigRnsx2mJGZvH8b0d5lvM5EBtGI?=
 =?us-ascii?Q?+YzBSzl/RCS1JcwEGsNwZEiQ2yy66H6P+9CT0h+gJkQNmb0WmvcTFY/7o7QO?=
 =?us-ascii?Q?zFQz1gYyGq7KW9lfvaHxrmotxqcJrxqtptcb4osGjDgWyw633BrViYXGlFXO?=
 =?us-ascii?Q?Rgyi4W6o92RpU36mQKzjj1IGE7gBCF3kTtzMRLWMH4AyEXoq+e+PiBgYXsrj?=
 =?us-ascii?Q?6y3Y0gm4mk+eNK1KFHnvu2PaAZM/x4HKNJQGucjhmFdre8hB97fI8ZZxl2A9?=
 =?us-ascii?Q?qk1VXFBKjGLPuTQf65aGzChkZRgAkhGdYXLRjuWp9LkFjS6Z9Hiafp0275AM?=
 =?us-ascii?Q?/+Fxvw00pgZgq8AzyHCxhpo615n6dVmVd5KUZSuFJZeBiyuTN+y0flFP2r1v?=
 =?us-ascii?Q?9fBEGL3706BDdzy4IFyeyC2Z71qJbtZzcd4NJR0dD6Wv8GD07ihZgP7JYmkC?=
 =?us-ascii?Q?F3GP/coB/GCMFwJYMWrCO/b99App5xnBsvge8npPB3JTX8pENauIiAQ+4he/?=
 =?us-ascii?Q?Tujpxi1B/BDPkARxRWAIujXgWOX1Wt+Nh4tcYhWCykc6gLY9wQjRhmesadNm?=
 =?us-ascii?Q?hk/5ciEUSlts812ZP+XvIvFUTILfw8VHNMNKRsgP8oz67J3/EIVHtfXcso29?=
 =?us-ascii?Q?VwL3WnCY+jWPGJQWzytoBUHgErR1TE3CR+/fCCf200saYl60IgEM4a19UAha?=
 =?us-ascii?Q?yrnvra2dBhxN62maBqsgIWiE3LPqGPIpZsgpHWS9tdzxhGRU5hs8S+AitFX6?=
 =?us-ascii?Q?xhbiSlJ8OWa6NwLuAnnCMm9D6uvzRvCz9D5UGGxLV13VwVem5+0OUSHAYeUz?=
 =?us-ascii?Q?eTfti0YmlaTF0cMvqZqVymFSdJ+W49/WKRmB7LeuKLx1IorixDttp+e/blfa?=
 =?us-ascii?Q?Kda2ooZXhklw2KP83kOM1GZIuM9HEeJrx/T/Jt8ljOJ22Gohp/X5Fot7A+5g?=
 =?us-ascii?Q?ZNKn8jNWkrtOMClTRL0Yl4GKFD6XaGhdo3harubuJn0tZZ3Zm43mSS40F9GC?=
 =?us-ascii?Q?9cHBWRnUq3HiVQlG6KVNCgt8eyxk+8UD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:33.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0126b1-1e15-4534-cfef-08dc991540a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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

This patch is to add firmware for PSP 14.0.4.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 407477b895d1..1251ee38a676 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -57,6 +57,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_4_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
-- 
2.43.0

