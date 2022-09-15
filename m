Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF62C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6CF10EB81;
	Thu, 15 Sep 2022 17:02:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBF310EB81
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsH3vRkfyUbvh6mTrUvZWA6DNgfAR8r60BPDhyHAXIgqqv7yqHmgeaqpe7qEJBig9+76rAt475IAwwXDZ9eU9i34GH8DGnx7KczY55/oKBLgTxdfcXG+YBGfB6ug23pSEOQ3NCvfasGXivSIJVR2NXm1VcScmtBFc3EDBbV0F+t1tPXpnAqNkXE/6YTW3kRLMvhZdrdwkzcy4Xx0zMaR0qQNjIkx89bZYW/OMy6Q8VfwI4LuXwbaK3r37VWYuilwapzZfbynDDdSR/uWOsQ5m5bytfCXYwIPmhTH+mgP7xnD3s2tPIv7+GcmdDsrl7tGSP5uNn3kWTBguHLZrwAh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cqUZG/3RE2+Qtrsgtut5nycjKKCHctwV88Zq73EAYw=;
 b=KfNbk1zEYNoANHwBqd116aPABA74qStVfReKw5Fi7x1xz28pt6vkrBDmWpRDk14psqTi815MYjIxZItVW9NC3fqLoZoSyKoinGpCnr8Pi4JavsmiZItzad3kE8kid4RqGfxo8sOmD+Cvdr8JT48cbwXijyUAvXMhhbhF96Ifry+jtTIxjz+4zWYhY0ysj51o8+EGkGMt+kehzTYiezlNZnxH3d1wD2gZIpl6k1JjmNhsmxhopSaIULOjr+Eco3RsVjBy6V6r1ZL6g7kI8ljGnqHhPZOT/e22k0Ia4TNwd1G4LIdr5tGHTvYWIGCOkows2f6NWy/nJuv9+VQuRW5/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cqUZG/3RE2+Qtrsgtut5nycjKKCHctwV88Zq73EAYw=;
 b=FqhHibX4VboL84WTQAaHcEo+P5idaS5LtCnWZA3RBdbfU2hp9nOqS4yFfWEsyZhIxAmlANzWXnSE0TVoQ731f3htPF60Tf8ygqdjbmMfH7SgJ9mhUSv9E1AVaFBroOznAB95rN9GzR6OI/4h7DIvwxdNodeA6tiJ14I0SdqxEI4=
Received: from DM5PR07CA0072.namprd07.prod.outlook.com (2603:10b6:4:ad::37) by
 BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 15 Sep
 2022 17:01:57 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::fa) by DM5PR07CA0072.outlook.office365.com
 (2603:10b6:4:ad::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:01:56 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:01:53 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: add helper to init rlc fw in header v2_1
Date: Fri, 16 Sep 2022 01:01:27 +0800
Message-ID: <20220915170135.23060-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|BN9PR12MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1900bb-1b38-4e1a-bbe4-08da973bff27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmDqW+1VT+QEG2p8uEkmSb7HOgAJq7YJCqVCTQ2VdcAgAGpueya3MBfTakTPZM5hTX3omHK/sFarDOr1lftPW1sRFTsGFV8mEhIbdHB2qtysQNLk3tBTAlXTV3OjphvHqDEPhfzj2RSEev2D4PuGVC6LYSEQXNMweyHuH/Z14rwcOA47mZaHEXaCvCXkkkeKl1ggtQcVgBX1sQD0bxfdrn2m3FjTAikfiTrv1P4eRfIKC2kisnEG0HTQHAHjbeB7QlMnEeLCG4Vc9R6BJNBr9oi/CwvLjUeulRvGGfq+2eLUTd+hpPMGYUYPMl3PdCIR2dnTx8cu5gILlcEpaRr6CBIxm11F4yL6C0xaoBohZF4mWwThuItOOqEjeVyCxOhRE0psWHCR4fxH/l+/sRm9mYJyFf2xGgNUB9L0jTBejO+sk+Ri22dtBS0cRz1LflJBVM8PM4srqUXXpFHDfcOipnRXZbEC54Q/JySS6qP+0m/v27HuchegbIt1BQRYSTw4MbDtMhG+vFJupARqqL9qS9GMo5asylW9Myx0TPlxOFiuXMDz6wGrKPvLVIG7aVBLhUE9Wsf7fQ73Nw8IDUmlnkHb1PM/sCx7Z0WLE8FY2yWoopMLFLBZFT7XMlqJyNCIuc2S9sh3JjHExsY7SXzt1DDQQ8CT4yWC0FCjnjEejS0uG4qxaqGkDs1tZ4KIUZ6QwJ0O1540TZdDq2uDZwnQ3InPdxulUEz/Xb20qkGukTq0RsJgLU6tGyjedGBHiurHQGS+CUTkgRfWUaFohjJJOW5xbSi0qSJKxLyQeLMPzlQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(86362001)(2906002)(8676002)(36756003)(40480700001)(8936002)(4326008)(70586007)(70206006)(110136005)(6636002)(82310400005)(316002)(26005)(2616005)(336012)(426003)(186003)(83380400001)(47076005)(16526019)(40460700003)(36860700001)(41300700001)(478600001)(82740400003)(1076003)(6666004)(7696005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:01:56.3973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1900bb-1b38-4e1a-bbe4-08da973bff27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To initialize rlc firmware in header v2_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 10b998cae1ba..04bdb885918d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -336,3 +336,43 @@ static int amdgpu_gfx_rlc_init_microcode_v2_0(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_1(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_1 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlc_srlc_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_ucode_ver);
+	adev->gfx.rlc_srlc_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_cntl_feature_ver);
+	adev->gfx.rlc.save_restore_list_cntl_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_cntl_size_bytes);
+	adev->gfx.rlc.save_restore_list_cntl = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_cntl_offset_bytes);
+	adev->gfx.rlc_srlg_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_ucode_ver);
+	adev->gfx.rlc_srlg_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_gpm_feature_ver);
+	adev->gfx.rlc.save_restore_list_gpm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_gpm_size_bytes);
+	adev->gfx.rlc.save_restore_list_gpm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_gpm_offset_bytes);
+	adev->gfx.rlc_srls_fw_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_ucode_ver);
+	adev->gfx.rlc_srls_feature_version = le32_to_cpu(rlc_hdr->save_restore_list_srm_feature_ver);
+	adev->gfx.rlc.save_restore_list_srm_size_bytes = le32_to_cpu(rlc_hdr->save_restore_list_srm_size_bytes);
+	adev->gfx.rlc.save_restore_list_srm = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->save_restore_list_srm_offset_bytes);
+	adev->gfx.rlc.reg_list_format_direct_reg_list_length =
+		le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_list_length);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.save_restore_list_gpm_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.save_restore_list_gpm_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.save_restore_list_srm_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.save_restore_list_srm_size_bytes), PAGE_SIZE);
+		}
+	}
+}
-- 
2.17.1

