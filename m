Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD63C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF54061209
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF54061209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0236EB5B;
	Tue, 18 May 2021 12:55:51 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF1B6EB5B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 12:55:50 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id c196so1471744oib.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MDCbq3ZgID1QHaDmcMv82n0gZNVQMt0TspFtW2LC48g=;
 b=g6jP3KhxixJB3GIi5ZPSGJvpt9k618bh93ef+ymkRv4hXsGRy7JDC3YGgsNlfbXHI/
 upPBFW7k/CAbM6mt+ZIHhoegjOcs2bnkDAN/k/ynkt9O6PkRMAWcwsRWANZ9YVnBhMy+
 Sxi6fK/nANmr3FlEN7gRa4PG9DjQs+BzNudVp9XU+KNn8zHxm7O6npqmfEpxJVqeX1vw
 Os452R+lLIJjPzSS9TANnd21HjmWQrjEkpAVdykzoNdYobRbF9uVyEjQt7Zgxt9ArNjF
 /1czq6f4/gIDeoheQ4ToZArTQt4VMRJdBtz51PkZS515Oa5sfFTlgGDZ3y0kHcRJb1bk
 OYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MDCbq3ZgID1QHaDmcMv82n0gZNVQMt0TspFtW2LC48g=;
 b=GOxsh3d6lsWmV68dj0Vc+G6sIIvvIWpwrqmR2RK753VeQ/tYKlQqZ20/OsunsiuTUz
 CDNwiZEdNxMFyf1LGFHk9PDOFTdLan65U5Al3YkXvcKz1/5y5tlmHs+qIxAbLaZanCaw
 iMHdjYBWBE/YT2ecT3WCemiwK307cJx8gZXIKip6tNLNGG+pom2odYQX1B8RHtoqOJzh
 QmT1Bzi7pFDu/C2jdHP0Ry/tmZPZw52/ImkKm4Zn1ZtZj8K6vGhGua1GHwWYH7OzynbN
 YlyObbqy4StBvZnE+ySyN9GsmIPCoEyjrSku9DMvJuPZ10RzCwtix3mPs0fV7E2TUDII
 SAnA==
X-Gm-Message-State: AOAM5337++XG5wpFiJTFi42lmdlqbZV77Szh0zf1qpm4szTOWEsS+c1E
 WLFqoLCqz3Ev5wTvWqyjHJuEUhI+Af4o1jrjuoQ=
X-Google-Smtp-Source: ABdhPJysf9/MP9WFS1Rt9N3j780+/QDkpewEEW051Xo7OppCOWCHEYRLFJC3+v+l9VaMGh1AmQ1ZRd1VcUVcLnKtQ7g=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr3797814oie.120.1621342549511; 
 Tue, 18 May 2021 05:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210518062603.1357891-1-aaron.liu@amd.com>
 <CO6PR12MB5473443F7F5A09DC716E4478A22C9@CO6PR12MB5473.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB5473443F7F5A09DC716E4478A22C9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 May 2021 08:55:38 -0400
Message-ID: <CADnq5_M517Z0X=X5zTDnAhOn9TxxNFvdjvWxzrvt9k5JkRrq3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: modify system reference clock source for navi+
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WIth Kevin's comments addressed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 18, 2021 at 5:36 AM Wang, Kevin(Yang) <Kevin1.Wang@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aaron Liu <aaron.liu@amd.com>
> Sent: Tuesday, May 18, 2021 2:26 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: modify system reference clock source for navi+
>
> Starting from Navi+, the rlc reference clock is used for system clock
> from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
> vbios smu_info table as system clock.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 8c417014ca89..83ca58426139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
>                  ret = 0;
>          }
>
> +       /* if asic is Navi+, the rlc reference clock is used for system clock
> +        * from vbios gfx_info table */
> +       if (adev->asic_type >= CHIP_NAVI10) {
> +               index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +                                                  gfx_info);
> +               if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
> +                                         &frev, &crev, &data_offset)) {
> +                       struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
> +                               (mode_info->atom_context->bios + data_offset);
> +                       if ((frev >= 2) && (crev >= 2))
> [kevin]:
> There is a hidden danger here. We can't assume that the higher version (frev) is compatible with old one.
> the code should change to if (frev == 2) && (crev >= 2)) {} ...
>
> +                               spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
> +                       ret = 0;
> +               }
> +       }
> +
>          return ret;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C28bc3524cc2b430f8ee108d919c6494d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569161701557512%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kD9yMGIWNpeCZc87I%2B4UufLoAssTGQc73DRjOx4ipXM%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
