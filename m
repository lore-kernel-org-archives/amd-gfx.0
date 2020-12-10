Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA82C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 07:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8D72313E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 07:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8D72313E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367376E9DE;
	Thu, 10 Dec 2020 07:10:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B156E9DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 07:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gubks1/ZGSUhsdO70Cf2yHsbM/z1SAkz6KyqKFIVST1XnOzi39eDruRAWOw/lK+Xk4mAhF/5giSR+BOjKkKkhYSCWGR1gw5cTyBt3wxHKagVtvUJv3D49IMtdlW45M8WbKPr4dYQPWOTASW+EXYKovMbihFV/gVOJjKCddibCtxl7jFIbcFigTcRlDyDugM9JtRwAnvkXbicEOaAEZIb9Q80ja0o6w0b0DiARfPjTgWDF8028KPTEiU1HQaoU+utqDl+4kb9QBFwRbYNAHLy/bwp9egVCZ4OxriK308fVMfTQwL0SqbiD3kQwPwntod9r3B2V12VoRVJFMm0eZYDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0EXuW3HbNkKZr9lXJKiFQ8bClbXlzaNRJgoFF9lL/Q=;
 b=VgT2GSbyk/j8M//ZxHcP5guo1p9GOx5NWNi8GUTnFjsObThAfs/MKQnHlfQivojhVwpB6g+jDRLpl8pLSawqrXqddHTpC7YWXD2tVQRaXDq9C2FAzaIgxdt04l9835TVUVMwpL1uGV7TbBW69PRi7cZXwxR3hUPVaPPY0wto/3V/O9Do84LzMyuYLnUVVWm9F17UfeYxbL/EbaaHLMHFVsTqzKBDrex76QraqtPmg4kFNkiwUq+cg02j5C3gNZw2x/g+3z4zfjyZ4Ml3g9mchaXB1+62HTFqu11eBLH0UUyO8ouOg28NUvqAHLecLpfBLEU8Ks0FvAN3mP/kvLu9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0EXuW3HbNkKZr9lXJKiFQ8bClbXlzaNRJgoFF9lL/Q=;
 b=jXH8MnLbiUpGNrTjGhhBglb3YVTX4Q+2Puy5yAKz6QtyvfDcZ5pkv9qbMCt/y463g4MiKIlH/G2Ap0mowxkguaIaYcPKjc9LoYd20Y++jjJx4mrDjZfq8T+1xdz9zoxNBa4/ibc9Gdmt3vAT4WV+aYkSfnaZoWD274HcSmYjbWo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Thu, 10 Dec 2020 07:10:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 07:10:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: correct the data structure for activity
 monitor coeff exchange
