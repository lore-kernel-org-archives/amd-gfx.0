Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BFC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 15:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2FA610E9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2FA610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189F96E24E;
	Tue,  4 May 2021 15:04:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746A86E24E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 15:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVOm1YnmquO2uh2pXN/xN9JKPKV4rgis7nHBv2zx2wwtHrlizXhW2zc7cdrgClRnYLhvIjlAyfcaz0DsBiPn5Os72MlzsHTmU/T4hprbbLAWOq9gGA01XxRreiYKmkRzdfd0q26i6WJumthQS27YfECaAeVc9Cck8cNDmsRhB5KkHMXhzS78TULaGdXS1SEcxc2SmBvApMzeH803b64uA1p3WX20hX+4cQ8nxCSf50nXDDHjNKGWERhQlg/ncsL2gz4ZVSyAK6BATvbhL0poRtoDVhyhZOAO9Bnc9ldvM56NKUQNfx24Py+fzgxeyy26FqDuOFdpAY3yXLBCgae84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWKzgUPQ7R/CUIeJ0dZgxTyE0wAjOFaQcpVgDaIfZws=;
 b=Pbrvo+knzX6PFca8gN076NKvEOROklqnFWZxQZ7RPISqNEs4PTyhuZkawc/E1UNpAWk1+ui+45TJ5UzcSvwV6Gk3o4VzyfFBCBy17+qfjrVAsDrDzN+CsDy+2xGbJEyDDRvUS8cQ2O/zi+PAnxcQgiQDJpjJf862AU549YD3wdWXWsO3SbuCHYJp0BffXM1L2Su1Ywue4kqTdBl031GMDUlSaFaLSWFOP4Ush7xDgFD/I0Kq+C31TgdmcGWe6wfbllMUBCxlVQIFKnAJY2iPJpcT+8IdIdMrtHDuVuTs7CQwz/m1uPEomf5rsYI7UIh0FyGvTVczxOWGU2GD7qRNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWKzgUPQ7R/CUIeJ0dZgxTyE0wAjOFaQcpVgDaIfZws=;
 b=tUe1OX128VdAL8cdcAuKBYaSTZGDZUKLSTNbUfcqBgWUnxBEfZxoT/GOrE57/Ojgoqj7MJ5BmQtT27REDIUFwhzR/2iyra0d0a0+RBeHZkhD7qP46XVWyQzcIZfWG2Tnh9+zPpiH2UketrA8MIg6EWEXhgO9qSMbMM/QXvB/DPI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 15:04:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 15:04:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: change the default timeout for kernel compute
 queues
