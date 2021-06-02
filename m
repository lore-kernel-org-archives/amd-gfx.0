Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B23C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F8E61C64
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F8E61C64
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD5F6EDC1;
	Wed,  2 Jun 2021 16:51:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381056EDC1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksHQIF2o3p/JYi1hV/NG8FKLwZWqTgknAFHEuFo97LG7NjTnzKsVQuBCZsjMKhr6NfPqOX4+k2NPTiRGOQMdqiK8e6jJbjH0nLsdE4sLKDr03uo4679iiPbZ7HW4OQZjstJiEaW56yGESd8+tJFUJIvSn4z7Nm1fYxtvYa9OgFfsqu4RDVMII2Uv6CudFIhq1A0E9X8qbxqx5phe/5m97PpqXC7hhHr7sHb3byrUoW/0JYVe3HFh9aCcsm4G/X+L20vnRqBq9x2UhlhXF/Pczh5k0bV/Ht3sfU+LVuO0WWE2J9H9meXb0jxqwC28ogMbfN/q06cU5i8oVt+d4nvP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jYwzlcYbO7an20kym8Kyvycy75CkL0XFMdssIdTjLM=;
 b=XeUSm4Wz6+S3Ys+m7mNv3fAAERMOVoIgRoBb2h9R/r8ZByOo3kAeB0sCVV3ud8YhAoEDFjSqK2+bROQ/VpW8XBbjERtYiA4IqcnzrzG/FXHBPphvSufwh9ksny7RlDnR410b+Sn5F6XAf7EXX4wc+cwfiBXWEWXTlVSpNPAZH0hYATTgh5oj6jY7l24sM7ZCfJjUyfAp7u6vL4WGVhwOGpKGuYUqgXu8G0YPHnuhD+QwuUq6TvN+nmZS0Hom5/llyoi0Xg5HSS4z05+xDWfzz2joJGVdt8W3np9ZFwnlQ2j1YzQXvz9lNSvrWm9OyNDEf+5TMzKMqG8YORTRPKBxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jYwzlcYbO7an20kym8Kyvycy75CkL0XFMdssIdTjLM=;
 b=5kykqZRwZF+Ew5xMvKKqXNtsOnd9YPxefvz8/BTFZqRsqldfneQ4jDUK+Y4AVxy+r+SHRxF/OZvVsZ4JhIFIPEcCs55WZGc4gj4n32N4W7XLC5Y01ynA1a6TRAd5tDTx5j4DKMFkbayoZy1stV4Wq3Yyethl5YRlPnJ5O+KkjrI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 66/89] drm/amdgpu: add mode2 reset support for yellow carp
