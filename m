Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB9EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A692072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LZPv03TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A692072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427A06E4A7;
	Mon, 17 Aug 2020 07:49:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E683D6E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8q3bSCK89cGoPpNlf8B9eyMJZbdHFUrKw2Erh+t+UL7EOSSi9jpcFDgAKZSKS99hUMHWZPLEM+doMrt8MrT/BkVITt/BpkLpZJ0jW82WtxEDmLvAJ/ycPESJHkBTBtbhAf5g2fD7TQ9tmEEg/eYa7dbugYBGY8xRmCd5GSYNHL7E6N+ZOChxSfinl+ygXH0ssTdCc4wpc86b8CJLYwFyQIdDHpsbdy1fKcd7VReUxRMJKcBBOBL36FqobLotuEkCiRkWwy7rXMWDg4W38rtF/h/6pGPiX6oUxfXe9emFw/qbJgtRlgcSSa1t64Dp9q/mxyFxhqi3jzsNHI0tzlSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSD5VhY3Y/xgRoEGHVucchp1vIVKsm9li2Mp3HXDFco=;
 b=bKUmv/08jMXRiHyiP9iKfpIX7rQUv/MOXUi7UO6Dj6Hs7B42mt8FkjDqSx9aRcht0TYNGYdVzahnhF61aSZDwKf6kjnuEA82NKWuHcCHXjw1F2EQ1Uu8AuV7LrQ4GCbRbHnmdwfL1y2O/ZAjDXcTA85FOZ0/mEpIJyheK1mlNHOTYZRA8vYBvFSk2d/8CaCU2eJs3FBOmvS6V8SQqoZzCBSpWq0ColiVwsY5K5hzWNMJeqdVDkuEYHv4WjoeEPZTnWBp/qN9fPYj+lr7YwrFA1RZdqhJrzSqCH0fFVQczgFNlvGAuXaq9RynRWp8dVuFRV1Nua2eGrx9b2CYKvV2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSD5VhY3Y/xgRoEGHVucchp1vIVKsm9li2Mp3HXDFco=;
 b=LZPv03TYNAmOY5BTGdYKu3J8OBNZ4PthCltAWll5EcMoeC9F17urB6gmMnjyk+KU4mEquu8u2hUxt0EHIEQ8timO6XPv/+jkv3D6tjl6xAy7dyT9ECaEXv+AAQna5PtZYOM2zu6DsYwutNGzy6+LLOSuFE3BOAtLUHufnikzDF8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 07:49:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 07:49:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amd/pm: add Sienna Cichlid gfx ulv control interface
Date: Mon, 17 Aug 2020 15:49:16 +0800
Message-Id: <20200817074917.9607-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817074917.9607-1-evan.quan@amd.com>
References: <20200817074917.9607-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 07:49:48 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a86c10b0-401d-4391-e5a0-08d842821ea1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452E2B4CCC582888796987DE45F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqcW8dbJxA2CSaCg3wCMyG4sWHSOcZH1fZ4P6Jc1prFYQ1SlGuzfbZXPhNIIQkNBgoeWfIn9VHUkQdMpn8g79QZJ/Es8hY8cGBFzJmHJiq6mpmUWVAUA874fJhg47pd6KlEfeKwYVT/r7t1ADp8h87NyfDEvRx2BTvd1QJxDiWSBFqCbCqDQERK2krQT7DWADiQy4JxQSrj1PoApgCCqjpZr8XYh2EaAmV2TWku/iuBWQ3CgO8/uVpVrrSyD108UWbngD/UhprgdM5Ak4rjiEnLPLUTtGeAghPl8r+NHvxcugKZPaoarVruiv4SlnpxUh1E2o3AsRZfbR24MNe/5IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(86362001)(16526019)(6666004)(186003)(2906002)(2616005)(478600001)(956004)(8676002)(6486002)(5660300002)(66946007)(66556008)(7696005)(316002)(66476007)(8936002)(52116002)(1076003)(36756003)(26005)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O1YqbzfkIRuQWCJlCP33eZdMNooKdqCyBpWU5O295DZkyhiL0qqcFJu73hRPTdSuZWO6K+hl32gq2ZCO6bMROVTIw+RXTPelvGs6Yq3T/yPi24cfDzn52ELLBsN6XNL9qtmueVSl9eMfxDQIU9+IxnEBeXz4ygmHCFeLUJ0oOEqtH66tzKVdlshtF3MK7e0i9Y3wiUWqqE4UTt30WcVKUS7aR6EZCgsLL2/MHUQFflQkuXcjU2mwO8KYfcP0kE+AcbWvpcTK2qFlxB84pwvCGs5jAkNFvw8x8gN76YkOrt6ISUmpmwH8jSU/+QoWlHd1EoXAaETmr5kiwEFCM5uIHFXgn+38QR8VGlLJpU8YZoul3MJ88BNtRf8eppJ/T1gtzpXh89e7M/BhjzxH6rnOPjsPMmShIciXo0ph/UOsu5jqOm5znhXaOGPa1oR8w/aeSzJiAzWZE++t8+is/YA7AkeeB3Yv6/DpnjuJ4Dk3cewQiRL3D+w1TzwhA8xOeZ1RK2+RwvBy4JLqg8IRzPHitAxTjv7Zm2Lqhkpp8fFYR9RK8FluEjKaB9vFS7AQSpOLG5pJ738UYgWin/MET8OeHaUZpYgBftu6FcZxpEdQ9ZAtim4EYUw5ZZvckbDdr/sRWFJJqaBDKh9L74VtlukLIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c10b0-401d-4391-e5a0-08d842821ea1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:49:50.6619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNvlWITb3QIhigW8ff5/LaiuDZbJxiNYOItzdL9FMiGpS8HrHREyP4ehYwKz7CVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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

Change-Id: I23d68bc291960118c799366cbb3fc89ccb42f98c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 407a11c2826b..3559b33da0c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2718,6 +2718,17 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int sienna_cichlid_gfx_ulv_control(struct smu_context *smu,
+					  bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2796,6 +2807,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
+	.gfx_ulv_control = sienna_cichlid_gfx_ulv_control,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
