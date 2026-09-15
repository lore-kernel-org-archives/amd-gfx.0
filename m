Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C474C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 14:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2742410E75E;
	Tue, 15 Sep 2026 14:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+T/9clt";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A362910E813
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:14:15 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97cb5c91d5fso92840241.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481654; cv=none;
 d=google.com; s=arc-20260327;
 b=iWWrC328I+0owMSyf2/L4FScfH6qfuhI+v/R5mSrVnuSeg81byy+hhNgLpxGmcVTPa
 262rpbpYjcRGSjOgsiHhKYCme5NysoBdaB1aB5k+fKrmaWVeSI/D12i4pKa07sK489WB
 F3KFXMC/u3yXej1FhnpLFSGyucFH27gPs6aUmOmsaog9LikVcwFqY/+lEeUp9FWibbDM
 4T+SrwKGS08u/TgSCvhSYdU+wI29F06sM+ybtJk5gRduLIo9jYXw7QTJXoXBXJaMLweW
 3ZtYV/0sEielObj2VXd7/HPdgQf9KbkUlcnEhv2ic7VPUOwhb4AK2hvQuSBquYIurdnr
 8dNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 fh=aCb9eB8bA52ZeXoSTaT5wLNSDvLiizm102iZ/xZA1Jw=;
 b=OeUZ9gJJAEBm6HL9pf9YtUv29dJBUab5gTX5CpxF8VHA5p74+FQyxC0y/tyfJ4bbwG
 bjnFm4Aeu980lb/AosgzOdViywZLmIbPTMvsIw5WAUhBPuhB8AKOwFyhYo0T1xmetFPa
 CowDAPyx55nUxEfIkc427Jtoc3M70fjX7E+ROZc3FUP6UNnKv05dIGXLCW/kT0Marj/B
 DrEXIkaujwDAADaQSSRH2HUcbRvF58gTWn5mK5XJMId4hmIJ/7G3FyGv+OrKBtpgRrgg
 lZClHZFaGz+JH7pVphGAJhljcKM72pNBSJZs1Zx46kICFlM1va5tQ/hrZ+5CeBSSsf0w
 aSOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789481654; x=1790086454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 b=m+T/9cltNFEby0DGH7HrhSNnhCSGKWYy0CvDe93fwJ+/Q4EE5DRSXwXGUZfIu7FK6C
 I4oET58y6z18quenAvHbwx5f5TYgV1LwjiaGVEhxK/iGQJJPxuwCHrqe/1Nq+f5e9WX4
 VPjAV3Jr8F2SREihYo/hRW18j5bCvdj5Mlmq7xCgXjki9cFj8Z1bJW0w7vxjWOou77h9
 VGMeTR+Hj/B5rs/GLuAXAM8Omt4CmwHmLNWRTENRKXyUnwpH0MnTNxdNc9Mcl2CdUkNg
 KKZiZokn0pCNEvt/JljA21TPg22mkdZBFVSK9z3IZD9Rhfn5Ao+xY5gotiSJVBZsU8rG
 /tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789481654; x=1790086454;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 b=cCO73syCEfn5w3PAchN0t8b53H8jnr+7JFUylapC/HoNOlTIO58e0mXxHuF+kPc5xM
 8B5G2uN2ysYH3K3fmbERkQGAOH87HNBN+GdR0ulFBAQ8RpgLKEm2ktl5saaOTUUnmCvo
 UZCAi1bRasru19LdGDAHOtsshPz7tA5ut2nddO0YISL1tWpGl+GO9/ZAI3I85LInvWka
 yLKBDyq2M1Am2AgEM14ito6ww1K5LQBeRqfpJfUeUwQh+6H3ANPKfpMw0dv5vS+UaUl4
 KqvM8Rv0XaqEDKXrLd3Bgqe6sirn3eIFlsShP4kfYrwPScPfklI5wXyg+Wp8vHLq0w8y
 JwFw==
X-Gm-Message-State: AFuF++mveVlPCJGE7DmW4+oQjY18rfqd3nfMNHfhTu1zoRu7b5xxIJ8a
 1+O7z5QctgHAUenEuVaB20B9mmMol+Og9qUe9PwUdT29GBR3JPKPEKef7gnCus7q3U5d6qSOpSR
 FEo1qZUTmU2irD8am/DMs8fBb8QmSJJw=
