Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E5AC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 18:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AC060F90
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 18:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0AC060F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928AA6EB2E;
	Mon, 26 Jul 2021 18:04:42 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE146EC3E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 18:04:40 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id z26so11879553oih.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=39uDEZ6HunqDLpscjjII1h+62ehwWS6G+IvX3UQyMj8=;
 b=mp3hkh0vZwWVAJSKF0/ZCkCk3iyJrCoNOzbQssB84OVjx2I5E087cMUzN4IlbdfILl
 mxSZDHvakodbElrNBCRD3Xfm4RHUMtE/G3ltwXGP59Z7+Vg1WtoJien613FSlN+fp+Zr
 0+LDUjIiA868S2wLpOijjA0Glmb2hBsIMur85oVMApo5CD17oxU4wIxmvqdp9Sys1QiN
 0BBrDY+yZm4aY+sfOOOr4LGd0oy/l16hfNeXxMlK2iMeyyWEQjc8llssQQY1totDEzS8
 NiAJ7JZVTRX/EULdmf+M+1uV7wyi20LHiuoqNNSF2rCEsAVQMyp2GxkCmDEELTiMz6pL
 vuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=39uDEZ6HunqDLpscjjII1h+62ehwWS6G+IvX3UQyMj8=;
 b=C7Xh7AZ9pc3ihwRWYrPXOLOpJqqoYXB5Io0zzMt/TcyQXZOgW1BnKuicJx9Qv+a20M
 a8xsRIxlP7zrS19n5zqZQ+5eoKsMvlhVjxzK2+aeQNY005i9x3FNdf8nSa/cNvxo4crQ
 rZBNemrD8UD1hzQGzl60CBKkiaoYYlYJM+jqUOt5ysb6r581Np8UfVlRg5vLzNI5ouTH
 cca+S1Fs2+m+MLyHp57Do5vmT30l5Io34uhS7ZIwRWJgIqQpz1p1R+mdHJm7oTJaY28r
 CFzmS9JcTyeLN+ud7RnUVvI6KXtP60Uo9PLZyHVqXaVNTtplSuJ0rTbGEIQOXc8F1Eqj
 e0Ew==
X-Gm-Message-State: AOAM5309soW57RGeI33L+s3qHq3X9JT2cDlJV7IluCW3DGCs+Xwu5LFf
 dOqdKDVxJHHKdckpnzgoiRX9xWhftwoE87WPK3c=
X-Google-Smtp-Source: ABdhPJyMBbWNfSXnhm+qiodVf5kxuaxPKc7LROy9ixzURcYkUwrQwgdaSqwxRgOGo6Rx2PXtk1wNd+BLZ/wviXwTiIs=
X-Received: by 2002:a05:6808:1390:: with SMTP id
 c16mr12018405oiw.123.1627322679516; 
 Mon, 26 Jul 2021 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <b00fd20df8d9d10648c0231a7b2adf813d4f2d30.camel@telikin.com>
In-Reply-To: <b00fd20df8d9d10648c0231a7b2adf813d4f2d30.camel@telikin.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jul 2021 14:04:28 -0400
Message-ID: <CADnq5_N3denw=JbLSTJW4vusJ_wsB0MEJypqHiAyM9xPc78fEw@mail.gmail.com>
Subject: Re: AMD A8 3500M LVDS with CH7511B goes off on resolution change
 (randomly)
