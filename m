Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A091C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CA520719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CihgpQtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CA520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796E06E895;
	Thu, 26 Mar 2020 09:14:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C646A6E895
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 09:14:26 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a81so6089436wmf.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 02:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=sYW0aCr6uiKezThWhnytJJjdl6zMJ1AZf150TLzmXmo=;
 b=CihgpQtKY2ZHCN2oVrHFokuX0dSSsXDlsfSg9LmKjHUFBtmoYbTqilvgr44D1N0Acq
 wZATLDi6uZyoMDSzXh2REFhGY2DsJhnF5A1d0U7Mp6vHnjENXfx0ZRwr7DFHz8m1cju0
 JNAB2EgEn4COaxGUWahVgaW0J/G+adytUZaMf1gmRa2Ueur4b0Kh7OhVlRzrn0fTnwrX
 t1RuWFg8yRc1fc2VMDYrgCWWkOnP6JNAy7f04n5+dsKtmSARezshQIEMdx9wVz9cADWh
 mJvK1qbLC6PJL3cH4QhsRCy+TureiibEMMmZ8Fx6GdmPmUl9HGVH+HMjjwkNJ3br4dY0
 l0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=sYW0aCr6uiKezThWhnytJJjdl6zMJ1AZf150TLzmXmo=;
 b=YPBP2jCkRkI1vKbkxnt2e/49/Kpb6ob9C5PEbHs7paUdldENKo1xgrsJWfIK68sBXd
 XKdg48N3PHcxHUwrpvABJWM5MEhfSHPR9JKl1+TovSLY4+yJHyXhvRzSvCpShwFwfKAY
 hJ74BpXrCst5W0xF2jlqfcFU2TEbW08OfEoBzbuaOmj+Xf3VxQWbORs3bV14xTw72hKi
 AnF7uDV//WShFbJcuE5YrSLs8KKvAY2yJgcHyC1/vlwtAx6eNdUtBVA0F28JcwTVjTln
 CG0k7ecwF2MzK+Xd1jgOhA7EFbCgahwelgYh4aoEbN4ddyL0wPG7cA6npGBrTSN6J0sG
 2mlw==
X-Gm-Message-State: ANhLgQ2bbGad0jJ2DlszdbMXZSA+wRfChALVNEPkfVj7/oVf2jBjQNN6
 7MS3sgiLkPIobzxpIeNrKa32d5Eu
X-Google-Smtp-Source: ADFU+vt2LsFFD107T92gk8xNlMSI2IYW7+cm+CywpTOrtPNRzYBz33+GULAr02UrPdfrnQ/kkiEUSg==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr2192391wmk.189.1585214065423; 
 Thu, 26 Mar 2020 02:14:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c85sm2626366wmd.48.2020.03.26.02.14.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Mar 2020 02:14:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdgpu: Add new ring callback to insert memory
 sync
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585146580-27143-2-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c09a5c2f-21b7-7acf-9a1d-afc15032e115@gmail.com>
Date: Thu, 26 Mar 2020 10:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585146580-27143-2-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.03.20 um 15:29 schrieb Andrey Grodzovsky:
> Used to flush and invalidate various caches.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 448c76c..ef9c444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -171,6 +171,7 @@ struct amdgpu_ring_funcs {
>   	/* Try to soft recover the ring to make the fence signal */
>   	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
>   	int (*preempt_ib)(struct amdgpu_ring *ring);
> +	void (*mem_sync)(struct amdgpu_ring *ring);

Maybe stick with the naming and call this "emit_mem_sync", apart from 
that looks like it could work to me.

Christian.

>   };
>   
>   struct amdgpu_ring {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
