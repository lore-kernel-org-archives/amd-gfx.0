Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318B0C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Dec 2021 14:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6826310E360;
	Sat, 11 Dec 2021 14:09:10 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F3310E360
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 14:09:09 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id n66so17040661oia.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ccn7FJBljgESV06GX9WCzd24IcS8Kk10/FBhvpQDpuQ=;
 b=VeDt+Y8z+2OXp6dhs0Z4pio9VBX0Zk44D8SIEgyYs6f4/5lMJWwQHh8Y+L9LXo6YoP
 P8ZR46ckCxd9iCsNYKhoZnl7nUF5KxGzNSr1fh5EHC2V7C99LQXnpbW2OXorqPRUwaNP
 rHdl3UG+Xs0v7K/xE/jUC4Aq+WKIjIDlVcXmBC+l87gHC0p5AzjDigzJqlX6Lg3MHY2K
 I90pGjOXER0QiUKUOflQVig8Gad18rLeI99+7khwvnQDKxb1nYTKB6wtcLm5kz0BAmuh
 M2DIVAOVHMk7CxlQ/o8S0/D4OI0e1P0r1OaiZ6f7EZN+nkScfhWIlQDSBCK+oFBDDiEL
 PfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ccn7FJBljgESV06GX9WCzd24IcS8Kk10/FBhvpQDpuQ=;
 b=6EmfA4IoZ0zCe33ToVJ68Gv/JPgOzXOMIVyHXyJtg+R1UCKd26xZ/T0eWTDHO12nzw
 ZsdT2FaHs8h0QJYUdfZeTQrLJy4lmjE1Jj5r+UCTfzSYlizznS2UEtxW9ByeUdpc08/c
 kIaWlC1DtSdUNKD4l3umFep3gd9I20JGrV52pW/ursW16I51txjYFjtvLV+j/8xGTYfY
 o4y3N+s8COkfQiL00j9rrXAk2un86Sb/SSDOzLyfe/Iqc2ze73MMl1yxo23JZoYN83+8
 vVT0CVff44eX6q03QPAdwgigFw0ApxTKVTsxRTEj+/yw1yEacQeSvr+LcomC9CYJ1fnV
 vdTg==
X-Gm-Message-State: AOAM5322BTJc208jifrCcdRfjOhKdaLgzbd8Pyd4LAqGxdOebvbyx3Oz
 mWwv+vmpzAvk/O9UqiOaKmwGwZYyuWpwZclJF54=
X-Google-Smtp-Source: ABdhPJx0waeQWLfH6VjUjNZY7ewtT/uFU380NwLZfiTfa732rolomWm463bh6KWCjXeu7c0V+8I25ZlpHnfcjCRsdTM=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr17857026oic.123.1639231748855; 
 Sat, 11 Dec 2021 06:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20211211024227.8323-1-Jerry.Zuo@amd.com>
In-Reply-To: <20211211024227.8323-1-Jerry.Zuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 11 Dec 2021 09:08:58 -0500
Message-ID: <CADnq5_M7iUUJgkKbQtusyrAYriS37mEEh17ATAth+Vb91_TCaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix Compile Error for DCE
To: Fangzhi Zuo <Jerry.Zuo@amd.com>
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
Cc: nicholas choi <nicholas.choi@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Dec 10, 2021 at 9:42 PM Fangzhi Zuo <Jerry.Zuo@amd.com> wrote:
>
> Follow-up fix for:
> drm/amd/display: Add Debugfs Entry to Force in SST Sequence
>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1779c7daaf72..dc55a736e198 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3237,8 +3237,9 @@ static int disable_hpd_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
>                          disable_hpd_set, "%llu\n");
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  /*
> - * Force sst sequence in mst capable receiver.
> + * Temporary w/a to force sst sequence in M42D DP2 mst receiver
>   * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
>   */
>  static int dp_force_sst_set(void *data, u64 val)
> @@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
>                          dp_force_sst_set, "%llu\n");
> +#endif
>
>  /*
>   * Sets the DC visual confirm debug option from the given string.
> @@ -3370,8 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>                             adev, &mst_topo_fops);
>         debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
>                             &dtn_log_fops);
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
>                                 &dp_set_mst_en_for_sst_ops);
> +#endif
>
>         debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
>                                    &visual_confirm_fops);
> --
> 2.25.1
>
