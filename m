Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF47C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7500361A09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7500361A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301C96EA8D;
	Wed, 24 Mar 2021 21:17:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0616EA8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 21:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAfVkxpIDCKje5UrtOrAciOUhGxZiyM5qP1kat8oojE/oa21+sn77rEb5pWhtFcgdlRIUEMVJPchrjbRcuN90sMpf62LvNbfP/o4Wz4Vv26kkGk0YCGkpDiaGu2VFBEDALsqj4D9LiurL7iUTgZ5a6pzTNo3ue3SPMtaEmrkQYU/QVDA/GdmJXCZ5A/INZlN+m7RzOAf2dM6McCdVJGUoT7cVy2wweQdaTkjJEEFlJxk01KTnkVeCZ0ZOb5KVrZwS0B1yZ38XliGwSy8haA9CWG4CUbaxXrMeYWirWKIGTPH1c7K74lDeRH1c9OM49Dput4tYqUE07+xY/KJgtRWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/jwXGRDdQvmRAmV3RynQCCRfI62t4thazR9Ym9Aavc=;
 b=NXUeOTSmoJqh7x3VzBAjoosFax5pGIUkm2BlFlZzvNjQE/tKZCwUBH6+ZCHOnfpZdAqvWEjFiMtqLzxHyAL8au/F6kqUO108GCvhSfwxfYNSRC8Ts9pDXclVW4EhVoVp9NMsiudRRT/cDhNZ6m9fEXZAJyG+EsNuLEVPyH1et04/NpdzZx3ojdq7SUot4DMDal5ltYzAeHegOQdeRQkoGsVUd3fWnqK2jE5pZXCcmrI93XEXq+SVbF68J6ovJfxgvXW/DLSCMdEJsThuvrtnk8YCD//Mmu/DLBV+GZSp57YX4ymp1aifk75u7sCw7GfcvqtoQh4jYIXcCtwerCO0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/jwXGRDdQvmRAmV3RynQCCRfI62t4thazR9Ym9Aavc=;
 b=cH5rIz2Ym/ljhgllZ34P+SwjAGUElApZ53b/pLbUpJWuE4dDg1FuIYr0wGOXtOvmqW5y0+tvQ0A5AqcWDS1PRl00Pv3h7lp1yY7PJZWOw6o8rXZn+Uts7r/u29ShD9BmEswvf+f2r9vX+GWXqwf4nHTPVXP6s39LeTZV8R0BUz4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2530.namprd12.prod.outlook.com (2603:10b6:207:43::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 21:17:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 21:17:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: bail on sysfs/debugfs queries during platform
 suspend
Date: Wed, 24 Mar 2021 17:17:31 -0400
Message-Id: <20210324211731.202254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 24 Mar 2021 21:17:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 837a2f78-8f86-4eca-bce0-08d8ef0a44bc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB253070316E195BAEF06E5C6BF7639@BL0PR12MB2530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFObE932hmaZaR1OFbmQd0B4XprNdtWUA5X3yzW20v6lu0+UT+vthb1rEu+bUKJzXyWGnOtSW8F2yj1Ac2qKOyMGuoZ7BY+UNuyQo1NjH5xEOTs63K12MHuJSi3voVrVnUmV6LNvvrBwpuOKaGDgOtP0LHljIGqHj9VzPw6OqI/PRP5pYJ9x2P8SVsxyDSkyvm18Kdd4DZAHgOn+1eXyEh59NQ7drH8z+eNWMrfpdsL3BGOBIgupvbn/LwvLllE6yGcax5Hl5UEy6m6d7ONU10G1H5NYxzxp6GzP/bGpCm5xsD4Ir37AmK6/M6pAOA3xsudYguy22QUastPwkdvIiYGcIzp77ixv6CctojjZrQoWXGPH6EDzRM9mMfFAszGo6o5Juri/555ClBt5qAEGbg53lX+YGP1NEJYKSisJeEkdRqgSa9odm/dCW4ftKH8iPa7EsAzSB285W5dxNjqVv7Hki1jvVMePJUzSeKeu7jPZeDf9WUo3kODPcRkpXg5TYPrK9erCndK31JuTQNsGcRpnIloDmLr4X+3/R5dfFHqoMBwec8Vu4OqlysFYm4+nTTtCILmAs4HDbLxFQfsMZl8wwR88HKEKyRdL+Cdh07e3dXBNMYpCQvi4W8Cmb86x0ulZMjbJTTODETkYSl6cDluFqkS8ISOJPeTduGVjDtx2NI0wbj9fKm7sSWRd7B1K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(86362001)(26005)(316002)(6486002)(956004)(1076003)(8936002)(36756003)(16526019)(6666004)(8676002)(478600001)(5660300002)(186003)(30864003)(2616005)(38100700001)(6916009)(15650500001)(66476007)(66556008)(2906002)(83380400001)(4326008)(69590400012)(6506007)(52116002)(6512007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1Hur//ka7yINvKa0fY53PENSM3BfMTO/JAmZg69VBVjA6SOVz0gJ+1XKLPyf?=
 =?us-ascii?Q?zKQ43AkLmj7nFWygWzjydTflaCvGwj4qADu+Yc47+0rf79poBUdqcG1TQWsQ?=
 =?us-ascii?Q?dxsMOps+itJ+dDd7nyp022XRei+zb+hesi1h/5HXOHnY9O5hLUcf4OXYEH6Q?=
 =?us-ascii?Q?l8wT8F1VeVlGymTc6pTCSqx1Q140QbzaBtZpEJEUFjYgzo8rHDTEoQ964OBj?=
 =?us-ascii?Q?tquZW1kMSh/p5ZBdbkdfPaHidMr7+/P+WRTVV1HbcHbklPifclqz2EV+h/PR?=
 =?us-ascii?Q?Yswkp5mOZOg7N2kXgQ/307cRYjd5aJfFPAZ5pW6CHDya3bSz06s8KHGPWj3c?=
 =?us-ascii?Q?a1AZFRu6pnXryT0UWXUoUVCZ5jzRT2dxdt7sjl7t5ypRLWhdlXiSiVc+GyiD?=
 =?us-ascii?Q?iO094LtUHkdI1qI9aScPCUJrFuH5Is1fM3qwxqO7EQhaNLYIfng+cJ3z/IGO?=
 =?us-ascii?Q?nkWP4UY56JTVxQ6vrnLNREN2+Xa7FBx7uX/Kg0Vu/gTpKkk/23VypRCLlmAL?=
 =?us-ascii?Q?/1qCG22R5KwF4R+w9IEN2Gz/9cfMFlZhNC/AMKzpqbE3fkfO2NybuK63MOun?=
 =?us-ascii?Q?NMUOK4ZMzAGFHIAPTwHx6iRhCMt1+gfXzbhFFH+5nEMhB3ypJrz6pMp8hSy8?=
 =?us-ascii?Q?Teccx4dh2fnaX1MRucxbxlE0kK/cj8KE0cF/DZo0l/J1lwaQ5By8TxCxAjS/?=
 =?us-ascii?Q?jKlILq8cgG1LM17lq6iOr1D0wx0v0jEazGFPDY0Lz8kdPnPkp+PqdFm3U+Vk?=
 =?us-ascii?Q?+9jnQcVv+QI363OE6VW6qvai9RTOSI9fWe0tF6qcZbwQs/VTe2wVnj8Ex0Pu?=
 =?us-ascii?Q?PX3e+CrRpaqKKM3ao0AZEUfQ4UgNV+YutevPHBOa/r2L4ENkaAtBtVuGEqCm?=
 =?us-ascii?Q?s+oJ3kcfhCo8EMQ9DN2F4ZWLCNzDc2U+9/9x64X/xDdzW926Cd5UanYJIcZi?=
 =?us-ascii?Q?XmcMQ63H0PMc2YxS3eJlHZs9Qe1xZs9Ecu7jSaaeot73kvZHeev1OqsSuZwS?=
 =?us-ascii?Q?gCXgH9D13yoCV2nosRT9+cSU8K49eZbQbugxPBb7HEAxLr5Ktg6Vhb6r7UgY?=
 =?us-ascii?Q?rmL4jsceLlh43PWc7kXnPHXirbWee5CQd4bOMQgeAfYDbtwlZOATdVM0fTNx?=
 =?us-ascii?Q?jkQ+kmBDCqcaGEdWp3MgIIZAeAyBIyRJ7hAdWM1/84B+7lTNsKqb8dbgzl1P?=
 =?us-ascii?Q?qbuvO8bvUXMLnKjfioLiBVdc/j7866fkJM9KyKyKI+nEzAfBtW7NQ7yAsUUn?=
 =?us-ascii?Q?ravtltdH1/zgJ8kF4/45aQYSF8dAghpEFGB0Ucmlj1x4sF8nG9w3OKqG9peL?=
 =?us-ascii?Q?Cxd6ob+8POPbLIc2MK2/LOdN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837a2f78-8f86-4eca-bce0-08d8ef0a44bc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 21:17:45.8629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e3tA2OOUUqdf9gb6NpAdGMdEXWcHNbClswoECkhjX0vOamGyChVOneEXA1x0XWzdmpzKJZMf3oeMK6o0/gJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2530
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The GPU is in the process of being shutdown.  Spurious queries during
suspend and resume can put the SMU into a bad state.  Runtime PM is
handled dynamically so we check if we are in non-runtime suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2627870a786e..3c1b5483688b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -129,6 +129,8 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -162,6 +164,8 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
@@ -268,6 +272,8 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -310,6 +316,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
@@ -408,6 +416,8 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -448,6 +458,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -484,6 +496,8 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
@@ -504,6 +518,8 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
@@ -564,6 +580,8 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -602,6 +620,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -764,6 +784,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (count > 127)
 		return -EINVAL;
@@ -865,6 +887,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -916,6 +940,8 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
@@ -959,6 +985,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1018,6 +1046,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1083,6 +1113,8 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
@@ -1239,6 +1271,8 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1269,6 +1303,8 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
 
@@ -1312,6 +1348,8 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1342,6 +1380,8 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
 
@@ -1405,6 +1445,8 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1443,6 +1485,8 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
@@ -1506,6 +1550,8 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0) {
@@ -1544,6 +1590,8 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0) {
@@ -1587,6 +1635,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
 		return -ENODATA;
@@ -1628,6 +1678,8 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
@@ -1726,6 +1778,8 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
@@ -1954,6 +2008,8 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (channel >= PP_TEMP_MAX)
 		return -EINVAL;
@@ -2090,6 +2146,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
@@ -2122,6 +2180,8 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
 	if (err)
@@ -2172,6 +2232,8 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2220,6 +2282,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2253,6 +2317,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2285,6 +2351,8 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2315,6 +2383,8 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2344,6 +2414,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2376,6 +2448,8 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (err < 0) {
@@ -2422,6 +2496,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (ret < 0) {
@@ -2455,6 +2531,8 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
 	if (err)
@@ -2496,6 +2574,8 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2533,6 +2613,8 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	/* only APUs have vddnb */
 	if  (!(adev->flags & AMD_IS_APU))
@@ -2575,6 +2657,8 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2619,6 +2703,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2656,6 +2742,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2693,6 +2781,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2739,6 +2829,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -2780,6 +2872,8 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -2817,6 +2911,8 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
@@ -3390,6 +3486,8 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
