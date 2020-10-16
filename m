Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A82BC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 10:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB151207F7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 10:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ED92/pqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB151207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AD06EB9B;
	Fri, 16 Oct 2020 10:55:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C11E6EB9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 10:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpTi5jxchn318cBZI1CslZzas6OVlTo4XWKLrxPg4fA0gn9In5WHi/RQOgvU0N7JWZB9GoqyrPS9XmLDfsqNtbDHn9ABRQ2VMneAFogrepVCH2/CojPrFpjeGpY9EKNm18LmOwxLaqyMLhEwfZTdqOFYKm7ZfYCqP2DAd9oGzKGWPd37/0PBhb2jmjMFxtZGXVMNNtur234beEVP0vRykT2p5BKUTZckNOMfOgOFgZjT3OS/GUqR2oOc6tFC4CuFRFaSEruJTH7r1LuzjOKvsv1i+0ZjpDoXEe+Bk2zzKpR9e3fItAU8yLmk4/jSVITMsAkGYMJ9sZTQ/Dld3u1WFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7phFYTwt0q+GpnZnk23WtH1CbTl+p1eKyHhME/mkw4=;
 b=ZeuxxjP40YUhGcCpXMtZQJ5OAc3WNVLpsLFdulRBnkJf1i/mnURCNe2UOarlWrgT/+0+1vhrx/pEaXrGsgTE5CkDDRAFNbPHDOhR1VDRX+Vyy/Siz1HsaqoYaslmxgkyJfE2DScQSzCEJB1qK/JEuYLNtZq6ubl3T2DzHNBAF4LMfeqwgsqhFy/uOukOAU/4KpaLdcOMScSiFXJF7VBMMof31UOe3i+MSm07uzXMBMJ5+r8Lu7ShI4bIx8tcFRtf6WNL4VgAv7taVxuIyT3h52JUIoLVIiBYQvNoBOQAqmz27VrMH1QlREc8OoENw0ZmC475LMQQZy/Gw+RVFfA2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7phFYTwt0q+GpnZnk23WtH1CbTl+p1eKyHhME/mkw4=;
 b=ED92/pqdx7RMD1C+UBkbxqpvhLzrPBcsEUpNqlf/SMgq+7f7BCLbmVgkedSfIO5lLGtQJZlGTcygKCU+TOZrgKuZ/KqStlQxORTAOrVuVydtDmoOzgpCGUprbdxT30n9QcSqliU/7TrW0RjtAtbMcvx+ODa92O/7ZeNSrZsSdJs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Fri, 16 Oct
 2020 10:55:51 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::dc3:ca03:7b23:5a44]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::dc3:ca03:7b23:5a44%7]) with mapi id 15.20.3477.025; Fri, 16 Oct 2020
 10:55:51 +0000
