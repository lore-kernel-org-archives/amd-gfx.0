Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76AFC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F5761090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F5761090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E1BF6E4D4;
	Wed, 26 May 2021 13:07:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF42C6E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWd4XzHwKuPs7EqSZbPcGIDkV5Li8jla6/dcN31YAbLcRayPeGadmjy11UC7DY1Jd2Fj0HTax7wwNQq0PaBr0DkzxgBgNfc+01F0TXia7VzkKoc1jIF2B6xKIu/kBgcK0Oa0cM6AX6KwtB49W8UNudHdHi44M3/Z2nBPXUdRubQFZ6J4YVm++a38PAo2QtwDZV1lpqz1avVDGcdrEnFSOGvneb+uJf+RLHtunLm7R0PV3XxFwyZxi+cyn5YDxv3+jbaxpJOENyfHFVwiBE6bl51+E9geHwxtxnGhRWbL/Tsvgv1gjlM1/mt4iAh83G45lQRv+rxj53VQv2aGb2o/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBD5iYUDpzUuG+gP0lBZsfGf+W/lk6tmMlu8KObI+d0=;
 b=FsKz+0QAtZJIkQrQzbkDnApVRE0+A62S/eE+5dh+Bw+foevTl9+bg/aMfroWdwSMUTgjDw6qd3MY6UA9jHKFRX5ZHNJ9eEH1bBU7JKVsNb7CqkJbiqFD4+lJ0dT96V5mEQMmHJ5bIZGx9QCm0tM9BUR8OwEhEd2fKLhLvp0f+lhTvKmA31SKAkApzlftdk4BRJ7ZrSpDSrCwqz82r51aGDfK5hFIf9+92yx71zfFAYw8hPxcokHWKZr/wVIUtDUaQx4A2lYp+ow0a1vzUfFtzs8uMZBBh3Fc9JkB9apFPVDBObUftBzOPUmeGhWOHY3dE5HBGf+zh5V6X/Wyznmwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBD5iYUDpzUuG+gP0lBZsfGf+W/lk6tmMlu8KObI+d0=;
 b=UiJq6yvfN0PJFIDay867OARACo56QKTI1NGbzTzEyH8BZtG0umDV/mVJ8O0oPenUzXfZ155P6XxtZNWkNx/lWk1WvKvrpQc5Ex/5Jbz1NDQJuq7jSaTSdL5PGMmM8CAsgiL+ZzroCAvudgK+wU+z2dAK25ex3wNAP0AjWl13VTs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 13:07:21 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 13:07:20 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/5] drm/amdgpu: remove unused code
