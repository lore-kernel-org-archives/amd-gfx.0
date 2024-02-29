Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA964C54E41
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 15:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C3110E4FB;
	Thu, 29 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sm7sgQOW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A2E10E519
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 15:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfmpSbHwDezdzIZdnKkcJ7nyMpG8sIkBDWQwQNqjJY9T8Swac4kxdwWeVh8xqm4yMP7yXQ7dyABuvUesNHviTYeKkke8m7BaoWMNq1Inm94D9kXroD+VW3GZ5/Dw0UBlbvzemcxG9GP9HUZsktVORezynno1b+xVDA97i/u8BwHVLVpMS26mshDoz/rfGfNRdnMfqYSXuQtCoIwR8aKnIn+KlOkBuxUyTU7rwBTuK+FBdOVH+3kpnUyrcxIoGQiBnGCe6LyLDaoZIlbUb4I7IZz5qP6MqVa4zKgmbEHTHxbCUjCeuBSYAEB4Ts5fkz2Gk2RCn2PyauGqcbegdRSYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gVJ5w2RG6K+DcP4Ht4K61Qt0fZMKkdXDyIlexfsAaw=;
 b=AdUyxMbI8XiZqK2bHa6EE+7kGJcrzCgECIn//OmgEcOPlbjhxBiqVBgoXrwhBZpDQ6Wi1O1TD3uFDujQ5jKzaPczDfKhWGzQB/IeExR+mzRXs+4rqEunPI6Ux8lQUCFE2fh8PYGL3vwKEgg9gTpLFyIErfXdPtMu89klm0pDQ6KgBDm5TIYP4T6l/UzOb0XDMUBigzBR5a9FORZEbwElIIWFdBwVcRFWpNqmAlEFIc+kgmusLvhVaaF8PaFwQCM1IN1LwtgYfYuP10qwqKyySfLi5glHvrjhHhYBV3C7GPw7U+DgBjCxsomn5HlCH2zfZwq91E68flVhq8Br1sL/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gVJ5w2RG6K+DcP4Ht4K61Qt0fZMKkdXDyIlexfsAaw=;
 b=Sm7sgQOWcOMWmioeLcb0B44JMmxBtDjOJ/LSZzYdXwddVAl3d/PAjJUgKpoMrCQWX0sT5JWleB1r/HOnUFmfSVnDcUIt+fqLLd4UMDqe/GHYsUuBJVkfDoVzLH+wBtFMCr/kRAPs5UMkSPySppdriTMx6Xf9R3ohiU4KFuybNvQ=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:58:29 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::2b86:edd8:2dbc:41cb]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::2b86:edd8:2dbc:41cb%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 15:58:28 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Topic: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Thread-Index: AQHaauum2A3QqaEyJ0qsZJk0VJOnIbEhePIg
