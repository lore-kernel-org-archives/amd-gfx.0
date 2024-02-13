Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AA2C48BC4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 09:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCAE10E6CA;
	Wed, 14 Feb 2024 09:19:15 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8890710E683;
 Tue, 13 Feb 2024 16:19:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 00D92CE16C6;
 Tue, 13 Feb 2024 16:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13877C433C7;
 Tue, 13 Feb 2024 16:19:32 +0000 (UTC)
Date: Tue, 13 Feb 2024 11:20:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Gustavo Padovan
 <gustavo@padovan.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, "Alex Deucher"
 <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 6/6] drm: add drm_mode_atomic_commit event
Message-ID: <20240213112017.726016f0@gandalf.local.home>
In-Reply-To: <20240213155112.156537-7-pierre-eric.pelloux-prayer@amd.com>
References: <20240117184329.479554-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-7-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Feb 2024 09:19:14 +0000
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

On Tue, 13 Feb 2024 16:50:31 +0100
Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com> wrote:

> @@ -1503,6 +1504,24 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  		drm_mode_object_put(obj);
>  	}
>  
> +	if (trace_drm_mode_atomic_commit_enabled()) {
> +		struct drm_crtc_state *crtc_state;
> +		struct drm_crtc *crtc;
> +		int *crtcs;
> +		int i, num_crtcs;
> +
> +		crtcs = kcalloc(dev->mode_config.num_crtc, sizeof(int),
> +				GFP_KERNEL);

If the above allocation fails, this will cause a NULL kernel dereference.

-- Steve

> +
> +		num_crtcs = 0;
> +		for_each_new_crtc_in_state(state, crtc, crtc_state, i)
> +			crtcs[num_crtcs++] = drm_crtc_index(crtc);
> +
> +		trace_drm_mode_atomic_commit(file_priv, crtcs, num_crtcs, arg->flags);
> +
> +		kfree(crtcs);
> +	}
> +
>  	ret = prepare_signaling(dev, state, arg, file_priv, &fence_state,
>  				&num_fences);
>  	if (ret)
