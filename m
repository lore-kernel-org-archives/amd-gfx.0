Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA744C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A2664EDC
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 02:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A2664EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3C56E47A;
	Tue,  2 Feb 2021 02:03:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAFB6E243
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 02:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyDiF6fCzM+pWGYsWToOt6UR9Dye3GVZInN5NYb+QAzlZDiXW/UUC7K/uqEqt6v85ZV6z0RwjWg+QPHiRwAUgVNInYlv91vHLZFLnE+DXil9KKjvi+YVNGRPynsm29sc2kHhbic9OP8RH4zfeDjedii8u/CsrAZ19IgFA0+drYi0QFKdT4DR4MnQpe3/u/LmWoeOSIGrzCMqJtRS/qZtgo27ys/c349Npaknzs4rz/eKOPwIfhjxB67/RPdfVri5uhNplBIFscrQd4N2kuDNXUXAJjzSreK6dNB6uccgIsCRNmJ4mul9qi/uJTu3vJARk9eMoLM4Vv25Ow3pWFE1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij6h0Ekwbi5bP7aHCxLrpvYoySuP9tsxkLK3FCQJIpk=;
 b=a8jAoSD3143daTjF0/atvfX6DL+L1INhF5TZMqkO/62NI6IBfHL4esKP54vQLi3grt+as98xpfQgQs5SfF3+5zcSswR6ISNdBraxmIBjZOW4Wep+iCE7EfqOPk0UJYD0qBqY9HdLBT/wIowHSPfIzIz6ABwd6VZO+ERNcS1+Ynbw6wKeC32zmP8b4x+ff8+729CDbU150PGYVhgRb2C0WYqErBfNOfYEMrAUVwW/x9BYvlMJLAYSgxxvpyW4fLCMiqEzuUqQWoN13F1LR0FEO/MS/7eWHRsz7AybGltHhDkMG6hSCJbvAYEEL93CCSrAqFtTeVaP4kjNliwGb/dZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij6h0Ekwbi5bP7aHCxLrpvYoySuP9tsxkLK3FCQJIpk=;
 b=qvBtSMZJRUuOGWsasmzeRZ1CRxnVN2LzEJaRsdS7VPkcBFQChQC6JWTeJ44r9qaBdiXvUfLyvO+NYxWPYS0GTpcb8YRvMDMryIRvs5ThOh3jfw6RdshX5zfeQXHsW/Vaso2p8Q/V7JaV6LOh8ECatv1xqLJsJMW0pK8uKU5DmE0=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1568.namprd12.prod.outlook.com (2603:10b6:301:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 02:03:46 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::c513:49f:30ac:3582]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::c513:49f:30ac:3582%6]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 02:03:46 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in
 kfd
Thread-Topic: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in
 kfd
