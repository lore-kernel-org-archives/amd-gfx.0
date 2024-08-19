Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD8EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5214310E28E;
	Mon, 19 Aug 2024 14:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="GeO1Zn5B";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169FE10E28F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 14:20:23 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-428e09ee91eso4785045e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1724077221; x=1724682021; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=89fVC9GjbHEsaGrVRfjMkxxWWpHDL7IRXbh656IqMi4=;
 b=GeO1Zn5BJAx5SIH+F6ropkd54wvJTcHG567nQ8MdEwfrfL/pFwN4Z8JMrJg7JAKy0A
 i17wB6GFCHN4IbY7YhmtRcfmV3zfIhX6uVO/Ta9uuR2oDPDkduueWg1EYDgZkaGWzOnI
 Xq6T7ndewn/aG0B11nFCCZtmai+llKyLsFDRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724077221; x=1724682021;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89fVC9GjbHEsaGrVRfjMkxxWWpHDL7IRXbh656IqMi4=;
 b=XS1O86w78cjM6j+mxER0BcSkhwMw/aaKib0p/pw078arLaQR/D8hH4OtkJV4hYCfHT
 +Pmf/rscI2OM07i6QE/pNDG6hrhw3Y9BRRMAhhQe4txf/AGzVDhCoCJXBNZCmJJ5q2ue
 CuKsbMueg8z9fw9JFeG5CuIY8AVwYr6hwubFL8VDwTVCyntqElsNrN9YdhgeatY9s3kI
 prwB6TByJWFQZlip8rt8b4NDesNx9D5zfqHp9t2nxMOExqP4G6JwIOmgSeoDDpasEuLu
 366rAVFit05FaH36VljGuhi6uJrkK7HWnyLjuJSA4j/PDI5QX7Gnrs2ni9Qyscl93RWh
 S93g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/5m7CJMk4xDFAGnqBOmVb55Cx17jHBH5uNOH62XyHJEbUzd5+rNvKfPwzaw5vIcBSPQjtbU5ASffO61zVH4J+YqKcoknOELiN6kWw6A==
X-Gm-Message-State: AOJu0Ywa0lCeO6iVDfAxY5FZgYdKGrzsMGrWXE+fNSMUHjT9fyWYd55M
 eRQ8mvYTylOWMbRA74WWliW2MfUHmerCPUUB2gn8jAE8fuOtfW6fx++DY76NLXg=
X-Google-Smtp-Source: AGHT+IEZpd+iWzsV5jfXUTSP8jclTWP8wCsAQhAetrQe5fGBQatgefAo3vZ9yN/+fe/HkRBh/t/8tg==
X-Received: by 2002:a5d:47c4:0:b0:368:aa2:2b4f with SMTP id
 ffacd0b85a97d-3719431df4bmr3961878f8f.2.1724077221210; 
 Mon, 19 Aug 2024 07:20:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aacf9sm10665736f8f.102.2024.08.19.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:20:20 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:20:18 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Rob Clark <robdclark@gmail.com>, Tvrtko Ursulin <tursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Rob Clark <robdclark@chromium.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] Documentation/gpu: Document the situation with
 unqualified drm-memory-
Message-ID: <ZsNUooau_t4Ax4Pe@phenom.ffwll.local>
References: <20240813135712.82611-1-tursulin@igalia.com>
 <20240813135712.82611-2-tursulin@igalia.com>
 <CAF6AEGvbZDg4K642HJtNAhj2f8Sv9DvfU+en52gi42=ssPiNnQ@mail.gmail.com>
 <51bb99fd-4f50-41b0-836d-69606c50321c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51bb99fd-4f50-41b0-836d-69606c50321c@igalia.com>
X-Operating-System: Linux phenom 6.9.12-amd64 
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

