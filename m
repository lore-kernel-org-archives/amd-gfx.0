Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A6C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916A422EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916A422EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7355E89C52;
	Wed, 13 Jan 2021 03:28:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A11489B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhJ7KTfJAo7NOPGbyKp/3Te3nB9uQNUAuWQlnfEmhWgN8h4h8ERqzmUIjG2E32h4hugDFi78dNt+Obd8iosvLHta1TXg0ncJocJ3V6Xzv5GsfABaa9R1Yxsauu90NM0gjVCBzxtYWkXpbGa0R3/RZm/HkS501DktFMG0QnzFOw/dEGJi7BuNydEPR6oFpuMWP1ehIiW+Os9gVLfz0BAnL/vcb7SHN52UunO7ChSPavIpfw6r3v07AsERv2I6Qf3tTwBDRZuJgNLd1m/OdMmvkaO1S2mhc8IY81F61Oo7rkN446awLls72h+mrJ/rgex4c6FSXdxenWx1KbMgBnl8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcJCrHFkwXSuhXCvnYf2c3M8yHxAHF2pbHO8HwOr3hc=;
 b=LNLT4u0AAXCj+azfVNsE+dTjA7ZSpIMMuHQnwZAxWAsojN3Eb+K7Md7zZrAOVtic6MBiRfLpaKncrUxVrSqWBA2O/GESrvKarAu/5DlHsP1o2dKXpswbReIWPS6YnK0NrGVTgf6nvGt0U8TjQxMSig3Y8q8xk0bESWV/wO4HrczxwkKEU9chzpCxs3O+fwaO8A7Vx14zKF3MMuwGyNxAID3kV/NIlNSUC9/C5+XQgLts4g7Sal4/z/bYggbtAX8KBPdRHXj9/lqOmkab7gDf9utgChBoua1zSnJiWBYuooPix7DVHaJhdDMr20M1/qyJAGaGpKWjqjsCcFui1XcW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcJCrHFkwXSuhXCvnYf2c3M8yHxAHF2pbHO8HwOr3hc=;
 b=p8dFCCatVQPEm+Lyu1hubDVoehDGPpjdEUSIr54J6SEFSzMgA8mnaRofGxJt/H+NlK2wsQbLNBNO02iIptKd3zyZvknyS1TqTXdR5TmekwuEspEWL4u/ac/I3RaGrH900AHLWokzRhsoQ/kzHu+KPIpKKBfca/eq4PPGFTsT57Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:06 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:06 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] amdgpu/pm: Powerplay API for smu ,
 changed 5 dpm powergating & sensor functions to use API