Thread-Index: AQHW+IaMPLbcbfi7ckG6E4et7e42bqpEHgdg
Date: Tue, 2 Feb 2021 02:03:46 +0000
Message-ID: <MW2PR12MB46843EFF02A3DF42AAFE9F8DFDB59@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210201103916.3153820-1-ray.huang@amd.com>
In-Reply-To: <20210201103916.3153820-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-02T02:03:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a0535799-3491-436a-a278-1e2d772114a2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17bd2d1f-03be-490d-48ce-08d8c71ec694
x-ms-traffictypediagnostic: MWHPR12MB1568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB156810B11A4155CF17345288FDB59@MWHPR12MB1568.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ItHzGzTDbn+XpmaWN67LPbl0q6l0/kODIzDcfdcElL6Zs6dhbzzNqRA//ACNRax1sKZp8Hqp1w2gyqH5OGtVMypWKPRCIT4g6ZkE9XRe0m8DHz3qTvzRwNN9K6J3xP0XImopcjiW8JzrSbA70STQ55f5UPjjK5GXRNhEWVgtisKfY/dYpF1E4b+WXdzf7ydAc5jx04RQmm25U9PMpWMJdcYtPWdbSyxue4n9oYrtIDDlHwoLrjJEzWEbj/nGPNtXvnLUQAuUiJtMtvaFDBVOsWyh5oljDbCT4+E8xsfO6+meSCtpX2IYqikC2bOiYf+4bew9wxiEQbnSMe5R8c4Ygt6TiRIb/hR/yqRg4I5U3UqPKfYdVljAUOPdpczXAGsWTYvXb8yoxyh6ZSC2WaGQSK+pjBddcA9ZgPUPtLAYwdUdiYqvEAzTGPI2/MVBFoztVCAt89/agiAFuy16ZkmgBMBaYintzxHy6e+NqJcIb8ioVOyNWyhCSpofUIqqzi8CNSh78VOxFnO3KA+u6uwoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66556008)(86362001)(2906002)(9686003)(66446008)(8676002)(66476007)(55016002)(186003)(64756008)(52536014)(4326008)(26005)(53546011)(6506007)(5660300002)(71200400001)(8936002)(54906003)(316002)(83380400001)(76116006)(66946007)(7696005)(33656002)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fwKnKeAWu0GbTDBhiBSW/Lg+dw2sJeq7yBvsC8uw8wtlSZzBm9m5x0FhGZsx?=
 =?us-ascii?Q?8dofqQJ1ebB9mRGm1TJuVy8O2MnfQJCgyzebry2G5BXkd1a5g7c9XxPr7QCD?=
 =?us-ascii?Q?GHWpY2sq1effGKVsjtwG1brbiNYJdB3qfbT52zPsc+je5fNFasQhjN6g2IGG?=
 =?us-ascii?Q?5FHdW/Tp/3J367Ije8zUASe0sEInng3n0fiaFvCDSw+L2jmoJHmQicSMm+kn?=
 =?us-ascii?Q?dJBv47ENPa74ck6VAO1lUd2sYw7D7mR8ozwCDPGpShdiyf+E4MeAZUAv8bBd?=
 =?us-ascii?Q?MxLUEv3vtURecA0Ha/HAxR0HHMlNpX9rzDxC98gEhbrmVcaiwG7UVb/ioCMO?=
 =?us-ascii?Q?yJqlJ3zfVm1O1C1OM1TyuwgrMPLZ2hC75AMgRNgVRmp1t7qv8OEIWhonFTmL?=
 =?us-ascii?Q?SNBqdRwwtum4qWrknegSTKXlFLS9/aEQBjISJFAR/8B8YWdUjyCRC8R5akvY?=
 =?us-ascii?Q?Glysr8BOX9K9Q5SoHrEhpVKUwC6/VxuDMoFy8XQvcsziUTsit/ek5/jf/OCF?=
 =?us-ascii?Q?FCTcP/hB/VXoYcPt1PGy7//7FC5tBVoZGeprVaGhrQSxvSvkIKO7CwaqzTJA?=
 =?us-ascii?Q?ek1ecJaHT+8x68PaPLfJk0JEclDhTShHpMAT7LL2QWjLpZq8NNuEle80hE9n?=
 =?us-ascii?Q?eW3PDiFRU6ujAOt+E93ic+Vez18iMxkGB98IJYHYVfxOSDJcFrhCUHOP6vuN?=
 =?us-ascii?Q?Qm+0wdQwn2sp1vKm9dbNqzjrId082+1r13e0XztEDYKk7z1Yf9L7sR9atXrY?=
 =?us-ascii?Q?9kTn6E8bKXCPmjoKsKHTDlULCwMD4oZwAlFj3wK087cTIsmrRL8SYBguqZJa?=
 =?us-ascii?Q?0KBWv+RwoLpoGQaVMe15PZraeiaDgNDlCDYI4b5OcrBXHY1IQl+gp7/H11iV?=
 =?us-ascii?Q?NGTBITy48A0I9sVUb7/dOp25EHaN4vXyfzaLUQ4aEo9H0CTYH2wT3q+0BmAf?=
 =?us-ascii?Q?cc/xgcXVAF2YlKoFXd1Pgfr4FKR6ybzTWNdSmoOPJVKfiYfx5fuLDn61Uzc5?=
 =?us-ascii?Q?URUdpt98fLZ9EpmHG6kqLaUaV9n355v49x70nxdwCPE2KtcOe78qkPlvY+LX?=
 =?us-ascii?Q?K7TH1Q/9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bd2d1f-03be-490d-48ce-08d8c71ec694
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 02:03:46.5159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JB35ELZUlHP1MSLBzlp3dwBHW4f5ON0FOMKLfiRCOZMVQ7jVONE2t8/+ksz9dmj9NNtQQhDdwiqg+kUUKnq1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1568
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Tested-by: Changfeng<changzhu@amd.com>

BR,
Changfeng.

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Monday, February 1, 2021 6:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhu, Changfeng <Changfeng.Zhu@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in kfd

