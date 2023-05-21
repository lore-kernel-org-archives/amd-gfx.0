Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20034C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 07:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAE910E255;
	Mon, 22 May 2023 07:20:21 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9258D10E1AE
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 May 2023 04:15:41 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-ba6d024a196so4137312276.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 21:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684642540; x=1687234540;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuy/ECGdaUtkYxS8w6j0LN3puMU4yYm7CZzTCAk5FCI=;
 b=Gfk9NN3FyHKdTuW0sqwk/nGRiV8kSdICC2zCzqI8ZBKixyFcYpXPZt+tlijrSB8jsj
 35nU3m3b2OukhOJZZk6BD+tb1yo+t+s87ImZi2EEaHlmYkx+hx6trFYGDohXTwaOpmfw
 n95AsOuqBNTGWK3YgFIYu3VZiAsMLpkvxfp4V9lGoN1huhDpP2+49dhwcOH/AXGk/4WL
 k1jugUMj1fuOi51Om+Bwrkv86kH6wnkluase6gEpEdDWti9Hg7/uD3DlXn1TepH4m84G
 LKaNb4EJTK1XJ8/m4HZpr6xr7BtR0ngAN4htmLxlZN9q3OjYjS7FBF5M5ZyHDsx1fp7g
 b+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684642540; x=1687234540;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuy/ECGdaUtkYxS8w6j0LN3puMU4yYm7CZzTCAk5FCI=;
 b=KF4WH1QTzhOnMKdHBtAa1W5RyHckp/WMpboZDeK6cBYX4dFABC7arkwQjza6nQ2AQR
 F3D1+FO4IAPjHyKp4vdDqA7Pll2suvX9smShvCG/+qBieNVMf5VOW5hUuU+6uhb1FUxr
 WjggxOqiJRnrgZ7BvEN+qxAE2DG7EzhaD+cfYXB+gGQ/+t8Spv0TWBm3ETDcDkOBTlu1
 PCbOYfyGW/vw94KaH+Zr7okCMG7LjpT2LdR5h2hOxxjEexOskW7eJRJDbWv0+2oaO986
 vSpvAWwrvSD/V3Db4f11VJK0CHy2budIFj2x2ti/fds87xmO3E3RYAWbHNPbJYdeX6mH
 H1xQ==
X-Gm-Message-State: AC+VfDxmiz5n6VxQkOkixV+8WP19CIhfsSp5eyMn9+2sP5+NLif6Edho
 hxjAsL0D/NqXz41sz5WYi/aBH5+2tOR/BJqNanZ6PXrfbAA=
X-Google-Smtp-Source: ACHHUZ49QV/dAShKP/clk/nlxbFf6wHL8wEfxazjVx9pm41Y+U5gj2IQqcCl6KxlaBZf4JNsFlPOXk9pQ56EpmrnnFw=
X-Received: by 2002:a0d:d890:0:b0:561:4bcc:464f with SMTP id
 a138-20020a0dd890000000b005614bcc464fmr7590775ywe.36.1684642539769; Sat, 20
 May 2023 21:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHPMNWdWaYyQs1u=r7wt=DudxoogCOe3GL2J1UC-Gcdroa=MaA@mail.gmail.com>
In-Reply-To: <CAHPMNWdWaYyQs1u=r7wt=DudxoogCOe3GL2J1UC-Gcdroa=MaA@mail.gmail.com>
From: Neil Sikka <neilsikka@gmail.com>
Date: Sun, 21 May 2023 00:15:28 -0400
Message-ID: <CAHPMNWeoNACjDh8AYWDvchXc8t9wHh3Gu+qriaWs0b9tHbxn1A@mail.gmail.com>
Subject: Re: Radeon Driver Crash
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 22 May 2023 07:20:19 +0000
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

I also crossposted here upon request:
https://gitlab.freedesktop.org/drm/amd/-/issues/2571

On Fri, May 19, 2023 at 6:36=E2=80=AFPM Neil Sikka <neilsikka@gmail.com> wr=
ote:
>
> Hello, I just filed a bug for the Radeon driver crashing:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217464
>
> It looks similar to this bug
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D198669) because they are
> both locking up the GPU and the page fault address is at the same page
> offset of 0xffc, which might mean its the same structure member that
> is being dereferenced (or an underflow), and the call stack is
> similar.
>
> Please let me know if you need any more information.
>
> Thanks!
>
> --
> My Blog: http://www.neilscomputerblog.blogspot.com/
> Twitter: @neilsikka



--=20
My Blog: http://www.neilscomputerblog.blogspot.com/
Twitter: @neilsikka
