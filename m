Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D6C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829882389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829882389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBE86E0E6;
	Wed,  9 Dec 2020 04:19:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3F06E0E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3ap5eYYeLxrSurpmM8i/oeg48Ih+Eri2uIR1rSRSpL70yuigYvYTWUPbCzY4jZyaoCBhYKxDD7j5gKWNuKf4eTUgBXFffq/Ag2BL6aRKeL7aUKQDWeoMKC4aVGaMHX7OKN8dMqCx+7ExI336s51XaIuFWwA/ZsiwOXWIvvYfs9TkPdxVHYNpW70OVi/eAr348DcHIEFCQG2xEhnG/pf0sW7Qzv/1mzdJExK2ikpv4XANGWVwvABzYsyf1bIUgLr4EDxPaLsHU8wMCBPTRjz/yMfcvMl3IjDuwdjj6eFbP5wd9w27vbedMYGrkU3nUhX2BnoCTgWNvuUxuV/kG0M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slLWgRUYpsmr1heBln+gvWpOhM1N8gXFhM70YJhO0/I=;
 b=Qz9MNXkF5P3YgmLANL/u2avhSwMVOM+ec9zLiNs6wZPrUqlamoWJLiwVTynhcT+PsxHEUN5ha/7ONWEP6aZvS2s5D28Xiagay0Wt5RZNaXg/z4dGB3ooqukhSbHijIIk6KJrjN8KHgbGio34TIQwbvnV7Ph4l161i/vvL+sYBCmMhi1m29bJjkkDMzkmmaAijY8ADC+BYdBI4eNE0F2nMSrfnxsjj/B0FoNuEwK0t2E3GQLI8UluEyR1ip5wiKNmcjTNuZjjOCRcdSEBGJsQtPFoGskEMtN1uG6hl33mD3Gc6bU4J3NPNY+HJydOCOnB1uwDxE2dPIUWeQb34+Aunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slLWgRUYpsmr1heBln+gvWpOhM1N8gXFhM70YJhO0/I=;
 b=AZgHeKqovb5Rx6cd4QzHo1fg9sbGDvIvnoySH5aC9yjCuR6XmrO7jDupfkbByAlT+qvh+aIumAzqyhTtVeTll27jAkcJTiJkJY1PaoV+H6OLCya9A2jCbC2oacEIk3pnO8QAuW4Vi7A+TqpbzgsktGi8LQy2ewbf3/tNCeQ98+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:18:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:18:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amd/pm: correct the gpo control for sienna cichlid
