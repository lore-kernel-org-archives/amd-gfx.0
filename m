Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5528C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888A66023F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 888A66023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324D46F38F;
	Fri, 30 Jul 2021 02:13:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B171B6F38F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KktGXG58YA5ozDfUHVgMMzWTFtWxrqFHyRs15vvQDzHfjWOD15duovUUfwJeGwcvYBdmIEtLxB/Z6XNmMOu7Q0Tp/kPSVrJhIwgnWIZuk8DiY1EP24+u0fGS38p/M0k3dGdasms6Tp/9Lh0oTTNAS/8FsdJ3wPvf0PvY6RUfe0KvXnQCanUwj+v2E+FcfCjoVvyQOV05AusaEXg2hd4uHYuoGnVlc1bc/BKvcMaJ1TeDBnKAnvUKOLEIEvJznz7ess0MEY3bgULgX0GgyydL/Gm0nQQuWEYHhtOgoC8V56NmE+TJydVGh3D7r4861/icaf7Pl27u/Ro9T/VFcRyJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GKxu2Ne3c2oCJ5eABqnbJErohD4CCb+1R66kn5sw8U=;
 b=hsbhErh34mEfRpPheZjF4Cd2l8iJsoOKlVRU1SIq8aye1dfkKzCejOz+3M1X5NH36QyAm4xJXFPBXwdNPhahi4Nu5zavdtjfrJkHNEmT0rBry/bgUYWPAggP/qFHpb2Ch9qEEqJaNYX8Zh+syjMh3Jm64x5ydVMTBih2TmA7r+f9fWqUawSqhaxnw4wIjZE2Txc1Uj+MQuWdR1KBmphY7bf+BcAWjedv9whLFvI7qPNOr2wcE/cMh6ONazWhI4OiFGCCller7Suc9okAH0FCFZ8n1REVCEgmLH6TK9uLRbqUIwlZ2TKuWrS0XD5ZTf5EF24vIhb7QrSodL5i7U/+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GKxu2Ne3c2oCJ5eABqnbJErohD4CCb+1R66kn5sw8U=;
 b=fgW+7KFIsvgQ8uqUkS+8wkzJRLmdTfJQCtJAxdDGUWj8f3wHntXbGwHyL+DbAx7fjIwO/WweSFPmfbPHFKNhhLxedC9cLdkqvYw0+JzKEzeTgsidBgcX3W+4jakljky4eZk7MEZzN2XJnZ+yasHOaHPfRfq5FqV31DemJ+y6eF4=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 02:13:36 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::98) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Fri, 30 Jul 2021 02:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 02:13:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 21:13:33 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix fdinfo race with process exit
Date: Thu, 29 Jul 2021 22:13:21 -0400
Message-ID: <20210730021321.7953-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18de7c42-f7e9-4203-f006-08d952ffa2fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5127:
X-Microsoft-Antispam-PRVS: <BL1PR12MB512753C40611565D08CBAD3FE6EC9@BL1PR12MB5127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OIhWBDd1iTsyRcmlw+tNmJFuHwAV8V5+FH3i2o5gv377LkwmpFJ4JZsga3fBPwu98PM9Cz9nSse4FSp5GG+X6CF1Jj0Buo+puRnCEm2xoo10qNBET01gCoMnaXboeWSO7ix5E1nJNyEWwTkfBP7P0U8YajOIIw7sNcUxIHF72fzm8zOmcRFANu6WIrGU7nUi8/OjuXF4DO1jOi6zBORqmvJAKj3TGYgSCk/z/CBXjSC/Jlfc6LkwJqu+8RIb0JXmN15UrliB+EYEBCbJAxjnAIKDyr5oh41Ff9fOMWol7Lw6zaUc6L6RoQMEOJRj/Z719ctw9nIVLwh4gKauCGugU9AWIvzo2aDoMYi+LX8LiULw07Xllga3fG+PzRl2XmvIGOLo4UyGRDVLy61fQukuU+VXmHyD42nH+WR8jdKwFufB1AW6WGCv/rn/1wUSYyBj1Rge8eFHemu+HeXFaDXrt943UWMnnLSIDPCWEqzOgcaH8PEDkfjSF0TQaj1YSa4F00oH2TEIOOaEmuup/OzztsSa/VfiWex955Y6YVcLjWxfUfCxg8SHBuIuPyoSKSQdTZV/r7FmJKLH0ZLvOBcJEcQEsOhyX041wUzHPbm/ISSr7NVfBZtF/mrIGpStGk+976FzJgZkO+Ckc0WppxjJ2G6bKFfymg3ukY5MiJ7lzT7nWhgjPZ0mlBW/AWyb4LXJXx3pMUVkA6zklc2eWYvBYY3xuBLQI0Kv8aXlZsPUR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(86362001)(336012)(36860700001)(6916009)(26005)(70206006)(70586007)(1076003)(7696005)(83380400001)(82310400003)(36756003)(16526019)(4326008)(478600001)(82740400003)(2906002)(8676002)(186003)(316002)(2616005)(8936002)(356005)(5660300002)(81166007)(47076005)(6666004)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:13:35.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de7c42-f7e9-4203-f006-08d952ffa2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get process vm root BO ref in case process is exiting and root BO is
freed, to avoid NULL pointer dereference backtrace:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
Call Trace:
amdgpu_show_fdinfo+0xfe/0x2a0 [amdgpu]
seq_show+0x12c/0x180
seq_read+0x153/0x410
vfs_read+0x91/0x140[ 3427.206183]  ksys_read+0x4f/0xb0
do_syscall_64+0x5b/0x1a0
entry_SYSCALL_64_after_hwframe+0x65/0xca

v2: rebase to staging

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index d94c5419ec25..5a6857c44bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -59,6 +59,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+	struct amdgpu_bo *root;
 	int ret;
 
 	ret = amdgpu_file_to_fpriv(f, &fpriv);
@@ -69,13 +70,19 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	dev = PCI_SLOT(adev->pdev->devfn);
 	fn = PCI_FUNC(adev->pdev->devfn);
 
-	ret = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
+	root = amdgpu_bo_ref(fpriv->vm.root.bo);
+	if (!root)
+		return;
+
+	ret = amdgpu_bo_reserve(root, false);
 	if (ret) {
 		DRM_ERROR("Fail to reserve bo\n");
 		return;
 	}
 	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
-	amdgpu_bo_unreserve(fpriv->vm.root.bo);
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+
 	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
 			dev, fn, fpriv->vm.pasid);
 	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
