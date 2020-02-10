Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF93C352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 09:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB63214DB
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bn2QX0hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB63214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D096E1F3;
	Mon, 10 Feb 2020 09:31:44 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEA16E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 09:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEgPsQ2jcJkgeAWDy14WVG7dF+b9/NooO6TbIVUb9p66dt5vi0aLyuhL1Fc6Xc44z+OJC7iey6wMDFKHk6KuXtTykuC74EYkSGAdthxIMmknx/CQZl0IoM7MpOSIvXzkumG0Mnx2uxaX/2R4k6rgZdnvNuFJ4zDPZQEndxtM3PAagwhpktyWK558yZRavthki4m0mTTKk+oLLCRIbCzPWKWNKYoW69rl0X9nJ9c5zDAiKiE37+cBCWAds8CXKblwl8F+Ng02RaTeXhzGn3vD9n874zd2bElbaAnC6+tXqVuAc4AIx/aeQuF77ir3QrUT5GXE8+nTq6+9sBTTcsYvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYXpjwGYis01aBkehwO2PuPLdmIMxMeKCj/6RPkfiME=;
 b=oBnjJ1+fGHmLo1lRQWPNFIsdZwikA0ibe6DJsM8E5wzldAYzYAO1QV/UWgzwx6vw6rSMrRcgPq64uuCSy+BeMCpG+qDtu96UK7mN/SdHxNpThYv/cFT/8kz9F/8Ht0bWjIbPK+nitBYEGs07okVezkeBZQJ1P1dmYYZmJu4VlS0Dle4OFuWPbj+tFgHBeWQYjgn/0gQTZu/i4u2ZlOwOxK9NCD7tiSmPkpycVUYWckbSfFk774A3gyny9ngS0KqxVPatCSq8v/iWzHgPsXetjIVCizNT4ipJQQegdirbTBkLVxkGCAaVMLu+K9i2l7zUqs4ZNr3T8X2y+mR+j/99YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYXpjwGYis01aBkehwO2PuPLdmIMxMeKCj/6RPkfiME=;
 b=Bn2QX0hEBFlHjPvbEVhsYizTE2QAqKPanK3K/2v+A0m74/j+jOdZWstA/MNonCjL7CGfhVCyavzwK4G20ynAuVvyRmswo876HBrGfV4I1rBXNAogX6iR2Qlbhq34zO1gKTvRVKHZKikFCHEvWDq+vlmlaN4Tqdh45QifaxOJ7n8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2374.namprd12.prod.outlook.com (52.132.141.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Mon, 10 Feb 2020 09:31:38 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.028; Mon, 10 Feb
 2020 09:31:38 +0000
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB2800EB2C9B3EE8BC3DC6B664871E0@SN6PR12MB2800.namprd12.prod.outlook.com>
 <cb22f498-f1c5-fa7b-ffb7-643ef9a584ff@gmail.com>
 <SN6PR12MB28004896C5D08FC3F4BBE2A787190@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6b6d763d-beb3-10fe-5eff-be6ba4d13bc6@amd.com>
Date: Mon, 10 Feb 2020 10:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB28004896C5D08FC3F4BBE2A787190@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::24) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 09:31:37 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e360066-c03e-482e-ccc3-08d7ae0c075f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:|DM5PR12MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237472C6B225C6F27563E63C83190@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(316002)(81156014)(81166006)(33964004)(2906002)(52116002)(66476007)(66946007)(66556008)(86362001)(6666004)(478600001)(31696002)(36756003)(16526019)(8936002)(66574012)(186003)(5660300002)(30864003)(6486002)(110136005)(8676002)(53546011)(2616005)(4326008)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2374;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK4UOKIZ+ZOudsw9oDo/e6EZmyGXCEINSA+yzLrMw6AT1Oc3pqdcyVfA5I+AMFiZZYem8jcbiQL5KHhK6Ohe3gbusKl+pu4WHImlrt0P7Z+XTnVTFsghGwVqlvTEeXsgxgTzSo81Ik7WmbftEj6u0mN+cpBad+lV6GIwAOt8NmbGLviPzK+ydwj8RgjRXxbonDxqEQKdAADK1NakmAD839BE2wrKzVbPN4qy+WejRRWDuiqk4aLWq7WrA+6SzIn+Ti3iCj3a0bpNKSfXWJWatXb1O1alpmL4xUi9ktQFYmOcuOuyzYqhJ6NlIIofLoePiDIBwoNohSwgKN+P+i4UjIpyW233RO4vi40pSNQxg6f7WDkSWdt2mLrYSlbr+uFj7LetsxQBjwBpDlbANf12XFQRBxYxluk2CVLBOcBmw5N9lkLbTdi6Z2/AWQkG+9PN
X-MS-Exchange-AntiSpam-MessageData: 4KBmZNBDqE2WDBg1zpjAuUB9FSGB1ZIZFcFfZnjPC6mn7buJLXFJKRKmHa3RP76KRTMzJ+wLTYdhIHxyah309sS1LlDbZp/AMHswbrYdqJjbVgOBAzKvOl+6UQvFzJaaiPGFAvOMePtQvksQlFdPl/i8mqBQDr/96S1pyw4nx5YuopsNUiR2jOuco3xKNwPynuykiInOfLTJTVtTtxzpkw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e360066-c03e-482e-ccc3-08d7ae0c075f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:31:38.6422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fTnSPLCUGYImiaVzLCPYUmfCk1DZdAOQMGLiQymqixSKP3QemFEMDmx+cqmZO3m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0867058138=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0867058138==
Content-Type: multipart/alternative;
 boundary="------------53FF26C93C3C50C00C0180D7"
