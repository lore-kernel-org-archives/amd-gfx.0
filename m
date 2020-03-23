Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B91C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D025720714
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeAphfC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D025720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9902089F73;
	Mon, 23 Mar 2020 14:46:55 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EC489F73
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 14:46:54 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f3so17399207wrw.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8hvTxnB4dcs6namdD0WbLtoMyVvJeAa4pkqSNqIH8/U=;
 b=GeAphfC8Cfo4lSYyT5/L8xb85A/6cKHxDtYOkOjdZPZG7cEYwNyd48eUuEsmXY8ZSC
 C6b5ShFsogEgAYxM7aWv05OERi9X3pUm3bc7NPgXLFrVGpT9DGdsvFsYjPeGAfd8gMo6
 pHcF7wLVVUup5I6cV24g676Zeb1/yb22xMNFeOA8oIjLk9AjaePRl4J7xc8qQ2DRH5AP
 4oaqUtn860yCGh/hiVfSLfKgdZH6z2xuhyECAZTrvSo9ru0cVFb17VoSdYXO7P7cp/Gp
 tnByCTSu+ofCHBMq5+QfhXrzofmUtn0NR8Rkap8EWbZ2wbNVJAlL67Lx3xryuzh2tSph
 gPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8hvTxnB4dcs6namdD0WbLtoMyVvJeAa4pkqSNqIH8/U=;
 b=Xv4r8h2OpzLciN9KfdxgkqtWg/elL5aPuDjR6+wgN+LkkPIot7MYFtjK86/FmuGi+K
 YZr2Da3C19OXOUTfyJi7el+ididQy2QvxjVjWsUJqM/rnQXRsHT9RiW+niOd1gyDtJmE
 CZ0Ff2V0du9fOeltTPDmAyL5esiu2W1F0sHRtMfkiiC0SFWH8OyMeeCDTkwFFqG54Czi
 4Yy1IfeO7cg9tTlGYP8RiATKFdmusdpdznkAf8CRSgTXYpDEx5AbKPrS4kwSy5y127ST
 r1Tnv4EfIBqvWtLuGFHjvJ+c4G1W/lPYn0/N851Maghs6yNnpeyvA4Cmrc5T3EMk8kdv
 IcCQ==
X-Gm-Message-State: ANhLgQ1RAZdrO5HRtgvkWrwbyL+uKx/Oj6j/mB2jUEx8VTB+hDw7b52T
 yl5rcTcIBbnevc0LE7ec6IPp0sC9LtzUWL/m+7g=
X-Google-Smtp-Source: ADFU+vvthR3YAgCZdDngrDCNixYwThw/x6txXWjaKqOtyUKB59dnCGS8a6g9F4jaQ1xazwGy/mkqEou5npEejSt/LBw=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr30238415wrd.362.1584974812845; 
 Mon, 23 Mar 2020 07:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200320182727.3805-1-alexander.deucher@amd.com>
 <20200320182727.3805-8-alexander.deucher@amd.com>
 <MN2PR12MB33446A1ACAAFB466670B417AE4F00@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33446A1ACAAFB466670B417AE4F00@MN2PR12MB3344.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2020 10:46:41 -0400
Message-ID: <CADnq5_OhhLSfWD5XRkdxbTtOhhCg6a7sSt9m_ON_bocNNs9GTA@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts
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
 "mcoffin13@gmail.com" <mcoffin13@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Mar 22, 2020 at 11:54 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Thanks Alex. The series is reviewed-by: Evan Quan <evan.quan@amd.com>

Thanks Evan.  Can you verify that the client and source id are correct
for the interrupt?  I wasn't able to find them.

Alex

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Saturday, March 21, 2020 2:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; mcoffin13@gmail.com
> Subject: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts
>
> Driver needs to send the ack message when it receives the AC/DC interrupt from the SMU.
>
> TODO: verify the client and src ids.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 20174bed11ce..d19e1d0d56c0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1525,6 +1525,13 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>         return ret;
>  }
>
> +static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu) {
> +       return smu_send_smc_msg(smu,
> +                               SMU_MSG_ReenableAcDcInterrupt,
> +                               NULL);
> +}
> +
>  #define THM_11_0__SRCID__THM_DIG_THERM_L2H             0               /* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
>  #define THM_11_0__SRCID__THM_DIG_THERM_H2L             1               /* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
>
> @@ -1558,6 +1565,9 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                 break;
>
>                 }
> +       } else if (client_id == SOC15_IH_CLIENTID_MP1) {
> +               if (src_id == 0xfe)
> +                       smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
>         }
>
>         return 0;
> @@ -1597,6 +1607,12 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> +                               0xfe,
> +                               irq_src);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C659315d457244e756adc08d7ccfc6dab%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203256919711120&amp;sdata=YM6rLmsPSMvUxiSxS4b4qH72I9xojvwi5QKhVnmqk0s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
