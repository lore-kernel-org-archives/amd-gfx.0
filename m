Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B67606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7yjt7Rd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F2111259D;
	Thu, 29 Oct 2026 22:09:05 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0B611259C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 22:08:59 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-33bb5afa736so24089eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311738; cv=none;
 d=google.com; s=arc-20260327;
 b=Bevw68799mqMQ51GlPcPsZrC9QNsVhQpV89TV7ifdOKUVD4IKN9OyLPzzGd/Azoe3m
 sdS8vLDPDyOt9eiGZKdc7hZAM6C+1TkeV/pP3NCy2106Ng2zPEEBD6pT3GRPkHqvIt1f
 OD2nt1nyEghshhRONKV4THxruvgnbHUoYfqs4SxRAhJrkjgtiPEgx/UmgTubMDH29y11
 mJoRAb8V+VKePaCPEMgzn+RTlL2l1Wy2/nU7yV95m5iD9sq1Z4q+JUZw9PSgmD6fFVwE
 g/02a3kR/MdvezNwafLybVJSbDynYcq90qsl02DSRNgVbWOH+oUrsYedaRLsi1ZBB+5v
 x4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 fh=yZvDkQ4FJ/k8yAxRbFVa0uBpQpci41LdZBnoC0m4AXQ=;
 b=roL3B6vg/JWEmzXtj2guV0OisZQd2H1ytOQbJRJ93Klvpw1DvE53y89qELFi2kORFF
 4k/jow/lKU2mfm7W2VMXHKBbEXsh63nuvYU9VynLdnqFgDxfsOB1PdTykmhGS1SBH6Ap
 mE8RvqtmRDsl29U6FOiB8kcPZc1QWm1TqWwnylhGZ8r5ZeCJdiXiCdMciZC1+oK5HTsC
 fRPgkj40RycnQXQOL3QD0yET/Mz1XnRsfYd5Z6aLJnZO3I41tZ+3D4dOtksN5F6b82e1
 9baGXyIrFyg50pMCTqEG9pF2QhAAHxoUxZNKj/JWLQu2AliFX7uK8KS/0XZBfsd/QXF2
 Jdzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311738; x=1793916538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 b=F7yjt7RdF8TEPaHKN7GtYjAwHq0Xu06C4qqoTEDpCWxwIj0T2nNBF6VSixOi0OiSrN
 gWF15oUlmKpIdfDkyJA+uDo3PSLEYpb4DXUYK5qinU4b5vOIPaMm90j6o50Tm2vlpSaR
 WvFoGRtQLRVkqQaMFH50G8uM7hAi57QOg2c4OTz56z3xlrU0k1xd+uAtPYi+t3Ou3QoL
 cxi39OG/xiY6KywVkPED1+uyr8a7iLZG6svZHUjvc2ROGvM3Fa0Uc+wSSUhVr66rh71k
 dudAwfuORG18rLpfly0BPC9SagAvCePBgqfGgnrrL3duoDTJbUUpjmCT+6qYjXCpu4/j
 IrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311738; x=1793916538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNBRkMvcPM5q+NH92pjwUamOJbPLuAm/rYF5XAa5e1c=;
 b=AFXs9XSB6vSxnViB9GV22rMH/UBe6oZ0sbRPrJkGC6PK8juUEhp64GO6erw/Cdao5Q
 xvbtfYA7E3LFpo0jLJMJ3tIT1Lzqk2TEM69vmabxJ+NybcK4iMKcSggP8Qdq7W8CYdl5
 Skg0BYGFqXL0teBV3lCwFpw9FMJAIPPNxC9U3AVr9J0giYVZTtRd9xxmyOODyRx2eDGu
 k2r90bZowWfAGynorS5fqv5bILargq6+OVZ1Uh9W5JIIpf86Beww52/zViRKPQRsAbNW
 AG1zutrbCOEZjElR9JIJIjF5vljE7IZmBjpGk07eVWaeqDbRAZ5+45X1gGseboIvRiRC
 /7tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1HB7bh7FHFANxThV34vf02EUSYe6yhc3M/aldY2rqdgWslBWTCBvIgmaS4xWPW3terN1BZG9P@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2mHbBLlmiP7787LOWqWSKpH1beYLK7E00oILQJ6/wxUk6aMTj
 BDpSZlhDJK5ugmAlrqxGxPz/o0ryCzpznA0R7l/bAbqUdSH+qNtMU2qUKOhnEsrkabzkMNa4rct
 fIYtLhpYfnIH5tyq9A0WkVsy4uY0Xxrw=
