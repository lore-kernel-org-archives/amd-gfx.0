Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB7C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4EC64DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4EC64DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D68389E2B;
	Tue, 23 Feb 2021 04:21:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B904B89DA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuMWbEKJ7bVHsdqP7TR7Vf5U9fsFypAdqxbEdUmlvhdSD+hXnP4UzKCVRWTWHBw7/t+im7tfONKzM1zZz89VdfWZsPs4Nu8TnRMShnEgEpKwkQfxG2mKpY2RKYm1eVqrf4HKMGFDBn2R3p6rY3uAK5CeHO7o101c6UOV+gMiVpEK2y9lql2u8cnRRT78/z0747jFCHi2U8JBz1x9c4k30zJ+rDQhVbYdtnnDDiv0P1qELA05BGdFAz1ajHybN7yyb5euAHjEnVIlyPC4jp7Gmh418IFkN2ymH+eZu9Oawv6ucfY6jZMWUh3+nvC0JWgonXK27+L9DiUaIagzwDNwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FPhENfh4PKAvsOXjiVHigQHxysWyf17OTp+GRgGSMI=;
 b=SOd16SxE0pcV3QhGvDDmj40g7BSYPPNWW2WjGRUPtk4rd6LegRkLmAi/1TSIJbQelWn+x9yHuUx+ApIpX9OD0Tksp3JI2reeI3yXYJ4M4Y+asYKxnkGMhFTYjeqV08XPhLg0pDveYkkR3fnoQL1ZtrKtUvd8pvgdup+7IHpFD1ZJ4wtE+Rm89MatimNq9QGhGAvdeypF7Sne6KncB0s8uciz1iHqvBXTe5AFkq1nREw18S5S4+glldyEpi1SJ+Vgbyv2rFBA0Z5tTp8HGFSCEvLwfx2AjvrqlG9z2V+aOTBD7uU1ZBA6wzz64BejOArM3mUtwx+ve2EddihLwJlneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FPhENfh4PKAvsOXjiVHigQHxysWyf17OTp+GRgGSMI=;
 b=Rs4uNFRfO2lBJK1bGbfL73dFRLKCN7HGracjiFKTQp5Pbn84cxPdJSUdzy0678fvxVPTy3XEtJ49g5HCZyji7RR9iHce3JnmUdyF847ZsjQ9GG3AOoflEg60yUhlACabDdgfPz4b6R2w0Vi5ML8OTtD11oFzSw6xow+y42XuRms=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:41 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:41 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] amdgpu/pm: Powerplay API for smu ,
 changed 9 pm power functions to use API
