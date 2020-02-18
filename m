Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59694C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E680208C4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcErv6Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E680208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53A66EA1D;
	Tue, 18 Feb 2020 14:35:10 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05306EA19
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:35:07 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w12so24222959wrt.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yj1DiOxTywxnNaYwwMEsq2trQGIz9WMmNdN8Z4WkPSI=;
 b=kcErv6Q7NsWj86mN5fwPpB3fgGuoPOMhrKLZ0BO4cCZ1QcM5dDezEyoF0WbaiaeJdg
 +/kx3SqACip4All3IlAxdtjjnW08xpw1Wbq8ppAhc5Zr6qeRybaj8UEWLsz67mMYfKfb
 q8uLhGp2zauFsORaY7mL1OOtSbd+3Luam9J6kjI4Lmg9H6+o7CtV7xYZOaGBPIeVQTM3
 3dnBZjiTu+JY+dhTkYzrgPx7eNYuTO/addelOTxZ2ChkQCfrvY9q7CXwtYnFxPDnGGEt
 4d3EwlIQaalN+Qx1fitSDVCgyaVkRdjtXgOAHsdvQchsNSjaWyTvp4XxUIaH6m4+qybA
 YTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yj1DiOxTywxnNaYwwMEsq2trQGIz9WMmNdN8Z4WkPSI=;
 b=C2z59+S6zfVdVDLBcyt6ApLymHDHxVaDubwvIuET2WcNTro1QvskWW+kDLNsktTiMb
 cf/nIKhX4+zSvc0JyY7VcOqM3AAODjDimkfWu0CiRWq7Ooa+KXrLByIFhi7jIMtSOR28
 8RruoLRQLT/NizKJWWH0/6Ka77Kgrq1srtea5cvHdpLw82gJLC4XSuSbyyYGxZHXoB9I
 aY/thmto8SBwfOWJ2JV6mYk7dh2A3fOTUDbqcOieSkQ82j6XTl+jHa8srj+js3v/Uihc
 uOl3e+nWL0mit3g4es4xJdjKsMJ7eoyoDKJkJq2lwf1C8AhnuI2UAcToNbTDF6POtAES
 gMnQ==
X-Gm-Message-State: APjAAAVFQa2idFUcj9z2bblLHX/nBw1emwpuUF4A5+IMBedZZSN0p+Qa
 TP4L8vWGqPFpSGQZIYcPrGKG/TYnoUOiYRwoeJw=
X-Google-Smtp-Source: APXvYqxFzWbmNwy/PUZauIXf1l5Ct7sifEX90R7xd9FHv8/H6xqNF2sjP2eonx5FSObeJ6iCjL+5DVjJdvwZxXf6aBI=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr30785554wrn.124.1582036506266; 
 Tue, 18 Feb 2020 06:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20200217213730.1413533-1-alexander.deucher@amd.com>
 <MN2PR12MB33444C333C7032B4F78BD581E4110@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33444C333C7032B4F78BD581E4110@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Feb 2020 09:34:54 -0500
Message-ID: <CADnq5_N4DorOzy4m_SaxYM4wFMp0J-exKpq85gf6ooz-D67drg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu: add an update table lock
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 17, 2020 at 10:01 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Hi Alex,
>
> Did you seen any issue caused by this?

Seems to help on:
https://gitlab.freedesktop.org/drm/amd/issues/1047
I haven't been able to prove to myself that the existing high level
locking covers every case.

Alex

>
> Regards,
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Tuesday, February 18, 2020 5:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu: add an update table lock
>
> The driver uses a staging buffer to update tables in the SMU.
> Add a lock to make sure we don't try and do this concurrently
> by accident.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 7 ++++++-
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 9f2428fd98f6..437a3e7b36b4 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -530,6 +530,7 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>
>         table_size = smu_table->tables[table_index].size;
>
> +       mutex_lock(&smu->update_table_lock);
>         if (drv2smu) {
>                 memcpy(table->cpu_addr, table_data, table_size);
>                 /*
> @@ -544,13 +545,16 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>                                           SMU_MSG_TransferTableSmu2Dram,
>                                           table_id | ((argument & 0xFFFF) << 16));
>         if (ret)
> -               return ret;
> +               goto unlock;
>
>         if (!drv2smu) {
>                 amdgpu_asic_flush_hdp(adev, NULL);
>                 memcpy(table_data, table->cpu_addr, table_size);
>         }
>
> +unlock:
> +       mutex_unlock(&smu->update_table_lock);
> +
>         return ret;
>  }
>
> @@ -900,6 +904,7 @@ static int smu_sw_init(void *handle)
>
>         mutex_init(&smu->sensor_lock);
>         mutex_init(&smu->metrics_lock);
> +       mutex_init(&smu->update_table_lock);
>
>         smu->watermarks_bitmap = 0;
>         smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 97b6714e83e6..506288072e8e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -362,6 +362,7 @@ struct smu_context
>         struct mutex                    mutex;
>         struct mutex                    sensor_lock;
>         struct mutex                    metrics_lock;
> +       struct mutex                    update_table_lock;
>         uint64_t pool_size;
>
>         struct smu_table_context        smu_table;
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cbdb09232f91649c08af408d7b3f1ab89%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175722941118202&amp;sdata=2%2FNzcPGthFtelyfXNiiIL3BV3c%2Bvoy%2F2Cq1oFWuZ4%2Bc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
