Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FCDC47077
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3DB10E254;
	Wed,  3 Jan 2024 08:04:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC85710E254
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3oT2BSkxJ7/8IWB8wYCrQVryXivpPM2IPGuzTpGjjjl2rwdQEtZBxlIdgKIkaWV3SmVL+5rixsrYHSKWnkEqhMH0/fzX6b2F3xeEGJl4NfrDrhAa2/s+qdGrI1bzblQl3tY0xaljNYfKz8zK1mNxtuhLWQ7YNgX/TEilh8cWuFtW+xpYHNUbcI+5xVnSTuz0fQgNJtjFlfOpSP4F0GTz2rJxv9yCKaztfOiEdTmReYNJMUtgRjbohb1qejtuWqpJTBPOuLYogVTk93OCK9ptemFyKDEkYr8AMvslXoSM5eYtcNczo2d9bqJn4rUDRvY5J2X0DaVF2Ia/SWLCAp5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWSis+/Ozz648A//G87Vl4S3Z/IPnRLYYOecLc0V3D0=;
 b=hWupxBktlAvLDCCekFWHuZnvUm9REoIbOaY7EYJdiSp7gyKHGljUFC/II+kv/yRn6uAHb5AjpuNWfJYU5JrLeTgVi3k50ACTmYqlUUJZ+KDYsPGVUljGFkanUieS352NiuDVnpWy/8RMp+XoLoxkm5ydyW6osoyET+UPOLsnJfuemIYI0vhf3sICMVfCbaAarH6WPFYSWgGQdZrGnTxKxH7MHgPRr8UuIS7VcyNDEMShkkOlIV16gcGYJb2x7BnlYBtgnxr2N5ig0kZyNg1aJTh96mtRC0lWn6we5qh91EZhlYDFW8GLYbtlLP7foNU8dTRvVN/mpj/CpHGHVv1gmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWSis+/Ozz648A//G87Vl4S3Z/IPnRLYYOecLc0V3D0=;
 b=eOtaw6jEZ2ZTQx/MtzTmyKeuF44NxIVgS/QAyqsR6p1NKpP9WH9MCQcQP5S065cTrUrpkWXLAn0077mbkHKS8SG/qhO13trsZSI17lT785i4zLfYC/lO8PpG7fCd6Js9uHitNIIPG62V1Omh5rSwzkGNqSKKx9AOAzN2CE6BUz0=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 08:04:01 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::81) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:04:01 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:59 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdgpu: add xgmi v6.4.0 ACA support
Date: Wed, 3 Jan 2024 16:02:17 +0800
Message-ID: <20240103080220.2815115-12-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c074db-7011-433a-d3b8-08dc0c328bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvE/FRnLkYEtIyZxOvCHYNWDBgqegNBatVnpKcptb5QfysOe+ke0kDk7Dr144cEHlbjuIqGSi6F0keLZON1lpKtojhpBotw+CYdA2Dce1LKcFemW3avAdwou4Q8QjlQutScxtj/HMY3ElD7EqeFgOPnc8nsNPMWA48ZKQLKEP0XwSGPCfwsX5zHUO08k+RTJSrZac00VXGW4a6AXU2hWuu/g7gsSqKZFusb4VLKs+PTcbJAuZDbMWMMIklpQzcnbzo/zKcxYB6TvROTy06q79ATcT0TNizKwBZGLuIhQwJWcwaOdMFLIujxD+XcnmphfUy4AyL8+St0zQN5TNUJzPMvpD7KTf3Y5r69ZtfKkEB3BbqINHO3naNA+bh3UZTTInKLwiUAKS+zdqGUm7Ed5cr541Vr9Xsj3E8oRBNk5y9OLu+aQGIgo5iKKQs9g0rXkiEslkkyrs2i/SYnHk8QYIpZUk2g+FtlPBEAPZt/drHxfdJIBdZFRQ46XYhB+FEahtM1nMdvCXr2/xGG4FiefIPwRmpis5xJCk9gSGr3MbcJpK4GdxFq+DrXSYl2cE9H4rNBk/aYAwgrXMn2aHSRQfOjqUQ2P8mNCz5/M7lJFpb70L9Nz2B7Dyk160+rQpZzxx+FTWSnAhwSM8mhPxbeYL972Vfih6Z3BksKUHedyeXlSFONwumXnyc+mDD1pcRYDY9Gia8yz5DIsan1sBg7fu8W8aPK32oiMJzBIjDfwhN+XoJv13Fc0wMi6kSHcWbiUTHim30AOdNG5HqAAukRV5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(426003)(1076003)(26005)(336012)(2616005)(16526019)(36860700001)(81166007)(356005)(82740400003)(83380400001)(70586007)(70206006)(47076005)(36756003)(316002)(6916009)(54906003)(478600001)(86362001)(5660300002)(2906002)(8676002)(8936002)(4326008)(40460700003)(40480700001)(6666004)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:04:01.1479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c074db-7011-433a-d3b8-08dc0c328bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
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

add xgmi v6.4.0 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 63 +++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index a6c88f2fe6e5..61208ca94442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1035,15 +1035,76 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int xgmi_v6_4_0_aca_bank_generate_report(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type,
+						struct aca_bank_report *report, void *data)
+{
+	struct amdgpu_device *adev = handle->adev;
+	const char *error_str;
+	u64 status;
+	int ret, ext_error_code;
+
+	ret = aca_bank_info_decode(bank, &report->info);
+	if (ret)
+		return ret;
+
+	status = bank->regs[MCA_REG_IDX_STATUS];
+	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status);
+
+	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
+		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
+	if (error_str)
+		dev_info(adev->dev, "%s detected\n", error_str);
+
+	if ((type == ACA_ERROR_TYPE_UE && ext_error_code == 0) ||
+	    (type == ACA_ERROR_TYPE_CE && ext_error_code == 6)) {
+		report->type = type;
+		report->count = ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]);
+	}
+
+	return 0;
+}
+
+static const struct aca_bank_ops xgmi_v6_4_0_aca_bank_ops = {
+	.aca_bank_generate_report = xgmi_v6_4_0_aca_bank_generate_report,
+};
+
+static const struct aca_info xgmi_v6_4_0_aca_info = {
+	.hwip = ACA_HWIP_TYPE_PCS_XGMI,
+	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+	.bank_ops = &xgmi_v6_4_0_aca_bank_ops,
+};
+
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
+	int r;
+
 	if (!adev->gmc.xgmi.supported ||
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
 	amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);
 
-	return amdgpu_ras_block_late_init(adev, ras_block);
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+		r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL,
+					&xgmi_v6_4_0_aca_info, NULL);
+		if (r)
+			goto late_fini;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
 }
 
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
-- 
2.34.1

