Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4BCC5475B
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Feb 2024 11:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECAB10E045;
	Sun, 18 Feb 2024 11:25:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDC710EC3B;
 Fri, 16 Feb 2024 16:42:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7C45061FA4;
 Fri, 16 Feb 2024 16:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9ACC433C7;
 Fri, 16 Feb 2024 16:42:36 +0000 (UTC)
Date: Fri, 16 Feb 2024 11:44:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Gustavo Padovan <gustavo@padovan.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 6/6] drm: add drm_mode_atomic_commit event
Message-ID: <20240216114412.1f181ffa@gandalf.local.home>
In-Reply-To: <Zc-PQ9Yx4fk4TK43@phenom.ffwll.local>
References: <20240117184329.479554-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-7-pierre-eric.pelloux-prayer@amd.com>
 <20240213112017.726016f0@gandalf.local.home>
 <Zc-PQ9Yx4fk4TK43@phenom.ffwll.local>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 18 Feb 2024 11:25:04 +0000
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

On Fri, 16 Feb 2024 17:37:23 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> > > @@ -1503,6 +1504,24 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
> > >  		drm_mode_object_put(obj);
> > >  	}
> > >  
> > > +	if (trace_drm_mode_atomic_commit_enabled()) {
> > > +		struct drm_crtc_state *crtc_state;
> > > +		struct drm_crtc *crtc;
> > > +		int *crtcs;
> > > +		int i, num_crtcs;
> > > +
> > > +		crtcs = kcalloc(dev->mode_config.num_crtc, sizeof(int),
> > > +				GFP_KERNEL);  
> > 
> > If the above allocation fails, this will cause a NULL kernel dereference.  
> 
> Yeah can't we somehow iterate directly into the trace subsystem? If
> nothing else works I guess just a per-crtc event should do.

You mean like this?

  https://lore.kernel.org/all/20240216105934.7b81eae9@gandalf.local.home/

;-)

-- Steve
