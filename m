Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A10CE8D67
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 17:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397D610E253;
	Fri, 14 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l59g+Hgd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A15610E253
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 17:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBt1QovcALjO2uixj3AGkP7Zj4F9iZq9+8IsB+ZgJFJo9shSLhtVOPhQAWIxYIHIgzmEDo8RYw/zOZw9r6YDmgZWpntQxp9egmkOK9dyX3Sir8KYf6kKB7+7cWpgJfgbdcbvshH3ip5U7JywdK6bISHbHoIUzSP11R/BwArgwiQ0Pivo8Gnp+pZZM9iw1nAMe4tbnjQejz5LqKlJ68H8+Cr9xU4zS8AyYG/xwGPA7Arl+m56J/0z7UoISDEJhoZoGtr65R+IjbafCXfWkJFw8chE98Aqb1Netk3voe4Pz11ACJF1PwUvdNC43iWjYa6Qvg67r6blagfWw30+WVR2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0TGd91C++5yLoA/vzlNHliO6NXOU9QlJVPlKKJxkB0=;
 b=oGQIXhLaMwWtKUnMOeO7O11jHXilUAQsmfBLVNyS36ZYsBthXgYXQo/1q7zicaKUQlbjjRDAjxi1jeabckhKu0CLWrF4zLWvYhFnTQncz4qanA6HoO2pRZkdnqAv49IAWEXxqrbR5ULP/IscZlwT8zqu0zZWsOCgb+zp81NZv93iGri81LFPBsAV/hwz20L/Dmz5hn4yanagPx2oTGV7lOrzvnBsiMCrSNtzrq1pMrh2YraUqUnaGOF0c0ByGCo1qQM2Zd9P6XDVj6BUNnhLhyuVoNXxctAPPAhjmM6XGdyYlKV6+BsbPH7yXoJlx2OFpaXgcMxQRuuxuVHVMj9EMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0TGd91C++5yLoA/vzlNHliO6NXOU9QlJVPlKKJxkB0=;
 b=l59g+HgdMgXGrcSCMN3dZsU1OPhfGgfTUHdRGX2Dj0mZJxwlbYE36cpszD6lYfN7X96brNx/i84nzNIhHUWnyOGI1lMG+bdnz+JprUE4Jmwyf5l91h6Y3V7CMmIrO2x41PtCzARvEW9GxQSh1p3iiKK4pyYql1I9ZZGtq9lA9EY=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 17:44:33 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::25) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 17:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 17:44:33 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 09:44:32 -0800
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH v2] drm/amdkfd: Trap handler support for expert scheduling mode
Date: Fri, 14 Nov 2025 11:44:07 -0600
Message-ID: <20251114174407.769287-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d342587-6203-4086-b19d-08de23a5789c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VkB8LxW2NUrBYaKOC7J+u9gu+Gp6YHwv+TJDDE/AM9bfG7c95q3Wr69J4V+Z?=
 =?us-ascii?Q?qScAAntIHSHMbBiiWeHF9B6rZz0wYZrtsF9RiWQegQVHsv9vZL6dULOPB9V7?=
 =?us-ascii?Q?BhK0k/Uv6euAcCB9/Od8NiQRe5oEtNs+mEPfVNvQ24ZOyTjuq0Q0tTyn1SuA?=
 =?us-ascii?Q?csMkKclTWqYzboH+XG3HCRjq8N5Do3BUZGSlfdWdbtJM4dpPz0sAbd8oAMmA?=
 =?us-ascii?Q?0SxF4mCSlRAK1w66Luwn/auMC28+dh5r7IAYgqrLpPPZefCJ6KVdkGq+h2ti?=
 =?us-ascii?Q?TsqNow5G0y0Nh78NC5u3xw6XxIcu/kDzUYRTGsreVNXxS0Qx3V5Mab6DJqsv?=
 =?us-ascii?Q?kjqixxPjlnJuqR8B7RVatqkxXd58PuCtRJHD341Y5E8+qzG2jdFNyZTTtHCn?=
 =?us-ascii?Q?pR+uc175ZTyun5MaWIeHwx2TizvbHJpvHeU5Njp3Qdob/ASsX7ppD8WQ9jdk?=
 =?us-ascii?Q?1sc4D258C5hxLjU25Cg/u+BrOh0xX6AO9tv687ga5vpQYaocqX1LpP5ayuHv?=
 =?us-ascii?Q?yOglk/uIWcuTlPVVDqZGxV+SIMM85lc7DzgoR38MXT5m5T1Gy/cLyZSjHXmI?=
 =?us-ascii?Q?lDylDrjgM+6rl+AZol8ACAugDOcU4FYma2Z23MrVMpgoatACttXR3KMkMpZe?=
 =?us-ascii?Q?98UH/XSAdGf8ks+K1zu04wG4LRhNFO7q1cnBPmxE1T6wgAzeG68EQrfZvlx8?=
 =?us-ascii?Q?ztwI7zvUzV3ITau48VCrg414oMDxXuDDyh+w9bHEiazQc//RWIKFPwadpjqr?=
 =?us-ascii?Q?+4127yAzccOdLOmx4dFOpti4w01itV5y/OUDWPbTD2hP0BdrrC+2KWUKI/R6?=
 =?us-ascii?Q?IASSJAHn9qK1aPhYhLh8hRbvEED3LCBCetu2Yd+ozsjpiJryZwPlwl5W+zEu?=
 =?us-ascii?Q?C8L/hE1idS/9581MgaPF36x4VmH5+IaY+9YNwR35CffxXFoTUdoIHMWHEVlx?=
 =?us-ascii?Q?RqFcrwUBmCQjYaegdIWxoO1aT1ciy3qcM5cxl0mNQn/XCwEJ8TkheVlmL5CY?=
 =?us-ascii?Q?x2zMyN0Ka+patCoDM6MdsNA9B7KHg+log8r6vM+bEuHJsmxFeBC1yaV7d855?=
 =?us-ascii?Q?Faiod2gYzlhneQMa82NLtJiVnh7/3gkQF0AOcn6YmojyKoXutXIqgLLE0f7K?=
 =?us-ascii?Q?4D8v1TKsvuM4Foxfxmuw5YFwaznECDLXB9/jCBXXTPlIVBC+rM7vs2/IMjEu?=
 =?us-ascii?Q?mBkXrqNyPOwoXLQT22f6YuUYsRKRPnhEEDLdNc3HlvfXaSEdKk18G4OINfwc?=
 =?us-ascii?Q?VkeoSh6shsQa7aEwTTpCozkU0/CwhR5tYj/veFfonDgsbG15Oc+A8TRtbVVs?=
 =?us-ascii?Q?6BfbpkqsUdJzf9T4wM6FN8vt/Kcaxga1I9gALcXDMwqa24hN7iOib9jU1BPW?=
 =?us-ascii?Q?1khRqMgs3pJd7tJJxOn/UInJwX4bI6wkIvdgTDoy6WAVJQ9y7dTJpNEAQVSZ?=
 =?us-ascii?Q?sWpHksdIiWu6jePRKwrAXLUmGxqE5nuYW3WDVDwIK2nckGZfQEJ25k66cuc/?=
 =?us-ascii?Q?pJSsAtM7Y4tq8QasxgVdZ46oKNQB9onaPu73vIT0qurNbOKtJU41mxCZw3kI?=
 =?us-ascii?Q?9aVyjawWpfs44XjFP3k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:44:33.2870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d342587-6203-4086-b19d-08de23a5789c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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

