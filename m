Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA91D637B6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51010E898;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mrc9X7Z1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA68A10E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB0AqTAhFPspkzIAZigCraQvOZY2LqtQFlG6XkDvh1a9lIwFYxOv3Voc+4cNd/o+Y/U0KFqWASU10piLerrisjQrUCoT+btei1TD3MLwGywe3di7CzNIuS87jLZmkHILC7R4kmb7uN2uoF4AVsSgWWwFDMbxXo9rTPg+h/1cQ3D5YSHrO+WKpv8ViBauE36K9XO1bG7CDT6hyGs7TREvDBPX0RZ3lsU4awITxXqesb53Ys8NH7CqLdiyA9ivCG4JTbw9nEW/im3xvGMyv1v36ofB4oozeacYWINmEDYGplPMnKULvvkVwtlF6pqHjmVggfC1GI3S5MRl3uoqYLOrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h03WkJxg5HJ4pI9Q86j66oIyGvVyjBARPgdGN9zTGX4=;
 b=VcfWWvgIpIwTXPjyL808nXCTzOMOGfdcrD6tOYFfBesWcHDvN1kese9yXSZ9MPOg7XMMEzaxUp8CkjTVxe+DlTENW6hnRiVORLB4g9A6OLXLDNGXoC/VQLc+OZxaJe9BuhUCSCP6z0lDjKyJVKmtsdS17jhnX5QtXg+LE2DCg5buFi5HvYtQ3lEjj0KL4CjSAYLCyC+gJCc7/FNOfw5f45A4fpyL+1L6wa3lDwgkE05qBpIaQp2k54BC/gWQTgugButpfd9jAdDKM+YGQSXtTF1nEUNqFiinpjwEduAs9CPm++bvLZH7CkLvklejZ2gWCpefD6SBo/zzwBMNQIEs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h03WkJxg5HJ4pI9Q86j66oIyGvVyjBARPgdGN9zTGX4=;
 b=mrc9X7Z1G5d+JC8VcU2cyWBwNDgBawM79tedPaIpbu5rklJB3ulSgea946dwWHgKJ8Dmau2oNIFkgEVCzN2qPJhugSH9AZZ4Hd8I3jvNyEIMIChxJqJF4LAOeFS7tcfSV+6mccnc7yJz/IV25A76O4Vzipe9VNQZlJVT5t863tU=
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:14 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::bd) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Joseph Greathouse <joseph.greathouse@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Apply VGPR bank state fixup on gfx12.1 trap exit
Date: Tue, 16 Dec 2025 16:03:44 -0500
Message-ID: <20251216210349.1963466-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: ace94818-9c39-4a09-79b6-08de3ce6ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0y0phoPwjbTIJSrQpf6Zjs8yd7j04fqksHyt7LwQFH2MJu6EWqm43KsJ4cqP?=
 =?us-ascii?Q?qtHd20MfAL4OYnQgk2o68O9XAtSwXE1OdxIfpJDz44FBWz+L4KKanImge7FU?=
 =?us-ascii?Q?CKPISfw1hr1QPf9Ed3VH99h0gzPHhD/xW7RPSNe/VpuHuejHxlB9vIFLOfWq?=
 =?us-ascii?Q?mlVuzEuSNHdP8HrltuHI9M9HviGy8z7ZaB/fdcmjlVfCNq0J2C/Spndfr6f2?=
 =?us-ascii?Q?ZqVKORoQTeRnv4o8SpqI3ejRIiY0RoWrsPJXEySjDWLHHduxK/kl3lSzaLV2?=
 =?us-ascii?Q?QD7KJlkXKmwViGF9FP45Z1zV4Qi/FlHZq0Tjb4oPaFrSgOIEJKp/iwJLXR6J?=
 =?us-ascii?Q?u9xV1K4I6FskN4qm6Qy4+TfqlFKOaLAHfFbu+2y/bliM7loPUlW9JR2EogWU?=
 =?us-ascii?Q?mcFjo6XXo9XjgYsFjQxn/XQ420QRClDAn8AcqT59Iu1Sj2iLmDB/R4gx3KHe?=
 =?us-ascii?Q?Phd9iV3Pv8BbgEgNkDhwpuPN86NmtdLLVDvJhTLb+qmd6u/VWOMz2SYY3wtU?=
 =?us-ascii?Q?SLQZlIcDykTyNhhSJs6RKatyRnn7QHnDtwMAK8lunzhgdt3HpfE0JnbB6EuY?=
 =?us-ascii?Q?Vf8hHFctYE5v0AaCbDmh1apzuspxD9bW9vEJKytXxkqewpqHfSvlOxPF0RwW?=
 =?us-ascii?Q?7NDvnnYX8bweuY+yanMvaPJjWg3uaF/E36R4xnx7+Cg44TkIzi/Xgh0GiB4i?=
 =?us-ascii?Q?X1LZC4HsYgphvUOEXyvlInUbrCa0clr42EUMhKKbVJxwzJBvRdSXJo6ssSla?=
 =?us-ascii?Q?NYUgopZj/IAaOruUW2tuny4Yqx3he0VjXdJCYxl9XWFQEcpISjmOj9eFs3Q+?=
 =?us-ascii?Q?sUbTMx0Ip2HrPpjXPXhM9wwPGNjWfc4qtDrx4TFymLlWBkJqNe4bVGvxZWij?=
 =?us-ascii?Q?6smjFjv/osyQfOBR0y6jWpXdQfeYPIRkezNQSPRjsBgsLHE70xB71aoy5f6s?=
 =?us-ascii?Q?PQD2TW47zusvGqRux9hWPSxUnFiLDEKy3ZXLHXB4KkB7RnOAferQAZRnBLyt?=
 =?us-ascii?Q?rFlvzJPdoeaWRq6XC1vOTrRM8ejrcyQP6a+79v1zM9Z8SihaxWQgt32mYRCc?=
 =?us-ascii?Q?uO19GsVNbNOla4Rd9lQ7F+HfOgdI8SumaGfFtKiu19mHOrfkg081CQBOO/Ih?=
 =?us-ascii?Q?1jqqImEGSCxvYoYTpCbQX3IY67Zpcq7uHFkytAmLFUzgpuuIUcIA2FvMkbPI?=
 =?us-ascii?Q?hfmFxcm6GSqpkQ89vSj1bSpzQpSEBv4gQeLI+5Usjz0TmGiAsYAkvcj5Yyq4?=
 =?us-ascii?Q?cRNyS2PAjR2zecSP6t6ZvGZoPzVQGzmu5aXpZHnUMFKJY/gDTB6o1kfw1bCK?=
 =?us-ascii?Q?RM50VE/qaj9bqmEKdDqdDR+NajjoYOqqKBNO9jLycB7FP6qkvdi5fxzt2BTt?=
 =?us-ascii?Q?3T6XuI42jlrs3LG9MGKBvQjW/67Mhs1kURZVzPRsq/Qk7hDEZRvoEgNCzf2q?=
 =?us-ascii?Q?rNDA4jk1Qsgb3EPZMPrZsFQpYL+TSdcMaGZvHWoPpQ4gCBf1cKPJzoOg81D+?=
 =?us-ascii?Q?YbCuIIWzF8T/33FqN0B4tEP1h0aY8vYKuzwBISKJd1XMB0cBLz0gRnbLToar?=
 =?us-ascii?Q?lH/MJCknjD7GwGQ5A1c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:14.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace94818-9c39-4a09-79b6-08de3ce6ab5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

From: Jay Cornwall <jay.cornwall@amd.com>