Date: Wed,  2 Jun 2021 12:48:45 -0400
Message-Id: <20210602164908.2848791-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c407b8bb-9c05-4773-0cd8-08d925e67d8a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23695C299C0C90537184E5E8F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD2IOhVWfa4pVWb2aX9YbTDfjPmTM/8aMG57V6Vjs291DiXBVTJ2SAKr2DuMg1A17J/kjGmj/Pwu3mJGigUciqpE54/5rLZsJhePO1LZIaL7YiH3Goss9+Kj3eAMVy3aPbaHvThT6Gg4NNqC2PkqAqu9oeX0pLdi2/MybpOFVpSzx6GpfrSSXpNVv0OutnnYR4IHSv6GE6O4VLX26jRYlsF/WIGbmmNt8HPdE9okvgVAP30A54f6m6y6fHJIPaecysEUijG4J8mXmb5i3iayl866eyQT3vXR9Rr2WjuRgOhyk9EC5t+czeHjhHQXlOYJKQ/IoHdV3Rn/67lNFWn2DdQrd65uvv+5KX7xVqvelnhcuN9cCeWSF17mIWUVshFmrHIdjS8WVQIRpP0WLq6UvpRDAvjYwI1Va0ITr09UjCJa4WdnFVihRbpWRY+aLNNzhwK17oeahHPfy1NW9nJoEG7kPYko4vEWlrwq5gvYsDDvEYS0PXuCxUHronIOWQ5kdeM6M9b0QBGNx59wVgzczOLAkMwiup5ht+oFFUbOcwnLA8+RRw5tw6T2h+C6Kv2EcVc4JcbrLIwA+YX/d7wCbEeY2f5uDQzbPkImakcPk05ZQ0xOOQtsQxAV2TBZ8J0x5sa5N/9ZocCZ8XBMLXCwDJqBgf1mkPO4hV4ZY5qfyhCXsnNf1tYviQIkYg9Wv004
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ddBKtH7Oare5dmlAW5kb3OupbwTkws0c1Epr66AYysBLa+/XEgHOHvfhjOkC?=
 =?us-ascii?Q?vn9ak7aFxvV/eduyMn8qlgO83Sp3rRN+HosXFxlJqEjPOu7k0LOLXsOmBG3q?=
 =?us-ascii?Q?srqWyBYN9SW2ff66WbPJ+AklYgpyNy2WDZZ9b/8Pa4ZPCa77FC+7gK4l+5yG?=
 =?us-ascii?Q?As70jB3dJOKGO1VcgaPL54FKcA3kmP2+otC0Bd2aC9DPt7Qyp7ZWfnyRrhaH?=
 =?us-ascii?Q?jqnGsHNqil9IC5o72xRe8qOu+TADdbUYeovTa6gKQmcWX9X4zNmrKyCUO+QC?=
 =?us-ascii?Q?qerSLoD5UwwcdI2EZEM7q7WCwPMvk568WA2hP09MZyzatZXjKARh78X9+bwX?=
 =?us-ascii?Q?jSjAuHWC60zfaMLWlGODDRJJkx52rOSW7mGEkD4kCZnHGWGzno+J300hW0or?=
 =?us-ascii?Q?5zzEINEoBGmI+H8H0E8RQltFOA9L2BJ1GF5r/uA+KZmy4n3cMDzIVBwDhAnj?=
 =?us-ascii?Q?By2nuPtkM5EYJdn/MOJr76g+2kSFyfbt8cIACd1jbG6VdJDOXMl3AsLc6MSK?=
 =?us-ascii?Q?TUfjg6SGjcUTFxWf+p6hmzoYQoVkT35uK1rqkvVge5mYgIPfkVz8YBoo37XF?=
 =?us-ascii?Q?eddHH5NsohHdfdtQDtP28BOnLkFRZtFAcNg1t2zxmKkTWDZkQ69B+/mrWYT8?=
 =?us-ascii?Q?0+HD0+Rgcg94NbaGBXlKbnXnMuxf+Rhg7kPnd7HhZ5P4JzjhJ4IYzNl13jSE?=
 =?us-ascii?Q?ULm7GdT+q/VZIQzeKZJoO1NVPHAUc2Xj6v9l/gVaTQEaQrLlMGeDvxxCMpNe?=
 =?us-ascii?Q?rN7uvQpyRAtrAVvp8SU7hhazo7FGW2eBn8RWPAAtXQigKkNVSI7p9CZl35Yc?=
 =?us-ascii?Q?pvpGWHOSFKlFi9yB8dqvj09wkmNYgxLxjnHCeoHOTP6L9oymgigs63DA5AIq?=
 =?us-ascii?Q?y3wBLNRfojaf0jSjzyljRGSgYmlI269BQdIkJqgSxgkiJsQLg+VTwRReq6mE?=
 =?us-ascii?Q?0jEqoFx1jUhiPiYfWQUJ6Al+CrlN9VnrwmBjFdNNMDBsEBB3h+aP2PM4d9c6?=
 =?us-ascii?Q?lo809LnDl30Tw7gZwYz82M8PyJuWQUPYR5Gp8vqmWbvnUn55h4mEGPiILuwB?=
 =?us-ascii?Q?10WiBfKW9fh3DBYGQGsW2Ke17xZ6R5Ef9aWKoZuwRvCAssUFBiNYIbp1RnDu?=
 =?us-ascii?Q?vYWT1mrjyBgHU3s65UXfxAJmPh/fusD/iGVGq99IutPLnnclIs3EZ4jDtOXU?=
 =?us-ascii?Q?0RyD38WIZs5OkleYNltovhCLWw9gJq2g+D7N86DT0OmzZ5O7Hs9Cympx1kbj?=
 =?us-ascii?Q?VtKwq+TnZ5Xj8j/8zqjjqbPPWyz4IFELONbzToO+UZn/PrWVUiFYP3M+0pjP?=
 =?us-ascii?Q?jUPn5vT5DBp71blf8kkEFkRG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c407b8bb-9c05-4773-0cd8-08d925e67d8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:13.0342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odkcZfp3O8mavmphgWgiKVa4W83N1sR9Z+O0PLEWacIIsVJY4fLUfV/+BQb7+DB0PvLRTDJk62A3v7J+khBPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds mode2 reset support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c               |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index fa2f0cbcec8b..54dd1bde202c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -633,6 +633,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		return AMD_RESET_METHOD_MODE2;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index ddf56b31a403..364fc17b2a78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -272,6 +272,31 @@ static int yellow_carp_post_smu_init(struct smu_context *smu)
 	return ret;
 }
 
+static int yellow_carp_mode_reset(struct smu_context *smu, int type)
+{
+	int ret = 0, index = 0;
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+				SMU_MSG_GfxDeviceDriverReset);
+	if (index < 0)
+		return index == -EACCES ? 0 : index;
+
+	mutex_lock(&smu->message_lock);
+
+	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
+
+	mutex_unlock(&smu->message_lock);
+
+	mdelay(10);
+
+	return ret;
+}
+
+static int yellow_carp_mode2_reset(struct smu_context *smu)
+{
+	return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
+}
+
 static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 							MetricsMember_t member,
 							uint32_t *value)
@@ -1167,6 +1192,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_1_gfx_off_control,
 	.post_init = yellow_carp_post_smu_init,
+	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
 	.print_clk_levels = yellow_carp_print_clk_levels,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