In drm_gem_object_free, it will call funcs of drm buffer obj. So kfd_alloc should use amdgpu_gem_object_create instead of amdgpu_bo_create to initialize the funcs as amdgpu_gem_object_funcs.

[  396.231390] amdgpu: Release VA 0x7f76b4ada000 - 0x7f76b4add000
[  396.231394] amdgpu:   remove VA 0x7f76b4ada000 - 0x7f76b4add000 in entry 0000000085c24a47
[  396.231408] BUG: kernel NULL pointer dereference, address: 0000000000000000 [  396.231445] #PF: supervisor read access in kernel mode [  396.231466] #PF: error_code(0x0000) - not-present page [  396.231484] PGD 0 P4D 0 [  396.231495] Oops: 0000 [#1] SMP NOPTI
[  396.231509] CPU: 7 PID: 1352 Comm: clinfo Tainted: G           OE     5.11.0-rc2-custom #1
[  396.231537] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS WCD0401N_Weekly_20_04_0 04/01/2020 [  396.231563] RIP: 0010:drm_gem_object_free+0xc/0x22 [drm] [  396.231606] Code: eb ec 48 89 c3 eb e7 0f 1f 44 00 00 55 48 89 e5 48 8b bf 00 06 00 00 e8 72 0d 01 00 5d c3 0f 1f 44 00 00 48 8b 87 40 01 00 00 <48> 8b 00 48 85 c0 74 0b 55 48 89 e5 e8 54 37 7c db 5d c3 0f 0b c3 [  396.231666] RSP: 0018:ffffb4704177fcf8 EFLAGS: 00010246 [  396.231686] RAX: 0000000000000000 RBX: ffff993a0d0cc400 RCX: 0000000000003113 [  396.231711] RDX: 0000000000000001 RSI: e9cda7a5d0791c6d RDI: ffff993a333a9058 [  396.231736] RBP: ffffb4704177fdd0 R08: ffff993a03855858 R09: 0000000000000000 [  396.231761] R10: ffff993a0d1f7158 R11: 0000000000000001 R12: 0000000000000000 [  396.231785] R13: ffff993a0d0cc428 R14: 0000000000003000 R15: ffffb4704177fde0 [  396.231811] FS:  00007f76b5730740(0000) GS:ffff993b275c0000(0000) knlGS:0000000000000000 [  396.231840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  39
 6.231860] CR2: 0000000000000000 CR3: 000000016d2e2000 CR4: 0000000000350ee0 [  396.231885] Call Trace:
[  396.231897]  ? amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x24c/0x25f [amdgpu] [  396.232056]  ? __dynamic_dev_dbg+0xcd/0x100 [  396.232076]  kfd_ioctl_free_memory_of_gpu+0x91/0x102 [amdgpu] [  396.232214]  kfd_ioctl+0x211/0x35b [amdgpu] [  396.232341]  ? kfd_ioctl_get_queue_wave_state+0x52/0x52 [amdgpu]

Signed-off-by: Huang Rui <ray.huang@amd.com>
---

This patch is to fix the issue on latest 5.11-rc2 based amd-staging-drm-next.

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0849b68e784f..ac0a432a9bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -26,6 +26,7 @@
 #include <linux/sched/task.h>
 
 #include "amdgpu_object.h"
+#include "amdgpu_gem.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
@@ -1152,7 +1153,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
 	struct amdgpu_bo *bo;
-	struct amdgpu_bo_param bp;
+	struct drm_gem_object *gobj;
 	u32 domain, alloc_domain;
 	u64 alloc_flags;
 	int ret;
@@ -1220,19 +1221,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
 			va, size, domain_string(alloc_domain));
 
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.byte_align = 1;
-	bp.domain = alloc_domain;
-	bp.flags = alloc_flags;
-	bp.type = bo_type;
-	bp.resv = NULL;
-	ret = amdgpu_bo_create(adev, &bp, &bo);
+	ret = amdgpu_gem_object_create(adev, size, 1, alloc_domain, alloc_flags,
+				       bo_type, NULL, &gobj);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
-				domain_string(alloc_domain), ret);
+			 domain_string(alloc_domain), ret);
 		goto err_bo_create;
 	}
+	bo = gem_to_amdgpu_bo(gobj);
 	if (bo_type == ttm_bo_type_sg) {
 		bo->tbo.sg = sg;
 		bo->tbo.ttm->sg = sg;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
