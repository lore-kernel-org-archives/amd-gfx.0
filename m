Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC66C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F00120768
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K7Takl3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F00120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BCC6EC06;
	Fri, 14 Aug 2020 19:14:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0E6EC04
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 19:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIiBWQmrfkWZHwJNNgcN5jSOUBSO6/g0XpVovUJ8CvynsOOCJQP0YPevZWJHv68HRlCJFe2n6x90piRIXKZhCBTi/1sQl6VnOEGJpRjt5EmCHlot9ShwRnFBhvj9Gsbjc78uNUwJICBw1nnPXC+3yIHPi4ONC3k8iF/vvHXLWiUQUij/2+ZOCHpuxl5Y0RaXcEKOKI5kJP1G569PTkYdj3DVetLdXanH47R9glBuHo/fP8fuS8BS2TKjd16NBED83iwBPPcwwcAr/HllSg1YwoAzZyEtNGhl+kiaMgja8sByh08AM3JJw+pTzpDOUUKteWbY22Wo3+qLbPqQ8W+6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSb7E/DeZ+vCEL5zh0ClyGAE88yXOtsvwC+5nFbllWY=;
 b=NYIrlMm3P512JCj35X2fvNiv6+XIM9SEkHvvnRwgpJofpwXuQ/ebS+nEtpJPpOqpwLarKkm7YR23Z0E4N6zzcQH6652rgf1l96tCcHD3klscWHu4bnBAZx0I+jzlAgsKNNZQrhA3eGbZucmhXXIZ2o3oRPE2rPx/m/P/th7VxFkwkTjf3aM77j9fi6z4WIamai7rwkXTLP8EdxAy+hLmU+U7iz262of+c0XTXnA+kP7vF2yIeMM1oPbHt1f2A/4PKOdTgYlolhhrtglhWMS5sw1qNCN5ALRqB6bCsCRSINaCv9whh+pUU3xosAcSA/o+3YKkp8n9/pNbOw+Hg4v2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSb7E/DeZ+vCEL5zh0ClyGAE88yXOtsvwC+5nFbllWY=;
 b=K7Takl3ReLzcbyNkCGa5NodxdxY4IN6L0Q7xwwpTik3W7c0mEhiw/uha6QXn35pvmX7hG7V+DZluGIfXybEQgwZ5CTS0sbyVEEinjGUEs8rR8pNX8Ml+HvqVNhc7c4fdG7IrvUIQzmouM61geCmZ/0A7nkBauMYunijOl0ggtx8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 19:14:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:14:24 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/scheduler: Remove priority macro INVALID
