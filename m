Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7E4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 18:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508B690870;
	Mon, 11 Jul 2022 18:42:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE68F9086E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 18:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuRqmJKNifjDMHfTGq/4gwjC44EN3aeBILsYrI4SEfXyCrrnWORPHsy2a4x9wg2s5xZtGUFA1CWLNRpvNvPe84BMr/0pX7v6nrRyLa4o3N2sghra6HVCiOPGOn1zNPg7RwB2/LR8Wkj2VbzwMobwRBs9D05L/zFqQOgDHVPEKvVZcY1+Zp4BTBqPzhzghB/vEmeoAa/NznokBXfPrBuBCZVFZmBmFds/34ez42A0jxqSDl4/aZs+/hTPur/3o2/jFno/Ue6R41f/3MgXTVCkz+jL8zmkEM1AcFm3Q+99806/5EKDc8RkbpgmPtKyvs1giYhh3xgcFfh8TGUm6qT3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QUaE3Ou+a2+CykMqRBqtAS63REFL+U3fbk8j7ZnSXI=;
 b=muB5cl1Llu7HBAIfBpaBj3Rnsfx8viobY/Wo+zcAc7QZigLWAq0ATkHIFIXywO6Fg5SaWksFwV5Yocp1VQWHnuBQKBnoDybdS41MLQZd8i3s4tu3CbbMcZPxiWXSyjpoe4eSYgWiLpQU2IW3I/1p6cSzuNPJ14hhjDrcp4yioMRTlxitjhvAHOm2JJvFEXBUXtvJ7fb6F2iVQBRM9syXQu1BCYtJStypmqSnTeD9bSNzfP7jL5xr04E7H0AfRdujiEJGVeWXzPOBuI0bmMHh70qEj1CQViM9zGBOdoALGZDqjmSxZ2jA5nYLMiXpeVODA5QxeKtIDr8m6DYsY6n1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QUaE3Ou+a2+CykMqRBqtAS63REFL+U3fbk8j7ZnSXI=;
 b=z5N9pCTUHd4dgTM5JGJijM81hvdGa9GelYC6TQq8EfgPXmFBQ3BRkv2+tqRLU82QZ7b4+IeC1WXQLVKN4LZZTM+RDcz0XivWbyebaK4Jsc7xoGU13EVPbQ+ocmMwBlFdN6IZKY8QQIViP7TZ9uNYuQFGZ3iBuLiNEA9+1o5VWXU=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 18:42:23 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e5) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Mon, 11 Jul 2022 18:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 18:42:23 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 11 Jul 2022 13:42:22 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] libhsakmt: add new flag for svm
Date: Mon, 11 Jul 2022 14:41:52 -0400
Message-ID: <20220711184153.135021-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711184153.135021-1-jinhuieric.huang@amd.com>
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea74a172-8d26-4369-4b46-08da636d184d
X-MS-TrafficTypeDiagnostic: PH7PR12MB5735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGHD3lI1HU5YPIqzwP+YPOKTsOUNnZ956EdR0IInSPf5k7Q08QJoPmf92Lq1CPZqvv1XPwMkB5jo6psO70w0NK0dzV58wprTa6BYLaef07kwShx22sBkcau9zX5ZKl+5lMCpqcKmBrgWLyIGQLoNgqzitUpLNOCeIzSRFmd9JTl/Td1KJCo0Yvei8qdIJd17tiPj4RShSzFOUcjbcqznFeCHk8omv9fLYTXhPyN4QWiDhbBDOIL8/D0zeikkutAw18UvuMa+4aT0BRisgMlLU/vSQXvEHxkzjGSOIOT5yVfGVm58QuxoQd9X71ZI1OH2v5Ogjv6QDCt27JQARo15c+Nk5PIabjcBgUMnm7ND75TKw9gz+q55yuacHf2kaw8uamaG9rTBwzoUdfRfcQvW8zVvWvmc4OgtIH4iHSlsKclIeeK4KPFgkmlaKoncuqayLXnLwV0XT0TEUhcKq+lTfEd3RWg5QYBDIKjQ/RUJPBZCKzjwHnUWpRzB+auOoXTzECdkQrfTxqx25x93JwrO39ylrEcsj4/26wUP/Pc4wM9IKis9bqpKrGqNg6V9kIUmzggq1qPIGWw4hdxe47Q9ywHF7S31Yc6GhBPKy0Nz4XktZInJKODZFrglDYgy1NyOkDEbYGAawNYBxxfWgEpvyH73b55I33FtDqnwZZAPaTmgJ17X9Tc//kkIZHsLY6AQ5Ftx8W72BvJ1XMAWAKAyCA2JMqGfaNn/n4Xmurn6KIyto+UfcbhTUZIlqeFotokt09NyykUhbfH1OF/kFC/ZhLBilvlapikBcIxH+td238OYrPpQwjzCenJoN6zyLUQziyFVIMXg3LGryDeH1pZPzz7z/iyMj37vpaEAmjx3JOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(8676002)(4326008)(86362001)(5660300002)(70206006)(356005)(70586007)(478600001)(26005)(8936002)(1076003)(41300700001)(6666004)(2616005)(6916009)(54906003)(7696005)(316002)(81166007)(82740400003)(336012)(40460700003)(2906002)(426003)(40480700001)(83380400001)(36756003)(186003)(36860700001)(16526019)(47076005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:42:23.5556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea74a172-8d26-4369-4b46-08da636d184d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new option for always keeping gpu mapping
and bump KFD version for the feature of unified save
restore memory.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Change-Id: Iebee35e6de4d52fa29f82dd19f6bbf5640249492
---
 include/linux/kfd_ioctl.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index ba8de4b..4898451 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -35,9 +35,11 @@
  * - 1.7 - Checkpoint Restore (CRIU) API
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
  * - 1.9 - Add available_memory ioctl
+ * - 1.10 - Add SMI profiler event log
+ * - 1.11 - Add unified memory for ctx save/restore area
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 9
+#define KFD_IOCTL_MINOR_VERSION 11
 
 /*
  * Debug revision change log
@@ -1080,6 +1082,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

