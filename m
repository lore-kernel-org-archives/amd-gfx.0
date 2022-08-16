Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DCDC28B2B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 13:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBC1A9919;
	Tue, 16 Aug 2022 13:06:47 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AA39019E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 13:06:37 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id o184so11932253oif.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=E/jHs13Z6JstU50hsR05SVnRuktMwvVWg9BTbSuNvLI=;
 b=RFW43fG7h+9ly2vZ0BAj0Rbw/RNh8+DamcRTE4qoxvihLooQ3cDIWCDzW9rZ3xmqW9
 Q9AclRpQfTeID1QoTaXc4yLde7XQu7I6kfgggzwlS8BQcFx/aly6HmvBDb0hgfTkH4wQ
 JveBG1XRsMEmc3++NqinEWq/PO+USkPASveCGa+kI9GkmsjDDCZgawUZp7OP37zGlC8Q
 I3heLiHH/5zlEgDIKTvTXEp9NDXPu98oZgs47/bJDt8QWECNbBVxkL6fVU5KLL+IgIUo
 wW6ioS1uIyr3OH8KMhfPkPrpnPbx375leFLiMmAOVc3S2n7etJGtDjm1kM5KvUIx5pG4
 6r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=E/jHs13Z6JstU50hsR05SVnRuktMwvVWg9BTbSuNvLI=;
 b=KDQ72bKIIbFSjsWiJxzwKEnnriKBUIQWVtrpBc4OeCimIoRYjt38IFxJTDEjh6djVI
 /BhWJTokYSQjcEgRHyEysed2H1RgBoL2rIoIMSCBq/MP9ihmBz0vyySFZ4PqqZaXKZjM
 u8o+dX1ay3PmJdep6oUs/sUgOwu2bsjKS55isceCQ3EvMpYXVDMssRQAHIR+HnW3D9a4
 HeM9uCiezDGrk+E1dyiloHfeTpZ59IHLsUYnkVKnO9ZRRt0rMgufWwDSu9Ig+uHDuh26
 QbKz7X7XCARoQ58yaIPs7/75oLmLMu8uAeXjt/xvKQWZiZajMr4CleLDuTZ2r3Xxpe4i
 FXgw==
X-Gm-Message-State: ACgBeo0/e63xG1Ho0V9JCEeyhqHnNX5ncgtOeYxNgygg02+ZiB4MF9yx
 hNfim8yB1CNi5P1ISgLl99z4FTYQ6WnxYA2qxSI=
X-Google-Smtp-Source: AA6agR5OsHNMsQGl9BeeGZL/XjtEd28lzEu5Eb6Oa8q8c2n8wsQzOJSP9mWW1/OmR1JBssfulKeEeq3Ad40muZfDsIo=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr8453398oiv.33.1660655196123; Tue, 16
 Aug 2022 06:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220811154819.3566210-1-Rodrigo.Siqueira@amd.com>
 <20220811154819.3566210-2-Rodrigo.Siqueira@amd.com>
 <DM5PR12MB130852E9DF9AFD42861235B185649@DM5PR12MB1308.namprd12.prod.outlook.com>
 <9ea11548-0c86-21d5-517f-0fbe263c3f72@amd.com>
In-Reply-To: <9ea11548-0c86-21d5-517f-0fbe263c3f72@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Aug 2022 09:06:24 -0400
Message-ID: <CADnq5_Otp4gH6epMcdUmqjQ_e0rrfL4GtyHOwKWTzmv9RTr83A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/gpu: Add info table for ASICs
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
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
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, "Hung,
 Alex" <Alex.Hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>, Simon Ser <contact@emersion.fr>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sean Paul <seanpaul@chromium.org>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 3:45 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
> Hi Kent,
>
> First of all, thanks for your feedback.
> See my comments inline.
>
> On 2022-08-11 12:02, Russell, Kent wrote:
> > [AMD Official Use Only - General]
> >
> > I noticed that you added DCE and VCE/UVD prefixes in the columns, but n=
ot GC or SDMA.
> > E.g.
> >     CHIP                  DCE      GC             VCE                  =
         SDMA
> >   BONAIRE      DCE 8  7        VCE 2 / UVD 4.2        1
> >
>
> Are you referencing when I added it in some specific lines? If so, I
> added it because we may have a different architecture for the same area.
> For example, DCE is our old display architecture, and we replaced it
> with DCN. That's why I added DCE/DCN in the label, and in the ASIC
> description, I specify if it is a DCE or DCN.
>
> > For consistency, should we drop the DCE/VCE/UVD prefixes and add a sepa=
rate UVD column, so it's just:
>
> Iirc UVD is the previous version of VCE; in that case, I think they
> should be grouped. Or is UVD a different component?

