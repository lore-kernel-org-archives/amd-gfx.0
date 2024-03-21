Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B8C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 14:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1576610EB3B;
	Thu, 21 Mar 2024 14:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7uYEVdp";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C8F10EB3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 14:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh5wobl8ypyw8u+DjVkw5TlPxq6+ZPq5Zdx6W9lC1/K2Qgkqd/eM6ZxxEatTQicwgr4IglT9+CqhaCy6I4ee/qc6C+sag34Ja/2ACOrGmBc7nFINKD46v8gMDOCzcZH24M/Np9ag0iWB6Ti+5z5HSTU1KlsA4AQhb4mC155GDiCLyB/oVdi2fIKOMbTGOgEDCN4FwQv+uKht8SxQwhFOEXSuHIvtewGihCKUOoTtGijJ3ycReBxDWgPRjhh2h8/r8TDvv3RQgVKhHTAxkhXrVRoWD9y/O8JFpvjh+Fi7yxZDkvQo3JE4mD6lncZKYQcITLv6J4YQ+EKoKdn0l6Qz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkwnQDYvHoR2SKptd5aU9Xm2ZhyJ2KEQCOUlZje3m84=;
 b=kIylUzY307wfW6G9nCevRFFTdBsM4tQs2upDATawJWxfvT6gZPBv3v/iOL3w9+xqey7PqkGiA5zMpQkjO9OhaUq5WB6EJjBJP2cuNqukzsND6il7wZmnWm0IU61BNbn7neGd+4GKhq/P7f5kPlY4jmGNHuPHMT6qFdcycQX1lcELZgOE7+dcfx18CZQnRaFwVp8SePTe0KyBzt08I32H6xed/z/WXfxLqVkQF4RkmTsaCo1zBUHWaXYxjjg/5PeW+TYdLwEZfabTReXbLXlDh5DYSJwYggagYiXp/wmNoeOH1oSH3un4efSvzc2z4WqP9ZY9doridO6GhzaYotJQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkwnQDYvHoR2SKptd5aU9Xm2ZhyJ2KEQCOUlZje3m84=;
 b=e7uYEVdpbaLvM3M9iWdW9nUOThi7ep405z1orT/j3ifXG4SaJHqb75vZrlwC4Z67EEyrG0XH+lDBx6NfCTDjdLdxqRvoB1H5IWjrT1tcMF5R/3L/CvkzkMmcVVpylbPLRDv6rSMvDTZhiDXytS8tnkC3cnyG33w+E5JmBl80TYA=
Received: from DM6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:100::46)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 14:35:55 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::85) by DM6PR03CA0069.outlook.office365.com
 (2603:10b6:5:100::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 14:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 14:35:55 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 09:35:52 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH] drm/amdgpu: Add a NULL check for freeing root PT
Date: Thu, 21 Mar 2024 15:35:25 +0100
Message-ID: <20240321143525.2123-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1eba4e-4d07-4096-5aaf-08dc49b437a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUjskQ6T5hSFHSPnN+reBRZsXCyJ6oQqcYHmTmoZtJjU4cbCjt4acAmhlFSRzEH/T6+kbWg1y2ipNuWt3OqVpYk/OrpJAL8AgsUIzHHmPvUBSjWfHffYMKfI5eTx6wb5qlTGHNis3YAx5B9omoBtBJMYcLIrJ7mJHCJ9KvqkUG3Gds0Yo1UMwrf+uns9rKLHUGlBttBxX32vph45EqUAJNDB9iTnb6wqQzXuSpzleiB97Ll1sy407rCK3LZ5MHdRb5W+FXJMQ85TshzOct/miUD1nA08FZ5S9PRdTZ3LpIMUaULTY9Aix0ZcH2dSfHufoOAnM56uwLPOmWLC0AlN5Le4zpT9AxgwUexaUxBMFUFoBATiZdatG/dUBHAz4RJvLCJ7DsHGkh/XVDmuHVcIhnvHi5joLkJuOwfdmPiOy55eVpKfDVwSl06rOA5CCgw+WMxkmdLS6f7cdzJtTWwoNRZYdBFyQswUFZiuNW44ugt2zibBHrPw9tRYxph9AtuSilxf1VzOSJ3KY7mnjtnA3P1CL6kAScUwV44rFTGoRH1mpvz1UCPHD7/KDitz7F4eyMTtGNumRcp3b5kdB6UJ7/mBSARtwPp2boyN0kqZG5vRQcXHVTWrsvESJ2rkj7APy1XkTFRGQpkRZbB3E2dXKrIseFmILqx7JPwVZx/CHmE5xSzUavoqBZXmPiclkpnGxqLOloqL84kE3G0FmOqsMAIUqoFAt/NPaMNVA3dj8CulHBxBFgz/UEQNxU8FwUVK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 14:35:55.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1eba4e-4d07-4096-5aaf-08dc49b437a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

