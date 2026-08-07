Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB752C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBE710E6B2;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LqC9riYm";
	dkim-atps=neutral
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448BF10E429
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:06:36 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 762EA3F1E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1786115194;
 bh=s9u4Cjv5O4KdNzN7wdMwSwBgYXAgpTiTJcch3SGL7zg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=LqC9riYmArjEMtW1o5j5kDsfKscLWgxxcqg8O648hoHXomUS4YXwyYTtDt5/tsKj0
 p3EG6GVUOyDhalaAPnmsiw3P42o3b+6nX9zURo9adai3gzWYMMN9nv+HD0iak4iFHf
 manW5hOXsYhXE2fQe+hvs4dOA4/fxgZUe5O7/zcCGbnD08mbEcV3u7c+IrG6nCdh07
 Py7SANmyut+Ox6QyJrYIaqXX2rDNLfwqE7p1BwhQMr/IJJ6/mPnHIpbm0N0006pG6Y
 xBm5gpGmz5+8MlAWVhAUaOXmnX25R5rsrcrMc6UObrkknsGBy7kPT5pp2kqwQd1XzV
 x6UUEnnVBWIC61wTYbURbY3IDAaHHaV7VJkLSFQjq/ZKRtlvgGCT0/vT8KoIcYbuXy
 IFmeMiVw38K9b+PuJyFrvu0rPf0FLEIiin+F3/RFVQyedys2BP1wRhaBapTRmxdKdL
 gR4zD3tUeo+iUsrnC1VAfeknyITVvI4vW956rGeAwwtmt5NV297/F7mOT/+TTYf0KU
 36f3fww3CDQ/qidtmcKsHArGnRixpOxIaNgyJbZ905mPRsc78cExqg3U5SuhZgCCiR
 RJIOQXy2lSG1kuXHMl9uuSnaZQ7wT7Z9g3HciUxEnMH+7iKGH05uAvaIVO3UlAsOsW
 a9y/E80UJcyXxW/9RAWjD9+Y=
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4ab4dd46ddeso1682330b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 08:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115193; cv=none;
 d=google.com; s=arc-20260327;
 b=p3vwIo4khiq3D/2Yc6aWKNYOWE3ldgxuNWHaPGtnqkNiy0NahYHQ7vvq9jabEOXl2m
 gNcre78NcSFUlYLdbBfJtz16xqCjhmB+Xmh1bPqHYhjUQlPuBhhaeuGvSXY3/Gk/Q3ji
 6TBZwnsLH9TF2ISYvnX8zhFxN8VHW1yQGDojDRhizElcmcI54KBI8P0g7CsCJAxnO8Al
 mGiePM+zlHR4Kswd2djUKqLS1ZpEqg1Immb6SvsRaSo3+fzK/AhHm57qXh5+VCChEv+I
 Wl/wRLkzceDkcL/gLJGrJR2b7MZ7pZnR2dyqMXSqeVz45IV8P2ozVkIDhjJJ8VvbGWOX
 igAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=s9u4Cjv5O4KdNzN7wdMwSwBgYXAgpTiTJcch3SGL7zg=;
 fh=Oq5oSzOQ1XX8U7BYgdltR96ZVeXvHgTh9i0/rblw6l0=;
 b=YggxsJ958bp0cLuTX8Odf6h189nLvzCLcEmF1Ak/kw9SPqtvE64eQiwZjqqYh2NK/+
 rxYDs+ecD8QaR3w469ARi8ZBvo0fHdLsphq6+jmI+zqRlasxOTnYgFXxPdOl/JxduI8n
 cbLacHxhmxgbfKAIdBAFBEL+Nhr/3T/MagvMTo73drbqVduFNIJgknnVYjuNKKDBRn0X
 g4guKFbS+DD6YDpltDq0HvMFwJUF25LwsZK8iHeV4vV864Y2DS2NN7bwH7kxnN5hxqTT
 Jnz/gHhE3b7zvV1enLlvlFe6k+x928Mi3WMiuAs36c/FlnVXl0feSRx/F+zB4jSyMIft
 K2wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115193; x=1786719993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s9u4Cjv5O4KdNzN7wdMwSwBgYXAgpTiTJcch3SGL7zg=;
 b=CDy0GtKXz6V0gX+WmJr1uFyQ/s5VzNHqrJnlIQeux51mWmj9PGcM73u3S5TaHnib3+
 0zqhVo26QYFSTIxll/8WcHZt3L+6657uExLaTJ1y5E6s2zTzDCfq9xOHi/kbdwFQpsNQ
 CNemR1w3wgcKUdwy6VJlxmWTsLdMDXeVrUjoHVCQM3ZN13E2qIX1dLy20otRYB3OR8zU
 nxlGsi4TkSqvbI35zcZGRqnfldLoDrZoIaF71au9wn5t85s1k8sn9AySftj7W/NTHm1J
 dhgWhONgt8SxZAn2iDanrDNifsuuSxqex0rfYx8W7rz2r1vdv4fbkuoyI6unSzYZUHmS
 ovcA==
