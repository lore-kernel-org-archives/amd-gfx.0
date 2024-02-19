Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822A0C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 08:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0894010E19F;
	Mon, 19 Feb 2024 08:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUfb0HrF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C7E10E192
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 08:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElGKlqQgBt8stNlMVT13c8qRtyIt/6lIbgGIG213Hq5OZE8MFkF7SNi+oaJvRsOH5f5nDeejVMTpHEKdA7nvdJeJbri7t+4KrNgt4lmyqZyeWs9Ri8B954Ae6QnF+kHcE4Om+/YtIR4g9hUoRoOvzg0cAoXOKJ+JQgK0ky8milSRZAQSmIzdSyzf5qNsSjNnLh5e3tCAtWWoc8K3Xi2//2ZvtKQ7gh8uYqaP3nc+7HwvOML2ux1A7DlauQF1QXDSbv7ndqXpSRAgY/bYGXX+wpWBUffGAg1e8ZnPU54ZDznYEWQ8V0BN2TzxaRXeN0CvV0QUt9O2NkgKhv+4/I6aCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p+nmm4fakPkhDfk4xKcERGnJIQyn3Vr72dHKWDtJqg=;
 b=CCtoOLpqd81D7c3JKfJVfMdMSRzYIsrCf7rV0FKQgj572YMy+ZQZsZnwaqyKaZ03ODcqm69xoVEj8rH8nUtpbi/hOgqUMzreElFXJVj/w+OLGd9/dYuGsDWR7D3VpX6v6DU8CPG2w6Tg+Udl3C7RoHoFguVF+B9o8begJXqYVRp45hGeYwTw029JDZjdjGy3Ut3n7nN0/1QtIfLKY8+WLktZ4IOFq8gZan0hk50YdpDW72pbsaOo6PgEu0TOeKwydADh+U/YecwNYuiM4esccZz24Y6Klc3+xlXVXO6m/NbZfHA+xHJbsyYZCKA6FUCodlk4WRKnRYAmclzUoEmLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p+nmm4fakPkhDfk4xKcERGnJIQyn3Vr72dHKWDtJqg=;
 b=ZUfb0HrFbCKixn9iy/klnd5zx/3cZbDRojPQpbHhVGmsCFGaT6vVg9eYkKZyzCuhLd96YJjlDsDEb4xraUL6PGj28/JNy8qM7vN3YWoX2ihTVhLbgZoV+3s4ud/gReWpCs1SS9HXBLmgtEr75O233yavRKUsUNH/odwwk07CT6E=
Received: from CY5PR15CA0253.namprd15.prod.outlook.com (2603:10b6:930:66::20)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:15:34 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::9) by CY5PR15CA0253.outlook.office365.com
 (2603:10b6:930:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Mon, 19 Feb 2024 08:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 19 Feb 2024 08:15:33 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 02:15:31 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add utcl2 poison query for gfxhub
Date: Mon, 19 Feb 2024 16:15:17 +0800
Message-ID: <20240219081520.316064-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219081520.316064-1-tao.zhou1@amd.com>
References: <20240219081520.316064-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|BL0PR12MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 388f504e-1843-4ddd-759b-08dc3122f1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wvrt7KexaFw7Hlq+mbUkuKHOU4D4Kbm2VSwLYrfEpYC98rbru/i/sl4sFGl4YlnrIFcRZwgYJo9b7kjNnl6H4s3OBejHm7vv9IE4jiwGCKWYCWReTdR46RliNJMsrxrl1HWZ2pacInFmJSqtt1a2jje/Uq+bqDgXPQvV0i0/0tsdlukye5ReMhUNbCFFdtlThKOiNwZkyQLQiJRHmEtfpyLMD+MXDu4v/FaBwvLgdXgthvIzPXCF/bWws1eOcdJ8H6sB2yYh/U+ra70LOlgVfPgbkh3OZJrcEQ58orssn6Z/JuC9aINQIyoGIOSxMLAr8X1PYSgYgrFFv6vGb3uaTkl6Itak0uE/TpSk9kKAx37HQjWJkYsBEbKxrGDFU9c6q/6kGWobiYwSlm/qAQCKtdckOUQ0jBjXeU29h/w0ickcl/pGuNcZQM/SQnOwDEWKtkd9AgbJdlprLAj41XbWM8517nvXZavYNCEAOlVrkBP4a9KvOK8M65ovxEftc9xZXIfABfTFV918LPV/9nBScqZYC1mBHyOyODpeg3ar3zxUCznR95r8KGUCsGvJSNP4zruWW5upRR1PvIBkvVB6QKoWnr9pPBEWhCNnUa9Y0r7xo3S8qJhQRPWokK7cHBrc7K6y0TG2xGQdwQE8c6dU34iy90DuZ1FrvNyS16OA/XU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39850400004)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36860700004)(40470700004)(46966006)(82740400003)(86362001)(36756003)(356005)(81166007)(7696005)(478600001)(316002)(6666004)(83380400001)(426003)(336012)(41300700001)(2616005)(16526019)(26005)(1076003)(4326008)(6916009)(2906002)(5660300002)(70206006)(70586007)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:15:33.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388f504e-1843-4ddd-759b-08dc3122f1d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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

Implement it for gfxhub 1.0 and 1.2.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index c7b44aeb671b..12b131a9cc42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -38,6 +38,8 @@ struct amdgpu_gfxhub_funcs {
 	void (*mode2_save_regs)(struct amdgpu_device *adev);
 	void (*mode2_restore_regs)(struct amdgpu_device *adev);
 	void (*halt)(struct amdgpu_device *adev);
+	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
+			uint32_t node_id);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 22175da0e16a..1c14b1665c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -443,6 +443,22 @@ static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 }
 
+static bool gfxhub_v1_0_query_utcl2_poison_status(struct amdgpu_device *adev,
+			uint32_t node_id)
+{
+	u32 status = 0;
+	struct amdgpu_vmhub *hub;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2))
+		return false;
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	status = RREG32(hub->vm_l2_pro_fault_status);
+	/* reset page fault status */
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+}
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
@@ -452,4 +468,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
 	.init = gfxhub_v1_0_init,
 	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
+	.query_utcl2_poison_status = gfxhub_v1_0_query_utcl2_poison_status,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 49aecdcee006..ebc96739e1c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -620,6 +620,20 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
+			uint32_t node_id)
+{
+	u32 fed, status;
+
+	status = RREG32_SOC15(GC, node_id, regVM_L2_PROTECTION_FAULT_STATUS);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+	/* reset page fault status */
+	WREG32_P(SOC15_REG_OFFSET(GC, node_id,
+				regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+
+	return fed;
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
@@ -628,6 +642,7 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
 	.init = gfxhub_v1_2_init,
 	.get_xgmi_info = gfxhub_v1_2_get_xgmi_info,
+	.query_utcl2_poison_status = gfxhub_v1_2_query_utcl2_poison_status,
 };
 
 static int gfxhub_v1_2_xcp_resume(void *handle, uint32_t inst_mask)
-- 
2.34.1

