Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1AAC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C40206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fD8OVqk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C40206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE1C6E978;
	Fri, 27 Mar 2020 03:42:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0866E978
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkm0vPhNHqYLJ0V+pE672qbeEDj9W4KaN6usG0TTqiJpVNYoaGl6kmBtqLs3dHzCTxuUF1WYwJV6iIooKJDyAzHxPClYhwHgCpz+hQ0MwRMWJqy+siHBd1l2Yz3aDsoouZKHFHIxzI+U6pO8HU+xJkL0AfsR4o1nthqu1ELMVXf4KEROTQCe5zkkn4sKxY0N/X65PRCjnln0tcjyziFmDu3au5iadXsagPGDimP2J1fR+4tzNpiB5YKtfCIibRlfDueWdLp1h8n4LTlq/K1RUaPn9rkQdrhm1ol92esmO8KzbAuBKKDwYBpzh1KbeSpK3gagSq581KBMoYgljqkT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUbtW4AWj2p0pb55o4fcAJvjLNtKRB+Cku+lK8uhPs=;
 b=NBUhio4+jA+LXiMB/U+fhkXbd2buSRcgQX97SqaktYa2oGRrSyH4vZx2LPJD3JHJYNnct7C+Iaok+u41jyvHJ6bKuaMH8OhCG5BpSlhoydrakJl6j5yxvWbMU871fxdolfbhBSlPdLzh+lZG7k180a85i7+s4Ij67sl6zE6SWm0WFCMWBBd56n6hbiRdPYXwZjXvgvjRVaGZI2g+A244/1fx6R3Fb+b43dpHMJ9AJNf2Gpk1MtBz84UALOjfrc3/N7NSq5d+6eWsNpxIj3E5/2bCgJbEkwRmi76d/JwsQmuGHZEWqlrNILmHPJpBktYrCYnibvNaXef+5HoxG2Wkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUbtW4AWj2p0pb55o4fcAJvjLNtKRB+Cku+lK8uhPs=;
 b=fD8OVqk0yZGyr9OQjLYG/1uC+Ja4JUweLFrk0b/57imts0pUwYLJJZiF7V9ypnymAXRZG3SY9gGKKxrQO2CqjF+yW/KgZkauHHusIW/u6h5+utnrC6nGREoV5Zdx016HHUzODPWUEus05TlWHemphqRq83KPZuX++LEXiCJokUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:11 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amd/powerplay: avoid calling SMU8 specific SMU
 message implemention
Date: Fri, 27 Mar 2020 11:41:33 +0800
Message-Id: <20200327034138.7653-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:42:09 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8440255-972d-4a26-5de0-08d7d200d494
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4373BFF11A7B96B3061FF12FE4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(15650500001)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(19627235002)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/S0GSxCdDRrz0IE4wZn9Dz2DRh0oEELWw57PMAuqR+DAELwl1bNUcrNUYXlWMwrV8T4QM17s98bqEWpaz0+AO28Qr2rqMCZomFRvpCZ/Unz/6jhL5e2O/HvfKuHy7wtDVYMrT2CXmAIFA6o9jGBtbg/oEJYBzugBE3n3Lrmcf44mShHZL8dX1R1NHEC4iXBM4Uw+ZyTRnbWqzz7eNjyjItzhH9cGH9VhDiK68S8jOvwrf6XEIPCWTyXdOXpiyP6M64bJ8ZscqvXSjikc0UeGDDGV/hlRS/UXI1fDqRd/4R7bKyteDcsLtHpn9/8/LQ4dclcVt5/vnGa+/sdqJ2eZgVWILGpwWOzAKqOO6tCpL6rSV3J3/Pwm29VbwykGEM+i9I/qivAsRR4hdxA9Eut0ehjrspSKPwuISSiE0d7kSqjBslhTeCzztvu5AeJG5ZO
X-MS-Exchange-AntiSpam-MessageData: vKzHGvXR157AgR0FEeLcKhfbfyNeyQpPmDSPPjWkgqDTcASKFcRP64e8HU7YtwJF1h0UWjOtbDeAh6Hd33sQvAzLGgtV8QOquhmah24Cb287YDJ52rqM83GvrM8IUn+yZpGAIqTosMtj8KmldSaYWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8440255-972d-4a26-5de0-08d7d200d494
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:10.8588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdkvXCpLOzycyzzu3dxoimvoiC8c8UwLvS0hEVj8wRhakE96vRDacITeeUWp3kK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for coming lock protection for SMU message issuing.

Change-Id: Ia4a07898410a661d8603474ec253859278f00d3c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c  |  2 +-
 .../drm/amd/powerplay/smumgr/smu8_smumgr.c    | 30 +++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
index 019d6a206492..2e8061eccc43 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1755,7 +1755,7 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
 		result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetAverageGraphicsActivity);
 		if (0 == result) {
-			activity_percent = cgs_read_register(hwmgr->device, mmSMU_MP1_SRBM2P_ARG_0);
+			activity_percent = smum_get_argument(hwmgr);
 			activity_percent = activity_percent > 100 ? 100 : activity_percent;
 		} else {
 			activity_percent = 50;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 7dca04a89217..294e48e900dc 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -610,18 +610,18 @@ static int smu8_download_pptable_settings(struct pp_hwmgr *hwmgr, void **table)
 
 	*table = (struct SMU8_Fusion_ClkTable *)smu8_smu->scratch_buffer[i].kaddr;
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetClkTableAddrHi,
 				upper_32_bits(smu8_smu->scratch_buffer[i].mc_addr));
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetClkTableAddrLo,
 				lower_32_bits(smu8_smu->scratch_buffer[i].mc_addr));
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
 				smu8_smu->toc_entry_clock_table);
 
-	smu8_send_msg_to_smc(hwmgr, PPSMC_MSG_ClkTableXferToDram);
+	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ClkTableXferToDram);
 
 	return 0;
 }
@@ -637,18 +637,18 @@ static int smu8_upload_pptable_settings(struct pp_hwmgr *hwmgr)
 			break;
 	}
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetClkTableAddrHi,
 				upper_32_bits(smu8_smu->scratch_buffer[i].mc_addr));
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetClkTableAddrLo,
 				lower_32_bits(smu8_smu->scratch_buffer[i].mc_addr));
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
 				smu8_smu->toc_entry_clock_table);
 
-	smu8_send_msg_to_smc(hwmgr, PPSMC_MSG_ClkTableXferToSmu);
+	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ClkTableXferToSmu);
 
 	return 0;
 }
@@ -671,23 +671,23 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 
 	smu8_write_smc_sram_dword(hwmgr, smc_address, 0, smc_address+4);
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_DriverDramAddrHi,
 					upper_32_bits(smu8_smu->toc_buffer.mc_addr));
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_DriverDramAddrLo,
 					lower_32_bits(smu8_smu->toc_buffer.mc_addr));
 
-	smu8_send_msg_to_smc(hwmgr, PPSMC_MSG_InitJobs);
+	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitJobs);
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_ExecuteJob,
 					smu8_smu->toc_entry_aram);
-	smu8_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
 				smu8_smu->toc_entry_power_profiling_index);
 
-	smu8_send_msg_to_smc_with_parameter(hwmgr,
+	smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_ExecuteJob,
 					smu8_smu->toc_entry_initialize_index);
 
@@ -862,7 +862,7 @@ static bool smu8_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
 	int result;
 	unsigned long features;
 
-	result = smu8_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetFeatureStatus, 0);
+	result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetFeatureStatus, 0);
 	if (result == 0) {
 		features = smum_get_argument(hwmgr);
 		if (features & check_feature)
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
