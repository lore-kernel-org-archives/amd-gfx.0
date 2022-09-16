Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A6BECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D35910ED76;
	Fri, 16 Sep 2022 15:06:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE2F10ED72
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDaXMmmcSSXS8EeUa97cpHCFswSgEMloADoVNHuugLnBNYxp0SZwSHziiqgucSSYigAp4r73eXj8p4cF6fb4BNgJo+POvTuje3t6sO1n/lTfN0Jpn3PU+f2qDY0n3VDOenljbrsLCwE+dg+3v7nyHvkUY72e2PRqZngTmM+mg7+nifkBPIigXj0it0Tyun3LrlY8JYiBJyJt9NNcUL8HU7BsXMB90knXz/ffmVzfrwiHMDHcWobVZdg33HJO0hz9VPO1umlZ1B3R8Pv9yWL8SQ7HmwC9Mzk7UVIXZD1kGs73D0TzxPu9sb1Dh2Djve7AI0cs62tvCyNHebkeX831zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knx0fqyS8hJYVZeD/VFrMoxtkw6QU+2cr8gMXK2//bQ=;
 b=PfSVlvvS/bJx6+0YWeVQ5vvzoCxbmVIqVZ1W4kszakei6hXh2EG3E0pNegmUdxbF80jJRDKWmRBsptAh1CX/xGBxmSnMe9qRmscfMkCJpbUskI3RBEE54P1wghpt911f4BfwDMWA2epMXzsTzgF3GtQ3EUdpm0nm7f3JDcEVvUTmyEpVJ4fF2Odu6pmK7lPTP6xs9O3zLU6o7IjU3MbddeKfm4/vkQC0dy1pCZ/achIr8g3edO1HYBb2jPMEZ819lkFloPCqd7F9mDffD9Dbccm2xdkb1l8WB5VBUdbuyZCX8EPP3cyPfKzLph+5Zfzx6E/KRuoVae+gjsyBESDWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knx0fqyS8hJYVZeD/VFrMoxtkw6QU+2cr8gMXK2//bQ=;
 b=q9j5ADvjU3LkfRX6jKL7y3KgF+4UlYK9RU8eOZ3pCcUVAq/dh28OGKJ4qRKP+y0PAdS7xRyMo8o/eOlIUg7b4cXC8YXqo6Fk0xP3BpA+DMl8Y9+IYoNFNV3yJYeWkTr1p2Ge5S8OmsQedsTpmSO//2Lz5vqxOIiVhfJPh8VzbA8=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 15:05:25 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::7c) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:24 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: Use vm status_lock to protect vm idle list
Date: Fri, 16 Sep 2022 11:05:06 -0400
Message-ID: <20220916150510.31321-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: da6640bd-aeb3-4306-b651-08da97f4e227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SPALwdQKMldwN53wR2Cfv+mDwPC7tdynNiRWVjbynlXNb2RJkGCmuCHEbssbVlwXN+k2hUJu97vueiUBrG3ATLXYUCU/Tk3MttKKr3pYtv4p3ax58DsshiQVYXIwsPzu2bkGXLGMtp6PbzzpCgHqItfW/MGufFTz5lyqQkbCvSL2kqesF6JM9MmBjEFOYUCamp5MYYu9GuCqNUXsCknbr7B2J1wdWwxfdmU5Ryiwst1RVXJ/YsQ2jb/uPxmg9zkkDS1NSLBQciMOp5u3L58caxBATbAi76IjAUvxUr/XbhClbv3klFqSWMQq7P8iDGJyV+cU6BsYX9JOXoec78qp042FZKzoYQVbcryvjoIeiAC9sFIvjg4jS+YLIMBaFd1i3qBD+uXGG+DBgr13OYj1RKebAZUwHAtyzVBj9NffoQ/ba5xuz/+K108PTo8OY5mMftIXB+RlLS5fMDX28HmM4G3Jm1SIkf7sTXRmP7fd/aWs5NBbCRTtKUQpIIoTP2puohe2pN+Sh1lxfXXyZO8bszT0M+uOY+ojcdYxg7Kfla7h1varDbG4GWHcrJhIYZQwkLXuAfGM5WTWKxEJdjl2CO2xm3nxZOhvON7VgRabw3hvbOjHpm15ej8vIcWqWhyWBg1LsQyXVU0Dx2cDbW/iTf5eR89Db7zKdCSYkCmnr3R32bEuKd3eOhgMWc9tvCXBgNCwnaiy250DYTmnQjBR+USzRtS3CsBX+V2bADO4NYooRtTJZ0N64IuWttxm0u4GM62X0iwYlxOW26JQi+8Q5JGSYAs4tpcG5qWsaG2oYZl4iEf1GTIjwl3w8J7fSwd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(82740400003)(8676002)(6666004)(478600001)(356005)(40460700003)(54906003)(316002)(81166007)(6916009)(70586007)(186003)(5660300002)(2906002)(16526019)(83380400001)(426003)(336012)(47076005)(4326008)(70206006)(26005)(1076003)(8936002)(36860700001)(41300700001)(2616005)(86362001)(40480700001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:24.7164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6640bd-aeb3-4306-b651-08da97f4e227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4a1cb20deb2d..c3412709e626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -211,7 +211,9 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
+	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -2554,6 +2556,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
+	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -2591,7 +2594,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-- 
2.35.1

