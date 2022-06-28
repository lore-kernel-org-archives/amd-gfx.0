Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2226C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5303310EAF3;
	Tue, 28 Jun 2022 21:44:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083A910E822
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkloub7MfR4I/eFR6G23hAx/5ZQaX1TPZMbCTI69Lih1gdF4XqlBvmUrQE4W5FlRJYdikw14oecbvDeVoAfWKsdRwFtBDhuu7EpligAN+qFcT/H9H6ovb1AhAGfISgwR/ZL1zsTAWLCG6Fq2Mw9pfKWV24BwTaLuvi3oiPbrBEH5vSqNTiiWgzUtqxigjzYIs03Owcdv13cTG4GTzrpbgjUvncplGRgbQ7i5Gyro9R/m+/K2G3dI5Im7O103uZgC+ZyLOCnSisFkAYGvLFFFLPR4CwFFFGGIXAJ8E6g8r6WEgyTLsDIR8grjbUfYKvnb/F543zIvcLSbVOv6Aq5CfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGufrzNTkNDHTBUVerDzv22p9pOVzBBqHvLoPu+Vt9M=;
 b=EbAPPhiFFMB9TsregC6XK8SMg8XDRQjZwYODohAXH9O3CRV6KcO2ro7iY3NWMNf/brdEAQ6HA24ZpidpQOnAgt+SVwZRGzj27b6qsKpwCsspDRV2oIov+mc0fB68LemmDyZpHmsPnKSQx8BGuFAWBypMyH+1k1I5XEDkGNMHHp4M8EuYt5YIEQylRvi33MWEds6L6nfhmfIivxr0rh3kLXA1sK7U9Cp3CrYU8F+bQ4/KEwLMBKrCMxhdsTbwGTHCE8JCnjGspqS4bGuNLFxWr8WMAcuBz0mQfjoMeJbn1Sl/VoDqTp5bbRqlrALmBQwka3IFOVqoTg+Cig8jAMOZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGufrzNTkNDHTBUVerDzv22p9pOVzBBqHvLoPu+Vt9M=;
 b=n6XnKM4x5cF3sC8FneeayKXbxbetX6VvKlZOi7qKKENopn41nzwN/1iaqVt6CjNmFm1LsjjK7rfcQi+L9AU7+mrVoZ8gKYc4oeacHT1nD0cFzENFjiLjUSuZ7YJ5mFKOeLArqsa9MeG6OBh3+GUR9+lROoOZzZQV0zYq0DVuRTw=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 21:44:09 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::90) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:44:08 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:44:01 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: add new flag for svm
Date: Tue, 28 Jun 2022 17:43:12 -0400
Message-ID: <20220628214315.235160-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628214315.235160-1-jinhuieric.huang@amd.com>
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3d5707-88fe-4318-8f33-08da594f54e3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpUzGAtPQ4lU4XVRMqFAqHdphoTF9KqkJf+hhVv5ZJVUt//HZRrjKrpJmOWvnSspVbhEksXnzo41VSYI/bIJE40PuO+d5LCy3TKI1qcvFXKgeG/F919csniQ/7BXuQoQKNqKOYY0VOIPUoHw+ZS/gn11y7NpZa+dhndHBK5jeY6iJwd4xwgLrXY+MZQUSeoOz+yhh9/l71RwTEtnJid9fhZNfRc5f7G6rUpYE+EWotuMm2HCA58ZOIwFMqU6IGPtIoQoat9Z/B1flgiJ1rNjBoKsOd2FcGS4npQhpNpeVeXbqiNvchKfx+WBFKgVcLSnFdNzzQcTo28PnPDTs3RTQhpCezXZ/DJ08FywdGLxxY6GEZVbk+rROR60dQR92Gk+BUWDO5h0EKPSpqlISpmgs/nR8Jggxn5wV1bA+onr99JKB9thJ9+vBd+g1Nj7WjcKBl5PTPznkAZ3txy0Gy1sLXhOcD+XTUGaSm06gcKBvMDlpr935VRJ3F1JAGmeKYmsZjkkk7TPJJzgjReM8dWkKxQxcVFpITWGEjlW+z00hilMc6WCS1zhtX//ufR7OamRt5skfYDFhR9HMMTtExa7Csyu4KWOr2skMD/1Y2hvMvH7VQ9NvAFSmAZAFPGEkAgSZwCZel7551Z03Cs83lVfFEtd991mPtftZkjKf11IECdjByZgpQk7Hg6C3DIlEa8CV2K306dDpua6F6bIChxbDOyYvLfb8pKcFWikkK5KJRIZcGigH4+JmY278WxzUkeLmPcgnpWxpWJ+osJIvn49t1jtDJM7QYAhvEPbwCraW4epq/BeShwoYT6csfBRJYurVJMlr+XtFSE1x2heMB5IDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(40470700004)(16526019)(36756003)(4744005)(70586007)(8936002)(5660300002)(70206006)(336012)(41300700001)(426003)(82310400005)(2906002)(47076005)(54906003)(186003)(2616005)(40480700001)(40460700003)(86362001)(356005)(26005)(81166007)(478600001)(6916009)(7696005)(316002)(82740400003)(8676002)(6666004)(1076003)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:44:08.6740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d5707-88fe-4318-8f33-08da594f54e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new option for always keeping gpu mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index fd49dde4d5f4..eba04ebfd9a8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1076,6 +1076,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

