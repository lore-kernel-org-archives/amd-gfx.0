Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 03:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD2410E0BB;
	Wed,  1 Nov 2023 03:05:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589CF10E030
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 03:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhHmjLkVU1l3sIAtV8n/B7JP17SP7Ihz+yS8cttm9j3057x51qAuOnKxOVm8BT9gaKgltspxIZxPy/9/KRGOVjxdU6koF9twTVwwie4ivngBUYwb69m8jSxNNHJ7Nd7l4B5wkQLAs0vH+0KE9Gr+a0FP7nC5D4h+ZeSU4BoqjTL15Dc+OnVyIXKCFiYjfpRUsNqL241h+rT2jChLN/MPEfz78a0AY3sJy4w7OMnhh7H1pSQ6PsbfY4Lcqk2Rf6X4pitHaj9KrUnGx1aDbpC2KjRUNR0aTVRYlJzWK4sG8fvhnfoKy/aRgys/U//FkatmdJ38F7rJNZ8U2fsXK0/rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoMDX0N2Bf8LRO/7hawQ/m7rqRqIORxPJBtCAJq2XpQ=;
 b=e2mOWnyCNkHKZyImxTRFxO8HsUq0+Zxpxus2f340rOCtbEZgwj/5KheriJSqGXMx116967tHHiVKmxm48DlMcUIHJzhL2vejRPoiciQhC82gSlPVyF9PkarAdbwlFDPjWV+WScb788rN/lWAEtXCXxzYrfUismMsOC2BtVBMSx1S8q3LImSk3ZDQmOfHV3d1la4TDEvunXayErvvox9V37Wb1ol2B4esjICl8Ns9jjPCqaeVe4ROG4Eh8LQ3yXDHlulJtEIhWGQBiS2Ewf1g0oXVVxHq5ZYc+TvPNV4hwFwMHWrHrnXWiG6DxM3HVEsPfgGs0hOg+a9YRAJFIPFPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoMDX0N2Bf8LRO/7hawQ/m7rqRqIORxPJBtCAJq2XpQ=;
 b=RWsJzf1OxOcC4aPpG24VuWd8IPF4+ES30k9vjWQCBbToNMJ1/OXXs6qgwEKrA3Dm7PFb4VhX+oWAoO6SB9Jv6G8EM9oWOvJZFb+9xNQnc3FGooKx7KXTGEta+Zb/Sn7fMYjvzzi4h5pctPszpXPlofIi9r11zw+j96nYhuHm2fo=
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Wed, 1 Nov 2023 03:04:59 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::40) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18 via Frontend
 Transport; Wed, 1 Nov 2023 03:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 03:04:59 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 22:04:57 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Fix the the asic type of some new asics
Date: Wed, 1 Nov 2023 11:04:42 +0800
Message-ID: <20231101030442.1988771-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101030442.1988771-1-Jun.Ma2@amd.com>
References: <20231101030442.1988771-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a280815-1a51-48b3-4b0f-08dbda87557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWYYqCnqZFVZfzSJchqSIiyGjDQi6sVMR+CYfoZYlJUsXjyHnGiV2+EyhlX7dUOREE6tUNJW+1ljCmiDDCUusjK+8UQdyFlwDRTXTzyYFciZ+VxKE21lJQirsupVvvPRu7DBd20sbp58mcreidfVedW1fpiDIbAPfhBD/db9yTwWdOg85ZJ+/h95rlvgDR1wMgeGxCrG9syRJH7OFY0bkJnRArF3vMXtAwkXtEYGwsNs7dTgIAxBP3ph6AM/FiueSTkoJdI1ho1gRcwT9AVIy6CX/sAI+nt5jmEYQ9cs+iY+BZj5YEBuCsgcAo9LsbEH/Z8yoUKCc6x33RGl3fKqMbtWsvo7ycvaUTfsLI1sR7khZi+m0VpH3dVg6f3hOTjhAw97ehYtw9XejjXuDYEDpaA3z85+07SpHKyg593pXl/Mk5gfV7qQdSY0zchmYGCZM42ZFzdc+42Js/0a3tdCXgRQPXX3AQb1Qtt2k3MPJQzQ4rwOJt+4pMWj2heTg03l6TA0SzrrUyVOGcJ+0J+wSnKrSQd/3VyuFKW5zK1BnmkIjuM4dGAbPRi6HQ99mG2AjEQelioIuqJ2zdoGSQuLB4HnkGMHelRHmG2yVgbfj3LIkXjvkN7lZb/FK+MenGcEY1IjX+0CJPvOvy3nJF+rn/8a59hGDTNzQk0bLfqhCcLH7ZBHsZsyhPhrdEmWTDgpzENemjCyPU2M3boG/pyCsmrVdnCjbo0VQedMT27h2/M9smwcs42QIDqBazQp+GrDzY26R6+ksLdZkz3pY76wNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(426003)(36756003)(2616005)(7696005)(26005)(86362001)(336012)(1076003)(16526019)(6666004)(36860700001)(47076005)(81166007)(82740400003)(356005)(2906002)(478600001)(41300700001)(6636002)(316002)(110136005)(70586007)(70206006)(4326008)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 03:04:59.2393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a280815-1a51-48b3-4b0f-08dbda87557c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some new asics use the same device id as Sienna_Cichlid.
So fix it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 756cf49557a2..93c8c8b763ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2073,6 +2073,17 @@ static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
 	{0x67FF, 0xE7, CHIP_POLARIS10},
 	{0x67FF, 0xF3, CHIP_POLARIS10},
 	{0x67FF, 0xF7, CHIP_POLARIS10},
+	/* differentiate between Sienna_Cichlid and new asics with the same DID */
+	{0x73BF, 0x18, CHIP_IP_DISCOVERY},
+	{0x73BF, 0x19, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD2, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD4, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD5, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD6, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD8, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD9, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xDA, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xDB, CHIP_IP_DISCOVERY},
 };
 
 static struct drm_driver amdgpu_kms_driver;
-- 
2.34.1

