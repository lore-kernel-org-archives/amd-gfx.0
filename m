Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE0DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 17:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE71010E371;
	Wed, 26 Oct 2022 17:07:28 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AEF10E371
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 17:07:24 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-36cbcda2157so97388507b3.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjDbarzxu4XYS5NgSw6p7Qc8Iv/b8DsoEBo4wINHXXg=;
 b=jrbfzp9QvyG5SgK9HDLqcFcBk94XttViqqNWbUv3PaT12jHcT2CR3A9Xzy/RSnyJA0
 fNO23PQqVhJAGzf4ILhVw7PWB2k2UtpErzQdnS2xLkKmtXBMqHd0xeOMHQ8d7EvuP9dS
 utLFSnbEl/4lvA3b0nN7HJbWfxyDPPkIn3aI4XKESel9/mhs3/dxeL5A9v9oVMxPwVGY
 r3tDIcPn7znZuJo5LS5N0ZVtmVas9tGw9xituTEHg9+QfrR/TEEe8ARSt4+wgPudJMGH
 ag6l0/vlLvBTSDpueQnSujdyBLd3KZ3UGTV+wpdzCTfUvDR4kKADeEuZO8wgJK1npr6N
 pYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZjDbarzxu4XYS5NgSw6p7Qc8Iv/b8DsoEBo4wINHXXg=;
 b=U6YNuRFr1NA1aI4AxVvRN+EEqbzJsDVTQksm3Wyk/f2hcGh86yQkscRqkK0bfXxyic
 Wk/884jItlZYwWBQJm3AqfVl2+d1AoiBH1z/P1eUbL1BiBKEjrOHTKZN4mvi81BQdL9l
 xLdRgujmpwmkzjbynLw/78oFl7KdScC/nDxxsEsfGgF2gLDFzRuYtZm/CQCklf5wI464
 w03x7WWkOv2fNk5QpAdxn2MCfb4HJmgEDPBOFkg7CJtrO6/0/NYbG8x82sgIZnNEUQE+
 NNYEFzafdcw+TVyRG4wfG8oZRPoNh93XBtgG9veBWqrVRVuMAPPeeXxO52e5KEsVbRBV
 9XPA==
X-Gm-Message-State: ACrzQf0NYoczQR+QMieO1+BBsKlpMV+nznSNh9zUFHAlySH9iv5MqijF
 brFGeisN9I4IJqDHdz6dsrXOPT6oRye20MZsOGM=
X-Google-Smtp-Source: AMsMyM6laHS/C6QV3GzReWQwFL/XTHeTlkukWobH6pG3myqUrCBH/KFXgq3bUXHRCj/lxoLaXhxfEL1cYPsXwT9Of28=
X-Received: by 2002:a0d:fbc4:0:b0:367:2a77:b081 with SMTP id
 l187-20020a0dfbc4000000b003672a77b081mr34961891ywf.234.1666804043565; Wed, 26
 Oct 2022 10:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221014041456.139813-1-Asher.Song@amd.com>
 <CANiD2e8PHA7u1qs8YkWkbbjxqB7JCnLNdR5OcHTH=dpfBWe7rg@mail.gmail.com>
 <DM4PR12MB513603C468CE9BA8DC933D118B309@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CANiD2e-jjJyycgmBUDirBD+pGjf+Etifbvj5aBa0Q8Zd=KFxOg@mail.gmail.com>
 <CADnq5_PNhqNTnwkVTdhGXmJ=UNWwQQjuftA-zgdBXejPk4LKqg@mail.gmail.com>
 <CANiD2e-wpom94j4UuqG7Et1DFyMwEafcLj1qCxwp5DyFwLSiYg@mail.gmail.com>
In-Reply-To: <CANiD2e-wpom94j4UuqG7Et1DFyMwEafcLj1qCxwp5DyFwLSiYg@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Wed, 26 Oct 2022 19:07:12 +0200
Message-ID: <CAD=4a=U21EJyPb9=qHO0oLwZB1a+jGOLDVdpYLExumbRxxQFPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
To: Yury Zhuravlev <stalkerg@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ed4fa605ebf30e4c"
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Meng, Xiaohu" <Xiaohu.Meng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Song,
 Asher" <Asher.Song@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ed4fa605ebf30e4c
Content-Type: text/plain; charset="UTF-8"

This stuff I assume:

https://github.com/RadeonOpenCompute/rocm_smi_lib/tree/master/tests/rocm_smi_test

https://docs.amd.com/bundle/ROCm-System-Management-Interface-Guide/page/ROCm-System-Managment.html#building-tests

Regards

Den ons 26 okt. 2022 kl 17:43 skrev Yury Zhuravlev <stalkerg@gmail.com>:

>
>
> On Wed, Oct 26, 2022 at 11:38 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
>
>> On Wed, Oct 26, 2022 at 5:07 AM Yury Zhuravlev <stalkerg@gmail.com>
>> wrote:
>> >
>> > Hello Asher,
>> >
>> > Thanks for the information, is it open-source tests? Can I reproduce it?
>> >
>> > Also, it seems like Radeon Instinct MI25 was released before Radeon RX
>> Vega, is it possible that they have different PowerPlay subsystems?
>>
>> Same silicon, same powerplay implementation.
>>
> Okay, what it means? Can I know what exactly you are tested by
> "rsmitstReadWrite.FanReadWrite"?
> I am working now with my patch, and I definitely can read and write fan
> speed by PWM.
> How can I help to solve this problem?
>
> Regards,
>
>

--000000000000ed4fa605ebf30e4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">This stuff I assume:</div><div class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif"><a href=3D"ht=
tps://github.com/RadeonOpenCompute/rocm_smi_lib/tree/master/tests/rocm_smi_=
test">https://github.com/RadeonOpenCompute/rocm_smi_lib/tree/master/tests/r=
ocm_smi_test</a></div><div class=3D"gmail_default" style=3D"font-family:ari=
al,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:arial,helvetica,sans-serif"><a href=3D"https://docs.amd.com/bundl=
e/ROCm-System-Management-Interface-Guide/page/ROCm-System-Managment.html#bu=
ilding-tests">https://docs.amd.com/bundle/ROCm-System-Management-Interface-=
Guide/page/ROCm-System-Managment.html#building-tests</a></div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-seri=
f">Regards<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Den ons 26 okt. 2022 kl 17:43 skrev Yury Zhuravlev &lt;=
<a href=3D"mailto:stalkerg@gmail.com">stalkerg@gmail.com</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Oct 26, 2022 at 11:38 PM Alex Deucher &lt;<a href=3D"m=
ailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed,=
 Oct 26, 2022 at 5:07 AM Yury Zhuravlev &lt;<a href=3D"mailto:stalkerg@gmai=
l.com" target=3D"_blank">stalkerg@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello Asher,<br>
&gt;<br>
&gt; Thanks for the information, is it open-source tests? Can I reproduce i=
t?<br>
&gt;<br>
&gt; Also, it seems like Radeon Instinct MI25 was released before Radeon RX=
 Vega, is it possible that they have different PowerPlay subsystems?<br>
<br>
Same silicon, same powerplay implementation.<br></blockquote><div>Okay, wha=
t it means? Can I know what exactly you are tested by &quot;rsmitstReadWrit=
e.FanReadWrite&quot;? <br></div><div>I am working now with my patch, and I =
definitely can read and write fan speed by PWM.</div><div>How can I help to=
 solve this problem?</div><div><br></div><div>Regards,<br></div><div><br></=
div></div></div>
</blockquote></div>

--000000000000ed4fa605ebf30e4c--
