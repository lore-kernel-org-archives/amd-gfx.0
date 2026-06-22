Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CC5CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC3B10E462;
	Mon, 22 Jun 2026 04:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkRDpRov";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9393610E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySFnMAhpBZcye2/SFfTOpPwx4RSfsB2k7QubVGqBIaozU2f6PmkaxtZ1ukDUQmurvQfZRJn/I+TNMWET32K/TYkTGM6TS2qz2WjiRZfg0DNUtUmQ5g3tbPm90AFT4ByksEyOWufU03/jeUGkiCLY82RgWNb+/fUJzVnQ4f6KwzabJcSqG4KD/vufl9ddBAnfzV1t0LwmaW7dqJMjhfI8DkLHeEpByUseOPJ57nhw3q5B+TY8tsfu2th+PDfz1nwRTUBQyosc/yZ5/q5N3FFj8bt1vxi6+s1IIORvo3XUXm5eSNj2kuOeeKSXbIu9gQECTXVPdhAf2CVnSLo4lkmivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=yWBsKVnTuwed1oLUejMZWun37LDKvrREJBUqdHa/a+YOOFbdpn9IQemRdUBvoxTdSh32yazYPwpDW31A4IqdHbBbqJ6Qe5+yP63PLiN5jyigL9C4mkA4rJzzn2pE/arLNnK7T5M+leS39zsI5YrF9Aj4ohEtMKnJebRdlA0igO5/lOqOBVXU4FDQxH+QRB61Kxbfizmz2s5YOHAL6GO4txMA/gBXkrvF0lVhvqrxqJzA83VFCTrjRhUFx1iji5dOo98meVBiB2EvA36B6Te1lBKE4UMqBBe3gKzuMtnDLOyDOAgEHcdKig8J4Am9OGlu2faWGw3/Mu7JJbcMAgTbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=CkRDpRovlRcFczkVKmFAZZ+wbhihmveI1zy2iWFjwgMojh1K2vAE8sTfXT+4l/6/lfnf7UTjqxMvl9WY/7NmgMdcYCtsTX3gFIc5FcjJzdbERFiOlu+LcEVb+w9ik9JKAKNM+Y1xJD89aYPLi3srGWhdnJB2q7D7+T4rn57y/FU=
Received: from IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::9)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:17 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::27) by IA4P220CA0005.outlook.office365.com
 (2603:10b6:208:558::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:16 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 07/48] drm/amdgpu: retire xgmi v6.4.0 ACA support
Date: Mon, 22 Jun 2026 12:39:56 +0800
Message-ID: <920bb4ba7f4ea695e7ca418828af9a1ced6e7c36.1782103073.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0473dd8d-965f-4d97-0955-08ded018a309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 92xAGYXe9WMcjjMIGQfI8w8QEsWTByiE4iBNEi+/f2iIxIYkBiMMjL+q+zQpa2NweZNKSWld1ilTO1rr57jE1wGVR2sQQhP/JfpHjGGGsnuSSzRV2Pr6FHPUTXNCu5KzFcEY1jhbZzKjCBT8s03Yi/yXGW4KMsJ9mpVO6kQkEMbcumnB2noQGhTETunQUChbTX+166pIDR8qEy860e/PNqhC3ASOPHje1CacYo0LJsp03RiCk0UTuERdqOigzENgCQF7PUOt/5WNdxxNUr3MMjQq8Yza4Yle0vMU/ryAr8PlLNIBFKD7lZu3V2mMQGoCKZ7uz/87ADVbYg4xIcoSES6QIYfKbMR2UPSq/Vi59YaRnhU9w3BZpxLHybrPng0XjQ7i/MtqFJC4OfsRvdfgnenZZnqYbpMcvWVOND8T0Fvf44uoiWZ+fzrGdzwdUACehVuVAbIoXQx6K0N7EhHoTrsmK59Ew/O7AsVxYnARRVXs/XmX2mZ6rK/Eixji8IbPyGPF0Nc+dNBzfmfSozCoLNdHohd8mqXSI851e/F1z+vxUmLZhTfUYwHllJhrEIhKch5NppQMNpdg/6DpcDLv5Utawh+SbrjphOPe52G2W2iPU+L350gtef8G/1JF6wz0VF0xrUk+bFfjwfYifjN0YV1eqZ3nvu5WeMKIeUNNE1ysFFT3/FiIPJXFDzpSxEeFqE8HhxT15Z6CR1/aB2BjZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ltYAUuz3nAVoI8T/4QdILDuFUvWYa3d5fpPOXvxjwMjK9lhPDf8RWZZrOCNQaVgwcQY6UQ6XVXo0dxaI+E+o+D2PEc2aWMJtx3ZtybDndrVtT2hWXG9UwYCSHAwaEDlc84MskSkoaJBMHv9uTmHAseU/XsjE3NP/P4/72mHt8ssoc0wTbGgAbfTuWC3N1t8nNnjfYIKBDOItIjam4Kp7uTi20ptM9h6iKn58FsLiQXlqShApRAmRJbj9e8NLRpSnIDY5uGUnXCKf3dnFxWZLRmT58Ei3QNEzRDQq0NgwPX6ZcjQG06KAwczpQ412HSZ2yrOFgztlMJRGcaIGGr2SAE4rGv3X3BKOZAr6WUHuCi9pjlufHX6nldR4H70WBpE2W2C7IzNa+JHi5vbBXnIhHYVWbOkOYIfvnKLXN7dPgeO6mbFVMakhz5CwdIWAhu/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:16.5838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0473dd8d-965f-4d97-0955-08ded018a309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

retire xgmi v6.4.0 ACA support

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 78 +-----------------------
 1 file changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index faac80a8a6eb..5e9012545102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1152,91 +1152,15 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				       enum aca_smu_type type, void *data)
-{
-	struct amdgpu_device *adev = handle->adev;
-	struct aca_bank_info info;
-	const char *error_str;
-	u64 status, count;
-	int ret, ext_error_code;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	status = bank->regs[ACA_REG_IDX_STATUS];
-	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-
-	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
-		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
-	if (error_str)
-		dev_info(adev->dev, "%s detected\n", error_str);
-
-	count = ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]);
-
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		if (ext_error_code != 0 && ext_error_code != 1 && ext_error_code != 9)
-			count = 0ULL;
-
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, count);
-		break;
-	case ACA_SMU_TYPE_CE:
-		count = ext_error_code == 6 ? count : 0ULL;
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, count);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static const struct aca_bank_ops xgmi_v6_4_0_aca_bank_ops = {
-	.aca_bank_parser = xgmi_v6_4_0_aca_bank_parser,
-};
-
-static const struct aca_info xgmi_v6_4_0_aca_info = {
-	.hwip = ACA_HWIP_TYPE_PCS_XGMI,
-	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
-	.bank_ops = &xgmi_v6_4_0_aca_bank_ops,
-};
-
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
-	int r;
-
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
 	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL,
-					&xgmi_v6_4_0_aca_info, NULL);
-		if (r)
-			goto late_fini;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, ras_block);
 }
 
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
-- 
2.34.1

