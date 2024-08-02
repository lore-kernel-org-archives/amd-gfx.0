Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B69C52D6D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 13:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BDE10E0BC;
	Fri,  2 Aug 2024 13:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hAIoo7eB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEB710E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722605353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jby6eZfb7DqV7eZt+nmBEx3PMtN18CphSR8+OwRmzkA=;
 b=hAIoo7eBZto2cN1FMhwA9gpdfxYc37gdU5cuxr9xLHmMDQNvA+wqcMiMkh01UkjmmTQ65e
 sQvxzBU4WR7DLL6C2tfTOD26YRHAoiSIhDmjpu1ldR0VPgoavGk26InipLpPwALxeZsg80
 Xst0JNvoETEZkyEfsjPj/NN8FEHUYZE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-jO5QmCiTNrWIJQRi5m2B4A-1; Fri, 02 Aug 2024 09:29:10 -0400
X-MC-Unique: jO5QmCiTNrWIJQRi5m2B4A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52efe4c2372so9382354e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Aug 2024 06:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605348; x=1723210148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jby6eZfb7DqV7eZt+nmBEx3PMtN18CphSR8+OwRmzkA=;
 b=xLGrlCBPptzd0WOYQ196D3bA58RG/52sDCpiVYa+9Ho7Y6wbuRrePZpJNTgPW7O/mY
 YJB8TTiB9PMaXp/hFFFw0mHVqC3poDbj2e/rT2ehNOEXxw0N1jl2qUUO0LVR59OWxNfE
 MyBB9QI6O+xBlE2etZNM8RAnjEY5BbfmdoV4XLt+LsWGlolfwORLyLo3AfYAQYafTUUh
 haRjxDzn+yiksIdy3qirLFQyJac4REZyKhIk6tddo+wYTwJHYXJaxh+9Dx0IabhAj34/
 AxFeBi4QJq2/TzBx+v3FLX8dS7No9KKkaX017rBGgCOsp+uHq3nyqNjvc5prxlXbf/fs
 JxaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWty+IsOwzw9TXsKa/MoNIlxTsCXRJ7ZrIsbrBuctrJJsnnwr+c5JeMahr0Yw8rThkLs1z5z2ivl4NO6xaNNONYQwHMiLd4DwQCVmZc3Q==
X-Gm-Message-State: AOJu0Yw6dsyMakdsntf18Vo5N0jjABAITqfVsmCUC9CSI4/bCWfKZGl8
 bAvyuT570FdZU4c8bhyoGROT0YLg6RwlHq6Y5DDrak5cz5/IyjdbM7q7Ilw1FYEfM2/YcstLiGZ
 2CLBTvuQvFYucduOZf+wrRyYJfOC1XM8Zj2XFd3fc6Uh31DdBUbhJYPuv6EFCsjRhg0PL2BlroV
 Di1Ua0VSFy55Ju9zK48RE+ifNd3GlEzW9sXTYrWA==
X-Received: by 2002:a05:6512:32c7:b0:52c:d76f:7f61 with SMTP id
 2adb3069b0e04-530bb3a47f4mr2227533e87.56.1722605348462; 
 Fri, 02 Aug 2024 06:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcn6uyOfyziM/LIeOVbLKwyZwKWWQaBANaOEnc4dlTveEf6oUTMNMatPqkGNk4rLeiLcW4dTRY9yOGPPlh3s=
X-Received: by 2002:a05:6512:32c7:b0:52c:d76f:7f61 with SMTP id
 2adb3069b0e04-530bb3a47f4mr2227514e87.56.1722605347842; Fri, 02 Aug 2024
 06:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240606020404.210989-1-mario.limonciello@amd.com>
 <20240606020404.210989-3-mario.limonciello@amd.com>
 <bc1d81ef-d9d0-4440-b63f-ecfb735ef783@amd.com>
 <d637d3c2-34f7-42f8-acbb-6a1730d3fc3c@amd.com>
 <CAFZQkGy0xuuUw73HQvS8Ce92sUi2rVrRnX25pi1KdNmyQbtBZA@mail.gmail.com>
 <CAFZQkGz8DeoiVX2MohoBoTMxraJk1Ou41N_wKP3GkqRrPg_6sg@mail.gmail.com>
 <87wml0v2vv.fsf@intel.com>
 <CAFZQkGx=Q0W2r6XWxovt90WkBC5CUg7_X2fM7ZicSOALUg8yJg@mail.gmail.com>
In-Reply-To: <CAFZQkGx=Q0W2r6XWxovt90WkBC5CUg7_X2fM7ZicSOALUg8yJg@mail.gmail.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 2 Aug 2024 15:28:56 +0200
Message-ID: <CA+hFU4w8kR1XjAZgXeUd7Z-pWDWn3yAv59HBr8o0iGhYruUssw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amd: Add power_saving_policy drm property to
 eDP connectors
To: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
 Harry Wentland <Harry.Wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 Sean Paul <seanpaul@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

I'm very unhappy about how this has played out.

We have a new sysfs property that controls a feature of the display
path that has been set to a default(!) which changes the color
behavior! This broke color management for everyone who is on a device
which supports this feature.

What should have been done is the following:

* add the KMS property and have it default to "sysfs cannot override this"
* add the sysfs property after the KMS property has been introduced so
it stays disabled by default
* add support for the new property in compositors and let them enable
this feature only when they allow colors to randomly get broken

Every other path results in broken colors at least temporarily and is
breaking user space! The sysfs property *must* be reverted because it
breaks user space. The KMS property *must* be reverted because it
didn't meet the merging criteria.

Another note: The only way to make sure that this isn't breaking user
space is if user space tells the kernel that this is okay. This means
that the sysfs property can only be used if the compositor grows
support for the new KMS property and at that point, why do we have the
sysfs property?

On Fri, Aug 2, 2024 at 2:49=E2=80=AFPM Xaver Hugl <xaver.hugl@gmail.com> wr=
ote:
>
> Am Do., 1. Aug. 2024 um 14:34 Uhr schrieb Jani Nikula
> <jani.nikula@linux.intel.com>:
> >
> > On Mon, 01 Jul 2024, Xaver Hugl <xaver.hugl@gmail.com> wrote:
> > > Am Do., 20. Juni 2024 um 22:22 Uhr schrieb Xaver Hugl <xaver.hugl@gma=
il.com>:
> > >> Merging can only happen once a real world userspace application has
> > >> implemented support for it. I'll try to do that sometime next week i=
n
> > >> KWin
> > >
> > > Here's the promised implementation:
> > > https://invent.kde.org/plasma/kwin/-/merge_requests/6028
> >
> > The requirement is that the userspace patches must be reviewed and read=
y
> > for merging into a suitable and canonical upstream project.
> >
> > Are they?
>
> I've talked about the property with other KWin developers before, but
> there's indeed no official review for the MR yet.
> As some new discussions about alternative approaches have started as
> well, maybe it should be reverted until we're more certain about how
> to proceed?
>
> > BR,
> > Jani.
> >
> >
> > >
> > > In testing with the patches on top of kernel 6.9.6, setting the
> > > property to `Require color accuracy` makes the sysfs file correctly
> > > report "Device or resource busy" when trying to change the power
> > > saving level, but setting the property to zero doesn't really work.
> > > Once KWin sets the property to zero, changing the power saving level
> > > "works" but the screen blanks for a moment (might just be a single
> > > frame) and reading from the file returns zero again, with the visuals
> > > and backlight level unchanged as well.
> >
> > --
> > Jani Nikula, Intel
>