- Identify co-issue of S_SET_VGPR_MSB and VALU with banked VGPR
- Restore previous bank setting when exiting the trap

v2:
- Refine VOP3PX2 detection
- Improve load pipelining
- Fix a comment typo

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Lancelot Six <lancelot.six@amd.com>
Cc: Joseph Greathouse <joseph.greathouse@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 955 ++++++++++--------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 166 ++-
 2 files changed, 706 insertions(+), 415 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index d82ce2f1e9b92..dfffda4aa8e21 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4666,14 +4666,14 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa002a2,
+	0xbfa00001, 0xbfa003b7,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
 	0xbfa20018, 0x8b6ea07b,
-	0xbfa2004f, 0xbf830010,
+	0xbfa200e1, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
 	0x8b6eff7b, 0x00000bd0,
 	0xbfa20010, 0xb8eef812,
@@ -4684,7 +4684,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xf0000000, 0xbfa20005,
 	0x8b6fff6f, 0x00000200,
 	0xbfa20002, 0x8b6ea07b,
-	0xbfa20039, 0x9177ff77,
+	0xbfa200cb, 0x9177ff77,
 	0x007fc000, 0xb8fa04a1,
 	0x847a967a, 0x8c777a77,
 	0xb8fa0421, 0x847a957a,
@@ -4710,169 +4710,330 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x80ec886c, 0x82ed806d,
 	0xbfa00002, 0x806c846c,
 	0x826d806d, 0x8b6dff6d,
-	0x01ffffff, 0x8bfe7e7e,
+	0x01ffffff, 0xb8fbf811,
+	0xbf0d847b, 0xbfa20078,
+	0xf4003eb6, 0xf8000000,
+	0xf4003bb6, 0xf8000008,
+	0xbfc70001, 0x8b76ff7a,
+	0x80000000, 0xbfa20027,
+	0x9376ff7a, 0x00060019,
+	0x81f9a376, 0xbf0b8179,
+	0xbfa20068, 0x81f9ac76,
+	0xbf0b8179, 0xbfa20062,
+	0x81f9b776, 0xbf0b8179,
+	0xbfa2005f, 0x8b76ff7a,
+	0x000001ff, 0xbf06ff76,
+	0x000000fe, 0xbfa2005d,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20057, 0xbf06ff76,
+	0x000000fa, 0xbfa20054,
+	0x81f9ff76, 0x000000e9,
+	0xbf0b8179, 0xbfa20050,
+	0x8b76ff7b, 0xffff0000,
+	0xbf06ff76, 0xbf860000,
+	0xbfa10051, 0x9376ff7b,
+	0x0002000e, 0x8b79ff7b,
+	0x00003f00, 0x85798679,
+	0x8c767976, 0xb9763b01,
+	0xbfa00049, 0x8b76ff7a,
+	0xfc000000, 0xbf06ff76,
+	0xd4000000, 0xbfa20013,
+	0xbf06ff76, 0xc8000000,
+	0xbfa20027, 0x8b76ff7a,
+	0xff000000, 0xbf06ff76,
+	0xcf000000, 0xbfa20039,
+	0x8b79ff7a, 0xffff0000,
+	0xbf06ff79, 0xcc350000,
+	0xbfa20037, 0xbf06ff79,
+	0xcc3a0000, 0xbfa20034,
+	0xbf06ff76, 0xcc000000,
+	0xbfa10031, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20029,
+	0xbf06ff76, 0x000000fa,
+	0xbfa20026, 0x81f6ff76,
+	0x000000e9, 0xbf0b8176,
+	0xbfa20022, 0x8b76ff7b,
+	0x0003fe00, 0xbf06ff76,
+	0x0001fe00, 0xbfa2001d,
+	0x8b76ff7b, 0x07fc0000,
+	0xbf06ff76, 0x03fc0000,
+	0xbfa20018, 0xbfa00014,
+	0x9376ff7a, 0x00040016,
+	0x81f68176, 0xbf0b8176,
+	0xbfa20012, 0x9376ff7a,
+	0x00050011, 0x81f68176,
+	0xbf0b8176, 0xbfa2000d,
+	0x8b76ff7a, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20008, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20003,
+	0xbfc70000, 0xbefb006e,
+	0xbfa0ffad, 0xbfc70000,
+	0xbefb006f, 0xbfa0ffaa,
+	0xbfc70000, 0x857a9677,
+	0xb97a04a1, 0x857a9577,
+	0xb97a0421, 0x857a8e77,
+	0xb97a3021, 0x8bfe7e7e,
 	0x8bea6a6a, 0x85788978,
 	0xb9783244, 0xbe804a6c,
 	0xb8faf802, 0xbf0d987a,
 	0xbfa10001, 0xbfb00000,
 	0x8b6dff6d, 0x01ffffff,
 	0xbefa0080, 0xb97a0151,
+	0x9177ff77, 0x007fc000,
+	0xb8fa04a1, 0x847a967a,
+	0x8c777a77, 0xb8fa0421,
+	0x847a957a, 0x8c777a77,
+	0xb8fa3021, 0x847a8e7a,
+	0x8c777a77, 0xb980f821,
+	0x00000000, 0xbf0d847b,
+	0xbfa20078, 0xf4003eb6,
+	0xf8000000, 0xf4003bb6,
+	0xf8000008, 0xbfc70001,
+	0x8b76ff7a, 0x80000000,
+	0xbfa20027, 0x9376ff7a,
+	0x00060019, 0x81f9a376,
+	0xbf0b8179, 0xbfa20068,
+	0x81f9ac76, 0xbf0b8179,
+	0xbfa20062, 0x81f9b776,
+	0xbf0b8179, 0xbfa2005f,
+	0x8b76ff7a, 0x000001ff,
+	0xbf06ff76, 0x000000fe,
+	0xbfa2005d, 0xbf06ff76,
+	0x000000ff, 0xbfa20057,
+	0xbf06ff76, 0x000000fa,
+	0xbfa20054, 0x81f9ff76,
+	0x000000e9, 0xbf0b8179,
+	0xbfa20050, 0x8b76ff7b,
+	0xffff0000, 0xbf06ff76,
+	0xbf860000, 0xbfa10051,
+	0x9376ff7b, 0x0002000e,
+	0x8b79ff7b, 0x00003f00,
+	0x85798679, 0x8c767976,
+	0xb9763b01, 0xbfa00049,
+	0x8b76ff7a, 0xfc000000,
+	0xbf06ff76, 0xd4000000,
+	0xbfa20013, 0xbf06ff76,
+	0xc8000000, 0xbfa20027,
+	0x8b76ff7a, 0xff000000,
+	0xbf06ff76, 0xcf000000,
+	0xbfa20039, 0x8b79ff7a,
+	0xffff0000, 0xbf06ff79,
+	0xcc350000, 0xbfa20037,
+	0xbf06ff79, 0xcc3a0000,
+	0xbfa20034, 0xbf06ff76,
+	0xcc000000, 0xbfa10031,
+	0x8b76ff7b, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20029, 0xbf06ff76,
+	0x000000fa, 0xbfa20026,
+	0x81f6ff76, 0x000000e9,
+	0xbf0b8176, 0xbfa20022,
+	0x8b76ff7b, 0x0003fe00,
+	0xbf06ff76, 0x0001fe00,
+	0xbfa2001d, 0x8b76ff7b,
+	0x07fc0000, 0xbf06ff76,
+	0x03fc0000, 0xbfa20018,
+	0xbfa00014, 0x9376ff7a,
+	0x00040016, 0x81f68176,
+	0xbf0b8176, 0xbfa20012,
+	0x9376ff7a, 0x00050011,
+	0x81f68176, 0xbf0b8176,
+	0xbfa2000d, 0x8b76ff7a,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20008,
+	0x8b76ff7b, 0x000001ff,
+	0xbf06ff76, 0x000000ff,
+	0xbfa20003, 0xbfc70000,
+	0xbefb006e, 0xbfa0ffad,
+	0xbfc70000, 0xbefb006f,
+	0xbfa0ffaa, 0xbfc70000,
 	0xbeee007e, 0xbeef007f,
 	0xbefe0180, 0xbefe4d84,
 	0xbf8a0000, 0x8b7aff7f,
 	0x04000000, 0x847a857a,
