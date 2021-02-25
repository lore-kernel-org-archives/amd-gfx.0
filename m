Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8DDC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1699D64F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 21:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1699D64F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8854C6E093;
	Thu, 25 Feb 2021 21:45:05 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D686E3C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 21:34:09 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id j19so10724944lfr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z33fwCKGRLdRggSVLa36+oxEo5k56+kIObYh56DIr1o=;
 b=iVOvgwBHTElHBmSyV8PIt+/n4PL5NWhFj7/q6FN4WduvYDrIce/fCRUQYtkupW2DJ2
 WAkqWlxLpGMGuZuQzh5k/1CYCcKI/HswXTLxgiylWtVEldlvWj9jCLVmA8rlGH9/5IDc
 W0KAGWMSe9u1PUJ9XO6r5QuvrlGbRgs6HM3O/HwMXFweNW5RbmKimMXu3HcyA2xiikkY
 3jCvA6OtwNK0/kic08DPa5I6tVW7VIQzCDdLC5oqzC0bfT8Tk8cSjjPgvaM+nWkm2BuW
 +NUABQpD18/jDPEFRuwHFY8SGx35eolwPjMCHURDTydHrY1IK863vZMSZdU63aOONaRg
 TSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z33fwCKGRLdRggSVLa36+oxEo5k56+kIObYh56DIr1o=;
 b=FuI6OgSxQq5yVR+KaAzJRdRxnPgtbX5w3twBH2f4C0pfZ7K4K8xjsanK8IwddDTGzZ
 4h4dckL7EGl5VzL5w+Cwym0+KW0PgGcsGbbgHYam4KDSSICjKmKeecblHisXtaXutLaq
 VhZ+zILJWENeBmqrd9XnpaAjjnECZqACUTpF/Rv6N1fki6cv/lO+Lekh6rP2gXcZjiVn
 ER3rfwmCiJBUJVDcu++x+7NFJSydjNDanWulxh2CpGJjDKBEGly2QwE2uwz2fz/zQa9u
 Y8TaEl57FcQOUf332OYwQYg/5DkXUEJE+61kV3hxghCfqLOHkw8tBor67KiG0DWSX2TI
 MAQQ==
X-Gm-Message-State: AOAM532dlYIZ5l/ZAZvL4X20QdB/Yn/mh3d4I4NR0wUPP4SnkPyLu19N
 A5eRVkuszIrrnUEbcjVRPLlbF+gRD6vTcT52JUQ/vA==
X-Google-Smtp-Source: ABdhPJwidz3VEFA1ImAO0a1g5OYBZZNdfVwrSeMhrhMW+jPSmbGKY9IlX0eQ/dAZ/ZuXoIxIYaDlY8Fz4hPCCRSI9ZA=
X-Received: by 2002:a05:6512:12c1:: with SMTP id
 p1mr3098656lfg.374.1614288847058; 
 Thu, 25 Feb 2021 13:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20210225150119.405469-1-arnd@kernel.org>
In-Reply-To: <20210225150119.405469-1-arnd@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 25 Feb 2021 13:33:56 -0800
Message-ID: <CAKwvOdkWfQi4vPphJ9X+xQ5MdzGhrHr1mj=oFGh3Yv5TB=76_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix an uninitialized index variable
To: Arnd Bergmann <arnd@kernel.org>
X-Mailman-Approved-At: Thu, 25 Feb 2021 21:45:04 +0000
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Arnd Bergmann <arnd@arndb.de>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, David Airlie <airlied@linux.ie>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 25, 2021 at 7:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang points out that the new logic uses an always-uninitialized
> array index:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9810:38: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
>                         timing  = &edid->detailed_timings[i];
>                                                           ^
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9720:7: note: initialize the variable 'i' to silence this warning
>
> My best guess is that the index should have been returned by the
> parse_hdmi_amd_vsdb() function that walks an array here, so do that.
>
> Fixes: f9b4f20c4777 ("drm/amd/display: Add Freesync HDMI support to DM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b19b93c74bae..667c0d52dbfa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9736,7 +9736,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
>         return false;
>  }
>
> -static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> +static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>                 struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
>  {
>         uint8_t *edid_ext = NULL;
> @@ -9746,7 +9746,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>         /*----- drm_find_cea_extension() -----*/
>         /* No EDID or EDID extensions */
>         if (edid == NULL || edid->extensions == 0)
> -               return false;
> +               return -ENODEV;
>
>         /* Find CEA extension */
>         for (i = 0; i < edid->extensions; i++) {
> @@ -9756,14 +9756,15 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>         }
>
>         if (i == edid->extensions)
> -               return false;
> +               return -ENODEV;
>
>         /*----- cea_db_offsets() -----*/
>         if (edid_ext[0] != CEA_EXT)
> -               return false;
> +               return -ENODEV;
>
>         valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
> -       return valid_vsdb_found;
> +
> +       return valid_vsdb_found ? i : -ENODEV;

Thanks for the patch!

I don't think we need a local variable to store the return value from
one function call that's immediately returned, ie.

return parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info) ?
i : -ENODEV;

would suffice, but the patch is still fine as is.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  }
>
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> @@ -9781,7 +9782,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>         struct amdgpu_device *adev = drm_to_adev(dev);
>         bool freesync_capable = false;
>         struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
> -       bool hdmi_valid_vsdb_found = false;
>
>         if (!connector->state) {
>                 DRM_ERROR("%s - Connector has no state", __func__);
> @@ -9857,8 +9857,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>                         }
>                 }
>         } else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> -               hdmi_valid_vsdb_found = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> -               if (hdmi_valid_vsdb_found && vsdb_info.freesync_supported) {
> +               i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
> +               if (i >= 0 && vsdb_info.freesync_supported) {

reusing `i` here is safe, for now, but reuse of variables like this in
separate branches like this might not get noticed if the function is
amended in the future.

>                         timing  = &edid->detailed_timings[i];
>                         data    = &timing->data.other_data;
>
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