The trap handler may be entered with dependency checking disabled.
Wait for dependency counters and save/restore scheduling mode.

v2:

Use ttmp1 instead of ttmp11. ttmp11 is not zero-initialized.
While the trap handler does zero this field before use, a user-mode
second-level trap handler could not rely on this being zero when
using an older kernel mode driver.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 853 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  39 +-
 2 files changed, 468 insertions(+), 424 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 0320163b6e74..5b09fac1c09e 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3644,14 +3644,18 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa002a2,
-	0xb0804009, 0xb8f8f804,
+	0xbfa00001, 0xbfa002ad,
+	0xb0804009, 0xb8eef81a,
+	0xbf880000, 0xb980081a,
+	0x00000000, 0xb8f8f804,
+	0x916dff6d, 0x0c000000,
+	0x846e9a6e, 0x8c6d6e6d,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
 	0xbfa20018, 0x8b6ea07b,
-	0xbfa20042, 0xbf830010,
+	0xbfa20045, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
 	0x8b6eff7b, 0x00000bd0,
 	0xbfa20010, 0xb8eef812,
@@ -3662,7 +3666,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xf0000000, 0xbfa20005,
 	0x8b6fff6f, 0x00000200,
 	0xbfa20002, 0x8b6ea07b,
-	0xbfa2002c, 0xbefa4d82,
+	0xbfa2002f, 0xbefa4d82,
 	0xbf8a0000, 0x84fa887a,
 	0xbf0d8f7b, 0xbfa10002,
 	0x8c7bff7b, 0xffff0000,
@@ -3681,99 +3685,45 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00004000, 0x80ec886c,
 	0x82ed806d, 0xbfa00002,
 	0x806c846c, 0x826d806d,
+	0x936eff6d, 0x0002001a,
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
-	0x85788978, 0xb9783244,
-	0xbe804a6c, 0xb8faf802,
-	0xbf0d987a, 0xbfa10001,
-	0xbfb00000, 0x8b6dff6d,
-	0x0000ffff, 0xbefa0080,
-	0xb97a0151, 0xbeee007e,
-	0xbeef007f, 0xbefe0180,
-	0xbefe4d84, 0xbf8a0000,
-	0x8b7aff7f, 0x04000000,
-	0x847a857a, 0x8c6d7a6d,
-	0xbefa007e, 0x8b7bff7f,
-	0x0000ffff, 0xbefe00c1,
-	0xbeff00c1, 0xee0a407a,
-	0x000c0000, 0x00000000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb0742,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
-	0xb8fb1e06, 0x847b8a7b,
-	0x807a7b7a, 0x8b7bff7f,
-	0x0000ffff, 0x807aff7a,
-	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xd7610000,
-	0x00010870, 0xd7610000,
-	0x00010a71, 0xd7610000,
-	0x00010c72, 0xd7610000,
-	0x00010e73, 0xd7610000,
-	0x00011074, 0xd7610000,
-	0x00011275, 0xd7610000,
-	0x00011476, 0xd7610000,
-	0x00011677, 0xd7610000,
-	0x00011a79, 0xd7610000,
-	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xbefe00ff,
-	0x00003fff, 0xbeff0080,
+	0x85788978, 0xb96e081a,
+	0xb9783244, 0xbe804a6c,
+	0xb8faf802, 0xbf0d987a,
+	0xbfa10001, 0xbfb00000,
+	0x916dff6d, 0xf0000000,
+	0xbefa0080, 0xb97a0151,
+	0xbeee007e, 0xbeef007f,
+	0xbefe0180, 0xbefe4d84,
+	0xbf8a0000, 0x8b7aff7f,
+	0x04000000, 0x847a857a,
+	0x8c6d7a6d, 0xbefa007e,
+	0x8b7bff7f, 0x0000ffff,
+	0xbefe00c1, 0xbeff00c1,
 	0xee0a407a, 0x000c0000,
