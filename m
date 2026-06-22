Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A6ACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE76110E460;
	Mon, 22 Jun 2026 04:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8pXUNgw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED9710E45F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN29yKJ9tNd0jtD1f4CJlDAM9urs+UMeCQUruAnfPjBKxzcgdX4t1aQjmIiMX7Wu49OedmL/Mye5q0/PAhcUaVe/mgscCJI3h1AaW63akx/7vxYPlxhrfadp9UH0C7Dhs+3g5VpUJR4NqvXaemtB62St6nJr61ljrfECuStz/ZlO5fK4icIc/p50Sj4gP3v8VYvVlbmufDXSdMJMI/oql8hCnE8QbwD9Z0RZXN3nOwucHHN6g0Uii0fgaIU9Ph+q7P8/9HKCMaAdJUt9hW2MJvNIxFW8zLdhcCR4jjGfaWUP8XCKvN674kBlugbLggOiGPiZa5sSstyVukvGvFsz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwgalVNfFeT9KdTD+uzm/EFxatUa/fQXPo8JVl3LLFM=;
 b=MVY0MdjgoDxwfncBxs2oPT1+1Az9mdVJMMLpY1W0Moems46nDqrr0NdvUElbODXDnEYENixOcPdy+zswJAm0jji4tn96G/2SPdMD9Vkx+M0yqbY7/VhQBfU7XYHnpQEQRZd+9hH3clCIRcM6ZGqmg55shKaSGi0sNhHqI+2fQ1461svlzjnPEv51UVQz2ixdN2+w8DkmqLrdUbHVgPTk7FLvGgP4oddY3Hr72c9jKJbct1FCp6f89igpTJF4PDRFdHVUg6GSnOhFL4VmwVk8HQ0B1teLbkibKu9z3z+NbWprHZav+camBnkdWUAyO2KDacqQHZ7JKhN6HCkdABzRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwgalVNfFeT9KdTD+uzm/EFxatUa/fQXPo8JVl3LLFM=;
 b=x8pXUNgwMm8xjKGmuQlijya5isC6tWh2XFqIbMezF/9oLcNLsKu3eV456/giGKx+M6KAoxz92jSbYgv6asIJMgt92DbD42Z/ltBttq5AkQOJv4elhb93c6xQpVBoV803LEuROthUEoqK427I2WfkfMMNwYd/6L+pp0TBd6l7m+8=
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:10 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::4) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:09 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:07 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 03/48] drm/amdgpu: retire ACA support for jpeg v4.0.3
Date: Mon, 22 Jun 2026 12:39:52 +0800
Message-ID: <faed35220896c6fb394c2589986724a72cbe2bed.1782103073.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dbcde5-bdcf-4af4-5acd-08ded0189ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TMD6ak6FPOYqOGBZX//QtmBxEsjG1mf6mJrDvGlhyfyMpw1ltrXR59+1NNa44iCRDNwk18GuqtBgMedkAYk1HEMH8RqoscxjdHd36xImKWxYLSKeg0Mtt+4AgTsBr2B9WSvJc2NfrUT4jnArRPASnrm+4YVeo8z0oMHYUFiVlMps8vX/9NdNTWZ2RccZVdAyIbw60lFQOuDqZ0+TtKYuzBqRrrPapzgfHwH5Yy6t9g0/dIM3H37E8q8DiFJtmOmG2c3pgOvIJ4xv1709DOnXP3O123v9bLgQOn+2bd7OPZ01P8cgu3E5OJU8hNizYnCL3HWU/jW8BnSRxIaMR3yVTdeHecuVlYIxo0BaH2378M27m24azBoUIi//fGkuAVNx3JFyzK7HJ8QAohrJL/G89aXonw4v5mJkF1fS8bZcvzpcSeshZGYU/eQ02GQcRuRqTeKYBAS/vD4U0TP+aW/AhQguXX1EaGLAbpCEGPIG54c3Vl4F/bE6ZbgOUMGCvW5dVrckyDleXRJ8P4ph1gUFoJklwgDNrV/2Nk9inJWwlO+Qp6hUZVp87K4gzk4zEHjO9UdXcj8TEJNoh3u7+kKEisMSaC769+J8BQ/tCxvhMGuH+rmthKh3jF4105WE5Pp/UAvKdJr5Rkbl/memdR7IHdkIs636dl6/iWrdTrwI5BgXz3wRvK95vOM1YN4OmF2cicZ+x5/QcGATOMHnXWS5KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: auie6HzUwzwZOUqGUdZynRxoDFvtPUlZtPWAULLlZ3CW3n/0fgiu2V7mLY1xYpiD6tSbtNX2IEOsucf32sxKCDjP/Jp+oJ/wlpKc10/JzB33si1c/N/GHL5Zc1dUZcARC/bUxcNrDW8RhqWMIg1Yrs3ZMW4KrWvniZ0G4rCgtMtBPfZ1a6JuWdS+8Bco8DckSVBXvHQkJY0A6nUmqT/Kuo+FuMaiNNb4FYrGz8kxVryZxC5KCYDJQyiT20jfUr+q38SwKvyOetRzSh4BnRsVYVN9x9c2oBOLCpd4JKq0+DeFpVrNfxiANbkzt73xur0VJcTkW+Uc37xJSBbrb+WqAUTtIHYHjXxlBsMTrIBfkDFoWZYeeo9Tibd/IpCVYPeF7k/9xumqJVeehHyV3AwcijnKhoQHUbyj5xTSLbcy9hdjRY3yzeNQI6/bhUJ8aH7U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:09.6458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dbcde5-bdcf-4af4-5acd-08ded0189ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

Retire ACA support for jpeg v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 95 ------------------------
 1 file changed, 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index b0bdb449538e..8438e13d96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1442,104 +1442,9 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
 	.query_poison_status = jpeg_v4_0_3_query_ras_poison_status,
 };
 
-static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int jpeg_v4_0_3_err_codes[] = {
-	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31
-};
-
-static bool jpeg_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       jpeg_v4_0_3_err_codes,
-				       ARRAY_SIZE(jpeg_v4_0_3_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops jpeg_v4_0_3_aca_bank_ops = {
-	.aca_bank_parser = jpeg_v4_0_3_aca_bank_parser,
-	.aca_bank_is_valid = jpeg_v4_0_3_aca_bank_is_valid,
-};
-
-static const struct aca_info jpeg_v4_0_3_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &jpeg_v4_0_3_aca_bank_ops,
-};
-
-static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->jpeg.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v4_0_3_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_jpeg_ras jpeg_v4_0_3_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v4_0_3_ras_hw_ops,
-		.ras_late_init = jpeg_v4_0_3_ras_late_init,
 	},
 };
 
-- 
2.34.1

