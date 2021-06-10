Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B65FC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B12613E9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 21:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B12613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77D86EDFA;
	Thu, 10 Jun 2021 21:12:53 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0F06EDFA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 21:12:53 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id r16so3270184oiw.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0+PIB31kxvenhkL7rOa5ItZ1+a5IAtlH43glc6bowuY=;
 b=JLig4+IRT4dhhJzL/1oZMcXNvrgwpQsU0AxLTdSfY11OGJI/3khakYhtIiSUPN8Jat
 ngyzao/loRrws6nalZK2fG+/btjSu16uar9jUA9B+TUDKr93PZDHdQig4PAFDA76Y1el
 DcR1dfOwjrDIiBd06W9ioicZT8HWdHZAYqaATnrEPf/8F18xaOF/bDR5vEE6tDHTt1mD
 c/RVtWqWLEA5EBtyNLkCsgfTC1lVqtw0JTMv32P0mMWN+PTR5+FrkQd1CzWC4FmZCI4H
 wBNMrLyqTdLd5tMZzo5lapknmkOji57uPHQOLKrNnL7Y2iXUQwLSFtCWsBBBwbXnY8K4
 xu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0+PIB31kxvenhkL7rOa5ItZ1+a5IAtlH43glc6bowuY=;
 b=U+7F6ojdizutKphE8YyqeT8FEiiupE9+DvPTQ+6380qAdOPXedmKW1mZj36XNOThaS
 CIZm55mULexJCSiMyBrg5+4LQwoVcpbur4gqBvmhKPJkWSM9n9DsySPrVAR6OwPu5fHV
 j08qs4mK1t6cAqegPcsxq+/3KYef+6pjT7I3iOJPw0UL/cRSIpe1nXobaf0Bq+qYopj+
 XhmFqTBC6nD4PPLFF688Du9RPizYCnF33mh4OircIRJ/YdBdAQSae1yBeeO17SedNVjN
 xywXHNiZbrCblVIEiF2kCkugRbqCIK997V3QljrteYlyGwcgRNy1GXhFsCZ40tEl39Wa
 Hn2A==
X-Gm-Message-State: AOAM531q0m7iG9f0OUf6eGWCeiWfW4HCCG1emZUbWkK0hocK3bqizzLi
 MDjutBPOM+N60FLhf1SOHCE64+znxveFNaTlecjnuo9ZujE=
X-Google-Smtp-Source: ABdhPJxfTQjeoj1U5ReJ1V4u2zkAVGlt0OpB6U5eol3Ao4SnSpOO+74cnqj9jOMcOdPJDdFWrrUyJkkViOiH4IGvMkU=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr274955oic.123.1623359572582; 
 Thu, 10 Jun 2021 14:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-35-luben.tuikov@amd.com>
In-Reply-To: <20210608213954.5517-35-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Jun 2021 17:12:41 -0400
Message-ID: <CADnq5_NQCfuhMQd=y1mptL+B3NfGssY=74hWwsJa2Tm3U3hHqQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amdgpu: Fix amdgpu_ras_eeprom_init()
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> No need to account for the 2 bytes of EEPROM
> address--this is now well abstracted away by
> the fixes the the lower layers.
>
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index dc48c556398039..7d0f9e1e62dc4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -306,7 +306,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>                 return ret;
>         }
>
> -       __decode_table_header_from_buff(hdr, &buff[2]);
> +       __decode_table_header_from_buff(hdr, buff);
>
>         if (hdr->header == RAS_TABLE_HDR_VAL) {
>                 control->num_recs = (hdr->tbl_size - RAS_TABLE_HEADER_SIZE) /
> --
> 2.32.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