-	0x00004000, 0xd760007a,
-	0x00011d00, 0xd760007b,
-	0x00011f00, 0xbefe007a,
-	0xbeff007b, 0xbef4007e,
-	0x8b75ff7f, 0x0000ffff,
-	0x8c75ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x10807fac, 0xbef1007d,
-	0xbef00080, 0xb8f30742,
-	0x84739973, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00002,
-	0xbeff00c1, 0xbfa0000c,
-	0xbef600ff, 0x01000000,
-	0xc4068070, 0x008ce801,
-	0x00008000, 0xc4068070,
-	0x008ce802, 0x00010000,
-	0xc4068070, 0x008ce803,
-	0x00018000, 0xbfa0000b,
-	0xbef600ff, 0x01000000,
-	0xc4068070, 0x008ce801,
-	0x00010000, 0xc4068070,
-	0x008ce802, 0x00020000,
-	0xc4068070, 0x008ce803,
-	0x00030000, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0x7e000280,
-	0x7e020280, 0x7e040280,
-	0xbe804ec2, 0xbf94fffe,
-	0xb8faf804, 0x8b7a847a,
-	0x91788478, 0x8c787a78,
-	0x917aff6d, 0x80000000,
-	0xd7610002, 0x00010071,
-	0xd7610002, 0x0001026c,
-	0xd7610002, 0x0001047a,
-	0xd7610002, 0x0001066e,
-	0xd7610002, 0x0001086f,
-	0xd7610002, 0x00010a78,
-	0xd7610002, 0x00010e7b,
+	0x00000000, 0x7e000280,
+	0xbefe007a, 0xbeff007b,
+	0xb8fb0742, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0xb8fb1e06,
+	0x847b8a7b, 0x807a7b7a,
+	0x8b7bff7f, 0x0000ffff,
+	0x807aff7a, 0x00000200,
+	0x807a7e7a, 0x827b807b,
+	0xd7610000, 0x00010870,
+	0xd7610000, 0x00010a71,
+	0xd7610000, 0x00010c72,
+	0xd7610000, 0x00010e73,
+	0xd7610000, 0x00011074,
+	0xd7610000, 0x00011275,
+	0xd7610000, 0x00011476,
+	0xd7610000, 0x00011677,
+	0xd7610000, 0x00011a79,
+	0xd7610000, 0x00011c7e,
+	0xd7610000, 0x00011e7f,
 	0xd8500000, 0x00000000,
 	0xd8500000, 0x00000000,
 	0xd8500000, 0x00000000,
@@ -3782,113 +3732,54 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xd8500000, 0x00000000,
 	0xd8500000, 0x00000000,
 	0xd8500000, 0x00000000,
-	0xb8faf811, 0xd7610002,
-	0x00010c7a, 0xb8faf801,
-	0xd7610002, 0x0001107a,
-	0xb8faf814, 0xd7610002,
-	0x0001127a, 0xb8faf815,
-	0xd7610002, 0x0001147a,
-	0xb8faf812, 0xd7610002,
-	0x0001167a, 0xb8faf813,
-	0xd7610002, 0x0001187a,
-	0xb8faf802, 0xd7610002,
-	0x00011a7a, 0xbefa50c1,
-	0xbfc70000, 0xd7610002,
-	0x00011c7a, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
+	0xbefe00ff, 0x00003fff,
+	0xbeff0080, 0xee0a407a,
+	0x000c0000, 0x00004000,
+	0xd760007a, 0x00011d00,
+	0xd760007b, 0x00011f00,
+	0xbefe007a, 0xbeff007b,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xbef1007d, 0xbef00080,
+	0xb8f30742, 0x84739973,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00002, 0xbeff00c1,
+	0xbfa0000c, 0xbef600ff,
+	0x01000000, 0xc4068070,
+	0x008ce801, 0x00008000,
 	0xc4068070, 0x008ce802,
-	0x00000000, 0xbefe00c1,
+	0x00010000, 0xc4068070,
+	0x008ce803, 0x00018000,
+	0xbfa0000b, 0xbef600ff,
+	0x01000000, 0xc4068070,
+	0x008ce801, 0x00010000,
+	0xc4068070, 0x008ce802,
+	0x00020000, 0xc4068070,
+	0x008ce803, 0x00030000,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
 	0x84708a70, 0xb8fa1e06,
 	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
 	0xbef600ff, 0x01000000,
