Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429B2C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 14:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D688C10E060;
	Wed, 29 Jul 2026 14:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LMUPODM2";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D44F10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:43:21 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso84767a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785336201; cv=none;
 d=google.com; s=arc-20260327;
 b=bXpp4qUFHE8v2aJIxeP9yqgV6OwkK/78ZoMcmha88iA/OHjpG2FwnKPiY3QB3SZc6y
 gTUYf3C4GYU9CwI3oDtjGpYXE/eQgiTkKD22JVIjwS7QPuEP2f42J4sjLFKIS20iZfTw
 LOBOIKFf1iyq9cu9NDuTNuck7Xuesd1VqQcd3E6kaDfHXvSzqrLRMewcem6fWwz2TMCn
 DpzVDP4J9jUGfROIBg6hLdmmVfd9q1TUPH00SFu0H4Dfgt5EZfxvofBVCvhtotF18P71
 bG3Pp1qnMyW68IGH4Agx3QprF3ugA6TG7zMxZ96LPo1mjQ8vepHPEAnhX59xiExp8okp
 i4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sPMtujTdypu2zF+lFOu6KiffqCP6R5EJ951JRWg5JJk=;
 fh=kLamgrlTxYVY4hWGFwKSLVPKBCKgvWC2a4NkF1vg8Wk=;
 b=G9ll0qsR5m1E+S/rB4y8OO62IV5+67QgIYCD+9cwyBws1RUOAXGAiu2RrBnlTku9kL
 KkbKNneQXcujtA4m2a0oeZaVjQ0izFyhrYKPb1CTjTa0+IS2hxLP2qMSX+3P/Yeswckc
 Y9Cyz26XqOs7T7RWuwhJLxCwk883xDw55lClyq81loc357KffMiGx2KaDK5dxyCwmZTq
 +4pC0D53m/MGoOTfEf+UEfzSMgUQGZ7aOdUTwqPstY99Kl3gUekrdi6X2FdAweWBZwxA
 F9coQtcTEB0oYEJ7F4svRJYsTpm/GlzMMTpPGmTMwDFaj6ApXlY8SWWaavVND4tmYzw4
 ZzDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785336201; x=1785941001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sPMtujTdypu2zF+lFOu6KiffqCP6R5EJ951JRWg5JJk=;
 b=LMUPODM2c2wE6i6pV6dKQRZUd5CSKxxAHtHrp1hLp4FwLGgxBY0mETMWjLELFF1I8s
 AyYmb6qfQS+K+RX7vSnPeYtzTIY49/Zq0oPaMwjfpgONiYKssA7yAk47W/lVDVS0+iXg
 XcYwp74RZthFvl4IOW7IDLXmwrn1ViO6VdVYCp/M7lQOHLbQEXMeHzolAf6Aaw+AjZAZ
 P5W7zR2e2LrsqpJw47+nqDqV15B7cxMuGI8h0uwfupYsWsQLP/XhpAnPPNnAX40qQxJO
 b4YDxZIMZTgj9JywriZyIg+IysXwzXfFrVoqV/mB017HzUcVAIhXTxy64JAGP1cuHcYQ
 YzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336201; x=1785941001;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sPMtujTdypu2zF+lFOu6KiffqCP6R5EJ951JRWg5JJk=;
 b=J9I/ookjyfAH02dIaifU0pbNqK8Mo/77bFrflkNsUBczKgexJjDRqGkBvHvuMrobP7
 R+61yOQgeAnwzQjzpqdLF7B4r2Ar7eB2l4DsAUaI8ud7EZqf9rpOhMwSyEPfWuWApA9u
 bH+yEc1TzKFRhemOJnh+XImVtz35NChSK9A3fca4jv2T8psavb9mOIdo85fMMm3QRbEy
 r98NEvkqDzhJW5G9KWypZtU7+qHbDNAE3w6BokVx8+7Wk02PKt60UAL792O8QajTdLTU
 lyvEbA9Q3PK9zGzAbIYEeAiin1MDbsZtzJHtQGBp1Tt/fNDAEv00v/DG6Xhir2JUjdvm
 5maw==
X-Gm-Message-State: AOJu0YwEQ7rwu8xOy80bJ0wV+10DM9oHry8FouTNtCCwU4CUekiUhqu2
 /SQzrxAhM+ygS4uWfADl4r8zG0TwbazxS7h12eSjBKxlh7DDM6/lTQ/TWdBt8DyuHmVKhou+l87
 YmRzx0wb5jSowY1HUV8MegoyK4Yno3ws=