-	0x8c6d7a6d, 0x9177ff77,
-	0x007fc000, 0xb8fa04a1,
-	0x847a967a, 0x8c777a77,
-	0xb8fa0421, 0x847a957a,
-	0x8c777a77, 0xb8fa3021,
-	0x847a8e7a, 0x8c777a77,
-	0xb980f821, 0x00000000,
-	0xb8eff822, 0xb980f822,
-	0x00000000, 0xb8fa2b01,
-	0x847a997a, 0x8c6d7a6d,
-	0xbefa0080, 0xb97a2b01,
-	0xbefa007e, 0x8b7bff7f,
-	0x01ffffff, 0xbefe00c1,
-	0xbeff00c1, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb0742,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
+	0x8c6d7a6d, 0xb8eff822,
+	0xb980f822, 0x00000000,
+	0xb8fa2b01, 0x847a997a,
+	0x8c6d7a6d, 0xbefa0080,
+	0xb97a2b01, 0xbefa007e,
 	0x8b7bff7f, 0x01ffffff,
-	0x807aff7a, 0x000001c0,
-	0x807a7e7a, 0x827b807b,
-	0xd7610000, 0x00010870,
-	0xd7610000, 0x00010a71,
-	0xd7610000, 0x00010c72,
-	0xd7610000, 0x00010e73,
-	0xd7610000, 0x00011074,
-	0xd7610000, 0x00011275,
-	0xd7610000, 0x00011476,
-	0xd7610000, 0x00011677,
-	0xd7610000, 0x00011a79,
-	0xd7610000, 0x00011c7e,
-	0xd7610000, 0x00011e7f,
-	0xbefe00ff, 0x00003fff,
-	0xbeff0080, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0xd760007a, 0x00011d00,
-	0xd760007b, 0x00011f00,
+	0xbefe00c1, 0xbeff00c1,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0x7e000280,
 	0xbefe007a, 0xbeff007b,
-	0xbef4007e, 0x8b75ff7f,
-	0x01ffffff, 0xbef1007d,
-	0xb8f30742, 0x84739973,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00002, 0xbeff00c1,
-	0xbfa0000a, 0xee0a4074,
-	0x008c0000, 0x00008000,
-	0xee0a4074, 0x010c0000,
+	0xb8fb0742, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0x8b7bff7f,
+	0x01ffffff, 0x807aff7a,
+	0x000001c0, 0x807a7e7a,
+	0x827b807b, 0xd7610000,
+	0x00010870, 0xd7610000,
+	0x00010a71, 0xd7610000,
+	0x00010c72, 0xd7610000,
+	0x00010e73, 0xd7610000,
+	0x00011074, 0xd7610000,
+	0x00011275, 0xd7610000,
+	0x00011476, 0xd7610000,
+	0x00011677, 0xd7610000,
+	0x00011a79, 0xd7610000,
+	0x00011c7e, 0xd7610000,
+	0x00011e7f, 0xbefe00ff,
+	0x00003fff, 0xbeff0080,
+	0xee0a407a, 0x000c0000,
+	0x00000000, 0xd760007a,
+	0x00011d00, 0xd760007b,
+	0x00011f00, 0xbefe007a,
+	0xbeff007b, 0xbef4007e,
+	0x8b75ff7f, 0x01ffffff,
+	0xbef1007d, 0xb8f30742,
+	0x84739973, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00002,
+	0xbeff00c1, 0xbfa0000a,
+	0xee0a4074, 0x008c0000,
+	0x00008000, 0xee0a4074,
+	0x010c0000, 0x00010000,
+	0xee0a4074, 0x018c0000,
+	0x00018000, 0xbfa00009,
+	0xee0a4074, 0x008c0000,
 	0x00010000, 0xee0a4074,
-	0x018c0000, 0x00018000,
-	0xbfa00009, 0xee0a4074,
-	0x008c0000, 0x00010000,
-	0xee0a4074, 0x010c0000,
-	0x00020000, 0xee0a4074,
-	0x018c0000, 0x00030000,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0x8070ff70,
-	0x00000200, 0x7e000280,
-	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xb8faf802,
-	0xbf0c8b7a, 0xbfa20003,
-	0xbe804fc2, 0xbf94fffe,
-	0xbfa10001, 0xbe804ec4,
-	0xbf94fffc, 0xb8faf804,
-	0x8b7aff7a, 0x0001000c,
-	0x9178ff78, 0x0001000c,
-	0x8c787a78, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xd7610002, 0x0000fa6c,
-	0x807d817d, 0x917aff6d,
-	0x80000000, 0xd7610002,
+	0x010c0000, 0x00020000,
+	0xee0a4074, 0x018c0000,
+	0x00030000, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0x8070ff70, 0x00000200,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbefd0080,
+	0xb8faf802, 0xbf0c8b7a,
+	0xbfa20003, 0xbe804fc2,
+	0xbf94fffe, 0xbfa10001,
+	0xbe804ec4, 0xbf94fffc,
+	0xb8faf804, 0x8b7aff7a,
+	0x0001000c, 0x9178ff78,
+	0x0001000c, 0x8c787a78,
+	0xd7610002, 0x0000fa71,
+	0x807d817d, 0xd7610002,
+	0x0000fa6c, 0x807d817d,
+	0x917aff6d, 0x80000000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa6e, 0x807d817d,
+	0xbefa0080, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6e,
-	0x807d817d, 0xbefa0080,
+	0xd7610002, 0x0000fa78,
+	0x807d817d, 0xb8faf811,
 	0xd7610002, 0x0000fa7a,
 	0x807d817d, 0xd7610002,
-	0x0000fa78, 0x807d817d,
-	0xb8faf811, 0xd7610002,
+	0x0000fa6f, 0x807d817d,
+	0xb8f1f801, 0x937aff6d,
+	0x00060019, 0x847a8c7a,
+	0x8c717a71, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f814, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f815, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f812, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f813, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8faf802, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6f,
-	0x807d817d, 0xb8f1f801,
-	0x937aff6d, 0x00060019,
-	0x847a8c7a, 0x8c717a71,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f814,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f815,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f812,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f813,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8faf802,
+	0xbefa50c1, 0xbfc70000,
 	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefa50c1,
+	0x807d817d, 0xbefa4c88,
 	0xbfc70000, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xbefa4c88, 0xbfc70000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
