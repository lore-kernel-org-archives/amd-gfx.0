Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CBDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C876F6023F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C876F6023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD4989D7D;
	Tue, 12 Oct 2021 20:45:37 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AF289B5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 20:42:09 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id t200so315369vkt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xn42lwNzcAD06LzekzwON2T0fKLFenkd9GSic/zsRB0=;
 b=MFod2F0OaCDe8VEqkOq0EpoM0emytvoWWNRtElpm0DMTYIgWGY0yFb4+/NPMLKy9Tu
 WkTh4wct/Na9QgK57qkcdIEwZYW3dTgfkZrIaXVRfRamDuHnADvDLG8VQbkmYOAeHAMG
 IrodbBO5nTnSyT/oB97qu9byrbqVaXGtnZNdZw4YCWtd8z6HF0yfjVxDpPRMD1bwRAE+
 LCko9DQGyoLJqRydZFOtgtns30ftFZQV52/sXrP9TwQwBdZQ3jg30fwqJvfq5MCnFLkf
 8Oey7t9Q3dYFbFQ4KCzpKEo3X+R048SwTB4se6xkwjaMXNi8k7I0MvsJBwcnbr6cz71T
 8sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xn42lwNzcAD06LzekzwON2T0fKLFenkd9GSic/zsRB0=;
 b=CcJ3bPUgvRLOxbNTE3nto9jZNg6Fj9QOqIwksuuxHy25LApg7/KDteYMAv0vcnlNzE
 ZCjDvR2ZOWWUjLjuJsym6zPObUVAbuv23ACw30T98/o+75jRoCY7xTrxh1zs8namEUFu
 pD+RAIOzrCRFfqedbjsp3+/eOc8p6ZW48DOP2Xor5jln56a2m+MbvY8UIOZLgLRgT5Le
 u1ZH7l4nbnyB0Obm5S9BKq8sT6fzYs2WDahFHh9WLWsmBKAO207v1mpLMmliaNDWI18n
 qqdOWJSU3EHBKNUsU+7GAKpkk38CMHDVpGrwKo+99VMczZ9cQN59DOKPiCQqL7hpNp5B
 sUyg==
X-Gm-Message-State: AOAM532RmsixQUbhbHc/Y9xuGrRLlbkI6ZZ62ihrIPWa/qV3BzpR9JXN
 t53e/5KHJSkLoPv30UI2vfdUkwe2nDnDQyo5jcapYEFuhDRayuQw
X-Google-Smtp-Source: ABdhPJyPRKGbCQiNKUQbeBTz4eJymxeVcWErBYGzktjtNkwCDca1dO6GtixBZmug8RkkTC8wxozjjDRkcoAqtRqtfsU=
X-Received: by 2002:a05:6122:8d6:: with SMTP id
 22mr29910398vkg.21.1634071328213; 
 Tue, 12 Oct 2021 13:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211011202158.GA19208@t>
 <CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com>
 <76a1cb8c-c1a9-b052-9e41-1738aaf94bfa@gmail.com>
In-Reply-To: <76a1cb8c-c1a9-b052-9e41-1738aaf94bfa@gmail.com>
From: "T. Williams" <tdwilliamsiv@gmail.com>
Date: Tue, 12 Oct 2021 16:41:56 -0400
Message-ID: <CADN=F_k1hm5GB1pQRqSxA6Mf0+dWATyRqMUbXfwU8vPWwumcNw@mail.gmail.com>
Subject: Re: Fwd: [PATCH] Size can be any value and is user controlled
 resulting in overwriting the 40 byte array wr_buf with an arbitrary length of
 data from buf.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>, Wayne.Lin@amd.com, 
 mikita.lipski@amd.com, Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com, 
 eryk.brol@amd.com, Jerry.Zuo@amd.com, victorchengchi.lu@amd.com, 
 aurabindo.pillai@amd.com, nirmoy.das@amd.com, Anson.Jacob@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000000e53ce05ce2de1d1"
X-Mailman-Approved-At: Tue, 12 Oct 2021 20:45:36 +0000
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

