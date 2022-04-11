Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD895C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8255D10EDFF;
	Mon, 11 Apr 2022 13:32:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2446C10EDFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENPpg+ju1/Qp1XtZkRGJT7Y4TLhl8uL8o7L8kW7p8TMHqnERP2Ke6fO6yuD154aIDHRgohKR7+hQRPT4wDRp50jhLn2CE+nuj9cn9xk2tVqqCb6yB+cIYWdJ40FkkAhNzlT+1K2etIQfg+WwjixU0cmOmmJvp2COHvozheFLzPn3l7MagV/+psCJtiHD0bnJftOuSqiUnkDHJELgVmHWiqTN0NdqV7ddxgGX7K8rQxspZPxnV6cZgKWSanynLDXym6tPAULv6+MEROZ5N1wKRCVnyzKiBwg7fWjBrXjjmDX6os5OWHXnNY3ymkknhB80XUY/Lc/vTxea3NQ1t1LKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KzyNKBPEwGLFHw56e1/xMbTP9pvQuJGV4rHN/4ELfI=;
 b=Q66qY4MMP10+TcybPa9zN0FeR4Ox+UfKAtlYqYEpjJwOwZC6ofEEmAAm4ymaAfQrGBagNORtNgqO0r6qAq6EsUyvqpAvtUIeeFTyt4H05/Ng7z/8AWgnz0cVoduQld/KZbAzL+sGa/hPuyWtNYbvtFZ2+kEZ09mcbA4UIDCuxulLH1lk1/w4ZvBFcMZn3Jjzq3OIvfw22Wsbs8Z/8SbLMNc/BBFUFlev5d0UukPZqZrOkZAGhzqu4b3Nj7v9ptRai9gQv6M/WPJ9J42TZBINE+KrnTHhBPlWAYL7RqFIM875oW9K6pEuc/7V5bqDHv3POryzfEyYJpUFOGVdhEecGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KzyNKBPEwGLFHw56e1/xMbTP9pvQuJGV4rHN/4ELfI=;
 b=IkiH5BX7BM+eAeg6xYHj/7YyA3TPkhRakNhtt+2pkevSaFNIsCxlruqy7QzPQGGnT9GKOPhlv23bKHu+FRSmhhG2YziVpNYpvykvBJI2VUDXVhmj0rE4MlFh9VJ+5BtVcat17MZmLLwITIZkwEz5ZW1wNg139spTNy8koX2qUAo=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:32:33 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::59) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Mon, 11 Apr 2022 13:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:32:33 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 08:32:32 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Date: Mon, 11 Apr 2022 09:32:16 -0400
Message-ID: <20220411133216.3407198-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7025a2e5-58f5-409d-068b-08da1bbfbc11
X-MS-TrafficTypeDiagnostic: BY5PR12MB4804:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48043DBC0C8447E508E0D268E0EA9@BY5PR12MB4804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFlYFEIjcgiw63axbHhsN55D/hz8hoz5vg7yBPn+vbLJN7JoqugN6qmDPen1/TyeeTCSaliDdjUFbu3rEK3uZHroxn1q5ts2tLGJ0rjJKQ0uNvC3ISuatyLJGN6XfNPAp94TYTMvA/64AqGB3pxp1xsESMia2MOuGML85zjqJHnCl9yaUsoup8tVbDlVfnRSCC3EoWK6tFiNRnRvz4YkurpfONgZkhNNWtVERa5ynIbfNRhowsmRNFEFMxUaExzX/xPp3LMID4noX60gjKVFhbYBcsyHLVMKeeYCDAfUNfZvlu/4KgNnxVQ/4usJpbnN6LAarTb80vlsRT24oN2TkxixHbMFFBi9QN6VNQW98WF/VIsw29MUaXceY++ss6vBTwvyHv1dqDvNrQgMfDM+KOxV0DG6HVrZC/0/btM6Mf0m0nI2xDbXvF6AAnWCK0MDrTtcvBSwRhE0p/FoFL8YlPRZih+HJ/stkKIykYApwrgBjhFRHC+jJX/v+j7qBGEFo6ElVzYvCcRWrE33zWZdbRAQaAWHMoTdPP2dKWq8N6GOFkcWC0k6BJ6ZLXhQAj1WPyvysQ5k0R75JpvBs5ilZn/bpHRa6fiHwA0nlQ24gF0K1046pu2LmQ8Pvzzkm9ze4ib3Jup7OTCI88/vyMkYjl1C46ovGUzPv8CjqX580ZHQLDL9cmSB259+srzOb9ydLMlbML62MmOOByHCHiMgVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(47076005)(40460700003)(70206006)(186003)(426003)(2616005)(1076003)(82310400005)(36756003)(508600001)(36860700001)(336012)(4326008)(8936002)(70586007)(81166007)(44832011)(16526019)(5660300002)(6916009)(2906002)(8676002)(356005)(83380400001)(7696005)(6666004)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:32:33.3188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7025a2e5-58f5-409d-068b-08da1bbfbc11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
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
index ab3e9d8b831e..ddc388b061b6 100644
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
+		!(pptable->FeaturesToRun[1] & (1U << FEATURE_FAN_CONTROL_BIT));
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

