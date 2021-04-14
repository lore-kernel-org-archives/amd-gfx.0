Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92702C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5315B613B1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 03:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5315B613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122F86E436;
	Wed, 14 Apr 2021 03:04:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416F36E435
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 03:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXB5J56VwHszTE24Dmiu8PLgQkwqIBc2N/l6P9AJxI67Alybib/LTDwhRWPy8ZwSlrFnefXsQkzpxaHUn+eBfNm/HGtruUXtaL8cyFHQeur2vltRb1xzedEzr5liZ1BV4zSjUTXf3R7dGbizABp/n3wpsX8tR9xSzVP2IhaeVi1kTiGbLZhN3pQ745E86AaNv97zp1sGPG3b+7PLvfN1JgrWSZOPmyvVAwQXcaFcplicEJFrjSo9juhZ2ieIpcNVatyITRAh1mA8HOblC1aLNw6NdpViyoLbpu5xXcpPRGorXgkG8nOwXSuXgALhMvUWrfh1miUH1jc78zPrYxEB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oounaw4TToNVawl1VEYbHtrqXuDr5jsCDvQP+Bcuaw=;
 b=h5IqNwmNO/nwebKw7eGhzWF3QAuYzFgayQRuPvLoxEeqoVrguUEQlMAAriFHMpDZTw2WY3IikzYA03ToP/jLknsvzZhK+iYrQyxdjB7IN8pzRVpXFs2kKvZEx062TD0/cO+7+949DweauVa7pzQ3LEar57hbu9PhpmCHJ1OV4PBd0e1t/7ZM8l2g7KMY6UXYKFG7aQKpqmAowqeiXTZ1L99kDXNox24bJKM4c0t/DK7xdwMqkB0TEzEwWjsJENjv8n0cNnOkVPWWDmqv6Nk5nM06t/t8rytyUp8L1e66GSRcP65lf5krG+TuD8LVrCvY5tlxEiz1qGrvhajWNyRFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oounaw4TToNVawl1VEYbHtrqXuDr5jsCDvQP+Bcuaw=;
 b=OBbKi8+JYWaKsg2AIbTc9PKNw7g6cY4HMVvVaQNi8o6RP0h6i/sGZIxgSgKhhmn1okqf3+3yUjw31EBmYWpD/ZsCgZRDAY44qnNIGugJ/6/9JzjTxpoNRojbpKkYTmreLKapWNvoA1Z6Y80mtC7OqDDUugZJrmers9nYgihiEaU=
