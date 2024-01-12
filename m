Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA3C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 08:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55BE10EA84;
	Fri, 12 Jan 2024 08:07:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B4F10EA84
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 08:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPCq9bbTLde3tNqHflcNlHsnKhfVPveU3UNiHTMHKqBpWT1545vDZFtaSEuBljURKL/pt/1gLjc+k1XKufQHG0cjKA0k0TacW8LI88Uj/GyvbtXFpnrOa+QKsnrh9KOcGWXZ2AvaP9fcXVnV1zVHEBj1+Ga60KdILVpoN0SnUMmomr/ndZ5bggqYw+ZNMkYCmCml0H1WESHvaPGgblN3WBjPUC+0AsWtPzFTDRjiyr9hmbwWCQ5HzPvaCdxPNGH0OrZpqoFeIv2oUnPKh/F1BAnApiMM3zUkYbq/oNmmK5AIAxwZDLxZnkxnJ7ecyAcA/HQJIlLZrXj2XBmmpP5PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJxzagO3X5FWvFme3c2G+VJ6yb9D9zn1/Cq42NlmdeI=;
 b=B5W3dGVVa1mc4s8gHEYULTZnho33Oq52yxfZNH324gMswbAMiAkYoyGyDxG7DoJeZWA7mHt7n1/7WjEHwSx7c1mRmJUX19pNrRuA09eVzy8v4pMBabnjiEQqZMsyLRJT1o47zEpeX/+vfe5ARIDIzh405MHWjrKnccFzc1EjLV4DWVKcODLm1yfLnvT7Iw7aA5IbAew09Gu/w3W7xvGEpX2qpWLF/hBjw64I/mwWYK1DC/kUblN14HJC3AjJz0VgPqBGCBPW6/Snld3YUPn1nXwXtdaCRKodXL3iXgiuHMKKpto02tfbTByhF72MP9OYxPYTTu/qNqCsMSBybBSDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJxzagO3X5FWvFme3c2G+VJ6yb9D9zn1/Cq42NlmdeI=;
 b=VfbQj34Ylks35k0oEv59xo6N36ugmIyIUqyPuwLLRb0MFU2RUh14IUdstLFlwwRzPTx9aMEkpGSt6r6EdqsR/ttB12fkbhUPuzpsbSltzurqSto6AmIvVSk18GK7OeP12ULD2cAxSNc78wnDuf2LaCpyZ+SqeFx3A7AywCJDiC0=
Received: from SA9PR13CA0160.namprd13.prod.outlook.com (2603:10b6:806:28::15)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 08:06:57 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::c2) by SA9PR13CA0160.outlook.office365.com
 (2603:10b6:806:28::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.13 via Frontend
 Transport; Fri, 12 Jan 2024 08:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 08:06:57 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 02:06:53 -0600
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: init drm_client with funcs hook
Date: Fri, 12 Jan 2024 16:05:16 +0800
Message-ID: <20240112080516.291675-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 17149c0c-dafd-4a56-f86e-08dc13457289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tyzv9y5V7DZaJlJCunkVkJRw9KpyTMbEWv6c8dWkENiNts8OigX1K1J5v4gaED0apimb7zHzLDkwDPHEYz3sY03T2fWl5KWMnT6/QHdDS/xP7MyHkuUD/VqXjOiBzPFJtHpoilpUCEur2k7yOQ7VK/0ZcON2dCVNOgUhUBvKPmkZEAC9PBAmZmnJOA6KRtov9hSCxs1uMn14P5uf6pPmqaoZeb9+Y78RM5kfoVU5olvyFGS7CPu25GhMn2oDttIUIMxl2CS6qvTFztzA9TCim13hi2Mcx0u7s+jLDBvPwYCPIYnhOuPhKLkwmBf6XsPF+/AIlJqv0MQ2kdHkZz74peWjQX3sBdnie0aTcQhcyC60I1Lst+TGHU987d0Oa52DeU+sY91T7A3wcnJsw8KC8K61tJaOkY781aDspU0p/Us6H05Gq4z7fQsfiVVSAPTeeXS5UzQFuXPAKAg06dZdAcPHQY8BxhTe1yJvbDssxdVEU5YbNe9+0DK+d2JuJffketpbz3b+wrCKmdw8k+zxu1LHO0SLASH7pBaXemtcCqj65phhrLKGsN91zQ05io44t+am0jfPgK36ZgV2EDqZIFu81F9im+rCDAeM9d1gOKr/uOFSDk7UH9eUxJK3iVv7Vw6+NCAiyqyhSmCVJp8R40LZ7AKfuPw8IpdQ0QZYPGsFb8NYS7GUk/7PqPO1zwDghGHB3/o6KLa2G8C/IacTevlgCC58Z7ySTQmVo0cFd/Dk8Ovkcs4UziwU/Jfk2JrjHZXhhbAFutNzuoOrdCVa2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(36860700001)(5660300002)(40480700001)(40460700003)(8676002)(4326008)(8936002)(2906002)(81166007)(26005)(426003)(1076003)(16526019)(336012)(2616005)(47076005)(83380400001)(356005)(82740400003)(86362001)(6666004)(6916009)(316002)(7696005)(36756003)(478600001)(44832011)(70206006)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 08:06:57.4302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17149c0c-dafd-4a56-f86e-08dc13457289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise drm_client_dev_unregister() would try to
kfree(&adev->kfd.client).

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 067690ba7bff..81af6bf2f052 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -138,6 +138,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
 
+static const struct drm_client_funcs kfd_client_funcs = {
+	.unregister	= drm_client_release,
+};
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -161,7 +164,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 			.enable_mes = adev->enable_mes,
 		};
 
-		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", NULL);
+		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
 		if (ret) {
 			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
 			return;
-- 
2.34.1

