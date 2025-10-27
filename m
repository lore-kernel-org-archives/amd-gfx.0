Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14159CCF9E5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 19:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB5110E555;
	Mon, 27 Oct 2025 19:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EEpgd65k";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCE410E555
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 19:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN5FmIzjGnciS+dZFws6EpK0Q2SyO+K4xwpSsNlO2hBw0a7169TnkvzmOauBd2U+QFpeU9qnnh/e2JVUR+U/HPukOvWmMqZRoFG5HFJPRo9XPh+8QbmUOA1D0BayXZZSddPWHjq255G3tDN98gFUhhIEoYIv+M24sUCtsOKL0WhAk3qCn606nHsFgLtfIFPOp23hQVXRxzX8FUQdysj1sIMcIgTzLyhEylAaA9cPd3bLAlwPcDg+VvVFBNROK5B0F/1Y/Auo99bq+JY9eofrdjW45FXIN4q4M99s1BSkLtYaAS+Z4o6bh44xFK7C7vJCxrByLshFA2+lC7E2xbdrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgrQieNyyW8W8XTeppSnBogq/DNnTuBQR/lT2A6A/4k=;
 b=ZGKCEC6LiFOLQRIXotvycJ2FhOwAXtl7w3HRCOTZc9sFqAYAa6s3M8njRxbPac/UUN0Gs2XmdhZT1TFq5uaJGLD+nbc587M+SqpLjdTHD+vJUJPeWKY95igxW+4m+z/ARxRRNp8mqkJ+y1+uFtqtYzPh2EphTwyhXXiZtqOWuI+YkqiRO1EATEeyJmAtwjWF8AF7tTTSNeq4O8xO74d+wXWLHkzdcKX/TnaE4fic1sO/2ycEwZ0zo/EZ0oiRHMTfiZMqImtZq9Dmxh1gKbjeo1alvHQ6RMor+juuKoczIBhp+luuMCx2cT5WxQFsvfB8/qUVUC6oocuvbp4eBPhMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgrQieNyyW8W8XTeppSnBogq/DNnTuBQR/lT2A6A/4k=;
 b=EEpgd65kIz5BmuivFsAHoorAvM33Bjx4RmcpiRggyfgJQlZISZ2qHoAOKW9XrKIYxdo7TWXFzsKhDZcaFOvCl/Rt5LeP70iwaaI2xDHYtxoFYQJhCftqE8GQKx0WhklEu4UuLEErXPZ7eJ2zWS/HwEoIeg5XqRBZr6ssAgJp5ZU=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 19:13:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 19:13:41 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix Unchecked Return Values
