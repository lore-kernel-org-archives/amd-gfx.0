Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46189C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B1323B55
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B1323B55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8846F89E39;
	Tue,  8 Dec 2020 18:59:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB41F89E39
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 18:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z39gvWEgRj8Nk9HLaRWkxzbu8YIcal6EFGjNoajyDzImBLcFFSI6G79mRDi6g7U9wHbczq7/fTGTkW6ZlzjvmesPxrh4IbrNEHOFMP+qQtnJg6QCc32EX0oallCPpq9XMcncvMC/vwXN0Im/kzb+0xLHqOYJm6K9tqRjmcg6m6dRON2e6yJQapvq+AolOfJlHEfA307sAHW1+MsKJ4Ib/dSxjTOcJRh3j+sObtXkMna6lDP7ozRYmx8D4nsCcsXsqnGlDAmN+U22CStjmmA7RIHVpcxFW7IXBe59Ijx8f96xyqjVmLijDg/V6SH0RaTyZEMCFJdfq91ExM/lM6oLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go/1ajKvxzotf0kJuanbXBIy3VrhRLdeYPzvMTtSkFc=;
 b=Msnmv/rnN3FumGYwVRozNZ0x9sbIqMVSQjuisRoqukJ6Th6SjBAk0QqtqXvRYgtBStUC727WJO4bpybc96Izg+BiZ6Yo+6+NucdPx9oSyniakDbQhQAb0KKMZeOwpiLp5YVNyuKLmWsb6Zsqy5cRFkjiN7g10JmfzlmJ0wPA47HnD8PIzi5nQlQ8Jxeck9/hSAb2fHdgl9QccHfYaJyehJDKySWRz4XewL9zXqUeSQgFQjIRoMYX6EUXgYjhelClhbVEuQU3t52g8GXBtkIKf/eNtcS4G+4b1yrBOBjkWK9QBNVlGlcju+fHsqwISHAjGvP1Ecnn4FTyhCqFlAI9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go/1ajKvxzotf0kJuanbXBIy3VrhRLdeYPzvMTtSkFc=;
 b=kt3yYchKXcATTxG4o4ZTofRnQcYMVH7grVNpwwjhO5iKGLudRDE38Ec0LPW5rdZChyPeB196ThX7+Yt/l0zfOjHhcY7XA0tYE7uggHzwL3d2NCL7EdGRKpkOD1BV8qpD+th8ru9DXvKglsy598dYw9D5yaw4FBDwheueVHjqYIo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 18:59:36 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 18:59:36 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdgpu: clean up bo in vce and vcn test
