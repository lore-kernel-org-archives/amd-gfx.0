Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140A9CCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 00:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB0D10E13D;
	Wed, 15 Oct 2025 00:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgQz0AC+";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1660010E13D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 00:51:59 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-78e4056623fso80188526d6.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760489518; x=1761094318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBvarSClHqKHAsN6DYDAp5r3GXTmqULdVHqWbkOWp+I=;
 b=CgQz0AC+NozRsL2gz/jUFyDds1t2bfmJpwQ9sAXH5LOMIFP2q1eIp+TZZRUiYQA3YU
 eSCslSjRIIHysXBFOOO6alK8uq2pwUFSf9Njw8F6KiEFP1vav3l8e5K3FVGOFVOby6RK
 PSPMS9A03YFsZNId1F1frwTefeTNdxQM38X8xvM1fQUx6OwFIVTMS4ObrvB5YHhZiLm2
 z71T0XD5p2cU54uUjGj10W4TiP/fQrbF4dYIePbnmqbD4hm/BTnvHtcqfGwoSOELGwH1
 1RmqI1iJkepvulo6ZggaCpsFBuFomTPEdfKJB5W5Dqm2cl3+aRRH9nETBMBo1elEz+dr
 sTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760489518; x=1761094318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBvarSClHqKHAsN6DYDAp5r3GXTmqULdVHqWbkOWp+I=;
 b=QLjEmGx711OckTZMqUVtpBIQokE+zESU4S7jpjoFC9iDNs8YuzloQVZPIxgfBiotsz
 l6/lqjRaw5AaFOkowGrCJMhMFgCV1lQBlGAQtLNUeyHyr7gsUxvek2PG4YPnujtECEw9
 1A+eXiKL1ZDqZlIYNNtr2wwyqqQPQEgKFjp7U9VN1AnVnTKQLgnpmTRiwcQnQXQxjsPE
 47LxBYeFq1be4ryc6rOKAQ5eDuVyxsGxL4sDUFVEGilpBmD1cFjx++9sPesc8b88rBsD
 pdeBOp3onjAv6w2Xe5+a7M126hxLk6Fchku/YtFuZw3OwSsL2EPhaVD1JyY3EDK/Fgqw
 dpOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8IgR/+WE5AMvQUdNK0AhzhKkGNRvgLDbXu6vWqvCfaCsb5wEGr3GfZlxKMBYkgPsppj5qE5Sb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwslEpUj8lU3Ljb7lDA0PO3y+vtI9cCrcR2QW5B4Dex9JXEpGzG
 owSibf24fQeh7SAEWpx1X4qT5TlzvZ3Fy/GTt1It7qx5HZ1iEap0J6PgHvcrfw8UflQR71kg7qA
 ipyqK/IEFbKeVbYJaFdRb07GVFvoBP270Iw==
X-Gm-Gg: ASbGnctRoav0qRFzIZjE/9Pubo7vwwdD49u2bSAs3JNDGEiiIaLzf3xYSoC2XSwZmdB
 jiJBI7rFVvVh3jM4nyvN7UWgLdzxsAQ+ChxOu6EjtOwJ5XaqGv6P+oDRBqiYn9KaVD2Omc9w0/G
 AuVNNNbtU76baRxoUrLkQVhZkVajsvEvdSm+LMHRw9UBbd/qtpcldA8IMD44kW8Sd/YzgWXl44n
 UsZX8CQuptyKWTNa2LkUVEL+JIVLzWXwgQ=
X-Google-Smtp-Source: AGHT+IHzqBUoDH15dRZufHzMs4mxLsN1RycWNriUL3NGuph2SDuItJrU+4QQZOIlNYwWq94MB/Cka0WFPf8yqhLO4uw=
X-Received: by 2002:a05:6214:e8d:b0:879:d13a:109e with SMTP id
 6a1803df08f44-87b2ef70547mr393256936d6.58.1760489518004; Tue, 14 Oct 2025
 17:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251013143502.1655-1-christian.koenig@amd.com>
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 15 Oct 2025 10:51:46 +1000
X-Gm-Features: AS18NWB-XS67voA6eav_aJkSDh3djLnguC57tZG1zZwSoGbLm_nMzt4FPvSC-dk
Message-ID: <CAPM=9twu_jrR=XnHLtR9hRaRdcLWdDndvFxdNHOQMn4-Pehd+g@mail.gmail.com>
Subject: Re: Independence for dma_fences!
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch, 
 tursulin@ursulin.net, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 14 Oct 2025 at 01:11, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi everyone,
>
> dma_fences have ever lived under the tyranny dictated by the module
> lifetime of their issuer, leading to crashes should anybody still holding
> a reference to a dma_fence when the module of the issuer was unloaded.
>
> But those days are over! The patch set following this mail finally
> implements a way for issuers to release their dma_fence out of this
> slavery and outlive the module who originally created them.
>
> Previously various approaches have been discussed, including changing the
> locking semantics of the dma_fence callbacks (by me) as well as using the
> drm scheduler as intermediate layer (by Sima) to disconnect dma_fences
> from their actual users.
>
> Changing the locking semantics turned out to be much more trickier than
> originally thought because especially on older drivers (nouveau, radeon,
> but also i915) this locking semantics is actually needed for correct
> operation.
>
> Using the drm_scheduler as intermediate layer is still a good idea and
> should probably be implemented to make live simpler for some drivers, but
> doesn't work for all use cases. Especially TLB flush fences, preemption
> fences and userqueue fences don't go through the drm scheduler because it
> doesn't make sense for them.
>
> Tvrtko did some really nice prerequisite work by protecting the returned
> strings of the dma_fence_ops by RCU. This way dma_fence creators where
> able to just wait for an RCU grace period after fence signaling before
> they could be save to free those data structures.
>
> Now this patch set here goes a step further and protects the whole
> dma_fence_ops structure by RCU, so that after the fence signals the
> pointer to the dma_fence_ops is set to NULL when there is no wait nor
> release callback given. All functionality which use the dma_fence_ops
> reference are put inside an RCU critical section, except for the
> deprecated issuer specific wait and of course the optional release
> callback.
>
> Additional to the RCU changes the lock protecting the dma_fence state
> previously had to be allocated external. This set here now changes the
> functionality to make that external lock optional and allows dma_fences
> to use an inline lock and be self contained.
>
> The new approach is then applied to amdgpu allowing the module to be
> unloaded even when dma_fences issued by it are still around.

Can we add some Why? in here, like what use cases does this enable,

Some more explanation about what these hanging about fences will be
used in, like if the module is gone away, I have to assume this is for
already signalled fences, so someone is waiting and hasn't cleaned up
yet?

What problem does it solve wrt module unload, what scenario is
unloading amdgpu not possible in now, what scenario will it be able to
unload in after?

Thanks,

Dave.
