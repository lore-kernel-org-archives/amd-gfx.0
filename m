Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E66A64EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E66A64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C336B6EB94;
	Fri,  5 Mar 2021 14:35:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C1C6EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et60ukciYUG+SQdPDwnE+HJnyagKu/1ji52IDiwRQaRdbFJ29O71uue7HaeJuJUAVU0CrEYzUGRk7R2i/QZUl5JNovm73KpbksAHS1vCgIwQiHmhKGCxTUsi2MgEqRJDGpFeJYPow2ERQW+/zLuJl+e8kna6asngao+A6AO/mRyKTUFwccmTCBaXA+/qgglpE7ttNbQN4m8MJ4DUqaOKP6/3ry30XK/C4dyKCv41FsQ4SfYWTJlOg9dM1KIJLBA8wluKMRA0pMdZJL+lCwrvz8srcNs/h42EJBbEV4CcuMz/uaBWB7BWz2zHMny6o5Qs3+cw3EvlUJJiYAbO/VR48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ycKuKEsdwgNFQnQsCNGNZsvc7Yr9HMh2zVdj/59vQ=;
 b=nZ/aSJ7AeF2iV5rYFk51CClUsxvj0sxNwZvVMqHvTrvMtchBNkFbH+51PzbC4VMMGTERVO6LSAh5wSlLc7MdzNnGKdjFbZ3MHqVzT3hlpSq95cYQExhGcwjxsAFc5hQkggO6ZgwwWEUwj0EUtGHS4f1GuK9/rp5y9ExBjgKMXkFIZCmINPcZgrrxiPmxM1G0yEkiXPpYuk93FCqEJvWQ7Y+R1swnK/kl3E08nVMBIwHu3LUtU4giprWo+5eborD5dbvBjGn06gCBqm7lDZJnwOV0UiFJJ4xCPQYBJJ+Q1SBWhyl8H69M8bzGnefGiumX1H35jXcsT2mpXbKK8ugLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ycKuKEsdwgNFQnQsCNGNZsvc7Yr9HMh2zVdj/59vQ=;
 b=WyMrlLawefRFjRnD5K9YFWXn/t6KiIEq0ZYCMgKPk3j2VuAoXbfvu6SPsOKraaYc5EuC1BAJAxKiVb/zJXS+HA6uQ29TusTHZX0hEHlTTdDtojNyHN0FmYHGyODK/paEyWecYJcZy0nsNflLFo2YnLthsjn+C5/Lv9OgjBdkHx4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 14:35:50 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:35:50 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
