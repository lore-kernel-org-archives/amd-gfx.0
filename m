Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62111CA5FCE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 20:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AA110E054;
	Thu,  1 Oct 2026 20:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNlx6QBl";
	dkim-atps=neutral
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com
 [74.125.229.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A983810E025
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 20:07:13 +0000 (UTC)
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-144ef651963so160421c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 13:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790885233; cv=none;
 d=google.com; s=arc-20260327;
 b=ICO1njb4h5csJ1YAw0d4cgKTek78VYZNFyo7qctXogkLpv36XeLzQ2txxsouFb/GXr
 YbDgM+BJL9RGrE4h/twar5mFR3kNgs7n7mNYC7nDQLEx1K6a/YOObCxZ/qRX4y3mA9Aw
 zxQHeO7VFaZwS3lXmblCkUDZuyHaY5oH6QrSrGuYfHrWFwP3GQqkGf3BF4M/FC5skcAz
 1sZDStOTO8DZZtdXXgITRm2yBJVGD222p0z3/srOUNrjxhbpquhAOGOv0IwdCoD7Gql2
 6jxeDkAjrfB+V9ofHOG0YRZJLGGO1MstL5l494oarniOk4PWdEQRqGgUTmQxEZp7qRqe
 UppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JrfvWUWEAWElhnecM861TImObnAFGbAixvPBsq9bOSA=;
 fh=hmYYSokgMe3uycMmiQ/ifYeBm/PA3AjdgytU5JO1NdU=;
 b=bItNy7dd679F19KaO1ymx0/aNjawwegvmqD8tYQbp4t4C0DAbgIPIu1BWpTuLykqjy
 8oCP5Gl3ZpSjV656ny9FHK5epmWvaiNDbI1I8H+SJ7GLInDfIK6RFi/INuC6rvhKyQhi
 +ErnY1YQxOgrsXOba4WOCQZ50hwsVe74cII6w9XI7zco3WoLUOoV9E+OZC5tEupvvS5B
 zMOlRAH3Rqp5zZQ2E2fGyfSizF99knJVbFCeiR64xj/A3lgNoZG+XhnQzi1pqss4KCZb
 xBRLAQXfrkw4QfMZRjaTrcigW7Oe2TiT0x2KcyxSHLhrhJxFeaS4sF95A5/57pUewoxq
 E25g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790885233; x=1791490033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JrfvWUWEAWElhnecM861TImObnAFGbAixvPBsq9bOSA=;
 b=eNlx6QBlZnph5jIcVtdGZ0l1wFGT7ktCLZjA2AiLIiKrbaKcsogKHZ+c5lkEahREwA
 SM+RSeeTdeuk8e7aE3W750Ml8/ndZi1vHuohyOCcgVa2jwH9WA62ceNKmlIi8Qs8meDV
 DhwA13zmXqGl1xscKVhBTepQhuJdN8K/nJC+lsJFnboMmXJbJ3TkeqKFIjI/cFxF/Qhn
 bFkqVy4jqTFghg5Cg3RhqN92vy8C3f/oStxiXmtndwiWkun9KI+HUHU7IlZP0LzCHjIG
 NoAL7i+WMSEDRMyp92Av7N6ZgBeZRgkwP/trTTC2a7+BxGf7eOwY6IzTcWqYiszPWT9i
 l1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790885233; x=1791490033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JrfvWUWEAWElhnecM861TImObnAFGbAixvPBsq9bOSA=;
 b=ZIINxkkxbXGYuhXpyN12zGNSGW10NlfKJwv8tsofXh55dH5ScsfewwGxkMty7y75Q9
 PWINSEZ0I0PBXbwumH1ocWz2MGwBxnz6uhJMXdr6GjyQvQsP1vIgVQhABi44vz19S1Zm
 iepFdHCroMFxDgghcRN4beNNRJvfBcGDCqdLxVN5vRE3RoeS3AaHuJdetBvD30qaHO+e
 sG3bUmoqNcxNvhhwrsI8nuny9fvaVLBWot8/WaHH2SI+eLZbktc41eFuxdHl5Y33MyZb
 FWhMeGUS9qURw8OZRLk4shxwKrFIa0/+Ic7UWYkYN/mTBT9H9rmScq6AEeGRzKLT//n/
 RMow==
X-Gm-Message-State: AFuF++lkSnDQIsrT4d/2aqzun+KYt6+Q1s0vVlUcGI3Gt+LeCBh/b3Ag
 CBfndCz2SUU69BUbHj3B2OndZDKWihekJC4S/K4QKr2F6E8M++TT4R6qfyVmjGWBAzSE92r+2PP
 LnCTHQH2M9qyaWgwP0ZRILrEJmHk8NsE=
X-Gm-Gg: AYBFou1t5gToPffqhfuyu9RYnDYdCddlKWbhqDGaa+1DUPDogWwbNa7CgqnAX1al0f1
 qL5gf2lmditKKWajszWeISwYM9hTI4ikHjkl/+OyH3Gkx7m8MXwsqHFNrI/yJTec2vgSEMhpDvT
 7UyQb09xDYmTXu9Q6nqHFH4bn9ONC5aQPZ9w0mOGOYG+PNSAS1rn/aHqRi/Wlkxww4sdyLLLDwH
 XRCQObmKK4rL9GDL3gnnTbwIZOxaXIQKkd5k7H1bbWCDc2bnSde2yTnwrIT0vfGCBhpmybB7bLN
 mnRSd7al28cRaGYLINUqYmUfprESVYNKTkQasoZhGhaFk4gQvGx8o5WNMYaUX3fk2qmHN8QBjCu
 5KLy4HGfxf+HCKrYoZJ1KXWzrL2Fgaidy5HrPfS/RcslNKrmbDtIQ
X-Received: by 2002:a05:701b:2516:b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14f5b11e751mr380111c88.2.1790885232671; Thu, 01 Oct 2026
 13:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJN0=HzowNF=GLUh8_smX5_+0u46JrzJaSJVQ5pm-8wiuYEErg@mail.gmail.com>
In-Reply-To: <CAJN0=HzowNF=GLUh8_smX5_+0u46JrzJaSJVQ5pm-8wiuYEErg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2026 16:07:01 -0400
X-Gm-Features: AclHuK-xz3gASXbqlnvfvnShgR7WR54qN8-CpzJhO4QR7PEkeKi8reQMsaexyC4
Message-ID: <CADnq5_M6xeAEZqH1HxpTLt7ZKPipm9Y6F0snngddtAWpZR8RGg@mail.gmail.com>
Subject: Re: [Bug Report] Black screen on Lenovo 14W (AMD Stoney / DCE 11.0)
 after updating to Kernel 7.x
To: Amd Alba <amdalba97@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Thu, Oct 1, 2026 at 3:56=E2=80=AFPM Amd Alba <amdalba97@gmail.com> wrote=
:
>
> Hello AMD Graphics Team,
>
> I am writing to report an issue after updating my Linux kernel to
> version 7.x (specifically tested on 7.0.0-34 and 7.2.6) on my Lenovo
> 14W laptop.
>
> When booting into Kernel 7.x, the internal laptop screen stays
> completely black, whereas everything works perfectly on Kernel
> 6.14.0-37.
>
> System Details:
> - Laptop: Lenovo 14W
> - Processor/GPU: AMD A6-9220C Radeon R5 (Stoney / DCE 11.0)
> - Operating System: Ubuntu 26.04
>
> The diagnostic logs show that the AMDGPU driver initializes, but the
> display output fails on DCE 11.0 hardware in Kernel 7.x.
>
> Please consider fixing this driver regression in upcoming kernel
> releases so that users with Stoney/DCE 11.0 hardware can run Kernel
> 7.x smoothly.
>
> Thank you for your support.

Please file a ticket here:
https://gitlab.freedesktop.org/drm/amd/-/work_items
and attach your full dmesg from boot with the failing kernel.

Thanks!

Alex
