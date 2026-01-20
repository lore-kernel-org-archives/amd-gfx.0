Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AF1D2ECE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E5410E106;
	Tue, 20 Jan 2026 14:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VuIrJPzp";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE4810E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 12:07:08 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64b6f22bc77so931031a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768910827; x=1769515627; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6mJN4EWiKZWaSZItRX0vL+7HkWk5OupdgIHdp6FGDiU=;
 b=VuIrJPzpMsP4ftNNjh88B4HdKAbfjvCz3R3aY86rJkjFP9OH9DrDNx7B1vc/Xey3Qr
 vRDCb/3cHAy4Tyl8YDRXy9r0Xqdnf82kMTzcux1PQ/o8P5mafZfh/iAVMMuuUuoWOSyH
 EZYOdYebmqT3/n7bYJOBDuZHZRa/bb2WOfjhyIJy55JMooW+ZmZKteguBBPzep55oEpG
 lNbT/AhqjJp05WvdhfaSJ5oLQO2PEpP1Ds1jW28DeU1B4pnvZw5xUCjaRthbq2nenUca
 j0kAuH0kB1on0XrcAtnA6sOKOkJxj1G8V+TLcDGX7mamd9Chgn0clxWuq+naCR3M3Flj
 /7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768910827; x=1769515627;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6mJN4EWiKZWaSZItRX0vL+7HkWk5OupdgIHdp6FGDiU=;
 b=KcEVIp5Y+l32I87v5c66mrtY3nYtN1ugtqLWoPR7QANkfsARQP5YVc5Erq8wabds7+
 GV2tnJHqjaXwUgNQmqCzJjV14ut477Ns+rxqQ2T5841LfKp7ykQ/Jsg4L/Gmsj+wrt/P
 t/fRUksLnj/UF6YTHl7CQm8k7/dMelVH+6i/KPnJK3KK/q5lqj6tPxam4oqP9Y4AOGSu
 O7t4PPK0ZXvxey9qOw1oxXyE1k2RgMRyF/bzg/PkOS4SjP/6yjNU40oN1dGl8aK/sT3J
 jG73Sk15UHERDDNARG1Fl6eDhMZS+yvQ26je7NYZkLAagT3sBNRb/UzqFoevzMApbTIN
 jRLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuSMya+bUWHyEK/n853p8seouzc0dLReFlK82tygVwnNOnAZ/g0a2Fe1jnb5oTX4GI4BISND1o@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxosTXh+aGh4pyaUZbAIgzcwugKRV2E1jR0C7kecSw3HSV7NPRz
 EEAMpUhVqr6gDP2uKDU7xgbb7y2FMLQqE3pCHn1Rz9lUhgLl2msCBVz5
X-Gm-Gg: AZuq6aIxVKn0Iv9Mk5hDlgt3tI1rS3o0Xg7CIDeS2yWzP0AbbEQue7Sr9w9nMGKehV2
 4798zcb6HJtryEdUN5gwvZIfvnzzjQvQonrCZ4k4dm0fgjaaUpIZrJ4N76c4s4igjC4C4weOMy+
 Wqoqy9M85rUzLPsNmrKv4Szks1fJzOcFhMys4P91OGnrwQTqZWqHXyHlWU997a6aJL3n+fhD3tu
 sO4Xdszv49o0fa6MdSmz80BMHuiUnnU5gX6FIQchXYYwEKTazeWjG0LGwxRP3oTw8jS5GtWRfxV
 54FoAqn7+jcEy2DYUaMo7YtkIx+7ATCZBeLU5PDx1NdR/kl6RdqyFl+g6jJvaKAz4Oi2lyN897y
 02zORYuxp3nnXTEkpM21LKuUtpuDj2G8+ynt0Wty9kqhnbMDYxoVlSyvR2LEXiNelHQX369kMKI
 GZDZ6/h0OoBFhj1Q5Cbe8BQS6SHZVlR/9KE6unDU9KxNrqugv4uJ+uPgZXKFPDalZ1e2JgMgs=
X-Received: by 2002:aa7:d74d:0:b0:658:dc6:6d08 with SMTP id
 4fb4d7f45d1cf-6580dc6702dmr167598a12.7.1768910827175; 
 Tue, 20 Jan 2026 04:07:07 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce433sm13190978a12.3.2026.01.20.04.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 04:07:06 -0800 (PST)
Message-ID: <222c4c14ee6c20f18381580b249d160d197ce3e4.camel@gmail.com>
Subject: Re: [PATCH 01/17] drm/amd/display: Return if DisplayID not found in
 parse_amd_vsdb()
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, alexander.deucher@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com
Date: Tue, 20 Jan 2026 13:07:03 +0100
In-Reply-To: <b535614d27e30831628b4a70b7ed825fd03791d4@intel.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
 <20260119011146.62302-2-tomasz.pakula.oficjalny@gmail.com>
 <b535614d27e30831628b4a70b7ed825fd03791d4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 20 Jan 2026 14:32:27 +0000
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

On Mon, 2026-01-19 at 15:23 +0200, Jani Nikula wrote:
> On Mon, 19 Jan 2026, Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.co=
m> wrote:
> > [Why]
> > The function would continue to try to parse EDID even if DisplayID
> > extension block wasn't found. Sometimes it got lucky and found AMD vsdb
> > in CEA extension block which made debugging harder.
> >=20
> > [How]
> > Add a return if DisplayID extension block wasn't found
>=20
> Maybe don't use homegrown EDID parsing, but use drm_edid.c instead?
>=20
> BR,
> Jani.
>=20

I would be all for it but I didn't want to make even more changes. I
cannot refactor the whole amdgpu on my own :)

Plus, the generic drm code doesn't yet parse AMD vsdb. I could certainly
add such functionality, especially since it's already in projects like
edid-decode but amdgpu seems to be doing a lot of home-grown edid
parsing and I'm not really sure why, even sending stuff to firmware.

Especially confusing is the part where AMD vsdb is parsed differently if
it's in CTA extensiton block or DisplayID. They honestly are identical.

At least, here in, setting the freesync caps, getting info from generic
drm should be ok. I'll think about it and probably intoroduce AMD vsdb
parsing to drm in a separate series.

>=20
Tomasz
