Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB11C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D3B2145D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qjf3FpUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D3B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF7A89F35;
	Tue, 29 Sep 2020 05:17:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC62889F35
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 05:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfS9F75V9Ct95kH24Zww4pCpO5gQds+1LifHf/cXOuGI2a9+PAkYMV9AKyF7bvdw0PUARw9LnKKU0YLrwgyLTVZM0TOxTpNE+0l+ruClJu4Kdsyy57f/oJafwoe6zPtVDmKb1Yu9niTxE8t8FHzwMvDfCg81fWMvjl4dDaGfV1merXZqKatvXOiSf8lkFwXVs363Nusu3L51dKRRAHxeEPITK1/x8SkdWFGRBh0fapgaQfYS+aAesqu1zxARW+gPXhZEL6/+ytWsAD7M+x663dwb/+ABAwezBLGlNaQGnvH5evLSM0oabFjh7C03cPTbHk+GV7Ey9BJhGfJ6SUe38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/G2FHpfx8oxPONz1yhaRJ658D8e8Z76Kp5WbYWHUKM=;
 b=JPh643x2FiZQwEIp4ZlumR/WC6DdVZMzhegHYne4A/M9elYduddghoV9gbh+FzwpFFMqm0E0nrinVmvmp7eJnh/eZNfPh5l+1qPwnP8YueEylioozwi9AWfHoJ1xp0FnyMsWf8o1ORT90IdjGgbeqaRs+VPkvBdnX71kf6juAUkahZoCtb5xpYBv/qeIoaeCnfGcjIia0WKcs1kyYaD7Ty6SqD7+bp50AIby5PyhYPe5ltQnf4q9muqSwXRYJaFF93c1csshkLgBEwrhwEuCwPm7CAhg2dworcdtTGQyjeGNT0/Ir15RVlMksb8P9QJEisO/RWSDaz5v6l0mD5/lRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/G2FHpfx8oxPONz1yhaRJ658D8e8Z76Kp5WbYWHUKM=;
 b=qjf3FpUXz0UgWyGMDtQD7akBME8LVt8QaqV1PLNbtMo3IxA+b5VPE5f+GHhw4HeislRl/kGJvKqD2Br88xUbI/8TFHo4HsSiJ9j+krD0ax0V5ogciwJ2l4Ct0T+tbnGh8baaMXn5C7SDoQwYXqIH5Pjh62zahoVFE63KdOG5qJ4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 05:16:57 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 05:16:57 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amd/amdgpu: Fix resv shared fence overflow
Date: Tue, 29 Sep 2020 13:16:32 +0800
Message-Id: <20200929051632.8737-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To SN1PR12MB2558.namprd12.prod.outlook.com
 (2603:10b6:802:2b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (58.247.170.242) by
 HK2PR04CA0058.apcprd04.prod.outlook.com (2603:1096:202:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 05:16:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fafba63-dcb1-4286-2582-08d86436e2c4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4496D34D98A52E259A6DF9EC87320@SA0PR12MB4496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4vxTs+lOjWWOrMNBwk7NatVdcfZ5cqsH2VLEou1P9Pks7qmk9TsSCDFVBo6Hjve+sf4rB6VwcQim0Tr2+gWyldwv2K2IwowEbqrpd+8PCbDwkliR2TAB6SE7gsfhuFSWJaMd4Io+XC7pcDTF1uCvODgJ+ReJeaxjSaDE/z4aF1TtbhlzkzZ97Gk4hwU66puf0HeK7TJHYY1Jfarx/NWyq1Q8R8h7ahxd9P0QLsjD6Rd/bytN/5x1iPKBglNlCeBsEDQhh2UZRZWgqxZ2sxfg7svPbhu6Zy5hNaSDrPLF4f3stgdw6FxYo0ZeypnZg/yA2QUFwDMHHHeDdO+X17v3vNHiz2chGKIS1t3PY+uu5IG3r3a1XKf/rNTQkQNfE52
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(6666004)(316002)(478600001)(86362001)(5660300002)(66556008)(66476007)(66946007)(2906002)(1076003)(83380400001)(6916009)(8676002)(4326008)(8936002)(956004)(2616005)(36756003)(6486002)(186003)(52116002)(7696005)(16526019)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EKgI/MIKVvhEmmojASKKy7+sENRaDFs1k3L6JJT7L6PoGFZijS5zksmuRmtXf38hOIPo2SikKuCH2FRBX1lSQNqo8gi7gUzW9J4wWPk1tnjzPVm1hXT5GojQSanelqA9CiPhjTbp0Tko0dTZZoqzZqrkt9QlpL1rSToCMiEtbNzBOYzDOIdKOyeFpLr1thkAFJA4zBLlYiWN3fPTuU3sze8uxYZTAzYYUHou4IV4k0ixLzyTyQFiKxSDKP//W88Ec+LkKTK7atmcIDOYmOwK1NyFjuZKPtbMQPbayY5y/CL0++naMj6X6RQ7DW5IFBXhzTLXtPym7ok1SsfNKfpRv5zbJBSE831guNoqjMwjZzIiv/jPL5OX9GRi6lbnlOwuNpShVtmCcv68NY65+e9MHmODj7XQ+8CBdZRSd0smrOGz+2nJa4IaXdJLssgZbUtl1FvYeOq/MQy2xvwfo7nIRjh0/I3lwEpK63wmeyCdnah/VEuS+2ebPAWYaFGky/YdmaRiCc5cJ6fKW5iN0P4GDhuia82yRqM6f623mHti4d/bPPb4BVm3u3azarNxv7LguhjluEgALcBCBC/w+QThaq7GCHynduF6GzAxiUmp+GTAPms0aKO6PjRBBcl1RpeKQYhI3EZNlAv6XPtH3BICww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fafba63-dcb1-4286-2582-08d86436e2c4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 05:16:57.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFabotP/nw/JUZmkYbTGvuG2XP3Ye2xkKPhVLKAhX/1oc7QoPxFytP4yXWejyl+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

For unlocked case, we add last_unlocked fence to root bo resv if it has
not been signaled.
And we will add another job fence to root bo resv in ->commit(). That
causes the shared fence count bigger than it reserves.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37221b99ca96..77689cecd189 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1615,6 +1615,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		struct dma_fence *tmp = dma_fence_get_stub();
 
 		amdgpu_bo_fence(vm->root.base.bo, vm->last_unlocked, true);
+		dma_resv_reserve_shared(vm->root.base.bo->tbo.base.resv, 1);
 		swap(vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
