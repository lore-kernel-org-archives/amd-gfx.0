Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C29C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 18:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8967210E028;
	Fri, 16 Feb 2024 18:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="jSBqkTdb";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F08610E028
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 18:02:52 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a3d2422f1b5so66925966b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1708106571; x=1708711371; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kWOeJUy90KVtiP9YXPoGesfXE8zdwI8eJnlf9+BtZ90=;
 b=jSBqkTdbiNLKqjWS5rhefpqQQpTwk/U8Evxn0q10KODn1R1Hwqjv9LiOSU7OZ91NMT
 7NrOPxCe6DGdUtt16pobvFN1VciIbIcPCCYGy+/lgIL/qS1tPB+nf+YKhPoh6zM306ko
 nq0GTegUIf27jpuoE+RxcCU3rmIwwirtPFlRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708106571; x=1708711371;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWOeJUy90KVtiP9YXPoGesfXE8zdwI8eJnlf9+BtZ90=;
 b=gMr38IpWVdmmZOpAYy305tXAMPp7xLF6lMpfMlcM0FqbUDVqlBDYw2FFHsBHDMVDky
 7FZ16K+vjczQiO6ouYsXiji4Ff1xX3i60U5rDO/CCg/G7xLvy5LNqYoRRj9KcsIiACGl
 +bqo9vDd7URYdOX+6Dav94PmC+qgoKE7bylLkfOCT0pe2Mp2CHK1D3KPsiwZdWrClSlD
 n8rVqodaE6ClxUGmH84B9dmXNaG2J5hQN/QicJ2ohYlg9psu4C8Ok6h99yC3VsJuapcF
 ML57JbimvUkw++QsEWKzgbJ8OY3004/bwFo1UI2sOMbxMTE8L1ghaojGD7DFYQKj6wCH
 uXJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF22YdjRIpSKO5h/EYpcn0NGp09BsY7323eL0jOZskF7TwS/Qh2EeiKE3QwzosZl3s/Hbzg3jbwuo8KmL2CrMR+U7NeJHBUw9rYdJa2A==
X-Gm-Message-State: AOJu0Ywn1AAOlVj+i6HrdVi/17NdiFL2HlOCENNaWujoX/lC1HhFI1ep
 0KZNMPqMBV+3pnCSLSgaslkh/0uOvOvFl5sX8QXy8bN9G6Jh823i2KzEVLqnPWI=
X-Google-Smtp-Source: AGHT+IHSmOAy3oa2La7yssKepZFC0ok9e49lHpBPZtwML9qSR/4sCtqzMn/r6OGKsb48uF7ZvrRmBQ==
X-Received: by 2002:a17:907:1604:b0:a38:526e:78ed with SMTP id
 cw4-20020a170907160400b00a38526e78edmr4205804ejd.7.1708106570987; 
 Fri, 16 Feb 2024 10:02:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 lc5-20020a170906f90500b00a3d6ff5f087sm191930ejb.55.2024.02.16.10.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 10:02:50 -0800 (PST)
Date: Fri, 16 Feb 2024 19:02:48 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] tracing, dma-buf: add a trace_dma_fence_sync_to
 event
Message-ID: <Zc-jSH4BVrBrkj5d@phenom.ffwll.local>
References: <20240117184329.479554-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-2-pierre-eric.pelloux-prayer@amd.com>
 <Zc-OJAXlApzcOfYQ@phenom.ffwll.local>
 <b719d7b9-8a9a-42ad-b35b-145d6a835964@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b719d7b9-8a9a-42ad-b35b-145d6a835964@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 
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

