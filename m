Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE659C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 19:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F32610A8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 19:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85F32610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012BB6E0F8;
	Mon,  2 Aug 2021 19:13:49 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BA76E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 19:13:47 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 y11-20020a4ade0b0000b029024b4146e2f5so4653667oot.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Aug 2021 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bpqCJm0oMRdy2axFw0Be6gHbRhnVwxsBnou7eeszF4w=;
 b=eBVuzT5FySzEsGTegDyPU84LYzJ6T2NdZzH21fzBpCXAbajJLyFgRBRh1kd7LaJNN0
 YRncog8S4cO0tJAnY13czajMccn+u5+exEnfiKK77Sh1YIr1gYFWsu1JKCoD9fV/RQze
 ly87FJGu5Lb2HcsOqOCB5jbcBV/TpwUcbcETZQx2PQBJc14Fuel1CEtO2kdqqb64DehX
 WBIt5+ckKgZ+p9da95/Uc+UQ+o8lg+iMlqOHMWWILYNcllVdPyhuAkt4RKJ131vwHhxz
 jH1J7a0FgI/XHEkjTRsavNO/0ZAZUTkl/QASLBuWTx12h4zM5N/h7mLHUGWtSGxdRpv/
 2zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bpqCJm0oMRdy2axFw0Be6gHbRhnVwxsBnou7eeszF4w=;
 b=s80ib985TXijbRV7UPCLIP2ka3oZYgH9fYfTujfSFnP1X60YeZ2ow1H5gHx1tvTrdv
 UnbTqjJxgOadNV6tpe22uS2YywHunMD3f/PozCSXV3mNWA7J8gjHGa0F3abtSAY4yUt8
 Z6CXRGgIQ8ST4wRzp5W7kyvoQ3gftreqGvwSsKIQamDcqhuawiAJZddplrJwfVYbadYW
 pIOTdCTXes3hw6Y2J8EhU7dmp7AAOlEKtiQGV+iAH6pOWKq133Lwx5YEqTY497z3wul4
 65yP5SVv1NReoYu/KL6udFLH4pWQzq85gHvxkgut2UNfKbbJtUlJ9qEaQcGuO/f4TKfa
 RRyg==
X-Gm-Message-State: AOAM533jy7es2IScuzeIpmBZQ7frxnOEmsfKDgIP18hurq6ZAXp3sifo
 AVav5JByvkYwOJfRVI20JSvUpWJ00IqnhfDzz3c=
X-Google-Smtp-Source: ABdhPJy1bIJC0uE7bNO2KxMX5bpjlqa7N3GEpYAMBqSjiGi3r+/jbXC2xPsDjnU5RsG7cmP6rLqZAFzMI2f23wLUfLo=
X-Received: by 2002:a4a:e3cb:: with SMTP id m11mr11732373oov.72.1627931626371; 
 Mon, 02 Aug 2021 12:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_N3denw=JbLSTJW4vusJ_wsB0MEJypqHiAyM9xPc78fEw@mail.gmail.com>
 <20210801144832.e65f3dee6eb7be07387eca4db24c459b.5070641322.mailapi@email10.godaddy.com>
In-Reply-To: <20210801144832.e65f3dee6eb7be07387eca4db24c459b.5070641322.mailapi@email10.godaddy.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Aug 2021 15:13:35 -0400
Message-ID: <CADnq5_PXm7DQw32AmwdOsxXn+ng_zZdEFTJH45f1dnpsjBVULg@mail.gmail.com>
Subject: Re: Re: AMD A8 3500M LVDS with CH7511B goes off on resolution change
 (randomly)
To: Edgardo Gho <edgardo.g@telikin.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Sun, Aug 1, 2021 at 5:48 PM <edgardo.g@telikin.com> wrote:
>
> Hi Alex, thanks for replying.
> I reported the issue ( https://gitlab.freedesktop.org/drm/amd/-/issues/16=
65 ) but have not got much help there.
> I notice when the issue happens LCD backlight goes off, so I measured the=
 Backlight Enable cable and it goes from 5V to 0V.. so I suspected maybe it=
 was just the backlight that was off, and I connected the line to 5V in the=
 motherboard and the backlight went ON, but screen was all white (like LVDS=
 was not sending pixels).
