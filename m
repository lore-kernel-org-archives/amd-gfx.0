Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD4C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 18:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F8A24810
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 18:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McNA8GLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F8A24810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929E06E2ED;
	Wed, 28 Oct 2020 18:56:01 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FD589DA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 17:39:36 +0000 (UTC)
Received: by mail-lf1-x141.google.com with SMTP id a9so8577515lfc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RKvFws6HfpayWjnGJqPTr7zKSrMSUXziDI6GGcjGPJI=;
 b=McNA8GLtS75smrZzUGhbGvWFLjl+daUBR01yFBrKISKO78TSgBqiDkq/lSimlLona0
 tm0VCRcX+8/O0PlVNY90/IlIFto1cauZhf72FmtNX8nYz8ChL8d0LI1KXGlY15xROPMw
 dJhtlbtHcZYC1tThhDTgaIpHySwqgbq9aG3m/HBIcjswXlJVGI37enObLeTfCHKhqASg
 6h1KUO5mfUWHNOAIkWSjt3/aG551AXr2LdjYdnWimZK9oI8sjoSE2EvZNuyKNKhLI6Bf
 1LvYN729ALyjsipXp4rHPD3xS+f2mBGMBSoyum6hlN27NrTGZQXvvokGc+u3V6HdlEzu
 Zt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RKvFws6HfpayWjnGJqPTr7zKSrMSUXziDI6GGcjGPJI=;
 b=Xa2lQRL+B5HbpE32KZxfdB9Uwtsb2B7TGpV9J28UJ0LPKEE76/quO/i33x5i1dS2qz
 0P1++tyI3Bz+RVGKyVVX7spKgom5hbYV+SJ4HeUtqqNdRRrAaXwU+3LBmSFux3SFD342
 H6MTySWIBUi/6sZG7Lf0lFU7fSdJNlutdDruhZICHYYJedTjm8fEkkBjAC3744LBau5h
 cCH1J+vw6ZaX4dn3V21iFkDTwshqiwaWvdKNsc3XqOu+C1cjdcj7NJwxoeMC4InsUG6a
 B5dPGiBiBvaIWCogcABZ7fUyUGRXzqJtiQ/h+OXY39veFtV82GGPNvuJPea+E55D/OtI
 NImw==
X-Gm-Message-State: AOAM533JNFZ7ZPHg+FPUysvl7Gu3oWU6ibPdCm0JdkJOIFdR3ImP0rC5
 Z1Qm5hLZ4SG295Gs7em9DpdgJeQQm/5H9TmOqD1I1tEqzFcOTA==
X-Google-Smtp-Source: ABdhPJzCwzWq1eXpgQIlR9F+xQ3ryyDxe75pZwYS2QpKqrDzgOyZ7DDCG30k96BNSOH7HoltrQheioC8e2QddzinxuU=
X-Received: by 2002:a19:8353:: with SMTP id f80mr86276lfd.348.1603906775130;
 Wed, 28 Oct 2020 10:39:35 -0700 (PDT)
MIME-Version: 1.0
From: Bryan Angelo <bangelo@gmail.com>
Date: Wed, 28 Oct 2020 10:39:24 -0700
Message-ID: <CAOvTWHuRNXyUNm1H_vz40iAE2-3Z3zGZO8=-7OJGu1wMMWYiUQ@mail.gmail.com>
Subject: Potential freesync Arithmetic Issue
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 28 Oct 2020 18:56:00 +0000
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
Content-Type: multipart/mixed; boundary="===============0621224803=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0621224803==
Content-Type: multipart/alternative; boundary="00000000000095a5d605b2bea535"

--00000000000095a5d605b2bea535
Content-Type: text/plain; charset="UTF-8"

While looking at the following commit, I noticed what might be an
arithmetic issue potentially stemming from some merge/patch conflict
resolution.

