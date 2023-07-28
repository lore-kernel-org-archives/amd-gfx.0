Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9782CC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 04:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B7910E63A;
	Fri, 28 Jul 2023 04:27:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E05310E63A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 04:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdFqWZxgrcx79KwmfiLx8BypQ9biTGHbvhuu86F3h5n6yb/W6P+PbpfBLG2UAo1jj2z76PF7X3s2aVdDlql34ca4kVVOKGuFGD6Iawe3iDt6eO3PmaPohtHMp+SayvaIHj3JglKQmMwtU+45Oe/0n9mFnMWMbTeWrW/EKm6xu2Hg02NEyHL8uj+fk644doiWlOa+eFPZJagR7lhvfxwPqEl5V144OLhtTvmI1Y1aNUE0ZhqHvalVZX1MXKveab+vWXhHekDZCmoQfQEyHkHi+DdvH9r4M1jGkLoENfwAGz+0NR8+5F5yiSvXDe00BmbNubJUAl5nbUkJW6QgQ1pgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUUHzChI4msTFoSFdYaBhhaW0b0oWyOIloeYXKQMhqU=;
 b=Oo/1QbwxKhEgaViEshh1Nfq3BymFGVaRM+pa0qN8jBzRMVl404RLteXCvC3m3H4vIF8n/1fWcYjPGRPZ8Irtd3inQbfRz1hXvIiATEA57QuCI/XAnl44OLEfhR4DmnxwWS8I3oKH6NwsF+zXGYSP7Y9WZ8hxCYRxMbJUd6c62bgL6i1wuqbGEbUHXD52nDnT9KhMmIM0y+dZ72ljDiQAsafWyDWucGECsAJ5kKDcEs0kwG6EF61fc9w7cLSmLs0sGx3GydPfXhmKjCAsW9dwxo/M4V+0j2zrJYqTzaZtVQuW4CBdLzaMjL/47yFmbv+63+G7ZKYyQeFZ4eF0tTBvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUUHzChI4msTFoSFdYaBhhaW0b0oWyOIloeYXKQMhqU=;
 b=IlmfX+SDQUhIelgDG5ysxWFCr9Ev59CsrSMeXH/6v7gxkabH/4JX49QmlBKUJFMRxIwqq7ssh2PjpQgUKIScGedJbAnyxYw8voxmVSzPBFfJ6K1A+VwAqcx5pvZMcRFCsoR6sPLxj22Fpgncg85W4Uj6cSA6y91TYy0QJ75HTHA=
Received: from SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::16)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:27:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::e8) by SA1P222CA0188.outlook.office365.com
 (2603:10b6:806:3c4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 04:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 04:27:50 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 23:27:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amdgpu: Move vram,
 gtt & flash defines to amdgpu_ ttm & _psp.h
Date: Fri, 28 Jul 2023 09:57:26 +0530
Message-ID: <20230728042726.2679963-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
References: <20230725045159.2246417-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 27626cfd-cc07-4a9d-0cb2-08db8f2300af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZW6blwn8ZbGXEshd7Yhk2Q2+jN9/idyYgy1oykkUDmqgnkY9S5QmSsyqgzV3x8cG1IyqQLa20MwlBO+PRT8x2LN2HCgqk6fZkVHldm9ej6DHKStkw1Qm6Xgy46XtqpZZEzNFN6It7yaZboKLaAWvennhlDJ9q9A7rCKakXZClKg6KxWyhz5gMtDBMt+cfWsLS1qDcFdlcjerkUoVIlntRvG2Ei9BvTR3wMxDHkX2WhgGZFzmUE7qeuC1Pf3OYIMT+bmq0MT7WcdK+Ei0VbAPOwsBMEKMYbE1yqezXn7GZLoe3crv7kd756aND9yoH+muvYaMYBp4sp2wjOFBFTSa2x8dIy7zhPzAOEIEo5HGFlzR2dLq/PFjQtEwLd6dKJFcZ+pP0bSUe3XScbA8B++2xyTICW4yEVgQYpU3T9AI3j33I/4iOnXdV4XoynLilH/0yApd4wI2fnCeF1gV2gYBwILbJZgoUqchXAgarLl1j1T9xgF1WI5EA2b4BM7M13Gogbjap5lbRd7fJadWdURORV7gLYVBdg11zfH3ch///GYHXjAvja0IIEj6R3ClwsILvO2/iVtpMT2Wz+vE86fXR/mW6FsP5R2ZzpQp9Z2mtwtJS7CfjJ2ENNnMdAN7SxNzr5G0borp3SQ3M5mYVXKENiKpaXS6MK6uKidjqqKzQz7LDhawqq7I2BxALobAnMwuWdyLXr5Gp/QP7+e4lR/wtt5LkP+Q6EREgoruT+AI3UfbsS+Y7PcIo83iiEoLJW4PvtLBwDe8hvB3n8KwcHw4ZG8MyObiiYjDPbZn9KdFH8yYIEC+qhdRxUCbdCQj/TE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(316002)(2906002)(8936002)(8676002)(5660300002)(40460700003)(44832011)(41300700001)(36756003)(86362001)(40480700001)(336012)(7696005)(6666004)(426003)(81166007)(356005)(82740400003)(478600001)(26005)(1076003)(16526019)(186003)(110136005)(54906003)(966005)(2616005)(70206006)(36860700001)(70586007)(47076005)(6636002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 04:27:50.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27626cfd-cc07-4a9d-0cb2-08db8f2300af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As amdgpu.h is getting decomposed, move vram and gtt extern defines into
amdgpu_ttm.h & flash extern to amdgpu_psp.h

'Fixes: 35488e44ed48 ("drm/amdgpu: Move externs to amdgpu.h file from
amdgpu_drv.c")'
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

   1. As a prerequisite, sorted the inludes in other patch
      https://patchwork.freedesktop.org/patch/549850/ | drm/amdgpu: Sort the includes in amdgpu/amdgpu_drv.c (Mario)
   2. Include _psp.h, & moved vram & gtt extern defines into appropriate
      places (Mario) 
   

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 90faaf1eadcd..0fec81d6a7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -45,6 +45,7 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_irq.h"
+#include "amdgpu_psp.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_sched.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c3203de4a007..e8cbfacb5ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,8 @@
 #define PSP_TMR_ALIGNMENT	0x100000
 #define PSP_FW_NAME_LEN		0x24
 
+extern const struct attribute_group amdgpu_flash_attr_group;
+
 enum psp_shared_mem_size {
 	PSP_ASD_SHARED_MEM_SIZE				= 0x0,
 	PSP_XGMI_SHARED_MEM_SIZE			= 0x4000,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6d0d66e40db9..96732897f87a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -39,6 +39,9 @@
 
 #define AMDGPU_POISON	0xd0bed0be
 
+extern const struct attribute_group amdgpu_vram_mgr_attr_group;
+extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
+
 struct hmm_range;
 
 struct amdgpu_gtt_mgr {
-- 
2.25.1

