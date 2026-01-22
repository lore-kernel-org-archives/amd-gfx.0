Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E24D6CFA3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 18:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A502410E0E8;
	Thu, 22 Jan 2026 18:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GwGIpbTs";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C815510E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 18:24:31 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1233985e56aso130666c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106271; cv=none;
 d=google.com; s=arc-20240605;
 b=WUI7SD+m28vqFhXw5r8AaKzaaD6TmxpIr9Y6jzTLCq8NaLX66rxklBIxP0DUviW7U3
 2lNeCd1Ev/FeND46uMBgTelYdX3pPPL7WfiLveXWepgUag+3E5TXGHz+/jAzsPuvnWo6
 8CIOsn+EMcPXFqbPgiFI7UE2YEGNDlTsoIt0bFHs824fJ2FNsVr1vvuH4eP0bJ4Wp8XP
 QmORVNW3miag1FGlbHBTu/y2cMEw8mf021f9z6PkzwOPXg8z9Q189x5mS3V4eUhSRl0W
 k+qo0nnk8RVQLdoh6atubm8bnGGJrpHYMPnJYUtIs50LZsK6I7j3CI06piMgx6ZHmB7v
 v3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fS5LJz/3fqX8Qq0PvM69y9dplviiFiEXqzYwaeqmpeU=;
 fh=0U1i7E8BtYoCKj16B9nnIt/JsZkeAgytrUfMqN+57XA=;
 b=b3HkV4ikdXnK4HWdE+pZ+rsNdkNw9YhYNVTJdGYjiw1kDJ7ZlO5TEBRZIvyO9TSu0R
 mu9us1LoEGUUZzwNJty3QpLwicUxBoOsBeqgqpqwqpBpYlJW+VEsQTgP9a0bE18B6AFy
 gFysPC8XJxUhMT9eUiVfr0oggmyeEm6PWOqz7kp34KaNp14I8PIbLrEC8GvOSYY+p6GC
 RZc//OpkRJN+YgsrnV1RQ+SlCUK3UDE8ztdhNgYv7Bb4WlKfrSA+af4qry3FwiFuiSql
 1k8J1oKfkkBjcM8p1w9Oqs/8rQ8xHO/kZDw0if/P8Ioh9BWmbDSw8KV4+0ye3+ZtNajD
 sZUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769106271; x=1769711071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fS5LJz/3fqX8Qq0PvM69y9dplviiFiEXqzYwaeqmpeU=;
 b=GwGIpbTseDCDa/nxjTCnAFbmSsyopqGQanEAPtywX9fTVcEXPbDqB5ZqhQ7oU7GtDh
 1Lfl4001BYOR8dQ3abcTjHHtGrxAC3fniEF36z0/kBl09SZDsM8pzuVEEALP+N18Yprq
 +Flw7pUpCui4kjZmyA6awmzGF2DGxCu6Y787cnmHwkGKZGw1hIFrRiABEo4gSw3JhlcH
 4iC3oSDE8a7Ehf31zUWU0ri8XA85W1HXMipsHZBeSXbf591Ir0dYtW1rkLxvpQAKtjqM
 V4XTBOuRnnuIWgbhe96YvQR/NySeK7p40y8uA3a6PECuPYGlAON+YoBDmmDg6KIVy/+V
 bmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769106271; x=1769711071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fS5LJz/3fqX8Qq0PvM69y9dplviiFiEXqzYwaeqmpeU=;
 b=fQ+0K70fkat0ve70/kLz3wefzDsVircWeWz4o7SAZAQJC0xLKSsDedFDUwDTyMXlgW
 tnJdvZlKf5VUbgm7WLE6YYP9SiRUmcZjzMEpPwWWdMjOwRIYMfmKrv//W3gos1T7jd6O
 JlvgamCfMGQGkGUi+00daZVccS5e4IfN87BublpjIy2iPhpWr84L/8a892ywK/a+QRnj
 5VupmxxE0Bbh6fa47hluA1NL9XxUGloLjAAu1C/FSxrEMTFEDS9WtmDXTE8A7NgZ9oKh
 bo3dE9NveB8lhyEPmF0nZBvpOuYaSHbJFgisdO/EntXBg3G+nBOUhGU70EQUTpHSLcxY
 z/4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZER2yiQUWB/RcHp/Jc9rFzTYkL7FUFXG9z2yonA+uSu/JcgFHmzq4TFcrZworZ3zer860Vwlc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKMiaMFZU9i4TZpcvBjka9xCVu8Ha7pEVxusMtGB6/LLO2ymeU
 jyUdpcmDJV0YzuhrfENIAdCxU0qBHJb90VH5+XSrhwpwMR7yKAGzK2D8PYI6YbxbSmSiy6n5l2B
 lN4aIsOOh67GlZX1KTiHOviin08y1jVzjTw==
