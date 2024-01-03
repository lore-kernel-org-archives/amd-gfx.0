Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D94C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CE110E25B;
	Wed,  3 Jan 2024 08:04:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C0410E25B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzPtebScMf3brJMAg4lquSdUaUPSCPIJn0ntslFwgAX7fCwlJgu8SJxPe5wLW1KE0JVkoDRU5hVPQhyVoegiX/u+JTxNwV4JSUJlYxKKJ11UzCP516naafPy1gUrM6v+emO6A0JlVRWDGpqANWB8jmHenwBUzaUD123rrHD04s132I0evvgtEIaVCCyGkL98lJhxsDCWivt4J7+ZrSiUuaqo3u1LBTUFAuV/1eWhRX7qZnA/YeFNN6JrDFRiQtUvE+tB/haF1RiQqNkR8vJmannr7pUrw4n9SRCjwC58AO6miZC/2OtUPHfspygRrtkKfuJH6RX2cht75WvpOlR6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEJpS1KE6cPc6i+zL4aISrJhDFHkG+PZmPZSS0jHafo=;
 b=do4iFe2E6ah7kBPDAk0PnWCa3PVhyxGwUGajYU0dUN44umYEctoNH27W/BaKLTVrBByTpnkWIbpIbmUgH9dxKg65xVxSW2BEzSGIHqxCUz9CZrPTJmTNded4k/mhnrd5qSFYRfBB3HcIpHtZIgmsHoS6X2KR98Rnf8i4lS6ZDrXomzgGPdOSdX9wYnBxSNaIPCTLzvxeX4YAB3jT2rY+Uy06pGxAwlsv/dGQizJht3MyHVrEYvTxtGtJVn+l89YB8BJJP9055d2XJG5BTvQLLwtLKzOYdJmWAWDsHq2uSPhP6vaKfXBR64dZ00oYpFOgyvJ5hhewlCT0aH6/FlNinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEJpS1KE6cPc6i+zL4aISrJhDFHkG+PZmPZSS0jHafo=;
 b=kzX7DLAqdsyHt0axMiQQjlxXO1WBNMSjkCisqtxx6S1pHdMUvJ2w8p+/FPw7sJmzB3wpw033M1yezxbCCKWzsomU85vdsYtZlviVdFiCtG8OA+WHslax9s05s2SuRQQ6lJD6W7QvaREecWvdXH90BhiUyma6ktN9N9OL+8aoHTE=
