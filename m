Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E55BC4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127652343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127652343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202CA89CD4;
	Sat, 19 Dec 2020 00:49:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D8189C6A
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STpn8grlPV1eFVWL+05NEYXdXw6AOs90RIm23gGjQwOCbu44DtLIuuk1A7cqsmsBg8js0gVt0k3mn0stxx/UFd5rPpK5j3YMwtf0BJVPuriVkZ2nDW9fmBfEPuuxAAu5fHsOfGv3BX++4FvVrXarazl7E+qSzlsPtgZvnB5o/3GXIDev1sBh6JtSOTBxvgy7eTQ9QS7Qu9KZm5e4/KBe/wIoL5+8iGrEzc0OCrM/sq3B/mTOtpjQ1npK6ls7o6wnVJTAXTNOKo9gqlTDnVRPx4ujFXk+zTgZ1Mg8SCbrq+0k8pccRhP1JXzimDhU1zxR++pagXtzHWIP3Y0sLKlKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwouxXUtXbAnVuf0jZsuVWUOYUASV+E03qsjwqFTeMY=;
 b=oAqzVzuO1aZ8mNH++I7TFo3H2oY5Mrp2gJq/y3ZdK200v4DIONaQdAc//rYuQOXmTsxpxJ4OF/gK73VBjUTgOU8phyevDWid0E4dG8YJWkh6T9JLdVG4TiH0a+sSm/95KtH8iTCvERrF6Rj68EEgpuci6WJJxto6kdItRUgcnFA+M+6WEHxltJyvCi04ZRxwTLau0xbNKsqdU7ntq8qNf9IyB8DPyzg9gFPcO6NDcgQCbYJTBcNzgxYONuz8UqHqmZT/fWf7A6OowNsfU06EpUcd6nQY4zwvKM9Xr1ds2Le5ZagIvPrCf+Xs4PbpqOHWHZaDXdL8BQuBnxzDjS3yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwouxXUtXbAnVuf0jZsuVWUOYUASV+E03qsjwqFTeMY=;
 b=Ae5C1Z+k/f3li4h6+XKAeifISuaj+WRmJYo4J+iFQFlU0w+Wq4BkNCGuC+FUXwxYzLzINFjI2GaxXJAJ8GuDQKAByd9gWC5yPmfwEoHhU2f3f3uwC86LQkvorVEzRFUxiew+Cllook1P1Prm70tx+Zmpcw7GyFUxAgYdNkhx7os=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:07 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:07 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] amdgpu/pm: Powerplay API for smu ,
 changed 9 pm power functions to use API
