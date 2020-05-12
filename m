Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DDBC54E4A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 13:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA58C206CC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 13:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5N5NiiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA58C206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5C56E911;
	Tue, 12 May 2020 13:05:28 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF016E911
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 13:05:28 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m12so16754559wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ONVCYeG4BTMfzoM1U12y7LiwSnPG+E0LY4tpNFN1F/Y=;
 b=g5N5NiiQp/WV7OItwkDDem/oMRllpLdg0yc7FTj0iD4sOjdHHuTUSxV/2ouRpJM/Rh
 FkSVvVyMzj9V5qgybfz9EDRMureVuoIy7lJ2bsphYbjjMBgJN/R1UrSAh0zrRvenWTGA
 uIoRUIJi4HDFPACqhtlce//A6HcROxYt2jeYyNRpPme3azyM4jv6soLBJW7Sd9w899Y7
 WxIVcFrwBhSEd06C+qdZ14R1x0YjcLlyCzvGf4JkCiQDdx4CS50TJjTuXlfPkAxcuW73
 kOnRfsv2fiHXmnfDdluhbwonirtR4BK4GSvM6xDcEENw2xQUACPlUwN05QAS+txpafVO
 C1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ONVCYeG4BTMfzoM1U12y7LiwSnPG+E0LY4tpNFN1F/Y=;
 b=libQp0xZaUf2QRHWPJ97iQc2oFMiLYrHzZVZMT6iciCqbxqL5rE0YDBK+LSXqQ13w/
 j24BSR3M9dLvdAa7HrAj4wfsEn89HuqhIK1vNiCjtC1c9NWTmwYkdjJE6UmzDAydSEV4
 DOeIY4GSXfQpgGA/dgDfqHWakwLMCA3pThjZ0x8j58VmjKtZPQ5VxqG6j4WfaORQBgPj
 DJxbRl8Z7BPJJa+u5JXRxxhpguvpvnMo3l46XpwrmzonIOBvHo+NNzhekP49p2wsus2a
 7gIWsSGCQj7y+7y9x2meO/V6ZpKDacQkINJtx8ayL5lOuWefoWTxsBIWDsk0/WRmEHIC
 O6yA==
X-Gm-Message-State: AGi0Pua9DY3UcH+fxV5HrorWgWZp680aH9yXuV/6bH4kGa6E+/KAfoB6
 QZygi1ix8OmowPSK9yRDs/4SOeeJLI4gxj0gcxE=
X-Google-Smtp-Source: APiQypLnops6i4te8DzenboyspnAla3zYchmSPZ7RNOkmiZ4+89yfpc+l+U9E3N5RVEqWhU1xdfeASEOCOoRhe5qYEc=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr36534348wma.70.1589288726512; 
 Tue, 12 May 2020 06:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200512111305.24665-1-evan.quan@amd.com>
In-Reply-To: <20200512111305.24665-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 May 2020 09:05:15 -0400
Message-ID: <CADnq5_NXPUM8TEPD8XQ1vgEVUEV5vu2vpGAs+d6cAAzbCowyhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 12, 2020 at 7:14 AM Evan Quan <evan.quan@amd.com> wrote:
>
> There will be no further interrupt without proper ack
> for current one.
>
> Change-Id: Iad5adcaf7dd5c3a773b3d93ee0922a424dba8ac8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 80d6c296a599..beec4ae0b1d6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1535,6 +1535,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>          */
>         uint32_t ctxid = entry->src_data[0];
>         struct smu_context *smu = &adev->smu;
> +       uint32_t data;
>
>         if (client_id == SOC15_IH_CLIENTID_THM) {
>                 switch (src_id) {
> @@ -1576,6 +1577,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                 orderly_poweroff(true);
>         } else if (client_id == SOC15_IH_CLIENTID_MP1) {
>                 if (src_id == 0xfe) {
> +                       /* ACK SMUToHost interrupt */
> +                       data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
> +                       data = REG_SET_FIELD(0, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);

Did you intend to clear the register here before setting the bit or
just set the ACK bit?  With that clarified:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +                       WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
> +
>                         switch (ctxid) {
>                         case 0x3:
>                                 dev_dbg(adev->dev, "Switched to AC mode!\n");
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
