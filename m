Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C91C636CC
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Feb 2023 15:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7B610E282;
	Sun,  5 Feb 2023 15:16:37 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C2A10E282
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Feb 2023 15:16:35 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id j4so3663148iog.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 05 Feb 2023 07:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mShSU1jG1ho41QspFO7kR3MgIcU5l0/w7QC3Vor6Ink=;
 b=kA0wLLJd3514iQI8fXdv9LMWv/rXfT4D8kfJYz59XZ+KEfAeTFKbio8SyFmXHM700O
 I+7yIPhgNspeYJd32Hio9ifeHkZCwQoA/a+RR00vbBkFq4Jc5gcoBq+mTGiyiBed0Qm0
 qptErui1yE3IUHx6rJRRYNrvgqHqazjwkNCh6OznawXphIO6fobmfQB0wkbEsMBmMKZ0
 2C5hnkNMr0w1NOsWemvMNMkNteRYyA29kfqPlUsqSUzux8gpvvA45d1OXNd6ShoROsp1
 aWihR40cf4hccK09Mr7Xig6KnNi0uys6ULekg3eYYZW43Y0qDRGJyrrfZCBfhFfAYRqC
 t8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mShSU1jG1ho41QspFO7kR3MgIcU5l0/w7QC3Vor6Ink=;
 b=Vyii7Z2CN5TyhSHSV0OTZnW9aOgnEI1SoGqI4V9UJzW6UTkcdj+gRxRNceidvv0OHp
 rLXA0hMWd01q7ILBSZOKJYYJqs6P7j2W+H8XGcBzK/AWERswLmhT3sWScePeui2C1V6h
 XzwJxACn6kuFIc+MyRZCUpLmVY8f7m8k3gt3y+xG8uTJUo3nF3Bp9aagIdn/uLm7B/Qv
 btIHDr0i2tng8i+91Kl/2UF3MGl6NXec+moYNG7JeWK7dgWlqQT+3mDoVHF9sd5ohvut
 +6ii0pO+xKxU/Gk2ZTgRkIOre5oLkCsVqgbyqolXpAxRYJTkKOQURVv+d/XjvbjXhuF/
 WfWQ==
X-Gm-Message-State: AO0yUKVbP8pwhy2qgDZai8WfpovbbFFaNlBORhe4px/jqNIjh39QU21y
 xW4AF/2pDxIb5sAwOCzqPEA=
X-Google-Smtp-Source: AK7set/nqVQFKuR5HZ7avanAeCHZtQX4F/DWqF3XiIdPGn6AeQrfTINgT54UGfZtaojzvntBf9/kww==
X-Received: by 2002:a5e:dc02:0:b0:723:8cb5:6702 with SMTP id
 b2-20020a5edc02000000b007238cb56702mr7369794iok.1.1675610194522; 
 Sun, 05 Feb 2023 07:16:34 -0800 (PST)
