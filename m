Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F287C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835B310EBEB;
	Fri, 14 Feb 2025 08:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Du2OyUu5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2078E10EBE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxg36i7rA8pCOEFQbq6txwzyGLORu2fbxmStDxabynmbVrt72cMfIDR+5zG9kPHq/ZAaql8Dwt25+C3nURe8rzVqDMIaLOtKxg9DLHnD9Dr12V8VABG3jpbPc7sX0t81x2EysP1qhvJbETelqvmIlBPCXL4G5Lt1TLiBmvY3nDTGBljg2JtGw2LnBVJxXsqh7/AHtCghkRh68KeewRDAbEn75aESrXq2smBUN/XHtS0AxZUXSIBipYvhqgRQRiCu2n/Femyl7X5kTpbnz30OQjXQr06EnEUnwbuEIxFUvKSFmMN7wQTyl4L3KC2IL62XrA2L9mo3SXt5XZQdNYpy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2UDlvTDr/MIGRYpOV7aEd2WkBITABHZq+7siqlPFp8=;
 b=hTzggNHDaMJJswdrqyV5MBWJSFKFatZrrC+dv7LwJDaxtiUK2xy9LLHRtv17JwsxH4zdW2OAW4VdUaPEHpBKJC6dMfJ7lDk9gUHdYIA2o1POYnkgWdCghR/DWUqutyS0KD2zn5fXIRwV5VFrqYeQqgNTWy90X0yfB/Ij5Z4DUUvjdgYWAgDPMz7pIUnR0NmgO/BKBXyICbtomM5xVthBo1nXEUo0eEpp+Bce+8lDaFb0A3ezz2I15N+ly8cGVpiDFX0ILKXEVVhWSxRnUm1AdiivBYfNBnfWgF3Y+hVQXACkKZ0VwwHHLtqNLJApU72Z14HawqkmHc1H3jDHyIM9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2UDlvTDr/MIGRYpOV7aEd2WkBITABHZq+7siqlPFp8=;
 b=Du2OyUu5L+dCbqsF1ShztNiGIq0OgJVDWlSsitSWyXM/15nAouYCJ4QLGdHFo5+s4UNwttvbCuFu7tcd+y31nWlAfpH7KYGPnww97ivymFUmxuFcKFvuLcYpEgu2AbnGoQuGXXlil255bGhCNnz69nTq30ANMa3NUBor2hddL98=