>
> I'm not sure why it randomly goes into this state when changing resolutio=
ns. At the moment I'm trying to detect the video output is on this wrong st=
ate, but I have read everything I could find related to video (/sys/class/d=
rm , /sys/modules/radeon ,  /sys/class/graphics) to find some file that is =
different when video is OFF compared when video is ON, and I could not find=
 anything there.
>
> Is there a way to dump all registers on the eDP to LVDS chip on debugfs? =
running drm.debug=3D0xe does not show a clue either. I'm trying to find som=
ething that will tell me the LCD is effectively OFF so I can trigger anothe=
r resolution change and bring it back to life.
>

I've added some comments on the bug report.

Alex


> Best Regards,
> Edgardo
>
>
> --------- Original Message ---------
> Subject: Re: AMD A8 3500M LVDS with CH7511B goes off on resolution change=
 (randomly)
> From: "Alex Deucher" <alexdeucher@gmail.com>
> Date: 7/26/21 11:04 am
> To: "Edgardo Gho" <edgardo.g@telikin.com>
> Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
>
> On Mon, Jul 26, 2021 at 10:45 AM Edgardo Gho <edgardo.g@telikin.com> wrot=
e:
> >
> > Hello all,
> > Not sure if this is the proper place to report this issue.
> > I'm using an AMD A8-3500M with AMD Radeon HD 6620G.
> > I'm testing with several recent kernels (5.11 , 5.13) on different dist=
ros (Ubuntu, Tinycore).
> > On all of them I have the same issue. When the video resolution change =
(for instance with xrandr) sometimes LVDS won't turn on again.
> > If I trigger another resolution change most of the times it comes back =
to life, but its very annoying because when kernel loads and video driver l=
oads it changes from BIOS video resolution to full HD and some of the times=
 the LCD shuts down.
> > I keep a HDMI monitor connected and HDMI never fails.
> > I tried with Windows and the catalyst driver does not fail either. I ca=
n change resolution hundreds of times in windows and it never fails. I also=
 noticed that on windows, when I change resolution, both LCD and HDMI go of=
f, and then LCD (LVDS) turns on first and then HDMI turns on. On Linux its =
different, both go off on a resolution change but LCD (LVDS) always turns o=
n AFTER HDMI.. and sometimes it does not turn on at all.
> > Backlight is off when it fails, but I tried illuminating the LCD panel =
and there are no pixels, so its does not look like a backlight issue.
> >
> > It using a CH7511B to convert from eDP to LVDS.
> >
> > Here is a piece of DMESG output with drm.debug=3D0xe . I can't find dif=
ferences between the piece when it works and when it fails.
> > The earlier piece of this dmesg correspond to working resolution change=
, and the later piece is from a failing one.
> > I would appreciate any pointers into how to debug this issue further. I=
 only got 2 units with this motherboard at the moment and same thing happen=
s on both, so I'm not thinking its a BAD LCD or something like that.
> >
>
> It might be easier to file a ticket for this and track it there
> (https://gitlab.freedesktop.org/drm/amd/-/issues). Please attach the
> full dmesg output from boot (without debug enabled is fine).
>
> Alex
>
>
> > Kernel 5.11 , DMESG
> > --------------------------------------
> > [ 428.597737] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 428.598024] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 429.133422] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 429.133769] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 429.731470] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 429.731861] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 429.896066] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 429.896339] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 429.915513] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 429.915735] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 430.067063] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 430.074956] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 430.075091] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.075159] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [NOFB]
> > [ 430.075221] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 430.078578] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 430.096061] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 430.096191] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.096255] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [NOFB]
> > [ 430.096318] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000000
> > [ 430.096714] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 430.096829] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.096887] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [NOFB]
> > [ 430.096948] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000000
> > [ 430.097130] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 430.108155] [drm:drm_mode_addfb2 [drm]] [FB:55]
> > [ 430.111259] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 430.111385] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> > [ 430.111498] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.111563] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [FB:55] #connectors=3D1 (x y) (0 0)
> > [ 430.111628] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ha=
s no fb, full mode set
> > [ 430.111688] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connect=
or dpms not on, full mode switch
> > [ 430.111744] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder=
 changed, full mode switch
