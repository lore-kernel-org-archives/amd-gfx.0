Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F368FC61DA3
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 18:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEF010E973;
	Thu, 26 Jan 2023 18:26:37 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A7010E971
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 18:26:35 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1631b928691so3423270fac.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/untE5AhezVOHQQuPSz4GBMmRtu8IWmcwQR9iYPggV8=;
 b=Vdy7JBCeljHbRszPFm15A4YVZK9ftUp6DEGjaEMDOrZiDrXeE8Ph12yXbjrWK4WJEF
 OlEKj0D7TUGDCCe245+H77LQSB/4Eo5/mpCclylE0eYjWUSEuNwP5VJH+EJzMzNcbwfk
 CCY/rBLMOe7j8ag+8N5ARVBntViSM4iy2CbVqnvfU2dZAVTPyoQkEHwTgNFhaywUiXuu
 xf9YXL1NGdkb58oN987GUBPYqy69UNMqJb5k+9ty1vo1zIYnePKHT5eqIT1+udrC+nC0
 64gmwuanYnSXP2UqcRiKDieFYyfEK9F3Cw/XvS4GPH71pXeNWZqg6blXvz5lkvQYlgIs
 G81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/untE5AhezVOHQQuPSz4GBMmRtu8IWmcwQR9iYPggV8=;
 b=NxwEK6QT7p9hAoqOnb5btEKZn51FBMrSZrpO7Fneuh4+U/aUFDlm425sRnCBIEB/7v
 ykTWozqykAMMBnzjNp1A7z2ZNwvhlG4+K0Pnx/+6Uws9Lp/WJoGV04p28cPdwXwB4JJg
 5HvkZ6yDHGPr73ghd0OBIaW5rlD+Gmi6zXFrbNSorZ47Sa6TYj4wkA14JvR7CW0fiwR8
 aCQLbVXMbjERDPNI7/CC/zOtMepUsTgS+xg3hWlIvec+pvwe0Gg5dnWTKIMJSp6JEV/V
 aT4miyxPicJmyRgKzq5A5UP8YO1hODn1KJ8bA3dXdnQ1AGy9NpcjTFiWIrX5WOgUPNko
 z+aA==
X-Gm-Message-State: AFqh2kq3zjuJpprXDCJO56wbuGJfcvS4DLG8YZ2cnS/57hwgxOerO8iW
 xVrcw1ExE3rFhJUa/cHsvExBv2mBKYK7vw7fEoY=
X-Google-Smtp-Source: AMrXdXsbm6KfoOTpgDYyUHqgxALUaLGk8nunipgwOXL3mrnndKP72VbzJIfIaEh67+0BwAmRquWvCZSuKQ+AvEdht7A=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr3503079oab.46.1674757594507; Thu, 26
 Jan 2023 10:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
 <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
 <DM6PR12MB26194938F0D4873D5DB83A1DE4FC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_N8RQAZtEy03qohNQF_7c_kLLQOQ0FGvXtRAqvBbV-Aeg@mail.gmail.com>
 <CQ1NGA3RIC0B.1SZDU9JBEN6MW@mcoffin-dev-tower>
In-Reply-To: <CQ1NGA3RIC0B.1SZDU9JBEN6MW@mcoffin-dev-tower>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Jan 2023 13:26:23 -0500
Message-ID: <CADnq5_PP0m6t5bk79nEFN-PiSsvhSuNR4WA2RAC3LUz5a4yS4A@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
To: Matt Coffin <mcoffin13@gmail.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 25, 2023 at 7:14 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> On Wed Jan 11, 2023 at 7:47 AM MST, Alex Deucher wrote:
> > On Wed, Jan 11, 2023 at 8:23 AM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only - General]
> > >
> > > Regarding the manual fan speed setting issue targeted by this patch, the SCPM feature of the new SMU13 asics prevents us from toggling the fan control feature from auto to manual.
>
> This makes sense as a move towards using the same interface that other
> platforms are most likely using.
>
> > > About the capability in the OD table you mentioned, it might be a different issue.
>
> I included some info/questions below; any hints you could give to point
> me in the right way to keep learning would be appreciated.

I'm following up with the SMU teams.  Will get back to you when I know more.

Thanks,

Alex

