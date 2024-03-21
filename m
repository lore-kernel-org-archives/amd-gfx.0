Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C9DCD11BF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 03:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA8410E3A6;
	Thu, 21 Mar 2024 03:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OMZ53Nqs";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D4910E3D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 03:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHEHNrt+eSFfYFebbnogA2WcHW68vIumgSYzXZ/cdl6STFOj2ri5JsqUJy0seEbfowlJhOHYI6zV6c9kkx9Ipdf93fUhAF2SbeogirSYD5VmkFPw71Bnm4tnDlinm2Kr4MoQySWHPaAlqwDxjbcTQJBGtFEvBZgP94mSYSETRydYxEm/PO78a3EFS6EDhGW1/4Zpvxs49rBxEIq0hy+nn59XdEvJ5gSz0dB+sKx0tEDSIlVwB589/k3gIKExs960SBISMj0cgo0V+nZ/AoCk0Q80gtu2xwRBUCenx2kpZsPCcbEmWb5MseHZxFy6bJsmVfWO5axqe+ODkOYXKN1DVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgYabHRXrGXgTvqypYPzMbMaKfuCaYI+7v19kqLDZwE=;
 b=UXiIX0pFCOqC+aQww3Pbpj+ja8NVJsUyvh5wnCcllpybuazK2fMrHYnaiJBl9J+RD/nf24nHPevkU8tNvMKBrzJiSgK38eynmEeb8DkHiN1OWxTHQWGbKmZC/3qvNmytLWa3J0d19kPgZqG54WYH6n1ky7YH+5KTVWLWUTuTFA/f9L2Kjxdexq5x1IpMsBdEFK1/to4GDwAG63gekbu49OYG2xyxlq4NxsGzTQZNRWDejzX+rY7P6f1FnXReTAlWmC+E520AVcu6RzjwrnF4FGmxgdWqFLCfJtLn6YE7mA7WFoxwKMvtNUuHh2W1AdOA285RRz/itzM+TE3DvS/JDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgYabHRXrGXgTvqypYPzMbMaKfuCaYI+7v19kqLDZwE=;
 b=OMZ53NqsS+lBuqUBbeh3NrPdEELUxioxZFTm1+Qz1xbNrLpI3MFv+iJmOO0EEKahDaKFwPhVjkHBsKWCqjRBLma38cc9aV+hE6N7x8Ans2/MM+irlMINQCPhQQlxNcEiXcB6JdHNzi+yC8UvzkcxOwmnlM2XOWEHcpMX3Q+Vadg=
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 03:30:33 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::6c) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 03:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Thu, 21 Mar 2024 03:30:32 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 22:30:29 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add socket id parameter for psp query address
 cmd
Date: Thu, 21 Mar 2024 11:30:06 +0800
Message-ID: <20240321033007.358505-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d01cfb0-2351-4238-988a-08dc4957441f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/TKqqA/mEN1Lpck3GDGWZH8rRgZLJLDaiW0rwC1ASZ74AFt5HPjsQ2iQOqDPEBp6w9G7ZNx5wXHUqi4uhUf26m0NDeLtcwLYuBqcN9oQ67zzf11EX0hdnXwWUXFZNuAilWBg8PnDkSE3IrfLjYLtqHAMLPTtVx0BXu7w3JCFNc8FMjay8rt+Rkm+ljzkxYRgAjALwPrP/y3yK36WJYvPl8O44mNldx9QS9Mx0caT5iA7Iky04G1vIoMQY12Y922MF0gMFfU8vk15McliXox1J9WCUOVgj1npB3E88RJsygzcDdNrSdbPoSPPGmJrtg/S023GvyJSkQJ93SMg8kLaeyOqNOnx3sp5SE3zRqIwEscdHsCvGpdbny5BMPs7gJ751/+zyO8HzZ/KCyf/epeqTN4VxiGGn3WnrbBSBB4VDtkBHvJMopXE8d+9Xp2TK2STqG1m5cp2s5zcnQR2XE2UK/Nf81WAzCTmU/9DLpBxRnYln1Mh4Dbrm2DFEnziGgSrBlMuduiBSZNJHk/xDUzdjThoF2P8o7EiaKHtY59w6ffEFF5ndeFa9uU7cNH5QDqphP5Xr4vvC/dBjFVJIbVJa8/VkJO2Op5aqwphIm0XW3fPKhEmnkpIQh+7gXRv3R+Z2W76mcHAq+KJZ4fyyRMLjXMhhwU1egF3VSgWRCjVV3Nt7J/gaRJdvYHvfUqyR1u0B449N4rIPwBSA3/hkBMgOf586MqdUEhOu7UT7K8C3N7dSg8eQgJS6CEIIvL85m5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 03:30:32.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d01cfb0-2351-4238-988a-08dc4957441f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

And set the socket id.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 056d4df8fa1f..3ac56a9645eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -146,6 +146,7 @@ struct ta_ras_mca_addr {
 	uint32_t ch_inst;
 	uint32_t umc_inst;
 	uint32_t node_inst;
+	uint32_t socket_id;
 };
 
 struct ta_ras_phy_addr {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 77af4e25ff46..0a9cc87e98d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -268,7 +268,7 @@ static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					    struct ras_err_data *err_data, uint64_t err_addr,
 					    uint32_t ch_inst, uint32_t umc_inst,
-					    uint32_t node_inst)
+					    uint32_t node_inst, uint32_t socket_id)
 {
 	uint32_t col, row, row_xor, bank, channel_index;
 	uint64_t soc_pa, retired_page, column;
@@ -280,6 +280,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	addr_in.ma.ch_inst = ch_inst;
 	addr_in.ma.umc_inst = umc_inst;
 	addr_in.ma.node_inst = node_inst;
+	addr_in.ma.socket_id = socket_id;
 
 	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out))
 		/* fallback to old path if fail to get pa from psp */
@@ -331,6 +332,7 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 	struct ras_err_data *err_data = (struct ras_err_data *)data;
 	uint64_t umc_reg_offset =
 		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
+	uint32_t socket_id = 0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -357,8 +359,13 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
+		    adev->smuio.funcs->get_socket_id)
+			socket_id = adev->smuio.funcs->get_socket_id(adev);
+
 		umc_v12_0_convert_error_address(adev, err_data, err_addr,
-					ch_inst, umc_inst, node_inst);
+					ch_inst, umc_inst, node_inst, socket_id);
 	}
 
 	/* clear umc status */
@@ -450,7 +457,8 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 					err_data, err_addr,
 					MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
 					MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-					err_info->mcm_info.die_id);
+					err_info->mcm_info.die_id,
+					err_info->mcm_info.socket_id);
 			}
 
 			/* Delete error address node from list and free memory */
-- 
2.34.1

