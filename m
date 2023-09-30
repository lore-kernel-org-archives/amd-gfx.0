Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F6E7734F
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Sep 2023 04:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D756710E188;
	Sat, 30 Sep 2023 04:08:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D133310E188
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Sep 2023 04:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxWVZUQopWxS03i9r/1netaPlhJ1SJeNcoXYMYWSpMPzzz85Wxq71RskiXRKh0WB8wQ5GgnnLHuqOvc7MhVgnCjCMQSvDWdz/H48FdtrX1ilaTzzEd4TnFu25JUzupdOHFEmKdLH0dtjY93XbEP7BJR+wdsHUfNzc/XuoHWugw6d5IzDq8CMqBbSwMvghYHj1HH82Tqew3m0b/ptrkD2z86TcCF0LkaVhzcIzOlKI0Vb0O4rh0I8wxVcUdHrQnJ1CwnSX2oHSHg0MDXyXlxxK8+aHBi6ATrD9/ZrWTFX+0I1981+PpXKrGzC6ukuXJSua6BXeG2u04/XO4rglTgNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CktfTVVoPkpttZvxB9IPAzPcExPOO+bQ7xE8uOCksuc=;
 b=df0us0TzwbSfOKuFcPBp0psujR2SPqsbXbo9wTi0nWHKX34Gos79DzRw0Ufuj9Exxm5I1FN9H3PD22r4lPG8lW03qKz6d3iL5n00HLmWYMAH10vOpPd1FsVYuo47usPLDTw/6/aohQM13XNGzXfZ6g9wtoUvckvKtcIaooElhUF/dHGyI/N0/4vovQhwvODCv2A/IwX26rHTLWn1LysybznaLyIN6dtbL+b7WBbsy4trEHpFlRvtJ3Dt8vdWKRtq9J9PXGe6xjAXj8tqJfM30fInUp/tDq8KvPBl0HTxYo1HpVEny55Pcu17lqLzZY76ZpPimew4YAa9Gl07aGryjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CktfTVVoPkpttZvxB9IPAzPcExPOO+bQ7xE8uOCksuc=;
 b=PMxmA8nqiCmqn7W7kYusR9HjdcH0jY66txom0l2t9AJpsAtT9G2n98Zt2QMecQXPtAQk+D5GUTzs+f66129AE67v+vTj/RR/w1GprLIhWusI8oNKAmmwBUvF7091o+GERMsrVETT7IYp5HOn1zQi7GKR2JdU4+9uxu0ZtLdcTzQ=
