Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099AAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 20:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D7A20776
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 20:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB2LT4yD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D7A20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3FE6E90C;
	Mon, 22 Jun 2020 20:09:21 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6846E902
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 20:09:19 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id v3so10523721wrc.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BQ7ssZDQFWtFd0te5SX/tpEuj+I6BIPtvfKcizsg7DU=;
 b=HB2LT4yDMlGAlbZBzYSBQWjHTV85kGoeA2SgIdviSnODPx5HIlaGxX//VsZh/z0B5N
 qWnJiE0u30rlEdVjEknC6JByPZBWW00i6+aReRk4snMt7TMoq9PsScdxf5Nl6neziURF
 OOaNMrsdUjRN9LZJlmICOhbtKmcNwB9ZVSgVTdUWV0duJQdoIRFgcDNh3mFU4Fsl2Csv
 UV7bEqiFSG5Zgd5yn90nLnSe7PfXkFT5fmkIGqSyDmPaCiZX/D6S7XTjWc5j1V7RbFig
 BEOTws6Vi/JZBeitIE93m8uXDXsK9+Ca6cY5og0U4A/iUmrjWthWrvH9vkf6ojZ1orw6
 pT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQ7ssZDQFWtFd0te5SX/tpEuj+I6BIPtvfKcizsg7DU=;
 b=XbNAMg+RQB6zj/8ifUTysh4F1puJMkY1mPOKomm1mYGNMxmoedMNOXBa3OmtF5+rNX
 nPFFT5Fx1QTqaEaE76DzWhyGju+EB1CjyTVVBaSe/QKNpRG09mz31Ah8rzuR1i2onu/z
 iuHOztSpLm7dUz5I9gNUm7HmjiWqyAaaenxdBGpKkIRsgDZ2sJynsG0AGIeWnSL7Is9o
 t4Ib6DLVcE18dUCep1EyycKfiQX2f5ZhnTL7q376ah0CsO0T6Xqykn3zYoJxm5QgI2Mr
 LL9u/5GzyOa9HrmAFick5uDIVNzIi+MVojZyt0TmHUDa5xYO4P0Xg3UlijKt20BDEMBn
 ar4Q==
X-Gm-Message-State: AOAM5305jgB+sKMM0vF8rfHS134mAHqo1+fL6IFt/c8bvXJYPQcEnLNb
 pKhwec8jjqLHADFRwU66qkuQ/++KMIDmET9lG3BdAg==
X-Google-Smtp-Source: ABdhPJyvg+TlId4r2BpFcd66W5J3le8YIsixHAycFtndI5oUSlz81hrk0lOM389qEOofmQjlzEOhPbPACzpazmu8r1I=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr11205472wrl.362.1592856558294; 
 Mon, 22 Jun 2020 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200622195644.35797-1-nirmoy.das@amd.com>
In-Reply-To: <20200622195644.35797-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jun 2020 16:09:06 -0400
Message-ID: <CADnq5_P2w_EUCrBvm2R8FUo9UsNJbv75jau9-4ZhqXLGtX2wiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/powerplay: fix compilation warning
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 22, 2020 at 3:55 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> If (smu)->ppt_funcs->intf is not initialized then
> smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32) and
> smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32) will not
> touch bottom32 and top32.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index b27d0b18eafa..d93f8a43a96f 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2371,7 +2371,7 @@ static void arcturus_i2c_eeprom_control_fini(struct smu_context *smu, struct i2c
>  static void arcturus_get_unique_id(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> -       uint32_t top32, bottom32, smu_version;
> +       uint32_t top32 = 0, bottom32 = 0, smu_version;
>         uint64_t id;
>
>         if (smu_get_smc_version(smu, NULL, &smu_version)) {
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
