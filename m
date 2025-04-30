Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3888C3ABA3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 13:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70E210E850;
	Thu,  1 May 2025 13:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="U+TxjzIu";
	dkim=pass (1024-bit key; secure) header.d=nordisch.org header.i=@nordisch.org header.b="JfQx60BU";
	dkim-atps=neutral
X-Greylist: delayed 339 seconds by postgrey-1.36 at gabe;
 Wed, 30 Apr 2025 23:34:17 UTC
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D05210E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 23:34:17 +0000 (UTC)
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
 by tengu.nordisch.org (Postfix) with ESMTPSA id 2513B75B728;
 Thu, 01 May 2025 01:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_ed25519; t=1746055704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUEgyQuETsjtturu6RqQZ44HHx7WCsRfSeWlLxTKoo=;
 b=U+TxjzIuC0YLICJge4eQQmXxuwecS5HBGrRLHORLbCzmwoZNWimwiVrg8H5dUHQPBv5KNH
 zwFZo950O4Au5NDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_rsa; t=1746055704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUEgyQuETsjtturu6RqQZ44HHx7WCsRfSeWlLxTKoo=;
 b=JfQx60BUEX0oxkoAlSiN9W80l7PqHVkkXn7sfOwXqVxqwyfNrARUQ25SgNIJDHyPxu/7m5
 Tr/vxSLtHsmkNBR9otHrEhBUlcD+p55gAVzM9zkai0ePcke4+pND1dHJEsmhLlII7SM/LI
 i13VLQFw0UynbqyC2qhy+53r1FIGRM4=
Message-ID: <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <amd@nordisch.org>
To: Alex Deucher <alexdeucher@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org
Date: Thu, 01 May 2025 01:28:23 +0200
In-Reply-To: <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 01 May 2025 13:05:51 +0000
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

On Wed, 2025-04-30 at 09:55 -0400, Alex Deucher wrote:
> please make sure your kernel has these three patches:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D4408b59eeacfea777aae397177f49748cadde5ce
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dafcdf51d97cd58dd7a2e0aa8acbaea5108fa6826
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D366e77cd4923c3aa45341e15dcaf3377af9b042f

I am kinda sure that's the patches Takashi backported into our 6.14.3.
They are already part of 6.15.rc4 no?

> soft recover kills stuck shaders, so I'd suggest trying a newer
> version of mesa and LLVM.=C2=A0 If that doesn't help, please file a ticke=
t
> here:

Newer Mesa is building although I didnt see anything radv related.

I am curious in https://gitlab.freedesktop.org/drm/amd/-/issues/4192
there is a lot more details about the crash than what I see. with what
kind of flags/environment variables do I have to run to get the same?

An observation from my latest crash:

```
May 01 01:05:59 steam[223306]: radv/amdgpu: The CS has been cancelled
because the context is lost. This context is guilty of a soft recovery.
May 01 01:06:05 steam[223306]: Game Recording - game stopped
[gameid=3D2357570]
May 01 01:06:05 steam[223306]: Removing process 352353 for gameID
2357570
```

Is the game launched by steam inheriting that context or could it
really be the steam process triggering it? As 223306 would be


```
~/.local/share/Steam/ubuntu12_32/steam-runtime/usr/libexec/steam-
runtime-tools-0/srt-logger --sh-syntax --rotate=3D8388608 --log-directory
/home/darix/.local/share/Steam/logs --filename console-linux.txt --log-
fd=3D7 --journal-fd=3D5 --parse-level-prefix
```

It claims "game recording" but that is actually turned off and their
LD_PRELOAD-s are blocked because of
https://github.com/ValveSoftware/steam-for-linux/issues/11446

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.


