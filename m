Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA2CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E8F10F8F5;
	Fri,  2 Oct 2026 15:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nmfrf511";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5A410F8F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 15:47:39 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-1431a73fa1eso679989c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 08:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790956058; cv=none;
 d=google.com; s=arc-20260327;
 b=Dq2AdHHYBAr6ePI6BAQ9AgTXDYGIIoY7/2d88BhI2izEHRobk2aODvZ25sF/h2wl0l
 3eUmCxJcwZTx5Y1talo9cPU56O5BYEthWFsLCCGQLWtcoUJNGBi6VBJCuYdT0xxvg248
 0pW+NfH0bk33LvRLbvfSQm4fIeXBi27dIoBx9MVAYF5ahyMhlKX4T003woWEg9ABluYy
 jDTsZCDub6RQ1j08NPYPW5Hv1cWLdLfo+uhgBbjp+aZrku77sTSmek7mjdkO5VNFd/cr
 +HZhRa7DbGjpNzB3FY0WGodNwRj6LZFeH31+3cKIpUYXPuAZrACrj/crBK5zioYb3weD
 8/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PtYJt2HiWSES49AdyTOSflj0yjcQseHIoq5zx8MW3O0=;
 fh=p/1C9UsJV+Ddxz+7z1iTeUvOFzwYWSz4Fx/+yYyLdz8=;
 b=eDJTaTRZiHjukNCmaiw99CbVCdpsMv4wwddtU6Mm0l/gQGImJTjQ75cOIzaxJn0lro
 YH4gqnhGvFBmFX2+B3bRY6ZKUD8zF40EnA1n1lE2l1A8eXI7kUN5l4fotgfUxhED+Kwm
 qXL958yWIWD69KS11zFOTHJ8qo+gRyDt+T1wKrpghEW9dO795AVDIcA3TFVhFw9bNunu
 qb1+pLHOGoFJJmI8uYmt4RcicQhD6/ZEUdRRhYpt91zdE1f4KsGXKb5JGx4v87ElAdNE
 0WIE25AOfaNCv3S4mBjdgXP6hbTY9k7m3AU3iBF7hZKqSKolzzKbUlf2stPBr3m9GMGP
 wOyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790956058; x=1791560858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PtYJt2HiWSES49AdyTOSflj0yjcQseHIoq5zx8MW3O0=;
 b=nmfrf511nb4zwCC/ib26cpW0HzY7ycRc0LQPRdk4rN9XqzJ7Az1hL/iLbhKlyd+wkJ
 tkvYax6MG0PF4CCToVjsqWFg4Nof7fBmUTuEfD6pdED09ygScEC0Sb+0LmpVWEVOvWB5
 5gfosqEB4z3o5/tCf+vxxO3L+/ttlfchvcPAJEw1rEWB86LqvKLnSeGAM0y8WFCtZdIx
 j2YC1i8gt4xPKFEVX86T8FVS6M36Z7D/bdxdkzwcZBtaZBApBd04V2te+jwmeKdAVcT3
 tFz9QPHzf/ZgLM+pbYCS6N6OXPLQ7xkdAtXhxynn239bZY6xij3tZ5E2buAw9slHopeU
 CcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790956058; x=1791560858;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PtYJt2HiWSES49AdyTOSflj0yjcQseHIoq5zx8MW3O0=;
 b=n/WHqdpeqHfG7yfTCjDQZTVdZUk/uwfrBd+98vGvzhaSxfRuh05ZznNOxG4nBZ3GSQ
 BCs4GekD4eNgE+SbX+K6QZt3/6KA/bqDZT+fGAmul3J1h8pVJm/6I9TdFAJIA1PZxhtj
 vEW+1sLsckqCyN7QA2rI5LIehJQs9hrGno1LQJEcrIAksKSh1P6zeTPFZ2nBsOXT3pga
 JC17QSAqnIlbhQaTja8sOXVGhrQ8VxpbVcdeKBtDSK1jYQiV/L3b00WCpNP+Of5KNKEU
 jCn7MmfDioR00m1nDQWpTfEzg5y2aG++W5FfBaK1KlSKoGQDMXk0TP4bASWVa2TDgmNf
 UiZA==
X-Gm-Message-State: AFuF++mnABY5ZOsviMsvvaf+p0aIpaWJDHMAQvKktQrixLDA3Fv1C8uv
 LTtyBBubGcBdzKv4GUNNveIaFTAlVJYXj2/ODTCnOUjGm67mAegbaUIGp0zZx7ANiO3ndB4tyKX
 JEocOz4WIcAB/ByYZJ0pvtEHDBYyF9Wk=
X-Gm-Gg: AYBFou3GLbMey/+dU3EOi1xNrVUgReZNNNGBRXR1GAdAv9kaM0Bbiz5ar2nscYcmZZ0
 6xZ8q0L2wKOa8yDFc3gnhDFAk8mBRFbghrAyVWR0LjeYjCAfAYeede/x/PoEK1wwQnM3FNi3Ah8
 QEFbeQgY5kuKBxwT0sT92Dmbv5IN+cKgY3nsJvuLAqSwSvUbo6Yj1YgD7yZO5bGaYLLSIC9SOUk
 WWhTWEbUk8KmtA7JWzNrycbpa0GYXqdl+cwvX+UUpRvyDhxQQwxuVy8siNAd1CNfrZ3tpgKOc6m
 RfTJm7J5q6ws5pv9SrI8DJU4xd8P4lGv1eDIXy93Obz1GtxVuAdhziJrRVcoYS8ahbnX9F743/R
 YCGeB1FWDKDaRhrJ8H6wI/DMv35CptIVJy/D/BsS8BokvwWGXgOXC9A==
X-Received: by 2002:a05:7022:b04b:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-14f56063178mr5259965c88.0.1790956058416; Fri, 02 Oct 2026
 08:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <ar-GzWfyQMeRTRCt@sig21.net>
In-Reply-To: <ar-GzWfyQMeRTRCt@sig21.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 11:47:26 -0400
X-Gm-Features: AclHuK_H9G69qh-U9t9OWIH05C5M1tNbCZij3V2y__uhQx9HTkLt6JPJQq8yHfA
Message-ID: <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
To: Johannes Stezenbach <js@sig21.net>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

+ Mario

On Fri, Oct 2, 2026 at 8:52=E2=80=AFAM Johannes Stezenbach <js@sig21.net> w=
rote:
>
> Hi,
>
> I have one Asrock Deskmini X600 with Ryzen 8700G.
> Recently a BIOS update was released which updates
> AGESA ComboAM5 from 1.2.0.3g to  1.3.0.1a.
>
> https://www.asrock.com/nettop/AMD/DeskMini%20X600%20Series/index.asp#BIOS
>
> The result is boot failure before any message could be printed
> with my self-built kernel, which has the amdgpu driver built-in.
> However, a Debian rescue image with kernel 7.2.8 could boot
> (in text mode or vesa graphics mode).
>
> Using the rescue system, I installed the Debian kernel 7.2.8,
> it can boot but hangs after the amdgpu module is loaded
> (no error message or crash output).
> It can boot successfully with module_blacklist=3Damdgpu.
>
> https://packages.debian.org/forky/linux-image-7.2.8+deb14-amd64
>
> If you have any ideas what to try please let me know soon,
> otherwise I'll have to downgrade to the previous BIOS version.

Can you get ssh access to the system?  Can you boot without amdgpu and
then log in remotely and manually load amdgpu and get the dmesg
output?

Alex
