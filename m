Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29648C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04AB2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QVPvit+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04AB2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FE26E4E8;
	Mon, 17 Aug 2020 08:30:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6563C6E4E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BudEf3pQGQ4WN42JJddeaNarb4sNbTvReNByNlVIUE7UN5Of4T9KvuTCoyQ18RVH2dM/MbMRUGiO7df/6NcsFPVrx2vUOOxm5sQJ9cokIcCIYS3zK7N9FrINXQPslsqzd6X8e387T5/q5bUU6HD80ehCatpniY0yHHeqlw5zwlnjUILZxsCXpdldNHRnrcXWlA3SwhSKP19wOX/pEbQhzskSqUlKK/YGtxlp+i5HgeyMrlRKZMlido4f7AASM/HO7ar1ALxNyviGCSwNuyN2TfYBXfS/Qb+QnA2mjxsvqknmRLBYHzfzjVTpdDb2f/Sm9+Phcwb48EZ3Q1RUkFqe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYqA0BNvvbLbMhUppCfeFdtDd4uybfxaBiTWXQzWusk=;
 b=j7NSMWG3JUSSxiKXCh/goV7Uqs3CiVCCCtl1lXjZ5jufoHhUjEopoMHsp2vjYMbzCtcwdNZOs6wRzozjZ3TOgiWVcOWq6RrTUie3xBjHbd+x/7HG5HsT8T+ddfoEb9W0fAV0/bTW5oRSNC2O1bAm9iCjCiucuu/QX50/FHwsNghbjh47ZmiR3ziu7RSwh8DSjrfrwjfD9SwqKNU4TiGWy/gHxhWOFx8NtOrdtof0tKjp9j+NKFo8XPqNBq/FG+alm6LEHjUdgOIC/Fg4mLbLdgV1LzsOlm+LBfGgDjqmr3+Y0sTr7cQ6wmSyVMlZnZlzySPhpQ8TdCmK42w9TEVRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYqA0BNvvbLbMhUppCfeFdtDd4uybfxaBiTWXQzWusk=;
 b=QVPvit+n2v5Mom/pxiThMxJdoYQ++69MreGeGcg7FnxQwbomEbA6YaixMiUqVVJnNU+q9dBMLpqbhL6+oHc38p1mmAArF7ceYKtKpctu7krGVDohwIGY6JVlhzykZZ2tH8gpGyshXO9D04eQh40EUwpua2dtwSBx9i3YIkiM4Ys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 08:30:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 08:30:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amd/pm: add Arcturus deep sleep control interface
Date: Mon, 17 Aug 2020 16:29:40 +0800
Message-Id: <20200817082942.25733-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817082942.25733-1-evan.quan@amd.com>
References: <20200817082942.25733-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:30:10 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61d61645-92b8-4fd3-d951-08d84287c201
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31774EAF9D020EC15E88FE27E45F0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3Il+NIeQ1K90mAfGE1Jn4bCbexi8v9QC4EZXc2CKT+Q4cJNJsL8StCggBP6/OU6nDld28Vn7l+9RA+oabMjL16/Ww1f0KAhXJUreLjKT2Y4EVbtUBE4PgDO/ZDUAXiB3zBzvqDDY2SHSKsLOxjUSJ8qNaP69J/IOroCdVGGOMMB+Tuu091a3YfJRCcIANlG55KA0hqzHLGfWZXxGwN5oN+FGtEAgXPk6D7vHRQ99wAtffJbErxLnRGKv//lev0dTjsscNtjH+xTurd0ozwnGm/Vgon+Z+4gyscSmNEiy3Q3FIhJ3yHXAlg1nkf80ZF9JB6JpTn+XWxBnLyu9lKn8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(66476007)(86362001)(66556008)(316002)(5660300002)(44832011)(4326008)(2906002)(36756003)(6666004)(8936002)(6486002)(8676002)(26005)(956004)(2616005)(6916009)(7696005)(52116002)(478600001)(186003)(16526019)(66946007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pOBf1fMDEwtML8yiIvx6n7MZiBzAvMHbNTpfQslXkTVtQFo8qFbCS+ij175O6BS9RYHnkbVamzJgCNbuffuGGU+nJs/FsUbSGk0LFIccs7RDqHFbLO6ljmhluQEisHjDPeiixa8TgO9r6s11lB9r8TFxSgBd6Yl7glcz6FGMiNiLGydwtNVkg1PYjRx1F25Ctkq+7KIB59JpHgK3KnFmw0mJoEefbdzS6HNctE5w2iD5UN4GDAlsH5JEvfi0C20f9Xt9fP0ZU/o10sLr7pWL4sVgtOgwLqLquJ+SwCgY3Uuy3/MzxYQjaCk+jWgPTp/Bjm/oHsVubGhN9EMfActPEc4UclmAprTcwnoCRnJJJWY4Krcep4bP3Aq/DwYv2w/DUD6ujHY9V409Mk8ITrHSijoPawwHNY50xBHrGAHUx0HfSBIYeIrkWWcP0KdvFrvvi64Lnzl8XeH6u47suLPjipyDhaCronxwPUuyPWHGvxXdI9F2QmxHtyMpSZkAuQCFhStoSGsgqDuv9exyrJUaiKNhXrONwXbr2QHzm44WuNM0KT66Go6V+O+wFKznk0C/HAPkYqZ+UyNbHtIyxYxWlN9UG5+Fwq21QyTG9bdYlfyePL45sX9fc+T47b45oD+7ND9kL39ThU6tfWQ8mY0/eQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d61645-92b8-4fd3-d951-08d84287c201
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:30:11.9272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IgNCEzorPHytHoLGX8xIJNyVDZwwpMdq3Awzwv/Ydr2GXITBULRmzK3tL7s0SZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is needed for UMD pstate switch.

Change-Id: I8e753c682c29fe420167b14b23f526ea9b0db42b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index aab83b957246..81b584abeea2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2313,6 +2313,39 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
+static int arcturus_deep_sleep_control(struct smu_context *smu,
+				       bool enablement)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2392,6 +2425,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = arcturus_get_gpu_metrics,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
+	.deep_sleep_control = arcturus_deep_sleep_control,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
