Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA0C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 05:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D3710E1D1;
	Fri,  1 Mar 2024 05:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBkpEYQE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B2310E1D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 05:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVfXokULeOBkBSzZ+ICuKJqn6p7LSf69iysB0qp/1VJlQcdvfU95pPQLf+i97EBHbZvEu6LqVHrDFulCLV+XzFKT+gJAs4stii+jAjNAEQBOR9sjB5evAYYRkTabbqR3yvO4RP3+FSb9/mqK/vw3EBQKtRB9HOWVHD6acAvy28g6dCEhb7Wcdyt3fkfZb0xBucNkrR9XaqZWTZ8IDhL8HbQ9h3npDGvBO5DgUFSo13GuTRoazvWAUnT/OTHHBsnOwUHKKjxVMVkbUl/oNaDZXz+nDb3Bn/AySKRs9GUTWoU8Y+s9kYzIlbRE+cpB/dEZJ8cDUTxzydwk1JS9BAbWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOCQJpkg6J8I0fkSZTlr+OPF6+yd7RMUVq4tFtQTCoI=;
 b=kxt9yg27BXLqypX+TczO9vHF2cGeL15Wu2AAN5FU7q8TnEBOOZMPd/9lNabD0VrvgynLL4/8pmXVdm+mDfcjA5x3jiNHyNr4NUuPn7USMw//qEx968Jkkifr0tFJpO5ih2YER7xyE6EQJCdOnYMOEXFg2XLzv/5gYaAaopqNn3uD7MKRYOGQZrf1JBaZi2EQr+xMttvcOtYr2ra8SowHFrYVECLL28eDPuI4oYsKRZVgdpEr8b8hp24iye8ezjOGE1xcchKRlt8heUb2giw7MFcpgZrkIU36wN5kDfFusxq1BNryW50EOOuOw8M4Yx99jYtmSasIwDmMmmQwMN0dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOCQJpkg6J8I0fkSZTlr+OPF6+yd7RMUVq4tFtQTCoI=;
 b=fBkpEYQEWSQDFdtbdl5wMuuUnfckM/8vuzM8a+A6yAjpPe6Nsr8Eky40SblYvu7sATPEu6MwIWW2vNt3tHXGElulasehHta/KjnMCIbCy0q1aNQD+p7ZwvgaO6qWu5UXCEC8TvfvKXNjiP5y2OPWfhm0MC+2yI2itPChsaGKafs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Fri, 1 Mar 2024 05:49:50 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6d24:19fb:11d3:b00e%7]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 05:49:50 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Topic: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Index: AQHaauumqLiA508CUU+PR0SiS+Fh77Ehem0AgADm9LA=
Date: Fri, 1 Mar 2024 05:49:50 +0000
Message-ID: <DM4PR12MB51525B4157A21971D747743DE35E2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240229084513.86529-1-jesse.zhang@amd.com>
 <CY8PR12MB7435E75B6866EDFAA8B2B7CA855F2@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435E75B6866EDFAA8B2B7CA855F2@CY8PR12MB7435.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB6012:EE_
