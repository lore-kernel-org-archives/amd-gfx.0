Return-Path: <SRS0=gBm/=OQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA7C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 02:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207D460240
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 02:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 207D460240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C466E4FB;
	Sun, 26 Sep 2021 02:38:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519316E479
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 02:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtgNWb+kFAs0FwkcNlKHTvUTl1BE52YgcfeqJ3BP/1zHveMx68htAqNLndaXZqC5hloX6KSza4Ne3tVGMKAtBjd+ha0q567U0miTFyVz8mskC1Pn08sQI+TdF7yrk+kMkkCm3hGz3MjaPhGOIdIQrL4A196ciBpTjF6mlG3P+Ji8NSYJR8W9IE2Ub9dQ12cqgiOPV5AMwoKihKxlRI0B6XiqF1SaMV2cQKtwlGDAq5brYJfh5A6+YbUbL2xWWY0nXwn+GI0RkdpQlVNQYMf8jTTEB071T8wDDKX1zV54MXcWaHQ2EmxEk01NuuVVC0CFN54VR919KpwYWjYHnmW+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=w1D7PNumP4+0cvnRYBFbu9im2/gDs3x3cydFFPEt4ys=;
 b=Nl1ONXI2h1bt12xdAkRJhWrfn198v7sMmuwsdA7d231oibfRZxZKwdl7nbt/fQSFvMduVKaU5aZ3txS1rz8xoHU4Vr0FjLeAS5sPa2Ii6NxkjW9Kzu2xBaqpt18s8WTgQR42LFfNS6pn7VPZUJqVkVuaUPEFSjGZAdJum8Kw4MWYsdQNfGIWYR31RNibr8OM3V4d+/94yB6OVNx1mnleaMgXAfANsVBk/zQX7DS9L1hw9G6xgudvuPiK8QT5CxE6ZnIfknfLgO+Pi/lH2nN6/bcIbIdBAXfcj/tWxvLZlv5WS/AB4MEjFOam15mU17QSnx9RiRHWzlV+EGkAKk+a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1D7PNumP4+0cvnRYBFbu9im2/gDs3x3cydFFPEt4ys=;
 b=S/bt/83z3ym0dGcYywfOAAZrnnKGqPRup74Q0QO+nLgTGJsVb8NP/rzcirSYwKPiDX5Bd6229PacpXenXxNcH7Xb67Ihpxvc1TRnPuqWY1slu936iwI+Z+c01J3Du/1AdmLUH0hYC7PLHcTs0HJDiWcAk1antXQu4OjwiQammS0=
Received: from MWHPR03CA0012.namprd03.prod.outlook.com (2603:10b6:300:117::22)
 by CY4PR12MB1333.namprd12.prod.outlook.com (2603:10b6:903:41::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Sun, 26 Sep
 2021 02:38:00 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::32) by MWHPR03CA0012.outlook.office365.com
 (2603:10b6:300:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Sun, 26 Sep 2021 02:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 02:37:59 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 25 Sep
 2021 21:37:57 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add poison mode query for DF (v2)
Date: Sun, 26 Sep 2021 10:37:41 +0800
Message-ID: <20210926023741.28736-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f7ccb1-2396-40d1-9295-08d98096a7a0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1333:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13338C4DAEA740CBE71F2F0AB0A69@CY4PR12MB1333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TgftVV6sBs/Gs2AwK9uLaOL9c3wQ6JUJH9jPachbxXTVW1ZFvsh3Z2YAneTXm6Dv+imb/jxl9uQ3XIay2qNkCYJY11SfavY2DMzPq+rkJ7OUkmuBsaSA7FiyC+14nMMkGUBvAiCDbSdyJlJjhSmfEggnCMEpgr+jwjVgvvHavKin/Nez4/Rs/pBTZ2P9TD9mQBgoPbRILoovcwqGoujJCzz3UKlEhAlMaUBXC3rnm3b9BjWwPHTZU2fgrfEUWj4YjEsRbqt+oFTIMDzrCfU81GjJOIslxbD1gzdEIx9xgecBC9SIlxk5qPtOnw0pzOsf1/x1P3Y1j3t5zGsg1mzoDy1qm72xeuHS7KzZUGqxwSXADBOmAGohxgZyrDp/6iBIgp+7TV8YF6TFlM2MYos480nQetqnnvZyhNdneOkmt7dVso+F+MBByfFWMd2ckigpC2zcg0nr5XIy0oMLV34OdtADKUEXKgMQ0Z8xlutZxkebUk/CeNkgcBwLlGatdtLP/PwzWAOEjBICV1JLkOl2cebHnvNCN/i9AjFmnjewmhlrAoAfJrmMgrzx7iH3585kYlg8NG4m/bOk9WErcP3LQg3gQwMzbelUE9RZxHXi/SFbmTqQ+zMHgUWe67vmj5kdngjzqCtCvLe/a+/vQGuaoN5Wkwr0Vo46xlCKIPWpnxK8JOkGaJkGZB4wSyuzQ1QM2vw0ccDNp1h0AeYCEFIw6uzP1kfP0Wz15e0lYevXGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(70206006)(356005)(82310400003)(81166007)(186003)(2906002)(6916009)(19627235002)(2616005)(5660300002)(316002)(30864003)(86362001)(16526019)(6666004)(336012)(426003)(8676002)(83380400001)(1076003)(8936002)(47076005)(26005)(36860700001)(4326008)(7696005)(36756003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 02:37:59.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f7ccb1-2396-40d1-9295-08d98096a7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
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

Add ras poison mode query interface for DF.

v2: replace RREG32_PCIE with RREG32_SOC15.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_df.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |  31 ++++
 .../amd/include/asic_reg/df/df_3_6_offset.h   |   5 +
 .../amd/include/asic_reg/df/df_3_6_sh_mask.h  | 132 ++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
index 52488bb45112..6b25837955c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
@@ -52,6 +52,7 @@ struct amdgpu_df_funcs {
 	uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t ficaa_val);
 	void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
 			 uint32_t ficadl_val, uint32_t ficadh_val);
+	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_df {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 14514a145c17..43c5e3ec9a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -637,6 +637,36 @@ static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
 	}
 }
 
