Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08D7C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FED310E5BD;
	Thu, 24 Aug 2023 21:47:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C157710E5BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EToRmsECe35pFZICfHXPTr0KDPD87SiyNphvbWpA8Kq1OOPMWd2lMnFTGK4e7u57OvDsJxAgB/OUghJ5Sv42dVw7dxw90qnikmN9AdPVJcXeFcxk75v45RFZDcG32T8iiENOm07gxWW0WCb3T9OKgkQxX4Y2NIz/7LdTTZErBIDktsKYADKm5cDIcYgT42SOhN0GI0rLeJBOle8ZQl5WagyPJ6a2X3Ox1PEtHiZ94u423Q9OUAmRVF7c739MZ4NBz/r+IlQ+x66Kqxl3gIKL0CIEr68ln6iBreVzS2RwPIv6dJLcft2Vcxl/Im6KXJ9TO1xBW1jzKQJhtrZO3Z+02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNxUk5kXUIJqBBZBbeoOQ6oMIfsZddhRIeJFi5hwU48=;
 b=VtP01aZf0+dgQ8utDnVFHaYXciU7Zs7i4ZePPGDmItvxX6Zn45ydTBDxsuM5QZnwLsBHFKJiKylFBgvuiIVqgFcSz/iUKxjUFNZVxojc8vMopBze8vJDBZ2FFckiTMBRVVD9MYSIL/uNPY1GGIghZCdKelc2tyMGI0WRNrjvh/mkVTLB07XAHzhVCiqx/Hx/nyP/WtxgqsS0k/8fyidaaaAQRDkQNY2vOjQq8hwP/F0Wmo2xMaxsW7qPzAcOZb/gEfjIsKgMJpoNFUDnmRHvi5woEt67DtfQR4l2pLfzmmNnE7pTxNcTulZ4ShJgO0/3k7Ws9upMlkYPGiWWqh4GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNxUk5kXUIJqBBZBbeoOQ6oMIfsZddhRIeJFi5hwU48=;
 b=eGYBIy8GnmnBpAbBSo2G0DusAGrluTl8ke2MsRUvSiQYTQJ+yoi1OXbhURe62Lrd60X/NVCGd7borduX6bW3f2O0IJUKuKaZS3bPYqWITbv9KQmYGS4xlLkc6byiSAtQIvqV1jmSUTyMYMGupELJ9RVBLr1F4a0RXsf4clBiSJw=
Received: from CYXPR03CA0010.namprd03.prod.outlook.com (2603:10b6:930:d0::17)
 by CO6PR12MB5409.namprd12.prod.outlook.com (2603:10b6:5:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:47:17 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d0:cafe::14) by CYXPR03CA0010.outlook.office365.com
 (2603:10b6:930:d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:47:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:47:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix VPE front door loading issue
Date: Thu, 24 Aug 2023 17:47:02 -0400
Message-ID: <20230824214702.2739427-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CO6PR12MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7b7548-5fe2-485f-7e94-08dba4ebafa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wOJVXmK2VIF7sntCtvIt6Tg2mXXA2dyKllZrun24tXBh5CeJJrc//sYJ6vLku1fhpITESXqssdfkkovaLOtXst5V2yuffDTCUvoFhmW5QzyBxIzkbXZ1f4ZG4HoLDzM7uczxk5TKke0xW2k75DOiG+SuiQ3xkNAJ51vN+hwm8IVIq4fAsqjc52vHf1ga6IOEnJNSTf7bfHfR/lE4LfdqXE3RQfUQXOevb3ug7QMmeLaw775o+sq9rC0K+tNHTz0D/yRLf4cxVoaDpoiU5IibaWwCcTiYjRonzsojsK5Vj0R/qTW5xuhiYdnJXGicbbA+zmCe5Lj4mmjG82qkHbcfCoqBWYpk0kl3r22O30D11wxf6d17AS1sLLOo5Eqb8V6Wa8hys/Ogxgtvb/qI1T+sGOZuOdcwmzaU1roUj6F32Ru1FJEE5TIksvVKjPqaos3mDIJ6u71c/fMYS5MuRNPUJTTQ70tKjD3U/FgJLeo4jqVHjlhQJScFQAZORXg+XAJezA7jXYz1QtQ/i7+xB8uoHM7HCmuKjXagKkvlFSgJCP1e5dwFa+gXIkwUmyFUwDXrleRIVH/3/3aH0LxECshb8wAqK1p0nlHzRLD/QZSPTart70k6WYLnijiP6UITr+na32VTv56L70aItrtLEHcGfDadhjcogjN8eQXS7V+f6NphCFs93cvYHLj7Sj2gqvCjs7m649MQAWubPYFSJ1ZVptmU6dNQFSGnd7qWXJwWCkhnMvLc9Po5Pt6A+6LV9ZkivSUblvlf4N1AlLJe/2YoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(7696005)(316002)(6666004)(36756003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(1076003)(36860700001)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:47:17.2895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b7548-5fe2-485f-7e94-08dba4ebafa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5409
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Implement proper front door loading for vpe 6.1.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c   | 38 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h   |  5 +++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c     | 15 +++++++++
 6 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0eef555e3ef8..bd70715d329f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2396,6 +2396,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_VPE_CTL:
 		*type = GFX_FW_TYPE_VPEC_FW2;
 		break;
+	case AMDGPU_UCODE_ID_VPE:
+		*type = GFX_FW_TYPE_VPE;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 0b601efa2944..4db6d0090893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -489,6 +489,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_DMCUB,
 	AMDGPU_UCODE_ID_VPE_CTX,
 	AMDGPU_UCODE_ID_VPE_CTL,
+	AMDGPU_UCODE_ID_VPE,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index a84e03a9b0fc..ae070072705a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -37,6 +37,17 @@
 
 static void vpe_set_ring_funcs(struct amdgpu_device *adev);
 
+int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)
+{
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = AMDGPU_UCODE_ID_VPE,
+		.mc_addr = adev->vpe.cmdbuf_gpu_addr,
+		.ucode_size = 8,
+	};
+
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
+}
+
 int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
