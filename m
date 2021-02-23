Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470AFC43381
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD59464DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD59464DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56216E223;
	Tue, 23 Feb 2021 04:21:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBBA89DA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5e65Nz7ZnPrsCXs61fqAx1zqh+9JyiA2DIAr0LZs7IFZI64fAaOF8E1QSpeT7wANAJy3svIW7NPhjRthGekn0P+CESRM5da79v1R4Sbr7J/NuYnl0jUkWwntP7zYh57mA/c/da/50dvz2gaILEIp7HSLu3s6V0eLDnpDibh7Kd/1YvXJrdDI/g2pfrPPKXiUWEu/sdzIaIrMXvG1xJJM/37PA99Q1FZvJvg5NhEOyX8kVHBol5UKKjvw5NDX9Zl+zjjtIY7ilzWYI4wygxZ/2GVqf+lANu5J+veOirJ5m70mJgilZDEKzX0vgZxwGM7aqAfOmaM/3rL96nR+097iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKR9RkLX6qR4yy+skDLaUt+nLZUc4lvM46BDSGIoypo=;
 b=Ufc9N92hA1gN5zqKvW4n6TZt+aVualGZEfKr/UAanJlXrYVqC2O1FvhKzhY5W0ammmXA2YxDghBOsHpRD75pV373PeTmWTjC0Led6L1GvbLs7qHoD+8wLxQ7SSHI0PuYlcCJGyzf/yTOijSB4Fym8CmP+g7YyJYjVJDya9i7U/aNL+KS3R+hm8Pu2iN0VKpJLXwBVKtSS2IQ7naj0r5OxKVHX1mboJlMsIG9+QELNSBdu7CmrxGOAHOjvhCGghgF0gVXWUHRnM0fSyutY/WMT8KXEyRYgnpY//9msGJ+oO8F5JtcaDpuqRWsuys9JfEM0HBC+IpSL9IXj/F+oa+yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKR9RkLX6qR4yy+skDLaUt+nLZUc4lvM46BDSGIoypo=;
 b=a9T/WV/7+czeggJeb0AfIAPjfTYtlh1Kj6tDQymG4cHgswC88ybvcg86cszWz+AEWJMdBU2HqWRTMolpOLBNuCQoALPyunc2btvrFGejd1Wcvwwq+ERqMcLIM65Jmxz483Kc7ETgfvnwB5desynbcI6ivKOqkkMsfFXz4cxMFvI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:43 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:43 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] amdgpu/pm: Powerplay API for smu ,
 changed 4 dpm functions to use API
