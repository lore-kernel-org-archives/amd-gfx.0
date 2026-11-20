Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185ED60A260A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBdztqNh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD76210E25B;
	Fri, 20 Nov 2026 19:25:39 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A95810E25B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 19:25:33 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-8231ccb04a0so155286a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 11:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795202732; cv=none;
 d=google.com; s=arc-20260327;
 b=qZBrl0OHGrglI/3femjr7S668oktgmtn0cydkeuuQ7TvxW8B/KLZXb0G+y1AxEs8/I
 1Jhp0735x1jRQOsz0LZvtcObYn9Av3aJ6nwyonhuhVutWTm0ac+xoKnGn1tOLW9+4n1L
 OUEpG0CB/f9y1L7cPnkuhqTbY8XXaDA8oqh7NNmtmgiDX1C2xhrz70qqRPuB7GFTw+hq
 ABAYnQvsJgyDcPcaXs4ir0jz7qUx+jYAM3Z3L6IJjB5zrsIZFnKfhPqyEu8e+lySaZw8
 BT2Z3Lc08b53FbPDjGJlLl5EPXwu9hdq+5iDPRrZI3Jnbir3OgSV1c052b/8HDOssDWA
 wazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nlv6GhPjZQGW7PYO/RY66LC0lfOtm6tD2nK9pWdfsEI=;
 fh=LfhjTNv397zgfavAwjtcPPMEYm8bvuUibtTbQVXQ47M=;
 b=M1p/So343tonrSGb0btzwmtpULrz74NNPMofbkGflAo25qp3UH4Td+GAkwS8hAW+VE
 0r83BWcvs1iZudF34LZbQW5swG7XsLzAxVWY1XPoUZx84v5SRUdplkopYXT/C0k3lsRm
 /2VFCxdphujUJWwml7sHVAAXvpwxKSpj1wBqnlP3MZYUnhr16K+S06GfuK9mayaZ1Drc
 vXgEzQccKg4Ye1hE809NcFsEeK16I1P8kH9LOEp37hTzbYuadZOfQUTKpBgRG09eS8/F
 0oJ4j3GEhNQKMwYQakkju/KCipc2X6yciNRirYZ+2SaTDiKsSoggTOnfc9eM9ULTLBhl
 jsEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795202732; x=1795807532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlv6GhPjZQGW7PYO/RY66LC0lfOtm6tD2nK9pWdfsEI=;
 b=sBdztqNhd09z1K42rGGrqYsvIFb4ETqwY56IZ7emRWNJXBzffA8u9rXdqXNCCR3mi0
 cP8ZTmgP3lw119bcsUE0Dqs7YAzXccTam7rEamQS1DePVGOoacxm06t0gtk2yNEQMTba
 VindOPOLS6Oe87DwFIIyPvyjABS8hkdWiE1YqUsWOpYniYyWMTAYHMMHlwYLvZNd75ph
 wnBFGV9V8Oc2x7oDNyHW1iVKYRWyYle9J7emLWPLZ7tWQ6unu2zw635mqiqKWTmPBpI0
 FlI4KmqnjM+Kco+YkxrBFaE0OPwQ5d8O0LvVtHeYsVHAxvcLOBtQItO1z1VpqSC71Cah
 rz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202732; x=1795807532;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nlv6GhPjZQGW7PYO/RY66LC0lfOtm6tD2nK9pWdfsEI=;
 b=lXRHlaX4iiMXz4u+c2tnoqERB253GTH/cV/FowiLjaCdyLvvb8uxAG153qn574Y9Pl
 eqI5d07Q7t8CZikALZzWRItIpRN9OMY0Va5wQpQAnbKZejEEYPhh6qXyH9M5hi4ztmEP
 zwHd45O9tKaNK0d1+qB8XWbBcDWoBNnLKysRjTrhcE5kJGJxJADmra5h+oAiYrbbVZ3C
 xDwlt/3uPENNvSr8Q+zhZjf9mvOZH4XmUmAZoe4BdS7wdnjbhhdT+g5htdoUBE4J6Waj
 1oLMYYXrikYxoFk+q8yOFpYhG9xdAG48TJszZTBJEXs1n3ZCfoF2h9w+yGtV+PpAGCeh
 gM7w==
X-Gm-Message-State: APuU4Z+RL+jzhBk7QbnzBxs7xDqkKLTD+JYI712/HCj4YcqP8fwEULj9
 8cS2WxeAVnMaUu900OT5wqlAH4iw/1bKlg2p2jk/362Tx9NoKAy389+7kFN0s6KSSneV/jX1lvT
 wSnk2rY9SSEp20oXJeNDHlQ93WACZ8v0=
