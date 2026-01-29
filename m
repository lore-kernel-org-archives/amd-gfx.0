Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610E9D358E8
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 08:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818C010E831;
	Thu, 29 Jan 2026 08:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dp3GQtTY";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C63710E7C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:43:14 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8947e17968eso7187686d6.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 20:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769661793; cv=none;
 d=google.com; s=arc-20240605;
 b=cVrjUBA3aM4T9X/igUJ3h00YBM8i7Xn1CDhWGlm8oP4qI4nt/hhitd6B6WQPxZwzBm
 Y10ncR2UMglgsyp4waHbD3ytZxZFUwPqDXXaB6FPDdMdgjBJhaTgfnW0jBihqPwPSQyb
 k7aLWUcE95l+vHiblDGE/3u/qdX1fruwcsG3lSu8b9NIvTbW02cX3TuU/VElDR1sP69g
 Bka8XwBj1mwszyd46wpsIzDo9A6R5Hh8nbVY+LPUD7VSuPclA3yE5vBN7dgXTQZKxXqy
 qhIHCraOA8gZaHQ6mfpYztnqLl5HJJLmcJgDVVjxkJl2OLewsmA8Chd1ENWG+LyxiDE9
 Q7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XfUYf7LLB2K5abp4d0ZkiqnHMi+g4gzW4547TspPJyk=;
 fh=dn+PU4oPVKSXZqYy+nEFBrqlFuKX+aPqtTVuhWpvG7w=;
 b=VxCAfiv8MB+DzDQHOfI9ExfaF5f7tGGMi5oK4RxgQdCFFUFMwvB2Y0wA8JZhGdsUds
 kjA4aFf9cGYyE5hgWF2eFkOrR7xxwXwKuKDRC4GqZcHheBcrci8BQPd/ZiSeqMPNYPCp
 z5myFaIdZNOOLP9AKztR3NKtUKN34j+scJBcqegUExEpUj0sPBLhn0Djwn9lB2X8Ulck
 xrXwYgGU1U/hrJUOZ/ZrpQBpFMRt6zN61zclyZdWODPYSbWnR4G7X+ualVtBj+LKgbxR
 x8kNt4Nq8NBbkixxPs4BVTzPvzzUfrRVkx71fvfaNSXUXJD4WQG59r+Do6MAr+2mKZ8C
 lU4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769661793; x=1770266593; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XfUYf7LLB2K5abp4d0ZkiqnHMi+g4gzW4547TspPJyk=;
 b=Dp3GQtTYHzRExF03nvUeUI73c5ixuUmFwKR2A9wLoChlu0ypbSkbMf/+SRrSd+Hjew
 aF8T007OSnHtnQYg0PIk4ZxD2Yrze6Y2ZHtyBHm3haSY8BRd8w3eyI7ihTqqdw+WlPU1
 vkENQloJ6nmCInsRbFksDUQcUjrIveEC7OnJuXsdxV1seEl2Ye/DLz0D2l2zIlTgeGFZ
 IB+bIxpVmcKoE4Sn1ldoLXDC7BsRlodPI+DVpFLxrq+LbocSgWoW8XiuhGiyEDN5ZkmF
 3mrhfwf9nK7NXbHqaO7/hj58y9cbtUpGuVHWBkzxk1KYedCJS6RUbPxgkoSENxYwYevQ
 LANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769661793; x=1770266593;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XfUYf7LLB2K5abp4d0ZkiqnHMi+g4gzW4547TspPJyk=;
 b=Y1Pq5WF2hN5v0K9ZECioK/+kRWUpvGj7BOjBCOYHStdgSPJKQ1AJUc9zwXWYpgn3Q5
 Z3uMdr2pNONihNZ03t0DO/dMZA648+1IwjwZlpgXO2phM3L1genqyQRVFc+dXpKNhboa
 +LW+pYn/tWriR4mEpbzB1bJHYQCdPCgcharuyI3eHVk3UCnpxpEeaslwsYVmAq7W1x6D
 BaH3d98yJyZ9TzVnDfi7lyS+JSIdvw4ykCQ98CQKsQ5e3bphAoZfPE3Sxbn1Pc1/bGKi
 lUUk0NrLVe88TDMCLWt8cX3tWiAm5lYU6iiioqeitpeq+rVaFMxPsdQj7QWFXX6TcoOa
 F5FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgQxjlRpqpxHd+wyj6L+NeiPZTSonOljBjsRiswTsMvZ8Affcp7Gu9H4ylCjD8PTsmMvE1SGar@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxLDxfnbMC8Wzkyold3xOpx9b8sQRWvbHNapeBxZkSpZxaf98O
 KaWdNlLXh0fydwHei3Aavl9jga2tC1Eefs0jd+YVBQDj+AXPfYUkUX0S6xlUUF4dNTBMitIDVUW
 e39A4K46xIKcPD09H/T9YPzxJ4OqpHdw=
