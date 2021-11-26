Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13C4C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 09:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE336E961;
	Fri, 26 Nov 2021 09:48:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAA66E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 09:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqmPucpC+/L0Czgf8cvn0PFdTwTZ28gWDe6IeNfgRZ+/PsGcSEoNjWP7iXPBiuzZFN1I/jn6T3g5pyt5HjtBnh0yPC+jL5exmia1PZDp7fE3HjC3Dnkj1l3qVtV2hGeINuS+5YCjdBpcH+ahBRiG+y7g7juvz6cQoA9fElJrh6fOvZ2H2K9KSrnxEWykLEs8sw/J3CJA9EmpyHvSqSyId7ct42ru4HSaTuBjOGEjQLQLxGPjhHNzYU5UBNXZvdJ8Qm6fFAEk3J92AqrVHCPd1DssHo+cpMFbm30A6M2hBRlVpDcHn9+WFkFMTs5msbxWkwIt0NYYKJ1wytXHmA7m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCt4G0TmYQtDvHQoTl4W06RQUV53jsqUmX4nU5FgBik=;
 b=VA8zjwbc7qsqulk7YounzxZbKASBTWseBzq/7z1oOjb+Lu7YtVIrSY+cgghtmJhXXGdK/eJn7+5LllKKAwsPODb8RiUHd6MRKZ2qlvM2BDDr3OZg4KZFcr2VEbc2vLYUVXYIvkKS6Ckixq99OSK5b5SQm3y/TyhMTuedL6TUhGLwkOegNcL2DQcTQn/Z5ypvk0AGdyqROZNlduDkzK8CTZilbF6+iWiSOgYBwL+xyY1S26cJT+5p7leH/JqR/WN30qq66QuFY1G2wV1h1V51AebjMlyp9CdLvZyMlxjguF6CM/ASdtxpah1XNE5TgeSfTOxJNYcKEhbQFHInXDPm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCt4G0TmYQtDvHQoTl4W06RQUV53jsqUmX4nU5FgBik=;
 b=fogXFNpCCDTJUdNWfIlf/F940n9hoPoyE/868fBz//8Vf9nPsI95u8+eUeqK0fczPQ2DeaAjDWauwu2s83SmkwZ6TMW57KCPwRjpXxbWjwz4cKTjynDJWctHeM+9mF97386GZKQMkBkwy75fjQiUI1Xih1OCuVWp3q5KdS4gtr8=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by MWHPR1201MB0174.namprd12.prod.outlook.com (2603:10b6:301:55::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 09:48:31 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::95) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 09:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 09:48:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 03:48:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 01:48:29 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 03:48:27 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed when
 unload drvier
Date: Fri, 26 Nov 2021 17:48:26 +0800
Message-ID: <20211126094826.13732-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fee828f4-91bd-42a5-7d87-08d9b0c1e760
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0174:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01742CD9E8662DD5BFB15DED9A639@MWHPR1201MB0174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Wy1CSRtvaSlQi2LpOhI7buYo3RFLWdwtv5PvGXJaInDZcBy0IGwUQtbyV3YOpvEgHsZmdG4ONPIRPxmhvZgmE7FDN70AKSuqwMN/mk6+8Vtq49bIGIEEV45AAC7jQm/Bw3U/MMVR6fqWBYtqkoEriUgY+JpKHo1umTSl0MXlA2xUHO3HO7NSu0CDBHi36v8oksmp8GMRFMI47bwPZzv8O3WVPmEgBGjHk+wNk/v4iYtO8pOXafqJ/GHTbjEVNr49abC7w65Gk+0uDhB7vIuwh2RyRIb/QZEDMCIbKmJ7UNyTfO0vpR81qRl4IVZx3VoJAysCasgb2RHd1aNvHRTF7l/5p+BmP1f3uBHh5EKP0K/FAikpwvwPQ9M9LDTaoRuxgBelL/c2gOnjq9LNbpYm8oB96ut+j/hyhuaE+5RFmhTH4DrWOKU3QW68TcT8BL3G3mMTo3BsJjxUNWwKmhM2634Uwfv5BamoHLqukMi6gf0jXXuKgow4CwV8VIdRliGbBLPIFnhEyrpf6oXv15CeSU7GNHJKCdH67SV1BnvUeKwxdKJi/IU9CTVrQFPwYh5ZsCfyQeJ7QPbMOjpLFfakcJ5htm/8B3wvCjLzoLFJTkdGSfYd7W7/4ChtRcv5FVOLIGf2SGBbbVgTg6xYcldjcn0+odchI+hl3XACFu6j63Y0bRX5UUOrUu/vSn8D1i+ZNoCqAYmr2eR9l4E/fZH3mcUCTEtqkAi5Rqju/dopXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(356005)(186003)(1076003)(36860700001)(508600001)(26005)(70206006)(86362001)(82310400004)(36756003)(2906002)(2616005)(336012)(70586007)(7696005)(83380400001)(6636002)(426003)(47076005)(8676002)(316002)(110136005)(4326008)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 09:48:30.6233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee828f4-91bd-42a5-7d87-08d9b0c1e760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0174
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function amdgpu_device_fini_hw is called before amdgpu_device_fini_sw,
so ras ta will unload before send ras disable command, ras dsiable operation
must before hw fini.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 73ec46140d68..d5e642e90010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2838,8 +2838,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
 
-	amdgpu_ras_pre_fini(adev);
-
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
@@ -3959,6 +3957,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_fbdev_fini(adev);
 
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 39dfd4d59881..65102d2a0a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2484,7 +2484,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
-	amdgpu_ras_feature_enable(adev, ras_block, 0);
 }
 
 /* do some init work after IP late init as dependence.
@@ -2564,9 +2563,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 	WARN(con->features, "Feature mask is not cleared");
 
-	if (con->features)
-		amdgpu_ras_disable_all_features(adev, 1);
-
 	cancel_delayed_work_sync(&con->ras_counte_delay_work);
 
 	amdgpu_ras_set_context(adev, NULL);
-- 
2.17.1