X-Gm-Gg: AYBFou33QAhMiPk/NPmqCYxnUY2I6BXNDkeuInPf5pbPCRcUZFPfk01bmZ6Z4LV+huh
 f0PdAQ5bOVju2dLrAtzumDe73g2rQ7qaBoiwVSxPgEskwim7Qz596+5poe5QNB+0r8US2tCWu6r
 Uz/dbmcpv8fZQHST6FkNao6zbRSWEnSdhWTnvlW/kvZNYz8REdMsbEKa8b23BeknwdMeL8/+w1j
 8iOM/sN1dzPewHeY8+TcFvwWd8oIbHvRGmzNknvSIdEl41isu4fvvqK3YLDfzhkuuyMZTtK8J6s
 rWYZuRqbayQUWXk43PjrJDKCm8qeMTWb7EUO77v1IE9yb3hgTRjl7HJiOvcXCxISN54arwikaLt
 +N1Fb12mf9w3v3m53ll38BNJbuPkMOS6xSJyhPxpG3gg2OkAIhBrPQIITc1FTcxKpnDY66DE7cO
 xcRqFEvgNphV/Wpc37o9jS4vM=
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr780931c88.2.1793311738368; Thu, 29 Oct 2026
 15:08:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133727.748652-2-phasta@kernel.org>
 <54e6cd9f-57ca-402f-93b6-27fe2b15b29c@amd.com>
In-Reply-To: <54e6cd9f-57ca-402f-93b6-27fe2b15b29c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:08:46 -0400
X-Gm-Features: AclHuK-38z0ojG634j8HTvYSqjvHDIGJv5-1HW3Xm4xmKYyn6vnp08A2upfv47I
Message-ID: <CADnq5_M6s1TFgHgfiPeLS0bQ0iq+iJWzPKPbacyPvBGibUs_HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: amdgpu_fence: remove ops->release()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Jesse Zhang <jesse.zhang@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Kexin Sun <kexinsun@smail.nju.edu.cn>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  thanks!

On Tue, Oct 27, 2026 at 4:16=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/27/26 14:37, Philipp Stanner wrote:
> > amdgpu's fence implements the deprecated fence_ops->release() callback
> > which prevents the driver from ever unloading robustly.
> >
> > amdgpu's implementation merely uses a call_rcu() that performs a kfree(=
)
> > on the fence - this functionality is already centrally implemented by
> > the dma_fence backend.
> >
> > The dma_fence backend invokes a kfree_rcu() on the dma_fence, which is
> > fine since this is always the first member of a struct amdgpu_fence.
> > Thus, amdgpu's implementation is redundant.
> >
> > Remove fence_ops->release().
> >
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>
> I have exactly the same patch in my pipeline as well.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > Just saw that this should be unnecessary? Don't have a setup for amdgpu
> > testing right now, so please take a close look, just compile-tested.
> >
> > P.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 -----------------------
> >  1 file changed, 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 3043ad041bb4..3f8b2571d74a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -892,39 +892,10 @@ static bool amdgpu_fence_enable_signaling(struct =
dma_fence *f)
> >       return true;
> >  }
> >
> > -/**
> > - * amdgpu_fence_free - free up the fence memory
> > - *
> > - * @rcu: RCU callback head
> > - *
> > - * Free up the fence memory after the RCU grace period.
> > - */
> > -static void amdgpu_fence_free(struct rcu_head *rcu)
> > -{
> > -     struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> > -
> > -     /* free fence_slab if it's separated fence*/
> > -     kfree(to_amdgpu_fence(f));
> > -}
> > -
> > -/**
> > - * amdgpu_fence_release - callback that fence can be freed
> > - *
> > - * @f: fence
> > - *
> > - * This function is called when the reference count becomes zero.
> > - * It just RCU schedules freeing up the fence.
> > - */
> > -static void amdgpu_fence_release(struct dma_fence *f)
> > -{
> > -     call_rcu(&f->rcu, amdgpu_fence_free);
> > -}
> > -
> >  static const struct dma_fence_ops amdgpu_fence_ops =3D {
> >       .get_driver_name =3D amdgpu_fence_get_driver_name,
> >       .get_timeline_name =3D amdgpu_fence_get_timeline_name,
> >       .enable_signaling =3D amdgpu_fence_enable_signaling,
> > -     .release =3D amdgpu_fence_release,
> >  };
> >
> >  /*
> >
> > base-commit: 731ba09867520c047c7de53f92e384808e0b638e
>
