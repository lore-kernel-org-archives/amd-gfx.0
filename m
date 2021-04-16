Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB51C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 09:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5D761166
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 09:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5D761166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880A56EB59;
	Fri, 16 Apr 2021 09:45:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97BE6EB59
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 09:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv0u2Y5zN3TszyxyWnHlFPfIiImljrcgj38Dp4wInKpTtyVvDuucMEBnvEtkwrORe5NlsZHeRQHl3/uptaCgyExzey8CTcLSR31ifoO5AxapwRbkmTLjfHp7UCdAFTUTyu1o3whFtsytHVTBVAmcEPv5IzzRlRvYDEaVRJoBLJE3gE9/XVG7AwRHP8p1lIwuLxnRN3a9wEzl9yMtPo9aIHXENg/lVobge6ngQeXOz0VrmToeEzVORhPzhbyF75YLr3UY9vmaUSK3V8/W2TuqCOBYzsE7PaLUwKHxiLoe51DG7Rw9RCFzHLWKO+DblXrQWgwXvhceZLsV+rA++cxs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdM1XzoZgBtVeZRE31lAiKBJlz7EGN7vWUGjqzroCdQ=;
 b=Mh5xirGgIcHph0ksZi1fSaP9pfSOD5iDHOPb+7DnBFnuhxN3Bw2MCd7airlldv9lpZW7e0gAy0AD7nQUUxW2Y8zdQzzcaIvA7TY6eVJvSV0q8C/wtIF/z/L73uPCIEabP+/zzVHsbQuC1sgaWrnD/Le7wxRVGgCtRcZO4uNAeKReeR77CcL62fhZnrG8Tgr4H/TT/+GxmkVjanHq0+bL3s3YJCJVsCa3GUkP2nH4HSrWITjfdZvWgYWsccDL499smo/YP0v5DItucHjJzSWnz5dJ922Z6088wpk19Oo0NY0Qe9kB3VwbJN8ZFx6JeqtZTSthqH/bRyaN24Fc6L1Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdM1XzoZgBtVeZRE31lAiKBJlz7EGN7vWUGjqzroCdQ=;
 b=tN1m1otAculieMV2COiIpnnYBKLD+A49hEcJ89Refsj4RqeiIzgA9D1uK/p0gD7rSNBC+NMk7HYKV/bUa/v5XPiB28/A/Z3SLlTimf+U4Q09AxstrPer9BnxSWF4s67HPTOkXGtucRokyhwgZNHuAbTNX12tRJ/k1V6H3jqA8to=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 09:45:20 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::1ef:6c3d:170c:8328%6]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 09:45:20 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Stanley Yang <Stanley.Yang@amd.com>,
 John Clements <John.Clemenets@amd.com>, Dennis Li <Dennis.Li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: only harvest gcea/mmea error status in
 arcturus
