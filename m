Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C8FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1CE10E6FB;
	Thu, 27 Oct 2022 21:53:50 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ACB10E69E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 16:49:02 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id 3so2324185vsh.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQzQZDg/7VclYn2N4LBBnqfpEVjjK+YPwSRbVdAR+hk=;
 b=XjJUsYkv+vLHY2vFlE8shvusXVhu+YwozXRs+Y7pKec4/wbWeW9IVSS6E8BynmW4kx
 WlSc+xYqFgZCsv0BHZSWMt4mqm0baBcQjcQ8PsHRvYqx/VidEsl1JF+CWPcppnXShe9b
 RW4rz84oXvpheQVNiiiF0uGlzbXN85TQjKajIfFHd5JfNLtjVniQTjyBd3u7tHzCBrzX
 tOJfGPs8Y0BnpWV8QDsUKSB6sKqI7vGQgtdm7og4YlTwTncL4R4odktGkw0i5azX1ouA
 rlgBXDOs5LWM7UMfPdHsF4y8X/bAEj5NHlbSaudLbkvr2BnmC0ooOlXQP6T7vVL/jAuT
 9bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQzQZDg/7VclYn2N4LBBnqfpEVjjK+YPwSRbVdAR+hk=;
 b=qeoPevMe6ZNXdSsuoaAxelGR0FaX0M7CWn7utMXDaYp+yx/daU+s9bBOgKc7q+iQy4
 9UUwj9xPTLXeRA0dD2DJA7UPxPNvOx+GKRxDO0ERw6nASakqn75TmNhYagi/zfU2FLJn
 Tj9Jj3XIFS1G0UzZ1/3AwX+EMcKbING/DDqHwhI6zueOi+d+GPXAfCit15jIAgENAaHX
 DNSJhs41247+JnUooxvGI9qnFwSjKkN+AcTrHwVRx8hhNP7ESATJuyesR6LFbbyBaAzh
 cqB8hCyqhWvMVnCMzHmNpZiiLf/JSWKJ8NhAzPs0yDueZdRpTDUvh977HZVNoyilyPtG
 G5TA==
X-Gm-Message-State: ACrzQf0+FxjO11PSqjqP5vb9RKyBY6Hk9yGixos3D/5EKNbu/BmxwPO9
 HtTo3XpO/NFSilfb6Ttjx/6ikOCWNf6IYF/FyHuWLpPsDGp9LA/S
X-Google-Smtp-Source: AMsMyM5BF4HuOJoHPIwUjVOx3ENhaCCkn5M3pwFB+N1hrOfqnYQXHO/8VWT4+Qb9ZwraCN6gDx7fp/Sr0i+h3qsFiT4=
X-Received: by 2002:a67:e281:0:b0:3aa:1c54:f8a1 with SMTP id
 g1-20020a67e281000000b003aa1c54f8a1mr12298169vsf.8.1666889341216; Thu, 27 Oct
 2022 09:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
 <20221026111258.25000-2-hacc1225@gmail.com>
 <d9de68d8-1c9e-7cef-cd82-ad0a6de59817@amd.com>
 <79d354e7-f61f-1f82-819d-91f4f2141fe6@gmail.com>
 <acd46ebe-c8b6-fcbd-504e-170836945f5a@amd.com>
In-Reply-To: <acd46ebe-c8b6-fcbd-504e-170836945f5a@amd.com>
From: Ao Zhong <hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 18:48:49 +0200
Message-ID: <CAG9e_p2PTguKc0w+z=hwnY4qoCnSZFSpNd38uP6eyAsc4bVqBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amd/display: move remaining FPU code to dml
 folder
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There isn't much information on the internet for Qingyun W510 as this
is not a retail machine. But I'm happy to provide any details about
this machine.

The Qingyun W510 is powered by Huawei's server SoC Kunpeng 920, it's
SBSA compatible.
Information about Kunpeng 920 can be found here.
Link: https://en.wikichip.org/wiki/hisilicon/kunpeng/920-6426
But not all the functions provided by Kunpeng 920 can be use on
Qingyun W510, like SMMU( IOMMU on ARM ), SAS controller or Encryption
Acceleration Engine. This machine is SFF form factor, it has only two
sodimm memory slots and doesn't support ECC (some Kunpeng Desktop
motherboards support that) and 1x PCIe x4, 1x PCIe x16, 2x M.2 slot
(PCIe x4).
It also has 2 SATA 3.0 port, one for optical drive, and the other for
the HDD. This machine will be shipped with amd's RX550 or Jingjia
Micro JM7201 GPU. My machine comes with JM7201, it's a GPU
independently developed by China. Unfortunately, since there is no
open source driver, I can only use EFI framebuffer with mainline
kernel. Qingyun W510 also has a Huawei's Hi1103LPC WiFi/Bluetooth
module, and a power button with a Goodix fingerprint sensor. Since
none of them have open source drivers, I can't use them with mainline
kernel.

There are also two similar-looking machines, Qingyun W515 and Qingyun
W525, which use HiSilicon Kirin 990 SoC and HiSilicon Pangu M900 SoC,
which are based on mobile platforms.

My workstation should be a product of DVT stage, because Huawei only
allow users to use PCIe 3.0 in the release version of Qingyun W510.
Some machines may not be able to install more than 32G of memory due
to firmware.


