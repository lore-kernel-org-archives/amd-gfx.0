Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B12010EA5B;
	Fri, 15 Dec 2023 16:00:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BD710EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu/L7ScMzfAOzDcREf9OJMZbFdmzsvWnwW8VpvyZ8HD6c/X2so8BMy1D8A+R6cjAHsMRH/tY4EfH6o9hNUpEhd/glcQFVE1jjUdHysMSYWGvRE6h7Pbel8me62oFhaBLPkMcddXM/TKnLrGDaKL6KfkKRw8DikualJgajrLJc6S3c1/gftocg2nEfO8kBbpapFKVlSQ3pvtpfxPUXRLbAL26nxMv6rrRuJuHEl1vlMZRUBwitxbWIdxRaHT4GsxSxJVMsmFQsa5zfQpHQJcZNV588pwcxXBR9movJgANjL5Qi5Q7GPzlMJ3Sgvji4MSTQFEfMGAWrh+MrCT6H8wo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Zz/0cs5gKbD5I7Z0RWDl9kftwRhKmJ6jl+mrEeaGw=;
 b=EuJ7kZ68CWJXn15aX8ntS2MKTdMXBOUgRN5HtjC7dgspFl0V3QiVtqr8aXSzzCdPSnePu4gVCyPl0cCMUFpYeHmfJGsurx5ClocFPZT97MVFHz0I1p4iYYivxOjm0e5wasFRab53ZWFmUpYigbdQu7jd/EAlVTL0pwmVpPgfF5CnXuv3DgLbP68UwMF35T3K5pAN/IPmbRelTm1jOWZxZ9ENumepgl319KKtKEefy33mH1iEmAPqhg2HATwJ/suHjH7WQr/KJrFeo6MSRqUtPO72PXQi1dp73niQdbCkD/FY7sPnhtzNzibWt+kPHa3/3n1lbltjH+L82RUA8Y9GAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8Zz/0cs5gKbD5I7Z0RWDl9kftwRhKmJ6jl+mrEeaGw=;
 b=UqRC7fFQtAY0lVR6gqE+B0FEPphq9EwFn+VU9+wi9dDKteGd4k7Qj8Pgzs1HuiugVmcEsHW4jNAbW+lYSx0r7+YSDEtxJjEMhLH6XR/+Vq3OAMJlKXSM9iWPxp/BzzQZFC6rWbRlRmJG2CTAH7fUOMHKpHaXj/tzpWqSbBXHzjo=
Received: from SN1PR12CA0112.namprd12.prod.outlook.com (2603:10b6:802:21::47)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::e2) by SN1PR12CA0112.outlook.office365.com
 (2603:10b6:802:21::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:40 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:34 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
Date: Fri, 15 Dec 2023 10:59:28 -0500
Message-ID: <20231215155951.811884-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b224403-99a1-4549-26ac-08dbfd86fca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPyN/PYdT099xir3UNVtPdg6VCBhdu5sNkR+UH8s+b64YfgColU5b9MGxuEScQkkCDbHe9bBzVQc3+1NGwxqXltNha78v0ECYdx/PUXbdZKivVAFGgD+lDMKZQuZyN949dHfhXWDl9tmq51OFiCW7FXPqMHCXZXy5Bw3yja1PMGIXE9/4IJmTExhPNzxYpg1j7VIa1lkN/DR575ps1qgBXfzIEf6u/13LDpl+QssR814FW2fXKTFnXuwIyIWoiXI+C9XAG+yrcOJ+yyVLLEkdcmH423Ju22bIsN+wGRk47XN2x0/UOsqxouQdjlFNhQzPNN0pkMsfdZpUSGvUrus7fGKB5s5mji3/7gsC6PsGKtTsu8Vs8HBRiBPhY7FoaRpmbhBeg8jguXWcycH5NcsoOAS8Yi2rQJGJRKOlH42JahhdHMgoWpg3a4Q+nMVzTE0kQWQ8qUBqzkYcf+HGst1Q7o7IwMdoSOiI6fbZArd1iuIzrJzWizck/2TeMUbJZBKiklnbdPpeb+K//XDWJOb0MkSCTf3GiCb60PK/di5wXvMuUB2gdmzzhqXt328itRIGHW2ywt228DOMNNQiWbhBJh7BlNrwnI2jgoAktq6gviyeme52VTC7Syn0LI496bp9Xa7Ck+m1T9PmD3nSyIaRbkP1vpUV+nc8bLBN2RZhI2Lw95ClU4TCnZMPyWCcKRC/EGhyjLxASUZEes1DC79Giq2DNUxgBIGvLQ9IKWKGgth2y0KS75CdMeDWNv6RttuYwN4rKN6aihI5FjTMGhTnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(356005)(36860700001)(70206006)(54906003)(41300700001)(8676002)(6666004)(40480700001)(426003)(83380400001)(2906002)(336012)(8936002)(6916009)(4326008)(40460700003)(5660300002)(70586007)(81166007)(316002)(86362001)(966005)(16526019)(7696005)(478600001)(1076003)(2616005)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:40.8624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b224403-99a1-4549-26ac-08dbfd86fca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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

