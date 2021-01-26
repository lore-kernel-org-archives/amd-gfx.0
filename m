Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824FAC433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 17:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C9821919
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 17:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C9821919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB026E16F;
	Tue, 26 Jan 2021 17:42:33 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07156E16F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 17:42:32 +0000 (UTC)
Received: by mail-vk1-xa36.google.com with SMTP id d6so4058135vkb.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MRwJU5drs07vN8PejDJBC7fLcEisXUJ1fbk6wfMAXn8=;
 b=Pdy/DZ3aDpnQDGN8UNJUhslBEy2iKmgCZcoYaLgL4+Rgs1lleDskikqZVk81anGB1D
 9RFtn4BTaMf9ckYGp+hWjYmRxm/FC2M9t7X5E0x9uYiO0Tdo5wO/15OjPTwGiig1TBx2
 UPsQs4RqBS55aM48962H507tr8c0+v0LyfYN3ZR1KQ5aECc6/a2F8zhS3Iw7RbOTPZhD
 wGpvnRaHxJL3bA4Vwv5aZQlk8B8gTGoI1NVkLTo5q5SSTx86DxgQofeDYPECgAOHtsbJ
 x+/m3OrbPuES9TnIfuEmdDsiAKXatba6pnfHtaaOZ3jeShTxfxeSe5zMZY3oQPW4mGre
 ddtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MRwJU5drs07vN8PejDJBC7fLcEisXUJ1fbk6wfMAXn8=;
 b=aRhYzeFLyKURoH4DitUrNPxH9KuwqyHpnFn9wXl5G6x06K2RgFIQS5LQqzX5zLxfNi
 njFwUAjsIXGSGnbCBXcg/aje5JbeiP8zKke7rUYhN3e5dF6vs2WNLUo8lMd1Wr+iFNS5
 v5ZBrOJT1FaGZoDQEx0QMpIP6YnuBO0js6J4P5XnG5W27WH0+CJfZfHXCB1mZZu6A5ep
 nV+0CEQ8M8MgEmEzim5Sheep5CuxoE1WEh2s2KDZiQRzssbAd45ri9xZayl+j8qrRFc3
 4eXdC8W7ysxK14m2MOwzEwbc/GrlwMoeejKy5s40M3RtIbQ+AjJfAbMZ+ZkI+eHWXH/E
 CCxg==
X-Gm-Message-State: AOAM530ZKgVO/9qoLj0pSBXXhVXO3sdZvAKIc3vmiWHdwcEhCUHn5wGB
 j1Ve7fFWA62TJpkptr3Eqo150LUl+Sj0lMLHJDI=
X-Google-Smtp-Source: ABdhPJxf4l/4PNhs2Zy3AcXjzvYIw9vpGx50w4UQPdi3630B0zmCxyilkl4fhpb2pHvY8bCwAhijyS/4J9xjYWJ6y+E=
X-Received: by 2002:a1f:5c16:: with SMTP id q22mr5374207vkb.12.1611682951755; 
 Tue, 26 Jan 2021 09:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20210126052745.14033-1-raykwok1150@163.com>
In-Reply-To: <20210126052745.14033-1-raykwok1150@163.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Tue, 26 Jan 2021 12:42:21 -0500
Message-ID: <CAAzXoRLHu6ie4D0o7dUkygO1=5ZFujj5JYAx5BZ+djvXXFSpvw@mail.gmail.com>
Subject: Re: [PATCH 1/1] register refresh to add mmGC_CAC_INDEX_AUTO_INCR_EN
To: Lei Guo <raykwok1150@163.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0549488699=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0549488699==
Content-Type: multipart/alternative; boundary="000000000000d47efb05b9d12da3"

--000000000000d47efb05b9d12da3
Content-Type: text/plain; charset="UTF-8"

Hi,

This update doesn't match the gc_9_0_0 headers from the drm-next branch as
such cannot be made to umr.  You need to first update the kernel headers
and then we circle back to umr.

Tom

On Tue, Jan 26, 2021 at 12:43 AM <raykwok1150@163.com> wrote:

> From: Guo Lei <raykwok1150@163.com>
>
> sync form drm-next
>
> Signed-off-by: Guo Lei <raykwok1150@163.com>
> ---
>  src/lib/ip/gfx90_bits.i | 7 ++-----
>  src/lib/ip/gfx90_regs.i | 2 +-
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/src/lib/ip/gfx90_bits.i b/src/lib/ip/gfx90_bits.i
> index 6741947..8aabb8a 100644
> --- a/src/lib/ip/gfx90_bits.i
> +++ b/src/lib/ip/gfx90_bits.i
> @@ -8711,11 +8711,8 @@ static struct umr_bitfield mmGC_CAC_CTRL_2[] = {
>          { "CAC_SOFT_CTRL_ENABLE", 1, 1, &umr_bitfield_default },
>          { "UNUSED_0", 2, 31, &umr_bitfield_default },
>  };
> -static struct umr_bitfield mmGC_CAC_CGTT_CLK_CTRL[] = {
> -        { "ON_DELAY", 0, 3, &umr_bitfield_default },
> -        { "OFF_HYSTERESIS", 4, 11, &umr_bitfield_default },
> -        { "SOFT_OVERRIDE_DYN", 30, 30, &umr_bitfield_default },
> -        { "SOFT_OVERRIDE_REG", 31, 31, &umr_bitfield_default },
> +static struct umr_bitfield mmGC_CAC_INDEX_AUTO_INCR_EN[] = {
> +        { "GC_CAC_INDEX_AUTO_INCR_EN", 0, 0, &umr_bitfield_default },
>  };
>  static struct umr_bitfield mmGC_CAC_AGGR_LOWER[] = {
>          { "AGGR_31_0", 0, 31, &umr_bitfield_default },
> diff --git a/src/lib/ip/gfx90_regs.i b/src/lib/ip/gfx90_regs.i
> index 1342a66..a9ef9c6 100644
> --- a/src/lib/ip/gfx90_regs.i
> +++ b/src/lib/ip/gfx90_regs.i
> @@ -1418,7 +1418,7 @@
>         { "mmDIDT_IND_DATA", REG_MMIO, 0x1281, 0, &mmDIDT_IND_DATA[0],
> sizeof(mmDIDT_IND_DATA)/sizeof(mmDIDT_IND_DATA[0]), 0, 0 },
>         { "mmGC_CAC_CTRL_1", REG_MMIO, 0x1284, 0, &mmGC_CAC_CTRL_1[0],
> sizeof(mmGC_CAC_CTRL_1)/sizeof(mmGC_CAC_CTRL_1[0]), 0, 0 },
>         { "mmGC_CAC_CTRL_2", REG_MMIO, 0x1285, 0, &mmGC_CAC_CTRL_2[0],
> sizeof(mmGC_CAC_CTRL_2)/sizeof(mmGC_CAC_CTRL_2[0]), 0, 0 },
> -       { "mmGC_CAC_CGTT_CLK_CTRL", REG_MMIO, 0x1286, 0,
> &mmGC_CAC_CGTT_CLK_CTRL[0],
> sizeof(mmGC_CAC_CGTT_CLK_CTRL)/sizeof(mmGC_CAC_CGTT_CLK_CTRL[0]), 0, 0 },
> +       { "mmGC_CAC_INDEX_AUTO_INCR_EN", REG_MMIO, 0x1286, 0,
> &mmGC_CAC_INDEX_AUTO_INCR_EN[0],
> sizeof(mmGC_CAC_INDEX_AUTO_INCR_EN)/sizeof(mmGC_CAC_INDEX_AUTO_INCR_EN[0]),
> 0, 0 },
>         { "mmGC_CAC_AGGR_LOWER", REG_MMIO, 0x1287, 0,
> &mmGC_CAC_AGGR_LOWER[0],
> sizeof(mmGC_CAC_AGGR_LOWER)/sizeof(mmGC_CAC_AGGR_LOWER[0]), 0, 0 },
>         { "mmGC_CAC_AGGR_UPPER", REG_MMIO, 0x1288, 0,
> &mmGC_CAC_AGGR_UPPER[0],
> sizeof(mmGC_CAC_AGGR_UPPER)/sizeof(mmGC_CAC_AGGR_UPPER[0]), 0, 0 },
>         { "mmGC_CAC_SOFT_CTRL", REG_MMIO, 0x128d, 0,
> &mmGC_CAC_SOFT_CTRL[0],
> sizeof(mmGC_CAC_SOFT_CTRL)/sizeof(mmGC_CAC_SOFT_CTRL[0]), 0, 0 },
> --
> 2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000d47efb05b9d12da3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>This update doesn&#39;t match the g=
c_9_0_0 headers from the drm-next branch as such cannot be made to umr.=C2=
=A0 You need to first update the kernel headers and then we circle back to =
umr.</div><div><br></div><div>Tom</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 26, 2021 at 12:43 AM &lt=
;<a href=3D"mailto:raykwok1150@163.com">raykwok1150@163.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Guo Lei &l=
t;<a href=3D"mailto:raykwok1150@163.com" target=3D"_blank">raykwok1150@163.=
com</a>&gt;<br>
<br>
sync form drm-next<br>
<br>
Signed-off-by: Guo Lei &lt;<a href=3D"mailto:raykwok1150@163.com" target=3D=
"_blank">raykwok1150@163.com</a>&gt;<br>
---<br>
=C2=A0src/lib/ip/gfx90_bits.i | 7 ++-----<br>
=C2=A0src/lib/ip/gfx90_regs.i | 2 +-<br>
=C2=A02 files changed, 3 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/src/lib/ip/gfx90_bits.i b/src/lib/ip/gfx90_bits.i<br>
index 6741947..8aabb8a 100644<br>
--- a/src/lib/ip/gfx90_bits.i<br>
+++ b/src/lib/ip/gfx90_bits.i<br>
@@ -8711,11 +8711,8 @@ static struct umr_bitfield mmGC_CAC_CTRL_2[] =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;CAC_SOFT_CTRL_ENABLE&quot;, 1, 1,=
 &amp;umr_bitfield_default },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;UNUSED_0&quot;, 2, 31, &amp;umr_b=
itfield_default },<br>
=C2=A0};<br>
-static struct umr_bitfield mmGC_CAC_CGTT_CLK_CTRL[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;ON_DELAY&quot;, 0, 3, &amp;umr_bitfiel=
d_default },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;OFF_HYSTERESIS&quot;, 4, 11, &amp;umr_=
bitfield_default },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;SOFT_OVERRIDE_DYN&quot;, 30, 30, &amp;=
umr_bitfield_default },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;SOFT_OVERRIDE_REG&quot;, 31, 31, &amp;=
umr_bitfield_default },<br>
+static struct umr_bitfield mmGC_CAC_INDEX_AUTO_INCR_EN[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;GC_CAC_INDEX_AUTO_INCR_EN&quot;, 0, 0,=
 &amp;umr_bitfield_default },<br>
