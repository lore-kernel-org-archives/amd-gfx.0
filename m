Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98192C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A5E210F066;
	Wed, 15 Jul 2026 13:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L9V6/uqv";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C4610F066
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:11 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ccae46de39so10719645ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 06:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784123111; cv=none;
 d=google.com; s=arc-20260327;
 b=dHcYHE+bdWU3H1IAq/qWi9/gLN8wotgyzbi78duMk2uGQOVyVD6ngKEibf9/0U8oUC
 QWrt7HoSzvES2j2qBPXS9eHOD4hUAIh1TSqSdnirh8jHIinKuP1RKqpmh5a3B7SLLk3+
 JY/ZFrhaKLPVkz6fEL+e2Z66STjb6hbMzG8h95DsII36QdQQPZCmoyaT2R6a64F8tKm7
 eR7a/e+O5OtX54ZS3ioFMDX2VAn1r15RkbLL8xuzKuPqxSQd2FQId5v7m5sJTziFgo4C
 B3sieFkV3CY2jQGb7L2ZKVv+jTgnu0lUd9KvmdFsaFWqjVFjpz8AVBj+Egm4FGUbWbu9
 dvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vy3sTjOkVDiLdu6EZkwlmHhnIXIucJfDO7aoHh3lPpU=;
 fh=kN554ZXdjNLFYlsoSN+4k+ab7ffU5SVaCgbW6KOXSBE=;
 b=KAEZRVVTUfwQdt/CLkgu8p2+S4CtXQtHAyF1YFngz4T+E0om2TvRnSUOuGbfbVkv2K
 2yVbYyCrXVzweMaHsaBEwKO15lACVLTI1k4OT87EAPADHIUfUg4nns/NOcL3fnS478ID
 RUg8ZAlKil5CsAyJtGp3uUXtJTqxJfLDyF7sTEr0FVrY0sv1Wm6wL4a6EO6eJOxtkRdm
 s54JE8QsiR+FD7ygQ4N1W8RRvaDFAOxrHc3B/rNaE7uTtIf997KAF9eIDMVnCUSYbB9L
 qTPebIftSavHQ7ilLFIVUyl+yL5kpi5uJK51q9SDksQcP0GVV/DuGo1FXon3Ds27KmFG
 qpdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784123111; x=1784727911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vy3sTjOkVDiLdu6EZkwlmHhnIXIucJfDO7aoHh3lPpU=;
 b=L9V6/uqvbwX2cSxoSWvX0CrVOp5tW2mKsZwPKA6qXgWZiYFc2jWgF0ZjBxlYtpfQOy
 nwhSli+QUrKguC+CfKhbwbuHq3MchLMPKXXZrE6hLBA1I9NIQ3b6W6HkHO0vvDtl0+hh
 gbxZfJ7mfsy/os3nwOfQMMCeSx9nUJW7HoTxXpFOEhKukUgeH4OViYc6jrEN/v3NmCGG
 9y6Eg+AQb0RM9pEqokQln9rQ4sqSFbXEDpyuCnAplsfiKBAXMi3a7jRrHo7V15wRhvDl
 +6tjKklteFJsGYDRYZ/0fCw+Y1mUiNy9OsMIlc+lJaD5CZ/aO5Edqi23O6k7+yHSY78g
 xRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784123111; x=1784727911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vy3sTjOkVDiLdu6EZkwlmHhnIXIucJfDO7aoHh3lPpU=;
 b=LS9N8LhLjYKCCEO5BCKlj2OawQP7k5LRkF8oXt+QH4CSbb5ZQ2PHgWKnyfAkUzpNhl
 A8Fh0pz5Htymrl7fGvXMe9bwcO+iI3hZUxbmIkwpkIAmd+vqVWbjh5dUPOxlxpwmCtDh
 G6wEG/N89ngqsL+dsl7IjMOPft4M1T2sluE2alnmJSPlDGKatBGnH70QACFonw0kNkqZ
 oY8CM69wldHCDtYUiW3dyxF8Uj5az5w63XFj3Do8zLJkqgN7G/Z+UrSOquWJOu/7CNpO
 5aCPHzQX4hlM3gGpKXZmt6wMZvjDTcF5nb0Wr2lpvdJq/dH/NjbKR429EzFf0L+W8biQ
 sByg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNrJHjKO7s+G+szWF9iDmwAcZJPK52mZtPVGo8725EGRHboWkkRzPaPCx3pBm7uG0phje7hzDT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqEJed60QcgkC9tCh71QoIrGLlSJKt0cS38JGlO236Y+QUswJk
 SdWO86lwCEYOeolAE06CX60aeV/2EVNTz8QDyTQsptAMaSzjEwPN8PN5U6vZAcsYwpmwwr09jVO
 DDcQWL3W4XOrSKo8d/fZQ3YX9yDfIo613Ld17
