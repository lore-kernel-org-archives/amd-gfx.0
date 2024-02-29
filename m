Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E1CC54798
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 03:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AD410E0F8;
	Thu, 29 Feb 2024 03:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Cf20o8X";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681D610E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 03:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEowomxQUE2usCHHZjB9D6y0Oj51Dvp02MKH00S+8sb0yHVOVLRBxNMNXZchdHQ9opl8ZjY8vfr/tT5jwTiG3HHOjcyK9b0E9dAip0MqOFOXCeyLuu1mY2jyaTkWMbVUrBXK4p0htIx/3PkgMfDnbXKy35WcSXXP4saVoMggIMY/+bQ/AfJG/ZPR7bpRvpA0H/o29ijrBvW5FzCPswFQdK1z04PrrfANfZ4oZuvCiXPW/eYvSTYGZVw0sqVED+dIWE7CM08Q7mLcfQuDbOQyliX6ciOFWC/IRjUO76BKf+t1dxMhBbAFI0q+mn9oX9Tp0GdxiiFGWd3R02vhBxDm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bajzBHHydiM1M7Oci5J7GMVVwuh+sPvqyD+tpsjAmN0=;
 b=gvyE6a3TFL6D1TyIlYA9qKzjh4Yq76WdlOqdC5emhk9p7lIsYPyh2279gapGBIhCBQUZzCYAp9C+ubCuV02C0dO66rvksAZxfbK1qzaKTXqcUoA1zz4Bqgib+dGI/H8TKuoaltZQ0cMzG5tsO5KhoHgaJ037DPKj/Y38vYMhSDtJv6X5gFJCLRJX0Svf4H0apCQ48qA9hs6iEWNZ3Tle319eoGUVpy1adApt53Ju4Df94TGV2e3DZOBCMJziCZMmuFmY6LTpqogZCkBqsBw7Uyrt0O3b96rq6OrYi3ywIKLBBqQQ02wI+RpnVhxNmDUn5ZbAoHtpjTOpdMcl3uD3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bajzBHHydiM1M7Oci5J7GMVVwuh+sPvqyD+tpsjAmN0=;
 b=0Cf20o8XgX8nF2JxymDBG+bMoWLpi0IdlM2u/o8YKo/6201q55ULTsoSFJXw2o1WDtPL6Bo74ITvuKE2f78sSWhQ8I1VZPsZxZRuuhnK/L7Ug+Qz0KMJ4jt/XC3D9UN+lMF3nffOLHVdqf72kxiJR5c6IdLP8CJvRj7+Y8S54vs=
Received: from SA0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:130::17)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 03:45:58 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::f3) by SA0PR13CA0012.outlook.office365.com
 (2603:10b6:806:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Thu, 29 Feb 2024 03:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 03:45:57 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 21:45:56 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add deferred error check for UMC v12 address query
Date: Thu, 29 Feb 2024 11:45:47 +0800
Message-ID: <20240229034547.328740-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 086151e9-40c6-42e9-66ec-08dc38d8f06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CF1HqbeypOpHkZqQJW6eRQPrgio1J17mGyBpr5m3S4LUPyrlfLj+moBC3Ax80eGT0Cx/8bUXZs6CNyxFAAL7eo4OGDEkWxiYyo3r3xE+DHP6e3RtX6Rf0Tj32UfS/m9J+FQC/gxGVtY2f+wTdQvhrUoO7N444LuPNs+HF/sOfsZLZjnM7pBOquz9OyX/nIbIrGJP3WfcU5VdX6JYulnSf09/akRe/ghcR5jFMB4vYi+JQwwXCaU7SnIqR9Y4Sn6j8OK/CO/8DRlniSSrQAYmruQQw2hqUtOb050QwFs1Zo1qxWk2L2KrfILs1tl5aatZv6lrwiyJW2yzkS0GlGYMOFvQ2OH4yEXoiS0AK3wKWqlJ8YBrCa29dgfg513MVk8/wmuPrqYcGGuBzxsJDO8Jx2aeut6s4uEirPDgREsA7W41gzSBJa30A/4PUD0x4wnaf23y6U5xiaQ9dc6oRLP03EsvMwHpYmldE0Sx6/5zAHFsFAJBV9m5H6i3CLdHsEkYJcK7tpds3grsYcfprimlpdnqlmCDt0igV1eA/X2odfDnXx+nDixlEXhi9KUov9ebwko1eBnpVJcbeeGOoBg4mrMaMMz01VB4v/sS6u9UZo191hgfJ9sN2UnPCbmx53AvlNzMjuK/83Y7urJz4eCDu1ea39dzfAg4nxsw4yQebJFaPQop99BNYk4GimyHSIHgkxY/soNzgTyXDMyC6AY94vogzcEMdtybOIpVW9DmDB5TVnvOs9JcIxPo7BOzSdd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 03:45:57.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086151e9-40c6-42e9-66ec-08dc38d8f06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
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

Both RAS UE and deferred errors need page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 14ef7a24be7b..77af4e25ff46 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -348,7 +348,8 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 	}
 
 	/* calculate error address if ue error is detected */
-	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
+	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
+	    umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
 		mc_umc_addrt0 =
 			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 
-- 
2.34.1