-	0x80767074, 0x82778075,
+	0xbefe00ff, 0x0000ffff,
+	0xbeff0080, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x010c0000, 0x00000000,
+	0xbefe00c1, 0x7e040280,
+	0xbefa5081, 0xbfc70000,
+	0xd7610002, 0x0001007a,
+	0xbefa5082, 0xbfc70000,
+	0xd7610002, 0x0001027a,
+	0xbefa5083, 0xbfc70000,
+	0xd7610002, 0x0001047a,
+	0xbefa5084, 0xbfc70000,
+	0xd7610002, 0x0001067a,
+	0xbefa5085, 0xbfc70000,
+	0xd7610002, 0x0001087a,
+	0xbefa5086, 0xbfc70000,
+	0xd7610002, 0x00010a7a,
+	0xbefa5087, 0xbfc70000,
+	0xd7610002, 0x00010c7a,
+	0xbefa5088, 0xbfc70000,
+	0xd7610002, 0x00010e7a,
+	0xbefa5089, 0xbfc70000,
+	0xd7610002, 0x0001107a,
+	0xbefa508a, 0xbfc70000,
+	0xd7610002, 0x0001127a,
+	0xbefa508b, 0xbfc70000,
+	0xd7610002, 0x0001147a,
+	0xbefa508c, 0xbfc70000,
+	0xd7610002, 0x0001167a,
+	0xbefa508d, 0xbfc70000,
+	0xd7610002, 0x0001187a,
+	0xbefa508e, 0xbfc70000,
+	0xd7610002, 0x00011a7a,
+	0xbefa508f, 0xbfc70000,
+	0xd7610002, 0x00011c7a,
+	0xbefa5090, 0xbfc70000,
+	0xd7610002, 0x00011e7a,
 	0xee0a4076, 0x010c0000,
-	0x00000000, 0xbefe00c1,
-	0x7e040280, 0xbefa5081,
-	0xbfc70000, 0xd7610002,
-	0x0001007a, 0xbefa5082,
-	0xbfc70000, 0xd7610002,
-	0x0001027a, 0xbefa5083,
-	0xbfc70000, 0xd7610002,
-	0x0001047a, 0xbefa5084,
-	0xbfc70000, 0xd7610002,
-	0x0001067a, 0xbefa5085,
-	0xbfc70000, 0xd7610002,
-	0x0001087a, 0xbefa5086,
-	0xbfc70000, 0xd7610002,
-	0x00010a7a, 0xbefa5087,
-	0xbfc70000, 0xd7610002,
-	0x00010c7a, 0xbefa5088,
-	0xbfc70000, 0xd7610002,
-	0x00010e7a, 0xbefa5089,
-	0xbfc70000, 0xd7610002,
-	0x0001107a, 0xbefa508a,
-	0xbfc70000, 0xd7610002,
-	0x0001127a, 0xbefa508b,
-	0xbfc70000, 0xd7610002,
-	0x0001147a, 0xbefa508c,
-	0xbfc70000, 0xd7610002,
-	0x0001167a, 0xbefa508d,
-	0xbfc70000, 0xd7610002,
-	0x0001187a, 0xbefa508e,
-	0xbfc70000, 0xd7610002,
-	0x00011a7a, 0xbefa508f,
-	0xbfc70000, 0xd7610002,
-	0x00011c7a, 0xbefa5090,
-	0xbfc70000, 0xd7610002,
-	0x00011e7a, 0xee0a4076,
-	0x010c0000, 0x00008000,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0xbef90080,
-	0xbefd0080, 0xbf800000,
+	0x00008000, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xbef90080, 0xbefd0080,
+	0xbf800000, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xbe8c410c,
+	0xbe8e410e, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
+	0x80798179, 0xd7610002,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
+	0x80798179, 0xd7610002,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
+	0x80798179, 0xd7610002,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
+	0x80798179, 0xd7610002,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
+	0x80798179, 0xd7610002,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xd7610002,
+	0x0000f20c, 0x80798179,
+	0xd7610002, 0x0000f20d,
+	0x80798179, 0xd7610002,
+	0x0000f20e, 0x80798179,
+	0xd7610002, 0x0000f20f,
+	0x80798179, 0xbf06a079,
+	0xbfa10009, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x010c0000, 0x00000000,
+	0x8070ff70, 0x00000080,
+	0xbef90080, 0x7e040280,
+	0x807d907d, 0xbf0aff7d,
+	0x00000060, 0xbfa2ffb9,
 	0xbe804100, 0xbe824102,
 	0xbe844104, 0xbe864106,
 	0xbe884108, 0xbe8a410a,
-	0xbe8c410c, 0xbe8e410e,
 	0xd7610002, 0x0000f200,
 	0x80798179, 0xd7610002,
 	0x0000f201, 0x80798179,
@@ -4891,63 +5052,39 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xd7610002, 0x0000f20a,
 	0x80798179, 0xd7610002,
 	0x0000f20b, 0x80798179,
-	0xd7610002, 0x0000f20c,
-	0x80798179, 0xd7610002,
-	0x0000f20d, 0x80798179,
-	0xd7610002, 0x0000f20e,
-	0x80798179, 0xd7610002,
-	0x0000f20f, 0x80798179,
-	0xbf06a079, 0xbfa10009,
+	0xbefe00ff, 0x0000ffff,
 	0x80767074, 0x82778075,
 	0xee0a4076, 0x010c0000,
-	0x00000000, 0x8070ff70,
-	0x00000080, 0xbef90080,
-	0x7e040280, 0x807d907d,
-	0xbf0aff7d, 0x00000060,
-	0xbfa2ffb9, 0xbe804100,
-	0xbe824102, 0xbe844104,
-	0xbe864106, 0xbe884108,
-	0xbe8a410a, 0xd7610002,
-	0x0000f200, 0x80798179,
-	0xd7610002, 0x0000f201,
-	0x80798179, 0xd7610002,
-	0x0000f202, 0x80798179,
-	0xd7610002, 0x0000f203,
-	0x80798179, 0xd7610002,
-	0x0000f204, 0x80798179,
-	0xd7610002, 0x0000f205,
-	0x80798179, 0xd7610002,
-	0x0000f206, 0x80798179,
-	0xd7610002, 0x0000f207,
-	0x80798179, 0xd7610002,
-	0x0000f208, 0x80798179,
-	0xd7610002, 0x0000f209,
-	0x80798179, 0xd7610002,
-	0x0000f20a, 0x80798179,
-	0xd7610002, 0x0000f20b,
-	0x80798179, 0xbefe00ff,
-	0x0000ffff, 0x80767074,
+	0x00000000, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8fb4306,
+	0x8b7bc17b, 0xbfa10042,
+	0x8b7aff6d, 0x80000000,
+	0xbfa1003f, 0x847b8a7b,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0x8070ff70,
+	0x00000200, 0x8070ff70,
+	0x00000200, 0xd71f0000,
+	0x000100c1, 0xd7200000,
+	0x000200c1, 0x16000084,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa20015, 0xbe8300ff,
+	0x00000080, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8a0000, 0x80767074,
 	0x82778075, 0xee0a4076,
-	0x010c0000, 0x00000000,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8fb4306, 0x8b7bc17b,
-	0xbfa10042, 0x8b7aff6d,
-	0x80000000, 0xbfa1003f,
-	0x847b8a7b, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0x8070ff70, 0x00000200,
-	0x8070ff70, 0x00000200,
-	0xd71f0000, 0x000100c1,
-	0xd7200000, 0x000200c1,
-	0x16000084, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbefd0080, 0xbfa20015,
-	0xbe8300ff, 0x00000080,
+	0x008c0000, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff1, 0xbfa00014,
+	0xbe8300ff, 0x00000100,
 	0xbf800000, 0xbf800000,
 	0xbf800000, 0xd8d80000,
 	0x01000000, 0xbf8a0000,
@@ -4955,252 +5092,242 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xee0a4076, 0x008c0000,
 	0x00000000, 0x807d037d,
 	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000080,
+	0x0001ff00, 0x00000100,
 	0xbf0a7b7d, 0xbfa2fff1,