Date: Thu, 29 Feb 2024 15:58:28 +0000
Message-ID: <CY8PR12MB7435E75B6866EDFAA8B2B7CA855F2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240229084513.86529-1-jesse.zhang@amd.com>
In-Reply-To: <20240229084513.86529-1-jesse.zhang@amd.com>
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
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH8PR12MB6890:EE_
x-ms-office365-filtering-correlation-id: b362f585-7f6e-4211-d8c5-08dc393f4507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuUwc+BOyBjGu4v6GCHz+MzLQ78Oqpv+C8OY1gJWa3OUenhFYy1UCArR6UHS4PI0eG0BF4te1uTt5EJIkNjzoyiu24C8Q+uT9tCN1WZvfXsMgffr1p8su03n1IVzVccZQ6TMGMtyqVQc6+3he+byWVfeUOOEXfj7Y3bXZ6Wc5XF3KgkriQHtO9waVs6RDe6oP4cVyJSIOSjDUJE3QCZQOBvcTBJKNm1mu+mQOA41utfYP7zgNW5GqogNsyNthK41Oc9Vm8uBqRM0K0l4JT0U8iMZH4JRuwIuARu+67Awgb9S3l2bHOD3/ZoTAFWhGTuyT2os7PqbkUikvXnjw2KLd5Q1msA7hNDwb4vL84fJ+bqvf+QB0YEaLpOdrxURRScMoIvf9MpkteOTeJ2QwrMeMiSgjl2qR++WSnWtH/oC/4Zur7V0QTEJVTNrn7rqwimjkMI+RLMM0zyuZ1cSVCSFedyYm3GMSurSHQWTJsd1A203Y3bZeO9A/PC5A0jMZTP5AY363wTyBsbbWCaa1XwZ38XkUAULTvmsqv4YCXivbCxxSGgrsWFiBovTV3DhpaxLlb7jxb73MHVqmcnB4qlJMMgrORNmUoU981OIECwDiRl9S4/0ki3WZ8sRH6FYKo9xvAMfaqawvP61gCuhqdsvTyQ0S3ZPlYEPU08Kzt7McrppmwX3+yoUc6AMKig76NSqsABvCrTMeIDrN6BwFCo3u7FomwHGBei9U9v+BFw2Sf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dbFMyMQAvuetBztc3Y00uYXII4z+mI/8xsmfSvVB1RaOXbFmV4mqDLCgDlsX?=
 =?us-ascii?Q?Pt3nXWtB2t0t/6gJtbWAwEf/zC5OD7jS/vvLgC9wqTZuhb9EfdNnUWTLFhk9?=
 =?us-ascii?Q?wFgYGWuaXNNbShcHarUH3F4mZPdOhH6tVeKfT26gvRts9JMw8N474G4zdCwr?=
 =?us-ascii?Q?HN8FoaPcxGC04IIFTnVP7YDNBlnzH9qGBwdJYkUVTG9p1sPi1vG5Yog7RZlK?=
 =?us-ascii?Q?xQ9RERMuvBvSDsSmNQQy6wShqmpO+d6jddhdNGg/WiBA9kEwNK6ish5xXTwJ?=
 =?us-ascii?Q?+PST6l/3ROclct9PnSfo77gD8JvBsmPSSGEZ5S82+BDTKSSWCvr6IRZlQ1Nm?=
 =?us-ascii?Q?jNYTDRF3vKKAmU0X/J35ndu5Bg6m89vExJuKzBv8fMSsVvdwPeDYidEda94V?=
 =?us-ascii?Q?SslTgSbtWl0+77G/ad58WyuAulg2BQ9DXrzBxHhU+Y4xCL91zNrdxcQiWPdQ?=
 =?us-ascii?Q?VRm772OPTHP2PEQsNXteC6faWQeb7gtAA35M3WUIwYuVbZJBpq/CKerwb+SN?=
 =?us-ascii?Q?3Ba6tQgOYTEgihINkbCALCgUueAWqe3qrSqP5/8r52oAbQHDaEA+AHDW6p5D?=
 =?us-ascii?Q?wk7D/lsrwfRwyikmfUBhDZ5nynR2/HcBNjr6gNXOo0cezZpswm8EoirZ7cIw?=
 =?us-ascii?Q?94y7WGqttq/VL93kILY8mqddet6Y3FYzPQ7HZL7ce3NWrASJu0+tXt4sTj+6?=
 =?us-ascii?Q?Ck2qdxcBqPDHzWtXr7rjN3jhxkdriFOc0ZCajENEdTrJiN0VcGTM3QM5UMQ9?=
 =?us-ascii?Q?/I4NVp0GhtLskhCrBvFlodMgOg2J27jhxytcy99sgcOtt+/4SHnmJJ0X7L+g?=
 =?us-ascii?Q?xX1L1DK9DljMSPjfU5oEHBtv+f97gWbDJCOu/aTKqlxLpbo836KJ55u416Fi?=
 =?us-ascii?Q?tGFd+ftecabExRuSKp3PzOtA2Q9DVRMWlQ4+F8ekgqHSMFZfQ8a6B/pNuoPT?=
 =?us-ascii?Q?xSYWmTtUJUW5sLceb7SqN8WjqQdf7gbL2NIU54NPkhRresRev7MwNuo6ir7K?=
 =?us-ascii?Q?4aXiCgmhLVMwDuxMQYqwKf1lCwyKYyCsviZdHXI8WBz0cuXNp7U1bgMO3sZz?=
 =?us-ascii?Q?dVxQmqJGUhgI6GUwijdA1fmraR2rDZMA5vY1AcSf6AQHWnJnnWu3WU61NkhS?=
 =?us-ascii?Q?JxBE29c/WmLYTsoQ4WUddrCjUQJkNohXHRohyM7v2GKBpfSLsyKH8o5VOrLn?=
 =?us-ascii?Q?Z7TKi+yPpaYgW8A/QeQDWJBwnxk9H16NHFwqgj41+dRkTxWlroBv/PH753ay?=
 =?us-ascii?Q?a05BeI9o3t/4yBtVj20I4rOSM4bP7f7M5hWHxSYkx0DBM3gw3x7kR0zlql1z?=
 =?us-ascii?Q?xWlzjeLZ6itUwrZvgCyWL/4aVzTS9CW3Glmdw2lw9mGHeEWgib25cwaGu3/5?=
 =?us-ascii?Q?C7RV6wwp9E9oH2E0frHa4PKnX2uKvcFQnfWTIsApoJNVpFD5Wq5GCZsJC3Mc?=
 =?us-ascii?Q?AyjYKe0U4FzjxvGlBRhozRHvr5vApAipI4h8QmAppTneU6DWRCDYxJK3XALM?=
 =?us-ascii?Q?OTmEvtphtkZlmKb+6snk++eT3zJNWnZI+040Ta0nzDfHwk/a3AEdGeks2MG1?=
 =?us-ascii?Q?mXdBDnUFJRUgdXR8MT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b362f585-7f6e-4211-d8c5-08dc393f4507
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 15:58:28.3606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llaZaikVBC0IWKzjc9O16Wb2nIswPKiTROiQholFJvw8K+Xe3MXwSebVrgj52kna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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

