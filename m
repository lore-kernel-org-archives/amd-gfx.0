Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB2C636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AA510E910;
	Fri,  3 Feb 2023 21:54:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A80210E91F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4OO+8/5YJ/p/xt/oh4/GVTZSEA8PUC6NEB4MYZBG8DtmKx6sGSK7pZE6AfVrMvBsUL+O8OQQ8+N5Cf95yGAuWiITz4OHZfrA5fpAbcNhJ9peTuDXOJ0k5MCBzVS3HjIQO+sk+k/+kiB8jyANioXv0JXsGeELDNc/HwMKT8oGJf8UtN1bL8COYhLgtT/eRCjftan98Gw7ZnbdNW/aY7iMFwl7jAPSSsgJkTF8tbL1EYVImd1qu53meyUW0QlG9Ne6/1uFpDEaAbd5KJllaDgIEmR3X6G4o+HLc3ivUnFTLU5o38dnNrZOFBAJ8PoREZlLpB0NNKEqsSvyCmkWmeWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rctg5KMTrdaZVzlsp8CucHYIsaiLX9PC66xcsJ6VB5g=;
 b=Ud1wL+vHXhOoYEkRNqi8NHE8YjVd8QhK4vTZ/H5euT2ZlkxgB2BcNa0nTyyfRqfXT3SyNGR2vmCWoghC6W49UaCzzJmyksUG43hqn3K6fU4tIh/hgbmCKpOWV+1SAWjl3nFmGgEra5+U8wqteC0GoHCDBWqITmUyvC7ns3V5dPJSMXsu7hcXKO8bzyI2jIpTidaQuBqzZE/zZJGl3uJ/K2gwTt96Pb2xKiw4ovwODo7qIExA8cgg0BBsId8QgFblhRdb5zTwtKEYWStxwkYvXst816cIpYS1KmXBg9/MUQPzTTxash5vHb8gDywWI4Wj/YyDU/PTaY60NgB0PkXnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rctg5KMTrdaZVzlsp8CucHYIsaiLX9PC66xcsJ6VB5g=;
 b=POKtCOGWErqKfvrjHFDlo9JqyJVBwQAiyn0xX5c3EyhmkJ/MKQmn6Cka0/rtvRhBZoD6iRrjIS00UgIcSv9SpD8VTLoBCWKTIrseak3pt+iH7hpEXzFDZhc82qk7KPtB+a19bQ7mCdaUiqNsbya2fRg/e2h3ppA8VrUfXTCGAGQ=
Received: from CY5PR19CA0112.namprd19.prod.outlook.com (2603:10b6:930:64::12)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 21:54:45 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::bb) by CY5PR19CA0112.outlook.office365.com
 (2603:10b6:930:64::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:43 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu: DO-NOT-MERGE add busy-waiting delay
Date: Fri, 3 Feb 2023 22:54:08 +0100
Message-ID: <20230203215409.2021-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: d57154eb-2084-4ad9-4495-08db063142f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5ByuPWp00qYfayS504Fa2yG0L4tQ+/wGDEpURne4bjBAGcggOOD5nfcj2PuScD8QBYuatFEFJgGlrkRvA+CQFOEstN+++NCQ3kKJQCBA+McH9+f2uOWD9lz5V6KywJae6pJRE4Svh7PhXhqRFkr8CwzR0XKTMD3jC9VnIQz68NOIi7iNTGy5dXiA8o3wPLXDQgNp+uFF4YCqd7B6kt6aF46RDeEf0fL7IVHNmzuPLXQ4DWpM/H4DuPZ5QQrH3WLbaiOJrnS8CNgO28Eqp0r/D6oU1EE4YI+8ZMdFZiOyeyiKJ+cI2I4MS3L6ioBvj3pNC4X0y+WmL+IM3fH/YOS9NgFdk6J9g2YEpHtQIyNKBnZeL017WsGkUlc9Z1+n/bQkF2HWDtMiRmSfTEth4wYIhTmpfl7In+rS2g7XvPlh/gzHvtBXv8akbBrf77CHdx6lnkGFIijNN4ehN63lpJFBwl1eXLWbs0WeTmg6+nudc1oKa3iN4tfTmgGaARSU2YP8FgxnJZRjRNuUXLvdWzenFPdmFllwwkxGAzafGyr8j25U0TvrEQRSr78Jmu4IIF2CHqhj3zOdfMBrtRTRUb1fR6pXwhKkI2RK4lXbwL8MJGBjTGkI5e74BlcjOMdgBlp61O1LkrSTlg0rVygQ4cPTe93qecAMD21O+i5w1/uFKFi3Odb9lV1Y1Nx03fAplHYomwsvj8132J/QmZCcExUc/h/FnsXlsiMFd5AEvaQbcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(316002)(70206006)(54906003)(70586007)(4326008)(6916009)(8676002)(82310400005)(5660300002)(8936002)(41300700001)(36860700001)(82740400003)(356005)(36756003)(81166007)(86362001)(1076003)(7696005)(16526019)(26005)(6666004)(186003)(44832011)(2906002)(336012)(426003)(40480700001)(40460700003)(47076005)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:44.8457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57154eb-2084-4ad9-4495-08db063142f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Arvind Yadav <arvind.yadav@amd.com>, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arvind Yadav <arvind.yadav@amd.com>

This patch adds 20 ms of busy-waiting delay after mapping the
usermode queue in MES HW. It was observed during the testing that
this delay is required for expected results.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>

Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index cbfe2608c040..a28ed8e98f7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -24,6 +24,15 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 
+static inline void userqueue_busy_wait(unsigned long ms)
+{
+   unsigned long start = jiffies;
+   unsigned long timeout = start + ms;
+   while(time_before(jiffies, timeout)) {
+
+   }
+}
+
 static inline int
 amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -85,6 +94,7 @@ amdgpu_userqueue_map(struct amdgpu_userq_mgr *uq_mgr,
         return r;
     }
 
+    userqueue_busy_wait(20);
     DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
     return 0;
 }
-- 
2.34.1

