Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506A1C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 22:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52EA10E0B6;
	Mon, 21 Sep 2026 22:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQIYF63d";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BFD10E0B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 22:01:43 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff2f2c4eso7203525ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790028103; cv=none;
 d=google.com; s=arc-20260327;
 b=UC1vTUjYgl8l35rU3I3bK/TBUowhkLsHfT9PugR3wqUHiIKsHQyaHa9d6nj/1KhkdI
 vZ14VFZTjznCoekTaY8VleEVcxZuCQ3h6QiYnMAdluYxwqsPy9gSdtYpgq5AicQcZ267
 1u5laGfHD1caJ4fajj0cBbOwDgDhsqdnlCia4JiQi1JVEIW2Kfqcdj83Qi77SfJ1Pw0h
 8+MCPeDNA9izJ/1KD3ApCR5cLzWXvS7xXgRPn5+p9//XN9jmED1llWjydGF2eHysTCEt
 0EmTa+0HJrttOJ0DBNc7qzA1MZtacCFB78lx3+rmCIP3LW8ScrC6/zSLb3d1XNcECFyU
 7AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 fh=0vIpwgZZO5cx782/8C0k7LcuRov6IWdRo1Vb/GdfI9M=;
 b=PUM9a+QucxQqHL08KLJZRSn/OW2TzuUgrCY0KnR6kc1/AVKKbwS7n7Iu6wOWzalJro
 cBwbgM0Tz13tjtwseRtmJc7B6n6dPxPTg8PdLtCbmWrubXivAHervGon8hL0pYwtH3eo
 NZB+xtsVzXkDjOvH93r9pBj4hI0vhYBAgwMuV/WI9NDpOQM7OckN7ZyuJKXObVbC1rrx
 GbdJmT/DU++BksdNiBRHylCWounnB2RlzHeCLjDRz4DkEA0RcOqST2TlMVyhtF4riBqm
 WKa/twTPzGQ8RGQBJlznyRnFmbIfMEE7j49OJmdSDCMXq/O3KUvSq+t03PA32nQ98XWO
 TkyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790028103; x=1790632903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 b=hQIYF63dSbEd2QPj1xyEcTl+DcqZnonuEzjl/01p1hpYHeT73CPQkRhcxzTAh+pOjC
 XL7gOlIV4u8FEsPAMxNzpWLWYLIGCm2DjLidlujtSsRZYQu8WQSAZIAIVqAYuc3e4ZGT
 2Ke2BKAx/2alzx8wxGvVquYZNlASmifvCHWG6p0N7EZ99V4DJNaoPvmH4MjfIKtcRy6c
 e9JFRKHHJhQXt/RDbUIQFDcY+QbrMug1ZAIKNSb1F7Han1V/K4AhSUiahPlCiItaLBzk
 VtwHha6xFo/BpHhZK9h+k3iGbBkdcza1aIFvFAnF41+/xRO+6kTt1VisDHnqz6Xr+YZe
 /OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790028103; x=1790632903;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1J+saQss82xL8Ce5qI/Gv+3joKI+8Uu+v3gbZJZO9EQ=;
 b=O6ZTilPdiRqVi+Pe7J6a3MieA9ZNX2RmjKkjtQ1YkcpNeTBErFQSwNoj3K1aLIpZSa
 VJigN2ouG5eAiRKXopeHHTB9IDCK/2TM+JAp9+17qk92iaa8gPwa0xrEQqS2Ei3sw+FN
 HXIUAEiJY3cQaWxUpOOQTK1+SP56AeDagG5y+Xat3x9/+sqHv1eBQUBPSsUPweT9A133
 4SI9bj6iPdTkIMIOCiETdmr7GvJ8P3DSjN6qTq6EzeknEX/lzdUVRG0ZU4C1CKeAj/0k
 KuQwKnRjs0dgy7SvQBy4P1WbM96ggCnkIgxM1wUCKexONHBwMZeqkwCPc2DltwnB8XKB
 kdfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwefsHQOf1yqKvtRaxZX2hrkHF6JxT8sCSMVU52T0/WIdw+RG+HmCpmxnjoIAMbAuRurp5WEgA/@lists.freedesktop.org
