Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C99D3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 21:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CBE10E121;
	Mon,  8 Dec 2025 21:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P62WpRas";
	dkim-atps=neutral
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B1910E121
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 21:12:23 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7c7533dbd87so4347143a34.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 13:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765228342; x=1765833142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVchRNSAVk+6iwTWpYx/JBJ0UCUEFaj4eH4TDPDhTNk=;
 b=P62WpRas7T5nWZnNqaUlm4ALeR6QlrmslwvMcUYEIrIeKEvBDsBOoXXw0rwAOypOXG
 Cg/pfLjlBe0MgFb3BaKBRSiSssfHM4xC72YCrqj4dtUJscbY1TScw7zqG+EggEMoxznm
 KCiT5yUZVBtOJJeM5LTSkIECIdjjlC9rmfOwj791QDNE1KTKbdqGliyEN2p8lLXgUa9A
 K3zWNe0IfYgjwBrsGOiOs//VrzUG3sFY3viEer/rgl+gtBcBrqMAgC0y9jiD5x8XQlFf
 Xt/ZY8xEx6sqtf0gP9eWd2vbOcN+BdeFIE4MbI93Y4HnFgwX0KBHDBQsWgOC89lgRSUt
 /x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765228342; x=1765833142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CVchRNSAVk+6iwTWpYx/JBJ0UCUEFaj4eH4TDPDhTNk=;
 b=FThupcyKDvrtOrSHsq5/3LliNV1RklqqkM70WfZHyavPZ+z8EOXl2gzs3vWzFyr7Wk
 Aut6eTmZNtME96KUUZZp59Lt0pLdG+vszyPgHN/SrPZzsG6/1lpgnHJNDbawENcQceRK
 UnBuhaNYjpU82zER86kCFpGVazbILYavhNAL3HuWHTD1+esWdw4kERAc/vQ7V0w0c0dD
 y65NXUt+n1pb4xyFj+//NLgJw45gz1/fIp7nGecxxXAvqi5sReQs3juKfHKQXuTfT3bU
 cRFXReP1CUTNkIfFzK51tSBhPfpP9Pi2qPd5OIewk7adAOdoBzifoumaKYwYeiRK9+C0
 saBA==
X-Gm-Message-State: AOJu0YxJgJebOBljLVb2cOutjmHuiUhvwCMubISfuKpGFG2k8oxDfl2I
 YI2yZzgAQ0fPweR9kTARzNmkxUuXrcoIdUnxyW4JPFGIS+8+JvXJy1QZplIO2r8ZQnybGwqZafK
 OKLckeg+fqrh/E9ip4ZW9dfyKbdN28VM=
X-Gm-Gg: ASbGnctm24dk0HFMh9CgdFYcNReB21QAHln7b79CJs1ZJCegg5NqtlVFV380P87v19X
 gjuAIhmw/lq90qK28QkkRSvQ8Zi9asqsCsHkCdxTBjVbDiae0KvEHtRg3VM+/KT4XnOvpDTzZby
 EbMgiXzS9U1aFj82UZQteqTNkbOJ5ksMfBynmbaKCbmH4CqoMCBxdQXzd4Y8PGSmsXq6OQv6F4g
 7hy9+MKKsAe5KqAcb1BJfK+NW5TV2/cm6IVHfDdwXWLZz38op1DiEyhQjqmv2+ju9lOSIBG
X-Google-Smtp-Source: AGHT+IHjzqSYvkWNC8UA83ODw1D1W+kRbDIvyDo3BQLtXIOm0qn7MvPXU2YkWwz2n2gbbUddfUySRjxMynMMnxTxGcw=
X-Received: by 2002:a05:6830:3817:b0:7c7:1f5:28a with SMTP id
 46e09a7af769-7c970789028mr4818517a34.12.1765228342564; Mon, 08 Dec 2025
 13:12:22 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
 <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
 <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
In-Reply-To: <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Mon, 8 Dec 2025 16:12:11 -0500
X-Gm-Features: AQt7F2oc5KGddL4gdf3glzkJEiy8nR8-UqRGtRc3inuaXz7pC4tQcVGE1T3rKew
Message-ID: <CAPEhTTGYADUKQPrF2R4NOm7sRzzpJbYVH+j3ECVyKMNHXTjiBg@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

I should have asked previously: were SI gpus based on SMU6 or are they
using SMU7?

On Mon, Dec 8, 2025 at 9:32=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Sat, Dec 6, 2025 at 11:30=E2=80=AFAM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > OK, I was hoping for a similar SMU7 implementation never completed.
> >
> > I see both VDDC and VDDCI (for Evergreen+) values available. When
> > looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
> > (and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn't
> > it?
>
> Yes.
>
> >
> > What would VDDCI correspond to? I mean, how should it be displayed
> > (maybe it has its specific inX_label)?
>
> I don't recall off hand what voltage domain VDDCI was off hand.  I
> think it may have been the memory interface.  I'll see if I can dig it
> up.
>
> Alex

Thanks
Alexandre
>
> >
> > Cheers,
> > Alexandre
> >
> > On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> > > <alexandre.f.demers@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I was wondering if SI GPUs support reporting power and voltage valu=
es
> > > > at the hardware level? I read somewhere that it was supported from
> > > > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > > > generations. Going through the register names, I wasn't able to
> > > > identify any who may correspond to power or voltage level.
> > > >
> > > > So I'm asking, just in case it is supported and I missed the
> > > > information while searching for it.
> > >
> > > Correct.  There is no interface to query the power.  For voltages you
> > > can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the curren=
t
> > > DPM level and then convert that into struct si_ps to look up the
> > > voltages, similar to what is done for sclk and mclk.  See
> > > si_dpm_read_sensor().
> > >
> > > Alex
