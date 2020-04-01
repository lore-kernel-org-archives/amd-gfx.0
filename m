Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B13BC43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B6206EB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jk+8wiqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B6206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D616E8D9;
	Wed,  1 Apr 2020 06:48:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0C06E8D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 06:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACJzPoTokA6srFvCB1c9LNHIkXQpHDqxVRO6ZeJTbAtnt+J250ZMIwC2AVq+RtTonmAAiY/UzfKJTjbKi/kF/j32zD0SDPnwlPAKNUEDaoERcbNuDjKzETlBa0uej8g438zEjealtoz/B/wm8jkxHbdnSu9Hq92JFV61iicGaTc5QDsFZduBucmRrX+5tBJe98lx1GNAuUzAxF9+748FwNifhDJCTKvyRU2Pp0zXFmsLerD+da9v4rjzCeusze4a3xwsxZ0vPFdiKWTpSeMios/81E9Sq2RdRT2YjKSoFciwtHCP4u+eiabkENMXwo6H9Sp3LRXbnVELxAdpZmlb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n+gPA6Xim39fCEr4Bvf88F1S4zzkEX94fiCNGTGEAE=;
 b=GI41LT6OK96Zw2UV41q7ZoE2tJ390xPh+TZUl7vzKfUHBnksYEkllA/skabW9QRB5IscFWTbfZtNxcIt8yFfgfeL3TL9XL8zb6EZLZvcinfRNDs6Kl5/uKvPt1LIpP1Ann62COku4Josq9CcUMmZfPAC4P/ZryS59WP1yQ1tNr5OYuIdw6lb6Ucj4iUqBP4Nw2momFwy2gZdl32JDv2CkEYdVDlK5b9Kh/Et0qAXdTFhbrFtTl4jIQsmjE2swiyg1Ue2sTQUoEA04u4vKw5l4rM1K6dDPINOdzMpGw9sHlopcPFrorZ5QVY1elYDI9Jgl0x04tNUzlpNWM4Rcgb6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8n+gPA6Xim39fCEr4Bvf88F1S4zzkEX94fiCNGTGEAE=;
 b=Jk+8wiqPGHbw4IBZuyU1wVV8ONHzQqxgNDfymgpoFcgRdgFeMzUtUPvXRUO9ujAJjsnJc2Ma90fGwMS80d2lNAcXyPCnY83kZ6B13GL6n+WBRqd54LBc78FaqMzmZvjKaSsiUxk9QnRYpXkZ+ClMgpUBWBmE9iekaCIYmqyi/bA=
Received: from DM6PR18CA0036.namprd18.prod.outlook.com (2603:10b6:5:15b::49)
 by MWHPR12MB1423.namprd12.prod.outlook.com (2603:10b6:300:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 06:48:10 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d3) by DM6PR18CA0036.outlook.office365.com
 (2603:10b6:5:15b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 06:48:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 06:48:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 01:48:09 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 01:48:09 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 01:48:08 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 14:48:05 +0800
Message-ID: <20200401064805.16144-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(428003)(46966005)(36756003)(8676002)(6916009)(81156014)(8936002)(81166006)(478600001)(82740400003)(70206006)(426003)(316002)(2906002)(70586007)(2616005)(54906003)(1076003)(5660300002)(7696005)(26005)(186003)(356004)(86362001)(4326008)(336012)(6666004)(47076004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d9602cb-49f6-46eb-fada-08d7d608a469
X-MS-TrafficTypeDiagnostic: MWHPR12MB1423:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14230DDDEE873C0D4C2204178DC90@MWHPR12MB1423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt2jHSHKEOfcezhc7T2NChVfJYt9+I8BTZunqwi/q492RpoJ0/KalIhxJ5iI1ovv9qF4qnTkWbScn7bNYqReWEzCfc0I9IxQEtpqVu2k938MTVc1/2+QVb7eW5Vvz+jrdMAPSPM9r7LOhm6x92LZPG4eyMFJstWVvvN9p7hARVps31lKi+eIKVIfM2FOAQbrwFrysKk+Dzf6Tf6OGUkIId4NGbi2P6GGpJHwx12AW/oW/UosvwzCT1sbDauAIaUaFtnJxz/1GbhCvrQJw4/kYjg+u1RIVOpq0QQc+9Vsygie4a/vZXJITBLLx0IKmelHK9GDvzwHU7vH40M46NmwF+QcCu8xF53J3uYriRO+vA7C1dtUXrGSUjHbGZnFjPQBVPmmGNzGr2dKgUEsaqUqu+HE+E9J6v6rIZruNnt3D4ZGCnKwv4ehbSBxIy2fOMQAXrChgUrZutPKBpLFvlFMPJk0sPoS1ew4CgQaPfaOcT9j+oZbn1QWKcfeBhF+lh8lriO2OAzzKlbvIQQ6SxFdew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 06:48:10.1806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9602cb-49f6-46eb-fada-08d7d608a469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1423
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 +++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..30240fdff840 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -297,7 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if(cur_value == value) 
+			cur_value_match_level = true;
 	}
+	
+	if(!cur_value_match_level)
+		size += sprintf(buf + size, "   %uMhz *\n",cur_value);
+
 
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
