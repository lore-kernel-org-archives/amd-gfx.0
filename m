Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41625C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFF810E581;
	Mon, 21 Sep 2026 07:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cM+nRQo1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF1F10E54E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSuKmm57bKVM602W18bnI5elch0QAYvp7lW6nqMN7WiPHXcN2QJSnTsyCxf4CvBxVJA/oiSSo2mhBmgZjOqxlDrcXejc3D73L+w1MRJhEe7/vZdIAGov+fPL9R5ButS4CfAtHk/IOw5dtNPyKw9QkZXtwUGQralJMPzdBglfdhgAwxyCj0+zPYKcpV7SnblS82IC6/8B5TinTFtambk+hYT2Q9jXtZqhoHSHCkDdtCUMax21HzKL9+hGercJXPXQ9zFGQnXArGgUT/z9GtNUy3m613nsOnBiNdmYSjpQtn6zLxRTu/F1eKFImbQSXAimok+NahBwCwF7QC9HuCCMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnqDOvkTc1XZ2hzB54M2tURSbxRGeTWZr6v5LQX+RMk=;
 b=RdFSPsV4VUcRgSdqbVg2m9a7rN6zEicY2o743WBAlDx9cGmtzRIOtgOGX3R/CoE2Ft/z7TQFHEnQMgDjAtfpW7v5U14kAfrKmcW5JMmmrO3QHXINzJBUDKDcbiA28w6eTPiDasxPbMGedCTkTAzIimCuLLkr620BlLVYz3DJatUxUjbIinfECb+M18eqcr26q9nGnjHyAFjcHjifyzkJj6q/Ng3Sp3djs/gxGACFW0v4zmqRm7BgjQogg1wpzaQTVn5wto5Et7U3k02m4dsbgh95H8yOINQnE+14hajRD3Au4EKh9mHxqYPVyzbYO06CZnyxMyyrXqAB1afPti/rPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnqDOvkTc1XZ2hzB54M2tURSbxRGeTWZr6v5LQX+RMk=;
 b=cM+nRQo1HS3EP8C1zBDsBrsRIVrg5pLeavFIW7POcaqAVLgXkVEHWpYMMJOg1AjE9w2HVw9vb04sDMv9Ax/VtIzlykdjUiCuJ/Ti2ORE2IJ8feM5LrINu9PNFdPPaJArPk3PSBoD8Z+I2Zc2MzpKbXKcG/o/uzf3+Giir7qbG9o=
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:13 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::63) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Mon,
 21 Sep 2026 07:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:10 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 19/21] drm/amdgpu/mes12: gate gfx pipe reset on PER_PIPE
Date: Mon, 21 Sep 2026 15:51:26 +0800
Message-ID: <20260921075326.2409021-19-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 38042756-11da-46b5-828c-08df17b58701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: CWclpDco6JbM2VhFq/Vb/CmeHBM+Qsh8riqcXprKVKdKhoF21OnU/OwBaD//kodyjA0UGhdRw0GUEo8hBJ6gVLD4IwUusY662sFnrbyvYYvMNNSzM4M8Frpd3+CqVoiLVNyorabmxWsCCYMQlUilNyQPkiNZqEWIJY20VnAQTSNGBF8Fpb7FEuubuLuX3j0td104X/BPdPqtGAzu4cwVL36wApT1/Wmub5RqZJhfIgsOOwXWu8WN+bt5nqBNoZ3VACnU8NkuxenItGnxIEP9Sf1NZefnnG2DI9GhmKjnSJqCzfUlsYTs9CVNpBMDSvuq4uA3zx2NnWWO/uwmvgfROtX2X4YLK5ImOvc6grlt71LdazNZpx7Mt6w+PXoSgQrwPSg+qkpRY3KYkmqoMfxNqCiCO4mddvQQVk0Plu9dInlaF14aaZSyYTouKyVP66CIYCo07VLU5m+4jmEK0ITJRsCdCBCI+iVwyMyj2N82nZsZxNiHuTlmSEVfdTmr32ehNXl54qVnpMcd35+1Xg72NQLZ4ai/ZRQoB2AqRqDTrFy75xxCkoFM3i93e5CwN4ML5Aj194If6mmZTCAxUi3EKO64nlZ55BdIZfZlw8tN/jNrHq01slQlR4Qe+31+FMyB3GnXWB2gmTPB8ImRx+FkRZ4G9XEQ1Awfj+mWHL71XqZktgbwvA7eXPmAjnbWTUi/Hd6E6n95YDtujhWyNs7wCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /dSgay0rKwTIHTbqi4NI5fq5TnkyjkFnxDfN2yBBFzyuApgYz82K0tlxWX95vbBXD0zjXRJwks54D6iue3Q4Gh0C/UM+7kTK+YR7Jur6kW4GN5hd1mrxZu8XE5V8EHPkJboCiw7jsqhKSFXd8WM92la9Gc5NXKQAG/CYojJlmqiC/Pl7fdzDSbgOnOSSKr8j9V4ho6sXfSyZi+JDGjSmg/tCZHoXrfaGUG8BSYLv9owDZ20PCAlqYWwzptnKt1Yi1kDZyYTCPJf9fzBsnnOTPDuxvACuUSvincE/Xh3UFbXZNdv8IcSRSOUaJpZ97ivVM4ZUCBW1pMjLa23HCCP2AEzGngEtg82IDaRKndMhrkJxdG8hMDPAUysde1S/VAmuIbQqSPsE5L7rzXhqKiolmjBQQr6229gD21QR5oiNQ6PEcKSdwEVzHmfzKTg7PQ2i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:13.1007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38042756-11da-46b5-828c-08df17b58701
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

Replace the disabled pipe-reset stub with the shared PER_PIPE capability
check, so GFX MMIO pipe reset follows gfx_supported_reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ead276503522..cc2e343903e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -418,13 +418,6 @@ int gfx_v12_0_request_gfx_index_mutex(struct amdgpu_device *adev,
 	return 0;
 }
 
-static bool mes_v12_0_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
 /* Use MES callbacks directly while holding the MES lock. */
 static int mes_v12_0_restore_gfx_kernel_queue(struct amdgpu_device *adev,
 					      u32 me, u32 pipe, u32 guilty_queue,
@@ -493,7 +486,7 @@ static int mes_v12_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_pipe, clean_pipe;
 	int i;
 
-	if (!mes_v12_0_pipe_reset_support(adev))
+	if (!amdgpu_gfx_me_pipe_reset_supported(adev))
 		return -EOPNOTSUPP;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-- 
2.49.0

