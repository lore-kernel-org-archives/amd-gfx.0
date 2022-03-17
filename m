Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADFCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 16:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D965310E032;
	Thu, 17 Mar 2022 16:45:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580E710E032
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 16:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihp/uSjhD1HDHBXVEcauOc9B7ELkNJb4hqdrJ7V9CAvMbyi0QqOxuneFcACpit8gonYibOObxSffPafW+7NcX0g7aYHJVHyy5a7irSv0kO/d941oZx96/vi6yW6aquJygOJLGWjVrLKhREkMFqOhNR5c7qIvk284ng69hgT/EXF74Oe1HFZW5JJ4dUvPC0nz5QlgdjMb6W/XkEN+Ckx5AZTny42NmJKBOMbTijJOuuEchdG8UiZUAFxhWV7E5hh9APMku8xuKsr5d0H5BoIyecSASEI2PpIDsFNWhyRze39p5xS4ejS0mBpyLzEBnTOMFUlO1Y9aF2yegvsV0PLh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck3biPthL5IW/V8SRb2lNALJB4jjW1G2wHN1tIZ3L1k=;
 b=NUqVGEEd68vOIsx4TCGPZQNNpRMpdE7wtsIB03e4tFrX4JGq4Y8WbJu9RZ7nE92r/aU6/ky9zCrc1Y2zS4SitbhXs3vmfpgQw7i4HQ7IkpyHaEUJSanmUtQhhImghiSj0Q2IkUJ8qri0/Ujtx3qpddlvZMWycZbqwkxJukNO/efTCX2CfuMem0u1Jc9by4ISAXaI8Knm2mIDAFpdMqyKeWdNYys8asrQ1Q+iRyEFsGcgUX+S5hK7GsDXY2HoUTT2EonH8WZielan1mn0pYI5S17kiBGr6oeIxZ0Q2dbikVyaZLh9BXzUvtRrm5+NmdBz63m0yHSyxHDnd6h0/Lmf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck3biPthL5IW/V8SRb2lNALJB4jjW1G2wHN1tIZ3L1k=;
 b=0aACK/FYvGGBKJNou1+0vzfTWkr4FDB6owlUpzGzWOmkRHlX7hMoXu1NtbRKuUVTIpVy9R4ppcx5JNinIL/8+ZUWEMy0ZooPr61CYo6WbkUi2w43xspXeggKaWvNlha7papb4VUHteucgoupdAhRHiZaTl2lVKl9x2lqwwejqco=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Thu, 17 Mar
 2022 16:45:13 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::3c) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.7 via Frontend
 Transport; Thu, 17 Mar 2022 16:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 16:45:12 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:45:11 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Date: Thu, 17 Mar 2022 12:44:58 -0400
Message-ID: <20220317164458.1365967-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e502e5-d46a-4e15-aa27-08da083581d8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50640372C02113A1FCCA79FDE0129@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoG8RkY6GGyMpBQkwDPYbj63FrB3cUPXW27e23sc2joTeQfD+JBo/V4q0++4corHm3T0GzQxfUHSqGILc+KiyecaQxoD0Au+93iibuObfHEgtRoL0DP8tWMKA9AZwjb6tEZBJfm0Oy9OlKgdKRqYB5Quwb4Vojb0RMNSDKJ0cd+Lp+EGSYvzj8R3Jst3WrGzTu2tFvh89aqHEQy2s2HUugXEGF6MIy4cXwuu6FZh3/JQyDNddR1s0Bht25yQvqepRTlpOBgafDhiBUjKaYa3M4WWX0gfpEIufW0r/8m6SXomLX35DO98103u8ZmGz6y7Z/9xR067PrGZXiPjCtWdV5Kyyt7eqEUyNSXHdIBTetAWyPm3mApZzi36s/2mHgfxdauuF9exR3D8XLbkj32TZKib+X9F7KwQ1jyWT91PtgCikygN3qAjFYUUnagpKHRt/7h0jkhwK/tqoaeCTGAWqsUsqZ+Tj3xkFTrC+vbxZlQP5g7uvp5q1mekMXUI6Xyz+qkh5+plreL9stGtGF6ZLLsACQ4cYo91Wrw8HuW2yz1bUMsMrcV1lMjxjBjen67QFXu4TfesTD2mRkbP7RFUE1Bh/vuo1atuxll8V1SW0WZFrktWNtQddLNO6IC1CrMQ+f0RWc5KRTLeYSErUiEv9wiJ+atXgoBJ4NsEU0aYkSZacgZS1mxIZ59DnQt+yFq+a2XxhuakvxIeswfPY+/R2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(47076005)(26005)(316002)(2906002)(70206006)(36860700001)(8676002)(36756003)(426003)(186003)(6916009)(336012)(16526019)(70586007)(86362001)(82310400004)(356005)(4326008)(44832011)(508600001)(6666004)(83380400001)(7696005)(8936002)(1076003)(40460700003)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:45:12.9689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e502e5-d46a-4e15-aa27-08da083581d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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
Cc: elena.sakhnovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sienna Cichild, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.
v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..c4fd70376481 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(pptable->FeaturesToRun[0] & ( 1U << FEATURE_FAN_CONTROL_BIT));
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		smu->dc_controlled_by_gpio = true;
 
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
@@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-	
+
 	return 0;
 }
 
-- 
2.25.1

