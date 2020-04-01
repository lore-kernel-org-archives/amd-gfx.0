Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F19C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 11:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E80220776
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 11:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QsEJVNQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E80220776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E786E098;
	Wed,  1 Apr 2020 11:41:21 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700079.outbound.protection.outlook.com [40.107.70.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6315C6E098
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 11:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLwMfewq0daQV99XB8hGJ1u+NhjNkHYJCco3ER7CbQj+fqT1jmTdySP5Hfydt+f2LiLeQXUVAN3f/OsXIVPx9gfEZK+57bv5y+62IiG4EOw+C7BALfAmXtMzjBpBmZTjY33iJNSDNWSeTp/GKfnAWo1BT7jMEErVhUyu4uVZvj+2B6LhXT5Fw6ybVDmLmNYE3X2umk9TzL1sZ1/hEQZpNyGlBidsC1iYbWcVuRhn7XbWzf3/xf+0N5hcd1k3z4dsPWirwSUt+/jsh/SVxKahlUPvZ505Jj4ccxYFz5YAaWjVhLQmlVTbUoPJoXeiWwK4XF5v1Plnb45nWvIFhblIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq8kHDza4yOPkensh8WtSlCdAqHNfZ9oaC7ojOBDkGI=;
 b=aT8fH6beDBeTPKoJYeLcIAbFRVi3eWekDYuSFfsbg3/DUFImWg767S1E2nCASK4PTw1cff8H9hjGOFADkUPJgq7pz2Td2hBvANTohqSRC5OHXWKsOrtEwg3VKoNLVjgmcnC6OE4ckSppj63Kv7nTCLNfZzxhIPK2sN0qzE9l13i99f90BOENEsul0QN+BSJQi4a6wQUr7aLM8+Ji2AijRImDuAXtF3d8+e7ga9OMI14dOCEVjsKlXfT+xHYAZs98M6PlVr0XUkX4Q2/gvRgCOXbC7e0kqcwmgu7RCQbi2aHs/q/ZA9yEwXzdeOJ57NG6QlAiwEyXvEAOn9EsSRl4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq8kHDza4yOPkensh8WtSlCdAqHNfZ9oaC7ojOBDkGI=;
 b=QsEJVNQGyHfdppuBs48J1578tKuFdd1PbnKESXyIs/MIY3TQqIysop0WA3UebVhkSc/EtNMd9RVtbeVuC3fRsNXo61qI/V2cAuo/slmuAr4/OsSGFLpw2w/vjhPHTpdNdPe1T0PnC99YWeq9lrdE9lNp7uQZkSCAC7H/qXTuKYg=
Received: from DM6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:5:1f4::37)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 11:41:17 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::bd) by DM6PR02CA0096.outlook.office365.com
 (2603:10b6:5:1f4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 11:41:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 11:41:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 06:41:16 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 06:41:15 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 19:41:12 +0800
Message-ID: <20200401114112.8372-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(428003)(46966005)(5660300002)(4326008)(70586007)(81166006)(86362001)(8676002)(81156014)(7696005)(8936002)(186003)(6916009)(1076003)(316002)(6666004)(26005)(356004)(426003)(2906002)(36756003)(336012)(47076004)(82740400003)(478600001)(70206006)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a7cf31-421b-4938-a6ad-08d7d6319721
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26856CB09FBE2E63A8AA97268DC90@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JffsyWAXWRXkPE+2iPgCgZmxsd1rZHV7pUFW5h2g9xjrGsMa/JXxCUJpr3+nUSLuYykmkgPBcX/kIA6Bp6k/GfoaNxnT8EGrfsGScgt7VzEk9B69KEXwn+Hz6z0Rc6gU/RFrZb02028hgbONzeY1zWQ/Os4ke/dsydTWXpniIJ58i5r8rU49r40WaCCv/RIKDQx56GZ9c3eMtsOCh7P1Qb5f/7l+bpqJ31uLdTmlbEvgBNNbkfRTQYPA11lL7rxhbKzq5JXs5CNGtMwL0RaSoVF66sou7Whw33HF0Xec7jEqyqj6RpzrQHDrJs2CW/q5d3jyr/Q2ax+i4rdVDMpFeJe7cqUkVEanhT72IIo+J/9iVYjiE7704tDflM8t3F+dAYQPL4TysMRMmhv3lRWpySbQQOD6xL31XYzn998gM7Lb034AaoaLnTR4/mFYNjMhmyyqQr3otYC7ZXQIUe4Yr6205Vkr6h1PE98/GWWCz7sIOHzsNDIw6TbHZwdxcFB74FF9M8PTOn+Ej1VBIorpw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 11:41:17.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a7cf31-421b-4938-a6ad-08d7d6319721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
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
Cc: Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2.we should show the current working clock freqency from clock table metric

Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Kevin Wang <Kevin1.Wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 ++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..c6b39a7026a8 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -297,8 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if (cur_value == value)
+			cur_value_match_level = true;
 	}
 
+	if (!cur_value_match_level)
+		size += sprintf(buf + size, "   %uMhz *\n", cur_value);
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