X-Gm-Gg: AfdE7clokfptN/kTEhRt7NTMkgqp9ieX1pL6Xv0fMqaVce2LXLOd8zvpzUgGgW1TyZI
 0sMlYMS3ibmRhwPp3dnQfKNR2X7sXw2NnNxd1DdFUXIO68PXIVh20zRVr56EkeKpRu6PvOygN7U
 EqfNqkmroRrN+vhQ/hbCfAiGBZ/HC2a7fN2xlzpl9/+zuhpJ3KYbfnpyzimO/eLk/MT1GE75A+g
 Xw13cdb19elZMl1ZClJOT/1K0gOvleo1rNKVreSdcK/2EfhbWGFSjd/fYK6qk9RBqjzxiy1u5En
 sz7evBiTr7xunPBEFRcyb7bXYF5KrGglu7Hyol5QHPiam92vUyPTuVWPRx4=
X-Received: by 2002:a17:902:ea0f:b0:2ca:6885:8a06 with SMTP id
 d9443c01a7336-2ce9f04c866mr141309635ad.5.1784123110806; Wed, 15 Jul 2026
 06:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
 <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
 <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
 <CADnq5_P8dPWAJCd_=u13KKDPmJQecC9MqHJ6K9g4+4iQxYvi_Q@mail.gmail.com>
 <70f3e844-002a-46b2-9341-47428abfd829@amd.com>
In-Reply-To: <70f3e844-002a-46b2-9341-47428abfd829@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jul 2026 09:44:58 -0400
X-Gm-Features: AUfX_mzgN6MoTs_NV5FIB_gbU3jNPGEHhmJRsRsRItNCsOSB_GTI-Lv6_cFQVRo
Message-ID: <CADnq5_OzP69GXe4TgotojQd7U8DUbyY-QK_HP6JR-h8+0PoTPA@mail.gmail.com>
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Jul 15, 2026 at 5:00=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/14/26 17:19, Alex Deucher wrote:
> >> Why are we using the MES for per VMID invalidation?
> >
> > gfxoff.  We can't access the registers directly unless we disallow gfxo=
ff.
>
> Well there is a remark that VM_INVALIDATE_ENG*_ACK is always save to read=
, even when gfxoff is active.
>
> And we explicitly acquire the semaphore to avoid that GFXOFF kicks in.

I'm pretty sure the semaphore just keeps it active if it's already
active, but the registers are in the gfx tile so they are gfxoff
controlled.  I think the semaphore is just meant to be used as a lock
to keep gfxoff from kicking in in the middle of an invalidation.

>
> I also don't see how we use the MES here?
>
> What we do is to use the KIQ on gfx9, but that is actually only as a work=
around for some SRIOV problems.
>

We do it for everything gfx9 and newer.  For example gmc_v11_0_flush_gpu_tl=
b():

        /* This is necessary for SRIOV as well as for GFXOFF to
function
         * properly under bare metal
         */
        if ((adev->gfx.kiq[0].ring.sched.ready ||
adev->mes.ring[0].sched.ready) &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
        amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
                                                 1 << vmid, GET_INST(GC, 0)=
);
                return;
        }

The only time we use the MMIO path is if KIQ or MES is not ready yet.
The goal of this patch set was to switch to using SDMA rather than MES
and to clean up the gmc code since most of the logic is the same for
gfx9 and above.

Alex


> Christian.
>
> >
> > Alex
