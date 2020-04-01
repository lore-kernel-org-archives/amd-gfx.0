Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD5C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C377120714
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 06:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IfoYqeQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C377120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5320D6E369;
	Wed,  1 Apr 2020 06:02:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E476E369
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 06:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj2goMW+kPWXiOVrb7A3HrOnankGlR6nuMRweae5gsj+AR8RfCk5BuV6eVNTzVqdiLK8BjzPG3UzTrk0msyefuhR9/xYu5lujyxTkglpfnlMtugjIS9qAO94UnLsi1USGFWHyHOfu4MTkSeiOULAzTn5N+nsiJmi2MgBOTXWGtn3oJyScT0fNI26uru8ZeKjyC82/O0Ldp1z4KnP6TWLkADC0wEE5FeJmAfz2LPdnoA6gL/6FudvdohpQEyO6y/qdfl993FEjnnjlLdABo3qISOTsyCHH6FT/0p4T4YgcwH4ogap8CkU/MMw3gyb7Gw4pKwbInielgmmQZolxEN9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfaeN38VPTMvTcu6D9bpV96MMszo/eALSslWJmR/WOE=;
 b=RR0gEr3Fhezhbxy4bXRveihj3ruvzPsRPVYfal8zSR+1qVmEMrL/b6X7D/V1huhnEt/WAP10XrWluKGmIhBFfidQrslJqrSHYgsnXi6f3QMYZJsLolju7b+3zCtLFfW3PvuSHTQX1blCiGCi17ST7qlHrwgWiVqM8FeI82Y9IxY8OOpDKXLK6ONwjfZWOg/qoBNgxu2QCA58MF676lOSfSoIXCwKsAZrnnY0Zc+acBC2M9IGAsQlWA/h5JSe5/6SSEvnFiO0GI8tuE/KhdT3MVOuj5jxiZKeXjGTi2+3rGPCtzcvfbHuTv1Z+9XvzW06ux72UhRRJmeb54jFor8oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfaeN38VPTMvTcu6D9bpV96MMszo/eALSslWJmR/WOE=;
 b=IfoYqeQxXw2jWexmhczBoSYR7WEAyeX1cpiQbzcjfaQyTcmEbBCHZrQkFBxsAxyplElSNUo8mMphH3p1WKf3NnKMbPTO4haeN7q8dTa29QSBwchJiiGbqtFg6PwV4XrxY+Op0fYNmjHkbiT14sdG9nYeTzxCM0LRNR1d+egsGt8=
Received: from BN6PR08CA0052.namprd08.prod.outlook.com (2603:10b6:404:b9::14)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 06:02:32 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b9:cafe::52) by BN6PR08CA0052.outlook.office365.com
 (2603:10b6:404:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 06:02:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 06:02:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 01:02:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 01:02:31 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 01:02:30 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 14:02:27 +0800
Message-ID: <20200401060227.15989-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(46966005)(82740400003)(86362001)(4326008)(478600001)(1076003)(426003)(316002)(2616005)(6666004)(7696005)(5660300002)(356004)(186003)(70586007)(70206006)(26005)(336012)(8676002)(6916009)(81166006)(8936002)(47076004)(54906003)(2906002)(36756003)(81156014);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b59e29e-b712-4ddc-0145-08d7d6024488
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:
X-Microsoft-Antispam-PRVS: <SA0PR12MB436889008F056A0D445234298DC90@SA0PR12MB4368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+BWNIb+E05OBxCvQP2qXWSHo0lVdWFt31OKauOmCzPFbt5Nkq2QwXjUxvLDKu6lqRvAApz09N01tXKJ2nSqygDh2UWFQS2D5UOyxchhtq/ksF9Pfx5UfOXyNh3dd3d7i0WX5CjI7d0lQhzr5Xrhu3g+tWb9eWZ1xmISjRWpL3fiXdpDPrjxz5ex2si69U0J92gdOLszNuzx622R4okKMCwYvHHYLpmJwpu5kk6h650xAHCoiI2QC+J4R+TxL2omQ4MHI3l4vN9bPlvtlC1cOoUniyQ8/DyyHViqUwpidgv1R8TZflbD7SJkPC7E7m3YL5Chll61OwP8sCRge+HqbECe8l1gLw5QEOMPi1MkD7eg59lOTLu4KNFc84LnuYn7/b0jCRXfJOZBxKjcNzewLOQqaU+lzmH/Bj/ssl4OzCmeHfrjKnnL8IZpfgFZD3Jqp2yChSuSocn9I08lPV2kUB2SzC07fIgQD0qWjh7x3G9QnnuYJT555t+R7mQEanSDhxm6FDFh3klHs+i6xvZi1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 06:02:32.3827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b59e29e-b712-4ddc-0145-08d7d6024488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..5c5d3f974532 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	bool cur_value_match_level = false;
 
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
@@ -297,6 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if(cur_value == value) {
+			cur_value_match_level = true;
+		}
+	}
+	
+	if(!cur_value_match_level) {
+		size += sprintf(buf + size, "   %uMhz *\n",cur_value);
 	}
 
 	return size;
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
