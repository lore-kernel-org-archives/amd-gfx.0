Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E8C47080
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BD76139A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BD76139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA1E6EB58;
	Wed,  2 Jun 2021 02:15:32 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252726EB57;
 Wed,  2 Jun 2021 02:15:31 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so1177040otl.3; 
 Tue, 01 Jun 2021 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B8W7mQck0zs774kTbT+4Y+xlf8nCc+MK9JC+2lYg3zE=;
 b=qHJOGBXsNCjbuu1M9YqCpqq1RfvnCzeoKXJHOi7f50s8kzMuGq/2TH1aeim4YfVPWE
 WuGlRuf+7W5KDX9ImbTKpto3udXjuRr1brQa2rEoWKqe4fpX5Cl47XFstY+mlkgZdS4s
 bh6toS4Yhu18tWEFxLZp1RvD93zT8ur7rz/CeN7MxoX2S7GBkEGf/hANVq+9XCbFzuNI
 W8FEDkf2LU3OaVDXOVQdNIM38qWX6blvgojVE3chWCwP/Y7nHpcCzJnE5/XWbpJmuPq6
 wOF6rQUXREd+WaJAoF7YNCtzdVSTZtoMkyJDcZ4/othzCAmBg8g5HRw4SuOSUYAaNg3X
 aQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B8W7mQck0zs774kTbT+4Y+xlf8nCc+MK9JC+2lYg3zE=;
 b=G/cSCFs/A5eJgvvGr+08NumhthKHEnQpGo5daHeHmwb5iPrWsT9LxYHxW6fUJC/Xd/
 jWNagaqbVi7zZQKHjg2WTv243j5UrRUw1xlmUvCj8unk0FVyBX2RcBLTbH+KnNHLXcWD
 nR40n5uSIQ5+zYiM9yCQeQ4b7cgoGVuGr9+pdgilEVgAch8e2pGEcWINfuZ/gQsFrBWa
 K9yyQi1TImWYc74lO+Us1C/eWMhKPz+v9z6y5aYXWoWJWJroh1AW0bgho8iDXgwj/g+k
 QDbcEhUWGWfvjmlaB4xipUi8By9l0Jtt6RTGcHx8TAopJhKrHPmEnYHZ0B0sIdR5rYb6
 68bw==
X-Gm-Message-State: AOAM530VRi/fsOfZolz5HNIQWGhaffkcBLpYWc2XooYLiRSPTsKi9mU5
 rMr7AtBOoLbeodbqEpdxmyY2+cF9zQm5YYJ93h5wBP7p
X-Google-Smtp-Source: ABdhPJzYlfRlP9uhCedE+PX9MiStThS6tMzO/MIxFMIq/6cuN1r9zaxs1LVhr62SBosE9437BvCp3d9x1Sn39n1ihp4=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24935473otl.132.1622600130512; 
 Tue, 01 Jun 2021 19:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210601142055.4132163-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210601142055.4132163-1-zhengyongjun3@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 22:15:19 -0400
Message-ID: <CADnq5_PoERXyB7f08X9uxZ-jQj6jw2_PpXxj2YFGJM=Z+iBFPQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: Remove unneeded semicolon
To: Zheng Yongjun <zhengyongjun3@huawei.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Jun 1, 2021 at 10:07 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Remove unneeded semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 65b1dca4b02e..148f6c3343ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -227,7 +227,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>                         break;
>                 default:
>                         break;
> -               };
> +               }
>         }
>
>         /* Reinit NBIF block */
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
