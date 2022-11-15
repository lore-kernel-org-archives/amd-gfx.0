Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDE7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 14:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4230110E40B;
	Tue, 15 Nov 2022 14:49:30 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C90C10E407
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 14:32:57 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id d20so17713154ljc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nmA9IQtPhmRiYmAcsIQmMUcPERu6ZRIIUxXn0bYa/6g=;
 b=QOwZqVs8fubRz/Zg6o+b7q8eps3gQUTNRxzgyILaWP+VaqiIxTZg8ykjhoGo7DlDF+
 3eQpScJcdQuw8ZBRrhpEyfijoHttBOAJXDYPR9p/pk4j54GrccRdxmBiXsocfDcEt+n3
 VyQKgmn/JiZSbc0lQEuyM5DL6G6Mn6DAJD20JeUGna9WTfRmjh8NVtuJG+HijVxFDFzJ
 fTzXqTY43Cla0cq3V9CRqLWmLomaKaY56AfHSM69oggmPV7GINWLN54g0euKj2F3DWqI
 BZgj1XWGAS8OcLfd7s2tASE04yaFwLTB1NCVwcgYxeeMTgjXBIWVSTk7CXWAdd7vudx0
 a0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nmA9IQtPhmRiYmAcsIQmMUcPERu6ZRIIUxXn0bYa/6g=;
 b=I31Jd1CJMwgtOzgAoDohdwlqNyDNavJ5Ka0JZDojIqXFQ8MoG+YCQQ2UU/Yulji53E
 9lcYYRyJN8UIsPaMQN/PQZTyV2f+Z38DMV7vXbqffoQ0i04GZK7RbXriGrqL5ZMI1sGJ
 nbUgQTO6Y7MVoKBTnC2ucKyyf2L5cUMKEGZpjDTJBQug7kXjU4Nb4J0wTHv7MSma1/qV
 0K3Lzc2dyV0PBV6jrJYrEZ6qEK+Lr3zSExEdobRM4BiO8Yx7l2WiMxqyk+adXoI+6Y2Z
 Bd6mWPuC691pudPMkv5zVlxKrWYBMGSA6L+i82Z8dwK4mtpykT7WVXQdZBQEZ3pwwhiR
 22/w==
X-Gm-Message-State: ANoB5pkQuKztuSktLF01J/LR31esJUeYVaOjmkZKyfzFmN4OvBwdiftX
 4PbJPOf3EWRG5e/UJ3nIh4x8XNn/9HozvKKd7I+UHrQmRt5sZg==
X-Google-Smtp-Source: AA0mqf7paaGtSGHjYd9UZgrJFgHQREhXIs9y5X0cJWf1FhybtFyqaPbQK0cmhuHrouM/mWdHgRkWnTNOOuGT3I9/eZ0=
X-Received: by 2002:a2e:9109:0:b0:26e:9559:972 with SMTP id
 m9-20020a2e9109000000b0026e95590972mr6664284ljg.453.1668522775701; Tue, 15
 Nov 2022 06:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20221114231325.18698-1-jntesteves@gmail.com>
 <DM6PR12MB2619FDCED7C17F2B79166462E4049@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619FDCED7C17F2B79166462E4049@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Jonatas Esteves <jntesteves@gmail.com>
Date: Tue, 15 Nov 2022 11:32:43 -0300
Message-ID: <CAE+LsM--eb3uXAAbTFziETx4QaJ48PRVZaJ-V7-BHevOm0DpOg@mail.gmail.com>
Subject: RE: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
To: "Quan, Evan" <Evan.Quan@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Nov 2022 14:49:26 +0000
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

>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Jonatas Esteves
> > Sent: Tuesday, November 15, 2022 7:13 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Jonatas Esteves <jntesteves@gmail.com>
> > Subject: [PATCH] drm/amd/pm: Fix output of pp_od_clk_voltage
> >
> > Printing the other clock types should not be conditioned on being able
> > to print OD_SCLK. Some GPUs currently have limited capability of only
> > printing a subset of these.
> >
> > Since this condition was introduced in v5.18-rc1, reading from
> > `pp_od_clk_voltage` has been returning empty on the Asus ROG Strix G15
> > (2021).
> What's the output then with this patch applied?
```
$ cat /sys/class/drm/card1/device/pp_od_clk_voltage
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
```

Changing OD_VDDGFX_OFFSET works for this chip. Changing GFXCLK_LIMITS
and UCLK_LIMITS is not supported as per the checks in
sienna_cichlid_ppt.c -> sienna_cichlid_od_edit_dpm_table()

> Meanwhile can you show me the 'lspci' output( I wonder which asic is used on your system)?
The ASIC is a RX 6800M / NAVI22 / Navy Flounder / IP_VERSION(11, 0, 11)

```
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne
Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne
PCIe GPP Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne
PCIe GPP Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne
PCIe GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal
PCIe GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data
Fabric; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Upstream Port of PCI Express Switch (rev c3)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Downstream Port of PCI Express Switch
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Navi 22 [Radeon RX 6700/6700 XT/6750 XT / 6800M] (rev c3)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi
21/23 HDMI/DP Audio Controller
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
05:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express
Wireless Network Adapter
06:00.0 Non-Volatile memory controller: Intel Corporation Device f1aa (rev 03)
07:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series]
(rev c4)
07:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir
Radeon High Definition Audio Controller
07:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 10h-1fh) Platform Security Processor
07:00.3 USB controller: Advanced Micro Devices, Inc. [AMD]
Renoir/Cezanne USB 3.1
07:00.4 USB controller: Advanced Micro Devices, Inc. [AMD]
Renoir/Cezanne USB 3.1
07:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
07:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family
17h/19h HD Audio Controller
```

Here are some SMU initialization logs I think might also be important:
```
[  970.119696] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[  970.119701] amdgpu 0000:03:00.0: amdgpu: smu driver if version =
0x0000000e, smu fw if version = 0x00000012, smu fw program = 0,
version = 0x00413700 (65.55.0)
[  970.119704] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
[  970.119751] amdgpu 0000:03:00.0: amdgpu: use vbios provided pptable
[  970.183486] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
```

Thanks for your attention on this.
Jonatas
>
> BR
> Evan
> >
> > Fixes: 79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation
> > details to amdgpu_pm.c")
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 236657eece47..9d364bbc78e1 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -869,13 +869,11 @@ static ssize_t
> > amdgpu_get_pp_od_clk_voltage(struct device *dev,
> >       }
> >       if (ret == -ENOENT) {
> >               size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
> > -             if (size > 0) {
> > -                     size += amdgpu_dpm_print_clock_levels(adev,
> > OD_MCLK, buf + size);
> > -                     size += amdgpu_dpm_print_clock_levels(adev,
> > OD_VDDC_CURVE, buf + size);
> > -                     size += amdgpu_dpm_print_clock_levels(adev,
> > OD_VDDGFX_OFFSET, buf + size);
> > -                     size += amdgpu_dpm_print_clock_levels(adev,
> > OD_RANGE, buf + size);
> > -                     size += amdgpu_dpm_print_clock_levels(adev,
> > OD_CCLK, buf + size);
> > -             }
> > +             size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK,
> > buf + size);
> > +             size += amdgpu_dpm_print_clock_levels(adev,
> > OD_VDDC_CURVE, buf + size);
> > +             size += amdgpu_dpm_print_clock_levels(adev,
> > OD_VDDGFX_OFFSET, buf + size);
> > +             size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE,
> > buf + size);
> > +             size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK,
> > buf + size);
> >       }
> >
> >       if (size == 0)
> > --
> > 2.30.2