X-Gm-Gg: AR+sD13AcA4QTj3/0lZvZLF2Bi+b5yoREaXm8Y7gmw0v8oGCUVStaxlkflQNBn8n5wQ
 FAo0JA/s/iT2F/JnbQ6cP39fq22POKlK81HFAATRhxk3jMkC6Ez0hMRgkGMNTIcuEidcWK9fQe4
 celoIQZ8IoAcM5O+BeCPUa4QZbgX07mOWmtLLYjFJWLubM72Dk90Qb6/mVP9sDu76Qa2x0N/IcK
 WV27F3Z45AnZ2n68iOglYmeFV9zJbCSK92joOi2j3VwXz4jfYz+31TF2BDwbTROI0B2UVmZgQt9
 60XMV6kdapCh09Bu42fiJhLeWmfJ1LQAGuj1n+bBFTUKhUTuBEwy7HjYOcfLUrJAxFkJn3S3dGr
 wroSqOwY/mBuAvK+whfJ3X4kTqLJpxO0=
X-Received: by 2002:a17:90b:280e:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-38f6a321a61mr6701509a91.2.1785336200877; Wed, 29 Jul 2026
 07:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260721114322.17535-1-timur.kristof@gmail.com>
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 10:43:09 -0400
X-Gm-Features: AUfX_myHf_G2Hz8WxGpxgJrBAsXGXlHEE-Agt4FxUbmuxn_cZkR6rL-BrtbtKW8
Message-ID: <CADnq5_O-OCL00WVytyYD2qhfo5fbOAytQWr425ziXwybPeDAFw@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/amdgpu/gfx7: Use GFX IP block soft reset on GFX7
 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

Applied the series.  Thanks!

Alex

On Tue, Jul 21, 2026 at 7:43=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> GFX IP block soft reset has been implemented as recovery
> method so that we can have a way to reset just the GFX
> block without resetting the whole GPU or losing the
> contents of VRAM.
>
> Fix up various things in the GFX7 code to prepare it
> to work with IP block soft reset. The main challenge
> was fixing up the MQD/HQD handling to ensure that it
> doesn't hang after the soft reset. There are also
> other minor fixups.
>
> Rework the pre-existing GFX7 soft reset implementation
> like the reworked version on GFX8 to make it more robust.
> In practice, this means that it will now reset everything
> in the GFX IP block (instead of taking a guess at which
> parts need to be reset) to make it consistent, and it now
> also handles clock and power gating to make sure not to
> degrade GPU functionality after a GFX IP block soft reset.
>
> This improves current user experience on all GFX7 chips:
>
> On Kaveri and Kabini there is currently no working
> GPU recovery method so those chips currently require
> the user to manually reset the computer when there
> was a hang.
>
> On Hawaii and Bonaire, the current GPU recovery method
> always clears the contents of VRAM, which means that
> a buggy (hanging) app can crash the whole graphical
> session, which is less than ideal.
>
> Using GFX IP block soft reset means that we can now
> have a working recovery on GFX7 APUs and we can also
> move on from GFX hangs on dGPUs without crashing the
> whole system.
>
> Tested on the following chips:
>
> Bonaire (Radeon HD 7790)
> Hawaii (Radeon R9 390X)
> Kaveri (A10-7850K)
>
> Changes from v1 to v2:
>
> * Add more explanation to various patches
> * Address feedback from the review of the v1
>
> Timur Krist=C3=B3f (9):
>   drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable on GFX7
>   drm/amdgpu/gfx7: Refactor MQD initialization and finalization
>   drm/amdgpu/gfx7: Return error code when compute ring tests fail
>   drm/amdgpu/gfx7: Return error code when failing to start GFX ring
>   drm/amdgpu/gfx7: Fixup emitting SWITCH_BUFFER packets
>   drm/amdgpu/gfx7: Clean up gfx ring during reset
>   drm/amdgpu/gfx7: Use COND_EXEC
>   drm/amdgpu/gfx7: Fixup IP block soft reset
>   drm/amdgpu/gfx7: Enable IP block soft reset as a GPU recovery method
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 331 +++++++++++++-----------
>  3 files changed, 186 insertions(+), 156 deletions(-)
>
> --
> 2.55.0
>
