Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E86C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4556310E6D0;
	Mon, 26 Sep 2022 15:03:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A2D10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJVYRfv8wzsa8SXgMRWdXOQIQp+fKW8vw/vdgeWgZWIOiUHGubn7g9P+xyorb5j3BYe4ng4BxmJc3EdDBg67xliPGvZ8x8NNK2QGe6Ni2bEhFhxWG300pRKTJafynV7cfU/OCAP8qpppCc/ws9+cVw+yf5qhdjLz6Q3fJvKEtF6AkbW7/oVkqPJlj4W3q9hNdfv/GIvA1c65uiBR10klFXiA+K1G9z9+Lkazpa2A5mAESX/xWT5PhKGH3yqlg0WCqG+/SUIk4ZjdzrBgI382v/35NtPHYgFGui3dvdHRjFO+vZKsCCtHRAmgOrwiVaQlMaHeDoVcuM2lujqLju2cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlSPpEFmjJ1365jhaTzI5rmUOr9Wog6rMG+P6PZCk4M=;
 b=fKQ9itU4xQTit+Lq6HRtZ16Kn2NV/TpIWkoNxrDioGPYo6McpFE5hKJiXS1W+dXbGk2FmXr6JiDTqGqgb0IFr4081RxpQryTMth17PzKfB/Q85HkbHbG4X92iZPGn44pDbeVC/UVqyucT3LDz8qp9+EGaluTXP5v+OqAy93cYn1mNOWoo1g/62g4ZC3nUZGmzCILn2MW58ohjQDfVLOD/T6BJAPYW7PbaAub4Lp9pNtNxX/dCl0EO8MPdgJD2yGJ2zp4+/LHXdHzKkqnSLW/wZakEQ+C30J5umdlc67StMOH32ofe7AAXVrddD7ybiPN6uUruUcLpLyc3LZL1oLJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlSPpEFmjJ1365jhaTzI5rmUOr9Wog6rMG+P6PZCk4M=;
 b=oAXRGwYzv9skBKs7EgBz1dQFZuHaDZk9Gg2kDMKb6fyiDi3VJHFzVQUD31eGTjNiWox6Ix2qBInQAWUQBsI0QCalK+bbSVLZpxm6j4cyhCvKwZwVIlAnIpTG2/ykTl+7EfeKftgAwnpeerSbr3Gy/3JTtXsUymDW/B5EzJdVmNY=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 15:03:11 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::c4) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:10 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:08 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/5] drm/amdgpu: add UAPI for workload hints to ctx ioctl
Date: Mon, 26 Sep 2022 17:02:48 +0200
Message-ID: <20220926150252.18635-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926150252.18635-1-shashank.sharma@amd.com>
References: <20220926150252.18635-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 48826d92-ac5b-4571-f1f6-08da9fd03a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPThqCizwQANKucvCw682BBZzUULKS3J037ZWzRdBs1lHJ2S9yNDa2EyP5Dt0kPKUZrDtnxm3E2dXxYpbRvSZRJyrrlMSO3ffrOy3Q2IT8fX93J3JAFLbCi8ghdRRxmBV3AEcIqkQ/+ZDD/YUibBVC79mZ04S6JRWxQnf7LwVG/EQ7hO8ro025Is0Dx+qVleqntjjSpTc0rN8pwcIo8FcDLglM3+C1LRbLdrT6tnqvQR1LU820Sq2a13zHSOXlKJazuFAgiyaZ3E9MtK0TFDpKOQpHzZXLcXo+WwipLs630Tk+RFFr571v4c6HnnW5ypyXO18Lc8gRGNfJHX62SULW2b0ksd7FriJFkbQHw/U2JHYLmkUeqZNXGyYo0eH1OEZuH2uXf0DvDppP4ea7jsWXRX3VEBFehtuS3is2RBnNe8M+njHRwldLMhf7qERR0S6IMy0S61JFPifUAMRx9Bl+OzmA7D4UhPHK7/Exce972GJp+fbdyHlbmzFqIaLFhDv/YKIQXEkfy1PJaW7lVWeXbQKB28Wc5i4StzRiBfKVfmZgva2cqX53XCxIoYylVUN33Hq5vtj/O2Of3AVMYFWsbCbGx5clUJMjkZYLsaqwgWXs/UAV08pDibtzgeInn0vID9PTmEk0XqjWcKUiABbV3ojlJwMlO53wYl0EwpnNr0mnQNoIi+y7oSbQQUVzSIgm/5ue8QakNdEkyCN1vLPc4WBVMBJAQOINZoIniTFcWIl7uO9UXTYF+yZpjNBdsY7SQLBcLvw506AP/LZQeBLoy5F7+/McxRRDRsvjS9gmobKsaL7BKDmK9hhJUlIuub
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(5660300002)(8936002)(40460700003)(478600001)(26005)(40480700001)(7696005)(54906003)(6916009)(41300700001)(6666004)(316002)(70206006)(4326008)(16526019)(1076003)(36756003)(82310400005)(336012)(186003)(426003)(70586007)(2616005)(47076005)(8676002)(44832011)(86362001)(82740400003)(81166007)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:10.7318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48826d92-ac5b-4571-f1f6-08da9fd03a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the user to specify a workload hint to the kernel.
We can use these to tweak the dpm heuristics to better match
the workload for improved performance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..da5019a6e233 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -212,6 +212,8 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE	7
+#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	8
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
@@ -252,6 +254,17 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
 #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
 
+/* GPU workload hints, flag bits 8-15 */
+#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
+#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+#define AMDGPU_CTX_WORKLOAD_HINT_MAX	   AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
+#define AMDGPU_CTX_WORKLOAD_INDEX(n)	   (n >> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
+
 struct drm_amdgpu_ctx_in {
 	/** AMDGPU_CTX_OP_* */
 	__u32	op;
@@ -281,6 +294,11 @@ union drm_amdgpu_ctx_out {
 			__u32	flags;
 			__u32	_pad;
 		} pstate;
+
+		struct {
+			__u32	flags;
+			__u32	_pad;
+		} workload;
 };
 
 union drm_amdgpu_ctx {
-- 
2.34.1

