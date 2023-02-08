Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A666AC05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 23:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DE210E8BF;
	Wed,  8 Feb 2023 23:26:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE06010E081
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 23:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiduGMYYIMQCb8rlQMZp0O4kjaVCG40sxCR153RcNbxLcFL6CQGicnh18QJYn7fILAii0WZjXJJUwdJtnzN7NsJbaK5zfgfB27Vxq+ILKSwfW4PdbtSAeE3N2OiiXGYO9GvLTa8e+NUa1zhM7k/HsKITk90QwzGDw+bs8wLz2opF1aOBbbnyM9HjrgWCfdbRZw9wQ+Ks+hvadKYD5jh7EszIMLHSRNBVZ3Q3Viu/Pvt9W3U22p0uGQKVpBLKiFIUb8nv9rkt8/zKWet16eZ3oGuVxleIr4HnP7eM2j8nbcYcGQVIjfQh6X7GFe5pZIA79iqHZzWa1+UvzImuCA+vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX9ZN3+IdazTC71DxgKUei1c0Nx/ClJASuO3CLADdhw=;
 b=bRwv/ADlGvWQEJ4sHqaag3RL3X2nQoF+qUqynw9TkYndOF5VV3E6TTW9MvFUCUeAdSGGOXQsxInzs1xdubLTzjZIyB+fuJWb1qMJnRwEHzZ5zGB4wSJVXUfknYdolXtmJVQI1/TOX+2uB+jD+owgDSpPm9L5gBuHyloBG48g/k1e+hOQeTcNdCjHwqse6gRx6RPcUXsXMCdmzAO9Kb9k0Qx+zQQOU1zZsKX8IAajeJWMGMZPEgSaRiI4ptIrnDhmYIdkvJi9Fh4h3oZ0iNciyCkAqHaCK1KPYcPdKYKlkxywkL+045KVDyACApOlxAU3JG5hfSl55DM/Qy/v93EJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX9ZN3+IdazTC71DxgKUei1c0Nx/ClJASuO3CLADdhw=;
 b=fPh8Jm4/8pUiAM4lcOQNwRHF8wVMFmn0T9qvx1UCWpDp5hc+xoKa0Neb/USSWNkDBIAuNUY40sBwWqizgagbRZI0iANvrzYr3tC9khqHR3sHaY43MMjmIhPp2L4Bfvat2k/Rv0eJcOCophKF8JhK0i7/seYLR9lAOU6rpr3d+As=
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 23:26:45 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d::4) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Wed, 8 Feb 2023 23:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 23:26:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 17:26:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 15:26:43 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 8 Feb 2023 17:26:43 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Prevent user space using both svm and kfd api
 to register same user buffer
Date: Wed, 8 Feb 2023 17:26:33 -0600
Message-ID: <20230208232633.1399053-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6034d335-3357-43dd-d669-08db0a2bf130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1JdjAyE5PJOvU0HcAVZTxJGFDOcEMqaeXXB5K82OPaD10sREV5QA4A4+Ykoproa1hzoKwYXnj+5hU+okVUMTd6SmxLoUFmjtozwyf27b6Yf4e9Uorh9ngi+hiuziaHh2V7EOmKdOdJlLY1jwOCyHj+cGzG8GxLfV9yBAhRqkitOPw2K1HI/P+8PhD2Weq6bA7Xhpkqm+8qYsdyzkMI/W9AUKF3pe37+FnqopkxATEifp/y2h6d22vn7PBxnWROKrPnFN8Sde+Ok2GufPteXeV/NE/SzwykmSLHYdLiYkTodg2qm/jsjvT5YRcjzJ3o9x1u15Hw3YW23NJK5mUqQtplG4BDxVj+aCTreH9pSy4sUG9r10QjkL+SKFV9TUqqDe3ZaAAWldqae44VUx9x1LF/85cFydrpN0ns1YoA5SK6mo+eO0iiYPob5agSIBMWizDbTzMEXFwus+t4Q/aNgTVTlRP8bL3rfwE4Clqz+tFf+PMeggB4G2nuzziiF9jCLJR4eYJ0p815Ax/68QhmkUd+KKOk3BamI31M3qH+fiPcVhZkPnjkZ3ws63nxLJUbsJNlV6DwnpTTFpvMTAwSLHhmGTvWAi0sOkAg84JzIzlYMNt/ZOiFbvScMTsZO82x4cj77+5xHz5VVBaubQ+JkIdJlWJcPR7nB83cNfgkFKelOerJzpcMx4vKWxHOCqH8FJ58NsRlq+rfmQ0R4xmTFpBNxRQykn0axkxo38PxJY98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(8676002)(426003)(83380400001)(336012)(4326008)(70586007)(47076005)(6916009)(6666004)(7696005)(70206006)(26005)(40460700003)(1076003)(478600001)(186003)(40480700001)(2616005)(54906003)(316002)(356005)(82310400005)(86362001)(36756003)(82740400003)(5660300002)(81166007)(8936002)(2906002)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:26:44.8032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6034d335-3357-43dd-d669-08db0a2bf130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

When xnack is on user space can use svm page restore to set a vm range without
setup it first, then use regular api to register. Currently kfd api and svm are
not interoperable. We already have check on that, but for user buffer the mapping
address is not same as buffer cpu virtual address. Add checking on that to
avoid error propagate to hmm.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f79b8e964140..072fa4fbd27f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1065,6 +1065,20 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		mutex_unlock(&p->svms.lock);
 		return -EADDRINUSE;
 	}
+
+	/* When register user buffer check if it has been registered by svm by
+	 * buffer cpu virtual address.
+	 */
+	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
+	    interval_tree_iter_first(&p->svms.objects,
+				     args->mmap_offset >> PAGE_SHIFT,
+				     (args->mmap_offset  + args->size - 1) >> PAGE_SHIFT)) {
+		pr_err("User Buffer Address: 0x%llx already allocated by SVM\n",
+			args->mmap_offset);
+		mutex_unlock(&p->svms.lock);
+		return -EADDRINUSE;
+	}
+
 	mutex_unlock(&p->svms.lock);
 #endif
 	mutex_lock(&p->mutex);
-- 
2.25.1

