Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE4F107BCF1
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Mar 2026 04:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5314B10ECF3;
	Sat, 14 Mar 2026 04:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qr+P7cnz";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67DC10ECEE
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Mar 2026 04:37:51 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b9704cd6951so297806766b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 21:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773463070; cv=none;
 d=google.com; s=arc-20240605;
 b=O0abJYYBt/RN2PvKRnF0wtVpam1qjCyHDnzMkCYSjZp8DppCR4Ytk95R/M2nTgBJjk
 WXEX93h5RxDDAJOQmtzjA8t/diqcXKyCI5Avgf0MfbTrfohafQyFA3MiqUmYZZpRCqcJ
 TxwoodVwUApwsDb8KsjGAwZy3VizD61jqFNT6uW9B4jd6MjTu1Cl118fGNRdet1ntrGY
 cZ8cX6d1GNpNjPL02NpxvwnD6rrUCzVXeIoKu4s7SnqKWSnSKjeoqxfJYNDJG599h72Z
 HVthZAtJnzhEVyzDEm0TCWe7PQR8dcHVxnCHBWjKfYp8ic7j2t2Qmr/3NmNizkeqjcv8
 tUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=/sRCj6aQjSil4dc0t3El4MUftedrp9NNBVb/SpPKT0Y=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=Vo0pEzt2dYq5PQ0FOEkJefuknvGLCgJmIVi2y2PVroJvUe/r6V38crb6/bAkpA4+ya
 2/4uIXKf62LZ3dbiuEGdHLHgScgtKrDVBoKhCAPnnX3DpH86JPMNqaJ/gnMUF2eHs0i1
 5f7/d8bGumvL5Atwm7c4Vih9CCYjkbeomKbN7DDLm3ii+6P3dC2hL4h6aWyGjoA6BuRd
 1WNWUl4658gHRNtDeuidvP8xrxlBkyWBc4YH6BTKPQiTmXRDMQgtWc2V0uYFakSN4mMi
 0YTIJ5z3n1EW3WWlw5FbFm6KBvFuyrroT63xTCipqVFBC+DJrUhis6TyYa+7GqDILutw
 oMpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773463070; x=1774067870; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/sRCj6aQjSil4dc0t3El4MUftedrp9NNBVb/SpPKT0Y=;
 b=Qr+P7cnzhR6fyz1IjblXk4ZAZgiOpTe6pxK5esAfFv/sANJ+LPtrPTDO356Lbz+/bF
 bBGeXVtHTyCOcDWSgLrdZxyOjx+rSLynQTDQHiF3SjakAP4y69tnkRUXh4Q1SYRQ7c+S
 FmJuCD4MW/m2GBZ0eX9n1A79KcZjo2FZnarPRT7RkGYa1nu9fStmYVf+6PQgo8c7ZXcp
 3jIQ29whZlBohcx/QT6tk8f8l5WahhfuJ7O6JDsiMVsGV90+fUeZ7pjORweI3zSeeR07
 nQjsyg29TxwT8Bs3816ErkduAZj9Ikzor94agey4Rx3fxJB89z3h0s5quUkEa2N/cYsf
 C32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773463070; x=1774067870;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/sRCj6aQjSil4dc0t3El4MUftedrp9NNBVb/SpPKT0Y=;
 b=tAfA/sE/1vkHB26Kciepf7E2ateYGJxxZLc6rOld+2bsv0LCza4VhbmtTIqlDh/tu0
 73MSvR2HXy1o9APzkLZ4xzZL/FLcQU/KwAI7gIP6HQaT/3Jgn6nFNL2NX204fX6HNILK
 +usfrRwLT9cXh9GbNveixV3h0V7lEnFxQ/zF1BALTOqcHTt6lCjkaog/57jo9uyLIilX
 FjM0H2Ef+AsIO6hX28zYrODFE1cKJ2N0x9E833y+8EOflHQvS9TRnqfSsJnNKljeF7Lu
 4FbVMzzdkcuSmPwf6nT7BBj7QMLjXJbzT3cH8uhbJB/PzEE+kOS51+Xjfoqe1wukXcuo
 9p3w==
X-Gm-Message-State: AOJu0YyxTRe1LbQWPYq4HwESykhXlfz3dRB1pmMmXLNOSCnW3MeR17Xz
 EQr1tAc4M3HMi17dOVE/D573XPiryKzrbLe/pKRxJCIEUI/0lexiIRQjSPGDQO09w5/JTui1yUj
 7OsJEDrA91QOFOaBXz3Y5J2zBQepuXukq81DRjSs=
X-Gm-Gg: ATEYQzydTT2sv8+o6m0iM7WBEjOuTsHUFmTwLb9ctGhS90ZL+Tly/Zw2wNWSc6dSHIG
 ldvdfjA2QhSGgFyQRTHrlgMgu1ijwxsuTYnMpVrBA+BY0OX6EnVLDinJ5T9+AiYr+2CmBrfS3Ta
 YN/qbgBtWALETDnAtRHBiXSTpFirW/RDp2SzyhniLmPunjx5DLxrhCk7CGmXpXJj8CrpxBeVdlW
 Gq9IDvGop+vGqH0dgKUCa3RVO9Vja4AUqBvmIlvFFjN9fC8VP6faQ0mdrifSUiFMr+O9RFgopfv
 y3A+iq3EUJ3+nPkakA==
X-Received: by 2002:a17:906:68d:b0:b97:3db:c7cb with SMTP id
 a640c23a62f3a-b9765376704mr286663866b.46.1773463069827; Fri, 13 Mar 2026
 21:37:49 -0700 (PDT)
MIME-Version: 1.0
From: Boddin Gregory <bodimode@gmail.com>
Date: Sat, 14 Mar 2026 05:37:39 +0100
X-Gm-Features: AaiRm51jhsYX3ADZqJjZshyhah-fKAyYtv91q6NTGZG5zRl6RVH6vzIGqK2ir2k
Message-ID: <CANHGPmVhS3CzfBw+9u6X=cx6d9=PG=XTmnv4yWEWe9QXd4CbjA@mail.gmail.com>
Subject: Issues with 7900 XTX power management.
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hello,

I recently entered the wonderful world of freebsd and have been
playing with a lot of video encoding and 3D rendering on my
workstation.
I noticed however, that the fans on the GPU were always silent, and,
now that I think of it, they never ran on Linux either.
A crash showing clear memory corruption on the screen and a GPU I
couldn't touch while its FAN were sleeping prompted me to investigate
if I could ramp the fans up myself.
It does require a working SMU, this card uses SMU 13 for its power management

The firmware that have been provided by AMD so far:

SMU 13 with version 3c ( waaay back then )
SMU 13 with version 40 ( now )

So I've been checking the source
(drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h),
and in every fork (mainline, amd-next) I could find we're still at 3C.

I haven't checked the driver packages provided by AMD yet.

I'd like to make sure my understanding is correct and that there's
nothing I can do at the moment ?

- AMD hasn't provided the structs for 3c or 40
- AMD hasn't provided the SMU firmware for 3d

Oh btw, relevent lines:

drmn0: smu driver if version = 0x0000003d, smu fw if version =
0x00000040, smu fw program = 0, smu fw version = 0x004e8000 (78.128.0)
drmn0: SMU driver if version not matched

Regards,
