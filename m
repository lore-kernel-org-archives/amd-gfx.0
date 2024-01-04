Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6084EC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A4510E450;
	Thu,  4 Jan 2024 11:49:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF36210E450
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3onjFmA6f70zUry5WbxfkgEBgDiFrySL/UQbVAELaS7xIBcJmCAe6OCRv28Ticv48ZpzXVtDtyQmKJcqLiebNz8Gf8k3ljtqKV5O9VzW8YNLWnLfvboxcdAhiZrNTds8Qpj50XeZ5K7WtWJcml8kaPze8tSv5Ili7WV5ivKecu+4jHhISQO7/7UjzLd5DDZjd3CzSkYniDNYg1bVsCz4DGkJfRrD7jHVPO1/n5vwjF4fx+Sn8TdBo/RlgMZwnGp+rzTMBxJs63VMTM/uiBKfSYqP9F/EXVoOmjW9D8HLy8VYHzOH2qRsTDi0r5bGa1KyGpHwDs2xyEEAer9eXraZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgtcSFIM58PElElWgO1PsMUCob1YF2UE2jXn5nrL+cc=;
 b=Bk3FL5A2ULqoN9jugthoWN5Wn2jSJa3rcNNx9CY6j0qrusekSu2v37hHSJAxX1oXrN8KbZPyfpgdlJI6dy0WjEmv3KyTXGG1XBRyXv8QdIOoCn22pipPrbX9nDSfhvrDiD3iTXwdKcJxqe2FE4dv/6Pt5DRkoSFFIsD0mVZAXTZ055Sb1o3xt/neZceP/9Kz2ymNZxk5DP0+eiRF45y6T/iSvoW89MEuE9/LMIlLA0SdByxlwZxG4GKozZiAw4Xls7+0AMsvDAkYHY8EuVn7YRsIetzwB7S6ttX8zWsH0LRjZdw/svysE5bpHkr3d0RSgzwUX6RWsIoJZHZOT/sXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgtcSFIM58PElElWgO1PsMUCob1YF2UE2jXn5nrL+cc=;
 b=FAQEziBmGKmonsrURumMy5rYfrOyqfKiQsxqMXCDJILhJAyj9Ii3LFqDZuOHPSGvLiUEXO2dvHnde49derrIZeWO2ShUr8aqPmbRbpRsy13CyTD7XkSnsscu1eHnyh8935FSqKvpxcY/tQSoYdDnxFDulP9H1EZEhSay7HoZknk=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 11:49:35 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::1e) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:31 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/12] drm/amdgpu: add umc v12.0 ACA support
Date: Thu, 4 Jan 2024 19:48:53 +0800
Message-ID: <20240104114858.3475783-8-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104114858.3475783-1-kevinyang.wang@amd.com>
References: <20240104114858.3475783-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f0eb74-5bc6-4f2d-1774-08dc0d1b38f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHJJ2PnfiYL+/8PaBXYPsenqg6SmkK7bnlHsJW1hYBmTb1terXN3kQZXy75Ow/66fWcqujQrDbhSiR4jhUh0FEDLeUhdh7aiB8S8uPm6/kzzKuY2zxlfu6hi21xmzglnDKt8v/TlMpWVDq1MWKSQi4Ub2uOIFNZgmFewPsyR8U7bQNStccJ14vsoegamH67uevC0xHUBmnPQoDjza2wPvsTMJfqaYWM5NW0VuaZxKJhRhgAhB1HnxtOwssv/2+HKBpyvMiPWnOIgyCA3QHgRrrLQl6H7Z2JllgZ1y/GuKiLeDci9W/x/T2xq7GdYk1+sAouS5Lj6NRszrQPUWMSzYW+b6RD64N0BmKaLUmUPP/mq/B9sJl1kBcvsS07RAdc/V1D0hy9nP6MezBAEuyk850xXGLNuxa50wv56SlodMJWFeHsuSltXVuRISJ3iYiSJfSmSxeXiPH48iMDHImGqGxhTxn1f56Yb51lyP+ReYf8JGtwmgHLbGBByLGOg6bmJPi+oaheQn1OLyt9VWX6E1l8vwT4gTIRyyp3rwQvhn3GBC7Ca5fOTw4rAfBG2JfSvgAjWz0bJE5g1EScp9PJznqlXbzXe/eZFeg7qjxmBygMF9BG+PqNWzbl0UbIkxAr8cmgpXpdHI8nJgRwLirzlZRjCO0mJR4h2M7jmWF/CDf2m+pUEnh3CUysK+9M1QSlvStUr/twPr3oUjapwFNIZIs16y+n8eVAQ2BX6iz08qAdyEHtMANQNf4sSjBNHZAo/4FtcJAEdvgDAq1nr7Bzd4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(6916009)(70586007)(316002)(70206006)(54906003)(5660300002)(83380400001)(8676002)(2906002)(8936002)(4326008)(16526019)(47076005)(478600001)(2616005)(26005)(1076003)(7696005)(6666004)(336012)(426003)(41300700001)(36756003)(356005)(81166007)(36860700001)(86362001)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:34.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f0eb74-5bc6-4f2d-1774-08dc0d1b38f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

add umc v12.0 ACA driver support

NOTE:
The bad page retirement feature will be re-implemented based on aca later.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 7458a218e89d..aa0ce6103dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -444,12 +444,72 @@ const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
 	.query_ras_error_address = umc_v12_0_query_ras_error_address,
 };
 
+static int umc_v12_0_aca_bank_generate_report(struct aca_handle *handle, struct aca_bank *bank, enum aca_error_type type,
+					      struct aca_bank_report *report, void *data)
+{
+	struct amdgpu_device *adev = handle->adev;
+	u64 status;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &report->info);
+	if (ret)
+		return ret;
+
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	switch (type) {
+	case ACA_ERROR_TYPE_UE:
+		if (umc_v12_0_is_uncorrectable_error(adev, status)) {
+			report->type = type;
+			report->count = 1;
+		}
+		break;
+	case ACA_ERROR_TYPE_CE:
+		if (umc_v12_0_is_correctable_error(adev, status)) {
+			report->type = type;
+			report->count = 1;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct aca_bank_ops umc_v12_0_aca_bank_ops = {
+	.aca_bank_generate_report = umc_v12_0_aca_bank_generate_report,
+};
+
+const struct aca_info umc_v12_0_aca_info = {
+	.hwip = ACA_HWIP_TYPE_UMC,
+	.mask = ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+	.bank_ops = &umc_v12_0_aca_bank_ops,
+};
+
+static int umc_v12_0_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int ret;
+
+	ret = amdgpu_umc_ras_late_init(adev, ras_block);
+	if (ret)
+		return ret;
+
+	ret = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__UMC,
+				  &umc_v12_0_aca_info, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
+		.ras_late_init = umc_v12_0_ras_late_init,
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
 };
+
-- 
2.34.1

