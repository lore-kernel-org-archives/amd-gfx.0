Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A61C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDC021D81
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDC021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92EF6E875;
	Wed, 23 Dec 2020 02:08:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3326E875
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 02:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI1MeBY6Kym/m1wxdm1tkdHSUFykkbuqs1sp3cXrQAm/HnUOUP+XvuRJDeIcHvvpEU2xjZNImL6UmUfWfewYY+NX2vr3MeTGlPTSPyU7JhvcGds9WwYjteUu0yjPjUgdr0/0vgdS+gL/SQvPIM2NOrOX1WczvK/jqjrtb5cFcnPUez4lv5KdUszyqJal9SQGcsKG/fIAsGtb7bTSDNQecHWYYgCN6TdJ7nRVQNciOf/GAlkkKQqbztv67/dlAtXDnAV7nZb+HnfMeECzKzHFFkHGLISimKLwDRaJjMzenAy0bp3JxAA8kWd3U6jSEri2fYRGG47dfOJ09eDOkRzJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPbhIm9qNlliG4RSkQGiPCr2Os+6bMjQCb/5tzrxRh0=;
 b=GXKe9GeGHzQb+HDPB7p2uXCH6W/UBhBTpFsAw3JERsQxVGfGW0YA55x3mRTX/s7RyXDOtrHeT+FgCfG8hOP44uk4TsfkGkTO5y4ygb5FwZ61dY5yPWf+8N4t4uH7ppnoGdBKNBHqpbbipHJywL5PPF6dBo9vvgFPNMMiZo3rVWJlf4ZqGvn25RizIa6bPt+nOfYJYjKxdVp6GCr48EX1c1dis2ihDVoJzgoImVcWQlDfQboNlp83DiYaXJJyDOIVnFz08503TbfFkZbGFN/BQ4+bcwFALcGCSXP/xnD5+J7yv46y//DsTYUaR1/rE/Ef8Lq2GiEpue/pfqw8qXtApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPbhIm9qNlliG4RSkQGiPCr2Os+6bMjQCb/5tzrxRh0=;
 b=xkp+qYAwTU4u0xAzqqsvfVLH89+/jrY346SCPJP6wylL/fnYMiGB0+dQMEcm3aMOmPiCi6jt2VLj2Lj4qGL3T7eDfrWFcSBNR+j78TT9lpOTTnC/ceFVQGdRMO9tvPLKWdt7/gTWqlE1c/RITWNPBRmtJrVG7+LRszn6rST4mAA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Wed, 23 Dec
 2020 02:08:23 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 02:08:23 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: revise the mode2 reset for vangogh
