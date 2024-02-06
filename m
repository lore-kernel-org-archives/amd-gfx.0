Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC8C4829B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A6C10F8C8;
	Tue,  6 Feb 2024 15:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2iQAHmgl";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB23010F671
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu+Ij0+HAN8pLGSaiBsina0IrDvrebiHIT4BqQfr9hdCYhe1vc8jEyhFQxWarX8y1gg5VV7jCRHIcyaB1Nzoheg6fVsv7PpH33H/vYhB2OTzhN7onDdp3FlYcpt+3mUGQo8Gog7WfJ7BL2+oKvmtB8R9qRX81zWWA1zp2Ta6QLCOHM5L+IbuXr3FGeqO6ZyPU83o3bRzYtP2pd1rBjmu8RRUoboojLFFgcvUPFV9uEoloMhTunBD348REc3YuIhCqMcsVXKck4LueZUKdDBGnZhYOffc/wMNfU4FX2RoVt1vYC6EMnyiLvAHhPFwYA5TM9mdC/EnJwicFxqzsICxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8TsCIg8ngLduVL9abIpXE6zbonTiiZh12oKdL9PhN0=;
 b=TiPaYFEe8GpRiDQ9dRgcbtrfSccL27Ef2PBVDxFOL7lpkJJ3CWpxePMgN+agOfPG9Sbv6HkcoRHIwfQcuh9U+lX9RFe7jGkeCusS/IwRQxjaCR4jA2p30B8MkUMmksooxh5s3qlMIHf6FkNjUVOg5Ag/oXDVB8qcmVK0XQoj4qH57Amreks93WBYiJU5mu0Z9yRawp74bPE/XfpkitAps41cUrWhC4IQJpLVknimbtkFzPWGyqSG2CZCM2Pje15PTouQ49cAvdYVTqu7fxb/e1LgVO+VZDIQYly986pH3n8yEM8SHJkA4wOavqZgWQSD7EOKnr8/aKbCqC47kJHJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8TsCIg8ngLduVL9abIpXE6zbonTiiZh12oKdL9PhN0=;
 b=2iQAHmgl64hKqieqxQpTbCIKycHSTxu29UIUzqqkClPQPQQu/32atUPkANhw3Gnwj3F5/pwS2iVdJHY4EbDCeNbpAp8YAwFzo4ttMD9sZdPHeQTBE7saOvGHVR2aLLuDaPZSEvZL/4UN36DN6R2Sv5y6GmrFitjxmMNuBNxVwjs=
Received: from SJ0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:a03:39f::15)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 15:59:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::44) by SJ0PR03CA0220.outlook.office365.com
 (2603:10b6:a03:39f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:33 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:32 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
Date: Tue, 6 Feb 2024 10:58:57 -0500
Message-ID: <20240206155920.3171418-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f30c28-3d6d-43f0-15d0-08dc272c9c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHZvp0ZWUA18UTn67YHGMFmk5gqP7AWV0UNHMQwjl7ZuyAD8QtIf4qE8dejqAYdlJMXyb+UVb8DsvX33Oic8OBoMmrxBH4GlQIR5cu06A7jxeMXmhg8PILsQukijlWzSw0mUvRosB+b/31Php6khvgORsjybYcONqJ1oYKJoRAcQJ5maT+5G+LhJBRSQnmRgdO0Y7Yz0ihTfUUpKHXbpFiNUcUv2prGT1uWZwHRKF5VfUNpyAn2d7dYzcJbFOup1HCcwmO2UgRig0ud1fAjyeaU0SIOA45R1HZCgF+a2pxgPEMVhtSiArRP4QT3fZQjS4E/LJhwmKSe5obY1rVnDnooEEc9QfdZOEzagNPzOLRR1HZZYWTScFYE/KQ139e0DzhzTL5OBzEJQE1Gh4dkq9IIl3R2h0oq9Fu7ZhOV/HHMHrpVJAsAQ0cP45CJxQDfmXdP0HxSWuRoB8qjYw6J0AIiIJ+BFAMvAoA4K917kDWB0QGajNYZVblnRI5bcQgIa6o9+iNJ3AvCXYusDDlp4XCAh2Nz6dvgqu/Val8Wma0S18cKnERaFLmH7yzXXC6j+uKGGBRStdIeN0XfY/TWstiYER9xUtWvufZbLunFGwS8rkuoAUre5gcgXbmU4F0O/wW7lr3+Otv1U35twb3oNAGl9NGgexGJ7BxUWE0dGvvXf4kIPkh1dNdujV8zQCUCOG/kc7VRY4F400Z+le55aqpha21pUc3jtv/UcubCHYr82pq+gPHv53wq9OmuhRV0EOGnx1GYKotS9mOZOWGhS9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(26005)(16526019)(83380400001)(2906002)(2616005)(356005)(47076005)(1076003)(82740400003)(6666004)(4326008)(8676002)(316002)(8936002)(7696005)(36860700001)(5660300002)(70206006)(426003)(54906003)(6916009)(70586007)(478600001)(81166007)(86362001)(966005)(336012)(41300700001)(40460700003)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:33.8168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f30c28-3d6d-43f0-15d0-08dc272c9c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

From: David Yat Sin <david.yatsin@amd.com>

Add pc sampling support in kfd_ioctl.

The user mode code which uses this new kfd_ioctl is linked to
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface
with master branch.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 61 +++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 9ce46edc62a5..ec1b6404b185 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1447,6 +1447,62 @@ struct kfd_ioctl_dbg_trap_args {
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
+#define KFD_IOCTL_PCS_QUERY_TYPE_FULL (1 << 0) /* If not set, return current */
+
+struct kfd_ioctl_pc_sample_args {
+	__u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
+	__u32 num_sample_info;
+	__u32 op;                /* kfd_ioctl_pc_sample_op */
+	__u32 gpu_id;
+	__u32 trace_id;
+	__u32 flags;             /* kfd_ioctl_pcs_query flags */
+	__u32 reserved;
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -1567,7 +1623,10 @@ struct kfd_ioctl_dbg_trap_args {
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

