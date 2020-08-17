Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD625C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ED52063A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bT3mBpy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ED52063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E81F6E069;
	Mon, 17 Aug 2020 08:30:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1246E069
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez4IVwzs0JypCM/9ElAOYZeAwHYtZc8hh97lV+6MQvQcZWieMnjmhYUv3F7kI/jAQsGU60MsWAt1hOTH8FtjLOVRJpvZmLth1rJBcsAJSa8B3co65SqNJVOWAPfCBweIDqRTxvPZ28uLHiy5GmOaT6h7/mOM3ml9W7/Iwlt3q+BlmyRo96i0G38Q6XrB4QpLRRHlq2YrxlfZJpb7FYbqvPTwZcVBjhTW1xwvayTo93mssMtCf5/VkZOGx+SlayHZZeT5BGXtxUDKFRrNjANJmLmGAvsNALBrmYK8wWMkM3Y9Asq2uk28OnRkntVJM3CC3SYIMbW9gsh1TDE9l+8k0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFt8HoFkn3LBMsOLJTcl6YD2Z5hPauUNczCCdlUVhYI=;
 b=UkaQ3v4POdv3N01gc3SpQt454gStQN3du78ayMFOeBqCMZH0KBxzVCNKZ1taV8D4Lpb7t2qkOUuJ6lapf23c2Bm1owEIYTz0HI/2GEQ7gJVAfHMj1mSed9QRgrE2Dhd3TjllR8sSRYElD9mhoSFVVOjWIVLtRIQaR/t00PfX0pkLg1fkguJY+7FqJoh3lUsPvP71JC+txSmM83BqHWdeuq0jhwhzATjmBSVSXmgusQ/ng5I+yWx8kb0w0PU1qBSp/l3wvB3QTBDXmn9mhh0vxIOHU+EZbruWTWfLZxUslBqXyC857WTWFc/I5kJQmdT5tunt9NWh+gbUBWSVQpPPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFt8HoFkn3LBMsOLJTcl6YD2Z5hPauUNczCCdlUVhYI=;
 b=bT3mBpy4mh7RZr0fC74uZidDorfpVLO0KI5paGTcXSUmek1Z9hwEkuAjgQGnEiat1rN1kRfAkS+3KRlMJUI5tI9F4kK8CF1bViWxtG/kYVbDggkBRSwbK078/WMWk0MQEbk6U2Ow/M7auCEq8spgVPN6RAgtc9m2QunG4EyAdo4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 08:30:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 08:30:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amd/pm: add Navi1x deep sleep control interface
Date: Mon, 17 Aug 2020 16:29:39 +0800
Message-Id: <20200817082942.25733-2-evan.quan@amd.com>
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
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:30:06 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab54bf9f-6963-4618-563a-08d84287bfd9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3177D7EEC9536CAAE98EFA11E45F0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LUcbvF9HH9+J35V4ka/Taq0V1BUmTOO33R6u8XGIDKkVh72cKb/jedc6PqModyrH3lM7R6690LoNLzf1roxIbnKLaNuT5Oy7W1LRn8qzr2BYrUDuwp9iUY7zoL9atKeC4Ztrae7pW6psO/0hASpiNAJ8Uaf6IVzWmaT68/RViWTDd43TrPDjf2e4EyEqPchO3fwI3S5gbl+8V3C0IXt1Nw9QK3Z9ugfSIBgxEZ/0Z2l/R0Ak8ZBPhax09DDsfa4TAYa3h9Wvit/H3jQs/CjG+gexeQDH3zW4MtQ0tDqejYOLaeYvx862GnjnCWRcFTXighiJaMsJ/a7onv6hAb0Y3Mcn8E0ei059x24Gu/nJqGzZCPPo9wMSMZJzRUlBAsx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(66476007)(86362001)(66556008)(316002)(5660300002)(44832011)(4326008)(2906002)(36756003)(6666004)(8936002)(6486002)(8676002)(26005)(956004)(2616005)(6916009)(7696005)(52116002)(478600001)(186003)(16526019)(66946007)(1076003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AjPKO3kmsFnU7HCIYwqIeN/2yzrOdx52qYf/3JYlbx0mV2kaoPgoHpCgjp4v1Mo5gTWDTOJZ2Zk3NzCTEcKPYeljolPWs+DXXWZoTQbsjjdt0a8vwrOtQUx2S6w1PHJ4vvW+8hZzjfR2TOdO4xAGrVnZXOSvDaWUnkTu+uqCyJWi6FiSQomOd0K91F+hraaRLyY7ldJxIMUPQxZSTg5v8aIkkJmIM9Q+qJ/Q9/Z2hZ6kzaV+TpTMI3I0mtbnwuKPZKi/ESmmQmsNNH3t/8S583mRAQx+xEjJM7DQu+aNTDlS8a8EzJ6rA55v1RJXDhb1/wMwJLZt5L3iXe4KpB/mHjuDzYY0IdEUYTiS7E4tejtUD5m4qGRuIZ/3HPQQKKCncLuSu7bT/gePg4hfek6Rztbm+ziLgKbFP0UvC+TaSQu+UCjQFlaS/GVG/X8cx7Y36FF/lfs/g4mwiaaePOt9ZOVDKQtPZ0xKP2fiG63JKt7Z1Nz+r2nLJTplduQJ1tip4J0KsWHxpGi1tKAT2oCKMFJwLAV8stnHt57CU5hal9wGunebjOZiWEOeFyrLpaI9QGQwhki2z9kX9Z7Kw6l0V7682f9C/UxiJfFzZhrtEM0/Qa8LU3nQh/FLZi0IEApt2oEDKBl3qGP/50ZaAV7+RQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54bf9f-6963-4618-563a-08d84287bfd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:30:08.2523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rXp6/qHD8id81OsIFqLg2BQi7Q1/I50dhM1VCnOn3fPU7qorv2yKDslLyaj8DKQ
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

Change-Id: Icd5d207359b7b83c1dd689a41fd9b48f537cde9a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c968f05533d9..ddb693888d64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2578,6 +2578,39 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int navi10_deep_sleep_control(struct smu_context *smu,
+				     bool enablement)
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
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2661,6 +2694,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_gpu_metrics = navi10_get_gpu_metrics,
 	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
+	.deep_sleep_control = navi10_deep_sleep_control,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
