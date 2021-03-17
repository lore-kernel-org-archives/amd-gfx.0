Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79FC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1303164F8B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1303164F8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFF46E4D2;
	Wed, 17 Mar 2021 07:47:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 612C36E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 07:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG5oHnbXXsZluIQFZTfwXQZgCYSQnDcfDLaUuCZtxGxD7MyLhEhMELkGXakO/41GVd827UJQwn5Kj/alpuSN5O0RGjh5lH/kjTxvKKqsEPJPW+b9L+udU22zE9+u76iY9IrWEBgzIYwUuOesDEsH1x05GcZkvS9UERs15x3dZ3LBjgR4oy5gZbMEYtMHNV+VxSj12f/UrTeTUkYhF0CsqyiPWx6t0RVm5gp7ceh+AnOvE2G3X2JnjbMXMkOIYcIFtMpPU6a8owkAkBJgXCWqbIvLreXDwLxzp6uoL4ta+a1lhGm8ynoG09/bs1gnA19y0VRE1xu8lle1pavUN7FEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Ae2yEDZL1Fc/3XPyjA36YGW2+oZmsyCxhOmCX2aoo=;
 b=SYO1E7L/U/HJcQEwBHhM9zGh1FIvwMMh15vXc8uFGAZou87JnIwzJ/hq7eHsk507zKko0CfIm+Zf397PZHB7YPbyLB/Hr/prdzo/I6sNEFLS7kGvYLFlZ72tBbynBz6phaVqlvwnmBfOfbILBKv3OMfrgqmuqz2U/EE8hJ3Myy79F+agLfOo8+7YCwDE1G00G1rxam9bHbOQaCJ6xmpugdqOAghV3MKurFPCOh2DnLMjRsDjQIOAplq5kdaZ+RK+9q/ORNVPvdDFyK0gda+rN/MMlfZtJW9w5uzX5+Go0jHoz74uLO5Dod4dlJZ2xQ8XDVe8ElGOL6Wy5JWtz0g/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Ae2yEDZL1Fc/3XPyjA36YGW2+oZmsyCxhOmCX2aoo=;
 b=paUfpfnCknYDsAtlfHvrAewTvjz7kRVru0Krj97prx+Aq2bS9GC608wNZEO6Hu8UNwMG3+Jr7bELZ0qqebm9Wbgp+ADyROtDRkh4uMCGp75BsO8BOKnpvJeYnzoEuPg0AJV0ZAaiurecksekacuRtpoxp47KR/FfU+8GL5Tc224=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1847.namprd12.prod.outlook.com (2603:10b6:903:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 07:47:32 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 07:47:32 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/4] drm/amdgpu: introduce is_amdgpu_dmabuf()
