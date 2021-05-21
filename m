Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04321C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF344613D8
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF344613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAAC6E4D4;
	Fri, 21 May 2021 12:46:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5B26E4D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Ddp4OxSYUzjxbGDrpUgpFdMEfmmT7rk8GwzOq1q7Opkn29VcUELLbn9DjXfJeyzLJtXVBluhe3UkdeeVrdy8G229ItY9NQSuIujeFOpX3iSTTL9FB3uY4lKqL1OeeOqHUQBWqJHpbPQMEJc66a3DLqckeav1mcrIGFqiWyfyMWAV/7Wbtd5PVQ8NHJM/Vt9G7n3WAYX7Ma46KzbT67zfpUdazlLewzoyrY6gQ1OAUsbKI0Jw/g3ecDtvl+LOfiXyATQnqBjpqURSZVbvv8wg9CY86vSJbnjGQ+9zytGZTpUuSLKWdbdMWTIYLOgJbaxXAVDGcw47lt387B6dtNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLpWBfJ8J+2GwyQ+/pkWgW8x5AzXQuNDYVETMnvfN4M=;
 b=nNNhWFsD/bDonqALdP1lWF02GVNYdEvbdBjiVLGnu6FgoykNWe4tKQJBUdBW3yUknDQdb3S5SQDInodU2phSv7ugGKTVYAgdEK5iXQljhbcSlYbprTjV8e/imxnj73IaNJve3rlotv4DSmaojXfTh6z75EQ5KXy5P8Y9f3qGaZ8O/LwWiiz3dGz05vzaZK7Iu066ztHG56nBZns6jOiS6P9jgX+VZkZhzBQYiUuQbjCSnIK09RojHqCFJMou1odpKF7ayY05WIQzD+YvD3HO9iZRbFp19Vig8IYfB152Xq4ZDDroUWzZk09bwZ0T9ayyzUBjnr4NBwXikotxv2EaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLpWBfJ8J+2GwyQ+/pkWgW8x5AzXQuNDYVETMnvfN4M=;
 b=yAKDZo0ZoeHvsa/IiNUcLe9QXoLcNrqFkLQVJPqmKh43eEjuRaNzEN959KYJzZuJY6uYUZNrbOngdlieZ5OpF1CSVruf9TdasDsfYZMfSxVTbWd27F2IjFMn/UNL+7SuA6GfxlUS1PxIdj2MfDduoCaCwe/hypOEbIOo0MQsNF4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:59 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:59 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: remove unused code