Content-Language: en-US

--------------53FF26C93C3C50C00C0180D7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, that is indeed partially true.

But we already have the same logic in amdgpu_vm_bo_base_init() and 
amdgpu_vm_validate_pt_bos(). Just in the functions 
amdgpu_vm_invalidate_pds() and amdgpu_vm_bo_invalidate() the handling 
seems to be incorrect.

Still sounds like a good idea to me to have this logic in a common place 
and not duplicated multiple times.

And the function name is still correct if we think about it as a state 
of the bo_va instead of a helper to put thinks on a list. It's just that 
for the root PD we can skip this state change and go directly to the 
idle state.

Regards,
Christian.

Am 10.02.20 um 01:59 schrieb Pan, Xinhui:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> If so the function name does not match its functionality.
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Sunday, February 9, 2020 4:21:13 PM
> *To:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated 
> list
> Am 09.02.20 um 03:52 schrieb Pan, Xinhui:
> > hit panic when we update the page tables.
> >
> > <1>[  122.103290] BUG: kernel NULL pointer dereference, address: 
> 0000000000000008
> > <1>[  122.103348] #PF: supervisor read access in kernel mode
> > <1>[  122.103376] #PF: error_code(0x0000) - not-present page
> > <6>[  122.103403] PGD 0 P4D 0
> > <4>[  122.103421] Oops: 0000 [#1] SMP PTI
> > <4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: 
> G           OE     5.4.0-rc7+ #7
> > <4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, 
> BIOS 3.0b 03/09/2018
> > <4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
> > <4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b 
> f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 
> 20 04 00 00 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 
> 8b 80 28
> > <4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
> > <4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: 
> dead000000000122
> > <4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: 
> ffff9010ca31c800
> > <4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 
> 0000000000000001
> > <4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: 
> ffff9020f823c000
> > <4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: 
> ffff9010d5d20000
> > <4>[  122.103968] FS:  00007f32c83dc780(0000) 
> GS:ffff9020ff380000(0000) knlGS:0000000000000000
> > <4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 
> 00000000003606e0
> > <4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> > <4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> > <4>[  122.104137] Call Trace:
> > <4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
> > <4>[  122.104347] amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 
> [amdgpu]
> > <4>[  122.104466] kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
> > <4>[  122.104576] kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
> > <4>[  122.104688] kfd_process_device_init_vm+0x24/0x30 [amdgpu]
> > <4>[  122.104794] kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
> > <4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
> > <4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
> > <4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
> > <4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
> > <4>[  122.105093]  ? vm_area_free+0x18/0x20
> > <4>[  122.105117]  ? find_held_lock+0x35/0xa0
> > <4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
> > <4>[  122.106001]  ksys_ioctl+0x75/0x80
> > <4>[  122.106802]  ? do_syscall_64+0x17/0x230
> > <4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
> > <4>[  122.108378]  do_syscall_64+0x5f/0x230
> > <4>[  122.109118] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > <4>[  122.109842] RIP: 0033:0x7f32c6b495d7
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 3195bc90985a..3c388fdf335c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2619,7 +2619,7 @@ void amdgpu_vm_bo_invalidate(struct 
> amdgpu_device *adev,
> >                        continue;
> >                bo_base->moved = true;
> >
> > -             if (bo->tbo.type == ttm_bo_type_kernel)
> > +             if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>
> Good catch, but that would mean that we move the root PD to the moved
> state which in turn is illegal as well.
>
> Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the
> idle state instead.
>
> Christian.
>
>
> > amdgpu_vm_bo_relocated(bo_base);
> >                else if (bo->tbo.base.resv == 
> vm->root.base.bo->tbo.base.resv)
> >                        amdgpu_vm_bo_moved(bo_base);
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Sunday, February 9, 2020 4:21:13 PM
> *To:* Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated 
> list
> Am 09.02.20 um 03:52 schrieb Pan, Xinhui:
> > hit panic when we update the page tables.
> >
> > <1>[  122.103290] BUG: kernel NULL pointer dereference, address: 
> 0000000000000008
> > <1>[  122.103348] #PF: supervisor read access in kernel mode
> > <1>[  122.103376] #PF: error_code(0x0000) - not-present page
> > <6>[  122.103403] PGD 0 P4D 0
> > <4>[  122.103421] Oops: 0000 [#1] SMP PTI
> > <4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: 
> G           OE     5.4.0-rc7+ #7
> > <4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, 
> BIOS 3.0b 03/09/2018
> > <4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
> > <4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b 
> f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 
> 20 04 00 00 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 
> 8b 80 28
> > <4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
> > <4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: 
> dead000000000122
> > <4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: 
> ffff9010ca31c800
> > <4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 
> 0000000000000001
> > <4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: 
> ffff9020f823c000
> > <4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: 
> ffff9010d5d20000
> > <4>[  122.103968] FS:  00007f32c83dc780(0000) 
> GS:ffff9020ff380000(0000) knlGS:0000000000000000
> > <4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 
> 00000000003606e0
> > <4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> > <4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> > <4>[  122.104137] Call Trace:
> > <4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
> > <4>[  122.104347] amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 
> [amdgpu]
> > <4>[  122.104466] kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
> > <4>[  122.104576] kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
> > <4>[  122.104688] kfd_process_device_init_vm+0x24/0x30 [amdgpu]
> > <4>[  122.104794] kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
> > <4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
> > <4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
> > <4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
> > <4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
> > <4>[  122.105093]  ? vm_area_free+0x18/0x20
> > <4>[  122.105117]  ? find_held_lock+0x35/0xa0
> > <4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
> > <4>[  122.106001]  ksys_ioctl+0x75/0x80
> > <4>[  122.106802]  ? do_syscall_64+0x17/0x230
> > <4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
> > <4>[  122.108378]  do_syscall_64+0x5f/0x230
> > <4>[  122.109118] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > <4>[  122.109842] RIP: 0033:0x7f32c6b495d7
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 3195bc90985a..3c388fdf335c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2619,7 +2619,7 @@ void amdgpu_vm_bo_invalidate(struct 
> amdgpu_device *adev,
> >                        continue;
> >                bo_base->moved = true;
> >
> > -             if (bo->tbo.type == ttm_bo_type_kernel)
> > +             if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>
> Good catch, but that would mean that we move the root PD to the moved
> state which in turn is illegal as well.
>
> Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the
> idle state instead.
>
> Christian.
>
>
> > amdgpu_vm_bo_relocated(bo_base);
> >                else if (bo->tbo.base.resv == 
> vm->root.base.bo->tbo.base.resv)
> >                        amdgpu_vm_bo_moved(bo_base);
>


--------------53FF26C93C3C50C00C0180D7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, that is indeed partially true.<br>
      <br>
      But we already have the same logic in amdgpu_vm_bo_base_init() and
      amdgpu_vm_validate_pt_bos(). Just in the functions
      amdgpu_vm_invalidate_pds() and amdgpu_vm_bo_invalidate() the
      handling seems to be incorrect.<br>
      <br>
      Still sounds like a good idea to me to have this logic in a common
      place and not duplicated multiple times.<br>
      <br>
      And the function name is still correct if we think about it as a
      state of the bo_va instead of a helper to put thinks on a list.
      It's just that for the root PD we can skip this state change and
      go directly to the idle state.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 10.02.20 um 01:59 schrieb Pan, Xinhui:<br>
    </div>
    <blockquote type="cite" cite="mid:SN6PR12MB28004896C5D08FC3F4BBE2A787190@SN6PR12MB2800.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div>
          <meta content="text/html; charset=us-ascii">
        </div>
        <div dir="auto" style="direction:ltr; margin:0; padding:0;
          font-family:sans-serif; font-size:11pt; color:black">
          If so the function name does not match its functionality.&nbsp;</div>
        <div id="ms-outlook-mobile-signature" dir="auto" style="text-align: left;">
          <div><br>
          </div>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Sunday, February 9, 2020 4:21:13 PM<br>
            <b>To:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Do not move root PT
            bo to relocated list</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText">Am 09.02.20 um 03:52 schrieb Pan,
                Xinhui:<br>
                &gt; hit panic when we update the page tables.<br>
                &gt;<br>
                &gt; &lt;1&gt;[&nbsp; 122.103290] BUG: kernel NULL pointer
                dereference, address: 0000000000000008<br>
                &gt; &lt;1&gt;[&nbsp; 122.103348] #PF: supervisor read access
                in kernel mode<br>
                &gt; &lt;1&gt;[&nbsp; 122.103376] #PF: error_code(0x0000) -
                not-present page<br>
                &gt; &lt;6&gt;[&nbsp; 122.103403] PGD 0 P4D 0<br>
                &gt; &lt;4&gt;[&nbsp; 122.103421] Oops: 0000 [#1] SMP PTI<br>
                &gt; &lt;4&gt;[&nbsp; 122.103442] CPU: 13 PID: 2133 Comm:
                kfdtest Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.4.0-rc7&#43; #7<br>
                &gt; &lt;4&gt;[&nbsp; 122.103480] Hardware name: Supermicro
                SYS-7048GR-TR/X10DRG-Q, BIOS 3.0b 03/09/2018<br>
                &gt; &lt;4&gt;[&nbsp; 122.103657] RIP:
                0010:amdgpu_vm_update_pdes&#43;0x140/0x330 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.103689] Code: 03 4c 89 73 08 49 89
                9d c8 00 00 00 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87
                28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 00
                &lt;4d&gt; 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0
                74 0f 48 8b 80 28<br>
                &gt; &lt;4&gt;[&nbsp; 122.103769] RSP: 0018:ffffb49a0a6a3a98
                EFLAGS: 00010246<br>
                &gt; &lt;4&gt;[&nbsp; 122.103797] RAX: 0000000000000000 RBX:
                ffff9020f823c148 RCX: dead000000000122<br>
                &gt; &lt;4&gt;[&nbsp; 122.103831] RDX: ffff9020ece70018 RSI:
                ffff9020f823c0c8 RDI: ffff9010ca31c800<br>
                &gt; &lt;4&gt;[&nbsp; 122.103865] RBP: ffffb49a0a6a3b38 R08:
                0000000000000000 R09: 0000000000000001<br>
                &gt; &lt;4&gt;[&nbsp; 122.103899] R10: 000000006044f994 R11:
                00000000df57fb58 R12: ffff9020f823c000<br>
                &gt; &lt;4&gt;[&nbsp; 122.103933] R13: ffff9020f823c000 R14:
                ffff9020f823c0c8 R15: ffff9010d5d20000<br>
                &gt; &lt;4&gt;[&nbsp; 122.103968] FS:&nbsp; 00007f32c83dc780(0000)
                GS:ffff9020ff380000(0000) knlGS:0000000000000000<br>
                &gt; &lt;4&gt;[&nbsp; 122.104006] CS:&nbsp; 0010 DS: 0000 ES: 0000
                CR0: 0000000080050033<br>
                &gt; &lt;4&gt;[&nbsp; 122.104035] CR2: 0000000000000008 CR3:
                0000002036bba005 CR4: 00000000003606e0<br>
                &gt; &lt;4&gt;[&nbsp; 122.104069] DR0: 0000000000000000 DR1:
                0000000000000000 DR2: 0000000000000000<br>
                &gt; &lt;4&gt;[&nbsp; 122.104103] DR3: 0000000000000000 DR6:
                00000000fffe0ff0 DR7: 0000000000000400<br>
                &gt; &lt;4&gt;[&nbsp; 122.104137] Call Trace:<br>
                &gt; &lt;4&gt;[&nbsp; 122.104241]&nbsp; vm_update_pds&#43;0x31/0x50
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104347]&nbsp;
                amdgpu_amdkfd_gpuvm_map_memory_to_gpu&#43;0x2ef/0x690
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104466]&nbsp;
                kfd_process_alloc_gpuvm&#43;0x98/0x190 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104576]&nbsp;
                kfd_process_device_init_vm.part.8&#43;0xf3/0x1f0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104688]&nbsp;
                kfd_process_device_init_vm&#43;0x24/0x30 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104794]&nbsp;
                kfd_ioctl_acquire_vm&#43;0xa4/0xc0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104900]&nbsp; kfd_ioctl&#43;0x277/0x500
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.105001]&nbsp; ?
                kfd_ioctl_free_memory_of_gpu&#43;0xc0/0xc0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.105039]&nbsp; ?
                rcu_read_lock_sched_held&#43;0x4f/0x80<br>
                &gt; &lt;4&gt;[&nbsp; 122.105068]&nbsp; ?
                kmem_cache_free&#43;0x2ba/0x300<br>
                &gt; &lt;4&gt;[&nbsp; 122.105093]&nbsp; ? vm_area_free&#43;0x18/0x20<br>
                &gt; &lt;4&gt;[&nbsp; 122.105117]&nbsp; ? find_held_lock&#43;0x35/0xa0<br>
                &gt; &lt;4&gt;[&nbsp; 122.105143]&nbsp; do_vfs_ioctl&#43;0xa9/0x6f0<br>
                &gt; &lt;4&gt;[&nbsp; 122.106001]&nbsp; ksys_ioctl&#43;0x75/0x80<br>
                &gt; &lt;4&gt;[&nbsp; 122.106802]&nbsp; ? do_syscall_64&#43;0x17/0x230<br>
                &gt; &lt;4&gt;[&nbsp; 122.107605]&nbsp; __x64_sys_ioctl&#43;0x1a/0x20<br>
                &gt; &lt;4&gt;[&nbsp; 122.108378]&nbsp; do_syscall_64&#43;0x5f/0x230<br>
                &gt; &lt;4&gt;[&nbsp; 122.109118]&nbsp;
                entry_SYSCALL_64_after_hwframe&#43;0x49/0xbe<br>
                &gt; &lt;4&gt;[&nbsp; 122.109842] RIP: 0033:0x7f32c6b495d7<br>
                &gt;<br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index 3195bc90985a..3c388fdf335c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -2619,7 &#43;2619,7 @@ void
                amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_base-&gt;moved = true;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.type ==
                ttm_bo_type_kernel)<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.type ==
                ttm_bo_type_kernel &amp;&amp; bo-&gt;parent)<br>
                <br>
                Good catch, but that would mean that we move the root PD
                to the moved <br>
                state which in turn is illegal as well.<br>
                <br>
                Maybe better adjust amdgpu_vm_bo_relocated() to move the
                root PD to the <br>
                idle state instead.<br>
                <br>
                Christian.<br>
                <br>
                <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_vm_bo_relocated(bo_base);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (bo-&gt;tbo.base.resv ==
                vm-&gt;root.base.bo-&gt;tbo.base.resv)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_moved(bo_base);<br>
                <br>
              </div>
            </span></font></div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Sunday, February 9, 2020 4:21:13 PM<br>
            <b>To:</b> Pan, Xinhui <a class="moz-txt-link-rfc2396E" href="mailto:Xinhui.Pan@amd.com">&lt;Xinhui.Pan@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Do not move root PT
            bo to relocated list</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 09.02.20 um 03:52 schrieb Pan,
                Xinhui:<br>
                &gt; hit panic when we update the page tables.<br>
                &gt;<br>
                &gt; &lt;1&gt;[&nbsp; 122.103290] BUG: kernel NULL pointer
                dereference, address: 0000000000000008<br>
                &gt; &lt;1&gt;[&nbsp; 122.103348] #PF: supervisor read access
                in kernel mode<br>
                &gt; &lt;1&gt;[&nbsp; 122.103376] #PF: error_code(0x0000) -
                not-present page<br>
                &gt; &lt;6&gt;[&nbsp; 122.103403] PGD 0 P4D 0<br>
                &gt; &lt;4&gt;[&nbsp; 122.103421] Oops: 0000 [#1] SMP PTI<br>
                &gt; &lt;4&gt;[&nbsp; 122.103442] CPU: 13 PID: 2133 Comm:
                kfdtest Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp; 5.4.0-rc7&#43; #7<br>
                &gt; &lt;4&gt;[&nbsp; 122.103480] Hardware name: Supermicro
                SYS-7048GR-TR/X10DRG-Q, BIOS 3.0b 03/09/2018<br>
                &gt; &lt;4&gt;[&nbsp; 122.103657] RIP:
                0010:amdgpu_vm_update_pdes&#43;0x140/0x330 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.103689] Code: 03 4c 89 73 08 49 89
                9d c8 00 00 00 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87
                28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 00
                &lt;4d&gt; 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0
                74 0f 48 8b 80 28<br>
                &gt; &lt;4&gt;[&nbsp; 122.103769] RSP: 0018:ffffb49a0a6a3a98
                EFLAGS: 00010246<br>
                &gt; &lt;4&gt;[&nbsp; 122.103797] RAX: 0000000000000000 RBX:
                ffff9020f823c148 RCX: dead000000000122<br>
                &gt; &lt;4&gt;[&nbsp; 122.103831] RDX: ffff9020ece70018 RSI:
                ffff9020f823c0c8 RDI: ffff9010ca31c800<br>
                &gt; &lt;4&gt;[&nbsp; 122.103865] RBP: ffffb49a0a6a3b38 R08:
                0000000000000000 R09: 0000000000000001<br>
                &gt; &lt;4&gt;[&nbsp; 122.103899] R10: 000000006044f994 R11:
                00000000df57fb58 R12: ffff9020f823c000<br>
                &gt; &lt;4&gt;[&nbsp; 122.103933] R13: ffff9020f823c000 R14:
                ffff9020f823c0c8 R15: ffff9010d5d20000<br>
                &gt; &lt;4&gt;[&nbsp; 122.103968] FS:&nbsp; 00007f32c83dc780(0000)
                GS:ffff9020ff380000(0000) knlGS:0000000000000000<br>
                &gt; &lt;4&gt;[&nbsp; 122.104006] CS:&nbsp; 0010 DS: 0000 ES: 0000
                CR0: 0000000080050033<br>
                &gt; &lt;4&gt;[&nbsp; 122.104035] CR2: 0000000000000008 CR3:
                0000002036bba005 CR4: 00000000003606e0<br>
                &gt; &lt;4&gt;[&nbsp; 122.104069] DR0: 0000000000000000 DR1:
                0000000000000000 DR2: 0000000000000000<br>
                &gt; &lt;4&gt;[&nbsp; 122.104103] DR3: 0000000000000000 DR6:
                00000000fffe0ff0 DR7: 0000000000000400<br>
                &gt; &lt;4&gt;[&nbsp; 122.104137] Call Trace:<br>
                &gt; &lt;4&gt;[&nbsp; 122.104241]&nbsp; vm_update_pds&#43;0x31/0x50
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104347]&nbsp;
                amdgpu_amdkfd_gpuvm_map_memory_to_gpu&#43;0x2ef/0x690
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104466]&nbsp;
                kfd_process_alloc_gpuvm&#43;0x98/0x190 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104576]&nbsp;
                kfd_process_device_init_vm.part.8&#43;0xf3/0x1f0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104688]&nbsp;
                kfd_process_device_init_vm&#43;0x24/0x30 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104794]&nbsp;
                kfd_ioctl_acquire_vm&#43;0xa4/0xc0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.104900]&nbsp; kfd_ioctl&#43;0x277/0x500
                [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.105001]&nbsp; ?
                kfd_ioctl_free_memory_of_gpu&#43;0xc0/0xc0 [amdgpu]<br>
                &gt; &lt;4&gt;[&nbsp; 122.105039]&nbsp; ?
                rcu_read_lock_sched_held&#43;0x4f/0x80<br>
                &gt; &lt;4&gt;[&nbsp; 122.105068]&nbsp; ?
                kmem_cache_free&#43;0x2ba/0x300<br>
                &gt; &lt;4&gt;[&nbsp; 122.105093]&nbsp; ? vm_area_free&#43;0x18/0x20<br>
                &gt; &lt;4&gt;[&nbsp; 122.105117]&nbsp; ? find_held_lock&#43;0x35/0xa0<br>
                &gt; &lt;4&gt;[&nbsp; 122.105143]&nbsp; do_vfs_ioctl&#43;0xa9/0x6f0<br>
                &gt; &lt;4&gt;[&nbsp; 122.106001]&nbsp; ksys_ioctl&#43;0x75/0x80<br>
                &gt; &lt;4&gt;[&nbsp; 122.106802]&nbsp; ? do_syscall_64&#43;0x17/0x230<br>
                &gt; &lt;4&gt;[&nbsp; 122.107605]&nbsp; __x64_sys_ioctl&#43;0x1a/0x20<br>
                &gt; &lt;4&gt;[&nbsp; 122.108378]&nbsp; do_syscall_64&#43;0x5f/0x230<br>
                &gt; &lt;4&gt;[&nbsp; 122.109118]&nbsp;
                entry_SYSCALL_64_after_hwframe&#43;0x49/0xbe<br>
                &gt; &lt;4&gt;[&nbsp; 122.109842] RIP: 0033:0x7f32c6b495d7<br>
                &gt;<br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;-<br>
                &gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index 3195bc90985a..3c388fdf335c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -2619,7 &#43;2619,7 @@ void
                amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_base-&gt;moved = true;<br>
                &gt;&nbsp;&nbsp; <br>
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.type ==
                ttm_bo_type_kernel)<br>
                &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.type ==
                ttm_bo_type_kernel &amp;&amp; bo-&gt;parent)<br>
                <br>
                Good catch, but that would mean that we move the root PD
                to the moved <br>
                state which in turn is illegal as well.<br>
                <br>
                Maybe better adjust amdgpu_vm_bo_relocated() to move the
                root PD to the <br>
                idle state instead.<br>
                <br>
                Christian.<br>
                <br>
                <br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_vm_bo_relocated(bo_base);<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (bo-&gt;tbo.base.resv ==
                vm-&gt;root.base.bo-&gt;tbo.base.resv)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_moved(bo_base);<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------53FF26C93C3C50C00C0180D7--

--===============0867058138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0867058138==--
