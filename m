Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE6BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 17:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B5310E50E;
	Wed,  2 Nov 2022 17:14:43 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132A610E50E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 17:14:40 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id t26so7800925uaj.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKNiAievnj9DMNWumIM3iix7T4Ug67PW7DGsIyCoJwY=;
 b=pmIQdSdajhNEXnVuBl/8Aokx4qVQvLkZdcfIO9FfTw5GZ8HguVWgFOA8BQcaHcXUNv
 CVPfGQSikEutO/0wIYT9LMaJ6RAZ7bcKl/uVi5Dn+OOI2Mz1eSFV0uaFyP6FU3Jra3sk
 tSjbo3bmDsz1oiBdO1MdAeexNKHuBTu9Bsn3McHqLJUKHVQ+tlDk6K75EIIMA1HwkGqX
 vhJ0uNHHSbg07OoNLjpUROEzWvyZThiLs8NoNfIWiaRbOKeoYKyKTy+OYLOVXPp2xQ0j
 PQZtZp+D2MmHPica0D3m7pen/Hct4qU9KhQp7XYPW+kUtuZ5xdvnrWM7gwn+a8IGHC2Y
 LYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKNiAievnj9DMNWumIM3iix7T4Ug67PW7DGsIyCoJwY=;
 b=DucFNgfWeeE29UUwPFsdWnhvMxL1HFME9Eq5514jikktoLRwsmuAjWYm6YgLRULxuH
 ViiN5paqc13hkws+j5EzCVYNzkDgJL3PXYgSPw5cBkZAORTGwPdVtkR2E3YsGymCmJ1c
 qqZXUTnXZguVewQzXp5qN2gLj7OQlE6cxEZMbfaBLpeG1g5MkHoz6wxxIjryzEpsJEUT
 aBgnJF5T5XObV6OrE+WCAPkUinzIDQn9N9FD4Uddq9pkqbjOK3ADaryq67ccyV4FgRb3
 3dPOfPcNsLqhzpyXtXSjaUMl2d0jUr/T5AgtN/QnoYBYg2f1DmAT+kWtKkCJNP/aAwVd
 V9lQ==
X-Gm-Message-State: ACrzQf0oCgUOiJ6Uf0URXdj74j/bbhgjMPnsaFUA0SOTHXNk44hZSGYG
 MEtu1ZdKfFQb6qQBI0jdI/AdeqaZkNfOZihxvHo=
X-Google-Smtp-Source: AMsMyM53zAJhSIxtZVUMAa0/HYvTdmSJAZn1VDjvOLZm7vc0jcY8TAty/VcA+eWFLuoigwor43AprNMPHmCl9qtGti4=
X-Received: by 2002:ab0:26c6:0:b0:40d:950f:12c5 with SMTP id
 b6-20020ab026c6000000b0040d950f12c5mr9810116uap.93.1667409279102; Wed, 02 Nov
 2022 10:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221102165914.1995657-1-Perry.Yuan@amd.com>
 <20221102165914.1995657-2-Perry.Yuan@amd.com>
In-Reply-To: <20221102165914.1995657-2-Perry.Yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Nov 2022 13:14:26 -0400
Message-ID: <CADnq5_NB93v-2B4N-7L+jQzQQS+n=1+kKwuHxVZdqiv=HjkbGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/amd/display: change GPU match with IP version
 for Vangogh
To: Perry Yuan <Perry.Yuan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shimmer.Huang@amd.com, richardqi.liang@amd.com, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 2, 2022 at 1:00 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> Use ip versions (10,3,1) to match the GPU after Vangogh switched to use IP
> discovery path.
>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1efe7fa5bc58..90636b88d6bf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10202,8 +10202,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
>   */
>  bool check_seamless_boot_capability(struct amdgpu_device *adev)
>  {
> -       switch (adev->asic_type) {
> -       case CHIP_VANGOGH:
> +       switch (adev->ip_versions[GC_HWIP][0]) {
> +       case IP_VERSION(10, 3, 1):

How about:
switch (adev->ip_versions[DCE_HWIP][0]) {
case IP_VERSION(3, 0, 1):

Since this code is more relevant to the DC IP than the GC IP.  With
that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 if (!adev->mman.keep_stolen_vga_memory)
>                         return true;
>                 break;
> --
> 2.34.1
>
