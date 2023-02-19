Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104AC05027
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Feb 2023 05:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B0110E063;
	Sun, 19 Feb 2023 05:02:14 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAA510E063
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Feb 2023 05:02:13 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 f8-20020a17090ac28800b00233d7314c1cso31554pjt.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Feb 2023 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1676782932;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ytLkNiyMERkwoJmZkZCjTmnTR8+2/NFm6CMCPLeYN98=;
 b=oytW5S/V7vTAC7iZhOzvdsdUBhEM9ayxDLpZxEhpszHqXLPkQkJvLVsdQOPgfj6m4V
 9UQnswmPew2TcFcCEnU3LmnCclzGI6YbYBcDU5AFrCBhpxekN5hwQMuZYFVbJK7E67TI
 yNKJcqMd/db6o8a4hFZU89C4cUVq+sWh7dThwhLbTdJAhVXlUdBL+hbmHfG3qB1C+BhS
 E6iqPvEBQ52Qn/jQAF0WWdbDIVeDf4CVBrIp7sySmOI7YAHVoQvm0qTOUZuVtm1tTc41
 DcjjWKo0Jj2yLfWsosx32UdbycQdCLQCE+jZHniwvZtTHEq0VwabLWyuDXclb0wRGQO+
 bL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1676782932;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytLkNiyMERkwoJmZkZCjTmnTR8+2/NFm6CMCPLeYN98=;
 b=zak9WapltfsPxhNxKzy4INqeTRIfmmBy2ZzLYZR7zfiH++Bc3t5S9YVDbBiDgRAmlH
 pLR9LX+Kvh6RglG6EbnpfAI6mgfqhCG69Oiiz7DCdimkNlvtECG915l3ZPhN7m2FvRlP
 Q3/Tke3qTOIOyHJC2Jns1SiFusZ8EOZFNi6FAiQqOy4KQf6Su3qb22A/o20M8+0FjY+g
 Gj8Q6TnMyMMu0JpDg77Ak+rAYn9jcWY3nY0BeOoYqQfpdS6ByZZh17LaE5+70Iiu79J6
 Olu8svOqhTe2LsD3Av81vBwKDKsQ4uIsSMx3fq+Wb7YN7fDyiUkuBSSu9yaIJET8vdS3
 BeUw==
X-Gm-Message-State: AO0yUKVSsX0V1We1pg/oL186LEidn7rFLhhHkIhX34wk+I2YtYtjgpPe
 mYBP3ZspVnIBW5h8MT/DRV9vH9qn4qkmpMuYb880NXRnXGk=
X-Google-Smtp-Source: AK7set+6PPq/ZXcX4iSeCmSMJIK50rEEbCYK8/UEwe3dNplPLS6EZXmKjODeAtihbofPW8Rb0pNukzDSF3TqWX5rf/s=
X-Received: by 2002:a17:902:8682:b0:199:15c2:99ae with SMTP id
 g2-20020a170902868200b0019915c299aemr335284plo.20.1676782932418; Sat, 18 Feb
 2023 21:02:12 -0800 (PST)
MIME-Version: 1.0
From: Mark Hawrylak <mark.hawrylak@gmail.com>
Date: Sun, 19 Feb 2023 16:02:00 +1100
Message-ID: <CABT+NQHh6t1X6fKmy4A0ULyTD5tTXT-quyTfRyq8Q7c87T7cVQ@mail.gmail.com>
Subject: Subject [PATCH] drm/radeon: Fix eDP for single-display iMac11,2
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui <Xinhui.Pan@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000d674605f5067311"
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

--0000000000000d674605f5067311
Content-Type: text/plain; charset="UTF-8"

From Mark Hawrylak <mark.hawrylak@gmail.com>

Apple iMac11,2 (mid 2010) also with Radeon HD-4670 that has the same
issue as iMac10,1 (late 2009) where the internal eDP panel stays dark on
driver load.  This patch treats iMac11,2 the same as iMac10,1,
so the eDP panel stays active.

Additional steps:
Kernel boot parameter radeon.nomodeset=0 required to keep the eDP
panel active.

This patch is an extension of the commit
564d8a2cf3abf16575af48bdc3e86e92ee8a617d
Subject: [PATCH 3.16 100/192] drm/radeon: Fix eDP for single-display
iMac10,1 (v2)
Date: Mon, 09 Oct 2017 13:44:24 +0100 [thread overview]
https://lore.kernel.org/all/lsq.1507553064.833262317@decadent.org.uk/

By making a contribution to this project, I certify that:
        The contribution was created in whole or in part by me and I have
the right to submit it under the open source license indicated in the file;
or
        The contribution is based upon previous work that, to the best of
my knowledge, is covered under an appropriate open source license and I
have the right under that license to submit that work with modifications,
whether created in whole or in part by me, under the same open source
license (unless I am permitted to submit under a different license), as
indicated in the file; or
        The contribution was provided directly to me by some other person