Received: from BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:04:03 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::77) by BYAPR03CA0024.outlook.office365.com
 (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:04:03 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:04:00 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdgpu: replace MCA macro with ACA for XGMI
Date: Wed, 3 Jan 2024 16:02:18 +0800
Message-ID: <20240103080220.2815115-13-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103080220.2815115-1-kevinyang.wang@amd.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d56a945-6133-45bc-637e-08dc0c328ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhrprDaa2ejuakKYycnV5NFK7suVMjhM3b16FZWJ9cg6uKzz2n/IHWbK0UahtYUG9x70+f61b0pFfpK+Lf8KlPnrZ7f6VDuIhBdqbNbSOBfY4sH44LOooQQTLjGtwkHDvJgdXnut1eL4D+9a4mX4s++PR/umD8ZMk8+nrO4MIkg1udLVN+bgTGwjutX3mg+GWyJzaTiqAKRkUjPC9ZIRhHIcyINNrqaoypfwWgtupQXoeEFt5/fRTkfw2L2+D1u05YVw0bPOieCCDz+QShe16Qnym0BJ4RIHTyX/EbyOwmIzDu6iZyzIfzS3uoTOEp3kFQbRkJaeWlL/dMDCUqpg4oHIRiaxUJAd90QN5w/c6R5Sdtg50UEX8/5dE+qCl8ArJyyin64jdzTdngkagjaAQg0hYcWcPptJRbhiUKHeAtPOb9paG6PtGjXjbU/rWBAHFBtKR0xsZ2vwWexn5c1Zr+gplWVX6xIiDmI9AftGb9ftX9jGi25vKwX1ItnGVGVf3mTdpJ1o7M+vvz/j1FK0Hgzfjjl6/TM7IMQFZO+jNKdub6Epk0CbYB1YjTIRPBCTjGXZzD//pV9WicmIfBDeroWt/V7Y0cUvI7ImLmGHHsd6EE1qdVSlI5y7T8JAIE1Ro4IV8yzPIvty69FqArsWypOClphmRAuknp/488pOrxZPjep/zhwTv9e21SRlybh9lNtu8onSTuAlf2MZh82pAxBMg0F7EWsGPNnQGsZiM81CeSef1Ygs+TCE68m7+LrrwTbvm3XwpRUIdLf5HJNCag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(26005)(2616005)(336012)(83380400001)(1076003)(16526019)(426003)(6666004)(7696005)(70206006)(36860700001)(47076005)(5660300002)(4326008)(41300700001)(478600001)(2906002)(316002)(8676002)(8936002)(6916009)(54906003)(86362001)(70586007)(356005)(82740400003)(81166007)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:04:03.0365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d56a945-6133-45bc-637e-08dc0c328ce9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use new ACA macro to instead of MCA

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61208ca94442..dcfa02d17d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1047,8 +1047,8 @@ static int xgmi_v6_4_0_aca_bank_generate_report(struct aca_handle *handle, struc
 	if (ret)
 		return ret;
 
-	status = bank->regs[MCA_REG_IDX_STATUS];
-	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status);
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
 
 	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
 		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
@@ -1160,7 +1160,7 @@ static void amdgpu_xgmi_legacy_reset_ras_error_count(struct amdgpu_device *adev)
 
 static void __xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst, u64 mca_base)
 {
-	WREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS, 0ULL);
+	WREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS, 0ULL);
 }
 
 static void xgmi_v6_4_0_reset_error_count(struct amdgpu_device *adev, int xgmi_inst)
@@ -1338,12 +1338,12 @@ static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += ce_cnt;
 }
 
-static enum amdgpu_mca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdgpu_device *adev, u64 status)
+static enum aca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdgpu_device *adev, u64 status)
 {
 	const char *error_str;
 	int ext_error_code;
 
-	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status);
+	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
 
 	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
 		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
@@ -1352,9 +1352,9 @@ static enum amdgpu_mca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdg
 
 	switch (ext_error_code) {
 	case 0:
-		return AMDGPU_MCA_ERROR_TYPE_UE;
+		return ACA_ERROR_TYPE_UE;
 	case 6:
-		return AMDGPU_MCA_ERROR_TYPE_CE;
+		return ACA_ERROR_TYPE_CE;
 	default:
 		return -EINVAL;
 	}
@@ -1368,22 +1368,22 @@ static void __xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, struct a
 	int xgmi_inst = mcm_info->die_id;
 	u64 status = 0;
 
-	status = RREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS);
-	if (!MCA_REG__STATUS__VAL(status))
+	status = RREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS);
+	if (!ACA_REG__STATUS__VAL(status))
 		return;
 
 	switch (xgmi_v6_4_0_pcs_mca_get_error_type(adev, status)) {
-	case AMDGPU_MCA_ERROR_TYPE_UE:
+	case ACA_ERROR_TYPE_UE:
 		amdgpu_ras_error_statistic_ue_count(err_data, mcm_info, NULL, 1ULL);
 		break;
-	case AMDGPU_MCA_ERROR_TYPE_CE:
+	case ACA_ERROR_TYPE_CE:
 		amdgpu_ras_error_statistic_ce_count(err_data, mcm_info, NULL, 1ULL);
 		break;
 	default:
 		break;
 	}
 
-	WREG64_MCA(xgmi_inst, mca_base, MCA_REG_IDX_STATUS, 0ULL);
+	WREG64_MCA(xgmi_inst, mca_base, ACA_REG_IDX_STATUS, 0ULL);
 }
 
 static void xgmi_v6_4_0_query_error_count(struct amdgpu_device *adev, int xgmi_inst, struct ras_err_data *err_data)
-- 
2.34.1

