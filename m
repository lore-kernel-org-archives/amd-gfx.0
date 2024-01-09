Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862F9C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 08:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E2810E106;
	Wed, 10 Jan 2024 08:01:55 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C5C10E540
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 23:22:14 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e7f0bf46a2so32061407b3.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1704842534; x=1705447334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebXuRtZ+jV+LA1Jw2fSqPglODs+5bJfr1352MU2Bcvc=;
 b=buezkh/sz/8UH/j9wzjq8v0q2nK84OMpbU13PfWDxchWFp79gdjJ8wrcWFUkSCpptR
 0GmyN8gMxX0H8cnmf8Nzrzx+Xtr8Q0WP86C+VybnL4u2S2LHDoFbfrMteGxMnFbtHvu+
 JdxgtyZ1pHq7hevYQYba2p3yqQ5H3BLCDGmhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704842534; x=1705447334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebXuRtZ+jV+LA1Jw2fSqPglODs+5bJfr1352MU2Bcvc=;
 b=B912QulnsaWQHTsSdn2QTZ2FOnAaoVhWMGL3GltJjjfYDTm/ZTzaYvRI1XnNKXQG5w
 DNSuuaxgdrD7wI54858gDHSMpE4L6bcU5zV2VR27jwgGQowHADLRCGMQGFdgqjZGuYu8
 a3tTq33ezkNh+RUayGEcpFMxWNjDxqhstsnkuEljewnmY7/EMWvQ2I2X50k6LaoN7jVE
 vapLorwHN6fs7bnWUCxfcT9J7HwNabL9Pc5BiiyiHZOzB7s931dEGggkcquVsNEVA7XA
 vkLcHoXHcvZu4Pqj/lvK7eEz4vgWpOA631/sq7LHZVI7AJi4rkMxIIlG1vc/dOuHbfeC
 iJag==
X-Gm-Message-State: AOJu0YzyvugM7hQ8/DG6JEVe3mTrqQhBEmhcHynsN0pvXELDFH70hrnY
 oKg60CWQE8Hl5CNjAGBf1WJ9GPlKU3crR6kk3q20gjZ52fLDTw==
X-Google-Smtp-Source: AGHT+IE8JDGH9ecjWUCMBMUouMOhuyEPG+0LSA+8kz0oPtVDBlLstNCfdQ5skELRjOnAGKeDWrBS6QE4QfdwIuqGTVo=
X-Received: by 2002:a81:4857:0:b0:5ee:1ca0:b7ef with SMTP id
 v84-20020a814857000000b005ee1ca0b7efmr258078ywa.42.1704842533828; Tue, 09 Jan
 2024 15:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
 <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
In-Reply-To: <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Tue, 9 Jan 2024 23:21:38 +0000
Message-ID: <CAFNQBQxM3dxdWRRY28jyXi4PZbgh7V+L7L6W1HQn40PwUGPNaA@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Daniel Stone <daniel@fooishbar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 10 Jan 2024 08:01:54 +0000
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
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, intel-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Daniel,

Please excuse my misconfigured email client. HTML was accidentally
enabled in my previous messages, so I'll re-send it for the benefit of
mailing lists.

=C3=BEri., 9. jan. 2024 kl. 22:32 skrifa=C3=B0i Daniel Stone <daniel@fooish=
bar.org>:
>
> On Tue, 9 Jan 2024 at 18:12, Andri Yngvason <andri@yngvason.is> wrote:
> > + * active color format:
> > + *     This read-only property tells userspace the color format actual=
ly used
> > + *     by the hardware display engine "on the cable" on a connector. T=
he chosen
> > + *     value depends on hardware capabilities, both display engine and
> > + *     connected monitor. Drivers shall use
> > + *     drm_connector_attach_active_color_format_property() to install =
this
> > + *     property. Possible values are "not applicable", "rgb", "ycbcr44=
4",
> > + *     "ycbcr422", and "ycbcr420".
>
> How does userspace determine what's happened without polling? Will it
> only change after an `ALLOW_MODESET` commit, and be guaranteed to be
> updated after the commit has completed and the event being sent?
> Should it send a HOTPLUG event? Other?

Userspace does not determine what's happened without polling. The
purpose of this property is not for programmatic verification that the
preferred property was applied. It is my understanding that it's
mostly intended for debugging purposes. It should only change as a
consequence of modesetting, although I didn't actually look into what
happens if you set the "preferred color format" outside of a modeset.

The way I've implemented things in sway, calling the
"preferred_signal_format" command triggers a modeset with the
"preferred color format" set and calling "get_outputs", immediately
queries the "actual color format" and displays it.

Regards,
Andri
