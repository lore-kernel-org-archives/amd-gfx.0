Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC20606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c6w843l/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37516112879;
	Fri, 30 Oct 2026 14:51:34 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A23112879
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2sQ3qw+LYyh0B+04iyOP2lQ8hD6e1JH5pS+h9UBOnMYlevuTn5fXOwyVosmz95BQ9T8eJPUWWwZZDx9U00IQRTH8N64sCVux3M61RNqytIPPyKG5E6zPZuVzmjBfRMFOGdZ5cF14wfjJrMFZiMOlyhGCQ+jS1EA+X1DJpjDb/Tv61UVF0Okrd60q4taiaS6nX2ayhwREqhWmqjZnCuR/SmA2AbnnQuHt5OyC5hNzg5taYedWt4j/Ads0SbezhSp7cBy0nMSLtAydb89saqhsyMxv8bXvXTh03tQLg60+3bXk5BUuQrr3B1klQC54aD+qxUoy2Td56AH0PrajEuUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+LSUX7e0ozeBXmt+N8R1zKhVhFSDXlo8XMvB8Z2Ek0=;
 b=AU0sNELXFPGdsUnq0cGtDdrJKsWeIVmi31OVJP69+4ob9dRqwFZ/guHgoTvzbYP/qF0gSWr67XISpNK20boG6P7vmgYS7H3haVySkNI3RLplPN/2Tzsib24BsmOOihSpOTzwtegZmkONm4fVttY3Yuh17S6Ayq5ERIbygwQTz5TEFX5KZdJO4mG9k4JdIOG4GIUfTabsS/23HY7RmXCgeWl40GcUo7COA2dfL29l5e59JrNhEKTNfjiwPEPaf7XQt86P4NpyvBfubVCiamek/3VEjiAPdvMbDeCIVBRfcfDgKVVOW75Z7uOU4UQKaLOzRjNYr7x7QLWh5PvnLBzD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+LSUX7e0ozeBXmt+N8R1zKhVhFSDXlo8XMvB8Z2Ek0=;
 b=c6w843l/e8IS+UTsAOA5LpBSzOQzddXIvwHuQ2aAa3QpaRt+dLJ5dpdB1tz1xqaBnfBgB++3GfcJ5A9E8v8nDwG7G6qPlHIluSYLuarK6iX+Xt247IFhumuy6XBCUZruDfOZn8bV/hF75NPMOvoZniFk4o8QXhHKao1C1I94vu8=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:51:22 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::7) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 14:51:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:51:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:51:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:51:21 -0500
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 30 Oct 2026 09:51:20 -0500
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Fri, 30 Oct 2026 15:50:56 +0100
Message-ID: <20261030145056.518748-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030145056.518748-1-Dejan.Andjelkovic@amd.com>
References: <20261030145056.518748-1-Dejan.Andjelkovic@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: e31686db-53b4-4109-105e-08df369543b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|22082099003|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: hJcf/8Lx4s5pNHFMf8LekOpeNvys7yLvlc8igEf0G9LaqMP4OGg+EfPgxi9p9CpsBXjpV+xyY12sfR2yFfZr6GlTqzoG+g8Mxtpe+H7qgxGMW3+agYPJLuqy6bIeNfKsbtYPvXt3bfJvHae2A84q5Nm7impx+6rue36oohOXADLC5j801yLTqkYrqjk4+xzq5IyC5mnBfFdz7WxS2XxTNsh/8NNXzz9j7LQONtg4shgtzciFPJNswV4krDM2CWuWXaQuss7q/42ZaoflQFb2l2JouKp65OB2JpkXdYtuoSMgy2dYKZvPU/6nAB0f0KJJjrbaYRv8OOcURdYSqL3iNLxamQYSXhd/7IVmwi+lN3J82jZn71Ikw5c9gXtxiEh7/tnMeWE6ow4WbEVHJ66+Uq4wzpiHGae+8GrYrj9KJcvlGAs7sxjHILoeOKNy8ooGH1yrprhEuexDPHyKI0AR8I/qjcxzNpOtv/pcRil6j9Bx9j5dpU96CcNMb/MNKS7QywgX8hSPVNT2NzpbokCxC6hHOxcAesEh887M8jiMawpVXpWunMbq4sveUmqzc9WbzCFibbVCH2Ur8v1BTYO640wGnul/pYrEfOA1DY6CL0Yi94BD874aYtlfJaGgmfStjmGvLDYCn0e1/5sbExLd6EILB+ZmXWf2/d/BeS8nBJMhT08G3eo2IlZfauNUsWf2wxlhozq5KVAu4ftOz7Pg4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O8eNDmgt7H90Ph88XLhRc7AlNXl+RG16tH8+5pcH4tmZdyKeY2aI1HQo6t6uSWE3oyiyYOg+B0afUltN+8qkMH/PGVE3HXMGv+31a2ujBeL+ma/xhTPsjEc0jxN3DYqLbVSO43nESB5Z4pPm1Awb1wxjWvXK3AAhpU6hyc8h3FiqdngEfwz/IzhMtdXUO13i8N2lhh6dDWva0atLfrkqWJ1Xx8GnQHAdXFrthBwAIO+8Y/IWTCl7VylWVLZeENPU+kRl8Acqd3Dpk9aC0CRucy36NQSKBlopqtE/oxvSzALDeloXOt6zR8/L99I4dDRVLbqyvJvKlwPPuUlzYRmwsUm9Tr3nUjVMMrPeLgU3aqeJn9WeTDkGoemtlNF8GUx2klglova9Dq2Tj5dQ9LvZMnMOz99vH4YxYInj3FyCQqft+jWLhY0GePy3Qssk71qB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:51:22.3197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e31686db-53b4-4109-105e-08df369543b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 047034cf7d20..9d6f580ab64c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -456,6 +456,19 @@ static int amdgpu_discovery_read_binary_from_psp_mailbox(struct amdgpu_device *a
 	return ret;
 }
 
+static int amdgpu_discovery_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = amdgpu_discovery_wait_psp_gfx_ctrl_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
+
+	return ret;
+}
+
 #define IP_DISCOVERY_V2		2
 #define IP_DISCOVERY_V4		4
 
@@ -818,6 +831,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 								GFX_CTRL_ADDR_TYPE_GUEST_PHY_ADDR);
 		if (r)
 			goto out;
+		r = amdgpu_discovery_disable_fb_carveout(adev);
 	} else if (fw_name != NULL) {
 		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
 		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
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