Am Do., 27. Okt. 2022 um 17:38 Uhr schrieb Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com>:
>
> Hi Ao,
>
> Could you share a link that describe your workstation?
>
> Thanks
>
> On 10/26/22 17:17, Ao Zhong wrote:
> > Hi Rodrigo,
> >
> > Thanks for your review! This is my first time submitting a patch to the=
 kernel.
> >
> > I'm not very good at using these tools yet. =F0=9F=98=82
> >
> > Recently I got a Huawei Qingyun W510 (=E6=93=8E=E4=BA=91 W510) ARM work=
station
> >
> > from the second-hand market in China. It's SBSA and has a Kunpeng 920 (=
3211k) SoC
> >
> > with 24 Huawei-customized TSV110 cores. Since it's SFF form factor, and=
 my machine
> >
> > supports PCIe 4.0 (looks like some W510 have it disabled), I installed =
an RX 6400 on it
> >
> > as my daily drive machine. It has decent performance. I uploaded a benc=
hmark result on Geekbench.
> >
> > Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fbrowser.geekbench.com%2Fv5%2Fcpu%2F18237269&amp;data=3D05%7C01%7CRodrigo=
.Siqueira%40amd.com%7Cdaa18df14f004d2d621d08dab7977866%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C638024158436988558%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C=
&amp;sdata=3DIyq4tWJL%2FfXuKB9xAUaVTQQmJQ0GRZ2rH%2F%2BXPTT%2F2tc%3D&amp;res=
erved=3D0
> >
> > Ao
> >
> > Am 26.10.22 um 18:12 schrieb Rodrigo Siqueira:
> >>
> >>
> >> On 10/26/22 07:13, Ao Zhong wrote:
> >>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma =3D 0;
> >>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma =3D 0;
> >>> these two operations in dcn32/dcn32_resource.c still need to use FPU,
> >>> This will cause compilation to fail on ARM64 platforms because
> >>> -mgeneral-regs-only is enabled by default to disable the hardware FPU=
.
> >>> Therefore, imitate the dcn31_zero_pipe_dcc_fraction function in
> >>> dml/dcn31/dcn31_fpu.c, declare the dcn32_zero_pipe_dcc_fraction funct=
ion
> >>> in dcn32_fpu.c, and move above two operations into this function.
> >>>
> >>> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 5 +++--
> >>>    drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 ++++++++
> >>>    drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  | 3 +++
> >>>    3 files changed, 14 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/=
drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> >>> index a88dd7b3d1c1..287b7fa9bf41 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> >>> @@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
> >>>            timing =3D &pipe->stream->timing;
> >>>              pipes[pipe_cnt].pipe.src.gpuvm =3D true;
> >>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma =3D 0;
> >>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma =3D 0=
;
> >>> +        DC_FP_START();
> >>> +        dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
> >>> +        DC_FP_END();
> >>>            pipes[pipe_cnt].pipe.dest.vfront_porch =3D timing->v_front=
_porch;
> >>>            pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes =3D 25=
6; // according to spreadsheet
> >>>            pipes[pipe_cnt].pipe.src.unbounded_req_mode =3D false;
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/d=
rivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> >>> index 819de0f11012..58772fce6437 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> >>> @@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct d=
c *dc, struct clk_bw_params *bw_pa
> >>>        }
> >>>    }
> >>>    +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pip=
es,
> >>> +                  int pipe_cnt)
> >>> +{
> >>> +    dc_assert_fp_enabled();
> >>> +
> >>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma =3D 0;
> >>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma =3D 0;
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/d=
rivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> >>> index 3a3dc2ce4c73..ab010e7e840b 100644
> >>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> >>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> >>> @@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mcl=
k_switch(struct dc *dc,
> >>>      void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
> >>>    +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pip=
es,
> >>> +                  int pipe_cnt);
> >>> +
> >>>    #endif
> >>
> >> Hi Ao,
> >>
> >> First of all, thanks a lot for your patchset.
> >>
> >> For both patches:
> >>
> >> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>
> >> And I also applied them to amd-staging-drm-next.
> >>
> >> Btw, if you are using git-send-email for sending patches, I recommend =
the following options:
> >>
> >> git send-email --annotate --cover-letter --thread --no-chain-reply-to =
--to=3D"EMAILS" --cc=3D"mailing@list.com" <SHA>
> >>
> >> Always add a cover letter, it makes it easier to follow the patchset, =
and you can also describe each change in the cover letter.
> >>
> >> When you send that other patch enabling ARM64, please add as many deta=
ils as possible in the cover letter. Keep in mind that we have been working=
 for isolating those FPU codes in a way that we do not regress any of our A=
SICs, which means that every change was well-tested on multiple devices. An=
yway, maybe you can refer to this cover letter to write down the commit mes=
sage:
> >>
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
tchwork.freedesktop.org%2Fseries%2F93042%2F&amp;data=3D05%7C01%7CRodrigo.Si=
queira%40amd.com%7Cdaa18df14f004d2d621d08dab7977866%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C638024158436988558%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am=
p;sdata=3D0GMN1Uj9iuQv2ZjipDHnl29V0UvWk6IL4XwlehdPNLA%3D&amp;reserved=3D0
> >>
> >> Finally, do you have a use case for this change? I mean, ARM64 + AMD d=
GPU.
> >>
> >> Thanks again!
> >> Siqueira
> >>