To: Edgardo Gho <edgardo.g@telikin.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 26, 2021 at 10:45 AM Edgardo Gho <edgardo.g@telikin.com> wrote:
>
> Hello all,
> Not sure if this is the proper place to report this issue.
> I'm using an AMD A8-3500M with AMD Radeon HD 6620G.
> I'm testing with several recent kernels (5.11 , 5.13) on different distros (Ubuntu, Tinycore).
> On all of them I have the same issue. When the video resolution change (for instance with xrandr) sometimes LVDS won't turn on again.
> If I trigger another resolution change most of the times it comes back to life, but its very annoying because when kernel loads and video driver loads it changes from BIOS video resolution to full HD and some of the times the LCD shuts down.
> I keep a HDMI monitor connected and HDMI never fails.
> I tried with Windows and the catalyst driver does not fail either. I can change resolution hundreds of times in windows and it never fails. I also noticed that on windows, when I change resolution, both LCD and HDMI go off, and then LCD (LVDS) turns on first and then HDMI turns on. On Linux its different, both go off on a resolution change but LCD (LVDS) always turns on AFTER HDMI.. and sometimes it does not turn on at all.
> Backlight is off when it fails, but I tried illuminating the  LCD panel and there are no pixels, so its does not look like a backlight issue.
>
> It using a CH7511B to convert from eDP to LVDS.
>
> Here is a piece of DMESG output with drm.debug=0xe . I can't find differences between the piece when it works and when it fails.
> The earlier piece of this dmesg correspond to working resolution change, and the later piece is from a failing one.
> I would appreciate any pointers into how to debug this issue further. I only got 2 units  with this motherboard at the moment and same thing happens on both, so I'm not thinking its a BAD LCD or something like that.
>

