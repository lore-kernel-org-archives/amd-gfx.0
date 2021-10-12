Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0CCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A568860EFE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A568860EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589306E99D;
	Tue, 12 Oct 2021 14:19:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505126E99D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+1U0yjAfuCYmOXIEGX+pKHS/9lIuxmx0nOoCmjv7awGaHQhaTRr2FvUdWbQbcA1Z+oC0RH1Tp77tjHhFEz51J+by1231IkJ5aa2En9S4acte2takM/kjX1KixEqRUZewUZazmEqMRSgEe6FKI9GNWV3oDbEMpssZNWje+15YpwzeRCQ0PaIxLk7VPfzfmU2gRcDqWM6Zh08NoKovJVsvPfPMlq3d+RslQ0QDkkCnrkUdp0TXuWritEtViq8BjCVC82t2Wp4QbUtphDb8DoM6boXT8Mswh6oEX4UN30Ew+G1XTKLaio0PeneddYw7Oto0Qn5gjN+mxnj8kNp0LU4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNKmJxyj0rN1Ijxwrux8ytAs6LKEAs1GxtMx+DvaXu0=;
 b=IKVQGlc5M6yeSJnLoXoG7BloZO9wSKZFqQTiOHrTLChYI+zPIyRH5GDsPylPII2ZEPD4eS/FXbzvj3nPtFaGklcW8igViYkah8ZKLk6R8x/ShqJ/rI/EN9vpKBLNwqo+NZ5E4ghBkFwPLoOG6M7zjgruXffODsWwpxtFen/yWqyO3mTJSyRvqycLwPZAr5udbY9PhL2J57bGzb3/aZhXlbwz60UIQmPnVfI3iWe3/QH4cPi6vbm1kvN6ZVEGQ6yx6BmlIqJqIVfxsq/da+850GMW8Cc3FaQY/1jK13QCh98HCnKMhjbZgMbKdS0lNOssOGEDPR7uch9zOUc9i1QNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNKmJxyj0rN1Ijxwrux8ytAs6LKEAs1GxtMx+DvaXu0=;
 b=4XhhVQVbGbQLVOD3k9gRH31KitikU0a8KJeSKjkT7SWSeAVLfJK+Q19t4Hzdqfd4Pz9O+SkSynXenDL/3qJNX7gUAJaSrj76GuRRJuZki8ARj+K7zU78OYPMA8syjJNgh9cwKUY8lVAKznM60ZAvzNm1aZiVQ7CskU1MOCEVb18=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB2731.namprd12.prod.outlook.com (2603:10b6:5:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 14:19:26 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be%2]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:19:26 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix surface optimization regression on
 Carrizo
Thread-Topic: [PATCH] drm/amd/display: Fix surface optimization regression on
 Carrizo
Thread-Index: AQHXv3ME+ykj2ak2b0Wvp4Q6/ZihBavPaHQAgAAA5W4=
Date: Tue, 12 Oct 2021 14:19:26 +0000
Message-ID: <DM6PR12MB3547B8C2BAA700E46FCD0C15F7B69@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20211012141102.4590-1-nicholas.kazlauskas@amd.com>
 <CADnq5_NU2PQjmJSuta-aBUZbuM=cLgrEFeGxtXSONRNF3D2Rkg@mail.gmail.com>