Date: Fri, 16 Apr 2021 17:44:23 +0800
Message-Id: <20210416094424.18955-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To BN9PR12MB5368.namprd12.prod.outlook.com
 (2603:10b6:408:105::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 09:45:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea18f151-cf4d-4c01-3278-08d900bc594b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53686C323EFB9EE58EFD137EFC4C9@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUvWjmRmd3i1kkloi8PMNKPE+qTzmE5960ugWTmOKXcfJXH+4oJqr9zah/xlIzEBdXHMNtpqGYbCOToSSM7Kbu3PKEcna0COMqasNhaZH40bLNJh6J1upaGzlGNghcufpbmHm6ZM8jpM32iKR/HiVV3c1+0Rx9ORtn+4HcrGzoIEowL0L+q7xApcLS84xJqAI4CONb/41lJI4C657RkdiFEPCIJAJWGWD1nZkN4oD8U9LN7cDXCpyfJVMcCYV2hV9zc2X6KlrIRDqNvBAH+C3eFkBRG3o98sF8qAIeHlzRE7xVr38KohR9AtKUcPeQOp8o97pTT7RtdEJFFgdYlHChKY6qwzlWXNIyM/RUrWGsNuBF4nf9jdL+1QAg7IcVt2/ZpjlSDxws/DH1sw0JSKIdyWHmnht4croNE1bGktPteD2BA1MFZkj4J0aE6kLCPgqWE8uLpwW2pqdDFHcDG+RA9K9Ps12lZswVpdBPBHYrpIkXID09tOhqLdNEkpUYotRqn+ResUWYT93JK1OI9SlYKmWcht1BoosX09/ls/j86UD5wVrM+3KfgqDPuSNsP0iDkTS4tYXKuIFy9TCEW811V6RGHQq9uvmky9I6k/XI4TYUV5rVhCKFo4CJMlC0S8+VddB2mkDXZKKtKSnovQPjUcHcqj+Grcr1NUHC0LfVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(52116002)(7696005)(478600001)(26005)(186003)(316002)(6636002)(4326008)(86362001)(16526019)(1076003)(956004)(6486002)(38100700002)(38350700002)(8936002)(5660300002)(6666004)(2906002)(110136005)(8676002)(2616005)(66476007)(66946007)(83380400001)(36756003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6yT2vo7d1JN5HBP5+Vw00+wFC++K5fJ/TKiqsIsK/J2sMkHBU+Y4f/WN7xVG?=
 =?us-ascii?Q?cPqMacY+xaMJgSm7eqWALFjz1gAEB36rxWeKeyizcnSHdJA5CdEhG5G4Vc5v?=
 =?us-ascii?Q?WY6PRy6JR0vyGpE5dZ0DE1QfUmAqCYtmnmW1MFgrfagfNRWlw+zO87DE9gSQ?=
 =?us-ascii?Q?4ZnYSyi1aI4cKBfUduh9RODnx24017xC/mtlDukEnywimKaD4dy+qUJm2YXA?=
 =?us-ascii?Q?KUyrd5GapP0gdEf0pRKejP9kvW2oBYBUnb6sw6Q7abL5WePG6zNCAbP1Rqzb?=
 =?us-ascii?Q?0G/B+pucjhRr6QULyJ6YcQVprMLiQLGPXvEzxfEBNR604HrBJgj8ayRIKlxT?=
 =?us-ascii?Q?caNu5aJGNHIYM2E7C3owsO1Z5264yXYV9ruDVd6LNIffd3WLKL7EcHymQ25g?=
 =?us-ascii?Q?xTCYJqs3cRCSpEKEoQlfVuRag5aHMBEUniG1K4xXCPi8+KM5K0EXeuxE/kIx?=
 =?us-ascii?Q?joZXGO0Hmqb/B1bApDya32r3bU8wczfYmiMVmLawKHzcjFndX47jrXviPCIo?=
 =?us-ascii?Q?YSbYb0TroWYn2KY74tLT+SgwOrWYmiKTxNhNPjG3yAx5qPFqI6zbuSq0gt4Z?=
 =?us-ascii?Q?6GdqxSWkxksoR3ojhExkPZr+/0yF1PrlXs1HKY8r8oOe9WhqNzMpDKP8HqVX?=
 =?us-ascii?Q?is7FKXfxqvDzOo5nDDGWabAV888Uai8xCwo/7J4I7gfqMrIdezaCXPkjMaQK?=
 =?us-ascii?Q?if6qEfd1f92+T3KNJNDvm8Q9rSLivTPbDTgkOamjadVajXSZihS5F+yUEHDj?=
 =?us-ascii?Q?B96mH85NsSXPktGgXAAa+zBH2Z3KJ/dPAzFxUO3RepaA+kwrU684Dpavgvzl?=
 =?us-ascii?Q?kdKxsoycxxpxUbPXPbv7r3ykamPWLo2RCbHf7qpPatwdGnvsdHkUMV3PGJhC?=
 =?us-ascii?Q?qFOvJ3VtNpYFe1i1Pu+CLLgmZGRgqmtSDgMoEUqsC+a+mlub/CN0eqobIGnp?=
 =?us-ascii?Q?c6RTmIZB0slMS9PBi0tRUr42ci9aD9BkqKuRbRFYFwbbH9/JDXCrCcE2ktms?=
 =?us-ascii?Q?UF+H8d/6KQlJjpgA8I2Bo+7L47ME0qurqCLyneOkFDutfWogV1OWwa5sz4Jb?=
 =?us-ascii?Q?SBj3p0QmS1xWqbNcqrc4AcRhCIohlEuDWkGOAtv4+pRfimXPNmDLq4Fq75oh?=
 =?us-ascii?Q?jZnskOyI9mtStDKNpMhLWfz0WUqFCrDFQi9JRIJeR8Bfe6UtG4xhnuC/MqOt?=
 =?us-ascii?Q?Y1xhcNCjAf0/qpNPJVsCZwp/oj95UnW54AEO7ntD1YFTJvx3gJOt7tDIA1w6?=
 =?us-ascii?Q?M6BYKQR9FX5yHEklpKxG1joQMb2MkeWYdByVAn+nl4re1PwT0jlwp8VUrqmn?=
 =?us-ascii?Q?K2DPuuDQAZPaMR6XaWvOKMDylPGK3k7VO3b4365Q1X3ESg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea18f151-cf4d-4c01-3278-08d900bc594b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 09:45:20.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D7q1b4TUeBnY5THDqM39fbTqcGLB0J+YPcZt6YaxD11uV/eRYyYqTI60anZ1w83RelDesaDYyhATyiZWOAfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDP RdRspStatus/WrRspStatus or first parity error on
RdRsp data can cause system fatal error in arcturus.
GPU will be freezed in such case.

Driver needs to harvest these error information before
reset the GPU. Check error type to avoid harvest normal
gcea/mmea information.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c            | 16 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c          |  8 +++++++-
 .../amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h   | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 830080ff90d8..b4789dfc2bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -994,7 +994,7 @@ static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 	return ret;
 }
 
-static const struct soc15_reg_entry gfx_v9_4_rdrsp_status_regs =
+static const struct soc15_reg_entry gfx_v9_4_ea_err_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, mmGCEA_ERR_STATUS), 0, 1, 32 };
 
 static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
