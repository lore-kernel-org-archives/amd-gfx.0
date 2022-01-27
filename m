Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE73C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 17:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4750010E1EE;
	Thu, 27 Jan 2022 17:36:23 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44EF10E1EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 17:36:21 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id q186so7239212oih.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JZpFI8l5HPh70e90rEq4gULROdmVbaPdsdK5LgCBr5E=;
 b=Y4mzcqWqjCSQl9oLTQRDVuWxDI3ccz05N5LzPC0eV2iSuMLjGQsLqLJhLEwBz4Xq0f
 Oop0f1PpbCrHTT4BHHdyPVovcOAGKDUb72/c9m8CiHMNZQn4E9/p4J3Nj69atPJpzdkX
 BbGL6tfjELHhM9EnIf9jGl+hfaZXt30TBSHhxHldQOUdO0XQrcrX8kzFjWsH0oiWvCKc
 fOxoGbRtNGscmQcDWmBma2egEwdFTf4FNjrCBXbRkOp8ohEDFENGldjh/063kRs1LRjI
 EE1G4Ure7pEwEQaSPpofHZWV5Fu8ywUnoP9QWdcyXuzXCBjnIzZ7geXimQyhzQOsKPxV
 u0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JZpFI8l5HPh70e90rEq4gULROdmVbaPdsdK5LgCBr5E=;
 b=rfySeXBuSHJYAPp4ZdXGRTiJGKF40nqrwHnIYqpO9VABKdFu9RHJekLNW8Y+FMA+1/
 ysOQb4q1PAuBoQLX90a5EBiHzM4nQbaQcSPbp32ktnBMKyFUcd50opc3ptNlVIYM9BFK
 OlaUVIF5JKbFYK8ZDFTjJekkoC/aXmwFrmhy6tipqwB63odTztH1mev9lAMSGLMEShkY
 psG572JoFbefqjoOfZ/0+w9lfzVB+jF8IZckSzHuajzJhwb65RA2/Ap6Hu39VeUPUJ6E
 Xt2PeBfrvxNKG4EG4LSn2TQlSJ2TaF65/AAnuvhKddWdbKKaCTd+90aRY52lCusnD+Ns
 egpQ==
X-Gm-Message-State: AOAM531nDXj8cTblAlToDUyWXAHONcXBob8fiSXVQ+HAln+D0nzNX6Hc
 ZBX3J4TYxVdX63Vqu+/c2Szw0nucQw7n1zQaPag=
X-Google-Smtp-Source: ABdhPJzXjC9kivhNdgqXKLMDJks/iHesfmgt1qChvejl45j8ptrGjrmSGCXtL1rUo1S3ZB1cKwwiFulggmn3klbeZpE=
X-Received: by 2002:a05:6808:2011:: with SMTP id
 q17mr7705612oiw.199.1643304980890; 
 Thu, 27 Jan 2022 09:36:20 -0800 (PST)
MIME-Version: 1.0
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
In-Reply-To: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jan 2022 12:36:09 -0500
Message-ID: <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
To: Aditya Garg <gargaditya08@live.com>
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
Cc: Aun-Ali Zaidi <admin@kodeit.net>, "roman.li@amd.com" <roman.li@amd.com>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 "evan.quan@amd.com" <evan.quan@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
 "George.Shen@amd.com" <George.Shen@amd.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "stylon.wang@amd.com" <stylon.wang@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
 "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
 "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
 "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
 "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
 "wayne.lin@amd.com" <wayne.lin@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 26, 2022 at 8:56 AM Aditya Garg <gargaditya08@live.com> wrote:
>
> From: Aun-Ali Zaidi <admin@kodeit.net>
>
> The eDP link rate reported by the DP_MAX_LINK_RATE dpcd register (0xa) is
> contradictory to the highest rate supported reported by
> EDID (0xc = LINK_RATE_RBR2). The effects of this compounded with commit
> '4a8ca46bae8a ("drm/amd/display: Default max bpc to 16 for eDP")' results
> in no display modes being found and a dark panel.
>
> For now, simply force the maximum supported link rate for the eDP attached
> 2018 15" Apple Retina panels.
>
> Additionally, we must also check the firmware revision since the device ID
> reported by the DPCD is identical to that of the more capable 16,1,
> incorrectly quirking it. We also use said firmware check to quirk the
> refreshed 15,1 models with Vega graphics as they use a slightly newer
> firmware version.
>
> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 05e216524..17939ad17 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5597,6 +5597,25 @@ static bool retrieve_link_cap(struct dc_link *link)
>                 dp_hw_fw_revision.ieee_fw_rev,
>                 sizeof(dp_hw_fw_revision.ieee_fw_rev));
>
> +       /* Quirk for Apple MBP 2018 15" Retina panels: wrong DP_MAX_LINK_RATE */
> +       {
> +               uint8_t str_mbp_2018[] = { 101, 68, 21, 103, 98, 97 };
> +               uint8_t fwrev_mbp_2018[] = { 7, 4 };
> +               uint8_t fwrev_mbp_2018_vega[] = { 8, 4 };
> +
> +               // We also check for the firmware revision as 16,1 models have an
> +               // identical device id and are incorrectly quirked otherwise.

C style comments please.  I'll let one of the display guys comment on
the rest of the patch.  Seems reasonable, we have a similar quirk for
the Apple MBP 2017 15" Retina panel later in this function.  Could you
move this next to the other quirk?

Alex


> +               if ((link->dpcd_caps.sink_dev_id == 0x0010fa) &&
> +                   !memcmp(link->dpcd_caps.sink_dev_id_str, str_mbp_2018,
> +                            sizeof(str_mbp_2018)) &&
> +                   (!memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018,
> +                            sizeof(fwrev_mbp_2018)) ||
> +                   !memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018_vega,
> +                            sizeof(fwrev_mbp_2018_vega)))) {
> +                       link->reported_link_cap.link_rate = LINK_RATE_RBR2;
> +               }
> +       }
> +
>         memset(&link->dpcd_caps.dsc_caps, '\0',
>                         sizeof(link->dpcd_caps.dsc_caps));
>         memset(&link->dpcd_caps.fec_cap, '\0', sizeof(link->dpcd_caps.fec_cap));
> --
> 2.25.1
>
>