In-Reply-To: <CADnq5_NU2PQjmJSuta-aBUZbuM=cLgrEFeGxtXSONRNF3D2Rkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T14:19:26.282Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b9aa0208-bdf7-dc3b-51d0-baf7feb41051
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab58dae-b811-4d31-2a80-08d98d8b4c34
x-ms-traffictypediagnostic: DM6PR12MB2731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB273122FC554C64DB9F282ABAF7B69@DM6PR12MB2731.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdhCr66hRbpakowkuRJoD1qYkMqOdNipx3gL7CbTt61B6kEqIlRjbVb9dDEQiR23+wqvH/H7JzJLN9kpvKp4fAh4OTCai0OX75P851cKniCIWaxSIjFyL5psBg5W0z5tUZaaRaPWCKyQ/rQpcA6tuYW8KGKvxw/mqv7RsDs15+1JlzhX+HQGg4u2pN26bEdchvffCVI/MhAnq+F4EO4278UwXpwTUnqPWwvwdegL//EtmYFqbnbH1nMI9u+rrnAwo8gDFhQxy6zH91Nr0F9LGE7LzjhCUB3hg4fGgopMpdrUdrL9/nJuhV66+7Q38AB54YiwviUxG/tSZY0dI8URUsV3Kh333dZWODFCFCAA9vNTr9x0HLS6DHsRLq2EWx9DiKujC83V1l6O04h+2IyWnxVrGQilgtuOg6F4Vzo09rWRLRIhdtYu5oTOu4nYVVi6is0Ny8zhGJoVwqJziXeBYnYZu5eevIFOB1Z/c4L3ENNTBY2SBAGtq/SOnNPJyf0w7ryWgn9nvYbBfO9HLhSCKFWjHfyqAq8xd3haKqglT7H4S5tJUumA12xtLiEpERbZTG36ZRQ8WW+Qdizb99q2NtZlXwFl0dYv0Z8Yh8A7rW+QyfCnwANHm7irsobLGKBmNnY14PzF9FuaS2PWdVpcgvvSoOF1udvOkDHRtpX+1G9v89U/NicwJRnVxhlGFsHjYbhB1nd+1RKYL++QM22l+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(5660300002)(6506007)(33656002)(8676002)(83380400001)(316002)(6636002)(52536014)(110136005)(4326008)(54906003)(2906002)(186003)(53546011)(508600001)(7696005)(66946007)(86362001)(71200400001)(9686003)(122000001)(76116006)(91956017)(66476007)(66446008)(64756008)(66556008)(38070700005)(38100700002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e7my6cyHNTPkUi/59POtIlv70+npW6HmaP/gsRyajqQ6O0qoleT8CILK3b?=
 =?iso-8859-1?Q?H4YXcWGjd+chIVonn7IzNslZ5bLUvyGwXkqUyA3EO0GNSq8Eqdy8YmcdrB?=
 =?iso-8859-1?Q?giCvyWglM0H2a9VhfZEkGiSta/QGYy3sFsqHISJ3a8Ar0puXlyqdZTfW4C?=
 =?iso-8859-1?Q?dsICEWfeOT0Kx/ae0q+Tp4JoWLTb9XobJZTKI82LrYAPEppAjmOhMAcHm/?=
 =?iso-8859-1?Q?K7DWGtGn6xu+V3XvG/CzOAPRRcDamjB8MVF9ffOzwCp1JsJ33XEmtfgJKs?=
 =?iso-8859-1?Q?u8wAsqYezz0tqessKeX7bq8FuRdi6Ir5NTMYldpuwRmcoSegVIyUtRbalJ?=
 =?iso-8859-1?Q?t9LA7NNBSJbAUMaZtkMeQiUUXTnjphInMb5djepdEkK2JQ6fJxaW9Gh9A+?=
 =?iso-8859-1?Q?3c3KkwCiks/J9PwDngDRB0MovE76cMT0DPRMy7HP1rVBRubqRDtLgGd4mv?=
 =?iso-8859-1?Q?wEFTfZzAXyITtcydphXsoqq7tN5JPvE912dhZl0EMrfGYPhcT/P65sLvAR?=
 =?iso-8859-1?Q?3mmaXk9s+jexIEPNcSVN6DV4i4h0xhgKcrfbhvzJeYf/a3FFE8EeZhYYG1?=
 =?iso-8859-1?Q?VJl/J7+TpTjU9/PvCWOBbh2pMlK5jUF41A1WbdTXwWBqmWcsMazAQCv0Jr?=
 =?iso-8859-1?Q?ZWuCfm5ah4+TZsbUqMiwNAgEbQoHnbp9xmUNHcyzQaVlfUQIiBcp86wU5y?=
 =?iso-8859-1?Q?smjI0PY/gux8M1+17BMW7puD8ZrMGGRH+1OW3DpIupZe1rbdA0fqHDXqMl?=
 =?iso-8859-1?Q?7lh0IULaT5cL7lwPMvmBEo4grMeYeG0V1aPJIXIy1kES/yyJ9kS/e37q43?=
 =?iso-8859-1?Q?/Sr+hh9K4kMdJl7cKfYz72Mf7DZirnPNouuKVYOGtpjuWW7Xr6fH8+dPjr?=
 =?iso-8859-1?Q?7V66VsJfn5vOJONfGYlIbu72gbnwjvbvoQhmed4P4WYvVciY1avlq5KpTK?=
 =?iso-8859-1?Q?DiyS40ObqwlYntFtshgWxsg6wJXK8H8iT6q5ulOmoEds1sEJ5RuM3rbXpn?=
 =?iso-8859-1?Q?r6nbrquWciksOFsFEyV86iAAVy3jHpUiiuKVooeC0rS01po3yZvMuHaGss?=
 =?iso-8859-1?Q?zwOVbgLNTUQLxDErc18e3L9ZFrkWlKuFbQxvgzafqqzesv9ES1nm8ATRqJ?=
 =?iso-8859-1?Q?pOtj0dJkyh2MRJOtjeuQBNcyatfIQuLAiGethNo+DB4DVm2UTeogsd+mQp?=
 =?iso-8859-1?Q?66eLy6ouZAJxNSAhNR8dblLheQd7QjBfK92otbOa1Y/7jJnkoRWtgoGWt3?=
 =?iso-8859-1?Q?0mgKD6Od51B12N3AsbsFoscC+gW4vgEUo6wUXkbGkCckuSGCkm3veVBP22?=
 =?iso-8859-1?Q?NXSjm/+mMKDq6Vp+ippiIcqDjvZ1FZbNLfHd9G589Sb4Yy8ujg1BWf4jQ4?=
 =?iso-8859-1?Q?cXeM0LvKu7/Lc+LNGHfzLqoyZeM4G5iA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab58dae-b811-4d31-2a80-08d98d8b4c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 14:19:26.6804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsXCfNapipA8hlQ3uFooomIZZejMV9O8OJd7DlRNnLdVBDz/lmVbjrFtmldUbZGuDp0pGxInv1WPwSt4VkV47g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
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

