Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E8C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EFF613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EFF613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A4E6EA75;
	Thu, 22 Apr 2021 12:36:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745CE6E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQxc7webu8UETwUPCg9SQN9eZr3tgRs9j5iJP98gxUAXhY0rlHexVO7+1T7CpOJLy7D+Bxt9ax2hGD8nwGrVEnqePN6n78hnUoG6aAHtXD/quK7K42WMpcsPJmuCsekMcrSDbM9L0ka9CxteMg1kWLPrx3SXZ7+lDQPTEEjfRvKsr4XtBABZ3+3y5cwdRnZossRRjYCk8Ra7IWb3V5Bt6a8oFljcaxQSneajDnCntnQRnlYFaV+nW9nmiRMK5/+1ibO8bdREMuVvGJgVZH2ectD5ibtBam3WNxb8US1tZnEkdRh/fixsXIJNsQOHj715Ub7FlbbBJQBqLi2GFQ7G9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CoqUZsLbqwDrch9NGsxfLTdCvXM52vCqdYNr7sayVw=;
 b=LVd5TSiHrL7902exyYnbpZ5sZomLNdWrR9CcfkIzNe1ivT/NX5Dd5CGgiwFbKMjMzvtN8rfpqjMJG97cas/5YkMDArfEj7yQyIXWAEKApoLdme85mEFoC1etxComlrOqE8BtbigkELYVnwAD9jEbrpJCxf1w/gRRtThVEmgJuZIVq6QuAOGowU0kYxmIl1/DdIiHr0e1p6mjH94ckXEBRqg4AWRSgMH7kZ6Xusil+8mOD4pYbk7JL28cR2r6AUs8GUxKKgVK6yHP/jZ7KIIgzsuPICSGqdS9q6LtqoO7KItyP0pSjTogLJKK6CnQFy1u3BH061KU1M/NciHdvab3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CoqUZsLbqwDrch9NGsxfLTdCvXM52vCqdYNr7sayVw=;
 b=lk5oQkBkO6mzZXCUO4j6IuVUbW0Ec4vza5+8t6qF6IFTRGHmFjaBk4RjyUDEVkljkyuEEOOGG1JArqBkLwO3Ld10SPXuyPAN9pCuMjBFqDsOBZvN2/l5u+HphjXc8kEegpRMgROgP/DxOyKG7w75Z3YZCbyQudFm+91vsaP7yHw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 12:36:15 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 12:36:15 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/5] drm/amdgpu: initialize vm->is_compute_context properly
