Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD184E728D6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 18:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433FA10E1A5;
	Fri, 29 Sep 2023 18:19:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA24E10E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 18:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB9iYf7d9T0a9JKQfaK6W/qsbo6cou7eVaqE+ezS2RsfCny3t9ivNqIYKJmqkarcEbYX5RepzVfOk26dhZXJht7/oL5mSU3/mz6pwqUjQnZxNI+4tSV+3HgwpN7stitKPiyarHeffnlKMeJijCFZAyV6xseiXlEhfW4K9v6P3ojtd+AKcIyBMJsey1KOMToghEVnxpdDXuAoQpaPmT9W6Zxh6lYcOG/GlVXpWZysVDM6hIwSDBthy4XvTZOFc03oF3IcFiafjf/kgBKdsP+4J17nK8BCnreFedVUowHXUE7MQE/U8ydG1veqMlhlBzWtkjcKHd1bPvGlHUA0h9wgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JjjLiac8RKn1Log8EujgdGR2hn3L8rUSasI9TlguuI=;
 b=LpnyxThrzKIq+4mvdHpAGrm6D8Xz1p9surl5Pe0EJ6d2BdGNr2TCkseL+jor7NyzcN9ny4HqHLghg78BI4dJznhGLmOPbI5eL2i7vElpCQzcuY82v03U13wKEYlTX14a/nUbzGGLYcBbwbiTtKkdP6+OM2Nby2Kc0wnOJjEw/605OwcXCyj9NAD5/70pp17R75mMIjc4H87OMGGMucIFIIry4A86+wdYbNyExfEP/59sHcy1evFoOYZeGFWxw/k0/NFwzE0DVgJ2HNX7/5LiYtGq8k/WciOquRzZu6H0sTnJszb7I3SZN+2I73P8VQAFkm69EYDcQJP2Hd8sjRIeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JjjLiac8RKn1Log8EujgdGR2hn3L8rUSasI9TlguuI=;
 b=RZhtZLl9pmclHIXKS7PGdhGeJD5HADT5PrEi6OXpYzvLEjP1kZex3cxKU1b2NFtmlW2CIv4nHoeztj/eDsJaMNWuT1yoCQkCGwtG+9S3OIVh+ecU5HZDEGzTE00uPO5zVXe5wqqu7Lpsfz02euN8sJ6tLrqj7Cv6dg6Tz0fImHA=
Received: from MW4PR04CA0065.namprd04.prod.outlook.com (2603:10b6:303:6b::10)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:19:11 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::96) by MW4PR04CA0065.outlook.office365.com
 (2603:10b6:303:6b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Fri, 29 Sep 2023 18:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 29 Sep 2023 18:19:11 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 13:19:09 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Rework KFD memory max limits
Date: Fri, 29 Sep 2023 14:18:54 -0400
Message-ID: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e86c829-0365-4379-5b87-08dbc118942e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2jbCGhRkcKu/2ytcwZcRrAxikPZP9q9mw3MQlxhMBwdeJIpSZ9y/Ym0wdqpnHPZqmSCehiAJ6ZRW+9EA0PIO7c+zF3CfFezDbwTOkdo/qaLIGEybgINLDYdgIOGVBX/KsJUKiM//f9q0mVykt1Bn9JvZJeDG+zp/28LNqSfgfEeP7l6TU2iRWT7Yy8v3zqSX0pO2q88apCwh272GJmCDW5x0tzcLuc1fm5AYZ6cP5AtQK+4qTQzvnOE/ZUFfIez2QX8dkaSXaFLO35tMo6xlKtuEwz+jLm4SctfUNaMjVCCEJxNol2K+Pr/xyo5sLEw77rxuWY/8EKOTfIdQgkyhlpCIEZQpfWTVJF/W45hh9r2PRBD8usv24YPm94rIzUi85rEYwoQuQTtdK9QwBLrkXd2kaBJ6pCoOxM+8W6vfmmVtpgLj5I8n8fDUJtZqOxHVuJFz/DPIVvPvX7Dozz9f5dMK8fuYDmTmR/Fqurqr7Kghe3MDyXqS+PZvarrQzZwP+fu5U50CkDp4r38GDnDmM2kP5+TSALMp/XMl5NKR0kNFWHOn0qDjKOP3cBFl/IMXBWwygQnk0F+9pJoL9JoCaXSRRsYtoFu6svHhCuly3QMEzAwudXdwjiEVvwWK1NcBUn2yVZhF1CjUA9QB2kRrGXFMC12FQBB2nWml9W0K0nDh7vs9xxnSwotcbEm0B4ntYtT3aOG0u4t0rG8TsSrXi28CXQABSHrVHviCraBiOAIFgrEG1pANiM0T6dX/pGFxBEJZWfg79cM2Ew0xodX9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(356005)(82740400003)(81166007)(40480700001)(36756003)(478600001)(6666004)(2906002)(44832011)(7696005)(5660300002)(426003)(336012)(2616005)(70586007)(26005)(1076003)(16526019)(70206006)(54906003)(6916009)(41300700001)(316002)(4326008)(8936002)(8676002)(36860700001)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:19:11.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e86c829-0365-4379-5b87-08dbc118942e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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
Cc: philip.yang@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow bigger allocations specially on systems such as GFXIP 9.4.3
that use GTT memory for VRAM allocations, relax the limits to
maximize ROCm allocations.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..b1c4e9c0e036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -42,6 +42,7 @@
  * changes to accumulate
  */
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
+#define AMDGPU_RESERVE_MEM_LIMIT			(1UL << 30)
 
 /*
  * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
@@ -115,11 +116,16 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		return;
 
 	si_meminfo(&si);
-	mem = si.freeram - si.freehigh;
+	mem = si.totalram - si.totalhigh;
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
+	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
+	if (kfd_mem_limit.max_system_mem_limit < 2 * AMDGPU_RESERVE_MEM_LIMIT)
+		kfd_mem_limit.max_system_mem_limit >>= 1;
+	else
+		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
+
 	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
-- 
2.34.1

