Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A72C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 18:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D59910E118;
	Tue, 25 Oct 2022 18:32:34 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E3810E118
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 18:32:31 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 v40-20020a056830092800b00661e37421c2so8332215ott.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TdAIvbjIiuqYiJ2fm/TZOlCClWbcmFYA7hj9w3pXmxQ=;
 b=eb1WinKWE+4l5djQbUW7hbPtWk5jrN8wtP6jxIwAQwNxQqmBBk16Ac1qpV7T0Y1EJK
 0H5Qmue7Dwwp8uh4Y7THwbRdz+5MTeu5ogR7/fBxzjhhD1dT55ssJ4NAc0yeH/nwq0P7
 9p/7g41UZobVIkGTkwRF7EAkg/MUgvXFKubY0lAf8b4W8w4+nGTWzIectdrYsZB7DRpq
 w4gy4cCdV1mWxMWiloJC65WWl6XpzNTGsjbRYZvHjJOCNa+NMC4SjSCkBWSl38YBXHJf
 dbx51p6osah03sMIl7cihbtFeRwfKv6CfqAg6y7UV3YTQn14KpttVkkVEJLjmhTyQkAt
 ADFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TdAIvbjIiuqYiJ2fm/TZOlCClWbcmFYA7hj9w3pXmxQ=;
 b=Sk+eyW27/M+JHsapTEek+WOLL9tSKr1VPBXZQRfgHMvegitNK0a6047oQjIM4GLIuO
 7garSC3LKhhvisqC2TL2XXL+D6psAAvkq2cUEShlyhlk939iNgrzpaltda2rNp+Azdqh
 LtWC1f94n4Xc6+mNRZNsNqyp+wyYFIOf89w7YhZxA82CYrTF6hyJQzKqyPfVKxT8nzOt
 LnhuX3fyxwtXSR2JcrntfkyCL6cv1zjpU+ezapDF8YGUZcawysncOZDgoVb2156EktUQ
 q4aeTrI6CfUY2c7K6KccXQzePVn0MFk1xkZwaI9K5esn0AH6EAPaEg+qByvdSf3h4/hZ
 cCQw==
X-Gm-Message-State: ACrzQf3oeaXmaiHEMYKB6rbNRCcq198fISJfUNOAFmwEPtj6lJnXCES/
 YtRZBXeKmgSY7VXhbYjQ4vcgftI6ZmDFQJD4nnwn3D7Q
X-Google-Smtp-Source: AMsMyM7I1nFcAdbA6B+XjnTq9Lsg0xxuW+Hp0dmAzrChxH84Ilfo5j7ImaqVw9vkEyPjB5GZ/sBG/uE63XhxDms6xvw=
X-Received: by 2002:a05:6830:2475:b0:661:b91c:f32a with SMTP id
 x53-20020a056830247500b00661b91cf32amr19948750otr.123.1666722750894; Tue, 25
 Oct 2022 11:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221025075908.185288-1-HaoPing.Liu@amd.com>
In-Reply-To: <20221025075908.185288-1-HaoPing.Liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Oct 2022 14:32:19 -0400
Message-ID: <CADnq5_Mw0Zk+kcvr+88Tv_hprqHRs0Qy5EjXh0k8vvRuUQu=Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Move the mutex_lock to protect the return
 status of securedisplay command buffer
To: Alan Liu <HaoPing.Liu@amd.com>
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
Cc: alexander.deucher@amd.com, shane.xiao@amd.com,
 amd-gfx@lists.freedesktop.org, wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 25, 2022 at 4:00 AM Alan Liu <HaoPing.Liu@amd.com> wrote:
>
> [Why]
> Before we call psp_securedisplay_invoke(), we call
> psp_prep_securedisplay_cmd_buf() to prepare and initialize the command
> buffer.
>
> However, we didn't use the mutex_lock to protect the status of command
> buffer. So when multiple threads are using the command buffer, after
> thread A return from psp_securedisplay_invoke() and the command buffer
> status is set to SUCCESS, another thread B may call
> psp_prep_securedisplay_cmd_buf() and initialize the status to FAILURE
> again, and cause Thread A to get a failure return status.
>
> [How]
> Move the mutex_lock out of psp_securedisplay_invoke() to its caller to
> cover psp_prep_securedisplay_cmd_buf() and the code checking the return
> status of command buffer.
>
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c               | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c     | 4 ++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 4 ++++
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index effa7df3ddbf..7bbf869f4f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1938,10 +1938,15 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
>         } else
>                 return ret;
>
> +       mutex_lock(&psp->securedisplay_context.mutex);
> +
>         psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                         TA_SECUREDISPLAY_COMMAND__QUERY_TA);
>
>         ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
> +
> +       mutex_unlock(&psp->securedisplay_context.mutex);
> +
>         if (ret) {
>                 psp_securedisplay_terminate(psp);
>                 /* free securedisplay shared memory */
> @@ -1990,12 +1995,8 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>             ta_cmd_id != TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
>                 return -EINVAL;
>
> -       mutex_lock(&psp->securedisplay_context.mutex);
> -
>         ret = psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.context);
>
> -       mutex_unlock(&psp->securedisplay_context.mutex);
> -
>         return ret;
>  }
>  /* SECUREDISPLAY end */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index cc7597a15fe9..2c1d82fc4c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -121,6 +121,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>
>         switch (op) {
>         case 1:
> +               mutex_lock(&psp->securedisplay_context.mutex);
>                 psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                         TA_SECUREDISPLAY_COMMAND__QUERY_TA);
>                 ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
> @@ -131,8 +132,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>                         else
>                                 psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
>                 }
> +               mutex_unlock(&psp->securedisplay_context.mutex);
>                 break;
>         case 2:
> +               mutex_lock(&psp->securedisplay_context.mutex);
>                 psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                         TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>                 securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_id;
> @@ -146,6 +149,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>                                 psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
>                         }
>                 }
> +               mutex_unlock(&psp->securedisplay_context.mutex);
>                 break;
>         default:
>                 dev_err(adev->dev, "Invalid input: %s\n", str);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index 8a441a22c46e..515352ba788e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -123,6 +123,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
>         phy_id = crc_rd_wrk->phy_inst;
>         spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
>
> +       mutex_lock(&psp->securedisplay_context.mutex);
> +
>         psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                                                 TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
>         securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id =
> @@ -133,6 +135,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
>                         psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
>                 }
>         }
> +
> +       mutex_unlock(&psp->securedisplay_context.mutex);
>  }
>
>  bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc)
> --
> 2.25.1
>
