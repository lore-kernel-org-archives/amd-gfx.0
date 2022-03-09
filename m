Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DD6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 22:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC6C10E4E8;
	Wed,  9 Mar 2022 22:08:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A5010E501
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 22:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/rTh18/FWR+Wq9Z+XvXg69xRaS/cKXZV5Vosk2hh+6xJZDuoHS1Ntpp/S2OR31yUlr49t/1tiKNXpE2eB68w+2RIzuRc4HE2az3ek+l34mqmpZfFhjDKPFspa9O9wat9yado2iCe/8RJw0V5mHFeNOXcwEyMxyiatQrIaRb/ghyavo6GJwOE6JFtslKfbmILAvMoH1cr+cyr4tonvLEecCWA6/mgvlniXnJY5rZF1nyCKht1e2H18KX/JddDqs89j+F3nBmFtVG2SpmAyMhZlFLhki7D+OKJvo8ieXv14LsS+S2Ok09LAYqG8qAceOvNuktQBWLyJ9QBEGFaH/wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCabvT4pLpzimTL0gDhhwLpRor0CSJJdpBM8DbVK7ys=;
 b=PiaqknNZw4R22V2PXHtWaebRNsuYDqEidVZVAYskVO9seIatcDD1vaoVcq88MHUXDc38uKiR770VwAwKq7yOP1zFecRF7yMShHJmgjNgwDPs2BKGogSZob33uXS1ouD/SvkqijwOG7oGka3cOUT7BarYtx6R4yXQXActKqlFAr/9FY4xf4jdLNlqz6cvHCXZli7BQuSLF+e/CoI2oxIt0D4y51dccBvx8wWde5P11Y8CMiKYLnQpf3LVP8+Y0NqmdswQIcrfitinx730S1F0tUJq7BX8c/ZbPdcUegAl6gGSrvGTZb6S4IwY78YafLslNCO4gDRRLd1pUTYrd0xsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCabvT4pLpzimTL0gDhhwLpRor0CSJJdpBM8DbVK7ys=;
 b=pQJdGQGu7BcSKUszNZ0NYIWOjut3nLzbRBT8Q4/TGBfAEhTJ6ozfG2uD6se4Hl4BjeNdS0KysRWf884NMBzvKJ7pFRxWkW3OvLpfoWq2AivRxZw3P8/KMd+WleJWFvjPfI0a7cDM5s/H90S/779ib6dnP8jKc9acZPc5ZSIEj28=
Received: from BN6PR14CA0003.namprd14.prod.outlook.com (2603:10b6:404:79::13)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:08:12 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::8) by BN6PR14CA0003.outlook.office365.com
 (2603:10b6:404:79::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 22:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 22:08:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 16:08:09 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Date: Wed, 9 Mar 2022 16:05:48 -0600
Message-ID: <20220309220548.2541074-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02310f1-17e0-4201-2218-08da02194c71
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525822C5EAF09A34F6EA652E20A9@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPZTnqaKA4XGpv67bkutT4DeULhMyykRfj38/BUWdf/mNxGuXmBCN9IU1fPukp6jLtOvyOU5MqA5CBKKvftjGVpBay+aQX5EdvNjQsK2nS3IZzxYG2UDoy+aog8tPogOhryy4itzKTPjF1ag5VpSNW2BkQtBsD6KovCPmzA9DM/Td2bBtWt/Se/hytAdDrjoVhaxaQewwOm52owr+jORXTV0xubkq99TwL6k05SlpRv/DgRv6jdvTHbqODr8QuEkaRMnYdBoxE0B/bAS2no8C7++EIOUxnAEZgD24xJURzxLDHTuNZixKZjtV9T6wrzVW201mqwrkze4m3ZvjgucRiVJvU6Ss4TGFmOCYTUqDn0dqjiC9GzW2eFqFSXUTyo8up9I/8wlP4sgXfm9fTGCx+KhzMqZ2kgRvTcda+XxBVeTkqoeQS9sTUL+iVjgzaN8xVZvVRhSlAbwwWLqqx6R+4KPWcMUgvhTcKSIYTQA9GAxM1D56qnEUVHyP7aL31Yqj2qUeELpz+YBrpM9+kp72r2YwLlKb/N9NlnYMxXg4/ior+yonAwydyiDoIgHll/7aeDU7I1jq2vSdJKf2UgJuNFnAT7NsEbUxW9ezB6qt/bdZj4QuH50Yd/udyV/UvcA+j19qY6Oj3ORdTjubF614bN8ljm9/DzbBabLhGP4GgrIKqOyHC2zf8Z5Ch0ezh9DRkyPt/XWUQt+MLziv/FzXamQy8DTbnfjqDB3twRwXqc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(4326008)(70206006)(508600001)(8676002)(40460700003)(82310400004)(83380400001)(356005)(16526019)(5660300002)(8936002)(6666004)(47076005)(36756003)(81166007)(44832011)(26005)(86362001)(186003)(316002)(2906002)(426003)(336012)(36860700001)(2616005)(6916009)(1076003)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:08:10.5485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02310f1-17e0-4201-2218-08da02194c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`smartshift_*_power` files are showing up on some OEM programs on
the APU instead of the dGPU.

Adjust the logic to the function `ss_power_attr_update`
to detect whether or not the attributes should be exported.

The existing checks that are dropped are already included in
`amdgpu_device_support_smart_shift`, so this can be simplified.
This causes attributes to not be shown on APUs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index cbbbd4079249..ccd0648c6789 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1884,10 +1884,7 @@ static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device
 {
 	uint32_t ss_power, size;
 
-	if (!amdgpu_acpi_is_power_shift_control_supported())
-		*states = ATTR_STATE_UNSUPPORTED;
-	else if ((adev->flags & AMD_IS_PX) &&
-		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
+	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
 		*states = ATTR_STATE_UNSUPPORTED;
 	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
 		 (void *)&ss_power, &size))
-- 
2.34.1

