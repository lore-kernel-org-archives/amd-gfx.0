Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C73C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 04:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E906710E147;
	Mon, 19 Feb 2024 04:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tI9W5luo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D1110E0E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 04:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm5NraOELbpSBQoI+RK31yHloNLXLHOMgGzT2F3MJHRtE/6vyebwRaEGstg+smshutlMNLe1lcmG+Bqu4O0lJcLYOUHTuD3UpQFmh5hajJjrapIAaPIEW1r3YMIrAwtEdVNBjEkDOV6ePP1uvbHWnrSBtUdk0SWGj78iVgXD1gvMApfmi8UK+cGYh/I7T1Xb1lnZnvYQVJaSOC2gPZ9uA4VNk/YHjFsf1FYffiUVFIKVQNTcNAEeyldcUXg+0aQv5Vud4VP73hFey7rfCbb1Vouiatpz8etgN93eF5D7tfIA/5UoZurkRwR/4dY6K3V3XsHXHks/aRiaIIQ7GU/jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0x+60/BfxkRiloLDIEdv1Kw30yM4WRT1zDsG97Q6rM=;
 b=iALCrVxPXhX1/wYvIetmbiDaPzK2jpERV9KGevdOxoITYiD8N+w1lAl/Zu2+tuSWS8YXHYtMX9tzjiDVrY5b7bQ9MvyWxLXI4cnt+f1dQSKXD23AbB4sakwjln+XF6gjFBZCvtBWqYlFM16qhmBBPRyYDe9BMWbjuqXCqPUFuZdC45a9jcfEsS5T2Gkry9qdMSDKLDu0Zd72w8FvtLKxYYAn0SmjvViaM6Yc9S3rFSzS03DLYopUUjhVRiGZANtzFEIMJcV/AB250NWksAV3WhScet6rIYoFbUR59Znc956kCbAZcFtcFMI6+cnaVZE4W7uoI96km9uH8j5JI6rYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0x+60/BfxkRiloLDIEdv1Kw30yM4WRT1zDsG97Q6rM=;
 b=tI9W5luoVFD9bXYGkGOuI9IV+Uvze81GaikSG8xcLJe0RstpnBZmoT6oochEWG4GEcxUlDYxalt5QlWSAAZLDd4ucImQXXxZYi0RnsE1FJrdOqkbbKqjJbw1VoIjPnMb3WDww6QeTZBmGBpXtNC19F4z1u5A6fVI4VKAVxflt9o=
