Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0115CA601F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 19:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A6210EB14;
	Fri,  9 Oct 2026 19:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROGOUxfC";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8BA10EB14
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 19:11:54 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-313bab9cfe7so1493eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 12:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791573114; cv=none;
 d=google.com; s=arc-20260327;
 b=H0ZquJDdYxOZKrvYVaOcPcZvmOVsHzsP16CLeFxN9emhcgSlkmaKdvGnL7CW5yRu5l
 vPKGRFBrjBv5xlrcsHtZxxbMGHeXPvOtBD0yudEf1Je3SjB8TrNEmat+X/TS/+tywfZi
 VKKFcb10uLsRLn5/6UYO9U5nXU+CzrgYhlw5hAFJ8cIMzWG6uCQfz8vjCEfLUXJtet2p
 SR6bwGBR3bdEFegNnL9F2bWGZqlI3/f8CJn9brwnwlXafoYIfHQgHyEBNyMVugUMM3l7
 zs/gWTG5DT88NHN0je3FLrZrxYW9fqP5qHMWPaqmMpv5DExTAkmZxIYoQbyvQ4EorIhE
 jFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p8hz+0Xts+jywKZV8MWK1hOsTu62bZ/zOQX8Q5CnEP8=;
 fh=8Oa+uAoUpvbCf3G4cxXQbcf4gCavfQje28NIBpvidIk=;
 b=pnDMoJceh2MSH9YvbkTBHfS0mtEa9fBO9L5Tk/oBW3wZqy0BtPzQvA/N6ZKRP33y1S
 ZK700ohx2LMaiC6c4mhMPdrNLX9+qttt3fzWybd/gsnFnausEexLbn3MPxl2/XOCwA/B
 Bb4al1j7rV/bWS8gNILWS/ZH+e9M7RoUIm3A1XqvdxWlZJnIVSpDzii+tr/3v9tWsT8U
 gqNFQp3ZW9xuD8zi9OPPQzGalBCQ1uicsYWkV5GXg9QpoeDWUfeX5yyZyoiGKzE9j6Sk
 mQoA2Aky8DIMctqruGSnJxv1g9I8KKDAjvjSI/gU+xzF7VP0is47PnWaP858RnnhWXC9
 byVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791573114; x=1792177914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p8hz+0Xts+jywKZV8MWK1hOsTu62bZ/zOQX8Q5CnEP8=;
 b=ROGOUxfCOwgxbfjLY7i//hdwHNdWApgBgRJzdiqcVcR6s018umwIUdVmA6/6xQ+K4W
 OmU85t0S1RgsIM28JN2xhn15VhX3/6TecjiZd+QN7HWcDakjtJ4O7MP9v/Z0eotY/fLp
 iXl6trjvdlyIItn49OeZJC2LyP/YeV4Fim+Z/r592D8vZdmMO3UvE9K6JxrksQUiP9ie
 u2jJWaeiXYJ1f/jWMZwPBEKwXIivTn5srPlKrKtKMznQ3Fk235FDAryw9F4mBHCg495F
 zm1WQhpHJkU2Yj7oIkAfmfDi5oq9+XfuPW8+3vpS07ddpxrAdyHrLQigQBCsZal0nnZ6
 lTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573114; x=1792177914;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p8hz+0Xts+jywKZV8MWK1hOsTu62bZ/zOQX8Q5CnEP8=;
 b=OCy9GSa5WGS13Nl6eFuV3y8MQOPu9Qxep57CL4Kby2QQ1MlajyUO85nEcBU17RDQhQ
 YPjFGjZSrH8wYbjQSixJNfw7zSA3vb0al7SIqgz9WwEmUcbFoy90CDiNx3BNyq2LxPPN
 wX2TAMo94QQz/EI7ZuFF0+aW88qy+ORIueCncx7DzUP3WfTfyf5s3wCmRtVKCUR3QqPU
 oSH614UzzUpXAAUg8OosEDRrZiuPLnkgRH52tG24V/sB5TM3OmUVREX70aXkoML8NbPi
 +lx7ANS6EMK615mBKO7Lg3A4Sl6uH4uRKLDnkAVxqIQx/S1kvPMQacWY3w8Xg0J1wdTD
 KgCg==
X-Gm-Message-State: AFuF++m1caEiw6H3ydscZGtMW8silE0uklfB+XLGG33qAbvwEW+r0Xhj
 AxSdW7OSjA+T+YoU2DSnUkEz6CYpesHA5XpGaNZ5UYMgLUgmdmn/FtKk9QA1VGjkcAjZn+mwq/U
 Sg/QTAau9U2b5sJ8Bae9bJalYURUOtiI=
