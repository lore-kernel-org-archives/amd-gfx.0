Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03478C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 07:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC7410E060;
	Mon, 17 Mar 2025 07:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8sWF0R0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5183A10E060
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 07:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXbeag2KJseuF9TLW5gy3QRHMy5Hv+uy6MCo3fOCa3wJEKkIWR8m5la/JRRaLKC1cBxrUBEWWDUpvSNvUT8hRGxRBFxXtG7lVK6jDE7UHYEwSS7pYtcEYxWTJEwJHeSN5bsBveOHDSXcPHQd9Btp4/LlyxNfXp31pa1JUTpqsmbMIOjLHOde02Xua3Za9fOSSmJMiB6JWBESj0PeWSbMZ82FD/PfJy2R+PZDwpOCBVgsLE/wQSa5/kNQBNKLp0SUXzJL9gZ8EAzUDbQerWhmhnERLncsh6+LQWx5YkA21WOmGwKtpt19p/Cq41w2YVB6vx2++KGwSdfUVxaaB+BKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3h8fWXvmbV0JlSiZ4LrsuLpdzVZzaFMRNtN2f4xc7c=;
 b=bxt8o+JkIa7sq6ewLwwjoARCzPfosAq/l0De+GfnTzAXmgsxAKAVev4bfmya52ovrSp0+2kRF9kUIvafXM/7lJiO0OXx0Js/tQRjLZ7Q43B6jJWa+2FP7+HrszDEQXICEDH/gJfh7oC+JRAcns6Ke4/Vi2ox/sD00NoLu12GDUCSsmH/SkJa0lcdVDYxH4X2kQiiacxlFEOMF0OO084sqZodDivFvxirT12ggFE6LYlKPnHPo0V7K2z/SjrmKD6NrTLZKW9xrZA+kdifHByFFvmjBbm4vhKtiKStXvVcI1/bKoSKQBdpHsBbj8BKLcxjF5tiJGE7MkXqDuXt6kR4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3h8fWXvmbV0JlSiZ4LrsuLpdzVZzaFMRNtN2f4xc7c=;
 b=q8sWF0R01hwVpEOWtH5mMJpatQruGy6n0RyGskHru7VdqK9tm+6mWriv0INqsYtI6bMKhb7a0Irpctv9LS/kGHOriNEOLoMjXDQQuyL2ptBTSJOGJwDtBR8x4G5YZn7YQosQZPyHMyTePMce7K6vVdcrHOljybcOzsC9mksoxyE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 07:08:19 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:08:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Thread-Topic: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Thread-Index: AQHblCYaH52apO81VkmkeP7rYLUC7LN24U5Q
