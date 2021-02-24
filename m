Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D2C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C1564EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C1564EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B6F6EB80;
	Wed, 24 Feb 2021 22:21:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6F26EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmncREtlBQ3wSYSNoPmYNvz+QcGKnHPevakELWi9JqkrTeREVNOUW84QUgbEhR5BIMqkiPJ0aSWz/C/h21vXr+Y4xMQSUFwY4HD+6ubduWqUorjkv6V1mKM9PzzGK14hBbsKNfdFl1TSG+9ttW/kfVWEL43NgT35hGXKD9w7C9Etb3PhTfwgowjYSKSqnw5/PsOMptFAeXmWUKnoR5SMATbh58ThA8lnrpjMXP08WfmUPzLpkSMUyZUy8iFaQ7gkFjWj/5IGokblCQ9MpjIC0SnqJ0dFA1PA3V2qDbVPeAZf24viuV8eZDHPOyUMuR26btwdXhAzsLI5QrW3uviyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg/zDtrxGjH2BS3EaF3OwGkklcz20Mny/jFQyNnP7/c=;
 b=by9o/Ccx5FhMiCTU/ae/kc5tKhSFssHgIrRcJDLBo6+uSW9bGmIj4elNWH5K4FeozxJ7Lflws23CTC3CyzDSiulQ2tvF0AuEBMGUyO+nFyw3M+cvyB1yA3PO4d6wJOxRxJfEa6VYU+7EwuewMtSV/KPVSmJIVL+MnNuOvl0hwrqXe8Z2/LNDradZFlhGQmFMrUaeaTFAHH7O9aDRnN0OrYu6RBGzRcncsEeGDDZ54rJnfW0xH9puZj//h2T/PyXZHy5Bx9IXJVmq0kmVtPLahGW2vuJcLvvCxIDiPk9IzgE9MmyvhqOo51fqeB6qay82vnxgag51UHW4Wz5KSD7VRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg/zDtrxGjH2BS3EaF3OwGkklcz20Mny/jFQyNnP7/c=;
 b=pBnEF81PGs8qgtTkYuW3K9/5dLfDr49YbC+YfLwQOFw/FV32MoGYSF+ViOHqX5XoGPcNf8HZ14r6HIwgiLJp9ryWJ3KOZSeCkeE9A2Dn9k7v+FKMsDQ4O5h5XFA0Qa/l11BbH5+eK5oPPQE13o0OmX1GozyCys1uNvvzYMzVtMI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:54 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 126/159] drm/amdgpu: Don't reserve vram as WC for A+A