Thread-Topic: [PATCH] drm/amdkfd: Fix Unchecked Return Values
Thread-Index: AQHcR2zB1i8tZfuoT0CsiAbparsk3rTWWHwg
Date: Mon, 27 Oct 2025 19:13:40 +0000
Message-ID: <CY8PR12MB74358EAD60AD3518A842C74F85FCA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251027180808.3022439-1-Sunday.Clement@amd.com>
In-Reply-To: <20251027180808.3022439-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-27T19:12:31.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4227:EE_
x-ms-office365-filtering-correlation-id: f39b7c3e-4a9e-4816-faac-08de158cf0a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vv1G0wL4vF1F7ozzXt7osx8wNQ9XjJsV7NYZlR9kHDMM44IjLf8WISX5524B?=
 =?us-ascii?Q?tJlwSM750V9tYhKjwJ961eSIdjEievvgOxGqCE5SwpharmK9nCqqmxHUWoSw?=
 =?us-ascii?Q?uz1WXLzJ4fJSYhH5nfHvu4R7dMx7Y+X11+FyTa3AAfh/RozrcFOjOiJydbqG?=
 =?us-ascii?Q?L4LQLmHyptpj4G/XlvkCDU3jBBeGanKfpEa0GAYiif5URc0so9OND76MeMnB?=
 =?us-ascii?Q?EghappIkJFOC5/+IMiJ7C1mvAcx0UEudXunk41taQ//ptpY+5a5wgaxBAiWX?=
 =?us-ascii?Q?k9A6gvHIqvPmOmB+XcbblIKuHBOkGICjeLgJpUV4bUQJd+/TRJoTsVwe+DUJ?=
 =?us-ascii?Q?zcEmAMHvar9p1XyrMOeRCQVqvpLhFybfgf0Xr0X5FJn9/P8MyoZnJajkhZmw?=
 =?us-ascii?Q?LfkthnASGYlptg1uiPzSbMgSyD1Y8L6XgAE5zTinTl6CZ/WwK5lZoZ3JPw6M?=
 =?us-ascii?Q?tAudqNfuFtGe+G8W08skS9kcakD37O3cKTaA+LHM70mkdC623+Jh4c3+SQVc?=
 =?us-ascii?Q?et3FlRinwizc031t3m4yPS1Dvok8gH8F3ue+HJxGbEahHerpeItsnhHajaTD?=
 =?us-ascii?Q?e1r9ZokeygBzQwb/JDLpqk7Jjv1Elssuio8PAGAN91MCFPgSZLyHoG1xAaZe?=
 =?us-ascii?Q?qOSrZ9K94XGaUHmGTMD0Rz7XKnkfxcKMNpZB9KY215LewTKBk1sEb9PSpR+c?=
 =?us-ascii?Q?Mfi5G2sMg7qeyUrnyjsRRaDM/AfcfFRyFjR6xds02VYCDmYg9i8XFwqBz3lp?=
 =?us-ascii?Q?7zq5kzl8Zdr0mM7KbJ7el7moUQSPEon4LzWHVuQCbGpCXXdbmA+NV3XV0++G?=
 =?us-ascii?Q?2U1+Qlp/f4bpc0TjIvlsScMGrn40Ivvj8inoY4TTOOPrxjxlZ+VRk1o1tTqU?=
 =?us-ascii?Q?SPha/w3P4Hn+gUz8t8Bmq/ttcUWwqxiB23f6Z+lfH8RZorR/dkxa+UwwdN3f?=
 =?us-ascii?Q?nwAGl0UlBQOzcMxRf3efP+3ZLXsxSyqgs+6k0kvRs7PYb+2Lh0zSQrbkSAcO?=
 =?us-ascii?Q?5SHavwDfCFN/ZVnDukwPyMseyQrT2b+yaOllr+FHNVhcG0gTYi18V8EzoMAE?=
 =?us-ascii?Q?fKxQrKP/zYwFUSWr6Fv4ipc1A/S4UvAfovayTdKS7skWm+6aD+Vs7fCmt61X?=
 =?us-ascii?Q?DgCX3N6zYEMAe5RzLojsPk1LHFa3khELjVOK+WjlcLRRYXycwWOvYB0dxaRI?=
 =?us-ascii?Q?ckFJtb5jCrwtJtGmT/DSVRWdNkLMBNDTJia1fzrh7ol81mZgLZ5jU+kUjRY8?=
 =?us-ascii?Q?Jg0ewVjU9W/BZExiyHv3AkHPr/xQ6ls7vIEXFWvbyNXf+Vski8yfSmlViVt9?=
 =?us-ascii?Q?pR1RA1IDUamXZea1jQFLgtXi9b46NHDnTiRUg9bERO+2KPzEnmYgseZobuUW?=
 =?us-ascii?Q?Sq0Sy8ZQ4k5Iek3fdfPO+cec8lt/oCeUVAjNK8Lu9wOsfCaj7aF2g9XUVpd2?=
 =?us-ascii?Q?ALB3NZXZJyEzVGKR4RU1iUX9NsYKEuDT2GWTHLHU9rCaLKw9gHpBJKVCj6wh?=
 =?us-ascii?Q?GYvn2auz1NmUmphsED22daH31GCBAxk491Ul?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L1/GhqgnUMpGLOyZmFkrRxq7qqOQgynYUWNNSnfJLjCvGfrfuHTAxTZlYEuD?=
 =?us-ascii?Q?NJrk3a+kmTe/uotL0gXgpZLy4WkwNnQdV0/XzxWWTIGKqCVNUjvN19pJtuRP?=
 =?us-ascii?Q?mG9ghrGwvgG3ABhwYTG3U9C58444JstZ+UwC/ewBhpS20BxCbuQ17znqwapp?=
 =?us-ascii?Q?9ep3b2cHGrGr5bBGh1gWx4zio7Ro5OUznggRsny14GiDHSCCmX83xnZ/nXB3?=
 =?us-ascii?Q?A2Hs86vCZ/8Up+H6iTX8y0q+zYkG0eNZW675o3M7QI++GyAWQQ97cGsq94d6?=
 =?us-ascii?Q?SAWR2vwBgDNP3S+kdSQKe7btZOmGrvPBPQSO6KYUgqsm+4K1aOEbOJrUnF6A?=
 =?us-ascii?Q?YoSRfZyDfyjxKO2+43iHDP6WJsp47a4kWSfSBIkv6tRlrv7k/uFuNjElFBV7?=
 =?us-ascii?Q?yzsIYLJiUUAX+Z4jvrrrTiSlLLrNO2X+LVQY8i/ZE4JoieOPubp+VivKLw7J?=
 =?us-ascii?Q?HB/3tTtg/MVzJN4aJpJ5/3bYxFXpFf2rP9TIK4LLUJxGrze73uPSQYR53nos?=
 =?us-ascii?Q?tXclyxCtzO3EHfilQmFpQVQMsVx8lY7Zd37s/cvnHj0yXVqnXNoxuSEpRr52?=
 =?us-ascii?Q?pMRuGOrbYasJBcrgr7V6sRwV5MAWyGbHctiQLoYw6/xPzviCaNpSu9ptN/2M?=
 =?us-ascii?Q?fE8WjR3v66XLZ8zJmVcLd4cQA5kHCL65WnR4JmIdXambDucohmgD6MaaMDEe?=
 =?us-ascii?Q?7MMvxpz1PBTJEUIrSrRXOq1TlHtSeyL3sJKEBUcu+Cw0jwGjKqBJutdeJs6Q?=
 =?us-ascii?Q?XjiZbAs48rj46dAVZnzdDqA8fFZcdcSb49qegO1lrJjgNVW/Lj2ScHw6xvWx?=
 =?us-ascii?Q?Mu7QtHxBzFmLsojiPpzPyT+/J2+xm7sEYmeR3BmP9fXpLIJr3a5c7uIIyYzk?=
 =?us-ascii?Q?s3bT34/uiTEgDNxAnHkroGkfnG8FdMqA6edregeDy9rAXDXuMV+yq0y87g8t?=
 =?us-ascii?Q?B2ilR7isKN3HCmUPljSmrs7zkMFqe0+05jFsLSjfoqcb92UCsKECOb6MfL7v?=
 =?us-ascii?Q?m8p+Oa/SUdkXL+0yUvPsH6DO0TWb7sXx26CXQX4pVCqsaA2+Q4ipBvWGAVFE?=
 =?us-ascii?Q?9jLwOLy9gLg4BNpe0wLM9HfUmF69ZtVSP2hG+frMPlOppSblUE77Ct8MoFWY?=
 =?us-ascii?Q?5sazbhQqWn/7rRWySHzzyTzyGEf+Tjy2Js6zHBLf4U/nKFaE1YWvGvIPzrgV?=
 =?us-ascii?Q?ROnFZrEJ8D3/L5VSZvICvAmywb1IRBaCblXJ9436Rqm1lqezpQWOt3KVITgX?=
 =?us-ascii?Q?S/+uP/ZUI7G8DY3shUycPOeRvhxYQQG14NW8NI6OIyaPJBbIinNZUK+xo6I6?=
 =?us-ascii?Q?7Cxfhu39+OJhOzHyq2KRU0i29mUECH9V3lRx8Dp2T1axz1czL70cHCXUXP2x?=
 =?us-ascii?Q?tQdZpWPRCTCvdKEH6Fwkr0L/EjcFjBgXwDNwfRHQ5vxr1PVze/M+McwLxWK6?=
 =?us-ascii?Q?bxhJ3bg6luAu9aeN6Ki1PIoG0JUMU0AcZ7UAlyTDcpm5yqrlPrpQpFgTKAeN?=
 =?us-ascii?Q?N5T6+L+iM8au1l7bSpuZfSpi43FoJ/ihn2kRdqpv71fhNaYug1mMbvKykxd9?=
 =?us-ascii?Q?tIRz/SKM4fSAdt8Ponw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39b7c3e-4a9e-4816-faac-08de158cf0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 19:13:40.9717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: da+ZUkG32fZpSJtUN4X0ylKlDu8ZgdT/csFSo6hYW41nPH3h6eJmUnbyblrgg540
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Monday, October 27, 2025 2:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonath=
an
> <Jonathan.Kim@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Clement=
,
> Sunday <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix Unchecked Return Values
>
> Properly Check for return values from calls to debug functions in
> runtime_disable().
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 0f0719528bcc..8d096f52127c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2826,7 +2826,7 @@ static int runtime_enable(struct kfd_process *p,
> uint64_t r_debug,
>
>  static int runtime_disable(struct kfd_process *p)
>  {
> -     int i =3D 0, ret;
> +     int i =3D 0, ret =3D 0;
>       bool was_enabled =3D p->runtime_info.runtime_state =3D=3D
> DEBUG_RUNTIME_STATE_ENABLED;
>
>       p->runtime_info.runtime_state =3D DEBUG_RUNTIME_STATE_DISABLED;
> @@ -2872,14 +2872,14 @@ static int runtime_disable(struct kfd_process *p)
>                                       pdd->dev->vm_info.last_vmid_kfd);
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> -                             debug_refresh_runlist(pdd->dev->dqm);
> +                             ret =3D debug_refresh_runlist(pdd->dev->dqm=
);
>                       else
> -                             kfd_dbg_set_mes_debug_mode(pdd,
> +                             ret =3D kfd_dbg_set_mes_debug_mode(pdd,

This doesn't really check anything because you'll return success if it's no=
t the last device that fails to debug unset in the loop.
But you can't break out of the loop on error either because you need to rew=
ind debug mode state as much as possible.

Maybe just store the last non-zero return somewhere then just return that v=
alue after the loop.

Jon

>
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
>               }
>       }
>
> -     return 0;
> +     return ret;
>  }
>
>  static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_proce=
ss *p, void
> *data)
> --
> 2.43.0