Date: Thu, 10 Dec 2020 15:10:30 +0800
Message-Id: <20201210071031.198001-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Thu, 10 Dec 2020 07:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cc88779-5d2d-4311-0703-08d89cdabbaf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963FA2306A7D000252C2C9BE4CB0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzOvNYZIouCv7XjhL44TUHGSuwAP0S0WCAfqP4aW9IgQQ4ISWFxo/mCQlnHWcUbfc8HbkH+yvZ3oY/oBfp8KCHRFItes+W3sv0SH/iQmGzsOsGIisE79lKwslJmb7NsJhO+u7mDRtou5SGR/jsdUbm3Hj5FQurwcQbdxZHknexteETl1ydrS9mxTeJiebkQcxRBocLIySmoBlT71WH7UE6HzHDTNbfV8Lp/JT6XR+3zlYJOEpALkI5Zx+SY272A/HAVJFbHTCWZpvxAVnu8QxMe20CNQOGLNgUzWxIVXzsj50VfoB0qlbS/IALrFNy+/mQPCpZd8ILsC8uzt/dltXumeqRIaFX0Te1x3lNtCS3BAN6GX8gXwnhZF2tZRgjep
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(16526019)(83380400001)(6666004)(2616005)(6486002)(66476007)(5660300002)(86362001)(2906002)(36756003)(34490700003)(44832011)(1076003)(508600001)(7696005)(186003)(8936002)(4326008)(6916009)(26005)(66946007)(52116002)(66556008)(8676002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UMmFyB9kRvXrZZBbD9xF/EE+TkQu5VP+VK6h+WT0wrY5UHXkrJO/NU/db7Vx?=
 =?us-ascii?Q?Nt+VFQGvtNqbSSqpxuiBTE4d5qbngBuYfc0UTj38TI35R+pZ1mwh81XBwniY?=
 =?us-ascii?Q?RolIRAewMo2fGrP+ukr4r7w9kaRubPARaV4cuhyqhJebzDeYnj7TOX6Xi0BP?=
 =?us-ascii?Q?UpZcoeiQ10qjyheOvQFMH3IqdoxQg9wkjdBTfUtBtNjAs0wMIwuWCuoo/pHb?=
 =?us-ascii?Q?m/0fgpCiEOl6htv9nJ129zvTeX2isCy2k64nS/dLtFA8dgAPzR8uTa9YrE2g?=
 =?us-ascii?Q?TxVis4splyNgZ5I+1K094eJwx70RJbAu37cK2ff/OPiRoUBjmupwb2uZ7BCX?=
 =?us-ascii?Q?tsaQktiTNM709D9ktKQq8tcEUjXXbNCGAnLk9ANfrc5CFgTXc0P+rckBs3aG?=
 =?us-ascii?Q?YZHgG4OD1P0r5FrTuQeOdQMgVYFlT2U1+vflLHqIKIBgymx/YTFMCXMd4hot?=
 =?us-ascii?Q?uyVal4hxug0bEPSm9Sv581ROZCMiWM8miCNJ0wYbX+/MogFnfS4U3QwZwHwa?=
 =?us-ascii?Q?is0+EYcIH9F9D866tyYxfyPzywgIjNkMlUN+N/u965BkCPuir0VhC+RNWBWP?=
 =?us-ascii?Q?wL2WOs27A8SqB9f/p7mCqS/rizLcxl1Jt9NqhI6hQ9Ctf5lSSAEaTusMJ4zX?=
 =?us-ascii?Q?jDKq6RSmPeN502xX2pAvhrRA7jlM3a4D5qsy5Qc5D88NZQmcYuEnW7Dut9d+?=
 =?us-ascii?Q?PHfHwp+iQLyAIqNy4ePVIYz61pIneG5TGiB6cdMWjHcF76Q+ow1j+rmaK6Hg?=
 =?us-ascii?Q?AJi0pNHG8vRG5uxuxdcOzvCt/nbQsTqCl0lws8QlJ8YOxX5EmI9P7RlHAH4i?=
 =?us-ascii?Q?mmsXX4csRO7RcJbvj+BsWBE18AnZiWWc1bT/5ntmp42k17h+65/qIbtCg6QQ?=
 =?us-ascii?Q?8FCttgVgr5lxQ6zMRt7RZj6dHqR0UhlXQxympOFe2hxzkYVu2AeHKp/fQdEu?=
 =?us-ascii?Q?q+BVsWF07025lolpradyGBhZw0DZkty2Ma6uWtSbCDu+3Q1rDWPEWSpPzlFC?=
 =?us-ascii?Q?l0B5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 07:10:53.7239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc88779-5d2d-4311-0703-08d89cdabbaf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLPl/055HujKN0Gc815a0xKPeSgp2RBJrQ+ofZYTc+Vt32jSSvnwtaQKHDUhcWcb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is needed for Sienna Cichlid.

Change-Id: I205190978743ec3e5176d051fba2c742e7769821
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 125 +++++++++---------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a8792a738acb..acbf6e97ffd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -524,7 +524,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-		       sizeof(DpmActivityMonitorCoeffInt_t), PAGE_SIZE,
+		       sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_SIZE,
 	               AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
@@ -1438,7 +1438,9 @@ static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 
 static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
-	DpmActivityMonitorCoeffInt_t activity_monitor;
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 	static const char *profile_name[] = {
@@ -1480,7 +1482,7 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 
 		result = smu_cmn_update_table(smu,
 					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
-					  (void *)(&activity_monitor), false);
+					  (void *)(&activity_monitor_external), false);
 		if (result) {
 			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
 			return result;
@@ -1493,43 +1495,43 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 			" ",
 			0,
 			"GFXCLK",
-			activity_monitor.Gfx_FPS,
-			activity_monitor.Gfx_MinFreqStep,
-			activity_monitor.Gfx_MinActiveFreqType,
-			activity_monitor.Gfx_MinActiveFreq,
-			activity_monitor.Gfx_BoosterFreqType,
-			activity_monitor.Gfx_BoosterFreq,
-			activity_monitor.Gfx_PD_Data_limit_c,
-			activity_monitor.Gfx_PD_Data_error_coeff,
-			activity_monitor.Gfx_PD_Data_error_rate_coeff);
+			activity_monitor->Gfx_FPS,
+			activity_monitor->Gfx_MinFreqStep,
+			activity_monitor->Gfx_MinActiveFreqType,
+			activity_monitor->Gfx_MinActiveFreq,
+			activity_monitor->Gfx_BoosterFreqType,
+			activity_monitor->Gfx_BoosterFreq,
+			activity_monitor->Gfx_PD_Data_limit_c,
+			activity_monitor->Gfx_PD_Data_error_coeff,
+			activity_monitor->Gfx_PD_Data_error_rate_coeff);
 
 		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			1,
 			"SOCCLK",
