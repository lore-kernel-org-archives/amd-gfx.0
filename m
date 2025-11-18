Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACAFCED265
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 10:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3490810E47A;
	Tue, 18 Nov 2025 10:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENjl6Ms2";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E30010E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 10:10:50 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b7373fba6d1so572672566b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763460649; x=1764065449; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdNvOrkjz0g9P+2burhRpJKtR6umvyZvxxc1nB4dlRc=;
 b=ENjl6Ms2BKZIjV2fwQwVeheqjCdGO29rlfbm0BQYywVMTwuHqm7oRUKZe6IGnuyDIk
 jksI9y8GyGjG9yRsxJxbGegcfk8v52DQuQh8gTa2R0Toc5km4egjdnfgLSBhEPdhhxCe
 0gYxHVCr0qYmhv24+q7gsYcKsvObPax0JaJWdrN0P4WVuhhinCm8m6laWlW/OfCnUcw3
 ojNUiR8Ohfxi8uo0gIjBVl0OISOC3qRWZR7/0bK9slP2JYlf6w0SNKVKFOVFeSlBjpjR
 Wzkh/EBuETHbP8hGAisKHctsHRs8/Jdah3Uvki3G4V5Z17xIF+qnMgs0CFhAqgUwquYx
 nuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763460649; x=1764065449;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YdNvOrkjz0g9P+2burhRpJKtR6umvyZvxxc1nB4dlRc=;
 b=eZCQgHLhjGPbDv75tQmzbcWAIssltmY3U7+ppPjJMP8MFODkrZIRwHZu/mzBZE4yOF
 ft/fCuPWr5CWnSY397uF7/+tjV7lZejVt95oQ9uOpKMSHBT4ds+INLT8EJSCATsVb8Ev
 KVPFkMArV4APcYf3APQ4YXw0NW290U7kc12Ii2aLLJ+D7ffES9SoBAckA9xCT8b6WWFT
 xyNa8wEFcKbJukEImGox5vAdsWFmBqFXSNDwZHeJmQAFx+7mBmJDeXTsPuTe5Fz0T+i+
 PVTmJ0epxyezKf6z4zJt2GhLf8v7kEdsU3C0KxL2Luqy/rF8925r3WGYNyEbNoswbAqC
 p/bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw/Oq3Uc1GkWN4UFiyC7XyKZPVpGmEZt+W2Z1eB4qAAoy3trXZltccW0bbXNXEJHUCSH667upq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdP1WYlyAe1EiIXf/2NU6NQiYRbuxmTEs9rNjftacDz9mroHYQ
 J6WCHPbCmGbj5Wb82ny+jTjAgUg0zy7+ecvc4r82iboJaAX0aEoT6Z03
X-Gm-Gg: ASbGnculrBduB5/gphwFhczzPKclb5jHu9fFkUEnAp7xAEhkIoyIYF8GCIh8xh4ZKvd
 da0/TB5kr1MV/gSnXraEF45f/hD8iH8Ypj//RU33QIGYi/n+UuZNAl1S46ud5e8JHbdYsxFG3uQ
 AD6vFUa8dQUBPjS2gRnu9Mj1s5jaGOKwdp9nrYwU66YG/WSI5rd9ha+fDWbHhHUXIHrOrm2QdG9
 3TyPwa6zWjLMqLS/DsGKYFWvIZXD/RODB7rC2BO0V9318aCm6pmSbDQlzOq1FTz81KUL6Y/Ozsn
 n4tNYIVSlRcOQrmikWHxJ1bnHqeYCls3xUT/AxSexj7fw5+cCFlIDDSUBGmfCt6aY0jLJCNmi4+
 yh6Up2a+U6omscGyjS6Q+pduxSx0GSnKmDnHDYkvVLKEQDmJwoEf2cO+z14z3PdACJK3Qs5u/Rv
 pMVQ6e9bKBXlxyjRYZLITj5Q6+J2X0nrvWmq59stgj/g==
X-Google-Smtp-Source: AGHT+IEuI/2brYohcwFGv90GpqtV9wi9Yywih3AmdR00/E5FepofXC2Udn3gJFTyCRi+n2kFTwGiYw==
X-Received: by 2002:a17:907:3e03:b0:b73:5e82:520e with SMTP id
 a640c23a62f3a-b736788fa74mr1834305166b.19.1763460648512; 
 Tue, 18 Nov 2025 02:10:48 -0800 (PST)
Received: from [10.104.7.53] (82-198-214-3.briteline.de. [82.198.214.3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fb11d94sm1306273766b.30.2025.11.18.02.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:10:47 -0800 (PST)
Message-ID: <c3b10cd054b690319ca40d0c107aa545d5fdf839.camel@gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: Follow-up patches to analog support
From: timur.kristof@gmail.com
To: Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com, 
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com, Yu.Wang4@amd.com
Date: Tue, 18 Nov 2025 11:10:47 +0100
In-Reply-To: <c9b5c81b-bcfe-4f8f-a9f5-97518a64be9b@amd.com>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
 <c9b5c81b-bcfe-4f8f-a9f5-97518a64be9b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
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

On Mon, 2025-11-17 at 16:18 -0600, Mario Limonciello wrote:
> On 11/13/2025 10:33 AM, Timur Krist=C3=B3f wrote:
> > This series addresses some feedback that I received after the DC
> > analog
> > series support landed. Harry already gave a review to the patches.
> > Please feel free to let me know if you have any other feedback that
> > I
> > should address regarding the analog connector support.
> >=20
> > Timur Krist=C3=B3f (4):
> > =C2=A0=C2=A0 drm/amd/display: Fix warning for analog stream encoders
> > =C2=A0=C2=A0 drm/amd/display: Cleanup uses of the analog flag
> > =C2=A0=C2=A0 drm/amd/display: Cleanup early return in construct_phy
> > =C2=A0=C2=A0 drm/amd/display: Move analog check to dce110_hwseq
> >=20
> > =C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15
> > ++++++++++++---
> > =C2=A0 .../drm/amd/display/dc/dce/dce_stream_encoder.c=C2=A0=C2=A0 |=C2=
=A0 2 +-
> > =C2=A0 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |=C2=A0 6 ++++=
--
> > =C2=A0 .../gpu/drm/amd/display/dc/link/link_detection.c=C2=A0 |=C2=A0 2=
 --
> > =C2=A0 drivers/gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0 |=C2=
=A0 3 +--
> > =C2=A0 .../gpu/drm/amd/display/dc/link/link_factory.c=C2=A0=C2=A0=C2=A0=
 | 13 +++++++---
> > ---
> > =C2=A0 6 files changed, 25 insertions(+), 16 deletions(-)
> >=20
>=20
> As these are reviewed by Harry and display promotion testing wouldn't
> catch issues with analog I've queued them up for the internal CI to
> run=20
> on and merge.
>=20
> Will let you know if anything crops up in that, and if any future=20
> promotion tests fail and it bisects to these the promoter will
> respond=20
> accordingly.

That sounds reasonable. Thank you!

Timur
