Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1310F506D2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D3110E53F;
	Mon, 16 Mar 2026 13:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cJI3Zy6F";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837A710E39D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:07:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so52385425e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773655658; x=1774260458; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kt/r5vRyIZH312eJIeu8mCgVoYlzanPWeEfJFGYYMF4=;
 b=cJI3Zy6F170wzPH4l8yBvdqKfm3LOUlNRdO9cVlGFPUaFzjMIoS7d85ZlnAyp6Arqc
 HNMeGJm1DbdDjtN3J2jZBJSqMlNq0D4ckYWrBNCfhcNYxSl2Sv9EvOvsQn/6+vrKWuK1
 VhHTjwvxq7gMils2mx8g2h2Z05dwySuOZ+TkfkRHfay1wLSUI+No/v1aCxbDdKhgcfmd
 d7cIxTF38dcqffe3VxAlvnIcXo5A5T8zW3yeHubA1ybmkq54cpFA06F6Dli/cqdPiW8e
 P7MVTlnD69bLRWG7miILqTm4denqU9ybDfuJgIrZS4fGRfwfXXI6H0jpENxkCvxHvDZ4
 Xcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655658; x=1774260458;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kt/r5vRyIZH312eJIeu8mCgVoYlzanPWeEfJFGYYMF4=;
 b=eHewE07qDVGEVqqGuAAqoMK4IAXLJsIyD5ke0n/XXGzVfcMKBuJtAvlrzABGOJ54ZT
 T/FaDaZAwogdVY7/vDawtHWOsESEA3NSgU2IJT6Jdfixgy8frfDTDKY/zl5Cv/bLQ7s8
 8D2FVdsQkGugsD+ltcKrB2YT5+iQegEWjHzmGCIpxfqqCvN9F/HmOHoGhyLhBPM+Oz81
 EUi/2seLtIkhxLzdDvrXfS2KzpWQ/sLKA6fksqDCnX6Ff6Nfj7ZSOKPc4x8N7oi0MjE3
 81/FD2F8IMFY89ONKq/fS5gwg1wWDsJxAf2MoPTHPlHaiz0YwUFkD/QVYQANlGqNIhAl
 pliw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHA0ozIASsjLzuexkGCay14nKL00blx6XsU+lk+PZGUPjVFMnBqBdtcMIFq3/wITH8EcQgpzWn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEnMFqp4I4TkXJGEMaKfStk/FWfW49D2c2LNuItkrWZ41s1rxC
 ujuHOGIeaN8L7NJWxAmfmn+QT96hPeihX+MFpR6l1W4mPWnSGFPurjM1m5iPY4QQlbz1NRk99tA
 48RgV
X-Gm-Gg: ATEYQzyIGRWxdJfKyQCmS54JzXXoCu0ATSG/nIcn/Fw9MaNOow+BFu/scVa0QTYYFL6
 os/VfcsUcOcdm2XXBIhA24mDaxV53y+hjNHwkuQQc5LoiuhAFBrX2i0M/EYhtva+eSOOtigL9Yh
 sLb4uT/J4Rc8Ok2fpG1EjSRf1FDmDGET8rtMGGKYa1EEFbQ8oOJKtFYFjIt7K6ipH40x+X1f44R
 /B3VukgRzKw+y5su/RLIkq8LENcmqugXu57s5lgbncHcFfbc5OmxeG/xHmHkW2Jwf7qNUfANZlx
 POWOqweG9ZTSG4GHKlgAiJzfsVudNAYFssTseWpvk+ts1L8j+TB4G7N5A1I9sMIsNVoht94mo6p
 og/ejmLQ+BGSsLaeDRpyH5H/hrb3pzlRY/Bg24yKbTx1OmJRwzshNvOKqoVanxtyC9G3Cks/kxq
 OQjuAucFgiMiZY4FA86h1f+y1xijA4
X-Received: by 2002:a05:600c:a46:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-485566d6ff2mr215794265e9.11.1773655657892; 
 Mon, 16 Mar 2026 03:07:37 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b41ff92a6sm13592203f8f.11.2026.03.16.03.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:07:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 13:07:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Add explicit NULL check for bo in
 amdgpu_vm_bo_update()
Message-ID: <abfWZnDMzYFWVjTr@stanley.mountain>
References: <20260312141315.1851106-1-srinivasan.shanmugam@amd.com>
 <2bdb769a-7814-480c-932c-c0e44c58c2bd@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bdb769a-7814-480c-932c-c0e44c58c2bd@igalia.com>
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:20 +0000
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

On Thu, Mar 12, 2026 at 02:39:34PM +0000, Tvrtko Ursulin wrote:
> 
> On 12/03/2026 14:13, Srinivasan Shanmugam wrote:
> > amdgpu_vm_bo_update() allows bo_va->base.bo to be NULL in some paths,
> > such as PRT-only updates.
> > 
> > Although amdgpu_vm_is_bo_always_valid() already returns false for a NULL
> > BO, Smatch still warns that bo may be NULL before it is dereferenced
> > later in the block.
> > 
> > Add an explicit `bo &&` check before calling
> > amdgpu_vm_is_bo_always_valid() to make the non-NULL condition clear and
> > fixes the below smatch error
> > 
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353 amdgpu_vm_bo_update() error: we previously assumed 'bo' could be null (see line 1292)
> > 
> > Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
> > Cc: Dan Carpenter <dan.carpenter@linaro.org>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index b89013a6aa0b..0d26346178d4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1349,7 +1349,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
> >   	 * the evicted list so that it gets validated again on the
> >   	 * next command submission.
> >   	 */
> > -	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> > +	if (bo && amdgpu_vm_is_bo_always_valid(vm, bo)) {
> 
> That would be unfortunate:
> 
> bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo
> *bo)
> {
> 	return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
> }
> 
> Maybe Dan can make smatch smarter? :) Because I don't think papering
> randomly at a single call site is great. It is even in the same compilation
> unit. Hmm does the order matter to smatch? Should we maybe move
> amdgpu_vm_is_bo_always_valid() to be earlier in the file?

I'm glad moving the function earlier fixed it.  :)  The function ends
up getting inlined.  This warning should only show up if you don't have
the cross function database built.

https://staticthinking.wordpress.com/2023/05/02/the-cross-function-db/

regards,
dan carpenter


