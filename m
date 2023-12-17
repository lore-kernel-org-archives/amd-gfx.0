Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A14EC35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57E110E2CD;
	Mon, 18 Dec 2023 18:23:47 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0F810E15B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:22:02 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-5909156aea9so700797eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702923722; x=1703528522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m+jVYqp6EcLXJ5MZmOR+viJOCSvxMGKIzUXoWZT6+4=;
 b=W9/vsaQBzOvzMXLsUCXz19CDPCZQVyFRGV04N88cvDVKW74up+XS8+L7SIhefbtta6
 +vDgtd32xRvcmzDU0O5q70vDwablhir2Od7fP6GEyz7l89mR5g5ZVSGqsiJ9pGygzsXy
 ZxQ3mL9fxXBXImD0twCmrTMiMqSbcB41lMNtSL2I0EvBQgIPjwj2dMiM2R+o22+KEMiT
 J12MG4xkZDZ7vsdxPCf/lm8qCO6sLNSZNs1sghJDcQnZoR2XdXPnLvlEVHjwcZYtz7oT
 RtlzMSozi8u6i6BgQUMQ/eUIcNkGgDuujZq2CYY0VWj7A8XZf4mxWrRYTH37bIz2td75
 YIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702923722; x=1703528522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m+jVYqp6EcLXJ5MZmOR+viJOCSvxMGKIzUXoWZT6+4=;
 b=Rx/va11t5jQdCzeuOEz6R2BPQ4qFijVMS4nPstMrtXZ/jVu9vrIQ78xeT+Rd6Bf3U1
 2tAGEnjIkx1hMIFTuqGzuwlneb/xY3T0IngM4Cs/rxitzLUoeWj9qONUOSBj78fkpvzN
 UDJ0Qmi+ciHXQmxIyxle9kkcIVoQ/Uatoox9OuA3HKvGeXeVQ3KlE0QAW4k0CCl/v3vj
 ZRHYxy5b2tnwPF2je3q5dtBFqkgPQbfAA1cqFbChLKoW6LwK235AuKw36Hr+wrMg/3H9
 KHOpn8xBNDfVjNmgZy/C2PTQ/1Efhqu1bOPKvFH+8S298uAvIGABmbxFrTN9AjssGo4R
 rYlQ==
X-Gm-Message-State: AOJu0YwBDIkQCGR6erlrQ62Q8oLwJu87TV6vtKkASnxr2oSmMAKGYkI1
 TgEb/uIdcbXnX3FS1TnyZryYLVmE0w28pFyPVj17cNvo3Jd2VYlRgAo=
X-Google-Smtp-Source: AGHT+IGwtlG0iYeuePZ8xUWo+zC56EnNODNKOb/8LKp9UBeZ8RrgL2+kY3r7chk8zMGQcxxG2CcbKZdqmnp8p9LKCDQ=
X-Received: by 2002:ad4:5228:0:b0:67a:a601:ce4 with SMTP id
 r8-20020ad45228000000b0067aa6010ce4mr27159450qvq.6.1702849175956; Sun, 17 Dec
 2023 13:39:35 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
In-Reply-To: <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 18 Dec 2023 02:39:25 +0500
Message-ID: <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, daniel.wheeler@amd.com,
 hersenxs.wu@amd.com, alvin.lee2@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 15, 2023 at 9:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> Can you try the following patch with old fw (version 0x07002100 should
> be fine)?: https://patchwork.freedesktop.org/patch/572298/
>

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> on 7900XTX hardw=
are.

Can I ask?
What does SubVP actually do?
I read on Phoronix that this is new feature of DCN 3.2 hardware
https://www.phoronix.com/news/AMDGPU-Linux-6.5-Improvements
But I didn't notice that anything began to work better after enabling
this feature.
On the contrary, my kernel logs began to become overgrown with
unpleasant errors.
See here: https://gitlab.freedesktop.org/drm/amd/-/issues/2796
I bisected this issue and bisect heads me to commit
299004271cbf0315da327c4bd67aec3e7041cb32 which enables SubVP high
refresh rate.
But without SubVP I also had 120Hz and 4K. So I ask again what is the
profit of SubVP?

--=20
Best Regards,
Mike Gavrilov.
