Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65797C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 15:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF4710E2EA;
	Tue,  8 Feb 2022 15:28:52 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22B510E345
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 15:28:51 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 u47-20020a4a9732000000b00316d0257de0so15067874ooi.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 07:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d++INkcQbdqoo6z89G04whQv2K3EDVnyirHllxtTPfk=;
 b=YFgUMIK41IObnANi66cwCy3WwwaDqylKwH6uQEBYdFFf11TjlXU6kGIlURogsfW2if
 z0ZMWr7ucsD86cbDe+YSypkJlitQJv6wyG1phy98vi3dBwfsC2sDLxcoSjHA0tr6WmBd
 xcJGri3S0V5noX0eVyWbgQ3yFirW43oVm7tUqxfoR+nt6hOXfO6YjrHvXAWrTnB3S/IH
 KUwFL6dbghR0AW2RIug382SQUH93atRKk3nYpqIxs+D1iLZc3pMObwKPPtiiok0JU2lO
 hIwSS3zpNEVZ5HBzAEOKUQgK5UxTWo/D2Qaygo9gyfueF07NccsBgcOhdOexmCuj+rAU
 7c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d++INkcQbdqoo6z89G04whQv2K3EDVnyirHllxtTPfk=;
 b=wPaAFfdv+VuX2u1RdPIhl0ql478tvWzr6W8wFmE4ZStef8rYKMGTn2KRQMFzmZNG75
 OjigvfVNK1/CRvmfvZaPyJjpGrEAaCLdBw2I+JcHkGJH8ENP9BQZ8HlDRG0pCzQqISKw
 cbibzIUPiGL5VzrP3OsW5B7NEQuOFDpyni8Gk0DoiHOzObBmbOKSDNewa5eY1l7qoSs5
 ShG1X4q9TGK7fzi8iiJkvsBJYzh/1TltBnhdE3kaiAR8FmAughAJNLO6Vg4mxSK7KSYS
 +zvEScE7eOCjbz8UNYLQnRAbaRS4L38EapKdHYdRPgiFaYlglg+TGSE5CWDX4tvk9a84
 0iHA==
X-Gm-Message-State: AOAM533e7XNWd1A6VRDtAzeno/s3jXCke8TQJukrfOMECPF6ZShTf2Pe
 j72wupHcdx1zgWyt7/xXoyO7OY9QLfgV/gBQvfo4wP9VFDk=
X-Google-Smtp-Source: ABdhPJwclQRZRgq3Yz6rAGhinpuYvtPH07IeHvQHrEYmOGMZzugWjXpcmRGPKMh/MVVAa9kM0FL5yMFIkevaApEl/to=
X-Received: by 2002:a05:6870:54d6:: with SMTP id
 g22mr518813oan.225.1644334130891; 
 Tue, 08 Feb 2022 07:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
In-Reply-To: <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Feb 2022 10:28:39 -0500
Message-ID: <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
<Amaranath.Somalapuram@amd.com> wrote:
>
> Dump the list of register values to trace event on GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e651b959141..057922fb7e37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>         return r;
>  }
>
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +       int i;
> +       uint32_t reg_value[128];
> +
> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
> +               if (adev->asic_type >= CHIP_NAVI10)

This check should be against CHIP_VEGA10.  Also, this only allows for
GC registers.  If we wanted to dump other registers, we'd need a
different macro.  Might be better to just use RREG32 here for
everything and then encode the full offset using
SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
about how to handle gfxoff in this case.  gfxoff needs to be disabled
or we'll hang the chip if we try and read GC or SDMA registers via
MMIO which will adversely affect the hang signature.

Alex

> +                       reg_value[i] = RREG32_SOC15_IP(GC, adev->reset_dump_reg_list[i]);
> +               else
> +                       reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
> +       }
> +
> +       trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, i);
> +
> +       return 0;
> +}
> +
>  int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                          struct amdgpu_reset_context *reset_context)
>  {
> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                                 tmp_adev->gmc.xgmi.pending_reset = false;
>                                 if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>                                         r = -EALREADY;
> -                       } else
> +                       } else {
> +                               amdgpu_reset_reg_dumps(tmp_adev);
>                                 r = amdgpu_asic_reset(tmp_adev);
> +                       }
>
>                         if (r) {
>                                 dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..3fe33de3564a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>                       __entry->seqno)
>  );
>
> +TRACE_EVENT(amdgpu_reset_reg_dumps,
> +           TP_PROTO(long *address, uint32_t *value, int length),
> +           TP_ARGS(address, value, length),
> +           TP_STRUCT__entry(
> +                            __array(long, address, 128)
> +                            __array(uint32_t, value, 128)
> +                            __field(int, len)
> +                            ),
> +           TP_fast_assign(
> +                          memcpy(__entry->address, address, 128);
> +                          memcpy(__entry->value,  value, 128);
> +                          __entry->len = length;
> +                          ),
> +           TP_printk("amdgpu register dump offset: %s value: %s ",
> +                     __print_array(__entry->address, __entry->len, 8),
> +                     __print_array(__entry->value, __entry->len, 8)
> +                    )
> +);
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> --
> 2.25.1
>
