Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B45C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 06:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230B10EB60;
	Fri,  1 Mar 2024 06:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEf/UqD7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C83A10EB60
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 06:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJPLv4E4akQ1vufEAHXH+EAFJmf6ZE3lSeepYbY0UAiUdFrkapOK74KCC/KbO4WFcXR1mf2uUsWc6MqJmlj2S6mLX6QH9MwV7fAkkkzXAApXGIybBmh1OJiNRtiBlXhggi1PBuxx3JOexaysRzVRyT9gz2w0T9PO+I4OI9qZH7FWqp6sOsxQBQyKyyXn/3l3IqAr23h2jjuqCirSUbMM6uxdyeA9kwPQnMGD9lU23uh9+gG0BJfHjN62V42pKqEmNtr42ra2dxfxm/vZBCblbEc9aENmFdoJVDFjsTyGDZG341iI4xVx4sk9whV/NTH4q6lRYlvHdbprhiAkXUZ8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vQO0+ov9EW5gL3/2tRdVvgXV8wBb3xt0Wv/L3UvKrY=;
 b=Z33PbxYL7Oe45rJU3vWRpPUx2kpw7yz4CLWV6EU0SMOYsk3+BGZSXuj41yPxJNnKzl79SRyCU6dER4OtRK2LeFu/blPoThlYeTjXGgGRdfKadgwPOkm0M6G6B3TRWZbtMAbQewGAqboX7BklugPlotFMLjOLlf5wra7O4qSSqPNfQmmrIjmeFkSbVYrGAXndgoWMi7XU213X3cXi8pjSo2pM+PiiC1ALxXPRKllHbQy4qpn5mis7z/LE2wxxB169kkwobpxg5Q/FsmWciuopBxQDpayt60quNduxoEiQp1ekGg//e1SAfSOzhHNKVRHu4QOl8gJWCp2453do843Lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vQO0+ov9EW5gL3/2tRdVvgXV8wBb3xt0Wv/L3UvKrY=;
 b=BEf/UqD7JgYccRNJ4N8igMBeu4z4/ITK9CvSEJx80YsCbTXa0bdJgpB/g1YEdo/t8rHFF1bib8FRe9wt6IqwOt4A6uOCPxkFs/rA+G0p301qnx+wuMEFEWb5ZRaJiRaHZ9etpRpaKStN2W3qdQu4piR7wYkcolPu6+UXQki4iGI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:35:50 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039%4]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 06:35:50 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Cornwall,
 Jay" <Jay.Cornwall@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Topic: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Index: AQHaauum2A3QqaEyJ0qsZJk0VJOnIbEhePIggADpwwCAAAV7sA==
Date: Fri, 1 Mar 2024 06:35:49 +0000
Message-ID: <CY8PR12MB7435DFBB213C5B3284F59227855E2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240229084513.86529-1-jesse.zhang@amd.com>
 <CY8PR12MB7435E75B6866EDFAA8B2B7CA855F2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DM4PR12MB51525B4157A21971D747743DE35E2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51525B4157A21971D747743DE35E2@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5dc775af-a409-4540-bec0-2ccff9622c22;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-29T15:56:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS7PR12MB8202:EE_
