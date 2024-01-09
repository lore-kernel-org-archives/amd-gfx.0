Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF32BC47073
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 22:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3F310E52E;
	Tue,  9 Jan 2024 22:32:32 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADE010E524
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 22:32:31 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-783310bd2d3so65027785a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1704839550; x=1705444350;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynsR4nnFEaZADpxDZxOiLIugSOI6RO8hBMHt22YNR9I=;
 b=celG7Btyc44T7hplGSCaQyHNuGCtEgipm73fSr5ULBkjVb8tAWFmsrq5uAjZoedcqv
 gFwgmL6Jps1SaZWKM6k2DIRtwuSneaNuTrXlMZGUwQu7SUkGQZ+2pCadLoNOaZhN/Tuj
 4hkjIhHTUWklYGdD6zbtA5+t0Fb3ZyO4LHOtsCXkyIgDZevu9n1+VWEn3ADMGizp5Fsv
 k5xh7/aE3UN2aTSzAbE/B1NCvGVO5IWJQGHIkQsqhR/JD5dnxup+5irGEFqxUKR/bZlJ
 ZZH6D1D3XNOtFvHrkfpsX9Kgrp+xXo8OruO0N/ogS50EK2ZIaQcicMkSQAP3sYalFOU+
 PuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704839550; x=1705444350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynsR4nnFEaZADpxDZxOiLIugSOI6RO8hBMHt22YNR9I=;
 b=ldVG72JoKxYUlvpE0K1nVZLjUhJN+9p+U3huq/LI6YfjDdjUdDqAyxuUGIPzcswzv/
 2Ir1h4A6ntau6W7nlNMcf5qJYg3MhXNVMwqbFYSaH11ikcNymTwzzEq3BVDW1xjy6KDh
 3bFVMEOhmKv2EGVty0JXrcYVq/KaS7ZGOngFnhMWy23y/MvUZct4hhvTPr+AaGNmTUD6
 m1NDUwZFTsfyxvy6ZJhDiQ6g+e0BBUFsAHIcOPtBGK5VQKYjl22hZVe0xsQZ5C9ad4wl
 fMNN4guGYPDSuQ4NQ1rMuoVukEgZfYD9iVxQQ8lCu0zq1J2xQMIaOof7U5dpsPVdL3hz
 fdaQ==
X-Gm-Message-State: AOJu0YxlVTU8bYBHpun1yk3Fz8rC5QKRbHig9UXm97HLS5N7va3bO11W
 +urEbpe/BO9U17UeGC3Rcj5YjZm2ja+Y6Z1pFYIeNCBhKlzl5w==
X-Google-Smtp-Source: AGHT+IEni1Ntup6ec+s61FZRN+0Cq4rkHJLzEGZRkocUASUKr2AOtWgASwxL8J0ZDkXeq6OC/kMNJ7/4oMga4t3FLWw=
X-Received: by 2002:a05:6214:48f:b0:680:857:1bd9 with SMTP id
 pt15-20020a056214048f00b0068008571bd9mr218069qvb.82.1704839550148; Tue, 09
 Jan 2024 14:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-3-andri@yngvason.is>
In-Reply-To: <20240109181104.1670304-3-andri@yngvason.is>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 9 Jan 2024 22:32:18 +0000
Message-ID: <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
To: Andri Yngvason <andri@yngvason.is>
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

Hi,

On Tue, 9 Jan 2024 at 18:12, Andri Yngvason <andri@yngvason.is> wrote:
> + * active color format:
> + *     This read-only property tells userspace the color format actually used
> + *     by the hardware display engine "on the cable" on a connector. The chosen
> + *     value depends on hardware capabilities, both display engine and
> + *     connected monitor. Drivers shall use
> + *     drm_connector_attach_active_color_format_property() to install this
> + *     property. Possible values are "not applicable", "rgb", "ycbcr444",
> + *     "ycbcr422", and "ycbcr420".

How does userspace determine what's happened without polling? Will it
only change after an `ALLOW_MODESET` commit, and be guaranteed to be
updated after the commit has completed and the event being sent?
Should it send a HOTPLUG event? Other?

Cheers,
Daniel
