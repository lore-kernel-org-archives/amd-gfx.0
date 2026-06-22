Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C952CCDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62BD210E577;
	Mon, 22 Jun 2026 08:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7dz219h";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D1010E575
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6MWl7UiU9MUXxejCGLuEP4rSUeON7XoWAhX6jVmN8cQHpLogR2P3JP+ScqCTZLIbgcRrGrfpPg6lhwGhATNXIk0QwJ2ZYFnUJyEcv+d+BxByCQHR3z+d+Ciq+5TqBaul/3Bzzpx9pRXD7sYaK5y1owd9Axk2c5cdTzpio9YMmzfaD3UY+P8uFLGb/ALnsRy1xb11fcvELEO1hhKT7ukAUAN85edo1CsJzbLtq4IVJKRb56HptdXxdsGehD/Ps3apYloZ4lCaRKvINLCD/2h3MmyDj35/mlD60OsbiZlccq60kkEUqyuquUScR20gNXz9F/dzKERyno/vab03ZqX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6GPD/4IYbow1VonjwO7dKq9hmdDuZKHI8CDoUneL6U=;
 b=ktjJWvRzNC8fLJUojufDM2g9e63brMRIZvwUKMvs/7xAkf9gf2obkR0/PYGS5XpAHWb42YfrvicTqAz7GijJCThgFIL/P2byADwHEUyW409S/VQ5XukxaARMB0n8YRkg3esajUTR7Q/2IXhdZZ8RdYBBV1R0aYwcCF6Vem4yWNfM5KY9ko9CbLz3fg0Q1cdtpVMaiTO7TkGE16X6vfDTesEyPireSwjo8oj60sada5Qp532TDzwlvcfeLQeUR2R2h44rjrY7mRgNYyNZR9ThzVuPUfB8AGD8FcKDr63ngGh9e7ZIyOSz4/5+h/NdlFyxSdPrwO22HsVmIHzByHSiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6GPD/4IYbow1VonjwO7dKq9hmdDuZKHI8CDoUneL6U=;
 b=R7dz219hxgogz8kERM1TB99WGf1Lr0QC3u7cFy2ImuiEt8a8lYCmDOgZ8LfToxx4zsuwosFIMMDGqMhj46X3jY2QgNdvNW5sOm1NWwr/9dBzoQkb/eb3k3332sozahSoxDNGA1B3NGj2dbpn88VkXgV9g3Mzp5jU1NJxkFmL/7M=
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:46:17 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::27) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:16 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:14 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 34/48] drm/amdgpu: retire legacy MCA IPID parse global
 interface
Date: Mon, 22 Jun 2026 16:44:36 +0800
Message-ID: <8a3120956b9dfb387651f19dd70ee2d4a25940fe.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b2c0ae-c53d-40c1-b7c5-08ded03ab93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oIt1nt8e2tYAlPjYUe2a/MtLeoqS2LMiJFm1ox1yPBO1dTuGgoB9d6EhApXnRttMPpgdXTUsztaA/z4rViwXRWcDaJSU3calEvBjRnJoWw9DRSm6Z662m6Q1s6NnjVGMdWpbn3rkuI2B0VN7seyTO41BZDwRNQQi48u36nO8uXERZP+F8EovUymWaEw5Xy7/4dNL0H2j4lV24vEqekYcbIUkOdKKi/5suJl6+BwtasBUT6U+nLDsXif0757Ap9egecaMH1305eRl5sDVcxE8nhxUfRhXiYDp8DsVcBuMgXmDpmXCYPA7oBZXLwo9+RR6uChuxz/aqaBOWTiLTaGWtjv/ytNlHwfNnTrfzXeB9gorVk3lZy5fEyUsMktWRNgqHGa85hAAyHa4akeViDS0MYrh16qXz5KM4B9g8pPwbjj0pXtsk3kC21hHNxt+lpbkYbVssc/1iXYvJvUClZPjy8hW/s3sdk+zjOhRU7r2b+j9Sco3rOfEb542RoNqufRFGSXCZheD8cK/cnwqTGxDh2KhKIEn10s+oSuJoB+f26YdWoiTnisusMuMI/m+mfgHaehGDBEpOfb4Zp7l3okYOnMkmmj4cJjwxrFi7fWajM3Lh3Ofc37dXfEFokojo7Q1bCQpEraoS7cB0hPQZlo/S7cglfDxF4if9MBV5SI+GqXzYI0fKGuR3rW7kIX+s6w/Pn9hg6YHdSAMViCvshhKKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NCpFVg4uhq2KcPDYYCVauD62aOnFCfBtUHvdeIY6PeVmurGyUrx3OT8HQFnue1MhLuyClkXq9Y/KsGp6zDRM7SoYeyrbYDvNKcN5uDSC99qOTpfdM6NTznEmMfhcorD2H+TMRMAFs2mXQZpgIuE5XovShWFPVlROHVIbYgPH4qqjxgguHxIOauWc8EFW4z+nDzeouI+vkmRRpumcXoqrEBttXgK9ZsoY7HGsarh2xV0IpIOurFI6hSNDvkdO0n0mwVTOl8/z/7jszdZGgHiqd31QFbbj+W5es/6VslReI0A+d82/5ejJZKyd2U9bXg2bQSzTGKvTIcf231h2esGWqZS/Ivto3plL2B8LWK06OvO4hus8Ex/U5gPyBHTP9UgfyrkkOgxB2L0RL9eu68h4tR6c6xbjMwIsw8v0OKYJ2I34cAju1MAIryyNbcL42Vt7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:16.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b2c0ae-c53d-40c1-b7c5-08ded03ab93b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

Remove the legacy global MCA IPID parse interface

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index cdaee4a049c3..cf06d5f856f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -104,8 +104,6 @@ struct amdgpu_umc_ras {
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
-	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
-			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index beb89b0f9f3e..67bdf7303e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -197,25 +197,11 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
-		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
-{
-	if (did)
-		*did = MCA_IPID_2_DIE_ID(ipid);
-	if (ch)
-		*ch = MCA_IPID_2_UMC_CH(ipid);
-	if (umc_inst)
-		*umc_inst = MCA_IPID_2_UMC_INST(ipid);
-	if (sid)
-		*sid = MCA_IPID_2_SOCKET_ID(ipid);
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
-	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