X-Gm-Message-State: AOJu0YyIC8StbIA09XA+/wHTSYOE1bwKUemgXJCvZ6kiiZsvB3M4D44D
 GQtK33t1mKLLZwIGS/LjIz2kwRd8EBT1KeU1hm8p71O+nojHAjKSbGtGy9ydz+U3GmQAgOFQyIJ
 Aq6Yb7ceQBmqb3FDlzjAJyqodLajueNGWxxaZHl1UQksXhu/LSV4lW89qx9OYlF/UOadr2SsDtr
 gsYzP9pXCdVouOslELI/5ZJFzYC4U4K5rzoIPe+2o4E9rh37+fjQObZnEV6LjSB5q95g==
X-Gm-Gg: AR+sD11jhanUy7UemunX0TqIHmYPIVgzblQoIXQR0v/ptXMt6FCPFEUmwKsOttQ6Doy
 qEv9ap+bnuHDLHTCpkL4xEzRl5X714Mxy56P+uS6HhotIJmTlz5+myxPF+5Wgore5QaBU1WCf6+
 10uQtcGr9NwwiJ7rnrAGLA4m+1AQ8U30pBQcPFp2rrQkKoHSRM7Ab2ERnYqkqu4KX8XYW3Aycrs
 t/xG+0XwsDeEBYtGg==
X-Received: by 2002:a05:6808:d46:b0:496:3a1:e44f with SMTP id
 5614622812f47-4b1ab7aba1amr441554b6e.6.1786115193123; 
 Fri, 07 Aug 2026 08:06:33 -0700 (PDT)
X-Received: by 2002:a05:6808:d46:b0:496:3a1:e44f with SMTP id
 5614622812f47-4b1ab7aba1amr441519b6e.6.1786115192655; Fri, 07 Aug 2026
 08:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
 <20260806143408.979209-2-mitchell.augustin@canonical.com>
 <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
In-Reply-To: <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 7 Aug 2026 10:06:21 -0500
X-Gm-Features: AUfX_mxZw4JfRByCTOWw05hzV7zuEqvITixMOQu_e6YUGE1ZqEPRg48frnDpsxU
Message-ID: <CAHTA-ubuVAMn8wnrWpBvnvMd6gH-80cSygbmS5Sy-AhU+Oy0XQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

Hi Leo,

I am not sure - I have only personally tested the latest
Ubuntu kernel based on 7.0.0 (7.0.0-27.27). Could you link me to the
relevant commits / mailing list entries? I can read through them and
will try to give it a test soon if I have time.

-Mitchell Augustin



On Fri, Aug 7, 2026 at 9:59=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2026-08-06 10:34, mitchell.augustin@canonical.com wrote:
> > [Some people who received this message don't often get email from mitch=
ell.augustin@canonical.com. Learn why this is important at https://aka.ms/L=
earnAboutSenderIdentification ]
> >
> > From: Mitchell Augustin <mitchell.augustin@canonical.com>
> >
> > Issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/5394
> > Ubuntu BugLink: https://bugs.launchpad.net/bugs/2162904
> >
> > This commit disables panel self-refresh when more than one display is
> > active to eliminate a common hang and system crash that happens
> > frequently on some laptops, evidently due to race conditions between
> > the DMCUB, amdgpu module, and possibly other components which are
> > exacerbated when more than one display is active.
> >
> > To my knowledge, a fix for the underlying failure condition is not
> > available upstream, so given how disruptive this is for impacted users,
> > I propose disabling this feature under this condition until it is fixed=
.
> > The main downside of disabling PSR is that it
> > will increase power consumption, but this should be barely noticeable t=
o
> > end users, since PSR will remain enabled on laptops unconnected to
> > external monitors, and since laptops connected to external monitors are
> > likely typically also connected to power (and thus less concerned with
> > the energy savings afforded by PSR).
> >
> > Signed-off-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> >
>
> Hi Mitchell,
>
> Do you know if this issue still occurs on 7.2-rc6? It includes a bunch of=
 fixes targeting flip-done timeout issues that involved PSR.
>
> Thanks,
> Leo
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 5d2715f78314..272f195b8c28 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -152,7 +152,8 @@ void amdgpu_dm_crtc_set_panel_sr_feature(
> >                 struct amdgpu_dm_connector *aconn =3D
> >                         (struct amdgpu_dm_connector *) stream->dm_strea=
m_context;
> >
> > -               if (!aconn->disallow_edp_enter_psr) {
> > +               /* Do not enter PSR if multiple displays are active to =
prevent DMCUB hangs */
> > +               if (!aconn->disallow_edp_enter_psr && dm->dc->current_s=
tate->stream_count =3D=3D 1) {
> >                         amdgpu_dm_psr_enable(stream);
> >                         if (dm->idle_workqueue &&
> >                             (dm->dc->config.disable_ips =3D=3D DMUB_IPS=
_ENABLE) &&
> > --
> > 2.43.0
> >
>


--
Mitchell Augustin
Software Engineer / Tech Lead - Ubuntu on NVIDIA DGX
Email:mitchell.augustin@canonical.com
mitchellaugustin@ubuntu.com
Location:United States of America (Central Time)


canonical.com
ubuntu.com
