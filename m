Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E9C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 22:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDC760EC0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 22:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DDC760EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F342A89000;
	Mon,  2 Aug 2021 22:33:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A80089000
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 22:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHGBbztdXeWjLQI8UdjZg75wGxyzgdyioMErB1oS12DTmzTFA3XXagO1F/g4mKa650TMDPFDpOzrMz4Qg+i4ziA/Rjuit6xvWhkbhOFZrxHqzv3JtDjProJrWcdaice7GcemGZdhx3+rsjp2dFeYGVQ5wUSGgCyGt7YPClILnFUNV5tsVXBxtOnKxs7Ub1FBK+xOtymgOuxTpgLADo67yrcmQsRK9eQeOp5ZX36ymfnnBSJqIbXmEtio77jWZbW5eRygijnsjcL30r8DjrkIw2FVox5yQKabebGZFKTA0vfGG4hWyHtNypM98dw5/YwdScN9kJKNzZ4bPeaPj7roig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB1jP3CE5WwxNojsGKCQS9h65Jh5iTXambX2KnckCfQ=;
 b=FEgqZ6E661PYZm9rWxv1+dOYIybxD15Muf8OPlwwbt2L2kxEZyWKvZ4CFgLjo8Yaewo4P7R0ChHkrZ1beq2nzR1Ckzl87m2h+tqTqRLG6st7VZwTevacBSSmrefekZYmlgmcoZd6CgvAxN+Y32Plv6q37SVG6n6vdFFEi4AbxSNF6icEIRty39BHlK2OOXFPy2ZQ1cJeffKaSfNvX1NAXKIdL0k1o4Pyy/zmAmAa3OVLiiSKOuLeVs0oi/hxTJL5MKDO1dnN6PSkPJkm9N1fE6oFXVAa2c+gAF4bOdgXDkZFCeGNUXeiEs3a3Z7LvdN+jzs0k/HU9DmBVTdsnl+a1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB1jP3CE5WwxNojsGKCQS9h65Jh5iTXambX2KnckCfQ=;
 b=dgcetVBCfR0aJJeX2bn4rnRcYPD0IFN6JbCLVw3cC1A5BbHvnE95DWjverdMZg4KlTjhtiTjgoSAYm4tYGlycUCXVc+1u90HC+TBIKZl5ByT0AcMxVdWK5XbaaiRDa56ggadAPzo6vG4zq6Hao4n81AmusZEMS4Evp+OLkGtR6E=
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 22:33:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::81) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 22:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 22:33:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 2 Aug
 2021 17:33:21 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix vm free pts race when process exiting
Date: Mon, 2 Aug 2021 18:33:08 -0400
Message-ID: <20210802223308.13076-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dba54c6-b9fc-4262-6ce1-08d9560588db
X-MS-TrafficTypeDiagnostic: MN2PR12MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3920EA79CE45933E4E3E997DE6EF9@MN2PR12MB3920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY1CtElMmvFDLAy+cRI/uBi9yKu6rIoNMmjT9NfXWP39SdqJJDFob0emqo9ddwdRnJNvrwtZL535tbbMc14+h19Eqdgwm0Awne9qH3GoIkOqMbBCTDAmufxiclS1rM01TpuF7SEUwfQfv8ipU1ofiHcLrci2DU2cXtAgu7wBKI6LxuVYRWQtWatIxWQXLDqwSRnIbnQ8lFhjvJHLKgQqn+FTsSTnsWbOy308rW9Tsm2MDVajAQ34AQmoyyh1npIDizln6mHMtqS6c6Nhxt5I1Ryk7g39LNm69LHf/08tJRe7mxsqmD0c6lZnCtoWJ3DDQEnmFJQ6vrylTZPulds8TKeDcg54j1iSAOe14csqQsxquOp/f+T/x2EaLjpcm4OLmhnWvndyc7x+Qz4U4pVGLKP9vOcZBFgqj3fcC95MA1e7++c/SXVagdokikg9oTW0bzhHXC4YzHTQONR0A+od44KQfSsN2XZBA27Fo1JLRRlXVeyCGApPH1xioxNdv3lTlJNVYB7VMs+kaWAAf59i1wEw88VIgOBmz/YqaXHDsEbNSF1f1FUiQXRvQ3fhlYvUKneHqUnTZxGwQl1WwgwEAj7InT1kHXd1kPEOwcnZfw9Lne8wXjdHpTmDMjfHRBBSK/REARCMsm6y7K6hCivBqmjf1SvoY7EUi9s0Nn1ALPG9YZXbBsCXrWEBts0AukhRB7i/S7sPt0YutNSF1o5b0/VOKrcbzeDTbghmP9hNqQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(8936002)(8676002)(478600001)(26005)(6916009)(2616005)(316002)(2906002)(6666004)(36860700001)(47076005)(7696005)(82310400003)(86362001)(356005)(81166007)(82740400003)(1076003)(70586007)(70206006)(36756003)(5660300002)(186003)(336012)(16526019)(426003)(83380400001)(4326008)(63370400001)(63350400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 22:33:22.0112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dba54c6-b9fc-4262-6ce1-08d9560588db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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

Take vm->invalidated_lock spinlock to remove vm pd and pt bos, to avoid
link list corruption with crash backtrace:

[ 2290.505111] list_del corruption. next->prev should be
 ffff9b2514ec0018, but was 4e03280211010f04
[ 2290.505154] kernel BUG at lib/list_debug.c:56!
[ 2290.505176] invalid opcode: 0000 [#1] SMP NOPTI
[ 2290.505254] Workqueue: events delayed_fput
[ 2290.505271] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
[ 2290.505513] Call Trace:
[ 2290.505623]  amdgpu_vm_free_table+0x26/0x80 [amdgpu]
[ 2290.505705]  amdgpu_vm_free_pts+0x7a/0xf0 [amdgpu]
[ 2290.505786]  amdgpu_vm_fini+0x1f0/0x440 [amdgpu]
[ 2290.505864]  amdgpu_driver_postclose_kms+0x172/0x290 [amdgpu]
[ 2290.505893]  drm_file_free.part.10+0x1d4/0x270 [drm]
[ 2290.505916]  drm_release+0xa9/0xe0 [drm]
[ 2290.505930]  __fput+0xb7/0x230
[ 2290.505942]  delayed_fput+0x1c/0x30
[ 2290.505957]  process_one_work+0x1a7/0x360
[ 2290.505971]  worker_thread+0x30/0x390
[ 2290.505985]  ? create_worker+0x1a0/0x1a0
[ 2290.505999]  kthread+0x112/0x130
[ 2290.506011]  ? kthread_flush_work_fn+0x10/0x10
[ 2290.506027]  ret_from_fork+0x22/0x40

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2a88ed5d983b..5c4c355e7d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1045,7 +1045,9 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
 		return;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	entry->bo->vm_bo = NULL;
+	spin_lock(&entry->vm->invalidated_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->invalidated_lock);
 	amdgpu_bo_unref(&shadow);
 	amdgpu_bo_unref(&entry->bo);
 }
-- 
2.17.1