Date: Tue,  4 May 2021 11:03:58 -0400
Message-Id: <20210504150358.1719088-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0434.namprd13.prod.outlook.com (2603:10b6:208:2c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Tue, 4 May 2021 15:04:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7ecfe0-bcd5-4813-28b8-08d90f0de247
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256058C28B19A4D23697A70F75A9@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7I+b+c2RW99sR8RG+h2r89NiZKvhbHFLcR3bnlVVDUP1z/1nhzTwM7s5ycEZv3mcaRdWy3ArCm+lxp1JsayjT9yJGQJVZqf8VGXsUSFeEWeCG1ibZeIBGHFxjbNjTZ6pCJJ84N7Donjf5ElW900DGLBuldzT8CA648qFfX6QSJEmAHqFJJKgOSN8wT3sK6huGSv3fY+DlduG4ZgAe17QJMrTD+uaPGKQEQ3p9HhbVvWFcBDNgVD6ubu+EV8JhAFJcbd2BiI71q3ZLsHMRXQkOAJ4PSYjTQzB417fZBmQxESq7yakPR/l5BnRoLasO65JnqjZ1ijOouowXU0MjfvND7evgnj9RPlvzcIPeSsLaFZVZMpSyP83ArcGmfK+3LLblU2/kVp1sgNvdRY6Nwnw8QLoiAs1R+FdprChID/my3wPDQ44PYzkABCYMKmywpe6SHYjJr7MZ6V44jNeCdHEuhQrebe80FA1ezhIaLvZQAi5RkIuH7Zgcs8GaBcCyaYPp1S/tp7iDJSBEV6Y/99eC/hMXpilodMC5KB9JsNUgR+XxIBjXwhXfFgLX3TNprRk1h5NHsiWjgNHs94qMITHl1P5/9VzSyxrtD9s6jJOLLPUrcxVr+b7F2RtpuifWK2OxgZSF55vD/rg7wUXdON0Gkgr+yk+cNX7a9JFG69uHaouU5RD8HZkdRVLA+oAb6c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(26005)(6512007)(38350700002)(956004)(66556008)(6506007)(186003)(5660300002)(16526019)(8936002)(83380400001)(86362001)(1076003)(66476007)(38100700002)(66946007)(6486002)(2616005)(8676002)(316002)(6916009)(6666004)(4326008)(2906002)(478600001)(36756003)(52116002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hKO9c+lwSvrC4loarKnIwnLUxQViCWE6QEpGiNMROyaCMaUkvkVDher7CJq7?=
 =?us-ascii?Q?U3syaonrXnVaFvRZnqcGm6cY0XreSJlhl5rZoGnyqTeW2pDdttKNdDM4Ygnd?=
 =?us-ascii?Q?zKcr8w8/+YFRGvha5aYkpEsi6I1/NttLW2oZKXry9qCFVM07gX4owSiqHQtI?=
 =?us-ascii?Q?GHQ+a3FnY5xeX6t4tyN9mUO3rKsh6xXX5GAkvA93xn+oUKarrNf9f4ycv23I?=
 =?us-ascii?Q?+G0+a3ITxl+BfX7Bqo1XRcHyR4RNF7eeJo7ymXYVWMqLN0a9FtHz/79gcUuL?=
 =?us-ascii?Q?JnHgg7uVXIcKY9z6/k54Gx1ethxffZp4GVa1NO1pwLim4KkyXA0/nf0w5w50?=
 =?us-ascii?Q?kFNtotFTKb+5qy1ro/4qNKSSFw7RMmkSU1o/IS8TbXhBn9sKKbGLP2g4DC+a?=
 =?us-ascii?Q?gGHO3QT5qlvxpgyE2X9FtFZg6WZVt3RmqNzb+1Ev/OPAoFsiK3Pf/GBQiF43?=
 =?us-ascii?Q?UuBC1XaiSMKGri/VT535b1QFC029YpDmXFY78429kf+oKvLsOJTb/ewtnL4F?=
 =?us-ascii?Q?cPIJIhelbanI72crMUgWFqfZ7ObfwCRf4l90eI491RTV3Ywfa6KvMpptQuev?=
 =?us-ascii?Q?9RPAaafiZr5ZSyGX/5mWaVooIYL55gu3K8bxd9wG8WymYvvbUSylQ6o/i6jm?=
 =?us-ascii?Q?jtq2Pg0dMLv5keQRfkJHqU9oFPSklAJykrsCo+EISmlS+stcUOT/DtgtF8Ci?=
 =?us-ascii?Q?A/wpzn0BorAwWPO3ExIj/LO9f3WAOmtt0PAUXavOsF1jmKWQ47P945YXmwCe?=
 =?us-ascii?Q?FeSd1irzVQu9L0hWBN4VoqolZ0zIZoedC5yikbf/eVnSebnDuMnNqXqiWvAB?=
 =?us-ascii?Q?E+UelO0PhUgy/scRe7iEA6fhi2GKOKR9GSaPsgN82NKHpSepLUaIUrC9QMUJ?=
 =?us-ascii?Q?lF6Olf52K+3+Kr9q0TMSMfWuzAABGm8f7zuipYkNGm2pIIcDJ/MUK/xcKAo1?=
 =?us-ascii?Q?Qq2PhBaBSdjBJQLTUUhosRFUdIE4TDWaC0G3WJNMO3IDm5lysoMn86Et4lNb?=
 =?us-ascii?Q?LJBj4pVjXKS6yrYNsWdCoumoKpb+cOFLj7M5TzFCJLsy/RdMX1A5Gmh6gbok?=
 =?us-ascii?Q?MSSX8de+lj9NLgXCU6bOHuizf2Vz8ub508zzdLGP8og2NGkhK4CEd0UBkDFY?=
 =?us-ascii?Q?vXBNwbD+Wsuk/21Xybbh4NyKfMbzfoSwPzeqsSgrTeK0JD9tTXfDA0GE2Fdx?=
 =?us-ascii?Q?2s2nWdLd1d4J17yiNhzSht6VnlcAzbVb+HI/MXtheltW6WEcEf17MQC/doHP?=
 =?us-ascii?Q?N6hPhljYwwiPpArwhgGpTJcHMJOc7IkBqbbAMYGT6su2wiLceuchKKdO74V5?=
 =?us-ascii?Q?Z2yRrrXy4EfbEsoi7+sJtSiS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ecfe0-bcd5-4813-28b8-08d90f0de247
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:04:15.6335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j27hu06t6hOyUkG5ncOFUr7BDAJ7eBZkL84GwwT2dmL6bQMNRoX6L6Nym3oVDwRI+ktK7vfeuDkJbFVvD09vfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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

Change to 60s.  This matches what we already do in virtualization.
Infinite timeout can lead to deadlocks in the kernel.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 357f9405f1aa..1b60f8205f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3167,8 +3167,8 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/*
-	 * By default timeout for non compute jobs is 10000.
-	 * And there is no timeout enforced on compute jobs.
+	 * By default timeout for non compute jobs is 10000
+	 * and 60000 for compute jobs.
 	 * In SR-IOV or passthrough mode, timeout for compute
 	 * jobs are 60000 by default.
 	 */
@@ -3177,10 +3177,8 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
 					msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
-	else if (amdgpu_passthrough(adev))
-		adev->compute_timeout =  msecs_to_jiffies(60000);
 	else
-		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
+		adev->compute_timeout =  msecs_to_jiffies(60000);
 
 	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ad8a2c391bbd..d3d756585db4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -287,9 +287,9 @@ module_param_named(msi, amdgpu_msi, int, 0444);
  *   for SDMA and Video.
  *
  * By default(with no lockup_timeout settings), the timeout for all non-compute(GFX, SDMA and Video)
- * jobs is 10000. And there is no timeout enforced on compute jobs.
+ * jobs is 10000. The timeout for compute is 60000.
  */
-MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and infinity timeout for compute jobs; "
+MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
 		"for passthrough or sriov, 10000 for all jobs."
 		" 0: keep default value. negative: infinity timeout), "
 		"format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
