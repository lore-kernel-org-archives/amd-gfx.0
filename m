Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CCFC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 21:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C4E22464
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 21:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+r8Dw2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C4E22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AD26E8B0;
	Mon, 16 Dec 2019 21:49:10 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8136E6E8B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 21:49:09 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z7so9046675wrl.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 13:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xgu944lO9kG9fLsmGSqjIcSB+w1gNM5siBdIth94dtI=;
 b=c+r8Dw2Z/UEEuG8xvapqqr95PdIAM056z31OTrz6bWZXM28pQpnB2BwfYZxhVbnYCh
 CTl8+5y6SbEMS1Y7qdbgt0fRzoxssh2/LrzNYjfXBMHE1YltFYe0Q8NX720JZtLWgMS2
 x3WzZE1RREWUF2ahHHwRhh8WBm54LhvK5YW9ZgOJgIUYXak7I+hTQt34JyTJg9ZNhH8T
 Q/t0BGTvd+L//UIom3I3oak7AuB/LmbCuhqptrGMdjspz/lmJja19e/uNXIDL5yKpuDS
 x1pgQBln0FDvW24kNqNizzJ5RiIoCvOmGMpD/XlaRKhVaRFuh0Uh+ADJ1Iz7/+QO0iBT
 wyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xgu944lO9kG9fLsmGSqjIcSB+w1gNM5siBdIth94dtI=;
 b=YGN/x8MD8KU6qMgCr4oDt8gq6BzXshcDPZt8P+55rJTFGrBwRZp6koGKmcH4IjOS1D
 bfrZ6WNQ5Bk07pEjZ7TFUNOPk1+128nclI0UzguZhk2uCKn70FQeDZib7glz+1oAZjCB
 UUGTiHmJ8VwUvf1ZqhxolSK2yxHsRWky3tqbvZ7rIUTeKX1uhz2H+xoEK28mwF2PNtO3
 aJ3mwH3MxMxEK+ug8PpgxZKSivc/anQCFqph3NuLngWSsDmLLSTk59K1s+jg0Oua2q1r
 z3AYmlotGraqXJMp4BFH5jEKaIHhEzQQICALzzPyeK4ax15I2Jevt6FAAMtPC3fE479D
 8v8w==
X-Gm-Message-State: APjAAAVaQXOoieqOZrwefPA4e2qyxz941lCUd2izoaw0uoyCcdPcGtWA
 trAMQ2SuHyIkpkHJPg5fdQYL2YMbRm5o3X9KvCE=
X-Google-Smtp-Source: APXvYqzQOKJvLe02Watqz4meok53IkDw+wAYllkaFv4hjLZJvt8Za6k1Tud7G59V43wsnuvJW5cJD6fu1+1xBHeCS8w=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr32416175wrs.11.1576532948251; 
 Mon, 16 Dec 2019 13:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20191216212952.34442-1-nirmoy.das@amd.com>
In-Reply-To: <20191216212952.34442-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2019 16:48:56 -0500
Message-ID: <CADnq5_MU=HFytyBY9i+FLL3oLMnoF=zvL3NwkAKSBo5CMHQn8g@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: add missing break statement
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, kenny.ho@amd.com,
 nirmoy.das@amd.com, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 16, 2019 at 4:29 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> Fixes: 8c066a8c7a9ac9a66 (amd/amdgpu: add sched array to IPs with multiple run-queues)
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5fe60465524..63f6365312d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -160,6 +160,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>                 case AMDGPU_HW_IP_VCN_ENC:
>                         scheds = adev->vcn.vcn_enc_sched;
>                         num_scheds =  adev->vcn.num_vcn_enc_sched;
> +                       break;
>                 case AMDGPU_HW_IP_VCN_JPEG:
>                         scheds = adev->jpeg.jpeg_sched;
>                         num_scheds =  adev->jpeg.num_jpeg_sched;
> --
> 2.24.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