-	0xbef90080, 0xbefd0080,
-	0xbf800000, 0xbe804100,
-	0xbe824102, 0xbe844104,
-	0xbe864106, 0xbe884108,
-	0xbe8a410a, 0xbe8c410c,
-	0xbe8e410e, 0xbf068079,
-	0xbfa10032, 0xd7610002,
-	0x00010000, 0xd7610002,
-	0x00010201, 0xd7610002,
-	0x00010402, 0xd7610002,
-	0x00010603, 0xd7610002,
-	0x00010804, 0xd7610002,
-	0x00010a05, 0xd7610002,
-	0x00010c06, 0xd7610002,
-	0x00010e07, 0xd7610002,
-	0x00011008, 0xd7610002,
-	0x00011209, 0xd7610002,
-	0x0001140a, 0xd7610002,
-	0x0001160b, 0xd7610002,
-	0x0001180c, 0xd7610002,
-	0x00011a0d, 0xd7610002,
-	0x00011c0e, 0xd7610002,
-	0x00011e0f, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0x80799079,
-	0xbfa00038, 0xd7610002,
-	0x00012000, 0xd7610002,
-	0x00012201, 0xd7610002,
-	0x00012402, 0xd7610002,
-	0x00012603, 0xd7610002,
-	0x00012804, 0xd7610002,
-	0x00012a05, 0xd7610002,
-	0x00012c06, 0xd7610002,
-	0x00012e07, 0xd7610002,
-	0x00013008, 0xd7610002,
-	0x00013209, 0xd7610002,
-	0x0001340a, 0xd7610002,
-	0x0001360b, 0xd7610002,
-	0x0001380c, 0xd7610002,
-	0x00013a0d, 0xd7610002,
-	0x00013c0e, 0xd7610002,
-	0x00013e0f, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0xd8500000,
-	0x00000000, 0x80799079,
-	0xc4068070, 0x008ce802,
-	0x00000000, 0x8070ff70,
-	0x00000080, 0xbef90080,
-	0x7e040280, 0x807d907d,
-	0xbf0aff7d, 0x00000060,
-	0xbfa2ff88, 0xbe804100,
-	0xbe824102, 0xbe844104,
-	0xbe864106, 0xbe884108,
-	0xbe8a410a, 0xd7610002,
-	0x00010000, 0xd7610002,
-	0x00010201, 0xd7610002,
-	0x00010402, 0xd7610002,
-	0x00010603, 0xd7610002,
-	0x00010804, 0xd7610002,
-	0x00010a05, 0xd7610002,
-	0x00010c06, 0xd7610002,
-	0x00010e07, 0xd7610002,
-	0x00011008, 0xd7610002,
-	0x00011209, 0xd7610002,
-	0x0001140a, 0xd7610002,
-	0x0001160b, 0xd8500000,
+	0x7e000280, 0x7e020280,
+	0x7e040280, 0xbe804ec2,
+	0xbf94fffe, 0xb8faf804,
+	0x8b7a847a, 0x91788478,
+	0x8c787a78, 0x917aff6d,
+	0x80000000, 0xd7610002,
+	0x00010071, 0xd7610002,
+	0x0001026c, 0xd7610002,
+	0x0001047a, 0xd7610002,
+	0x0001066e, 0xd7610002,
+	0x0001086f, 0xd7610002,
+	0x00010a78, 0xd7610002,
+	0x00010e7b, 0xd8500000,
 	0x00000000, 0xd8500000,
 	0x00000000, 0xd8500000,
 	0x00000000, 0xd8500000,
@@ -3896,273 +3787,389 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00000000, 0xd8500000,
 	0x00000000, 0xd8500000,
 	0x00000000, 0xd8500000,
-	0x00000000, 0xc4068070,
+	0x00000000, 0xb8faf811,
+	0xd7610002, 0x00010c7a,
+	0xb8faf801, 0xd7610002,
+	0x0001107a, 0xb8faf814,
+	0xd7610002, 0x0001127a,
+	0xb8faf815, 0xd7610002,
+	0x0001147a, 0xb8faf812,
+	0xd7610002, 0x0001167a,
+	0xb8faf813, 0xd7610002,
+	0x0001187a, 0xb8faf802,
+	0xd7610002, 0x00011a7a,
+	0xbefa50c1, 0xbfc70000,
+	0xd7610002, 0x00011c7a,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xbefe00ff, 0x0000ffff,
+	0xbeff0080, 0xc4068070,
+	0x008ce802, 0x00000000,
+	0xbefe00c1, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0xbef600ff,
+	0x01000000, 0xbef90080,
+	0xbefd0080, 0xbf800000,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xbe8c410c, 0xbe8e410e,
+	0xbf068079, 0xbfa10032,
+	0xd7610002, 0x00010000,
+	0xd7610002, 0x00010201,
+	0xd7610002, 0x00010402,
+	0xd7610002, 0x00010603,
+	0xd7610002, 0x00010804,
+	0xd7610002, 0x00010a05,
+	0xd7610002, 0x00010c06,
+	0xd7610002, 0x00010e07,
+	0xd7610002, 0x00011008,
+	0xd7610002, 0x00011209,
+	0xd7610002, 0x0001140a,
+	0xd7610002, 0x0001160b,
+	0xd7610002, 0x0001180c,
+	0xd7610002, 0x00011a0d,
+	0xd7610002, 0x00011c0e,
+	0xd7610002, 0x00011e0f,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0x80799079, 0xbfa00038,
+	0xd7610002, 0x00012000,
+	0xd7610002, 0x00012201,
+	0xd7610002, 0x00012402,
+	0xd7610002, 0x00012603,
+	0xd7610002, 0x00012804,
+	0xd7610002, 0x00012a05,
+	0xd7610002, 0x00012c06,
+	0xd7610002, 0x00012e07,
+	0xd7610002, 0x00013008,
+	0xd7610002, 0x00013209,
+	0xd7610002, 0x0001340a,
+	0xd7610002, 0x0001360b,
+	0xd7610002, 0x0001380c,
+	0xd7610002, 0x00013a0d,
+	0xd7610002, 0x00013c0e,
+	0xd7610002, 0x00013e0f,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0x80799079, 0xc4068070,
 	0x008ce802, 0x00000000,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8fb4306, 0x8b7bc17b,