Date: Wed,  9 Dec 2020 12:18:32 +0800
Message-Id: <20201209041836.143264-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 04:18:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dba7e4e-0b05-4036-148f-08d89bf98bd9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB250565880D096C762CE976D8E4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSy9NnhgnSz4J2U4q3Adw8bwwmXcMJlRUqGFDxj28JyMjhlE8eJdc67SbxMF20OcSDSrHr8RHsO4wsOruPgEZGtwhyMoLhliZnVFdmMgLpLgg/4qVWiABci/0ow+7BnOLYi2K2ZAYAn1Ap9YKPhZCVFFXjd55osSXbmKdKDygM7QetCLW85zSUGuI/fmEw1pCEXOzt6ED6usibGpVW1HNWyzmt3dDo1UnW+Z/XbwQswoNwc1MIEo+jMmsM06yFOYsNN4qNpS2cedlb4J66WnyXYPR0Vjatplbs4IElkn/sEoyjF7fkbO+VJXtLcQ506xanolxVGTCiHDqiccMVfmz7kGu1kaalQFzugAF2+ST/xR1mecTWLpU9zWmR3YpUV+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(8936002)(7696005)(66556008)(66946007)(66476007)(52116002)(508600001)(186003)(16526019)(44832011)(6916009)(8676002)(6666004)(1076003)(36756003)(83380400001)(26005)(86362001)(2906002)(34490700003)(4326008)(6486002)(5660300002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CLHJp1Wwmo4AG2hS8n2Tm90jxDhJYuMwEsFF0T9VUpu4U+eho0zhiZzd2m4v?=
 =?us-ascii?Q?GS1uL1XRbN1guSkwZtgaLrQB8XKz3qnwaDsqhlweh1Pwj+KxN8vwdxGljNT7?=
 =?us-ascii?Q?UfWnZoJQI5Pfe65mcDpRbgukovESqIJlmy2zYPCiDJAKsCLAK1yYHEdO9JA+?=
 =?us-ascii?Q?KA+G5VrAJttsIYSF4h3ovKiHD7UkWKrTPJZYhRRsrl7/ihUd4y9fKVN9DYIy?=
 =?us-ascii?Q?aAWArKrn0X+OKiuwAcUSTXRBZBaKTLMb4SelCkusF8OxYSKlaU5otoduHMkQ?=
 =?us-ascii?Q?y/9IOqaqB0yXFcbqAI4wrUVSfEIakd0nTNtYB8IxBUMjy145NFE/l7dJI62K?=
 =?us-ascii?Q?Nl4jND3nkMJOTTvG8bovAMCpFcqvb2cg6B5zVqzg3VruvVtg7SEGx1nNmwdh?=
 =?us-ascii?Q?BWOJE4iGbkbqFFZ8AmGeVWiEih1sk2GOBbcElLr7DXr5B9pnnOiPQVCp0Rw1?=
 =?us-ascii?Q?yohftCisgI4Cz6HEnL49h0pUTY460TkqBHs6dnhIinZ5iSTaRERp9bIadESE?=
 =?us-ascii?Q?XCg/tjm473re1Ond8W8kW4IT2tYV3LEuEGR8akCSqV9pS/+korMVeWk0BqXc?=
 =?us-ascii?Q?uJfsFYjUm3xhv9hwYl+D+rjDpj7vfOFm42hNE5qw9Eq8j9/6bwmO/rC7A97/?=
 =?us-ascii?Q?CT10gYFI2o7B3bnq+DXpY7fP2YtbOJcOatHHOUyWYHqHpdyNWomBjNNqwzed?=
 =?us-ascii?Q?hhF+z+u6gebLoORg6t34kdoXCsZ5xBFMfjTYuBVRt/5ZRIybxFxhalmpzmTE?=
 =?us-ascii?Q?Zr4QeMr6MEl+VB3+48UnDhxD32D2utpegmEbrY35d8gckNXi4mdJlqg9NVEj?=
 =?us-ascii?Q?bQpZkONpo/n7as55f2FlwKYAOBofnKdo9m2ILWO/T1eEXXtk8J4k4fwOxiBW?=
 =?us-ascii?Q?BVrJXeecWOps3HN6PbSCVu5NM4cUBxbmFOc02qxaKeBpbY8zdyhi43seHj9m?=
 =?us-ascii?Q?hkEVI+uH7xM7O/oBuYDXMDO5ywSHddMhPMi3NDLdllyn6RpEKtdiodw09cnU?=
 =?us-ascii?Q?i9/v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 04:18:56.7537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dba7e4e-0b05-4036-148f-08d89bf98bd9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtj5FEV9TTuEvYB2qK/q2Cxt775k+ENIbO4c4Q788X70s1qezzbGbrL2Yn/lx9fP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New SMC message was introduced for gpo control on sienna cichlid.

Change-Id: I6f09ae96e9dd7a290c9975564740f597a08ff2fa
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h    |  4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 42 ++++++++++++++-----
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 745b04730428..c79ad184503e 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -209,6 +209,7 @@
        __SMU_DUMMY_MAP(SetSoftMinCclk),                     \
        __SMU_DUMMY_MAP(SetSoftMaxCclk),                     \
 	__SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
+	__SMU_DUMMY_MAP(DisallowGpo),                    \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
index 35dd6072cc45..dad2832ff3b1 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
@@ -134,6 +134,8 @@
 #define PPSMC_MSG_SetGpoFeaturePMask             0x45
 #define PPSMC_MSG_SetSMBUSInterrupt              0x46
 
-#define PPSMC_Message_Count                      0x47
+#define PPSMC_MSG_DisallowGpo                    0x56
+
+#define PPSMC_Message_Count                      0x58
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 822ddfc42360..7e8aa5f7c0c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -128,6 +128,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
+	MSG_MAP(DisallowGpo,			PPSMC_MSG_DisallowGpo,                 0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -3207,19 +3208,40 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 static int sienna_cichlid_gpo_control(struct smu_context *smu,
 				      bool enablement)
 {
+	uint32_t smu_version;
 	int ret = 0;
 
+
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
-		if (enablement)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_SetGpoFeaturePMask,
-							GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
-							NULL);
-		else
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							SMU_MSG_SetGpoFeaturePMask,
-							0,
-							NULL);
+		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (ret)
+			return ret;
+
+		if (enablement) {
+			if (smu_version < 0x003a2500) {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_SetGpoFeaturePMask,
+								      GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
+								      NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_DisallowGpo,
+								      0,
+								      NULL);
+			}
+		} else {
+			if (smu_version < 0x003a2500) {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_SetGpoFeaturePMask,
+								      0,
+								      NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_DisallowGpo,
+								      1,
+								      NULL);
+			}
+		}
 	}
 
 	return ret;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
