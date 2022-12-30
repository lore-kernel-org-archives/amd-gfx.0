Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFF7C10F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Dec 2022 22:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F87C10E096;
	Fri, 30 Dec 2022 22:11:32 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7159F10E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Dec 2022 22:11:30 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id x22so53723441ejs.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Dec 2022 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vBJtP91j1cOEwUuEAN2FIQufHLE1qmKMmY03dyor8w=;
 b=cUERzc5xsDEEWKWKJIp9AhdIjj1Fgq29DRHCEPNz4BNI1mvcr+aLv0egPV1PidBGhJ
 VbmQMouAqK4zGd3yyzUsJ576Aj0Z8JZX57scxvKYImnBXLXaYYhEDkHAQuRDfO0qam+A
 7yC2QZpLt/cKpaMVcXDt+Nctxq95gSha3nWvAtaPtHWWqkdGfOA4435dmxV8oSQVSMt2
 6Vakdtu5MZwqaV4psHybPIIQdnckfzSk8dxN1ntwP3zHWWxYGFFjx1Nz3IWRI8itjpcd
 lRtgeTb3ehliY6NorZaU5wTTOLucAC3IrGADqeXAVil4sTSdeutjQiTTLi6PM2pS3q8A
 oEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vBJtP91j1cOEwUuEAN2FIQufHLE1qmKMmY03dyor8w=;
 b=KyC1PVWY6WDvm6HzGSFfqrUqlfXmAYUhrLO8+mokOsmxFdb1FBjQV3ffkgL5IQbscg
 8oK8Is+ihoLx/alOXvoqSiA0YShqRoZX19tfFsqm3zZKsIUj076bc0YDQoKCjOoQqpXx
 NOaXUPL7YpyVNGfsrnZ04NiZuqF6bh3TcJP/icgs+ms0+M09c68YlQQtMdmB/O85+QPF
 9XNNwvF10Ab78WlNfjOeqfFLr+KG+XoIvru+WMBWC+1xmlpdHUa/SzTueSOUwj29IhnN
 l+EMeO5+tDQoU2h22w4Am/JQKf++/6j/Qst77+LHyvlqKCZN58h11ubHGQ9VTMXXap9t
 0gvQ==
X-Gm-Message-State: AFqh2kpNjvpf5zLRRLB4VfWDNImJVWNzOQN99G07VLeEaE5D/JbVoTa/
 mDz6xTLdAPKflSOEt+SwHuuV6PdG+vQehakKL/fx+05t
X-Google-Smtp-Source: AMrXdXt2udnoL1bfohpbN3NFiCFGZ/0rEtyyXm+/+NbaXpSabpYZZ9pVRy4cKPlcyMU1dCsbnyqJ75qL0EfUhkRnOpM=
X-Received: by 2002:a17:906:d973:b0:7ad:d411:30af with SMTP id
 rp19-20020a170906d97300b007add41130afmr1987015ejb.636.1672438288806; Fri, 30
 Dec 2022 14:11:28 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
In-Reply-To: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 30 Dec 2022 17:10:52 -0500
Message-ID: <CAAxE2A5tp_Tk1-a_oK-z+zz3Q3vUVjArSL+YJMCeO1Mmhb-apQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000001cf5f705f112e20c"
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

--0000000000001cf5f705f112e20c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, I've fixed the mixed tabs/spaces in amdgpu_drm.h locally.

Marek

On Fri, Dec 30, 2022 at 5:07 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:

> To give userspace a detailed view about its GPU memory usage and eviction=
s.
> This will help performance investigations.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> The patch is attached.
>
> Marek
>

--0000000000001cf5f705f112e20c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>FYI, I&#39;ve fixed the mixed tabs/spaces in amdgpu_d=
rm.h locally.</div><div><br></div><div>Marek<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 30, 2022=
 at 5:07 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com">m=
araeo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr">To give userspace a detailed view about its=
 GPU memory usage and evictions.<br>This will help performance investigatio=
ns.<br><br><div>Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:=
marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a>&gt;</div><di=
v><br></div><div>The patch is attached.</div><div><br></div><div>Marek<br><=
/div></div>
</blockquote></div>

--0000000000001cf5f705f112e20c--
