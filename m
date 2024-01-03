Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61143C47079
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 08:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E499F10E250;
	Wed,  3 Jan 2024 08:04:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8104910E249
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 08:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEIuYOHNoiqs7rv+XVGk3hpjYTzx45XLOxKPURZ1h8B3K/iAO9isJT0VfvKaBarG4LCG8YimUKxuSttobh0lIcsSECXzKnz0CaVwHPxRUYncaGiAsd72xyofrsYe6IAKNbAhB7Xwb3F+yI/G/9Mlo4INoiMwr4v/ij3YRj/Uk1RAOd7HrUKX8ectJ1HW3tvPW6XY8p7Vy7DavIlESQWELVNlJ48VvMhrztA6xjOOdB0NpVrSUNvePpc+9XDhGfmCeXX1W4BG/2XDXj5wgrD0h2WJGYkVBPn2RXZnSgfpwyqyFv4UxFNQRjwEfdmG8tz0kujc/33rs3OE2iE7NanCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di9gxYyGX1+a+B0rBciRUS0+UVjBmaaPvvIQf5XHmLE=;
 b=QpaC0wqbCjgjzi1yQZDdL2BIYpHeJqRa7FPN6dCB0Qxn/F/YgzA9iPQNv0tX4mxdzmHb0bT/0O+J/rdD8z7WaITSTLLPZRhrzHGZg/oiXu42JVw4cfkfL9O/iZe2vj5GQqOyldSFeXrL6Ifr6rhtT7UDupkEP4BhXVz5oD8lXSHaZ2IpfC1GRwTLqqlIK44u+OhALukZDGxCnmPGhnCpHwiIDyGJCJpcPbgBaNajNmxpBCn5d/aQsv4PkbNXDiQXsWMLW8IuOHRow4B7WOAVJBnNlcxcKAIKptPK/5gJnx9kVSGhO4cbmzbathIsX5UBrGYzuZdJ73ldeWZYX1sy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di9gxYyGX1+a+B0rBciRUS0+UVjBmaaPvvIQf5XHmLE=;
 b=4ZiudqxAW52eStH0uOB+JDkrpqsFNSICZvEdKJzOPP5UMQ0YT0OVRR0829uRuDA4sK5oZqU9/pVT2Jz/4GsKssMEPJvfkNyelHhPEBegepogqdS5gB9eADbWq/zEYoJhWO0Tnc75o3Upb5YGSoAd3EQq6Bi+054AlkxAyABkO2Q=
Received: from SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:03:57 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::82) by SJ0PR05CA0047.outlook.office365.com
 (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 08:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 08:03:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 02:03:55 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: add sdma v4.4.2 ACA support
Date: Wed, 3 Jan 2024 16:02:15 +0800
Message-ID: <20240103080220.2815115-10-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8f409b-6ad1-4c23-667e-08dc0c328988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22FnEmK0VKVCMbRyYfVSgI4WWItrSl+K0r2+S8bkjNSX8mbmMWCxLXKAbw/5vYfcY6JJvtOKy3cP121i2OKKMcSj7Vqe3dA/DtdXfYyR5LKMyPe0t1Mwye+5PqcWJo8N9OBe6D0b1mBOM/Kf+PkIEzNGyS0CzTXlPZc1421N6be34munZbU4vrZa0NbxzmhF27BEHfLYfRN8diChRFrWK3/wbhxHkex7OqhKljXt3Kd6XvuT6FVyOlIWvEEeLj+ODk/nDGYHo9kisWJJXodguiEmzH3Bbm5IGPoWrdd1W4PSMmoTOMknBjTu/SocE9JnMUg7/tk8HZANO4TYVrG7ZPu4W6DrWCXm1+1oKF2ZU/yGFA7QoDTuhMNEhiznDAXjnzgCLnmfiSOQSpxgoXwfNhT253BR0tY3OqLpk7Ot5uGfTJTfaHS/w8lZi9PizViEPj2aMUwbLL5tnMk52rDREOEGbJ/Ko2xnU9H91imO7+ofhorHOpcOIHMKqW20pfu67LhUhU5oBb/m7ihO6tUMZAWcHyc7vIQAxYB0rNaJSd5OKwHWUijmnrdSt6MyPaTVtiOqFgC1IXXq72x/ut76GI3uQAE0WzrBVH8klECBjoEM+cWEJKCSwrimrGRajzeerWYldJQiwpwNFH9Fe7kG0BlpZCxwIgQBZnppWT2STBvyACUDba7+nMn/Xib7CSXiVZkrsepUQVLdt+qhayXaKfvSlsutaSzGKrny9clk/u/6OmGulQVpY7xtZepLqd6aWBn8DSQ99tPxCTWsW/s7IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(46966006)(40470700004)(36840700001)(2906002)(356005)(81166007)(36756003)(86362001)(41300700001)(336012)(426003)(40460700003)(16526019)(8936002)(478600001)(8676002)(47076005)(83380400001)(6666004)(54906003)(316002)(40480700001)(6916009)(7696005)(70206006)(70586007)(36860700001)(2616005)(5660300002)(82740400003)(26005)(1076003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:03:57.3833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8f409b-6ad1-4c23-667e-08dc0c328988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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

add sdma v4.4.2 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 80 ++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 2d688dca26be..01e002e298ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2204,9 +2204,89 @@ static const struct amdgpu_ras_block_hw_ops sdma_v4_4_2_ras_hw_ops = {
 	.reset_ras_error_count = sdma_v4_4_2_reset_ras_error_count,
 };
 
+static int sdma_v4_4_2_aca_bank_generate_report(struct aca_handle *handle,
+						struct aca_bank *bank, enum aca_error_type type,
+						struct aca_bank_report *report, void *data)
+{
+	u64 status, misc0;
+	int ret;
+
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	if ((type == ACA_ERROR_TYPE_UE &&
+	     ACA_REG__STATUS__ERRORCODEEXT(status) == ACA_EXTERROR_CODE_FAULT) ||
+	    (type == ACA_ERROR_TYPE_CE &&
+	     ACA_REG__STATUS__ERRORCODEEXT(status) == ACA_EXTERROR_CODE_CE)) {
+
+		ret = aca_bank_info_decode(bank, &report->info);
+		if (ret)
+			return ret;
+
+		misc0 = bank->regs[ACA_REG_IDX_MISC0];
+		report->count = ACA_REG__MISC0__ERRCNT(misc0);
+		report->type = type;
+	}
+
+	return 0;
+}
+
+/* CODE_SDMA0 - CODE_SDMA4, reference to smu driver if header file */
+static int sdma_v4_4_2_err_codes[] = { 33, 34, 35, 36 };
+
+static bool sdma_v4_4_2_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					  enum aca_error_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != 0x03b30400)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       sdma_v4_4_2_err_codes,
+				       ARRAY_SIZE(sdma_v4_4_2_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops sdma_v4_4_2_aca_bank_ops = {
+	.aca_bank_generate_report = sdma_v4_4_2_aca_bank_generate_report,
+	.aca_bank_is_valid = sdma_v4_4_2_aca_bank_is_valid,
+};
+
+static const struct aca_info sdma_v4_4_2_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &sdma_v4_4_2_aca_bank_ops,
+};
+
+static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
+				&sdma_v4_4_2_aca_info, NULL);
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
 static struct amdgpu_sdma_ras sdma_v4_4_2_ras = {
 	.ras_block = {
 		.hw_ops = &sdma_v4_4_2_ras_hw_ops,
+		.ras_late_init = sdma_v4_4_2_ras_late_init,
 	},
 };
 
-- 
2.34.1