Date: Tue, 12 Jan 2021 22:27:23 -0500
Message-Id: <20210113032726.2475-6-darren.powell@amd.com>
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
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99a913de-dfda-410d-0305-08d8b7733de4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817EAA946AFD7E5BF2220EFF0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVfJgeiPiDTHYkUh+l75ddgzeWi3a4cT++qVjUKfvSjXxQWIYPGb9d8xLeAb2fUozfnKvnZjC1i9Tj6fIJhXlQrf7JIEVHNyaVKDFs49ypWYRXIdPNtJfVTxAJgmOwOo0Qgs6oYF7IqKIjKchJWXTgJ8htE9TDXE27cJbrdYsINBgTIueCe2L4X5zuAjgfEyTeYN+MYBZRdALKgJtVUcNFQ0IoJMY1BZKXqRF0flORk2tbsAp7tP4ZvCqIMz9SBmYnZ8zixUDSGmynPvR12+rfwKBGGr+HgZ2dRFT1SfbzHc8sGT/jm9ESRLMoED0LMvbySgPOE7niJ7cqlYztT1W44Us9JN3b4MKYmFLpMi7H4O5HXHOOCmMFbUsxj9MdVooRpeJsqI/mvUfUjJYMGF1vohhQn51lCGUv3WiSyq/OQJ7abWTyusZEv1tOvR/ARwvZSqs2lDFMvxd1c0cmq/dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ukxnOvPSWXIeZmYXh9RCbqNzJsJ0HucSaSTX3ITl/ZjoqfmLFGw74G4j4fIC?=
 =?us-ascii?Q?G/hZwxw8HFU4MfD1bJ2rKwAPwjy0OjOohuZAlcTJBjuBgzdARDJ7ADQW2fvo?=
 =?us-ascii?Q?j0trp2jP5oInpDsXMYOCP1KrhuG7JOo7h4Q6++LCbkVC9vQM9KSPhwSSyW29?=
 =?us-ascii?Q?b7heaju3Y3iNuUbLMo1FRb3IZOUqKAMDaw7kv3Tizq6pq16isHqq8n21ja7Y?=
 =?us-ascii?Q?O7Cbm+3qOy2y5PxunKnoRYKb2hZlpif55Fm+YqerMGTYZ7HjGU8V5A6dytey?=
 =?us-ascii?Q?bb/EXB9EDuWdsFIKyKhNxcVlGclkFIF3YIv/tl+UEpa/YkMMTOMwr/wSmnuq?=
 =?us-ascii?Q?Kr1tkiZRFrHiy9q3HJkrcEctmvHU2/CIkRjNSp926BZbH1qURVy6xRW1xwta?=
 =?us-ascii?Q?wnzYUbA8QzE93l3JK+o1WZ6VBcfF2UnhnpMx//kg4aFNgAhxeLVED7HbvCkK?=
 =?us-ascii?Q?8krIXRI8o4czphheO3HrmdznGyK7UTO6+Z0PZpGRNWI8/QwuEgZyJZyeDwAG?=
 =?us-ascii?Q?atA2Sbov8PBe9M9+4MI9C/NPn1El44bxwmqBOJiEx0dB4dqfWT5ymlrP/ZRI?=
 =?us-ascii?Q?D7HUC5BCGpSO/Vams0nGIIo+KtFeHhyYIf6Nk02K4sHukbeTD51CW8cXNS8n?=
 =?us-ascii?Q?7M15msK8jN3hKxz8HZsDK0Atru8IHyz2CBBllf/cZoUmYgl+1uDhxoSiWoub?=
 =?us-ascii?Q?lOdM9t2DEyO8zNyV6vovtK7sbhXWBqYPNbVZRrAajKxm59ICtDdCqLsIiKcH?=
 =?us-ascii?Q?x5GPSXEGgxt9Nw+ukiynO4Kb4AYc5+xfIXkJh0Iz1X/l2XazbefyzrlfCbBt?=
 =?us-ascii?Q?6j1HlMZJR4tSHSBywmrzA0HPEeH2NQUitQ/0DJ+hZVCHO7n2teLH8yx6nPjl?=
 =?us-ascii?Q?a6HTG8Smj+A68wme2rrkVHcOwQk7c7NBdH+Hi9RAcFxAgMtrF76FZo6xv7/5?=
 =?us-ascii?Q?PhFtD27c+6IeuwbwCzbLnjG8Xo4ChUzq5KOvgW/wmvHxM1UJAIiZnGLrPDuT?=
 =?us-ascii?Q?bNti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:05.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a913de-dfda-410d-0305-08d8b7733de4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4EAi55XnVZq7uuV/N74AXcV5I25uqsH0a4tk3LYvhG+C7bCZeGEk1kIwSF9qg4cPGPIqLdegQu3kojDUcPPAw==
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

v2: add comment to highlight assignment that changes uint32_t value to int
    fix errors flagged by checkpatch.pl

New Functions
  smu_get_baco_capability() - Implement Powerplay API get_asic_baco_capability
  smu_baco_set_state()      - Implement Powerplay API set_asic_baco_state

Modified Functions
  smu_read_sensor() - modifed signature to match Powerplay API read_sensor

Other Changes
  added 3 above smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling in 5 dpm functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 86 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 72 +++++++++++++++++--
 3 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index df5e7b573428..8ae2df82addc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1019,18 +1019,13 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_enter(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* enter BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-	}
