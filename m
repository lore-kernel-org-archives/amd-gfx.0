Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBEAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACAE10E5E4;
	Tue, 28 Jun 2022 21:49:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F6610E5E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUNsl3zh3Uit+q4AviuH8P5RU9UyZvRnUePIDIJks/pVeACpKBoPFbpV1rLiwh7iOKQV6m2M3gTysFpoanHQ2LlyKm3USmIhJ3zqSEMrAYWfYVhbnO9xqJWXoerMTVsAbgMINbVI4JpraejUXyuKVQTk+pRdac3AEDqN5Lz3mMkkfePrzThf61AzBRX/S+/nru35QUOl4DsCyPgJ03LR1LbvpccsTa6f/peDpbsvvXdjUcMg4koCANA5ZV3diMGTdVjrj5/9d8ijflmofczWASKSX1dBYXxcoGl1SBuur13I3Ce2GfTy1R3aQ5WgEqCk3UP92EM58jXjC8fz/O7PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=CjX0ryJGzLmon3k9QFcD+UpkKmaWkFGhfkL4NbWvA0Sj0gxkacgbo+1r9aE4fFFC2xtPjp7Zp4vhbbOZDCGD6/570ztiVCFCzhfpsjmhADP+I4KQoNzQshc213auMhsThswe3+YOviXPVBbCLGHmsXFi65oZZ89HiSANh5Klb6GabgpqlnKJOkzuxDrNr+CngbbG+RNeq2bjhtfxLLNQflJ71Tc/5NmlsUu5LF5YjWVVHr9SVMs6GNf40urke6T9+gvMdoJzWy5y6q3GjLAFSxe8exsIKqyxUqkzSbhTroDkR8wAVEDZILEdjYQQTvcpZlRhU2VoNvoghKDzjoH7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=kGcL9D5MYC18UCKx7kxnJehqfrrf1tWLjmBd22S5l9GNukyhQpLHbw52mXfJzaFhTdW+NSfMhSVlTS3sh650fXmq8hvarsjDhaZVVaM7giK8MfcEaXoHeybGwvtJyhs18Bchg/UcZ5ABnKFQ8sexSp/ErcUZP2wrBfFOo/WJduw=
Received: from MW4PR03CA0039.namprd03.prod.outlook.com (2603:10b6:303:8e::14)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 21:49:18 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::76) by MW4PR03CA0039.outlook.office365.com
 (2603:10b6:303:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:49:17 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:49:15 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] libhsakmt: add new flags for svm
Date: Tue, 28 Jun 2022 17:48:54 -0400
Message-ID: <20220628214855.237602-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd08a371-36ac-4cdb-f291-08da59500d0f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SUd/P+Fa9V/Ng7iNFnwYpi/p/D9yWI/gtPYgxKMjzs7UABv9aW8y2026cDR8WcJBteY5S4OvGg/meBGeEJCzU/Tkfx73UHgD0kJiXpLe/wWxxePTtWXBSBGcJEPia0f+YgIMACi1c9dhdqcwSLuMtO/46GVlI9f3FYlnH7P2ihHeSRNUPWUXT7EzhFCDjDZxi+u1MTMwH4Wccf/VbPEWVpvHa1PYhpVMtauKvpdjpix+nPumt+GP4wd3xaQdPUvwjHhK7iqJq11t7FPyaNd4arJO9f2zE8hn4fm1VT9xUPu7ohPwa9E//8SabLfDDpMSdGpufJZxN2M1Blh0gcEKeeWx2on5W5FkgisTeTkNvTEqGB0+G2ncH/b1jzq022NW2r56pueRFKG6oGYwqCctUPyrQJ7JlfmL4NBMkYEQZJ97DcTtpuM8454hX8PzDueaGv6A9dwAR8nEoQBwVEJAUgKdUl5nlcF2nfiY5Wu01RdBEUMkeQLgzKPqPLRMdW9tE07cm1TU57fx/EpLwZMFnjgeCrljkuxdcL4WbOe3Fkh5qifTE7zI95MK0hNuwOjdvW0zLBBeh3KdvgncRFtJB60lxw2P9lAIt7JYHZPopHUBCbiHvuY6Jvhc7gkkLf8k0cvgUec0ve7bqkONdDrT7YeBWaPI/i7s3CLKWRD1T9OjBkMjwJ0/YbnUIphvs3cCh9DzVJr1L57ZSgtdHUOT4WMD1fgeZlrCocw4qo+uJJ3JURHKmSnPN3XGLPwdOE7wGn2N2FifmuoGOS2lhRlB79R5f4HZoFdhEkYCfG5FICLsbEfwxmHtub+4BVDRpKkjPJaXKGI8iePQpP8za7vKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(356005)(16526019)(47076005)(426003)(86362001)(336012)(186003)(36860700001)(1076003)(40480700001)(8936002)(4744005)(36756003)(5660300002)(2906002)(70586007)(70206006)(8676002)(7696005)(40460700003)(41300700001)(6666004)(82310400005)(81166007)(54906003)(82740400003)(2616005)(478600001)(26005)(316002)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:49:17.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd08a371-36ac-4cdb-f291-08da59500d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
Reply-To: 20220628214315.235160-1-jinhuieric.huang@amd.com
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new option for always keeping gpu mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Change-Id: Iebee35e6de4d52fa29f82dd19f6bbf5640249492
---
 include/linux/kfd_ioctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index 8a0ed49..5c45f58 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -1069,6 +1069,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

