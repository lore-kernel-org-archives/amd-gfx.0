Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC17DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 12:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6941E10FA01;
	Tue,  3 May 2022 12:26:08 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDEB10FA01
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 12:26:06 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-2f7b815ac06so177734897b3.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 May 2022 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/kdLTIP5KWv/w0AGbW53dgxr50ylE5lpuqrP/XFE1k0=;
 b=sZ1hgtTI7fxvaZ0k0uOV0GVYFCdwj7DY7WyRTiIERlNBLwVMA0aHkM9eKI80hA90uD
 TXVIUXOGNCaChIHkrDbRhvfjvJ0FLlxpCu/9Fcn4eqBj6GWfHbSOtkkgrbdVdckmuHJO
 QMdo8MDD6ZfD78z6MNJYaz4rHtJumcdPKAyidpPq6G6BV//fDOirycvGWFrXm7CGonHd
 jdt8JKOKbEldXBTe+9cfzR5GgqTyKwjsF2/aeOcX/05Xhs9WsVZW9XRZwxak4N+E2GlS
 VCEGLtHKm24ij5PYMb7kqfkjC9t8ITlg/FFNoZl2N4ZKuZ9lIWVaA4+F+58PlU6+2wEs
 L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/kdLTIP5KWv/w0AGbW53dgxr50ylE5lpuqrP/XFE1k0=;
 b=ufytMvLj1zCsMKjty1ME1zeZyvrdden2LI93bi9lQAPCAV2N8/MsVnDSTcEWotWcHc
 atrMDR4LQ5UroAtbS6GkSXKpVdOcFPCJySPwRqn9+c9BkAobWAFxJsd6LiQPLoj9DgZK
 orTDFpb4rbnD29OLmjyyZZhmvd8TtkKCZCAZwNTJdElZCT1msGjigHMhU+siPhYd9Vs8
 qEbTwdQ6rJ7MVRvO+I0jwenrS7tV81VeGgLC54XsMXwuVkh/mcS8Y+3bm1JvIEFqskij
 qbGn9wsjdoinTAR75Uv7Siws5Ep7bra55T7UbA+837N/74FO+tZq9YPFJTHZ3HsvNB/N
 0pRw==
X-Gm-Message-State: AOAM532IR3tr01z+UXdOIXJ8+G5Nm53OdYRQwrnPScysrmxNix6j3H5W
 PN2pbjX+319EYczid2bkcDfLX9EzTdpRMaSBbCduig==
X-Google-Smtp-Source: ABdhPJy748BeoJGvdERlz6RifdnU94P5oaWHAfAf55iJWUIXN/sTYUf3fG9793RzhGeYw55AQSLOvtiy7IjggXp0lMY=
X-Received: by 2002:a0d:e5c6:0:b0:2f8:c866:7af9 with SMTP id
 o189-20020a0de5c6000000b002f8c8667af9mr15130119ywe.268.1651580765968; Tue, 03
 May 2022 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220412215000.897344-1-richard.gong@amd.com>
 <d4ba3998-34aa-86d2-bde9-bc6ae9d8d08d@molgen.mpg.de>
 <CADnq5_MgvcGPWf2gYn_3qCr+Gq1P39tvv-W-o8NhivvMpMwUBA@mail.gmail.com>
 <91e916e3-d793-b814-6cbf-abee0667f5f8@molgen.mpg.de>
 <94fd858d-1792-9c05-b5c6-1b028427687d@amd.com>
 <efc1dfd1-2b54-aee5-1497-4b800a468141@molgen.mpg.de>
 <237da02b-0ed8-6b1c-3eaf-5574aab4f13f@amd.com>
 <294555b4-2d1b-270f-6682-3a17e9df133c@molgen.mpg.de>
 <5adfe067-dc00-6567-e218-c5c68670cf5b@amd.com>
 <543a9e76-ca90-984b-b155-a0647cdeacff@molgen.mpg.de>
In-Reply-To: <543a9e76-ca90-984b-b155-a0647cdeacff@molgen.mpg.de>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 3 May 2022 13:25:53 +0100
Message-ID: <CAPj87rOERk-kNa6n-UdjQsDKXP9zzm8=an=FHcM+33yebW6ECw@mail.gmail.com>
Subject: Re: [PATCHv4] drm/amdgpu: disable ASPM on Intel Alder Lake based
 systems
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: Dave Airlie <airlied@linux.ie>, Richard Gong <richard.gong@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, 1 May 2022 at 08:08, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Am 26.04.22 um 15:53 schrieb Gong, Richard:
> > I think so. We captured dmesg log.
>
> Then the (whole) system did *not* freeze, if you could still log in
> (maybe over network) and execute `dmesg`. Please also paste the
> amdgpu(?) error logs in the commit message.
>
> > As mentioned early we need support from Intel on how to get ASPM working
> > for VI generation on Intel Alder Lake, but we don't know where things
> > currently stand.
>
> Who is working on this, and knows?

This has gone beyond the point of a reasonable request. The amount of
detail you're demanding is completely unnecessary.
