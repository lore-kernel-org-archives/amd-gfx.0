Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2DDD10DCF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 08:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE7F10E662;
	Mon,  2 Dec 2024 08:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MT5Sglwz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2893F10E662
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 08:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LorP+x/d76VIpsa+LS/IViQZGGADEMXAcHz1+iQfG6d+Xnoq2C9Xq0UtjQ4rxN98roEcNGQ+0qmdTQlyKbM+IoQN70TXpRzXAfIGg1ny8WJK72OKfMwjug4l7wie1XDrVhjNVvjUyWWATR1Q9aBRIeER+Mj6fOGelkRQsw1+gbGaBFzf8oIy4cbggAlGAB4h0gJMbUSTpCqzHNq1ALTEGHDDFaDK91H2PdKvoU1CIVmpjkdTef1j4Jj5k3WVVnkwRMEjKEj82j8z50riuEm7FEQHowHLVsV7pbNp+6xMUsVinLcNKbPAtCuYgF/PAfFVBl3i/t32SieCzetKetUIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mkvQQORvGLZEJLikn9JwzMzfdBzxrxNxDda4RphUqg=;
 b=zT8Ch0SjrpezcCiViAp14gAhTjmuhwLM88c3NV8gREx4iHVIr0Kq629WnMujBLAbiwL7lV+16SrXHOqQ0HA5kgUPgxuMuPi9KmRHLhBeabb0xhFa4tO9Uxl79pPwHP+tIoxSy1Zgo59isAh3Ned5f/x2036fFJqOlzwdjApedz+X7042W/BprNYSFy9CHjK6AouhMJQDh4x6sC+aeQaD2MrDePPm3E2v/rQYSCsYnhHvzGWnqN2silCl5ooOcuZd/dQ5x0ogoTsfvzso1T59NJD/6/2WtF8BGnEEQpj6EUquWizpmUiPA+PM0IaU44HqYvnF2giMv7Vxu7Gw4g+xrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mkvQQORvGLZEJLikn9JwzMzfdBzxrxNxDda4RphUqg=;
 b=MT5SglwzjJz9crKkpkK30hnfH+PhHuJRVH6AphO88NNEALa0CvZosYU9+WwIhDPi9IapECjUelFYm2vd1S8gYzV8YqDrmu7U12JupYDK5G61lBQmKUGb4rkarTo8P6C7Mv/I/Hmb7waIAc67t4g+gt3A1/SUBn/7ppHZY6pPG4Q=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 08:49:06 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::c0) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 08:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 08:49:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 02:49:04 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <stanley.yang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add ACA support for jpeg v4.0.3
