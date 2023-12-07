Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDCFC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7514A10E12F;
	Thu,  7 Dec 2023 22:54:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD8910E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMuAouC67RNI57ZLMunO4zTamWuUiJIyDxXngQslL0UYqbqIYTE8c8rG3g8lgWvzodqe3B1QfpNtfkCv0o66KtSfqJiJsEtVTk+Vqq5Bpu6aS9NtEq5czRFk1DXuPP7uQ/eqfubhwvC7V2qkZS3TIjxDiYqX0C7pcYkxPaj9SZiRfUrW8APTv8cFutHPXDppQEbw7+W1rpxLd/FE8JFQEwnTQS+vYmAFupnKVNgKE+8/pJr8FVjAcLJhbhETLPLXjdUXivjTpXbk/GNxt9Qq/X5ZiJ3JYVPrnBp8cgFTm+SluDayeBTRUmWLmvBa1o4YP09bnJU/qHDw+PTUXPbHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Zz/0cs5gKbD5I7Z0RWDl9kftwRhKmJ6jl+mrEeaGw=;
 b=nkvWHCrFtqe0SYAdKe90WE1KFi38iQVYjzSqJFrboIVOUp1wwl99KwejnaVBnB7Lo8/rnOAQviU14FjIZ1z6UIihXINfTI1TfQCXTdLJciiV4Mb38bWYgDUMDFAtFHTuXVT6FqsjfO7QSXmLvZIC0J+/l+kAPXsVPTkgcLZ6l9VN8H3T0Yv9bwtcjLo79kE+O2Je2vTrDM9m4Tidv3/9qH+oNWDLIgWFv3JTFsOKtvxUKFKNRcksQDWy8dlJfgCdKmnFPeoM+Po8o1Nx8Hdh6PbpWRxB4s5gUTJjrW8jYEomAXDVRR6VVn4FUTr/a+xBb0nD2oNXh46lnnOtE6Fczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Zz/0cs5gKbD5I7Z0RWDl9kftwRhKmJ6jl+mrEeaGw=;
 b=cZCoi9w759mOAFZUXAoE9V6f+W+9pyrY2uZU0I3lWxLk7EMMl7f4nEU4SXOSexGvfnwuw5+u6RyWnand3lZnVRUm4s1OAGkXQqhLIJ+laNXoK/kFqIdW+u7Gncy01SKl531ZBZKl/NxlIuEM9fXCj9XD8FvsnP4H5sRSHnAYK+I=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:36 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::ff) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:35 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:34 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/23] drm/amdkfd/kfd_ioctl: add pc sampling support
Date: Thu, 7 Dec 2023 17:54:00 -0500
Message-ID: <20231207225422.4057292-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: fae4a2ad-798b-4bdf-1c72-08dbf7777c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76hCsu3bJTkwVDCYtdtYNKCcTQR4ULTSKl2kco7pjwwf5F/ajQSP6yCdffUbyL+kBSg78ZiQo3Qx1bPiA/Cfp1iNNDAarq90g7OgyN/nSmbhD/fHvEjytS5fakA4dOg3K7uwcJpJ1X/CVwLMlbE3b4x4XgYLqZ8pTZwFHPoQxYUVQHBl7olQKgd+fPLTluhQ2kBMDNDNg0+2f2ZOzhVHiWZmzRGv3wby6cIf6ltjq9vRmu5cXyxvCnOoUVTnMgcKNA8wAuKsWdMtYSelzGBwVi+nnRGziGUiZ7wTP/DZSIEBVkdc32HnkNwdf/h5NEWov2K2ybgXeQr0FwWYfHhXeC4V9jdU6kwBWcpYpwnEWcX2dUVZQjEWyaDf/pz5k0d/J6fOXJ/8TgrRY9B7nBH74D9qUlPMWXGEBT5hVjZFwiSrtfoknmLBI05dZKyT0gyRsVxWiyXST1DlpnoM9Ppehy1e+w3WYakecLrXc/KvxUijSFi/D2rjHrfpZ0xmqkHH4RlXdG0Bor9gkOKoZpru0Dd8Zmu+suN6cIc0JJLbjpYSSJ7KjxGojSPMBOJ+xsFR+dOWNSOdRVGxehLU8du+Zisz/0kMdCryXveVrEXyiVb3o/r15ZrAHqOaUjPfvLOPSyPXj6RulQhuevD8Q+8UdiK9l+7sxTOH1bXe28kShzKGwwC28/9aVTVWIJ7WY4zBM5tlmHtPysdBd5cskvSGEpxqvFT8NhAh7fsHqxuELd5zdq1JbUmDuWuQy9eeQl+OlDqBwCo4HNR25pt4mVkBbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(40480700001)(4326008)(8936002)(8676002)(316002)(70586007)(54906003)(70206006)(6916009)(40460700003)(47076005)(36860700001)(478600001)(1076003)(2616005)(966005)(36756003)(7696005)(41300700001)(26005)(6666004)(336012)(16526019)(82740400003)(83380400001)(426003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:35.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae4a2ad-798b-4bdf-1c72-08dbf7777c04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Add pc sampling support in kfd_ioctl.

The user mode code which uses this new kfd_ioctl is linked to
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface
with master branch.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..1bd1347effea 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
+/**
+ * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
+ *
+ * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling capabilities
+ * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with a per-device PC sampler instance
+ * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a previously registered PC sampler instance
+ * @KFD_IOCTL_PCS_OP_START:              Process begins taking samples from a previously registered PC sampler instance
+ * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking samples from a previously registered PC sampler instance
+ */
+enum kfd_ioctl_pc_sample_op {
+	KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
+	KFD_IOCTL_PCS_OP_CREATE,
+	KFD_IOCTL_PCS_OP_DESTROY,
+	KFD_IOCTL_PCS_OP_START,
+	KFD_IOCTL_PCS_OP_STOP,
+};
+
+/* Values have to be a power of 2*/
+#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
+
+enum kfd_ioctl_pc_sample_method {
+	KFD_IOCTL_PCS_METHOD_HOSTTRAP = 1,
+	KFD_IOCTL_PCS_METHOD_STOCHASTIC,
+};
+
+enum kfd_ioctl_pc_sample_type {
+	KFD_IOCTL_PCS_TYPE_TIME_US,
+	KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
+	KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
+};
+
+struct kfd_pc_sample_info {
+	__u64 interval;      /* [IN] if PCS_TYPE_INTERVAL_US: sample interval in us
+	                      * if PCS_TYPE_CLOCK_CYCLES: sample interval in graphics core clk cycles
+	                      * if PCS_TYPE_INSTRUCTIONS: sample interval in instructions issued by
+	                      * graphics compute units
+	                      */
+	__u64 interval_min;  /* [OUT] */
+	__u64 interval_max;  /* [OUT] */
+	__u64 flags;         /* [OUT] indicate potential restrictions e.g FLAG_POWER_OF_2 */
+	__u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
+	__u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
+};
+
+struct kfd_ioctl_pc_sample_args {
+	__u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
+	__u32 num_sample_info;
+	__u32 op;                /* kfd_ioctl_pc_sample_op */
+	__u32 gpu_id;
+	__u32 trace_id;
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
 #define AMDKFD_IOC_DBG_TRAP			\
 		AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
 
+#define AMDKFD_IOC_PC_SAMPLE		\
+		AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x27
+#define AMDKFD_COMMAND_END		0x28
 
 #endif
-- 
2.25.1