-	0xbfa00014, 0xbe8300ff,
-	0x00000100, 0xbf800000,
-	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf8a0000, 0x80767074,
-	0x82778075, 0xee0a4076,
-	0x008c0000, 0x00000000,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000100, 0xbf0a7b7d,
-	0xbfa2fff1, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20004,
-	0xbef000ff, 0x00000200,
-	0xbeff0080, 0xbfa00003,
-	0xbef000ff, 0x00000400,
-	0xbeff00c1, 0xb8fb3b05,
-	0x807b817b, 0x847b827b,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa2001b,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20004, 0xbef000ff,
+	0x00000200, 0xbeff0080,
+	0xbfa00003, 0xbef000ff,
+	0x00000400, 0xbeff00c1,
+	0xb8fb3b05, 0x807b817b,
+	0x847b827b, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2001b, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10032,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
+	0x80767074, 0x82778075,
+	0xee0a4076, 0x000c0000,
+	0x00000000, 0xee0a4076,
+	0x008c0000, 0x00008000,
+	0xee0a4076, 0x010c0000,
+	0x00010000, 0xee0a4076,
+	0x018c0000, 0x00018000,
+	0x807d847d, 0x8070ff70,
+	0x00000200, 0xbf0a7b7d,
+	0xbfa2ffe9, 0xbfa0001a,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10032, 0x7e008700,
+	0xbfa10017, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0x80767074,
 	0x82778075, 0xee0a4076,
 	0x000c0000, 0x00000000,
 	0xee0a4076, 0x008c0000,
-	0x00008000, 0xee0a4076,
-	0x010c0000, 0x00010000,
+	0x00010000, 0xee0a4076,
+	0x010c0000, 0x00020000,
 	0xee0a4076, 0x018c0000,
-	0x00018000, 0x807d847d,
-	0x8070ff70, 0x00000200,
+	0x00030000, 0x807d847d,
+	0x8070ff70, 0x00000400,
 	0xbf0a7b7d, 0xbfa2ffe9,
-	0xbfa0001a, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10017,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
-	0x80767074, 0x82778075,
-	0xee0a4076, 0x000c0000,
-	0x00000000, 0xee0a4076,
-	0x008c0000, 0x00010000,
-	0xee0a4076, 0x010c0000,
-	0x00020000, 0xee0a4076,
-	0x018c0000, 0x00030000,
-	0x807d847d, 0x8070ff70,
-	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffe9, 0xbfa00180,
-	0xbef4007e, 0x8b75ff7f,
-	0x01ffffff, 0xbef1007f,
-	0xb8f20742, 0x84729972,
-	0x8b6eff7f, 0x04000000,
-	0xbfa10044, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef4306,
-	0x8b6fc16f, 0xbfa10039,
-	0x846f8a6f, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000200,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xd71f0001, 0x000100c1,
-	0xd7200001, 0x000202c1,
-	0x30020282, 0xbfa20012,
-	0x80767874, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xbf8a0000,
-	0xd8340000, 0x00000001,
-	0xd5250001, 0x0001ff01,
-	0x00000080, 0x807dff7d,
-	0x00000080, 0x8078ff78,
-	0x00000080, 0xbf0a6f7d,
-	0xbfa2ffef, 0xbfa00011,
-	0x80767874, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xbf8a0000,
-	0xd8340000, 0x00000001,
-	0xd5250001, 0x0001ff01,
-	0x00000100, 0x807dff7d,
-	0x00000100, 0x8078ff78,
-	0x00000100, 0xbf0a6f7d,
-	0xbfa2ffef, 0xbef80080,
+	0xbfa00180, 0xbef4007e,
+	0x8b75ff7f, 0x01ffffff,
+	0xbef1007f, 0xb8f20742,
+	0x84729972, 0x8b6eff7f,
+	0x04000000, 0xbfa10044,
 	0xbefe00c1, 0x857d9972,
 	0x8b7d817d, 0xbf06817d,
 	0xbfa20002, 0xbeff0080,
 	0xbfa00001, 0xbeff00c1,
-	0xb8ef3b05, 0x806f816f,
-	0x846f826f, 0x857d9972,
+	0xb8ef4306, 0x8b6fc16f,
+	0xbfa10039, 0x846f8a6f,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000200, 0x857d9972,
 	0x8b7d817d, 0xbf06817d,
-	0xbfa2002c, 0xbeee0078,
-	0x8078ff78, 0x00000200,
-	0xbefd0084, 0x80767874,
-	0x82778075, 0xee0a0076,
-	0x000c0000, 0x00000000,
-	0xee0a0076, 0x000c0001,
-	0x00008000, 0xee0a0076,
-	0x000c0002, 0x00010000,
-	0xee0a0076, 0x000c0003,
-	0x00018000, 0xbf8a0000,
-	0x7e008500, 0x7e028501,
-	0x7e048502, 0x7e068503,
-	0x807d847d, 0x8078ff78,
-	0x00000200, 0xbf0a6f7d,
-	0xbfa2ffe8, 0x80766e74,
+	0xbefd0080, 0xd71f0001,
+	0x000100c1, 0xd7200001,
+	0x000202c1, 0x30020282,
+	0xbfa20012, 0x80767874,
 	0x82778075, 0xee0a0076,
 	0x000c0000, 0x00000000,
-	0xee0a0076, 0x000c0001,
-	0x00008000, 0xee0a0076,
-	0x000c0002, 0x00010000,
-	0xee0a0076, 0x000c0003,
-	0x00018000, 0xbf8a0000,
-	0xbfa0002d, 0xbeee0078,
-	0x8078ff78, 0x00000400,
-	0xbefd0084, 0xbf0a6f7d,
-	0xbfa10018, 0x80767874,
+	0xbf8a0000, 0xd8340000,
+	0x00000001, 0xd5250001,
+	0x0001ff01, 0x00000080,
+	0x807dff7d, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2ffef,
+	0xbfa00011, 0x80767874,
 	0x82778075, 0xee0a0076,
 	0x000c0000, 0x00000000,
-	0xee0a0076, 0x000c0001,
+	0xbf8a0000, 0xd8340000,
+	0x00000001, 0xd5250001,
+	0x0001ff01, 0x00000100,
+	0x807dff7d, 0x00000100,
+	0x8078ff78, 0x00000100,
+	0xbf0a6f7d, 0xbfa2ffef,
+	0xbef80080, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef3b05,
+	0x806f816f, 0x846f826f,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa2002c,
+	0xbeee0078, 0x8078ff78,
+	0x00000200, 0xbefd0084,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xee0a0076,
+	0x000c0001, 0x00008000,
+	0xee0a0076, 0x000c0002,
 	0x00010000, 0xee0a0076,
-	0x000c0002, 0x00020000,
-	0xee0a0076, 0x000c0003,
-	0x00030000, 0xbf8a0000,
-	0x7e008500, 0x7e028501,
-	0x7e048502, 0x7e068503,
-	0x807d847d, 0x8078ff78,
-	0x00000400, 0xbf0a6f7d,
-	0xbfa2ffe8, 0x80766e74,
-	0x82778075, 0xee0a0076,
-	0x000c0000, 0x00000000,
-	0xee0a0076, 0x000c0001,
+	0x000c0003, 0x00018000,
+	0xbf8a0000, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x8078ff78, 0x00000200,
+	0xbf0a6f7d, 0xbfa2ffe8,
+	0x80766e74, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xee0a0076,
+	0x000c0001, 0x00008000,
+	0xee0a0076, 0x000c0002,
 	0x00010000, 0xee0a0076,
