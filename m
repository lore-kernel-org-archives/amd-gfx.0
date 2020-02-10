Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7FC2BA83
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 00:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBDA208C4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 00:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lgum28iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBDA208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE9D6E0D4;
	Mon, 10 Feb 2020 00:59:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB146E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 00:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBzHGqSHPhcgpknm/+sCBsdIf0QhznXKlldETuVGEf5t2EHO5eS9DO30CI0qRXaMmCZB/zXhGKLv0R4daJc18wYrLd0XH9CCV1PZgquo6n1+626Dzu38fluVmqJDb0XdjES9m4r93VC8nfPRvoTYC5dt/TPtdpWaKVQieUAoR4uF8MVB1QZAbcXokN2QH6Gfq3Hk5HjOu8qElIztc//7lWjy0e4CKT8xATc9Pq1O0SWZ56JPck0JMT3cfTgXZaCKG8JmsD/42908GHwOlTAzjpchbQayVfxufcVSFNaEKQNBnaE5euJGUWZmyRCIlsLp68V/JiJ/2lRL60ZOJoxEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9fh9awag9tJOnMd/Nx0WhYSE/ZzRiYJlJTOZM19gew=;
 b=l2P6WrDgS8Cy+8SD1ray93xBbEIkBSRfODh1rdSskz+M6vZdQ5SJ5gO4WSak2JtwaU7+KBdwIEGy46j+8GsML+1MkNuRAAYQzI0Ijlfy/U7mA0+Nwrzkck2gI61NIDGhL3UpW96b/1HaDi8U+pQUu04qjzG8MZ228IaOsvLbzFsKSGqeKgjJBwS3AeDRVRhw+z1LOOl67txg2rNX3VWTNfkVGYOS3hs+863adTadenvaZMlHAzHUssYO5xQc+R0vKkSpD/MWdkIoh/OiqkQGnu3jVskcG9Q/C7YWJcNKIHrXwBAJTRoKnKBuk1YKFQoWrKeU1uJP4UIShoie5b8z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9fh9awag9tJOnMd/Nx0WhYSE/ZzRiYJlJTOZM19gew=;
 b=Lgum28iqBOqQlxEJR2NFhIrSLtClOZpvurIE27NCVaRqrMoky8zowuBXq6pEUzYDRKgZDpfY34IXlEq6JU9ntFa/0f1ykwNyKPbJVHS9vx3z8hOC1RkKhJ5ZxIQeyg7YLoAvjP70zQiuUADLLIMeEfTDoRExg9H6Pc6mEg+9WIg=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2750.namprd12.prod.outlook.com (52.135.107.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Mon, 10 Feb 2020 00:59:17 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 00:59:17 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
Thread-Topic: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
Thread-Index: AQHV3vNP56MTPbl2TEqB6lFXcDTL9KgSheGAgAEVWGg=
Date: Mon, 10 Feb 2020 00:59:17 +0000
Message-ID: <SN6PR12MB28004896C5D08FC3F4BBE2A787190@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <SN6PR12MB2800EB2C9B3EE8BC3DC6B664871E0@SN6PR12MB2800.namprd12.prod.outlook.com>,
 <cb22f498-f1c5-fa7b-ffb7-643ef9a584ff@gmail.com>
In-Reply-To: <cb22f498-f1c5-fa7b-ffb7-643ef9a584ff@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-10T00:53:52.2873681Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.245.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41330edf-e2cf-43f2-3713-08d7adc4747e
x-ms-traffictypediagnostic: SN6PR12MB2750:|SN6PR12MB2750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB275043C50A973E4F2DAD9B2587190@SN6PR12MB2750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(2906002)(71200400001)(33656002)(110136005)(4326008)(316002)(54906003)(186003)(86362001)(26005)(53546011)(55016002)(66556008)(81166006)(6506007)(8676002)(66946007)(91956017)(76116006)(81156014)(66476007)(64756008)(66446008)(66574012)(8936002)(478600001)(52536014)(9686003)(5660300002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2750;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bziJpeF//qBphCt2GRTHNPJEwc8jTtCy+SrrX7lcpKXyMZuPSEligfdewh2AaITTQhP8syA/UvUAnHNz7DZzg4agD+cYpSRzA25JrAJUMqzqqlrogM7qMKIUexwFfwkQOhY8aLxDnTsrlBW8C5QV04j9p7GgBsJWOMnenOpqqwOHg4qZ5Y7WnJLZF0slwF/tjRabwjFi1s/v2LbHBrjLGG8cFrsaDBTxbhE5F3ByyGAPnbMDImuFH/LWh6MO/E/8nw/ViqC9IGq1wo0u0hYov2YZ/c5dxWkzjIxljRKDP8vYUnHeiUGujnAjPgXzPgVfRZPlqZZCumw0egwn0dfdf6/0AheU+MWdyj6Id14m5MWtvJKRw4Q4ITeyIeik1bAltyqPspTFvSKTxpG0bOdA7nTNDtWmiWy4T9XcS96uqP+XeyJGE7YF3QP3YdaYylqB
x-ms-exchange-antispam-messagedata: 0wEdaOowM7yXwR69rdxau/bayZIR4izYh4I0dQH2Nk5VuMOjlNLskEUIf3q5MaeDFaVOQ5tzztZBpnkiMC25LoiC0OHqBNBjgRPU9jd0uxEoCNZnRf1BSyixsOpgFaNh6aQ9enZ+O+b6SFpKTaz8CQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41330edf-e2cf-43f2-3713-08d7adc4747e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 00:59:17.4729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bp83FjLdss/RYEJFc9Rt4Ia9Ze96mnfduGoJgm2AMFlZqnpoo4bD/wC/uI6a05PF
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
Content-Type: multipart/mixed; boundary="===============0975517894=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0975517894==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB28004896C5D08FC3F4BBE2A787190SN6PR12MB2800namp_"

--_000_SN6PR12MB28004896C5D08FC3F4BBE2A787190SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

If so the function name does not match its functionality.

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Sunday, February 9, 2020 4:21:13 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list

Am 09.02.20 um 03:52 schrieb Pan, Xinhui:
> hit panic when we update the page tables.
>
> <1>[  122.103290] BUG: kernel NULL pointer dereference, address: 00000000=
00000008
> <1>[  122.103348] #PF: supervisor read access in kernel mode
> <1>[  122.103376] #PF: error_code(0x0000) - not-present page
> <6>[  122.103403] PGD 0 P4D 0
> <4>[  122.103421] Oops: 0000 [#1] SMP PTI
> <4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: G           OE=
     5.4.0-rc7+ #7
> <4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, BIOS =
3.0b 03/09/2018
> <4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
> <4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b f0 c=
6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 0=
0 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 8b 80 28
> <4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
> <4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: dead00=
0000000122
> <4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: ffff90=
10ca31c800
> <4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 000000=
0000000001
> <4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: ffff90=
20f823c000
> <4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: ffff90=
10d5d20000
> <4>[  122.103968] FS:  00007f32c83dc780(0000) GS:ffff9020ff380000(0000) k=
nlGS:0000000000000000
> <4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 000000=
00003606e0
> <4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> <4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> <4>[  122.104137] Call Trace:
> <4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
> <4>[  122.104347]  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 [amd=
gpu]
> <4>[  122.104466]  kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
> <4>[  122.104576]  kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
> <4>[  122.104688]  kfd_process_device_init_vm+0x24/0x30 [amdgpu]
> <4>[  122.104794]  kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
> <4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
> <4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
> <4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
> <4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
> <4>[  122.105093]  ? vm_area_free+0x18/0x20
> <4>[  122.105117]  ? find_held_lock+0x35/0xa0
> <4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
> <4>[  122.106001]  ksys_ioctl+0x75/0x80
> <4>[  122.106802]  ? do_syscall_64+0x17/0x230
> <4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
> <4>[  122.108378]  do_syscall_64+0x5f/0x230
> <4>[  122.109118]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[  122.109842] RIP: 0033:0x7f32c6b495d7
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 3195bc90985a..3c388fdf335c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2619,7 +2619,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *=
adev,
>                        continue;
>                bo_base->moved =3D true;
>
> -             if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> +             if (bo->tbo.type =3D=3D ttm_bo_type_kernel && bo->parent)

Good catch, but that would mean that we move the root PD to the moved
state which in turn is illegal as well.

Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the
idle state instead.

Christian.


>                        amdgpu_vm_bo_relocated(bo_base);
>                else if (bo->tbo.base.resv =3D=3D vm->root.base.bo->tbo.ba=
se.resv)
>                        amdgpu_vm_bo_moved(bo_base);

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Sunday, February 9, 2020 4:21:13 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list

Am 09.02.20 um 03:52 schrieb Pan, Xinhui:
> hit panic when we update the page tables.
>
> <1>[  122.103290] BUG: kernel NULL pointer dereference, address: 00000000=
00000008
> <1>[  122.103348] #PF: supervisor read access in kernel mode
> <1>[  122.103376] #PF: error_code(0x0000) - not-present page
> <6>[  122.103403] PGD 0 P4D 0
> <4>[  122.103421] Oops: 0000 [#1] SMP PTI
> <4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: G           OE=
     5.4.0-rc7+ #7
> <4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, BIOS =
3.0b 03/09/2018
> <4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
> <4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b f0 c=
6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 0=
0 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 8b 80 28
> <4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
> <4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: dead00=
0000000122
> <4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: ffff90=
10ca31c800
> <4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 000000=
0000000001
> <4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: ffff90=
20f823c000
> <4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: ffff90=
10d5d20000
> <4>[  122.103968] FS:  00007f32c83dc780(0000) GS:ffff9020ff380000(0000) k=
nlGS:0000000000000000
> <4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 000000=
00003606e0
> <4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> <4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> <4>[  122.104137] Call Trace:
> <4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
> <4>[  122.104347]  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 [amd=
gpu]
> <4>[  122.104466]  kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
> <4>[  122.104576]  kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
> <4>[  122.104688]  kfd_process_device_init_vm+0x24/0x30 [amdgpu]
> <4>[  122.104794]  kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
> <4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
> <4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
> <4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
> <4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
> <4>[  122.105093]  ? vm_area_free+0x18/0x20
> <4>[  122.105117]  ? find_held_lock+0x35/0xa0
> <4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
> <4>[  122.106001]  ksys_ioctl+0x75/0x80
> <4>[  122.106802]  ? do_syscall_64+0x17/0x230
> <4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
> <4>[  122.108378]  do_syscall_64+0x5f/0x230
> <4>[  122.109118]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[  122.109842] RIP: 0033:0x7f32c6b495d7
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 3195bc90985a..3c388fdf335c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2619,7 +2619,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *=
adev,
>                        continue;
>                bo_base->moved =3D true;
>
> -             if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> +             if (bo->tbo.type =3D=3D ttm_bo_type_kernel && bo->parent)

Good catch, but that would mean that we move the root PD to the moved
state which in turn is illegal as well.

Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the
idle state instead.

Christian.


>                        amdgpu_vm_bo_relocated(bo_base);
>                else if (bo->tbo.base.resv =3D=3D vm->root.base.bo->tbo.ba=
se.resv)
>                        amdgpu_vm_bo_moved(bo_base);


--_000_SN6PR12MB28004896C5D08FC3F4BBE2A787190SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<meta content=3D"text/html; charset=3Dus-ascii">
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
If so the function name does not match its functionality.&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div><br>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Sunday, February 9, 2020 4:21:13 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated=
 list</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 09.02.20 um 03:52 schrieb Pan, Xinhui:<br>
&gt; hit panic when we update the page tables.<br>
&gt;<br>
&gt; &lt;1&gt;[&nbsp; 122.103290] BUG: kernel NULL pointer dereference, add=
ress: 0000000000000008<br>
&gt; &lt;1&gt;[&nbsp; 122.103348] #PF: supervisor read access in kernel mod=
e<br>
&gt; &lt;1&gt;[&nbsp; 122.103376] #PF: error_code(0x0000) - not-present pag=
e<br>
&gt; &lt;6&gt;[&nbsp; 122.103403] PGD 0 P4D 0<br>
&gt; &lt;4&gt;[&nbsp; 122.103421] Oops: 0000 [#1] SMP PTI<br>
&gt; &lt;4&gt;[&nbsp; 122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: =
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp=
;&nbsp;&nbsp; 5.4.0-rc7&#43; #7<br>
&gt; &lt;4&gt;[&nbsp; 122.103480] Hardware name: Supermicro SYS-7048GR-TR/X=
10DRG-Q, BIOS 3.0b 03/09/2018<br>
&gt; &lt;4&gt;[&nbsp; 122.103657] RIP: 0010:amdgpu_vm_update_pdes&#43;0x140=
/0x330 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00=
 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b=
 80 20 04 00 00 &lt;4d&gt; 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 =
0f 48 8b 80 28<br>
&gt; &lt;4&gt;[&nbsp; 122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 000102=
46<br>
&gt; &lt;4&gt;[&nbsp; 122.103797] RAX: 0000000000000000 RBX: ffff9020f823c1=
48 RCX: dead000000000122<br>
&gt; &lt;4&gt;[&nbsp; 122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0=
c8 RDI: ffff9010ca31c800<br>
&gt; &lt;4&gt;[&nbsp; 122.103865] RBP: ffffb49a0a6a3b38 R08: 00000000000000=
00 R09: 0000000000000001<br>
&gt; &lt;4&gt;[&nbsp; 122.103899] R10: 000000006044f994 R11: 00000000df57fb=
58 R12: ffff9020f823c000<br>
&gt; &lt;4&gt;[&nbsp; 122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0=
c8 R15: ffff9010d5d20000<br>
&gt; &lt;4&gt;[&nbsp; 122.103968] FS:&nbsp; 00007f32c83dc780(0000) GS:ffff9=
020ff380000(0000) knlGS:0000000000000000<br>
&gt; &lt;4&gt;[&nbsp; 122.104006] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033<br>
&gt; &lt;4&gt;[&nbsp; 122.104035] CR2: 0000000000000008 CR3: 0000002036bba0=
05 CR4: 00000000003606e0<br>
&gt; &lt;4&gt;[&nbsp; 122.104069] DR0: 0000000000000000 DR1: 00000000000000=
00 DR2: 0000000000000000<br>
&gt; &lt;4&gt;[&nbsp; 122.104103] DR3: 0000000000000000 DR6: 00000000fffe0f=
f0 DR7: 0000000000000400<br>
&gt; &lt;4&gt;[&nbsp; 122.104137] Call Trace:<br>
&gt; &lt;4&gt;[&nbsp; 122.104241]&nbsp; vm_update_pds&#43;0x31/0x50 [amdgpu=
]<br>
&gt; &lt;4&gt;[&nbsp; 122.104347]&nbsp; amdgpu_amdkfd_gpuvm_map_memory_to_g=
pu&#43;0x2ef/0x690 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104466]&nbsp; kfd_process_alloc_gpuvm&#43;0x98/0x=
190 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104576]&nbsp; kfd_process_device_init_vm.part.8&#=
43;0xf3/0x1f0 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104688]&nbsp; kfd_process_device_init_vm&#43;0x24=
/0x30 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104794]&nbsp; kfd_ioctl_acquire_vm&#43;0xa4/0xc0 =
[amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104900]&nbsp; kfd_ioctl&#43;0x277/0x500 [amdgpu]<=
br>
&gt; &lt;4&gt;[&nbsp; 122.105001]&nbsp; ? kfd_ioctl_free_memory_of_gpu&#43;=
0xc0/0xc0 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.105039]&nbsp; ? rcu_read_lock_sched_held&#43;0x4f=
/0x80<br>
&gt; &lt;4&gt;[&nbsp; 122.105068]&nbsp; ? kmem_cache_free&#43;0x2ba/0x300<b=
r>
&gt; &lt;4&gt;[&nbsp; 122.105093]&nbsp; ? vm_area_free&#43;0x18/0x20<br>
&gt; &lt;4&gt;[&nbsp; 122.105117]&nbsp; ? find_held_lock&#43;0x35/0xa0<br>
&gt; &lt;4&gt;[&nbsp; 122.105143]&nbsp; do_vfs_ioctl&#43;0xa9/0x6f0<br>
&gt; &lt;4&gt;[&nbsp; 122.106001]&nbsp; ksys_ioctl&#43;0x75/0x80<br>
&gt; &lt;4&gt;[&nbsp; 122.106802]&nbsp; ? do_syscall_64&#43;0x17/0x230<br>
&gt; &lt;4&gt;[&nbsp; 122.107605]&nbsp; __x64_sys_ioctl&#43;0x1a/0x20<br>
&gt; &lt;4&gt;[&nbsp; 122.108378]&nbsp; do_syscall_64&#43;0x5f/0x230<br>
&gt; &lt;4&gt;[&nbsp; 122.109118]&nbsp; entry_SYSCALL_64_after_hwframe&#43;=
0x49/0xbe<br>
&gt; &lt;4&gt;[&nbsp; 122.109842] RIP: 0033:0x7f32c6b495d7<br>
&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 3195bc90985a..3c388fdf335c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -2619,7 &#43;2619,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bo_base-&gt;moved =3D true;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (bo-&gt;tbo.type =3D=3D ttm_bo_type_kernel)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (bo-&gt;tbo.type =3D=3D ttm_bo_type_kernel &amp;&amp; bo-&gt;par=
ent)<br>
<br>
Good catch, but that would mean that we move the root PD to the moved <br>
state which in turn is illegal as well.<br>
<br>
Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the <br=
>
idle state instead.<br>
<br>
Christian.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_bo_relocated(bo_base);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (bo-&gt;tbo.base.resv =3D=3D vm-&gt;root.base.b=
o-&gt;tbo.base.resv)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_bo_moved(bo_base);<br>
<br>
</div>
</span></font></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Sunday, February 9, 2020 4:21:13 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated=
 list</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 09.02.20 um 03:52 schrieb Pan, Xinhui:<br>
&gt; hit panic when we update the page tables.<br>
&gt;<br>
&gt; &lt;1&gt;[&nbsp; 122.103290] BUG: kernel NULL pointer dereference, add=
ress: 0000000000000008<br>
&gt; &lt;1&gt;[&nbsp; 122.103348] #PF: supervisor read access in kernel mod=
e<br>
&gt; &lt;1&gt;[&nbsp; 122.103376] #PF: error_code(0x0000) - not-present pag=
e<br>
&gt; &lt;6&gt;[&nbsp; 122.103403] PGD 0 P4D 0<br>
&gt; &lt;4&gt;[&nbsp; 122.103421] Oops: 0000 [#1] SMP PTI<br>
&gt; &lt;4&gt;[&nbsp; 122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: =
G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp=
;&nbsp;&nbsp; 5.4.0-rc7&#43; #7<br>
&gt; &lt;4&gt;[&nbsp; 122.103480] Hardware name: Supermicro SYS-7048GR-TR/X=
10DRG-Q, BIOS 3.0b 03/09/2018<br>
&gt; &lt;4&gt;[&nbsp; 122.103657] RIP: 0010:amdgpu_vm_update_pdes&#43;0x140=
/0x330 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00=
 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b=
 80 20 04 00 00 &lt;4d&gt; 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 =
0f 48 8b 80 28<br>
&gt; &lt;4&gt;[&nbsp; 122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 000102=
46<br>
&gt; &lt;4&gt;[&nbsp; 122.103797] RAX: 0000000000000000 RBX: ffff9020f823c1=
48 RCX: dead000000000122<br>
&gt; &lt;4&gt;[&nbsp; 122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0=
c8 RDI: ffff9010ca31c800<br>
&gt; &lt;4&gt;[&nbsp; 122.103865] RBP: ffffb49a0a6a3b38 R08: 00000000000000=
00 R09: 0000000000000001<br>
&gt; &lt;4&gt;[&nbsp; 122.103899] R10: 000000006044f994 R11: 00000000df57fb=
58 R12: ffff9020f823c000<br>
&gt; &lt;4&gt;[&nbsp; 122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0=
c8 R15: ffff9010d5d20000<br>
&gt; &lt;4&gt;[&nbsp; 122.103968] FS:&nbsp; 00007f32c83dc780(0000) GS:ffff9=
020ff380000(0000) knlGS:0000000000000000<br>
&gt; &lt;4&gt;[&nbsp; 122.104006] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000=
0000080050033<br>
&gt; &lt;4&gt;[&nbsp; 122.104035] CR2: 0000000000000008 CR3: 0000002036bba0=
05 CR4: 00000000003606e0<br>
&gt; &lt;4&gt;[&nbsp; 122.104069] DR0: 0000000000000000 DR1: 00000000000000=
00 DR2: 0000000000000000<br>
&gt; &lt;4&gt;[&nbsp; 122.104103] DR3: 0000000000000000 DR6: 00000000fffe0f=
f0 DR7: 0000000000000400<br>
&gt; &lt;4&gt;[&nbsp; 122.104137] Call Trace:<br>
&gt; &lt;4&gt;[&nbsp; 122.104241]&nbsp; vm_update_pds&#43;0x31/0x50 [amdgpu=
]<br>
&gt; &lt;4&gt;[&nbsp; 122.104347]&nbsp; amdgpu_amdkfd_gpuvm_map_memory_to_g=
pu&#43;0x2ef/0x690 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104466]&nbsp; kfd_process_alloc_gpuvm&#43;0x98/0x=
190 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104576]&nbsp; kfd_process_device_init_vm.part.8&#=
43;0xf3/0x1f0 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104688]&nbsp; kfd_process_device_init_vm&#43;0x24=
/0x30 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104794]&nbsp; kfd_ioctl_acquire_vm&#43;0xa4/0xc0 =
[amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.104900]&nbsp; kfd_ioctl&#43;0x277/0x500 [amdgpu]<=
br>
&gt; &lt;4&gt;[&nbsp; 122.105001]&nbsp; ? kfd_ioctl_free_memory_of_gpu&#43;=
0xc0/0xc0 [amdgpu]<br>
&gt; &lt;4&gt;[&nbsp; 122.105039]&nbsp; ? rcu_read_lock_sched_held&#43;0x4f=
/0x80<br>
&gt; &lt;4&gt;[&nbsp; 122.105068]&nbsp; ? kmem_cache_free&#43;0x2ba/0x300<b=
r>
&gt; &lt;4&gt;[&nbsp; 122.105093]&nbsp; ? vm_area_free&#43;0x18/0x20<br>
&gt; &lt;4&gt;[&nbsp; 122.105117]&nbsp; ? find_held_lock&#43;0x35/0xa0<br>
&gt; &lt;4&gt;[&nbsp; 122.105143]&nbsp; do_vfs_ioctl&#43;0xa9/0x6f0<br>
&gt; &lt;4&gt;[&nbsp; 122.106001]&nbsp; ksys_ioctl&#43;0x75/0x80<br>
&gt; &lt;4&gt;[&nbsp; 122.106802]&nbsp; ? do_syscall_64&#43;0x17/0x230<br>
&gt; &lt;4&gt;[&nbsp; 122.107605]&nbsp; __x64_sys_ioctl&#43;0x1a/0x20<br>
&gt; &lt;4&gt;[&nbsp; 122.108378]&nbsp; do_syscall_64&#43;0x5f/0x230<br>
&gt; &lt;4&gt;[&nbsp; 122.109118]&nbsp; entry_SYSCALL_64_after_hwframe&#43;=
0x49/0xbe<br>
&gt; &lt;4&gt;[&nbsp; 122.109842] RIP: 0033:0x7f32c6b495d7<br>
&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 3195bc90985a..3c388fdf335c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -2619,7 &#43;2619,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bo_base-&gt;moved =3D true;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (bo-&gt;tbo.type =3D=3D ttm_bo_type_kernel)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (bo-&gt;tbo.type =3D=3D ttm_bo_type_kernel &amp;&amp; bo-&gt;par=
ent)<br>
<br>
Good catch, but that would mean that we move the root PD to the moved <br>
state which in turn is illegal as well.<br>
<br>
Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the <br=
>
idle state instead.<br>
<br>
Christian.<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_bo_relocated(bo_base);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if (bo-&gt;tbo.base.resv =3D=3D vm-&gt;root.base.b=
o-&gt;tbo.base.resv)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
vm_bo_moved(bo_base);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN6PR12MB28004896C5D08FC3F4BBE2A787190SN6PR12MB2800namp_--

--===============0975517894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0975517894==--
