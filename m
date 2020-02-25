Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BADC35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857BE20CC7
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz0ffWiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857BE20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B6F56E8FD;
	Tue, 25 Feb 2020 19:32:10 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A2C6E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 19:32:08 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y17so27349wrn.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wt8Ds4BViKrbtpaB5ZfSPTFA4iIpgRM6dU1CpUh581Y=;
 b=Tz0ffWizqP5jPYP+Zrujs84/4zEnUToX5hP8SM+Ghbj++MadCj5dRryxXhhtwWtJO+
 OGdCHnJdxdm7OkOTGx2yv+/pKDj0eA/f6SRdjFhFMvCwIX3koeezqHwcIF0G6JWn9eHA
 DnfUJlg/4F4pIueOHnh/Iek+PJyFetuGTvX1XG0dNP1uHipkfEs+BgjyM7juN41Y1q0O
 5cAzy5Yy6B9UBAfnuLauM7VT6T/jNas8rDLYcgYyps8ICJNhA+hZX+GpmQvX535lufar
 ld0H9c3oTk0ksByaH2osPivd1ZfAcrJYAJO+Qj9jLhvYl+R8lixuBjrymfFbwVIP7zyv
 /eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wt8Ds4BViKrbtpaB5ZfSPTFA4iIpgRM6dU1CpUh581Y=;
 b=Q7vgB7bOvrfYi59gF2pcEld9LANjVtu01eqB4/dAbxFQP1+IydNUe4tin0+2V+E2Fk
 urJcs+GbJUIROKi5vyWusQTd/UNWUAmzbul/CvNyEAUccy6lF9Toc9BOuRh3N8DRk8rB
 440lOCtMri+h67fdlsn4nWf2jLrfHywIGL/DtiRrLoJdw63rDU3bFmUoMolLFZQ2DLA9
 ym6afVQbAr6U/O57yxJLBg6M6XO1f6UDBUrak1vLKvY1miEzW0btPrULl0LFiYbOChgc
 4AKPAAVUCyDIRpWigRii+svcT+GLzQ/6ZVHbD5WAoxYUUIx//PMzIx8p5vh/fRlIgwoP
 XqOg==
X-Gm-Message-State: APjAAAUYL9CXe5X0vAX+b4p7zPJEiHVgmMzFy/hWP7neVN5sE/KTxFe6
 tVoX0VUwvX4xaPoTIlzZ0yH6Mox0cs67I0amfL0=
X-Google-Smtp-Source: APXvYqy1JOdNaAfFCeONiOvMrK+L0u13TyZfx0fuVfO1sOeTndUWAjlSsCb45+oEMcV2n8Fa9bZj5PXUMp8MrUErzNQ=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr709437wrw.374.1582659127622;
 Tue, 25 Feb 2020 11:32:07 -0800 (PST)
MIME-Version: 1.0
References: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
 <20200219191941.67724-3-mcoffin13@gmail.com>
In-Reply-To: <20200219191941.67724-3-mcoffin13@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 14:31:56 -0500
Message-ID: <CADnq5_O7U4R=tmg0ah+JLCWPjX7Hey_RuC6xs+ZO0nEsUsUsjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Add message sending lock
To: Matt Coffin <mcoffin13@gmail.com>
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

On Wed, Feb 19, 2020 at 2:19 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> This adds a message lock to the smu_send_smc_msg* implementations to
> protect against concurrent access to the mmu registers used to
> communicate with the SMU

Missing your signed-off-by.  Also you need to move the mutex init and
declaration into this patch.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 220bf0b10971..19bebba3e0a4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -102,11 +102,12 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
>         if (index < 0)
>                 return index;
>
> +       mutex_lock(&smu->message_lock);
>         ret = smu_v11_0_wait_for_response(smu);
>         if (ret) {
>                 pr_err("Msg issuing pre-check failed and "
>                        "SMU may be not in the right state!\n");
> -               return ret;
> +               goto out;
>         }
>
>         WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
> @@ -119,18 +120,19 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
>         if (ret) {
>                 pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
>                        smu_get_message_name(smu, msg), index, param, ret);
> -               return ret;
> +               goto out;
>         }
>         if (read_arg) {
>                 ret = smu_v11_0_read_arg(smu, read_arg);
>                 if (ret) {
>                         pr_err("failed to read message arg: %10s (%d) \tparam: 0x%08x response %#x\n",
>                                smu_get_message_name(smu, msg), index, param, ret);
> -                       return ret;
> +                       goto out;
>                 }
>         }
> -
> -       return 0;
> +out:
> +       mutex_unlock(&smu->message_lock);
> +       return ret;
>  }
>
>  int smu_v11_0_init_microcode(struct smu_context *smu)
> --
> 2.25.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