X-Gm-Message-State: AFuF++mop10VcjG8L51HZNYaF5KyGOLflPRP1iK90nxjiSewqErulhrE
 WfnTnUyuj6l30EEF1NjEWvQAnAfShrfnktuWcnVR4Wr0x9ZviEIGhQsF03KteYrYgtyTG3mGR0k
 v4svFj7JRfmdD1SAdw3p6mR3xEgu3L7o=
X-Gm-Gg: AYBFou20FoxzWBxBanDF+m33ozxKKYEONzJm2cjU1O2mX9oAiJzFUP06AxoJ46u8iEL
 f+uK7A/BtpQRmESwTvqNmtpNEiv9uuQc/WZYVL36p+VGcbCi3FU/1sPqPViln8a2ooce/6zUmkZ
 frdzqi6DHZX2i1IcQTmQVQ6ghKgXxXY4hfnZ0S4npGFGI/8O5wDCtDKpQqDXdpSzWR39/e9oTfz
 BgTkP8dKM/0ph9eCq1eqYajgPzAckq7v3iQ23HQ/NoDCWCxDL3LQoaszWSpEAKqJpzM68RgoJ24
 Y9g87Jt9olWjsQUgMrx0xh/ZFz+ZnHWk5Ng/C1TwZpSIfquO8v0IMmaWdgf1OG2458WthDRY04f
 Ht3F8PagDoXitCL5RN4sKKLmDeKlKk/uAkdyS2SA0wQ==
X-Received: by 2002:a17:90b:50cf:b0:39e:2f57:67c0 with SMTP id
 98e67ed59e1d1-39e591e3bd8mr22753640a91.0.1790028103022; Mon, 21 Sep 2026
 15:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260921103318.353216-1-lgs201920130244@gmail.com>
In-Reply-To: <20260921103318.353216-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 18:01:31 -0400
X-Gm-Features: AcwNN1WqVwSStsMay_gri4_rw5IDdLWdJymJyP5EtqkVYtYOv-9on_0dL0POVzk
Message-ID: <CADnq5_M39zRZW57prCham1JSmUEo1dZOaaannkAsTA=LeLz8Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>, Brady Norander <bradynorander@gmail.com>,
 Kees Cook <kees@kernel.org>, 
 Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Sep 21, 2026 at 6:51=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> acp_hw_init() registers ACP child devices with mfd_add_devices() before
> attaching them to the ACP power domain and initializing the hardware.
>
> If attaching a child to the power domain fails, or if the ACP reset or
> clock enable operation times out, the failure path frees only the
> source cell, resource, and platform-data allocations. The child
> platform devices already registered by mfd_add_devices() remain
> registered and are never released.
>
> Remove the children from the power domain and unregister the MFD
> devices on failures that occur after mfd_add_devices() succeeds. Keep
> mfd_add_devices() failures on the existing cleanup path since the MFD
> core already rolls back partially registered children itself.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index 9014678d75ab..be4d00ac96b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 break;
>         }
>         default:
> @@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 r =3D device_for_each_child(adev->acp.parent, &adev->acp.=
acp_genpd->gpd,
>                                           acp_genpd_add_device);
>                 if (r)
> -                       goto failure;
> +                       goto failure_remove_mfd;
>         }
>
>         /* Assert Soft reset of ACP */
> @@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                 if (--count =3D=3D 0) {
>                         dev_err(&adev->pdev->dev, "Failed to reset ACP\n"=
);
>                         r =3D -ETIMEDOUT;
> -                       goto failure;
> +                       goto failure_remove_mfd;
>                 }
>                 udelay(100);
>         }
> @@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
>         cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
>         return 0;
>
> +failure_remove_mfd:
> +       device_for_each_child(adev->acp.parent, NULL,
> +                             acp_genpd_remove_device);
> +       mfd_remove_devices(adev->acp.parent);
> +
>  failure:
>         kfree(adev->acp.i2s_pdata);
>         kfree(adev->acp.acp_res);
> --
> 2.43.0
>
