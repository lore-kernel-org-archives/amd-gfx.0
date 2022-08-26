Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990E9ECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B250910E10E;
	Fri, 26 Aug 2022 18:43:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2C110E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7j6bV0lMBMkSqeks0fFv3Kr27FPpD+bP4MhXNRfn0lnRExBqGKZTWiPCzBZknzFLUXb9z7IdTig2QlvCoC9E8hxV2VS3L13weRMVHgWAh8lke6Xf0NXbC2Wa+itApWCRZHGKGiOSjT6ndWlo/V1tRLQ5yddauGYDK4G5RMqHcBL/cmKXHCffv7OKzeOqxdQDTnD3/UfmfUugpu7fljWGvk41nd92sa/kdzBE7rTlZC3hMNiwcvQaWCEkgg/m89zd/IOZ2xeTDwkNIz94hdxmBQh7+fGLDI+F9dWqcXLtA/moqRX9/W/EvXmgFX9NWNXXnsZCHMTkS0PVTnK6AsgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEFjp8Nj3xJD4zcJyvdBF6WibnvbBpvQ+yHDFymZ1v0=;
 b=EWqayY7XMA/623W2XRZIVzWOTDDsnDHw2UDtCbeJDxo8gXucvZuGPxaEfBOjXgvH2VgoHap3I817PT22qqN/vRV2YyGk5bw0XCy8i8YrmSvATqhSVE7KJIdHFfYNa7C1gSiSqOKMal2Q2u758b/HgHygRW1tchgjWQl3Sonme/H4OncZiKPSomQ6kpSH0JEBUKuv4azCGksUNwG+P5Ss7U+MNUKaS4LA1pI9vQAiRodJuHPZIsBY6MgYv8YrX9GzcBeepv9Xd0NiKKuilO/YgGq8RBLBndc5GOW0ofVEuBFYEeq6jIpiDEYx/7QT5CacqOpYCTZCVrXxtU2NB12AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEFjp8Nj3xJD4zcJyvdBF6WibnvbBpvQ+yHDFymZ1v0=;
 b=QBRpvNGi9zHm+mcNcfOsMUu5eReFCzv+UUD6kpSnV4rC/ZPx3VX9tthIvP0F5oSMxDmW2v7P4q7NaCcytaEzS8Fp1OIXmXe4qRGCfOmjJUCBwbUblO83RQQ2kW4uKxqSbz0Hq2JzD9E8PtAl2R0yTCa+5uQHJqb3PbrcG7368rY=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:43:54 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::9c) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:43:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: support psp v13_0_10 ip block
Date: Fri, 26 Aug 2022 14:43:37 -0400
Message-ID: <20220826184339.855360-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50658156-5f88-44fb-27e0-08da8792ecb1
X-MS-TrafficTypeDiagnostic: BL3PR12MB6571:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIn5cBSTB91ShrP+kG0+ioAAAQ1p1xt8f7SFiDf0Gn+X72Ev1WuvK4k5drnm2Ib7aIqR4BAdaKB/DQHD9IHBBOASPAgf4lZXT4j8PjzQFs0381cvEqe8Eih3qauLRH4tN+zIOOsYoYeQrn8qGQGaEHl2hkjhYzdTgIkAR2ktT7N/IhweEdmGQr2HF2qWjavLBRwRXRJcl0BUoiSQrdw/cXitvkKoqQmlqEQdiLwYXT3wx3+4EFRQFo2mDzNU10vYGYTloqBw2cKfeAoio4l6h7lgNlH9SsBJX7enjVhjwGLt1NnOK0dOXX2CT9SA1819qedYSghGGyiKGMXYdi5UK2KhUki08Z4yVkn1plvJOHJCKeizYwI/8QIr6O3tDFnG3b/3wIaDbYEUj4jfeiu1EVCFg5NsTrehO1QyXXTeMGKtudaCVwr7BNkn4s6xsHMObOXnt7V+1QPWmUFNF07E/QTJS2cE0gFKwtJbb3pB80X/9j7BfrKuugpOHI1wUo/sB1KwUkUatgWr6ZABeWBdTsKCIePzzgfou4TX0Isx4Cly4Yz9HtdE6P9MssPlNw7ZooNO0Bya9toohemmji7phNIAGpjs78jn9F8yug7Rco3qEbIOf0sOEFFwYKmF7QNyaG9o5n43OhIbefM6zjoQ6LQ2QJkz7Rkm9ROBnFb8cY9SZB1Bu7z+PqF2LtWd0OB7VJ1eWyy56L/HKO2wfdcCAzz/QKml32akbfYglO7OQR7pCM/dUMXW/JQL22CYzrPk+AvaARTQTgSLRWpv5+SoqjHveOp76takmEAOpjqNo6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(40470700004)(46966006)(36756003)(5660300002)(47076005)(83380400001)(2616005)(54906003)(82740400003)(63370400001)(316002)(426003)(2906002)(63350400001)(356005)(40480700001)(81166007)(6916009)(478600001)(40460700003)(1076003)(4326008)(82310400005)(26005)(41300700001)(6666004)(7696005)(186003)(70206006)(16526019)(336012)(36860700001)(70586007)(8936002)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:53.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50658156-5f88-44fb-27e0-08da8792ecb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Frank Min <Frank.Min@amd.com>

Add psp v13_0_10 ip block, initialize firmware and
psp functions

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c932bc148554..b007371df59c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -138,6 +138,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(13, 0, 10):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index c39e8b333181..38553e8141f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -108,6 +108,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.37.1

