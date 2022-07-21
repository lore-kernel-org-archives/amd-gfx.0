Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A489C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 14:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95FB11A27E;
	Thu, 21 Jul 2022 14:37:19 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4874011A27E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 14:37:18 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id w12so2386097edd.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9c7nQf9wTV4yz9hKVf/YayUXQBjs4WSUF5A+YnsAG8M=;
 b=aH0ut5b/z/M2ZVSYvLaf8MEwfv3NGH4KE0YOu+SZrHH0ieSyTwfB62zz52BXKWIBOe
 jBS4sKwDf2PQ+Ykv113yJmEnq/VMWIhdGU9ZfFgr5rVa0r/j+7pFLGwZaWNDg/IFeLQg
 FrkAfbmyIYispusjX7riNmVKyxBe6mekV4dJqiTD7OCparYTbFnyn8jozXvguUYmh2rm
 mY2T8qnL47hwrY8lyDYbCJAb/pIzxzEYn8oWoyPbCZ/gYjYe1X+g3pwap33owPUZNvz3
 vnTQ7hqC0pKrthza2k7Xp2qjMK0C5DJvMax40XEhyGN1CHn8nlcWfErx9Miy09VEWa8+
 Si0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9c7nQf9wTV4yz9hKVf/YayUXQBjs4WSUF5A+YnsAG8M=;
 b=eSO1rbaF/UqmeVrlPp1tWr1ZuwxJlAtpuC8X75se+KbAbfwPFup+58pk7rJdbyce50
 zQvrzcXto4aNfzy2k4ulH66ffHghiflR8gwh5PFWGlvSkUTkIQHgKj2MvZ/8qKB60dMO
 g2xDEDZJ21lRUz6WNmeH2hh730zGF6fZsoN8TjNwK0NR7s9roJ5+c8SMVBmks5OcvpOM
 BVDZcK4V88+/vxIlITC4mETm8dnxihVL2pHPTDZCI2k+SHRHh7/1f7x5D57PIJxQYKRQ
 OlsLk50IaNdjyQWxu1a8tgdD5SlQsoPWsO21qnC+LjgWYhYOJlcgvcsI307MWoisYp94
 8nxg==
X-Gm-Message-State: AJIora/sAppZ/c0ZwDJIyPWTGgYnnVeaRWR0bsaMvmhtGSa4ZtW/bmZB
 9dSUHlIOiRWG0a00IFZLQQ83a+JDOmeVe8qs7Z16+UbRg7I=
X-Google-Smtp-Source: AGRyM1u7h60Rgz0lW14D4R+dObP6SsnpU0n+Nx+ysqrXnT0B6cxZ16L0z/lJAt69C/RSApBhKM7dUZPlm96Sgbc6KJA=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr56570012eda.75.1658414236539; Thu, 21
 Jul 2022 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Jul 2022 10:37:04 -0400
Message-ID: <CADnq5_PoE3m2qic2tqRn8pwgXBFS24u=5gRPpg90qHocqbietQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
To: Horace Chen <horace.chen@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> For further chips we will use CHIP_IP_DISCOVERY, so add this
> support for virtualization

All current and future chips will use CHIP_IP_DISCOVERY.  If we plan
to keep the register the same for all new aics, this should be fine.
If we might need to have it per asic I think you might want something
more like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9be57389301b..0bdd71f9a8fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -709,6 +709,16 @@ void amdgpu_detect_virtualization(struct
amdgpu_device *adev)
        case CHIP_ALDEBARAN:
                reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
                break;
+       case CHIP_IP_DISCOVERY:
+               switch (adev->ip_versions[GC_HWIP][0]) {
+               case IP_VERSION(11, 0, 0):
+                       reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
+                       break;
+               default:
+                       reg = 0;
+                       break;
+               }
+               break;
        default: /* other chip doesn't support SRIOV */
                reg = 0;
                break;

Alex

>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 7d7044e9de2f..ab55602ff534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -705,6 +705,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>         case CHIP_SIENNA_CICHLID:
>         case CHIP_ARCTURUS:
>         case CHIP_ALDEBARAN:
> +       case CHIP_IP_DISCOVERY:
>                 reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
>                 break;
>         default: /* other chip doesn't support SRIOV */
> @@ -748,6 +749,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>                 case CHIP_NAVI10:
>                 case CHIP_NAVI12:
>                 case CHIP_SIENNA_CICHLID:
> +               case CHIP_IP_DISCOVERY:
>                         nv_set_virt_ops(adev);
>                         /* try send GPU_INIT_DATA request to host */
>                         amdgpu_virt_request_init_data(adev);
> --
> 2.25.1
>