=C2=A0};<br>
=C2=A0static struct umr_bitfield mmGC_CAC_AGGR_LOWER[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;AGGR_31_0&quot;, 0, 31, &amp;umr_=
bitfield_default },<br>
diff --git a/src/lib/ip/gfx90_regs.i b/src/lib/ip/gfx90_regs.i<br>
index 1342a66..a9ef9c6 100644<br>
--- a/src/lib/ip/gfx90_regs.i<br>
+++ b/src/lib/ip/gfx90_regs.i<br>
@@ -1418,7 +1418,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmDIDT_IND_DATA&quot;, REG_MMIO, 0x1281=
, 0, &amp;mmDIDT_IND_DATA[0], sizeof(mmDIDT_IND_DATA)/sizeof(mmDIDT_IND_DAT=
A[0]), 0, 0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmGC_CAC_CTRL_1&quot;, REG_MMIO, 0x1284=
, 0, &amp;mmGC_CAC_CTRL_1[0], sizeof(mmGC_CAC_CTRL_1)/sizeof(mmGC_CAC_CTRL_=
1[0]), 0, 0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmGC_CAC_CTRL_2&quot;, REG_MMIO, 0x1285=
, 0, &amp;mmGC_CAC_CTRL_2[0], sizeof(mmGC_CAC_CTRL_2)/sizeof(mmGC_CAC_CTRL_=
2[0]), 0, 0 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmGC_CAC_CGTT_CLK_CTRL&quot;, REG_MMIO,=
 0x1286, 0, &amp;mmGC_CAC_CGTT_CLK_CTRL[0], sizeof(mmGC_CAC_CGTT_CLK_CTRL)/=
sizeof(mmGC_CAC_CGTT_CLK_CTRL[0]), 0, 0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;mmGC_CAC_INDEX_AUTO_INCR_EN&quot;, REG_=
MMIO, 0x1286, 0, &amp;mmGC_CAC_INDEX_AUTO_INCR_EN[0], sizeof(mmGC_CAC_INDEX=
_AUTO_INCR_EN)/sizeof(mmGC_CAC_INDEX_AUTO_INCR_EN[0]), 0, 0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmGC_CAC_AGGR_LOWER&quot;, REG_MMIO, 0x=
1287, 0, &amp;mmGC_CAC_AGGR_LOWER[0], sizeof(mmGC_CAC_AGGR_LOWER)/sizeof(mm=
GC_CAC_AGGR_LOWER[0]), 0, 0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmGC_CAC_AGGR_UPPER&quot;, REG_MMIO, 0x=
1288, 0, &amp;mmGC_CAC_AGGR_UPPER[0], sizeof(mmGC_CAC_AGGR_UPPER)/sizeof(mm=
GC_CAC_AGGR_UPPER[0]), 0, 0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;mmGC_CAC_SOFT_CTRL&quot;, REG_MMIO, 0x1=
28d, 0, &amp;mmGC_CAC_SOFT_CTRL[0], sizeof(mmGC_CAC_SOFT_CTRL)/sizeof(mmGC_=
CAC_SOFT_CTRL[0]), 0, 0 },<br>
-- <br>
2.17.1<br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--000000000000d47efb05b9d12da3--

--===============0549488699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0549488699==--
