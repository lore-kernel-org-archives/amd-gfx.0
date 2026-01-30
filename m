Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5916E6BF1E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821AA10E363;
	Fri, 30 Jan 2026 15:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UsSpC2Cd";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D59F10E363
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:49:34 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b71a4fdb86so170339eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 07:49:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769788173; cv=none;
 d=google.com; s=arc-20240605;
 b=jFe7OmQmVoGH/Qqq0LRalUUUUxcoRcOWEKiKueIfxRz6joWnlsbZD5bC6gfmajGYY6
 Ukz9kr7MtrjI3/RG3tcZW+qVKXBqhRFQzxvKv+RvPnel9+P9PKvWUhYs+s/lWwPC1DLD
 sSh3fNZTtMDnt8Wfa1bxWeT045SSw4lamb1wgJSK9hLTwp9rxdhnESrZQWMmW5kCiXYY
 WUIxB2WfgfLqKBrqRNkyHUI0bCOET8dpQor4muGd+cjYjzwYY0SLb8QkOCY5JThq0Fgi
 xWAJVpSA8usxcGwXNvVlYuiORNGyDyd14Pf7cJ50/sw2W4FZokGMdMoJSNp1X5K6vgbc
 +frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ipAW0zBx9xe8gKRQTwLZ7Kyod8OJ6GpumoVd24pyYM=;
 fh=ri8rmX3yk8HtxiXES8w1mww4Yee1P0AOIub8n8gW7PA=;
 b=lW1/4smwJFwYYKgE9uanYmmS+4/yal4mvOJwaRO058Q3In7n+EAvqzQDL3D0JtFIgp
 jRoGEq1qIIcLwSjojClUlxYYMQ/nO0wJoDtNTkPwvSD47+JLzC+Dn6viCXyTvUeO2MSb
 Ube/3GUfxOco51XTKSh6dkUodotuVCoFiTkNnT6jHh5cxzTO3anSEuVEtJQrTwJnsA+g
 0B6e2D2TTWeKhHc4OGwWLOnsUNygILBRGKI7UBN5vj4KfS7zSrB2fXta8a9yJliHONbp
 Bh2aLMPF4K2bocgvRRMImh63nCrZ913Iugn+/bVppqlGa555RV8XWuhFwfHNQ0nrGnT5
 BqGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769788173; x=1770392973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ipAW0zBx9xe8gKRQTwLZ7Kyod8OJ6GpumoVd24pyYM=;
 b=UsSpC2Cdn+nevFrNJXvHyPZrEh34Zb/i8P7FAdf1bQoLXEz29qOnVOqch/7SkOzYUP
 XS9v01ZpZ05X+TddHcClYdf3ZcOTiYVpZYPmDUuUDATGoYBv7yX01KjCzLXcUpvAeyWl
 pynWefo1xJIpaO0fy4pua3PpeY5vnk11tMOUqIddrni1yCn5tKs0JqcN64PeEt95b/rU
 ovB++OFvOhzagMlbRW5hdgYZn0NEfUReqv+mR4igH9EOL8EYIIuLiJGSlgB/H2J8FGty
 LhSbMNRYkgzhcfHDXyXaBDT7hSRpqFR4bWHkdR4xWVo8eB2N7ytk4PGd/mJKgazHfVE/
 H1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769788173; x=1770392973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ipAW0zBx9xe8gKRQTwLZ7Kyod8OJ6GpumoVd24pyYM=;
 b=aXaUrz56B3d4g1XsplErLOySBImcKAdYyNyaYQDhE6dbtSNE6LbCM+YufztPoNmd8e
 vo/5oKQct7H4Ny3t+5KGsfhQJpXSlkcF1TDXyktPPuYUNvGNh9w6N4L2LPausVh+Tcs4
 f/uaWkEPvQOZYHfifXoc+vjj41Debng44PCWorRvpDeL59nLn6YJLJKnLqxUH80z+3kr
 UOBQ9a1cSsm8KMb6xGQt8aFZ4i3COO63w6GrWQI7XG7IAO8fupL90YAAemMyB7UZaje4
 USCdqwxOi61sOYkF3r8Bhzp3TDHGhANZESf4jPIuuckCzr+gI4XqiQ6X1jCbAWomRywj
 Yzgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Jhi3nJ6DGCv91cBqkcWtAWE0YLHS/daQEoO4qqgouiq2aFHptiM8Ur7eahoXilzcaCs9hZIC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC0Vt2tngXz7Nbp7s2Og8HVaZsDJw6JsY8xmJw/jSvOUGxIz4a
 LYWB23SBnkxQGdYBtU2KGauBLvP2VXjOHy0knVsKVJcQva63ySNSYMT9+gTCSDzER/JD/hlAq/T
 Hwf0tFuC2ceSoUefDppr3J64bC4BlNzE=
X-Gm-Gg: AZuq6aK98jQyLxJ4VBFRpWoUvcYWAS4NRcT/Ng5MY0ENvBXW/b2eMydJNw6ZqK0AAly
 9FVRH67xl80Xmo64PUHZ6AatlzlCWUJQJNzQ2UAWsOYdr/N5PN0+aE16qIb6mA1fdhbkxd4HaRS
 TzN/AborNbot4WMrbKsC5iiIg7FXEE5DPE7w9P68iWvHVaN29xAntZYNaoVv5XqtoKgz2O/oYig
 U0v++hFcTtIYELwztnSG1iAoO9fImnV8hDVUaFLqUwh3ciwc4jOrtCLM/4/LFjRsua8a1gpCikW
 cAZdyR0=