Date: Fri, 18 Dec 2020 19:48:27 -0500
Message-Id: <20201219004831.13527-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c56f594-2f35-478e-bb35-08d8a3b7e449
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32798AC0F5B58F8AE08106C0F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvEOxLOEIRKYSJsIoSmoxa+HPqOQjBuBbbEfIVUe5jxrxRTNWq1ZVep0WMG1eIF7191cgzvyiDZgEDR5Xxq4Cebg/PeUmxN4+Hp4SIGZ441nE8r4ht7FqRj6w9iYyOgMb3XNRhYDbuqv6FUuRlizpAqCrQxsAqCSzPShc75jRA7tsgcBmRwbOd9Y+P1M/2s7txGOKhcs/dnER8CTH3xJukBe+r20z69ENfgdmOQkecUkHKsJgtrgaBF1A/wHopEZhfvDQ31Gbdk2lkrMzdlHe3ZAy1jAHNPIS1x4JPGzjWEfkNVeYr8Qw63u6p1joZMG/KedBpDXin96vA1LqzUrpb+sogUeGQUbyCyOKiRbVTajXE59II7IGnvDw1Lq13JP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(30864003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?14J7A5rRgVBBwvpJ+AWswvYKi12yln6stwcXGxdir7ROfCyEcUWxpxCQ/kdd?=
 =?us-ascii?Q?9BwqDmb799VepS6Ss/2EXdThyNMVAaqmfDE1hf6u9YVoYz1A0SkCgAs4+USb?=
 =?us-ascii?Q?IfrphIzQhfae/uynRU+Khd8BoUGsJVTbJGmBRIZ8k96CBMYP/8TWzvi/IUJF?=
 =?us-ascii?Q?hMrVwQ7qPUOXOf8CeXk1n+4vab2PMFf24Ae65W5qWYOpLj5WhOcdI7o1Sp5Y?=
 =?us-ascii?Q?i/+/kiJ6OXp2j6G8rlNyNmHRanePa2jCFHxM2VZ9OzVNXNEyF+WNy4tVAliO?=
 =?us-ascii?Q?d0rl5UWcGslLuLqMjy7mGlsf21mTAVSPC8YJfOk3vNjku+frZSSdfUVUYSVx?=
 =?us-ascii?Q?/Q3MnJ3OHRhOe1Tbcc1Bm3hn/jKc8Dj3x3CmYTCMy50Ekr94yrXDQf3st3Rj?=
 =?us-ascii?Q?65vH+t/BiiooGkFIeZmlR3/tkceqU4si8XLstSqVa4XurfC01cer3Z7Pfn2j?=
 =?us-ascii?Q?5yHQkdvmEA9fH4Blb/sWmqLZKwUZwtJfW/oClZyqZyvXI4f1Koydmtt0xgUa?=
 =?us-ascii?Q?mjw8AJxWeADV8t4X4/zGcDmxIKqYFfKnyZKvimFjhrGmlP51l19ddvC6ZwvL?=
 =?us-ascii?Q?1kEYJSYkSqVTl6p6T2VFKR353F7Y31PShQwlTId1J9VU7hiOQmOd3KoGWVQh?=
 =?us-ascii?Q?fDtpud7Gl5TJYZ+OLo+BHcvCk6n+52+Gv5OLoXhSByz0S63B05h5pGwfr6pC?=
 =?us-ascii?Q?8X7H1TKb7DFO2z5EoJ05hUtMDFCogoKDy29QnJtEOKVesp58kNTRKfDrntTE?=
 =?us-ascii?Q?IgqVl2tezSIzHr63rJMHuDhMaijWz789a0VBQAesm8of2q2GiE6ywJeWo6cb?=
 =?us-ascii?Q?rWzkAI5tsYvBF/KfS5odfd2u79/Couzs6AeLCrJ6WBjveLL7aT31KSg9qdho?=
 =?us-ascii?Q?eKuArk/HfWzJjs63l8/jhp0myDC7yctKQYSphD5+EI3JWrAT/xu0kSdHQPFP?=
 =?us-ascii?Q?dGpqnjJXOQHUXFz7s7XlVqBezh9Q/Xx/K2PeJSFL/LoV7nWMW4aZzblooEhH?=
 =?us-ascii?Q?jw32?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:07.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56f594-2f35-478e-bb35-08d8a3b7e449
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxspabOYkNPyFf0FBDRtzCaDIDkhOYua2BQ5vviCQ5dTLc/dFIMrLGqFf9hWmy54VN0OZa31gs7zfHgK/lGOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Files
  smu_get_power_limit()         - modifed arg0 to match Powerplay API get_power_limit
  smu_set_power_limit()         - modifed arg0 to match Powerplay API set_power_limit
  smu_sys_get_pp_table()        - modifed signature to match Powerplay API get_pp_table
  smu_get_power_num_states()    - modifed arg0 to match Powerplay API get_pp_num_states
  smu_get_current_power_state() - modifed arg0 to match Powerplay API get_current_power_state
  smu_sys_get_pp_feature_mask() - modifed signature to match Powerplay API get_ppfeature_status
  smu_sys_set_pp_feature_mask() - modifed arg0 to match Powerplay API set_ppfeature_status

Other Changes
  added 7 above smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 73 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 16 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 59 +++++++++++-------
 3 files changed, 69 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b345c29147b9..41da5870af58 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -124,6 +124,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_pm_state_type pm;
 	int ret;
 
@@ -136,12 +137,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		if (adev->smu.ppt_funcs->get_current_power_state)
-			pm = smu_get_current_power_state(&adev->smu);
-		else
-			pm = adev->pm.dpm.user_state;
-	} else if (adev->powerplay.pp_funcs->get_current_power_state) {
+	if (pp_funcs->get_current_power_state) {
 		pm = amdgpu_dpm_get_current_power_state(adev);
 	} else {
 		pm = adev->pm.dpm.user_state;
@@ -307,6 +303,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
@@ -342,9 +339,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		current_level = smu_get_performance_level(&adev->smu);
-	else if (adev->powerplay.pp_funcs->get_performance_level)
+	if (pp_funcs->get_performance_level)
 		current_level = amdgpu_dpm_get_performance_level(adev);
 
 	if (current_level == level) {
@@ -381,7 +376,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 			pm_runtime_put_autosuspend(ddev->dev);
 			return -EINVAL;
 		}
-	} else if (adev->powerplay.pp_funcs->force_performance_level) {
+	} else if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
@@ -412,6 +407,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
@@ -424,12 +420,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_power_num_states(&adev->smu, &data);
-		if (ret)
+	if (pp_funcs->get_pp_num_states) {
+		ret = amdgpu_dpm_get_pp_num_states(adev, &data);
+		if (is_support_sw_smu(adev) && ret)
 			return ret;
-	} else if (adev->powerplay.pp_funcs->get_pp_num_states) {
-		amdgpu_dpm_get_pp_num_states(adev, &data);
 	} else {
 		memset(&data, 0, sizeof(data));
 	}
@@ -454,8 +448,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
-	struct smu_context *smu = &adev->smu;
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
@@ -468,15 +462,13 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		pm = smu_get_current_power_state(smu);
-		ret = smu_get_power_num_states(smu, &data);
-		if (ret)
-			return ret;
-	} else if (adev->powerplay.pp_funcs->get_current_power_state
-		 && adev->powerplay.pp_funcs->get_pp_num_states) {
+	if (pp_funcs->get_current_power_state
+		 && pp_funcs->get_pp_num_states) {
 		pm = amdgpu_dpm_get_current_power_state(adev);
-		amdgpu_dpm_get_pp_num_states(adev, &data);
+		ret = amdgpu_dpm_get_pp_num_states(adev, &data);
+
+		if (is_support_sw_smu(adev) && ret)
+			return ret;
 	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -589,13 +581,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		size = smu_sys_get_pp_table(&adev->smu, (void **)&table);
-		pm_runtime_mark_last_busy(ddev->dev);
-		pm_runtime_put_autosuspend(ddev->dev);
-		if (size < 0)
-			return size;
-	} else if (adev->powerplay.pp_funcs->get_pp_table) {
+	if (adev->powerplay.pp_funcs->get_pp_table) {
 		size = amdgpu_dpm_get_pp_table(adev, &table);
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
@@ -989,9 +975,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_pp_feature_mask(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_ppfeature_status)
+	if (adev->powerplay.pp_funcs->get_ppfeature_status)
 		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2862,6 +2846,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	uint32_t limit = 0;
 	ssize_t size;
 	int r;
@@ -2875,10 +2860,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
@@ -2896,6 +2878,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	uint32_t limit = 0;
 	ssize_t size;
 	int r;
@@ -2909,11 +2892,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit, false);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
-		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
+	if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2932,6 +2912,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int err;
 	u32 value;
 
@@ -2954,10 +2935,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		return err;
 	}
 
-	if (is_support_sw_smu(adev))
-		err = smu_set_power_limit(&adev->smu, value);
-	else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_power_limit)
-		err = adev->powerplay.pp_funcs->set_power_limit(adev->powerplay.pp_handle, value);
+	if (pp_funcs && pp_funcs->set_power_limit)
+		err = pp_funcs->set_power_limit(adev->powerplay.pp_handle, value);
 	else
 		err = -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 9f739d1b18d5..8471b42587d3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -659,11 +659,9 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 
 int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 
