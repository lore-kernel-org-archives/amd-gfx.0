Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E0C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5487C613C9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5487C613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4789D6EB75;
	Fri, 23 Apr 2021 11:18:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0006EB74
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KudMx+s8hGmOyfYZh2AwKwMFvxd2hl90QFi+GcB+qid+V/FDCHKXhFzvjymMhAGlWD/eXsub460V04dKtXs30jaFIk13F7Qf6syWr3AhLqUggioo9ICaZe3GRvj99Rw8O5xxn1QS+4Zl6BbIVUdbfjk2e+xIAOn3jUtI9wGXiIb9821ZyJLJkrMOrvY+zMzeIBKr+9t4RAKWHBTq9ffNNLOQk/mr9jlZwXoNxV70cqqiGG0iKhPoFzN7yGgLu5r//vQ/+qf9FXieg2CB1+90+Vb/jNCnuGEYQNbZsHSDrIr1rgiNfosdTac2W8YU/pPRDfXniGFV2m3W4GU0b7R1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX9QM7iWY77AtHqUovWQ1+nSDUc7hMDMaBbMceoMmPA=;
 b=PSJ4dfdfR1SgzVfzmBzsHpd3wWLIgi10cXzEbkdseCjfobfEon98pUkega4f+fpJULANQOJ1H2iF4uS/NYIQ+SUuo0Wfg7XLxphqNt5YutbZXqESOmVrslbfp/SIbirkFJpiMpqSKlEd2Lvvy9q66udYtRMX0WCVBxP7IC8cq5ov345yfCJxT4bY/1YPXtqlXyNF9Vpj21NXfEfL00BSOFmcAThDOWQ0S/m82rUmmZxbwWDbgqg6cvtY0awd5ojkbkeGuMckNK9K8F0Ipp2XzIZBcBcKhu2EYwat/RJ4q2tx8hiYNvjOSk0iBwNjocP3+ZHvlk9+9y8rbSKRO+D+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX9QM7iWY77AtHqUovWQ1+nSDUc7hMDMaBbMceoMmPA=;
 b=pzjObPJ6t4HMp+LUMGetLQKAKrIQIBtI3cIrklzd05GRiat0pydVO/sB639McNPgtz8lq4wZA4cVEel4tWBxSp7TcYt9X4gmGYSXD4EdQHtB7vH3drUa9oodfA+Qyzk15xstr4zJWoxPBmInF7rJpvs+e8tG7lw3M0YthRq5Q18=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:18:01 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:18:01 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/6] drm/amdgpu: cleanup amdgpu_vm_init()