> > [ 430.111862] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ch=
anged, full mode switch
> > [ 430.111919] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 430.111982] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempt=
ing to set mode from userspace
> > [ 430.112040] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 =
148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x9
> > [ 430.112162] [drm:radeon_encoder_set_active_device [radeon]] setting a=
ctive device to 00000008 from 00000008 00000008 for encoder 2
> > [ 430.112352] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:42:=
crtc-0]
> > [ 430.112439] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 430.112758] [drm:radeon_compute_pll_avivo [radeon]] 297000 - 297000, =
pll dividers - fb: 29.7 ref: 2, post 5
> > [ 430.136118] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:=
45:TMDS-45] set [MODE:]
> > [ 430.136112] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 430.136184] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 430.136406] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 430.136633] [drm:dce4_crtc_load_lut [radeon]] 0
> > [ 430.153327] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000008, active_devices 00000008
> > [ 430.153499] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 430.154722] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting=
 connector DPMS state to on
> > [ 430.154780] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] set DPMS on
> > [ 430.154867] [drm:dce4_crtc_load_lut [radeon]] 0
> > [ 430.155019] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000008, active_devices 00000008
> > [ 430.155189] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 430.155507] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 430.155837] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 430.155953] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.156012] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [NOFB]
> > [ 430.156073] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 430.157771] [drm:drm_mode_addfb2 [drm]] [FB:56]
> > [ 430.157927] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 430.158047] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> > [ 430.158159] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.158222] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [FB:56] #connectors=3D1 (x y) (0 0)
> > [ 430.158288] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ha=
s no fb, full mode set
> > [ 430.158347] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connect=
or dpms not on, full mode switch
> > [ 430.158404] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder=
 changed, full mode switch
> > [ 430.158461] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 430.158520] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ch=
anged, full mode switch
> > [ 430.158577] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 430.158636] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempt=
ing to set mode from userspace
> > [ 430.158693] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 =
138500 1920 1968 2000 2080 1080 1083 1088 1111 0x0 0x9
> > [ 430.158814] [drm:radeon_encoder_set_active_device [radeon]] setting a=
ctive device to 00000002 from 00000002 00000002 for encoder 3
> > [ 430.159011] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:44:=
crtc-1]
> > [ 430.159194] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.159360] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.159528] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.159692] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.159968] [drm:radeon_compute_pll_avivo [radeon]] 1350000 - 1350000=
, pll dividers - fb: 27.0 ref: 2, post 1
> > [ 430.188060] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.188071] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 430.188229] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.188399] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.188563] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.188744] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:=
47:LVDS-47] set [MODE:]
> > [ 430.188805] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 430.189326] [drm:dce4_crtc_load_lut [radeon]] 1
> > [ 430.206051] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000002, active_devices 00000002
> > [ 430.210824] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 430.210994] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 430.211158] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 430.212333] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at =
voltage 1 pre-emphasis 0
> > [ 430.214013] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 430.214179] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 430.214343] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 430.216165] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 3.5dB
> > [ 430.216332] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 3.5dB
> > [ 430.216497] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 3.5dB
> > [ 430.218213] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 6dB
> > [ 430.218379] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 6dB
> > [ 430.218542] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 6dB
> > [ 430.220261] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq =
at voltage 1 pre-emphasis 2
> > [ 430.279845] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting=
 connector DPMS state to on
