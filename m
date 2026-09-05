Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB57C624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A5810E5D6;
	Sat,  5 Sep 2026 10:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DSfcisLs";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7CA10E5D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaX3G1izfnp8fE0dZnv7i6h/XKSM3LJ1N+VTkVoTrfkPZYeC+aejLFQDtpqz0SzIy/xZHK33cSQKN4gty6kkhUc3KK3yvVY+cXS1RR63BrSSo9HhNDSdYrq9Vr5HMIe72SOcCUvQAs32hhTcIMwCDg7vMuiXyWtSajLjELQVN2RfDCzIyOOlngXjovQZa5MsTlg85walAFpg4WSDIqH3PRJ4ejJNyJlJaGZTypCG0+lXmcR60TUonUOWLJXie+2QdzLPXqyPGrJwkmeqTicARvsMEOVq8G6aR2k/p42l27vix+YbhPSe/KdrU7NXnTOZQQnlLyb7G3qXYLHrwtfdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlQUtvpLX0/PyaFvm3YWcdL+YRRNiA/BV4vEoFYGNCM=;
 b=FZb5BxZfiA556949dTTEL88jbJ+nbnGmjugKw2RLuI33Bj8y/mp9BUnG+CZe1//9tidh2nxbV1llaL8fJ99hFAk/BFKM5i4I5O4D8HDJHTriCUuGqG84FNONShl/xfdV3Duhx/Qz5Td4FIJg+ATV+NZGD6kRwyURnqBIoU4F/qN7FUNvTazrtNIFoqN80irwgfbVFzL7rL1PW7Iflcf+qa28H6l1nQkwCiBaTZTfiMLj6TIs8XIlWt52R661GZIAu3xl4mMd52SWYf8wdnQGEazPyGPrGgo4tqwnx6wuawxIsjI0iH3+pev3miRhXBFYBcyWvVINnUHIuNbtCEi8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlQUtvpLX0/PyaFvm3YWcdL+YRRNiA/BV4vEoFYGNCM=;
 b=DSfcisLsURF03e6aVzppAigbGFDfqlvteyc1NsKwvuBvbNCcz7pIweoRDV1+jLksOcupNWvjKKnDfEYfCF8f3+xUc7IsyhfYRl7c2sqseusVCgkKBY/wlvykT/HG7bLQfTnindON1+dsWTLUInDQ8Bjq864tfKkYqf5m9+kWMTw=
Received: from DS1PR02CA0025.namprd02.prod.outlook.com (2603:10b6:8:44a::18)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:16 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::1c) by DS1PR02CA0025.outlook.office365.com
 (2603:10b6:8:44a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:15 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:14 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 06/13] drm/amdgpu: Support doorbell range programming through
 smn
Date: Sat, 5 Sep 2026 18:05:31 +0800
Message-ID: <20260905100538.12877-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 154fc730-9bed-424c-3135-08df0b3552a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: K4m3UteKAALJGYBIrblNJK+NI1D3XwoUpyoBn1kyzpLrn+N/pHMwOrww6IGiHxcA1gWVyDK95euGq5djls4gMV2TvkqxNS/6CayGg/7Y9mkawNNy3BUI4py+14DJ10Oyt0+D/2Fg7UsfaUVAR//WYNBANHxAPLfx9Y+1x95KYnCcKfhBaCTSqKdX82HhWx/3wF3z4PrtEWwlt0il/rVUDdvCYWRtz2FPaiDVP1OdsdBMuKvNRNC9CkBbTX41s+pmlnoCQHKByRRcvgKYKQya8I9r9d/ggq/dQgyWD33JtRPtHwjvAi/9dP3xqE8RUOmte06NfxqAu731oo/rRX2v60Xgd2ZVFv2YIlScs+3iNh7n75QLFVIhx1FVor66X8SMk4csgJCidkqpxXEJ33lvlq1SUjOTSuzDWnCNaINifnYTTtN8ixU2G4dxh9prre6X12fSjBy476WIIHbwcYu0wyLAZDE+NOp+qvQ1isi575GH2B1rVFWMGFDjkQ5aFOT7/vWQ1LWJeZ7BgL7MxLG55X+XLf6AHSiOYquobVruTuT6LvKd+cvaGFZHLaR1ZEsEj+Ybn8UeSNFjpOdenqR/+hbAdm7PwuM2QXiaDQ0qp8PzXAI6Fb/gglmuk0hIT00r0hVawNFIzftUjChk+0oOfMdxaoHpwdE7eDTHfPFIO0736q+8p2AakAwVicX958LsYWkEWppfeuB28PrrdaSRDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f68KSZ6yM+dKUeQR16S4XGrD+2/B2oVUDFhChYzsefqf/CQZd2QxFtzKqasvXJX6ScMIbL8DFQIczMBCzMnEkMyIH6SHZek6tcudii2m4XshQqQvWnbnh03RlR5tpo4bgUChpv1rhe9sxHEC2TRmIGK4UwQb5krh+K2zm46J9JEYhLgPyUwe3eAQwLhw6nUIfTEQogRlTbG4u9knd7mGGVj1GV1xc1ifWwheXAJnZl0KX02/7BDpfZ6ej8pJcnS2KNRewrFOFb/duwu39ehH476znU8NSmbHIdDcSS4MsSDGFeh9Cp7MwKz0M6zcK7g7WPvelF3t8BlCetCxfmQVjzJ7y/DyrdoQbDjLnHYVzrs0sHX8pCDTWupGwnAuMRfKpbkeeTTIZ+9j7TN0RCYhkgPziH2S7j+ZrEyj87DIWdneZ7Gp6rPQY9JEDaV2OTeW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:15.7244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154fc730-9bed-424c-3135-08df0b3552a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

