Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0E3D637C4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753AA10E298;
	Wed, 13 Nov 2024 21:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zeYbz8PY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACD710E298
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/Xwo6SbJsLEwjn1hg2C9dnX9h2PUEwJeoRMvxb/Vd15OvReYpWYrivXdOl/DhNYC/NG2giEJTp06pyPUE4PjsWWgh0gl7A+7l+h6dlf8ouCQLSfUjfmFpKsamKQt9wB0490E8vI+7WK0pGWoOq9qo4GRBQKqWPqte9vvAJ7lpeoV9LqAyzXDSDa7zgcxhSjMEOo1BdPnm8mLmDSxT1a0yrlp/qKyDvIkHQkr0BEzL6B4r1aVi91GDLazqyjWXk8LKQ6O/x8U2dELo4AOqpbzzDnehUcVjFmjLQ2NYVSPE2aV4I1RGzbLdjnFaiHJBhgrnZZnT3b4IHujDJQQ/Rf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se146vnpkGhKpozU9vrVAbNOcSP/TobT1sfaqH/qflU=;
 b=pC86q8R9e07/kFO2LksoTyD52nceoNLN82QC9Qju9DrSjkRF0eqMHKslb3SsX1KUzAjbVBAe38B7iQaYby32ZDmW86Z3pG0nHAo6+ryFmJhtZcUCAE9kTDUhUqAig6r0+SWx6PruqUwlpIUYzDch6RWWodISL7tIPJrVAQQNO8N6Oh69j07kwbGFVptqfN/Lr8rij6Nit3eoDyFF+N5lPrcU8EWrZlQjD7avpRLh6FNhso4UgUOsiuBhV4qsAXRJHhKZW8qq20xBvV3+uXVLnUrQbHD7JcNU9YOKglPgOr8Yrb687lTklBXHhJkg1vjJ+5Z4lnAtICa+vjVuSwn0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se146vnpkGhKpozU9vrVAbNOcSP/TobT1sfaqH/qflU=;
 b=zeYbz8PY3x5ACyXjMJeZsKuNM+2fcABr7jnWw7romvOehT18xiqw+J6uZ2QaKgglsSd/ZNM4jNmQZSGOss6GucyvMoyfQ3LZU8rfSEVQn3e2a33DC4V1qPIgVg7nlftA8KC0xGV+uggNnlIC6n0M9gU97+kcpBRH0FML2n6Cke0=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 21:45:12 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::3) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Tim Huang
 <tim.huang@amd.com>
