Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF78C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910F464EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910F464EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF096EB93;
	Wed, 24 Feb 2021 22:22:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F506EB8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No6fNO62SywWXmI9k5g9QGvfCeusEN9ppIKEND3CSv6J61gWtZTab0RJTF7hmACe54lT9G12C0IJL+P48zf3eX/9MVdhEnbJ/cXUlpF2nZ5qi2Y7v9yJUE6ykHBIlKIf64NHz+YdblutMI0jNIMOsUa21SshqiMPYOCrgqO/csD+4nWxpN1lbQ0A8BN40SYGWAsT1n3tgbtASawCw7Xh8OcRkLPCF60A3RGr6rpQFq2fgQzvatc0K7/rBJesWq2/hYdnP2pUq0eJV0dNgzjWa5jp1meqLCQIjkYG6AVrl5l+JmLnTXD2yXn4VuzqfWVsZn0ju/9bI4Em7vPV0GD74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2MDDdV+yLjzNxjTtC+3YjJ845OWw6TgRYILRqP2FBY=;
 b=XwqzM7VWGA9pk/BjOsN0RBaVem4ZI9gCwOvmZDapQR5ebmu1htqpVYCuAhs1OgVjoWsGHFpjyboG9DSG0LG04137Wtq/rG5QCsKlrT7SJdX7e9p8VeoNP9BEyRsRpqaM7/xN++BpQpyZzLIlvHBhTU8yD5jBc8FthwI/IJD3gHwEANdgwL/eSSDPRC329GZQ205/JtpqqxF1VVRKK1GFnVlbxGafcSRsIE/G0q7dRvugX33eCr7Tp8xp3CDYQIgDwhsbjevhJL2jKC/o4gLs2CGgKPl68rcK/RIoK2TfFNtqtfjMGUDOj+mbcEc4s1m/Pu9fON1sIGGYsNEO2SB7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2MDDdV+yLjzNxjTtC+3YjJ845OWw6TgRYILRqP2FBY=;
 b=n3/vBrUtObj2rvaA1oyPwdlXgac1Gp9Dq5jnkA5A/FARIt5EgK3cFFqJx/JPKxgTAQ/G5F0H0dC3CTM2K7IdrpxDzcUjUyb8lJ5HXAvo8dgcyJDKMTjywKMoX6h0WPE9sF57DXrSkNjKjSIF3MXwFShfAF5xnZ0TmfF97L+LQFM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:52 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 123/159] drm/amd/pm: Add DCBTC support for aldebaran