who certified (a), (b) or (c) and I have not modified it.
        I understand and agree that this project and the contribution are
public and that a record of the contribution (including all personal
information I submit with it, including my sign-off) is maintained
indefinitely and may be redistributed consistent with this project or the
open source license(s) involved.

Signed-off-by: Mark Hawrylak <mark.hawrylak@gmail.com>

---

--- linux/drivers/gpu/drm/radeon/atombios_encoders.c.orig       2023-02-19
14:03:03.126499290 +1100
+++ linux/drivers/gpu/drm/radeon/atombios_encoders.c    2023-02-19
14:04:15.449831506 +1100
@@ -2122,11 +2122,11 @@ int radeon_atom_pick_dig_encoder(struct

        /*
         * On DCE32 any encoder can drive any block so usually just use
crtc id,
-        * but Apple thinks different at least on iMac10,1, so there use
linkb,
+        * but Apple thinks different at least on iMac10,1 and iMac11,2, so
there use linkb,
         * otherwise the internal eDP panel will stay dark.
         */
        if (ASIC_IS_DCE32(rdev)) {
-               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1"))
+               if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
                        enc_idx = (dig->linkb) ? 1 : 0;
                else
                        enc_idx = radeon_crtc->crtc_id;


-- 

Regards
Mark Hawrylak
0425 714 725

--0000000000000d674605f5067311
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From Mark Hawrylak &lt;<a href=3D"mailto:mark.hawrylak@gma=
il.com">mark.hawrylak@gmail.com</a>&gt;<br><br>Apple iMac11,2 (mid 2010) al=
so with Radeon HD-4670 that has the same <br>issue as iMac10,1 (late 2009) =
where the internal eDP panel stays dark on <br>driver load.=C2=A0 This patc=
h treats iMac11,2 the same as iMac10,1, <br>so the eDP panel stays active.<=
br><br>Additional steps:<br>Kernel boot parameter radeon.nomodeset=3D0 requ=
ired to keep the eDP <br>panel active. <br><br>This patch is an extension o=
f the commit 564d8a2cf3abf16575af48bdc3e86e92ee8a617d <br>Subject: [PATCH 3=
.16 100/192] drm/radeon: Fix eDP for single-display iMac10,1 (v2) <br>Date:=
 Mon, 09 Oct 2017 13:44:24 +0100 [thread overview] <br><a href=3D"https://l=
ore.kernel.org/all/lsq.1507553064.833262317@decadent.org.uk/">https://lore.=
kernel.org/all/lsq.1507553064.833262317@decadent.org.uk/</a> <br><br>By mak=
ing a contribution to this project, I certify that:<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 The contribution was created in whole or in part by me and I have t=
he right to submit it under the open source license indicated in the file; =
or<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 The contribution is based upon previous w=
ork that, to the best of my knowledge, is covered under an appropriate open=
 source license and I have the right under that license to submit that work=
 with modifications, whether created in whole or in part by me, under the s=
ame open source license (unless I am permitted to submit under a different =
license), as indicated in the file; or<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 The c=
ontribution was provided directly to me by some other person who certified =
(a), (b) or (c) and I have not modified it.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
I understand and agree that this project and the contribution are public an=
d that a record of the contribution (including all personal information I s=
ubmit with it, including my sign-off) is maintained indefinitely and may be=
 redistributed consistent with this project or the open source license(s) i=
nvolved.<br><br>Signed-off-by: Mark Hawrylak &lt;<a href=3D"mailto:mark.haw=
rylak@gmail.com">mark.hawrylak@gmail.com</a>&gt;<br><br>---<br><br>--- linu=
x/drivers/gpu/drm/radeon/atombios_encoders.c.orig =C2=A0 =C2=A0 =C2=A0 2023=
-02-19 14:03:03.126499290 +1100<br>+++ linux/drivers/gpu/drm/radeon/atombio=
s_encoders.c =C2=A0 =C2=A02023-02-19 14:04:15.449831506 +1100<br>@@ -2122,1=
1 +2122,11 @@ int radeon_atom_pick_dig_encoder(struct<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* On DCE32 any=
 encoder can drive any block so usually just use crtc id,<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* but Apple thinks different at least on iMac10,1, so ther=
e use linkb,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* but Apple thinks different a=
t least on iMac10,1 and iMac11,2, so there use linkb,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* otherwise the internal eDP panel will stay dark.<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ASIC_I=
S_DCE32(rdev)) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
dmi_match(DMI_PRODUCT_NAME, &quot;iMac10,1&quot;))<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dmi_match(DMI_PRODUCT_NAME, &quot;iMac1=
0,1&quot;) || dmi_match(DMI_PRODUCT_NAME, &quot;iMac11,2&quot;))<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 enc_idx =3D (dig-&gt;linkb) ? 1 : 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enc_idx =3D radeon_crtc-&gt;crtc_=
id;<br><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div><br></div=
>Regards<br></div>Mark Hawrylak<br>0425 714 725<br></div></div></div>

--0000000000000d674605f5067311--
