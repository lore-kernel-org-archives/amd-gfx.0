Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EDBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575F810E86B;
	Thu, 28 Apr 2022 21:30:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4997D10E943
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfaR0CRhTTxoM5vyIEFkMhAt/muoj2nS/hAy8IQUKkEx/ZFyP56avfZn/kbyz756NCCx1wN2QQ2QCd74RZqv8tHweaZl8FGQjInGWxeWw/r2d6OdkVEqqs1JtK6cXKJj4Z6cmx2HtT0NA3q2fr+GTZipFPKPErO5+zkyp4gYgf3RqDScJrYxFrJjp6SZlDyDMcKkNYML99L4vtItKjPAfr6ivrVW6y8hM7rNPfN4MTcn4LKfh2jvk6DBIPMBSdB5qVDzYThtJN1Z60ZGJlMsteRphaJEjI3vbLz+FYi6NjGIhcHoSHT961CeiSXWpU4Nu+xbwd576NEh42h8PWqBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JloZbXfA/Vez8etpkqUi0Q7Qfb5Grl5jjU+dNQNXQo=;
 b=PhEDsUuZzK7PQw6uHL8a+Mnbs8erX6TaECcecCXtb13ZFk9bWkMSaL+pEc7zMHKpNsgyzjfi9aoZvMi1hzei9FD7G4mG+jGJUav9beOVyyKat2cxdaaOSxskOVKG/KVBjl1rnKPkN89D7f52TqJE6gZIs7xXtDW6L03QVSwr/YkN4IZJgKOYSVJsX+t6JXEjbF7w1VK7x6JJMbsTTku8hFFCFFBghTUpfvB6Eeo1Vel+LhY8LbATU4twjY3KyqA60osAA9ajKicZ2NNc2Xj2P14LEYFRzE64GnYbTj1lzFD/T0KAbx+Sb6wKoRyXKD1G4y7N9DD8ssAWHUs8IR7bPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JloZbXfA/Vez8etpkqUi0Q7Qfb5Grl5jjU+dNQNXQo=;
 b=MELlkoVn+ZyLJXlUkvo4qeZ2EGAgfo1SCEU526f37POZb+TWRLdjNg6YbD+j04VVtmfGzex290JZlt4UW8r8KP2A+H6thlBT/patiAycPKkYQSzkWN7Hzmj12xbOw0tM+EGpX/bmsN15lez1b0RK9HOrtBCM7DewmgZ6FpVdejw=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by BYAPR12MB2648.namprd12.prod.outlook.com (2603:10b6:a03:69::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 21:30:06 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::be) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable pptable ucode loading
