Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E84C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A2C10F6E6;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gg0VdZvw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D175010F6F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4cioPXkTu5rMxoA/yOAX1u9HFFbF3/+ra/6DkeNgMrpha71EnN+xjOVYmZqOH1u7HtsRM4AcaJJD0ziGc5rhVVPoFZcwFi5gaW0sHKRu88ow42+ZVvnl8wEw842YuP/zroafyTRKhKpqEMlqy92tPx1uyJq4yX+Luyis/C/uLuDD8zhecYoe+iOMyAT+u02KBnKcFihul0nj0cN1UbVP4/zAJZVKmjhHygtS+ZRQKrnat3B2nqYdXJ3/HBo78RCMSeq87ps+nHGD5HdJmwn8zxdazN8xxqYrQKHRViGOYd23W/Ibdj7sRYUxrZVnd34NjtOt7lTjSiedl18aAhRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbk6sWrxn9wxmbpJj88cbUgEAy6Osd0iGy7MtiIRzOM=;
 b=PjBdmQ14XBgS8dkqD2fNwR11nLUa6aWLlTMaU88Oqcu9ESUyS3HY43p3FRK4JeiybVyggN5vAvIdjR1Hx/ZOe0swz1qNrUjiQz1awbQDFpgMmC7i/xNOHSGqUCqlaEt/KpSbkdgTJEaB756Rek1cJpUucRjJhdMJ0HYGTISbSrjLusSZ4ZcuPGampdwueKE2tS72zUhyj8Ljjo0WOoZ9OlyiMRTGXgLwoXCnYZO0i4z36/P5cuArbaBBV20YSFTsQB7aj/Bc4OfQw8NCGW38x6FBoSwaEr7z7BMEyKMvFw9LKqwTRqR3chNXJoas9A5dzl2mmeVJeu2rf7NdCp3rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbk6sWrxn9wxmbpJj88cbUgEAy6Osd0iGy7MtiIRzOM=;
 b=gg0VdZvwfXIwg/Jtqv+t7ofk43/DXjfAn9038frUaXSm7Wdii1OlJNtDa2oPMQ1vHOhN1Ndb/cRv4i4P0SS81V7voaklVqlH7iN0FA5VBmdkZp/MxSVgD4pKQcuC+duYCbUeXqagDXZbsfSCIIk7+hmGDOP4wrwYpdEGQWFdJTs=
Received: from CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::6) by
 LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:20 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::7e) by CH0P220CA0008.outlook.office365.com
 (2603:10b6:610:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 030/109] drm/amdgpu: load standalone RL firmware on psp v15_0_8
Date: Fri, 14 Aug 2026 17:01:27 -0400
Message-ID: <20260814210246.3067612-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: d81692a7-8a76-43cd-122e-08defa47788b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ph6o8qbxoXr11hFdoOI9yfLhTyXHhzEBmvbTQyY7XoRJUl6+AI+x3nqbOFqCivSr2t91TO3nBz5CzxxJQwDrMxYHdIXtUV1CBrANGMu6Xj/vJ6eD1lB6TBNtzOGB+IyckB68T10/DGdaa2yDWakxH79Wj7sS/gU2PKNyXN3UXt4cOSVIk55VnUeL5/dhkHBmJ2fXxCBXk5URlG6FIULZFFLbDl/Or2q/H3qhkTzCsC4xzJQ5ci4A//hmBgizxIP8ENh9xr5PhXll0vWtKdLInhPPZnFscEW1EUKEevzyyuVCSf9wmV6AupxtWzsZFoXj4C6FFw8dDpjNWWMmNJgNCTrbp3uHBiFaXvfmXB8zvj6DOzGQmlL0hCLP2r1Z0fF1uZmAKeFAWefPVl64EaEqOLTJL984t1s480ZxKtpmJEH3GLB5Wks7eUEiaijyeOGsU32Ou6Aq05ZvrK6v7ScttOp4Q5PqjSUKmLmOUO1iyBzWGmlA1Wp5oneove7MwWZwLlFxCIUv+CWHh4GbLW3PiqrPtcU9Evo6PQJW6X7VU+4TPHSSB5cCO7cQ7TgXHVUoABlcyXezyVj666qOIcvYM9uVu1KBUIAeB2KRDTuL60nVuHbXNjdml35iVS8KGv968MP+hNM6p4f7A8R7UcLp+MnAKFP0E0CLCL1S+L4QiGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: akdk7sm5tdSic/xcUPWULIXQGkQrgd0gUAmaKoJtk41f/b5aViyElrME3masOOXdB81dH6Dn5FNyGmnFXmhq3KiVDMsmnmMW+kqVANAi5k702v9UDChRnwXMfslOrxFixwcN88JzQMQywfrJLAb4WM/UHgGY3XoX23KorP6FAJRM3V6KtL0dUtTQiDps/qT5/C5xDAzkcJ8oyUNmxttczmHjbY++X8Hp2AxuCcAaUz3zeDkMiQwnGszcyvdG2IjrkeKNTkGWxwLGyVz99sATq8dDnLNVU6rw7E8MjqeQZ7UY9NxXdJkEDavvwvoUsmAq6ODv2rVq52CaQv38UdRlErnO7fq8NLhGt39ZS4OUBmLM+ri3zj4UjCafxuPMTzooiclGD78XJJFI1oDZu7NpMeHkS2w3KGunW0DQX4dlbPQ44OIN88x4wLMrvcw9/iE/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:20.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81692a7-8a76-43cd-122e-08defa47788b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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

From: Candice Li <candice.li@amd.com>

Add psp_init_rl_microcode() to request amdgpu/%s_rl.bin and populate
psp->rl using the existing v1.0 PSP firmware header parsing.

Wire it up for psp v15_0_8.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d7d6623b51da6..2a0ab763f59ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4025,6 +4025,26 @@ int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 	return err;
 }
 
+int psp_init_rl_microcode(struct psp_context *psp, const char *chip_name)
+{
+	int err;
+
+	err = amdgpu_ucode_request(psp->adev, &psp->rl_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_rl.bin", chip_name);
+	if (err)
+		goto out;
+
+	err = parse_psp_v1_bin_descriptor(&psp->rl,
+		    (const struct psp_firmware_header_v1_0 *)psp->rl_fw->data);
+	if (err)
+		goto out;
+
+	return 0;
+out:
+	amdgpu_ucode_release(&psp->rl_fw);
+	return err;
+}
+
 static int parse_psp_v2_bin_descriptor(struct psp_context *psp,
 				   const struct psp_fw_bin_desc *desc,
 				   const struct psp_firmware_header_v2_0 *sos_hdr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4047706c1ce22..ea3658e2be6dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -425,6 +425,9 @@ struct psp_context {
 	/* cap firmware */
 	const struct firmware		*cap_fw;
 
+	/* rl firmware */
+	const struct firmware		*rl_fw;
+
 	/* fence buffer */
 	struct amdgpu_bo		*fence_buf_bo;
 	uint64_t			fence_buf_mc_addr;
@@ -656,5 +659,6 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type);
 int psp_set_mmhub_eco_sec_level(struct amdgpu_device *adev);
+int psp_init_rl_microcode(struct psp_context *psp, const char *chip_name);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
index ec20cd5eb7552..57a079e3f356e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c
@@ -33,6 +33,7 @@
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_8_toc_1.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_8_rl.bin");
 
 static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 {
@@ -46,6 +47,10 @@ static int psp_v15_0_8_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_rl_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.55.0

