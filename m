Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5336C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 20:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8522A20659
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XixeV5hJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8522A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABF06F941;
	Wed,  5 Feb 2020 20:33:17 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08476F941
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 20:33:15 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id t2so4447254wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 12:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=h8w3PKy3NgpkpwLlrPWS9PryMtHQ1jZpvrTxUtkyro4=;
 b=XixeV5hJs0o/am/o6mUxL0LxJKYcMTui7tM8GJ7mbdXUWjQ81SVaySZySS9wLRS+UM
 fdjJcHowccptBN1L+1Qovx9TPhvIz0GCBxz9t9kH9GMeAYlZLWQQX/Vy71UUsKg95Kk1
 Pu8EOdUm5txcbZpRtyunhLiENAfzKt2oEf8mYf9juRUDSEsRl3T5gZEtRa+R2PDxvm5j
 DRghEMYrzYPeUs2w7q+LQQghHZRZd8lvdhtiEifYe72RDI/rLDuq3ymYLRKSXcgZNZD7
 OnHzXJMrdg43wfsQeazEQHCyq4lPgwNz7bO0RlmsjDECKZTX+VlDIO5SAmHh0Ppltch5
 BuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=h8w3PKy3NgpkpwLlrPWS9PryMtHQ1jZpvrTxUtkyro4=;
 b=V4kyqGL5E112G5en39aYhxGgYKUsZ5PyrynVNV0noR3O6PJSxeDQJI/GNBzK/vWvrS
 Zo1h1+pUPYU/RZ4b7BfKgnrIIsQld6GAomoYM9YK1zwWJwoQADgYZoJtOZ71ZW4X0hDW
 7KukHsffGuEWf4uvKYi8xCQw28VXFJ1XcbJjHFi7HWvEbfPmxp9AycWWuxKOJ+zS6sWv
 FxXNE0+8Jh5+HMr/m2Os4kALscIwc7NoBblM5qrEQhxB9mJCvZf78YKvCW2Sm6nE8X7E
 gLb5lueAVun2IbssmXy0v/YBSzS6/XcGGcAWfWiCOUQILOMve/w11K0RdFlJpMq82ZQW
 HYFQ==
X-Gm-Message-State: APjAAAUpqSuf5TYn+cbac9WvpUHLKNg6AqJev0zhgnHp2iAaM2D7X7TA
 72QXZhkNwveSiQiUKCIFZ2UbPKtAQRpuqLxyInM491+l
X-Google-Smtp-Source: APXvYqw4/SFbc9A4o3AWykibAqMSOcEgxZoxYiIlt48C712GOy0BOWvUg0O2HGKsVbwDHyYJVHDkz9spPkPzerJ+3m0=
X-Received: by 2002:adf:a50b:: with SMTP id i11mr313454wrb.362.1580934794307; 
 Wed, 05 Feb 2020 12:33:14 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR12MB33724602207E1D3B7839A4EF81020@DM6PR12MB3372.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33724602207E1D3B7839A4EF81020@DM6PR12MB3372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2020 15:33:03 -0500
Message-ID: <CADnq5_Pb904Z_=4zcVkQHBpBghV-zevorL9q_zwHgL5JP57ypw@mail.gmail.com>
Subject: Re: [Dali] Raven 2 detection Patch
To: "Tawfik, Aly" <Aly.Tawfik@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

just a couple of typos in the patch title:
drm\amdgpu: [DALI] Dali Varient Detection
It should be:
drm/amdgpu: [DALI] Dali Variant Detection
With that fixed, patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Feb 5, 2020 at 9:59 AM Tawfik, Aly <Aly.Tawfik@amd.com> wrote:
>
> Hi,
>
>
>
> Dali is a raven2 based asic that drives at a lower (6W) TDP than other raven 2 chips. Currently the fused internal id is the same on all raven 2 boards, this means that the detection process must be done through PCIE REV ID.
>
> Unfortunately PCIE REV ID is not defined inside the scope of display. I created a patch to alter the fused value for internal rev_id if the chip is detected as dali through PCIE REV ID. So that detection of the chip will be possible inside of Display core.
>
>
>
> Can you kindly provide feedback on this workaround.
>
>
>
> Best Regards,
>
> Aly Tawfik
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