> > [ 430.279906] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] set DPMS on
> > [ 430.279994] [drm:dce4_crtc_load_lut [radeon]] 1
> > [ 430.280147] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000002, active_devices 00000002
> > [ 430.284539] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 430.284708] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 430.284872] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 430.285995] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at =
voltage 1 pre-emphasis 0
> > [ 430.287669] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 430.287871] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 430.288037] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 430.289764] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 3.5dB
> > [ 430.289931] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 3.5dB
> > [ 430.290095] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 3.5dB
> > [ 430.291842] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 6dB
> > [ 430.292010] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 6dB
> > [ 430.292174] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 6dB
> > [ 430.293896] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq =
at voltage 1 pre-emphasis 2
> > [ 430.362999] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:46:HDMI-A-1]
> > [ 430.424882] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.424968] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.425030] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 430.425104] [drm:radeon_atombios_connected_scratch_regs [radeon]] DFP=
1 connected
> > [ 430.425202] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 430.425266] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.425326] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.425386] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 430.425450] [drm:drm_edid_to_eld [drm]] ELD monitor AAA
> > [ 430.425510] [drm:drm_edid_to_eld [drm]] HDMI: latency present 0 0, vi=
deo latency 0 0, audio latency 0 0
> > [ 430.425571] [drm:drm_edid_to_eld [drm]] ELD size 28, SAD count 1
> > [ 430.425633] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.425693] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.425752] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 430.426814] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:46:HDMI-A-1] probed modes :
> > [ 430.426850] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x9
> > [ 430.426914] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > [ 430.426976] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > [ 430.427038] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > [ 430.427099] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > [ 430.427161] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> > [ 430.427222] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> > [ 430.427284] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> > [ 430.427345] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1=
050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> > [ 430.427407] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1=
024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> > [ 430.427468] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x9=
60": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> > [ 430.427530] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1366x7=
68": 60 85750 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> > [ 430.427591] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
00": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
> > [ 430.427653] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 430.427715] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 430.427776] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 430.427868] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> > [ 430.427936] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> > [ 430.427998] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> > [ 430.428065] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> > [ 430.428135] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> > [ 430.428198] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
> > [ 430.428260] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
> > [ 430.428322] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> > [ 430.428386] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> > [ 430.428448] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 430.428510] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 430.428572] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 430.428634] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> > [ 430.428696] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> > [ 430.428758] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 430.428822] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 430.428884] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 430.428946] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 430.429008] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 430.429070] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 430.429132] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 430.429193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 430.429255] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 430.429317] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
> > [ 430.429379] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
> > [ 430.429441] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 430.429502] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 430.429564] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 430.429626] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x40=
0": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
> > [ 430.429887] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:49:LVDS-1]
> > [ 430.430544] [drm:radeon_dp_getdpcd [radeon]] DPCD: 10 0a 82 40 00 00 =
01 00 02 00 00 00 10 01 00
> > [ 430.430638] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD=
1 connected
> > [ 430.430713] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD=
1 disconnected
> > [ 430.432928] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.434552] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.436162] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.437789] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.439404] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.441029] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.442655] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.444274] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 430.445685] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.445748] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.445830] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.445890] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.445952] [drm:drm_edid_to_eld [drm]] ELD: no CEA Extension found
> > [ 430.446013] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 430.446073] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 430.446541] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:49:LVDS-1] probed modes :
> > [ 430.446574] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x48 0x9
> > [ 430.446637] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1=
050": 60 146357 1680 1784 1960 2240 1050 1053 1059 1089 0x0 0x6
> > [ 430.446699] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1=
050": 60 121790 1400 1488 1632 1864 1050 1053 1057 1089 0x0 0x6
> > [ 430.446761] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1=
024": 60 109100 1280 1368 1496 1712 1024 1027 1034 1063 0x0 0x6
> > [ 430.446822] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x9=
00": 60 106684 1440 1528 1672 1904 900 903 909 934 0x0 0x6
> > [ 430.446884] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x9=
60": 60 101344 1280 1360 1488 1696 960 963 967 996 0x0 0x6
> > [ 430.446946] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
54": 60 89337 1280 1352 1480 1680 854 857 867 887 0x0 0x6
> > [ 430.447008] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
00": 60 83707 1280 1352 1480 1680 800 803 809 831 0x0 0x6
> > [ 430.447069] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74648 1280 1344 1472 1664 720 723 728 748 0x0 0x6
> > [ 430.447131] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1152x7=
68": 60 71951 1152 1216 1328 1504 768 771 781 798 0x0 0x6
> > [ 430.447193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 60 63531 1024 1072 1176 1328 768 771 775 798 0x0 0x6
> > [ 430.447255] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 60 38313 800 832 912 1024 600 603 607 624 0x0 0x6
> > [ 430.447316] [drm:drm_mode_debug_printmodeline [drm]] Modeline "848x48=
0": 60 31648 848 872 952 1056 480 483 493 500 0x0 0x6
> > [ 430.447378] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 26852 720 744 808 896 480 483 493 500 0x0 0x6
> > [ 430.447440] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 23975 640 664 720 800 480 483 487 500 0x0 0x6
> > [ 430.498291] [drm:drm_mode_addfb2 [drm]] [FB:57]
> > [ 430.498479] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 430.498603] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> > [ 430.498715] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.498782] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [FB:57] #connectors=3D1 (x y) (0 0)
> > [ 430.498851] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 430.498910] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 430.498986] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.499171] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.499339] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.499503] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.499937] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 430.500058] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> > [ 430.500169] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 430.500228] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [FB:57] #connectors=3D1 (x y) (1920 0)
> > [ 430.500293] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 430.500352] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 430.500419] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.500584] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.500753] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 430.500917] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 430.503282] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 430.506898] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 430.671173] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 0000000069d28491, new_rbo =3D 00000000d4b81f84
> > [ 430.671441] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 0000000069d28491, new_rbo =3D 00000000d4b81f84
> > [ 430.708430] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 430.708769] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 431.275771] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 431.276153] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 431.876460] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 431.876777] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 432.007998] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 432.008277] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 432.041170] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 432.041419] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 432.187255] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 432.203462] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 432.203597] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.203664] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [NOFB]
> > [ 432.203727] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 432.207170] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 432.228610] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 432.228740] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.228804] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [NOFB]
> > [ 432.228866] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000000
> > [ 432.229253] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 432.229368] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.229425] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [NOFB]
> > [ 432.229486] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000000
> > [ 432.229663] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 432.241027] [drm:drm_mode_addfb2 [drm]] [FB:55]
> > [ 432.244230] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 432.244360] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> > [ 432.244473] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.244540] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [FB:55] #connectors=3D1 (x y) (0 0)
> > [ 432.244606] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ha=
s no fb, full mode set
> > [ 432.244665] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connect=
or dpms not on, full mode switch
> > [ 432.244722] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder=
 changed, full mode switch