-	0x000c0002, 0x00020000,
-	0xee0a0076, 0x000c0003,
-	0x00030000, 0xbf8a0000,
-	0xb8f83b05, 0x80788178,
-	0xbf0d9972, 0xbfa20002,
-	0x84788978, 0xbfa00001,
-	0x84788a78, 0x8078ff78,
-	0x00000200, 0x80f8ff78,
-	0x00000060, 0x80767874,
-	0x82778075, 0xbefd00ff,
-	0x0000006c, 0xf460403b,
-	0xf8000000, 0xbf8a0000,
-	0x80fd847d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0x80f6a076, 0x82f78077,
-	0xf460603b, 0xf8000000,
-	0xbf8a0000, 0x80fd887d,
+	0x000c0003, 0x00018000,
+	0xbf8a0000, 0xbfa0002d,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefd0084,
+	0xbf0a6f7d, 0xbfa10018,
+	0x80767874, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xee0a0076,
+	0x000c0001, 0x00010000,
+	0xee0a0076, 0x000c0002,
+	0x00020000, 0xee0a0076,
+	0x000c0003, 0x00030000,
+	0xbf8a0000, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7d, 0xbfa2ffe8,
+	0x80766e74, 0x82778075,
+	0xee0a0076, 0x000c0000,
+	0x00000000, 0xee0a0076,
+	0x000c0001, 0x00010000,
+	0xee0a0076, 0x000c0002,
+	0x00020000, 0xee0a0076,
+	0x000c0003, 0x00030000,
+	0xbf8a0000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0x8078ff78, 0x00000200,
+	0x80f8ff78, 0x00000060,
+	0x80767874, 0x82778075,
+	0xbefd00ff, 0x0000006c,
+	0xf460403b, 0xf8000000,
+	0xbf8a0000, 0x80fd847d,
 	0xbf800000, 0xbe804300,
-	0xbe824302, 0xbe844304,
-	0xbe864306, 0x80f6c076,
-	0x82f78077, 0xf460803b,
+	0xbe824302, 0x80f6a076,
+	0x82f78077, 0xf460603b,
 	0xf8000000, 0xbf8a0000,
-	0x80fd907d, 0xbf800000,
+	0x80fd887d, 0xbf800000,
 	0xbe804300, 0xbe824302,
 	0xbe844304, 0xbe864306,
-	0xbe884308, 0xbe8a430a,
-	0xbe8c430c, 0xbe8e430e,
-	0xbf06807d, 0xbfa1ffef,
-	0xb980f801, 0x00000000,
-	0xb8f83b05, 0x80788178,
-	0xbf0d9972, 0xbfa20002,
-	0x84788978, 0xbfa00001,
-	0x84788a78, 0x8078ff78,
-	0x00000200, 0x80767874,
-	0x82778075, 0xbeff0071,
-	0xf4601bfb, 0xf8000000,
-	0xf4601b3b, 0xf8000004,
-	0xf4601b7b, 0xf8000008,
-	0xf4601c3b, 0xf800000c,
-	0xf4601c7b, 0xf8000010,
-	0xf4601ebb, 0xf8000014,
-	0xf4601efb, 0xf8000018,
-	0xf4601e7b, 0xf800001c,
-	0xf4601cfb, 0xf8000020,
-	0xf4601bbb, 0xf8000024,
-	0xbf8a0000, 0xb96ef814,
-	0xf4601bbb, 0xf8000028,
-	0xbf8a0000, 0xb96ef815,
-	0xf4601bbb, 0xf800002c,
-	0xbf8a0000, 0xb96ef812,
-	0xf4601bbb, 0xf8000030,
-	0xbf8a0000, 0xb96ef813,
-	0x8b6eff7f, 0x04000000,
-	0xbfa10022, 0xf4601bbb,
-	0xf8000038, 0xbf8a0000,
-	0xbf0d806e, 0xbfa1001d,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804ec1,
-	0x816ec16e, 0xbfa0fffb,
-	0xbef800ff, 0x00000080,
-	0xbefd0081, 0xf4601bbb,
-	0xf0000000, 0xbfc70000,
-	0x80788478, 0x937eff6e,
-	0x00070004, 0x847e907e,
-	0x8c7d7e7d, 0xbe80517d,
-	0x917dff7d, 0x007f0000,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804e7d,
-	0x816ec16e, 0xbfa0fffb,
-	0x807d817d, 0xbf08907d,
-	0xbfa1ffec, 0xf4601bbb,
-	0xf800003c, 0xbfc70000,
-	0xbf0d806e, 0xbfa1000c,
-	0xbf0d9a7f, 0xbfa10002,
-	0xbf068180, 0xbe804fc4,
-	0xbf94fffc, 0xbfa10006,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804ec3,
-	0x816ec16e, 0xbfa0fffb,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0xb979f822,
-	0xb97b2011, 0x857b867b,
-	0xb97b0191, 0x857b827b,
-	0xb97bba11, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
-	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0x806eff6e,
-	0x000001c0, 0x806e746e,
-	0x826f8075, 0xf4605c37,
-	0xf8000010, 0xf4605d37,
-	0xf8000020, 0xf4601e77,
-	0xf8000034, 0xbf8a0000,
-	0x856e9677, 0xb96e04a1,
-	0x856e9577, 0xb96e0421,
-	0x856e8e77, 0xb96e3021,
-	0x8b6dff6d, 0x01ffffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0xb97af804, 0xb8eef802,
-	0xbf0c8b6e, 0xbfa20003,
-	0xbe804fc2, 0xbf94fffe,
-	0xbfa10001, 0xbe804ec4,
-	0xbf94fffc, 0x857a897a,
-	0xb97a0244, 0xbe804a6c,
+	0x80f6c076, 0x82f78077,
+	0xf460803b, 0xf8000000,
+	0xbf8a0000, 0x80fd907d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0xbe884308,
+	0xbe8a430a, 0xbe8c430c,
+	0xbe8e430e, 0xbf06807d,
+	0xbfa1ffef, 0xb980f801,
+	0x00000000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0x8078ff78, 0x00000200,
+	0x80767874, 0x82778075,
+	0xbeff0071, 0xf4601bfb,
+	0xf8000000, 0xf4601b3b,
+	0xf8000004, 0xf4601b7b,
+	0xf8000008, 0xf4601c3b,
+	0xf800000c, 0xf4601c7b,
+	0xf8000010, 0xf4601ebb,
+	0xf8000014, 0xf4601efb,
+	0xf8000018, 0xf4601e7b,
+	0xf800001c, 0xf4601cfb,
+	0xf8000020, 0xf4601bbb,
+	0xf8000024, 0xbf8a0000,
+	0xb96ef814, 0xf4601bbb,
+	0xf8000028, 0xbf8a0000,
+	0xb96ef815, 0xf4601bbb,
+	0xf800002c, 0xbf8a0000,
+	0xb96ef812, 0xf4601bbb,
+	0xf8000030, 0xbf8a0000,
+	0xb96ef813, 0x8b6eff7f,
+	0x04000000, 0xbfa10022,
+	0xf4601bbb, 0xf8000038,
+	0xbf8a0000, 0xbf0d806e,
+	0xbfa1001d, 0x856e906e,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec1, 0x816ec16e,
+	0xbfa0fffb, 0xbef800ff,
+	0x00000080, 0xbefd0081,
+	0xf4601bbb, 0xf0000000,
+	0xbfc70000, 0x80788478,
+	0x937eff6e, 0x00070004,
+	0x847e907e, 0x8c7d7e7d,
+	0xbe80517d, 0x917dff7d,
+	0x007f0000, 0x856e906e,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804e7d, 0x816ec16e,
+	0xbfa0fffb, 0x807d817d,
+	0xbf08907d, 0xbfa1ffec,
+	0xf4601bbb, 0xf800003c,
+	0xbfc70000, 0xbf0d806e,
+	0xbfa1000c, 0xbf0d9a7f,
+	0xbfa10002, 0xbf068180,
+	0xbe804fc4, 0xbf94fffc,
+	0xbfa10006, 0x856e906e,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec3, 0x816ec16e,
+	0xbfa0fffb, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0xb979f822, 0xb97b2011,
+	0x857b867b, 0xb97b0191,
+	0x857b827b, 0xb97bba11,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0x806eff6e, 0x000001c0,
+	0x806e746e, 0x826f8075,
+	0xf4605c37, 0xf8000010,
+	0xf4605d37, 0xf8000020,
+	0xf4601e77, 0xf8000034,
+	0xbf8a0000, 0x856e9677,
+	0xb96e04a1, 0x856e9577,
+	0xb96e0421, 0x856e8e77,
+	0xb96e3021, 0x8b6dff6d,
+	0x01ffffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb97af804,
 	0xb8eef802, 0xbf0c8b6e,
 	0xbfa20003, 0xbe804fc2,
 	0xbf94fffe, 0xbfa10001,
 	0xbe804ec4, 0xbf94fffc,
