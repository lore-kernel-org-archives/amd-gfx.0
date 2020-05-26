Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC2EC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08372068D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 10:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MJWYRTRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08372068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1885E6E13C;
	Tue, 26 May 2020 10:06:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6126E13C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBflV4g3lf+l0nNKnrAbAYmLxlATJoA0/VD3Fr3YknTV6MhChNCQxSa6E0+NqCvJ3R0Yq1DhcQxQzJtA9pTMjZfjgVCDJ1qGFdvwASlx0Vh18De0JwVbcOtfGT8WLn8HZs2+X2fgPr1tgT3d1ARklP3vy7rocPKiT5GjB0gS3b2tDJuEegkHHv5a+UmUN534SjLbZvKACGmqDd/oTx+cGMmX8APWHAST3lmxpeQBaIflhqh3Y/pfWSovGMpaRlSW4JaGISV+I9v8FLyYlbbaI7ZS6+ZwQjEHTueG7taW5Odq/ijPzWiejkSpA/qggnJI2e+AtNQBxeGTiyLc7dt/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gXaKk+0xyykg1qu7GMpY4HRNCxqgDSth4KgQOaSV8k=;
 b=UAmCHBMyRL9lzM/c89ezIJ2R4Vw+oEKLfgLTagTpGOELwnpkg7uZAGhdrYcNOMEbQieIaC2SmL5J4Z9+gE8DD0WzOScdkKE1yjKLAXHVhCgMmyRsyHnIrjRsy6k71dnHlclDbcXQr3TVi4mux6G6VB1JFlf4EHTDZNO//W0FSduy1E2/Z7UpXpKo+1DAk8xlClibYx/NqauOKc697BYzwDdyr+SRLXtO6eIbS78W+PiizZnZMvlcvhv2Ei2eUNBtFAFvW5XI1vwKdI70O+fjWRq9hBO/wIiOkcomj+9bAKPayoqRZSNWYW0KzTNbf2k4NwTrZBQK4Xlsik83CibArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gXaKk+0xyykg1qu7GMpY4HRNCxqgDSth4KgQOaSV8k=;
 b=MJWYRTRqZvM6kNSV0yeN4MGeu9epT0Ro1Zj0jnz7fPVtrWSiPD95n+SDT5HaUKbSKVV7Ef+qhy20eNB0aoVajpmuY3bPIdFElwnzdxQ1fR2CprR/hN536pOu69lsdarHNTcaGYbGUjVZYHUHjiQVuJdWQUmvf02ohBIxgzDuLVk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 10:05:59 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 10:05:59 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: enable SMC message filter
Date: Tue, 26 May 2020 18:05:41 +0800
Message-Id: <20200526100543.5844-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
References: <20200526100543.5844-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0010.apcprd04.prod.outlook.com (2603:1096:203:d0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 10:05:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 496d844b-3733-4030-c39f-08d8015c63ab
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3958080BAB34ECDE218CA1918CB00@CH2PR12MB3958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CacGYkBv6D/e7VD7mgjSo0SAPJ4R3/BsvGi/Hu8QrgviTI30JPFUUa1VWPMHxQdUbcdKLpivGC+EBRNVxQIuG/p5RUN+PKTgqQCWmsQBWVkoddl4z7jayZB2Uh25X5irITp4Y4PlUeEEvZGy+Ol59u2q/12yoq95gBv4bQsY6F4OqvXgWg24NRg3y4sItPzlQbJBqd2ceyC7uyom4Kj9JMF57YQFKyxpuW7EOjYFgizFJcJxBT4dnOjxBcUqKZO+P5oZ9O0KAVEUCStdovkQAHr58fRJeBTo0Pp4AK/9RebV+ixSZ4lvUYEyWg+V035uFoCc4Q4BYOf2CtkWaxStpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(36756003)(16526019)(186003)(2906002)(5660300002)(86362001)(8936002)(8676002)(6916009)(2616005)(316002)(15650500001)(4326008)(956004)(26005)(66946007)(54906003)(7696005)(478600001)(6666004)(1076003)(6486002)(66556008)(66476007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C4M9tFum2Cj/BmA4zOWwH91saL6tsAuuLl5nC1GjzFbnDEmYNuqXqQFvSH1p5pVpW0VA1h6IxkeEAIwd/tHdvaIA8TOFXlhu8ZBrcqCaiIH3wLf5dO1Jelobzee3aDOL6z8RoPK+En42SaI1tz4nFez7Lg5c6oTp3eZroaY05kN6X/rn760KRs0rM64kUPDAFUJw4RQ/hx+nUxIQ/SfaXQrmncsbRMsUiuXmVKWTiUABi8c1yt5s/XsVwGB5nsOnUVXs5XT1EOJDZgOMx/R52X9GgpcwIx7x/kPSqQbOcIktFLZtGFXGWJpElBiNfuF8Vl89Elf0BQZfavWXA3PBV0js5gJ/4uxuIcLt6wj+b+O4o6uC1rHgWFu8JD52NcmG4/TM/dsy3hZr0mK/Mu56gqLgKwf2N/iw+eO7waSjwL1XmVDqducmVRCXM31yTNJVMuwZUjn+5DxjDNCBrDkw+STN0/SbPXmeJjbH59a95zE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496d844b-3733-4030-c39f-08d8015c63ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 10:05:59.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsIDWPKYeFzLsMNCiDUFqSNrPvysTb1Ark01NRTaN9RyAUhN0Rq/Q8MpR01oCzimsWb0TjvlnQi64A5+x6E5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3958
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. enable SMC message filter in SRIOV situation
2. return -EACCESS if msg is blocked from smu_msg_get_index
3. if msg is block, always return 0 from smu_v11_0_send_msg_with_param

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Change-Id: Iec3d259fd621ee2a043c9b6ec9076e7be4c66442
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 +++---------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   |  3 +++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index fad6f3a60dc9..dcbb273674d1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -208,6 +208,9 @@ static int arcturus_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 	if (!(mapping.valid_mapping))
 		return -EINVAL;
 
+	if (amdgpu_sriov_vf(smc->adev) && !mapping.valid_in_vf)
+		return -EACCES;
+
 	return mapping.map_to;
 }
 
@@ -382,11 +385,6 @@ arcturus_set_single_dpm_table(struct smu_context *smu,
 		return ret;
 	}
 
-	if (!num_of_levels) {
-		pr_err("[%s] number of clk levels is invalid!\n", __func__);
-		return -EINVAL;
-	}
-
 	single_dpm_table->count = num_of_levels;
 	for (i = 0; i < num_of_levels; i++) {
 		ret = smu_send_smc_msg_with_param(smu,
@@ -397,10 +395,6 @@ arcturus_set_single_dpm_table(struct smu_context *smu,
 			pr_err("[%s] failed to get dpm freq by index!\n", __func__);
 			return ret;
 		}
-		if (!clk) {
-			pr_err("[%s] clk value is invalid!\n", __func__);
-			return -EINVAL;
-		}
 		single_dpm_table->dpm_levels[i].value = clk;
 		single_dpm_table->dpm_levels[i].enabled = true;
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2dd48b2c580b..5f7373e86d90 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -228,6 +228,9 @@ static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(smc->adev) && !mapping.valid_in_vf)
+		return -EACCES;
+
 	return mapping.map_to;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ee9e04dd8155..906bc7f2e686 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -100,7 +100,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
 
 	index = smu_msg_get_index(smu, msg);
 	if (index < 0)
-		return index;
+		return index == -EACCES ? 0 : index;
 
 	mutex_lock(&smu->message_lock);
 	ret = smu_v11_0_wait_for_response(smu);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
