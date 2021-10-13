Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F0DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 20:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D19860E78
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 20:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D19860E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267566E0CC;
	Wed, 13 Oct 2021 20:04:44 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0E96E0CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 20:04:26 +0000 (UTC)
Received: by mail-ua1-x935.google.com with SMTP id f4so6950452uad.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=auExVTDinqoWhF3wItvsimRAgKrqB5K4kkvWmmSs+rw=;
 b=QF/jXerUre4eF7VP4RxgogZIXLDBwhwiqvRivdxA6qvx93HI9JomWdCVcnITs6atzA
 SdNeGdVmqnyxtAgAPZVHrSFVRe38+8C9oeK0dRtecbjcXlQkbXcE5Ns9EjJ6wDTKylIT
 XwZ3l10z34S5p1cXtziBb6UdugDKNQbC63CS7jh5+g99MlUK21uyqMR3W29lrXynn0oU
 wXuMJuRKls845jNIMcTHHRuIk7TrD52j7ssygkag2XIWdsolaQ8n1BuLg2kKdqihCy9G
 U29sW7YwoyQzxnoSEe/2oBblVN2fCBN/bBk2A20UYLMFPkmyMUIilUztnZpwYd8ud32T
 GNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=auExVTDinqoWhF3wItvsimRAgKrqB5K4kkvWmmSs+rw=;
 b=5+3voQJOR2NawQzmWmlOxRK4DzR+qba2Fjwzcil3Cla7BIoz5LJ/6y+//6S+SnlaP6
 3x7qPtgJkdILybNToRX5US2LVQp0PbkxWnjMFYqou1jOtNb8vRHWyJjKnjhCiBDtjfiP
 mec3jY/FYIgXB+8HmW/k6xREB0WxJaNLfVjd6aUyB96jLSp7dqk/01cuDdhTpiAy8UsU
 qSl+Y33q0AV/zj/FOfut0UGDpXVXhRv062cTStjj3mh0OW9qjLsGDUm0zdMxtg4YDQzo
 /NLHxp7uU/EZ1/UFI7AYol+Lzf23mmgMD8YHfETCtaOl/VxZa+HAri7uxJEvEeBjysOA
 2fuQ==
X-Gm-Message-State: AOAM530/73phhWsZfVGs65C2Rqp+58coJB5a9rI+IhkZ0mWI1zX2B0KG
 6p0+QN1Q1WenUnW5W/a8sCP8bX5uRZAH1QU5BwQ=
X-Google-Smtp-Source: ABdhPJxLYHBEyWwABe3WDbL7xp7KViPUQAYHOTU+fY4Uu3XgXy2TQYOVmaiPDtsSAKsZ/o4Pj+4IjzSkGED/iE3XLb0=
X-Received: by 2002:ab0:45c4:: with SMTP id u62mr1553532uau.69.1634155464734; 
 Wed, 13 Oct 2021 13:04:24 -0700 (PDT)
MIME-Version: 1.0
From: "T. Williams" <tdwilliamsiv@gmail.com>
Date: Wed, 13 Oct 2021 16:04:13 -0400
Message-ID: <CADN=F_ngDhs10tBOtQy4kz0T6ZEjLJ_q0P+7bpen=JU04cpUXg@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: fix out of bounds write
To: harry.wentland@amd.com, sunpeng.li@amd.com, airlied@linux.ie, 
 Daniel Vetter <daniel@ffwll.ch>, Wayne.Lin@amd.com, mikita.lipski@amd.com, 
 Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com, eryk.brol@amd.com, 
 Jerry.Zuo@amd.com, victorchengchi.lu@amd.com, aurabindo.pillai@amd.com, 
 nirmoy.das@amd.com, Anson.Jacob@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000fbd12b05ce417754"
X-Mailman-Approved-At: Wed, 13 Oct 2021 20:04:42 +0000
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

--000000000000fbd12b05ce417754
Content-Type: text/plain; charset="UTF-8"

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
Size can be any value and is user controlled resulting in overwriting the
40 byte array wr_buf with an arbitrary length of data from buf.
Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>

--000000000000fbd12b05ce417754
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">---<br>
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
=C2=A0&amp;param_nums)) {<font color=3D"#888888"><br></font><div><font colo=
r=3D"#888888">
-- </font><span style=3D"font-family:arial,sans-serif"><font size=3D"2"><br=
></font></span><h2 id=3D"gmail-:7r" class=3D"gmail-hP" tabindex=3D"-1"><spa=
n style=3D"font-weight:normal"><span style=3D"font-family:arial,sans-serif"=
><font size=3D"2">Size
 can be any value and is user controlled resulting in overwriting the 40
 byte array wr_buf with an arbitrary length of data from buf.</font></span>=
</span></h2></div>Signed-off-by: Thelford Williams &lt;<a href=3D"mailto:td=
williamsiv@gmail.com">tdwilliamsiv@gmail.com</a>&gt;<br></div>

--000000000000fbd12b05ce417754--
