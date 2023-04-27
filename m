Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46D9C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C6C10EA9F;
	Thu, 27 Apr 2023 06:27:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2E010EA96
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF0AG7QQ89pfUCm57bF3sAVQeIOkZb/inLMc8e/81sdyhNtjX8KV12LmKcFcpRRgDBJsawEukLmSoZ6SxrWpHmC1vLDJgZ4P0iA33qgbCDamM7JrUywbgxkcd2DFz6q6Smzjg3C7PK1CH0DEprp8hoLjrSoaBcn5hoV83m7x03hPLhH/gd2T81AU1AUJp4/s0OcDH/eGMAqHIDNajlBBEQoVhhvs+fR9RchJ3HBQqzcUsP254+CFxiLkDxNdO5M+FnOj8Fgxmf7rVSp6u6xj/1MgnPqs4MdJoWjp1t0ISNulyDmfBLaJHmQcMe3i62k6EFiptKxXPoLSHU8xegLGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hWBIzUxBB01wQia/ymUZkej2XMAkI+3fqmrrCTGu+4=;
 b=TR1dsk58OSeEGJmCZRyvQWn85Ns2TnCEEP9GbYc/YbD3841AZDQrSgbUUNDBbh1G/dxfBV/b3+54yPQdrbKmhP1hH140P/qHFRpqLgN0D2cPWzFsRRLduGrrFrTSkUPirnuUBC6IDo2uQZY68SjyGN2ovBgyLvvcqM5UxbXLe9v238RyEB89KGLF/NhVbUOiFXElqdn2dbac/oe0fp7mrVuPp87g+5trZz0W4q74ns9i8K+QOnyhkj5SHSIA11ojNKkHSuTCi8d644zR4765pVvZLBaY8YLBkmBRrT/LTyKmGMRKvXshsI/+hG06QctgEC1+44XQ6fW9hzlcs16vGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hWBIzUxBB01wQia/ymUZkej2XMAkI+3fqmrrCTGu+4=;
 b=tDfhAEfOoEZLjRZbVFmHM7pjtWn0gd7yRnIP5OETAXFxOU1qWZ1H3PhhPXpv1RVsN+9BVhKcJe0js09Eto2kLf2VS8Xju1LpeGDedr2EQl2/L/F5YzQi5apTOro03ncMFb+JEuWtHnDYD39PabHQShBiSNSbUHCKOb4KsJ4HDB8=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 06:27:51 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::36) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:51 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:49 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] amdgpu/pm: Optimize emit_clock_levels for arcturus - part
 2
Date: Thu, 27 Apr 2023 02:27:13 -0400
Message-ID: <20230427062718.1172269-4-darren.powell@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7166bd-8137-40d4-362b-08db46e8874f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lX6MbRIZVWIbXqhC/onllQlcJOLouosUL1KjDnhpt/Lu74ixtNp+YHuwJL5V50rFATBXyUQZgetHv5HDLjgcc5B3UB6VTsLJPjSWN45L2o3wmH0/eH4vhbg87J+nZGwQCSVJSqjwcBtfzerXUtE2HaTKXZbofSaRHd0Zuc/F8Z4YepLLN38uLAD8vZDRP1Lm1AiisfETKiwnZrvYiLGUi+deihAVmrF6URmjvmJHQZVAYmKotlplfLwZ8BRn8Wizy468rPdwnBwVJTYeEhl+rhvgT1UODxOh8RCXCOFFCUxqGLdOYEoEZY2AIuyoZOTv88aofm6FB3c8vkI9W47mqfCbKJiOJo9Nr3EyX8SCu8D9dY9Fw240aTF4L6ahzv7QDZ5Uiav+aOrdOfiIsueEOLCjT15krCXj+SSx3eZwVZfk2al2JXcs2ecHsxTBKBfA/02SHdnb+bhbfpDys55+cx4zhM3sg2G0Kk/GNx8xKvn0tw/xgyk+0fgILy8RrqxLOGk1fzWfXwcag1JDMFZFb97PZ6lV+OVRN1Tn3UwrGTPMhh8VRjn+O/SgNxBg/U01tPteS8e38WUGmvPqNboDILZNFt2s7s5/Kocx6a1D9PYnHtkvw5SwDHB77P3Umk3dDnYYoQzpaNSKCqbXpxxlAq3AvT+IfOaJFfh+oDbuKXxFgLekD57PT9b+El/ff3HRpf+kU+7/0VHDfcKK+FACn2w61+SoKgmx2Ys91hlWqI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(6916009)(316002)(4326008)(8936002)(8676002)(26005)(41300700001)(40480700001)(16526019)(1076003)(186003)(40460700003)(7696005)(6666004)(83380400001)(44832011)(47076005)(36860700001)(54906003)(478600001)(356005)(82740400003)(82310400005)(2906002)(36756003)(81166007)(70206006)(70586007)(5660300002)(2616005)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:51.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7166bd-8137-40d4-362b-08db46e8874f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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

 Use variables to remove ternary expression in print statement and
 improve readability. This will help to optimize the code duplication
 in the switch statement
 Also Changed:
  replaced single_dpm_table->count as iterator in for loops with safer
    clocks_num_levels value
  replaced dpm_table.value usage with local var clocks_mhz

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 23e768aad6f9..aea78f9dbae2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -794,11 +794,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
-			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
-					clock_mhz,
-					(clocks.num_levels == 1) ? "*" :
-						(freq_match ? "*" : ""));
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -815,11 +815,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clock_mhz,
-				(clocks.num_levels == 1) ? "*" :
-					(freq_match ? "*" : ""));
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -836,11 +836,11 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, clock_mhz,
-				(clocks.num_levels == 1) ? "*" :
-					(freq_match ? "*" : ""));
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -854,14 +854,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-					(freq_match ? "*" : ""));
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -875,14 +875,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-					(freq_match ? "*" : ""));
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -896,14 +896,14 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
 		arcturus_get_clk_table(smu, &clocks, single_dpm_table);
 
-		for (i = 0; i < single_dpm_table->count; i++) {
+		for (i = 0; i < clocks.num_levels; i++) {
 			clock_mhz = clocks.data[i].clocks_in_khz / 1000;
 			freq_match = arcturus_freqs_in_same_level(clock_mhz, cur_value);
+			freq_match |= (clocks.num_levels == 1);
 
 			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
-				i, single_dpm_table->dpm_levels[i].value,
-				(clocks.num_levels == 1) ? "*" :
-					(freq_match ? "*" : ""));
+						 i, clock_mhz,
+						 freq_match ? "*" : "");
 		}
 		break;
 
@@ -926,7 +926,6 @@ static int arcturus_emit_clk_levels(struct smu_context *smu,
 
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	return 0;
-- 
2.34.1