-			activity_monitor.Fclk_FPS,
-			activity_monitor.Fclk_MinFreqStep,
-			activity_monitor.Fclk_MinActiveFreqType,
-			activity_monitor.Fclk_MinActiveFreq,
-			activity_monitor.Fclk_BoosterFreqType,
-			activity_monitor.Fclk_BoosterFreq,
-			activity_monitor.Fclk_PD_Data_limit_c,
-			activity_monitor.Fclk_PD_Data_error_coeff,
-			activity_monitor.Fclk_PD_Data_error_rate_coeff);
+			activity_monitor->Fclk_FPS,
+			activity_monitor->Fclk_MinFreqStep,
+			activity_monitor->Fclk_MinActiveFreqType,
+			activity_monitor->Fclk_MinActiveFreq,
+			activity_monitor->Fclk_BoosterFreqType,
+			activity_monitor->Fclk_BoosterFreq,
+			activity_monitor->Fclk_PD_Data_limit_c,
+			activity_monitor->Fclk_PD_Data_error_coeff,
+			activity_monitor->Fclk_PD_Data_error_rate_coeff);
 
 		size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
 			2,
 			"MEMLK",
-			activity_monitor.Mem_FPS,
-			activity_monitor.Mem_MinFreqStep,
-			activity_monitor.Mem_MinActiveFreqType,
-			activity_monitor.Mem_MinActiveFreq,
-			activity_monitor.Mem_BoosterFreqType,
-			activity_monitor.Mem_BoosterFreq,
-			activity_monitor.Mem_PD_Data_limit_c,
-			activity_monitor.Mem_PD_Data_error_coeff,
-			activity_monitor.Mem_PD_Data_error_rate_coeff);
+			activity_monitor->Mem_FPS,
+			activity_monitor->Mem_MinFreqStep,
+			activity_monitor->Mem_MinActiveFreqType,
+			activity_monitor->Mem_MinActiveFreq,
+			activity_monitor->Mem_BoosterFreqType,
+			activity_monitor->Mem_BoosterFreq,
+			activity_monitor->Mem_PD_Data_limit_c,
+			activity_monitor->Mem_PD_Data_error_coeff,
+			activity_monitor->Mem_PD_Data_error_rate_coeff);
 	}
 
 	return size;
@@ -1537,7 +1539,10 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 
 static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
 {
-	DpmActivityMonitorCoeffInt_t activity_monitor;
+
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
 
 	smu->power_profile_mode = input[size];
@@ -1551,7 +1556,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
+				       (void *)(&activity_monitor_external), false);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
 			return ret;
@@ -1559,43 +1564,43 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 
 		switch (input[0]) {
 		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_MinFreqStep = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+			activity_monitor->Gfx_FPS = input[1];
+			activity_monitor->Gfx_MinFreqStep = input[2];
+			activity_monitor->Gfx_MinActiveFreqType = input[3];
+			activity_monitor->Gfx_MinActiveFreq = input[4];
+			activity_monitor->Gfx_BoosterFreqType = input[5];
+			activity_monitor->Gfx_BoosterFreq = input[6];
+			activity_monitor->Gfx_PD_Data_limit_c = input[7];
+			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
+			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
 			break;
 		case 1: /* Socclk */
-			activity_monitor.Fclk_FPS = input[1];
-			activity_monitor.Fclk_MinFreqStep = input[2];
-			activity_monitor.Fclk_MinActiveFreqType = input[3];
-			activity_monitor.Fclk_MinActiveFreq = input[4];
-			activity_monitor.Fclk_BoosterFreqType = input[5];
-			activity_monitor.Fclk_BoosterFreq = input[6];
-			activity_monitor.Fclk_PD_Data_limit_c = input[7];
-			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
-			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
+			activity_monitor->Fclk_FPS = input[1];
+			activity_monitor->Fclk_MinFreqStep = input[2];
+			activity_monitor->Fclk_MinActiveFreqType = input[3];
+			activity_monitor->Fclk_MinActiveFreq = input[4];
+			activity_monitor->Fclk_BoosterFreqType = input[5];
+			activity_monitor->Fclk_BoosterFreq = input[6];
+			activity_monitor->Fclk_PD_Data_limit_c = input[7];
+			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
+			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
 		case 2: /* Memlk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_MinFreqStep = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+			activity_monitor->Mem_FPS = input[1];
+			activity_monitor->Mem_MinFreqStep = input[2];
+			activity_monitor->Mem_MinActiveFreqType = input[3];
+			activity_monitor->Mem_MinActiveFreq = input[4];
+			activity_monitor->Mem_BoosterFreqType = input[5];
+			activity_monitor->Mem_BoosterFreq = input[6];
+			activity_monitor->Mem_PD_Data_limit_c = input[7];
+			activity_monitor->Mem_PD_Data_error_coeff = input[8];
+			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
 			break;
 		}
 
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
+				       (void *)(&activity_monitor_external), true);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
 			return ret;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