DCE was the old display IP and it was replaced with DCN.  UVD/VCE
where the old video decode/encode IPs and they were replaced with VCN.

>
> >     CHIP                  DCE      GC           VCE    UVD    SDMA
> >   BONAIRE      8      7       VCE 2   4.2     1
> > ? I know that from a compute perspective, I'd like to have the columns =
represent the fields, so there's less to parse through, but I am not a disp=
lay guy so the DCE/VCE/UVD relationship is a mystery to me.
> >
> > Also, for VG10 you have SDMA 4.0.0, but Polaris it's SDMA 3 . Again, ju=
st consistency with trailing decimals. I don't know if that's just because =
we didn't do point releases on SDMA <4 or whatnot, but it's something I obs=
erved.
>
> I also don't know if we have a good reason for not using the decimal
> part, but I can add it to all components if it makes sense. Maybe Alex kn=
ow?

The old parts didn't really have well enumerated IP minor versions
like we do today.  We could make up minor/rev numbers, but we don't
really have them in most cases.  We could do something like 8.x or 7.x
if you think that is clearer.

Alex

>
> Thanks
> Siqueira
>
> >
> > I am not staunchly steadfast one way or another, I just wanted to hear =
rationale for it. Especially if we're maintaining it going forward, and for=
 when someone inevitably starts parsing it via automated script and needs c=