--0000000000000e53ce05ce2de1d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should I resubmit the patch email with correct formatting? MITRE assigned
this bug as CVE-2021-42327. Does AMD/kernel do public vulnerability
reports? Do I need to email someone else or something(sorry for dumb
questions this is my first time doing this and I don't know what to do)?
I am trying to do step 11 from here:
https://cve.mitre.org/cve/researcher_reservation_guidelines.

On Tue, Oct 12, 2021 at 3:18 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 11.10.21 um 22:24 schrieb T. Williams:
>
>
>
> ---------- Forwarded message ---------
> From: docfate111 <tdwilliamsiv@gmail.com>
> Date: Mon, Oct 11, 2021 at 4:22 PM
> Subject: [PATCH] Size can be any value and is user controlled resulting i=
n
> overwriting the 40 byte array wr_buf with an arbitrary length of data fro=
m
> buf.
> To: <dri-devel@lists.freedesktop.org>
> Cc: <harry.wentland@amd.com>, <sunpeng.li@amd.com>
>
>
> Signed-off-by: docfate111 <tdwilliamsiv@gmail.com>
>
>
> While the find might be correct there are a couple of style problems with
> the patch.
>
> First of all the subject line must be shorter and should be something lik=
e
> "drm/amdgpu: fix out of bounds write".
>
> The detailed description of the bug then comes into the commit message.
>
> And finally please use your real name for the Signed-off-by line.
>
> Apart from that good catch,
> Christian.
>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 87daa78a32b8..17f2756a64dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f,
> const char __user *buf,
>         if (!wr_buf)
>                 return -ENOSPC;
>
> -       if (parse_write_buffer_into_params(wr_buf, size,
> +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>                                            (long *)param, buf,
>                                            max_param_num,
>                                            &param_nums)) {
> --
> 2.25.1
>
>
>
> --
> Thank you for your time,
> Thelford Williams
>
>
>

--=20
Thank you for your time,
Thelford Williams

--0000000000000e53ce05ce2de1d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Should I resubmit the patch email with correct format=
ting? MITRE assigned this bug as CVE-2021-42327. Does AMD/kernel do public =
vulnerability reports? Do I need to email someone else or something(sorry f=
or dumb questions this is my first time doing this and I don&#39;t know wha=
t to do)? <br></div>I am trying to do step 11 from here: <a href=3D"https:/=
/cve.mitre.org/cve/researcher_reservation_guidelines">https://cve.mitre.org=
/cve/researcher_reservation_guidelines</a>.</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 12, 2021 at 3:18 AM =
Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com=
">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Am 11.10.21 um 22:24 schrieb T. Williams:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr"><br>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">---------- Forwarded messag=
e
            ---------<br>
            From: <b class=3D"gmail_sendername" dir=3D"auto">docfate111</b>
            <span dir=3D"auto">&lt;<a href=3D"mailto:tdwilliamsiv@gmail.com=
" target=3D"_blank">tdwilliamsiv@gmail.com</a>&gt;</span><br>
            Date: Mon, Oct 11, 2021 at 4:22 PM<br>
            Subject: [PATCH] Size can be any value and is user
            controlled resulting in overwriting the 40 byte array wr_buf
            with an arbitrary length of data from buf.<br>
            To: &lt;<a href=3D"mailto:dri-devel@lists.freedesktop.org" targ=
et=3D"_blank">dri-devel@lists.freedesktop.org</a>&gt;<br>
            Cc: &lt;<a href=3D"mailto:harry.wentland@amd.com" target=3D"_bl=
ank">harry.wentland@amd.com</a>&gt;,
            &lt;<a href=3D"mailto:sunpeng.li@amd.com" target=3D"_blank">sun=
peng.li@amd.com</a>&gt;<br>
          </div>
          <br>
          <br>
          Signed-off-by: docfate111 &lt;<a href=3D"mailto:tdwilliamsiv@gmai=
l.com" target=3D"_blank">tdwilliamsiv@gmail.com</a>&gt;<br>
        </div>
      </div>
    </blockquote>
    <br>
    While the find might be correct there are a couple of style problems
    with the patch.<br>
    <br>
    First of all the subject line must be shorter and should be
    something like &quot;drm/amdgpu: fix out of bounds write&quot;.<br>
    <br>
    The detailed description of the bug then comes into the commit
    message.<br>
    <br>
    And finally please use your real name for the Signed-off-by line.<br>
    <br>
    Apart from that good catch,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          ---<br>
          =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |=
 2
          +-<br>
          =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
          <br>
          diff --git
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          index 87daa78a32b8..17f2756a64dc 100644<br>
          ---
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          +++
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          @@ -263,7 +263,7 @@ static ssize_t
          dp_link_settings_write(struct file *f, const char __user *buf,<br=
>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wr_buf)<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -E=
NOSPC;<br>
          <br>
          -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (parse_write_buffer_into_params(wr=
_buf, size,<br>
          +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (parse_write_buffer_into_params(wr=
_buf,
          wr_buf_size,<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(long *)param, buf,<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0max_param_num,<br>
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;param_nums)) {<br>
          -- <br>
          2.25.1<br>
          <br>
        </div>
        <br clear=3D"all">
        <br>
        -- <br>
        <div dir=3D"ltr">
          <div dir=3D"ltr">
            <div>Thank you for your time,<br>
            </div>
            Thelford Williams<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Thank you for your time,<br></div>The=
lford Williams<br></div></div>

--0000000000000e53ce05ce2de1d1--
