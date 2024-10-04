Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFCFCF8857
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 20:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBB510EAB1;
	Fri,  4 Oct 2024 20:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dV7w+d52";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551E210EAB1
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 20:52:24 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7e9f0e91961so62971a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728075144; x=1728679944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcGB3qPTIyAq2lyv3gVDHDXN+w1J2sfilEkLN6A+gPs=;
 b=dV7w+d52sy0HPCQ/uztvxqaF9W4+s7RIkoE9WKlmX7SL6jAImf8NAfcYXuc4c+hKj1
 FHYdrYu3ZQj5pukS7EKTJbeAwGCJbprTuYR8d7C1hRLFZrU6zsTZ8CsVv01tbISGgvvj
 slI+OcQeHUu8iqtRDxrMfUgj8cNMvNj30JoJBpyeEsIERtQYICmiFb9+lWVnjWnj1eV7
 4ElOCl66dGQSS0T87PLHam2t9QoJaz6iUlksE+KYQYanmcc1LP5dblBVW9TgIIr2iDCm
 7xT9eMKu7j/WZyvTaH+Ghig489rO7XlR0VeShDje0KSHuGRbvfvPuo+MEjntrFkLUKTN
 4XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728075144; x=1728679944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcGB3qPTIyAq2lyv3gVDHDXN+w1J2sfilEkLN6A+gPs=;
 b=JYrQOecgtwRAvZHoe7pUZSBohIvauXSPcrpCiLSwtAIn9dBOXWZBtfy8EK1uDY2cmh
 vbqTYo4TTtv4y0m/G7ehDTF5GGdhZt/2atQIC0uw7PsveSYzYf+L15J41TaniNERf0J+
 1L90BGoOEhlFoXL9x52QGfBev3evtro45KlPLJdpi1zu3s4MjexKauKg3oeeZnxZ+sZa
 QjVJdI0ozkFzf5iDEQU+lh9uWHFDk7p5CYI+Vq2O6gd7/dANi0Ka9vsZfo/lW5+xayWC
 WNLVQU4mOlePG5OrbxykKl7o7MpCaid42uWaGCHSs8ciw8jAo0Wlladv0xrLDvtuZmzR
 yGQw==
X-Gm-Message-State: AOJu0Yzalji+HbZ0t8xtMjEIp/t3JE3sBJUWMeXk3xG0mptpKZ/vYcbO
 PPDsGnckgXI2b1koZZ07D1JS4duEfD0CTFogwAg0mzFe7GLyPDegmj+cl+8xrSPk6Yz65hTJyMG
 gmAtRapW8f2yUrUd/lp+KWSVCpNJ07w==
X-Google-Smtp-Source: AGHT+IEyLbDaJotxu0JWabK3Z8khe4QKbWO5nRb0owghJNfcN0DktBUWWEuulBBkDzLF0tmx3UYSBoxyCnSADqsKdPg=
X-Received: by 2002:a17:902:f54f:b0:20b:7a43:3693 with SMTP id
 d9443c01a7336-20bfde64ef8mr26491735ad.1.1728075143741; Fri, 04 Oct 2024
 13:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241004203350.201294-1-hamza.mahfooz@amd.com>
 <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com>
 <7efda303-f813-4da8-988c-110a90f49964@amd.com>
In-Reply-To: <7efda303-f813-4da8-988c-110a90f49964@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 16:52:12 -0400
Message-ID: <CADnq5_O0WDiFYCZbkSov37gv-QhaORKbHpUYPguFimQXdRd01Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Roman Li <roman.li@amd.com>, stable@vger.kernel.org
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

On Fri, Oct 4, 2024 at 4:49=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> On 10/4/24 16:44, Alex Deucher wrote:
> > On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd=
.com> wrote:
> >>
> >> Since, two suspend-resume cycles are required to enter hibernate and,
> >> since we only need to enable idle optimizations in the first cycle
> >> (which is pretty much equivalent to s2idle). We can check in_s0ix, to
> >> prevent the system from entering idle optimizations before it actually
> >> enters hibernate (from display's perspective).
> >>
> >> Cc: stable@vger.kernel.org # 6.10+
> >> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 4651b884d8d9..546a168a2fbf 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *=
ip_block)
> >>
> >>          hpd_rx_irq_work_suspend(dm);
> >>
> >> -       if (adev->dm.dc->caps.ips_support)
> >> -               dc_allow_idle_optimizations(adev->dm.dc, true);
> >> -
> >>          dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> >> +
> >> +       if (dm->dc->caps.ips_support && adev->in_s0ix)
> >> +               dc_allow_idle_optimizations(dm->dc, true);
> >> +
> >
> > Is the ordering change with respect to dc_set_power_state() intended?
>
> Yup, it's safer to set idle opts after dc_set_power_state(), since it
> involves a write to DMUB.

Might want to mention that in the commit message.  With that:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> >
> > Alex
> >
> >>          dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM=
_POWER_STATE_D3);
> >>
> >>          return 0;
> >> --
> >> 2.46.0
> >>
> --
> Hamza
>