Date: Mon, 22 Feb 2021 23:20:31 -0500
Message-Id: <20210223042032.3078-8-darren.powell@amd.com>
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
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9039bd83-2226-4d2c-c9f5-08d8d7b28668
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850ECF827C5B91812F05BA3F0809@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mq52pI16NTgSMV+N2la2pS5Lmqsv1Q9/O5UtN0T8+sxKdyPUdX74IB9ftMlBYM4gnWzUbO+sZ3rhQGIH0UB1I8XUmtiSDm5DPDmwFgHPvpiRfj2g3TztHteRdyzdL22jY/cEYZSNLZZ/3TpCeitca8oZGa99/hXE465ftGnbKex5qkvPDbxk5skyFUmFL3n2qciPPJZo4GFdOtfvf8HXwnv19QMhuGW0Ynh7BoBR9+2nxUbVWht2Pe7NV6z9AjZmh1adm/oN3ZWDmjFPNXOKvtcoaH8vnez454rt/sraIZIKsyOQPYgeSAE5jP08LdBZipnQNOfr6qaYd0sHz4dAhH6l9MxjmJgswa0XqdRq1gnPNN6LomvBAQkDGlDvluBfXRmDqL7qdkNnUhxiuwOW2r+udztmy1QKEgQCEI7a3vNB2RTa6JmKz6JXeYHblerCeS8qffzdPA8YDwMA6dP0lVEPg5coi02lkMnsr37dxuGjkEpRKdvZMsl0IaeV/cnthJ3FmPQ0ykS8dDA1/SLvyWJOhEoRFNYIea1XcqgCaE2i/WDq5UFdUQ5yiqbm1pwMAwTV/j0nqAcMPwi7yDNtxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(956004)(6506007)(26005)(5660300002)(16526019)(316002)(186003)(8936002)(6512007)(2616005)(66476007)(66946007)(36756003)(2906002)(83380400001)(6916009)(69590400012)(30864003)(66556008)(1076003)(52116002)(86362001)(54906003)(6666004)(478600001)(8676002)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ym8ytN55aXEmZ4XhTlpH/OEN8CiDrgM6uW9hg0qciM9qgI+VD2UEy5/6DfxM?=
 =?us-ascii?Q?5q6x85aLLJTQRE3OLewirFCIo7CHL7q7zyOgqYnEhu+Ck1jX+ZrXzjpUStRE?=
 =?us-ascii?Q?f4WVst9ViStW22VYENjJVhqZL+QRg0WpWjFXf+kwCmTZz2iDOTqH3CoGKLSx?=
 =?us-ascii?Q?QY7RJvEkr0xky3PbtHdfiLHUsT0vTFnC3PLvsoeii3yidEY5dL9N4orKKJ0h?=
 =?us-ascii?Q?6Z26eSAVAht1sYIQFeicM1GgQreL/ZMDnvTw3ALaRjP9A8EJHAEQibxyNFEE?=
 =?us-ascii?Q?tbRy7DE4SbMOtK4bQZcgGjSBNSEZCGneQMHpaZTNCrIq8+ZJGu9oRS0+NPUF?=
 =?us-ascii?Q?zsY3wzVY5h4v+zhvG59p5fIivO0pS/zGE5JCLaLtZ7K6iiAMjKyKOEmUm7Iw?=
 =?us-ascii?Q?To9muhotKQeUCpctwc7r53JYgnZjXDADNI912Z/91olgQuRn/Ju3g4VdVbOs?=
 =?us-ascii?Q?hcjBKKyzPtPdH3EkxR2foRFdfhkygjutbNpEC348Zfp8Q7ZS0YdLoNRi2iil?=
 =?us-ascii?Q?qcRWqp/tQYj7p9O7lyzb1Ho01RajbTWvBnqujnPz9yOvc23/9hpDs3tkQ2Ua?=
 =?us-ascii?Q?jmTae0TxSNpTMJi8CfzPD2hSrh5A3lP2GouLDXNy++Q8NSnZaqAsDYMNHkuD?=
 =?us-ascii?Q?3Z/xPw4lxSc3Wd+1suoRXluCqDLmTyMNFlLsEzDZMTFO+dITOnpGO6NjKg84?=
 =?us-ascii?Q?WHXDMDgSfaUXHmt3+dVevfyepWev8NymIW+nGxYcarAVP3axv7pv9sdwRV6u?=
 =?us-ascii?Q?CU6j2LHiBjDDL0cqjMPujLGYBxNYIbEvZHCCJCkrZnDs+0J8D7aqkmKLwamX?=
 =?us-ascii?Q?GDWVHB5p4MhjUzDE+mxpKqvtzUMHZIrXcirMfCih8r1AwXGXYeWImJGpfSgO?=
 =?us-ascii?Q?5yTM8U7ZupeB7YU3kiufnUY9tIsvAHvjNrw9FEb5t4O0YhG+iG4HdJcHGcIh?=
 =?us-ascii?Q?ZHb3Sn4CuspkIWBn3fPlTaERi2sr06SYvk+TX4bAzlFnQlZ2zLngtOD5oC1Z?=
 =?us-ascii?Q?L5HUbJiyi5CnjrSF7nOGX7ZZGxD+xucjXniHVPQl8XMv99rkP9iAFfE60nXE?=
 =?us-ascii?Q?6wMLeUlC4msc+oH9lWJziHeX+rMdXQuklgQ8UHtLrR/TfEvW1nDmou+1FAFA?=
 =?us-ascii?Q?KVInETRIQV4lEKUgzFmmIwPua0tkBqnVuvXpWlFnlHY7a8ply5kvXE93jQSp?=
 =?us-ascii?Q?lbQZOmieDYti9SLSyRFyLFvCjfve28Q0vqKxdnWbASc0XqwnIU48G95O15CP?=
 =?us-ascii?Q?XSzM/4Q8pUpz8QHZ+Y1geb06jtNiH5XJeXRZrKdE9whVKJTncHzGcdzUjhnh?=
 =?us-ascii?Q?vTz4tdrEtUtFGePviQBVfKIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9039bd83-2226-4d2c-c9f5-08d8d7b28668
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:43.3899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNKLrhixhCYAsU6OmOck/F9QyCmlj+jRVPliOeEXhD4PEi2wmRiSgwniHvc8kNDUysB5glIHrIL+Ywp3D5Pkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: fix errors and warnings flagged by checkpatch
v3: Context mismatch with revision v3 to patch 0003

