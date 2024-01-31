Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA1AC47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D4610E990;
	Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5761D10E990
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+bDtGZ1VNCQFymLaCN9LnmHXm9B1FlZExy1A24qZnYEMpBLgvf7DQ0YUxrC3+6yjbrwYBKx9Q3jj7UMiqqNDEIVM7GhftsotShNQr44uZHe3dA7p6BFQCnYQEF6zpJphUNYJCcQA0UJKFZcdk5TAbSPaWSbp5zcZibWCJz3RiEfhAW5ytNw2St+JR5fj2OkLCCvKlx/WC/31fF0Pg7lQj7dXxLxC0BfUC8TLD/zhxLUFMRePW4IabettDWHJ0ScfDR8Z74OwNg/B1IlyoBCQJJNhJ0Re1C+TeV6kY8/ntOlmE1fEg864NIGfcwiW4MaH4Ul3EkCA60gLARyf1B1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/qp2fAzsfulp61l3n9HxQW7LVauAmjUuuuvWKqJvjE=;
 b=eUkqkYZQo5Ubo/JSHO0SMCU/GM7NxEXTc1Q5P/aLZEEz1/LDOYm6Dfyda0vN2alaKK+MQ+LmMiP8AlThT9FrYzV/sEX9/At2r7VQQtq7xytRuWC2AsbJzutcURP3Dj7OfY2B+mOq/ktfxzmlL2AyVcWxANMFP1bsbNX3sMVTdjlxXlE+Ey8/+M38gT2xyfX8yx6MCFiGEQ84FxqoiIglT59s2QoU/wcZ8UtgcifiQXxtjT87YWVvq3Fx2HI9o/IPoifGLr9Yj83GcRejSa9/hQu1BKmQX0hS8q3qO43eXyVYFHUdWWMsJ4trVd5EG0mG9/j1vJA+jieA8Uv8dleHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/qp2fAzsfulp61l3n9HxQW7LVauAmjUuuuvWKqJvjE=;
 b=RXnjvhylZQdoGCqiCXJFSI22UwGYlRjKzDue4SB1hQnZy9ISUs/c9xEoNJQmDEFNuqA7M80u6rSRowLhF+IuCxvgpcj/ZR9pgaH3wpwWVSqWET3vIX8nuj57j3MbbYrQeIcksds9wB0sGsMFzSGGlHlpk0t4TRkzovbotMrC35U=
Received: from SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 20:12:41 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::f2) by SA0PR11CA0117.outlook.office365.com
 (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:12:40 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:12:38 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amd/display: Don't perform rate toggle on
 DP2-capable FIXED_VS retimers
Date: Wed, 31 Jan 2024 15:11:08 -0500
Message-ID: <20240131201220.19106-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 661d9ba5-cf82-4e07-6068-08dc2298fa51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYL4AUGWdGHROK0e6NtmEa6xZQEzPc2zeUZaf/78Jx2Ao/Umow4MdWU1/bnuJAZNjY8pZo6MtPVhTqE/RJ5tNIdIYF2UufMBiyR147v65b33aJdIZIKRFXS1546UjcywEu0aJDC1qJM4OE6jt0oVkQqv8EfGWavznjUR+8S9x/AyIJ8a1Zc6TjkDMRvQDXdWeZB7+PI0/AtrjCuji8U/TlKPRwL/HO9txt6A5U0bhOZ6FuU41HuXoXvp2qJGhn5/Yy2hZnVop2F2bhC/Ot3klKFcOM6v3aM6IjbAyKR5/Xgd1ZIYhfLaVZ1qJLqzi8M5mELxdWlHFPKtsQnA/5/TMrpJnDshdFKn1+ZOkmjmv+eUtRrjAW2i/TBIX4NWdqakFYEW1NWKkO97aXfQ7I17nDmQWwxUMK5N8+vdE8ZpKCsGFzNieFP6LA8eTqnd9nbkzMFtF+HN4on8i+fYMZTqYkuJRYmsctM8c1yIBUYl01Z8L/3fzsWZLhizsCIMlSOUUh1W8wbTo09vFIE90k8M5YBEuM5LDVIkQVGDHFSG5M3MMyWjJx+vPAZbI63ytB0QNXxI3eMRDhTlHGY1Lq/BgDM+Rfu7oH5XceJOr3YN0XH1JoZ8/UITr1aNmfWGT+qQkDxQjSxFcEoF5RjboTWrfFGWhtja1ecIZzMAoa2peVDqUTnuxp1MgP2eHa/p/DeTNSaHA+462UrvyASZIwnLxABLmLqpZL5Bsc034Vdst0TfmstIRFKIzwt+RaK/OvQy5zja6tfQ8nrVEKON+YOCtBQwoy+Y5+KF2QpZVqXefOY7c4zuikoeDjMjgwiUX3se
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(426003)(336012)(2616005)(1076003)(5660300002)(36860700001)(16526019)(26005)(82740400003)(47076005)(54906003)(70206006)(70586007)(6666004)(4326008)(8936002)(8676002)(44832011)(316002)(6916009)(478600001)(86362001)(81166007)(356005)(40460700003)(41300700001)(36756003)(40480700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:12:40.8371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d9ba5-cf82-4e07-6068-08dc2298fa51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Only required if FIXED_VS retimer does not support DP2-capable.

[HOW]
Gate link rate toggle with DP 128b/132b LTTPR channel coding cap check.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../link_dp_training_fixed_vs_pe_retimer.c    | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index c36e0e5df447..b5cf75975fff 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -270,18 +270,20 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 	rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
-	/* Vendor specific: Toggle link rate */
-	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
+	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED) {
+		/* Vendor specific: Toggle link rate */
+		toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
-		core_link_write_dpcd(
-				link,
-				DP_LINK_BW_SET,
-				&toggle_rate,
-				1);
-	}
+		if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
+			core_link_write_dpcd(
+					link,
+					DP_LINK_BW_SET,
+					&toggle_rate,
+					1);
+		}
 
-	link->vendor_specific_lttpr_link_rate_wa = rate;
+		link->vendor_specific_lttpr_link_rate_wa = rate;
+	}
 
 	core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 
-- 
2.43.0

