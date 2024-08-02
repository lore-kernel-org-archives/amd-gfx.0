Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F45C52D70
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 16:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0396210E0D4;
	Fri,  2 Aug 2024 16:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JE/8iBSc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A829A10E0D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722615747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vi6n1fL4oqLRoS8yugjJmnCla/husXgdjSFAHpyvCzk=;
 b=JE/8iBScYR2Lzy100sB3cFeE+8H4mn+iutlfGfLsf8CMVOjxg8D+Nmusv1JD/SOaRUfpoI
 YEOMmluPDmITvOdluQGnC2l15XnVtetjZdO/AMwQT0QkqsXlK1rMLE3Ryyij4njtUoUnv5
 Fw/e+TxJRTAMLgLTY/dsRW6OMbQXoew=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-rTI-Nz0UOGqwEZmn8DxI8A-1; Fri, 02 Aug 2024 12:22:25 -0400
X-MC-Unique: rTI-Nz0UOGqwEZmn8DxI8A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52f00bde210so9250009e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Aug 2024 09:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615744; x=1723220544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vi6n1fL4oqLRoS8yugjJmnCla/husXgdjSFAHpyvCzk=;
 b=LTdw5q4RXmOjgKqWN9BVGgyOxeis8frF/2+urrjKnz/mZIbbRck+4t6KHuqVMxAUV+
 bWB42iWBMdcySytiwIXzjNEt6QgP6hf2S2Xpm1jrpzPeW+/PFQbdLX+D81oYBLgt1OI1
 INtJyRahVfSMO303Dq68LNPA4k2dv5NjZxdx2qGqVZt1Q7faejndulL3TMQdnDsVlWXN
 pETVB8KmZ3ezXPd95lMIayLfRLr8MsXxTcRzKnJRXkCNc6GASrt57+i0NfHZANBkRl/b
 EqHms1ggQA3gadafbbFT0S2o4DJUJln2N0XgzjYVIrLJTv4qj9OGQs9o6Z9wBpkqpPQn
 WpmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw1awHt7ZonOZ9YIShah78YGux/Vzru91bxrG3A2tMicXRB462mPNYCdZdRRPeQUkIEDjpjMi4/68FLb8LzYaNd1amsRIbZ0SLSXSqWQ==
X-Gm-Message-State: AOJu0Yxo6wF9bUbdr8g15baO56iXXoXhcJ2MEQvFMVxvdQ5Al7ZZ+Tq9
 BawC6177Xcy8DnOtkKAHV/sNAZBo1iBeNbGZrv4p4MDP2tIb4gNwCe1ZStBQC9d9Um4z+f8YzQY
 BH58X0dsCF3YKgdz68pPheL1P9/AJvnGjd+Z0XgES5GWoxUybFmw33Z0h97D1H4eTbrbSqfvIMV
 hvw+ziPwL0LAnJVYq2NYifw5w+toR6POtuXqZFBA==
X-Received: by 2002:a05:6512:3a87:b0:530:a9fe:7bb6 with SMTP id
 2adb3069b0e04-530bb38147dmr2600049e87.30.1722615743640; 
 Fri, 02 Aug 2024 09:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/xZZvFMbxp/6gtymqdyIjas+EN6FSzQxoTRLla/QplBZF15L6JpCEcxfPVbsoMpfu+RF9os4Ix87D8wxz9zA=
X-Received: by 2002:a05:6512:3a87:b0:530:a9fe:7bb6 with SMTP id
 2adb3069b0e04-530bb38147dmr2600023e87.30.1722615743003; Fri, 02 Aug 2024
 09:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240606020404.210989-1-mario.limonciello@amd.com>
 <20240606020404.210989-3-mario.limonciello@amd.com>
 <bc1d81ef-d9d0-4440-b63f-ecfb735ef783@amd.com>
 <d637d3c2-34f7-42f8-acbb-6a1730d3fc3c@amd.com>
 <CAFZQkGy0xuuUw73HQvS8Ce92sUi2rVrRnX25pi1KdNmyQbtBZA@mail.gmail.com>
 <CAFZQkGz8DeoiVX2MohoBoTMxraJk1Ou41N_wKP3GkqRrPg_6sg@mail.gmail.com>
 <87wml0v2vv.fsf@intel.com>
 <CAFZQkGx=Q0W2r6XWxovt90WkBC5CUg7_X2fM7ZicSOALUg8yJg@mail.gmail.com>
 <CA+hFU4w8kR1XjAZgXeUd7Z-pWDWn3yAv59HBr8o0iGhYruUssw@mail.gmail.com>
 <ce4ce642-39ba-4153-8838-039d8a88c07e@amd.com>
In-Reply-To: <ce4ce642-39ba-4153-8838-039d8a88c07e@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 2 Aug 2024 18:22:11 +0200
Message-ID: <CA+hFU4yu7pfMhP7QHn0G9Jf3XEVz=jq1emPVR1tnFEsNUtawjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amd: Add power_saving_policy drm property to
 eDP connectors