X-Gm-Gg: AZuq6aJz8NAquvXSNXqjYgcb7n7u9imzisrkEwOYOMp6gV8qyfDpusXhXw0lnGB/qK5
 BNGs7NWaV4bYZXqICDEG9YrSiOWMJWAq70Q8qAMBQn1Ei9QtFfGe/s30SLLC9Sh/3aUnIjMRICg
 H2jf+M9NW3P2t6Q9ceVM/5uEWqIEvVbv0SbaoI4QpheYrY9LOnhqXvTB9Q252aVnwbnnkDHD2bR
 f04PQOf3st90snMUJ3JRqiuJjxzuU3yeaqLLQyrZByScMf3h1azGL6RzkGu9sTlyHZnv5m3Rqow
 niphAdY=
X-Received: by 2002:ad4:5ce9:0:b0:894:76f1:b6f7 with SMTP id
 6a1803df08f44-894cc7d6692mr105516946d6.14.1769661793551; Wed, 28 Jan 2026
 20:43:13 -0800 (PST)
MIME-Version: 1.0
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Wed, 28 Jan 2026 20:43:03 -0800
X-Gm-Features: AZwV_QhJADNnN-iMG1xRqtxKpv-vDGdJQLQowzzj1lIuQQOoldmCcgn1e1slovo
Message-ID: <CAFqHKTnSUndwTs-cc8SZxST48UBj6_oKf0Bzt_mMSsj6=g-xww@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
To: sunpeng.li@amd.com
Cc: Harry.Wentland@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 simona@ffwll.ch, 
 Mario Limonciello <superm1@kernel.org>, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Jan 2026 08:56:55 +0000
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

>From: Leo Li <sunpeng.li@amd.com>
>
>Some drivers need to perform sleepable operations prior to enabling
>vblank interrupts. A display hardware spin-up from a low-power state
>that requires synchronization with the rest of the driver, for example.
>
>To support this, introduce a DRM-internal drm_crtc_vblank_prepare()
>helper that calls back into the driver -- if implemented -- for DRM to
>do such preparation work before enabling vblank.
>
>v3:
>* Unexport drm_crtc_vblank_prepare() and make it DRM internal
>* Drop warnings in drm core for vblank_prepare(), drivers can do so in
>  their implementations
>* Drop unnecessary crtc null checks
>* Check for drm_dev_has_vblank()
>* Rebase on latest drm-misc-next
>
>v4:
>* EXPORT function to fix build error on DRM_KMS_HELPER=m
>
>Signed-off-by: Leo Li <sunpeng.li@amd.com>

Hi Leo.

I wanted to know what branch this series applies to. I'm trying to
troubleshoot a possible vblank issue on the Legion Go 2 and was
pointed towards this patch series. Unfortunately I can't get it to
apply cleanly to drm/drm-fixes, drm/drm-next or stable/linux-6.18.y


From commit 15392f76405ecb953216b437bed76ffa49cefb7b (HEAD,
drm/drm-next, drm/HEAD):
$ b4 shazam https://lore.kernel.org/dri-devel/20260127194143.176248-1-sunpeng.li@amd.com/
Grabbing thread from
lore.kernel.org/all/20260127194143.176248-1-sunpeng.li@amd.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
  [PATCH v4 2/2] drm/amd/display: Implement prepare_vblank_enable callback
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 2
---
Applying: drm: Introduce drm_crtc_vblank_prepare()
Applying: drm/amd/display: Implement prepare_vblank_enable callback
Patch failed at 0002 drm/amd/display: Implement prepare_vblank_enable callback
error: patch failed: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:277
error: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c: patch
does not apply


Thanks,
Derek