X-Gm-Gg: AYBFou0Npl9Qa922c4VSE2z/3UeuomglhKhhi2SoRI6s6ef/oxt/GkiJTE9oG4xkN5u
 vIkqtmfoUG16WUqIsmY3lSPEZ6/QEr6btUGnDs4nX7dbhndMIfojcyX3ACO7owd4Wmy06oIyqbE
 4cE/RW/UBnP4zjZZchUdBRuZvkQK2Jwx/AnBnU/Vk43EepMcesfOcAqGmiYN0ZdX4v68K47fxd0
 fMfRdzDMSvsnAaSdv5urVdc3FhGbWsi5Rw5XMylnSGxp5mT9S7qoouqAfWKyGp88fjj8pWtrqFj
 HTEAD5wsm6jpiKiFUCob7dTQjLf0tk4OMVsV2hTRv69vdNEdrYKXYUdGlgLbuTcXNA59YrR7T4E
 AKcgJbLBRs+0pNarEmFz89j3oLMn+P08eSWQsL3qawQ==
X-Received: by 2002:a05:6102:54aa:b0:795:41a8:ff58 with SMTP id
 ada2fe7eead31-79b53156063mr2222470137.0.1789481654462; Tue, 15 Sep 2026
 07:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260915005421.20570-1-emmaonana18@gmail.com>
In-Reply-To: <20260915005421.20570-1-emmaonana18@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 10:14:01 -0400
X-Gm-Features: AcwNN1XCYqnubKV6DPknJ8VP8xcUX59hQZqAGMsqaqTYwSEti10uZRVGJHGdrc8
Message-ID: <CADnq5_Orei9+6ZjCC2jTt8jrPM+w6jx5i1WoLxZWj9treOdzXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings for
 amdgpu_display_manager
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, 
 bhawanpreet.lakha@amd.com, Wayne.Lin@amd.com, ivan.lipski@amd.com, 
 matthew.schwartz@linux.dev, Jerry.Zuo@amd.com, chiahsuan.chung@amd.com, 
 chen-yu.chen@amd.com, skhan@linuxfoundation.org, me@brighamcampbell.com
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

Alex

On Tue, Sep 15, 2026 at 3:41=E2=80=AFAM Omokefe Emmanuel Onanaroghene
<emmaonana18@gmail.com> wrote:
>
> scripts/kernel-doc reports missing and excess member descriptions
> for struct amdgpu_display_manager:
>
>   struct member 'power_module' not described
>   struct member 'hdmi_frl_status_polling_wq' not described
>   struct member 'hdmi_frl_status_polling_delay_ms' not described
>   struct member 'boot_time_crc_info' not described
>   Excess struct member 'dm_boot_time_crc_info' description
>
> Add @power_module to the main struct doc, document
> hdmi_frl_status_polling_wq/work/delay_ms with separate inline
> comments, and rename @dm_boot_time_crc_info to @boot_time_crc_info
> to match the actual member name.
>
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 3524931451c8..61756c089fcc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
>   * @backlight_link: Link on which to control backlight
>   * @backlight_caps: Capabilities of the backlight device
>   * @freesync_module: Module handling freesync calculations
> + * @power_module: Module handling power calculations
>   * @hdcp_workqueue: AMDGPU content protection queue
>   * @fw_dmcu: Reference to DMCU firmware
>   * @dmcu_fw_version: Version of the DMCU firmware
> @@ -716,16 +717,26 @@ struct amdgpu_display_manager {
>                 char reply_data[0x40];  // Cannot include dmub_cmd here
>         } fused_io[8];
>         /**
> -        * @hdmi_frl_status_polling_work:
> +        * @hdmi_frl_status_polling_wq:
>          *
>          * workqueue for 200ms frl status polling
>          */
>         struct workqueue_struct *hdmi_frl_status_polling_wq;
> +       /**
> +        * @hdmi_frl_status_polling_work:
> +        *
> +        * Delayed work for 200ms HDMI FRL status polling.
> +        */
>         struct delayed_work hdmi_frl_status_polling_work;
> +       /**
> +        * @hdmi_frl_status_polling_delay_ms:
> +        *
> +        * Delay, in milliseconds, between HDMI FRL status polls.
> +        */
>         unsigned int hdmi_frl_status_polling_delay_ms;
>
>         /**
> -        * @dm_boot_time_crc_info:
> +        * @boot_time_crc_info:
>          *
>          * Buffer info for the boot time crc.
>          */
> --
> 2.43.0
>