Date: Mon, 22 Feb 2021 23:20:28 -0500
Message-Id: <20210223042032.3078-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cff3e5c6-1d3e-435a-b1c1-08d8d7b2851f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515352FBFD05933BF4B636BF0809@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:31;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAxcAKL8JzxIHJGm1iTlI7/jCeOy+j57Mrk/MaF3jalJTHuhqO1Q56rAFfZbTc2XA8nvM7BSKt9ZvARPiYFxc2Jo+HTaDbawfAjYPttwkngKebS0Og9e8upLMpYbHsEViUv9DbAUJShW7KPDwcgXM4OASVA+GC4vP6BZhnOeAfljQxwMJUETF/14Lp2GHW5IpkN+jhtI8Xz46OZC06R372Kgrx+lnDoBlGGo5P9DJIfzeJexXsaxbw8tm73ULCjymsKQLxw9kNncOj/Q1RJlQUQ5ZO8P+6Vg69fiTAo/SRauVdb8t0/hckZLi0kI4LWpiWgqiOT/9UGXiKwxMq76PfJVovABeBUZ493XxC4e0DG/6WXUq2TWM4J2i9qWgEdUJ+UZGajQiwSpeOs4BHPzY/O3zTCXxQt0RxAOdYyeQ0HEHFln/wodu7PnTpYgfOyPnZNPQtXOPbtQ6vwgeiZuT2L53pUPI/sSdPsEMtrGGLyvxv79zJxVgQlYvvlmJKdPlb1O9eXYKRsSd+HL0zzxERcN999LcY3hm7HJ0kaNTqV9Ww72X/vCYosmlyEKT99Ag/ebDZMubMtuXrAbBJ1cqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(26005)(86362001)(52116002)(5660300002)(66476007)(6486002)(66946007)(30864003)(66556008)(69590400012)(478600001)(36756003)(1076003)(16526019)(186003)(6512007)(2906002)(6506007)(6666004)(8936002)(4326008)(316002)(8676002)(44832011)(956004)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pFD6QF5uB2O+/62MRpaO1VDdbAcivuhz+QP9kI+/ioIpe2YyTCtluhBZ8OI/?=
 =?us-ascii?Q?PY47+CB9eICFBygaAHLu9S0d36I2+ejpDTZnqQtWH4IUbfWYrKIEY288LWka?=
 =?us-ascii?Q?9MvzzEYMqd0hbOgmewL5T1OhiMoiC8X8gb+9VjEUmza5C+POcwq1W4C+QmRW?=
 =?us-ascii?Q?CbKJOSwKF8CXfEb8nd9PkMmBYsPm2VE/LOUxpzDBn9NtEz2KxcL0af83U8fO?=
 =?us-ascii?Q?TEel82OM/1oE+6Fj7oQ/9X9Wl9C2aF8z4nBqdYhtfj5GsjaZcLV09YAsieP9?=
 =?us-ascii?Q?fmQ9tA7UC37iB8XSLv8vwdORdWyhqdrf2cDesudHQWH27NJRKkNlNBIyBU9Q?=
 =?us-ascii?Q?Qo1Cf1q+sJox+7bixmFUxRE5ZTC5+xEjMGhYPj380qjLDpw35op0xlgSRlnl?=
 =?us-ascii?Q?OJHPleGwgm0P10m3lngtK+C2QOaDloVa9jMTWQ7WZNI0Rm/Ue2q2uh34cAt4?=
 =?us-ascii?Q?TcKfYzt4SDKul3cVofrLlXoDONqc11BEOXDHKlbUF0nHll3k245eS7NKX2F5?=
 =?us-ascii?Q?S3qyy12WksxsUetyyuQwQRGm8muJy7RSIUPBDsIQeU5rzjSwQYOT/nJ/G53V?=
 =?us-ascii?Q?dd1Ghbr2JYJ5rUGlC5DIFisA8im4NM1+S3F0as97KxwZrkt8At96lZiMvRMZ?=
 =?us-ascii?Q?YCUohCS25K9MwIYtyMkEJLPxekNwEW4FrSUTTYwqrrDy/yqYnsaXsOUIrCjs?=
 =?us-ascii?Q?KNH/zcabhud+rUVVFejkH6hj+OgbHUmRfMDfDTFlolK6504xn6HhQ9l0Evbs?=
 =?us-ascii?Q?ZyvZXOj+Q88mkrI2v88gISSjmmWBCT74SMCD6nNkSzCU14+gNIGdfoarxXZz?=
 =?us-ascii?Q?3hoRYETVELfFQEnBC0CQczLRW307l+ZLjnANh7tXy6tXlynqXCQZZVaHBqW1?=
 =?us-ascii?Q?mPGt1p3oBmCOK17sKvhe96DNFhCogHes0UskZ3TkymfJWMjNaJN1Qs4n5fHl?=
 =?us-ascii?Q?4sJ51W1tv+GZGf9JGS2vIEVzY24vcmPus72QLxRdlLFFzZiLSZi0M4NiJCeN?=
 =?us-ascii?Q?w1FSjeEO0Aue0/jVIe6iQ4qYWGqqYKYzwwbgDsHmgdXN4mhUWDhh9bIrydKl?=
 =?us-ascii?Q?iEQZbLxmCHEfleMFnbLsbfsBoT2Kji6YeHTGdzrO5+Ff8qmCmBdIEHabIAgw?=
 =?us-ascii?Q?bKJGQ5gV+vtlajflhG8iQ8VvnnArRlemSdP/ug9bx0GPDgIc+YcYq9f1uaav?=
 =?us-ascii?Q?ghmEJrFqyFhX8dd81gd/u1HO1rqx+5X3U6csx/VUJfGacrbSGeSXdrOeJrVL?=
 =?us-ascii?Q?HvuCbvPjwxOmFG6BUhe32aXpeFmhHMjcZJB7WMOQD5+ilWCGWVM2j+/P3SCd?=
 =?us-ascii?Q?cR5XnlY+TGWg3G0rC+4vwW0g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff3e5c6-1d3e-435a-b1c1-08d8d7b2851f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:41.3051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6RLAqvRuFYDKiRvqfnLSi40l3nGWZQKOYWjq66oHOrA36IjTKr4ITdOt5rnGrCVrWizZ/PvmjfHKE07Lu2/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
