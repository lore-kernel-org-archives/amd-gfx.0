Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58607C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA62F10EAA2;
	Thu, 27 Apr 2023 06:28:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7978510EAA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjyHrIqnnmOktbFcDwojAIWIMXMmSnSVSG+IWRnTgbpcC2uBXyWzQ8c6OKRgEXQ+Q0Il2Rh/OlkaAgVLoHuk1Q6jDnCVRG+OgdHwNTvN+LX/2k2TtafB/TFlMepXombA/eJsi//U+Ycsfv7B4PRDrJ2l5Kx6D648c4TufqxE327/BI7Ijwdk5/KeErmIwBn6M5DFxszMLN05jSAB2RikOx+IYhKtwobFF9qH/nc3MT3pySzNKMHUgCbwLZNcLZJaAUsrrlHNreMo6ebBrKerYM65KNpQoWF9LWYRwDl5/TGd6NADyN2f0tMarwIsmMhZ2/U9NuqIU6Ha6dLvVNy0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyYiSjxMcmfCwZ0SE3OheZFNeEnrclas12fkyifSTEw=;
 b=oUynPCsNgONq2EkbPgIEprXsDcGRYZbG+ulJ6KG7fr5ixeCXQJ0ZsmjQhcP8a9JITDpkDfgK7Yh7jMU0D40M3h/jw+vHg5s9n8OgMRZbGsE+1QgKf0FeID5Xe+b9V+yn6PM0s6wWrTSB6c5xgvTZpOTVTOf94Ag8t+Aduen03atQ+5b6yZDlBBKjkw3rey92/KaCY8e0mlozZfd5Yf1QE0qigDChT8yaNsC+9ey6v3A9t9T2+SxvAE/ApOMf7cgqKANiIaIp1RzV2ltmF3LX1YkR5bGCsw8GVe0GlzmQwsE0RO2sRCGaWX4KRlqdtXPgg4G7kRqi7gzYd6lkji90WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyYiSjxMcmfCwZ0SE3OheZFNeEnrclas12fkyifSTEw=;
 b=aQu47DZyyV3sMn59L8MaKOhi456xVkf6Jsrn8uPeBRImzJlHjPqSzGJ+Cws+Wn+0UJbDFeBxF6Tc5qV9TIdA0s3qfeg4+anYCzt66kTlQL/6gcdp+FJi19VyaQJmy3hh10dV37y49DXk4jA3Nza3EXKLw51zkekk1rfjT8cpb1c=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 06:27:54 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a::4) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:53 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:52 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] amdgpu/pm: Optimize emit_clock_levels for aldebaran -
 part 2
Date: Thu, 27 Apr 2023 02:27:17 -0400
Message-ID: <20230427062718.1172269-8-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427062718.1172269-1-darren.powell@amd.com>
References: <20230427062718.1172269-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de14d5d-1b8d-471f-d3e3-08db46e88876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpZR6R1pksUCtEQ9l7mr/DApcaAw39/BOrwdSd34zJpFGKE9ZBFeWK4+OeANffPTXB74eMpd9XX/TUtVVW501vdsJonNFLOyZR0Pu49YpYmiT/ikB5hC+RGcl9Vmg2kDEkPnoVx0I9xVmqIC+fNBADwRyotBvvVrFTkCevkXVa/0ahlS7lVOS2Sce15yxxbHY56PbegmBnp7v9WzlD3QGWh3pGVD5F/d7O6t33f4yQUY7x94rh+KOFfzE2DhHp43+/FH3RQt3ntjReosxizNGQV0YxqajbxiG9uCJ+Rjt0cMP7cZwS0R4EjbrfA4X93QOCPvXSoS4oyUw/829BoVvb5Bi4OlmceIAiV1lUFjHOS1k+nbhW7pnOzvh1g+X8GUPgmwI2SLWMx/IMHwonjoPINOrqgJZ5+TLCmi/kRAZOW+XH+13DS9qITsRJbNjFCmqOkLvG9VwWyN7fqsNkfgi8WL87ieet1BAA349jX5cr9muw85hapl9yuTnmp2UFycHy2F27IWTVZ56REDxWRYi5qS3oaQq5RdYszEoWX/8pufd+9lNz56J3pd4ktPKnCoRTpHQziCo+CBKanLlnbBbyqGvhBOR3eLeCGuAP1yG93sUijrEtA0x5nCn/GVaSLF5u7yKBpFOd8unySi/u8eB/9Wq0+UrQRT7N1pA33jRGFkhYl3zNL1mqotjR6JxBw7JKmqCAijTahFGVU93qkPmnYdamcFJZlnkELaDylHRb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(6916009)(316002)(16526019)(2906002)(8676002)(186003)(70586007)(36756003)(44832011)(41300700001)(40480700001)(70206006)(478600001)(5660300002)(86362001)(40460700003)(8936002)(6666004)(54906003)(2616005)(82740400003)(356005)(36860700001)(26005)(1076003)(426003)(81166007)(336012)(83380400001)(47076005)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:53.8434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de14d5d-1b8d-471f-d3e3-08db46e88876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Cc: lijo.lazar@amd.com, ray.huang@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
 david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 Use variables to remove ternary expression in print statement
 and improve readability. This will help to optimize the code
 duplication in the switch statement
 Also Changed:
  replaced single_dpm_table->count as iterator in for loops
    with safer clocks_num_levels value
  replaced dpm_table.value usage with local var clocks_mhz

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 75833bc3d4c4..b315353adfdf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -792,12 +792,11 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < display_levels; i++) {
 			clock_mhz = freq_values[i];
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (display_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
 				clock_mhz,
-				(display_levels == 1) ?
-					"*" :
-					(freq_match) ? "*" : "");
+				(freq_match) ? "*" : "");
 		}
 
 		break;
@@ -818,10 +817,10 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, clock_mhz,
-					(clocks.num_levels == 1) ? "*" :
 					(freq_match) ? "*" : "");
 		}
 		break;
@@ -839,10 +838,10 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
 					i, clock_mhz,
-					(clocks.num_levels == 1) ? "*" :
 					(freq_match) ? "*" : "");
 		}
 		break;
@@ -857,13 +856,13 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
+					i, clock_mhz,
 					(freq_match) ? "*" : "");
 		}
 		break;
@@ -878,13 +877,13 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
+					i, clock_mhz,
 					(freq_match) ? "*" : "");
 		}
 		break;
@@ -899,13 +898,13 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = aldebaran_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-					i, single_dpm_table->dpm_levels[i].value,
-					(clocks.num_levels == 1) ? "*" :
+					i, clock_mhz,
 					(freq_match) ? "*" : "");
 		}
 		break;
-- 
2.34.1