X-Received: by 2002:a05:7300:7b81:b0:2b7:bb5:40b7 with SMTP id
 5a478bee46e88-2b7c895e6a3mr722388eec.9.1769788173294; Fri, 30 Jan 2026
 07:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
 <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
 <42191bbf-6f92-4883-8aa9-9e808fae3e8d@amd.com>
In-Reply-To: <42191bbf-6f92-4883-8aa9-9e808fae3e8d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 10:49:21 -0500
X-Gm-Features: AZwV_QhPNYzOso3v68avrkLcq9LCfbo0pNAdUDNZG4QGbY5R3OebNlnyddMKF80
Message-ID: <CADnq5_M-CoUDrWs9nOUSUF5yM+Jq2+RY1WS6mYGbWVYmtxgA8w@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Yifan Zhang <yifan1.zhang@amd.com>
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

On Fri, Jan 30, 2026 at 10:05=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 30-Jan-26 8:18 PM, Alex Deucher wrote:
> > On Tue, Jan 27, 2026 at 12:02=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.co=
m> wrote:
> >>
> >>
> >>
> >> On 27-Jan-26 1:37 AM, Alex Deucher wrote:
> >>> Need to make sure gfxoff is disallowed when we touch GC
> >>> registers over MMIO.
> >>>
> >>
> >> I think interrupt enable/disable sequence is only supposed to be done
> >> under ip power/clock ungate sequence like in hw init/resume/suspend
> >> sequences. The fix probably should be in the higher level sequence whi=
ch
> >> doesn't take care of that.
> >
> > In that case, Yifan's original patch is probably fine as is.  Someone
> > should still double check all of the call paths though.
> >
>
> Original one is also not correct. For example, if this is happening
> after reset re initialization, only that sequence needs to be modified
> to keep the affected IPs ungated during reinit.

It also gets called in amdgpu_device_fini_hw().

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> Cc: Yifan Zhang <yifan1.zhang@amd.com>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
> >>>    1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_0.c
> >>> index 36f0300a21bfa..05178ee8e0e3a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> @@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(st=
ruct amdgpu_device *adev,
> >>>        u32 cp_int_cntl_reg, cp_int_cntl;
> >>>        int i, j;
> >>>
> >>> +     amdgpu_gfx_off_ctrl(adev, false);
> >>>        switch (state) {
> >>>        case AMDGPU_IRQ_STATE_DISABLE:
> >>>        case AMDGPU_IRQ_STATE_ENABLE:
> >>> @@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(st=
ruct amdgpu_device *adev,
> >>>        default:
> >>>                break;
> >>>        }
> >>> +     amdgpu_gfx_off_ctrl(adev, true);
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(stru=
ct amdgpu_device *adev,
> >>>        u32 cp_int_cntl_reg, cp_int_cntl;
> >>>        int i, j;
> >>>
> >>> +     amdgpu_gfx_off_ctrl(adev, false);
> >>>        switch (state) {
> >>>        case AMDGPU_IRQ_STATE_DISABLE:
> >>>        case AMDGPU_IRQ_STATE_ENABLE:
> >>> @@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(stru=
ct amdgpu_device *adev,
> >>>        default:
> >>>                break;
> >>>        }
> >>> +     amdgpu_gfx_off_ctrl(adev, true);
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(s=
truct amdgpu_device *adev,
> >>>                                              unsigned type,
> >>>                                              enum amdgpu_interrupt_st=
ate state)
> >>>    {
> >>> +     amdgpu_gfx_off_ctrl(adev, false);
> >>>        switch (state) {
> >>>        case AMDGPU_IRQ_STATE_DISABLE:
> >>>        case AMDGPU_IRQ_STATE_ENABLE:
> >>> @@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(s=
truct amdgpu_device *adev,
> >>>        default:
> >>>                break;
> >>>        }
> >>> +     amdgpu_gfx_off_ctrl(adev, true);
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(stru=
ct amdgpu_device *adev,
> >>>                                              unsigned type,
> >>>                                              enum amdgpu_interrupt_st=
ate state)
> >>>    {
> >>> +     amdgpu_gfx_off_ctrl(adev, false);
> >>>        switch (state) {
> >>>        case AMDGPU_IRQ_STATE_DISABLE:
> >>>                WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
> >>> @@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(stru=
ct amdgpu_device *adev,
> >>>        default:
> >>>                break;
> >>>        }
> >>> +     amdgpu_gfx_off_ctrl(adev, true);
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(str=
uct amdgpu_device *adev,
> >>>                                            unsigned type,
> >>>                                            enum amdgpu_interrupt_stat=
e state)
> >>>    {
> >>> +     amdgpu_gfx_off_ctrl(adev, false);
> >>>        switch (type) {
> >>>        case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
> >>>                gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
> >>> @@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(str=
uct amdgpu_device *adev,
> >>>        default:
> >>>                break;
> >>>        }
> >>> +     amdgpu_gfx_off_ctrl(adev, true);
> >>>        return 0;
> >>>    }
> >>>
> >>
>
