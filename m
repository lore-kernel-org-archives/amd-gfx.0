Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750BC46467
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83EE10E632;
	Thu,  5 Jan 2023 03:27:51 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1F310E632
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:27:49 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id r205so31096240oib.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 19:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wAfC/RLef/tgUix2WKDsBCfl8YLYob1vfNHXr8YVaZw=;
 b=HgnS4bopOmnJhMT6fSKng4HHQKolWn7QItW4SjBkPtRAeo6Zg8vh2I4+rojZTaUAhm
 m9y9NntXaMOqUjdcexCLpRR2GtyTTN6nA1spSqlMSgabm7c2EPBaHe2+jF37UkyLTIKr
 VrYdGoDWV4rf4+qEn/F4nW9jchM0hi8AbfusqZaN+TKzqHC4iY2H+M9UxMBtSltZcpM2
 KYTy5fq9dVSJKk+6+YklwIPQm/T8l+UwNKLFjcOKdCe6TQRPAfulltZdkiobL0esvTCR
 4HvksNBjIbAMX5XFv4yleY03Q9qaMSWY+Pmhr/B6SzgWWRrBpz3/SqKkh4CQ2dy9Is5V
 RGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAfC/RLef/tgUix2WKDsBCfl8YLYob1vfNHXr8YVaZw=;
 b=MP+6jboaXPQuiIcav4wLvC5liYYPPhdHkpazuJC3zbb5wNWfXB9UBG13Wj40jbDAzH
 vBFQ/z2s1ZFq0+HM7wEqxo+ykpsDTRWwCcySnAhAW3BlaC889yETzPpH1+yVroxNQDvj
 HwWoGMXf0zMxvrIyhFI2f7dlUP9vehZQTTDtIuAfIAQYjH58Ul84fhX44OVkN7YvTGxj
 G6GCcBojs//TAPlj9ZsQj6CkSsy1iPorOaQBGSjxt00S7T/4zVx+agl+8SHU4iJhn5bn
 ceDKedhBLQBzu+ELIOWMiK4IHwEhaoG9TuQqZY8pGzA4XLjrmbzrocQxxqX1HZrKfWr2
 hwDw==
X-Gm-Message-State: AFqh2kpjV9fxgoOp06WCjuf54DxF4ZKeHwnPpcpjL1j/XpWU68v/mDxu
 LW9ONUDSyzFzx1CZoODjgxUlZQ0Bxya2wMs/Q4Q=
X-Google-Smtp-Source: AMrXdXuUxwVLb6X73rPM/u90fg1f1RzZPB1FGl/iqo/wr+zk/4ggFnG+Wq6gb7FATgd+LSBqIBYTPxU8kKVYnUfDOnI=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr3183631oiw.96.1672889269052; Wed, 04 Jan
 2023 19:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20230105010401.2216819-1-aaron.liu@amd.com>
 <20230105010401.2216819-2-aaron.liu@amd.com>
In-Reply-To: <20230105010401.2216819-2-aaron.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jan 2023 22:27:37 -0500
Message-ID: <CADnq5_OEFtd3GFRZvseVf9J4WU3ex8DgZGN+F1jUzK=u7nvC_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd: update securedisplay_cmd to
 ta_securedisplay_cmd
To: Aaron Liu <aaron.liu@amd.com>
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
Cc: haoping.liu@amd.com, Alexander.Deucher@amd.com, shane.xiao@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These two patches should be squashed together to avoid breaking the build.

Alex

On Wed, Jan 4, 2023 at 8:04 PM Aaron Liu <aaron.liu@amd.com> wrote:
>
> This patch updates securedisplay_cmd to ta_securedisplay_cmd
> starting from amd-ta_securedisplay-v27.00.00.08.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c               | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c     | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h     | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0706afb11577..2bebda7de604 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1907,7 +1907,7 @@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_rap_stat
>  static int psp_securedisplay_initialize(struct psp_context *psp)
>  {
>         int ret;
> -       struct securedisplay_cmd *securedisplay_cmd;
> +       struct ta_securedisplay_cmd *securedisplay_cmd;
>
>         /*
>          * TODO: bypass the initialize in sriov for now
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 2c1d82fc4c34..8ed0e073656f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -77,11 +77,11 @@ void psp_securedisplay_parse_resp_status(struct psp_context *psp,
>         }
>  }
>
> -void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
> +void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct ta_securedisplay_cmd **cmd,
>         enum ta_securedisplay_command command_id)
>  {
> -       *cmd = (struct securedisplay_cmd *)psp->securedisplay_context.context.mem_context.shared_buf;
> -       memset(*cmd, 0, sizeof(struct securedisplay_cmd));
> +       *cmd = (struct ta_securedisplay_cmd *)psp->securedisplay_context.context.mem_context.shared_buf;
> +       memset(*cmd, 0, sizeof(struct ta_securedisplay_cmd));
>         (*cmd)->status = TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
>         (*cmd)->cmd_id = command_id;
>  }
> @@ -93,7 +93,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>         struct psp_context *psp = &adev->psp;
> -       struct securedisplay_cmd *securedisplay_cmd;
> +       struct ta_securedisplay_cmd *securedisplay_cmd;
>         struct drm_device *dev = adev_to_drm(adev);
>         uint32_t phy_id;
>         uint32_t op;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
> index fe98574748f4..456ad68ed4b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
> @@ -30,7 +30,7 @@
>  void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev);
>  void psp_securedisplay_parse_resp_status(struct psp_context *psp,
>                 enum ta_securedisplay_status status);
> -void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedisplay_cmd **cmd,
> +void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct ta_securedisplay_cmd **cmd,
>                 enum ta_securedisplay_command command_id);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index ad73e5855580..8841c447d0e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -103,7 +103,7 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
>  {
>         struct secure_display_context *secure_display_ctx;
>         struct psp_context *psp;
> -       struct securedisplay_cmd *securedisplay_cmd;
> +       struct ta_securedisplay_cmd *securedisplay_cmd;
>         struct drm_crtc *crtc;
>         struct dc_stream_state *stream;
>         uint8_t phy_inst;
> --
> 2.39.0
>
