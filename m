Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF2C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D36010E460;
	Thu,  4 Jan 2024 11:49:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C0E10E457
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzCekw2MJ12ucvj2MnqTRu7QZbvRDsXaXvwXLWJMiWgYHixiZ6NtScFKMY+Ne7lr0jVyTCJXrSnR4EoAr6BqvcUBhPdzHIeSpkqbIcvWh86vcreAXFhpZHD8IhNFUuHOUUdYgDH8M1FgfhyE2hazn+N5LWbCrkdHZUV52yk6rrZU4A6WjhxvpzNeOAL0HgX2UuR4tdV5VRc3DyxAZCT69ypBrMGacEOQtTAIZ604oCUv1vQbSZIUF+A7BwINLvzt+2irba17Kue9pDd93QWBZGEVqxNoMVC7bgAy3TV/zckbAIQIG9S8AHQ/7nbyIaF92CADWX5PyRnwk6DjCLS9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWSis+/Ozz648A//G87Vl4S3Z/IPnRLYYOecLc0V3D0=;
 b=T7058qscnSHc20tlrUKQwD4gmnj91cYp+7F0J+MHdDL/DJLVvqCmOtoy0AKqkP2a0WE0jwnSXCDoupIB6dzGN7JKI8JUiMY5hI+J0jojmTyqFitBfVYxxlQeT/9qARRYBpMHmyaK7yqSogCOll4EScepESuP+o6ZpaX73Ou0h6WHe2+XGoYvb8cAseQJHGr8PZoTD3iZHZ8LbeOcKmv2R+/jD2UnuQRfViLEq/WGHTVsfLoX1FUacPW2BAMRJlvckkiekhMNf4p1t+RIgC0vH19w2Xd94/B9WUpsfia60cLcZf2vkaCurtidjGLs+4la9t6moW79xhHtw7JjRlBwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWSis+/Ozz648A//G87Vl4S3Z/IPnRLYYOecLc0V3D0=;
 b=gXxbN1tcro39/O/G008gWvpm5tw2TNE8BOq3CMbW8kn44dQKcn5/RJgU95k/bDMSW/Cp4BfrPoTx3fRfbkXLCGoMOiEGDRzOpln62TW4T0iwhA+3xGgTeBKtTXmhA0OKqLvCctpl80hEJtPyHgmhKYKwAoNHub8gJi1ugH9uChY=
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 11:49:41 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::65) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:41 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:39 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/12] drm/amdgpu: add xgmi v6.4.0 ACA support
Date: Thu, 4 Jan 2024 19:48:57 +0800
Message-ID: <20240104114858.3475783-12-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da8c8e7-c494-4514-c79b-08dc0d1b3ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cWO35AaSHjq+Gj1Xwj+BdHg1LZFZmrcF3K9oCySIr4kRMyAXxdWFKTA0ezjUjDnpfDWcWrTCx1q70kol0SLyOQc1kaMewJ8KNOAHuQwqMrkOmyuFnrqpZKy2ya2fHvnP+BARSOSNFG0x3czJnQF5bAuiSNTCd2+eRfz/pmP3p4TJ2Ws2pIqIaFflJZUXdpDb6MCds26DF3mnoS76t0q41DxoFcEyT8ey0ngUEJTYuKSYEXDtR/RdHRDD9ZHLA038R3e0SM5g/53gJmNaeu419b199/+NqX8mNfHrIU29etUbON0ulNyHE2SX2Kz2u2Fj1jxu7/gSrWmotR4Tf5wuUOtM/ibcV2L5m/XgVsXV5/wy6EUvY4q4L7ZHy61oQpTOPdCOvK8jytm6C9UlciSz54o153OdZK/sMBMGOgMFe2YSEgAycdX7KMvOQEAWPLk3FYFDmU/W0OlvCV21NVA28iybhSfuHCvvs3ebv3SQcpKLSdDgb/v9ckqdw3l3qz2V9Hchp3ZXX/FUl4erh9W/jpU4G3CwNv09hoMbdcv+NjlWKhH2z75WzJab4Tr0b0VkKrj/DaKQpD3ToTDNaLkvyH5fsM0X0LZvmgfhPRW01dmWtKhNqUVpcC6Px3BV0LpnMj6bBxgSYGYHBb5JTO7sRcyIlt2pzNP6pmDXO+hr5K3PuFE4WKYek4+Kdblf3ebnQxdHF98wNQzTEMuWF7Zc9+972p0m14hi7unS10uishj0UZRCGZDbFFvHHZcn61UYpoxzIC+c3AlwK+1uuTBiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(82740400003)(47076005)(83380400001)(1076003)(26005)(81166007)(356005)(4326008)(2906002)(41300700001)(316002)(8676002)(8936002)(54906003)(16526019)(2616005)(6666004)(36860700001)(5660300002)(336012)(478600001)(70206006)(7696005)(70586007)(6916009)(86362001)(426003)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:41.0774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da8c8e7-c494-4514-c79b-08dc0d1b3ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

