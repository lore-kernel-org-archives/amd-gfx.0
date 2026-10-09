Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E1CCA601E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 16:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22A910EA56;
	Fri,  9 Oct 2026 16:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OYK7GE5i";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBFB10EA56
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 16:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2d4fQpUx3QV/7LTIOpNjfXrlCjGM5xyYuNpy7v3NWjn4I4RZI/YaCrIjOI5nGQ/88d/bSfaIfRFalgY7W91v8ZZQP0b5RhG7FRMQb4U28ODJy+1NDsmYSPF+BXEVtgvi9a6EHLfm0snr4WNb+EDqj6wj5atGfEZRIoB6UV/E0F4ck97HuRr/qiWOPr/wQzsCXb8VAO5WIqxFVM1f7K3T4yobyCJqdrkC48pMdsq1CQBh/TecIh6yd+TG1t5PF0VuZwrAK/Xr4BqaZ8urw4Pk8iVoT3wU4aUjyIDQyc6NB+qoitgR+yUMjRvyJnMp2esiKtk4/qNV4lgeGs8LBNSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q5BND/rNT9ZHysP8/J2XPkW5fYY5rjpWLJaWZ93f7s=;
 b=YuVsybJlIyRb5vKu/8GTVBkSZzVhXbHOVrIjxBLVVSkVu0qOrblK0F86uCr0t5codCVf/vDMbXO8GVjViYOt13e4NmGyTtlqMF+QtkrdYFJGppaPTJXdlMf9ov0n9hxencyOhWOU2lyOK2ttBP+topGsWqqPRreuFIyFNi5FOshkXDH2I735WEC5cgjuODMtRlqtxAieLBTuRlpJa6nPXcQZ1Y4vLbQXzM5wQmI9ypOFuEJ+LKUCvAV2ZPiLJ+E2V4BhftfIZmxktkyfmN/PRffVTA7jGpoleOH8t30D9guB4uTQFX1Z81/IvO18ReFYfB5r0i7afP2xkgHRAPqlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q5BND/rNT9ZHysP8/J2XPkW5fYY5rjpWLJaWZ93f7s=;
 b=OYK7GE5iQstKwiOcXJ4Xx+bSgjOVukQTUn6Pgpgi74eL/kxpmhnRQYflXb1M5KHnNTmyTJmrMEgxSO1xWdQMVMpRgieQV1iqnqAFx1Xyh5KyoF4TG6YvEmZwCPpO/r9+V/Fn+JWN2n1h1VjPVALP8hATb+DpvDbXDiJ/N7cRk7I=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 16:49:24 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::9f) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 16:49:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 16:49:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 11:49:16 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1 IP_VERSION(13, 0,
 12)
Date: Sat, 10 Oct 2026 00:49:06 +0800
Message-ID: <20261009164906.206393-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: c45c7784-5a6d-4fe8-3497-08df262545b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 12sntg7IK2+7YG5dBT2qbfaDx46X+/QRUmdEj0w61GI7fHJcwsMaE2nBnCHmXHSL4LOo6g9jQOsxRkz2+6hmuDYFm6PcB+lJhV8QI79q7u5O5sAeOyBJ2fs8Bed2jHBzutAyUq1eeXZMU1JcvAC4xrYUrA77gpI+rjKRN2taHzc4oYhFcgNT9TIGAiAuFA+tn44WzmJ39nqaFG0nqJwKaH+qOfYf4gLtdYFlyQCzHnwXsj9H8Mx2WtYzqlY7yTsb4JNOWYZPj9aPIRVW15KMxmGtpSaw0wzuIhS5ljWZpHTbkHYZaKGmE7IjyOPVuMy//yT6bEOl2ZRxxkHICbAjUMP8STjpN7dD/XGBZIsRiltrXgI7L1ZQtAs9Bn0gL7jri8ZDKyKMYjs8eeO5MF8mtGG1sisJmP+ya7/dd0bSHhN7ctAcRCCVpYC0oAU1FdTDDN3bwk2Pdh+raiXKK9PUKAaW0oCpCbYNQ2cFb/c0Oesb7GZkd1G79M4YyNgzsKl9w0mqg8sef/tJm4Bv7MAzk6boYrVXDzs+oUnZOmgzeTirCnz2xDBLCwMizVbi27etk/FojimlKtXbMfLEJejFctysoHikrOxULS/3yyHuc0LSWhR2boH/7Xs3YNSikovNEuk1CwNEe+jZ+8oHXvAXLPcSPl/9OcdA95sArLwU/SS6CRwMCHn2rwpvJPBcWVmmv4ecMQgY7lFg0UfbGXUlRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YmxXuGz6ZkcJWPSGhl0mGkJm2slICQCM2M099vQn2q0x2BzKD5roAA3Rn10ZfqACmkv874ZIT5RM93DGd/1kuYb2FlKO1yFP8cdRNDV1MaWkXn4395YzvT/CoBAbau+169CYBoueXPhK7wp61cP2X/6a/BYzN+PNIhdn2i9st5es0Ivkr5HJGDj2Fwn6uSBrEzO8v3xHQYOk5HjGWWUd5eLDb9lgtNbYKlbqSZvofFNvFxNNTj76iZjRldR2Yo4zkTQ94sbUda5mvojlyEQp9yAF23KiH4LtR05AQOws9Gt6AZMv9wDdaoshBTwlRieO5Oce5GfCBlizClOqFU+qjgoCyvtKHS8YH7xLMxzyHZiH4iy2zdFrksyfgZja+yco8hwrGMxoLG92ylQt2hQ7m9T15htNHv3eLp5Ya17FfPmC6m7aO+CgsSc5o0jZAzhM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 16:49:23.3567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45c7784-5a6d-4fe8-3497-08df262545b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

For ASIC with MP1_HWIP IP_VERSION(13, 0, 12), enable firmware managed
EEPROM

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index fe0e35357af1..cd332fc267be 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -40,11 +40,10 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
 	switch (ip_version) {
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 14):
-	case IP_VERSION(13, 0, 12):
-	case IP_VERSION(13, 0, 15):
 		mgr->eeprom_early_init_service_supported = false;
 		return &ras_drv_eeprom_ops;
 	case IP_VERSION(15, 0, 8):
+	case IP_VERSION(13, 0, 12):
 		mgr->eeprom_early_init_service_supported = true;
 		mgr->fw_record_enabled = true;
 		return &ras_fw_eeprom_ops;
-- 
2.34.1

