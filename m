Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0654AC433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 00:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56832077D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 00:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahg4JNUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56832077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2E56E0E5;
	Wed, 22 Jul 2020 00:22:04 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFEC6E134;
 Wed, 22 Jul 2020 00:22:03 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z15so197650wrl.8;
 Tue, 21 Jul 2020 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76HUDfWZhaARVooyxDCIOj9blSgQTf/u/IOtCa+nrKM=;
 b=ahg4JNUuc9ssgve80L8bfxHve4YLoKjUl4MTmjtp90HfoBgeyImdvZQmyz219gfo9Y
 XUxJH4mi4QNoGbPuq5m++mRAADWt2cxeGhKq7r42DAl8rxjW7NN9REHtbySLzcUgULUJ
 x/bTInfKJIU0USxASQVLnm2C9O+sxy9m39N+XcGc9f2c2Fy1ufyn6hLqvHaUAgElRThr
 dqNCM/06SRbrr2emA+tFH0R7LeQWyfQFv5tVBnAHhfkKYioOKzR72s6PDTpvNMhiZSfa
 mcNHzgnd2RkqoCTpewkr+ZYnM3BuZJcu+FwsLHoQT0UOloxofLYrrmFoy79zWJK7mSBE
 NABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76HUDfWZhaARVooyxDCIOj9blSgQTf/u/IOtCa+nrKM=;
 b=UYne2zVFP+CfKMvveBjKZDbf5sEC2wYIUisjVrbI0RtWnTXQ17IHFhXRKkN8ju0iDG
 p4/TdGSf4rRzHxwP33yu/Z28tOtP6x1TAtoqcepJqukHvsKGKW2UiJj+BxQzF6oL3LKu
 poyh0XU4KK/pUObDHvEEoFW78tyGRtPy6H+nFPZmd1p9fQSCjNQJyuuFtcOhFzqgtteZ
 yGDWoCHzc8Dj5mdujzZ303jG0p1Xq6xUZhUFd+Sg/lg7uGbocHPim3gVAacN7h0L945o
 JweRgzaLLk5FeczzQE9st02xi5dboHFsm1kWxt78lShq9L008AZMRTdMMAv+haUx8kKX
 jagQ==
X-Gm-Message-State: AOAM5329z7AkjrvAbVfqh94S/7XXtnBVKPxgSRL3Js75VKUU5OI8/Sw+
 Zi4BmPqYy/l9Jo0EZAzy3PsULaY3QviAJ5cydU0=
X-Google-Smtp-Source: ABdhPJyheSsVZA+4yrw5Gbi+Tiwp9dcucANWSAVEzG07VRLLK/fZW79U6+ge251tQGqUmEN8pDPl482klDFefb/60Yw=
X-Received: by 2002:adf:a351:: with SMTP id d17mr3189369wrb.111.1595377321869; 
 Tue, 21 Jul 2020 17:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200626231242.15010-1-manasi.d.navare@intel.com>
In-Reply-To: <20200626231242.15010-1-manasi.d.navare@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jul 2020 20:21:50 -0400
Message-ID: <CADnq5_NEFxfsN-mJ5T8ZzYiLjVQU-kwnXyu3TszAmk5uegL4Vg@mail.gmail.com>
Subject: Re: [PATCH v4] Revert "drm/amd/display: Expose connector VRR range
 via debugfs"
To: Manasi Navare <manasi.d.navare@intel.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 AMD gfx <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 26, 2020 at 7:11 PM Manasi Navare <manasi.d.navare@intel.com> wrote:
>
> From: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
>
> v3:
> * Rebase (Manasi)
> v2:
> * Rebase (Manasi)
>
> As both VRR min and max are already part of drm_display_info,
> drm can expose this VRR range for each connector.
>
> Hence this logic should move to core DRM.
>
> This reverts commit 727962f030c23422a01e8b22d0f463815fb15ec4.
>
> Signed-off-by: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: AMD gfx <amd-gfx@lists.freedesktop.org>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Applied.  Thanks!

Alex

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 -------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1d692f4f42f3..b246354967bc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -820,24 +820,6 @@ static int output_bpc_show(struct seq_file *m, void *data)
>         return res;
>  }
>
> -/*
> - * Returns the min and max vrr vfreq through the connector's debugfs file.
> - * Example usage: cat /sys/kernel/debug/dri/0/DP-1/vrr_range
> - */
> -static int vrr_range_show(struct seq_file *m, void *data)
> -{
> -       struct drm_connector *connector = m->private;
> -       struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> -
> -       if (connector->status != connector_status_connected)
> -               return -ENODEV;
> -
> -       seq_printf(m, "Min: %u\n", (unsigned int)aconnector->min_vfreq);
> -       seq_printf(m, "Max: %u\n", (unsigned int)aconnector->max_vfreq);
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
>  /*
>   * Returns the HDCP capability of the Display (1.4 for now).
> @@ -1001,7 +983,6 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
>  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>  DEFINE_SHOW_ATTRIBUTE(output_bpc);
> -DEFINE_SHOW_ATTRIBUTE(vrr_range);
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
>  DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
>  #endif
> @@ -1058,7 +1039,6 @@ static const struct {
>                 {"link_settings", &dp_link_settings_debugfs_fops},
>                 {"phy_settings", &dp_phy_settings_debugfs_fop},
>                 {"test_pattern", &dp_phy_test_pattern_fops},
> -               {"vrr_range", &vrr_range_fops},
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
>                 {"hdcp_sink_capability", &hdcp_sink_capability_fops},
>  #endif
> --
> 2.19.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