> > [ 432.244778] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ch=
anged, full mode switch
> > [ 432.244835] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 432.244895] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempt=
ing to set mode from userspace
> > [ 432.244952] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 =
148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x9
> > [ 432.245074] [drm:radeon_encoder_set_active_device [radeon]] setting a=
ctive device to 00000008 from 00000008 00000008 for encoder 2
> > [ 432.245270] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:42:=
crtc-0]
> > [ 432.245357] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 432.245654] [drm:radeon_compute_pll_avivo [radeon]] 297000 - 297000, =
pll dividers - fb: 29.7 ref: 2, post 5
> > [ 432.272125] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:=
45:TMDS-45] set [MODE:]
> > [ 432.272121] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 432.272178] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000008, active_devices 00000008
> > [ 432.272363] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 432.272555] [drm:dce4_crtc_load_lut [radeon]] 0
> > [ 432.289250] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000008, active_devices 00000008
> > [ 432.289389] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 432.290564] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting=
 connector DPMS state to on
> > [ 432.290611] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] set DPMS on
> > [ 432.291027] [drm:dce4_crtc_load_lut [radeon]] 0
> > [ 432.291152] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000008, active_devices 00000008
> > [ 432.291288] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 432.291566] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 432.291835] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 432.291902] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.291935] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [NOFB]
> > [ 432.291969] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000000
> > [ 432.293150] [drm:drm_mode_addfb2 [drm]] [FB:56]
> > [ 432.293249] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 432.293320] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> > [ 432.293384] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.293423] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [FB:56] #connectors=3D1 (x y) (0 0)
> > [ 432.293461] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ha=
s no fb, full mode set
> > [ 432.293495] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connect=
or dpms not on, full mode switch
> > [ 432.293527] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder=
 changed, full mode switch
> > [ 432.293560] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 432.293594] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc ch=
anged, full mode switch
> > [ 432.293627] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 432.293661] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempt=
ing to set mode from userspace
> > [ 432.293694] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 =
138500 1920 1968 2000 2080 1080 1083 1088 1111 0x0 0x9
> > [ 432.293764] [drm:radeon_encoder_set_active_device [radeon]] setting a=
ctive device to 00000002 from 00000002 00000002 for encoder 3
> > [ 432.293882] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:44:=
crtc-1]
> > [ 432.293991] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.294080] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.294171] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.294258] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.294385] [drm:radeon_compute_pll_avivo [radeon]] 1350000 - 1350000=
, pll dividers - fb: 27.0 ref: 2, post 1
> > [ 432.320037] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.320049] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 432.320160] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.320286] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.320406] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.320541] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:=
47:LVDS-47] set [MODE:]
> > [ 432.320587] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 3, devices 00000002, active_devices 00000002
> > [ 432.321045] [drm:dce4_crtc_load_lut [radeon]] 1
> > [ 432.337773] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000002, active_devices 00000002
> > [ 432.342461] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 432.342584] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 432.342704] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 432.343767] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at =
voltage 1 pre-emphasis 0
> > [ 432.345435] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 432.345557] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 432.345677] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 432.347339] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 3.5dB
> > [ 432.347459] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 3.5dB
> > [ 432.347579] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 3.5dB
> > [ 432.349245] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 6dB
> > [ 432.349367] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 6dB
> > [ 432.349487] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 6dB
> > [ 432.351156] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq =
at voltage 1 pre-emphasis 2
> > [ 432.415843] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting=
 connector DPMS state to on
