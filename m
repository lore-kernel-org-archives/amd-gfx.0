Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916DC2BA83
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 01:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1D6208C4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 01:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e30tFTGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1D6208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B706E0E5;
	Mon, 10 Feb 2020 01:04:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C816E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 01:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdSmw7WJfO0e8upgmmvrGoJgxYRJarCL1W338DaUOSegRWkv5Qge6Y+zoJ9ReGcerDvAyvcXD6XUp0fD0V6fNvDsX2iTT9+uMK4qSJYRLDHwFCudwCweHqYqi8Ruhd2lp27svxvI5ODzJXxmGMDIo1msSvFJ5BKM6ecNveR7xjz9hup+tqjCYSe1Ck9OcXEVA49nPipwu3hIZNuUOIbPHPW51bR6EkPXtBd9gjTeaV2Y7snrXwPDazRaFJEKZalbGb2XO13VQ0f1WZc2Rf0j5mxuDtek8mqVu5RcO9p2xi+bGPa+6J3nxMiB1lun8zULVQ8xWLQ+Rhb8ZjCelcAPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/AUOQwZa0LoLk7UmXPuDFfsNPZoaQLT7b7481O6crw=;
 b=BqX7bljc0TDAvbnmpqxffIcZAUM7vacc/KJLA5XGp9LKZoxGbMlV9jEAc4GWb/oHtD8DkJ6LspoQKejG9PVLXjUwTQGtzH5qZTQ5WrsKd533vbkrMZNJVH4wMIkGoTs4WqUTzCAu0ls2jC+XxEkLC/cQad4N/gwKvhsttGnzSqhtn4MUiUm+OHjvwnmIof9REqcGGm4fE0TT3H/AMOo8QDRGiHbgtNbVsdaRePdaQAtHpq3AnzRnpq3TYkCjpE02/7Ago1U6cbeQglSktYhOMkT4iO+btf7zm6UcOvMZFPdxxq8qsOlGVSKkXHA420HvBjuX2ZezitFQQ5YNR8FMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/AUOQwZa0LoLk7UmXPuDFfsNPZoaQLT7b7481O6crw=;
 b=e30tFTGy87hNjdPitr+u8UyEwVo5xXuXRlJkTQddMdkMzfL0vlJ1GFP9jHCCWFWej+zlnbfyYW1t8gNJgIPCjYp5xa5fqSHURQq2ofqer15WBcrneuWXyKVGyWDvIiC0xZ/A26sN+ugKvmHRtkQCLsugyrcWA4APCSona3MAvME=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2750.namprd12.prod.outlook.com (52.135.107.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Mon, 10 Feb 2020 01:04:20 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 01:04:20 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: Do not move root PT bo to relocated list
Thread-Topic: [PATCH V2] drm/amdgpu: Do not move root PT bo to relocated list
Thread-Index: AQHV363JPwEEMuSvX0ym5Sus0fH+ow==
Date: Mon, 10 Feb 2020 01:04:20 +0000
Message-ID: <SN6PR12MB28007664AFF433168DF33CC787190@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-10T01:04:19.977Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cda7b78a-e5d5-4904-722c-08d7adc52910
x-ms-traffictypediagnostic: SN6PR12MB2750:|SN6PR12MB2750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27504EBC20E15DA7F0ED9F4987190@SN6PR12MB2750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(76116006)(81156014)(91956017)(8676002)(66946007)(66446008)(66476007)(64756008)(55016002)(6506007)(66556008)(81166006)(5660300002)(7696005)(478600001)(8936002)(52536014)(9686003)(4326008)(33656002)(316002)(2906002)(71200400001)(6916009)(26005)(186003)(86362001)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2750;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcoAt+2afuH+uUwjbA7ZXztrPrav7YnNE8/fCsVN2cv5tsfNjInZ2jJZP4z4NaxzVMPsZB0A4DRBRY+hSozgYQ9uS2sS1Wj2K8FBcKVV6ytdtXOXLGg5SoHcsuJ+VTcBsYrXqhPibvGbFLm13iJjhMVkwuiMrkGUYClFgo0kc8/aE+N4Bq5s6EJSoX4/5iR6ru2LjtXMlXVmfChnYrmJfTUxYMgRc4EyoxK9Xt8lI/d6fT5IlARR8I6iBRUOpP04/aOJ7xkBRcsfaQaFQSq7ozApbTare5eUWqBihUC4p2pSAi6Jn8erNDMeRpMI/4ELleYA3D1I+9vFvbfot7AZSK99pCoqaxzHPddomV4uFcFr17UX5qN7EY4APa5lQzMmPI7SgepPEiXol/tDamcJXwko/tGxhfJ0sR2V2+uftSX/DMFviF0X8kptrK0kbtpU
x-ms-exchange-antispam-messagedata: nULseF93yXrLlIbs1LVX4T8SSZf//gBSo4Guy9AcJpBaGD3ZcwE4VZK53bT5DimHQ8v9uFG6gDKREKYQiX0q4AM/1ZzmkOundwSNEIFOo20irdNShIbI3G+8Svs9hD4K8N7Yf8nIM/qMont00B5cng==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda7b78a-e5d5-4904-722c-08d7adc52910
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 01:04:20.4721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srzDL7eDw26EHuiU+r1s8lefddk4CRyGwNsqg4dkarUJli+1mpA07V1GUH5J3Idg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hit panic when we update the page tables.

<1>[  122.103290] BUG: kernel NULL pointer dereference, address: 0000000000000008
<1>[  122.103348] #PF: supervisor read access in kernel mode
<1>[  122.103376] #PF: error_code(0x0000) - not-present page
<6>[  122.103403] PGD 0 P4D 0
<4>[  122.103421] Oops: 0000 [#1] SMP PTI
<4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: G           OE     5.4.0-rc7+ #7
<4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, BIOS 3.0b 03/09/2018
<4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
<4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 00 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 8b 80 28
<4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
<4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: dead000000000122
<4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: ffff9010ca31c800
<4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 0000000000000001
<4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: ffff9020f823c000
<4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: ffff9010d5d20000
<4>[  122.103968] FS:  00007f32c83dc780(0000) GS:ffff9020ff380000(0000) knlGS:0000000000000000
<4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 00000000003606e0
<4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[  122.104137] Call Trace:
<4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
<4>[  122.104347]  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 [amdgpu]
<4>[  122.104466]  kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
<4>[  122.104576]  kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
<4>[  122.104688]  kfd_process_device_init_vm+0x24/0x30 [amdgpu]
<4>[  122.104794]  kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
<4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
<4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
<4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
<4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
<4>[  122.105093]  ? vm_area_free+0x18/0x20
<4>[  122.105117]  ? find_held_lock+0x35/0xa0
<4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
<4>[  122.106001]  ksys_ioctl+0x75/0x80
<4>[  122.106802]  ? do_syscall_64+0x17/0x230
<4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
<4>[  122.108378]  do_syscall_64+0x5f/0x230
<4>[  122.109118]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
<4>[  122.109842] RIP: 0033:0x7f32c6b495d7

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
   move root pt bo to idle state instead.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3195bc9..c3d1af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2619,9 +2619,12 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			continue;
 		bo_base->moved = true;
 
-		if (bo->tbo.type == ttm_bo_type_kernel)
-			amdgpu_vm_bo_relocated(bo_base);
-		else if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
+		if (bo->tbo.type == ttm_bo_type_kernel) {
+			if (bo->parent)
+				amdgpu_vm_bo_relocated(bo_base);
+			else
+				amdgpu_vm_bo_idle(bo_base);
+		} else if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
 			amdgpu_vm_bo_moved(bo_base);
 		else
 			amdgpu_vm_bo_invalidated(bo_base);
-- 
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