Date: Fri, 23 Apr 2021 13:17:26 +0200
Message-Id: <20210423111730.2345-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:17:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f35bb499-e5c2-4995-769d-08d9064974b7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14620E5D9C0AEC7B2150B4878B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2DZGOIIZoM2VvGJXZxBOT/BljCBMVDKsu5IAbEYOF+cfGRIlmX3S8r4RubD6sSH9QIauGXE2bmGKaAE+qS6irsX4tHihX5NSrVnDcrz/lJZgnbFHbjEu8w2CoFjE/BiVeHTiRTdqf4SAO85KqIptly3g+wHzrYqiW70HCXthAgim1YtYMjDegkN5Z5YJJ0qEygWRQl9+f8ef8M8qDHoAZknV32EUfELu9yaLCPxrDVlr9gsWfo9NfdFov2YLHsn3cz5EUpaaMqxrMUVPC6AVFT5kjmX7sxzMGSYdfU4zjIqtuEsovyPo+qj58/WSiyk4CWlksG1dSEBqLKhwIqVUy/D+rqsJvN7SUjp8Fm9RQO0Tiytev0O2ips/3DHus5PjfcSfkLKFW3iN5pPXyhMAm6G5zst4LFF/D9isOCtw77OM/xD/N81AYqmkv+K7u10Efq2k8VHR2PlSCjl/JABrH9l7aaDxq2clDT3XhAjWWeRTvN86I647sQJ+m9LAF7OKraXywFu9TE2BfN2XuKZ6Z/QoDazbMJJMbXTWDckSpvs2VwNF5GkxlhSckgcimRiwje3IaLY+580eekBc6K9ZT5wwjayGC94e86D0KaxEu8lUG1s9x0SlR5+UxvIzazqQ41w0TDIby/b/bKzKfy4pXSnn5xm+q7cdIX/mcyvUkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(54906003)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5dizLgUan0Hvz6TFIeZC09rpnasn870S4rcT4+35J7HqXzS6GD5hznoQJj9S?=
 =?us-ascii?Q?+e569CTSBmLK0Gbv8Hn2VIAdoojPG9sGhpELEKIgdxvOKnAZKmT8G54eL3Jf?=
 =?us-ascii?Q?7fI+QunmuedcD5bIukhXvSAu/9obzqC6GU77XtGyrzJSxrW5NdY63cc/DLHG?=
 =?us-ascii?Q?AOXi9jjugzgjhBbdehug54vJLSyRMCQ4Sh3OiT+W1ZpCQduXasdj+IqgVbMJ?=
 =?us-ascii?Q?vol/9dWjXoK24cDm2A4fcpnruxnVu6E1WdJry6Xyy3Y5vYpM9hZb/WceHj2m?=
 =?us-ascii?Q?BRI5yPLgwZRSKMdcwxTlZco4xFQiWq2z8eOsRtO8Ob+17m7lCB886aleP1cW?=
 =?us-ascii?Q?pJS0UrA3OBWbeykcBkmlKex2kTSvBJVT/EfHmUHW61bW4b8i+EIC9akdDk5g?=
 =?us-ascii?Q?UrmVYECHypkCsPIXXJKVrYxDkuaPkvHBhucxcsx4gO4eawZT6FUyKiS8Xn5U?=
 =?us-ascii?Q?Djlj3+dW2xjcd+y+P6MtDg5QZRwQ4mPGLT8HgJUVJA2Dc6KIjjMhnMOQK4+U?=
 =?us-ascii?Q?XAS0R3cETTe7DsR7bbOON5Z9XNGpVonGTV0O793Vpge5OeBik3JUPgrX4NDL?=
 =?us-ascii?Q?ntHiIPtwEJ/dhmtOrGSYHjXyNbTTamuo/y/ZTePq5MDatilyP38ddDJuJ19B?=
 =?us-ascii?Q?2dpfhCDgxaYZHauRxZ8JZ31El1YomPX5CShesPoAj/5yT4OBhExQZnrqsO8D?=
 =?us-ascii?Q?x19FYHNaQYEBrs4faFhQJ/TL6Y5bLnB2fyrfPNxJWUnhMcnmfYqPvpcUW7dm?=
 =?us-ascii?Q?m3mXwcvG4623nfw862ewSTBJkCgsY0Cv70Uh+YTC/z1Ya9rweWFhJwnRQETd?=
 =?us-ascii?Q?bfLhpc4QYvTwN/Yp511gPfpjakfpi2eC0hCfW4IDAdK79IWaNOkAETStwnOw?=
 =?us-ascii?Q?b6JF3FzpGoF12aQ4Th0EpdhT7p4TsYE0Kch9Lmzc9IPpnHWXNvrxsLD9gxaJ?=
 =?us-ascii?Q?LdiN3+xGkPoj3sg35+nllkn64H1SP9a57JpoE8eaea8yS6z19rvSCdQUZOwn?=
 =?us-ascii?Q?mfQ0TfWNVkv01grVF7IKhF50FnvhxGIumhMSaAg5WBfo61uba3r40EqBsr6W?=
 =?us-ascii?Q?AJ1tG4x5SCASU8Kf5qi9EXfNRIV1MzMbniMt+ADM5YlipnUy6wV4SskfiXSF?=
 =?us-ascii?Q?0Le1OqTPB5triGEOwwzJGXtHfbsjx3Q4RW8lwH1MZHJGBbZNG/Z4oIojjFbB?=
 =?us-ascii?Q?njf0ArZXfy/gDwu0K5PGcCYxdYbQNF3ojxP//mvMDy6tW0I9ToNypaxJIzuP?=
 =?us-ascii?Q?XpbSl5SUimEXYysFj4x+FJ4Nh45Ph2M6Kb/5yquieoe58b7fECaRSZPKzNJi?=
 =?us-ascii?Q?Of/kfZhZjkQDbdlBBZRjZ/hC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35bb499-e5c2-4995-769d-08d9064974b7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:18:01.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUk0aYXrAAYr2Hy1sCAqp7d8rylt2mgYLWFWyzrG+R9sG0pgHw37J+spn1i2zbo5nmJB8H+cupQd3Ex7B5Pu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently only way to create compute vm is through
amdgpu_vm_make_compute(). So vm_context isn't required
anymore for amdgpu_vm_init().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..07e8a7c28561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1114,7 +1114,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
 	}
-	r = amdgpu_vm_init(adev, &fpriv->vm, AMDGPU_VM_CONTEXT_GFX, pasid);
+
+	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
 	if (r)
 		goto error_pasid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..577148a4ffaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2782,8 +2782,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, u32 pasid)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
@@ -2817,16 +2816,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
-		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
+				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
-		if (adev->asic_type == CHIP_RAVEN)
-			vm->pte_support_ats = true;
-	} else {
-		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-						AMDGPU_VM_USE_CPU_FOR_GFX);
-	}
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
@@ -2844,8 +2836,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->evicting = false;
 
 	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
-		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
 	r = amdgpu_bo_create(adev, &bp, &root);
 	if (r)
 		goto error_free_delayed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 848e175e99ff..7f07acae447b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -379,8 +379,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, u32 pasid);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
