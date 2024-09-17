Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEDCC3601E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 14:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6CA10E0BC;
	Tue, 17 Sep 2024 14:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeYVlMhk";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB3810E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 14:18:43 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2053f72319fso3200915ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726582723; x=1727187523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4WPr1pbAlZah0iiL5eeCFWmiEBgVs2YL/Ot/1IDXzo=;
 b=IeYVlMhkRRG2fdLXtI1kR2sqAPdebtU+tmjk9pD06uFtuBVeQKmsgUqRCyf9+aAoYw
 qqQFa922ycJYc0/9jM2TuycoY1GWrn5nk0RsK9sYFx/FIMWHBfxoDL4YXT/mgcpScIpb
 hyGtTqj9WsUWAPxtY126plyoT/TZJqDVhs4RoEEPD9b22+zFJ9+cPfR4gGhyyVQkQ5tr
 W2ta/qlAbA13iN97Ozj/90yI1s58B7ufxif7PVQPskQIhsfLfjLaebmDzWwxuCQz0Vp2
 DaGr7tSJQ26vhKYtaFGBRyIJrjfjG1vEJHPwZPDGKSlqrCPq5ShgZy/WcqlArv4mR1QC
 FGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726582723; x=1727187523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4WPr1pbAlZah0iiL5eeCFWmiEBgVs2YL/Ot/1IDXzo=;
 b=Qi42Ypgcy757wsSWdNUG9VMfI7DsIn/EWsgtR/DU5AtVrM0in1VOwWvQg5a4PyFyiH
 ab8sVoavs6YSb1nOeMqAzSG7eArWVu0VJDYklUt5FlD+NvXpdEM4vRGCDNri9zWMk37Z
 MqVx0PI+PiFzZYbWm0mN8fzziKpAWK9kr9fI/5nyQvVUOrNpZ99j+i0yihpfe1LiCEaN
 YTY4FC/U5NozTXkdx0ErvieVn0URhkPATAGDHX1R3NJlmBaKY4kN+dVjXItTQlsuHw5/
 IbTg4kTNLh16SDkm1cJ5ybbrrmwFRvl1FhaHeMNm3NDNdTJlzV91hFgrIes5pSXJlLqm
 B9gQ==
X-Gm-Message-State: AOJu0Yze6Nx0TfJmOusInYmrBDF3P9xHBbsQGNSBZTu1xk39J9SAxpa9
 N/y46L/ZvtBCMt7gLz5g0L8BTAWOAQc0Z6y7Jw+qP6e1KzuPT4qF+WHa6nbZCMnwWy5XYh/Er1+
 LVVDJAgyrONNhSaiRXeoV9MJ+1xY=
X-Google-Smtp-Source: AGHT+IEa77OdkYXbyt6ZgKUa9tRWlYpDel2v8QHQHPcwfxq3FO6Erwh69f+dYsXy6bbNaaE9fX6NUzcFVCDBtirh8sw=
X-Received: by 2002:a17:902:d4cb:b0:205:4415:c62f with SMTP id
 d9443c01a7336-2076e318b03mr119942355ad.1.1726582723217; Tue, 17 Sep 2024
 07:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <0hK0BKCBLeH6gSnQwLZWrj2gi0Lr11FUnZN_O0S0Slx4jqvJ5SYYneohmweiegj2k-y4InxuAmdn1pEvcVrOcf00p6is32iKf21JZ-dC5As=@protonmail.com>
In-Reply-To: <0hK0BKCBLeH6gSnQwLZWrj2gi0Lr11FUnZN_O0S0Slx4jqvJ5SYYneohmweiegj2k-y4InxuAmdn1pEvcVrOcf00p6is32iKf21JZ-dC5As=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Sep 2024 10:18:31 -0400
Message-ID: <CADnq5_NDPJpieW0++z4MzthaUrY=SqEO_tZOQLNMrU2FRmRdgg@mail.gmail.com>
Subject: Re: amdgpu driver probe error
To: Athul Krishna <athul.krishna.kr@protonmail.com>
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

On Sat, Sep 14, 2024 at 6:03=E2=80=AFAM Athul Krishna
<athul.krishna.kr@protonmail.com> wrote:
>
> Device: ASUS Zephyrus G14 GA402RJ
> CPU: AMD R7 6800HS
> GPU: Radeon RX 6700S
> Kernel: 6.10.8
>
> Hello,
>
> I have encountered a problem with this specific device. So I'll explain t=
he backstory a little bit.
>
> \_SB_.PCI0.GPP0.SWUS.SWDS.VGA_, this is the firmware path of the discrete=
 GPU and \_SB_.PCI0.GPP0 is the hotplug bridge. An eject notification will =
remove all the devices under \_SB_.PCI0.GPP0, i.e, SWUS and SWDS(PCI-PCI br=
idges) and VGA_ will be gone. So will be their acpi_hotplug_context.
>
> So device check notification to VGA_, with the current implementation of =
acpiphp module will not be handled. I have modified the code so that device=
 check notification to VGA_ will runtime resume \_SB_.PCI0.GPP0(pci_pm_runt=
ime_resume() callback), which then will enable interrupt to the bridge, and=
 the rest will be handled by pciehp module.
>
> Here's my problem, when device_attach() is called on the GPU, it spews ou=
t bunch of error. Most of the time I get:
>
> amdgpu 0000:03:00.0: amdgpu: SMU: response:0xFFFFFFFF for index:2 param:0=
x00000000 message:GetSmuVersion?
> amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset failed
> amdgpu 0000:03:00.0: amdgpu: asic reset on init failed
> amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>
> very rarely:
>
> amdgpu 0000:03:00.0: amdgpu: PSP create ring failed!
> amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
>
> Any help would be really appreciated. I have attached the dmesg output.

I'm not sure I understand what you are trying to do.  The kernel can
already put the device into runtime suspend (e.g., D3cold) when it's
idle without using hotplug.  It looks like the dGPU is not properly
powered on when the drivers tries to initialize the board after
whatever you did.

Alex

>
> Thanks,
> Athul
