Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D0C6FA86
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 07:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA20D10E288;
	Mon,  5 Sep 2022 07:04:47 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8A810E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Sep 2022 15:29:59 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id b128so2415882vsc.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Sep 2022 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date; bh=3WBfZBRxD2lj7twjbO+1SJCTIiVK+qortc9qhiiFJMk=;
 b=NxOZ27EKRCXeq6+6f/1Jtoni4je3gOe06ufGVhyJrqgMQ0kt5VoWHNSQq+CKRadV6L
 5zaq39oaqROeU+PLXN3RkNZo5k2D4etdiJ6TnhQmrlSV3apWVxaf6XfJwijZk4jZze2/
 qlNSOGZkOBQln3fLgXoYr5KM15clAmVr2hm5u+TQttx6fmU4cXNPKZrmS6xx0keBN0/M
 WFcKTW4a+0x802oNw7eprw7vnXeFt7p2Nh33hziRffRhQQjCt2QS5Spk+2I9WKi47MLQ
 N4zXRChpKW/Q3CfhWohm1lgYQj4GiyinGCRzkLxwz3xVCc/MDLErhvtl6ygpvCfceqfI
 SXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date;
 bh=3WBfZBRxD2lj7twjbO+1SJCTIiVK+qortc9qhiiFJMk=;
 b=wfwyfUASXMOTur7DUqFn77Y2XOiBS/fwLHgbmLk7n8jnwoDCIDhUfd7+MoLaCF2hs7
 34IRUEFMHrjzTsGx2q0tqAET0cbQp5K07L+Wc2r1+B2Ntnjdw5kRlCKw34UWADl+JZcE
 Iyq5nIdLps5szX5b8qApKe0caGb75BT0W/Rd0Prjpq9A6Lb1wm5kNQYtgTUGFggSkANl
 htd9R7lkimLIn8ZfeoI4TvKpPMZ6mydh3SEq2WHeQPHAh+Nb8ZR8XoXPil3KfSqlBlDf
 AuKx1z4tDxejlBAd41icgKKBpbT5Lx7NQ4afS6Ev007xZLqX1epE44IV4r/vSKfKMy8e
 E2TQ==
X-Gm-Message-State: ACgBeo17gqaN3P69lYMHJRuGfEmZt6oNs5TYPyuA8WZgKiXE+AzraESw
 RxN/gYJfziPXQLz9os8n63ne1TQ7Ev8q3Zm0yI8K+6yNkvA=
X-Google-Smtp-Source: AA6agR66F48clRLNqVOCegByEm1Oh1tQsJOagRLhP178uNKQWyALviYOqc8rnE/aFrP+XbGMq36YCAnTCZzfHYmmHc0=
X-Received: by 2002:a05:6102:662:b0:390:f5e4:9772 with SMTP id
 z2-20020a056102066200b00390f5e49772mr7385761vsf.74.1662132598451; Fri, 02 Sep
 2022 08:29:58 -0700 (PDT)
MIME-Version: 1.0
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Sat, 3 Sep 2022 00:27:24 +0900
Message-ID: <CANiD2e9U=QXyYBOZLyTyqamtSJ3pyz45kZjEH04QbSpb=4miEg@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000019b05d05e7b36761"
X-Mailman-Approved-At: Mon, 05 Sep 2022 07:04:08 +0000
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

--00000000000019b05d05e7b36761
Content-Type: text/plain; charset="UTF-8"

Hello,

During the setup, the fan manager https://github.com/markusressel/fan2go I
found that my Vega56 was not working correctly. This fan manager expects
what read PWM value should be the same as you wrote before, but it's not
the case. PWM value was volatile, and what is more critical, if I wrote
200, after reading I saw ~70-100, which is very confusing.
After that, I started reading the amdgpu driver, and how fan speed works,
and I found what PWM value was calculated from RPM speed and not correct
for my case (different BIOS or fan configuration?).
Because it looked wrong, I started looking into different implementations
and found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers
to calculate the PWM value.
I also checked how we set PWM for Vega10 and found the same registers.
After that, I copy-pasted the function from Vega20 to Vega10, and it
started working much better. It still has some fluctuation, but as I
understand, this behavior is expected.

I have no in-depth information about amdgpu, and the original function may
have been for some reason (maybe for some broken BIOS?), but I suppose
somebody forgot to backport this code after prototype implementation.

It would be my first patch here. Sorry if I skipped some procedures, will
be appreciated it if you help me.

Regards,

---
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index dad3e3741a4e..190af79f3236 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr
*hwmgr,
 int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
                uint32_t *speed)
 {
-       uint32_t current_rpm;
-       uint32_t percent = 0;
-
-       if (hwmgr->thermal_controller.fanInfo.bNoFan)
-               return 0;
+       struct amdgpu_device *adev = hwmgr->adev;
+       uint32_t duty100, duty;
+       uint64_t tmp64;

-       if (vega10_get_current_rpm(hwmgr, &current_rpm))
-               return -1;
+       duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+                               CG_FDO_CTRL1, FMAX_DUTY100);
+       duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+                               CG_THERMAL_STATUS, FDO_PWM_DUTY);