> > [ 432.415898] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] set DPMS on
> > [ 432.415977] [drm:dce4_crtc_load_lut [radeon]] 1
> > [ 432.416114] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 t=
o mode 0, devices 00000002, active_devices 00000002
> > [ 432.420522] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 432.420671] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 432.420817] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 432.421916] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at =
voltage 1 pre-emphasis 0
> > [ 432.423577] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 0dB
> > [ 432.423724] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 0dB
> > [ 432.423905] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 0dB
> > [ 432.425604] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 3.5dB
> > [ 432.425753] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 3.5dB
> > [ 432.425899] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 3.5dB
> > [ 432.427599] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 0 voltage 0.6V pre_emph 6dB
> > [ 432.427747] [drm:dp_get_adjust_train [radeon]] requested signal param=
eters: lane 1 voltage 0.6V pre_emph 6dB
> > [ 432.427930] [drm:dp_get_adjust_train [radeon]] using signal parameter=
s: voltage 0.6V pre_emph 6dB
> > [ 432.429634] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq =
at voltage 1 pre-emphasis 2
> > [ 432.490835] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:46:HDMI-A-1]
> > [ 432.552494] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.552580] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.552642] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 432.552714] [drm:radeon_atombios_connected_scratch_regs [radeon]] DFP=
1 connected
> > [ 432.552812] [drm:drm_detect_monitor_audio [drm]] Monitor has basic au=
dio support
> > [ 432.552877] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.552937] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.552998] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 432.553061] [drm:drm_edid_to_eld [drm]] ELD monitor AAA
> > [ 432.553122] [drm:drm_edid_to_eld [drm]] HDMI: latency present 0 0, vi=
deo latency 0 0, audio latency 0 0
> > [ 432.553183] [drm:drm_edid_to_eld [drm]] ELD size 28, SAD count 1
> > [ 432.553244] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.553304] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.553364] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS =
clock 0 kHz
> > [ 432.554427] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:46:HDMI-A-1] probed modes :
> > [ 432.554463] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x9
> > [ 432.554527] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > [ 432.554589] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > [ 432.554651] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > [ 432.554712] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > [ 432.554774] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> > [ 432.554836] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> > [ 432.554897] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> > [ 432.554959] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1=
050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> > [ 432.555020] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1=
024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> > [ 432.555082] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x9=
60": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> > [ 432.555143] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1366x7=
68": 60 85750 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> > [ 432.555205] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
00": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
> > [ 432.555267] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 432.555328] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 432.555390] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > [ 432.555452] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> > [ 432.555513] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> > [ 432.555575] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> > [ 432.555636] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> > [ 432.555698] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> > [ 432.555760] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
> > [ 432.555852] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
> > [ 432.555918] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> > [ 432.555980] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> > [ 432.556042] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 432.556104] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 432.556175] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> > [ 432.556238] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> > [ 432.556300] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x57=
6i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> > [ 432.556362] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 432.556424] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 432.556486] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 432.556548] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 432.556610] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> > [ 432.556672] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 432.556734] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 432.556796] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 432.556861] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> > [ 432.556923] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
> > [ 432.556985] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
> > [ 432.557048] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 432.557110] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 432.557171] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> > [ 432.557233] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x40=
0": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
> > [ 432.557501] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:49:LVDS-1]
> > [ 432.558160] [drm:radeon_dp_getdpcd [radeon]] DPCD: 10 0a 82 40 00 00 =
01 00 02 00 00 00 10 01 00
> > [ 432.558254] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD=
1 connected
> > [ 432.558333] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD=
1 disconnected
> > [ 432.560563] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.562184] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.563834] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.565449] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.567075] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.568685] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.570293] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.571897] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native d=
efer
> > [ 432.573301] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.573365] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.573448] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.573508] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.573570] [drm:drm_edid_to_eld [drm]] ELD: no CEA Extension found
> > [ 432.573630] [drm:drm_add_display_info [drm]] Supported Monitor Refres=
h rate range is 0 Hz - 0 Hz
> > [ 432.573690] [drm:drm_add_display_info [drm]] non_desktop set to 0
> > [ 432.574159] [drm:drm_helper_probe_single_connector_modes [drm_kms_hel=
per]] [CONNECTOR:49:LVDS-1] probed modes :
> > [ 432.574193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1=
080": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x48 0x9
> > [ 432.574256] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1=
050": 60 146357 1680 1784 1960 2240 1050 1053 1059 1089 0x0 0x6
> > [ 432.574318] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1=
050": 60 121790 1400 1488 1632 1864 1050 1053 1057 1089 0x0 0x6
> > [ 432.574379] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1=
024": 60 109100 1280 1368 1496 1712 1024 1027 1034 1063 0x0 0x6
> > [ 432.574441] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x9=
00": 60 106684 1440 1528 1672 1904 900 903 909 934 0x0 0x6
> > [ 432.574503] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x9=
60": 60 101344 1280 1360 1488 1696 960 963 967 996 0x0 0x6
> > [ 432.574565] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
54": 60 89337 1280 1352 1480 1680 854 857 867 887 0x0 0x6
> > [ 432.574627] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x8=
00": 60 83707 1280 1352 1480 1680 800 803 809 831 0x0 0x6
> > [ 432.574689] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x7=
20": 60 74648 1280 1344 1472 1664 720 723 728 748 0x0 0x6
> > [ 432.574751] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1152x7=
68": 60 71951 1152 1216 1328 1504 768 771 781 798 0x0 0x6
> > [ 432.574812] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x7=
68": 60 63531 1024 1072 1176 1328 768 771 775 798 0x0 0x6
> > [ 432.574874] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x60=
0": 60 38313 800 832 912 1024 600 603 607 624 0x0 0x6
> > [ 432.574936] [drm:drm_mode_debug_printmodeline [drm]] Modeline "848x48=
0": 60 31648 848 872 952 1056 480 483 493 500 0x0 0x6
> > [ 432.574998] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x48=
0": 60 26852 720 744 808 896 480 483 493 500 0x0 0x6
> > [ 432.575060] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x48=
0": 60 23975 640 664 720 800 480 483 487 500 0x0 0x6
> > [ 432.625743] [drm:drm_mode_addfb2 [drm]] [FB:57]
> > [ 432.625904] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> > [ 432.626036] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> > [ 432.626149] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.626214] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
2:crtc-0] [FB:57] #connectors=3D1 (x y) (0 0)
> > [ 432.626282] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 432.626342] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 432.626417] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.626599] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.626768] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.626931] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.627282] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> > [ 432.627401] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> > [ 432.627511] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> > [ 432.627568] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:4=
4:crtc-1] [FB:57] #connectors=3D1 (x y) (1920 0)
> > [ 432.627632] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> > [ 432.627691] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNEC=
TOR:49:LVDS-1] to [CRTC:44:crtc-1]
> > [ 432.627757] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.628005] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.628175] [drm:evergreen_program_watermarks [radeon]] force priorit=
y a to high
> > [ 432.628339] [drm:evergreen_program_watermarks [radeon]] force priorit=
y b to high
> > [ 432.638631] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 432.639202] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_=
status =3D 0 !=3D RADEON_FLIP_SUBMITTED(2)
> > [ 432.786805] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 000000004da6713b, new_rbo =3D 00000000a7ab5f38
> > [ 432.787153] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 000000004da6713b, new_rbo =3D 00000000a7ab5f38
> > [ 432.828527] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 432.828861] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000a7ab5f38, new_rbo =3D 00000000d4b81f84
> > [ 433.395499] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> > [ 433.395962] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() =
cur_rbo =3D 00000000d4b81f84, new_rbo =3D 00000000a7ab5f38
> >
> > ------------------------------------------------
> >
> > Best Regards,
> > Edgardo Gho
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
