Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 19:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2221C1136AA;
	Thu, 14 Jul 2022 19:14:54 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191F3113697
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 19:14:52 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id y4so3666395edc.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/LuQaklzlHjl5BZ/8eW+8DGSrCrY0hPsrbHgWp39LsY=;
 b=j5cmfIzSb0o8su2rrNFsM+DdfRM5O8YbXY5cqf45nBqgp/YUiLdqlUXJ1FloTqUVbN
 BQBKarHQsRsU7Idd35j5Jqyzwg+9TrbSFy0jT3WdTtf0PidMS9tTqScnu2muzhtIA1or
 hYFIlkeSK/hVy7cxNIkYRGSA8tBiJ4bzfXtRFyJ8J7zDa2CEt5xXkoGu1B+T6g21zr8s
 uswP36Ao7v3PF5wL0HJwtjuBdPuZ7RVg2R2qJkKl8/oaefh+qAar3o2Du1kJjeRFhehU
 047aB5wyIf/eECeg0D/asBMJk0/Vb1/uCy6biYnA+O4b5cV1SpbmYr7lBqnwT1+6JlVf
 Kt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/LuQaklzlHjl5BZ/8eW+8DGSrCrY0hPsrbHgWp39LsY=;
 b=p9BX65U6dEB+RxhlgwFPi1ASGYlzDLNjly4yupHpgHDSgVWtKbkzWseIo2Pn41AjG1
 DfDhX9Em6cbntrcNy0/rRkeq6we6cKrTnYkCOuuwIDErs29udwD4fdyXsfclzC7aqVna
 PHfk9o/uS8OZkknG7bwTM1YpKZkn8pZeauwBOhf1f4pXxeBxxyxUlTQjQsJ4DOTwxuOo
 HOMpwIa/+npV9yR/OP9R9MX5WGbG6MbfEhq/UHC6md4env68kMhqYyeXnAG/dNZGkSIh
 4Gc+9bMR7ca27LG+VmbQx0SPz3eSEJcq9B+/b6wISvqw0m/edOzXMIncaorcFnmYSq+2
 wuQg==
X-Gm-Message-State: AJIora8d592oR8v5Uy8HQl9sJq0q4HdG52uZ7BMs4EHfzEiqHim+Fnm2
 R9m32OFKjHdqXJ6XbEc0MVZIrof316oalNsALEU=
X-Google-Smtp-Source: AGRyM1uGYn42AA2Dmstp5qhjOfkmCIE3Gd1zm5LuMv8WTL6o5D5bfwSjt3MR+0MHK7z9l9ON7nXoiVWW+MU7Qf3SPlk=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr14061217edb.93.1657826090552; Thu, 14
 Jul 2022 12:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <92eebfd3-4234-b3fa-87cc-c48b3deec33f@igalia.com>
In-Reply-To: <92eebfd3-4234-b3fa-87cc-c48b3deec33f@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jul 2022 15:14:39 -0400
Message-ID: <CADnq5_OGGMTDhacr+x5jO=DttEmTvsMWPLZGxcQ=_GJS4B-r+Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
Cc: Magali Lemes <magalilemes00@gmail.com>, David Airlie <airlied@linux.ie>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 14, 2022 at 3:05 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Hi Ma=C3=ADra,
>
> Thank you for your patch,
>
> =C3=80s 13:44 de 14/07/22, Ma=C3=ADra Canal escreveu:
> > On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> > should be written into the control register instead of 0.
> >
>
> Why? I do see that tmp was unused before your patch, but why should we
> write it into this register? Did you manage to test this somehow?

The patch is correct.  We should only be clearing the enable bit in
this case, not the entire register.  Clearing the other fields could
cause spurious hotplug events as it affects the short and long pulse
times for the HPD pin.

Alex

>
> > Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> > Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
>
> Checking both commits, I can see that 0 is written at `mmDC_HPD1_CONTROL
> + N` register in _hpd_fini() in them, so if you are trying to fix the
> commit that inserted that behavior, I think aren't those ones. For instan=
ce:
>
> $ git show 2285b91c
>
> [...]
>
> @@ -479,28 +372,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device
> *adev)
>         list_for_each_entry(connector, &dev->mode_config.connector_list,
> head) {
>                 struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
>
> -               switch (amdgpu_connector->hpd.hpd) {
> -               case AMDGPU_HPD_1:
> -                       WREG32(mmDC_HPD1_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_2:
> -                       WREG32(mmDC_HPD2_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_3:
> -                       WREG32(mmDC_HPD3_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_4:
> -                       WREG32(mmDC_HPD4_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_5:
> -                       WREG32(mmDC_HPD5_CONTROL, 0);
> -                       break;
> -               case AMDGPU_HPD_6:
> -                       WREG32(mmDC_HPD6_CONTROL, 0);
> -                       break;
> -               default:
> -                       break;
> -               }
> +               if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> +                       continue;
> +
> +               WREG32(mmDC_HPD1_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd], 0);
> +
>
> 0 was the valued written here before this commit. The commit basically
> replaces the switch case with a sum in this snippet.
>
> thanks,
>         andr=C3=A9
