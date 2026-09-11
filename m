Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A4DC79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525EF10F56C;
	Fri, 11 Sep 2026 08:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zhdkcyXC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9B310F56C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 08:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwXFsSp7oPon+KfMn5oXGAWzY5scOIGc2+RL2pfxRmL2GYYHFI7fr0+ejO7Z6RsU6QcljQ1prLswG3lTc4S71KQXrYbqHwHh8G1hpxrG4quEmXS2lOgiXuHyDwkiYan98arIwWPZ8QtTbopgjLvOkqnwsJ1lpcdyXWXB/ZmaW0O0CL0DFNfeu68x3Z7W1A2GM/j/ZeSPK/WLWNgr+4yN+4boS2KeJFn4gRbG7Q2MsOgD9eNgfRONyxYUVyKOVtCITijsQGimEcdoN7f59D+Ifh1TdjK2dqzBx83lrn9ADq3kNPzwqaW8wOMRYL3+8KWSh0cSujg4jsMiNAFw84PGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=U/vd9Z3wbz0hG7ZNFnbl0rbmVVY+anrvTott7B79Ys/o3s+R+EQgHukuuiJt+DIRl1uduJ/WVJSRrpn6tNPT/YXXhI40S/+/vVViWWlPbUp7czLEUfef6KSYurvAlaETQqu4eQwcRNw8mmAnhtdpMrNAgTGLQC1UA8MsVKlOQh5iAb1nh6/YIcjhoGtcidh5rlQsgM+DlTmoLMVR8oz/z6tWdli9easbR6Z+XUUmgmKn87auMfMHYpnxUmUY5iHxXZ6u/n0ke1jZX2cBy9zsygY6ytoJZoYOE3zJDBbimYbqO2jsw/AR8RnMgZ0c3c/kMYvb76f98q//ZrFLTEH5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=zhdkcyXC7QdwIGzEwr/XyLJBGKv5UsZO67Okq6erVu+/yzNaTuVFuA3/plQa8NaErw3S5J4lbUrtP3W2652tH/g2+lgolqGmgSivfI3OTrJsW4oE9lcEZ2FT/woPSRj42k/COqzewmJJZ/WoWpJJcpvBW47D+tLfUZ3pXdNAClc=
Received: from SJ2P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::12)
 by SJ5PPF09E5F035B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::988) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:22:45 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::31) by SJ2P220CA0001.outlook.office365.com
 (2603:10b6:a03:5da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 08:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:22:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:22:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 11 Sep 2026 16:22:29 +0800
Message-ID: <20260911082233.694414-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 216bfc3e-7256-4ae4-0db4-08df0fdddb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|3023799007|10067099003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: psZYOMEkt63gbc1AW/U/ET+BXEXgidQelNBJ/BAZXGJUv0XqQd0VZUGRNkzAlAXbopvUaECson7wCqY/CrFsUdvGTztuwtacSITWjNfD6t8gTYywdzeQ/yBpkbaio1RbpJaU0P6YVbVOTpljzfh4WAfzWXweJp4S5uS8G7X/RjiTvBuzKlaUVtWodf28EFi0TdxEFycZkvKjvNpRJ75slqqGrhpvY5E4YgRE8GJPCM8oQ+DEHFixPtP0bs0R9r0PmUsWR8p4KCKeJgpTSDwokXzY+njD+dEDoVZWRxgXaTPb/XreMHVwlj/5wUimp2WsCblVZ+kSixu0aVqP5zYsWaxGddpOHRFXlM6EV8Z1cpuhd9/zCkSbOiN++vebF4Uxg6fik/HTf7DpcSc06ESE0FDCozEhcdE0MmaMmcCVmE3T1cKkMMP8r/oiu5UX1dSfe5fKSoV5uPSruMDEmtpikR1isQdJ3CAJWb9rt7lnhT64wymIPC38CGpSF+8TiWoIXOXXp/b8boDP7pcj7dSj2RKC0paZ4iJEzxqsWA2Y5fPdmQtVKBIJJ2xyWqOAAtua7E2GbcziIfe8qq85j69XHZL+J+oMrST2iYB9+5Y1uHvYajVs2Ty7OHye1CyDZ1fA0GVmVD5Xn6jS2CehKqmdxqHQslPL8yTKvTwRhk1NmjTXLGDfQCeJXlc+0O/P8mkHAcNSaQeDPH/qNq7Pn2+5kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(3023799007)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 74fJ110yf3bfQx8ZDtSfsKxUepLZy47qPHzP6FlEW58Hr3WkCpfLSVqftwvnzpbFDx8+szBLqdUoRZlobjkaCE/vGeOvZluqdd/m69WfV82hlz4JLVmW7EaCKS1OINV9z+epBA5lJrKwpffhueSTSnjOYjYtUGKcW6ZHqacU435TMfFOre83HsVx/hvNLtiYVQohncw4e1NFbEvFGwC9LCs6xDDemIzkStpayrwkkQtuMBtYebQPOlb4NdtToeEs5cdyWh2HWsSCfGjUoNCtWRGRZZ/591LH/pQdd+LM/L6lJh6IJL4aPuPHGwnp5Y2bVhIlsfossbh3p/pEvi8S6uV7gN/Yg/NNbwbi51ae/wvEnMEg8+39BFLU/ddS97+U0yUNAd0CwcCqwM8UFnceZ5NP1L/9jVibsjzELwNYjRVe2CM/YvRPgqW4ztf4foYT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:22:44.8215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216bfc3e-7256-4ae4-0db4-08df0fdddb31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd1b8034a2fb..183ac26f2bd3 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -352,6 +353,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -433,9 +440,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