Subject: [PATCH 02/15] drm/amdgpu: Add sysfs interface for vcn reset mask
Date: Wed, 13 Nov 2024 16:44:38 -0500
Message-ID: <20241113214453.17081-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb6366c-196c-4773-695f-08dd042c7383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aiiMHdQGHGmUSIOkgkaP3bWhZtrcUA9MtgRnTk4R79C80rPZIHEaYwbfIZR/?=
 =?us-ascii?Q?IuIKxWMOtT1KMC5yT/w2qH6FObJtb5W7xUAFosaLttEHCTwfF0MocpuUhuFo?=
 =?us-ascii?Q?Q+owOAnrJAZxdKTTgtu27UaI+llv30xFsEM+usNFun7ley3cSBc3UmrmhZeX?=
 =?us-ascii?Q?5pLYl5KBN8cLWPZCR6tklJkz5pL+0xabv3E7eWD+7tWKzJ8JURAM371WhphM?=
 =?us-ascii?Q?vrmqZwic3mYbFDZ/IwTOZIZQBx/W88FwUpwdymIGJ3B0w16tcdFsJd1v4AT/?=
 =?us-ascii?Q?yPSTXd8blN6QGzNEbPlWcGh/8GTeOtsTgesvMItPUAg0FH5QMKvIBl5KjHRH?=
 =?us-ascii?Q?36nAsygYuz00mcTYmQcmZVO+VFZkqVYF2Oor2MfiQ2xhqbQx+saeP9QWIk8V?=
 =?us-ascii?Q?Xo1sChrXnaiDvJJNLzZ5MDuCOQ06Pd5W5bxI/gKWrR9fk7H/pGmCyLKp3O4I?=
 =?us-ascii?Q?jcWLTmUPEVRhL5ddZjpXxLY3omINjSM6I8wHrl4+vSnRqIqp3Sk2Lo27OKTb?=
 =?us-ascii?Q?Sl4EToeA95nSRJAyFs6aVjqpnGk+zCTcKz/hKWdB8lI61qXMzrYdTfEF5aye?=
 =?us-ascii?Q?WOaC3VNARViMsYH4K4BRkDv8S34oMKpkOreanqqV6pfL7sm7rywbw6ytUbNi?=
 =?us-ascii?Q?+6oVeop81qQWOJ3RdVrla5UnPifispJsBGR0sigIJlko6KEtJz0v2/3ptKgc?=
 =?us-ascii?Q?kbRpVdbPpYPxrsjvS/H6WiadO22yHOIr07IwkkYU954CR3wHxl6VW+tvPHx1?=
 =?us-ascii?Q?LA9Do/74ba5YD0EPxj/Ev9js+LG6poTyXsx87NctxnSwMuUuzZsgfc/O9iUo?=
 =?us-ascii?Q?hlrMetzhVB25cSUgf2gSa80unieB58flKfottyk6uqx73tsQfnJM15EfUBTe?=
 =?us-ascii?Q?iLTtuUzhIR/vWLwyAKCt5Q4yZcUNOzHaE+BsoBjiWeac5/skZOSe9DA/UmLV?=
 =?us-ascii?Q?ESFl15rPWcfYTI4Llq3ydkT/Z75ejrF3sRNs4+OeR5rYm6ouowrRQ6MdA0D0?=
 =?us-ascii?Q?hyyGq7Xin8wap8VJYRNTePJTdEWc7vLY0PqSBmiUH/U5/Ll6eHn1+FwTRQ5u?=
 =?us-ascii?Q?cZmm6aCHpcwflZNpBpip3G7Iov3yO1ECgjY7I5rmFhHi9yCavnZ0oWxaY/Io?=
 =?us-ascii?Q?Oe7Igxo90LuWPvz4nURKKnKrtuR2YoY53VXNtmMce4lM0s2DdBPgYFZbG4p/?=
 =?us-ascii?Q?oluU/zilNyY6M9K1uzRfHdpggv5ZzQA/U/TYUD4KbYlhX6gQbIeviEqtznRm?=
 =?us-ascii?Q?YFH5nEBt7WboDmc0xKvekWAJPc53POA1AuhwyNJ8OtGxQdY09ineIQuN+qlf?=
 =?us-ascii?Q?OOlcwSsPfqeEQJpGM/W7bV9ndkOqsDZ+IItwDDrvdB3GYsurQQxbp2JKDUnm?=
 =?us-ascii?Q?2LjtoYr9uxgy00xMP0SgzNs6a0Cpepy7IkoE4Fm1l+RhzwrS2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:11.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb6366c-196c-4773-695f-08dd042c7383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Add the sysfs interface for vcn:
vcn_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)
v4: s/sdma/vcn/ in the reset mask setup

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  9 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 10 +++++++
 5 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 49802e66a358..c813dc94a7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1283,3 +1283,38 @@ int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 
 	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
+
+static ssize_t amdgpu_get_vcn_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->vcn.supported_reset);
+}
+
+static DEVICE_ATTR(vcn_reset_mask, 0444,
+		   amdgpu_get_vcn_reset_mask, NULL);
+
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->vcn.num_vcn_inst) {
+		r = device_create_file(adev->dev, &dev_attr_vcn_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->vcn.num_vcn_inst)
+		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ba58b4f07643..7b528123b36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -333,6 +333,8 @@ struct amdgpu_vcn {
 
 	/* IP reg dump */
 	uint32_t		*ip_dump;
+
+	uint32_t		supported_reset;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
@@ -519,5 +521,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
+int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 7aa6198e7733..f307921e2a35 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -225,6 +225,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v4_0_fw_shared_init(adev, i);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -247,6 +251,10 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -284,6 +292,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5edbd60c1675..78d046fd935a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -187,6 +187,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -213,6 +217,10 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->vcn.ip_dump = ptr;
 	}
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -246,6 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 900ca8ababc1..3c278554cb4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -170,6 +170,10 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
 
@@ -181,6 +185,11 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	} else {
 		adev->vcn.ip_dump = ptr;
 	}
+
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -215,6 +224,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 	r = amdgpu_vcn_sw_fini(adev);
 
 	kfree(adev->vcn.ip_dump);
-- 
2.47.0