Date: Tue,  8 Dec 2020 19:59:16 +0100
Message-Id: <20201208185916.4569-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
References: <772be2aa-56f0-14d5-3de4-343c556e1dc2@gmail.com>
X-Originating-IP: [217.86.115.138]
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.138) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 18:59:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09e53a1c-7728-402a-6d09-08d89bab6842
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2746E6D1C975D1E7BA4E391C8BCD0@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1zwv3Eo3DlHM5S77is7+xbC37giiVv88gNUg2tx8eaxN3tMpTj09TO1fHnVs6o3TQY9YdwvcqKwjC90lcAsBPsA/y22leUKwzufZYjN23NuI7BW6MRaK++54gsLXjltFE2IK7AfE2lCMMhhJlStE4D8PweoPSrzoUWOGfvJ4qH5s2luBuePUBHXt9/4Jrmyoeyz+KwXPzfkc4BraNMcrzz99Sqm2HlM4U1qGdbXwXzXMxC7bvX6c8Zi71vVHIvJNrFPDS7zWd78GM7Lm8OnlYa+bQivOr+K5PwAacTxqIm/QFAPeUde64yTD/+MZsckFsxbaxWpJyXtvpHaGd/NU1fvZXTPxVzpEPAQ2GTy7dgfZJ2lvbiOzwJqJVygbFmf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(86362001)(6512007)(26005)(6666004)(8676002)(34490700003)(6506007)(66946007)(52116002)(44832011)(956004)(6486002)(4326008)(508600001)(5660300002)(36756003)(66476007)(66556008)(2906002)(1076003)(16526019)(6916009)(186003)(8936002)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DxVuTs+0vbaChwpMQwi/J0VJobCjXblSIA1LUz8AGXXsDBsycDQLOTn9gaQ7?=
 =?us-ascii?Q?39zIqDBIEqWZ/DE50yPJXESfXu9tXqP+v0GM+0QFhu2fxK5IGbqQ821T0hUh?=
 =?us-ascii?Q?FqirCxeEIoGS5N91suK5BMddb1j0gECh5SX2xGVqv/ty2u3yx+4sPRXTLsgJ?=
 =?us-ascii?Q?ys4aIGHMSLBSQpMq1bKm118Bk70W8H5i/5FwpjB8dOajC637QNWnWGvpod/i?=
 =?us-ascii?Q?MwQlQXS0nd461lHcLsEGAkMVbiZO4B6T4QBpitJMU/b2D57bu1PNynfvMfnT?=
 =?us-ascii?Q?3zNZZ1QlDuE3RymLcdar8aeignIxWYgUKUCiSXqJl2qPLl6muK0m0q16IJkF?=
 =?us-ascii?Q?a7kD1wKc7ZTn/pIU/J6FadUSgDp6Yqxn+likgtF+nQ4lT48b57PN7m8yJZth?=
 =?us-ascii?Q?J22Wt9VJQx7wjOrqZMy2cDl1JgPJnHRXAEg+WcBBYG1BPWgBn74+eQZlCwnL?=
 =?us-ascii?Q?+PohPOV4SNRLD+avnYbo+CleO7TAd5S2gT6N+aMF1BCgrzVgSLEgxjzp7TGk?=
 =?us-ascii?Q?fgBOhzZoZ86mxBd4YqUzHqduFuuRa7Wu4/cU7Y6f6HSqG3X4Eji4iH7QHyZ3?=
 =?us-ascii?Q?/pM6bMSiaPouy0WjSoSmeAb/oseAKoSKA6sA4q2B3IuUjsDqmh7GqqG2XnJF?=
 =?us-ascii?Q?iU7q2wwx/Sc95DJ55beOlK18GEOpnOiIU7xBx2QLc9x4TXp0hb25o9plygpF?=
 =?us-ascii?Q?n90Bw3DmfQjBWjJZeTsSAg0OXRiImMWIQwt+1huKqiXqQNmF1uZn8NQxOxYL?=
 =?us-ascii?Q?oP/iQZ11PHDDOLi6cyst4ApTnHXMQT2gEZhugMwG97uDSDCHqmuF8Lfou+yo?=
 =?us-ascii?Q?lYrvfywV6k+XM5E5YBWFgYRdXtB38gA0WqdovQ04obW3++Lf52tFZjE1YfLw?=
 =?us-ascii?Q?pzQUh0MjuyG95Q/oeq7ZheD0OLyrEBrm7Z1Cdz/OoO/oufxgBvpjc9emn/fm?=
 =?us-ascii?Q?GzpkrM240FL0vaG7RDMYFrGD4UEJ3k3CXfiAR3N0kH6bb9YhLzeARuOWsy3Y?=
 =?us-ascii?Q?KKf5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 18:59:36.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e53a1c-7728-402a-6d09-08d89bab6842
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LodscofCLS9Am20xPLA4izXQr0dkUUDWse+7UAS9ehrZwb/2H7/NLhPN1SHiRHwt+dSiEz4UrrLF8sCn58uaiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

BO created with amdgpu_bo_create_reserved() wasn't clean
properly before, which causes:

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index 7e19a6656715..921b81054c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -465,6 +465,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr;
+	void *msg = NULL;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(adev, 64,
@@ -474,6 +475,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 	ib = &job->ibs[0];
 	addr = amdgpu_bo_gpu_offset(bo);
+	msg = amdgpu_bo_kptr(bo);
 	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
 	ib->ptr[1] = addr;
 	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
@@ -492,7 +494,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 	amdgpu_bo_fence(bo, f, false);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -505,7 +507,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 err:
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
 	return r;
 }
 
@@ -761,6 +763,7 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	dma_fence_put(fence);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_bo_free_kernel(&bo, NULL, NULL);
+
 	return r;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
