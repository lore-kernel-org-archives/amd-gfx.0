Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDCACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E456C10E557;
	Mon, 22 Jun 2026 08:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIJTPgQA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE5C10E552
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mICKfFMxnz4uhyaQz0W7u4KkU6YtHfdiGUq1kEwE/nw5bgK2ZQBUN2K9eNJRG6Hom1kwPDLTGlK+5vNQXwlpPxoaCf/rxWBVqSpg7DrbsORMif85H/ZTz67lxlEyAIpuX6vCJn807xAYLGdt36MOFDiSiP2dUJ9kspBjdNhVvWKgUqg3Z+bv2EaqJqbFRLMltTCy4gjMAvnWnK0lXSTQUJTaHjvEaHRX7UGF8S7OP1w5xSrWG9JjbmSJOuzzVs13f/Ydd+KS/sZ0RFFFrH7AocGJE90EmFMk06XIE2YBZXwK6RFZ2i8dKXPh1HJf4OX+S4Bk55BtxFE/Ezuw/yIchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=RIviP7UtlI7R8gFoFNDsm7zhDSVkFK7fu7SRg7LKCDaVvla2vDGb/kHwuysSzLM13CeRNCwgrk4rDG/ZQegxct8B9TlfkD+rqcBrAolHuQteETzOUj89I465+a7ZD6QuNe7fuL4+BV2Tja/aDA0gmoClaaDVhEKi5k85RX7MK4rv8DhCpY8DAAVKCD3j2yRslDt9IE4vK8jIrfDk4B5nhUI1YdOc3OACpQbIj+Tyl71z26l/ePkI4FanVxF32oOjSpGvfRpyFRL6U//wUyycz0Z6076L0QzQmbu3RiFGRVK6UQN905Y5WZ8OBbnPSxsJBUNHLIgIiMZM0saNz5FVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHNDHEHFvxG1SJSEejOjLwOJiP5lWV4bE5JB2/K+k5w=;
 b=AIJTPgQAxiR1RRB7qMmkTAWNoeOKcR1yzzh/g5n9gzJvEU/XDahOoqO70A+Yt4BjL96NH7Uebrn5x8IWRwRi+cO7W/nxPUR3WEfx3G2bt4YE6bfD9MD++rCdq7crwO0Fr6oRM86DP9hcoernvyLcICahhK0xd+kRlof7/3RAMpo=
Received: from CY8PR19CA0033.namprd19.prod.outlook.com (2603:10b6:930:6::9) by
 CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:45:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::88) by CY8PR19CA0033.outlook.office365.com
 (2603:10b6:930:6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:21 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 07/48] drm/amdgpu: retire xgmi v6.4.0 ACA support
Date: Mon, 22 Jun 2026 16:44:09 +0800
Message-ID: <093069b2544615562b167c230def1d6ada442969.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f98ac7-015a-4ff6-1f63-08ded03a9965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LAxbV86+NuwTopz6/rwFkqNJw2RVU5QVsdPWV/RTBBGFbZGbwsVRzCEVxBKMD7a4rxcTAhX6Tbf9eZEQzbtk7+EAFXU35xDjl9uYKUZyVQzuFe6FsRc9QZ1cOG1OaRkan1nFRL1ACEYatHpCvSvWwu0DbxrL5sDDSlL+Egx9x2SCT93Rdi8p+i70Hr7M3xECq40omSpfi1Stinb1C62VqzUK+MpgCzMQaneqBV1rOzofTuU8HwLkdPKvsL9xWv6TT0wLNSP8J4q/pQ7J8TGc1TgWx+bFfEmngbeV3zaXhuu9Q7SKSXi08udpz6f68I96NiJP5uTA04uDHqQzgdOAcgGay9nU/UbljdivtOnv219wsHYVh2GJPTBE182miq9aajc0QvUu5CQPlsX2QCENk8EjrB5cZmST78vk4Jm65nPaEEDqyHAGLiCvQMT2xUvJWb3zN3WN8YwnufbEtTaLIFaNybOpcDVlWnvHpmItpqX7PO4EIbZCTVFBu0UQfIv4JNtMG6zBTRIYde4oEbGrC6qHZpwbj3fr01emN+6IoG5DzeNjQa0BU/TR3t4F7P4an+lRlmkssSwCEtEtlu3wTdUqyWb2XivxFFA95M1d2qTKZgeG9mziSGWEBRV5wpi8Cf+HtKQw1XhGcmWQeuJ7vJiHVKgfMKTOed8aKErpEDaPTAu0Q7FbjF3Y2kAQnTD0bF8DKYcv1Tcum4fkJ9RRnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BvuqIPXXCuszImVh9jRc8cM3ghKZse54lSA54pFq304XfNuBaFeGkrBhKTEx/3i/73FdMfDYujApCp31JhfQfCRjrzUMO67Lm8mfxISXB9+tFlNVX06v0oCYSvM7C5ByuT4v3wQDasmlTNgVPQwp/EVtN4pFN52dX7Okjh1QQYyq6uCi97GTmMwr6CGvQOg86SnfztyGRKzemifmlmnn0Wuz65pP46vEfK1mzag02rl7jHTVOhz18PX9sAmORBuNk4+l8/WyIbOQZzqbdknjtjxm00NERIVaME99cOkZkBWRCFNm36qLrGWSas1mv755AFwuT3q4+v5HqnZe94p8ea/5IK2pxWzWQXXVtr25+y8AMgA35apogIb791OC6KyAw3lGI55Bqauc7krRoqWX3k5DmWT35cRcI+GruOAtzhNSUtwdgP2dPQbjXDdPlXj7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:23.2523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f98ac7-015a-4ff6-1f63-08ded03a9965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