+static bool df_v3_6_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	uint32_t hw_assert_msklo, hw_assert_mskhi;
+	uint32_t v0, v1, v28, v31;
+
+	hw_assert_msklo = RREG32_SOC15(DF, 0,
+				mmDF_CS_UMC_AON0_HardwareAssertMaskLow);
+	hw_assert_mskhi = RREG32_SOC15(DF, 0,
+				mmDF_NCS_PG0_HardwareAssertMaskHigh);
+
+	v0 = REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk0);
+	v1 = REG_GET_FIELD(hw_assert_msklo,
+		DF_CS_UMC_AON0_HardwareAssertMaskLow, HWAssertMsk1);
+	v28 = REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk28);
+	v31 = REG_GET_FIELD(hw_assert_mskhi,
+		DF_NCS_PG0_HardwareAssertMaskHigh, HWAssertMsk31);
+
+	if (v0 && v1 && v28 && v31)
+		return true;
+	else if (!v0 && !v1 && !v28 && !v31)
+		return false;
+	else {
+		dev_warn(adev->dev, "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
+				v0, v1, v28, v31);
+		return false;
+	}
+}
+
 const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.sw_init = df_v3_6_sw_init,
 	.sw_fini = df_v3_6_sw_fini,
@@ -651,4 +681,5 @@ const struct amdgpu_df_funcs df_v3_6_funcs = {
 	.pmc_get_count = df_v3_6_pmc_get_count,
 	.get_fica = df_v3_6_get_fica,
 	.set_fica = df_v3_6_set_fica,
+	.query_ras_poison_mode = df_v3_6_query_ras_poison_mode,
 };
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
index bd37aa6b6560..b4b2584bbd66 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
@@ -77,4 +77,9 @@
 #define smnDF_CS_UMC_AON0_DramBaseAddress0 	0x1c110UL
 #define smnDF_CS_UMC_AON0_DramLimitAddress0 	0x1c114UL
 
+#define mmDF_CS_UMC_AON0_HardwareAssertMaskLow                                                         0x067e
+#define mmDF_CS_UMC_AON0_HardwareAssertMaskLow_BASE_IDX                                                0
+#define mmDF_NCS_PG0_HardwareAssertMaskHigh                                                            0x067f
+#define mmDF_NCS_PG0_HardwareAssertMaskHigh_BASE_IDX                                                   0
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index f804e13b002e..f45ec6f97ff2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -62,4 +62,136 @@
 #define DF_CS_UMC_AON0_DramLimitAddress0__AllowReqIO_MASK                                                     0x00000400L
 #define DF_CS_UMC_AON0_DramLimitAddress0__DramLimitAddr_MASK                                                  0xFFFFF000L
 