On Fri, Feb 16, 2024 at 05:51:59PM +0100, Christian König wrote:
> Am 16.02.24 um 17:32 schrieb Daniel Vetter:
> > On Tue, Feb 13, 2024 at 04:50:26PM +0100, Pierre-Eric Pelloux-Prayer wrote:
> > > This new event can be used to trace where a given dma_fence is added
> > > as a dependency of some other work.
> > How?
> > 
> > What I'd expected here is that you add a dependency chain from one fence
> > to another, but this only has one fence.
> 
> That's what I though initially as well, but at the point we add the
> dependency fences to the scheduler job we don't have the scheduler fence
> initialized yet.
> 
> We could change this so that we only trace all the fences after we have
> initialized the scheduler fence, but then we loose the information where the
> dependency comes from.

Hm right, I thought we'd dump the hashed pointe value into the fence
events too, then you could make the connection. But we don't, so this is a
bit annoying ...

And walking the entire scheduler dependency chain at trace_dma_fence_emit
time (or something similar) maybe?
-Sima

> > How do you figure out what's the
> > next dma_fence that will stall on this dependency?
> 
> I'm not fully sure on that either. Pierre?
> 
> Christian.
> 
> 
> >   Like in the gpu
> > scheduler we do know what will be the fence that userspace gets back, so
> > we can make that connection. And same for the atomic code (although you
> > don't wire that up at all).
> > 
> > I'm very confused on how this works and rather worried it's a brittle
> > amdgpu-only solution ...
> > -Sima
> > 
> > > I plan to use it in amdgpu.
> > > 
> > > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> > > ---
> > >   drivers/dma-buf/dma-fence.c      |  1 +
> > >   include/trace/events/dma_fence.h | 34 ++++++++++++++++++++++++++++++++
> > >   2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > > index e0fd99e61a2d..671a499a5ccd 100644
> > > --- a/drivers/dma-buf/dma-fence.c
> > > +++ b/drivers/dma-buf/dma-fence.c
> > > @@ -23,6 +23,7 @@
> > >   EXPORT_TRACEPOINT_SYMBOL(dma_fence_emit);
> > >   EXPORT_TRACEPOINT_SYMBOL(dma_fence_enable_signal);
> > >   EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
> > > +EXPORT_TRACEPOINT_SYMBOL(dma_fence_sync_to);
> > >   static DEFINE_SPINLOCK(dma_fence_stub_lock);
> > >   static struct dma_fence dma_fence_stub;
> > > diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
> > > index 3963e79ca7b4..9b3875f7aa79 100644
> > > --- a/include/trace/events/dma_fence.h
> > > +++ b/include/trace/events/dma_fence.h
> > > @@ -83,6 +83,40 @@ DEFINE_EVENT(dma_fence, dma_fence_wait_end,
> > >   	TP_ARGS(fence)
> > >   );
> > > +DECLARE_EVENT_CLASS(dma_fence_from,
> > > +
> > > +	TP_PROTO(struct dma_fence *fence, const char *reason),
> > > +
> > > +	TP_ARGS(fence, reason),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__string(driver, fence->ops->get_driver_name(fence))
> > > +		__string(timeline, fence->ops->get_timeline_name(fence))
> > > +		__field(unsigned int, context)
> > > +		__field(unsigned int, seqno)
> > > +		__string(reason, reason)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__assign_str(driver, fence->ops->get_driver_name(fence));
> > > +		__assign_str(timeline, fence->ops->get_timeline_name(fence));
> > > +		__entry->context = fence->context;
> > > +		__entry->seqno = fence->seqno;
> > > +		__assign_str(reason, reason);
> > > +	),
> > > +
> > > +	TP_printk("driver=%s timeline=%s context=%u seqno=%u reason=%s",
> > > +		  __get_str(driver), __get_str(timeline), __entry->context,
> > > +		  __entry->seqno, __get_str(reason))
> > > +);
> > > +
> > > +DEFINE_EVENT(dma_fence_from, dma_fence_sync_to,
> > > +
> > > +	TP_PROTO(struct dma_fence *fence, const char *reason),
> > > +
> > > +	TP_ARGS(fence, reason)
> > > +);
> > > +
> > >   #endif /*  _TRACE_DMA_FENCE_H */
> > >   /* This part must be outside protection */
> > > -- 
> > > 2.40.1
> > > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