Received: from localhost ([2602:47:d3e7:3200:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a056638000400b003b6c70901a9sm1443882jao.54.2023.02.05.07.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Feb 2023 07:16:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Feb 2023 08:16:33 -0700
Message-Id: <CQAQ8O6CFTBV.3RFCV63C80HV@mcoffin-dev-tower>
From: "Matt Coffin" <mcoffin13@gmail.com>
To: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
X-Mailer: aerc 0.14.0
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
 <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
 <DM6PR12MB26194938F0D4873D5DB83A1DE4FC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_N8RQAZtEy03qohNQF_7c_kLLQOQ0FGvXtRAqvBbV-Aeg@mail.gmail.com>
 <CQ1NGA3RIC0B.1SZDU9JBEN6MW@mcoffin-dev-tower>
 <CADnq5_PP0m6t5bk79nEFN-PiSsvhSuNR4WA2RAC3LUz5a4yS4A@mail.gmail.com>
In-Reply-To: <CADnq5_PP0m6t5bk79nEFN-PiSsvhSuNR4WA2RAC3LUz5a4yS4A@mail.gmail.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu Jan 26, 2023 at 11:26 AM MST, Alex Deucher wrote:
> I'm following up with the SMU teams.  Will get back to you when I know mo=
re.

Hey again guys,

I'm still relatively stuck on this, both due to being confused the
*seemingly* out-of-date information in the pm/inc/smu_v13_0_0_pptable.h
header, and my general lack of experience in any kind of reversing when
it comes to hardware interaction.

I do have one update, though: I found that the smu *is* able to accept
*some* changes in the overdrive table, so the message to upload it to
VRAM *is* working. The only thing I've been able to modify is the
FeaturesCtrlMask, but I haven't been able to discern which bits would
correspond to which features, but it doesn't appear to have a
correlation to the SMU_13_0_0_ODFEATURE mask(s) if the supported
capabilities information is to be beleived (if that were the case, then
it's rejecting bits being set that it says it supports, *OR* the header
is more off than I'd thought).

I know y'all are busy, so sorry to bother, but anything helps since I
don't quite know where to go from here right now.

Cheers,
Matt

> > Sorry for the late reply; I became busy with day job. I've been working
> > on implementing OD support (and a sysfs interface to set *any* OD
> > setting by number, in contrast with pp_od_clk_voltage's pidgeon-holing
> > into supporting only PP_OD_DPM_TABLE_COMMAND commands), at the very
> > least for my own experimentation.
> >
> > The following is what I see when I read the OD table out from the SMU
> > (assuming that the inclusion of another VF curve setting at index 4 in
> > the header was a mistake, based on the values returned by the SMU).
> >
> > It seems that, at least in my case, my hardware is running in some kind
> > of mode that would *not* allow changing of the fan curve? Is it possble
> > that the header information in pm/inc/smu_v13_0_0_pptable.h is incorrec=
t
> > even beyond the potential idx 4 of ODSETTINGs?
> >
> > It appears also that transferring the OD table *back* to the SMU result=
s
> > in no error, but also no action taken, as subsequent reads to not
> > reflect any changes. I'm thinking this is due to some values read in on
> > the inital read of the table being invalid, but seemingly irrelevant
> > given what is reported by the capabilities (see: FAN_CURVE[*]).
> >
> > Is there any hints you guys could offer in terms of
> >
> > 1. what might be mal-aligned or mis-labeled in the smu_v13 pptable
> > header above?
> > 2. What pre-requisites I might be missing to allow the support for
> > ODCAP_FAN_CURVE?
> > 3. Why the apparent values for some settings in the boot table seemingl=
y
> > wildly invalid? Will those somehow become valid once pre-requisites for
> > OD operation are met?
> >
> > I also feel like I've strayed from the original topic of the proposed
> > patch, and this probably belongs in it's own thread... but quite know
> > how to preserve any context there (sorry).
> >
> > Thanks in advance for helping out an eager outsider,
> > Matt
> >
> > Capabilities:
> > SMU_13_0_0_ODCAP_GFXCLK_LIMITS[0] true
> > SMU_13_0_0_ODCAP_GFXCLK_CURVE[1] true
> > SMU_13_0_0_ODCAP_UCLK_LIMITS[2] true
> > SMU_13_0_0_ODCAP_POWER_LIMIT[3] true
> > SMU_13_0_0_ODCAP_FAN_ACOUSTIC_LIMIT[4] true
> > SMU_13_0_0_ODCAP_FAN_SPEED_MIN[5] true
> > SMU_13_0_0_ODCAP_TEMPERATURE_FAN[6] true
> > SMU_13_0_0_ODCAP_TEMPERATURE_SYSTEM[7] true
> > SMU_13_0_0_ODCAP_MEMORY_TIMING_TUNE[8] true
> > SMU_13_0_0_ODCAP_FAN_ZERO_RPM_CONTROL[9] true
> > SMU_13_0_0_ODCAP_AUTO_UV_ENGINE[10] true
> > SMU_13_0_0_ODCAP_AUTO_OC_ENGINE[11] true
> > SMU_13_0_0_ODCAP_AUTO_OC_MEMORY[12] true
> > SMU_13_0_0_ODCAP_FAN_CURVE[13] false
> > SMU_13_0_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT[14] true
> > SMU_13_0_0_ODCAP_POWER_MODE[15] false
> >
> > Limits:
> > SMU_13_0_0_ODSETTING_GFXCLKFMAX[0] - [500,5000]
> > SMU_13_0_0_ODSETTING_GFXCLKFMIN[1] - [500,5000]
> > SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_A[2] - [97,1500]
> > SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_B[3] - [97,1500]
> > SMU_13_0_0_ODSETTING_CUSTOM_CURVE_VFT_FMIN[4] - [10,15]
> > SMU_13_0_0_ODSETTING_UCLKFMIN[5] - [500,3200]
> > SMU_13_0_0_ODSETTING_UCLKFMAX[6] - [500,3200]
> > SMU_13_0_0_ODSETTING_POWERPERCENTAGE[7] - [25,105]
> > SMU_13_0_0_ODSETTING_FANRPMMIN[8] - [50,110]
> > SMU_13_0_0_ODSETTING_FANRPMACOUSTICLIMIT[9] - [0,1]
> > SMU_13_0_0_ODSETTING_FANTARGETTEMPERATURE[10] - [0,1]
> > SMU_13_0_0_ODSETTING_OPERATINGTEMPMAX[11] - [0,1]
> > SMU_13_0_0_ODSETTING_ACTIMING[12] - [0,1]
> > SMU_13_0_0_ODSETTING_FAN_ZERO_RPM_CONTROL[13] - [0,1]
> > SMU_13_0_0_ODSETTING_AUTOUVENGINE[14] - [25,100]
> > SMU_13_0_0_ODSETTING_AUTOOCENGINE[15] - [23,100]
> > SMU_13_0_0_ODSETTING_AUTOOCMEMORY[16] - [25,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_1[17] - [23,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_1[18] - [25,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_2[19] - [23,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_2[20] - [25,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_3[21] - [23,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_3[22] - [25,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_4[23] - [23,100]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_4[24] - [0,0]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_5[25] - [0,1]
> > SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_5[26] - [0,0]
> > SMU_13_0_0_ODSETTING_AUTO_FAN_ACOUSTIC_LIMIT[27] - [0,0]
> > SMU_13_0_0_ODSETTING_POWER_MODE[28] - [0,0]
> >
> > Boot OD Table:
> > GFXFLK: [600, 2945]
> > UCLK: [97, 1249]
> > FAN_CURVE[0]: 0 @ 0
> > FAN_CURVE[1]: 0 @ 0
> > FAN_CURVE[2]: 0 @ 0
> > FAN_CURVE[3]: 0 @ 0
> > FAN_CURVE[4]: 0 @ 0
> > FAN_CURVE[5]: 0 @ 0
> > FAN_MIN_PWM: 35
> > FAN_TARGET_TEMP: 94
> > FAN_ZERO_RPM_ENABLE: true
> > FAN_MODE: 0