Date: Wed, 17 Mar 2021 08:47:15 +0100
Message-Id: <20210317074716.5547-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317074716.5547-1-nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.184) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.10 via Frontend Transport; Wed, 17 Mar 2021 07:47:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c2f91a7-96b7-4445-ee5d-08d8e918ebd6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18478C8934F148E390A432C38B6A9@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwnileEOXuA57ezoc0Dki9PLbbFfNbtbPM3BAD3mMxMd0+q8pSSVCkp0dpyyAIwG1ahvVJfsBCIuRdLISE8yguyj03TqvT/62H6zHfaAXAg6UwMvoW4PAn90Fpj2KI/1YrwD5iMQZ33sXMaQuZaknPxlwTcMkNRjKbLR5Ml4Z36FL4oCravEYD1jr/0e/CAx8JkD2P1BTfEOyGMsuhbodqA0f6+JGkcJnBvqgJPLfpnCbJvLQuwCpanKEhW3FVQ06wwj4x++0mS+SI9hxxqaqbDUzLLM64J7XUrs2ioe/f26z1+yrh2Ci7G8UduhEDNfRRHAKW7ayu8sl3MjHKP4NsW/kGVK1D+BmxT0drOKI494ifyVAFE3HRhLI7hCUA+tO3P0hyWVKN5ZJiHIbzl4J5zPXSYtzje9zrFqKX8Puet9ZASp8E/euZFzFBryY0C0gmPcAcAoAORsWRC6pWXEIzvDuJeoSbQDNxneheIXAYfbTwwtHrMxKbBatZJ7eFqzkiI0/kyhKiPvJcjcLJgqsGcdQHPPTOSAD4HCf2oJ7Wm70kCEO66QwzC/LAepGOuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(37006003)(316002)(1076003)(8936002)(66556008)(52116002)(478600001)(6506007)(34206002)(36756003)(4326008)(6636002)(6512007)(5660300002)(2616005)(6486002)(86362001)(66946007)(6666004)(186003)(16526019)(8676002)(26005)(2906002)(44832011)(956004)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wNO4aQiOQ9WNgqBWDtv/sUjBZD0dPsxJ1wk+T+JXjzRWXjkSIDyYSYamt75R?=
 =?us-ascii?Q?/+prmZ3sdi8nRUqdmmO1xxk1Wd1bu7Y5yT9t6UyHzlAAq5rjeYdtcvwbL1WS?=
 =?us-ascii?Q?WvR8iEM1GqwFc0HjAEI8zuN2XvBstLaJV5k4UfxpLqu02dEkUsM+0QROtIaf?=
 =?us-ascii?Q?MU1DwdyYeFlx1OBocly7zj0tQE7cRySkoLoojq1mInJ323/gpWYfHuEbekc/?=
 =?us-ascii?Q?mmJZL3HKgU9BEuwNvoiqQjrmDkwMxcLyB6+ffq6pQx9TmnnrN/6A+CznKnq6?=
 =?us-ascii?Q?obrUQtnZcKs3abwh5Ui+Afq9SbBSRkodPdTCmRLVaWOJQAwPrrdG0SHDLYWB?=
 =?us-ascii?Q?CxO8i8jFqunpaoeIQJ4E5/b+p0eB8/oa1GGfL+wIxsLI8uk6sFKybYF7AWLE?=
 =?us-ascii?Q?VgqAiePuqkEjQV0jsGZVVauUtgqaDFNa34UNvKbuEtJ9NIEZDp7o2SmAHe8N?=
 =?us-ascii?Q?9W+A8oAAIyC4JEjh4jzVoef5UyuWNld0tJcjNCE5UGTY8kI1yh4RPf+GSfBl?=
 =?us-ascii?Q?PRBhvyVHFifp297m+dvvdU2EHAUnWu/07XofSkopxJ4O3VUVJF1gTWGyFclp?=
 =?us-ascii?Q?VRL3kpTUkO/4AAwf4VU04s3FQ3IVMMvftFt6z7r/dkF4kXNObvxZr7hAVC5m?=
 =?us-ascii?Q?JY/auYWt46wgJcEgNg+OfwSr+Jwz+7H5KaxZkYP1UdHmSSAsO7dYWOy+JpAP?=
 =?us-ascii?Q?IoY00qtGDkdKVh2uyfrYovTDbRwaqzke1m+HvzhtJr0LRGufyEK0IvzhGoK4?=
 =?us-ascii?Q?3AhRqPhPJStXvlxq8K2m0t1hxWWcnekJ4W0RjvlVN+/DwolcSHzoY9xXwiWx?=
 =?us-ascii?Q?Aq0JL/0YNCn1smT1EaLG24nYXtD8gs9pigLyciQ7QJip41pPtq4w1lqAs/MR?=
 =?us-ascii?Q?xWm2D4UnAg3olIqLxn7FoAy+AEGr80nx0m7HpHuZrBjvA5tJEHfARsmxjm9E?=
 =?us-ascii?Q?9OCfvQuNlqQcHOCz3mkgClVTkQdk2VeGQeaeRfvI3Rq/ZRZqDI/JkqxRX6yK?=
 =?us-ascii?Q?MonHAbz6oF//AgqG6Xn0TGTLC9JXfwmD6hLutfdZTBqIYijFxVJaf7CyBrdV?=
 =?us-ascii?Q?A+aEH2sOvW3UbUgR2gBnr6s9U9eo+ROuhtpkbD8P3knFz/6DIRI5O0a0byWV?=
 =?us-ascii?Q?6apnFGhdUUON3iq1HKMJU3oXLbIbruNnKmhdQ9SDAG2obblibhxNwAN1LInU?=
 =?us-ascii?Q?gJ/05EJO5cElmScIseeIVUL88DvtiXrpbKbrtK8PcNr+0h++kyBsKE+72205?=
 =?us-ascii?Q?wxYGsCoJqQEH8LSCTL85EyBXh7KYBkALh93MVSZLT2Tjebdp8Ub3AlRURrgG?=
 =?us-ascii?Q?2lsyRvVX+EhzEVrkFmaft3J0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2f91a7-96b7-4445-ee5d-08d8e918ebd6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:47:31.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBV0pehXdrmrHvf166S/cZbS31Bkov1EOad7o0BFZMhcWf84MuJGjHW4fyvfAGfav686Wf/3YJ4BJ86A/NQz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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

Implement is_amdgpu_dmabuf() helper function.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fa4686fe95c4..ad615eec1e8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -120,6 +120,11 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 	return false;
 }
 
+bool is_amdgpu_bo_dmabuf(struct amdgpu_bo *bo)
+{
+	return (bo->tbo.type == ttm_bo_type_sg);
+}
+
 /**
  * amdgpu_bo_placement_from_domain - set buffer's placement
  * @abo: &amdgpu_bo buffer object whose placement is to be set
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 4b9339c3f3eb..3d23ad247b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -274,6 +274,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 int amdgpu_bo_create_dmabuf(struct amdgpu_device *adev,
 			    struct amdgpu_bo_param *bp,
 			    struct amdgpu_bo_dmabuf **dbo_ptr);
+bool is_amdgpu_bo_dmabuf(struct amdgpu_bo *bo);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