-	0xbfa10044, 0x8b7aff6d,
-	0x80000000, 0xbfa10041,
-	0x847b897b, 0xbef6007b,
-	0xb8f03b05, 0x80708170,
-	0xbf0d9973, 0xbfa20002,
-	0x84708970, 0xbfa00001,
-	0x84708a70, 0xb8fa1e06,
-	0x847a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
 	0x8070ff70, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0xd71f0000, 0x000100c1,
-	0xd7200000, 0x000200c1,
-	0x16000084, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbefd0080, 0xbfa20013,
-	0xbe8300ff, 0x00000080,
-	0xbf800000, 0xbf800000,
-	0xbf800000, 0xd8d80000,
-	0x01000000, 0xbf8a0000,
-	0xc4068070, 0x008ce801,
-	0x00000000, 0x807d037d,
-	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000080,
-	0xbf0a7b7d, 0xbfa2fff3,
-	0xbfa00012, 0xbe8300ff,
-	0x00000100, 0xbf800000,
+	0xbef90080, 0x7e040280,
+	0x807d907d, 0xbf0aff7d,
+	0x00000060, 0xbfa2ff88,
+	0xbe804100, 0xbe824102,
+	0xbe844104, 0xbe864106,
+	0xbe884108, 0xbe8a410a,
+	0xd7610002, 0x00010000,
+	0xd7610002, 0x00010201,
+	0xd7610002, 0x00010402,
+	0xd7610002, 0x00010603,
+	0xd7610002, 0x00010804,
+	0xd7610002, 0x00010a05,
+	0xd7610002, 0x00010c06,
+	0xd7610002, 0x00010e07,
+	0xd7610002, 0x00011008,
+	0xd7610002, 0x00011209,
+	0xd7610002, 0x0001140a,
+	0xd7610002, 0x0001160b,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xc4068070, 0x008ce802,
+	0x00000000, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8fb4306,
+	0x8b7bc17b, 0xbfa10044,
+	0x8b7aff6d, 0x80000000,
+	0xbfa10041, 0x847b897b,
+	0xbef6007b, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0x8070ff70,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0xd71f0000,
+	0x000100c1, 0xd7200000,
+	0x000200c1, 0x16000084,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa20013, 0xbe8300ff,
+	0x00000080, 0xbf800000,
 	0xbf800000, 0xbf800000,
 	0xd8d80000, 0x01000000,
 	0xbf8a0000, 0xc4068070,
 	0x008ce801, 0x00000000,
 	0x807d037d, 0x80700370,
 	0xd5250000, 0x0001ff00,
-	0x00000100, 0xbf0a7b7d,
-	0xbfa2fff3, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20004,
-	0xbef000ff, 0x00000200,
-	0xbeff0080, 0xbfa00003,
-	0xbef000ff, 0x00000400,
-	0xbeff00c1, 0xb8fb3b05,
-	0x807b817b, 0x847b827b,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa2001b,
-	0xbef600ff, 0x01000000,
-	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10040, 0x7e008700,
-	0x7e028701, 0x7e048702,
-	0x7e068703, 0xc4068070,
-	0x008ce800, 0x00000000,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff3, 0xbfa00012,
+	0xbe8300ff, 0x00000100,
+	0xbf800000, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf8a0000,
 	0xc4068070, 0x008ce801,
-	0x00008000, 0xc4068070,
-	0x008ce802, 0x00010000,
-	0xc4068070, 0x008ce803,
-	0x00018000, 0x807d847d,
-	0x8070ff70, 0x00000200,
-	0xbf0a7b7d, 0xbfa2ffeb,
-	0xbfa0002a, 0xbef600ff,
+	0x00000000, 0x807d037d,
+	0x80700370, 0xd5250000,
+	0x0001ff00, 0x00000100,
+	0xbf0a7b7d, 0xbfa2fff3,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20004, 0xbef000ff,
+	0x00000200, 0xbeff0080,
+	0xbfa00003, 0xbef000ff,
+	0x00000400, 0xbeff00c1,
+	0xb8fb3b05, 0x807b817b,
+	0x847b827b, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2001b, 0xbef600ff,
 	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10015,
+	0xbf0a7b7d, 0xbfa10040,
 	0x7e008700, 0x7e028701,
 	0x7e048702, 0x7e068703,
 	0xc4068070, 0x008ce800,
 	0x00000000, 0xc4068070,
-	0x008ce801, 0x00010000,
+	0x008ce801, 0x00008000,
 	0xc4068070, 0x008ce802,
-	0x00020000, 0xc4068070,
-	0x008ce803, 0x00030000,
+	0x00010000, 0xc4068070,
+	0x008ce803, 0x00018000,
 	0x807d847d, 0x8070ff70,
