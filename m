Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79770C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 19:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E9810E3CB;
	Mon, 27 Nov 2023 19:11:34 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71DB10E3CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 19:11:32 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1fa235f8026so1503924fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701112292; x=1701717092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfzRcTqpBktSLBkBD0j82m/Hwn5iOoiG8zoqIpWInnY=;
 b=NMs/zZc41b+UaF6zuB7I45X10rdQYdTa3PQBn0QWZeu/ENeocn9cFC//ZOfb+d0Ya6
 Oisxgmydvd5RZDdlINEAaG1/Gyh0QioAuj12fH/m5YywAHAHSi4if1riHrAwtg080Wmy
 F5nhjbFURL2Uhty22cUQrpabYSY4dzDqFPRVRIwWWQtx9Fxf5yNlfyP+SLFE2rLrYs6L
 2v/AxVXYxYRmEtJ9qwuIu81PVPGFnKUo9U9IBQ5Q8kIz54sDIxeO+8pdmfX/bX7rKGUx
 35lfTXyZdvbapLEPzek5bIdaOi+fyiAd0pGLpm9oJN5dXSlF69NwyaaIr4QpmUi0MLVK
 NbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701112292; x=1701717092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfzRcTqpBktSLBkBD0j82m/Hwn5iOoiG8zoqIpWInnY=;
 b=nXQ93/XhuAYdjckuH8/D7UHqeZ9u+y9On1z5ms/pE5R2UQlGfbos2EDyV/YJCao8Wk
 55uyq9CHaxzBc1FzE4K97yjdNoEMpKYRf9k2/KVj32czHYoZXmJeQ97hiqrssKIj4k5a
 LpX9LobbgVRLLtu+Y7zfgFrXPLCb6snUx/ZaGTOAviZYBDyEO4UnnveEeKul6BVnYlky
 Xq4KeVcsNhVqyKZGAT9iS31zqF/Je8jt7x3a4c1QWJIy2ZnFk2RiAezxHlQh07MziPYb
 2b3cgeWZiUrs0X5xQ8hCFlqy4AjsloeIGnOBNGCB5gtpeuPiT4QVUE7r+bcSdFLFQ+qn
 NlTg==
X-Gm-Message-State: AOJu0YzGqYmz1TeThm+Os/TgqRBy9MVmkzw5+tMc+Cln2borIBwwKIil
 uZNHdonfF3u17jqYrR6c8d8qrC3UaevDw1fGUFrxK/9H
X-Google-Smtp-Source: AGHT+IGSONNn+iAZr36mhJ+mP8eqQJ0OQmbUF2rouCsToobi+kR5A1DSmlh0doW/lTD0lDBjlFZ/e8Xmb5HZE+ZWw2I=
X-Received: by 2002:a05:6870:3c8b:b0:1f9:dc5a:b8fc with SMTP id
 gl11-20020a0568703c8b00b001f9dc5ab8fcmr17381435oab.56.1701112292037; Mon, 27
 Nov 2023 11:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-2-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-2-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 14:11:20 -0500
Message-ID: <CADnq5_MyXm+G3n=n9o8NJiHR9BtFZkN9+FSS1r3MkUvaPnzh7g@mail.gmail.com>
Subject: Re: [PATCH 01/24] drm/amdkfd/kfd_ioctl: add pc sampling support
To: James Zhu <James.Zhu@amd.com>
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com, joseph.greathouse@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 3, 2023 at 9:22=E2=80=AFAM James Zhu <James.Zhu@amd.com> wrote:
>
> From: David Yat Sin <david.yatsin@amd.com>
>
> Add pc sampling support in kfd_ioctl.
>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>

For any new IOCTL interfaces, please provide a link to the user mode
code branch which uses it in the patch description.

Thanks,

Alex

