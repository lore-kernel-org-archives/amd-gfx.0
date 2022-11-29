Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648B3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 17:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7D110E123;
	Tue, 29 Nov 2022 17:52:49 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A0E10E123
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 17:52:46 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 p8-20020a056830130800b0066bb73cf3bcso9604177otq.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 09:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKXx/HCJK7bUt8Tm5w0jZbAv03pJDavtP/WOl/qetUI=;
 b=M2WhLkEiTpLoYzoeHt1u/eADVHCV4OrPqd32MrUWHEjSkUUt6yOJxwMuUjFV2lTGPI
 T68qLzi78H6z6OHyR/iUq1whuy1xSPAuT4MNC8FqyAa7oZ6/ThHOQwEHTNdy9DADzDgZ
 Wdc/r+av/S1ORJIaQOFNx3DjO8RJ7Oowsrqw7rqvfqLgSRGD+8p9e0LbwXCTYvrsFcnr
 bHKSrifOUVRL0ogvgfuWjrVwXFy0ETl7mOLMonMiPTy4m/a/n3EmsI2SMJ30Gq0xaT2l
 T9TDk3oUptpNkYYjRMeaQxaLz1BPOyyo0PZgLeBY0M8rPqP+AMZnj2Jjiz0e7Mj+1YN0
 AVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKXx/HCJK7bUt8Tm5w0jZbAv03pJDavtP/WOl/qetUI=;
 b=2b08MIlyvhE4uaZubnp5jxwtScrDS7ZB7PW9ZhFdZsXQH5n4XDmK2xJvAtiYm4pt/g
 cAiy56aecln+IybfvcVglysx+wjoTRBgRfKu9wgCTFQjkpV+XSUMY08JmgVytpyntagY
 w9JUkpiUEc6PR9B7tm1Eg+CpENa7r4CknBw+hBNOsHsZ85OUp83o6rc3BswrIzgVFzEe
 hD+uAhP29Hbhp6mKNRXiNs0llrwOEToWWa5lnC3Qh942VbWsk5+rg70AjMoNGE5WkSKP
 +I955PEF8xnUjX4HAA1oeWfKdi/MoH6qcoumXQ9gDwS4Zhq9UDkB02nwzIBz4QQ7DNdT
 yyYw==
X-Gm-Message-State: ANoB5pmCB15/D1eisFJpLQvvux4+V+PYBJTlQV3zl/f1EjgJxOCABDUO
 zg0hiMER12fzLsS9o+j6IhIbFXCcHYC8UV0Ii8jxpscbmTc=
X-Google-Smtp-Source: AA0mqf52F+Ezcd4DKmI0+vvauze8QlDxTdGk82BDTOnTg3OH0qWUSed6RzR4QgO4ToELKehM1/FO8y9vioW4FdQq9B4=
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id
 x11-20020a9d628b000000b0066c6afa5006mr22466418otk.233.1669744365319; Tue, 29
 Nov 2022 09:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20221123014341.263439-1-guchun.chen@amd.com>
In-Reply-To: <20221123014341.263439-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Nov 2022 12:52:33 -0500
Message-ID: <CADnq5_MKhpns=vUGYjZLG4-k+7m9E3SSKWS+Vjb3Nb7cV0z-Fw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/pm/smu11: poll BACO status after RPM BACO
 exits
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, evan.quan@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once these patches land, can we revert these changes?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c85c067c9d9d7a1b2cc2e01a236d5d0d4a872b5
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=192039f12233c9063d040266e7c98188c7c89dec

Alex

On Tue, Nov 22, 2022 at 8:44 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> After executing BACO exit, driver needs to poll the status
> to ensure FW has completed BACO exit sequence to prevent
> timing issue.
>
> v2: use usleep_range to replace msleep to fix checkpatch.pl warnings
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index ad5f6a15a1d7..ad66d57aa102 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -79,6 +79,17 @@ MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
>  #define mmTHM_BACO_CNTL_ARCT                   0xA7
>  #define mmTHM_BACO_CNTL_ARCT_BASE_IDX          0
>
> +static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t data, loop = 0;
> +
> +       do {
> +               usleep_range(1000, 1100);
> +               data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
> +       } while ((data & 0x100) && (++loop < 100));
> +}
> +
>  int smu_v11_0_init_microcode(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev = smu->adev;
> @@ -1689,7 +1700,18 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
>
>  int smu_v11_0_baco_exit(struct smu_context *smu)
>  {
> -       return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> +       int ret;
> +
> +       ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> +       if (!ret) {
> +               /*
> +                * Poll BACO exit status to ensure FW has completed
> +                * BACO exit process to avoid timing issues.
> +                */
> +               smu_v11_0_poll_baco_exit(smu);
> +       }
> +
> +       return ret;
>  }
>
>  int smu_v11_0_mode1_reset(struct smu_context *smu)
> --
> 2.25.1
>
