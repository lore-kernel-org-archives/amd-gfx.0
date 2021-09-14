Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8758CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 18:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6C660F44
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 18:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F6C660F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D046E528;
	Tue, 14 Sep 2021 18:19:25 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48316E528
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 18:19:24 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id a10so345074qka.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a2HFB4rqcxAVoYtMbwTpx8gBKEbIlG8WOMnHiBGzcF4=;
 b=D0ui/ttYAGdS73AWWNJ45QrUWE7UyuF7ue/HgpIa0q9cAro8BxhDAE91xBYFYVYZ4G
 tpRKUCQseZiP+MhRi0wcYKRAUO4ROcHQk7Csngiv0RwYfhJ5+mn3EEB9BxsvzbsEyIl8
 HVFv3SiJCUblfU7dgGB63GyxHyJU0c0EDuLeUsMBvK5GG+YekxitTpMwzsqUM0AOsf80
 EPy3PAZrOo8ikFfppk8n71QdBa2sUwpBlnaY8X0zMXrnDlNC8EY8QlOE/rzlWcHYMKpn
 4d7Fk3IiCz6JaxedoyUhqaA1ucPxeLig5JUE+wpdrAnAP7yDsPt/TeWLvS5vUsaZv5Rb
 CzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a2HFB4rqcxAVoYtMbwTpx8gBKEbIlG8WOMnHiBGzcF4=;
 b=YxS8O+JIlumgHpOgFbGrJep9DOe+F9jLaf/Kpv83C/5MOO6w+WeBDl3WFy8S/OAuGt
 KNR2dYNHo7i+Ax/cYOBKUtOFw2n2E2GSo8gr436l+tqEIRoMDGe037fGsdN+U5GTXoEO
 EtsSfYzXgOWGSt8iqWHuyhmiDeiajWZV8j4K+m0cROl9uxalaMpg3HGuUv4UUTrC2eYt
 x7ubvumpJ6hCVfEHn+H+BiWC3P1bIw0vnTvgqvrLLQfMksqOPX6/qmw93xh1VlCuinVs
 64BAd7QeecINssx0y9z5RGcCxoiQiy5bjpKIacveh66AefmsHI6ajBcHr++9lO/O43Yb
 RBQA==
X-Gm-Message-State: AOAM530s1UotlxYYYZ3KiuOZZK9UKFjnSNO+vrh+SC0AQIelBnv4pjd8
 ul3IRH4q8qk5XDYd1SI/tsmHkyorS3rDJSdbMK0=
X-Google-Smtp-Source: ABdhPJysrAuh1E4uXoLdBgA3i59jCtwGAh4BUQq2A4bXZl1eSU9fKVcAs7oWQjA7U3HCOdwCe3DkCXN1y1zbql1uzlk=
X-Received: by 2002:a37:a58b:: with SMTP id o133mr6207900qke.120.1631643564032; 
 Tue, 14 Sep 2021 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
In-Reply-To: <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 14 Sep 2021 23:19:12 +0500
Message-ID: <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="00000000000008c7e505cbf89f0c"
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

--00000000000008c7e505cbf89f0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Apr 2021 at 11:48, Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

>
> That is expected behavior, the application is just buggy and causing a
> page fault on the GPU.
>
> The kernel should just not crash with a backtrace.
>
> Regards,
> Christian.
>

If after it GPU hangs with the message "[drm:amdgpu_dm_atomic_commit_tail
[amdgpu]] *ERROR* Waiting for fences timed out!" is it also expected
behavior?
Kernel log: https://pastebin.com/WkhATKXX


--=20
Best Regards,
Mike Gavrilov.

--00000000000008c7e505cbf89f0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif"><span style=3D"font-family:Arial,Helvetica,san=
s-serif">On Wed, 14 Apr 2021 at 11:48, Christian K=C3=B6nig &lt;<a href=3D"=
mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</=
a>&gt; wrote:</span><br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><br>
That is <span class=3D"gmail_default" style=3D"font-family:verdana,sans-ser=
if"></span>expected behavior, the application is just buggy and causing a <=
br>
page fault on the <span class=3D"gmail_default" style=3D"font-family:verdan=
a,sans-serif"></span>GPU.<br>
<br>
The kernel should just not crash with a backtrace.<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif">If after it=C2=A0<span class=3D"gmail_=
default"></span><span style=3D"font-family:Arial,Helvetica,sans-serif">GPU =
hangs with the message &quot;</span><span style=3D"font-family:Arial,Helvet=
ica,sans-serif">[drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting=
 for fences timed out!&quot; is it also=C2=A0</span><span class=3D"gmail_de=
fault"></span><span style=3D"font-family:Arial,Helvetica,sans-serif">expect=
ed behavior?</span></div><div class=3D"gmail_default" style=3D"font-family:=
verdana,sans-serif">Kernel log: <a href=3D"https://pastebin.com/WkhATKXX">h=
ttps://pastebin.com/WkhATKXX</a><br></div><br></div><div><br></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best Regards,<br=
>Mike Gavrilov.</div></div></div>

--00000000000008c7e505cbf89f0c--
