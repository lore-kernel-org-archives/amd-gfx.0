Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F978C2BB40
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 15:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE08B23AC0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 15:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE08B23AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5DF6E97C;
	Tue,  8 Dec 2020 15:55:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C956E97A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 15:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQeGbmucXxtzpfu+HAPceMAxLUjK78BKVeyy6H1PLinon+BB1lH9NxU6MdWF8EInsiF5RAexpYAFoO1X+5ILyeRo7AWkMc7y4wSwJtIudJlo7gBeXBWeHsy9WmHNlJmkiN6966kxOPyBMM7x5Cvu9gbcD7x2WMt6szKDGxOZzRp9HIFDy7jUCwzXOh4y3QoNq+gy43jrKSxzqUZRAqAgdlcEypzQ9a1RE6vbg6PLMRT+X+jAtVOuW32WYwWqEW1fA7VLEwYeIm7Yz86Ew43O2YDCSPHhLP2ftxWToSYWJrS0qBPKxwU2W8xRukHBDtQ15P8RdrBBgKL7llmkZvUVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuPk/dUSpx9EYOcb9rJ4bCA/G5w7vfbl4rtY35Plft8=;
 b=nFoQR3XD9MFBcbyDyA/RToj0SR+kl2iI6hgg64eqlYRdEVCPmGoVow+Wpc8NoobvS6HTl1J8AdsmWhNpUk279xNYRP7j5h0xy+arvGNAvvO6FnQP9Mb29rWdB2kqQdXBLil+NhxcVEAMIV4BQLxt/zERC/LgCCVwjVdYJO+bk6OOgqcWsmg9JbRRlO/7b1FdiYiAFaVOUWCFBmzE3gB2Z1oEulE5JXBJItT1Z0EhB1bxj9HNrHOgJU35haLkmjE5MLgZ+RS4SWJ/frt3XPu465shYJUoNMgyqwdSSru/HTqkvzeaNQa9yks37JeYO2Vf1zIQB1roC8mL0YrifaHywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuPk/dUSpx9EYOcb9rJ4bCA/G5w7vfbl4rtY35Plft8=;
 b=LghhVhk0rdg5YnR7OQsp7kj+bGyBFwIXuKDnyEPLXshqRd02x5SWK/4I5PVnLrZItyp3F+oikNuwyroqO+iv2F+eYvibfBPIecPEaMn9NSdZRD+9AC7WI7oInhXmxq/o4ZAmjAQ1yf/qqYoDWHVF20WSpvPTV3w7b3IWELzQCXE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 15:55:32 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 15:55:32 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: clean up bo in vce and vcn test
