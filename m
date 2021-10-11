Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9090EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 21:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5279A60EBB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 21:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5279A60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C186E96E;
	Mon, 11 Oct 2021 21:17:56 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EA26E959
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 20:25:09 +0000 (UTC)
Received: by mail-vk1-xa29.google.com with SMTP id f126so7996404vke.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 13:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=mQef4d8LHsoBY3hvYCsiS3k3cyFkl7pS9uI51Lf2mu4=;
 b=S2RjY9YK1SbIQE11+7M/5WyiWbulf1qkA3483t97fOpCf5J8Qt7C0ffpjfGfIVhqUr
 Cmk4U1CLfiEc4HbVj4TIsExUyX9/QmPrVbrHGVVVidmgvQq6IMPKCJwu57CB0cFDLtKl
 JufbuNL91az7fpTO0+pf3gyrP8ld36UlkK7vFfCQP38uokbR0RgMWcTGY7Im+M/mLn8I
 thoPZSqskUDp63ZuJKxEKTfma3GJWZ58dam/QXdKOzf3PY4YK1Sk8hq58PZKY4Mpdon7
 92KlMHI4wC4OqOkkEEOx+AQT+Z4Xk+fVEM8C287LW7aWCKz27mMQIlAj6D41KJR0wq+i
 yB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=mQef4d8LHsoBY3hvYCsiS3k3cyFkl7pS9uI51Lf2mu4=;
 b=B6XyBdw64hbhF+VGVAPcQQLfOv5C7Qbr/RElGwpehsTvEf3qOYKr/IGTr0J7wHpGQh
 +U4D241Hj2WDZvHwakhAjIY/bVeVabsAM9+Diq6Rb6aYgSnlt8s6p5LdLKinrEAFLwNZ
 uEHdhJLkgV6ZZUZ0OgfBfA9std1tlrjrpwxDxtK8nYPWezGH2GeaedZbMhcbLchTac5o
 RQlMkjZj4UHJh2IHFaA40UXH+svusPWJhMK4rTjMMRyNPAdXOMumpP+tWiY1rHI7wGG3
 mIacLm+whrDXRxkOmq64HH3Afk0jhihxI7Qc6Hh3CI/3CpOZNI8IprGyeldCcwig/kh9
 VNEQ==
X-Gm-Message-State: AOAM533nMmgXJNQuh6yZdB9ccIsoGgRMkbTbD08WJISxMosbqDllKGZh
 ZPbFA6kB52qsc5ConXTrVbXqH62IuQkwUtHHoUc=
X-Google-Smtp-Source: ABdhPJzdgCctqu0whvge9pfj75LQtK1lPhZP1MjaxDdfzyybbLcJnqOey9tdJn//gyjUzMUE/suVddHoszFCkJVT4dY=
X-Received: by 2002:a05:6122:8d6:: with SMTP id
 22mr22701963vkg.21.1633983907997; 
 Mon, 11 Oct 2021 13:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211011202158.GA19208@t>
In-Reply-To: <20211011202158.GA19208@t>
From: "T. Williams" <tdwilliamsiv@gmail.com>
Date: Mon, 11 Oct 2021 16:24:56 -0400
Message-ID: <CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com>
Subject: Fwd: [PATCH] Size can be any value and is user controlled resulting
 in overwriting the 40 byte array wr_buf with an arbitrary length of data from
 buf.
To: airlied@linux.ie, daniel@ffwll.ch, Wayne.Lin@amd.com, 
 mikita.lipski@amd.com, Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com, 
 eryk.brol@amd.com, Jerry.Zuo@amd.com, victorchengchi.lu@amd.com, 
 aurabindo.pillai@amd.com, nirmoy.das@amd.com, Anson.Jacob@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000067aabf05ce1986fc"
X-Mailman-Approved-At: Mon, 11 Oct 2021 21:17:56 +0000
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

--00000000000067aabf05ce1986fc
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ---------
From: docfate111 <tdwilliamsiv@gmail.com>
Date: Mon, Oct 11, 2021 at 4:22 PM
Subject: [PATCH] Size can be any value and is user controlled resulting in
overwriting the 40 byte array wr_buf with an arbitrary length of data from
buf.
To: <dri-devel@lists.freedesktop.org>
Cc: <harry.wentland@amd.com>, <sunpeng.li@amd.com>


Signed-off-by: docfate111 <tdwilliamsiv@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 87daa78a32b8..17f2756a64dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f,
const char __user *buf,
        if (!wr_buf)
                return -ENOSPC;

-       if (parse_write_buffer_into_params(wr_buf, size,
+       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
                                           (long *)param, buf,
                                           max_param_num,
                                           &param_nums)) {
-- 
2.25.1



-- 
Thank you for your time,
Thelford Williams

--00000000000067aabf05ce1986fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">---------- Forwarded message ---------<br>From: <b class=3D=
"gmail_sendername" dir=3D"auto">docfate111</b> <span dir=3D"auto">&lt;<a hr=
ef=3D"mailto:tdwilliamsiv@gmail.com">tdwilliamsiv@gmail.com</a>&gt;</span><=
br>Date: Mon, Oct 11, 2021 at 4:22 PM<br>Subject: [PATCH] Size can be any v=
alue and is user controlled resulting in overwriting the 40 byte array wr_b=
uf with an arbitrary length of data from buf.<br>To:  &lt;<a href=3D"mailto=
:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>&gt;<b=
r>Cc:  &lt;<a href=3D"mailto:harry.wentland@amd.com">harry.wentland@amd.com=
</a>&gt;,  &lt;<a href=3D"mailto:sunpeng.li@amd.com">sunpeng.li@amd.com</a>=
&gt;<br></div><br><br>Signed-off-by: docfate111 &lt;<a href=3D"mailto:tdwil=
liamsiv@gmail.com" target=3D"_blank">tdwilliamsiv@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
index 87daa78a32b8..17f2756a64dc 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
@@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f, c=
onst char __user *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wr_buf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOSPC;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (parse_write_buffer_into_params(wr_buf, size=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (parse_write_buffer_into_params(wr_buf, wr_b=
uf_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(long *)param, buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0max_param_num,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;param_nums)) {<br>
-- <br>
2.25.1<br>
<br>
</div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Thank you for y=
our time,<br></div>Thelford Williams<br></div></div></div>

--00000000000067aabf05ce1986fc--
