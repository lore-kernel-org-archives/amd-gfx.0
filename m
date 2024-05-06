Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CC7C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243A4112306;
	Mon,  6 May 2024 18:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Li4IMw5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEA4112306
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az4PxLy1FgWxOcwNO3vZ2ckTzVAuyfD0pyYxtZ4IscmtjLq48o6ZxScwPdZYns6yGvtzAev9o0DVQJugpElwKaPcegdxgyEVplm+iaILR8zq65dnaRsTBKW9rf9nbrM4pMNiG+7z6ktOFoODwtJwaFIhXth0EIV4lnMCZ+D484EcdCxHS/T588uNQVc/rWrb2unMrROJsR90kYZrK6Z3ZMcKKYL/8pbhW0UvFWUnmUQMO3QpY/E20u7blGhEMwnnQFYzQxsfctj/QCWhrklxs6ViAmwqSTsDmctF//ot+8M1RCvOvbKIEjpG05jAae/vIpj6ZR9dD8QtVLvz9q45cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaUIf8VGSU6rmRz9AU8BPq6OJxHmvjGkiooIQFeoPV0=;
 b=VSBiA0g0WJx6DkFOYJQE/pRqXExEmKROB3+cnpTQzsbRca9Pdyo6gTV+z+n09NXbzVthYrM16of4hFddCRbptvCDSg9s6dWLeNmPFYOZfJX5W1foGg9SNjTtuQylHJoB8VC79k4gy0OV6WWPKLs67iJDKqpw34P/vxWkOwADjiPyUuW2XHumSaiDN2IrHjD2Wr7mkTZpuGhBs6/KxX8BOJ8Gd6cQ5yyeThxEG3bz81nqm/i+GUYRXRBUcUXwHNP8UK6zQRe2go0/YjMvVJVriO0d1TokAqN2mg7yykUQfTmIp7pSMmIIYhNYL37PlgH2v9qX89ivEYXAxQe9+/UgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaUIf8VGSU6rmRz9AU8BPq6OJxHmvjGkiooIQFeoPV0=;
 b=4Li4IMw5IuGSLEUVLAqaV6rDTW3of7Y8cRw+QqVEJggVKOms4pPhgaCo2dApoIo2Na6oG0RuuSkK05zs3T7+/LRqioZi2VX1mjWHLvOHzWWJObTkFjfqhEhhA1Nmqwe3myb9VBZCGFH9ANndxb2eySQybPY/XWC09zYMgzPeuf4=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:46:05 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c8) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 08/14] drm/amdgpu: add set_reg_remap callback for NBIO 2.3
Date: Mon, 6 May 2024 14:45:33 -0400
Message-ID: <20240506184539.1669157-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 765596be-f81f-4cc4-0abd-08dc6dfcc87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Z0I2c/O8vvsjrqusnxXvDyUT95S/xm+vNRbJ8AFp3IlzNre2Gw9KSBELgEC?=
 =?us-ascii?Q?Q6A/V67VMUqzrD+DYS896W/XnV6NiarjZS9AJObUiWIRTIvtXa9hX/wLoxk9?=
 =?us-ascii?Q?2YuJt81Wn+nhqEqXozuprbGTFXxm7mOywAH7ZkTLW3q1AA2Ul8k8k3qXScLL?=
 =?us-ascii?Q?72/UhBDeXwivSlsSwee8NA1pspPkiAwhClGE52HfJnS5HSf+H2JxS78xFmIA?=
 =?us-ascii?Q?qP5aH5CbOqOrNavxLFbpLC+DuJMt3LCJlgKd1M0mBBcBSMFwEyKfoVnrKm0l?=
 =?us-ascii?Q?2G8n/GdII32/i2ZbYXETv0fLIPqbABeBqMZh06Pu8gDGk2FAese3Nu50V08C?=
 =?us-ascii?Q?QoKKC9skN9tZ9eCN5PKROz1TT1F37KsxYNyuHdyPZB89T5FBOcMtidBCLj3z?=
 =?us-ascii?Q?D9K7FtjGBrc3X1esDoWryNxI8ZR/2qb9xy4eVifjBWEzBJgQY2Jj+rp6YfkC?=
 =?us-ascii?Q?V/IVqSnz9c3nXzlUXpbWODG4NupKvObmp/RbVS7HnebaimsH5uFhPSJTA/+A?=
 =?us-ascii?Q?BX38J+u9JdMXFYin5t0PiK4i1+H19Vq9AwMhFWPCZ/ve8KDxOOCJeuS9167j?=
 =?us-ascii?Q?adodfOTLaFeiURwKYxqTmE3PbeDQfNXtfZMGhB5bjogDuQ9uPXPq8uNhTgKe?=
 =?us-ascii?Q?CSbyIm9Ui/9Asl/kkDTlmETVu/1tqMWVrkj636l/No2pNdaRliQ8FQOFqqxd?=
 =?us-ascii?Q?wW6xQJdIRE/qc6ZyJ6joIZrXzdsgr5vqmBwHPTwXsMun803za5VdcQaGcN93?=
 =?us-ascii?Q?oxRPI0SRFP+bDuSZLTsCgpOtvNz6um0frhBzJ+f5CFKnJPTwKq3sJOYZ0fNX?=
 =?us-ascii?Q?3CuYFpl755dB18Z72UyHce9OWQeXfhocYDC7XraE2LDX4w3qgAhYvdf9uW8i?=
 =?us-ascii?Q?VRpCNh2Gr7K1DRfDjJlgqFK3VxsUWzyeAZfcuuxLt+OC+ltIHrtYw3be6NiH?=
 =?us-ascii?Q?lAAR1MHu5H8pUHnxenEUwiDvcjEkBodEFBXKDDsIocKBMsunP98g2R+6cKhZ?=
 =?us-ascii?Q?z2tGajUwFQ+ys9BKtN0D/kVZk4lMDQn5DHOGtn75dzkjzfVhcLJaR08cabfB?=
 =?us-ascii?Q?0ueyQxFQiEMhlnEIr4aSbJwwAwNWhOi9YN9c2K04sv06wxYkPD13yGJp9prR?=
 =?us-ascii?Q?Uvhob77ula0zyTU4dv1QPo3DkqcWQO0biNgteb5lzzSWZwcMOOeuRqvk79kp?=
 =?us-ascii?Q?c4leNcOxTJ/jpW5v1q1w9cus0l7TvghXbkuXBG0WBH7zcqYblulbDIqoJq1g?=
 =?us-ascii?Q?1AmHgK8jlVDEpvBOmgcrKsCA8kiHOoP+Y94UswHfyPLynr8BDto0LyOtj0Ki?=
 =?us-ascii?Q?KUMLByTaqWvM0XcVAmci6sE3XDhI05o0H/tmw0ehTdyO3E/Mpr11GdTzLPpe?=
 =?us-ascii?Q?XTnXRWYU+SLH66RSkWG4DI7Laadt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:04.1367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765596be-f81f-4cc4-0abd-08dc6dfcc87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index df218d5ca775c..41ae0a6f9db86 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -553,6 +553,20 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
 	}
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v2_3_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -577,4 +591,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
 	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
 	.clear_doorbell_interrupt = nbio_v2_3_clear_doorbell_interrupt,
+	.set_reg_remap = nbio_v2_3_set_reg_remap,
 };
-- 
2.44.0