Date: Fri, 14 Aug 2020 15:14:01 -0400
Message-Id: <20200814191401.25606-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.215.g878e727637
In-Reply-To: <20200814191401.25606-1-luben.tuikov@amd.com>
References: <20200814191401.25606-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YT1PR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:14:23 +0000
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4da4fe8b-7ccc-4fc0-ea33-08d840864133
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217FE050BB914D35B6EE87F99400@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RnUyB8mir/UUbeWbtvvfEP21g/C1B70urvMA8kh9yqxCYlZsGxxQqdLwVUaBy8MpXlu+YUvWePV0nUImpb7/nRobfHvjbi0cnbgycOf3aYy6bHMEqFT81uONGsv/hmiO0eEB/kxosER1IW7AtpDN1Rhx/pgSCVa3nubZVZD1ybFJsgWCAc+2yq3BTgKbYFmqcOtSCkR6PiEOmvYUhG8wxhTfsQahnwdywcykAvWV759V0lMUsGGSND2VjLexz3hxYsmd8GmvoDlhHEpyVcQy2kaVzcU9nj3l20GSu1MWMqLQLB3g7gSNk+etjBvx18XuVRtYKNqq2GyUcm7jxHI2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6486002)(4326008)(7696005)(86362001)(36756003)(186003)(52116002)(956004)(16526019)(2616005)(1076003)(44832011)(26005)(66946007)(5660300002)(8676002)(8936002)(2906002)(83380400001)(316002)(478600001)(66556008)(6666004)(6916009)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bXUtYVXyifXBRtSk9tC9mqZCNzYGoGOj1xH+cAwjDTfE1ygOkDZa01MGw5N6BnTuNrBrPqjK0UtYCpLRyvG9YfbouCDA7pxMNyfEYPVU4RxZFYlrbP2nGYks3p61zTNo0Bgo9FD0T7zRGPRn0hkr42S0MujETdEHkQhiO7qO7FqYP6PwekxUTMO6kYw7pQAzBT0cZvV+R0ovG4GgJmSojIc9SISxvIThQsd706NYtQAn+SQTds/utmH+j/qlYE0i/a0LlojrwoEWU0xngKkk0OBZL0k2+TX0Liu6BnY1voJ8nIprGmh2FiH3X/HcKXH5TopbUoSOOw5HfybxrlmaPmp6g3QqrljVMxnikFKYqZljdHKeY23ZgGMr0pN74A2jfkpqDdB1dyF49P9QX+yE4NLYl2vQ6mpHj9ffzYkacv+sSS7czzp90OaA4dWW6WVH5PGLjP4FRMINLX7xOtidOncK8FJYMi8do9gRHrpqUJKgmHcLXCCrwxi9q9Do3t1WAETRGV+o9Zd0zzRDXVzPBsXnTdESWRHBbT8E9H4zPYNE5RxeaVlJma74kXzfkrOE+7COnzTMYsdNj5eHARxxJTZT5VFnVTzIk/pZTvhPrzv+oXaeJiQXLX/kGUVKRmBRnUWI3G1c2xofC3F7tA3+vg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da4fe8b-7ccc-4fc0-ea33-08d840864133
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:14:23.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7EgIrPdLXSojJbYHUNbV2ozM2NaD/Pyeb0LGnBSHnK9R/ihzgV6ymjT508o1YHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove DRM_SCHED_PRIORITY_INVALID. We no longer
carry around an invalid priority and cut it off
at the source.