Date: Wed, 23 Dec 2020 10:07:39 +0800
Message-Id: <20201223020739.2383191-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR02CA0211.apcprd02.prod.outlook.com (2603:1096:201:20::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 02:08:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e8fb291-a67a-44c7-42a5-08d8a6e7a053
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1519134DF2FFE9572111D64AECDE0@MWHPR12MB1519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwdJuixnIzbAy4d6CiG1lp1WZLNt1obDk/Ukm/yS0wQOaFDqLN1fiQeteLDRfZtsB8LA/on8L1m1QoVeE5U1FX7xVye+0u6+1AXkbMitjRgSPNQWoxFkaEDUiQMgsi/v/vfKDTChTCdzcw+HSWs78nllnrObC0bBEgvbxS17L/xZuQDZt+TzZaNnrQ2J7gSH6cXmcHDGKugu3RmYgx/lovVWppEU5poRNWJL5+bnrNJQzmjPJZez6BP5jdoTv9GROzrTSkisti58kkJgEn4ryIM1JRSFWodNymV/vhBqcIJps8ND9ITDYgld93/xNgEx0J8bBIa/em2j8/94qJxUKOquz73RTxnySAISvbRI+k8/P4sMKaM9TXdhm7eGkPzQnl7QrzBGJlrhZOjDCyZQSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(86362001)(36756003)(8936002)(54906003)(6486002)(66476007)(1076003)(8676002)(316002)(2906002)(478600001)(52116002)(7696005)(4326008)(956004)(186003)(16526019)(2616005)(6916009)(26005)(5660300002)(66946007)(6666004)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hJALvD9AuQfWEVI0Ks+acXdOYjmSmy0eMSuUbNM2o0q4v1MNNTw3Urdz5fVb?=
 =?us-ascii?Q?MirouHR9RfQuwGvmMe174rNQmd5JrwqINzFCQ6EYgNRnRZpmlrYb4lVE7LFN?=
 =?us-ascii?Q?t01deOK9qCbAqgj/D5rEXmkJra6dwnM7f4OggW32NyADu/GQyBu/dPwNO4je?=
 =?us-ascii?Q?EV/ytIF1r0nOkiW3RFtY8MbbsunG1kYpH3k8UstGfVa7cXAOB1QSxQpmvJ69?=
 =?us-ascii?Q?iGChl7+p0dLzun3oJDIeuyOmpPutWywSGYRgPgFHO8oEAKC37sPVa3lTfcFG?=
 =?us-ascii?Q?XIvaJMrhSkB9L5YEQI5qSC0kq/59jh3XTwcnoG2q1Mt9laJKPdITUescUgfq?=
 =?us-ascii?Q?PQblKZnMVK5bo56ppnoKpyp9LD7U1Y4q+a71VvMvGnX4S0jRqqKM6ZAdMaO8?=
 =?us-ascii?Q?oYtZYX2qvipbiRIRosSpnILGTIV4GuJemUZMTUQFP4LxY90wNkzHoZQa/xzh?=
 =?us-ascii?Q?9Md2AUWMBot8xNoTsqIZo6UrKAQcqpMzWlBfoush4ELPIbLJoP3JmOqi8zBz?=
 =?us-ascii?Q?xBbdnDiQSJROqOSh45AQBm5TLzEpOM/uimB9IugM88e8OjNIPge0XnDnCmDT?=
 =?us-ascii?Q?BQtDQMjI69r23085gupgKI2jBuygJmZZ7QZGvoy0HGsynU4cxdvpleMiN+0a?=
 =?us-ascii?Q?lT9Cja07O6HpqdL74gaII+WE4M213vB41q91PXreMVNVN5zBu5xR9+2OdrBG?=
 =?us-ascii?Q?ZkDoRQ7+Umk2939LxYM36/jWpJ0fPSbJcAIKAp2n3vEsQq9VgPQhdjmWp5qU?=
 =?us-ascii?Q?3+P6coXSBlLtusQYldnlc3/Ss9ajBqOUEhIhhF06Mko1N1CRoxpZzzrlOn2y?=
 =?us-ascii?Q?uWtqwIoP0JK9cDKpV1mKMGhXNOLxF2LZJw2gn1N0V5LURVLyiUjPNG53jxgB?=
 =?us-ascii?Q?yZMNC4tcQSwnZzVVjIFZgtVTjiAAaFoZyzCY2u2+EKsIYnwJZ+hwlAKDIogM?=
 =?us-ascii?Q?XAmw4M6dwX6N3gG2AV77RrCu9KMjC+9D+AxFVvx23ywdHW6HZEYd9JY0p6uy?=
 =?us-ascii?Q?PDNU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 02:08:22.9003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8fb291-a67a-44c7-42a5-08d8a6e7a053
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voXekGRH+GK8a9xJhN1AJaDHvbM4V49mcCwJXVNq22voexnSp+1kYTTD+H7tP47AvRyV4tzkHjxeFETOu9QLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Jinzhou . Su" <Jinzhou.Su@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PCIE MMIO bar needs to be restored firstly after the reset event
triggers. So it's unable to access the registers to wait for response
from SMU. Becasue the value of mmMP1_SMN_C2PMSG_90 is invalid at that
moment.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 22 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 42 ++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 49864efdeffe..93328eaec0da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -888,9 +888,29 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
+static int vangogh_mode_reset(struct smu_context *smu, int type)
+{
+	int ret = 0, index = 0;
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_GfxDeviceDriverReset);
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
 static int vangogh_mode2_reset(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }
 
 static const struct pptable_funcs vangogh_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 76ca41653354..39d5edb8c16b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -68,14 +68,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
 	return __smu_message_names[type];
 }
 
-static void smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-					     uint16_t msg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-}
-
 static void smu_cmn_read_arg(struct smu_context *smu,
 			     uint32_t *arg)
 {
@@ -104,6 +96,26 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
 }
 
+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+				     uint16_t msg, uint32_t param)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	ret = smu_cmn_wait_for_response(smu);
+	if (ret) {
+		dev_err(adev->dev, "Msg issuing pre-check failed and "
+		       "SMU may be not in the right state!\n");
+		return ret;
+	}
+
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+
+	return 0;
+}
+
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
@@ -122,18 +134,10 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 		return index == -EACCES ? 0 : index;
 
 	mutex_lock(&smu->message_lock);
-	ret = smu_cmn_wait_for_response(smu);
-	if (ret) {
-		dev_err(adev->dev, "Msg issuing pre-check failed and "
-		       "SMU may be not in the right state!\n");
-		goto out;
-	}
-
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
 
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-
-	smu_cmn_send_msg_without_waiting(smu, (uint16_t)index);
+	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
+	if (ret)
+		goto out;
 
 	ret = smu_cmn_wait_for_response(smu);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 01e825d83d8d..08ccf2d3257c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -26,6 +26,8 @@
 #include "amdgpu_smu.h"
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+				     uint16_t msg, uint32_t param);
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