New Functions
  smu_get_mclk        - implementation of the Powerplay API function get_mclk
  smu_get_sclk        - implementation of the Powerplay API function get_sclk
  smu_handle_dpm_task - implementation of the Powerplay API function dispatch_tasks

Modified Functions
  smu_dpm_set_power_gate - - modifed arg0 to match Powerplay API set_powergating_by_smu

Other Changes
  removed special smu handling in dpm functions and called through Powerplay API
  call to smu_dpm_set_power_gate via Powerplay API now locks mutex for UVD and VCE

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 96 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 49 +++++++++++-
 3 files changed, 86 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8ae2df82addc..0a6bb3311f0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -911,50 +911,28 @@ amdgpu_get_vce_clock_state(void *handle, u32 idx)
 
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_GFXCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_sclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 {
-	uint32_t clk_freq;
-	int ret = 0;
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_UCLK,
-					     low ? &clk_freq : NULL,
-					     !low ? &clk_freq : NULL);
-		if (ret)
-			return 0;
-		return clk_freq * 100;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	} else {
-		return (adev)->powerplay.pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
-	}
+	return pp_funcs->get_mclk((adev)->powerplay.pp_handle, (low));
 }
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
 {
 	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	bool swsmu = is_support_sw_smu(adev);
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
-		if (swsmu) {
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		} else if (adev->powerplay.pp_funcs &&
-			   adev->powerplay.pp_funcs->set_powergating_by_smu) {
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
 			/*
 			 * TODO: need a better lock mechanism
 			 *
@@ -982,7 +960,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 			 *     amdgpu_set_dpm_forced_performance_level+0x129/0x330 [amdgpu]
 			 */
 			mutex_lock(&adev->pm.mutex);
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
 			mutex_unlock(&adev->pm.mutex);
 		}
@@ -990,12 +968,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
-		if (swsmu)
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		else if (adev->powerplay.pp_funcs &&
-			 adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
 		if (swsmu)
@@ -1003,10 +979,10 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
-		if (adev->powerplay.pp_funcs &&
-		    adev->powerplay.pp_funcs->set_powergating_by_smu)
-			ret = ((adev)->powerplay.pp_funcs->set_powergating_by_smu(
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate));
+		}
 		break;
 	default:
 		break;
@@ -1512,36 +1488,30 @@ void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
 			amdgpu_fence_wait_empty(ring);
 	}
 