X-Gm-Gg: AYBFou0wvWefi3Ks/a1DHIS43e5JfD4jEJI7mbb9nANPSvl7bCV96NaNjE24CkbwYuf
 qFWQvI79xEG5F8tlsuhvAQYPyHriRiDHhbJFfQrv2wTyUmyZ+RsbZ1MX0AN1p5s2sb5Tvk1anhW
 lyMkHLkrOnsrz76PYdsgsULtZUyXRzYQ2L61VXT2xtQvopyn+nZww+VCsmnjNhsgpLqZEsSKSh9
 CpcKwDmqDTjJNMDXjg8JSs8hG9u123vv9fst1aPSoQSQLao40BFSW6XeeG4l8DuPEuWpRYi3XrS
 D1KbTBb2GHNueBojAZs5ievvE4bRUCiZbBdsFXC3jc8RmyHxKV1IoKjkfnEsXPSysUlWvZMS6Sb
 HD6xxm6pMtyX7yL75qyGOIdbiLgHgLYGsi2PW3O9VsQ==
X-Received: by 2002:a05:7022:170a:b0:143:8212:a43 with SMTP id
 a92af1059eb24-16a5b97d796mr4940089c88.1.1791573113728; Fri, 09 Oct 2026
 12:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261009090822.4095122-1-Jesse.Zhang@amd.com>
 <20261009090822.4095122-3-Jesse.Zhang@amd.com>
In-Reply-To: <20261009090822.4095122-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Oct 2026 15:11:41 -0400
X-Gm-Features: AclHuK8WOJ_AUxR5gNNknMZYeeYIo3kGmqdp8ZE7bK4DZ7r1w4O-9fTOGyb2wH4
Message-ID: <CADnq5_PrqMG1BPiQinwuD3SJwf69ZEPQQykth2DzTT4HHOY1Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: free the userptr ranges when a CS fails
 after parser_bos
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, prike.liang@amd.com,
 sukhatri@amd.com
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Oct 9, 2026 at 5:08=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> amdgpu_cs_parser_bos() allocates an HMM range for every userptr entry of
> the BO list and looks up the user pages. Those ranges are only freed when
> amdgpu_cs_parser_bos() itself fails or when amdgpu_cs_submit() checks
> them under the notifier lock. If amdgpu_cs_patch_jobs(),
> amdgpu_cs_vm_handling(), amdgpu_cs_sync_rings() or the early part of
> amdgpu_cs_submit() fails, nothing frees them: neither
> amdgpu_cs_parser_fini() nor amdgpu_bo_list_free() touch e->range.
>
> Each such CS then leaks the range, its hmm_pfns array (8 bytes per page
> of the userptr BO) and the BO reference the range holds. An IB on a ring
> that patches the CS in place (e.g. VCN) with an unmapped va_start fails
> in amdgpu_cs_patch_ibs() and takes this path.
>
> Free the ranges on those error paths. Ranges amdgpu_cs_submit() already
> dropped are NULL, so freeing them again is a no-op.
>
> Fixes: fec8fdb54e8f ("drm/amdgpu: fix userptr HMM range handling v2")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index d059e0c92866..d3c1b4b9472f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1435,6 +1435,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_=
parser *parser)
>  int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file =
*filp)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       struct amdgpu_bo_list_entry *e;
>         struct amdgpu_cs_parser parser;
>         int r;
>
> @@ -1475,25 +1476,31 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>
>         r =3D amdgpu_cs_patch_jobs(&parser);
>         if (r)
> -               goto error_fini;
> +               goto error_free_user_pages;
>
>         r =3D amdgpu_cs_vm_handling(&parser);
>         if (r)
> -               goto error_fini;
> +               goto error_free_user_pages;
>
>         r =3D amdgpu_cs_sync_rings(&parser);
>         if (r)
> -               goto error_fini;
> +               goto error_free_user_pages;
>
>         trace_amdgpu_cs_ibs(&parser);
>
>         r =3D amdgpu_cs_submit(&parser, data);
>         if (r)
> -               goto error_fini;
> +               goto error_free_user_pages;
>
>         amdgpu_cs_parser_fini(&parser);
>         return 0;
>
> +error_free_user_pages:
> +       /* amdgpu_cs_submit() only drops the ranges once it got that far.=
 */
> +       amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
> +               amdgpu_hmm_range_free(e->range);
> +               e->range =3D NULL;
> +       }
>  error_fini:
>         amdgpu_cs_parser_fini(&parser);
>         return r;
> --
> 2.50.1
>