@@ -1007,15 +1007,21 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	for (i = 0; i < gfx_v9_4_rdrsp_status_regs.se_num; i++) {
-		for (j = 0; j < gfx_v9_4_rdrsp_status_regs.instance;
+	for (i = 0; i < gfx_v9_4_ea_err_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_ea_err_status_regs.instance;
 		     j++) {
 			gfx_v9_4_select_se_sh(adev, i, 0, j);
 			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
-				gfx_v9_4_rdrsp_status_regs));
-			if (reg_value)
+				gfx_v9_4_ea_err_status_regs));
+			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
+				/* SDP read/write error/parity error in FUE_IS_FATAL mode
+				 * can cause system fatal error in arcturas. Harvest the error
+				 * status before GPU reset */
 				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
 						j, reg_value);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 4e2c5f117cef..d28df47cea91 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1644,9 +1644,15 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_err_status_regs); i++) {
 		reg_value =
 			RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v9_4_err_status_regs[i]));
-		if (reg_value)
+		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
+			/* SDP read/write error/parity error in FUE_IS_FATAL mode
+			 * can cause system fatal error in arcturas. Harvest the error
+			 * status before GPU reset */
 			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
 					i, reg_value);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
index 4089cfa081f5..849450caca15 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
@@ -617,6 +617,22 @@
 #define GCEA_EDC_CNT3__MAM_A3MEM_SEC_COUNT_MASK                                                               0x30000000L
 #define GCEA_EDC_CNT3__MAM_A3MEM_DED_COUNT_MASK                                                               0xC0000000L
 
+//GCEA_ERR_STATUS
+#define GCEA_ERR_STATUS__SDP_RDRSP_STATUS__SHIFT                                                              0x0
+#define GCEA_ERR_STATUS__SDP_WRRSP_STATUS__SHIFT                                                              0x4
+#define GCEA_ERR_STATUS__SDP_RDRSP_DATASTATUS__SHIFT                                                          0x8
+#define GCEA_ERR_STATUS__SDP_RDRSP_DATAPARITY_ERROR__SHIFT                                                    0xa
+#define GCEA_ERR_STATUS__CLEAR_ERROR_STATUS__SHIFT                                                            0xb
+#define GCEA_ERR_STATUS__BUSY_ON_ERROR__SHIFT                                                                 0xc
+#define GCEA_ERR_STATUS__FUE_FLAG__SHIFT                                                                      0xd
+#define GCEA_ERR_STATUS__SDP_RDRSP_STATUS_MASK                                                                0x0000000FL
+#define GCEA_ERR_STATUS__SDP_WRRSP_STATUS_MASK                                                                0x000000F0L
+#define GCEA_ERR_STATUS__SDP_RDRSP_DATASTATUS_MASK                                                            0x00000300L
+#define GCEA_ERR_STATUS__SDP_RDRSP_DATAPARITY_ERROR_MASK                                                      0x00000400L
+#define GCEA_ERR_STATUS__CLEAR_ERROR_STATUS_MASK                                                              0x00000800L
+#define GCEA_ERR_STATUS__BUSY_ON_ERROR_MASK                                                                   0x00001000L
+#define GCEA_ERR_STATUS__FUE_FLAG_MASK                                                                        0x00002000L
+
 // addressBlock: gc_gfxudec
 //GRBM_GFX_INDEX
 #define GRBM_GFX_INDEX__INSTANCE_INDEX__SHIFT                                                                 0x0
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