-	if (is_support_sw_smu(adev)) {
-		struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
-		smu_handle_task(&adev->smu,
-				smu_dpm->dpm_level,
-				AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
-				true);
-	} else {
-		if (adev->powerplay.pp_funcs->dispatch_tasks) {
-			if (!amdgpu_device_has_dc_support(adev)) {
-				mutex_lock(&adev->pm.mutex);
-				amdgpu_dpm_get_active_displays(adev);
-				adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-				adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-				adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-				/* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
-				if (adev->pm.pm_display_cfg.vrefresh > 120)
-					adev->pm.pm_display_cfg.min_vblank_time = 0;
-				if (adev->powerplay.pp_funcs->display_configuration_change)
-					adev->powerplay.pp_funcs->display_configuration_change(
-									adev->powerplay.pp_handle,
-									&adev->pm.pm_display_cfg);
-				mutex_unlock(&adev->pm.mutex);
-			}
-			amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
-		} else {
+	if (adev->powerplay.pp_funcs->dispatch_tasks) {
+		if (!amdgpu_device_has_dc_support(adev)) {
 			mutex_lock(&adev->pm.mutex);
 			amdgpu_dpm_get_active_displays(adev);
-			amdgpu_dpm_change_power_state_locked(adev);
+			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
+			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
+			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
+			/* we have issues with mclk switching with
+			 * refresh rates over 120 hz on the non-DC code.
+			 */
+			if (adev->pm.pm_display_cfg.vrefresh > 120)
+				adev->pm.pm_display_cfg.min_vblank_time = 0;
+			if (adev->powerplay.pp_funcs->display_configuration_change)
+				adev->powerplay.pp_funcs->display_configuration_change(
+							adev->powerplay.pp_handle,
+							&adev->pm.pm_display_cfg);
 			mutex_unlock(&adev->pm.mutex);
 		}
+		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
+	} else {
+		mutex_lock(&adev->pm.mutex);
+		amdgpu_dpm_get_active_displays(adev);
+		amdgpu_dpm_change_power_state_locked(adev);
+		mutex_unlock(&adev->pm.mutex);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 20af40b24f66..a2f4b8f1db4e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1306,16 +1306,21 @@ int smu_set_watermarks_for_clock_ranges(
 extern int smu_display_configuration_change(struct smu_context *smu, const
 					    struct amd_pp_display_configuration
 					    *display_config);
-extern int smu_dpm_set_power_gate(struct smu_context *smu,uint32_t block_type, bool gate);
+extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
 extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
+extern int smu_handle_dpm_task(void *handle,
+			       enum amd_pp_task task_id,
+			       enum amd_pm_state_type *user_state);
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
+u32 smu_get_mclk(void *handle, bool low);
+u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c760f75ccb54..72501d8a80b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -141,6 +141,34 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+u32 smu_get_mclk(void *handle, bool low)
+{
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_UCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
+u32 smu_get_sclk(void *handle, bool low)
+{
+	struct smu_context *smu = handle;
+	uint32_t clk_freq;
+	int ret = 0;
+
+	ret = smu_get_dpm_freq_range(smu, SMU_GFXCLK,
+				     low ? &clk_freq : NULL,
+				     !low ? &clk_freq : NULL);
+	if (ret)
+		return 0;
+	return clk_freq * 100;
+}
+
 static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 					 bool enable)
 {
@@ -216,7 +244,7 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
- * @smu:        smu_context pointer
+ * @handle:        smu_context pointer
  * @block_type: the IP block to power gate/ungate
  * @gate:       to power gate if true, ungate otherwise
  *
@@ -227,9 +255,10 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
  *    Under this case, the smu->mutex lock protection is already enforced on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
+int smu_dpm_set_power_gate(void *handle, uint32_t block_type,
 			   bool gate)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -1678,6 +1707,18 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
+int smu_handle_dpm_task(void *handle,
+			enum amd_pp_task task_id,
+			enum amd_pm_state_type *user_state)
+{
+	struct smu_context *smu = handle;
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+
+}
+
+
 int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en)
@@ -2918,9 +2959,13 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_pp_table            = smu_sys_get_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
+	.dispatch_tasks          = smu_handle_dpm_task,
+	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
+	.get_sclk                = smu_get_sclk,
+	.get_mclk                = smu_get_mclk,
 	.enable_mgpu_fan_boost   = smu_enable_mgpu_fan_boost,
 	.get_asic_baco_capability = smu_get_baco_capability,
 	.set_asic_baco_state     = smu_baco_set_state,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
