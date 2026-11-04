Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C4606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJcqz8A0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16E910EE0C;
	Wed,  4 Nov 2026 14:32:45 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9020510EE3C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 14:32:39 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5eaf36b5c95so22018e0c.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 06:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793802758; cv=none;
 d=google.com; s=arc-20260327;
 b=Ask3sWqusb/phFtQDFpPcnN3LVLjkXXhrMkGD+DVUzk6TTeneQPALf0kr63j8AR/x0
 GHI5BCegb87Xs6pdNC2qYMWlFAqYBXkh2UB+H7uACsNZTGSagU3Cd3b/RTbXhZEYxw20
 bY+a31EwF1bDGgDQeLBHy20OD/U7PKmrd8SxBfH+o51IGjBvpTIrCfZjDi/2VXyADOMZ
 0AUPnk5xV5rawaQt7XvIkQaDnEpvfE56voM1WNs8tZkl8zcs9h672p5cwFDIfZtutvSM
 oLDydaGjKogYVOSdpr+Dw4j2z/PWGSda9Ey1KJHjSDy+VmOTrM6r+BBPHCk+XxbpGhiW
 H/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 fh=Oi9nfaOLTV74BkRQDkkMSy3syYhdJTOMkxVEBZwmwyY=;
 b=CTYMf43YOZ6usa94AivHSVNp5ss6RjlxX+QySN/NUKBXJbuNej/S1KO5nfPqk+hXcv
 IWhLN1NS9822QCDRb0e5t61fsXs3kiWbsY9tit/8nFPsJHKR1ngqOkTm04iNIoHogusZ
 +zIHTffZX5U3MKA2Z3fIB2yrCVwC9kXS9VT4mr/XVbpRfux0fpV7AzDBosfJkTHmljHM
 ZDGLUm0CpwDdGirGSwjNT8yvaMU3PO08mFsuEDttrRhJ8JKnB0EQM2ddINZb90mhyqk2
 19iXETmAVWhLWGiSKCzCA6zbPqOavvMmD8aL2mSsnt4m/PexGK8YBGgpfRvJ0L2rfFs4
 EqjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793802758; x=1794407558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 b=BJcqz8A0a8s0Kjkkv0YhIDRf8cY1n+k/EMCSMEgOq9H9YQiK4b+bW3FA17wzJcONpX
 iQs13gEPNFVwcsHDsgBJsBaiD+UsCk1+3IvpvU74ypHjO8Lzd7xbU7ZdttQjL+Sh9g61
 glhK03sTesYmpkfY0dNKfGmoB6E6CVEWzUw9OOZIcQc3G2BdRA011ZS1IXky1y6M+7kI
 9pZUEKteTnr6lm4QJWv+kQFiSKOzPgvjgJ3oPIUe4UV29M3mSpARMemByCFXTa1BSTed
 Ovf+Opml+/6HCnsmH9AYnPK2p5PuGQz1v4xSdb9wJyyAPvDcvuE8ba8XKjCtcPsTbOmv
 uHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802758; x=1794407558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rBCJhchK0NF+Gj+SXhOsU8rPb9pW7B64q/c4ONRSGCE=;
 b=PD0DRZrYYP0aUvHf2WdoBn4ICd4mByosRTd+NQNjXbuexRUDgRXbCEchjzr2w0QjqJ
 WKN3ofLx29BnTuAqifjx065GD9RfEMusEdrNCIlt4P9qD33zRx0HGMT5I6AeIVwc8iA3
 jp2AdER3M4i275LEoqggDH5Nl127NzaMl7bww5ZTI9weF1UY6ehb59X7bQi+iJrn4cjb
 Udk2fn8sjMc9oMPxrlK85EzIDMMKDBWLXi3Ir7ha+UibThCjFPFkypsVymrfpRKuYBNR
 nwdfz41cNSfFtzO+8X/8TLsxeYLDzzwJ5LqGkijn1Ab2iYmQZsOD7xzwOHJE/9ZXpBHr
 dKSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMP7HthZeo6UnGr07r5bxPydC/atw/HR2ivPv8O0UtwUcY+HcOAFM02/+f+ATgBYQyqKrj2QnM@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/hwxQPxnDBl5Wm/ic88DrYm5zvsXe4rg7DJxmb6hY6d1C8+g8W
 3qXPKutcgqLLR8kCmC2ttU43rdoshmI/AptakSD3Na8MpF8/5VCpCHPFJMYvPSJyWjxZwCToqMF
 nXKwCMocbNU9I5xiCjgoRHFyWmdSHG9E=