X-Gm-Gg: AYBFou0D+wMbbCnHg3D/oQU5UXxiqX6ngaCsxwDGuY1GYHUtJqFPa9hzryUY88AH2QM
 LeG8Yl3lqQYrr9zLQ8xCZg+c0B1mSVHq40DPnueoXh/w0D2i2R/8M/QyCqvwB30o9FLrW+HrKz8
 VhOCsK9i7Yj6DYwgMCojJ0mMiFOardynCtMfLMijaiHmIo0VHLtVWI/GeMnqyFrODCy7A1kdxSB
 mjb+gCWyFImos4IuoJo7VbWYlr5UGYd6EsPkNLQxoy65gzHt1X+m75hK5R6RKwwChdSYmKPbOTA
 a5NW1mb/rgTdpjkcztVq+e4Y5EBSfIZ/T04csy+P1MEuUXXzTouiCOmnu1L3cTX5f9pIrT/tdMf
 5bG5CgJr2a/UCJWvh1fQcIEJs4Q1MZ2Pm/KrSFgCA0KcCNtZwvf6d5MU+gyNreQym4pr/Lul15j
 vle4QQ5CngRwbByYEA3x/Hl1FxAAMPmbuIm/5YgdxIN84l84pprKJy7GLZgeno
X-Received: by 2002:a05:6808:c123:b0:53a:5069:cdef with SMTP id
 5614622812f47-57a09b0c52emr7011830b6e.4.1795202732238; Fri, 20 Nov 2026
 11:25:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120172407.64651-1-caberliner@gmail.com>
In-Reply-To: <20261120172407.64651-1-caberliner@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2026 14:25:21 -0500
X-Gm-Features: Aa3M54racJksns4uDg1cEVY7ON5hZkzFesN2EJrg-B8HLeiXkhcVmxMWS54ZE5Y
Message-ID: <CADnq5_OsKujx3VgWDNDYF_ANocTs0aswFaC3uGwZhp7fE+SBCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amdgpu/gfx9: make KFD usable again after MODE2 on
 Renoir
To: Christoph Berliner <caberliner@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Jiqian.Chen@amd.com
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 12:46=E2=80=AFPM Christoph Berliner
<caberliner@gmail.com> wrote:
>
> On Renoir/Cezanne (GC 9.3.0) a MODE2 reset reports success, graphics and
> the kernel compute queues come back, but KFD stays dead until reboot:
> every new KFD queue runs into "qcm fence wait loop timeout expired"
> and triggers the next reset. Reported in
> https://gitlab.freedesktop.org/drm/amd/-/issues/6177, sent here as
> asked there.
>
> Commit c3988a7ad479 ("drm/amdgpu/gfx9: Fix Ring and IB test fail after
> mode2") already found that MODE2 does not reset the HQD registers on
> gfx9 APUs and deactivates the KCQ HQDs before the reset. The HIQ used by
> KFD survives as well, though: kq_uninitialize() skips destroy_mqd()
> during a reset because it cannot take the reset domain semaphore. After
> MODE2 the MEC restarts with the stale HIQ and the HWS no longer answers.
> The same trylock pattern on the MES side is discussed in
> https://gitlab.freedesktop.org/drm/amd/-/issues/6053.
>
> Patch 1 is a small cleanup plus a fix for the timeout check of the
> existing dequeue loop. Patch 2 deactivates all active compute HQDs
> (except the KIQ) before MODE2, restricted to GC 9.3.0 because that is
> the only gfx9 APU I could test. Raven/Picasso likely need the same, but
> I don't know this code well enough to widen the condition without
> hardware to test on.
>
> Tested on a Ryzen 5 5600G (gfx90c), MEC firmware 0x1e3, HWS,
> amdgpu.noretry=3D1. An instrumented build used the old path for the first
> MODE2 and the new path for later ones, so both were compared in the
> same boot:
>
>   old path: HIQ still ACTIVE with the old MQD/PQ after MODE2; next HIP
>             program -> "qcm fence wait loop timeout", GPU hang, reset
>   new path: only the KIQ active at resume, HIP/rocBLAS tests pass
>
> Since then the patches run as the boot-time amdgpu module on the
> Proxmox 7.0.14 kernels (-29 and now -30): requested reset with 9 HQDs
> deactivated and the KIQ skipped, HIP/rocBLAS work before and after.
> On amd-staging-drm-next (8dd68a795) the series applies with offsets
> and builds without warnings (W=3D1).
>
> The analysis and the patches were prepared with an AI coding assistant
> (see the Assisted-by tags); I tested them on the hardware described
> above.
>
> Christoph Berliner (2):
>   drm/amdgpu/gfx9: factor out HQD deactivation and fix its timeout check
>   drm/amdgpu/gfx9: deactivate all compute HQDs before MODE2 on Renoir

I would just squash this into one patch to deactivate the HQDs on all
queues.  No need to make this renoir specific.  It should not hurt
anything to do this on all gfx9 APUs.

Alex

>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 105 ++++++++++++++++++++------
>  1 file changed, 82 insertions(+), 23 deletions(-)
>
> --
> 2.56.1
>
