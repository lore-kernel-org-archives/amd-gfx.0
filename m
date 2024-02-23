Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F033C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 19:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4642F10EC8A;
	Fri, 23 Feb 2024 19:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ehIgBWMr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142B910EC8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 19:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QadYoTwr+tuHn/oLD0ZYEkmB4yeiMCVEyXmcSBL5dUY9CB/4Ug5/EQA7TDgS8SHNrIPN0yTnjg4MZF6U+0vn5xqWu21ibIkAZp+VZl73qKTBmRKrLBW5F0BwrKwfgY2g5VlHW1aXYTwLvmhvI37ayWmV8vVdcwv78Yk7lMHrfmGmvRzGYXhHRs8eSMBqreR+YWgDDHRQwqXO2rEhKeeBHYTPuKt+5+ADOrdU4GqCdpWxDR5KSpPREO0/jJNsuwYm/X7Ilw262dSNuU0tCm1vgPU3dRpphdLpG0Ec4gdRRjoulxG5+xi3ZNWUcgpWdBUb8sVznXwsfN9KtK32fy1gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olNH6dLS6Q90jVes06A3bCcPNxBEdTDAMj1LFm1JZ7E=;
 b=UqDtquzgYyVPpb4sPHXUodPrBc0KHCu8MqDUpArnYGs2Eh0qlwTT8rx7mPlGDImmy5rK0lsVfUabh4PMQJCIazFOzlcIn3+BNG+26lOSC5g4Bp4yFE7w7+9xVrlc8L2C2CACS6VC4VFfY2XHJnY9zRHTkn4H/vZ/FaSn1XuIVaNpDultUpVkcZwOrEzQwKM1HZWf+wKaLSlh1ZrFOhU2luf4S62PowZRYs555Kb+D3Gd9IpZJ2WK2yvLgfP8KnyQNdVrV3k+oAoYC4n3IZ1/2M7M2ZOKjJaqMTjHS4og0PRy/pBtMB3/aUOqwt9ovJGp5YQsTa9vGxBoMd+zEgaRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olNH6dLS6Q90jVes06A3bCcPNxBEdTDAMj1LFm1JZ7E=;
 b=ehIgBWMrqt9AQedXEUlwHw0DBjNGnZqVJe+0GbpOqO2/XEKLS+yARKtTgd3mT5oBVMK4FrQsrtj2Z45rny1paSAUYaqgeR9GnmHxbqUk71E5IrV+gfxwhTEgRM10Q7tnnnY2EZcBrr5eYMJji6ljFlCivy72rvyJ2CRPYn5PMw8=
Received: from MN2PR04CA0032.namprd04.prod.outlook.com (2603:10b6:208:d4::45)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 19:06:02 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::4e) by MN2PR04CA0032.outlook.office365.com
 (2603:10b6:208:d4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.44 via Frontend
 Transport; Fri, 23 Feb 2024 19:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 19:06:01 +0000
Received: from lmoriche-tr.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 13:06:00 -0600
From: Laurent Morichetti <laurent.morichetti@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <jay.cornwall@amd.com>, Laurent Morichetti
 <laurent.morichetti@amd.com>
Subject: [PATCH] drm/amdkfd: Increase the size of the memory reserved for the
 TBA
Date: Fri, 23 Feb 2024 11:05:23 -0800
Message-ID: <20240223190523.1823860-1-laurent.morichetti@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe450ad-955e-4f38-414a-08dc34a279c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F03rfEpEpVgDBFQ8X+aGxGSNqAi62gptu6WGzjFMPD5S9BIJLdTu3K2kT59vwThN7QR3o1KZoZA7K20b4ur0lB3LV5VyZ50PRHTWGaq+Qe1ObJ04amqUDTOOt4hPYmhFy3feRgIoABBfuXEm/OAK1WHKcpLXg8flzIc+HRrmA72toIa5THcFt2yVsNVHA+FnWHtn+VcUY37dpNfxIgXGNKcNCgeWpGZJgUR/RicY7XkM+F2hxbAoSDeKN9UaRZP02MKvk5ltd0mq+nd4KcVh1nKweK4DziH7NsKtTcOWVXw109P80SzS3CFUEUvbepJz6YfppSrZnstlSt8TB1sLBnw7y2Jw7Trusa7YZ9Wjn2M9DtGQDbZ2yVy0eSGfNL4DguaDe2PRNGnhJBpZKBiBFSMdr1q5R6ROFeyi3gh7x1znN3bRF0p2OFnWtAtBD4Lv6D59QmPlqdGmjK+ukHZ3oHwbSkr7k3+R0QM+wJUhAp5Fankg3eI3CKW3YpNAKkZN0Tm2iBi8aU9cXzORBs4qmmOnaFo9zORyFRU+cFsqk/lyw7XE6rqpAU8Z+lwRFxdDpGTG/F5SrzK2Q8u2wI7ESKvGKHox0LUuDt68Z94LtajBEl4tHDf267NX9RL7TY9Qy9vW1qhWYXbcsoDYT2KxTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:06:01.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe450ad-955e-4f38-414a-08dc34a279c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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

In a future commit, the cwsr trap handler code size for gfx10.1 will
increase to slightly above the one page mark. Since the TMA does not
need to be page aligned, and only 2 pointers are stored in it, push
the TMA offset by 2 KiB and keep the TBA+TMA reserved memory size
to two pages.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 23 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 +++---
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4d399c0c8a57..041ec3de55e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -466,34 +466,43 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
 	if (cwsr_enable && kfd->device_info.supports_cwsr) {
 		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx8_hex);
 		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_arcturus_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_arcturus_hex);
 		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
 		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx9_4_3_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_4_3_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx9_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_nv1x_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_nv1x_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(11, 0, 0)) {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx10_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx10_hex);
 		} else {
+			/* The gfx11 cwsr trap handler must fit inside a single
+			   page. */
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 80320b8603fc..42d40560cd30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -99,11 +99,11 @@
 /*
  * Size of the per-process TBA+TMA buffer: 2 pages
  *
- * The first page is the TBA used for the CWSR ISA code. The second
- * page is used as TMA for user-mode trap handler setup in daisy-chain mode.
+ * The first chunk is the TBA used for the CWSR ISA code. The second
+ * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
  */
 #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
-#define KFD_CWSR_TMA_OFFSET PAGE_SIZE
+#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
 
 #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE		\
 	(KFD_MAX_NUM_OF_PROCESSES *			\

base-commit: 420b2460a743b320868f30e407d4c4685958ea2c
-- 
2.25.1

