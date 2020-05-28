Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F98206F1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkRWoq5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F98206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08946E406;
	Thu, 28 May 2020 13:00:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D968E6E406
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:00:05 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j16so15356779wrb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fz2gjJ69dd6gIdvhgh0Cinb9RImhqsI2Zlc59+thTlQ=;
 b=GkRWoq5yjVOCgWzTa3TNw+kaJsqO7vk44KpQoxy/ix0rIj90TX/jjoLrPRjtXlFN7P
 +I06KUdioRubHvsuXPgdL4L5sMH8rEyPnHwDKMDsLz0ZJzjpIzLyp4mH00fNAQekOV1d
 rBs4UJHlMP/vYZk6QIn5nN7PCZ2QWgKSKSwqHirZYMJJg99JfTe0uHiqVoqRHHbok0Ec
 Ult8/oG0zkMLtcPDdpYPSWUzIK0VxY+3mj3M1mzd1YYsI9WjjoJ+ppuyhXp/qfPCsv18
 p5QWhST3iIyNs8v+/ZXbBnXhl1NN2+SFgmyOfgWHRg/Lq3Y8uwtmccjG8wFl2gE74+7o
 wsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fz2gjJ69dd6gIdvhgh0Cinb9RImhqsI2Zlc59+thTlQ=;
 b=a3aMghH+K/H40gaSwjD2/bq4QvxeGJyV9g6lLllaBxzHLihqzMBXFI5kGx1E78T0WY
 HEQQpX8eTwPs8JIInVhaJDnHM+Gp/caHWzPXBJVd2bHxuu0MW6nzhC2PzN15Fm0u6WSW
 rd4soMCE0HkAhVXxvdIgRtNXZa/wC4H734Ok+d7y6VydvXvYvunQTf03dHRHb+0Ehskw
 9Sz1rVYk34cBqcWpCLwr+p7G5Wy6oMuIeX1RuVQD2yBrZ8/Ykqe1vju3Qw6KlYi4Rnbi
 JQfC9iROPFjQpD57AIHbZVK4m+XWtTW+N+EMNGMhbWkbuK51ItFaRemEO0quU8luedZx
 p2Cw==
X-Gm-Message-State: AOAM532ZkCQJZnwz2iqg2g7n1fOSzHpS9OV6z1Bd+nwyfQ+eEL/y+CEr
 QKjWE3oVF8XDnj5XwEc8IpF3CKide3kZxClcyeyQ+Q==
X-Google-Smtp-Source: ABdhPJxfsyvmfW/Pmy9KdD8Cci6fMgBI6KV6wb4one42pdhdA8uVeCR3Uc5HEcyz8XPJ5OA7ZEzjo4p+wp+nD42yaWE=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr3628045wrp.419.1590670804075; 
 Thu, 28 May 2020 06:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200527225158.27756-1-alexander.deucher@amd.com>