On Thu, Aug 15, 2024 at 09:37:31AM +0100, Tvrtko Ursulin wrote:
> 
> On 13/08/2024 19:47, Rob Clark wrote:
> > On Tue, Aug 13, 2024 at 6:57 AM Tvrtko Ursulin <tursulin@igalia.com> wrote:
> > > 
> > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > 
> > > Currently it is not well defined what is drm-memory- compared to other
> > > categories.
> > > 
> > > In practice the only driver which emits these keys is amdgpu and in them
> > > exposes the current resident buffer object memory (including shared).
> > > 
> > > To prevent any confusion, document that drm-memory- is deprecated and an
> > > alias for drm-resident-memory-.
> > > 
> > > While at it also clarify that the reserved sub-string 'memory' refers to
> > > the memory region component, and also clarify the intended semantics of
> > > other memory categories.
> > > 
> > > v2:
> > >   * Also mark drm-memory- as deprecated.
> > >   * Add some more text describing memory categories. (Alex)
> > > 
> > > v3:
> > >   * Semantics of the amdgpu drm-memory is actually as drm-resident.
> > > 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian König <christian.keonig@amd.com>
> > > Cc: Rob Clark <robdclark@chromium.org>
> > 
> > Reviewed-by: Rob Clark <robdclark@gmail.com>
> 
> Thanks!
> 
> So this one is stand alone and could be pushed to drm-misc-next.

fwiw on the series Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 2/2 can wait for AMD to give a verdict.

Imo best to wait a bit, unless Alex takes a while to get around to this.
-Sima

> 
> Regards,
> 
> Tvrtko
> 
> > 
> > > ---
> > >   Documentation/gpu/drm-usage-stats.rst | 25 ++++++++++++++++++++++---
> > >   1 file changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> > > index a80f95ca1b2f..ff964c707754 100644
> > > --- a/Documentation/gpu/drm-usage-stats.rst
> > > +++ b/Documentation/gpu/drm-usage-stats.rst
> > > @@ -144,7 +144,9 @@ Memory
> > > 
> > >   Each possible memory type which can be used to store buffer objects by the
> > >   GPU in question shall be given a stable and unique name to be returned as the
> > > -string here.  The name "memory" is reserved to refer to normal system memory.
> > > +string here.
> > > +
> > > +The region name "memory" is reserved to refer to normal system memory.
> > > 
> > >   Value shall reflect the amount of storage currently consumed by the buffer
> > >   objects belong to this client, in the respective memory region.
> > > @@ -152,6 +154,9 @@ objects belong to this client, in the respective memory region.
> > >   Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
> > >   indicating kibi- or mebi-bytes.
> > > 
> > > +This key is deprecated and is an alias for drm-resident-<region>. Only one of
> > > +the two should be present in the output.
> > > +
> > >   - drm-shared-<region>: <uint> [KiB|MiB]
> > > 
> > >   The total size of buffers that are shared with another file (e.g., have more
> > > @@ -159,20 +164,34 @@ than a single handle).
> > > 
> > >   - drm-total-<region>: <uint> [KiB|MiB]
> > > 
> > > -The total size of buffers that including shared and private memory.
> > > +The total size of all created buffers including shared and private memory. The
> > > +backing store for the buffers does not have to be currently instantiated to be
> > > +counted under this category.
> > > 
> > >   - drm-resident-<region>: <uint> [KiB|MiB]
> > > 
> > > -The total size of buffers that are resident in the specified region.
> > > +The total size of buffers that are resident (have their backing store present or
> > > +instantiated) in the specified region.
> > > +
> > > +This is an alias for drm-memory-<region> and only one of the two should be
> > > +present in the output.
> > > 
> > >   - drm-purgeable-<region>: <uint> [KiB|MiB]
> > > 
> > >   The total size of buffers that are purgeable.
> > > 
> > > +For example drivers which implement a form of 'madvise' like functionality can
> > > +here count buffers which have instantiated backing store, but have been marked
> > > +with an equivalent of MADV_DONTNEED.
> > > +
> > >   - drm-active-<region>: <uint> [KiB|MiB]
> > > 
> > >   The total size of buffers that are active on one or more engines.
> > > 
> > > +One practical example of this can be presence of unsignaled fences in an GEM
> > > +buffer reservation object. Therefore the active category is a subset of
> > > +resident.
> > > +
> > >   Implementation Details
> > >   ======================
> > > 
> > > --
> > > 2.44.0
> > > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