X-Gm-Gg: AYBFou20JMeVnr9lD7Iro09SCq0kCus7WXplFJCT9Ro4x1utJIWaLo1F4Zzis1HuZUG
 TYy6/nylTJpz1+gxBXk80nPSFQm3zQbQcx0mZF3saLS9W1zZbpe3sPon7QKExU85PUrVeFlXfmB
 21QgnNkoJfSLXkvX4iIZBmFyGTveVykzeaxP0mTJZ5Bs3NkZLherqx5OqZuV4omfl3fjS0Cw4CU
 BpTWi5Mq4/Q9BoVMXulJtRUPayBzwBSuKIuGwk4wtlz5l7dmZcA7GPU6Ewek+2rNZGAWFo47AtA
 Ti7IgEpudl9gFDAdt3FydBAMdmRtw38AX7twB5/dhdSa2Q32ATFS5EUBqpmL+tX0mTYsVjF8Ocj
 OFOqfCn3I0S9vCujgqICxhRgxb4wSB5pZPRLLyJRH3PGWH1vTdiRXXOJUH13H62nERRc46+6is4
 L0WgN9Q+/ZCYoGXGBg3cdFjAo=
X-Received: by 2002:a05:6122:11ae:b0:5ea:af6f:16e7 with SMTP id
 71dfb90a1353d-5ec689382bcmr7635405e0c.4.1793802758252; Wed, 04 Nov 2026
 06:32:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104024754.166260-1-abo@medichon.fr>
 <0566b969-cfee-444c-8a94-5fbb42859e07@amd.com>
In-Reply-To: <0566b969-cfee-444c-8a94-5fbb42859e07@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Nov 2026 09:32:25 -0500
X-Gm-Features: AclHuK9ldrrG9D5KOFB1JvP4Sf7ocCzQzX9d16vWTCBxdyyw6VsOZNy538gY8us
Message-ID: <CADnq5_PvQ+NPJ+nzXD34FJuLpa+rP=qA4ZOdns3QqBaJiHpzRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add missing parameter documentation in
 amdgpu_ttm_map_buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnaud Bonnet <abo@medichon.fr>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Wed, Nov 4, 2026 at 4:41=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/4/26 03:47, Arnaud Bonnet wrote:
> > [Sie erhalten nicht h=C3=A4ufig E-Mails von abo@medichon.fr. Weitere In=
formationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnA=
boutSenderIdentification ]
> >
> > Commit 48c4aaeef621 ("drm/amdgpu/ttm: Make buffer copy source readonly"=
)
> > introduces a new parameter @readonly in function amdgpu_ttm_map_buffer(=
)
> > but doesn't update the documentation, leading to the following warning:
> >
> >   Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:209 function
> >   parameter 'readonly' not described in 'amdgpu_ttm_map_buffer'
> >
> > Add the missing description to the kernel doc comments for the readonly
> > parameter.
> >
> > Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 0f86777250fc..d3a875a32af1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -195,6 +195,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, s=
truct amdgpu_ttm_buffer_entit
> >   * @addr: resulting address inside the MC address space
> >   * @vm_needs_flush: out, set true if a GART window was programmed (VMI=
D 0 flush
> >   *                 needed) or false for a direct address
> > + * @readonly: true if the mapping should be created with non-writeable=
 pages
> >   *
> >   * Setup one of the GART windows to access a specific piece of memory =
or return
> >   * the physical address for local memory.
> > --
> > 2.53.0
> >
>
