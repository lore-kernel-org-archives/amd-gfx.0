Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A4C4167D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6E810E9C0;
	Fri,  3 Nov 2023 13:12:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F95910E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKx0kx+xjtUTtN8Awy7OitaOSSjrdWDyz9zar9uZIlkH5wHE5kP+k/q/NYEeJAOpY87FdkusrLuQmcpKl0peEGc3PwYMOytZLVAMqejzp3BoN12D2Waaa4xecEgRXmBgNgibS1ZTORvP4PqA1h48yVHspVO5A79QR6P06fT0VHsYm/SBcrANK46Es7vMUmj8Qu8cpj+LWXifR2YlE4Lwl915Sp1F+yg/XQhLRbV1EWjD5wNrhHazOC+rc3YJPHPiYpu7uPVgyZZs/hSQB5O2XCpcj+R1rfplQookMFWhgM0ZZXPA1YaRIQGc6Lk+tscMNvHVXXNTfSJRzs7hIhNlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrWmzMo3AL+nQsV/raVwc2bULAb5jFskF+9mXPbFVpo=;
 b=EqpPQINY9qHGIYVDUoXPgK7Tgc+uyjfzoru9aE3S2/uN2CDT64M6EjIXpE/7A+fpty7yCMXnG0YcYlqV6fuxeErvMW1CEEbW3BR8YmfSSKFYh8UkZYrZnRrwabpwa55DtbaFJrTNmVfjS49b8/DYt/sGx5ZSbpM3Yq+6Yi9YbDoUjc4yzSJVeRT4kByUoqd5XR67/hosstQl3WWtMSoUbZErplFcCAgaQoJKqGZ6iI+HAQYeAwwKAqb7Iog0Gbx3ybxvq8memDobdmuv7EFWpzbIRt/jSGjU/je1IEd50L/6AZSfunIR9vy0iV1QloffxioGwzbysg+9KjocMeVqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrWmzMo3AL+nQsV/raVwc2bULAb5jFskF+9mXPbFVpo=;
 b=KDG5KGuNj4ADB+3bpJYvGDjkhpjWCu13s5HIlxiSQDA2a8HIzE4ObdV2SEFDgxgd2R14akRNMj19Cbqw/gLZeyZwwT8KSb6YfqIvv0j4CY+feAdfUg7jyX6m8Hc33+uDx8wW73PS0bpV8AlD+3ufU8fugZc5Ktos2x1c41V3QEo=
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:11:59 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:11:59 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:57 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
Date: Fri, 3 Nov 2023 09:11:16 -0400
Message-ID: <20231103131139.766920-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: d5df2266-bd1a-4cd0-2ad9-08dbdc6e7673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyNDaiG1yq+MqPyXAtfICyMZPTI5OL9QmfutbZcFG6itgCdGj+IApp4SzgEQEfTUl2mAUXGUdOmKX1DlwSBR2OZ0UwSeZEk9IrGNWInwebsdckMEAWOTYIfYYojq/AQ2eLc0BMsXrS3EKMrGCs1P/nJP/w9R7piM2u8jWQRrY8cxdjm/poWNNuzHH5DbqyCLniA37HsvT0FrQ2JH9NUgpuD443Oz+O4WpeC0AbJePzH6pSGTghZ7hHi/UaWb3q3oUhCpOOcbkzRpUMNrK2zUyihrn6whRNm3tV2O3cZkWkqk5kInCWAVM0/KMGN1+k5WDQoTzVKOlY92+FmTpujYR9VB4nHSOVLbmUHNWyC/hHR36mC+QnaPeWfH4A5UzzBdsyxFX5ZuAsSMt6XuYGGOYkZ6hsy8XpLoLKY9R7nlZ01GIwxSttQ1cQUsaW7GHMQk6Bw0iefOB7j28m8dba4lXAZf7ToDOrt6nwSyvpX4/TV7BG2sOzar16PQ/QMzR/OugWXR+VC4kGziFzB41/Fu3tN+2Zsgj3rWns/5VWLjioHmVXtqq2+3HWY8FC/x4+5WqqJpiVC5nsRkHE6QbUsGCPiF7iZIvfEzBXkf5dP8U4tRXpt+/w6h7jMScFoNNOP/+PvrJKPmixkrY6wVmz4VK2UFot3fvEcPH2ph3FIQCkbsZiqeKJnOQjEvSImgToqw9xnziL1jS8UlutdxT/tIpWSkqVWTVY2Ngx5zwCb6NgmZk3V+rxV1KNHbKf4xYS+NKbqfSFuBG77vRfcZ5SllJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(4326008)(8936002)(8676002)(41300700001)(40480700001)(40460700003)(36756003)(2906002)(5660300002)(26005)(2616005)(1076003)(336012)(426003)(83380400001)(16526019)(47076005)(6666004)(7696005)(36860700001)(81166007)(356005)(82740400003)(86362001)(6916009)(478600001)(70586007)(54906003)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:11:59.2641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5df2266-bd1a-4cd0-2ad9-08dbdc6e7673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..5202e29c9560 100644
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
+	__u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample interval in us
+	                      * if PCS_TYPE_CLOCK_CYCLES: sample interval in graphics core clk cycles
+	                      * if PCS_TYPE_INSTRUCTIONS: sample interval in instructions issued by
+	                      * graphics compute units
+	                      */
+	__u64 value_min;     /* [OUT] */
+	__u64 value_max;     /* [OUT] */
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

