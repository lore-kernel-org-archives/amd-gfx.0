Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F8C433E9
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C08C60C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C08C60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AF889E59;
	Tue, 23 Feb 2021 04:21:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3424F89DA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5lPefwztTE5lmGC8H2yutAf4AmtK8BXPnRSm43keSpEv87tZhgyHdgO1FJ11w5YGbiGj2K9qixTRw+6E/xMmP0lofp/d5XQAl1PKgZb75F+ywSev1px4ADtKgrKQuFJpDluWC5j5NPe75rlQHgTXeTEtOQSFUz6cMiJ/hd+F1LDOsEM+0rXimdemxjljw6zESxJzb4ODMbR4l5ORQmQvk60r8GjkD5uoujiJjYJoc8vebrxwAKBDXJ2N3dOdq50dE6ZwAER9r83i4slUInKtPTxI6Pb3Rnnv9BUq7m6rjZzAAsFQUmDIoDIvp12EZ9HYXBn+yDqUVaEgOSUow42Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPPKQ0g21ukzqHiHDjXsfLFaXyOqLYTMDz3xBxXuRfk=;
 b=PTTc+aFohVIbN4+9p2p9s9jVgkQDIxvTC61LWwlx+8471nYvViF7QwPrdR9QPZzJ0oQsSUjbRKguijWOEHL8dCTR1xuJ0dOwO76jTzQGLk1rv8kXyQhjOxt1GN0YcMal/PVIOF7DXEp9wB/iK4lSs7/PBslPXcTDGS0DRpOdPYYzEC/15FKVhVNy6ps1jsf5+3b7eTVhIhkm5mAobNXw4uzkXaFb9HZohxQDR2A6+yyY1jFi4vNBFosbBYRAmeD4iiD6GOTgyuHVOHwMwbS08mVsk07LzhnwURRHYDA+sdG64R1Imd4KpF8IOv2tyGCrN5FUsTU95S9Dcm8rG2puzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPPKQ0g21ukzqHiHDjXsfLFaXyOqLYTMDz3xBxXuRfk=;
 b=CABxSkIysEjL8WMPYn9Su7PXae4SQlq3JqFFKPpEG7w/3yvhAwFn32yJ2/UqkYkrZa3rSFqXlPN4CCTo/aF5MlxyN0VX0+0Hi61ay4YrVpICnyn/fk6h7hE/ZstOC/NlBGx6Y7mh6DLGsuxea9OI+oaliC1TRxXb+u95RSUb2Io=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:42 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:42 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] amdgpu/pm: Powerplay API for smu ,
 changed 5 dpm powergating & sensor functions to use API