commit ad339f69114a6a145fc94d44376851c53dee3475
Author: Jaehyun Chung <jaehyun.chung@amd.com>
Date:   Thu Jun 18 15:27:35 2020 -0400

    drm/amd/display: Fix incorrect rounding for 10Hz refresh range

    [Why]
    In cases where refresh range is slightly below 10, FreeSync is not
    active or supported. Need to round values before checking refresh range
    in order to have FreeSync supported in these cases.

    [How]
    Remove redundant values and round values before checking valid refresh
range.

    Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
    Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
    Acked-by: Anthony Koo <Anthony.Koo@amd.com>
    Acked-by: Eryk Brol <eryk.brol@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

There appears to be an errant plus sign when calculating the refresh_range
-
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/display/modules/freesync/freesync.c?h=v5.10-rc1#n948

  refresh_range = div_u64(in_out_vrr->max_refresh_in_uhz + 500000, 1000000)
-
+ div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);

I am unfamiliar with the freesync codebase so I opted to present the
potential issue here as opposed to preparing a patch.

Thanks.

--00000000000095a5d605b2bea535
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While looking at the following commit, I noticed what migh=
t be an arithmetic issue potentially stemming from some merge/patch conflic=
t resolution.<br><br>commit ad339f69114a6a145fc94d44376851c53dee3475<br>Aut=
hor: Jaehyun Chung &lt;<a href=3D"mailto:jaehyun.chung@amd.com">jaehyun.chu=
ng@amd.com</a>&gt;<br>Date: =C2=A0 Thu Jun 18 15:27:35 2020 -0400<br><br>=
=C2=A0 =C2=A0 drm/amd/display: Fix incorrect rounding for 10Hz refresh rang=
e<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 [Why]<br>=C2=A0 =C2=A0 In cases where =
refresh range is slightly below 10, FreeSync is not<br>=C2=A0 =C2=A0 active=
 or supported. Need to round values before checking refresh range<br>=C2=A0=
 =C2=A0 in order to have FreeSync supported in these cases.<br>=C2=A0 =C2=
=A0 <br>=C2=A0 =C2=A0 [How]<br>=C2=A0 =C2=A0 Remove redundant values and ro=
und values before checking valid refresh range.<br>=C2=A0 =C2=A0 <br>=C2=A0=
 =C2=A0 Signed-off-by: Jaehyun Chung &lt;<a href=3D"mailto:jaehyun.chung@am=
d.com">jaehyun.chung@amd.com</a>&gt;<br>=C2=A0 =C2=A0 Reviewed-by: Aric Cyr=
 &lt;<a href=3D"mailto:Aric.Cyr@amd.com">Aric.Cyr@amd.com</a>&gt;<br>=C2=A0=
 =C2=A0 Acked-by: Anthony Koo &lt;<a href=3D"mailto:Anthony.Koo@amd.com">An=
thony.Koo@amd.com</a>&gt;<br>=C2=A0 =C2=A0 Acked-by: Eryk Brol &lt;<a href=
=3D"mailto:eryk.brol@amd.com">eryk.brol@amd.com</a>&gt;<br>=C2=A0 =C2=A0 Si=
gned-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">=
alexander.deucher@amd.com</a>&gt;<br><br>There appears to be an errant plus=
 sign when calculating the refresh_range - <a href=3D"https://git.kernel.or=
g/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/disp=
lay/modules/freesync/freesync.c?h=3Dv5.10-rc1#n948">https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/displa=
y/modules/freesync/freesync.c?h=3Dv5.10-rc1#n948</a><div><br></div><div><di=
v>=C2=A0 refresh_range =3D div_u64(in_out_vrr-&gt;max_refresh_in_uhz + 5000=
00, 1000000) -</div><div>+ div_u64(in_out_vrr-&gt;min_refresh_in_uhz + 5000=
00, 1000000);</div><div><br></div>I am unfamiliar with the freesync codebas=
e so I opted to present the potential issue here as opposed to preparing a =
patch.<br><br>Thanks.<br></div></div>

--00000000000095a5d605b2bea535--

--===============0621224803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0621224803==--
