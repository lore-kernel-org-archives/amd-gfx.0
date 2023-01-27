Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDB5C38142
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 17:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594BD10E9BE;
	Fri, 27 Jan 2023 17:52:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAEBC10E9C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 17:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZQyIzaoUPGYq/s51E3S7uEbfLVZo4orluZBnPLa8R7+QFR4U05XA1o5oRxVU8rz72RojDGzhXyVnvbXZvsBwkLM75g4eGZ7fX/n0cFqAPNNCmos8y14uM979YDdvikGrU31VJ2aUM/KMYY/uK9Kamub9RA1rtn2rs2B1lZkSx/VizXTB5HG588dYXzUnKVnQZEKTmZDW6d72GhRvv3Oc3fj/v1IuBF2D0JuAhOX9JyjV6Kuej8DI0LbIB3y/VrcJ6Cjm01ZK8GMaNawm6PR/zeF/9lrKh6uMf5AdeBiWMCyTyQnkYWEE/fjtLfvDvfqrHYdejAW7JC/TLUVq+gaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2B1zc1H3DMRoacVccmz17BBuKYrW4Jj7GEozPWuRyE=;
 b=WQxV/XfYSpUZqBnQkZ6lehIaDRqsVQ1C4oydMCKh+hK+VwAG8MiMWE+uzByMKkDt7jQRmK/uW7R7H2TsIQZAdc8VxA4JHX2SXWpRTzu2cc8qfHYfzr+21NXK3fpibBrfpsqFv4LDzog2NoGMTbusakDgkG4GexMvr2FD9PV+0M7CixbZ+UogJ+sHvnxhg3BPeizNK0+/4l9EuNn8s7I2ts9HSsi2mkeR3v+m5fhbCDGtyOIVtgpwvhhRWpCccQjag8OkkhSi+uzZMY93rif0mP+G90fx0ZaW961CYwaqSC7K+Bl9Bv+ASqXLZq7RS3VcioQ2FWeP7joI6bOpDQQN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2B1zc1H3DMRoacVccmz17BBuKYrW4Jj7GEozPWuRyE=;
 b=nsWbBYj26dhYwUPmGZ7qYNEQfPVV3mDebrc0C/oQyGLpHmpYrtEjMEriCJNHXPPX4RQ7qdHL9f+USdvXdI9nTHa+m7TqUqTVAOEEz6sqOZHvCGa1SQIQBAj4qveBOlTH5f/Hr4ToZ37ZOK8v36xYKFFaxhZGYdxAILpfk+4w3IU=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:52:03 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::c7) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 17:52:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:52:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH] drm/amdgpu: add force_sg_display module parameter (v2)
Date: Fri, 27 Jan 2023 12:51:27 -0500
Message-ID: <20230127175128.2570382-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c93770e-bb2b-4234-ea2e-08db008f32b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dig7fZ9hVnW8ph0839mEXMPxMhxGJ8/3svDAAi73wx/nRYtTj/80jruu0E1ko49WQWiJ+20fwOmnL139xJLqu6/dRHLEUziF4dwkaB+jF2ZUjK7IGJ/fcwoAGc1AVmH9S87yCBp9Rr+OnvrMl4k+zXWeWdwyy7qp9AbbvP5bddae69a8eVXJLSWaaf4oIPqzrwKjq3OKErT4bgF9IWwvvl0x5yWWNtX0mgEdtzrJ2IjzosxILJwQFSZ4jRjNMYcDN4k2xL6dPc5WjIjWfowW+Hrf94znOMUH5XHlvRQEOQj5kaW3jBVQzG2S0abA0e5ms0b0H2vpOkom8vnRAsL/KBDnDh9Vx6WY6dgUZmk0ykmwQXBGaFIcXIStMFFczw6jnWkgv6bIfr6/kKOCqKSZTsRgoBIedhWuvVKlHEMqp5RPUJiJ5neqf9t8t42nXCyNjOmNn621R7u1A84eH8wiNue5w9BmSyWC0fdKhYIpXiQuI0fXEs+A1QqrPEQ1Bs0d5aflbcjSKAHTrq0oWDFjTlLObjHll9SJSld4GqrcJV9l08SJYTvpGvrDtKkOEV7aPlJpxpEVbejoqVd3uuv91vNOra2fW9L9M66U0GXOm2SYlCjm+iNhi7ox+AKtC9UvrOPxLaqZ9y1Xf0Np8s6CUNqahtSm/HAHmXzGT+CT8zPIF2B5ZeLOiJLRwR06Y9zQnr6lj4G+L/aa5ueV902vZ3iqHKL5lhV9y85AnnWgUrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(81166007)(16526019)(186003)(1076003)(2906002)(82740400003)(26005)(36756003)(82310400005)(356005)(478600001)(2616005)(8936002)(36860700001)(41300700001)(70586007)(47076005)(70206006)(336012)(8676002)(86362001)(316002)(7696005)(40460700003)(83380400001)(426003)(4326008)(6666004)(6916009)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:52:03.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c93770e-bb2b-4234-ea2e-08db008f32b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a module parameter to force sg (scatter/gather) display
on APUs.  Normally we allow displays in both VRAM and GTT,
but this option forces displays into GTT so we can explicitly
test more scenarios with GTT.

v2: fix checks

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

For reference since the original patch was buggy.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 872450a3a164..73d0a0807138 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 
+extern int amdgpu_force_sg_display;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4cf2028b5235..c8975c2da853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -943,6 +943,18 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: force_sg_display (int)
+ * Force display buffers into GTT (scatter/gather) memory for APUs.
+ * This is used to force GTT only for displays rather than displaying from
+ * either VRAM (carve out) or GTT.
+ *
+ * Defaults to 0, or disabled.
+ */
+int amdgpu_force_sg_display;
+MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
+module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 981010de0a28..840190dd78e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1516,6 +1516,9 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 	}
+	if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
+	    amdgpu_force_sg_display && adev->mode_info.gpu_vm_support)
+		domain = AMDGPU_GEM_DOMAIN_GTT;
 	return domain;
 }
 
-- 
2.39.1

