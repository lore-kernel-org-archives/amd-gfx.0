Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5475BCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC4810E709;
	Wed, 20 Aug 2025 11:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWm4iYGz";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD45010E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:49:20 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b00797dso43293525e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755690559; x=1756295359; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B/bKP3LN5nK22uxOYOscj24VWWZt2XxiQ8BM78nq9wU=;
 b=TWm4iYGze5gMgMmsj2PJszQowjvBbZGH6I0L9ORvfa051mCu/jir92kFBDDL2KjeOe
 QmW5yojrja7a26xz4jXKrtUHNHSLI+IQts8WZ1ERz3pFYyl1vrbBkTf1hE7jarRnvnc1
 dO8qdFE7KBXYMPh7GYaZv9cDmY1nqAX1CG1ExK6CC0Hv4BNdS96WRaJl7Dk4d00A3gvw
 BW3kTvhU0yPP//RQxCXv3HiR8wJK7d7obTSfQ4b/QuTjjny/2PMU1RvEKVCan9HRkXBV
 sCbFO5dn/FDbqPrA9HkmE/o9QzwkhQAGpmTHxv+O6CEFhngDOUbV9bZPF7EjSjwfBOTa
 XRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755690559; x=1756295359;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B/bKP3LN5nK22uxOYOscj24VWWZt2XxiQ8BM78nq9wU=;
 b=kXileVyCOOgIE4QR/Q/9/KXp147k+6ADVlU+fPUFbfQtkHXh/wB03D7u0EPjP6qgQ8
 2QBIy5y44VTcMsAvLV300EonFIngjyskOZMg4HoVN/RjruXHyvgBw9F2aN95NjJQ5njJ
 ZPpe7TiC1Xl1L7VkhGG4p2RXwhxX+NTwToPP+2KkU0D8mQGqiHzhVvLAH+WLAYNuz7fD
 6YYGiNNg4uNrKLZNV2nI5N7pT5SDdgEbtUPZql6dW2aT74cQSgovt7m9bJXMZLAqpsgt
 qFobD/U3K5LHN5nV3KcBEWiZRYx+Bp0mZjfDg16rZim/lgpIEku1cOELSf2ohfPw3dng
 MLuQ==
X-Gm-Message-State: AOJu0YwzgmlvYiVHnwIwcnSMEy+ty5VDaqVnLX7Y1PJLaBXU1zsoJ05w
 tM/FcstB8ZUQSXv4Wi8qeP2DoyO8xGWg2fqANJC+yw2P5N4TWrxl57BA
X-Gm-Gg: ASbGnct1JRkdSCG9HJPLJZRMLFzjaqiONjWBSsjcY3F6/YCE79qpmpUKV8772X1injz
 jMlTmhftha8O4x3Zrl8JOmyXLjMOksseNgS1jwc5TmoxKB/OdkQYIw7/rKi1RfzpAAwr1pm48L/
 PvjJhlAEDHL1OfAns4DP6FbPwRtPlKU6IcuSEcrlekXTQFDMQFkNjQvVcsXeRE03q8sSaV9R0nd
 gvbxpcuVViNFJOMN/RN7oHv61kEWJdS38aw6htZ8PZVcOJkppC7uC+LJ8prBKpOsytthed3jAII
 DDapiIvhYuqwryVQaPvLzNz2m29/WYJhjTHD0pjRUwEMKJG6oC9H/IJ3FPHAb9WO7hjol7bkgFN
 0t/KLeotHI3EzY3ORUn0INumi+4rHSqi3P9YzZYu8VAUdihVOMug+FSNAwnQglkQgOczTnP3Jic
 iGSs0vrJe6b2BBXnjnj1GM4f65CuPbwT0HMwy6lmexA+gezB7fzgPiNOyLSMaYgHFFVIiPpA==
X-Google-Smtp-Source: AGHT+IHQn5XQzO6jVECNYg+VGG8NI7A/fVASv9Kg9v7d6d0ChcsaDPxCTnzVP0qDJ/Yv1i6+FG+FCw==
X-Received: by 2002:a05:600c:4fcb:b0:459:da76:d7aa with SMTP id
 5b1f17b1804b1-45b479fd53fmr20139645e9.25.1755690558904; 
 Wed, 20 Aug 2025 04:49:18 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d9:d00:9fb6:4062:d31c:4e1b?
 (20014C4E24D90D009FB64062D31C4E1B.dsl.pool.telekom.hu.
 [2001:4c4e:24d9:d00:9fb6:4062:d31c:4e1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0748797acsm7172232f8f.10.2025.08.20.04.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 04:49:18 -0700 (PDT)
Message-ID: <ea586972729d65ce6cbeaacd48ca2df47aa71220.camel@gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type
 more accurately
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Date: Wed, 20 Aug 2025 13:49:17 +0200
In-Reply-To: <598e36e4-7b96-4f13-8461-1abd650c16da@amd.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <fba517c2-2626-41f7-a09d-31fd028e1aa9@amd.com>
 <CAFF-SiUuwwz09Vz90HOTuCcdUt5DXgFLR5EkxWUO1V7uDEOnbA@mail.gmail.com>
 <598e36e4-7b96-4f13-8461-1abd650c16da@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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

On Wed, 2025-08-06 at 14:13 -0400, Harry Wentland wrote:
>=20
>=20
> On 2025-08-06 13:45, Timur Krist=C3=B3f wrote:
> >=20
> > Harry Wentland
> > <harry.wentland@amd.com=C2=A0<mailto:harry.wentland@amd.com>> ezt =C3=
=ADrta
> > (id=C5=91pont: 2025. aug. 6., Sze 16:56):
> >=20
> > =C2=A0=C2=A0=C2=A0 this patch regresses the kms_bw IGT test with Navi 3=
1 and 48
> > =C2=A0=C2=A0=C2=A0 with a single 4k60 DP display connected. These subte=
sts fail
> > =C2=A0=C2=A0=C2=A0 when they should pass:
> >=20
> > =C2=A0=C2=A0=C2=A0 linear-tiling-2-displays-1920x1080p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-2-displays-2160x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-2-displays-2560x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-2-displays-3840x2160p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-3-displays-1920x1080p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-3-displays-2160x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-3-displays-2560x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-3-displays-3840x2160p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-4-displays-1920x1080p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-4-displays-2160x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-4-displays-2560x1440p
> > =C2=A0=C2=A0=C2=A0 linear-tiling-4-displays-3840x2160p
> >=20
> > =C2=A0=C2=A0=C2=A0 We confirmed with a revert of this patch.
> >=20
> > =C2=A0=C2=A0=C2=A0 Harry
>=20
> > At the moment I don't see what is there that would make a
> > difference to Navi 31 or 48.
> >=20
>=20
> Not sure either. But that's why we have these tests because
> they often catch things that aren't obvious.
>=20
> Harry

Hi Harry,

I took a look at this issue.

I found the code for this igt test here:
https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw=
.c?ref_type=3Dheads

It seems to me that the test sets up a very simple display scenario and
tries to check that the CRC isn't zero.

However, the variable "igt_crc_t zero" is never initialized (and is
also of the wrong type). So what the test is actually doing is
comparing the "captured" CRC with a piece of uninitialized memory.

That being said, I decided to rewrite my patch and only check the DC
connector type for DVI signals to distinguish between DVI-D and DVI-I
specifically, and otherwise leave the rest of the code as-is in order
to avoid any potential regressions.

Does that sound OK to you?

Thanks & best regards,
Timur