From: Mihir Patel <mihir.patel@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add a list in VM for BOs in the done state
Date: Fri, 16 Oct 2020 16:25:11 +0530
Message-Id: <20201016105511.3670-1-mihir.patel@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [183.83.139.166]
X-ClientProxiedBy: MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::34) To DM6PR12MB4452.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihirp-navi14.amd.com (183.83.139.166) by
 MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Fri, 16 Oct 2020 10:55:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed555ac1-c610-4272-6acf-08d871c20bc0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31640DFCCB8CB62CAA9C0AAAE8030@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxx8U8WHQVtYGbE8BpwTmPlLbNRCf+E5HaQXlZ1ZWoHYHGztlqmKEUQrUZuxXUrtoLbo97rC41nm/fM5/tfhRZk1KHOqqutiY7/Gr/uD7qZ95OYUlIpjgzSaaan/Tx0zUJVDFMVrI+af+VtV8bcl26CNzwzjmGYwz+PKREhFXuQpMCYgON1/KYTmoRORfnC9+NqbNH2CenPEHu87Tbi+3QR1HDh4CnF2j6bnAKgDgAfMVPPGdzrtnbBwvVtQEc3UidtZfvZgME7onYOADOWVdcSt4/KTvCtHRXijYkyUoSoLTNAuuIyTJlsFpLHKDYt0XLcOMfCKySJxBvXV0fHTiuOq+bRXMYJiAzkSPsrCqrm2KGk4HeHpKsG0QXZnH2ua
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(186003)(66946007)(956004)(1076003)(44832011)(7696005)(6916009)(66556008)(2616005)(34490700002)(52116002)(6486002)(83380400001)(16526019)(66476007)(86362001)(478600001)(36756003)(4326008)(2906002)(6666004)(8676002)(316002)(8936002)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tiOhwnqePgvrRuvpvLhDfDQoEbjF4+1hORsV60fAyTp0ch7pMAywVhhleM2WS0XZcX5lHHEO97694iU+vOALfxgufkuBJSjVhIEpuunvwUfzqjigmWMGSi4gF3zARiHXzqdl7vlhdcVkcDaWFdraJFRsP4LmglNPtSMGkqbUBP0QI3xnV7770/EisX72m/nI+BwI2f4R+OR+rtmZWEJkOOwQdOzabbUBcgJyNYgXfUMCKNgzSGttCtbZdgru8jP3Fhrm+xPxQAa9b4ecOVMG7PQ5fWN9+ZQdry5CSqeVmSv5+rxBKKks1WOD3uxOb2vBMuEd8Xeqqgu/zSLDL14zLB+Cc4rtpNGvnT+EnFGCKp4A11PuMPAV0KMuNxC/4Wjczp+/MOc5YJ4oQ/e8AdbFT0bQo6jdkL5WzyNcuwYue9TOy1+BAbCnoH2wTuewBLwlUajQToOnV3WQUwtrA7cctCrGOGE8+z2rvCvvd7Yg1EedOFYRZ0sp4DgQul9zx/6BLcos937oNLCUI1EXn2Kv6sYdBRO5md4Cn79g5UgyluyXWh/mVmYpOQhkTwO6cE/mV0hYH1k1TkFQJyvFr+r+eWIuvdOPTY5/Rs3QqnSZtN9opum7Eak88qfq3VY0CdUGxv2yPQIVDc60Ruwy17GSmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed555ac1-c610-4272-6acf-08d871c20bc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 10:55:50.9909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNUUbDRXJCEQTHspE4PZw2CexsPksRfRqFab6tbmHYg6nHtpLNe8UxHSDNgMGGd30BXM34g7avFrS3v9j9ZsyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Mihir Bhogilal Patel <Mihir.Patel@amd.com>, alexander.deucher@amd.com,
 ksurampa@amd.com, Madhav.Chauhan@amd.com, pkamliya@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mihir Bhogilal Patel <Mihir.Patel@amd.com>

Add a new list in VM for done state i.e. BOs which are
invalidated and updated in PTEs.

Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 19 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 122814c3ff5f..c08b76f4042a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -300,7 +300,7 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
 	spin_lock(&vm_bo->vm->invalidated_lock);
-	list_del_init(&vm_bo->vm_status);
+	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
 	spin_unlock(&vm_bo->vm->invalidated_lock);
 }
 
@@ -2823,7 +2823,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->invalidated);
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
-
+	INIT_LIST_HEAD(&vm->done);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -3410,11 +3410,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	u64 total_relocated = 0;
 	u64 total_moved = 0;
 	u64 total_invalidated = 0;
+	u64 total_done = 0;
 	unsigned int total_idle_objs = 0;
 	unsigned int total_evicted_objs = 0;
 	unsigned int total_relocated_objs = 0;
 	unsigned int total_moved_objs = 0;
 	unsigned int total_invalidated_objs = 0;
+	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
 	seq_puts(m, "\tIdle BOs:\n");
@@ -3460,8 +3462,17 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->invalidated_lock);
 	total_invalidated_objs = id;
+	id = 0;
+
+	seq_puts(m, "\tDone BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	spin_unlock(&vm->invalidated_lock);
+	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
 		   total_idle_objs);
@@ -3473,5 +3484,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 		   total_moved_objs);
 	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
 		   total_invalidated_objs);
+	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
+		   total_done_objs);
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 74cc14179c41..ffea3b89b9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -274,6 +274,9 @@ struct amdgpu_vm {
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
 
+	/* BOs which are invalidated, has been updated in the PTs */
+	struct list_head        done;
+
 	/* contains the page directory */
 	struct amdgpu_vm_pt     root;
 	struct dma_fence	*last_update;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