Date: Mon, 17 Mar 2025 07:08:18 +0000
Message-ID: <DS7PR12MB60057FE73D45BF10F18E0046FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
In-Reply-To: <20250313144136.1117072-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Marek.Olsak@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8decea8b-75c6-43a6-9c60-46901e1631dd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T06:21:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB6664:EE_
x-ms-office365-filtering-correlation-id: aa59b7cd-e5c9-4cd4-f696-08dd65227edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|4053099003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BjiaPpS0hSnG6dcNs3t4gyfVleIF+ZCjfXnmfWG79YdBnNvuNoa3P/cgmgtf?=
 =?us-ascii?Q?1BxIdyTt0xIBmLRgtEyV7BV4vFSzLg+MUJltX/eQtBghOn2qT2o0204yfPni?=
 =?us-ascii?Q?cwWXuPJyw5y7cG4XmUVdvnkUFtNOBQyJjTS7IXVV7xy6mSlHcBrza5y6ktr5?=
 =?us-ascii?Q?uY7Nwc8k7Amo8EAu/SMIuqv14YSHr/89SVkblR/I1uwkj5WzQX6yotEDVIaT?=
 =?us-ascii?Q?MN7DW5/UOK7hly9IOaCFLn/zKbcB6jaIhlHgV7/4wk/Uarp556anoN07vD/6?=
 =?us-ascii?Q?HGfcahUey/TZrgeuNuJBHYgL897cag1MvHxB2lY8fA1QP6AcuCI7d5/H9GZ7?=
 =?us-ascii?Q?yP98jbXWUclHwq9pyJYMc4XOOLEWNIOF+FsQgQQI/kGYvATWqLlRa7YrzWf2?=
 =?us-ascii?Q?nyTUri0aTKfDEVMzF9R+kGBLZs4zFxTcs13YE9W1c3nwG+QZqWOf4ZPdBG7x?=
 =?us-ascii?Q?amvBQs5elDuVpctBd2OyWzNw46AxNzrUQVhr0ViATL0bPUAYLQKyXvVg2rsF?=
 =?us-ascii?Q?Q77KM7lXXwDpb9oO6Wa8wjrEnoAyH43ZbzTqpaqNV45PvZoWjWHSV1iZ7Grp?=
 =?us-ascii?Q?5CTiBIImMYcYgNiWsxOwtJ4dL3c21wBy+q0PPDTBNcqKf1ROvxEeiW/mBIZz?=
 =?us-ascii?Q?OfLB91y/c0SZIjtdUqWUBas/XCdB++2SdeQwxTr3h2wfe7SFMZZxpWW7m1m/?=
 =?us-ascii?Q?Z2x1b3D9tF0S2e6GLtDYKeuNlqQ7LT744lDe1ywgyWhSTyvPPE+qlI2wh0Mf?=
 =?us-ascii?Q?YR3qFm0wF7nFTn2DBj9I53ZhwfTBlnmAq5dB9UpOrQtWPf3wWaocWbrAWm6z?=
 =?us-ascii?Q?teYjHKoP5PUiHxJY+ORPTplFvTp9WEUhSY/19TZa5eqFVbPaYhxoqBgec6Xq?=
 =?us-ascii?Q?MrwLhB07ZLl1pvQKC2Tb/bI24FX92QkEXlDi44zwdCcgbPZHhUOeCh+81ae8?=
 =?us-ascii?Q?6ekfJ2n2d1+23PXtOG7qK4fqwvkuykoCKbWdjM/vwjT+zzz9Lvs4f+H2QhJ4?=
 =?us-ascii?Q?qA2FauEk0J8FLFHkiIxjD+MkL6hkw8RtIiV3HeMe7K8dPZLEeu5K09zrErSi?=
 =?us-ascii?Q?5+U+QsHOHVokNUB6unKlGd0JI6tVYgslwuPXmKVpIKgNeXZPLEu+UKXn0guC?=
 =?us-ascii?Q?/PksRssEw0IIB7dSmgf66N2nlO6HGd2+Tf0m4Mu8q00GdQJFsCU0rFVfVLwn?=
 =?us-ascii?Q?lNSd5I0qPC7rNWTx81QggYfgRJt4m2XHqWG3lKb25gCCYOZaVeWwVbgpoM9r?=
 =?us-ascii?Q?ipRN9IvqCjvlEiIhdBtiIfxl8Wd+FNbsnESX5wRu7Hjx5IR8ffqXrAEhQk07?=
 =?us-ascii?Q?5+R5wGVKuZKrgdYNFJ1G+s2Z66Mug5g17C3Rc8rJ3hexB0HXeA/s9RytvWwc?=
 =?us-ascii?Q?d+wO6O6tFNuvDB5Acy6trq57IBMkUAaXAAREXXn0U7z76Xcnb1ldkwCYB9+u?=
 =?us-ascii?Q?dl/ekvSTxjYW58bEbcAQm+iTgbusTCuM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(4053099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjoImC9U+IbOIVFI6kTUpSXbZSPY3hSnncYcL2gNzVLq10nw5EgdzPnF80Av?=
 =?us-ascii?Q?bPc33v2tRmds7ZrLSw1AlhQ7/Ue2w4KywsQWHFNLdD9e36pUlVPfTZgJ26+S?=
 =?us-ascii?Q?7/hIad5DHOiK+ajzAb1du8TifZK32XMzwsR1l/10qkddY2ZISrWybZd3YN2B?=
 =?us-ascii?Q?NPAXhmjNGDx3OZog7gcoOt8kbh1rtGA1e7eY0zaHTcIY1BJ0s3HpfT1aoCm7?=
 =?us-ascii?Q?36xyk4mUy8apJ1qndwzghws/5gUKH+htqGJtJrotOFj5+6p0RM9DBD2oa9Cl?=
 =?us-ascii?Q?PaNMn2g1HV02OqKUQ1sjVhTXUVZhTi9FA+HFKlvUTQdfder1zJppdh8bwFou?=
 =?us-ascii?Q?YObMq0ySlZBLEOD3stor/VLYvxlosF+0EOY4B3HzupNkmWWg2SS9ytdKp2GH?=
 =?us-ascii?Q?jglxWmuvwo8Xx87ZpDMg5cfQRktMGlMfCT6PRmpK2+jmVpFC5OkZvHMpkcN3?=
 =?us-ascii?Q?MPy4uxKer1gNCjHns+yNYMQ0BG+CdhdDIM3f6ezyfIaj86lC/PoseKTbI9Fg?=
 =?us-ascii?Q?Ol9GwtLdFxl7OlGGmJIdsHfXFSv5XRnZppgoDvnse0+o9qMOwHkRIY8LVeIx?=
 =?us-ascii?Q?cWn4iCpGp6cJsQJzN8Py1HzlOe06yy4wUT8atgfwm2ZqluK2fG3muZALCp6o?=
 =?us-ascii?Q?DswYj54OJlvdacZSSsdR3V6Gyi7jg5COgrKyCOPi8ie1WJtW840V/o2kqFXS?=
 =?us-ascii?Q?pJ/24qnyHeCF7kBVopkyNpMJDq1jOBkX25QWZjRBq+hYcisxg1mZEiNfTa+7?=
 =?us-ascii?Q?aKUzYIIjmfhosUQ/D/bfC+NMF9UvfGfH2LrTl93PevOmWV48KyhJvxqiCm1a?=
 =?us-ascii?Q?MVuZa1Be9bKzlUh3l3/P1Syt13O1I/kS46E22qg5jn0P+CH7VaNCzW129uwT?=
 =?us-ascii?Q?gstjS0TPHDOq5XVrpABfTEKrUoZLsjB05AHtavECVkwwzjtLHOc/xT7EGtIB?=
 =?us-ascii?Q?DwihyZAFEgsKEdf/uQtGhtmAsGLWbO7FfObiilVma0k4rcT4rB24sRkyFEVQ?=
 =?us-ascii?Q?rvze0guSD9Atqzbph5Lj9Q7iKCsifjeCnyQRwqD1T1TUZeHYJmpxhgwRwyFw?=
 =?us-ascii?Q?msQHj3AwkP1oJqDwM765bQofQYco20aAuBmYrZ59hqspuHylBoqdOetoorqh?=
 =?us-ascii?Q?OC6FWXGy4sE8pCw3PUB+3wmog2Z6zQliOk8VsTisox8rkVNHpK5rfVLOiuo1?=
 =?us-ascii?Q?xHXnNT+4tTE6qQoDWPflGCMTXs/heYqBtzkTfp3CpS05UteHuSYDZv5mE50y?=
 =?us-ascii?Q?fHGJ2MIwQbg1Cz9egYS0DedBcprYALPr9BZ2+2kiVHEfcBZaL5pZeWiHWigS?=
 =?us-ascii?Q?8Kl2PYTQJDssmWK9YUbnSuwj68mFl3im0cw6hgMBTpzSJqcBD/Jxk3JcWUEr?=
 =?us-ascii?Q?2rhozU3M/3i6AUylyyfpcUaGn7D/24BojJcBcfcRMm6VlrA5uQymfrKWY5vA?=
 =?us-ascii?Q?YP26SBv6zj579g8g8fpjRUQ580EGLQEG9H0uSVtt14N0XTF0kYt8KvyfSjf4?=
 =?us-ascii?Q?T8c7ZI4MtTe6Yg8xv4EZ9K9mQfK8YQh3PaW/srsmUbOSX0VGcYljT/pV/JN7?=
 =?us-ascii?Q?S3wxvjGnG8ZMU2ksf/U=3D?=
Content-Type: multipart/mixed;
 boundary="_002_DS7PR12MB60057FE73D45BF10F18E0046FBDF2DS7PR12MB6005namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa59b7cd-e5c9-4cd4-f696-08dd65227edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 07:08:18.8172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UP8JPtAVW4r5BlvS1QIsb6YvRg02mt5Ryn0V40cEAYeWJ2r6fW5aB30e4Plm5lbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

--_002_DS7PR12MB60057FE73D45BF10F18E0046FBDF2DS7PR12MB6005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

We might still need to export each ring's number correctly; otherwise, the =
Mesa driver will consider there's no available ring supported from the driv=
er and then further assert before submitting the user queue.

If we want to keep the ring number being zero, the Mesa driver may need an =
attachment change to allow the command submitted to the zero-ring number if=
 the user queue is enabled.

Hi @Olsak, Marek Do you think it's fine to have the attachment patch for th=
e userq support? Except for such changes, maybe we also need to clean up th=
e IB-related part.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 10:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
>
> This would be set by IPs which only accept submissions from the kernel, n=
ot
> userspace, such as when kernel queues are disabled. Don't expose the ring=
s to
> userspace and reject any submissions in the CS IOCTL.
>
> Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5df21529b3b13..5cc18034b75df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser
> *p,
>       ring =3D amdgpu_job_ring(job);
>       ib =3D &job->ibs[job->num_ibs++];
>
> +     /* submissions to kernel queus are disabled */
> +     if (ring->no_user_submission)
> +             return -EINVAL;
> +
>       /* MM engine doesn't support user fences */
>       if (p->uf_bo && ring->funcs->no_user_fence)
>               return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_GFX:
>               type =3D AMD_IP_BLOCK_TYPE_GFX;
>               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> -                     if (adev->gfx.gfx_ring[i].sched.ready)
> +                     if (adev->gfx.gfx_ring[i].sched.ready &&
> +                         !adev->gfx.gfx_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 32;
>               ib_size_alignment =3D 32;
> @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_COMPUTE:
>               type =3D AMD_IP_BLOCK_TYPE_GFX;
>               for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> -                     if (adev->gfx.compute_ring[i].sched.ready)
> +                     if (adev->gfx.compute_ring[i].sched.ready &&
> +                         !adev->gfx.compute_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 32;
>               ib_size_alignment =3D 32;
> @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_DMA:
>               type =3D AMD_IP_BLOCK_TYPE_SDMA;
>               for (i =3D 0; i < adev->sdma.num_instances; i++)
> -                     if (adev->sdma.instance[i].ring.sched.ready)
> +                     if (adev->sdma.instance[i].ring.sched.ready &&
> +                         !adev->gfx.gfx_ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                       if (adev->uvd.harvest_config & (1 << i))
>                               continue;
>
> -                     if (adev->uvd.inst[i].ring.sched.ready)
> +                     if (adev->uvd.inst[i].ring.sched.ready &&
> +                         !adev->uvd.inst[i].ring.no_user_submission)
>                               ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>       case AMDGPU_HW_IP_VCE:
>               type =3D AMD_IP_BLOCK_TYPE_VCE;
>               for (i =3D 0; i < adev->vce.num_rings; i++)
> -                     if (adev->vce.ring[i].sched.ready)
> +                     if (adev->vce.ring[i].sched.ready &&
> +                         !adev->vce.ring[i].no_user_submission)
>                               ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
> -                             if (adev->uvd.inst[i].ring_enc[j].sched.rea=
dy)
> +                             if (adev->uvd.inst[i].ring_enc[j].sched.rea=
dy &&
> +                                 !adev->uvd.inst[i].ring_enc[j].no_user_=
submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                       if (adev->vcn.harvest_config & (1 << i))
>                               continue;
>
> -                     if (adev->vcn.inst[i].ring_dec.sched.ready)
> +                     if (adev->vcn.inst[i].ring_dec.sched.ready &&
> +                         !adev->vcn.inst[i].ring_dec.no_user_submission)
>                               ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; =
j++)
> -                             if (adev->vcn.inst[i].ring_enc[j].sched.rea=
dy)
> +                             if (adev->vcn.inst[i].ring_enc[j].sched.rea=
dy &&
> +                                 !adev->vcn.inst[i].ring_enc[j].no_user_=
submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>                               continue;
>
>                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++)
> -                             if (adev->jpeg.inst[i].ring_dec[j].sched.re=
ady)
> +                             if (adev->jpeg.inst[i].ring_dec[j].sched.re=
ady &&
> +                                 !adev->jpeg.inst[i].ring_dec[j].no_user=
_submission)
>                                       ++num_rings;
>               }
>               ib_start_alignment =3D 256;
> @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> *adev,
>               break;
>       case AMDGPU_HW_IP_VPE:
>               type =3D AMD_IP_BLOCK_TYPE_VPE;
> -             if (adev->vpe.ring.sched.ready)
> +             if (adev->vpe.ring.sched.ready &&
> +                 !adev->vpe.ring.no_user_submission)
>                       ++num_rings;
>               ib_start_alignment =3D 256;
>               ib_size_alignment =3D 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e9..4a97afcb38b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,6 +297,7 @@ struct amdgpu_ring {
>       struct dma_fence        *vmid_wait;
>       bool                    has_compute_vm_bug;
>       bool                    no_scheduler;
> +     bool                    no_user_submission;
>       int                     hw_prio;
>       unsigned                num_hw_submission;
>       atomic_t                *sched_score;
> @@ -310,7 +311,6 @@ struct amdgpu_ring {
>       unsigned int    entry_index;
>       /* store the cached rptr to restore after reset */
>       uint64_t cached_rptr;
> -
>  };
>
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (=
job), (ib)))
> --
> 2.48.1


--_002_DS7PR12MB60057FE73D45BF10F18E0046FBDF2DS7PR12MB6005namp_
Content-Type: application/octet-stream;
	name="0001-winsys-amdgpu-allow-to-submit-userq-at-invalidate-ri.patch"
Content-Description:  0001-winsys-amdgpu-allow-to-submit-userq-at-invalidate-ri.patch
Content-Disposition: attachment;
	filename="0001-winsys-amdgpu-allow-to-submit-userq-at-invalidate-ri.patch";
	size=1286; creation-date="Mon, 17 Mar 2025 06:46:11 GMT";
	modification-date="Mon, 17 Mar 2025 07:08:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkZGY2ZWEyNDhhMGRmYjhlNWZkMjhiZjc3ODRiNDE2YWQ3NTQ1ZmMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4KRGF0
ZTogTW9uLCAxNyBNYXIgMjAyNSAxNDozMjozNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHdpbnN5
cy9hbWRncHU6IGFsbG93IHRvIHN1Ym1pdCB1c2VycSBhdCBpbnZhbGlkYXRlIHJpbmdfbnVtCgpJ
biB0aGUga2VybmVsIGRyaXZlciB0aGVyZSB3aWxsIGRpc2FibGUgdGhlIGdmeCBrZXJuZWwgcmlu
ZyB0aHJvdWdobHkKd2hlbiB1c2VyIHF1ZXVlIGVuYWJsZWQuIFNvIHRoZSBtZXNhIGRyaXZlciBz
aG91bGQgY29udGludWUgdG8gZmlsbAp0aGUgdXNlciBxdWV1ZSBmb3IgdGhlIGtlcm5lbCBxdWV1
ZSBkaXNhYmxlZCBjYXNlLgoKQ2hhbmdlLUlkOiBJNzM1ODQyMjVhZjg3ZDk4NzE4MjQ3MGY1NmNj
NGRiYmU0YzQ1MTIzMApTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1k
LmNvbT4KLS0tCiBzcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9hbWRncHVfY3MuY3BwIHwg
MyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9hbWRncHVfY3MuY3BwIGIv
c3JjL2dhbGxpdW0vd2luc3lzL2FtZGdwdS9kcm0vYW1kZ3B1X2NzLmNwcAppbmRleCBiZWIxNmNh
NjNiZWIuLjc1ZDExMzQyOGI5YyAxMDA2NDQKLS0tIGEvc3JjL2dhbGxpdW0vd2luc3lzL2FtZGdw
dS9kcm0vYW1kZ3B1X2NzLmNwcAorKysgYi9zcmMvZ2FsbGl1bS93aW5zeXMvYW1kZ3B1L2RybS9h
bWRncHVfY3MuY3BwCkBAIC05NDEsNyArOTQxLDggQEAgYW1kZ3B1X2NzX2NyZWF0ZShzdHJ1Y3Qg
cmFkZW9uX2NtZGJ1ZiAqcmNzLAogCiAgICAvKiBDb21wdXRlIHRoZSBxdWV1ZSBpbmRleCBieSBj
b3VudGluZyB0aGUgSVBzIHRoYXQgaGF2ZSBxdWV1ZXMuICovCiAgICBhc3NlcnQoaXBfdHlwZSA8
IEFSUkFZX1NJWkUoY3R4LT5hd3MtPmluZm8uaXApKTsKLSAgIGFzc2VydChjdHgtPmF3cy0+aW5m
by5pcFtpcF90eXBlXS5udW1fcXVldWVzKTsKKyAgIGlmICghYWNzLT5hd3MtPmluZm8udXNlX3Vz
ZXJxKQorICAgICAgYXNzZXJ0KGN0eC0+YXdzLT5pbmZvLmlwW2lwX3R5cGVdLm51bV9xdWV1ZXMp
OwogCiAgICBpZiAoaXBfdXNlc19hbHRfZmVuY2UoaXBfdHlwZSkpIHsKICAgICAgIGFjcy0+cXVl
dWVfaW5kZXggPSBJTlRfTUFYOwotLSAKMi4zNC4xCgo=

--_002_DS7PR12MB60057FE73D45BF10F18E0046FBDF2DS7PR12MB6005namp_--
