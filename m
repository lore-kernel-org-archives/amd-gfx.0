Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D044EC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 10:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0A710E17E;
	Wed, 30 Jul 2025 10:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cj/SEg2X";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6347410E17E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 10:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frF+3l04EA88sD+nXrbQS5di1yeqqQDoc0EXG/4kQPH8ga+XSWv6l+J5CQvzQkgrLUNLBRCpm2UNojDNR5FxFbuc+VGauMlDKi7WqA/mxB7yvUZLiBQvwGYGjC6QcMI1qNzGslDUwvfUwb6TxHBxsxp+tFpf5csbVhk7lm5iXRVB2BRpVhmRXR0/1Pp9saVVRy+Ct3bkzMKfej/0ePuH1+o8TGwLZUMtujmyTEsliDHB8ES3jEY3YQXHRt/cIj8vHddvUQs7h1Ogjrqu8PbX22a0xwZN5KXCeHOGQNxCQqiywjO9L3hLEBpJcoDQ8vN55EOPEEYAlYOh/NV3gqX3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0GvRtEiZGwyPYY11m33ovjgWPdwN9pxaLbJZgpY8Ig=;
 b=oCc3g2QD0+rKcGDgaStrPimrsgufbtgQHHqusZAEyLPWxancAokWSkUDJpciilmMGmRxuZ70IB1Ib6wt8c8ALZ9AYKpEP41fCBnZH0hOmBqIUsy5wHEMos3bq8TClp5Ja50IskHg6KAxFsMn9MZLp0/lNHzxiK7pjAUW6YmCBsEQrRNF+p4s3qNt+7eCCLCtfgPkeII104Nv8PDZe4kVjTRUUa017LyaKxpql5NiH7xypXh7rAR4zYfeVVUL99Gdacfttjcuqh8oSdtkhW8YWFAQlGRTvUDSSzVGrQlwq+KyLlXoro1mG3WraxIoiDnzyPHCF1RVEuntctjMPDpcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0GvRtEiZGwyPYY11m33ovjgWPdwN9pxaLbJZgpY8Ig=;
 b=Cj/SEg2XoD3oFIorH0Zc2GEI2sAqvBQXa5qrYxCPWwnvAuc2qFhyBsayaV9CzvIjtdTnkCfNDqEfoTvi3Y4d4Iv6vODpLfITYSbFBHN4spWpD35KTQrNbu0sGUYXPwblXr9T8tAxe+2QaRHFRkklczbJzdhQNVHDmc17WTyKM94=
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 10:46:12 +0000
Received: from SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae]) by SJ2PR12MB8807.namprd12.prod.outlook.com
 ([fe80::563a:16e3:6049:53ae%4]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 10:46:12 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Xiang(Dean)"
 <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Thread-Topic: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
Thread-Index: AQHcATPoLqwXEcjgBUabfDJMe07Ea7RKe2qQ
Date: Wed, 30 Jul 2025 10:46:12 +0000
Message-ID: <SJ2PR12MB8807A6715D8376959EDA3BE8B024A@SJ2PR12MB8807.namprd12.prod.outlook.com>
References: <20250730092454.58644-1-xiang.liu@amd.com>
In-Reply-To: <20250730092454.58644-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-30T10:44:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8807:EE_|CH3PR12MB7713:EE_
x-ms-office365-filtering-correlation-id: 2ab6e404-4087-43a0-e2fb-08ddcf564d1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a3vVnGV8zjCI8GAUtvNiwbW5h8kPf31Pm/V6K8vhrgHVLbuiEgyaGFYI4h2p?=
 =?us-ascii?Q?g12CVIDGq0Y9Wd2KDewcbv561Kfh4U3x8NZzpketABqq16LE1UVsgsfZStyn?=
 =?us-ascii?Q?oSGrQFFAVEx15xo3778JNRBfB/+9A4rddBB3UYlRGx1tfZcQ7tLZSqJVruLX?=
 =?us-ascii?Q?XF/NdqYNHzNSNma4IeUr/extjWjyb3vkY1tE4O++KtTs3OrY5kTRs2EyaEmc?=
 =?us-ascii?Q?6Lk35slXhHJVoFAgcOo46l254K5y380LvSo2s/DXDIEASF6PNHQf/qwCIgSq?=
 =?us-ascii?Q?BebyqZbMSnX3PVflLV8WHpJur21LD/8Rr9PFGaiWXyjEqu0PrNRX7zIgEAbM?=
 =?us-ascii?Q?hjup5Y0AX74RNBXqQxlBR+fEAgJwYWh/+5TgZHaJJMSIEfATKWzgc37lRXSL?=
 =?us-ascii?Q?Wux001Z/+HgmNc07krACn1usc7JUdk6kfE4aRgXqSro8cfwvwEdvYwIuH34j?=
 =?us-ascii?Q?NUmwdVKSmX9tO4FoJ5hZhHbWdxfQf6BcQdc/lKm37xn9kFwyZy0gT1YOrWds?=
 =?us-ascii?Q?n15CNdb4bcq2tGnTV0yp/YvozC1PsmkQXm7MZEYYxKVT71x5lPUDZKfSsy8H?=
 =?us-ascii?Q?eUlJmp79g7d9LvyrAZobe3C1+XhPHdKYTGDngV89dIpydNIi2cGTs061fCJP?=
 =?us-ascii?Q?H4ckXUn2rEiMX66gMQ+dMEmoZpLiwk81LRjgX5sc9yb/8e6dMHdGacz+tQWo?=
 =?us-ascii?Q?9nt99pMSPHs7pb0YjfwKvohlrA8LIQjjiZa2h/Uol9V6Fq3fZ+qrSfFoASOj?=
 =?us-ascii?Q?+5EnqUIHCksugwgDSIQAQHVn+4ZX6C/a//akJkdkXxfOYY2TArJTiQ8Mb+ul?=
 =?us-ascii?Q?2qbEzQYbpzt6wARJryKFcCLHONbrBjSN9OQkedSxR3mUvDPMxXBFqXWR/lHK?=
 =?us-ascii?Q?3AxG/dbV09rqWlkiCrwJL3TS5+9xDgLkp/CBndlV8e+jdx/FrvTI514/PGnv?=
 =?us-ascii?Q?OomdmsWERSmfd05B8DeWgrkOuPFWrmUUzpiBm9ul9klNlY9oWxb6tvLheCUo?=
 =?us-ascii?Q?0Wj18xF7ZmkuEI1ga9fG5lpTJETx4eXGGp51iLxc/6cw6wZeIvU814Q6u7At?=
 =?us-ascii?Q?7RE0FjHxmwjliYg6AuHCg1SQnjkZ2ct8SC+cLn9dVlaxcU6uoapcu+BtW3W2?=
 =?us-ascii?Q?3o07lsqUhRfQqbXT/n5a628T8jPBlVa2Icv7pvy0gM8rKKfrJRK8/I1S/1mA?=
 =?us-ascii?Q?qvYJC5mLXPdgVhv3bq00Cm+8SZyRAKcr4OPoSurghspr9QjejLV//mpSmCin?=
 =?us-ascii?Q?8KMMo7jdudqZNTqaEm+GnMW6PKuP/0FnKhUhEzGYrnXUctcDDZOuUFvEqJl4?=
 =?us-ascii?Q?YULuRjRc4Mkn4zF+ltv8RzVf0yQWUqkAT85zxBfmy46Y0P4HPSL7QYFBGhyT?=
 =?us-ascii?Q?oIo4Wl1doBZhIgaipsZXSxs+RW7aXyxUDaNlK4F8ZIPWRBocC0clIkmvCyme?=
 =?us-ascii?Q?aIQgU0JJ0cL8mn6x1A95XtDu6tgdj4r7A8hhHbbYC73n3A+QfeOVEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+4F/6TBCuCsk0Xjuxbpb8v/djT4e2tCIofvJJlTDjNMaqvf2+yCNlw653z7?=
 =?us-ascii?Q?6e05jW9lM68p8RoCy8FbkPVBAJ0jdpgeNVT8/35AomqX6GrBzuAtDm1FNIko?=
 =?us-ascii?Q?24hGlgcjRyEl7Zl2CXkWRKESGfKCWcRUu2F5O+FZI1muMle6vzPQDqY9lJvC?=
 =?us-ascii?Q?KZPa4O7OSHQwCFxL9Fm6TdsQWI8ebmmpXsR7fNbDWss+/dW01sgbyzQNL9BF?=
 =?us-ascii?Q?WmUJBo0rDJebT3fhi1mlSnkZ+wuFKXVNjl0yWcMAbkGQPJHpb+mvW4hHKe3h?=
 =?us-ascii?Q?I1wkO2aesREBsK9771QOrPqaRrVg4nGevxO+5o10D4GRG1rLFlIsEwnRmBRz?=
 =?us-ascii?Q?b7rpMJao66v3DhgvrvjYs0Ov0N2seMRwY27gVlamAEGabVIgpySP/fRaF5kf?=
 =?us-ascii?Q?e4wGZ9k2pDOPVy9ghHz218nXjPQ8ObEpN80rulOxXKE9BOTAOMrpJDBD7Qal?=
 =?us-ascii?Q?VXJS70fHCKpWJbrrhd+Jsi85ZYjHHPzZAjn/+pzRMIrn52C68bifqL9hR3En?=
 =?us-ascii?Q?sAjDcgIdcnyEJquO4vfMAWRQI9YJGboD0gMQ7rZPuITqjPb5G8oisz9OZT2G?=
 =?us-ascii?Q?UhMNktq1M5erdJTcy6xmTjnlsA0d3AefJWJRQ6KZI9M9RwOLkf/gRWN5Xxbn?=
 =?us-ascii?Q?AO5nnF22jy/JGP5Qb91TbNDmQx5bcZwT4w8wGRu+UfFQ4sVLEyPk4/D6aCM+?=
 =?us-ascii?Q?j+goeX8OxCM2ikOzqL91ekhCKNnzPqOFwJM3lRIYLqncxqJkhFe8L0n6Xet+?=
 =?us-ascii?Q?AYm5v5XtYtOoEjW7xdbM9c0cI0hAqxkX06U6zG0fo4kVsvB+hOdyu57TIkiX?=
 =?us-ascii?Q?XKl6/r6HljVEhec4xpiik+ZlLa6w1iYSTuBuLfak+kwWfEKJj2UNdovLSp8r?=
 =?us-ascii?Q?AOZJuOfZR5yX4ABGhC/VjfNAZJJLE2iddX6+tTeWzJl7PoSpN1z54SymSzO3?=
 =?us-ascii?Q?N+ZMY0cBPK2H/2ykY7IgICQdB4JNZqgqe2gbtG4u/1+AyoSykwajxjP9E8ET?=
 =?us-ascii?Q?eH57FE8ODrwU8GpXZ29YT2f0f/ngolEvhU2JQezby81aFydEo6DQNG11gSer?=
 =?us-ascii?Q?X0t14qt2jKb1omcwHxVXHxuEsPaos+b5WOxvQ+JXn5FZEQdXkuGDCkIpLq87?=
 =?us-ascii?Q?LPwkWgyIPSDPcYJoZi9kbltNWfTMuxnB388LmkB5d4284Ju1eTjfVHLIx/DE?=
 =?us-ascii?Q?uzCKTheCP03TPerkO2KrkSfbbYcZhx/GrB59RO6utUrnIkaJU+GRmW0bE7nc?=
 =?us-ascii?Q?fqbo0/ucLxEneI7oCNsIdcxCLs0E7CAoWJ9RDYCuSMluJzcSrjjmGPT1WBZj?=
 =?us-ascii?Q?1rbSEDis0vpxctVHBrHVZDLp0OEkPfTKHXI6glMvlpNvEC3KC/gyxmPzQ+CQ?=
 =?us-ascii?Q?6rPnbOjnNJf/YJSvAMGwMor+mNKEEEVAD0Id3OiZDk1MKn6LdsUgTQWMeOdP?=
 =?us-ascii?Q?yE2ApJN1vxtK7JGAYxMWFraDUhp88UBqQoAs+2m2oyzBZkDB9HRuAn6xl4qE?=
 =?us-ascii?Q?Nk6iLw32CDLRm5YJFQ4KWf0LodR5EYK16o+E1u0+mKjzil7Ujo0wwTZMqRRM?=
 =?us-ascii?Q?IavP/Qtpfy16wfl1b4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab6e404-4087-43a0-e2fb-08ddcf564d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 10:46:12.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k99xax6AfXhjlfoxFDvqXUrAitAmUEJUZOeqtVPKLW2uGAhEw3xydffnrjVs2ftS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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

[AMD Official Use Only - AMD Internal Distribution Only]

Better to add comment for the added condition check, with this resolved, th=
e patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiang =
Liu
> Sent: Wednesday, July 30, 2025 5:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean)
> <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Skip poison aca bank from UE channel
>
> Avoid GFX poison consumption errors logged when fatal error occurs.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 47 ++++++++++++++-----------
>  1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 3835f2592914..59dbb9257096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -125,6 +125,27 @@ static void aca_smu_bank_dump(struct amdgpu_device
> *adev, int idx, int total, st
>               RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged
> by the scrubber\n");  }
>
> +static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
> +aca_hwip_type type) {
> +
> +     struct aca_hwip *hwip;
> +     int hwid, mcatype;
> +     u64 ipid;
> +
> +     if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
> +             return false;
> +
> +     hwip =3D &aca_hwid_mcatypes[type];
> +     if (!hwip->hwid)
> +             return false;
> +
> +     ipid =3D bank->regs[ACA_REG_IDX_IPID];
> +     hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
> +     mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
> +
> +     return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype; }
> +
>  static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum
> aca_smu_type type,
>                                      int start, int count,
>                                      struct aca_banks *banks, struct
> ras_query_context *qctx) @@ -163,6 +184,11 @@ static int
> aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
>
>               bank.smu_err_type =3D type;
>
> +             if (type =3D=3D ACA_SMU_TYPE_UE &&
> +
> ACA_REG__STATUS__POISON(bank.regs[ACA_REG_IDX_STATUS]) &&
> +                 !aca_bank_hwip_is_matched(&bank, ACA_HWIP_TYPE_UMC))
> +                     continue;
> +
>               aca_smu_bank_dump(adev, i, count, &bank, qctx);
>
>               ret =3D aca_banks_add_bank(banks, &bank); @@ -173,27 +199,6=
 @@
> static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum
> aca_smu_
>       return 0;
>  }
>
> -static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum
> aca_hwip_type type) -{
> -
> -     struct aca_hwip *hwip;
> -     int hwid, mcatype;
> -     u64 ipid;
> -
> -     if (!bank || type =3D=3D ACA_HWIP_TYPE_UNKNOW)
> -             return false;
> -
> -     hwip =3D &aca_hwid_mcatypes[type];
> -     if (!hwip->hwid)
> -             return false;
> -
> -     ipid =3D bank->regs[ACA_REG_IDX_IPID];
> -     hwid =3D ACA_REG__IPID__HARDWAREID(ipid);
> -     mcatype =3D ACA_REG__IPID__MCATYPE(ipid);
> -
> -     return hwip->hwid =3D=3D hwid && hwip->mcatype =3D=3D mcatype;
> -}
> -
>  static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank=
 *bank,
> enum aca_smu_type type)  {
>       const struct aca_bank_ops *bank_ops =3D handle->bank_ops;
> --
> 2.34.1