v3: removed smu implementation of powerplay get_power_limit, which clashed with commit dfb3bb7fccb37
    Resolved context clashes caused by commits 9485ed36411b7, 766e03739bce7

Modified Files
  smu_set_power_limit()         - modifed arg0 to match Powerplay API set_power_limit
  smu_sys_get_pp_table()        - modifed signature to match Powerplay API get_pp_table
  smu_get_power_num_states()    - modifed arg0 to match Powerplay API get_pp_num_states
  smu_get_current_power_state() - modifed arg0 to match Powerplay API get_current_power_state
  smu_sys_get_pp_feature_mask() - modifed signature to match Powerplay API get_ppfeature_status
  smu_sys_set_pp_feature_mask() - modifed arg0 to match Powerplay API set_ppfeature_status

Other Changes
  added 6 above smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 62 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 ++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 51 +++++++++++--------
 3 files changed, 58 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 81ebeff599e2..34e5c4c4f280 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -125,6 +125,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_pm_state_type pm;
 	int ret;
 
@@ -137,12 +138,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
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
@@ -308,6 +304,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
@@ -343,9 +340,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		current_level = smu_get_performance_level(&adev->smu);
-	else if (adev->powerplay.pp_funcs->get_performance_level)
+	if (pp_funcs->get_performance_level)
 		current_level = amdgpu_dpm_get_performance_level(adev);
 
 	if (current_level == level) {
@@ -382,7 +377,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 			pm_runtime_put_autosuspend(ddev->dev);
 			return -EINVAL;
 		}
-	} else if (adev->powerplay.pp_funcs->force_performance_level) {
+	} else if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
@@ -413,6 +408,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
@@ -425,11 +421,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
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
@@ -455,8 +447,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct pp_states_info data;
-	struct smu_context *smu = &adev->smu;
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
@@ -469,13 +461,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
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
@@ -590,13 +577,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
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
@@ -1010,9 +991,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_pp_feature_mask(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_ppfeature_status)
+	if (adev->powerplay.pp_funcs->get_ppfeature_status)
 		size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -3024,6 +3003,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit = limit_type << 24;
 	ssize_t size;
@@ -3041,8 +3021,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
-		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
+	} else if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -3059,6 +3039,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 					 char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit = limit_type << 24;
 	ssize_t size;
@@ -3076,8 +3057,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_power_limit) {
-		adev->powerplay.pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
+	} else if (pp_funcs && pp_funcs->get_power_limit) {
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -3105,6 +3086,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 		size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	int err;
 	u32 value;
@@ -3128,10 +3110,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
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
index 81ee621df448..6c0aa38fccba 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1239,7 +1239,7 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
 
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
+int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
@@ -1296,10 +1296,10 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
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
@@ -1325,8 +1325,8 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle);
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
index b7fe56b9e33e..e2b885bd23a3 100644
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
@@ -381,7 +383,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
 }
 
-int smu_get_power_num_states(struct smu_context *smu,
+int smu_get_power_num_states(void *handle,
 			     struct pp_states_info *state_info)
 {
 	if (!state_info)
@@ -417,8 +419,9 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 }
 
 
-int smu_sys_get_pp_table(struct smu_context *smu, void **table)
+int smu_sys_get_pp_table(void *handle, char **table)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t powerplay_table_size;
 
@@ -2085,8 +2088,9 @@ int smu_get_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
+int smu_set_power_limit(void *handle, uint32_t limit)
 {
+	struct smu_context *smu = handle;
 	uint32_t limit_type = limit >> 24;
 	int ret = 0;
 
@@ -2663,8 +2667,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 	return ret;
 }
 
-enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu)
+enum amd_pm_state_type smu_get_current_power_state(void *handle)
 {
+	struct smu_context *smu = handle;
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2750,19 +2755,25 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
-	.set_fan_control_mode  = smu_pp_set_fan_control_mode,
-	.get_fan_control_mode  = smu_get_fan_control_mode,
-	.set_fan_speed_percent = smu_set_fan_speed_percent,
-	.get_fan_speed_percent = smu_get_fan_speed_percent,
-	.get_performance_level = smu_get_performance_level,
-	.get_fan_speed_rpm     = smu_get_fan_speed_rpm,
-	.set_fan_speed_rpm     = smu_set_fan_speed_rpm,
-	.switch_power_profile  = smu_switch_power_profile,
+	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
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
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