Received: from BN6PR16CA0033.namprd16.prod.outlook.com (2603:10b6:405:14::19)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 03:04:10 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::dc) by BN6PR16CA0033.outlook.office365.com
 (2603:10b6:405:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 14 Apr 2021 03:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 03:04:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 22:04:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 22:03:50 -0500
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 22:03:49 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: add ASPM support on polaris
Date: Wed, 14 Apr 2021 11:03:47 +0800
Message-ID: <20210414030347.23655-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414030347.23655-1-kenneth.feng@amd.com>
References: <20210414030347.23655-1-kenneth.feng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa720d3-a92c-4112-91fa-08d8fef1f9fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240D7EF85131794418638E78E4E9@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJQvFXChBEO4A/AwjHA+NujFRcGWeOe3iWHvBxVIO/PcW6Nc0E3QOS2GN6x4d55k/izUkVdd7UqX+19rmsYTR48/abkAtJvQ/9iLQHo3z1OHlEzZzxPOUzSBD4Af0L2iyuHvaMP95SAda/Bfv5B7nTm77abN/tx1QO3bzMcLECkJ5JPS0JhWG+RhbAC7gLzBhJoTF1+Nknqpcps16SNix2Wkp2ZvkYxn+/VY22qwgEhMDvBhlLajrhjbynP8/wl31N7nmKbFpMt3LUO8bQ25xINivyAKTpoLItkJZ2LWJCX56Zeyj6wRjrb21bMr/Kf8Rez9+1hAjmtl00YuvgBZR0e37JspcliENCREG58oNltxZzt4phE3Sh6Vb6bx/M+AcuZ1YbCYzjK/bQ/BZnMR/9Ew+HXojaNasNNgfLqBc1PqowaxOiGZUm2jJ7UjjdSdIR3WKVUxfePnbeK7rIDdT+/AWWqRhbVIlonbDY6t4F779NWRgjDYNAtv+X4WSqG10LOfnNT7S1MzNtg8IaMQkcW+/m4v4suYn9xi3+517zr9QDJSSrHdRHuVrNjs31z/IMrbxqLnDg6KazAfunbmWDVoMStA8c6imcIFGkSpMkAP9Etm8y9nPBRCOmnnct3vMhDa6a9L7n84+6ztfauxQgeaQgJwqh0I27qP69fQl9q6jyyfYJcC1KcCe+KYwJoc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(70206006)(336012)(7696005)(5660300002)(36756003)(70586007)(2906002)(478600001)(47076005)(2616005)(36860700001)(4326008)(26005)(82740400003)(186003)(86362001)(426003)(6916009)(1076003)(8676002)(83380400001)(356005)(316002)(44832011)(81166007)(8936002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 03:04:10.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa720d3-a92c-4112-91fa-08d8fef1f9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ASPM support on polaris

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 193 +++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index ea338de5818a..735ebbd1148f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -81,6 +81,30 @@
 #include "mxgpu_vi.h"
 #include "amdgpu_dm.h"
 
+#define ixPCIE_LC_L1_PM_SUBSTATE	0x100100C6
+#define PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK	0x00000001L
+#define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK	0x00000002L
+#define PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_1_OVERRIDE_MASK	0x00000004L
+#define PCIE_LC_L1_PM_SUBSTATE__LC_ASPM_L1_2_OVERRIDE_MASK		0x00000008L
+#define PCIE_LC_L1_PM_SUBSTATE__LC_ASPM_L1_1_OVERRIDE_MASK		0x00000010L
+#define ixPCIE_L1_PM_SUB_CNTL	0x378
+#define PCIE_L1_PM_SUB_CNTL__ASPM_L1_2_EN_MASK	0x00000004L
+#define PCIE_L1_PM_SUB_CNTL__ASPM_L1_1_EN_MASK	0x00000008L
+#define PCIE_L1_PM_SUB_CNTL__PCI_PM_L1_2_EN_MASK	0x00000001L
+#define PCIE_L1_PM_SUB_CNTL__PCI_PM_L1_1_EN_MASK	0x00000002L
+#define PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK		0x00200000L
+#define LINK_CAP	0x64
+#define PCIE_LINK_CAP__CLOCK_POWER_MANAGEMENT_MASK	0x00040000L
+#define ixCPM_CONTROL	0x1400118
+#define ixPCIE_LC_CNTL7	0x100100BC
+#define PCIE_LC_CNTL7__LC_L1_SIDEBAND_CLKREQ_PDWN_EN_MASK	0x00000400L
+#define PCIE_LC_CNTL__LC_L0S_INACTIVITY_DEFAULT	0x00000007
+#define PCIE_LC_CNTL__LC_L1_INACTIVITY_DEFAULT	0x00000009
+#define CPM_CONTROL__CLKREQb_UNGATE_TXCLK_ENABLE_MASK	0x01000000L
+#define PCIE_L1_PM_SUB_CNTL	0x378
+#define ASIC_IS_P22(asic_type, rid)	((asic_type >= CHIP_POLARIS10) && \
+									(asic_type <= CHIP_POLARIS12) && \
+									(rid >= 0x6E))
 /* Topaz */
 static const struct amdgpu_video_codecs topaz_video_codecs_encode =
 {
@@ -1091,13 +1115,178 @@ static void vi_pcie_gen3_enable(struct amdgpu_device *adev)
 	/* todo */
 }
 
+static void vi_enable_aspm(struct amdgpu_device *adev)
+{
+	u32 data, orig;
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_CNTL);
+	data |= PCIE_LC_CNTL__LC_L0S_INACTIVITY_DEFAULT <<
+			PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	data |= PCIE_LC_CNTL__LC_L1_INACTIVITY_DEFAULT <<
+			PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	data |= PCIE_LC_CNTL__LC_DELAY_L1_EXIT_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_CNTL, data);
+}
+
 static void vi_program_aspm(struct amdgpu_device *adev)
 {
+	u32 data, data1, orig;
+	bool bL1SS = false;
+	bool bClkReqSupport = true;
 
-	if (amdgpu_aspm == 0)
+	if (amdgpu_aspm != 1)
 		return;
 
-	/* todo */
+	if (adev->flags & AMD_IS_APU ||
+	    adev->asic_type < CHIP_POLARIS10)
+		return;
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_CNTL, data);
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_N_FTS_CNTL);
+	data &= ~PCIE_LC_N_FTS_CNTL__LC_XMIT_N_FTS_MASK;
+	data |= 0x0024 << PCIE_LC_N_FTS_CNTL__LC_XMIT_N_FTS__SHIFT;
+	data |= PCIE_LC_N_FTS_CNTL__LC_XMIT_N_FTS_OVERRIDE_EN_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_N_FTS_CNTL, data);
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_CNTL3);
+	data |= PCIE_LC_CNTL3__LC_GO_TO_RECOVERY_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_CNTL3, data);
+
+	orig = data = RREG32_PCIE(ixPCIE_P_CNTL);
+	data |= PCIE_P_CNTL__P_IGNORE_EDB_ERR_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_P_CNTL, data);
+
+	data = RREG32_PCIE(ixPCIE_LC_L1_PM_SUBSTATE);
+	pci_read_config_dword(adev->pdev, PCIE_L1_PM_SUB_CNTL, &data1);
+	if (data & PCIE_LC_L1_PM_SUBSTATE__LC_L1_SUBSTATES_OVERRIDE_EN_MASK &&
+	    (data & (PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_2_OVERRIDE_MASK |
+		    PCIE_LC_L1_PM_SUBSTATE__LC_PCI_PM_L1_1_OVERRIDE_MASK |
+			PCIE_LC_L1_PM_SUBSTATE__LC_ASPM_L1_2_OVERRIDE_MASK |
+			PCIE_LC_L1_PM_SUBSTATE__LC_ASPM_L1_1_OVERRIDE_MASK))) {
+		bL1SS = true;
+	} else if (data1 & (PCIE_L1_PM_SUB_CNTL__ASPM_L1_2_EN_MASK |
+	    PCIE_L1_PM_SUB_CNTL__ASPM_L1_1_EN_MASK |
+	    PCIE_L1_PM_SUB_CNTL__PCI_PM_L1_2_EN_MASK |
+	    PCIE_L1_PM_SUB_CNTL__PCI_PM_L1_1_EN_MASK)) {
+		bL1SS = true;
+	}
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_CNTL6);
+	data |= PCIE_LC_CNTL6__LC_L1_POWERDOWN_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_CNTL6, data);
+
+	orig = data = RREG32_PCIE(ixPCIE_LC_LINK_WIDTH_CNTL);
+	data |= PCIE_LC_LINK_WIDTH_CNTL__LC_DYN_LANES_PWR_STATE_MASK;
+	if (orig != data)
+		WREG32_PCIE(ixPCIE_LC_LINK_WIDTH_CNTL, data);
+
+	pci_read_config_dword(adev->pdev, LINK_CAP, &data);
+	if (!(data & PCIE_LINK_CAP__CLOCK_POWER_MANAGEMENT_MASK))
+		bClkReqSupport = false;
+
+	if (bClkReqSupport) {
+		orig = data = RREG32_SMC(ixTHM_CLK_CNTL);
+		data &= ~(THM_CLK_CNTL__CMON_CLK_SEL_MASK | THM_CLK_CNTL__TMON_CLK_SEL_MASK);
+		data |= (1 << THM_CLK_CNTL__CMON_CLK_SEL__SHIFT) |
+				(1 << THM_CLK_CNTL__TMON_CLK_SEL__SHIFT);
+		if (orig != data)
+			WREG32_SMC(ixTHM_CLK_CNTL, data);
+
+		orig = data = RREG32_SMC(ixMISC_CLK_CTRL);
+		data &= ~(MISC_CLK_CTRL__DEEP_SLEEP_CLK_SEL_MASK |
+			MISC_CLK_CTRL__ZCLK_SEL_MASK | MISC_CLK_CTRL__DFT_SMS_PG_CLK_SEL_MASK);
+		data |= (1 << MISC_CLK_CTRL__DEEP_SLEEP_CLK_SEL__SHIFT) |
+				(1 << MISC_CLK_CTRL__ZCLK_SEL__SHIFT);
+		data |= (0x20 << MISC_CLK_CTRL__DFT_SMS_PG_CLK_SEL__SHIFT);
+		if (orig != data)
+			WREG32_SMC(ixMISC_CLK_CTRL, data);
+
+		orig = data = RREG32_SMC(ixCG_CLKPIN_CNTL);
+		data |= CG_CLKPIN_CNTL__XTALIN_DIVIDE_MASK;
+		if (orig != data)
+			WREG32_SMC(ixCG_CLKPIN_CNTL, data);
+
+		orig = data = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
+		data |= CG_CLKPIN_CNTL_2__ENABLE_XCLK_MASK;
+		if (orig != data)
+			WREG32_SMC(ixCG_CLKPIN_CNTL, data);
+
+		orig = data = RREG32_SMC(ixMPLL_BYPASSCLK_SEL);
+		data &= ~MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL_MASK;
+		data |= (4 << MPLL_BYPASSCLK_SEL__MPLL_CLKOUT_SEL__SHIFT);
+		if (orig != data)
+			WREG32_SMC(ixMPLL_BYPASSCLK_SEL, data);
+
+		orig = data = RREG32_PCIE(ixCPM_CONTROL);
+		data |= (CPM_CONTROL__REFCLK_XSTCLK_ENABLE_MASK |
+				CPM_CONTROL__CLKREQb_UNGATE_TXCLK_ENABLE_MASK);
+		if (orig != data)
+			WREG32_PCIE(ixCPM_CONTROL, data);
+
+		orig = data = RREG32_PCIE(ixPCIE_CONFIG_CNTL);
+		data &= ~PCIE_CONFIG_CNTL__DYN_CLK_LATENCY_MASK;
+		data |= (0xE << PCIE_CONFIG_CNTL__DYN_CLK_LATENCY__SHIFT);
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_CONFIG_CNTL, data);
+
+		orig = data = RREG32(mmBIF_CLK_CTRL);
+		data |= BIF_CLK_CTRL__BIF_XSTCLK_READY_MASK;
+		if (orig != data)
+			WREG32(mmBIF_CLK_CTRL, data);
+
+		orig = data = RREG32_PCIE(ixPCIE_LC_CNTL7);
+		data |= PCIE_LC_CNTL7__LC_L1_SIDEBAND_CLKREQ_PDWN_EN_MASK;
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_LC_CNTL7, data);
+
+		orig = data = RREG32_PCIE(ixPCIE_HW_DEBUG);
+		data |= PCIE_HW_DEBUG__HW_01_DEBUG_MASK;
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_HW_DEBUG, data);
+
+		orig = data = RREG32_PCIE(ixPCIE_LC_CNTL2);
+		data |= PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+		data |= PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK;
+		if (bL1SS)
+			data &= ~PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK;
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_LC_CNTL2, data);
+
+	}
+
+	vi_enable_aspm(adev);
+
+	data = RREG32_PCIE(ixPCIE_LC_N_FTS_CNTL);
+	data1 = RREG32_PCIE(ixPCIE_LC_STATUS1);
+	if (((data & PCIE_LC_N_FTS_CNTL__LC_N_FTS_MASK) == PCIE_LC_N_FTS_CNTL__LC_N_FTS_MASK) &&
+	    data1 & PCIE_LC_STATUS1__LC_REVERSE_XMIT_MASK &&
+	    data1 & PCIE_LC_STATUS1__LC_REVERSE_RCVR_MASK) {
+		orig = data = RREG32_PCIE(ixPCIE_LC_CNTL);
+		data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_LC_CNTL, data);
+	}
+
+	if ((adev->asic_type == CHIP_POLARIS12 &&
+	    !(ASICID_IS_P23(adev->pdev->device, adev->pdev->revision))) ||
+	    ASIC_IS_P22(adev->asic_type, adev->external_rev_id)) {
+		orig = data = RREG32_PCIE(ixPCIE_LC_TRAINING_CNTL);
+		data &= ~PCIE_LC_TRAINING_CNTL__LC_DISABLE_TRAINING_BIT_ARCH_MASK;
+		if (orig != data)
+			WREG32_PCIE(ixPCIE_LC_TRAINING_CNTL, data);
+	}
 }
 
 static void vi_enable_doorbell_aperture(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
