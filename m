Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06846ECD996
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 19:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737BC10E092;
	Thu,  5 Feb 2026 19:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FA86oDfT";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A8510E092
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 19:17:01 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8946e0884afso26718306d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 11:17:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770319020; cv=none;
 d=google.com; s=arc-20240605;
 b=jWDzLMigDPXgKVtWPwNAnmGZFWQyGrMY2lKwYmVHAtE38DQMBOdLcobu1w5W+6oFyi
 zLirYO5au1U+/V4S8XKrj2lcGxlOUEDHKl36vS9Vod8txYnTpYEsP/uJQfdAOErBWmcP
 i4Q4JuLIhJhhYuyQBRIVsL7Mbpi5JIkEvFKTHIA0MQwezlpZuV6kna3w4fRZqYXREhcA
 EnT9dRLDk6h+qJOdSknpoehyogQckRFzVhokiWGpYcEgUFpxwZu3dgcn3SvL8Jc0WhK+
 HBxfFRYA61MkyfKwaIT6tIcMvwCH5pX8Qw92M16xxaMOdjzAqOEgef7lL4n1IXNjg1ie
 Ongg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P2cu2LaqjKk/iHOyXMDpBb/9EjbCB9O39mcEVZVjW00=;
 fh=Z44YKgoc6HsUI/8EJIqyQ35hg0JMsbevW2TYqFqKjhI=;
 b=Vm0XPkDAJfsbnnMZyKNhM1sFZpR0T34cV087T/gEJh8461DcPMQA6/JOWkRCdM3iJ9
 wX/cdinzys/M4VqYZRHoNmxjDfs1F4PiUx/3uMvBP7pg0WIrOY1anLm7PvQs2fuW4/aB
 zJdrtwuPQ/X+xQvn+BT0cLb1bNTxIbPW7I4qkEhfFlJc/tfLFlwK+tciOHuGPdmLEgLi
 OT4ziWt+XG8sefTJ6HTxt3YIsU7qOZYPU5tWIlIew/n3wNdgn4iM0tdZbo5I3J1xJTt3
 IuL96kVuaZHAoVSAVGDRkhCUg3zE1xtt3jsK/8E43BNw2ByXxQpDjOUzEMHYk3OZMrFG
 fhSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770319020; x=1770923820; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P2cu2LaqjKk/iHOyXMDpBb/9EjbCB9O39mcEVZVjW00=;
 b=FA86oDfTsNXoYD42Sz/j3eS2AjT+qYvcNMPeOggf8V1e9d3kr5QRHKdkcbVVfVJToO
 kvUBfg8t6QHkRo1pKKyCd3ubEhYAZQ1MkWu/mQ0eGOkNMCMZwo5RsPw7I1ArDVpWHlcE
 lwM4fYeG1n1k53LuMWjSWgoVVtEqsaP9WNCByod+Vj54Bkzpq/LO7wEXH8/6rknthu+z
 jfNB1AOS98ma24xjnz0xU6nF/aTbEgXWkYd2gAiRBayYpynVHQOjZhk3zGzDyFYUkLk4
 8QsfBe1nvMiZPXRfhliQFXzt2qA5uQnaWFfirUiQvQT21Gzry+nLUcNJoTpOH7aPAo+W
 Ar+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770319020; x=1770923820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2cu2LaqjKk/iHOyXMDpBb/9EjbCB9O39mcEVZVjW00=;
 b=JJX/R/yvDUDv7O09Et6bv2nDTmEixG/1QNJ4MwOkdn5AF4mPxRsF3ZONBJK3lNLPBd
 B4Ch16nY9aN+U0HLgp39on7F3+M60UkHjft28CrLLNw2ziqOpwsfNmLtXVC8GbJncE2f
 JbMtAlZ8OBTTk9bhJZ2jLs16POs12KdVTdQAvl/BUO76hcQMh9ZedAhNQ62Ke7erl0IR
 NWVZxV//M+BXUKm/1mU9/mD/wdu4LS9a/uD9SDIPohpCPSdDyomA6hE8eKUkmRtrkdQ5
 M3Hug158/aEY6iPEL4k5mPKCUQ76jQJjtCFM2m4oni1Tf0ObbHD8S6y+hM/L64XPQvUC
 Y97A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXc4brHl6rGJNeUWZdWA0yXPpqVZSgY/wKCkfyQhXrThgdqY75bFZje5/9iit4MbmsC8U8dCE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8Y+3wORqUyj+icxi0CBZUKxbjgtCVdH5MD0rrnL7f2g/6yomD
 FUCmQ/B7GKMy3oyQKLwWwMUNCX+O0POrb5qpyTXaJy+CF7DOC+PB6kKI2AaQ8HRy/sWdj7xqanJ
 Z5lyBMu7WihEku+S6nWeINDPDab+wboc=