[AMD Official Use Only]

Tested-by: Tom St Denis <tom.stdenis@amd.com>

Thanks.

________________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, October 12, 2021 10:15
To: Kazlauskas, Nicholas
Cc: amd-gfx list; Lakha, Bhawanpreet; Lipski, Mikita; StDenis, Tom
Subject: Re: [PATCH] drm/amd/display: Fix surface optimization regression o=
n Carrizo

On Tue, Oct 12, 2021 at 10:11 AM Nicholas Kazlauskas
<nicholas.kazlauskas@amd.com> wrote:
>
> [Why]
> DCE legacy optimization path isn't well tested under new DC optimization
> flow which can result in underflow occuring when initializing X11 on
> Carrizo.
>
> [How]
> Retain the legacy optimization flow for DCE and keep the new one for DCN
> to satisfy optimizations being correctly applied for ASIC that can
> support it.
>
> Fixes: ab37c6527bb1 ("drm/amd/display: Optimize bandwidth on following fa=
st update")
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Reported-by: Tom St Denis <tom.stdenis@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index da942e9f5142..f9876e429f26 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3118,8 +3118,13 @@ void dc_commit_updates_for_stream(struct dc *dc,
>                         if (new_pipe->plane_state && new_pipe->plane_stat=
e !=3D old_pipe->plane_state)
>                                 new_pipe->plane_state->force_full_update =
=3D true;
>                 }
> -       } else if (update_type =3D=3D UPDATE_TYPE_FAST) {
> -               /* Previous frame finished and HW is ready for optimizati=
on. */
> +       } else if (update_type =3D=3D UPDATE_TYPE_FAST && dc_ctx->dce_ver=
sion >=3D DCE_VERSION_MAX) {
> +               /*
> +                * Previous frame finished and HW is ready for optimizati=
on.
> +                *
> +                * Only relevant for DCN behavior where we can guarantee =
the optimization
> +                * is safe to apply - retain the legacy behavior for DCE.
> +                */
>                 dc_post_update_surfaces_to_stream(dc);
>         }
>
> @@ -3178,6 +3183,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
>                 }
>         }
>
> +       /* Legacy optimization path for DCE. */
> +       if (update_type >=3D UPDATE_TYPE_FULL && dc_ctx->dce_version < DC=
E_VERSION_MAX) {
> +               dc_post_update_surfaces_to_stream(dc);
> +               TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
> +       }
> +
>         return;
>
>  }
> --
> 2.25.1
>