Date: Wed, 24 Feb 2021 17:18:23 -0500
Message-Id: <20210224221859.3068810-116-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c56cc00e-9296-4fb4-e36a-08d8d9126f24
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38079DFC7DB9374CAC8624DCF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79zUjw2RbXCbRzdB6N78xaL4vcjFJsvDP8ze9tuuPmxI5JCpJvyOae7VG+HhVRVPGevioKOzbitpnw6XjVoTsD9wzl/PEC3Is4HPVAJPoyC/QQ3MX+6Uc9si89lH2yQ9sdX1nHDFIvBGYid8kuf1fNIh6y4GM+sldGMWwmQpnag/M2kJWqPEdYoclCkVY0O6/UcyBO5UFwhMJCIS5j6IOVoANSmXzyC+XPpTCzXCDSpyzPappqI44Xq1LjlcpB/HjOSCeRM6CRyko4N8Dnjy/dkmGiW0YxUcyzHnj0rqFoEGQip/Su0xQv2eA79Qc7mRxcNumysNUDREVmFXqvWBt7ccYGhqNu6IEHOXDHfIYbkJRO4r4F2/vact/Qr/5oBOQXgHyj84VX4SXKcy30fXduveAZmYNjJMx606qpL+D3JTEnqlX2yKX9T+J/T5EQea7d+Iooehg/ORQ/+goASxD3fgS2aNag5BDAM2n6GvcEVhadLvJRCL8pl7V2gWl6Ee0aeuwtdlg8uMxgxUDnZaM6UPE9LtOwZoLB+rm4eUfDIkWd601ONkvKED892IpbFqNpopUTU5sA3o08g2CGNCjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(66574015)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NRv+0Ao6Iqxk/H3W5+zc8SizyOEX2T/CK7DDCM90IvxgY7mUyNxEjtsFh/2e?=
 =?us-ascii?Q?DAQjq5Ao3UDtByI4BOQp8QIsgtD/bEz4qtkBja06ZOCU2aTlWm6uTaFNolO4?=
 =?us-ascii?Q?gvx6r29KiLRMSBke3ZHDi2EaeLY6yn5hyfdlWahXleDFYDWXmM54/KvAH+L2?=
 =?us-ascii?Q?NNXvg9h1hy25h5I5usfWVyFkj4koYCfJ9HL1uSc2Ijt5tlcu5kNkOAQDFCNt?=
 =?us-ascii?Q?T9CrGR9+1RZAL5mf3V36bNu2tZBPzkzf1ZffUvROlvt/GNIbwaI46s5iGE6O?=
 =?us-ascii?Q?ZlNT7qf6pkoTGQEmciR3fo+U3x/QxItbVOvsCh6cdjzUYIUm1s++IQVA00W5?=
 =?us-ascii?Q?zHuksPs10yXknGegyNAFAz0niV5KWPzJbxICTwNdTREXOyObLmiu1o5YdX6p?=
 =?us-ascii?Q?CuDcLOJOk8TGl0ECsR2LlaY/plqgUQssNTJBJRQD3QlQA0WsbSQlL31rwjTA?=
 =?us-ascii?Q?DvFaEd2nazqo4oDIf1WzP4/wYgpG/+wuHj0iLxECC/SoGMFpnxVki3CrFLy3?=
 =?us-ascii?Q?8U678liDZftIi0G6t7ZhOFjpJtHykibkfAF4QpGlOy//Zw/ltT1NFxQnbVKj?=
 =?us-ascii?Q?d5zE6OXBiWSA3RDfNINrH4BRdM195K0kcaqIxiFj9d3KKnE5tGxdig+GMHmx?=
 =?us-ascii?Q?qb0flZaKurXe2Ev0FoH+ZrkZPRJISa8ckV65TJ8zWNPEojWOfj5RwgSc8yFA?=
 =?us-ascii?Q?Dab7QpdC4QgyFvLI2hqMFp3CXdPg3YQzvEDLutUEI6AHJP8EjY8yO6aprDkD?=
 =?us-ascii?Q?aaDC7N3DMo6AFv1sdPil9zke7+yPAHH3Rl5ZioreRnexFVz0o7E1arpvSkzb?=
 =?us-ascii?Q?6jSCOvzbkcJPoDIiy9TK8k9J0GAvhAdOqsHUtHuiR1Qj8ATgCXULm5IZobYX?=
 =?us-ascii?Q?moCGVm/qXaXEq3KGvclZAsgP38Wa5vowR35sKS5bW0YrJG6c1XkSa6+A0uCb?=
 =?us-ascii?Q?Kj7xFUOtLWWwalugNrGaMTwxnUChwuAYnh8TzJlpqOn25B+parfDt/lz9/Jf?=
 =?us-ascii?Q?BIw0ogPeucvQeMPuxvbtReOBZqdTVuSq2gZx9yOduGqXR/pSd22UMBp77C8s?=
 =?us-ascii?Q?5TvrHjJkEnBSfcx4u75euYN4xENHLpzqkeVmbTMfZQaxx17SkRbqsu+eQWH+?=
 =?us-ascii?Q?V025vBE2PopKjFNbnNwhdjXwUipCoTyAir/VYJ3L8xqSB6Z9tPRO3bDIC0fw?=
 =?us-ascii?Q?sjNl8S0+ob9aUwdMWcQqfXn/Wx/2TuIVGTn9mm1pZK/+HXvvZMbrUviincYG?=
 =?us-ascii?Q?nOg3rlQ5NMPHtGe1rqCg2eIVEznSs0724+GtF3NvudGtTYV318Hei0YaZRHH?=
 =?us-ascii?Q?wHfUXr8Id/eMuRBdD9Y1wirQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56cc00e-9296-4fb4-e36a-08d8d9126f24
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:47.2024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/Rspmy2qblEIFH/+8CQm+Hqco+ixc3HTZVT8sg30WgW4T8LcCS60MTik9N2Ald9Ics23RTIpecuRTAVrTrRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

On aldebaran DCBTC should be run after enabling DPM. DCBTC won't be run
if support is not enabled in PPTable. Without PPTable support the message
is dummy and will return success always.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index e08df4da57a8..2427681fab8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -425,16 +425,13 @@ static int aldebaran_setup_pptable(struct smu_context *smu)
 
 static int aldebaran_run_btc(struct smu_context *smu)
 {
-	/* int ret = 0; */
+	int ret;
 
-	/* ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL); */
-	/* if (ret) { */
-	/* dev_err(smu->adev->dev, "RunAfllBtc failed!\n"); */
-	/* return ret; */
-	/* } */
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
-	/* return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL); */
-	return 0;
+	return ret;
 }
 
 static int aldebaran_populate_umd_state_clk(struct smu_context *smu)
@@ -1092,6 +1089,17 @@ static int aldebaran_get_power_limit(struct smu_context *smu)
 	return 0;
 }
 
+static int aldebaran_system_features_control(struct  smu_context *smu, bool enable)
+{
+	int ret;
+
+	ret = smu_v13_0_system_features_control(smu, enable);
+	if (!ret && enable)
+		ret = aldebaran_run_btc(smu);
+
+	return ret;
+}
+
 static int aldebaran_set_performance_level(struct smu_context *smu,
 					   enum amd_dpm_forced_level level)
 {
@@ -1300,8 +1308,6 @@ static bool aldebaran_is_mode2_reset_supported(struct smu_context *smu)
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
-	/* btc */
-	.run_btc = aldebaran_run_btc,
 	/* dpm/clk tables */
 	.set_default_dpm_table = aldebaran_set_default_dpm_table,
 	.populate_umd_state_clk = aldebaran_populate_umd_state_clk,
@@ -1329,7 +1335,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
-	.system_features_control = smu_v13_0_system_features_control,
+	.system_features_control = aldebaran_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