x-ms-office365-filtering-correlation-id: 6914f281-4fc8-40f4-423a-08dc39b9d5de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHSTw1ugEw1Xqqp9MjHCOyp0zmrAKGoPVc13WgzAtcGwmMILKNWQVJTzi2umYZebD+OHYO+5AR9B4+Inkc0Dg3pF4l5lh8GA/3mf3aIvrXlpbIYghYNiR8hGhAQ5ebWZThG0mv+Agus6IkZMfZF/cl1Num1knMFBjYuK9Lk1jWNmmr+r/UnR9ROESxnRg7PJwx/prBhFDf8TRZ3yt3XPp0V06Vc+lM8sn522d489+/P8IxZjn6WBd8ISrkNfx6jlsiFkH6E++msovZW+oLPKugAIbUvUfAEnkl8G/I9JtSqoDIxVEyK1kzB6p0/7cLgreMjGbNrUamSRY0WJTccctT2QUc4YoqboyFCvJriWSQsN/PrGKfyUc24zkXgBsrH62sTQlBdKeNchJSK3KMwz/YeqLtytfT+Zjj1s7tycplqP6BRyEfLU4KO4PFNuY8IuSSA9uYhHfDVAYwIaUQJHi9tFCjASe5oUYg4vCoe10WqabGE6tEXTy48pUo8nMJjZMD7gxBr+mttcMQ8DWJHoaKa2EqEqjT7AX6tdP9Lj/4vwTw0Hw8tIe+8vsRslYxC3VWU4rZOnmiOW55eyAyWV9d3tpHam3di1bi2mYFy3GKmx7VzfwZv+8wzBM9QrQSOslDjDjQmS/P7ydPH2g8sxPtn9RKugl+u80TNtiSfDZku5f7ZLMJYKfPZs1mKzcA8J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pVh6ooI+zfyGOHkvSsgKzzkP76jh2RYmHzjqwRJ8xeJ09JtIM4tmDKIJ5VB4?=
 =?us-ascii?Q?Tfb/aW2v1p7rXNmlp1nQ1iutbkmnWQ0wQ7drBzBZHR03Ms4KQ+KOq+6hGPmO?=
 =?us-ascii?Q?dQBpYkuTgCyxBcwK/IiiIC6XI1nIcqzaMkgEdxrS94gCIG5hQ/yMTHB6v86g?=
 =?us-ascii?Q?0vp7AaSpQUjxJ5BbJt6EnG7q6MN07jK5iLRJjiv29p1+ZaQtYp8ICsIg5qpK?=
 =?us-ascii?Q?duRnX9c0VqwtHOIJatbF8snxnCQ0Uzo1HJFLITs1JvA6cuX7Yv73hwXim84R?=
 =?us-ascii?Q?LJoMxijVvfWzwaL6Y+eg0axCgqa5J2fWq3dysgw39rDObVW30t6wFX8T1kS0?=
 =?us-ascii?Q?wgrvp+ZKQV3/SqCRacC2tS8DjuxiMce62IxdYEOYDBhyUg/NKYRKaTb6f9gx?=
 =?us-ascii?Q?e6BJPNeFQSV8Q0HDF4EU0dQMwLVf2pkHGLWHY1JDcM1CbZpr4Hya/AuT13f+?=
 =?us-ascii?Q?Y1ZdpelphbCaO9b2JZdeNuhckJG+RmKj+h8uzTmQBN63yNdoIYYoHZqttOfh?=
 =?us-ascii?Q?uBZ4hpdTxbQv58+C+z/rUXwKZbgHFP5eskWLCMz+qY5qibnojwY0BQucK12o?=
 =?us-ascii?Q?3CtenASg27j8gOos28t4ots2nQSbm/QZWzrBRQaFvh6FMJ2cJpDE2yK9JItf?=
 =?us-ascii?Q?2yoeMMGdIYa2ZNDD0tYmJfdNLUXPkYzBCqsWdvTmu91mrPHiOF35j7BIGdRD?=
 =?us-ascii?Q?03jzdASFC31sgPXLSTRNjzy17FK9DbP1bmJ+RcuTOEegTyKrIsn0XesZD2Cv?=
 =?us-ascii?Q?ZLCoD/1FEMwd0ivW0h/S33cAPk/husUejb3+mEGFpM1AOXIGVJX1cYb1hmIR?=
 =?us-ascii?Q?9nqBjubQ65jDsUC1iJ+KlF+dJMPnrlRZ8ooq5LA5adf1iGLJ2xPiu4HKyjMh?=
 =?us-ascii?Q?gWTEM+DCv5i0D5hG59L0eN2mCCtnsz6x7DNGdCGJRUli9JewP8Xi6yx20qtS?=
 =?us-ascii?Q?7td9XcXQ/VzdV179zuK9eJajvxcfkaR9EO4gPcO89mObN935K1SuJxf80xV2?=
 =?us-ascii?Q?nEkXwHRIdrZBqZQk0T1fLZmPbyl2g9bKJL8UYx1xKS9RcPRtxRa2QC0FeNrm?=
 =?us-ascii?Q?4vBlILcmBrEwM9jcd/kVvqXeHUSmx5SPQjK6vBxM61nx/IJp4z4WIvjJMl2U?=
 =?us-ascii?Q?IDuJFcnnVOLGaZ/mdUjivFoTjCmDDMnwUenqkDxwhgi76/S28TzzKJn4f/jM?=
 =?us-ascii?Q?jb8OLC6mkVW5ed4ceR0K68RzAWYcX+b8H8hnFmyaQec5janUCj/2V/yS52xs?=
 =?us-ascii?Q?VT969DxXadQK7dFtoPK4+vnS2oCvzkpuepaSJMgLQTEl3QEJrBETxour2ZYV?=
 =?us-ascii?Q?27DCVYM1XHuAIvRidDnJFZ1FE9tgB8VafkVxA+GPfFBXcvP9lNN+pdf9DimZ?=
 =?us-ascii?Q?8NL9KpPB9hoT6gS8wV7qbcy+TZ5h/SefsCqrkrVGdJ5jqHO9xW5eU39LsBwG?=
 =?us-ascii?Q?i2mmGNjkKybnB4S4pmsEgZge52kOraMiqkKuIApDwCBFbySpc5kRrpOSQom5?=
 =?us-ascii?Q?Ou2p+r3O3N9Rd0Ps+7NjxaxoNLxMhnLuxirjg9UgH2OFf+eteoj0rr+h+8M8?=
 =?us-ascii?Q?45S2/AN1lcXAEzXGhDU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6914f281-4fc8-40f4-423a-08dc39b9d5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 06:35:49.9346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opRGfHdOBQb+rAji3ANuMPhf3oJCcoeED2PXtZzXB2qllXRJlEJpQxkIgqQScZLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Friday, March 1, 2024 12:50 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
