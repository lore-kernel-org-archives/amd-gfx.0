Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3BDC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D344464E89
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D344464E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C5A6E997;
	Wed,  3 Mar 2021 14:07:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9766E997
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 14:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6rj4WSDdh79RB4F6WtfFqJxa9tFmtagYddmgf55jrlO71t3d0fw3aZD9xG9y3v0Mz1j/vkSeBhglaDwPHorLv7FdGNUtwf/Hgo/BHFvMvlNjYHySMU0dVcnmR4tS4uEbd/oCZO2ND7kcb+rYIT9DvrKbAiGUNEwHRUsQ5OZ91V4O8cSQM+FrgUqQjZj8owBaqkOsLE0uaxsJsMM0FT1Q2v87d6kFGuDfEaqXW2qFY1AovTaJXU4kzOe5nctmwuC+4lvHAURAibfF2SRnVI5JyK8gw9ZnRDdsleCJaz2FQqefVMtnGwxQ5NCo31clmOL0XRA4tMV6fbnsaOiP1X40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euFO1BkcMKeLFHdk8pCc+hRlhXOC30a5gkNOw6W65eA=;
 b=g1vZq8o3ADpk2lpn5wZm3DFtDuz5z1tJZm3Lz0hwYxN3s8V1vqyfhGmqQk2FACKiAmgcOoDepV0jqrPyYXPsCbZWnYpn6dShwgXusw21mXuTY+PEtgX92jpwo25t9HWyit7tK45lZyebtt1ApB/5PmhWbrTiKSC2qyugmq+7M9HjsrXD5SQCXoO+mGmYoPMZIXUHl4MTapJ2EPjypDSm6l6/GtSVCvHT4MJoU3S9gFMXyTYIeKFviGkVM4WdjhxXMlqfpVJOS3DQX3Ke/16sUzaBVUR/bWKk9vWKbzOoFr+3Qqcd2bf9jZgKyVRUchFUmVrxDXXR6nUkbspY/YYT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euFO1BkcMKeLFHdk8pCc+hRlhXOC30a5gkNOw6W65eA=;
 b=YjfW2NlsZG7swAUgbftbINi6ueSEh5G0j+RVNO1D7HqFSB9SzXTaBBgrdGX1T4fEVUoSVN6kAbmX+bMCarWvVATFOSiyTJlSlxdv7nBa0u3a1x3ivVsPxUd/SzX+1ZRJwUdo5lApknw1zwvzXpMa92RN5jrMAU/y0U5p3JLyrnw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18)
 by DM6PR12MB3193.namprd12.prod.outlook.com (2603:10b6:5:186::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 14:07:40 +0000
Received: from DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5]) by DM6PR12MB4188.namprd12.prod.outlook.com
 ([fe80::e940:8e3d:17ab:65e5%9]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 14:07:39 +0000
From: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/pm/swsmu: clean up user profile function
Date: Wed,  3 Mar 2021 19:39:19 +0530
Message-Id: <20210303140919.29132-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::29) To DM6PR12MB4188.namprd12.prod.outlook.com
 (2603:10b6:5:215::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-desktop.amd.com (165.204.156.251) by
 MAXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 14:07:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6836a1c5-4bcc-4b4d-7819-08d8de4db49e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3193989BC5642D801C6EB372E4989@DM6PR12MB3193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R32yu8KEgA6Rcwm3CWZO33qYndaJq9EkazteoQ/kwLQjX6NPIRDWAtu4r1u0QuI2hsnMFOxwxRgo1nFtOOul+L1n8b0aktK1gGW74zuDcoKa7dvkQdpwAf7WhAXT+8gy5LnZRpR4OdTDBTEK0o8WhM9bWLabXlpgtogImi+OPgIpyLvBYIrAunGwox2+VPbsafYK39b/xeG8rlf2n9wNznVzIlbCikHNlMKx+mZWif0UpTp/t8CPbIsYm2bFUjI1Up1+3N6CDo+EAlA6DmEXK5eJo/RhVFUzlzcLwSTY95Q6rIKSPhAWmnZzuivYW2pXl3k2HzcHP6JurmyxL3TpELGzJToeTy6eYxBkpqlkagui+fYUW1ahsqmHbvRy/wRF/lOM2AwxJossNsivf96vxsXoXbyL3zVAF2Y4uoepE91CeDLVtZcVcibUHdR/ri0KkTWvbUt+V2tb7WWBQoFsrO6DRZt/GeklSj9Qm0g0c2y4wo5BlAqRXxHo74zvx+5VIZKu/BM4n7Orp9zccw04sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4188.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(2906002)(86362001)(83380400001)(16526019)(36756003)(66476007)(4326008)(66946007)(66556008)(956004)(478600001)(2616005)(6916009)(7696005)(52116002)(8936002)(26005)(5660300002)(6666004)(316002)(186003)(1076003)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TBN2R1x86BrPXOZTW43HiIk9HUp/RMU4gaPgCRlB9/HBHQT+iuLgHExeUAS+?=
 =?us-ascii?Q?O/J5tz8T+n3x8ZdrMU1f9IX71wVhnnof68YWlynSdh3Wi0gcPoaMpvHLhVPN?=
 =?us-ascii?Q?087xs3UiKjH65ziFMAsO1BMOBxEqMcDOrmhMakk32f19ehRt908vMI1AmMoO?=
 =?us-ascii?Q?oLWFSoqwBDEERXn4sr7BuKnF1xTGDcF1x+hqZZbQBcOWMbrucJN3YOr4mTim?=
 =?us-ascii?Q?VtSGDIwaf6QZXYcidReywU/jYDNnVKFTZz1kdwtiB/NPbst9vtWXDmqOunL/?=
 =?us-ascii?Q?lAboELVSa8o3/TIjCQUvImOlnErDnZ0eINlMKqZxbTP37L+1V68vJDxNuQfI?=
 =?us-ascii?Q?teTyKLRZcTQgjn6c6MXIq78qJBMVJ70TTXDwcqJJAvY5ziVeiYnK4oHuBoZT?=
 =?us-ascii?Q?6PfRu1cHMIl/hunWGcIw8MmQ3frc1gtoRPhEvcnK/dALZW+h6rz0qE+upFcz?=
 =?us-ascii?Q?R5be3y6qPVVkml42+RSSsgzqHRGqiYeauvdY9TBR9BOPCY2YAHqQBapZg83U?=
 =?us-ascii?Q?0rovalID7Brw7WNA7rC4mRmDIEM+iYVQf0X+OC0qD6CV82TdVw6ksVsZXEzy?=
 =?us-ascii?Q?KvYJU6LM61nam6B5aK/nxfqPZPGPU+nDzEIikEloFoVBEE3BF/k8QMFjRv++?=
 =?us-ascii?Q?saCdQsJ81KkR4HJAuuUCvB9c/Ky6ovasDf83D3OLxk6IF5tF8NPgyYLPLNew?=
 =?us-ascii?Q?5jxj3DG5HlYPcIKPhqGYs2amRNMyEnY+44RC4UQ7/m+/oiQWmwH+2JeGmFku?=
 =?us-ascii?Q?wFpUAPsakM1yPvPOySN+z49BnxHhHwGA7vYnCgWfsiJZhnpbThhsb7TWTKkO?=
 =?us-ascii?Q?JNC92bMs3aUdgUpH/YVxHT6Egu+T878g6sVnjmy1/JRpduBGVgtDO8L9oUp/?=
 =?us-ascii?Q?aAUDJRqSr5/UK5uOKqu/NeDAEdB9jIyHvVHaBph67OX8R3oYU/Swmp0j5fuq?=
 =?us-ascii?Q?vvLYXN5EjVocdgTTRDs89JLiG4jdjhKbUpfVNf7LZa15QMoDNmqr1e4c4XSt?=
 =?us-ascii?Q?cXg1vpZFlbWqu6ga7nTyGfaa+mxE2/5xfLURXC6iTad5QqAoj+0ZbFXmCWmM?=
 =?us-ascii?Q?pjcoKrN8XJ0ecAkafw14UGe04EGsDdG8cjlGaQoCT2EwX3SpxQIk9W6RvGEO?=
 =?us-ascii?Q?9MamYWOBJJw6+eWYgwWTJJPbjBiqz+bsBOkAFKw1vTY9l+xm2QtqOVZ4B/TO?=
 =?us-ascii?Q?3ier6QMFJQYnBgoNatDZHZN9yantj7r+dAkfadTETGz6bfTxlF7qSNf4X6UC?=
 =?us-ascii?Q?1i3QN3fE9u++lnbJdwC9zlBJIxFrNiBfzTfl93/KEvSIi78SuQyEFklT6uu2?=
 =?us-ascii?Q?THo2Aqhn9aEiHjBXYmBfVbSY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836a1c5-4bcc-4b4d-7819-08d8de4db49e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 14:07:39.8899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9HmyjFV610P9fmNxnkI/W3Wxm3Hx2oz9ZST/n4ZKLj7Mmdwq6k3xUb+5LjBVHZQzWngc8STKn+Hrtsgn4WvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3193
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, evan.quan@amd.com,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unnecessary comments, enable restore mode using
'|=' operator, fixes the alignment to improve the code
readability.

v2: Move all restoration flag check to bitwise '&' operator

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 34 ++++++++---------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..a64228157ff6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -315,35 +315,25 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 	if (smu->adev->in_suspend)
 		return;
 
-	/*
-	 * mclk, fclk and socclk are interdependent
-	 * on each other
-	 */
 	if (clk == SMU_MCLK) {
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set mclk dependent clocks(fclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_FCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over FCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set fclk dependent clocks(mclk and socclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
 	} else if (clk == SMU_SOCCLK) {
-		/* give priority to mclk, if mclk dependent clocks are set */
+		/* MCLK takes precedence over SOCCLK */
 		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
 			return;
 
-		/* reset clock dependency */
 		smu->user_dpm_profile.clk_dependency = 0;
-		/* set socclk dependent clocks(mclk and fclk) */
 		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
 	} else
-		/* add clk dependencies here, if any */
+		/* Add clk dependencies here, if any */
 		return;
 }
 
@@ -367,7 +357,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		return;
 
 	/* Enable restore flag */
-	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
 	/* set the user dpm power limit */
 	if (smu->user_dpm_profile.power_limit) {
@@ -390,8 +380,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
-					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
-							clk_type);
+					dev_err(smu->adev->dev,
+						"Failed to set clock type = %d\n", clk_type);
 			}
 		}
 	}
@@ -1844,7 +1834,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE) {
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 			smu->user_dpm_profile.clk_mask[clk_type] = mask;
 			smu_set_user_clk_dependencies(smu, clk_type);
 		}
@@ -2141,7 +2131,7 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (smu->ppt_funcs->set_fan_speed_percent) {
 		percent = speed * 100 / smu->fan_max_rpm;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_speed_percent = percent;
 	}
 
@@ -2212,7 +2202,7 @@ int smu_set_power_limit(void *handle, uint32_t limit)
 
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.power_limit = limit;
 	}
 
@@ -2433,7 +2423,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	if (smu->ppt_funcs->set_fan_control_mode) {
 		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_mode = value;
 	}
 
@@ -2441,7 +2431,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 		smu->user_dpm_profile.fan_speed_percent = 0;
 
 	return ret;
@@ -2492,7 +2482,7 @@ int smu_set_fan_speed_percent(void *handle, u32 speed)
 		if (speed > 100)
 			speed = 100;
 		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
-		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_speed_percent = speed;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
