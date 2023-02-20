Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517E3C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 18:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A113410E289;
	Mon, 20 Feb 2023 18:11:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D2B10E289
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 18:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX4SVHgOx4E/+ztvkF2BmTsw3MZQ3q9/4sPORYKyNDDDnoC7m2Pd2SCi8ESg6oq7pxOsynEmQqoRi08o49J3u7xoZoSdx3qwcDmgdyOvREHmTQJtwtsmW8h/hvn5MHrxGoWTInAhIbiiIrHAk9Rtk5snkjy3rb42myy5sbY8H2s/rvpVJI1NnSrM0pzkXWXWKKYZXuHloEFJvy+XQ5AAH4QSgmBE6kOHFkT9vatHy350NUG3X3o3KOsCaclyvExVXG65glJMFL/p1wmzpJ17OR/z2pzS+cFIEQkYYu3dbxpDaQ/dpWjqhTSGRqSZOgI7jEqEpCYxX8ddfBb1zyChnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxm+ZvZtTCXq+80pwHSTKa63kGTwXHhymruC9YnlZOU=;
 b=WhvgtxvnXvkLa8flUgoX44n8K/L5icGMFPK+wVVLTtM9oeXxBiIKyHSESAs7ng70Q7TCNFFhYciJ74hBw+coNBzMdzTUC+qv2OPVVLPcBafK5mJRhWNQzrkqhk3Jnw5md2SMMQRZkFaqwl6KGx8/xFgY84MpR/jN4wqIcooiu4S/vQUwDbvQmfggvTCI/pTuKhCbshOf/OCfkycLKys4ZLishdio10dYWfZ/pJIHc2lKLijYxFS+zzr7dDfzzPnl7O7UfzmfTdjMmPmoayHpvFVbckVSCMBSP2yxTyPlCdvsh0bfmrXS3Zy3QIvn15YCYlBCcLbF57RODpWXFSdk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxm+ZvZtTCXq+80pwHSTKa63kGTwXHhymruC9YnlZOU=;
 b=lqo8xJpOWF257j/w2JfHzcPcuJ7z4my2H+X54JcJ2+OgvgDcKWKrOrPl81q9faFOAFFB6U+J+44Dr+GUhdt6uosA9VCQr1j0Wx4+pmQB8SBK51WQFTXOgm1Wyz0M6784VaMwaDw1DIkqWeWvI1sPEDlpxdpshqeJFXP0ktUeBa8=
Received: from MWH0EPF00056D0E.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:12) by DM6PR12MB4044.namprd12.prod.outlook.com
 (2603:10b6:5:21d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 18:11:19 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by MWH0EPF00056D0E.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1 via Frontend
 Transport; Mon, 20 Feb 2023 18:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.20 via Frontend Transport; Mon, 20 Feb 2023 18:11:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 12:11:17 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix initialization for nbio 7.5.1
Date: Mon, 20 Feb 2023 12:10:57 -0600
Message-ID: <20230220181057.24162-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: e840446a-991e-46ba-52dc-08db136ddd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGhiZN2sOdOu/22hhv3TIVJ054n8dr96FH6APrfem6LCUPXa7k8dlnUHRDE4QZK8U6LZnOobJjxTYoGiK4Qr+yzLpZwa76E5J8VG8oooOa0U/FgF6hD2QerY70NoqSA97f1Z+edBGIF7zcbXtV52sSx9CRKEx7KyskQ9OIGzqVOjArIMWlsNHcXUswf4QJxlIV63tXMen5r1h1rgysjJBeMcPLgyE2AGidir+slT2liQsVk3wbsuaLERLr2M1esqblcHzdoa+UM0r3BAn3hyhMfF6vWZ//ba7roCHqhukDQs9F1OtPy3uGMoeyE+84An7KlgIjTc01HI9FhvJ7+y6XRG0f8cpm+I1QkiU72wBWv9aNU4X+Qxb9z9/Cj/Ao76AU+S2UdtlMzO5566YFRidZmAZjeOrc9kGwApVzLQSW3p6yB3ty57gP/a7jMQn5Wdxn1gIewZXU9UfnDVBAKV72d/Ce2XmiLlkiQ9d5sT2dht7u6OG4ctvdas/rX5aFRF2fQLXJlhXVcy9YhM8B9LZ0zo/n/WTr3n59c0tsx2gkJmkxJAE6RoCJUtSbghm88Au3JSZL5JMV+XSil6HJZgfTrKZxU1bCDblQ551Gx4fttAvqPaHjnvSLYh5VHOHXXnIzsDV1x/RRQwQqq2LW6AuT8I7Ai7OMYC20mQHFBIZEBTyu4gCtgzUfCulk2XVoLbJpkz6fR/DGtqd66353dGSfDmNC6h+YfECyKZE52qJG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(336012)(70586007)(70206006)(8676002)(7696005)(54906003)(40460700003)(426003)(478600001)(47076005)(316002)(1076003)(186003)(356005)(26005)(16526019)(8936002)(2616005)(36756003)(4326008)(6916009)(41300700001)(5660300002)(82740400003)(6666004)(82310400005)(81166007)(86362001)(36860700001)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 18:11:18.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e840446a-991e-46ba-52dc-08db136ddd23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Cc: Richard Gong <richard.gong@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A mistake has been made in the BIOS for some ASICs with NBIO 7.5.1
where some NBIO registers aren't properly setup.

Ensure that they're set during initialization.

Tested-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 31776b12e4c45..4b0d563c6522c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -382,6 +382,11 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 		if (def != data)
 			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
 		break;
+	case IP_VERSION(7, 5, 1):
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
+		data &= ~RCC_DEV2_EPF0_STRAP2__STRAP_NO_SOFT_RESET_DEV2_F0_MASK;
+		WREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2, data);
+		fallthrough;
 	default:
 		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
 		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
-- 
2.25.1

