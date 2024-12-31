Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90242E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2024 12:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FA810E66D;
	Tue, 31 Dec 2024 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/+aOLxV";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C570C10E66D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 12:43:50 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so7114973f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2024 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735648969; x=1736253769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzR5Q8hqCauRZLsysEvoLuXhgbLUKt8HPQwaPffhcWM=;
 b=Y/+aOLxVlkNMt842DEvTIA86BmmS5jcwT87cV3O9loNOSp43QRw7AA073SAz3YX9pm
 euIZ7OoqfxFIqBqaGls4Dkf6oqWDs9KDkhivm+LrytcFu5rkLirFA/x+9I1y4kWWPyC1
 LtvbwL6M+LFT3Xqbfzlu6ZaqtqfW06VGWHlB0jcYWjyyCc9qZSush+C7MFaq1uGZMWyp
 u9arPsqnPErq3ji77eKUM/QTcC0jqb4Gy0y42FUCvPEFx+km9UOGx1L6WBgqtibDQWob
 uCZ9LluAQ/YethBrAAWdJl+T/WL91lO44VROvHVL4pUluWLR55H/x0l1JpG8KGNAXikw
 mGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735648969; x=1736253769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzR5Q8hqCauRZLsysEvoLuXhgbLUKt8HPQwaPffhcWM=;
 b=vwM19ybK7OIWbRjrjsjDZLESv+qUfdogqnrk22a7D0L4eBtry0jyfnPqbwy6XyiTEf
 IzXSbi7AI3VLDjG/5wWSO0q1sqEpRAg+0kGQBit1Y3rxE/l1mBVqwTO70BgJaGpQDOEE
 TRhZ6OzHHoBM+/Z3hmSGobJt6njS/7FwxJM3rwbJVCfNxuv9l/PKgPeHRN2uqK7kMNKx
 uLW5VpBgdxxcZ7A+18QF23unpWsmAo0FWWY1nLAZ33/7G9RqaVGaTaSRlfGSVMs0o7GX
 knxjkc2HcmfEL6fkhESq32ih9seZHnS+BIZ3FEvV1buAQZUxbmAICYBty3+18SeFxo52
 lv3w==
X-Gm-Message-State: AOJu0YxypMK6pwbdBnMKg7g8BE3p4hMrNEarHGZXqpHUeYU67SYgNm6O
 +1Xc7C+Up6d9sAsuAnTViIKHJwjZXoOKacLlZ0VxVoO6sV5DHVSdBM7NZMpClA00yWOc2r/0ev0
 KHjIW8hNnoFZ1LNKxb76kcSBnkqnSkS0vF5Q=
X-Gm-Gg: ASbGncsPzyzmPkN+kh+pRHI0iSI3pazNbwL8lrKtUnBbwAf5E0Nu9w36nBgTHzT8WTk
 Bwxjd0MWlUEPQvgiGO1PIPMFfr7jqgHPARFZGc0Y=
X-Google-Smtp-Source: AGHT+IEhI0zKiijGjDOL8Lq1FoSUbtMIi/uYosF6aP4slKVZRNJ75Q+DdZqAvLabX4qNNqZjg9fb0pABQK125+hzCxs=
X-Received: by 2002:a5d:5e09:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38a223fd417mr41474396f8f.55.1735648968961; Tue, 31 Dec 2024
 04:42:48 -0800 (PST)
MIME-Version: 1.0
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
In-Reply-To: <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
From: Mischa Baars <mjbaars1977.backup@gmail.com>
Date: Tue, 31 Dec 2024 13:42:38 +0100
Message-ID: <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
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

Hi Mario,

Although unconfirmed by their website, the rumour goes that the HDMI
Forum will release a 2.2 specification somewhere in Januari. Do you
think that an open source 2.1 implementation will be allowed soon
after?

In the meantime I also checked the framerate synchronization through
glxgears at different resolutions and framerates. This does function
as expected. Although I haven't yet inspected the glxgears source
codes in detail, the OpenGL double buffering must be functional up to
some level. This means that the problem must be confined to GTK and
the GtkGLArea widget. Using GDK_BACKEND=3Dx11 I do get a double buffered
context, but the default buffer does not alternate between GL_FRONT
and GL_BACK.

Enjoy new year's eve!

Regards,
Mischa.

On Wed, Oct 23, 2024 at 6:16=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 10/23/2024 11:12, Mischa Baars wrote:
> >> I certainly don't have a crystal ball, but I try to avoid saying thing=
s
> >> like "never" or "for sure" in non-ephemeral contexts like mailing list=
s.
> >
> > I understand. I'll concentrate on different aspects of testing the
> > connection with this TV, like gdk_monitor_get_description(...) doesn't
> > return a valid description when the application is started with
> > GDK_BACKEND=3Dx11. I also have less trivial questions about the ancient
> > and seemingly long forgotten concept of page flipping. I'll think of
> > something to do.
> >
> > Thank you for your help.
> >
>
> OK, If you have more questions about other things that come up along the
> way feel free to raise them on amd-gfx.
>
>
