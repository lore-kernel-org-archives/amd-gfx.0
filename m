Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35234C6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFD510E5C8;
	Thu, 24 Aug 2023 21:32:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5343910E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBgqQ2SZyoHlBq1VSMD/Vw0Jdg1/k31wSlUbJvngp8JkFr+zdQMAawnQ3w+aztipOkmrtJ+B0TJyg2FX8/OP6DK09+4nD8mPaHp6RYrzqHMQcD3wbX+dilsKMculcsIUBPG/UbRYZWCLbBwkFzWtBQyDuTBVMrtbKXWW+VDDpbe+ESHL3qE4Vl4LKQARuLUVbGAd/DPaHe/s0jEznPOFGdZs8gLqrIJMj0WDlFmsmCz6x6d9Ut4h1miHIk0SMeectbmX5tttlD4hXY7hdy/Yf0yQ3CCHcd1QmPMuHIfjltKiNE0e8pnJxXV0cvsRSbSevsjLCAY+cVNDquBgErnIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyZXLJxu/kcPRhVWGgy3wUF4fO+48OfFJIuPHDaFjXs=;
 b=oapFpDF5S0O6G2yO1aIuME23lOQSfj3AvOZ56BGk3s9IiAUyItwvBSuQ2ydfuRI3SWIK5mnvVbrQSGNnZYBSEWmUqy6wKSg7BJcIQ04rxtffYoo5ROC/UrbEkIzaOx8gS8Leyfj6Bt4iOkb1gj+QuggJoZCM6ZL08bP9jfB+BNs/T1i9OvOyh6bhjM+HwroirQnYoJIuojxnQdrFw/KdijOyxX9D84n1qXUIjqgGqk53Uf0FI+pf5gaH46kyS5iKSLlm8ehDVjikOSslhl4aYojDfOjOw0/wl+W7ZaIajT68F47LHGXPCfKfrWvYlkMZfQaad/rw7u6nGiQ0R4OuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyZXLJxu/kcPRhVWGgy3wUF4fO+48OfFJIuPHDaFjXs=;
 b=XS2NG6p5mjIoHTMrjEkZxC0rnBB3aCAkDgTpPAZzk1I+6VKJ3Np4VqN34lUe8jKZBmpwQ6WXWL7Mk5HjLiRnHcJJLRv+WIcpc/4lF0mgCYYAHnceJttOjSpXUc164Z8XHpzjXLbPNY220ZdcnTyZjvsvdFLFJODUeyAW72/3FV0=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:56 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::73) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amdgpu: enable VPE for VPE 6.1.0
Date: Thu, 24 Aug 2023 17:31:26 -0400
Message-ID: <20230824213127.2725850-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: e80c1f63-7453-4338-5a17-08dba4e98a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jl8n/Wa8nC/4dngj4bFS0KOKoXVCaTsaIsmPdbiWFKKiuew1xs61V0v0jPVfY5OQOAioUu6NJjRtRq8jCOajqkbl5sP3DopIfsThk2sGitsEFTxR6gToCmmnUC94HDal7Q6GHLa1cR+uSObIRGQVMbUf5dwr8HgMXhdCfuWUY9IBjJ9KqAx7S0XoZYeFMWo0nj9XezGu80kRTUyTQZtCBl0UzwGd+lU0PhcRnF43k1QDn13fGYpySwtIw0Jl1mDOtqDZATGF57smUt+xGgQnjCkxedwCb0/7bKLUEtDMpq7HlmQUfNCOWxhX/fwJleXK34QR/Ci7au/ixLDb97XwrCjslVXXA9hV9XfS4RkQ8pfC8TIvuF4uwW4gw4D166uosp8mlUPq1GkyKaTVHg6X6AMK3tGcvZIwJoSFNmDsba0XV349/s7Hnhx2te6hHYuqe1WMjADiSslx+eOCYgfKBNXSVdwAOaTqpIPM+d8h7FGwLAzHqQzb4pRxaSmJ+LTPMO1csxTc+K2fhptil/Q+lNYVgriBywFVVSZT3T9Wres2IFTUT4kDeWS0MriJwbDFTXfwiZszi+XFFI83YbtbMUqWTkEBY1/BWM1+1pPmvxQZllG4aIJdlEphevM0U7nTNpB0c5SsTByEzCx0Cq8QSqIY7XZSqdMylQPJZl18IxL0jKflC6I7mYQcaa5E3VPS9R1r51CeHTONRa2K9g/6+H1a59MpkvDn1+D47DuetU/QCDEq2qCJvBPzZBg1RAn4zvygcmFTybwWHscCNw5Dew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(7696005)(316002)(6666004)(36756003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(1076003)(36860700001)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:55.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e80c1f63-7453-4338-5a17-08dba4e98a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Enable Video Processing Engine on SoCs
that contain VPE 6.1.0.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c513b1650be5..ed68ed9b9e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -90,6 +90,8 @@
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 
+#include "amdgpu_vpe.h"
+
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
@@ -2138,6 +2140,19 @@ static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[VPE_HWIP][0]) {
+	case IP_VERSION(6, 1, 0):
+		amdgpu_device_ip_block_add(adev, &vpe_v6_1_ip_block);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2625,6 +2640,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_vpe_ip_blocks(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.41.0

