Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E19FA373F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FCF10E18A;
	Tue, 25 Oct 2022 08:41:43 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDD510E18A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 08:41:40 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 az22-20020a05600c601600b003c6b72797fdso7955249wmb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bFqzFzVNYfKYoINAAGTk6UQ5JH3C3/XiPiexTxP/R/c=;
 b=fjVIvtAvn715XJrw9d6RjrsCEvttij5q3mL98wF1EtKpJfzby/ZhPh1UDWzAH7f6b2
 t7ciyo40bcMY+S0sy9xXXZ3gBMLiS9Poyw2WatJtuQopvIW6ZYS86nttDKUdGxg+9Hqi
 QBAhB+nJVJGbsQWqLFoezIOLoXHXGBV1F2Ruixb+6t08cMfYs69Ga5p6Rry7sPtjYMKg
 lelCbY3c6K65NckyNkfwFToXUXIudSvz1dEmxlcs3ttnJ/yghlbvtlNZeCbxkUU0SoT7
 hxWWex7QpFhtVf31+Wvo1g5Y0aU5elSaMpnXYaJP0VraRX13xRoz+ZzMBFKFHz+0pFtP
 8Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFqzFzVNYfKYoINAAGTk6UQ5JH3C3/XiPiexTxP/R/c=;
 b=sBhVJvSz0llapBxzVU8/6OTiKaS5YQr3CG5HFe2TZDpOwblDMUhWxO4KxyHgtHYjHE
 hFbBu0Ru2oYmvzsdK4imCJAQO49OJMxH7BOuTF/EiwSOHQnKvE2oKOQ2RLGI38FViIEo
 Ye2i8/gvR5W5wwLMUy36CeEmNc4gpNXtMS2ORBWPwCrRVa/imGZRsjDg9EioiPB4DTWp
 DM5NG584UgcQh1us0ZNKAjc7DeOFHPLhg6lzyOT4qaqCyBZruLpvf8K2qDFloT1f5Pmz
 VIZ0J+BeEBR8ARuDgpY98Una5TT4X1j6dcxco6VNLGyhvHOb5eSX/AQZkuvtTqgnC/rS
 5QqA==
X-Gm-Message-State: ACrzQf11bVotZ0AJqCs3MG1bWuO8S8Bmjhb2+x2XDyEszQxW7eZVU4tO
 JNlg2tNHZYfNJdt9vNbj+U7hRNdrJ+SEvg/P6zk=
X-Google-Smtp-Source: AMsMyM7vBX5rtQZx9OBpzHaIvWaGSSimwd8l6Ujvw4wNIoN9tVv22/XwkxeW76tQMbguZufjB62x4dX+MDynsoKUhN0=
X-Received: by 2002:a05:600c:4187:b0:3c6:fe18:b2a with SMTP id
 p7-20020a05600c418700b003c6fe180b2amr25545825wmh.41.1666687299207; Tue, 25
 Oct 2022 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221014041456.139813-1-Asher.Song@amd.com>
In-Reply-To: <20221014041456.139813-1-Asher.Song@amd.com>
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Tue, 25 Oct 2022 17:40:43 +0900
Message-ID: <CANiD2e-ip6oSgxTmY2H=LU0p8OHHLGiAfUHkwHTD1AJpPxFBbA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
To: Asher Song <Asher.Song@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006bc5e405ebd7e0f3"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000006bc5e405ebd7e0f3
Content-Type: text/plain; charset="UTF-8"

It's working 100% time correctly on my Vega 56 it was a reason why I did it
because without it returns mostly random data.

On Fri, Oct 14, 2022 at 1:15 PM Asher Song <Asher.Song@amd.com> wrote:

> This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.
>
> Unfortunately, that commit causes fan monitors can't be read and written
> properly.
>
> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 190af79f3236..dad3e3741a4e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr
> *hwmgr,
>  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
>                 uint32_t *speed)
>  {
> -       struct amdgpu_device *adev = hwmgr->adev;
> -       uint32_t duty100, duty;
> -       uint64_t tmp64;
> +       uint32_t current_rpm;
> +       uint32_t percent = 0;
>
> -       duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
> -                               CG_FDO_CTRL1, FMAX_DUTY100);
> -       duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
> -                               CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +       if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +               return 0;
>
> -       if (!duty100)
> -               return -EINVAL;
> +       if (vega10_get_current_rpm(hwmgr, &current_rpm))
> +               return -1;
> +
> +       if (hwmgr->thermal_controller.
> +                       advanceFanControlParameters.usMaxFanRPM != 0)
> +               percent = current_rpm * 255 /
> +                       hwmgr->thermal_controller.
> +                       advanceFanControlParameters.usMaxFanRPM;
>
> -       tmp64 = (uint64_t)duty * 255;
> -       do_div(tmp64, duty100);
> -       *speed = MIN((uint32_t)tmp64, 255);
> +       *speed = MIN(percent, 255);
>
>         return 0;
>  }
> --
> 2.25.1
>
>

--0000000000006bc5e405ebd7e0f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It&#39;s working 100% time correctly on my Vega 56 it was =
a reason why I did it because without it returns mostly random data. <br></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Fri, Oct 14, 2022 at 1:15 PM Asher Song &lt;<a href=3D"mailto:Asher.Song@a=
md.com">Asher.Song@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">This reverts commit fe01cb24b81c0091d7e5668874d51=
ce913e44a97.<br>
<br>
Unfortunately, that commit causes fan monitors can&#39;t be read and writte=
n<br>
properly.<br>
<br>
Signed-off-by: Asher Song &lt;<a href=3D"mailto:Asher.Song@amd.com" target=
=3D"_blank">Asher.Song@amd.com</a>&gt;<br>
---<br>
=C2=A0.../amd/pm/powerplay/hwmgr/vega10_thermal.c=C2=A0 =C2=A0| 25 ++++++++=
++---------<br>
=C2=A01 file changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
index 190af79f3236..dad3e3741a4e 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<br>
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,<br>
=C2=A0int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *speed)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D hwmgr-&gt;adev;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t duty100, duty;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t tmp64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t current_rpm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t percent =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, =
mmCG_FDO_CTRL1),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CG_FDO_CTRL1, FMAX_DUTY100);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmC=
G_THERMAL_STATUS),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CG_THERMAL_STATUS, FDO_PWM_DUTY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!duty100)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vega10_get_current_rpm(hwmgr, &amp;current_=
rpm))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (hwmgr-&gt;thermal_controller.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0advanceFanControlParameters.usMaxFanRPM !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0percent =3D current=
_rpm * 255 /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hwmgr-&gt;thermal_controller.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0advanceFanControlParameters.usMaxFanRPM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp64 =3D (uint64_t)duty * 255;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0do_div(tmp64, duty100);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D MIN((uint32_t)tmp64, 255);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*speed =3D MIN(percent, 255);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000006bc5e405ebd7e0f3--