Date: Mon, 2 Dec 2024 16:48:50 +0800
Message-ID: <20241202084850.1960341-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202084850.1960341-1-kevinyang.wang@amd.com>
References: <20241202084850.1960341-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 990ef074-a374-442f-b7dc-08dd12ae2ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4tKbYqtZmvl6ZYz5RwSknJb1y5xOwP77R96BqNjSxWCGHqJ/AzWgVLRzud9L?=
 =?us-ascii?Q?I2cbNQ8YKJpyaqm46GXBiLhE9Zamo5/EQlVWVIZtYfG/UO1kWOVGQ5BbZAS3?=
 =?us-ascii?Q?672GV0erh9UfndhPKIQezfM1X2maE67cdDHsSMbQy7TeZo9djmR8uV7orrOc?=
 =?us-ascii?Q?cIJNP5vkMx8gteT2bfgLD+/Fw+sP3PAGxZanZqn1s6j9Zh6YCKG1CYPl+Wwk?=
 =?us-ascii?Q?hbrWAcuDG25Gvxcf43tZsYwy9bwMrtAlKJ+iVeX8EdVPlwrCTcBTFPImE5GD?=
 =?us-ascii?Q?wWpwZMXUWzeh8xlxV0wSBDwgAJTv0sTL25vu7LiX8wZf27j4Oa1StBg41TFk?=
 =?us-ascii?Q?QnQvr2DtUjPDZreXq7ALG4k2jy+EQP29zg88NHSdGyPgSsLB563MG99gRH36?=
 =?us-ascii?Q?Lv7LUKM4UYGm5LPkV090FHAQ8O7M+EK+Xebz8DlTrHdOdqugo4ksRGWj0v2B?=
 =?us-ascii?Q?45cbx0ynZAEpGZGJ5TPri7T+Yuw5dlGnzzcaBc2eYKsIcznTe4dHeCgBePuk?=
 =?us-ascii?Q?5d5LlXY5x5fnQYTBTTmoO8knG/p+rTVuN4+5DqD8RSkankZJIl8no87Cm+5W?=
 =?us-ascii?Q?38Sb/nXGVeCZQHi2p+aybVsBIiIY8ca4SJ4vmNIGKXad9cPBsRKlUxbAY2VX?=
 =?us-ascii?Q?C8q8hyVjh6bCK42yuLCXMPpaVYvijkPFZrlcldn3G6dEpDVqxGlhIbXc0z0F?=
 =?us-ascii?Q?uzo1k7ynaTFG60y3+zaIgbTuoyHDPk+lncQfGZPgjXhTIQn6rcoPVGaIO5oO?=
 =?us-ascii?Q?yFeqqad4QX8QpQlOvrl85Gq1BMs6Vyuj4v92PeaO8552EUGZ2w5yMdrHMQTe?=
 =?us-ascii?Q?7InV/CWNzXU3jQs+3PSyoO8JZn9JNuGmBWEhEch02/BlZSpEh5Msol/7iDZa?=
 =?us-ascii?Q?KTH3Q2FyeV1eaXJYgbe4wl4C36HXMI6rYrgUIMCOFsoAdgBXaSzwdxWj+pjM?=
 =?us-ascii?Q?cKCyh4KDU0cdX5IanFv8N2egT5qRImLARlx/MiawToB+HnZAzqFNDrufJX+g?=
 =?us-ascii?Q?IsvMONHlY+Ubsj1wM4R6OY0csGyH+7HBG9JfhG723HUtJldvuQSjsGW9SuHm?=
 =?us-ascii?Q?KhG1xCgbZdddHquUOgvp8O4ebnjoRX9CrbXiBDdLr55XyNAGnYrLTmivB6aR?=
 =?us-ascii?Q?tnRHoZNAUOCuuQY5qbcWFF2YUmqRtM5qN0mVh708bem6b4TgU4AxDonWN6P6?=
 =?us-ascii?Q?xHRdxgbnv/LumTB17r1euhwffhE1/PxKyiAJIje/j2fmZ0iDMu2CtTifSebU?=
 =?us-ascii?Q?K0EaXe3+c1P4KwbaV6UPpIXiOV19Xd/5+y3BLsG1NAIN9QnNDZzTt56t7LAM?=
 =?us-ascii?Q?E0k/Cc1O/ZGYhiKYMSENlJi3MyQctrc85TAbeaTk6fnM9MFa+kz71xz+BfRC?=
 =?us-ascii?Q?3tVMfin5EeL9tFagipscMmYjw19y7HgvQgP1bJpjC6aFLYNEQknpRN1ovJc/?=
 =?us-ascii?Q?zCvkWDIeOUgqktWCx59VlYdOZGAQFy4e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 08:49:05.8902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990ef074-a374-442f-b7dc-08dd12ae2ddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

Add ACA support for jpeg v4.0.3.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index fd040b9cc93e..fb10ae873e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1231,9 +1231,95 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
 	.reset_ras_error_count = jpeg_v4_0_3_reset_ras_error_count,
 };
 
+static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						     1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_CE,
+						     ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int jpeg_v4_0_3_err_codes[] = {
+	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
+	24, 25, 26, 27, 28, 29, 30, 31
+};
+
+static bool jpeg_v4_0_3_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       jpeg_v4_0_3_err_codes,
+				       ARRAY_SIZE(jpeg_v4_0_3_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops jpeg_v4_0_3_aca_bank_ops = {
+	.aca_bank_parser = jpeg_v4_0_3_aca_bank_parser,
+	.aca_bank_is_valid = jpeg_v4_0_3_aca_bank_is_valid,
+};
+
+static const struct aca_info jpeg_v4_0_3_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &jpeg_v4_0_3_aca_bank_ops,
+};
+
+static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
+				&jpeg_v4_0_3_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
 static struct amdgpu_jpeg_ras jpeg_v4_0_3_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v4_0_3_ras_hw_ops,
+		.ras_late_init = jpeg_v4_0_3_ras_late_init,
 	},
 };
 
-- 
2.34.1

