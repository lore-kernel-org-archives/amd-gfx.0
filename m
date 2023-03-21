Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F007C6FD20
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 19:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EBE10E805;
	Tue, 21 Mar 2023 19:54:05 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B0710E805
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 19:54:04 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-177b78067ffso17365513fac.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679428443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsCiSE4Hb1pCWgqie68S4G4PcCaZ4SdoahP9G0ikEzw=;
 b=XPjw/nNFY+8JdBu47C770Kg+Qj7EVXn806vK2YWHSMxhqK66JL6umpD+MgT4eqAnbA
 m5cCALO48igMuYDzZR2qkZs81eR9EsEbRG2s3NmmFIKIs899NH4JbQtLgE+HVeNzAKIR
 jbrQUcJxHOnX3Bt+nVfmQqqXn3ZwPfbOQiMtv6AgmS/MC+TtW2MJrb0Mxp+jtMU9b6Yt
 3M8bWgcg3LQjl95VkZZtNePJvAOJRiBkTP1w2vHpcgAw66yZhXXsNiA22ut3siJs5bW5
 gk5AmrUYoRXGP5WyOqobL1obkknSsh0fCoffaF06lvhXHxMUVldta45lf0eKtDJGz5bD
 269g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679428443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsCiSE4Hb1pCWgqie68S4G4PcCaZ4SdoahP9G0ikEzw=;
 b=eP40dEPe3z9KjOSOvxG9xV2vDX6/THfCwHIFUWYZd0uKg97wM+pPIzM7BBqjnbBMsq
 xEYC3NJ+GELUl+wqOkRt0gp+P2+87to1l6FIRxsw5BJ1fb0zK3wg0WwHxMLxqC2m7kkB
 +Th7gWBOhaOMG26j4/EuVakdNASHsoWBvB6FcP+N2ebaCmVFqEUH17SojO+BIqs11VED
 PtgUsqEbwMwn2YpglSqNeA/ApXSQ4G6bM2EM+ajzfxOIBJzkyoMvKsF3+wkGi8gITE9z
 tIWhmOmtqCCAXYHPXJVm/yXbyLKBMDBdf8nWGOI3Q1RzmZeAsLFt0GWsv5wHmLh9zMbV
 E2XA==
X-Gm-Message-State: AO0yUKUkIfz+L206wW8JnUSQg8PRLyHf4V5/TpevXwfxzDqjsuXkHeXW
 bZC8asMWVYlGvzIz68C8UV4bfhnwRDLFA/jqp64=
X-Google-Smtp-Source: AK7set/tX/0ctnDyUfERN9A3p8M2m/0J6sXZEUJeyWoxOhL3LpfEqh82CvmzwoeMUtgx3oNo6eSbk0z++JwEg+pXfTE=
X-Received: by 2002:a05:6871:4905:b0:177:9150:e7ba with SMTP id
 tw5-20020a056871490500b001779150e7bamr59922oab.3.1679428443536; Tue, 21 Mar
 2023 12:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A7enKdyE_cBsCwCFZJjSWQZgOGZYCfUT5ShZN2DGa+Qbw@mail.gmail.com>
In-Reply-To: <CAAxE2A7enKdyE_cBsCwCFZJjSWQZgOGZYCfUT5ShZN2DGa+Qbw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Mar 2023 15:53:52 -0400
Message-ID: <CADnq5_Or8QGhBwoB-rc8_gY2g3gaX-4Fvz8VaGKnaRXfJZMCNQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 20, 2023 at 8:31=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>>
>> Add UAPI to query the GFX shadow buffer requirements
>> for preemption on GFX11.  UMDs need to specify the shadow
>> areas for preemption.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index 3d9474af6566..19a806145371 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>>         /* Subquery id: Encode */
>>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
>> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
>
>
> Can you put this into the device structure instead? Let's minimize the nu=
mber of kernel queries as much as possible.

I guess, but one nice thing about this is that we can use the query as
a way to determine if the kernel supports this functionality or not.
If not, the query returns -ENOTSUP.

Alex


>
> Thanks,
> Marek
>