+//DF_CS_UMC_AON0_HardwareAssertMaskLow
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0__SHIFT                                             0x0
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1__SHIFT                                             0x1
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2__SHIFT                                             0x2
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3__SHIFT                                             0x3
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4__SHIFT                                             0x4
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5__SHIFT                                             0x5
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6__SHIFT                                             0x6
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7__SHIFT                                             0x7
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8__SHIFT                                             0x8
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9__SHIFT                                             0x9
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10__SHIFT                                            0xa
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11__SHIFT                                            0xb
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12__SHIFT                                            0xc
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13__SHIFT                                            0xd
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14__SHIFT                                            0xe
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15__SHIFT                                            0xf
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16__SHIFT                                            0x10
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17__SHIFT                                            0x11
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18__SHIFT                                            0x12
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19__SHIFT                                            0x13
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20__SHIFT                                            0x14
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21__SHIFT                                            0x15
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22__SHIFT                                            0x16
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23__SHIFT                                            0x17
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24__SHIFT                                            0x18
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25__SHIFT                                            0x19
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26__SHIFT                                            0x1a
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27__SHIFT                                            0x1b
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28__SHIFT                                            0x1c
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29__SHIFT                                            0x1d
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30__SHIFT                                            0x1e
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31__SHIFT                                            0x1f
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk0_MASK                                               0x00000001L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk1_MASK                                               0x00000002L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk2_MASK                                               0x00000004L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk3_MASK                                               0x00000008L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk4_MASK                                               0x00000010L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk5_MASK                                               0x00000020L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk6_MASK                                               0x00000040L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk7_MASK                                               0x00000080L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk8_MASK                                               0x00000100L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk9_MASK                                               0x00000200L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk10_MASK                                              0x00000400L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk11_MASK                                              0x00000800L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk12_MASK                                              0x00001000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk13_MASK                                              0x00002000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk14_MASK                                              0x00004000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk15_MASK                                              0x00008000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk16_MASK                                              0x00010000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk17_MASK                                              0x00020000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk18_MASK                                              0x00040000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk19_MASK                                              0x00080000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk20_MASK                                              0x00100000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk21_MASK                                              0x00200000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk22_MASK                                              0x00400000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk23_MASK                                              0x00800000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk24_MASK                                              0x01000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk25_MASK                                              0x02000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk26_MASK                                              0x04000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk27_MASK                                              0x08000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk28_MASK                                              0x10000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk29_MASK                                              0x20000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk30_MASK                                              0x40000000L
+#define DF_CS_UMC_AON0_HardwareAssertMaskLow__HWAssertMsk31_MASK                                              0x80000000L
+
+//DF_NCS_PG0_HardwareAssertMaskHigh
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0__SHIFT                                                0x0
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1__SHIFT                                                0x1
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2__SHIFT                                                0x2
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3__SHIFT                                                0x3
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4__SHIFT                                                0x4
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5__SHIFT                                                0x5
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6__SHIFT                                                0x6
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7__SHIFT                                                0x7
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8__SHIFT                                                0x8
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9__SHIFT                                                0x9
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10__SHIFT                                               0xa
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11__SHIFT                                               0xb
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12__SHIFT                                               0xc
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13__SHIFT                                               0xd
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14__SHIFT                                               0xe
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15__SHIFT                                               0xf
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16__SHIFT                                               0x10
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17__SHIFT                                               0x11
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18__SHIFT                                               0x12
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19__SHIFT                                               0x13
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20__SHIFT                                               0x14
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21__SHIFT                                               0x15
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22__SHIFT                                               0x16
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23__SHIFT                                               0x17
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24__SHIFT                                               0x18
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25__SHIFT                                               0x19
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26__SHIFT                                               0x1a
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27__SHIFT                                               0x1b
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28__SHIFT                                               0x1c
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29__SHIFT                                               0x1d
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30__SHIFT                                               0x1e
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31__SHIFT                                               0x1f
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk0_MASK                                                  0x00000001L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk1_MASK                                                  0x00000002L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk2_MASK                                                  0x00000004L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk3_MASK                                                  0x00000008L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk4_MASK                                                  0x00000010L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk5_MASK                                                  0x00000020L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk6_MASK                                                  0x00000040L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk7_MASK                                                  0x00000080L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk8_MASK                                                  0x00000100L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk9_MASK                                                  0x00000200L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk10_MASK                                                 0x00000400L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk11_MASK                                                 0x00000800L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk12_MASK                                                 0x00001000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk13_MASK                                                 0x00002000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk14_MASK                                                 0x00004000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk15_MASK                                                 0x00008000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk16_MASK                                                 0x00010000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk17_MASK                                                 0x00020000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk18_MASK                                                 0x00040000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk19_MASK                                                 0x00080000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk20_MASK                                                 0x00100000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk21_MASK                                                 0x00200000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk22_MASK                                                 0x00400000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk23_MASK                                                 0x00800000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk24_MASK                                                 0x01000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk25_MASK                                                 0x02000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk26_MASK                                                 0x04000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk27_MASK                                                 0x08000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk28_MASK                                                 0x10000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk29_MASK                                                 0x20000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk30_MASK                                                 0x40000000L
+#define DF_NCS_PG0_HardwareAssertMaskHigh__HWAssertMsk31_MASK                                                 0x80000000L
+
 #endif
-- 
2.17.1