Received: from BN1PR14CA0002.namprd14.prod.outlook.com (2603:10b6:408:e3::7)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:07:55 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::7d) by BN1PR14CA0002.outlook.office365.com
 (2603:10b6:408:e3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:55 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:51 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Yang Wang
 <keivnyang.wang@amd.com>
Subject: [PATCH v2 03/12] drm/amdgpu: Include ACA error type in aca bank
Date: Fri, 14 Feb 2025 16:07:10 +0800
Message-ID: <db8c6bc1f53d35d2a54d18d38c3854054686ffcc.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: f320e6c2-ef3f-4e03-04c4-08dd4cceb01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYy+maOPvfnOYo6zo4HjQkPneNBSHmZj7v2cPv909L91MuHF4I7pecwqotPs?=
 =?us-ascii?Q?elwPqOzaaeHBNF6ilkUFGdwZt65Pajkeich9n3GEqKGv8yEsmmrWZjuJii28?=
 =?us-ascii?Q?aSCR6yFL95TN01DqRIhAG0br1lMVFzEbWaoC8CEPBI0ttbEN+63ZJfk5FGf1?=
 =?us-ascii?Q?C6z6UWbhkgEPPmTAcJ40x3EB12GVY5emUq7bi0aHRYuQkE0Hau6+YAbwWzNV?=
 =?us-ascii?Q?UCN3e66SCER8MVvHR3Xq2v+35Uk5Xx5TfPvn1SUeGUGYNTXY4M3CBgPe+FzA?=
 =?us-ascii?Q?oWUE98s4GG8KgvgKcbD/G6kHVzdaCvT9kwyXxPbLRIt5k6/uNHR1c0dpOjrt?=
 =?us-ascii?Q?Lrqe9/+F1otKUYTyOZwVdRtaIKmR8UQDSiJIT99fAbkdnYvf8McTeWV2utSf?=
 =?us-ascii?Q?EJvki5i1TpmXPTIa/MwcUlNmIf7vfZTp2peGLXSRR5TdHzIxnQz/3TPom6b+?=
 =?us-ascii?Q?lk27VgWHwKVVybbdJIdMKxZhTJTzbTIo/i0FSDrsEX/yLbRByLJESdhGiv5f?=
 =?us-ascii?Q?v/wxW9WuL6FcC+FJsoy2GGIEGbmgcdhjpNUz4Xmvhb/ONQT8lZkbX6qISsFv?=
 =?us-ascii?Q?BOCGksgVVk6FEqFDtW39zaVsaIocXcO+b87CV2oXTb88whYEtC+7sBtFyltB?=
 =?us-ascii?Q?5O3cCdR8maQWKOVaNuzKAHEI7H6K0V+7B1yt0AVEB2Zh0RuKuu1No7FUEPJq?=
 =?us-ascii?Q?rZk8NKWpSZQ/ya8EAQ3VzCSyHMLqamZWP4mLdDkp2D439/a2xk+bquFXVexL?=
 =?us-ascii?Q?2cuW3Veo/cofumquyUbrQ7AbeD8L0gbrf1Jv7MvzUmoVuJgBZB3naKi8GHEJ?=
 =?us-ascii?Q?N2AXD6tEhIZ4HMsYgYMSTtrqxx/IF0qHx6GAAsKKqGdW7IMk3xVDp18a2Nc1?=
 =?us-ascii?Q?TulufRPdLWbF7gcnaVWtftLXDfIOlZ4K/rm2+ujuL7xqKXvI8790owtxYsPH?=
 =?us-ascii?Q?8ailtabTybF0lXZVOv7hkSjjoolaMDn8Ic0J/WYmqyvReyoe5VlORRKucDFg?=
 =?us-ascii?Q?M3sODhvUR/eVn4CRn+cT61UjmNoiph0fRM0F5TLwtsSE5wtBklZCfFQt4wBa?=
 =?us-ascii?Q?t+75hxuv7YcI0nwynfImhnAjTdo+eC09blpjpenj+NypoBEXXWMuCn9Xjg4J?=
 =?us-ascii?Q?aGPcozqBjrok5zY4B1I5bH7uoiPGmL46V8NIRrCDtbozPcqdgG804DuVWOeH?=
 =?us-ascii?Q?VmEZlhshSoV2hR3zEhr226BDzeyOeHfh9LUlav4uzu4uBoMYwyW0vLDlMqcG?=
 =?us-ascii?Q?FHsAKpCYWIt3RV9WEqGNY0TeRU6BvwpUd5NS/vuQLpP4wk9p2ReHdM8jHqmM?=
 =?us-ascii?Q?XRHHSooVGlPzA5peORJhX0eo6bifuX/gANiubX1ZYcWnslaRCWQsaTUqXI8K?=
 =?us-ascii?Q?IJuH7zq5Rp7yw2rPxiW3KO8ROD5aGTC431KOFMuPzJJLsUT3EKVRk07orjog?=
 =?us-ascii?Q?UWA70oxWDXfcLCnN7s2zrWZTtHX9h+x/GffLYmb1GfKsUTHhLUY5b4KHMb1/?=
 =?us-ascii?Q?oVHVrIxQKW7KNa8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:55.7650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f320e6c2-ef3f-4e03-04c4-08dd4cceb01f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

ACA error types managed by driver a direct 1:1
correspondence with those managed by firmware.

To address this, for each ACA bank, include
both the ACA error type and the ACA SMU type.

This addition is useful for creating CPER records.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <keivnyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 2 ++
 9 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 9d6345146495..1a26b8ad14cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -168,7 +168,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 		if (ret)
 			return ret;
 
-		bank.type = type;
+		bank.smu_err_type = type;
 
 		aca_smu_bank_dump(adev, i, count, &bank, qctx);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index f3289d289913..3cd0115b0244 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -108,13 +108,15 @@ enum aca_error_type {
 };
 
 enum aca_smu_type {
+	ACA_SMU_TYPE_INVALID = -1,
 	ACA_SMU_TYPE_UE = 0,
 	ACA_SMU_TYPE_CE,
 	ACA_SMU_TYPE_COUNT,
 };
 
 struct aca_bank {
-	enum aca_smu_type type;
+	enum aca_error_type aca_err_type;
+	enum aca_smu_type smu_err_type;
 	u64 regs[ACA_MAX_REGS_COUNT];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index aecbe52a4f5c..94f306c0b706 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1129,10 +1129,12 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 		if (ext_error_code != 0 && ext_error_code != 9)
 			count = 0ULL;
 
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, count);
 		break;
 	case ACA_SMU_TYPE_CE:
 		count = ext_error_code == 6 ? count : 0ULL;
+		bank->aca_err_type = ACA_SMU_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE, count);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aed05f3daeeb..d54b2261305b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -893,10 +893,12 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info,
 						     ACA_ERROR_TYPE_UE, 1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_SMU_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info,
 						     ACA_ERROR_TYPE_CE, ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 9459e8cc7413..99bd68f705b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1249,10 +1249,12 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..17d27b12ccce 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -719,10 +719,12 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5e0066cd6c51..3dc0ffa81484 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2392,10 +2392,12 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index a7b9c358a2d4..74f57b2d30a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -415,6 +415,7 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 		err_type = ACA_ERROR_TYPE_CE;
 	else
 		return 0;
+	bank->aca_err_type = err_type;
 
 	ret = aca_bank_info_decode(bank, &info);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f0716c10f23e..980e610c2451 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1935,10 +1935,12 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
-- 
2.34.1

