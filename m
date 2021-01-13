Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1363C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8F522EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8F522EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4438389C37;
	Wed, 13 Jan 2021 03:28:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E65789B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmWHVeF8rC4FCWEpCyYKP+sOgLhUAmzVpLJXjCAzMbAOTThio3Ki9cE7S/vZpOZqs3CVh+CLqCvqiqLwE8o8T4zcVIY1Lq0OIvIBT/6GKZY7qv/4swCNEo0QscIxXlK71vgxU/eiy3m6Jv+YwXu4CrzOKtUJF8dVINw8RaMD7nxI/0hxwrwx3xvZnmf8PdrZBrHrFAqObBNh1acGq/x6n7OHl5ngZ2G6OZ5rt6jbiArNFl1DWyPfkQXs4//vFtypkC+n1NiXmC/j3S1sBnxoQ4HG+8rHblDlsPWau+QQk/QjTkNhLeHO0hiUL3gimQyXEFdS7RWZnVfKMzBDsCrzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdwgvtK4m101P46zZj3oXW2mwVYnoAL/S5nXT7/nM5E=;
 b=PNCuvK7d0sEMjfBX7UdlJNG+6P3XH+jd6cNSOiE5q4zsAvfAxjil+qZS9ekF/DCtAp7K0pvTod/HLhUCwSdlmDD9uNAzEhQxrGU+BiawIcM4eyWoxXhZIQOuGtcfAa68JMAKND/sddw06eDMvEh7liQKOvHQXXCntCsLqSI9/P8kbhKymZ4f4u+D63E8dGnQ3E7i6JcaX26uGQS46w6IeNFPO3esNXa0lUMTH09sb9jsCbtn3pPSXd3JS0QgOPmR1kKTgW0yEQfbpGhuvVygoqCUN7ZbuXeZhd1hO4a5G+qqRtBkshIE8rwmof4UsZZKU83nFLOeFn5mgPF/EHe+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdwgvtK4m101P46zZj3oXW2mwVYnoAL/S5nXT7/nM5E=;
 b=DHRLMib9lnuzDc/pH6/LK9m3735gTMufdL9wzJgbAPJhQsL9Yy5RBlGO3tGejLcTMMBcMaFdJGZYTFeLjhndNB3qGan0iTW+ZGhHELmx+XNTSkSb+54k2rYETWSBBNjRHxgMC2bmoklmdxyHzCN+nLpPXdNLQHkW+ZNmYgxNU5c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:05 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:05 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] amdgpu/pm: Powerplay API for smu ,
 changed 9 pm power functions to use API
