Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673B9C05027
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 19:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0302010E852;
	Wed,  8 Feb 2023 19:58:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA3310E852
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 19:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltNdbinS9blSlcMuVL+H29Qs5sMkXw1LY/WEcn4D9c+g/9IKtWJvCon7ERMIVGMhRNDO9uPyw25URR1wZY38IM62kuS0zdfCkZEFYLgC8p4CTl2t6PB6n84XAGYIszvc0HGcE+mlYnbs9J1P6qFVWqGaovL5hAyX1e/Q8YZrlzcq4TcBkr9ddBK25F5JFaNsAjmrg5RqUrPfp+gIeItEaosx7raJl7hLiHSftjpcEPMTPkxHvCNUdDrNgIykf4Vc6aCQ9BUQX3rTSt+goPqXoZf/bfmnzHV6bOjpnCzUGDw1rMMUVH+bGcEhcHEl9+MNZEt9MHuscgq33WqxRZtM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+GEh2BIb3+TWuP/LWMVTUdDdT9xNd6cITK0DJirC6w=;
 b=JeL003ecQcn3YGads3smrqidn8EKe/6DvYnoH4XeNmaD7pVJF3wxC4kavocChBdExIjEeDUwR5+7R7C9aOa4F0BNxF+zViDdindEeBv8c6wBdLwGbb1ZCdCNFcFYqiB/9owYj7SrxY9B+qE0HMVuKhopStog/qGR2sc+jqVAEG7TIFyR/ptVVL1gRM6e0SyUsYmokwgkelwDhp6QVSWsWFo8ZZS+Z0zEcOcUlm1R0i0Q5il9ebHov7oEggmU8IFka/bh3ileFLO6+L0Ac09Lp7MPYpQji4QMd0ot+vI9EgM3tEz2LDF1kDnV7wf/Yca4znijSXxvnlNdcis+AYwIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+GEh2BIb3+TWuP/LWMVTUdDdT9xNd6cITK0DJirC6w=;
 b=np/86WJauI5eUHuUfGkQSd6J0q/eghfil0knIh7r/sYD9Uez7KUKpRyD6kmzF/8wq4tmRfnD+ZvnIUEOctQC7At+kFBwFvzpsHsRP/q2fPU4iO2Oep+vhA6DStXw/Q9//XGpS+KCiNWegLH4jJnkpqMJsnC7LYvff6av2OqzKyI=
Received: from BN9PR03CA0576.namprd03.prod.outlook.com (2603:10b6:408:10d::11)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 19:58:20 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::95) by BN9PR03CA0576.outlook.office365.com
 (2603:10b6:408:10d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Wed, 8 Feb 2023 19:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 19:58:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 13:58:19 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 8 Feb 2023 13:58:19 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Prevent user space using both svm and kfd api
 to register same user buffer
Date: Wed, 8 Feb 2023 13:57:47 -0600
Message-ID: <20230208195747.1269250-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 98074be6-badd-4526-feaa-08db0a0ed3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r1DTwZH9/ynfKV39rF8HXH2LaVR0z4skBNSrUgn3MEz4MXzmr2fefO5bM0JJlfEPocxIoebmnpXd5562yWCSSuFC1EkFGR5hyE4ixBDKTPervRJAH0zAfdTHIUsQvdO+2+ifjmV4tZ/xtqf4aG9hgUzSwav3U/99VMFX9T5MD5g+tNGNv4QXEKtaW/5rB6EDqHjFcsKSIBTYESQlsQxlIfnvnbOhpiM9mJ69opnJmfr4u2d8r6UqUWcxC4hJuedTYkLMOhfkhp9gQkfWwFy1bUrSmBMTnDeM/bQ3KoW1PRgywNgaLqANYog6KjU5/+2nmT2pVNWUkiDP583elT7sPHjty2IMOGRY68qIeaNmPmkKokDf1N1RmBYiuybZm8hRABhoYRWefS3/wx06QYYr++MMLcfBkmYBdOx7bXLOYRkuVz4On+HF5py5rHQdJLmLClI3IVbnwtGyZxrZ3tSW0toBUncZeLFt5FqQrcgt1qJ5guGWiqwsc4+X9W1qrHpIjtBl3pzzUIeW/kFwiqqJUINPg3cc6Eo+SERHoRpNKn1CukSwBFd+PDnyNu+jtKZdpw70yxr0st87tj8IMeZxt/W+TzvWehp/xXZqrL/aVJPl/FRBhWQlPGI20y0lATyiegZSftORS1TFIuVlvoEXtEjOj0W/freHWWop0cqJYyIK5+8PLMo2Wed1aw12N9rFZ7alhQuiytCp/027kcJzD3IXm83VDHgIghgKHesubw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(70586007)(316002)(41300700001)(8936002)(8676002)(6916009)(186003)(70206006)(4326008)(5660300002)(86362001)(36756003)(82740400003)(81166007)(356005)(54906003)(6666004)(1076003)(26005)(2906002)(40480700001)(47076005)(40460700003)(82310400005)(7696005)(478600001)(83380400001)(426003)(2616005)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 19:58:20.2515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98074be6-badd-4526-feaa-08db0a0ed3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f79b8e964140..6d9cf860d2da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1065,6 +1065,21 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		mutex_unlock(&p->svms.lock);
 		return -EADDRINUSE;
 	}
+
+	/* When register user buffer check if it has been registered by svm by
+	 * buffer cpu virtual address.
+	 */
+	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
+		interval_tree_iter_first(&p->svms.objects,
+			args->mmap_offset >> PAGE_SHIFT,
+			(args->mmap_offset  + args->size - 1) >> PAGE_SHIFT)) {
+
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