>
> [Public]
>
> Hi Jon,
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Thursday, February 29, 2024 11:58 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
>
> [Public]
>
> I think this was discussed in another thread.
> Exception codes should be range checked prior to applying the mask.  Rais=
ing
> null events to the debugger or runtime isn't useful.
> I haven't gotten around to fixing this yet.  I should have time this week=
.
> Just to double check, the out of bounds shift is because of a CP interrup=
t that
> generates a null exception code?
>
> [Zhang, Jesse(Jie)] Thanks for your reminder, I saw that discussion.
> In this interrupt, other fields(such as, source id, client id pasid ) are=
 correct.
> only the value of context_id0 (0xf) is invalid.
>    How about do the check ,like this:
>           } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE) {
> +                       /* filter out the invalidate context_id0 */
> +                       if (!(context_id0 >> KFD_DEBUG_CP_BAD_OP_ECODE_SH=
IFT) ||
> +                               (context_id0 >> KFD_DEBUG_CP_BAD_OP_ECODE=
_SHIFT) >
> EC_MAX)
> +                               return;

The range check should probably flag any exception prefixed as EC_QUEUE_PAC=
KET_* as valid defined in kfd_dbg_trap_exception_code:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/kfd_ioctl.=
h#L857
+ Jay to confirm this is the correct exception range for CP_BAD_OPCODE

If that's the case, then I think we can define a KFD_DBG_EC_TYPE_IS_QUEUE_P=
ACKET macro similar to:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/kfd_ioctl.=
h#L917

That way, KFD process interrupts v9, v10, v11 can use that check prior to m=
ask conversion and user space may find it useful as well.

Jon
>                         kfd_set_dbg_ev_from_interrupt(dev, pasid,
>                                 KFD_DEBUG_DOORBELL_ID(context_id0),
>
> KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
>  Thanks
>  Jesse
> Jon
>
> > -----Original Message-----
> > From: Jesse Zhang <jesse.zhang@amd.com>
> > Sent: Thursday, February 29, 2024 3:45 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Zhang,
> > Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>;
> > Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Subject: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
> >
> >  the issue is :
> > [  388.151802] UBSAN: shift-out-of-bounds in
> > drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v10.c:346:5
> > [  388.151807] shift exponent 4294967295 is too large for 64-bit type
> > 'long long unsigned int'
> > [  388.151812] CPU: 6 PID: 347 Comm: kworker/6:1H Tainted: G           =
 E
> > 6.7.0+ #1
> > [  388.151814] Hardware name: AMD Splinter/Splinter-GNR, BIOS
> > WS54117N_140 01/16/2024
> > [  388.151816] Workqueue: KFD IH interrupt_wq [amdgpu] [  388.152084]
> > Call Trace:
> > [  388.152086]  <TASK>
> > [  388.152089]  dump_stack_lvl+0x4c/0x70 [  388.152096]
> > dump_stack+0x14/0x20 [  388.152098]  ubsan_epilogue+0x9/0x40 [
> > 388.152101]  __ubsan_handle_shift_out_of_bounds+0x113/0x170
> > [  388.152103]  ? vprintk+0x40/0x70
> > [  388.152106]  ? swsusp_check+0x131/0x190 [  388.152110]
> > event_interrupt_wq_v10.cold+0x16/0x1e [amdgpu] [  388.152411]  ?
> > raw_spin_rq_unlock+0x14/0x40 [  388.152415]  ?
> > finish_task_switch+0x85/0x2a0 [  388.152417]  ?
> > kfifo_copy_out+0x5f/0x70 [  388.152420]  interrupt_wq+0xb2/0x120
> > [amdgpu] [  388.152642]  ? interrupt_wq+0xb2/0x120 [amdgpu] [
> > 388.152728]  process_scheduled_works+0x9a/0x3a0
> > [  388.152731]  ? __pfx_worker_thread+0x10/0x10 [  388.152732]
> > worker_thread+0x15f/0x2d0 [  388.152733]  ?
> > __pfx_worker_thread+0x10/0x10 [  388.152734]  kthread+0xfb/0x130 [
> > 388.152735]  ? __pfx_kthread+0x10/0x10 [  388.152736]
> > ret_from_fork+0x3d/0x60 [  388.152738]  ? __pfx_kthread+0x10/0x10 [
> > 388.152739]  ret_from_fork_asm+0x1b/0x30 [  388.152742]  </TASK>
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  include/uapi/linux/kfd_ioctl.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/kfd_ioctl.h
> > b/include/uapi/linux/kfd_ioctl.h index 9ce46edc62a5..3d5867df17e8
> > 100644
> > --- a/include/uapi/linux/kfd_ioctl.h
> > +++ b/include/uapi/linux/kfd_ioctl.h
> > @@ -887,7 +887,7 @@ enum kfd_dbg_trap_exception_code {  };
> >
> >  /* Mask generated by ecode in kfd_dbg_trap_exception_code */
> > -#define KFD_EC_MASK(ecode)   (1ULL << (ecode - 1))
> > +#define KFD_EC_MASK(ecode)   (ecode ? (1ULL << (ecode - 1)) : 0ULL)
> >
> >  /* Masks for exception code type checks below */  #define
> > KFD_EC_MASK_QUEUE
> >       (KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |     \
> > --
> > 2.25.1
>
>

