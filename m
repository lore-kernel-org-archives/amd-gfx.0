Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C0C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C3F10EAA0;
	Thu, 27 Apr 2023 06:28:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9053910EAA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n11yvS11iD9iuBovv9XUNG86HaE7EEuRoCa+E2o1zG0XEhfLrFPQZjmrUl1uf5T5CXQaEs2iug6sAPYY+4OdaPb/1+CfrY2hQXbsRd7uig0qDjTAAoH8lPf9OjISzCHx9rSF+NBtuTiaIA+NuNWnr/IBgO9u85OnEqS9n1Kw1FPDfPn+DivI/+7dqzX44cDS2rbsmQ0BPvnOR0xom1a6BWKMbL/wZpUwWTAX+hlrEneXA9wk4gjkp32TXJrYDf0HUT+qgwOCofWWGFMdb2ALghh008aPicwpqtbEVX7E3J2n0iJwCQEGQFMDycDTkPuGw+KMnv1PXIOPlVQnWXx3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4heiAbEzji62rZ1th3PqZORAYiVy3DT9ev/InbP+4M=;
 b=K6gU9IVOkNpzTxpVrhuN6YAnhnJpevEy/vYo7VDuVHQcNTODb8R6IhQApV40vaSoP/418h6ZuHd9LKaAYfBtSLpIAWAt4EqDHUjKcdY3rPOfP6kcp2qGxaBPbDssGnAMaF/r7XD/fFQN9NrmcFf39kUnq6hEhokrepcK68uL2eSgexwv7Fseeg42ZRIqnvsdExq59m/OZl4ZClFUTZI2+ttnouR3P0TJuDmYTloJkPQzHb3l89/iqKQaX/FUSnAQRmZFpOcGceLYw5jNn2NY4d0mbFfUjLumD1FrAxmb4owlX1vS5OYMi7DZPbsE54z7sNgGqI2bcolmHYQ+TDQfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4heiAbEzji62rZ1th3PqZORAYiVy3DT9ev/InbP+4M=;
 b=GaCU4pcbES2MSefQCTEbfmftRGxa8G2/Y95MOLWvXcnmFGYHzu8NVxEx4fgDE2sRjZ74TDn8E4b/j26m0TNZJ7Bg3pwflFCoZ4VfQcuJj3sw55CcLXOOh7z9NnfqjLxEJxCOHw9dhOYIlUeIZukrLWoP3r7r79xjJIHNjQpEZ1M=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 06:27:52 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::15) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:52 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:50 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] amdgpu/pm: Optimize emit_clock_levels for arcturus - part
 3
Date: Thu, 27 Apr 2023 02:27:14 -0400
Message-ID: <20230427062718.1172269-5-darren.powell@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 948440c3-59c6-46b7-3429-08db46e8876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULYqfs2dP2D++hAN3ngEvISuyvl+UKtM0j6PiOecfwY9HSdKQ6xOMK43S6j+K9rFR3wrSp2CLjrTLCpnnk9iwxfNGTMUUZOKZMV9paLSyQRAxFc0FfsevEyTGfC9XsqRJJo364x5yQdfe2XL3MvNzWUQG1xz1+5zyzKEKr/arg4W4hbWLp9BCyQlkzZgGf8lThiVr3d3GfTLV64SpbiqJsdvpgZEKYN6bhsZ+cLmXZiKG7QYHCPLdNOwT7W74UnhRkustgklzHNZUbOx5EGvibU14MtGeVJvlqXOjMRwFnkDWYYT0oiJu1b4lkhGx347uFD2ZV/JMUXHRj6b5iwpscRxd+1KfNgPA7oH1PXb6JeXVzGrJHgjva4BdsqYKnSuHfDa0h56OUwA65BHqN5Isf5/IxUr4UJfMqHKIokxxsxbLEPhdzVDroDksuhHwbmYEXastm9Cze1J0GSrSJUGcFt3OQms5sBZ/fn0D3kga5c89HqTBN2CPXje2csVD/eqZTHFgjW4LSS2ofEHv8Hff4rtYpHboCyL7kowNpcdPMYKmf1QHPeLQ++TWaDRQDEimWkF8zZft6e6v+blT2HLjoToRVa/VVdqbU9TpBZLgezo3N1To3SgoH+5IbqoJuDMx8zxq3/n7xEfdQYTdcYFLSfWpM4WwMtJGmEW65Y2EcNBKx+LjzGeM2n2g5dGCChTEp3abBdiWHT7JAmgpYfaEENWroru7i4BnNBIkZ499iA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(4326008)(70206006)(5660300002)(316002)(41300700001)(6916009)(70586007)(8936002)(2906002)(8676002)(7696005)(1076003)(86362001)(478600001)(356005)(81166007)(40460700003)(82740400003)(54906003)(2616005)(6666004)(82310400005)(36860700001)(36756003)(83380400001)(16526019)(336012)(426003)(47076005)(186003)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:52.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 948440c3-59c6-46b7-3429-08db46e8876e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

   split switch statement into two and consolidate the common
     code for printing most of the types of clock speeds

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 77 ++++++-------------
 1 file changed, 24 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index aea78f9dbae2..0e26c8b31daa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -787,19 +787,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		/*
-		 * For DPM disabled case, there will be only one clock level.
-		 * And it's safe to assume that is always the current clock.
-		 */
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
-		}
 		break;
 
 	case SMU_MCLK:
@@ -812,15 +799,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
-		}
 		break;
 
 	case SMU_SOCCLK:
@@ -833,15 +811,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
-		}
 		break;
 
 	case SMU_FCLK:
@@ -854,15 +823,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
-		}
 		break;
 
 	case SMU_VCLK:
@@ -875,15 +835,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < clocks.num_levels; i++) {
-			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
-			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
-			freq_match |= (clocks.num_levels == 1);
-
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
-		}
 		break;
 
 	case SMU_DCLK:
@@ -896,20 +847,40 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
+		break;
+
+	case SMU_PCIE:
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case SMU_SCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		/*
+		 * For DPM disabled case, there will be only one clock level.
+		 * And it's safe to assume that is always the current clock.
+		 */
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
 			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-						 i, clock_mhz,
-						 freq_match ? "*" : "");
+				i, clock_mhz,
+				freq_match ? "*" : "");
 		}
 		break;
 
 	case SMU_PCIE:
-		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
-		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		*offset += sysfs_emit_at(buf, *offset, "0: %s %s %dMhz *\n",
 				(gen_speed == 0) ? "2.5GT/s," :
 				(gen_speed == 1) ? "5.0GT/s," :
-- 
2.34.1