Received: from BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) by
 PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 04:00:13 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::af) by BYAPR01CA0034.outlook.office365.com
 (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 04:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 04:00:13 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 22:00:10 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>, "Yang
 Wang" <kevinyang.wang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add new aca_smu_type support
Date: Mon, 19 Feb 2024 11:59:55 +0800
Message-ID: <20240219035955.932526-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219035955.932526-1-kevinyang.wang@amd.com>
References: <20240219035955.932526-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 571a7d8e-f3e7-4c90-61c3-08dc30ff467c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIm3Uu82NW6acCukuRVFlj72/20FFMQm2yA/ykgp4KcLmwCD+nFCV1/Wh7TvSr8Qr2kUffWeTMJ3lYFDpDTw2ijfIlxFHzlEnoPm5v4vkmJGGqwZBIn2lf2zl9mYJUhE633qmMHq6L48xlloW7LiP7NLnyetxiRhlEZUqBuw+/NMP6IXk1dHKSpwU1+hXjFWUoBdbbaUaqMVwoxgSchViDZTJCjrapRa5fJiMK2+WyoHxqxyThNMXIKfELqboQJnkCuHbShGB+eSy8enoSxRx1269Ac+AuA0WpKB0lUJnD9ZQtBdxoGWAkFhxLvfNFMsQt5637z+1tYIVc1uRxv8WKR1iLFDyWAoQ3tkXPEX0AQ8a1MdtocpCdLqdk43fDBVczgBvVq4JFNqqEh1dAQ0sh7EopNslLlwhROkG3UoH+ehV15t4h7FBp8OBnfAReEDg2DLt42IDYfe3tTrkdpKgNyxYMvNK5JvgeczoKp7QjUhbhDFyEh6uG1XtRbMufXM6ZQRD7SoVdzxLM23K8hNfI830npzxhwlQDGpJMvhyME/62iYoQvvHJ77/6NwXzxhzj/i/0Dea/32aNg/yXcFaf3GlJGAmue48EVqvytSqbf+yjF2buTg+VpRvx9tDxYVwkVVLC1ORMjDR+ZEYs1j2OM4DPAfYLy9Wya7S+bAISI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(36860700004)(451199024)(1800799012)(82310400011)(64100799003)(186009)(40470700004)(46966006)(82740400003)(86362001)(36756003)(356005)(81166007)(7696005)(316002)(6666004)(54906003)(478600001)(41300700001)(83380400001)(26005)(336012)(2616005)(16526019)(426003)(1076003)(4326008)(6916009)(8936002)(8676002)(70586007)(70206006)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 04:00:13.5711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571a7d8e-f3e7-4c90-61c3-08dc30ff467c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

Add new types to distinguish between ACA error type and smu mca type.

e.g.:
the ACA_ERROR_TYPE_DEFERRED is not matched any smu mca valid bank
channel, so add new type 'aca_smu_type' to distinguish aca error type
and smu mca type.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       | 27 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       | 10 +++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 26 +++++++++---------
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 8c18dfb28030..72b7fe5d246a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -86,7 +86,7 @@ static void aca_banks_release(struct aca_banks *banks)
 	}
 }
 
-static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_error_type type, u32 *count)
+static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev, enum aca_smu_type type, u32 *count)
 {
 	struct amdgpu_aca *aca = &adev->aca;
 	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
@@ -127,7 +127,7 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 			 idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
 }
 
-static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_error_type type,
+static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
 				       int start, int count,
 				       struct aca_banks *banks)
 {
@@ -143,13 +143,12 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_erro
 		return -EOPNOTSUPP;
 
 	switch (type) {
-	case ACA_ERROR_TYPE_UE:
+	case ACA_SMU_TYPE_UE:
 		max_count = smu_funcs->max_ue_bank_count;
 		break;
-	case ACA_ERROR_TYPE_CE:
+	case ACA_SMU_TYPE_CE:
 		max_count = smu_funcs->max_ce_bank_count;
 		break;
-	case ACA_ERROR_TYPE_DEFERRED:
 	default:
 		return -EINVAL;
 	}
@@ -164,6 +163,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_erro
 		if (ret)
 			return ret;
 
+		bank.type = type;
+
 		aca_smu_bank_dump(adev, i, count, &bank);
 
 		ret = aca_banks_add_bank(banks, &bank);
@@ -383,6 +384,7 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_error_type type
 {
 	struct amdgpu_aca *aca = &adev->aca;
 	struct aca_banks banks;
+	enum aca_smu_type smu_type;
 	u32 count = 0;
 	int ret;
 
@@ -392,8 +394,19 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_error_type type
 	/* NOTE: pmfw is only support UE and CE */
 	if (type == ACA_ERROR_TYPE_DEFERRED)
 		type = ACA_ERROR_TYPE_CE;
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		smu_type = ACA_SMU_TYPE_UE;
+		break;
+	case ACA_ERROR_TYPE_CE:
+	case ACA_ERROR_TYPE_DEFERRED:
+		smu_type = ACA_SMU_TYPE_CE;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	ret = aca_smu_get_valid_aca_count(adev, type, &count);
+	ret = aca_smu_get_valid_aca_count(adev, smu_type, &count);
 	if (ret)
 		return ret;
 
@@ -402,7 +415,7 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_error_type type
 
 	aca_banks_init(&banks);
 
-	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+	ret = aca_smu_get_valid_aca_banks(adev, smu_type, 0, count, &banks);
 	if (ret)
 		goto err_release_banks;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index e650fed2e806..0fc9e266e269 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -99,7 +99,13 @@ enum aca_error_type {
 	ACA_ERROR_TYPE_COUNT
 };
 
+enum aca_smu_type {
+	ACA_SMU_TYPE_UE,
+	ACA_SMU_TYPE_CE,
+};
+
 struct aca_bank {
+	enum aca_smu_type type;
 	u64 regs[ACA_MAX_REGS_COUNT];
 };
 
@@ -167,8 +173,8 @@ struct aca_smu_funcs {
 	int max_ue_bank_count;
 	int max_ce_bank_count;
 	int (*set_debug_mode)(struct amdgpu_device *adev, bool enable);
-	int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_error_type type, u32 *count);
-	int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum aca_error_type type, int idx, struct aca_bank *bank);
+	int (*get_valid_aca_count)(struct amdgpu_device *adev, enum aca_smu_type type, u32 *count);
+	int (*get_valid_aca_bank)(struct amdgpu_device *adev, enum aca_smu_type type, int idx, struct aca_bank *bank);
 };
 
 struct amdgpu_aca {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 29c102fe650d..f101c58acc51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2974,7 +2974,7 @@ static int aca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
 }
 