x-ms-office365-filtering-correlation-id: 6e367a0b-95d3-407d-e80a-08dc39b368da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1pTX2c5gFdoUZI9kO5+WTDKBUWmCoAns+B0rlWQ/CFUHQZhevrP1g2XS03fUzztS3L1bu682vqPal4tL2a6/uY875T0Kiz17LU7VYgB+gzp6IfWxh00F0Ws9CTSrIJiXAb41DBOTlyM4yarj0RgLaHngNf0lj9MQ4k7dWvceWGmimLpgofKraASLIWhyW2gfzSDu4Bq56Q1o+pjgbkFfeXGPM8TaRR6EuU5yviRmkwsFWXzBh5SAxo6zlJf1EwiKK9suJg7LjU9UryfjPEdrWVa6+fefC3DPQDFfUAYdUpraNSXy5/Fe3AgwOy0GNg0zn4YweP27d0W4IZNncid1etWAQsFwlOrajvWRlxhoXeKIuzki8kf7mdKu6XqErwGDdJQSRKcEQHTC8G2KMtf5nkj72HNY1yKgMs4R5eg/kxqDePD4Nvm/vBRy5S4j1pLogFbYutHr93qv5efWHbLv30IEuq0bzt3vYkoNpJ7pq7K0nk4HfodCwFTKLjTsn/qwmtM5t06F2B9YIUBJHWaQfriiDWRAaknwFtDtADLEWxMPzU5t2tOtDvTYl8lm4Iqi3MGg4/ucfN0kpbSOaICunpJ4HR0IkyXsnK370KgVzkFrWUUM/oAoEWsHihF6Pig0wA25lxXSwft+rSHDIZpQWmTRRG7c/ZqyA9gczlxgJEqDngVKZuPMjJCvsyQU6j3tuUDZZ+Jnrm9lTMqbWY3uQm0/UZFWoHrIeEAp2JZdSLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PzQVmqjFFo8YTbCwvfDTSV9VC1xNsEoUQGelfmc+F1tA4ZPjAmOoSQd0RBBi?=
 =?us-ascii?Q?/7pAbpob85YVWUn+/zglUIBP/IFwuF4jBZe6+/hqn1FETBWB4QLDoyjt5xfk?=
 =?us-ascii?Q?o4ITM4gf2VCv49U3qdlArcisA6EPp+6pYST6phuAsPMEyDou22a/FtsgaYHm?=
 =?us-ascii?Q?5aXwVEcTb90eShaQ+zqU1hKxBxDl9VEzov0WpZ9j13p2gwrqjAct/6qgs3hx?=
 =?us-ascii?Q?gZJLk5e8prt7jdjF6v9xGEuO/KsBXJHhtgZdHBEvHQNyd1iHNpbfwyuxiY5T?=
 =?us-ascii?Q?yyS2U3DQdclhzZ2VL+2iM6YEMD2IPQnrbnFFtik6f7NDrk/Fja3h6gl//E8K?=
 =?us-ascii?Q?jdEUMDi2OA1lmEgP6ciokq6dZzTBgf23ckCbftzbKXLWif7y1V5KSeroLTkD?=
 =?us-ascii?Q?UWOlNYrnB0qNuY/2dryOKnJX8L2hssjPsMFq1oJ80Hj6DUtkHD8b5VcauRmP?=
 =?us-ascii?Q?n5ZayBol8vnbLbLl8u5QaIoucwgD21SXukJp4O3OjI74EOsfZqU6yzRKtYky?=
 =?us-ascii?Q?NPGicub8v4PmpR1njYJBN7Yr3tKjFveGToz1Fhub49OII4dQILqyuxv+nVwy?=
 =?us-ascii?Q?lMwOua6FH4d+iU+8XSuuZvwSkoPRDjbPGE6T7Al4kuB5qS+Zwqq0J/qC2lJv?=
 =?us-ascii?Q?DvH2wbGgPOG1YKt54FQ+vZOtJq/EwGwscUS0lxvRHuKX85EVANyoV32tpawe?=
 =?us-ascii?Q?UAMVRBlqF/Rj8lUcv8A2l+HuihgaS5p+fU4xnwlqZh+SQM2tGXUQ8g9NUJ9k?=
 =?us-ascii?Q?HLizcZoVTjAvQoKE9iXk5/KU6WC5Dk/ITDI+33E4vl4OS4iZsWwTe3bPwQFI?=
 =?us-ascii?Q?dTvdn5pfFt/LtXvgcqe1mfl/56phopQdnpzvNWv9ez+nO3TDT9f2oyfNIllS?=
 =?us-ascii?Q?PM9k25B5O1oa0umbgVSoKIeAHmFx6CA2BW/z6iU58UEPB6n+3PMViXPos/Co?=
 =?us-ascii?Q?c6/Xd+InxpxOC4ZGegkkEoQg7AzfTtksMpNihmoqWf69zm+UViP5DG15JSpP?=
 =?us-ascii?Q?79wXkIKQE+5qVlWm2p4XKh5dv2+6rIsWd0s8xJHKiBfNfDYGmZ2Zs9gpEJ5V?=
 =?us-ascii?Q?0CyZsncKXRlSRR2z2VK9yCbQua3jSEUNrHewES1kG8k0RBXIJGMvCkZ9+3Dz?=
 =?us-ascii?Q?EEx47SI317jgpfA/AZZ2UbEYi8X3deDNh2nvAZa0Z4i30PPWaMVa2qbH/tcB?=
 =?us-ascii?Q?3qG1Ge1YXarr02ZP53/wWUnC/5FVh9HbYYVGCGq2Q6UpQBOhAlh/uXyatE1e?=
 =?us-ascii?Q?hNvEbrj5pvzpvLUipemhakS56xO0I28gBy3EuBaY9iO1pKYxgDhsWJ3IfcWW?=
 =?us-ascii?Q?dqaWtE2vKSGa7GffKFZGsrAoO3Su1u7tqQN0Ojs8rpLdiA8uZjnkEkCBTbdZ?=
 =?us-ascii?Q?viDd/mICMHZn4p/haj5xedZJjGZTZ0IbcCGTKNO9n7pCyyvWRl9mGl6sHBP+?=
 =?us-ascii?Q?KHT+1plVGKtmajJwQKep9CTIyE521w5rrfEnq/9IPcOu9m7+F+FoTfzNUEPW?=
 =?us-ascii?Q?CGqzfD9fQ4rWW0wzY/O4/8dQInw4TFutXzgkGj8pyFhcP/4dfQG+lMWdRZZN?=
 =?us-ascii?Q?DQqT+z62qe/BcE3RC1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e367a0b-95d3-407d-e80a-08dc39b368da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 05:49:50.0846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7+z+8LDMEQGkcYv6IyR3l6ExTwRGttOj8jHI+mGUBrn/aMW4Mu54P/wW4q7lZ6RI+/hVF4tGFPGgDkk+Q9ZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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