Received: from DM6PR13CA0026.namprd13.prod.outlook.com (2603:10b6:5:bc::39) by
 CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Sat, 30 Sep
 2023 04:07:59 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::e1) by DM6PR13CA0026.outlook.office365.com
 (2603:10b6:5:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.15 via Frontend
 Transport; Sat, 30 Sep 2023 04:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 30 Sep 2023 04:07:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 29 Sep 2023 23:07:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Drop unnecessary return statements
Date: Sat, 30 Sep 2023 09:37:36 +0530
Message-ID: <20230930040736.1153256-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d31e79-a8d7-43c6-455b-08dbc16ad548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9Y5OKFPFNeDmn01n2iZoeUMJfOmW0Gg085DgQCL1v9MOlvBJDiWGhJrkJeaGgdPXZ97aFA72sUawU5YTMhazhukjBFIMe78CdhI+IYqBuoOHVNXZFk9xikrO0Hai5D2vDhVAoWW64te1a2UevSpPng7ULNdIDqVF/f+HxKNlcHKQEshLqNNhOSns/2HA0UUnzyhv7SDBN9MuwhLhoXgBxlLb/IGpAGXPLl65VK/z+DllfCUgRRFskh+5woTttyDaX87TP+j9C7ODVSKy8I/D8Jai6aaS6Pm2/vthqdJIw/MLk+HgVnhmXxdkspeIJ7JhwofZtlx4QFFOEKU4JhY5kRDWUouFw6v2LVdFytEV/HekGBEfdocM/d7IRbcmsyPlq7CGa6AukW9zxlUim6wMhlfJ/UvEGILfjj0lohtSQmvxo68WudUKv7IzR/1M/eTSuu98M8b7oK4i7IHuJd//JywSSmElNJ0PHFhlTbF9hpGbzJByP5DrkD+o2kyzRlS4ZsKbKr6O5PGbHW1cWB1Qty56bXWI9Dok9HUhiDmE9Td70WTHxfJm8O4CO7SQWb+30gFR/0uo856G/rv+lyAftN8NYNn270lS47LeajoiUjjADuckYO0ICw3T0+e5WJn/DuliqgSxJx7FdwkCfe1y4ayJoeV1lHHZ1dX+3pI8C3s77j9D9bxWPetS9HqoHIlnm9dceqDb4k+iVH3QZ+4tnM+EatN3nsSPOyvvjsh6uKWF8lXJglIGgK/d3lkXZFcZawYKLVsvU3VjcDa0zwkzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(83380400001)(1076003)(36756003)(6666004)(2616005)(86362001)(7696005)(478600001)(16526019)(26005)(336012)(40480700001)(66574015)(426003)(47076005)(36860700001)(44832011)(6636002)(8936002)(54906003)(4326008)(5660300002)(8676002)(70586007)(316002)(70206006)(82740400003)(41300700001)(81166007)(356005)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 04:07:59.1253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d31e79-a8d7-43c6-455b-08dbc16ad548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no reason to call return at the end of function that
returns void.

Fixes the below:

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 1 -
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c        | 2 --
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c           | 4 ----
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c         | 4 ----
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c         | 3 ---
 drivers/gpu/drm/amd/amdgpu/nv.c                | 2 --
 drivers/gpu/drm/amd/amdgpu/soc21.c             | 2 --
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c          | 2 --
 9 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
index 3c988cc406e4..381101d2bf05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
@@ -112,7 +112,6 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
 	cur->remaining = size;
 	cur->node = NULL;
 	WARN_ON(res && start + size > res->size);
-	return;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index d95b2dc78063..3ee219aa2891 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -228,7 +228,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 register_acpi_backlight:
 	/* Try registering an ACPI video backlight device instead. */
 	acpi_video_register_backlight();
-	return;
 }
 
 void
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index e7ae37233234..065b2bd5f5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -746,8 +746,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 			 die_id);
 		break;
 	}
-
-	return;
 }
 
 void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index ec0c8f8b465a..d9ed7332d805 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -641,8 +641,6 @@ static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
 		if (def != data)
 			WREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL, data);
 	}
-
-	return;
 }
 
 static int ih_v6_0_set_clockgating_state(void *handle,
@@ -726,8 +724,6 @@ static void ih_v6_0_get_clockgating_state(void *handle, u64 *flags)
 
 	if (!RREG32_SOC15(OSSSYS, 0, regIH_CLK_CTRL))
 		*flags |= AMD_CG_SUPPORT_IH_CG;
-
-	return;
 }
 
 static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index bb1873363d75..e64b33115848 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -665,8 +665,6 @@ static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
 		if (def != data)
 			WREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL, data);
 	}
-
-	return;
 }
 
 static int navi10_ih_set_clockgating_state(void *handle,
@@ -691,8 +689,6 @@ static void navi10_ih_get_clockgating_state(void *handle, u64 *flags)
 
 	if (!RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL))
 		*flags |= AMD_CG_SUPPORT_IH_CG;
-
-	return;
 }
 
 static const struct amd_ip_funcs navi10_ih_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f85eec05d218..cc034a740605 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -173,8 +173,6 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 	default:
 		break;
 	}
-
-	return;
 }
 
 static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
@@ -556,7 +554,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
-	return;
 }
 
 static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0535cabe3b16..1995c7459f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1115,8 +1115,6 @@ static void nv_common_get_clockgating_state(void *handle, u64 *flags)
 	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	adev->smuio.funcs->get_clock_gating_state(adev, flags);
-
-	return;
 }
 
 static const struct amd_ip_funcs nv_common_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 92a80780ab72..6fcc4f7be117 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -885,8 +885,6 @@ static void soc21_common_get_clockgating_state(void *handle, u64 *flags)
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
 	adev->hdp.funcs->get_clock_gating_state(adev, flags);
-
-	return;
 }
 
 static const struct amd_ip_funcs soc21_common_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 96831f931423..88e17f5e20b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -877,8 +877,6 @@ static void vcn_v4_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
 		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
 	WREG32_SOC15(VCN, inst, regUVD_SUVD_CGC_CTRL, data);
-
-	return;
 }
 
 static void vcn_v4_0_enable_ras(struct amdgpu_device *adev, int inst_idx,
-- 
2.34.1