Date: Wed, 24 Feb 2021 17:18:26 -0500
Message-Id: <20210224221859.3068810-119-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ab7a94a-3446-4d46-eab5-08d8d912703f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503E089CD8FD3BBF1A8D462F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUApNJUXP1cvPR/7CqNXeE2yjC8TjxuEBO1HC2jEl5dNzRZwl7WtWj5hA9nms1jLweotHyTESWWsDC+e/QMNFJfZ3Sqk/oaAapzIpPMRsfm2jEG7bfwx0qQc4P+z0AO+I1ACnt/atAK/yCfCiuSfCc/BjemzYBphLVEULpGyD/aLqSP6fS4CH5OOiMYSCEIagf825n2/R0RlItM+dZ9IUk7gfeAF5m7I0Ub8K36YG5vb5j0hDdQ+/kJBz7CGeY0+XdhOTUCmMA6WZcpunUxFum5b5OHjyYpmUYOiyGESOg0bHMYWWK2J190FL9Bb3+Clz2uUGVCNhjnTAg1Qrnj0HslHxz85ei7sHmf0LVYCzdrcbrJQzJm7EBD/PeXDOIO3MhVuRUN12CSs96TJyxYmt7oku51DuQFb+7S1JiDraRg68AtIHmUzpXYdFsYRgKdwUZsBGGSe7BSzfkzCM9qdZP9C8wZhiApvCOQ6L5LQ5AcP0cF5vxIrBbfbiU4wws9/bKmBaa2JE8M56ub84/y2rB5xxEEXWtQ8c5nSls+iIe1dO+xdAZzvCsPAzKZZhwJB7bVNh+t2npmarwVC+St+iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z+X7DKZAuYA82tNiZtdRIB62z9znPdB0NlEGhIjnHJ2VcABCWNWVII54OC4s?=
 =?us-ascii?Q?MngfhEbJbAQgca93vKWSYuySVADqtKzdjrXKU3jkX9bJKW4WFqq8iPTeUGcC?=
 =?us-ascii?Q?LnGSwzecUNf771MAoIms8n1+W1hF0jGlNGzGzACqQR2tfIxQ6Qj7VjCr1YgG?=
 =?us-ascii?Q?Tx1GsYg1uuefAJbSitLkGVOsSCx1UvDi09gSbZULpp9MVioBOZvR9a7ToqQL?=
 =?us-ascii?Q?vtqY55li6YuXIZxTjG7gk+MnuDRCvniYJ2R8laUapZgPR1q1FRlPcRafyinZ?=
 =?us-ascii?Q?HgkDrbcFkHW1HO6iDWsZhGMkx5llwvdgauUr77hFPBXsF74aNNQQrGo9s4Ld?=
 =?us-ascii?Q?pzVdFvyJ+fJWCGp+I9dBGZgWKsXRHTKazWZHouBwsncklwsg7Fb+YcvVUXoX?=
 =?us-ascii?Q?cPzCx4Lqqt1sIDFMi8aiXIEnQQ2tDDhXxYp2qiKUqdOi/pkHZZ5PYlX53TEM?=
 =?us-ascii?Q?zkqiuAL3ONXTb6CC8+ro+P2frym65n69ZzRK6doBjijDEh0Oy0g3dbTD+qvF?=
 =?us-ascii?Q?xrtjTcB5IdKPLeOuksFnEg5vglx2obmvvkxNn3tOjWpzx3dVC3mvf9ETONrW?=
 =?us-ascii?Q?hKPdMaRy2bxhu3mdSykXW3i92u50MtoM9zNjjEMxblZaykP1jne7PfEFqo62?=
 =?us-ascii?Q?dCibgfvzD+wEEHtHsCvXb5ztiwZv5cNTYTarw2+npQwUEtm8x+pbQjA6yz7J?=
 =?us-ascii?Q?rVpxzz7cQyU0HugHyG4AJvX8WCgGI3kBVN8R13m7Q/yIn2mPaVNLifB2M+/A?=
 =?us-ascii?Q?njnlwhlxj6dhK+hxEQIvZ65HOgo9DlqrXWTvI53OrQ838+N5q+bGbjVLdQOM?=
 =?us-ascii?Q?H8Jm9CYpPVnkgDAaHBbn61vz2vMXS95OmCRCqV88RJbsj96u/Mu9emIOq4NS?=
 =?us-ascii?Q?amEP2i1vB78+fkHmXRctKJtcHCOMRdoF85FkYDiZRDzZf+Sap4UyJC9ktueX?=
 =?us-ascii?Q?S8Rd9EyeyHAQBdKcQ2n+gZ1sjSyoDfV+v0YTQmRWuqVztyTi2E/qu5RBSI9B?=
 =?us-ascii?Q?pCsyvRFOR5Of/fKTvIJqd81/sYPgvS7fHe/ZZxELNHDpP/DUo/ySW/rJlQVw?=
 =?us-ascii?Q?ISUyTT63u3PWPVqMKz+k+JcAfDQkW/VQkEynx9WKqhDrR6CAJKBBiE/N7c5K?=
 =?us-ascii?Q?XUan4RKifFF7ws8j0VzxX7yGsnEsOTkKRhNjaZKxbczp+qD20z8yoATsIzlI?=
 =?us-ascii?Q?Dbui0jnJ6p+aSA38ZG8gZf8hb1Hh1KS/spDhjPqPSVJRj9Hh2ThlpXT1yVmT?=
 =?us-ascii?Q?tJDcRJuKIiedx2jkbfTb9CHcxLsVqpngw2mtM0vzoXB5W7Yus2+A+xoitIXa?=
 =?us-ascii?Q?Nej9W5wLzM60e+3GRGwz4rJA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab7a94a-3446-4d46-eab5-08d8d912703f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:49.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1B+4LnSf7NLRHaVmDuGvR5DUVNpB3oLnNhMH7wVFPCeFKPsEO4Oeogd159T8uyTBHeQrpYBiqlHgs8wigYZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

On A+A platform, vram can be mapped as WB. Not necessarily
to always map vram as WC on such platform.

Calling function arch_io_reserve_memtype_wc will mark the
whole vram region as WC. So don't call it for A+A platform.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c02e28c0683d..8353afb62ed4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1086,13 +1086,17 @@ static const char *amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
-	/* reserve PAT memory space to WC for VRAM */
-	arch_io_reserve_memtype_wc(adev->gmc.aper_base,
-				   adev->gmc.aper_size);
+	/* On A+A platform, VRAM can be mapped as WB */
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		/* reserve PAT memory space to WC for VRAM */
+		arch_io_reserve_memtype_wc(adev->gmc.aper_base,
+				adev->gmc.aper_size);
+
+		/* Add an MTRR for the VRAM */
+		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
+				adev->gmc.aper_size);
+	}
 
-	/* Add an MTRR for the VRAM */
-	adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
-					      adev->gmc.aper_size);
 	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		 adev->gmc.mc_vram_size >> 20,
 		 (unsigned long long)adev->gmc.aper_size >> 20);
@@ -1110,8 +1114,10 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 void amdgpu_bo_fini(struct amdgpu_device *adev)
 {
 	amdgpu_ttm_fini(adev);
-	arch_phys_wc_del(adev->gmc.vram_mtrr);
-	arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		arch_phys_wc_del(adev->gmc.vram_mtrr);
+		arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
+	}
 }
 
 /**
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
