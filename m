Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACAAC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 04:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFB110E337;
	Tue, 30 May 2023 04:54:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C00D10E337
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 04:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA3TE/b06YBFvrwoksA2wjv2LzlALvl/U6fvcEbBZk3hfij5U4+le+AhjKrpJiXYc6BLgdDXWZ4YFA99GtnJudyR7pmKfC1UR6nuKc8sIyRAcrkLjYzM0h3rfJcli3mQPT7t6v56GLtYrLTHhwaVJJBvAqKw6+00o8qCXaYMvfB/YEXB6nQ+eEoESIo1e6K3N5fYud3a1HJg8hSWMCCcUrleanTLWMSYk+SBTR4NJL/72A8nn31NUfohzSuwWIFSDwGON8RwW/edmiJh5b4UitxLpqQvVpkpBcT44ADfvs7alCyTblgVTT4jqHvJR0t4Lnv/bLzqttd5ERTX2BzbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWnRBtfcP4MOFZ/0oPiQSvzdyDV9DnThaYahL1Gi3lc=;
 b=BkTUS78FaKY5Ulx33gth/T9m6sgAEwIoKX4h4izYXpvyOt1SKMtI3RD/6LgpmQgvwhyQICnmcMJdteB7uNFCCDNllYi5d9pFc5dGPSd61xv1NkHR6yWJgLNXjV0ADHhztcuyzaveptJJQC5N+JwvL2ylsO1NLegb3jdXPt4jRa0MiLxJ6wB5eQvUzYR+XVIsHW5PkqzB/524qUahaMRxQKZjxis/zAGbSc2CDhmXnTqCSFlz5TsGpXARb8uBOzP/OepPkwk3u0cQ7q6ZmKgaEuLrM/2IVEYl4Tr2refeb16nxOuuNJYQMC7al46emwCI+yflcKDGo7iApbZ0Ktur+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWnRBtfcP4MOFZ/0oPiQSvzdyDV9DnThaYahL1Gi3lc=;
 b=pTnetA4lupxf+wvGEiSC70/XmZ5tsyD3nN5uD6AwoydfcJjxI6io7ooVRihFj2YcDGCAkU+cUe7JgtjbpEui+vrhZNomiiwKzB+k/bfwblx8Hps/Ekpue0G2l9g3f405pTSyYOYF/V1SJYDoM5i+igZkKGUjusaiCWCGQXJzM7o=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 04:54:28 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::28) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 04:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Tue, 30 May 2023 04:54:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 23:54:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up missing parameters kdoc in
 svm_migrate_vma_to_ram
Date: Tue, 30 May 2023 10:24:07 +0530
Message-ID: <20230530045407.2266290-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: c89cf198-c0d6-49e7-32f4-08db60c9f2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOJT73E5JyXt3GArEDRZ1kV3OZdy2GE1dQko1ee4QNErqi10UeJ+Z6W4vPhhMLeUCz0nfVmQkcXz+SJrhnn0k0gzqji5SOvpaJl5OasnL4ml8TLDIlvzkQWmg1tnS8PyPhJDnDTbqzAAAHgIBaLgaFlPJqd6paMZpazAKPzBUJEH8TklrxHmSFjMFIkAYSYnkjb3nLtfnUz6jAuiEC2q8Y8dwBJ4DL1hHiwU8G940rOJ6IgLP6O3CZ4pD4Eg+FdmQDuudY9P3oxApyWkpyWZCEK2S0xwOf/KGLbWzUFZRjwU43sij+kLGjGp7aolTX2vVQtTbQO94lKNXNgKar9uhKJj3tyTr7JG+6cqq19nzdUd4bcZ7H2R1ZewiY1k/giJd0Zur0X0VfyskcMxg42VsCL8KGJ6p6D8KqsLW2BpTFDiojJ67sYAkWE6TmptRRxH4sO35S6U4Au+4lXqvhMF3mHvak5XiLswUpVqynbS0I+FkAiGE+Om6JrPoenqvuT16dQLpdxnmicpow/XgKjytMZTRRb3+AVgxw5OSm7qXOqeLERA06fdSjsPmaOtbizOp2SE/wQUzvffmBv7YPz+IArqtwA104/7phs4K6lQiHGKweLwzlIhl7fDCxH+R4mkcIWypCvER6n5nxpWEu9yTeqaWfmjXeZdn3/mTlXUHwUsQQbDuEN0rWMlp6vcd4OGepGm2ZY0MbZaxgR/CUog35hJrWq/18PIz4y56MP7GWEq/0jqajsTVGyNS+hF+7P3HgKQzpv15mde9LZC5JJPkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(186003)(16526019)(2616005)(41300700001)(426003)(336012)(83380400001)(1076003)(26005)(66574015)(6666004)(7696005)(36860700001)(47076005)(478600001)(40460700003)(110136005)(54906003)(356005)(81166007)(4326008)(82740400003)(70206006)(70586007)(6636002)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 04:54:28.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89cf198-c0d6-49e7-32f4-08db60c9f2e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

Fix these warnings by adding & deleting the deviant arguments.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'node' not described in 'svm_migrate_vma_to_ram'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'trigger' not described in 'svm_migrate_vma_to_ram'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Function parameter or member 'fault_page' not described in 'svm_migrate_vma_to_ram'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:671: warning: Excess function parameter 'adev' description in 'svm_migrate_vma_to_ram'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:771: warning: Function parameter or member 'fault_page' not described in 'svm_migrate_vram_to_ram'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 35cf6558cf1b..58d95fb99595 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -651,11 +651,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 /**
  * svm_migrate_vma_to_ram - migrate range inside one vma from device to system
  *
- * @adev: amdgpu device to migrate from
  * @prange: svm range structure
  * @vma: vm_area_struct that range [start, end] belongs to
  * @start: range start virtual address in pages
  * @end: range end virtual address in pages
+ * @node: kfd node device to migrate from
+ * @trigger: reason of migration
+ * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
  *
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
@@ -760,6 +762,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
  * @trigger: reason of migration
+ * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
  *
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
-- 
2.25.1