>
> >
> > Right.  Manual fan control is no longer possible.  As Evan said, you
> > can adjust the automatic fan curve using the OD interface, but that is
> > it.
>
> Sorry for the late reply; I became busy with day job. I've been working
> on implementing OD support (and a sysfs interface to set *any* OD
> setting by number, in contrast with pp_od_clk_voltage's pidgeon-holing
> into supporting only PP_OD_DPM_TABLE_COMMAND commands), at the very
> least for my own experimentation.
>
> The following is what I see when I read the OD table out from the SMU
> (assuming that the inclusion of another VF curve setting at index 4 in
> the header was a mistake, based on the values returned by the SMU).
>
> It seems that, at least in my case, my hardware is running in some kind
> of mode that would *not* allow changing of the fan curve? Is it possble
> that the header information in pm/inc/smu_v13_0_0_pptable.h is incorrect
> even beyond the potential idx 4 of ODSETTINGs?
>
> It appears also that transferring the OD table *back* to the SMU results
> in no error, but also no action taken, as subsequent reads to not
> reflect any changes. I'm thinking this is due to some values read in on
> the inital read of the table being invalid, but seemingly irrelevant
> given what is reported by the capabilities (see: FAN_CURVE[*]).
>
> Is there any hints you guys could offer in terms of
>
> 1. what might be mal-aligned or mis-labeled in the smu_v13 pptable
> header above?
> 2. What pre-requisites I might be missing to allow the support for
> ODCAP_FAN_CURVE?
> 3. Why the apparent values for some settings in the boot table seemingly
> wildly invalid? Will those somehow become valid once pre-requisites for
> OD operation are met?
>
> I also feel like I've strayed from the original topic of the proposed
> patch, and this probably belongs in it's own thread... but quite know
> how to preserve any context there (sorry).
>
> Thanks in advance for helping out an eager outsider,
> Matt
>
> Capabilities:
> SMU_13_0_0_ODCAP_GFXCLK_LIMITS[0] true
> SMU_13_0_0_ODCAP_GFXCLK_CURVE[1] true
> SMU_13_0_0_ODCAP_UCLK_LIMITS[2] true
> SMU_13_0_0_ODCAP_POWER_LIMIT[3] true
> SMU_13_0_0_ODCAP_FAN_ACOUSTIC_LIMIT[4] true
> SMU_13_0_0_ODCAP_FAN_SPEED_MIN[5] true
> SMU_13_0_0_ODCAP_TEMPERATURE_FAN[6] true
> SMU_13_0_0_ODCAP_TEMPERATURE_SYSTEM[7] true
> SMU_13_0_0_ODCAP_MEMORY_TIMING_TUNE[8] true
> SMU_13_0_0_ODCAP_FAN_ZERO_RPM_CONTROL[9] true
> SMU_13_0_0_ODCAP_AUTO_UV_ENGINE[10] true
> SMU_13_0_0_ODCAP_AUTO_OC_ENGINE[11] true
> SMU_13_0_0_ODCAP_AUTO_OC_MEMORY[12] true
> SMU_13_0_0_ODCAP_FAN_CURVE[13] false
> SMU_13_0_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT[14] true
> SMU_13_0_0_ODCAP_POWER_MODE[15] false
>
> Limits:
> SMU_13_0_0_ODSETTING_GFXCLKFMAX[0] - [500,5000]
> SMU_13_0_0_ODSETTING_GFXCLKFMIN[1] - [500,5000]
> SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_A[2] - [97,1500]
> SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_B[3] - [97,1500]
> SMU_13_0_0_ODSETTING_CUSTOM_CURVE_VFT_FMIN[4] - [10,15]
> SMU_13_0_0_ODSETTING_UCLKFMIN[5] - [500,3200]
> SMU_13_0_0_ODSETTING_UCLKFMAX[6] - [500,3200]
> SMU_13_0_0_ODSETTING_POWERPERCENTAGE[7] - [25,105]
> SMU_13_0_0_ODSETTING_FANRPMMIN[8] - [50,110]
> SMU_13_0_0_ODSETTING_FANRPMACOUSTICLIMIT[9] - [0,1]
> SMU_13_0_0_ODSETTING_FANTARGETTEMPERATURE[10] - [0,1]
> SMU_13_0_0_ODSETTING_OPERATINGTEMPMAX[11] - [0,1]
> SMU_13_0_0_ODSETTING_ACTIMING[12] - [0,1]
> SMU_13_0_0_ODSETTING_FAN_ZERO_RPM_CONTROL[13] - [0,1]
> SMU_13_0_0_ODSETTING_AUTOUVENGINE[14] - [25,100]
> SMU_13_0_0_ODSETTING_AUTOOCENGINE[15] - [23,100]
> SMU_13_0_0_ODSETTING_AUTOOCMEMORY[16] - [25,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_1[17] - [23,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_1[18] - [25,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_2[19] - [23,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_2[20] - [25,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_3[21] - [23,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_3[22] - [25,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_4[23] - [23,100]
> SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_4[24] - [0,0]
> SMU_13_0_0_ODSETTING_FAN_CURVE_TEMPERATURE_5[25] - [0,1]
> SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_5[26] - [0,0]
> SMU_13_0_0_ODSETTING_AUTO_FAN_ACOUSTIC_LIMIT[27] - [0,0]
> SMU_13_0_0_ODSETTING_POWER_MODE[28] - [0,0]
>
> Boot OD Table:
> GFXFLK: [600, 2945]
> UCLK: [97, 1249]
> FAN_CURVE[0]: 0 @ 0
> FAN_CURVE[1]: 0 @ 0
> FAN_CURVE[2]: 0 @ 0
> FAN_CURVE[3]: 0 @ 0
> FAN_CURVE[4]: 0 @ 0
> FAN_CURVE[5]: 0 @ 0
> FAN_MIN_PWM: 35
> FAN_TARGET_TEMP: 94
> FAN_ZERO_RPM_ENABLE: true
> FAN_MODE: 0
