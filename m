Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C114C7EE22
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0E210E588;
	Thu, 11 May 2023 02:33:43 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563C710E588
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:33:41 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-54fd5aae4e7so1448501eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683772419; x=1686364419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pQAf81EzyS4XpYqyhhqkA7QaovNS9VTfmfTqVDEAuw=;
 b=Akbesd3Voq6LonNsh97LC6tgbbXG9iWrhtjMXuIrhw3YaFbvgLuWcg6KCv5gfFoWrA
 HHv5Bj7IO4gKDWtk95UYKEoAn6WruhjazJw6V10Pka8lVYQ+r84M2iBp6Gv0JyPcjQd+
 395lHFEMQ4Thf58BnlS5PjRpl/vjPUg7LFbDJF3dczhpInSlpkqeJKgXKhMQs7mjt7g/
 lgr1x7ew3eE9ESF6rIHlvQviBCSVt2sabXo3xUNMlShxzG1jwP0X34wZR5Pct167lLbH
 DB1dbpRnK4NoDCLZ2pNhwgZ+Qi4eN8v4EkS4+53nV3EZv+mAjyunoXx25f8FWA+UFsoE
 s+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683772419; x=1686364419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pQAf81EzyS4XpYqyhhqkA7QaovNS9VTfmfTqVDEAuw=;
 b=cQbXtV0wsRS17pTHTvVXyiRCX0R1oq9GKvkIT7WGo2aun8Bk7OJKq7RqWbk/xuTmMX
 0ivUP6kbCQmIZWpG75Wlt5R5d1yTeLobeKvaPcMWPfJlkHkQ1mkzU2HDVEvyAjt4SL0Z
 I28ZF7hI4qBO2shpYgBF0Pvk4kSZCTM/il3FmXrF/Fsk9JqjwgobE7nGq3Qpz0lQT1zW
 QPu4pqbF67RmDf5p5WW1T/3oTmlJacKBFf3r2JXc7jZ0H+V779zeEUhTw4akFknNaA4P
 YEjnNLbNZFGW1YC1VV5AfFeZoD3UgrmTU8LCQ1B+DNsCuMXsT9TTQZSACxjmeOjpvOPu
 mZiA==
X-Gm-Message-State: AC+VfDy4mqTCQZ29delxgW33Kcx+XVbahR6USHYyVNjgc4gbJbxjxxmR
 6l5/7G/mHLr5+HxntDtYoy+1ayhXwZgg+O5gtBY=
X-Google-Smtp-Source: ACHHUZ6sfYi1W/OyiPQMwOGxHJNmQIZ8LFuuL4v67ToKiR1D0ZJpvTT41Z14Z0cOvKskayzGzm3eIByhNIQF2fZ9Un0=
X-Received: by 2002:aca:180f:0:b0:38e:c2a4:3530 with SMTP id
 h15-20020aca180f000000b0038ec2a43530mr3620806oih.9.1683772419411; Wed, 10 May
 2023 19:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <75e5d2a6-9be4-4530-b8f8-c98d1bd96b03@kili.mountain>
In-Reply-To: <75e5d2a6-9be4-4530-b8f8-c98d1bd96b03@kili.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 May 2023 22:33:28 -0400
Message-ID: <CADnq5_O-BU5aku753wJvQ9GO5smQPS-ZheO25G3wwEL3CTEXgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: release correct lock in
 amdgpu_gfx_enable_kgq()
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Cc: Tao Zhou <tao.zhou1@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 David Airlie <airlied@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, May 9, 2023 at 10:32=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> This function was releasing the incorrect lock on the error path.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 9bfa241d1289 ("drm/amdgpu: add [en/dis]able_kgq() functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The LKP robot sent me an email about this after I had already written
> the patch.  (I review LKP Smatch emails and hit forward).
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 969f256aa003..7d2f119d9223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -644,7 +644,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev,=
 int xcc_id)
>                                                 adev->gfx.num_gfx_rings);
>                 if (r) {
>                         DRM_ERROR("Failed to lock KIQ (%d).\n", r);
> -                       spin_unlock(&adev->gfx.kiq[0].ring_lock);
> +                       spin_unlock(&kiq->ring_lock);
>                         return r;
>                 }
>
> --
> 2.39.2
>