Some NBIO generations expose doorbell control register
instances through global SMN addresses. Extend the common
doorbell entry description and programming helper to
select this access path

The IP-specific mapping records the target register
instance while callers remain responsible for invoking
their doorbell callback for each required instance.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 24 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  9 +++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 70b63fd3656f..55049a8635bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -221,18 +221,26 @@ void amdgpu_nbio_program_doorbell_entry(
 	if (WARN_ON_ONCE(!entry->ctrl_reg))
 		return;
 
-	/* A NULL CTRL disables and clears the entry. */
-	if (!ctrl) {
-		WREG32_SOC15_IP(NBIO, entry->ctrl_reg, 0);
-		if (entry->ctrl1_reg)
-			WREG32_SOC15_IP(NBIO, entry->ctrl1_reg, 0);
+	if (entry->use_ext) {
+		/* CTRL1 programming is not needed when use_ext is set. */
+		if (WARN_ON_ONCE(entry->ctrl1_reg || ctrl1))
+			return;
+
+		WREG32_PCIE_EXT(
+			(adev->reg_offset[NBIO_HWIP][entry->reg_inst]
+			 [entry->ctrl_reg_base_idx] + entry->ctrl_reg) * 4 +
+			amdgpu_reg_get_smn_base64(
+				adev, NBIO_HWIP, entry->reg_inst),
+			ctrl ? *ctrl : 0);
 		return;
 	}
 
 	if (WARN_ON_ONCE(ctrl1 && !entry->ctrl1_reg))
 		return;
 
-	WREG32_SOC15_IP(NBIO, entry->ctrl_reg, *ctrl);
-	if (ctrl1)
-		WREG32_SOC15_IP(NBIO, entry->ctrl1_reg, *ctrl1);
+	/* A NULL CTRL disables and clears the entry. */
+	WREG32_SOC15_IP(NBIO, entry->ctrl_reg, ctrl ? *ctrl : 0);
+	if (entry->ctrl1_reg && (!ctrl || ctrl1))
+		WREG32_SOC15_IP(NBIO, entry->ctrl1_reg,
+				    ctrl ? *ctrl1 : 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 2ac392934169..18418a331517 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -114,6 +114,15 @@ struct amdgpu_nbio_doorbell_entry {
 	u32 port;
 	u32 ctrl_reg;
 	u32 ctrl1_reg;
+	/*
+	 * Some NBIO generations expose each register instance through a global
+	 * SMN address. The caller invokes the doorbell callback for each required
+	 * instance across the die; reg_inst identifies the instance represented
+	 * by this entry. Extended entries only support a CTRL register.
+	 */
+	bool use_ext;
+	u32 reg_inst;
+	u32 ctrl_reg_base_idx;
 };
 
 struct amdgpu_nbio_doorbell_entries {
-- 
2.17.1