-	0x00000400, 0xbf0a7b7d,
-	0xbfa2ffeb, 0xb8fb1e06,
-	0x8b7bc17b, 0xbfa1000d,
-	0x847b837b, 0x807b7d7b,
-	0xbefe00c1, 0xbeff0080,
-	0x7e008700, 0xc4068070,
-	0x008ce800, 0x00000000,
-	0x807d817d, 0x8070ff70,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff7, 0xbfa0016e,
-	0xbef4007e, 0x8b75ff7f,
-	0x0000ffff, 0x8c75ff75,
-	0x00040000, 0xbef60080,
-	0xbef700ff, 0x10807fac,
-	0xbef1007f, 0xb8f20742,
-	0x84729972, 0x8b6eff7f,
-	0x04000000, 0xbfa1003b,
-	0xbefe00c1, 0x857d9972,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8ef4306, 0x8b6fc16f,
-	0xbfa10030, 0x846f896f,
-	0xbef6006f, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0x8078ff78,
-	0x00000080, 0xbef600ff,
-	0x01000000, 0x857d9972,
-	0x8b7d817d, 0xbf06817d,
-	0xbefd0080, 0xbfa2000d,
-	0xc4050078, 0x0080e800,
-	0x00000000, 0xbf8a0000,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000080,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff4,
-	0xbfa0000c, 0xc4050078,
-	0x0080e800, 0x00000000,
-	0xbf8a0000, 0xdac00000,
-	0x00000000, 0x807dff7d,
-	0x00000100, 0x8078ff78,
-	0x00000100, 0xbf0a6f7d,
-	0xbfa2fff4, 0xbef80080,
-	0xbefe00c1, 0x857d9972,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8ef3b05, 0x806f816f,
-	0x846f826f, 0x857d9972,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa2002c, 0xbef600ff,
-	0x01000000, 0xbeee0078,
-	0x8078ff78, 0x00000200,
-	0xbefd0084, 0xbf0a6f7d,
-	0xbfa10061, 0xc4050078,
-	0x008ce800, 0x00000000,
-	0xc4050078, 0x008ce801,
-	0x00008000, 0xc4050078,
-	0x008ce802, 0x00010000,
-	0xc4050078, 0x008ce803,
-	0x00018000, 0xbf8a0000,
-	0x7e008500, 0x7e028501,
-	0x7e048502, 0x7e068503,
-	0x807d847d, 0x8078ff78,
-	0x00000200, 0xbf0a6f7d,
-	0xbfa2ffea, 0xc405006e,
-	0x008ce800, 0x00000000,
-	0xc405006e, 0x008ce801,
-	0x00008000, 0xc405006e,
-	0x008ce802, 0x00010000,
-	0xc405006e, 0x008ce803,
-	0x00018000, 0xbf8a0000,
-	0xbfa0003d, 0xbef600ff,
-	0x01000000, 0xbeee0078,
-	0x8078ff78, 0x00000400,
-	0xbefd0084, 0xbf0a6f7d,
-	0xbfa10016, 0xc4050078,
-	0x008ce800, 0x00000000,
-	0xc4050078, 0x008ce801,
-	0x00010000, 0xc4050078,
-	0x008ce802, 0x00020000,
-	0xc4050078, 0x008ce803,
-	0x00030000, 0xbf8a0000,
-	0x7e008500, 0x7e028501,
-	0x7e048502, 0x7e068503,
-	0x807d847d, 0x8078ff78,
-	0x00000400, 0xbf0a6f7d,
-	0xbfa2ffea, 0xb8ef1e06,
-	0x8b6fc16f, 0xbfa1000f,
-	0x846f836f, 0x806f7d6f,
-	0xbefe00c1, 0xbeff0080,
-	0xc4050078, 0x008ce800,
-	0x00000000, 0xbf8a0000,
-	0x7e008500, 0x807d817d,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff6,
-	0xbeff00c1, 0xc405006e,
+	0x00000200, 0xbf0a7b7d,
+	0xbfa2ffeb, 0xbfa0002a,
+	0xbef600ff, 0x01000000,
+	0xbefd0084, 0xbf0a7b7d,
+	0xbfa10015, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0xc4068070,
 	0x008ce800, 0x00000000,
-	0xc405006e, 0x008ce801,
-	0x00010000, 0xc405006e,
+	0xc4068070, 0x008ce801,
+	0x00010000, 0xc4068070,
 	0x008ce802, 0x00020000,
-	0xc405006e, 0x008ce803,
-	0x00030000, 0xbf8a0000,
+	0xc4068070, 0x008ce803,
+	0x00030000, 0x807d847d,
+	0x8070ff70, 0x00000400,
+	0xbf0a7b7d, 0xbfa2ffeb,
+	0xb8fb1e06, 0x8b7bc17b,
+	0xbfa1000d, 0x847b837b,
+	0x807b7d7b, 0xbefe00c1,
+	0xbeff0080, 0x7e008700,
+	0xc4068070, 0x008ce800,
+	0x00000000, 0x807d817d,
+	0x8070ff70, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff7,
+	0xbfa00171, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xbef1007f,
+	0xb8f20742, 0x84729972,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1003b, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef4306,
+	0x8b6fc16f, 0xbfa10030,
+	0x846f896f, 0xbef6006f,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
 	0x84788a78, 0xb8ee1e06,
 	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000050,
+	0x8078ff78, 0x00000080,
 	0xbef600ff, 0x01000000,