Date: Mon, 22 Feb 2021 23:20:29 -0500
Message-Id: <20210223042032.3078-6-darren.powell@amd.com>
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
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e1789be-2405-46dc-5779-08d8d7b2858d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850FD626CE89AEC87BC7DEAF0809@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21mtkByxbNxNtIlrk/i4JMqdDDdSmuzPCvA/8+7BIYlWL6XxTl+3GZHVQ4i1KIEC7rum83cLjnsUtUpIt3EqGkmEnwm/JAAIs076dj1E4VqjtjjtIP+LC/ot2Z0EyJBS2gnT1/fHYdheNquc+7PLFWO81MDZiVdury50O3vEcQliBUJ3UCIHBSvGXxQ5MwSBHOM/H2FqJBu/QsxnEUJhGMCYlnZ6Q9c9zMlDN5sLVZL/eGZl7usDswoYw1w0ZQk6kjN5wIZIxWB9/rY3PHQdAze4lYiisAv2nBc7FBW7tSKuLZn+coQHYBs5uBgkjHJkJ0WcJJepY/yEgfhhjt5BKmMlKs2wC6d0j0A+0tNazpd0a4bX0CxJ0V5iye+XeUAnopjW9Mus7t25l0FA+KC8UveG7M6NRBamXw3YsuG1x0/RDms7pPoDC9PSaHvBIysJSMA6bq7/t2zcDHZ0rLyKfDdDw45O6EJHIUU4Wnhn55eMgymOvwlDkRRjlEBlKfLBhKTiS9ab+l47vLZWnMfYLN0nsXSSBlyenEVVFpmwcweILVoGVRXCxg65wTtYLKpWQBxw4Cl2GkRfmHt3em6KTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(956004)(6506007)(26005)(5660300002)(16526019)(316002)(186003)(8936002)(6512007)(2616005)(66476007)(66946007)(36756003)(2906002)(83380400001)(6916009)(69590400012)(66556008)(1076003)(52116002)(86362001)(54906003)(6666004)(478600001)(8676002)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3GdwX4DJpTOm2C6wfBWUyDjhjL3GK4P1gQ3U2y/ESLeOjbXpFLx8rwCfMUH0?=
 =?us-ascii?Q?RhZIouahZeziSmLy3fRVxG9CHSy6JgAXhYPLuN8vKMbjszjOVNVyWUBA6tVX?=
 =?us-ascii?Q?V91VOKLrCxsFsPg8SexkUkTtlPUBd5zBb4WipYSvYxyB9M0GxE6JL+mN0mDh?=
 =?us-ascii?Q?7P7i+Rpql21ZTsSyMevajyyanShpU1uONcePb0nDZ/ls4roDb0iN3bgVaaK6?=
 =?us-ascii?Q?hv4j3pHlAWvm4q9wS3kTbShDCnfesqFz0ntGNuhMFsT/IK3gSlLcRCbN7SER?=
 =?us-ascii?Q?yShJAkMYP7389OFY3J7YeyVcBmngM8HMXNEuVG396an1NW9MJEpjI8GiPrFa?=
 =?us-ascii?Q?lgPMgxrBoQhVHMUOy200b06yQ3W8nlcwW2OgsmoHYMesYWtoIKVtAE2D3PG6?=
 =?us-ascii?Q?UtIInt1IR6nkUGmC7aNCqxRU45bJXfnwI32mTnadlv8Y5JDFfHRqD7qD8Ae4?=
 =?us-ascii?Q?s9suUwfMfnKbA/prEMj0G+1AUVDtulfWz7k+zKG+QTC9zZxeW0xVzOMz35N+?=
 =?us-ascii?Q?Iu7G/U3Fv3alnFxRtRMmW7x1jBL6W7187q5I2uXRQdKtYvkudFB2tyPmz/Re?=
 =?us-ascii?Q?k2R8Ebk6OzjcNRfSmu7gX2bTMWPlc0K1Tqy8ui0t9tcKpOxP2zk4tLlxXOyG?=
 =?us-ascii?Q?Ihf3HVP49TIupWV/W440flOvaRGoxT9WaBZcIpkrXjIii/vS6rtJlrwwoEVC?=
 =?us-ascii?Q?/DYwyOrLe2t/+QPwYwG/9FO9GirD1CZcObPQFR+oxZytXK+aDeKhiigQVcuQ?=
 =?us-ascii?Q?ADeuAfZTRVWW+T5uAXhaSg58J6eaS9ee9HVGqg5RLMRUf/vdIttPDOOQsxSY?=
 =?us-ascii?Q?HKrO/cRqm9nFO5K0CPgeoyiZZ9CQrSOSM/gDVhIkvj6/8U5DXrVWh5xtdSMS?=
 =?us-ascii?Q?aFfa62XJ6+j0RBBT0FGw3sNmotKlhiH5DHkvqRkKusEVj5GRgVHrYCVzXwpp?=
 =?us-ascii?Q?gJDszXaFxNMC9jdxLbi7ohPTgx/qMlYORXf3DBv6v1cP9oe2u/0TrWzj+UpL?=
 =?us-ascii?Q?IynBWp24eOVUGAHP2umyvOvtrJlU9m4p4LddwBEyEs9QcSkI5K5eSsOwLb/a?=
 =?us-ascii?Q?O7v3Sz7a7CRR36wY2nJscB3M1b2MrKqtwo4WWreK3VeutV5iL6BbsxN2zjXQ?=
 =?us-ascii?Q?vAfn9VkpVeq8TVaPioDP8GpZ/KKfTBqyUl3vdI7FUq7BOye83edHrOu696sJ?=
 =?us-ascii?Q?cSjpipBM1jOhG8e/tSR9uOClF+4KcMetzvU3hNbSbKmUmscGe63nMdvvgH6t?=
 =?us-ascii?Q?/BrriPtXbJfETt7mXh3juCA3bb5mvheH4fpVWLUOoK/WfLCMqkqUn4Qw2ZHq?=
 =?us-ascii?Q?jO/llT2JYAvisw4jmvsuDDYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1789be-2405-46dc-5779-08d8d7b2858d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:42.0486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQuwGWux47mTeEi1N03Mkw+JZ4LE2z3/ebc1aPX6+S8Y1XqQzh3UGFeD92CyBLSMow4IIE9z4s3lXZo6S12fmw==
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
index 6c0aa38fccba..1835fce3369e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1246,9 +1246,7 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
-int smu_read_sensor(struct smu_context *smu,
-		    enum amd_pp_sensors sensor,
-		    void *data, uint32_t *size);
+int smu_read_sensor(void *handle, int sensor, void *data, int *size);
 int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
 
 int smu_set_power_profile_mode(struct smu_context *smu,
@@ -1278,11 +1276,14 @@ int smu_set_xgmi_pstate(void *handle,
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
index e2b885bd23a3..f88c1d2ab9b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2169,20 +2169,23 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
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
@@ -2227,6 +2230,9 @@ int smu_read_sensor(struct smu_context *smu,
 unlock:
 	mutex_unlock(&smu->mutex);
 
+	// assign uint32_t to int
+	*size_arg = size_val;
+
 	return ret;
 }
 
@@ -2523,6 +2529,27 @@ bool smu_baco_is_support(struct smu_context *smu)
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
@@ -2575,6 +2602,40 @@ int smu_baco_exit(struct smu_context *smu)
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
@@ -2759,6 +2820,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
 	.get_fan_speed_rpm       = smu_get_fan_speed_rpm,
@@ -2771,6 +2833,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
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