> ---
>  include/uapi/linux/kfd_ioctl.h | 57 +++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index f0ed68974c54..5202e29c9560 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1446,6 +1446,58 @@ struct kfd_ioctl_dbg_trap_args {
>         };
>  };
>
> +/**
> + * kfd_ioctl_pc_sample_op - PC Sampling ioctl operations
> + *
> + * @KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES: Query device PC Sampling capabi=
lities
> + * @KFD_IOCTL_PCS_OP_CREATE:             Register this process with a pe=
r-device PC sampler instance
> + * @KFD_IOCTL_PCS_OP_DESTROY:            Unregister from a previously re=
gistered PC sampler instance
> + * @KFD_IOCTL_PCS_OP_START:              Process begins taking samples f=
rom a previously registered PC sampler instance
> + * @KFD_IOCTL_PCS_OP_STOP:               Process stops taking samples fr=
om a previously registered PC sampler instance
> + */
> +enum kfd_ioctl_pc_sample_op {
> +       KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES,
> +       KFD_IOCTL_PCS_OP_CREATE,
> +       KFD_IOCTL_PCS_OP_DESTROY,
> +       KFD_IOCTL_PCS_OP_START,
> +       KFD_IOCTL_PCS_OP_STOP,
> +};
> +
> +/* Values have to be a power of 2*/
> +#define KFD_IOCTL_PCS_FLAG_POWER_OF_2 0x00000001
> +
> +enum kfd_ioctl_pc_sample_method {
> +       KFD_IOCTL_PCS_METHOD_HOSTTRAP =3D 1,
> +       KFD_IOCTL_PCS_METHOD_STOCHASTIC,
> +};
> +
> +enum kfd_ioctl_pc_sample_type {
> +       KFD_IOCTL_PCS_TYPE_TIME_US,
> +       KFD_IOCTL_PCS_TYPE_CLOCK_CYCLES,
> +       KFD_IOCTL_PCS_TYPE_INSTRUCTIONS
> +};
> +
> +struct kfd_pc_sample_info {
> +       __u64 value;         /* [IN] if PCS_TYPE_INTERVAL_US: sample inte=
rval in us
> +                             * if PCS_TYPE_CLOCK_CYCLES: sample interval=
 in graphics core clk cycles
> +                             * if PCS_TYPE_INSTRUCTIONS: sample interval=
 in instructions issued by
> +                             * graphics compute units
> +                             */
> +       __u64 value_min;     /* [OUT] */
> +       __u64 value_max;     /* [OUT] */
> +       __u64 flags;         /* [OUT] indicate potential restrictions e.g=
 FLAG_POWER_OF_2 */
> +       __u32 method;        /* [IN/OUT] kfd_ioctl_pc_sample_method */
> +       __u32 type;          /* [IN/OUT] kfd_ioctl_pc_sample_type */
> +};
> +
> +struct kfd_ioctl_pc_sample_args {
> +       __u64 sample_info_ptr;   /* array of kfd_pc_sample_info */
> +       __u32 num_sample_info;
> +       __u32 op;                /* kfd_ioctl_pc_sample_op */
> +       __u32 gpu_id;
> +       __u32 trace_id;
> +};
> +
>  #define AMDKFD_IOCTL_BASE 'K'
>  #define AMDKFD_IO(nr)                  _IO(AMDKFD_IOCTL_BASE, nr)
>  #define AMDKFD_IOR(nr, type)           _IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -1566,7 +1618,10 @@ struct kfd_ioctl_dbg_trap_args {
>  #define AMDKFD_IOC_DBG_TRAP                    \
>                 AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>
> +#define AMDKFD_IOC_PC_SAMPLE           \
> +               AMDKFD_IOWR(0x27, struct kfd_ioctl_pc_sample_args)
> +
>  #define AMDKFD_COMMAND_START           0x01
> -#define AMDKFD_COMMAND_END             0x27
> +#define AMDKFD_COMMAND_END             0x28
>
>  #endif
> --
> 2.25.1
>