This patch adds a NULL check to fix this crash reported during the
freeing of root PT entry:

[      06:55] BUG: unable to handle page fault for address: ffffc9002d637aa0
[  +0.007689] #PF: supervisor write access in kernel mode
[  +0.005833] #PF: error_code(0x0002) - not-present page
[  +0.005732] PGD 100000067 P4D 100000067 PUD 1001ec067 PMD 4882af067 PTE 0
[  +0.007579] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  +0.004861] CPU: 52 PID: 8146 Comm: kworker/52:2 Tainted: G           OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
[  +0.012135] Hardware name: AMD Corporation Sh54p/Sh54p, BIOS WPP4311S 03/11/2024
[  +0.008254] Workqueue: events delayed_fput
[  +0.004573] RIP: 0010:amdgpu_vm_pt_free+0x66/0xe0 [amdgpu]
[  +0.006270] Code: 01 74 6e 48 c7 45 e8 00 00 00 00 31 f6 48 83 c7 58 e8 0e ea 3b ff 48 8b 03 48 8d 78 38 e8 f2 9b 90 c0 48 8b 43 20 48 8b 53 18 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 43 18 48
[  +0.020954] RSP: 0018:ffffc9002e117c08 EFLAGS: 00010246
[  +0.005830] RAX: ffff8884867bda20 RBX: ffff8884867bd9a8 RCX: 0000000000000000
[  +0.007961] RDX: ffffc9002d637a98 RSI: ffff888482845458 RDI: ffffffffc155916e
[  +0.007958] RBP: ffffc9002e117c20 R08: 0000000000000000 R09: 0000000000000001
[  +0.007961] R10: ffff888482843000 R11: 0000000141eed000 R12: ffff8884867bd9a8
[  +0.007959] R13: ffff888471d68098 R14: ffff888471d68098 R15: 00000000c1dab300
[  +0.007960] FS:  0000000000000000(0000) GS:ffff88e1cf700000(0000) knlGS:0000000000000000
[  +0.009027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.006409] CR2: ffffc9002d637aa0 CR3: 0000000006410006 CR4: 0000000000770ee0
[  +0.007961] PKRU: 55555554
[  +0.003016] Call Trace:
[  +0.002726]  <TASK>
[  +0.002340]  amdgpu_vm_pt_free_root+0x60/0xa0 [amdgpu]
[  +0.005843]  amdgpu_vm_fini+0x2cb/0x5d0 [amdgpu]
[  +0.005248]  ? amdgpu_ctx_mgr_entity_fini+0x53/0x1c0 [amdgpu]
[  +0.006520]  amdgpu_driver_postclose_kms+0x191/0x2d0 [amdgpu]
[  +0.006520]  drm_file_free.part.0+0x1e5/0x260 [drm]

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index d904fc96ba0f..a0a5b955a4b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -688,8 +688,10 @@ void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
+		if (entry)
+			amdgpu_vm_pt_free(entry);
+	}
 }
 
 /**
-- 
2.43.2

