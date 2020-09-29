Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC48C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFED20BED
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="reXDJNQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFED20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0681E89E43;
	Tue, 29 Sep 2020 05:57:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD2289E43
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 05:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrjfMn0MwazInI0HZnUNN9K0b0eRN/ZdneBMY3aBbnnhjx2/+WJslLMKaL17acnHp5QP8z9FCrUKZc72XfwFTsnk8MSXceVB5HhtacFOJ7anml49EPgCXR+H7mFy9EevQeRb5N2+5mqPW3WB5wqDTmuTkKunC8KDb482LP7pICtkXoo/qF/QC4bjdHCqVwTlsk79JsnHScaXvBo0HHZocB7wKgOYInbeYArsJCt31/t0HpePfE1B9b+q327zEdRZkL3m5U6nffW9TQ8KDJDTnx6Nq8W1R2FdSaQmrOkCituuMEC+5e8u3tVNTPp3HcuRnQVl/dvIo+HE5Pb/BUwfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IkfNpUVtrrKq4DCRYRxtmRc+r0eCQDkWnHG4zXxheI=;
 b=B84/+anCqrToekKY2IIv7u9pWKB7IONp8aT9ZE348DHNoldXRIQekMzIEHXy+2+txlLE0KBN3NXUk9xmGQm1nwQrUkHK5g5OJu7eeOx2EVR3mphhfzKD7Q8KmpkgEpcJbozP8WYt9VmwHqykGvVteMnIijMGp3pI98JM4xMjq0cOxTAPUwXDFV1k5w7VoHzwuSks8vsns3qzqYY0hkex3MnrfdRsDL6SHYUyI6L/LQIgAWoKPBin+b20GKMOdHkArzkBN4GJYrTHw29BTGPhpg20h1oFG9rGP9F0+L61Mpn31oeZjRQknZHSN76aV5IWF89fm6FmIVl1oetRo+lWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IkfNpUVtrrKq4DCRYRxtmRc+r0eCQDkWnHG4zXxheI=;
 b=reXDJNQvDbLZY7Dqtk8XZTUIKVDuDjDGBIOxnAt0dwrNT8o/9X0bjP0tYp3eW0+zuANp2kIBf6Ck6WrLeRqfwef66ymNyT7i79XiRlaTrzC2PADuiAldjZQWJyg712Gmz1bgCc3EmPQKb5+509lvnY8ii9QsmpQYjVcomuvJ4F4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 05:57:20 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 05:57:20 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] amd/amdgpu: Fix resv shared fence overflow
Date: Tue, 29 Sep 2020 13:57:01 +0800
Message-Id: <20200929055701.3120-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (58.247.170.242) by
 HKAPR04CA0016.apcprd04.prod.outlook.com (2603:1096:203:d0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 05:57:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f8768cb-8735-49d3-3e79-08d8643c8738
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4735012884B184C6A6DEF1D487320@SN6PR12MB4735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pboZJ+XAAzm5XsIjYIU7v7LYOQuvhikYON2Tid0cClNj/Mkrn7/Z+bR+uKq8D678DCrX0iWlWTJwkQef5XvhfVer8cBysrvjPh1M11ClZbJ8Qc2ccLt1AG/6ww6stBAei7++eM4b8Q7wcTt20bZgqIjZmipf4K/Lg1nPXDoT8oPFycG6dFsRPlhuoP3zHSVCcCHQpJimhZZOc8G6LhvyoeZxnduqkWlt9LmV5gfb17lmJGki2/n70E5Wfzllc+QpKTPU0t0bddQvggt+9xNfZaKZPwoVfcIUHmhc4iq5yaVTJS8d7LHYZMeNf23P7pFRzKLWdNaFVhCaO071mFJTLLb04G16QEounZpywTPVZAp3QFpbc9QssbI9J8LMz9v9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(66556008)(2616005)(8936002)(478600001)(6486002)(8676002)(66476007)(5660300002)(4326008)(956004)(6916009)(66946007)(16526019)(6666004)(2906002)(36756003)(1076003)(186003)(26005)(86362001)(7696005)(316002)(52116002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3cim4q98/xsJx1zHotxpn7fXciSulFuR2aSxUWjJJ5d0gNyaCAaTiIzjMWgP77kLEazlYb8tMLugBs7uqDjkB0PUvaOH/wMMmX9FiHUyCIK4HUFT0apOLIc1ypIQ9J2eOXQZUeIJjmAgPQrlqRgPS1AtnKKeDBWwjAQZH9z7pOvKLqqTqKpBVqaLKQBP6Xai0m3dBAHicIz7qFRhkLVFRv2LX5vBctEJ4aFQ10mGtUSGEZ4D1zpTUlen0dmShsK1rbqhjA7bIANOkywhcE607noSm2lsfBu4LC4SixAlmomwEumhp0kR7Cjmibvbkn+x4188cidKRbFb9ZGWG6OTsDRHHRkUBwdq+5ZZdw4cMyPGVFI7Vq2g6YukY5AVJCs8VBh8VNAUawaMR2OlMHNeMXI/XPxRlf0t7qk3BJdh+Cn7EPstFrqX4SrthJZjQMko6aH7Jw6SBI7pXIhqktlkpQITdusd5qNud8Jylqt0Vxnaf4qaN9SsD1VQQzUxmj6mi3ryMvllK3B5E/2gGJXV68E8a+Q/N5WnRXdMOYBYkttwZWVAmToHMMTwzvm8y8UB0ZlyIa8K3nRgi4V+ngtde94WlX8yIYFcfdIfrsBZaDC1JJukYnuDvPaEje5IOMQX/LJhffuPSGUm+CF6M7uZ6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8768cb-8735-49d3-3e79-08d8643c8738
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 05:57:20.3849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELBuDb3vsH6FMVm4FLzzELc0qnJJii1U7ShW8jgtKNvOSv5OuI4aTfTkbcYtRnDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  179.556745] kernel BUG at drivers/dma-buf/dma-resv.c:282!
[snip]
[  179.702910] Call Trace:
[  179.705696]  amdgpu_bo_fence+0x21/0x50 [amdgpu]
[  179.710707]  amdgpu_vm_sdma_commit+0x299/0x430 [amdgpu]
[  179.716497]  amdgpu_vm_bo_update_mapping.constprop.0+0x29f/0x390 [amdgpu]
[  179.723927]  ? find_held_lock+0x38/0x90
[  179.728183]  amdgpu_vm_handle_fault+0x1af/0x420 [amdgpu]
[  179.734063]  gmc_v9_0_process_interrupt+0x245/0x2e0 [amdgpu]
[  179.740347]  ? kgd2kfd_interrupt+0xb8/0x1e0 [amdgpu]
[  179.745808]  amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
[  179.751380]  ? amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
[  179.757159]  amdgpu_ih_process+0xbb/0x1a0 [amdgpu]
[  179.762466]  amdgpu_irq_handle_ih1+0x27/0x40 [amdgpu]
[  179.767997]  process_one_work+0x23c/0x580
[  179.772371]  worker_thread+0x50/0x3b0
[  179.776356]  ? process_one_work+0x580/0x580
[  179.780939]  kthread+0x128/0x160
[  179.784462]  ? kthread_park+0x90/0x90
[  179.788466]  ret_from_fork+0x1f/0x30

We have two scheduler entities, immediate and delayed.
So there are two kinds of scheduler finished fences.
We might add these two fences in root bo resv at same time while we
only reserve one slot.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37221b99ca96..9e0116c7f8d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2869,7 +2869,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_shared(root->tbo.base.resv, 2);
 	if (r)
 		goto error_unreserve;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