I think this was discussed in another thread.
Exception codes should be range checked prior to applying the mask.  Raisin=
g null events to the debugger or runtime isn't useful.
I haven't gotten around to fixing this yet.  I should have time this week.
Just to double check, the out of bounds shift is because of a CP interrupt =
that generates a null exception code?

Jon

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Thursday, February 29, 2024 3:45 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
>
>  the issue is :
> [  388.151802] UBSAN: shift-out-of-bounds in
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v10.c:346:5
> [  388.151807] shift exponent 4294967295 is too large for 64-bit type 'lo=
ng
> long unsigned int'
> [  388.151812] CPU: 6 PID: 347 Comm: kworker/6:1H Tainted: G            E
> 6.7.0+ #1
> [  388.151814] Hardware name: AMD Splinter/Splinter-GNR, BIOS
> WS54117N_140 01/16/2024
> [  388.151816] Workqueue: KFD IH interrupt_wq [amdgpu]
> [  388.152084] Call Trace:
> [  388.152086]  <TASK>
> [  388.152089]  dump_stack_lvl+0x4c/0x70
> [  388.152096]  dump_stack+0x14/0x20
> [  388.152098]  ubsan_epilogue+0x9/0x40
> [  388.152101]  __ubsan_handle_shift_out_of_bounds+0x113/0x170
> [  388.152103]  ? vprintk+0x40/0x70
> [  388.152106]  ? swsusp_check+0x131/0x190
> [  388.152110]  event_interrupt_wq_v10.cold+0x16/0x1e [amdgpu]
> [  388.152411]  ? raw_spin_rq_unlock+0x14/0x40
> [  388.152415]  ? finish_task_switch+0x85/0x2a0
> [  388.152417]  ? kfifo_copy_out+0x5f/0x70
> [  388.152420]  interrupt_wq+0xb2/0x120 [amdgpu]
> [  388.152642]  ? interrupt_wq+0xb2/0x120 [amdgpu]
> [  388.152728]  process_scheduled_works+0x9a/0x3a0
> [  388.152731]  ? __pfx_worker_thread+0x10/0x10
> [  388.152732]  worker_thread+0x15f/0x2d0
> [  388.152733]  ? __pfx_worker_thread+0x10/0x10
> [  388.152734]  kthread+0xfb/0x130
> [  388.152735]  ? __pfx_kthread+0x10/0x10
> [  388.152736]  ret_from_fork+0x3d/0x60
> [  388.152738]  ? __pfx_kthread+0x10/0x10
> [  388.152739]  ret_from_fork_asm+0x1b/0x30
> [  388.152742]  </TASK>
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  include/uapi/linux/kfd_ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 9ce46edc62a5..3d5867df17e8 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -887,7 +887,7 @@ enum kfd_dbg_trap_exception_code {
>  };
>
>  /* Mask generated by ecode in kfd_dbg_trap_exception_code */
> -#define KFD_EC_MASK(ecode)   (1ULL << (ecode - 1))
> +#define KFD_EC_MASK(ecode)   (ecode ? (1ULL << (ecode - 1)) : 0ULL)
>
>  /* Masks for exception code type checks below */
>  #define KFD_EC_MASK_QUEUE
>       (KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |     \
> --
> 2.25.1