-static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_error_type type, u32 *count)
+static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_smu_type type, u32 *count)
 {
 	uint32_t msg;
 	int ret;
@@ -2983,10 +2983,10 @@ static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_err
 		return -EINVAL;
 
 	switch (type) {
-	case ACA_ERROR_TYPE_UE:
+	case ACA_SMU_TYPE_UE:
 		msg = SMU_MSG_QueryValidMcaCount;
 		break;
-	case ACA_ERROR_TYPE_CE:
+	case ACA_SMU_TYPE_CE:
 		msg = SMU_MSG_QueryValidMcaCeCount;
 		break;
 	default:
@@ -3003,14 +3003,14 @@ static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_err
 }
 
 static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev,
-				       enum aca_error_type type, u32 *count)
+				       enum aca_smu_type type, u32 *count)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret;
 
 	switch (type) {
-	case ACA_ERROR_TYPE_UE:
-	case ACA_ERROR_TYPE_CE:
+	case ACA_SMU_TYPE_UE:
+	case ACA_SMU_TYPE_CE:
 		ret = smu_v13_0_6_get_valid_aca_count(smu, type, count);
 		break;
 	default:
@@ -3021,16 +3021,16 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_type type,
+static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_type type,
 				       int idx, int offset, u32 *val)
 {
 	uint32_t msg, param;
 
 	switch (type) {
-	case ACA_ERROR_TYPE_UE:
+	case ACA_SMU_TYPE_UE:
 		msg = SMU_MSG_McaBankDumpDW;
 		break;
-	case ACA_ERROR_TYPE_CE:
+	case ACA_SMU_TYPE_CE:
 		msg = SMU_MSG_McaBankCeDumpDW;
 		break;
 	default:
@@ -3042,7 +3042,7 @@ static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_t
 	return smu_cmn_send_smc_msg_with_param(smu, msg, param, (uint32_t *)val);
 }
 
-static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_type type,
+static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_type type,
 				     int idx, int offset, u32 *val, int count)
 {
 	int ret, i;
@@ -3059,7 +3059,7 @@ static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_error_typ
 	return 0;
 }
 
-static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_error_type type,
+static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_smu_type type,
 			     int idx, int reg_idx, u64 *val)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
@@ -3076,13 +3076,13 @@ static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_error_type typ
 	*val = (u64)data[1] << 32 | data[0];
 
 	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, val: 0x%016llx\n",
-		type == ACA_ERROR_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
+		type == ACA_SMU_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
 
 	return 0;
 }
 
 static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
-				      enum aca_error_type type, int idx, struct aca_bank *bank)
+				      enum aca_smu_type type, int idx, struct aca_bank *bank)
 {
 	int i, ret, count;
 
-- 
2.34.1