To: Harry Wentland <harry.wentland@amd.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
 dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@google.com>
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

On Fri, Aug 2, 2024 at 4:37=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om> wrote:
>
> On 2024-08-02 09:28, Sebastian Wick wrote:
> > I'm very unhappy about how this has played out.
> >
> > We have a new sysfs property that controls a feature of the display
> > path that has been set to a default(!) which changes the color
> > behavior! This broke color management for everyone who is on a device
> > which supports this feature.
> >
>
> Has this been a problem that people have noticed or complained about?
> Are there bug reports?

Yes. Even worse, it's not obvious to people that something is broken,
where it is broken and why it is broken.

https://gitlab.gnome.org/GNOME/mutter/-/issues/3589

>
> AFAIK the default is "off" and PPD will enable ABM if in power or
> balanced mode and on battery.
>
> > What should have been done is the following:
> >
> > * add the KMS property and have it default to "sysfs cannot override th=
is"
> > * add the sysfs property after the KMS property has been introduced so
> > it stays disabled by default
> > * add support for the new property in compositors and let them enable
> > this feature only when they allow colors to randomly get broken
> >
> > Every other path results in broken colors at least temporarily and is
> > breaking user space! The sysfs property *must* be reverted because it
> > breaks user space. The KMS property *must* be reverted because it
> > didn't meet the merging criteria.
> >
>
> I agree we should revert the KMS property until we have a userspace
> implementation that is reviewed and ready to be merged. It was merged
> based on a misunderstanding and shouldn't have been merged.
>
> I don't think we should revert the sysfs property. The power savings to
> end-users can be significant. I would like to see compositors take
> control if it via the KMS property.

If this was just a KMS property then I wouldn't have anything to
complain about. The problem here is the sysfs / PPD thing.

> > Another note: The only way to make sure that this isn't breaking user
> > space is if user space tells the kernel that this is okay. This means
> > that the sysfs property can only be used if the compositor grows
> > support for the new KMS property and at that point, why do we have the
> > sysfs property?
> >
>
> We have a good handful of widely used compositors. We have one PPD
> with a replacement for it in the works. A sysfs allows all users
> to get the power benefits even if compositors don't explicitly
> enable support for power saving features in KMS. The goal of PPD
> and co. is power savings while that is not always a primary goal
> for all compositors (even though compositors play a large role in
> a system's power usage).

The problem is that if the compositor didn't explicitly opt-in, then
it can break something (and it actually did). I appreciate the intent
(enabling it as broadly as possible) but the only way I can see how
you can enable feature at all is by somehow doing it per-compositor.

Given all of that, there shouldn't be a sysfs property (you should
revert this!) but it should be yet another KMS property.

> Harry
>
> > On Fri, Aug 2, 2024 at 2:49=E2=80=AFPM Xaver Hugl <xaver.hugl@gmail.com=
> wrote:
> >>
> >> Am Do., 1. Aug. 2024 um 14:34 Uhr schrieb Jani Nikula
> >> <jani.nikula@linux.intel.com>:
> >>>
> >>> On Mon, 01 Jul 2024, Xaver Hugl <xaver.hugl@gmail.com> wrote:
> >>>> Am Do., 20. Juni 2024 um 22:22 Uhr schrieb Xaver Hugl <xaver.hugl@gm=
ail.com>:
> >>>>> Merging can only happen once a real world userspace application has
> >>>>> implemented support for it. I'll try to do that sometime next week =
in
> >>>>> KWin
> >>>>
> >>>> Here's the promised implementation:
> >>>> https://invent.kde.org/plasma/kwin/-/merge_requests/6028
> >>>
> >>> The requirement is that the userspace patches must be reviewed and re=
ady
> >>> for merging into a suitable and canonical upstream project.
> >>>
> >>> Are they?
> >>
> >> I've talked about the property with other KWin developers before, but
> >> there's indeed no official review for the MR yet.
> >> As some new discussions about alternative approaches have started as
> >> well, maybe it should be reverted until we're more certain about how
> >> to proceed?
> >>
> >>> BR,
> >>> Jani.
> >>>
> >>>
> >>>>
> >>>> In testing with the patches on top of kernel 6.9.6, setting the
> >>>> property to `Require color accuracy` makes the sysfs file correctly
> >>>> report "Device or resource busy" when trying to change the power
> >>>> saving level, but setting the property to zero doesn't really work.
> >>>> Once KWin sets the property to zero, changing the power saving level
> >>>> "works" but the screen blanks for a moment (might just be a single
> >>>> frame) and reading from the file returns zero again, with the visual=
s
> >>>> and backlight level unchanged as well.
> >>>
> >>> --
> >>> Jani Nikula, Intel
> >>
> >
>