Date: Tue,  8 Dec 2020 16:55:08 +0100
Message-Id: <20201208155508.6036-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [217.86.115.138]
X-ClientProxiedBy: AM8P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::12) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.138) by
 AM8P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 15:55:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29004052-f320-4520-275e-08d89b91b1cb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00906F8F226CAE71D65460FA8BCD0@DM5PR1201MB0090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eLEe6Cw6ZSstX/Vi4QgvUPTZFd8lFun+aiKwESP3mFU4WEWpvvJuPP9WS9XMXHDG4bRVhMD0EqHgPDCQ3ryTUmdOSc2EvVi5n65QrG7Rn2oFzriffmD5f5B6m2qxZspVTiyd51d155uuQ7nm8ouWla/WTcl2uRkMcUdbsK0YLeOPuWBVkt//9UXzISNV6RZTIhsbtuyyyomVOuHp6+4gORKd/7hrBP+dSSah/E+b7JY3PoPI7fPijxaW/2r9ssDvddjDFt3UusC8HvFCzXzt3Pj7CgClsZP22yrQwIybxzyhuKEPbKeDadJGy+924GTtgLUJWvF/XWPKhw2z9SHhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(16526019)(26005)(186003)(66946007)(6512007)(6506007)(52116002)(66476007)(66556008)(6486002)(316002)(86362001)(36756003)(4326008)(5660300002)(8936002)(956004)(2616005)(2906002)(83380400001)(8676002)(1076003)(44832011)(478600001)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ArV6ulLWb3IZ9XB9FKoKmYg185ZjDpKOlUoB38jF52IwFM8C/e9RgCw6hBIl?=
 =?us-ascii?Q?TVal01lbNOCMz3+YR1zSq0PEYNDog92Z45rZFrrJNK4D9a7lOE2ld5pA9oRv?=
 =?us-ascii?Q?hEkAHygdTgFxteMsAS1yPm9UnTZdVUWxxz2f1MN/TadJk4jguTUTbe++G5vs?=
 =?us-ascii?Q?519zAOMODGsDJwguRfNa4MKKHAHVnUvlsMRG8tDOQhUTzhirRcCXJENBvRjf?=
 =?us-ascii?Q?CBXaSCavQWP/lbhEUuusGLVLch9HPERQJ0/mzzB3eb4FbkGWpeV5fMwD5XlE?=
 =?us-ascii?Q?BIUkLEtdRBXiuK+xf/FEqRkQ8UFoS6s2Rn79f41G9bCUl57Q1rtSmnnRtXgm?=
 =?us-ascii?Q?vGDFNk/lWNICk9+h1g9LTaM3NUOmdRTzh8tnl3ydFnwHwJdKgmpoH32pVZBY?=
 =?us-ascii?Q?iwN7Vs5fGwcW2hfsKTAtjkBJ8Gt19xBQJ2vTeizgTrNKl9PRyg1gZEktSaAb?=
 =?us-ascii?Q?lHh9AJ9iYimESGbGRlUWCpETgK94EJ2hsaq8Ftd0pd7zg/kaoP3LDREJ26uO?=
 =?us-ascii?Q?cUPPyN3PI5ZqkZQ7sBesvAxWLqaAcadUH+AiyHQ6hS4KTJgfdQPmpZiHW64U?=
 =?us-ascii?Q?XutgkIWckVcnH7O8kf7vQTyjiau475fM6FiHF9EHBlub0mvz2dLhb31ugaXN?=
 =?us-ascii?Q?LBkBPaOdcZmWLTHxuKxU/hHAeuYnBbrd9AIUulGucUBQSEEH5pjDCh87ahVr?=
 =?us-ascii?Q?dW6A+aysxEtGVWQOfKdSZqk9yDrrSPjxPhvBJV4FuGOk5gE1Fmms5CesWD0m?=
 =?us-ascii?Q?eSci1tlPYM+c7nRDLzCA+NFkaWj1z+hw/1uhoWymvwdBPGEmw7x6m54AxoGr?=
 =?us-ascii?Q?mvtK8qRKNF+a0t0ih80DV1/c3uMUPraB0RGcdBPFOYqyk3RFLoSzy4BH55cj?=
 =?us-ascii?Q?6lB2jmt26b413a3ucPVVZeaJoSamGuGcsZRVd5STmtg4Gr4EckrRjDJm6a7U?=
 =?us-ascii?Q?kic8tnSz1g6PQXAsTmbgqRbh/xh5Ad+XefYg1jL+/Iwu5YTXvCk7hjFHAGjy?=
 =?us-ascii?Q?eazK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 15:55:32.7839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 29004052-f320-4520-275e-08d89b91b1cb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6c4IFLqEisqnpDWLggWd8y8quE0m9wJlNG5Uyf4Rkedtd42T/YGqiXSz4LVEzljaz+ZOlPUIlE/uGcBXkw8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BO created with amdgpu_bo_create_reserved wasn't clean
properly before which causes:

[   21.056218] WARNING: CPU: 0 PID: 7 at drivers/gpu/drm/ttm/ttm_bo.c:518 ttm_bo_release+0x2bf/0x310 [ttm]
<snip>
[   21.056430] Call Trace:
[   21.056525]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
[   21.056635]  amdgpu_vcn_dec_send_msg+0x1b2/0x270 [amdgpu]
[   21.056740]  amdgpu_vcn_dec_get_create_msg.constprop.0+0xd8/0x100 [amdgpu]
[   21.056843]  amdgpu_vcn_dec_ring_test_ib+0x27/0x180 [amdgpu]
[   21.056936]  amdgpu_ib_ring_tests+0xf1/0x150 [amdgpu]
[   21.057024]  amdgpu_device_delayed_init_work_handler+0x11/0x30 [amdgpu]
[   21.057030]  process_one_work+0x1df/0x370
[   21.057033]  worker_thread+0x46/0x340
[   21.057034]  ? process_one_work+0x370/0x370
[   21.057037]  kthread+0x11b/0x140
[   21.057039]  ? __kthread_bind_mask+0x60/0x60
[   21.057043]  ret_from_fork+0x22/0x30

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index ecaa2d7483b2..78a4dd9bf11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1151,6 +1151,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	dma_fence_put(fence);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7e19a6656715..dfcdd38ff9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -491,8 +491,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err_free;
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -504,8 +502,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);
 
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -540,7 +536,11 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+
+	return r;
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
@@ -566,7 +566,11 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+
+	return r;
 }
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