In-Reply-To: <20200527225158.27756-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2020 08:59:52 -0400
Message-ID: <CADnq5_PO-SFFSpz=V3JsGPqunAs+Na9pUwy22Bj+cX3N3Sv48A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: don't bail for in_suspend
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, May 27, 2020 at 6:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Otherwise we disable sysfs/debugfs access with runtime pm.
>
> Fixes: f7c8d853b029df ("drm/amdgpu/pm: return an error during GPU reset or suspend")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 114 ++++++++++++-------------
>  1 file changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 808884aaf36d..775e389c9a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -163,7 +163,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>         enum amd_pm_state_type pm;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -199,7 +199,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>         enum amd_pm_state_type  state;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strncmp("battery", buf, strlen("battery")) == 0)
> @@ -303,7 +303,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>         enum amd_dpm_forced_level level = 0xff;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -343,7 +343,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>         enum amd_dpm_forced_level current_level = 0xff;
>         int ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strncmp("low", buf, strlen("low")) == 0) {
> @@ -445,7 +445,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>         struct pp_states_info data;
>         int i, buf_len, ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -487,7 +487,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>         enum amd_pm_state_type pm = 0;
>         int i = 0, ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -526,7 +526,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->pp_force_state_enabled)
> @@ -546,7 +546,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>         unsigned long idx;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (strlen(buf) == 1)
> @@ -604,7 +604,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>         char *table = NULL;
>         int size, ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -646,7 +646,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int ret = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -751,7 +751,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>         const char delimiter[3] = {' ', '\n', '\0'};
>         uint32_t type;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (count > 127)
> @@ -843,7 +843,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -895,7 +895,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>         uint64_t featuremask;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtou64(buf, 0, &featuremask);
> @@ -938,7 +938,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -997,7 +997,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1063,7 +1063,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1097,7 +1097,7 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1127,7 +1127,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>         uint32_t mask = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1161,7 +1161,7 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1191,7 +1191,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1227,7 +1227,7 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1257,7 +1257,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1293,7 +1293,7 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1323,7 +1323,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1359,7 +1359,7 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1389,7 +1389,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>         int ret;
>         uint32_t mask = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1425,7 +1425,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>         uint32_t value = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1453,7 +1453,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>         int ret;
>         long int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtol(buf, 0, &value);
> @@ -1494,7 +1494,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>         uint32_t value = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1522,7 +1522,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>         int ret;
>         long int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = kstrtol(buf, 0, &value);
> @@ -1583,7 +1583,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>         ssize_t size;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(ddev->dev);
> @@ -1621,7 +1621,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>         long int profile_mode = 0;
>         const char delimiter[3] = {' ', '\n', '\0'};
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         tmp[0] = *(buf);
> @@ -1683,7 +1683,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int r, value, size = sizeof(value);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(ddev->dev);
> @@ -1719,7 +1719,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
>         struct amdgpu_device *adev = ddev->dev_private;
>         int r, value, size = sizeof(value);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(ddev->dev);
> @@ -1760,7 +1760,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>         uint64_t count0 = 0, count1 = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->flags & AMD_IS_APU)
> @@ -1799,7 +1799,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (adev->unique_id)
> @@ -1996,7 +1996,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>         int channel = to_sensor_dev_attr(attr)->index;
>         int r, temp = 0, size = sizeof(temp);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (channel >= PP_TEMP_MAX)
> @@ -2130,7 +2130,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>         u32 pwm_mode = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2164,7 +2164,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>         int err, ret;
>         int value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = kstrtoint(buf, 10, &value);
> @@ -2216,7 +2216,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>         u32 value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2268,7 +2268,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>         int err;
>         u32 speed = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2301,7 +2301,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>         int err;
>         u32 speed = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2333,7 +2333,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>         u32 size = sizeof(min_rpm);
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2361,7 +2361,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>         u32 size = sizeof(max_rpm);
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2388,7 +2388,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>         int err;
>         u32 rpm = 0;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2420,7 +2420,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>         u32 value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2469,7 +2469,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>         u32 pwm_mode = 0;
>         int ret;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         ret = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2504,7 +2504,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>         int value;
>         u32 pwm_mode;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         err = kstrtoint(buf, 10, &value);
> @@ -2547,7 +2547,7 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>         u32 vddgfx;
>         int r, size = sizeof(vddgfx);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2582,7 +2582,7 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>         u32 vddnb;
>         int r, size = sizeof(vddnb);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         /* only APUs have vddnb */
> @@ -2622,7 +2622,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>         int r, size = sizeof(u32);
>         unsigned uw;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2661,7 +2661,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>         ssize_t size;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2693,7 +2693,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>         ssize_t size;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2726,7 +2726,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>         int err;
>         u32 value;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         if (amdgpu_sriov_vf(adev))
> @@ -2767,7 +2767,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>         uint32_t sclk;
>         int r, size = sizeof(sclk);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -2802,7 +2802,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>         uint32_t mclk;
>         int r, size = sizeof(mclk);
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(adev->ddev->dev);
> @@ -3665,7 +3665,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
>         u32 flags = 0;
>         int r;
>
> -       if (adev->in_gpu_reset || adev->in_suspend)
> +       if (adev->in_gpu_reset)
>                 return -EPERM;
>
>         r = pm_runtime_get_sync(dev->dev);
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