X-Gm-Gg: AZuq6aIaBiM3pRUXfHm+5cGjmQqnjohJsWr8+Qkw00A7A1zHFXmUSoGyEEx0tnOZ444
 onsonrNY0HkWQ58tD8z77bS5WFZzj5HMcAhRzPCqU1paAZy3bpVE3Eh7UXc60ZzmrJ37TOBdgIT
 KGYKKyiWHv4e7Xxx5rf//bmqo3FhVgpognc6ckY0WDGG65b8wTKvH04H/zId39VFNJwqZgO83mE
 uYTFQRk8tskXJRw3fTdRx/mI0SjShxlCVGxyG4d7vhb5WjU8GRQsOIqoUm06wUmEJoVfZhc
X-Received: by 2002:a05:7022:699c:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-1247dc0f483mr62868c88.7.1769106270787; Thu, 22 Jan 2026
 10:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
 <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
 <CADnq5_MxLO-9xyJr4jELJhiuXVVqAbpy58j0sw=BiMBHHG=a8A@mail.gmail.com>
 <df0d27d7-0230-4d61-92b7-3ab9d4ea68dd@amd.com>
In-Reply-To: <df0d27d7-0230-4d61-92b7-3ab9d4ea68dd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 13:24:18 -0500
X-Gm-Features: AZwV_QioZyxJxOXFIBa9MJnWizghc7PZvoM34lIuk4PPc76RdF1kn-N9MfXKiOE
Message-ID: <CADnq5_OgWR26f5RmcAAOKdvryJJM9Ck=vX8KEhuuSPHqM2mvKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, 
 hawking.zhang@amd.com, alexander.deucher@amd.com, kenneth.feng@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 22, 2026 at 12:22=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 22-Jan-26 10:32 PM, Alex Deucher wrote:
> > On Wed, Jan 21, 2026 at 1:27=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 21-Jan-26 8:44 AM, Yang Wang wrote:
> >>> resolve the issue where some freq frequencies cannot be set correctly
> >>> due to insufficient floating-point precision.
> >>>
> >>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
> >>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
> >>>    2 files changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/g=
pu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> >>> index efeaa3d57712..b0d6b7b0946d 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> >>> @@ -55,6 +55,7 @@
> >>>    #define SMUQ10_TO_UINT(x) ((x) >> 10)
> >>>    #define SMUQ10_FRAC(x) ((x) & 0x3ff)
> >>>    #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >=
=3D 0x200))
> >>> +#define SMU_V13_SOFT_FREQ_ROUND(x)   ((x) + 1)
> >>>
> >>>    extern const int pmfw_decoded_link_speed[5];
> >>>    extern const int pmfw_decoded_link_width[7];
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>> index 51f96fdcec24..e27ea0879429 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> >>> @@ -1554,6 +1554,7 @@ int smu_v13_0_set_soft_freq_limited_range(struc=
t smu_context *smu,
> >>>                return clk_id;
> >>>
> >>>        if (max > 0) {
> >>> +             max =3D SMU_V13_SOFT_FREQ_ROUND(max);
> >>
> >> Looks more like a firmware issue. Isn't firmware supposed to round it =
to
> >> the closest DPM level frequency?
> >
> > Arguably yes, but at this point, it's easier to fix in the driver for
> > existing programs considering all of the firmware out in the wild.
> >
>
> The question then is will just (x + 1) alone get to the right frequency?
> Or should the logic be like what firmware is expected to do to find the
> nearest dpm frequency?

According to the PMFW team, yes.  I think the issue is the int to
float conversion rounds up rather than down.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>                if (automatic)
> >>>                        param =3D (uint32_t)((clk_id << 16) | 0xffff);
> >>>                else
> >>> @@ -1565,6 +1566,7 @@ int smu_v13_0_set_soft_freq_limited_range(struc=
t smu_context *smu,
> >>>        }
> >>>
> >>>        if (min > 0) {
> >>> +             min =3D SMU_V13_SOFT_FREQ_ROUND(min);
> >
> > Does min need this too or just max?  Same question on smu14.  With
> > that clarified the patch is:
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Alex
> >
> >
> >>>                if (automatic)
> >>>                        param =3D (uint32_t)((clk_id << 16) | 0);
> >>>                else
> >>
>