Date: Fri,  5 Mar 2021 15:35:30 +0100
Message-Id: <20210305143532.5936-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305143532.5936-1-nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:35:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f8c5ac8-6ba6-45ce-4492-08d8dfe3f924
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1845A0131D8860613F55341A8B969@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4hn8SS7Vcp84y0xL+CF6yv9329ysvJSAj9CQxVkANFfo+CIj+g0qMUgMN2DXLvirDRB8xBCxXAhaHNuZUWCHU2r2RC1gzyVmsXMfXSxDfdVpBpI1x20cla4s/NYoIPGWyKZC+OHbyHoHHC+WkQQmxzyv1Oe4rjwIW/yZpUZqLsS806/NDzbiglkXuJ0Lkcp1vr32XknkmTsRigu0/XhYPdOY3KXfBwBW3Lx3SVqC25xNxaITccz+mOqOelxYW0NekrPR8znogfCGC52YmHYo+c9tQRwp2lZEEmIwWcif11acqSBGDtheoaS1lFZ+ZnWilh/ebfcYLokGGuIUU8F/lmDn0oRGhwu2C476F/Qei2CpyAtzfjNojLOy5vfzqIJjDUk8TSEn53h5/uZpcH4q8zl5ifNXlHm0U6kqrrSj+eCHc0SsNABksyf5OGiSU+dYq5goytsJ9qmi+vY+LVlxEetAQHp+wCGs9eixhGiRrLe1v8q9UGrTwcDlNZgGpzbx1znsmDLqnTVZTZNDguVUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(44832011)(8676002)(2616005)(6636002)(16526019)(6666004)(26005)(956004)(83380400001)(6512007)(4326008)(37006003)(66556008)(66946007)(186003)(5660300002)(6506007)(86362001)(8936002)(34206002)(6486002)(316002)(1076003)(52116002)(66476007)(2906002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KdCVug4jYXROl+5YHSdcqf0w6crpGqJ4BsyuoiR1dxSD72INi7xjihZtySVr?=
 =?us-ascii?Q?Zd9+7jzQ6hNuGJaz3XGlgPMmpnd5jKmRBYzm3BSusCt06qhk1rJCk4WWsF7r?=
 =?us-ascii?Q?29tTZENfJxZmVCQBRLk4So7zGrm95O+7Dgo+jSac0JEiuzfMdf6zWcNz5T89?=
 =?us-ascii?Q?nq6ptMpZKjTwbEKt4K6lnJyv+FaJOTCN3bpX77thGeLsCh6JnriqcavRBgsM?=
 =?us-ascii?Q?WKy5t3P44DZDqascydNBtoaHlDPQRJvDhmqWkbfAYz9U31o4A0B/gpoGa/yM?=
 =?us-ascii?Q?zhuTMaWAymN5EUseMj9Axp/OjqUvJtlP6wReMfMri5bpkOEm6rBP6RSMWnMQ?=
 =?us-ascii?Q?LDC8SGvAOj6PWbiITQr2LEl3NQOq+N46eDSZGEU8SuS9LYVwxIDN552Wjd0c?=
 =?us-ascii?Q?wZL4EI8o+PyBG7YXMKxK2RZhjkIIhAjdS0K9+G6t/65SYeivoEDNtPE+I8Gz?=
 =?us-ascii?Q?N9y3VfK2hj9eu1maINB0C04hytfjm8LUh+tBYHRFKtpZ5eistwea2yXjkczw?=
 =?us-ascii?Q?Uf8iMO8l8KZtFL+KNmiuCWkD9IHk86MdKloF0FlqTYEgjC7pmehvmzj2Ja6A?=
 =?us-ascii?Q?bSvvuGCUHSkAFkVKlfQongilepfLY5D52sjIbx2z4hY0P9CCRcb5sMo3B0hJ?=
 =?us-ascii?Q?KsqM64mOOqpuoRGrYk+F+8ljk3F96Po5xMTD1mlxT2r3gH6GLRlUiw0JY9Dp?=
 =?us-ascii?Q?L7X9RMIHa55UxepsI6n+LcHX6MjDw730pgsYdReuPQBfP8qWGXTcbQFQrALJ?=
 =?us-ascii?Q?Nqw8bahGQyQSPZdoQT/HCaBopeDOM8hX0TzsRIDeVIQVPK1aVTsvFQ8EIedv?=
 =?us-ascii?Q?EZ2hl29LFmvi1VKNnlF79qJMWWDl0Csj7P20cG3V3G+8bbkcREuZ9UNYbEqB?=
 =?us-ascii?Q?PwFTJ1dOLp4CjlfSXpJmIfwNQf0+RyaUUy27L5QdlV2tcXPzMGkN2RLDZFSm?=
 =?us-ascii?Q?wQUL5ptqWqit4Jxin9M+z1UvkcQat4WxIprbixWTeJZ7LIBPh4XBARft7e5b?=
 =?us-ascii?Q?KrD6Xw3+0m8xroIfakYs6XBrZjg3mPvusea/L1LVAOcZ/RK5eq3VDmSD2kGb?=
 =?us-ascii?Q?0MiQIounaafyL7Uq+vbXQSIEKrNwfdVuKyW78GTYtXgzcPgwVNJO24fqPWsv?=
 =?us-ascii?Q?fIwde9Siuju+Pf1f6/piON91Zk1VDWrun9jQAui6sdpZGCjVTQzbFcV1u4Ua?=
 =?us-ascii?Q?rumnIdCrx+GeGScFoY5MnQdoTN8zRI/Bs+uSZotn3YTmpPRQ++UNFZnLVvU/?=
 =?us-ascii?Q?XfW1Z5RwLcRtRsJprVriuZl8eTYMLqkJBFqMhwJ2l7xY+Gb5dzqMhMlsKwAU?=
 =?us-ascii?Q?n6TZ5vDsz82VCXnhQyLJHxqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c5ac8-6ba6-45ce-4492-08d8dfe3f924
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:35:50.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG4BmyL3vnI97l/wQqdCbj2AfQjR20zMs4i1M/t2+SRfGXQ7UhU2wZ2uguwur7gdfsJCXs7AQjKj1VJoSz6T9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GEM objects encapsulate amdgpu_bo for userspace applications.
Now that we have a new amdgpu_bo_user subclass for that purpose,
let's use that instead.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8e9b8a6e6ef0..9d2b55eb31c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -54,6 +54,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     struct drm_gem_object **obj)
 {
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;
 
@@ -68,7 +69,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 retry:
 	bp.flags = flags;
 	bp.domain = initial_domain;
-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r) {
 		if (r != -ERESTARTSYS) {
 			if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
@@ -85,6 +86,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 		}
 		return r;
 	}
+	bo = &ubo->bo;
 	*obj = &bo->tbo.base;
 
 	return 0;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