@@ -126,12 +137,35 @@ static int vpe_early_init(void *handle)
 	return 0;
 }
 
+
+static int vpe_common_init(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = container_of(vpe, struct amdgpu_device, vpe);
+	int r;
+
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &adev->vpe.cmdbuf_obj,
+				    &adev->vpe.cmdbuf_gpu_addr,
+				    (void **)&adev->vpe.cmdbuf_cpu_addr);
+	if (r) {
+		dev_err(adev->dev, "VPE: failed to allocate cmdbuf bo %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 static int vpe_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	int ret;
 
+	ret = vpe_common_init(vpe);
+	if (ret)
+		goto out;
+
 	ret = vpe_irq_init(vpe);
 	if (ret)
 		goto out;
@@ -157,6 +191,10 @@ static int vpe_sw_fini(void *handle)
 
 	vpe_ring_fini(vpe);
 
+	amdgpu_bo_free_kernel(&adev->vpe.cmdbuf_obj,
+			      &adev->vpe.cmdbuf_gpu_addr,
+			      (void **)&adev->vpe.cmdbuf_cpu_addr);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 010fa7f308fd..b590205d6a28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -59,8 +59,13 @@ struct amdgpu_vpe {
 	const struct firmware		*fw;
 	uint32_t			fw_version;
 	uint32_t			feature_version;
+
+	struct amdgpu_bo		*cmdbuf_obj;
+	uint64_t			cmdbuf_gpu_addr;
+	uint32_t			*cmdbuf_cpu_addr;
 };
 
+int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
 int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index fd11115429c8..dfd60db97012 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -295,6 +295,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_RS64_MEC_P3_STACK               = 97,   /* RS64 MEC stack P3        SOC21   */
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
+	GFX_FW_TYPE_VPE                             = 102,
 	GFX_FW_TYPE_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 1a483d38e70d..1259b150dc96 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -84,6 +84,21 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 	ret = REG_SET_FIELD(ret, VPEC_CNTL, UMSCH_INT_ENABLE, 0);
 	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), ret);
 
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		uint32_t f32_offset, f32_cntl;
+
+		f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
+		f32_cntl = RREG32(f32_offset);
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
+
+		adev->vpe.cmdbuf_cpu_addr[0] = f32_offset;
+		adev->vpe.cmdbuf_cpu_addr[1] = f32_cntl;
+
+		amdgpu_vpe_psp_update_sram(adev);
+		return 0;
+	}
+
 	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw->data;
 
 	/* Thread 0(command thread) ucode offset/size */
-- 
2.41.0