Date: Thu, 28 Apr 2022 17:29:43 -0400
Message-ID: <20220428212946.700296-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a6a145-a00c-4730-96f8-08da295e436a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2648:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26485B114875168316342A12F7FD9@BYAPR12MB2648.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTdwNR9TyhX8I+3oPKHxuWmLwfKSCOYYFLhGj/uvMTGwOzf28p8zmX0jlk0QUTuRrjnQx+PZlVPzPSg6F1IMFgjiedpY84nqjQ+MzqLU/mnxn+PFXyLe7SED2LEjfQJ8J9iyrLCmEokOMtERZotw3ZbYe8plCrcu3yOtibU0rSuNmt2P5dZqBS3EQnQ0fy1T1bMYFSaVEMEmwjL6W0rNpnAyuxXg0RSrDWJgBbe6rv7bGdluqv3k0cEVEhhTmv4cdkp39IXJoGm5TPtFi0Wm5w5q+9uVGHEc19j/TWEuNp2QHpVEYry980K4OVrx1V9bjx9OBjL/ntSoZK1VzwvO0MCmAH8Okzvg0BRmxlWn2MNsEDnvGhRcjLP5yG6J8LGXCvzTgl3+hGv9W3xQf+GvP3/Gfqk0it7NbwTAvDwRdJRYTg/cUA89ocFvyu4nxQ14jWXYKNYoxBkG51xoQjn0YoXuGtr21JcHYdwMkoHM6wXDUOjtJAO/40QidULs1Q161DXDCU4EVEsIEDVqH8Pc0cFxVF3zOKNW/u1mky18f8uuH4NigTUmpPQcLQ5qkB2r9JyxjVB86Tjpi1u6k7PgxQHm8WVyYpubdeQAHs3yYjoCHT2rbSXC9dXzVoBsrwn7/HpsIV5BAHj++X6icM+SrFUXEXdama0/3Sv8xKYl8pFCZ8eibzZDMUZror45oEauWxEnsJlIvRk3xApGJrQZbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(47076005)(356005)(83380400001)(36860700001)(8676002)(4326008)(2616005)(86362001)(70586007)(81166007)(70206006)(2906002)(6916009)(54906003)(36756003)(316002)(40460700003)(6666004)(426003)(26005)(336012)(82310400005)(7696005)(508600001)(8936002)(1076003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:05.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a6a145-a00c-4730-96f8-08da295e436a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2648
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

With SCPM enabled, pptable cannot be uploaded to SMU directly.
The transferring has to be via PSP.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   | 1 +
 6 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 890259d4414a..aabb208bebde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2232,6 +2232,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_SMC:
 		*type = GFX_FW_TYPE_SMU;
 		break;
+	case AMDGPU_UCODE_ID_PPTABLE:
+		*type = GFX_FW_TYPE_PPTABLE;
+		break;
 	case AMDGPU_UCODE_ID_UVD:
 		*type = GFX_FW_TYPE_UVD;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index c909446c3a96..6218bd62d172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -543,6 +543,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "STORAGE";
 	case AMDGPU_UCODE_ID_SMC:
 		return "SMC";
+	case AMDGPU_UCODE_ID_PPTABLE:
+		return "PPTABLE";
 	case AMDGPU_UCODE_ID_UVD:
 		return "UVD";
 	case AMDGPU_UCODE_ID_UVD1:
@@ -720,6 +722,10 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(header->ucode_array_offset_bytes);
 			break;
+		case AMDGPU_UCODE_ID_PPTABLE:
+			ucode->ucode_size = ucode->fw->size;
+			ucode_addr = (u8 *)ucode->fw->data;
+			break;
 		default:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 864984d0d3ef..1c2d1f9bf418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -369,6 +369,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_STORAGE,
 	AMDGPU_UCODE_ID_SMC,
+	AMDGPU_UCODE_ID_PPTABLE,
 	AMDGPU_UCODE_ID_UVD,
 	AMDGPU_UCODE_ID_UVD1,
 	AMDGPU_UCODE_ID_VCE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5dd97eac0e99..2513b1af76d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1027,6 +1027,12 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
+	ret = smu_init_pptable_microcode(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup pptable firmware!\n");
+		return ret;
+	}
+
 	ret = smu_register_irq_handler(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to register smc irq handler!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 46e34ed8a3c8..491357321020 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -27,6 +27,7 @@
 #include "dm_pp_interface.h"
 #include "dm_pp_smu.h"
 #include "smu_types.h"
+#include "linux/firmware.h"
 
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
@@ -557,6 +558,8 @@ struct smu_context
 	struct smu_user_dpm_profile user_dpm_profile;
 
 	struct stb_context stb_context;
+
+	struct firmware pptable_firmware;
 };
 
 struct i2c_adapter;
@@ -1298,6 +1301,11 @@ struct pptable_funcs {
 	 *										of SMUBUS table.
 	 */
 	int (*send_hbm_bad_channel_flag)(struct smu_context *smu, uint32_t size);
+
+	/**
+	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
+	 */
+	int (*init_pptable_microcode)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 5f21ead860f9..7469bbfce1fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -93,6 +93,7 @@
 #define smu_set_fine_grain_gfx_freq_parameters(smu)					smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
+#define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
 
 #endif
 #endif
-- 
2.35.1

