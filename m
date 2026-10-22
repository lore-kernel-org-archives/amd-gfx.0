Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E2606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CopF/1Fa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054D51123EE;
	Thu, 22 Oct 2026 08:21:41 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75A6112404
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRXZqaIvJ8k/s6eJ1fJ99Slmt95KR6dJvCDXbqToPKJ7lyyUil1EMW394x3d2Q3dczeAsq7Ki7pQYdY5n4REsHf4P+dNOuvosx5jA4m+I3Fp4hES+o5E8ccLfdRdbGG85Dv3H5x2+I8M169GJOaEsmWlznTMAbU9GUJreJmpOG9vxz/0vt/AXdv/Xqjb95dGq+sbnNU9GiSlx474boDysS+63ftWB6PIMxsDjagJCNj1cokgyatbfkB1u67x5jg4zN4AzEtBGciAaiMV/xRsS4AIgI47PZNhSHthgzXb8X+hXRMkWY/QEBPxOQkoWcxdjITkhUEBz6FzeZy0WTVGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+EZMP/A0tGXTs4UFwPN7Tuma+c9KHq9/MBT6gRJtek=;
 b=sdljxb9zAbYpqCFK/8E1Z3HM0FcqzNinKiy2DUu6iJ2u80kVfbSVg2rnYAsQwCkhxvxy9WUDUeU4cKWIZIN4IITlneJdoLn1ybgAN7rZIZXr4csWqzjbLvvlsXGGI3GkBbttvH0pSiCa0uTyB5CErZjXNzfZ05RbXkFWVevk48/XljuvV6ADKX4zMC53Yth4vMWpHRulGeab7QGI5WIq9z5qLA9pQe3TU8EuBVcPz1G19abodmy2HZcuhi47sTpHkmqwIsw1n81ix5uyBacEvlf7F7D20rqwmQr/mhQMM7bRX55altSUDmOt5nvGMs7FwKDPNsWutQCmjKt+QR8Edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+EZMP/A0tGXTs4UFwPN7Tuma+c9KHq9/MBT6gRJtek=;
 b=CopF/1Fa4zK/q6QlIKKcLYTREmt7jYhz1YRUcmf7+3fJpax5RPfaL968mKjK8ob3KOwFzRx8oE1rrMeV11tIVDZk2u+6Cy8sJHr2N7YHK8kZ9bFoNsfBZ7Wf+5pDyAVqvSO5JLeK+xCj0XqZYwvfJxv9DPcaLW4C1vTGTIOI4jI=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:21:31 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::23) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 22
 Oct 2026 08:21:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:21:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 15/15] drm/amdgpu/gfx11: enable the gfx engine reset
Date: Thu, 22 Oct 2026 16:19:55 +0800
Message-ID: <20261022082011.331462-15-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 55329936-125c-4395-7928-08df30157a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|6133799003|22082099003|18002099003|261021121427099003|261009223027099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: NB9PNyEoPV8Anrg+cl/HnYskYx2OUQXpJom5FqZuXh2ezc18kxdlyGSOIVzac1EyGkRJDPTv57G6+6+CDNpS4RW4jAHneT/jDBqfNwmGo+WFlvMC6wzYM0jfF6i3QUFmzmpFtvmuyQ+ny1+6wtD2sDcMxa4T0WAhPYZx+vIP+1ZD7zeuO4jjn+2VP1zihLEeIIlboD+4CkVxB17bYU1YizALUNl22uaRQ67+LNabAa/wH2g4uxoRZBn33ueRin45pOwn9msB4F4Ls2AsSw/mDIQfpYtFCxLXVlonA08f90K25xhbbRjep1M6fAKCSUSOSpGlKPKkLWItx5Wd7xFRof6ju0zUA59x0XFFjBrK5kkk2zWVFRnmtZBjzHAKDsPfMcpwLmsSH/m+xxkFhaDBznY+JZ4Psh7JUGyLSYYvJCYCVATysABcKa8tc5SvmoQr6yYlyy46MQT6HcKK5WmysaEwFiJ9WE2RkH3hDGhgNPAFHTcEQKLsUGvb2oXzUFCylA7ZCfjBHLox4OrQx0BziiBspMW4rgti4zyM3Fe1w2wfUvnoPG9X/x+l1ELFrU6eqXiGmlDiC14lZESLsPIcKyUXa/Tf1EQnMFNoMCdpYZCatLyw6HYktS5w1R/h06Q9fsC1GqrLk41aD1JMQM9Z2fnqOSn0w/q8M+j6+pkGg94eg0/pRWN28+b2NgCHOpPpw7oMau5PCqWgO6f414W/4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(6133799003)(22082099003)(18002099003)(261021121427099003)(261009223027099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q19GkXZdgiy9gFr8vOeINTz0ZUvz1tC1G+EJzh8KhG0uUOPqL337xQjQaZWMiUnITbI+LKGeeV75LOzq2ot0jBTj5ovlrBFMsBokkI7XgYquOwFZvbomdKSwqnb8JGe7O0Ud0o0CW/2D91zbl7q6JRnnf3LUtKt2HEGHrRYwnXIbTsBNoJWknl71D8pcOgtRqpxRETIU86pTrfOxU5az2XKA5gROh+RkqRAI+WC8syLyRHF2PfozGZiaxSLf3NsxwjI+E32+eh4KMSwz6gS/bPfUweNRuUY6O4XD3D7w42KI6f197i9Mk5fEZq5sNtghNsk9Nt1NIDSQkk4k53WssPWMxLK0u7aZdi7qN7TuEujYGGfwBShTpgHWicmB+FMbhx2+IPK+GUUexkmxL5UdDGn4DeBg0xPgVQ/hkRVof/l2owLN1HaoTHq6vneC9bAy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:21:31.3166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55329936-125c-4395-7928-08df30157a43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

Report AMDGPU_RESET_TYPE_PER_ENGINE for the graphics engine when the
reset_engine callback can be used: with MES, async gfx rings and the
RS64 firmware. The reset restarts PFP and ME from the start of their
RS64 firmware, and remaps the kernel gfx queue through MES from its
MQD, which the kernel gfx queue only has with async gfx rings. Not on
SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a gfx
engine reset before a full reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a2eaf416b12a..3b52eb58b124 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
+static bool gfx_v11_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
 				  enum amdgpu_gfx_engine engine);
 static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
@@ -1945,6 +1946,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v11_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_engine_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_ENGINE;
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
-- 
2.50.1

