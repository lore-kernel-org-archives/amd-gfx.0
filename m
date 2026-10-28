Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDA606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4yU6K3JX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5DA10FA96;
	Wed, 28 Oct 2026 08:58:30 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620D610FA8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pno8wO7WXUTIPz5rxQB+78EEks3priqM3GiRabUX7TmoucWNNNoraEIz6D/73d6NzRB2HIYmVdc/tPeW5KYRO1LmRIg3gyUinn0lBYjrWj5cHgBV3KUPbd2h22rU60AlD7DxBS/0+E2z5e4ml8j3KeLA40LdAlNhgV6QE2gs7EMB2ddbkRHtEdEP2G7N8A8UfPSxkGEzNJSGKwoEhAGFeboQ9LIlJk3d69Bpi8dgqYVEfCPZi5t67F3G9OOifvKPS3Zc5ZxX0Q+9keqQmEm/TUi+0j1AUUrSTmQrR+3nc5X0wiytKZA1qg9vmuHudHCrxx3OjQ7kxPXjapzG3jXEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTo8X32udeH4HCREiAn1sdNfRm7QitR3Q8n600unK6g=;
 b=ratdR4T5T7fmhqWcwIuASE0zX0nv7cU7p3+hEPpTULLtOekryXgAa1k6kg75CmnFGwfDjr04mgqkq0IOw8M5Kn3dGjh27lyx6V0VpoDvuDnZuC5wi4khOZ/s53wb3q+Oqv4NpSU2tlhj7vnRdk3iaFipYFSe3ZymCmzKLFV3Q5Mh5Xh0J2php21pFmAaVw9mYvfu5YyiZmwMFbPT2Isv4mipHcK44D6l8kxJtVYAPiSn9RbgpAYnfkAyn+B1PZhSR/sfU5VvpBz8vO+VSaXpFTm7/HrsTgEEPabljPRRSzCRo9klr6hQR81dG+ffSLFm2Ru0dFqsLa6EM3O5PM8PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTo8X32udeH4HCREiAn1sdNfRm7QitR3Q8n600unK6g=;
 b=4yU6K3JXABx9tedngHG4F8EpFfqIqnn5dBWb2cXtembLFmuKb1A9Z8SFJzjjy+xhqkUJ4//auZIr27k37OL3cnD6IeQJ3FJS1Uyk5bVaw7K8qgZpOtIUPjhxlCQxnGAOoKJzwvDShqiXr1iN3qQK9VhPN07MDD2KogJq4KdOyvc=
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 08:58:16 +0000
Received: from DM3PEPF000265C4.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::53) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Wed, 28
 Oct 2026 08:58:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C4.mail.protection.outlook.com (10.167.23.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx engine soft reset
Date: Wed, 28 Oct 2026 16:56:46 +0800
Message-ID: <20261028085736.3808569-15-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C4:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 89986db4-ac4e-4337-611c-08df34d19abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|261026140227099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: nRNungzZ2aIg//uqqET9fBrLoBQlRtESJo5qYMRo1I471ut8wKTqCj9iLzAU4Lz+k6VPTHQBx1ZWb0AYrqOyIM7SQ/fbF168vGYbiz6WbdcKfG2UjG6qVQu6UmvOd5shyhT8K3lOg4MAyWMdzcYv6iTtrWPfzRdJurXXPn5m1O8fwKrwoj4gCTQi1/h6Gx4YvdKbfHBur4/gE9nOemmUnI99ZuG7PxJTnUmTXxuL2UdDESm6c1DdcoNlVpJUfqDfSPHQQEoDOpKY8NPYA5Hc5xHbY5e95NEuAiXpg9oIZYPZIA98J0cKsdlTXXprviN7/76vj+ETVIkth2Y5G571pwBWfUJ2SMhSmOrJXlsVGKUuvx7cZg7qRH8yT05CC5VuARDbhCwW+QVk25CLppH/+uOjQ8zH693JUzdSxRaomqQM/MTOUANzfWa9VVi3Wq2h5Rw7kHEqTSEjDflCju2sPFVUkxhSffXwCXgtYElqsOlR2Otto1GiIRAQbqqNu3vUCoVsszZF/GPKhexsY2v8Zc9rbvLC4sog616y+hAafd5qGEiqZamFo0yiA5/Oy4TdgP7v9qqqQXwoaTPjOvxdjTWUor/DROYB4ThZtHDCaAKriBcQREXPqSC4zJSz8W1w2jcpsZz0rk6qdXr2fSVyX65KRtN3XIxzwiw56AKf6UX+YQE2W+IMGFIkCyYrgmmI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pdRLv4mzhfaXxpvJTrDVBm2A4NSmBnx6ybIOhP4n02+Cvcp/NFUlc69n2umasmLnOkVJlFLUV3/VdacwHmgQvZFL6Zv6o5frvohTOyFAq6QIPUO3IMk4CymcsJStNTbKMRz74MiFFzAxCDOQEQB1ctP7qMUY+nwoqr7JFspmAjZTKxsC0IUpC6Gso1pYss83jNrK4jM+CsnzY8JZFWQ7T0HgcvRPNUyUQlHFvsGSKr0szqkDzRZKG+CvODEc/Eylp+qLnkJZzOgbjY91L24f7G1Qije3UKXwQ65bbNlgAJ82oE+Bb6qZmf6N9+eR4sFMSxQr6M/whnK7qzmXNDPw0bi3/m94qtq0HDQZkQ9mmuYXG4WIRqvdY+jT3YUCcXV6XRFdOp/7QdeHm8VlkEildWrPwX0OVX5xOJxIQXeJ2GfC2rfI7rHUFFwo3RbOYOEZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:15.8098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89986db4-ac4e-4337-611c-08df34d19abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings, with
amdgpu_gfx_soft_reset_engine() as the soft_reset_engine() callback, when
the reset_engine callback can be used: with MES, async gfx rings and the
RS64 firmware. The reset restarts PFP and ME from the start of their
RS64 firmware, and remaps the kernel gfx queue through MES from its
MQD, which the kernel gfx queue only has with async gfx rings. Not on
SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset. The IP block soft reset of
gfx11 only resets the gfx engine then; the whole IP block soft_reset()
isn't used.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a71dae5d0d3a..41ebd2ead99b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 				  enum amd_ip_engine engine);
 static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
@@ -1945,6 +1946,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v11_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -6927,6 +6932,16 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+/*
+ * The reset restarts PFP/ME through their RS64 start addresses, and remaps the
+ * kernel gfx queue from its MQD, which needs async rings.
+ */
+static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	       amdgpu_async_gfx_ring && adev->gfx.rs64_enable;
+}
+
 /* Restart the PFP and ME pipes from the start of their RS64 firmware. */
 static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
 {
@@ -7370,6 +7385,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.resume = gfx_v11_0_resume,
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
+	.soft_reset_engine = amdgpu_gfx_soft_reset_engine,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
 	.get_clockgating_state = gfx_v11_0_get_clockgating_state,
-- 
2.50.1