-	0xbfb10000, 0xbf9f0000,
+	0x857a897a, 0xb97a0244,
+	0xbe804a6c, 0xb8eef802,
+	0xbf0c8b6e, 0xbfa20003,
+	0xbe804fc2, 0xbf94fffe,
+	0xbfa10001, 0xbe804ec4,
+	0xbf94fffc, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index d59400d242d19..b7b82f1c6072f 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -73,6 +73,7 @@ var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
 #endif
 
 var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
+var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_SHIFT	= 4
 var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
 var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
 var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
@@ -362,6 +363,15 @@ L_TRAP_CASE:
 L_EXIT_TRAP:
 	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
 
+#if HAVE_BANKED_VGPRS
+	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	fixup_vgpr_bank_selection()
+#endif
+
+#if HAVE_XNACK
+	restore_xnack_state_priv(s_save_tmp)
+#endif
+
 	// Restore SQ_WAVE_STATUS.
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
@@ -390,6 +400,14 @@ L_HAVE_VGPRS:
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
+#if HAVE_XNACK
+	save_and_clear_xnack_state_priv(s_save_tmp)
+#endif
+
+#if HAVE_BANKED_VGPRS
+	fixup_vgpr_bank_selection()
+#endif
+
 	/* inform SPI the readiness and wait for SPI's go signal */
 	s_mov_b32	s_save_exec_lo, exec_lo					//save EXEC and use EXEC for the go signal from SPI
 	s_mov_b32	s_save_exec_hi, exec_hi
@@ -404,7 +422,6 @@ L_HAVE_VGPRS:
 	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
 
 #if HAVE_XNACK
-	save_and_clear_xnack_state_priv(s_save_tmp)
 	s_getreg_b32	s_save_xnack_mask, hwreg(HW_REG_WAVE_XNACK_MASK)
 	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_MASK), 0
 #endif
@@ -1328,3 +1345,150 @@ L_BARRIER_RESTORE_LOOP:
 
 L_BARRIER_RESTORE_DONE:
 end