Date: Tue, 12 Jan 2021 22:27:22 -0500
Message-Id: <20210113032726.2475-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a0b6139-bfbf-429e-d311-08d8b7733d6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817C89ECD47D8F92E4D2BD6F0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FQ4xiJ7cYBF10/k4P3UVoAK9i39bZJil1zr4heUihjWo3cBiGRVnxw7O+boyrpnNq6HhLfX476aH3qrotdtcJ+2Rutku43rTP7v8BGv3cOVD+8FiUqiKts3X2i9HV/mz2AgN3F5f8Ab9gdC7QTAYmncZAsQ01sD9CS1zFDxNvxAl/1XFFhS+yjI3wcfADStdhDfark2D9NQJVT8jvdw/w1aNbDNLQptMDRv0xAzMWOvREJyw87OovY2fRZfxuA6Y6VlJp8Vgtup7qwg3v88jbaSS/Jz3fX95RRCcHOTZM8fxwZgTskSoDYlO/6fVu3Ng1i2B8PeJtytNqMGqU1aJsguX00M/qYka9YsfthDB5GZDCeow/e+zHKM67Od0kGD2O6a8fmnlmkeHiPX0vwn0A+0gKSisUtgwwz8NHpvYBERtAP4exLTICprBkjQ+m/awu5PifDYjDhvTEL5ne3sfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(30864003)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Feo4qNmqnZClX0+JlI1Z+zybecUGc26zFpyATX66T1bpYa4aREuC13ZQPsH2?=
 =?us-ascii?Q?tbA9eBJiZfUFkDTlb8HVN1gLfefehh1ovbTa6WM0dSo2cVm7fxQQZ7tbQX3t?=
 =?us-ascii?Q?LxcG3Ij8tasOvQCG7jR9ukNkIpHwiGWl1mFdAnRgddCQ8Qu65ROoUH80H1io?=
 =?us-ascii?Q?Tmzh9gIIe8wXeneZaL3j69jTOh8c4MatuiTJQFSrp1xSzGoXYpGnoyJH/0tW?=
 =?us-ascii?Q?ihCoSjo+Hpny9vtA+cta9oC+TvSpoDbnWOIjQvIOoSmBOvZANhnH3ZAc+/Z6?=
 =?us-ascii?Q?5fGDFGE89igtjWT5MmnLlWeZU0fbxpLKL5iQM6NAUtEaoytojUUAXRQuuB9C?=
 =?us-ascii?Q?L2U+xRyVAeTMmP7JL84qrNnIR7JC/Dw3zeO+VY5wxX5B7qxBtXpbY7d0wX/Y?=
 =?us-ascii?Q?NVtvXJv1d1FLlyewYxnE5mfk7hnXoO7szz4KzmMcyr8ZsvFjlscBvSUV8iU+?=
 =?us-ascii?Q?7sD2FQkUc11Ah8+MiHYAAzfi34gfGB/Ql2rc/WFkCWTbo7Vx34LXclPOE2Fp?=
 =?us-ascii?Q?8XC4TFkul7UTLCC9qYJKCUoAqT6Ihz3ksdGmx2rdpzEg4CEZSq974x92Np9z?=
 =?us-ascii?Q?q1IzBQBqtPM24Z7laXq9gTJw/pVzPry9RUjeeo+flQblRD83VJcmVgT5JEL5?=
 =?us-ascii?Q?xsVofWXEGvRvkZGbU8Alk8Q20g3pULUQBHWiVIHQStY5RjEEtPuXlQMMvQYP?=
 =?us-ascii?Q?kmYQKSoBWzRz9xH6PhUyqvnvm76HYZfA/IUFpdDXS8pGf0T/lwOR6NTKYpe2?=
 =?us-ascii?Q?3Nl5PfT5bTaghH0eXotIS3VfaMKM7Er/uUASMTg97J5dAIC2mf0JG8TvHz7T?=
 =?us-ascii?Q?AVx1nVJn7+zIsueXoBFFKiXSYnQlhBmj28oeNHWInshQ9zXI0a9ufrkOA5Z4?=
 =?us-ascii?Q?L1PJQN/C72N5tV4mqncj7eFOHouQHBG0PIzP3cV20/YhaT+cTzhz+FcCeH1J?=
 =?us-ascii?Q?9mP7IG/4CN6kHN5rtRfEIToKfBsNfo500nuip6UvtVJ8I+ofgeVqQK0FM3vN?=
 =?us-ascii?Q?FDce?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:05.1865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0b6139-bfbf-429e-d311-08d8b7733d6d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtwzAphLKzRm50h3aU9IIXGBzYw0xJ8oJ2zzQ4YdO3pWuW8Yf9Zk8X+pYGaG1kYbAYFu3xx4EGwpexWFd9oQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

v2: remove check for error during swsmu amdgpu_dpm_get_pp_num_states() call to match previous powerplay behaviour

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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 66 +++++++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 16 +++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 59 ++++++++++++--------
 3 files changed, 63 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index cc32cfb7e41e..068a369866bd 100644
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
 
@@ -424,11 +420,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_power_num_states(&adev->smu, &data);
-		if (ret)
-			return ret;
-	} else if (adev->powerplay.pp_funcs->get_pp_num_states) {
+	if (pp_funcs->get_pp_num_states) {
 		amdgpu_dpm_get_pp_num_states(adev, &data);
 	} else {
 		memset(&data, 0, sizeof(data));
@@ -454,8 +446,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
-	struct smu_context *smu = &adev->smu;
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
@@ -468,13 +460,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
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
 		amdgpu_dpm_get_pp_num_states(adev, &data);
 	}
@@ -589,13 +576,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
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
@@ -989,9 +970,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_pp_feature_mask(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_ppfeature_status)
+	if (adev->powerplay.pp_funcs->get_ppfeature_status)
 		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2862,6 +2841,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	uint32_t limit = 0;
 	ssize_t size;
 	int r;
@@ -2875,10 +2855,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
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
@@ -2896,6 +2873,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	uint32_t limit = 0;
 	ssize_t size;
 	int r;
@@ -2909,11 +2887,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
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
@@ -2932,6 +2907,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int err;
 	u32 value;
 
@@ -2954,10 +2930,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
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
index 155faa589d46..c01cf79385a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -48,9 +48,10 @@
 
 static const struct amd_pm_funcs swsmu_pm_funcs;
 
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
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
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
