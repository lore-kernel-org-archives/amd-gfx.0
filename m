Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF37C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 15:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E96510E913;
	Thu,  7 Dec 2023 15:52:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A961010E913
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 15:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KypnpHs5X9vWXXxdd84uYTYnb4LG+YvbO1qQdpRQGmEyW6KDR8usen0ZMag1Vy8ClIJDL6ZYnMJmjb9pN4gpllGago1QeR1bdgSsYKnacQQtyvoMMtT7hZ7BYhfshvzF1YjX3aRAIaMrDuLzoiRGgJy5rg11q7FOmOnEO1gMX/fp60o8shZVqlplDGpNlJQ+gtUMGzjSyS4Dmk6YMGJApqyIifdpuqDcysxqEaYqhmWzcZjmLAIs4TtzAn1h/jE1OGX2857x8D1GELyX9csGiAwUhJ5VO4tP4XWP+KBKF5JRB++1we4II5/7mhmxfIz34eKjvAhHkhhJPJdmLyjSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECW3E1cIzHkJQvG/nyRYgFrmnfXwDDXU7isgDNxES4Y=;
 b=kuxFd19NlHLcFcMQDnkoNvr7od6gJD9IC0odqwqh0BXfcdz1NzZLCg9GPpz6HCpbhzVVM78392TgSPgPqEpMUp3b4Cs/95PWssZiXVNY+GwcVp2gUG2WXIzh5ui6vAMSrc+A/L76oXZZt45QbR6Bi72tRxV2zh6Rp5W05o78YXhb445mT1qZJvEN/+J9rcMpcarpJ8rLFqe/d+ew9T/s1bUC3JltZktZWVITDowrBumVrEmB8n5ogdZ5TbUkNAdAmBD5AyOM7lc5DYFcYYOpJH2DiuZaHc9WCVEkW9O1HwIPphaxF9fbR2wNRj1T5SQTKuXAvzEGsxm1wQzkAnwJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECW3E1cIzHkJQvG/nyRYgFrmnfXwDDXU7isgDNxES4Y=;
 b=ku2TS/BlGEty6xUmNCSSkiLFJ/MNY/0/gCoJqtdofyttLWos6RVsG9CZm/iDhfePrWA8cOYBYTNcwnPz//iF09U6AxlAWoahvYVgC1VEjhhcEfLGF0/4fOCY56iLt14WrkICgLxKR5YrzhuN3gIwQJWdgSUcS8SH9Zf69DniNCE=
Received: from CH2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:20::22)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 15:52:41 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::ee) by CH2PR07CA0009.outlook.office365.com
 (2603:10b6:610:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Thu, 7 Dec 2023 15:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 15:52:41 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 09:52:38 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1] drm/amdgpu/jpeg: configure doorbell for each playback
Date: Thu, 7 Dec 2023 21:22:22 +0530
Message-ID: <20231207155222.734041-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 38abc06b-9cd5-4b58-0a58-08dbf73c8ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LD8rOuS8lqo2JHHZoy2dWs0poPhIeTMErINpNpDHIB7YmgLo5UCBtjBAYKR3ymqiWhwSsZVAuGKra8Swxy2ctYzHG5PzizBOxuXCodW0vFUH3Fp74FNUej+sjBWE3DWeCfKOWaDix5J4EPpDK01g6s3QTmjG0zt8JaL3p3SzksR1lxoFnALCOfitWLjNzfOk1Sm5tTA4A2YurWiasznvFbeBNyrTKYlUo/VwsulwtA2S80EGvex+gQBX94U5ePzTFxnFEqQjON34FiBUL9n7XAwidoNXkHdtvEKAm3ymiwSF7DQsuv161841NlWjNWtsXuvpDyDxlf9uOioBP2MM+AV+YcegsE4mBFtP1WwWysyHbblKQA2WgocoYhTDBZlADO3GteMV8WNKh9ZVl41s/BO11s/hyd6hmOZBsEY4Join9GAjTbiYcQPy33kN+miI7LzkqSlp6/G1syRWGdzCdSu/8pJpfYOuy+MsfTZD6UjyNr839RMqVdUiAjL+PsIXI17UKHppOstbpHcmdoxGuwC3d0ERcUrO4PRBAdAZSWcn1QzUFw4I7DYHa+dCY9lum4iTYoW1+ll+tDS7FViWvj+pgG6TljU4h6XV142l7uYN/1CDlfAK0j5/7mnYcJMzDG6Q1RDoayWLzm1ZWz74S+XSpBJuRKWKIh925TWtP610AJrxjG3ywFVF0DqkpkfLMpfhyQr5UlvvSyx7plgz/NPgv5kbhAZ2DimvRog+W6phlOJRazyXnaWl6uaRbxFRS4WFOZQARJxg3Rq0TP/7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(81166007)(47076005)(356005)(7696005)(16526019)(336012)(426003)(26005)(40480700001)(8936002)(8676002)(4326008)(110136005)(70206006)(54906003)(316002)(70586007)(82740400003)(6666004)(83380400001)(2616005)(478600001)(1076003)(86362001)(44832011)(40460700003)(5660300002)(41300700001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:52:41.4870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38abc06b-9cd5-4b58-0a58-08dbf73c8ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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
Cc: alexander.deucher@amd.com, sathishkumar.sundararaju@amd.com,
 christian.koenig@amd.com, Srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Doorbell is configured during start of each playback.

v1 - add comment for the doorbell programming change (Veera)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 9df011323d4b..6ede85b28cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -155,13 +155,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
-	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
-
-	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
-		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-		VCN_JPEG_DB_CTRL__EN_MASK);
-
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
@@ -336,6 +329,14 @@ static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, true);
 
+	/* doorbell programming is done for every playback */
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
 	/* disable power gating */
 	r = jpeg_v4_0_5_disable_static_power_gating(adev);
 	if (r)
-- 
2.25.1