+
+#if HAVE_BANKED_VGPRS
+function fixup_vgpr_bank_selection
+	// PC read may fault if memory violation has been asserted.
+	// In this case no further progress is expected so fixup is not needed.
+	s_bitcmp1_b32	s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_SHIFT
+	s_cbranch_scc1	L_FIXUP_DONE
+
+	// ttmp[0:1]: {7b'0} PC[56:0]
+	// ttmp2, 3, 10, 13, 14, 15: free
+	s_load_b64	[ttmp14, ttmp15], [ttmp0, ttmp1], 0 scope:SCOPE_CU	// Load the 2 instruction DW we are returning to
+	s_load_b64	[ttmp2, ttmp3], [ttmp0, ttmp1], 8 scope:SCOPE_CU	// Load the next 2 instruction DW, just in case
+	s_wait_kmcnt	1
+	s_and_b32	ttmp10, ttmp14, 0x80000000				// Check bit 31 in the first DWORD
+										// SCC set if ttmp10 is != 0, i.e. if bit 31 == 1
+	s_cbranch_scc1	L_FIXUP_NOT_VOP12C					// If bit 31 is 1, we are not VOP1, VOP2, or VOP3C
+	// Fall through here means bit 31 == 0, meaning we are VOP1, VOP2, or VOPC
+	// Size of instruction depends on Opcode or SRC0_9
+	// Check for VOP2 opcode
+	s_bfe_u32	ttmp10, ttmp14, (25 | (6 << 0x10))			// Check bits 30:25 for VOP2 Opcode
+	// VOP2 V_FMAMK_F64 of V_FMAAK_F64 has implied 64-bit literature, 3 DW
+	s_sub_co_i32	ttmp13, ttmp10, 0x23					// V_FMAMK_F64 is 0x23, V_FMAAK_F64 is 0x24
+	s_cmp_le_u32	ttmp13, 0x1						// 0==0x23, 1==0x24
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If either, this is 3 DWORD inst
+	// VOP2 V_FMAMK_F32, V_FMAAK_F32, V_FMAMK_F16, V_FMAAK_F16, 2 DW
+	s_sub_co_i32	ttmp13, ttmp10, 0x2c					// V_FMAMK_F32 is 0x2c, V_FMAAK_F32 is 0x2d
+	s_cmp_le_u32	ttmp13, 0x1						// 0==0x2c, 1==0x2d
+	s_cbranch_scc1	L_FIXUP_TWO_DWORD					// If either, this is 2 DWORD inst
+	s_sub_co_i32	ttmp13, ttmp10, 0x37					// V_FMAMK_F16 is 0x37, V_FMAAK_F16 is 0x38
+	s_cmp_le_u32	ttmp13, 0x1						// 0==0x37, 1==0x38
+	s_cbranch_scc1	L_FIXUP_TWO_DWORD					// If either, this is 2 DWORD inst
+	// Check SRC0_9 for VOP1, VOP2, and VOPC
+	s_and_b32	ttmp10, ttmp14, 0x1ff					// Check bits 8:0 for SRC0_9
+	// Literal constant 64 is 3 DWORDs
+	s_cmp_eq_u32	ttmp10, 0xfe						// 0xfe == 254 == Literal constant64
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	// Literal constant 32, DPP16, DPP8, and DPP8FI are 2 DWORDs
+	s_cmp_eq_u32	ttmp10, 0xff						// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_TWO_DWORD					// 2 DWORD inst
+	s_cmp_eq_u32	ttmp10, 0xfa						// 0xfa == 250 = DPP16
+	s_cbranch_scc1	L_FIXUP_TWO_DWORD					// 2 DWORD inst
+	s_sub_co_i32	ttmp13, ttmp10, 0xe9					// DPP8 is 0xe9, DPP8FI is 0xea
+	s_cmp_le_u32	ttmp13, 0x1						// 0==0xe9, 1==0xea
+	s_cbranch_scc1	L_FIXUP_TWO_DWORD					// If either, this is 2 DWORD inst
+	// Instruction is 1 DWORD otherwise
+
+L_FIXUP_ONE_DWORD:
+	// Check if TTMP15 contains the value for S_SET_VGPR_MSB instruction
+	s_and_b32	ttmp10, ttmp15, 0xffff0000				// Check encoding in upper 16 bits
+	s_cmp_eq_u32	ttmp10, 0xbf860000					// Check if SOPP (9b'10_1111111) and S_SET_VGPR_MSB (7b'0000110)
+	s_cbranch_scc0	L_FIXUP_DONE						// No problem, no fixup needed
+	// VALU op followed by a S_SET_VGPR_MSB. Need to pull SIMM[15:8] to fix up MODE.*_VGPR_MSB
+	s_bfe_u32	ttmp10, ttmp15, (14 | (2 << 0x10))			// Shift SIMM[15:14] over to 1:0, Dst
+	s_and_b32	ttmp13, ttmp15, 0x3f00					// Mask to get SIMM[13:8] only
+	s_lshr_b32	ttmp13, ttmp13, 6					// Shift SIMM[13:8] into 7:2, Src2, Src1, Src0
+	s_or_b32	ttmp10, ttmp10, ttmp13					// Src2, Src1, Src0, Dst --> format in MODE register
+	s_setreg_b32	hwreg(HW_REG_WAVE_MODE, 12, 8), ttmp10			// Write value into MODE[19:12]
+	s_branch	L_FIXUP_DONE
+
+L_FIXUP_NOT_VOP12C:
+	// ttmp[0:1]: {7b'0} PC[56:0]
+	// ttmp2: PC+2 value (not waitcnt'ed yet)
+	// ttmp3: PC+3 value (not waitcnt'ed yet)
+	// ttmp10, ttmp13: free
+	// ttmp14: PC+O value
+	// ttmp15: PC+1 value
+	// Not VOP1, VOP2, or VOPC.
+	// Check if we are VOP3 or VOP3SD
+	s_and_b32	ttmp10, ttmp14, 0xfc000000				// Bits 31:26
+	s_cmp_eq_u32	ttmp10, 0xd4000000					// If 31:26 = 0x35, this is VOP3 or VOP3SD
+	s_cbranch_scc1	L_FIXUP_CHECK_VOP3					// If VOP3 or VOP3SD, need to check SRC2_9, SRC1_9, SRC0_9
+	// Not VOP1, VOP2, VOPC, VOP3, or VOP3SD.
+	// Check for VOPD
+	s_cmp_eq_u32	ttmp10, 0xc8000000					// If 31:26 = 0x32, this is VOPD
+	s_cbranch_scc1	L_FIXUP_CHECK_VOPD					// If VOPD, need to check OpX, OpY, SRCX0 and SRCY0
+	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD.
+	// Check if we are VOPD3
+	s_and_b32	ttmp10, ttmp14, 0xff000000				// Bits 31:24
+	s_cmp_eq_u32	ttmp10, 0xcf000000					// If 31:24 = 0xcf, this is VOPD3
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If VOPD3, 3 DWORD inst
+	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
+	// Might be in VOP3P, but we must ensure we are not VOP3PX2
+	s_and_b32	ttmp13, ttmp14, 0xffff0000				// Bits 31:16
+	s_cmp_eq_u32	ttmp13, 0xcc350000					// If 31:16 = 0xcc35, this is VOP3PX2
+	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
+	s_cmp_eq_u32	ttmp13, 0xcc3a0000					// If 31:16 = 0xcc3a, this is VOP3PX2
+	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
+	// Check if we are VOP3P
+	s_cmp_eq_u32	ttmp10, 0xcc000000					// If 31:24 = 0xcc, this is VOP3P
+	s_cbranch_scc0	L_FIXUP_DONE						// Not in VOP3P, so instruction is not VOP1, VOP2,
+										// VOPC, VOP3, VOP3SD, VOP3P, VOPD, or VOPD3
+										// No fixup needed.
+	// Fall-through if we are in VOP3P to check SRC2_9, SRC1_9, and SRC0_9
+L_FIXUP_CHECK_VOP3:
+	// Start with Src0, which is in bits 8:0 of second instruction DW, ttmp15
+	s_and_b32	ttmp10, ttmp15, 0x1ff					// Mask out unused bits
+	// Src0_9 == Literal constant 32, DPP16, DPP8, and DPP8FI means 3 DWORDs
+	s_cmp_eq_u32	ttmp10, 0xff						// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	s_cmp_eq_u32	ttmp10, 0xfa						// 0xfa == 250 = DPP16
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	s_sub_co_i32	ttmp10, ttmp10, 0xe9					// DPP8 is 0xe9, DPP8FI is 0xea
+	s_cmp_le_u32	ttmp10, 0x1						// 0==0xe9, 1==0xea
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If either, this is 3 DWORD inst
+	s_and_b32	ttmp10, ttmp15, 0x3fe00					// Next is Src1, which is in 17:9
+	s_cmp_eq_u32	ttmp10, 0x1fe00						// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	s_and_b32	ttmp10, ttmp15, 0x7fc0000				// Next is Src2, which is in 26:18
+	s_cmp_eq_u32	ttmp10, 0x3fc0000					// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	s_branch	L_FIXUP_TWO_DWORD					// No special encodings, VOP3* is 2 Dword
+
+L_FIXUP_CHECK_VOPD:
+	// OpX being V_DUAL_FMA*K_F32 means 3 DWORDs
+	s_bfe_u32	ttmp10, ttmp14, (22 | (4 << 0x10))			// OPX is bits 25:22
+	s_sub_co_i32	ttmp10, ttmp10, 0x1					// V_DUAL_FMAAK_F32 is 0x1, V_DUAL_FMAMK_F32 is 0x2
+	s_cmp_le_u32	ttmp10, 0x1						// 0==0x1, 1==0x2
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If either, this is 3 DWORD inst
+	// OpY being V_DUAL_FMA*K_F32 means 3 DWORDs
+	s_bfe_u32	ttmp10, ttmp14, (17 | (5 << 0x10))			// OPX is bits 21:17
+	s_sub_co_i32	ttmp10, ttmp10, 0x1					// V_DUAL_FMAAK_F32 is 0x1, V_DUAL_FMAMK_F32 is 0x2
+	s_cmp_le_u32	ttmp10, 0x1						// 0==0x1, 1==0x2
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If either, this is 3 DWORD inst
+	// SRCX0 == Literal constant 32 means 3 DWORDs
+	s_and_b32	ttmp10, ttmp14, 0x1ff					// SRCX0 is in bits 8:0 of 1st DWORD
+	s_cmp_eq_u32	ttmp10, 0xff						// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+	// SRCY0 == Literal constant 32 means 3 DWORDs
+	s_and_b32	ttmp10, ttmp15, 0x1ff					// SRCY0 is in bits 8:0 of 2nd DWORD
+	s_cmp_eq_u32	ttmp10, 0xff						// 0xff == 255 = Literal constant32
+	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// 3 DWORD inst
+										// If otherwise, no special encodings. Default VOPD is 2 Dword
+										// Fall-thru if true, because this is a 2 DWORD inst
+L_FIXUP_TWO_DWORD:
+	s_wait_kmcnt	0							// Wait for PC+2 and PC+3 to arrive in ttmp2 and ttmp3
+	s_mov_b32	ttmp15, ttmp2						// Move possible S_SET_VGPR_MSB into ttmp15
+	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
+
+L_FIXUP_THREE_DWORD:
+	s_wait_kmcnt	0							// Wait for PC+2 and PC+3 to arrive in ttmp2 and ttmp3
+	s_mov_b32	ttmp15, ttmp3						// Move possible S_SET_VGPR_MSB into ttmp15
+	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
+
+L_FIXUP_DONE:
+	s_wait_kmcnt	0							// Ensure load of ttmp2 and ttmp3 is done
+end
+#endif
-- 
2.52.0

