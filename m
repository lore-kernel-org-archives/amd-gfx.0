Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7754606A329
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eKBj/bvZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2374710F61E;
	Tue,  3 Nov 2026 14:44:26 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473B510F61E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3KBbrjtQVipBBF6DPu9z6o3UgVdasW4mAgjlvuiNtppvu6jw11MNeIJwEk9+/PAi6FLvJT/MJGXCDFrU64B2IGCNM+BJFk+jv661jGeQJCVwE5nvyeBi3ojR2BCSd3zJ8jud9yOhlqMvkT4dR8You/1dsLUSh3myO5JjUfNVJX2ugSIq4JE6kuY6aWvrBQSkz98Of4kpPXTj4kWMaKAD6vxx2vpz7xggKpco2yUUIDHsfuVU2HtP955a79rdAS2sgSnmFE/2YTCIOzJFiS08C8DYfpe8WuVFMIfYvhdvCkHlWsSFqavtb9GKT3v7QGB81gpu2mvBntOBq+jxM+4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBlVFoO7AmfvN52CFb/wWEZh7n8hysNbBRz3l0P+GHA=;
 b=b+hzyR/mWs0m7g02TgI+3sSlcIvm1N1S2iGPF8JjwS2IDOUud81uGLfa4SV1gYf8y4x6grTqISZ/833WvNDPblO4BWoWO7P2rcpRM9AsMu8K5k32l4IRhZvl2nPDji2lnxBwpvXAkc8UGbjVznqmJI2h61Q3um6VaHG072J9ke0f8tcr3nQeFo89hyWVzt69baQWmmUt6+uYlAQthMEl/oEjtqpVeW4qvvDmPsiUGq6XcpOlKoHjjC8Yn3tn83hCLgV9+IgQL/P1c+yoth3wIbvIC5R7pqqyrGrMujdCDULg+qDAWbWVmNDlOq4A7CthWl5C1vVh9Gb3Bb6AGMSLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBlVFoO7AmfvN52CFb/wWEZh7n8hysNbBRz3l0P+GHA=;
 b=eKBj/bvZpmKpZa4D3+yEp+lUfBRqvb4WcxGMY5qZ2xCW0+EVnxvgN+Ye4xe3KSTq9uChypjErlfV2vY10OvmLbESe82/9W5d2s35zzHxnsmgSJ0YxYW98h4YIfHf9+X0xbexBhkrBgef601oEFTZrpWQcKIugfH8/moI4JkoTRk=
Received: from LV3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::20)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:44:12 +0000
Received: from BN3PEPF00022BDA.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::b) by LV3P220CA0024.outlook.office365.com
 (2603:10b6:408:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 14:44:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BDA.mail.protection.outlook.com (10.167.248.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 14:44:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:44:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:44:08 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Tue, 3 Nov 2026 08:44:07 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Tue, 3 Nov 2026 15:44:01 +0100
Message-ID: <20261103144401.298613-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103144401.298613-1-Dejan.Andjelkovic@amd.com>
References: <20261103144401.298613-1-Dejan.Andjelkovic@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDA:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: e0317b82-a403-4c45-0523-08df39b8eca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: Oc9IQ2bHKslqjYZ98idBVyNRi48p7dhLduIvPfSgOLCbiWZ00w3rFWxBF2TetbxUg2WJitp4D7WyXGTOYuSzUxxX3cW2H2DglFcMkTHu2OdRq/PVhfCmoZDIZ8MeJ8c4jEcFsyNpKOe28uSnUAomdE0abp580UiRuaEkHlqpsKMdZyDr9O38C+H7WcMFfS0NJdoUFwvNXC4nr3IXbaQX0Ny15GZdK3E0Qgyt2m7/D6/uQlkVXnfMuFQHFyFa+vnPkbm75p7lge9wOaeooxeY9fkK3aPP7u5JWu0gkl5mDxVIGyytnnQkOZYGG0enh4eEhCmsxuOIb+efKiyYYzQuszddtUBPJsvMIYonChmpjyyMS5OiLfhZgLZaAARKVddgeC1vkRfhPS92IOTmOZugpbwqqU0+0QuVZPLI4r0v0dTF5DF1tToyeEfH3sGVjErAZ4ov3Cm+LBodtP4ruqKeYlpOXhb+tvjo9QFgBQSVtnouf6bn/xsg/y3ZaW6JXV++d+D0OXPWDCIShvdms2KtcL+OAukHdbNEKHlnnBnkvD4uOpdz5bzD9ClTa8cO9OqIE01XFZDPzhRfUe8Sf7zxuMY4DWMDM9CihaeIvfuLnjBQ1ZYktnd+ePe/tr6qN/W1FvRX7jIsobwr5hWDNfnt36ZFoDiJJ6dtoAIYoLXHzEo+1ZRTbEyelN8YU+spKdcwu9Gg54kiFi2CiarPejEm9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3FYV+NfNvFRCiKk/670Oc4RBqLVpe9uR6AO69/y+7nPbFnXD/+njvCbKiDXtIVVfiNTEa9lJkDuN8xjsilRuWLNU2T0OEPJTeX/geHuXUX/Y03aMoRXkS0rgZ/FocthfQGuC5GFtvrmLi2w8Py6nC4IcAxrNS5UbRVcnLTfo7aUbfwikfZyFxQA3zVexbanpWGRuGk6bX2HndNzXqILB3axtBe3ISCvcONLojJhBHZOUYWVFZj5eKJYgfQEMBVB9WS2AfYWLlt6BHw8yFWcVRD0aSjz5M5np2Y88YU5Dng474bXbs1vG1k+/TtiDh+U/a7/Gj8RSNVHF2pO7hZ2dtZ6ckFfZ7+j4pCflQkUjQQqdyUcuiFCc1GFfUP5ZglyJWVd6BhVla7ITPMw6gBg/t7v4VjCjJzBQjfqk0rrmI2aBjIRfeZ47rkhPuqWmqpvd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:44:11.6335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0317b82-a403-4c45-0523-08df39b8eca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BDA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

Adds support to disable FB carveout via PSP mailbox for passthrough A+A.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
v3: Carveout disable moved to amdgpu_psp, and now called in device_ip_early_init
after successful discovery as suggested by Lijo.Lazar@amd.com.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef01d280cd0d..4088b8f0472b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2055,6 +2055,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			adev->num_ip_blocks = 0;
 			return r;
 		}
+		if (amdgpu_is_spm_passthrough(adev)) {
+			r = amdgpu_psp_disable_fb_carveout(adev);
+			if (r)
+				return r;
+		}
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b1492f8d5d92..a3869bf0c4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3400,6 +3400,19 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 	return ret;
 }
 
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = amdgpu_psp_mbx_wait_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
+
+	return ret;
+}
+
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 {
 	struct psp_context *psp = &adev->psp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3ca2fe9ce94d..ec7cbcaa5c35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -690,6 +690,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 			 GFX_CTRL_ADDR_TYPE addr_type);
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev);
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index e0713e27556f..664c885a8cf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -50,6 +50,8 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
     GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
+    GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT = 0x00100000,   /**< message runtime VBL to disable FB carveout */
+    GFX_CTRL_CMD_ID_ENABLE_FB_CARVEOUT  = 0x00110000,   /**< message runtime VBL to enable FB carveout */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
 };
-- 
2.43.0

