Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718FD1037B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 11:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1395310E5C3;
	Wed, 26 Nov 2025 11:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="abG9m7Kt";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA0210E5C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 11:07:40 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8b2f2c5ec36so756235985a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 03:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1764155260; x=1764760060;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ySJZVvPVAtkVNPz6NA10TcVQSbkBmCkSCgqEWvBqTZ0=;
 b=abG9m7Kt8F8NjgnXFzzkXLbnECsSf+ZnJ9V3v5vPcDszzatZqekJ0sNpbTsAgmID1v
 IJt2sJ1zpV/ZDoq+tR5cxA4NiFhhXbeHRxOctLaqkpaaolUOyo7gO+OPiZ/DKZvevF8j
 mP00SDVpfxDZMf0SSP4SWZGECG2sSrBP9oJYlPwnKVBfX9m9U1BlU8pemx9vHStjzOjQ
 8hiWGYLIt330NUkbzdyVog+0rpzun2MhPK2p46ibN7fw0iiKCdzY0SsLw7+OsexjwHIg
 7BbOuc/O/eiKBECO2qYfK7kmCza4xKj5r3adTGnH9SsnTyGKovLlqTFB8P6gBq7+q06V
 OsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155260; x=1764760060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySJZVvPVAtkVNPz6NA10TcVQSbkBmCkSCgqEWvBqTZ0=;
 b=IHLdgYwHLc6qU+E9K2xkmBFX4PSU2elpou1wQ+13a0dT1mAL2qJpX3UGwkzfSjyj+f
 U28mT37nTdBtPaTS7TAAdsfDWR52T4GXCr4T8hzpXy/9u3tY4rG0PYERK49s4NL1ccm/
 T7mSTsEIYjYCkAdqfFVERR6v0C319eyfabSMFGwGu0617GkPDWrVfTCBe4M8FX5+WWgS
 C5byxZq51r5R/lebhJKxSlzyS6faeTPUwmNRpzbk5fZ8RPtz/v9i3fq9+xfU0VG646z8
 6bA1hPFtQD9JDlWIs+izHmPWY5ryFzULSmR4GO3PZi/GdTVcC6Otm6nZ4Fzvjeq+lVNv
 c2IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg8xAa4B9jjoOf4V0uV0E0jJQWrXHvihGO3VNmppNEfWsDRGlm7m8RWMV8C238SmuYd5bQBQau@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWpNBcpusGgEihPea2yn2QzguKUccIivCGkEud9CdkkNF0OI36
 a5LMBeE6XanebhapGJ5dg6hRcw6+eXLNxI3255+LgpCJvE6nPnM1WAnbfJA+vW3IlMcBIlm4OkX
 NCHVZeIhZ0rWyroeD2yXrzgtv/Qf25EaiucryGqRVHw==
X-Gm-Gg: ASbGncsaIWHbMXAQhCmLQR8aaD7W5rwNz5sddhr8phgy0UKZKLhUdiw392Eg8+xTJ6d
 eHSvlkhe2W/owd5pnYAvKma7AgSQLlMARxeYN/acuuCd9lay/gdt54w/qZVkQSWwTMRdFpf+D9l
 E/kFBSZ6YhMhZ7A+Z7qFM1aNj4BpUmgQ3dq1K/iMbVQ+RMhFuXopWWq1v32k39sRbouIMywgIPD
 S8MiJPO6O+8SPazmg/DHw1bFss7HlSO5+/WuJsWQYAech+0QwbcOcBGpYMl+NzKudEf
X-Google-Smtp-Source: AGHT+IFEMRhUJ5DgUF4M36O1+CotSLgmr1pmxYhcDMz2eQI19J/ZEulHKQDG2upEFzMe0pelGzx7DUfPzYgkEkrs7pQ=
X-Received: by 2002:a05:620a:45ab:b0:8b2:f8c6:7ce6 with SMTP id
 af79cd13be357-8b33d5fcea1mr2587147985a.79.1764155259826; Wed, 26 Nov 2025
 03:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20251115000237.3561250-1-alex.hung@amd.com>
 <cbe00ac4-a535-47d3-813a-e2eda7e9b991@amd.com>
In-Reply-To: <cbe00ac4-a535-47d3-813a-e2eda7e9b991@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Nov 2025 11:07:27 +0000
X-Gm-Features: AWmQ_bk-XY4uko7oWn1VM70Ld-snMR_1TXIzQmZl4NZVeR2M8i3me13S5kT5F4I
Message-ID: <CAPj87rPoadOOTk0LbVb_VKFOOkSq0xG-PU8fRsLaaqO1kKFuDg@mail.gmail.com>
Subject: Re: [PATCH V13 00/51][FINAL] Color Pipeline API w/ VKMS
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, xaver.hugl@gmail.com, 
 wayland-devel@lists.freedesktop.org, leo.liu@amd.com, 
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
 contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
 sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com, 
 joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 victoria@system76.com, daniel@ffwll.ch, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, mcanal@igalia.com, 
 nfraprado@collabora.com, arthurgrillo@riseup.net
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 20 Nov 2025 at 20:13, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2025-11-14 19:01, Alex Hung wrote:
> > Both kernel patches and IGT patches are reviewed and the API is stable
> > for a few revisions. Does anyone have concerns if kernel and IGT patches
> > are to be merged?
>
> Xaver, are the kwin patches ready to be merged?

The Weston patches are ready - they have been for some time now - and
will be merged as soon as this series is.

It would've been nice if we could have had an MTK implementation to go
with AMD and VKMS, but that's still being worked on. I'd expect to see
that and another implementation early next year though, plus whatever
happens with Intel's.

Cheers,
Daniel