-int smu_get_power_limit(struct smu_context *smu,
-			uint32_t *limit,
-			bool max_setting);
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);
 
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
+int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
@@ -718,10 +716,10 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
-int smu_sys_get_pp_table(struct smu_context *smu, void **table);
+int smu_sys_get_pp_table(void *handle, char **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
-int smu_get_power_num_states(struct smu_context *smu, struct pp_states_info *state_info);
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu);
+int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
+enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
 int smu_set_watermarks_for_clock_ranges(
 		struct smu_context *smu,
@@ -747,8 +745,8 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
+int smu_sys_get_pp_feature_mask(void *handle, char *buf);
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index acde0e831bb8..caed6a10ccd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -48,9 +48,10 @@
 
 static const struct amd_pm_funcs swsmu_dpm_funcs;
 
-size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
+int smu_sys_get_pp_feature_mask(void *handle, char *buf)
 {
-	size_t size = 0;
+	struct smu_context *smu = handle;
+	int size = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -64,8 +65,9 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 	return size;
 }
 
-int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask)
+int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -268,7 +270,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 	return ret;
 }
 
-int smu_get_power_num_states(struct smu_context *smu,
+int smu_get_power_num_states(void *handle,
 			     struct pp_states_info *state_info)
 {
 	if (!state_info)
@@ -290,8 +292,9 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	return false;
 }
 
-int smu_sys_get_pp_table(struct smu_context *smu, void **table)
+int smu_sys_get_pp_table(void *handle, char **table)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t powerplay_table_size;
 
@@ -1914,10 +1917,9 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
-int smu_get_power_limit(struct smu_context *smu,
-			uint32_t *limit,
-			bool max_setting)
+int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting)
 {
+	struct smu_context *smu = handle;
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
@@ -1930,8 +1932,9 @@ int smu_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
+int smu_set_power_limit(void *handle, uint32_t limit)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2482,8 +2485,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 	return ret;
 }
 
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
+enum amd_pm_state_type smu_get_current_power_state(void *handle)
 {
+	struct smu_context *smu = handle;
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2569,19 +2573,28 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	/* export for sysfs */
-	.set_fan_control_mode  = smu_set_fan_control_mode,
-	.get_fan_control_mode  = smu_get_fan_control_mode,
-	.set_fan_speed_percent = smu_set_fan_speed_percent,
-	.get_fan_speed_percent = smu_get_fan_speed_percent,
-	.get_performance_level = smu_get_performance_level,
-	.get_fan_speed_rpm     = smu_get_fan_speed_rpm,
-	.set_fan_speed_rpm     = smu_set_fan_speed_rpm,
-	.switch_power_profile  = smu_switch_power_profile,
+	.set_fan_control_mode    = smu_set_fan_control_mode,
+	.get_fan_control_mode    = smu_get_fan_control_mode,
+	.set_fan_speed_percent   = smu_set_fan_speed_percent,
+	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.get_performance_level   = smu_get_performance_level,
+	.get_current_power_state = smu_get_current_power_state,
+	.get_fan_speed_rpm       = smu_get_fan_speed_rpm,
+	.set_fan_speed_rpm       = smu_set_fan_speed_rpm,
+	.get_pp_num_states       = smu_get_power_num_states,
+	.get_pp_table            = smu_sys_get_pp_table,
+	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
-	.set_mp1_state         = smu_set_mp1_state,
+	.set_power_limit         = smu_set_power_limit,
+	.get_power_limit         = smu_get_power_limit,
+	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
-	.enable_mgpu_fan_boost = smu_enable_mgpu_fan_boost,
-	.asic_reset_mode_2     = smu_mode2_reset,
-	.set_df_cstate         = smu_set_df_cstate,
-	.set_xgmi_pstate       = smu_set_xgmi_pstate,
+	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
+	.get_ppfeature_status    = smu_sys_get_pp_feature_mask,
+	.set_ppfeature_status    = smu_sys_set_pp_feature_mask,
+	.asic_reset_mode_2       = smu_mode2_reset,
+	.set_df_cstate           = smu_set_df_cstate,
+	.set_xgmi_pstate         = smu_set_xgmi_pstate,
+
+
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