Hi Jon,

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, February 29, 2024 11:58 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie) <=
Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug

[Public]

I think this was discussed in another thread.
Exception codes should be range checked prior to applying the mask.  Raisin=
g null events to the debugger or runtime isn't useful.
I haven't gotten around to fixing this yet.  I should have time this week.
Just to double check, the out of bounds shift is because of a CP interrupt =
that generates a null exception code?

[Zhang, Jesse(Jie)] Thanks for your reminder, I saw that discussion.
In this interrupt, other fields(such as, source id, client id pasid ) are c=
orrect.
only the value of context_id0 (0xf) is invalid.
   How about do the check ,like this:
          } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE) {
+                       /* filter out the invalidate context_id0 */
+                       if (!(context_id0 >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIF=
T) ||
+                               (context_id0 >> KFD_DEBUG_CP_BAD_OP_ECODE_S=
HIFT) > EC_MAX)
+                               return;
                        kfd_set_dbg_ev_from_interrupt(dev, pasid,
                                KFD_DEBUG_DOORBELL_ID(context_id0),
                                KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(conte=
xt_id0)),
 Thanks
 Jesse
Jon

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Thursday, February 29, 2024 3:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang,
> Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
>
>  the issue is :
> [  388.151802] UBSAN: shift-out-of-bounds in
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v10.c:346:5
> [  388.151807] shift exponent 4294967295 is too large for 64-bit type
> 'long long unsigned int'
> [  388.151812] CPU: 6 PID: 347 Comm: kworker/6:1H Tainted: G            E
> 6.7.0+ #1
> [  388.151814] Hardware name: AMD Splinter/Splinter-GNR, BIOS
> WS54117N_140 01/16/2024
> [  388.151816] Workqueue: KFD IH interrupt_wq [amdgpu] [  388.152084]
> Call Trace:
> [  388.152086]  <TASK>
> [  388.152089]  dump_stack_lvl+0x4c/0x70 [  388.152096]
> dump_stack+0x14/0x20 [  388.152098]  ubsan_epilogue+0x9/0x40 [
> 388.152101]  __ubsan_handle_shift_out_of_bounds+0x113/0x170
> [  388.152103]  ? vprintk+0x40/0x70
> [  388.152106]  ? swsusp_check+0x131/0x190 [  388.152110]
> event_interrupt_wq_v10.cold+0x16/0x1e [amdgpu] [  388.152411]  ?
> raw_spin_rq_unlock+0x14/0x40 [  388.152415]  ?
> finish_task_switch+0x85/0x2a0 [  388.152417]  ?
> kfifo_copy_out+0x5f/0x70 [  388.152420]  interrupt_wq+0xb2/0x120
> [amdgpu] [  388.152642]  ? interrupt_wq+0xb2/0x120 [amdgpu] [
> 388.152728]  process_scheduled_works+0x9a/0x3a0
> [  388.152731]  ? __pfx_worker_thread+0x10/0x10 [  388.152732]
> worker_thread+0x15f/0x2d0 [  388.152733]  ?
> __pfx_worker_thread+0x10/0x10 [  388.152734]  kthread+0xfb/0x130 [
> 388.152735]  ? __pfx_kthread+0x10/0x10 [  388.152736]
> ret_from_fork+0x3d/0x60 [  388.152738]  ? __pfx_kthread+0x10/0x10 [
> 388.152739]  ret_from_fork_asm+0x1b/0x30 [  388.152742]  </TASK>
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h
> b/include/uapi/linux/kfd_ioctl.h index 9ce46edc62a5..3d5867df17e8
> 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -887,7 +887,7 @@ enum kfd_dbg_trap_exception_code {  };
>
>  /* Mask generated by ecode in kfd_dbg_trap_exception_code */
> -#define KFD_EC_MASK(ecode)   (1ULL << (ecode - 1))
> +#define KFD_EC_MASK(ecode)   (ecode ? (1ULL << (ecode - 1)) : 0ULL)
>
>  /* Masks for exception code type checks below */  #define
> KFD_EC_MASK_QUEUE
>       (KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |     \
> --
> 2.25.1