-	0xbefd00ff, 0x0000006c,
-	0x80f89078, 0xf462403a,
-	0xf0000000, 0xbf8a0000,
-	0x80fd847d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0x80f8a078, 0xf462603a,
-	0xf0000000, 0xbf8a0000,
-	0x80fd887d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0x80f8c078, 0xf462803a,
-	0xf0000000, 0xbf8a0000,
-	0x80fd907d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0xbe884308, 0xbe8a430a,
-	0xbe8c430c, 0xbe8e430e,
-	0xbf06807d, 0xbfa1fff0,
-	0xb980f801, 0x00000000,
-	0xb8f83b05, 0x80788178,
-	0xbf0d9972, 0xbfa20002,
-	0x84788978, 0xbfa00001,
-	0x84788a78, 0xb8ee1e06,
-	0x846e8a6e, 0x80786e78,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbefd0080,
+	0xbfa2000d, 0xc4050078,
+	0x0080e800, 0x00000000,
+	0xbf8a0000, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff4, 0xbfa0000c,
+	0xc4050078, 0x0080e800,
+	0x00000000, 0xbf8a0000,
+	0xdac00000, 0x00000000,
+	0x807dff7d, 0x00000100,
+	0x8078ff78, 0x00000100,
+	0xbf0a6f7d, 0xbfa2fff4,
+	0xbef80080, 0xbefe00c1,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8ef3b05,
+	0x806f816f, 0x846f826f,
+	0x857d9972, 0x8b7d817d,
+	0xbf06817d, 0xbfa2002c,
+	0xbef600ff, 0x01000000,
+	0xbeee0078, 0x8078ff78,
+	0x00000200, 0xbefd0084,
+	0xbf0a6f7d, 0xbfa10061,
+	0xc4050078, 0x008ce800,
+	0x00000000, 0xc4050078,
+	0x008ce801, 0x00008000,
+	0xc4050078, 0x008ce802,
+	0x00010000, 0xc4050078,
+	0x008ce803, 0x00018000,
+	0xbf8a0000, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
 	0x8078ff78, 0x00000200,
+	0xbf0a6f7d, 0xbfa2ffea,
+	0xc405006e, 0x008ce800,
+	0x00000000, 0xc405006e,
+	0x008ce801, 0x00008000,
+	0xc405006e, 0x008ce802,
+	0x00010000, 0xc405006e,
+	0x008ce803, 0x00018000,
+	0xbf8a0000, 0xbfa0003d,
 	0xbef600ff, 0x01000000,
-	0xbeff0071, 0xf4621bfa,
+	0xbeee0078, 0x8078ff78,
+	0x00000400, 0xbefd0084,
+	0xbf0a6f7d, 0xbfa10016,
+	0xc4050078, 0x008ce800,
+	0x00000000, 0xc4050078,
+	0x008ce801, 0x00010000,
+	0xc4050078, 0x008ce802,
+	0x00020000, 0xc4050078,
+	0x008ce803, 0x00030000,
+	0xbf8a0000, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x8078ff78, 0x00000400,
+	0xbf0a6f7d, 0xbfa2ffea,
+	0xb8ef1e06, 0x8b6fc16f,
+	0xbfa1000f, 0x846f836f,
+	0x806f7d6f, 0xbefe00c1,
+	0xbeff0080, 0xc4050078,
+	0x008ce800, 0x00000000,
+	0xbf8a0000, 0x7e008500,
+	0x807d817d, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff6, 0xbeff00c1,
+	0xc405006e, 0x008ce800,
+	0x00000000, 0xc405006e,
+	0x008ce801, 0x00010000,
+	0xc405006e, 0x008ce802,
+	0x00020000, 0xc405006e,
+	0x008ce803, 0x00030000,
+	0xbf8a0000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000050, 0xbef600ff,
+	0x01000000, 0xbefd00ff,
+	0x0000006c, 0x80f89078,
+	0xf462403a, 0xf0000000,
+	0xbf8a0000, 0x80fd847d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0x80f8a078,
+	0xf462603a, 0xf0000000,
+	0xbf8a0000, 0x80fd887d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0x80f8c078,
+	0xf462803a, 0xf0000000,
+	0xbf8a0000, 0x80fd907d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0xbe884308,
+	0xbe8a430a, 0xbe8c430c,
+	0xbe8e430e, 0xbf06807d,
+	0xbfa1fff0, 0xb980f801,
+	0x00000000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0xbef600ff,
+	0x01000000, 0xbeff0071,
+	0xf4621bfa, 0xf0000000,
+	0x80788478, 0xf4621b3a,
 	0xf0000000, 0x80788478,
-	0xf4621b3a, 0xf0000000,
-	0x80788478, 0xf4621b7a,
+	0xf4621b7a, 0xf0000000,
+	0x80788478, 0xf4621c3a,
 	0xf0000000, 0x80788478,
-	0xf4621c3a, 0xf0000000,
-	0x80788478, 0xf4621c7a,
+	0xf4621c7a, 0xf0000000,
+	0x80788478, 0xf4621eba,
 	0xf0000000, 0x80788478,
-	0xf4621eba, 0xf0000000,
-	0x80788478, 0xf4621efa,
+	0xf4621efa, 0xf0000000,
+	0x80788478, 0xf4621e7a,
 	0xf0000000, 0x80788478,
-	0xf4621e7a, 0xf0000000,
-	0x80788478, 0xf4621cfa,
+	0xf4621cfa, 0xf0000000,
+	0x80788478, 0xf4621bba,
 	0xf0000000, 0x80788478,
