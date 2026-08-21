Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413D8C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C310110F4E9;
	Fri, 21 Aug 2026 19:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hxLVsRBJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010028.outbound.protection.outlook.com
 [52.101.193.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D917010F4E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjRNdELz3BTrKc70v+A2UslkhuA8I1mlz/QjYRUwXkhH8WV8fG55vtNlLWMNGibh3HRP1z44HXfM906t0yhosbB4RuQACAVTFCv8ojtfLfIekAe5vIqqepg07onlmTLsLZIOEr2vexml2nAzTB1zC4tGDy6wsw6zy+7dcdmKFSHk6mlm8sEfYJ8yvcVHNaziXc47Ma4fs9Hf+8t2W3EXmx+vPZJ8y3p+3oONi7JEzQxyfuqPTTLQ2U4YK82gEFED5SOSVoB4ymVrxHbHmKhB4WWBtu3Wz0j8XqjyTIqouaN14TbGROQWTlCNh/dZoVFs8KZh329lpCmSiww7p9vgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAzTT25Pu+ClcetQV9+HIbZFhH532Sv3dX79HMa99Ls=;
 b=EYZpquckc8CVnH1CQzKwveYnkRvcTTFymfQcNxPE0lKq49CUXguNoikjveFKsColyuakPWubxECfSFjJL9x3QfHmYrDLZzS9CrITefwkJsrzVAunt52AVUNZ6h/O6tiRyUjyQ08kq13GWNIfgp4+teyiZ2suZlFTIID7omaID3BUSRF/PskjnKCpQLjbmL/PBhWdfAw3LdXUe+PvVolUcLc/U3QOgOOaNMAK7hMcIh3fh/a8JTLqXqvGouffq3/wM1DUlCz7eDQItX5mxTF24ibmkhFLpKisbTBIQIqOkC/gc0cLkc5ikwah6WnkGkyoaD5Qn1Wk/GgrMnKhf/YyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAzTT25Pu+ClcetQV9+HIbZFhH532Sv3dX79HMa99Ls=;
 b=hxLVsRBJG3AdxdkYgia5mOQ+gXoVAL+yERFSMqLXqs0Fa7+9aW+EB091IX4AohnfwSKe5h8VOmW4U3EsVzpHugXgM+D6Fw1mif+yurbPqw7ikvuG97mBNwI2GPURjtIFSyTBz/1CNR5xFNtgmP+Xigppy7ys/uhexpuz+fiPgM0=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:17 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::54) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/95] drm/amdgpu: Fetch asp ualink interface version
Date: Fri, 21 Aug 2026 15:33:25 -0400
Message-ID: <20260821193458.808626-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: c92fb4a8-85d6-40dc-ee56-08deffbb5397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b3vaPeFMa36MSj08W+icsObN1YmDo3LBquFDxk7ccmjMTo3KNntjH6KNxeAFI1DN4ji/4ml+Kmlnp0nh9NnTngyrPYwaDtWaPyC12damHiYhZgC6Ihl5iiwpSRlCZLMhpAIscWfAoJfopdCmYCI7p65LOSB7kCB1L4cnt5wpJ7ajT5uSKoc+0fA55jFeFRIKr00Qeyhfc4zl7WSU9DzwJJp42hK2RW/FSt/jRWOd413iFTowJf1OscHLqYAQj5fI7OA0rUhdw9SyQXKIB4ArzQ9G51jKtGBQrbipBX8a8Jd79A3YF3KLteKsD/9tuxKDj5zTNTeCDrGCBvt39xISpi0fpWUvQNn+VUwHfFoDZ11DZBJk24Zbe8xOyzGvQlnONxm1hXlBJsRi9S4Pqo1RdOfQepefdz22jOyR1DAQjDs6868c6so5F2T1Ptzx8kBrAR8efd7e47gT1zJT28lsfHFPjqiHR7VU9bLM6WEQ1vNxdv+2T0yfeFo8ff0LUKX6jKnd4ZbnSQlgPmuteWR+Qka++FNbKakQqeoHJ/SdhV7+WLTFR3o+m690aMbBXZLvGDWKqRt2esI1VJp4cUkq5+YlWd5OoMeu/mtODorD6MfyGWM7CsCsNmTux3yfS8jwsIAjMM68vOprxIevz3Nlk0b23vkk3ywM1B3zrXoRPMp/4WdomahOF8dOpG4Qw82MwYZlX6KAwBib5RgN+ce5mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tD8k3muJ7eLAcyMBcvd2h09GpaKSPc95Val+R+cN6nuDi13TFmb3IQ2P79cVhJWh+r6QJ51kviGqd83eWoETYq+tHGdm68rPK2G6c57WtDTYJMTRlGpu/+seAGY1+MTLJOEkmUvB2siQ90XlMhQElqoEAWpswFiGweSkG/77fpFrjMyX4Sz+Mjfz8213SVnWWFHwMR5Q8ic29I10ByHy1qZ/YeCAQl3jeT4Snkio6Jg5cfBxbOJaE8I/E49ETr73gF/0d1fYYK74VaPy141bDqACqmW03Ydc2p0hPerRRtwv4EqTgs4OPR2XfYoq8BrLyvN2Wq4fqNJr4EHduI6Ad5trmf7myNxsHADl7dEdYXJWzKs5/NGTbG2+Jx/GuP/f+17lU7LZ4bu3+1UaJOZkl2W/AUZ7z6s7U4g7xlHROGslswz3Znfa7wYoNOKsdKn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:15.9056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c92fb4a8-85d6-40dc-ee56-08deffbb5397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add interface to get ASP ualink interface version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0f6df5067e6e..5c82d1d808157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -827,6 +827,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "NPS_MODE_CHANGE";
 	case GFX_CMD_ID_PERF_HW:
 		return "PERF MONITORING HW";
+	case GFX_CMD_ID_UAL_GET_INTERFACE_VER:
+		return "UAL_GET_INTERFACE_VER";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1187,6 +1189,29 @@ static int psp_get_fw_reservation_info(struct psp_context *psp,
 	return 0;
 }
 
+int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_GET_INTERFACE_VER;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && !cmd->resp.status) {
+		*intf_ver = cmd->resp.uresp.get_intf_ver_ual.intf_ver;
+	} else if (!ret) {
+		pr_debug("ual_get_if_ver: PSP status %x\n", cmd->resp.status);
+		ret = -EINVAL;
+	}
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_update_fw_reservation(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 0aef9ee83bd0c..5968595647fef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -705,5 +705,6 @@ int amdgpu_psp_irq_mgr_register(
 	struct amdgpu_psp_irq_mgr *mgr,
 	const struct amdgpu_psp_irq_handler *handlers, int count,
 	const struct amdgpu_psp_irq_handler *default_handler);
+int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
 #endif
-- 
2.55.0