Date: Thu, 22 Apr 2021 14:35:42 +0200
Message-Id: <20210422123545.2389-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422123545.2389-1-nirmoy.das@amd.com>
References: <20210422123545.2389-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 12:36:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d6cfcd-c3c3-41d1-c11e-08d9058b380a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0231735D5A4C45E1E720E90B8B469@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQEPmyf7yHts0l5tNUi3CmmfhZrxYchpUWVYgKXfzhRvJ0vmP+aPXFjKQPkUSIOxz5n7PqXHc5xoCq1SrwoF8RXCpDEJO3rjpApR0jr76YcRz4y4K/lqw6V8HlWbV65yzxv5SrcXPN4UDi1QzQUJCMTEWR9Svbj2BdOAY0s+aka7oF9yEuIzED3AnMsXau9Wwgsp2TnMAdzMP14QxkMjpPW5zf3RnXoPV587maTpgVA5hRHtdZMJDtY0oX//FVZM9fiqipdEqSoL4d5Uz/eQuhEnJzdlARomjaVW3Q8KHQv9AJoExjSh0iBFSRKUxRFqqbCetFnykvyWtAH6aEJqHgLBfjRl5oE7JaC9EGKuV/7MWFPXVkxc9VmuTvK08rXTgh799kW6xmjqKpoew3rh/FTz9tQ2VeYeDJhpeUyL2LLrtXaiGduYZLQDk0uINdaJrMhgsif/ENYn6aX7FmEkp26NWRMv0OhjhpbbFC/JH4tSrf8a20bUYuzRqgUnn8LZrtAlrzUpg/gylcEbXx3ZXuoJIqlXuLZO+GnmfGV7gbfzRvZx+t6tw4NZsJP/vaGvG+MusR/6kTVrOK58l7GBw0qvzawrke7oO3mz/iU4XA3uDWzAjGDj/QScfChjqGTvoGg+0nkMRAs4H1UnkKppffoaLDRFFpypGI28LyUFHpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(52116002)(2906002)(26005)(38100700002)(44832011)(37006003)(1076003)(16526019)(38350700002)(36756003)(6506007)(6666004)(6512007)(8676002)(956004)(5660300002)(83380400001)(186003)(2616005)(6486002)(4326008)(6636002)(34206002)(86362001)(66946007)(316002)(66556008)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eKGFcv0qVE+DXXhxXPm3aTehJTZ2WrKfEsYvP4SX9VgxW7sK2WLFVh5Qe+UB?=
 =?us-ascii?Q?ceAv1uu4lX3IaN/Dta1qneKb/N35irGrfujK1ahB5MtHb7d0J4+YNbjbSp4H?=
 =?us-ascii?Q?CO5kajcQ2PND6j7mThExQoq8N9RDrS4aLeEjh/n3bPBmbwEQEAVlixnsREXG?=
 =?us-ascii?Q?DyXsPlKPyBOzo2ypdVfCpHy/hEvNcl7VIxgeZQy/OMj9pKTDK5Pq6aPkZozv?=
 =?us-ascii?Q?V6kf9LfKBSBExxH3I9ppVle+IodY2AoHp13PiASNwkPGUEdvU6o6d9Q4S9p6?=
 =?us-ascii?Q?g8p6byt4Vjj7RAfzXCV06FjqLQWaAmhrNg1nIcbgljAZA/bX3YyYxtk7nAWH?=
 =?us-ascii?Q?AgjZtRQTljAPm6ebTI1f8f2PxOUkLU6XgmGIsDeOXwqKm/2qcZ7L01PrMgtk?=
 =?us-ascii?Q?BvLu49d1sxE9d1pbX7CyF897UZiPkZuvUe7O5sW9CixxwcHdVxXeMi3owltJ?=
 =?us-ascii?Q?HFfdPJDLDIdA3pf3gVDNL3nlfbYPNjvsZRQlChR4qNK/hil6cQ3G4s+0EX6c?=
 =?us-ascii?Q?UjejSXVIIwoF+0BSQ4ryGi6YtpWEPiaXBxWOqIO9yItUzG+IVCiWlibLeoB5?=
 =?us-ascii?Q?AZ6i8ispcAPug+krECvhPIeKtiUwDxyMktfQsDT9I6b+/VQzTVcJKjQbDYZk?=
 =?us-ascii?Q?LaCxhg7bUtQPnYLNCDJyEVUrwfZWtDd8YQYHrP/5/x9MAqYTEXXPnsVglAUL?=
 =?us-ascii?Q?RXQyjw74BoLDl5Ye674MuXQp/0nWK+6U1E9rtM6zlaUZ2L6aUE9xq+5e6Rm1?=
 =?us-ascii?Q?44nyEuNtHjjGTDuzPwPIi9Pgj7fG9ayNDnjpYhYo52HK7t5pJDqJ/Ah5FRT8?=
 =?us-ascii?Q?arDXd14P+ub2+ACvAkHmo/xh+tn8CfdKqozISIuwYQemOTe8ywlgqn5cya8g?=
 =?us-ascii?Q?jqgpugvFXPCiDKMttyEVqFYnyjA7Hdd0qVBrct3LKwX5Kz142adJs44EYnmY?=
 =?us-ascii?Q?AYufmzSH7cMLUrpvkoQ0oV6f5zASuLV9RaSj7IA7pAFMRXr5Fmc0RkacmPTQ?=
 =?us-ascii?Q?xREh7Yh4XMaPe1ezW2Zo9ifdZ6hvB+9gF8MBvKoZqulRDhFEr3cpoJyVArcp?=
 =?us-ascii?Q?6XVGQkQcf2Ms0AUWpb++pnBDVnWx99K3yZtidWE1jCsoakGP9V9qtoK1nvyb?=
 =?us-ascii?Q?4vgxJ1ziMLxlZkS37z+1xjKvQFkPehy40csw29OhvhJ143oPfEEO0pSdpHR6?=
 =?us-ascii?Q?XOqmSYLiKN1IEsDP/gs7r158t8A6l3BxPPkU8Y0wIpV0wFjK78SqAqUtMk86?=
 =?us-ascii?Q?h1k/IqF3QskrFe4qZc2GlOPeFkKsIGOzM+MT0uIZnQnMcPzkxKA98BTYRFT8?=
 =?us-ascii?Q?IsJvAl3doxwlWk7B2ZFj2ZpJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6cfcd-c3c3-41d1-c11e-08d9058b380a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:36:15.1686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aor9avUALCslDnejVlBZSHXiqioAJie7Z1bZZV9amRUnQ4kMyN8/wyt8QpVpukkNiJAhEd3IDfm0tk4kzjh8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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

Fix vm->is_compute_context initialization in amdgpu_vm_init().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..6f0a6011cb3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2815,9 +2815,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free_immediate;
 
 	vm->pte_support_ats = false;
-	vm->is_compute_context = false;
+	vm->is_compute_context = vm_context == AMDGPU_VM_CONTEXT_COMPUTE;
 
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
+	if (vm->is_compute_context) {
 		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
 
@@ -2844,7 +2844,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->evicting = false;
 
 	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
+	if (vm->is_compute_context)
 		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
 	r = amdgpu_bo_create(adev, &bp, &root);
 	if (r)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