X-Gm-Gg: AZuq6aIuB0vC8frSk39BRt9UYQDt0CfJZ5a/4EWuXE8tCjCEAWCVN3dwzkVCEXeNmig
 93kawQsT4wxJ1fT6T8kRcsxg3c0qsRoYQ4y1ofIsufyn0VAIvczkaSlTkFTJ3068I1D0Sj+yJ8w
 owROAEYVL7XEd/HUm31ZMYEcO6h0R/f6tWhvNsQNT2ygbJUezhvx5m2PvhiKtD2OhwYGaGxPOLr
 cjAs74dS9VBNCM+p0CWLEw0nGkxoWJN+XsTVwIoCLjip8TDYvJG6xn9uK2w+QM0/SI236M=
X-Received: by 2002:a05:6214:4017:b0:894:79f2:db00 with SMTP id
 6a1803df08f44-8953c83ae3cmr2562026d6.30.1770319020581; Thu, 05 Feb 2026
 11:17:00 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
In-Reply-To: <CADnq5_MTX8CifP25UvE5kdMbCYxgK+A+KGdd-_Ef1m4VYv+WRQ@mail.gmail.com>
From: Gregory Carter <gjcarter2@gmail.com>
Date: Thu, 5 Feb 2026 12:16:49 -0700
X-Gm-Features: AZwV_QhJnU3PMpjjPKF2DHVOJ2PGlym_H7moo0vpTpCU6LfzBsYljzmq3sxcOc4
Message-ID: <CAE4jU7jfKWtvvgRiY2fTM466en3JgRNg58DW4D1aWwCtXGm-WQ@mail.gmail.com>
Subject: Re: Accelerator/GPU top
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 David Francis <David.Francis@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005c67ec064a188483"
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

--0000000000005c67ec064a188483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are all kinds of accelerators out there for various sorts of things.
It would be a shame if you chose an approach just for GPU's.

On Thu, Feb 5, 2026 at 11:58=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> Has anyone given any thought on how to support something like top for
> accelerators or GPUs?  We have fdinfo, but using fdinfo requires extra
> privileges (CAP_SYS_PTRACE) and there is not a particularly efficient
> way to even discover what processes are using the GPU.  There is the
> clients list in debugfs, but that is also admin only.  Tools like ps
> and top use /proc/<pid>/stat and statm.  Do you think there would be
> an appetite for something like /proc/<pid>/drm/stat, statm, etc.?
> This would duplicate much of what is in fdinfo, but would be available
> to regular users.
>
> Thanks,
>
> Alex
>

--0000000000005c67ec064a188483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>There are all kinds of accelerators=C2=A0out there fo=
r various sorts of things.=C2=A0 It would be a shame if you chose an approa=
ch just for GPU&#39;s.</div></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, 2026 at 11=
:58=E2=80=AFAM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Has anyone given any thought on how to support something=
 like top for<br>
accelerators or GPUs?=C2=A0 We have fdinfo, but using fdinfo requires extra=
<br>
privileges (CAP_SYS_PTRACE) and there is not a particularly efficient<br>
way to even discover what processes are using the GPU.=C2=A0 There is the<b=
r>
clients list in debugfs, but that is also admin only.=C2=A0 Tools like ps<b=
r>
and top use /proc/&lt;pid&gt;/stat and statm.=C2=A0 Do you think there woul=
d be<br>
an appetite for something like /proc/&lt;pid&gt;/drm/stat, statm, etc.?<br>
This would duplicate much of what is in fdinfo, but would be available<br>
to regular users.<br>
<br>
Thanks,<br>
<br>
Alex<br>
</blockquote></div>

--0000000000005c67ec064a188483--