+	0xbf8a0000, 0xb96ef814,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf8a0000,
-	0xb96ef814, 0xf4621bba,
+	0xb96ef815, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf8a0000, 0xb96ef815,
+	0xbf8a0000, 0xb96ef812,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf8a0000,
-	0xb96ef812, 0xf4621bba,
+	0xb96ef813, 0x8b6eff7f,
+	0x04000000, 0xbfa1000d,
+	0x80788478, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf8a0000, 0xb96ef813,
-	0x8b6eff7f, 0x04000000,
-	0xbfa1000d, 0x80788478,
-	0xf4621bba, 0xf0000000,
-	0x80788478, 0xbf8a0000,
-	0xbf0d806e, 0xbfa10006,
-	0x856e906e, 0x8b6e6e6e,
-	0xbfa10003, 0xbe804ec1,
-	0x816ec16e, 0xbfa0fffb,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0xb97b2011,
-	0x857b867b, 0xb97b0191,
-	0x857b827b, 0xb97bba11,
-	0xb973f801, 0xb8ee3b05,
-	0x806e816e, 0xbf0d9972,
-	0xbfa20002, 0x846e896e,
-	0xbfa00001, 0x846e8a6e,
-	0xb8ef1e06, 0x846f8a6f,
-	0x806e6f6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x8b6fff6f,
-	0x0000ffff, 0xf4605c37,
-	0xf8000050, 0xf4605d37,
-	0xf8000060, 0xf4601e77,
-	0xf8000074, 0xbf8a0000,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
+	0xbf8a0000, 0xbf0d806e,
+	0xbfa10006, 0x856e906e,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec1, 0x816ec16e,
+	0xbfa0fffb, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0xb97b2011, 0x857b867b,
+	0xb97b0191, 0x857b827b,
+	0xb97bba11, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0xb8ef1e06,
+	0x846f8a6f, 0x806e6f6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x8b6fff6f, 0x0000ffff,
+	0xf4605c37, 0xf8000050,
+	0xf4605d37, 0xf8000060,
+	0xf4601e77, 0xf8000074,
+	0xbf8a0000, 0x936eff6d,
+	0x0002001a, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb96e081a,
 	0xb97af804, 0xbe804ec2,
 	0xbf94fffe, 0xbe804a6c,
 	0xbe804ec2, 0xbf94fffe,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 5a1a1b1f897f..7d6219cd5bd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -78,6 +78,10 @@ var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
+
+var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
+var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
+
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
 var BARRIER_STATE_VALID_OFFSET			= 0
 
@@ -94,6 +98,14 @@ var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_SAVE_PC_HI_FIRST_WAVE_MASK		= 0x80000000
 var S_SAVE_PC_HI_FIRST_WAVE_SHIFT		= 31
 
+var S_SCHED_MODE_DEP_MODE_SHIFT			= 26
+var S_SCHED_MODE_DEP_MODE_SIZE			= 2
+var S_SCHED_MODE_DEP_MODE_MASK			= 0xC000000
+
+#if ASIC_FAMILY == CHIP_GFX12
+var s_sched_mode				= ttmp1
+#endif
+
 var s_sgpr_save_num				= 108
 
 var s_save_spi_init_lo				= exec_lo
@@ -160,8 +172,19 @@ L_JUMP_TO_RESTORE:
 	s_branch	L_RESTORE
 
 L_SKIP_RESTORE:
+	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)
+	s_wait_alu	0
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
+		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
+
 	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
 
+	// Save SCHED_MODE[1:0] into s_sched_mode[27:26].
+	s_andn2_b32	s_sched_mode, s_sched_mode, S_SCHED_MODE_DEP_MODE_MASK
+	s_lshl_b32	ttmp2, ttmp2, S_SCHED_MODE_DEP_MODE_SHIFT
+	s_or_b32	s_sched_mode, s_sched_mode, ttmp2
+
 	// Clear SPI_PRIO: do not save with elevated priority.
 	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
 	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
@@ -278,6 +301,8 @@ L_TRAP_CASE:
 	s_addc_u32	ttmp1, ttmp1, 0x0
 
 L_EXIT_TRAP:
+	// ttmp1 may alias s_sched_mode.
+	s_bfe_u32	ttmp2, s_sched_mode, (S_SCHED_MODE_DEP_MODE_SHIFT | (S_SCHED_MODE_DEP_MODE_SIZE << 0x10))
 	s_and_b32	ttmp1, ttmp1, 0xFFFF
 
 	// Restore SQ_WAVE_STATUS.
@@ -287,6 +312,11 @@ L_EXIT_TRAP:
 	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
 	// Only restore fields which the trap handler changes.
 	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+
+	// Assume relaxed scheduling mode after this point.
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE, SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, \
+		 SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), ttmp2
+
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
 		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
 
@@ -301,7 +331,7 @@ L_SAVE:
 	s_endpgm
 L_HAVE_VGPRS:
 
-	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
+	s_andn2_b32	s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK	// Clear unused bits for storage
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
@@ -1039,10 +1069,17 @@ L_SKIP_BARRIER_RESTORE:
 	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 scope:SCOPE_SYS
 	s_wait_idle
 
+	// s_restore_pc_hi may alias s_sched_mode.
+	s_bfe_u32	s_restore_tmp, s_sched_mode, (S_SCHED_MODE_DEP_MODE_SHIFT | (S_SCHED_MODE_DEP_MODE_SIZE << 0x10))
 	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
+
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
+	// Assume relaxed scheduling mode after this point.
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE, SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, \
+		 SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), s_restore_tmp
+
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
 
 	// Make barrier and LDS state visible to all waves in the group.
-- 
2.34.1

