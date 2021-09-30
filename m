Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB99C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CAC6141B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46CAC6141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF436E0FF;
	Thu, 30 Sep 2021 16:15:12 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9D96E0FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 16:15:11 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id j15so4387261plh.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XM3hCTjCUZ4v3zMgN7WNA5qJTsDGauz1YGJPcBmlhbY=;
 b=Q5PDw6bqNA0dZ0KcApsvyWFFtBo4HU/VSLjopEY0+cr9bJQD85v9fM+3Y9YtxA1WXc
 VIW9xek7Yt9Pn67Bn6hgLsHn8ZnvF23BkWKM733ZEORjZP+9VhJcoaKodQ9lSImsb3iR
 VCgdRjoOidZBsftu1spEZEK8VlbYoXfL+TPz1LZ78jrJ0CHUziDZRiApL6xFRqLgHPx9
 MixpMHweEBsDjexQCiB+M+nFOpNN/n7gPazGNEYo9zyaoBTudYx1WHtGMInCfKGe6bTj
 h9i6kMpllrmrda1fV4yZW+gkarEkxkRUrVEyNqdPf+WdbcNeYyG4d07JsxVeWhLqHKTA
 ciTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XM3hCTjCUZ4v3zMgN7WNA5qJTsDGauz1YGJPcBmlhbY=;
 b=L4U+GlC5vVKl8L9JUjHvourM/aWLWV995fAAMg1SFHVv0qNdfnAd/M2G0ObAkntR3l
 TBOaM99CkGFias1hJgm1nEospGKBYKzaoxoIxCMvwPAb8S+7w6vFU6HiSdQx6tFamaSr
 ky20k5PzVAEJ4+61sBEj0giRDHbalmz5hZMrZ1FDpkTde7rTuSRzcl/+rT+gt5chZwEx
 6QXfp4FMU4FqoPQRiGNGM7YyNk6NahUS7leB0JuftL6J/faKt/9Ihq0zQe1dur9vkSYV
 AgatWsefcJpEYi3ZZrjfIU9vHex2LctnPtzSgBfroorqZWntDN5hs6kHTprJoAmkH0Dm
 +4mQ==
X-Gm-Message-State: AOAM532G7ytgKx4+xnJtVClSKbb1CujGl1pyoamqquOyq67uWKPKOPsQ
 T6oSgsAjCuLRCyKyD3ViRZApkuXr8QyFcx5B6icvobX41IA=
X-Google-Smtp-Source: ABdhPJz27XFcIYaZz/zMRXtQ08phAOQuXr3cl7miEORJ8gfVw4WK07YvVM4QEErj+0adWWrNFvFKvZeU95oYpW1f6gc=
X-Received: by 2002:a17:90a:7301:: with SMTP id
 m1mr7338678pjk.164.1633018511059; 
 Thu, 30 Sep 2021 09:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
 <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
In-Reply-To: <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 30 Sep 2021 12:14:35 -0400
Message-ID: <CAAxE2A6mjGL27dGpq1GCGspsa7CffSGO9MhW8LmFmbZ=JzTr_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix DCC settings for DCN3
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000436e0a05cd38c06b"
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

--000000000000436e0a05cd38c06b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've also amended the version bump that I forgot to do:

-#define KMS_DRIVER_MINOR       43
+#define KMS_DRIVER_MINOR       44

Marek

On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher <alexdeucher@gmail.com> wrote=
:

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Thu, Sep 30, 2021 at 11:50 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
> >
> > Hi,
> >
> > Just discovered this typo. Please review.
> >
> > Thanks,
> > Marek
>

--000000000000436e0a05cd38c06b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve also amended the version bump that I forgot =
to do:<br></div><div><br></div><div>-#define KMS_DRIVER_MINOR =C2=A0 =C2=A0=
 =C2=A0 43<br>+#define KMS_DRIVER_MINOR =C2=A0 =C2=A0 =C2=A0 44</div><div><=
br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Sep 30, 2021 at 12:06 PM Alex Deucher=
 &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Acked-by=
: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" target=3D"_=
blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
On Thu, Sep 30, 2021 at 11:50 AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailt=
o:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Just discovered this typo. Please review.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Marek<br>
</blockquote></div>

--000000000000436e0a05cd38c06b--