+	/* enter BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
 
 	return ret;
 }
@@ -1039,18 +1034,13 @@ int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_exit(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* exit BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-	}
+	/* exit BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
 
 	return ret;
 }
@@ -1074,20 +1064,15 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	bool baco_cap;
 
-	if (is_support_sw_smu(adev)) {
-		return smu_baco_is_support(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
-			return false;
+	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
+		return false;
 
-		if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
-			return false;
+	if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
+		return false;
 
-		return baco_cap ? true : false;
-	}
+	return baco_cap;
 }
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
@@ -1105,32 +1090,20 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
-	} else {
-		if (!pp_funcs
-		    || !pp_funcs->set_asic_baco_state)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->set_asic_baco_state)
+		return -ENOENT;
 
-		/* enter BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
-		if (ret)
-			return ret;
+	/* enter BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
+	if (ret)
+		return ret;
 
-		/* exit BACO state */
-		ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
-		if (ret)
-			return ret;
-	}
+	/* exit BACO state */
+	ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -1272,20 +1245,17 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
 	if (!data || !size)
 		return -EINVAL;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_read_sensor(&adev->smu, sensor, data, size);
-	else {
-		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
-			ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
+	if (pp_funcs && pp_funcs->read_sensor)
+		ret = pp_funcs->read_sensor((adev)->powerplay.pp_handle,
 								    sensor, data, size);
-		else
-			ret = -EINVAL;
-	}
+	else
+		ret = -EINVAL;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 8471b42587d3..739d645df7ef 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -668,9 +668,7 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
-int smu_read_sensor(struct smu_context *smu,
-		    enum amd_pp_sensors sensor,
-		    void *data, uint32_t *size);
+int smu_read_sensor(void *handle, int sensor, void *data, int *size);
 int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
 
 int smu_set_power_profile_mode(struct smu_context *smu,
@@ -699,11 +697,14 @@ int smu_set_xgmi_pstate(void *handle,
 int smu_set_azalia_d3_pme(struct smu_context *smu);
 
 bool smu_baco_is_support(struct smu_context *smu);
+int smu_get_baco_capability(void *handle, bool *cap);
 
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
 
 int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
+int smu_baco_set_state(void *handle, int state);
+
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c01cf79385a5..0d657cb518ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2003,20 +2003,23 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
-int smu_read_sensor(struct smu_context *smu,
-		    enum amd_pp_sensors sensor,
-		    void *data, uint32_t *size)
+int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 {
+	struct smu_context *smu = handle;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
+	uint32_t *size, size_val;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (!data || !size)
+	if (!data || !size_arg)
 		return -EINVAL;
 
+	size_val = *size_arg;
+	size = &size_val;
+
 	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs->read_sensor)
@@ -2061,6 +2064,9 @@ int smu_read_sensor(struct smu_context *smu,
 unlock:
 	mutex_unlock(&smu->mutex);
 
+	// assign uint32_t to int
+	*size_arg = size_val;
+
 	return ret;
 }
 
@@ -2341,6 +2347,27 @@ bool smu_baco_is_support(struct smu_context *smu)
 	return ret;
 }
 
+int smu_get_baco_capability(void *handle, bool *cap)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	*cap = false;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
+		*cap = smu->ppt_funcs->baco_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state)
 {
 	if (smu->ppt_funcs->baco_get_state)
@@ -2393,6 +2420,40 @@ int smu_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
+int smu_baco_set_state(void *handle, int state)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	if (state == 0) {
+		mutex_lock(&smu->mutex);
+
+		if (smu->ppt_funcs->baco_exit)
+			ret = smu->ppt_funcs->baco_exit(smu);
+
+		mutex_unlock(&smu->mutex);
+	} else if (state == 1) {
+		mutex_lock(&smu->mutex);
+
+		if (smu->ppt_funcs->baco_enter)
+			ret = smu->ppt_funcs->baco_enter(smu);
+
+		mutex_unlock(&smu->mutex);
+
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to %s BACO state!\n",
+				(state)?"enter":"exit");
+
+	return ret;
+}
+
 bool smu_mode1_reset_is_support(struct smu_context *smu)
 {
 	bool ret = false;
@@ -2577,6 +2638,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
 	.get_fan_speed_rpm       = smu_get_fan_speed_rpm,
@@ -2590,6 +2652,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
 	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
+	.get_asic_baco_capability = smu_get_baco_capability,
+	.set_asic_baco_state     = smu_baco_set_state,
 	.get_ppfeature_status    = smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status    = smu_sys_set_pp_feature_mask,
 	.asic_reset_mode_2       = smu_mode2_reset,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