Date: Wed, 26 May 2021 15:06:57 +0200
Message-Id: <20210526130658.4237-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130658.4237-1-nirmoy.das@amd.com>
References: <20210526130658.4237-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::35) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 13:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c454c34f-ce13-4adc-9e5a-08d92047323e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51985C49F2DCBD2BFC7902C78B249@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5FXJxOMjHIkye1j+XSUThxsA999MEEBZLIKoM7HCrjnv9EQYqwiw1mrIqarAMvkx8Yr1BSylZeF1XlgL5GVtl0TOluzW7kFEAg6lJrfjgJdQufojqy1ORUE5DVGXnAPvGr9Br322EGMVEVRXPY39rNeU8EN+/ON/QdQZujVwgsR3Ty2mBZgIlWbrF3WjrM6CsGUlHPiWNBuK6O5ImSw7Iqotxp3WdwkHu+vVB5Z6j5g4Z5dh4SSUaYRtsLYi3xMa5ZrIqBHiSPBxNXUrDrzg5k7h/k6NTeqVQ9v8K3oeCT7lCgWqPx8+m3I5YiSrZKa7E31pnXb+S8+cjLBw4MG0Sw/EbD6rCoOa3g57s1iJO+/jo81jUTLBkL9qS11NcV9EXEgvwP80u1F6t9FN3kXBorA/ZfaBLdPQ0+HuHibpEKdCvwmeo8zUw8RIhJqQITn5Gbedf9MOoRw2lQ13a5a/knE5jNgRZeE5Ymo2RnHv5KNbAVZnAKjVD45FUog44F7HDQT1RBG82iEW8qbJZo5Bqq8MPJxT0SlD3YdgNrbZWL5w4FWxjNwjdCLLhlIp+DLVFj4tsl8FWjMDcyAInFnBCLQyGWq8Vs/5IgGxAJv11chRJ9QG56yFJMmI6PE522g1Z7AbCbiam98Ok1ve0q91LVfI64jFgfHD5rBb0cBikY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(6486002)(186003)(16526019)(478600001)(2616005)(956004)(36756003)(83380400001)(66556008)(6916009)(86362001)(44832011)(66946007)(66476007)(6506007)(38350700002)(38100700002)(8676002)(52116002)(8936002)(6512007)(6666004)(2906002)(316002)(1076003)(26005)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NeVGnrp+8nKrWu1pW50PgBdxP3vwAluIk8wFNx0ZdDuKMzxYnApCDG4eSJtT?=
 =?us-ascii?Q?fbP8pk/IY356h6sbf5h38eaWQmqwPHIQocy5GFUYpeGo9ykKJK/3cZSElAri?=
 =?us-ascii?Q?BfYhoq144CtY9li3PoXDafin3SnOYMZIRHh4sY6bQl6aGCB1vT/m+xPhLb7k?=
 =?us-ascii?Q?rVC6kz4eD99sSwUh7/UvHq5xv6PSBbxTZ7u++QT/hrpOEi3vVEZj1LbG77WO?=
 =?us-ascii?Q?h9gAzNisVUDQVQabOBCAM0TwF94X0rXbHtfu0J3cSt0lENtuDvQbDE5cniJq?=
 =?us-ascii?Q?ECcqPWsBNGFXtp6nan5YyXXNj4fivWI0idN7lhLvrZ1LbbRybTDxu2P/reUx?=
 =?us-ascii?Q?OV/boMC7DtX28t+ajLznjbvXryUj0KhREmHshkr8CtghWp64YEWL8eHEOwC3?=
 =?us-ascii?Q?7+lDZiOIBVhVL4fjXDl68wz/GRfqTCeCzbWUHzwsHKmrOdCJ1kZm9Bjd8LZx?=
 =?us-ascii?Q?MfKQ1ovS/Ald+tuEUlMzTa5dYnWGX16E8L3l0rjM0jdj5HyPjZBkY8ED4CeC?=
 =?us-ascii?Q?NsU2iUedlliXds+X8z1fCL2/MCR2+BI+xHtHkz6FX8jPZytABtZyJv2rRR6V?=
 =?us-ascii?Q?jDi3uhpNcz5/Eenv1oB4HfBlCXJUHVfpXBWGzdEgE5qgs0aoBCo7HhxWcpWf?=
 =?us-ascii?Q?jCQx33HqNtaeDNZtBqxglFVuq7GjqFNIhDEnqtJaOgbT4WOyWuE8XFe9986c?=
 =?us-ascii?Q?L+XLpLjfV0w+ISJnPerI0EjSjBDybyTke4Hlps7qghsPXfHY8vfZrzB/8nja?=
 =?us-ascii?Q?gYAqWlGhnPP/jqRggVlI0QUpCyhvDbSNSjXv8Mp+ipfEtJFIj6+I3GulfSLA?=
 =?us-ascii?Q?jpmiNfR/R2807F3XOrR4/+1Y9mtJdR2zeXI1L5L4dAl7vXR9+07AfGF67UAA?=
 =?us-ascii?Q?i4T3mrohP49wd8R4sujPOJe/I/mekIv67vR/V0o4+AEzJWigc3+82BZ03fcu?=
 =?us-ascii?Q?e+JGmi3AcNZyzM0QJvCNUhg76Kcgrm+ojPXsqcdBz0AuOz7vfRP6uH1kjc2Z?=
 =?us-ascii?Q?JaDuKCzrqwmjgbDQVX5CDZYwF95yKJjI/Gnjlzf3rVg9v8GscIbG2UE82yla?=
 =?us-ascii?Q?UL2OTcoUCdtPQfYJU/DAR83obUlzd/0NSTX6jp6W1L0RU5m71nJXi9QNcnk0?=
 =?us-ascii?Q?0aCrgGkotLGcDbPMhXoTFpWCaon8yZVoX9MskbxB5eUH8h4wp5KiU05Xn17F?=
 =?us-ascii?Q?u2X1KCOP/NCEOOBqzNC+TGB6Efcn5XwTg09QHK1czrRJlOpQy6eobf/I3YeV?=
 =?us-ascii?Q?g4QLAIDudutsONPxlTpGyAQHeL6+cUddlRen76j8izds5+Lp19k6729/h2MR?=
 =?us-ascii?Q?rCOsFk+hY42Ou4J7qV+AdZeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c454c34f-ce13-4adc-9e5a-08d92047323e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:07:20.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+vV9ne6JDOXIJ6G8msBMk+/uPd8v1Vw787kO9J4n5Ppk4Bvdvf4BZTjD084i1QiuIa1rNsv9Pe3MRQlalxgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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

Remove unused code related to shadow BO.

v2: removing shadow bo ptr from base class.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 -----
 2 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6870cc297ae6..7930b7d9a3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,35 +638,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }

-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo)
-{
-	struct amdgpu_bo_param bp;
-	int r;
-
-	if (bo->shadow)
-		return 0;
-
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = bo->tbo.base.resv;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
-	if (!r) {
-		bo->shadow->parent = amdgpu_bo_ref(bo);
-		mutex_lock(&adev->shadow_list_lock);
-		list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list);
-		mutex_unlock(&adev->shadow_list_lock);
-	}
-
-	return r;
-}
-
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a7fbf5f7051e..07478f86f05a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -104,9 +104,6 @@ struct amdgpu_bo {
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
 	struct amdgpu_bo		*parent;
-	struct amdgpu_bo		*shadow;
-
-

 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
@@ -284,9 +281,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