Date: Fri, 21 May 2021 14:45:32 +0200
Message-Id: <20210521124533.4380-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a2e9151-cfc9-4dc6-8336-08d91c566227
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB513315B07CBA4BD0C1D44CC38B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7YxppHOC56SnXLzKPCQO6pbZUcucTMlhjXU6nwr7RJG7MUtuZyKCYaCg6oRy1cJTa1hCZT7pkf+cFGLqdnfF1SBpeQGtT2zdamCcrygWvFWXFH74NBysRZFysnIaDEEW1qB+VoC4imbft2eJqOWm3LSSpIaAnZ3m54VmvNM1kkHjDA0Dn8+v6J/eO/3t8nSgMjHCkzKeqs2YfRvJqwThhTomm52mu4EXd0UNR4ST1wYIWIYNe5jb3s0fM2kz9AQXbSLnaoXjJ62R3vxKub20jherhGlcqv3XVbELXsz/NP86687AWeEiW/wAuP8Jh/WdHXGe2ZP5krFNaT+JVK4iGUSBtLEuPVabb9Ej4c6Epw09/J9Hsekj1YOFCHXOmjaRsHCXOgkSjfePLrKcfv3o7kh1lVwqOU0iNUkOrUdgfE+nWn3F6e2elzmlEjnh7RPg/hII2SKOjebry9behD3ZDyqW4r2uyj6Y7C3xIQVFhQTtzWFtV9MZY2VIoFxl3N6Ve5w3VW0X3YmFDMNXSCPhqh208g3brtBuLG70WNC+2kvjybajAtaueLuMvSZEfzrDVY4HVdtXSUFX5TimPqdqsVotuoPkTzLz8EPqZmWoFQq/IUCOAMK0g+6h0iXMg8uYBqu8n+c0LdADyi7fe+4Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kmNAm79UFHGt7dafpQVk52qkY68nhZhohwPoILQlDsGHKRmjxR3t08Db/8LU?=
 =?us-ascii?Q?dHf/gn72hpH+E5EjDcAsEAuUejwG7fCLYLiOoWJ40D7rGqpCnTjz3snYQzCA?=
 =?us-ascii?Q?ZI0Gwo26sG8xbEt0Wf9q081kLnpM1EPVeW00K8LrbfZcsLr+mBvo4FjncQvj?=
 =?us-ascii?Q?mok5ZthycDptQEf4uFNrOL3FJidIoFKnKQarRNCE5R9+ZHR++KBJTV4j6hfu?=
 =?us-ascii?Q?xqwZ3wrdpvSDM50VSynSmnQ5qqos8RmW7R0xGW73+KWhkFrcbiFGajeyh6S1?=
 =?us-ascii?Q?1kQAIaoEZHTmzv7HqAGamP+Vm1qfuLlkZVHoeZHCUXe5ilEe/f3D2uQdd1P4?=
 =?us-ascii?Q?Nh7cX3RnYwQgo2GhEhOjKJ0V4737wuT+C8CrTBDBU4umQdoPQUxy7gB0F7xV?=
 =?us-ascii?Q?aUB8RJe//ngptn7XdtMXpBPQ4bI2gSPZTPqBXY8faMqDY6rGmW4QDKlt4luY?=
 =?us-ascii?Q?1mI3jpPSQ7jC89TjtqJxyRNwxA80pwbzHndK+QgC+XRllTxV7/y/ZcoLGclI?=
 =?us-ascii?Q?SV33BajOg4jlpZmp14EZuKPhxeQGwl0i9WFI4NeOOIFySI4sn7fVpRo0abhf?=
 =?us-ascii?Q?3aVwd5F9K4fSUbGBGA9qgxv3q2DMpmxekC9spc3GvnMpUUjAYPFnDk7Jr1rV?=
 =?us-ascii?Q?zT65UNqPfvAc0j351w0JEM9nGETnheBba0NtzwE72vPqdhX4Bp9zl9oedSVj?=
 =?us-ascii?Q?BRD3S2mgS/ppEpykV5zU81ObXYe+7rQCPGGLqMfNzfw7x5k6IlmIRy7h6ykU?=
 =?us-ascii?Q?tNjPLwhi1GGm5foyW3GacG98YmoixpnHq46A8QorBkEiZPqjaivoSLBWqWdZ?=
 =?us-ascii?Q?45wqAFuCtx8TaGQPPgYxeo48+LCNfVjT7Cx15yb1XirovzAFlDc62lkLH68s?=
 =?us-ascii?Q?6HdRfoQY6DmAKhinar7pxEy8jtKQG7Kdtdw/zjC004+/r7i3F6LGVo4nz1Id?=
 =?us-ascii?Q?G+C41MOS8ddoJQZRLRhwhvhAC7inP5iuh/UBMsThzslyNtr+BYXrSqttBnhK?=
 =?us-ascii?Q?BsOgrOFF/gPv9KakNijeGuzu+Lv2EPv5uMqoFv47ufhwr/+Yr8fgl8oQxoM2?=
 =?us-ascii?Q?igCmBn8RyOPKHBfYwZK+zEP2cjBzN+yrfIEA0fizI6msrrjxcQFxAzygUSfn?=
 =?us-ascii?Q?JnGSdL9/VQGVRtztPiZtSQcuUJk0k3d2QmepP4oGPFbM/bRIRCwZWuYm/icH?=
 =?us-ascii?Q?bgOEh8vaJAob0/aZjKL75fPX8/D5csP7FEDDvpSlhPgmOY4vFYmKCrpFDPaL?=
 =?us-ascii?Q?PtHkbs7S/vLEd1wS8FrLBo2X9WARWeKFV1JLQCMsUpG9311tK9XomPpAMUlq?=
 =?us-ascii?Q?3WAyc/0JT+E9hNL7DFKFnaLb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e9151-cfc9-4dc6-8336-08d91c566227
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:59.0631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8njXj2Z7MHXUzOZcbyALutC2LwWeD51vL0ZzX1fa15fy4Sb50S+mCcpyvaJg90IFcJREAgJRWWm0Kxx8f2Oqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 ---
 2 files changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index eb3ce33cbfff..7308048bb7cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -637,36 +637,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
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
-		bo->has_shadow = true;
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
index 3a0e6ca88563..df30dc7effda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -104,7 +104,6 @@ struct amdgpu_bo {
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
 	struct amdgpu_bo		*parent;
-	struct amdgpu_bo                *shadow;
 	bool				has_shadow;
 
 #ifdef CONFIG_MMU_NOTIFIER
@@ -283,9 +282,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
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