-       if (hwmgr->thermal_controller.
-                       advanceFanControlParameters.usMaxFanRPM != 0)
-               percent = current_rpm * 255 /
-                       hwmgr->thermal_controller.
-                       advanceFanControlParameters.usMaxFanRPM;
+       if (!duty100)
+               return -EINVAL;

-       *speed = MIN(percent, 255);
+       tmp64 = (uint64_t)duty * 255;
+       do_div(tmp64, duty100);
+       *speed = MIN((uint32_t)tmp64, 255);

        return 0;
 }
--

--00000000000019b05d05e7b36761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>During the setup, the fan manager <a href=3D=
"https://github.com/markusressel/fan2go">https://github.com/markusressel/fa=
n2go</a> I found that my Vega56 was not working correctly. This fan manager=
 expects what read PWM value should be the same as you wrote before, but it=
&#39;s not the case. PWM value was volatile, and what is more critical, if =
I wrote 200, after reading I saw ~70-100, which is very confusing. <br>Afte=
r that, I started reading the amdgpu driver, and how fan speed works, and I=
 found what PWM value was calculated from RPM speed and not correct for my =
case (different BIOS or fan configuration?).<br>Because it looked wrong, I =
started looking into different implementations and found that Vega20 used m=
mCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers to calculate the PWM value.=
<br>I also checked how we set PWM for Vega10 and found the same registers. =
After that, I copy-pasted the function from Vega20 to Vega10, and it starte=
d working much better. It still has some fluctuation, but as I understand, =
this behavior is expected. <br><br>I have no in-depth information about amd=
gpu, and the original function may have been for some reason (maybe for som=
e broken BIOS?), but I suppose somebody forgot to backport this code after =
prototype implementation. <br><br>It would be my first patch here. Sorry if=
 I skipped some procedures, will be appreciated it if you help me. <br><br>=
Regards,<br><br>---<br>diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/=
vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c<=
br>index dad3e3741a4e..190af79f3236 100644<br>--- a/drivers/gpu/drm/amd/pm/=
powerplay/hwmgr/vega10_thermal.c<br>+++ b/drivers/gpu/drm/amd/pm/powerplay/=
hwmgr/vega10_thermal.c<br>@@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_s=
peed_info(struct pp_hwmgr *hwmgr,<br>=C2=A0int vega10_fan_ctrl_get_fan_spee=
d_pwm(struct pp_hwmgr *hwmgr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint32_t *speed)<br>=C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 uint32_=
t current_rpm;<br>- =C2=A0 =C2=A0 =C2=A0 uint32_t percent =3D 0;<br>-<br>- =
=C2=A0 =C2=A0 =C2=A0 if (hwmgr-&gt;thermal_controller.fanInfo.bNoFan)<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>+ =C2=A0 =C2=
=A0 =C2=A0 struct amdgpu_device *adev =3D hwmgr-&gt;adev;<br>+ =C2=A0 =C2=
=A0 =C2=A0 uint32_t duty100, duty;<br>+ =C2=A0 =C2=A0 =C2=A0 uint64_t tmp64=
;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 if (vega10_get_current_rpm(hwmgr, &am=
p;current_rpm))<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n -1;<br>+ =C2=A0 =C2=A0 =C2=A0 duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM,=
 0, mmCG_FDO_CTRL1),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CG_FDO_CTRL1, FMAX_=
DUTY100);<br>+ =C2=A0 =C2=A0 =C2=A0 duty =3D REG_GET_FIELD(RREG32_SOC15(THM=
, 0, mmCG_THERMAL_STATUS),<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CG_THERMAL_S=
TATUS, FDO_PWM_DUTY);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 if (hwmgr-&gt;the=
rmal_controller.<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 advanceFanControlParameters.usMaxFanRPM !=3D 0)<br=
>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 percent =3D current_rpm=
 * 255 /<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 hwmgr-&gt;thermal_controller.<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 advanceFanControlPa=
rameters.usMaxFanRPM;<br>+ =C2=A0 =C2=A0 =C2=A0 if (!duty100)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>=C2=A0<br>- =
=C2=A0 =C2=A0 =C2=A0 *speed =3D MIN(percent, 255);<br>+ =C2=A0 =C2=A0 =C2=
=A0 tmp64 =3D (uint64_t)duty * 255;<br>+ =C2=A0 =C2=A0 =C2=A0 do_div(tmp64,=
 duty100);<br>+ =C2=A0 =C2=A0 =C2=A0 *speed =3D MIN((uint32_t)tmp64, 255);<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>=C2=A0}<br>--<br></di=
v>

--00000000000019b05d05e7b36761--