It might be easier to file a ticket for this and track it there
(https://gitlab.freedesktop.org/drm/amd/-/issues). Please attach the
full dmesg output from boot (without debug enabled is fine).

Alex


> Kernel 5.11 , DMESG
> --------------------------------------
> [  428.597737] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  428.598024] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  429.133422] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  429.133769] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  429.731470] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  429.731861] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  429.896066] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  429.896339] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  429.915513] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  429.915735] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  430.067063] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  430.074956] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  430.075091] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.075159] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [NOFB]
> [  430.075221] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  430.078578] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  430.096061] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  430.096191] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.096255] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [NOFB]
> [  430.096318] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000000
> [  430.096714] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  430.096829] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.096887] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [NOFB]
> [  430.096948] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000000
> [  430.097130] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  430.108155] [drm:drm_mode_addfb2 [drm]] [FB:55]
> [  430.111259] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  430.111385] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> [  430.111498] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.111563] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [FB:55] #connectors=1 (x y) (0 0)
> [  430.111628] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc has no fb, full mode set
> [  430.111688] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connector dpms not on, full mode switch
> [  430.111744] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder changed, full mode switch
> [  430.111862] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc changed, full mode switch
> [  430.111919] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  430.111982] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempting to set mode from userspace
> [  430.112040] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x9
> [  430.112162] [drm:radeon_encoder_set_active_device [radeon]] setting active device to 00000008 from 00000008 00000008 for encoder 2
> [  430.112352] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:42:crtc-0]
> [  430.112439] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  430.112758] [drm:radeon_compute_pll_avivo [radeon]] 297000 - 297000, pll dividers - fb: 29.7 ref: 2, post 5
> [  430.136118] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:45:TMDS-45] set [MODE:]
> [  430.136112] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  430.136184] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  430.136406] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  430.136633] [drm:dce4_crtc_load_lut [radeon]] 0
> [  430.153327] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000008, active_devices 00000008
> [  430.153499] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  430.154722] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting connector DPMS state to on
> [  430.154780] [drm:drm_crtc_helper_set_config [drm_kms_helper]]  [CONNECTOR:46:HDMI-A-1] set DPMS on
> [  430.154867] [drm:dce4_crtc_load_lut [radeon]] 0
> [  430.155019] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000008, active_devices 00000008
> [  430.155189] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  430.155507] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  430.155837] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  430.155953] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.156012] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [NOFB]
> [  430.156073] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  430.157771] [drm:drm_mode_addfb2 [drm]] [FB:56]
> [  430.157927] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  430.158047] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> [  430.158159] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.158222] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [FB:56] #connectors=1 (x y) (0 0)
> [  430.158288] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc has no fb, full mode set
> [  430.158347] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connector dpms not on, full mode switch
> [  430.158404] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder changed, full mode switch
> [  430.158461] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  430.158520] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc changed, full mode switch
> [  430.158577] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  430.158636] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempting to set mode from userspace
> [  430.158693] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x0 0x9
> [  430.158814] [drm:radeon_encoder_set_active_device [radeon]] setting active device to 00000002 from 00000002 00000002 for encoder 3
> [  430.159011] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:44:crtc-1]
> [  430.159194] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.159360] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.159528] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.159692] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.159968] [drm:radeon_compute_pll_avivo [radeon]] 1350000 - 1350000, pll dividers - fb: 27.0 ref: 2, post 1
> [  430.188060] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.188071] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  430.188229] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.188399] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.188563] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.188744] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:47:LVDS-47] set [MODE:]
> [  430.188805] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  430.189326] [drm:dce4_crtc_load_lut [radeon]] 1
> [  430.206051] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000002, active_devices 00000002
> [  430.210824] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  430.210994] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  430.211158] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  430.212333] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at voltage 1 pre-emphasis 0
> [  430.214013] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  430.214179] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  430.214343] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  430.216165] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 3.5dB
> [  430.216332] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 3.5dB
> [  430.216497] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 3.5dB
> [  430.218213] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 6dB
> [  430.218379] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 6dB
> [  430.218542] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 6dB
> [  430.220261] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq at voltage 1 pre-emphasis 2
> [  430.279845] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting connector DPMS state to on
> [  430.279906] [drm:drm_crtc_helper_set_config [drm_kms_helper]]  [CONNECTOR:49:LVDS-1] set DPMS on
> [  430.279994] [drm:dce4_crtc_load_lut [radeon]] 1
> [  430.280147] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000002, active_devices 00000002
> [  430.284539] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  430.284708] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  430.284872] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  430.285995] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at voltage 1 pre-emphasis 0
> [  430.287669] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  430.287871] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  430.288037] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  430.289764] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 3.5dB
> [  430.289931] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 3.5dB
> [  430.290095] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 3.5dB
> [  430.291842] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 6dB
> [  430.292010] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 6dB
> [  430.292174] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 6dB
> [  430.293896] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq at voltage 1 pre-emphasis 2
> [  430.362999] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1]
> [  430.424882] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.424968] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.425030] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  430.425104] [drm:radeon_atombios_connected_scratch_regs [radeon]] DFP1 connected
> [  430.425202] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  430.425266] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.425326] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.425386] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  430.425450] [drm:drm_edid_to_eld [drm]] ELD monitor AAA
> [  430.425510] [drm:drm_edid_to_eld [drm]] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
> [  430.425571] [drm:drm_edid_to_eld [drm]] ELD size 28, SAD count 1
> [  430.425633] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.425693] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.425752] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  430.426814] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] probed modes :
> [  430.426850] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x9
> [  430.426914] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> [  430.426976] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> [  430.427038] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> [  430.427099] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> [  430.427161] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> [  430.427222] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> [  430.427284] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> [  430.427345] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> [  430.427407] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> [  430.427468] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> [  430.427530] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1366x768": 60 85750 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> [  430.427591] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
> [  430.427653] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  430.427715] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  430.427776] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  430.427868] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> [  430.427936] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> [  430.427998] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> [  430.428065] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> [  430.428135] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> [  430.428198] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
> [  430.428260] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
> [  430.428322] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> [  430.428386] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> [  430.428448] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  430.428510] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  430.428572] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  430.428634] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> [  430.428696] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> [  430.428758] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> [  430.428822] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> [  430.428884] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  430.428946] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  430.429008] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  430.429070] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> [  430.429132] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> [  430.429193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> [  430.429255] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> [  430.429317] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
> [  430.429379] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
> [  430.429441] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
> [  430.429502] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> [  430.429564] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> [  430.429626] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x400": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
> [  430.429887] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:49:LVDS-1]
> [  430.430544] [drm:radeon_dp_getdpcd [radeon]] DPCD: 10 0a 82 40 00 00 01 00 02 00 00 00 10 01 00
> [  430.430638] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD1 connected
> [  430.430713] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD1 disconnected
> [  430.432928] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.434552] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.436162] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.437789] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.439404] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.441029] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.442655] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.444274] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  430.445685] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.445748] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.445830] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.445890] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.445952] [drm:drm_edid_to_eld [drm]] ELD: no CEA Extension found
> [  430.446013] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  430.446073] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  430.446541] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:49:LVDS-1] probed modes :
> [  430.446574] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x48 0x9
> [  430.446637] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60 146357 1680 1784 1960 2240 1050 1053 1059 1089 0x0 0x6
> [  430.446699] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1050": 60 121790 1400 1488 1632 1864 1050 1053 1057 1089 0x0 0x6
> [  430.446761] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60 109100 1280 1368 1496 1712 1024 1027 1034 1063 0x0 0x6
> [  430.446822] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x900": 60 106684 1440 1528 1672 1904 900 903 909 934 0x0 0x6
> [  430.446884] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60 101344 1280 1360 1488 1696 960 963 967 996 0x0 0x6
> [  430.446946] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x854": 60 89337 1280 1352 1480 1680 854 857 867 887 0x0 0x6
> [  430.447008] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60 83707 1280 1352 1480 1680 800 803 809 831 0x0 0x6
> [  430.447069] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74648 1280 1344 1472 1664 720 723 728 748 0x0 0x6
> [  430.447131] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1152x768": 60 71951 1152 1216 1328 1504 768 771 781 798 0x0 0x6
> [  430.447193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 63531 1024 1072 1176 1328 768 771 775 798 0x0 0x6
> [  430.447255] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 38313 800 832 912 1024 600 603 607 624 0x0 0x6
> [  430.447316] [drm:drm_mode_debug_printmodeline [drm]] Modeline "848x480": 60 31648 848 872 952 1056 480 483 493 500 0x0 0x6
> [  430.447378] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 26852 720 744 808 896 480 483 493 500 0x0 0x6
> [  430.447440] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 23975 640 664 720 800 480 483 487 500 0x0 0x6
> [  430.498291] [drm:drm_mode_addfb2 [drm]] [FB:57]
> [  430.498479] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  430.498603] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> [  430.498715] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.498782] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [FB:57] #connectors=1 (x y) (0 0)
> [  430.498851] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  430.498910] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  430.498986] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.499171] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.499339] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.499503] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.499937] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  430.500058] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> [  430.500169] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  430.500228] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [FB:57] #connectors=1 (x y) (1920 0)
> [  430.500293] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  430.500352] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  430.500419] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.500584] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.500753] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  430.500917] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  430.503282] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  430.506898] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  430.671173] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 0000000069d28491, new_rbo = 00000000d4b81f84
> [  430.671441] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 0000000069d28491, new_rbo = 00000000d4b81f84
> [  430.708430] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  430.708769] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  431.275771] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  431.276153] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  431.876460] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  431.876777] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  432.007998] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  432.008277] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  432.041170] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  432.041419] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  432.187255] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  432.203462] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  432.203597] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.203664] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [NOFB]
> [  432.203727] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  432.207170] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  432.228610] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  432.228740] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.228804] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [NOFB]
> [  432.228866] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000000
> [  432.229253] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  432.229368] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.229425] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [NOFB]
> [  432.229486] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000000
> [  432.229663] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  432.241027] [drm:drm_mode_addfb2 [drm]] [FB:55]
> [  432.244230] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  432.244360] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> [  432.244473] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.244540] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [FB:55] #connectors=1 (x y) (0 0)
> [  432.244606] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc has no fb, full mode set
> [  432.244665] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connector dpms not on, full mode switch
> [  432.244722] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder changed, full mode switch
> [  432.244778] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc changed, full mode switch
> [  432.244835] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  432.244895] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempting to set mode from userspace
> [  432.244952] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x0 0x9
> [  432.245074] [drm:radeon_encoder_set_active_device [radeon]] setting active device to 00000008 from 00000008 00000008 for encoder 2
> [  432.245270] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:42:crtc-0]
> [  432.245357] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  432.245654] [drm:radeon_compute_pll_avivo [radeon]] 297000 - 297000, pll dividers - fb: 29.7 ref: 2, post 5
> [  432.272125] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:45:TMDS-45] set [MODE:]
> [  432.272121] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  432.272178] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000008, active_devices 00000008
> [  432.272363] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  432.272555] [drm:dce4_crtc_load_lut [radeon]] 0
> [  432.289250] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000008, active_devices 00000008
> [  432.289389] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  432.290564] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting connector DPMS state to on
> [  432.290611] [drm:drm_crtc_helper_set_config [drm_kms_helper]]  [CONNECTOR:46:HDMI-A-1] set DPMS on
> [  432.291027] [drm:dce4_crtc_load_lut [radeon]] 0
> [  432.291152] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000008, active_devices 00000008
> [  432.291288] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  432.291566] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  432.291835] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  432.291902] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.291935] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [NOFB]
> [  432.291969] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000000
> [  432.293150] [drm:drm_mode_addfb2 [drm]] [FB:56]
> [  432.293249] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  432.293320] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> [  432.293384] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.293423] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [FB:56] #connectors=1 (x y) (0 0)
> [  432.293461] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc has no fb, full mode set
> [  432.293495] [drm:drm_crtc_helper_set_config [drm_kms_helper]] connector dpms not on, full mode switch
> [  432.293527] [drm:drm_crtc_helper_set_config [drm_kms_helper]] encoder changed, full mode switch
> [  432.293560] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  432.293594] [drm:drm_crtc_helper_set_config [drm_kms_helper]] crtc changed, full mode switch
> [  432.293627] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  432.293661] [drm:drm_crtc_helper_set_config [drm_kms_helper]] attempting to set mode from userspace
> [  432.293694] [drm:drm_mode_debug_printmodeline [drm]] Modeline "": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x0 0x9
> [  432.293764] [drm:radeon_encoder_set_active_device [radeon]] setting active device to 00000002 from 00000002 00000002 for encoder 3
> [  432.293882] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [CRTC:44:crtc-1]
> [  432.293991] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.294080] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.294171] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.294258] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.294385] [drm:radeon_compute_pll_avivo [radeon]] 1350000 - 1350000, pll dividers - fb: 27.0 ref: 2, post 1
> [  432.320037] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.320049] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  432.320160] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.320286] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.320406] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.320541] [drm:drm_crtc_helper_set_mode [drm_kms_helper]] [ENCODER:47:LVDS-47] set [MODE:]
> [  432.320587] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 3, devices 00000002, active_devices 00000002
> [  432.321045] [drm:dce4_crtc_load_lut [radeon]] 1
> [  432.337773] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000002, active_devices 00000002
> [  432.342461] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  432.342584] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  432.342704] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  432.343767] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at voltage 1 pre-emphasis 0
> [  432.345435] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  432.345557] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  432.345677] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  432.347339] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 3.5dB
> [  432.347459] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 3.5dB
> [  432.347579] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 3.5dB
> [  432.349245] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 6dB
> [  432.349367] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 6dB
> [  432.349487] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 6dB
> [  432.351156] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq at voltage 1 pre-emphasis 2
> [  432.415843] [drm:drm_crtc_helper_set_config [drm_kms_helper]] Setting connector DPMS state to on
> [  432.415898] [drm:drm_crtc_helper_set_config [drm_kms_helper]]  [CONNECTOR:49:LVDS-1] set DPMS on
> [  432.415977] [drm:dce4_crtc_load_lut [radeon]] 1
> [  432.416114] [drm:radeon_atom_encoder_dpms [radeon]] encoder dpms 33 to mode 0, devices 00000002, active_devices 00000002
> [  432.420522] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  432.420671] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  432.420817] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  432.421916] [drm:radeon_dp_link_train_cr [radeon]] clock recovery at voltage 1 pre-emphasis 0
> [  432.423577] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 0dB
> [  432.423724] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 0dB
> [  432.423905] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 0dB
> [  432.425604] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 3.5dB
> [  432.425753] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 3.5dB
> [  432.425899] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 3.5dB
> [  432.427599] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 0 voltage 0.6V pre_emph 6dB
> [  432.427747] [drm:dp_get_adjust_train [radeon]] requested signal parameters: lane 1 voltage 0.6V pre_emph 6dB
> [  432.427930] [drm:dp_get_adjust_train [radeon]] using signal parameters: voltage 0.6V pre_emph 6dB
> [  432.429634] [drm:radeon_dp_link_train_ce.isra.0 [radeon]] channel eq at voltage 1 pre-emphasis 2
> [  432.490835] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1]
> [  432.552494] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.552580] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.552642] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  432.552714] [drm:radeon_atombios_connected_scratch_regs [radeon]] DFP1 connected
> [  432.552812] [drm:drm_detect_monitor_audio [drm]] Monitor has basic audio support
> [  432.552877] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.552937] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.552998] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  432.553061] [drm:drm_edid_to_eld [drm]] ELD monitor AAA
> [  432.553122] [drm:drm_edid_to_eld [drm]] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
> [  432.553183] [drm:drm_edid_to_eld [drm]] ELD size 28, SAD count 1
> [  432.553244] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.553304] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.553364] [drm:drm_parse_cea_ext [drm]] HDMI: DVI dual 0, max TMDS clock 0 kHz
> [  432.554427] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] probed modes :
> [  432.554463] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x48 0x9
> [  432.554527] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> [  432.554589] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> [  432.554651] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> [  432.554712] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> [  432.554774] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 50 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> [  432.554836] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> [  432.554897] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 50 74250 1920 2448 2492 2640 1080 1084 1094 1125 0x40 0x15
> [  432.554959] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> [  432.555020] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> [  432.555082] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> [  432.555143] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1366x768": 60 85750 1366 1436 1579 1792 768 771 774 798 0x40 0x5
> [  432.555205] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9
> [  432.555267] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  432.555328] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  432.555390] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74176 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> [  432.555452] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> [  432.555513] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 50 74250 1280 1720 1760 1980 720 725 730 750 0x40 0x5
> [  432.555575] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 75 78750 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> [  432.555636] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 70 75000 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> [  432.555698] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 65000 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> [  432.555760] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 75 49500 800 816 896 1056 600 601 604 625 0x40 0x5
> [  432.555852] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 72 50000 800 856 976 1040 600 637 643 666 0x40 0x5
> [  432.555918] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> [  432.555980] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> [  432.556042] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  432.556104] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  432.556175] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576": 50 27000 720 732 796 864 576 581 586 625 0x40 0xa
> [  432.556238] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> [  432.556300] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x576i": 50 13500 720 732 795 864 576 580 586 625 0x40 0x101a
> [  432.556362] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> [  432.556424] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27027 720 736 798 858 480 489 495 525 0x40 0xa
> [  432.556486] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  432.556548] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  432.556610] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 27000 720 736 798 858 480 489 495 525 0x40 0xa
> [  432.556672] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> [  432.556734] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13514 720 739 801 858 480 488 494 525 0x40 0x101a
> [  432.556796] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> [  432.556861] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480i": 60 13500 720 739 801 858 480 488 494 525 0x40 0x101a
> [  432.556923] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 75 31500 640 656 720 840 480 481 484 500 0x40 0xa
> [  432.556985] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 73 31500 640 664 704 832 480 489 492 520 0x40 0xa
> [  432.557048] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25200 640 656 752 800 480 490 492 525 0x40 0xa
> [  432.557110] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> [  432.557171] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> [  432.557233] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x400": 70 28320 720 738 846 900 400 412 414 449 0x40 0x6
> [  432.557501] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:49:LVDS-1]
> [  432.558160] [drm:radeon_dp_getdpcd [radeon]] DPCD: 10 0a 82 40 00 00 01 00 02 00 00 00 10 01 00
> [  432.558254] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD1 connected
> [  432.558333] [drm:radeon_atombios_connected_scratch_regs [radeon]] LCD1 disconnected
> [  432.560563] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.562184] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.563834] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.565449] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.567075] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.568685] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.570293] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.571897] [drm:drm_dp_i2c_do_msg [drm_kms_helper]] (null): native defer
> [  432.573301] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.573365] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.573448] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.573508] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.573570] [drm:drm_edid_to_eld [drm]] ELD: no CEA Extension found
> [  432.573630] [drm:drm_add_display_info [drm]] Supported Monitor Refresh rate range is 0 Hz - 0 Hz
> [  432.573690] [drm:drm_add_display_info [drm]] non_desktop set to 0
> [  432.574159] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:49:LVDS-1] probed modes :
> [  432.574193] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60 138500 1920 1968 2000 2080 1080 1083 1088 1111 0x48 0x9
> [  432.574256] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60 146357 1680 1784 1960 2240 1050 1053 1059 1089 0x0 0x6
> [  432.574318] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1050": 60 121790 1400 1488 1632 1864 1050 1053 1057 1089 0x0 0x6
> [  432.574379] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60 109100 1280 1368 1496 1712 1024 1027 1034 1063 0x0 0x6
> [  432.574441] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x900": 60 106684 1440 1528 1672 1904 900 903 909 934 0x0 0x6
> [  432.574503] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60 101344 1280 1360 1488 1696 960 963 967 996 0x0 0x6
> [  432.574565] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x854": 60 89337 1280 1352 1480 1680 854 857 867 887 0x0 0x6
> [  432.574627] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60 83707 1280 1352 1480 1680 800 803 809 831 0x0 0x6
> [  432.574689] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74648 1280 1344 1472 1664 720 723 728 748 0x0 0x6
> [  432.574751] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1152x768": 60 71951 1152 1216 1328 1504 768 771 781 798 0x0 0x6
> [  432.574812] [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 63531 1024 1072 1176 1328 768 771 775 798 0x0 0x6
> [  432.574874] [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 38313 800 832 912 1024 600 603 607 624 0x0 0x6
> [  432.574936] [drm:drm_mode_debug_printmodeline [drm]] Modeline "848x480": 60 31648 848 872 952 1056 480 483 493 500 0x0 0x6
> [  432.574998] [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x480": 60 26852 720 744 808 896 480 483 493 500 0x0 0x6
> [  432.575060] [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 23975 640 664 720 800 480 483 487 500 0x0 0x6
> [  432.625743] [drm:drm_mode_addfb2 [drm]] [FB:57]
> [  432.625904] [drm:drm_mode_setcrtc [drm]] [CRTC:42:crtc-0]
> [  432.626036] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:46:HDMI-A-1]
> [  432.626149] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.626214] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:42:crtc-0] [FB:57] #connectors=1 (x y) (0 0)
> [  432.626282] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  432.626342] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  432.626417] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.626599] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.626768] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.626931] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.627282] [drm:drm_mode_setcrtc [drm]] [CRTC:44:crtc-1]
> [  432.627401] [drm:drm_mode_setcrtc [drm]] [CONNECTOR:49:LVDS-1]
> [  432.627511] [drm:drm_crtc_helper_set_config [drm_kms_helper]]
> [  432.627568] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CRTC:44:crtc-1] [FB:57] #connectors=1 (x y) (1920 0)
> [  432.627632] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:46:HDMI-A-1] to [CRTC:42:crtc-0]
> [  432.627691] [drm:drm_crtc_helper_set_config [drm_kms_helper]] [CONNECTOR:49:LVDS-1] to [CRTC:44:crtc-1]
> [  432.627757] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.628005] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.628175] [drm:evergreen_program_watermarks [radeon]] force priority a to high
> [  432.628339] [drm:evergreen_program_watermarks [radeon]] force priority b to high
> [  432.638631] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  432.639202] [drm:radeon_crtc_handle_flip [radeon]] radeon_crtc->flip_status = 0 != RADEON_FLIP_SUBMITTED(2)
> [  432.786805] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 000000004da6713b, new_rbo = 00000000a7ab5f38
> [  432.787153] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 000000004da6713b, new_rbo = 00000000a7ab5f38
> [  432.828527] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  432.828861] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000a7ab5f38, new_rbo = 00000000d4b81f84
> [  433.395499] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
> [  433.395962] [drm:radeon_crtc_page_flip_target [radeon]] flip-ioctl() cur_rbo = 00000000d4b81f84, new_rbo = 00000000a7ab5f38
>
> ------------------------------------------------
>
> Best Regards,
> Edgardo Gho
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
