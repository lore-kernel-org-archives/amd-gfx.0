Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E5BC2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623EC206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmX6CFDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623EC206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC1A6E34B;
	Tue, 24 Dec 2019 18:08:15 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25D46E34B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 18:08:14 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g17so20385513wro.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fpst3wDa2L1vz9pXYWsp5deHWryqd5iVbmoiwHvx6N8=;
 b=FmX6CFDbGQKFUDrc3F2kfEA+xGzE3zeM/D/h0TGvqZYwuLqT15xw+Wc6f2xhdfnI4T
 Pt27kxrPUN2ANQ28EY5MP1WvsjtrkVMczQcKDycFKGFakv+P1xmhq8/zwg68BSIGtarB
 9DPxVDkiFd1ZjJGjHUelYSWzxq9RTPwN8uLjgvPECVxVI+5QxSB2X6h8HCN6O4bkeeHV
 TND9QPYRzzMa2WqH+k5DYAe3tDSUDt/D8sMEBAPgueVg9y7c9mIO2QjDSLBx3zoo7sNz
 vZ8I19YSj5hRyI+Cdfj0QdQkD9baTey6ZagRwCqAM2hhAuzZx7DAabEqNQ/gJZtXRkMG
 49Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fpst3wDa2L1vz9pXYWsp5deHWryqd5iVbmoiwHvx6N8=;
 b=BP294SzO/QM/1zCYGt5uU3w1z53O5frdpJEedGRWssRUeoFndP+jOBX+nWBXT/SxE2
 j5Okr7HNnayWY4g0kxXuufmhIMUSMDa9kHc1cjFUyPiyZTeHq/Z0D4P5sSij7A9V5EhK
 F5EElozZFokVsE+FjDXsBefCPbLnk1PyIE5s7f6TxctbYEso/eVvAIN6mNI2KukQrmEB
 W6hGi/vz1IBRQLBYHQbKLNum+ccePhQFlE9BB0a6BwbVYgo0ZtXjuPNW1sLxjD08Wg9x
 E1p2c45ZRpUK0+itccR+Rql7IDWePhp0TUiFG5hqvcdPFG1oZcXJfNIQ8WhCqs16KXrK
 HZ+Q==
X-Gm-Message-State: APjAAAUEeR55+YsP9oxZeqI0O60yKi7EobpmCWchqp1P18WjMXZ0fAe5
 FEebOglqO/fAuGxsHGSmfcLX4hr3hhAxBGk2XVawDw==
X-Google-Smtp-Source: APXvYqyIml8x1BYXKMShB2Cg5mq3bTT7xRhN9bkXaUThqNVlHe7VI17JsSrVjynFnjpNTZXefpRKISydUzuHl21ZUBU=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr35973302wrs.11.1577210893554; 
 Tue, 24 Dec 2019 10:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20191224092848.8259-1-evan.quan@amd.com>
In-Reply-To: <20191224092848.8259-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Dec 2019 13:08:01 -0500
Message-ID: <CADnq5_NjnK=YfFfTMjrqMoyLv4sjP3veQyDxLUe2u6EkBxjrRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: add check for baco support on Arcturus
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 24, 2019 at 4:29 AM Evan Quan <evan.quan@amd.com> wrote:
>
> This is used to determine whether runtime pm can be
> supported or not.
>
> Change-Id: I0b6452ae56094d768ece23ba62476f410f19e57b
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index b53d40177e93..a0615640082a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -613,6 +613,7 @@ static bool soc15_supports_baco(struct amdgpu_device *adev)
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
> +       case CHIP_ARCTURUS:
>                 soc15_asic_get_baco_capability(adev, &baco_support);
>                 break;
>         case CHIP_VEGA20:
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