onsistency. If you're confident in the format and can justify it, then that=
's sufficient for me.
> >
> >   Kent
> >
> >> -----Original Message-----
> >> From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
> >> Sent: Thursday, August 11, 2022 11:48 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas
> >> <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet
> >> <Bhawanpreet.Lakha@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>;
> >> Hung, Alex <Alex.Hung@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-
> >> eric.Pelloux-prayer@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> >> Simon Ser <contact@emersion.fr>; Pekka Paalanen
> >> <pekka.paalanen@collabora.com>; Sean Paul <seanpaul@chromium.org>; Mar=
k
> >> Yacoub <markyacoub@chromium.org>; Pierre-Loup
> >> <pgriffais@valvesoftware.com>; Michel D=C3=A4nzer
> >> <michel.daenzer@mailbox.org>; Russell, Kent <Kent.Russell@amd.com>
> >> Subject: [PATCH v2 1/3] Documentation/gpu: Add info table for ASICs
> >>
> >> Amdgpu driver is used in an extensive range of devices, and each ASIC
> >> has some specific configuration. As a result of this variety, sometime=
s
> >> it is hard to identify the correct block that might cause the issue.
> >> This commit expands the amdgpu kernel-doc to alleviate this issue by
> >> introducing one ASIC table that describes dGPU and another one that
> >> shares the APU info.
> >>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> >> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >> Cc: Hersen Wu <hersenxs.wu@amd.com>
> >> Cc: Alex Hung <alex.hung@amd.com>
> >> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Simon Ser <contact@emersion.fr>
> >> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
> >> Cc: Sean Paul <seanpaul@chromium.org>
> >> Cc: Mark Yacoub <markyacoub@chromium.org>
> >> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
> >> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
> >> Cc: Kent Russell <Kent.Russell@amd.com>
> >> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >> ---
> >>   .../gpu/amdgpu/apu-asic-info-table.csv        |  8 +++++++
> >>   .../gpu/amdgpu/dgpu-asic-info-table.csv       | 24 +++++++++++++++++=
++
> >>   Documentation/gpu/amdgpu/driver-misc.rst      | 17 +++++++++++++
> >>   3 files changed, 49 insertions(+)
> >>   create mode 100644 Documentation/gpu/amdgpu/apu-asic-info-table.csv
> >>   create mode 100644 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> >>
> >> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> >> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> >> new file mode 100644
> >> index 000000000000..98c6988e424e
> >> --- /dev/null
> >> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> >> @@ -0,0 +1,8 @@
> >> +Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VC=
N
> >> version, SDMA version
> >> +Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3
> >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
> >> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
> >> +Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2
> >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
> >> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
> >> +SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1
> >> +Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1
> >> +Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3
> >> diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> >> b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> >> new file mode 100644
> >> index 000000000000..84617aa35dab
> >> --- /dev/null
> >> +++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
> >> @@ -0,0 +1,24 @@
> >> +Product Name, Code Reference, DCN/DCE version, GC version, VCN versio=
n,
> >> SDMA version
> >> +AMD Radeon (TM) HD 8500M/ 8600M /M200 /M320 /M330 /M335 Series,
> >> HAINAN, --,  6, --, --
> >> +AMD Radeon HD 7800 /7900 /FireGL Series, TAHITI, DCE 6, 6, VCE 1 / UV=
D 3, --
> >> +AMD Radeon R7 (TM|HD) M265 /M370 /8500M /8600 /8700 /8700M, OLAND,
> >> DCE 6, 6, VCE 1 / UVD 3, --
> >> +AMD Radeon (TM) (HD|R7) 7800 /7970 /8800 /8970 /370/ Series, PITCAIRN=
,
> >> DCE 6, 6, VCE 1 / UVD 3, --
> >> +AMD Radeon (TM|R7|R9|HD) E8860 /M360 /7700 /7800 /8800 /9000(M)
> >> /W4100 Series, VERDE, DCE 6, 6, VCE 1 / UVD 3, --
> >> +AMD Radeon HD M280X /M380 /7700 /8950 /W5100, BONAIRE, DCE 8, 7, VCE
> >> 2 / UVD 4.2, 1
> >> +AMD Radeon (R9|TM) 200 /390 /W8100 /W9100 Series, HAWAII, DCE 8, 7, V=
CE
> >> 2 / UVD 4.2, 1
> >> +AMD Radeon (TM) R(5|7) M315 /M340 /M360, TOPAZ, *, 8, --, 2
> >> +AMD Radeon (TM) R9 200 /380 /W7100 /S7150 /M390 /M395 Series, TONGA,
> >> DCE 10, 8, VCE 3 / UVD 5, 3
> >> +AMD Radeon (FirePro) (TM) R9 Fury Series, FIJI, DCE 10, 8, VCE 3 / UV=
D 6, 3
> >> +Radeon RX 470 /480 /570 /580 /590 Series - AMD Radeon (TM) (Pro WX) 5=
100
> >> /E9390 /E9560 /E9565 /V7350 /7100 /P30PH, POLARIS10, DCE 11.2, 8, VCE =
3.4 /
> >> UVD 6.3, 3
> >> +Radeon (TM) (RX|Pro WX) E9260 /460 /V5300X /550 /560(X) Series, POLAR=
IS11,
> >> DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
> >> +Radeon (RX/Pro) 500 /540(X) /550 /640 /WX2100 /WX3100 /WX200 Series,
> >> POLARIS12, DCE 11.2, 8, VCE 3.4 / UVD 6.3, 3
> >> +Radeon (RX|TM) (PRO|WX) Vega /MI25 /V320 /V340L /8200 /9100 /SSG
> >> MxGPU, VEGA10, DCE 12, 9.0.1, VCE 4.0.0 / UVD 7.0.0, 4.0.0
> >> +AMD Radeon (Pro) VII /MI50 /MI60, VEGA20, DCE 12, 9.4.0, VCE 4.1.0 / =
UVD
> >> 7.2.0, 4.2.0
> >> +MI100, ARCTURUS, *, 9.4.1, VCN 2.5.0, 4.2.2
> >> +MI200, ALDEBARAN, *, 9.4.2, VCN 2.6.0, 4.4.0
> >> +AMD Radeon (RX|Pro) 5600(M|XT) /5700 (M|XT|XTB) /W5700, NAVI10, DCN
> >> 2.0.0, 10.1.10, VCN 2.0.0, 5.0.0
> >> +AMD Radeon (Pro) 5300 /5500XTB/5500(XT|M) /W5500M /W5500, NAVI14,
> >> DCN 2.0.0, 10.1.1, VCN 2.0.2, 5.0.2
> >> +AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0,
> >> 10.3.0, VCN 3.0.0, 5.2.0
> >> +AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0,
> >> 10.3.2, VCN 3.0.0, 5.2.2
> >> +AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH,
> >> DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
> >> +AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN
> >> 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
> >> diff --git a/Documentation/gpu/amdgpu/driver-misc.rst
> >> b/Documentation/gpu/amdgpu/driver-misc.rst
> >> index e3d6b2fa2493..1800543d45f7 100644
> >> --- a/Documentation/gpu/amdgpu/driver-misc.rst
> >> +++ b/Documentation/gpu/amdgpu/driver-misc.rst
> >> @@ -32,6 +32,23 @@ unique_id
> >>   .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>      :doc: unique_id
> >>
> >> +Accelerated Processing Units (APU) Info
> >> +---------------------------------------
> >> +
> >> +.. csv-table::
> >> +   :header-rows: 1
> >> +   :widths: 3, 2, 2, 1, 1, 1
> >> +   :file: ./apu-asic-info-table.csv
> >> +
> >> +Discrete GPU Info
> >> +-----------------
> >> +
> >> +.. csv-table::
> >> +   :header-rows: 1
> >> +   :widths: 3, 2, 2, 1, 1, 1
> >> +   :file: ./dgpu-asic-info-table.csv
> >> +
> >> +
> >>   GPU Memory Usage Information
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>
> >> --
> >> 2.35.1
>
