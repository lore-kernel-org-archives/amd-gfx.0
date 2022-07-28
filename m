Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ADBC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ED314A2F4;
	Thu, 28 Jul 2022 10:33:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED9498C0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSoLuMe2JYlTqb7GNP3C36AVl3mEZv0iIfpvDvtlbhJy3tQ1UiZvbll2GIdgg9JA6ABN0qwAEmcwJbO1tjgVFH4rnjUhtHi/1hyhLBnRoGRrJd9vbW/t5gvAWRRYRs3W3Ae8rAQc8gbYz0gw+jJUHMlJTjNuvO8CAfFYJfGSqcEw1wygbRXZDesr933DzDNKqInHl5yCnWFA09KDpISEUK+ib6PTfwgUy80SebGaHvo5BC9Dgpa0FQvmZzgZVcEPvkIWH0Tdn+34gXvxSxB8G7RDcsBLgJelSQyBqxpNkFZDesFjQ2W1HVZwghB+7O8qCkt1gr6yfg0DUkYp49msqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb9mZX/UtqyeffzrE3aXmjiZ3D7Rrv0Es+RMkG9Yzhg=;
 b=nXwh/4cyr/dxQs3TGh5LR57mo94dHrhzupbLUyHnDc9VYn+KnImp/aiFlyVN0xErRIbLd3Aftt7cJID7dtD+ULQnBqH5vWxcUjPun/tgfFymq0+sCEtMUt8LOyoeltDEI0nluSyuyyzpwbecGgpT2aGLniK9p2dIgE/K1FlxFLpmnIE5F2aDuEidrQI5EILG+5KRPlW6lY4AXNP4so4mzzZBMi+o1i5w8JKgr6mxqStxcJ+Mid96H+mqOSf2jcFnF2HudbnyfutRbcFzR/ZCRGpnm1kU5RVv9ShEilCee9nsaGit+6E5n4c9khhIbzvoLx0x9Q2/P4jT10htHwZuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb9mZX/UtqyeffzrE3aXmjiZ3D7Rrv0Es+RMkG9Yzhg=;
 b=InzX/V0WSvAYegEkiZ/pxCfy4FnWSmJ0NU0ovY+8PNJq7BAoUcF8yo9Ucvfmz/J9qNDEuDmOXPaeKWx7jrSpiHUUUIRq6xiqAmJidviEJBGWWBcHNQnSXk6tSedMBBOKOFrzS9ihxbpkV8Gjo2r6QjR6Ur1ern1uCHyjn8KDh44=
Received: from BN8PR16CA0036.namprd16.prod.outlook.com (2603:10b6:408:4c::49)
 by BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 10:30:42 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::92) by BN8PR16CA0036.outlook.office365.com
 (2603:10b6:408:4c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 03:30:41 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:40 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/6] drm/amdgpu: add debugfs amdgpu_reset_level
Date: Thu, 28 Jul 2022 18:30:24 +0800
Message-ID: <20220728103027.27255-3-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c784df2d-b4dd-472f-b0cb-08da7084393c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: argvomYyG9feIb80Xd7iEP4zLkkrarcu1FAGw6vjQmO0JDZYEYyRR56ITVVR5DsEG/WJfZT4UuigKAozjPBE1fN+6EQcGhJwR4jx2FWu1UfiDMwNm2IX6YnlSpztg4c+RyrkAbWlnv0iVhwW+YwzsMchOQePrrNdYG+xrlyihd/K/KyJ/mglNjnx47d5jOAIGPQqjWgie2arrDO1HIml0rJpKyLci7nfKnEbjGQl3hE50c86W88hM3UEIK3veaUO+Dw/MK4r3T35NXhTetOcXivUqpITahosTM6VTi12xIn8ux27q+2Jsj2RfwBQ0KHey3yETPJiaca4NHcT1SwJyyJC6gThObJ3Ij6RKJI42/SEyO6V70XVeZ50k+ZO7mlZ8VXA4/9e9dYo6Camd0gzf6jwi7kc94Aszzmimu/CSDLnEMZdYMRBDXFcKjjIibTpR/6rtFlb7luDQy3K8ssmCtxURQLo5M9oNETFS2LDvewKPGI9qAKONmxCndlgziSJfMxvVtSPx/VGRkM5buEI+1yFNHmVRZ/FK3CAPO0iA/R7A/+e9UPQh1bnqwwLqBFjDAGMMMWJklhoEEWpdifjZxk0CtcTbV2Eqp9Sr8J6S0mD0ooWq0X78YgPp6eWsON3HKgBLQsPuwR6CZQkr8Q7TlaskiadU6buasTpSOeTDUXxZinIONeFgRcZXmWRndglvdq9rz/+GccgAS3CJgfgqqFPieEKDUTlO3ql0BHhNI1SkfR4m5UTJJi689mMTXU8eaRVDjW8SUprIbl527ryK+ExGHSRL67m/hcKyYfYsIlc768YXkuvAaL2xujctasgoA+JRZvBiYelbJWqegXXwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(40470700004)(46966006)(356005)(82310400005)(5660300002)(8936002)(26005)(478600001)(4326008)(70586007)(70206006)(1076003)(2616005)(86362001)(8676002)(2906002)(41300700001)(36756003)(6666004)(7696005)(40480700001)(40460700003)(336012)(36860700001)(47076005)(186003)(54906003)(83380400001)(316002)(6916009)(81166007)(82740400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:42.3838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c784df2d-b4dd-472f-b0cb-08da7084393c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce amdgpu_reset_level debugfs in order to help debug and
test specific type of reset. Also helps blocking unwanted type of
resets.

By default, mode2 reset will not be enabled

v2: make this debugfs in adev and use debugfs_create_u32

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e146810c700b..895d74c8aace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -274,6 +274,9 @@ extern int amdgpu_vcnfw_log;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
+#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
+#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
+
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
@@ -1060,6 +1063,8 @@ struct amdgpu_device {
 	uint32_t                        scpm_status;
 
 	struct work_struct		reset_work;
+
+	uint32_t						amdgpu_reset_level_mask;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e2eec985adb3..c21b04463de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1785,6 +1785,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return PTR_ERR(ent);
 	}
 
+	debugfs_create_u32("amdgpu_reset_level", 0600, root, &adev->amdgpu_reset_level_mask);
+
 	/* Register debugfs entries for amdgpu_ttm */
 	amdgpu_ttm_debugfs_init(adev);
 	amdgpu_debugfs_pm_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 831fb222139c..9da5ead50c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -37,6 +37,8 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
+	adev->amdgpu_reset_level_mask = 0x1;
+
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_init(adev);
@@ -74,6 +76,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
+		return -ENOSYS;
+
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
@@ -93,6 +98,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
+		return -ENOSYS;
+
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d3558c34d406..3e316b013fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -405,6 +405,9 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 {
 	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
 
+	if (!(ring->adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
+		return false;
+
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
-- 
2.25.1