Backwards compatibility behaviour of AMDGPU CTX
IOCTL passing in garbage for context priority
from user space and then mapping that to
DRM_SCHED_PRIORITY_NORMAL is preserved.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 21 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 62 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h |  3 +-
 include/drm/gpu_scheduler.h               |  1 -
 4 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fd97ac34277b..10d3bfa416c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -384,42 +384,41 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp)
 {
-	int r;
+	int res;
 	uint32_t id;
-	enum drm_sched_priority priority;
+	enum drm_sched_priority prio;
 
 	union drm_amdgpu_ctx *args = data;
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 
-	r = 0;
 	id = args->in.ctx_id;
-	priority = amdgpu_to_sched_priority(args->in.priority);
+	res = amdgpu_to_sched_priority(args->in.priority, &prio);
 
 	/* For backwards compatibility reasons, we need to accept
 	 * ioctls with garbage in the priority field */
-	if (priority == DRM_SCHED_PRIORITY_INVALID)
-		priority = DRM_SCHED_PRIORITY_NORMAL;
+	if (res == -EINVAL)
+		prio = DRM_SCHED_PRIORITY_NORMAL;
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
-		r = amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
+		res = amdgpu_ctx_alloc(adev, fpriv, filp, prio, &id);
 		args->out.alloc.ctx_id = id;
 		break;
 	case AMDGPU_CTX_OP_FREE_CTX:
-		r = amdgpu_ctx_free(fpriv, id);
+		res = amdgpu_ctx_free(fpriv, id);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE:
-		r = amdgpu_ctx_query(adev, fpriv, id, &args->out);
+		res = amdgpu_ctx_query(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE2:
-		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
+		res = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	return r;
+	return res;
 }
 
 struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index e05bc22a0a49..2398eb646043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -32,24 +32,32 @@
 
 #include "amdgpu_vm.h"
 
-enum drm_sched_priority amdgpu_to_sched_priority(int amdgpu_priority)
+int amdgpu_to_sched_priority(int amdgpu_priority,
+			     enum drm_sched_priority *prio)
 {
 	switch (amdgpu_priority) {
 	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		return DRM_SCHED_PRIORITY_HW;
+		*prio = DRM_SCHED_PRIORITY_HW;
+		break;
 	case AMDGPU_CTX_PRIORITY_HIGH:
-		return DRM_SCHED_PRIORITY_SW;
+		*prio = DRM_SCHED_PRIORITY_SW;
+		break;
 	case AMDGPU_CTX_PRIORITY_NORMAL:
-		return DRM_SCHED_PRIORITY_NORMAL;
+		*prio = DRM_SCHED_PRIORITY_NORMAL;
+		break;
 	case AMDGPU_CTX_PRIORITY_LOW:
 	case AMDGPU_CTX_PRIORITY_VERY_LOW:
-		return DRM_SCHED_PRIORITY_MIN;
+		*prio = DRM_SCHED_PRIORITY_MIN;
+		break;
 	case AMDGPU_CTX_PRIORITY_UNSET:
-		return DRM_SCHED_PRIORITY_UNSET;
+		*prio = DRM_SCHED_PRIORITY_UNSET;
+		break;
 	default:
 		WARN(1, "Invalid context priority %d\n", amdgpu_priority);
-		return DRM_SCHED_PRIORITY_INVALID;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
@@ -116,30 +124,42 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 {
 	union drm_amdgpu_sched *args = data;
 	struct amdgpu_device *adev = dev->dev_private;
-	enum drm_sched_priority priority;
-	int r;
+	enum drm_sched_priority prio;
+	int res;
 
-	priority = amdgpu_to_sched_priority(args->in.priority);
-	if (priority == DRM_SCHED_PRIORITY_INVALID)
+	/* First check the op, then the op's argument.
+	 */
+	switch (args->in.op) {
+	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
+	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
+		break;
+	default:
+		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
 		return -EINVAL;
+	}
+
+	res = amdgpu_to_sched_priority(args->in.priority, &prio);
+	if (res)
+		return res;
 
 	switch (args->in.op) {
 	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
-		r = amdgpu_sched_process_priority_override(adev,
-							   args->in.fd,
-							   priority);
+		res = amdgpu_sched_process_priority_override(adev,
+							     args->in.fd,
+							     prio);
 		break;
 	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
-		r = amdgpu_sched_context_priority_override(adev,
-							   args->in.fd,
-							   args->in.ctx_id,
-							   priority);
+		res = amdgpu_sched_context_priority_override(adev,
+							     args->in.fd,
+							     args->in.ctx_id,
+							     prio);
 		break;
 	default:
-		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
-		r = -EINVAL;
+		/* Impossible.
+		 */
+		res = -EINVAL;
 		break;
 	}
 
-	return r;
+	return res;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h
index 12299fd95691..67e5b2472f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h
@@ -30,7 +30,8 @@ enum drm_sched_priority;
 struct drm_device;
 struct drm_file;
 
-enum drm_sched_priority amdgpu_to_sched_priority(int amdgpu_priority);
+int amdgpu_to_sched_priority(int amdgpu_priority,
+			     enum drm_sched_priority *prio);
 int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 8ae9b8f73bf9..d6ee3b2e8407 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -44,7 +44,6 @@ enum drm_sched_priority {
 	DRM_SCHED_PRIORITY_HIGH,
 
 	DRM_SCHED_PRIORITY_COUNT,
-	DRM_SCHED_PRIORITY_INVALID = -1,
 	DRM_SCHED_PRIORITY_UNSET = -2
 };
 
-- 
2.28.0.215.g878e727637

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
