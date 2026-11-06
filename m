Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7297F606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ogmjDFln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BF710E49D;
	Fri,  6 Nov 2026 21:02:35 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB1A10E49D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 21:02:29 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4fa872538c2so82473b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 13:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793998948; cv=none;
 d=google.com; s=arc-20260327;
 b=Ehp8IbGy7mjSfraRLvWDmsgUyhDFAvqJ9SU0h8e13ssoIQDo47Jx8zTvURAHQTA/xE
 4CjrLrwMPz77UMKk0ldJF7UU86H92w6woYP+MYsIHit8I+l7aq4lgLkkiliH54l8iaH+
 +VV7cvIHPMe+e89B2VhWVHhkmAq0SG+BLgtU2igHQApkTvHUeIYn8O8nKeggYWdAUu8E
 NB5zz8SNXadsT8fnyEmCFhGUU7SUW6hX8lsHSWoQEcyPEauF/sld3src4RebUPBVHQpB
 WbzmCIk4uA/qWw+ObHXZ4L7H+iRT2TR+U1ItG8styqgbopAlBNk7TXbqpBkjRA2nR3VD
 AMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GtdQaiNwapbQmSeqAxiFvS+VzpGLuWgfSxYAFQhPQDs=;
 fh=ZxvrC6rNjWHvCh5o5yNM8zSSCYAFdK0GMEIYqGOthl0=;
 b=CmdCOI/WNxfflkW5piKWIxe6vKYF0DYUxrUDEu/eqWnCB/wszJtWYo2+sZsv57Leag
 JQ61aGUGiuNivEB3ZA3bocIRaGU329FmLuRbo8tf0e4/91SHRiaweaHTNBQLOXkVnoWr
 bNvs3vzOIHSXkh/Uhb2FlYPS2l3TZFWX+nsr7ulkOtzXJLhK9UCpGNyEFPkYcoCsg2G1
 Cmu5TxaPrPq+LSs0TrsoCdI1bAwhtuRKXGCmgJXkrzO3x1QDekMRH+hTKtWHDSqBa80q
 zLRMAVxSNL+ISkggS+y8bFfqs91GM01H+84ZIRI2BOQiy7nCRh1zHeJbfBWuj2ONVqPL
 BHXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793998948; x=1794603748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GtdQaiNwapbQmSeqAxiFvS+VzpGLuWgfSxYAFQhPQDs=;
 b=ogmjDFlnxlxHCbYF3MIySC3dQInOlnbtrjKdFXA8+w4cqx8mnciO5qFfNTeWexq6Wq
 F32bBfIC2NyI/qTmjh9hGO/QbhSXoedHDGIY5uWdX+AEX2BGWLdMK82pyxN8sOsy/tza
 3tHMEP1SegW3gxLpyDAH/dxV24Ioi4ZlCDdcTd8fdFc3nvAogHRM9DSaKBOdGJkLj9wE
 UlEj1FLsu1oHy8CvOOTH/V9TvJypT6uZBDVc6T78AKc5Rcyjru+X9OCoGLCcF/turktr
 a3hydABEoX6CW5cKcZB/6AIZLouFSCUT/9WCw1S+/0RU4+2ILHS+84lTx7VnlP/zEn4J
 /kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998948; x=1794603748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GtdQaiNwapbQmSeqAxiFvS+VzpGLuWgfSxYAFQhPQDs=;
 b=vwitk92nsRU/TaMU+3pKYwA+pg52kyOWVD1m9T3xQoINfrvyOgHqz7QSzHrKHadCRj
 d1DM8JVEuq2Bp7jx9jxd8kBZUlcCNLc38Lmelh6LHPv52iES893PuRK/EGTf870cZmt0
 OFv+bFyEPPrYyV71fsxIR5oflOGX8slF9MQ/vCeV5CGXUJcbfOd3UN9GVg1S0pYtkqzx
 IjuRbi2mWb7IA64DpgPhRcTL8VCdS417gbkW4GspDLH9luEGJncZJfbfnhT5bjLR/Z2T
 E/Ks6YYYBnLHq6GFT8ZBH5QOuE20iXpDl+tftz3Gd4YjAJpSuOPqyvSJ85VJ4PBvqbZh
 q81g==
X-Gm-Message-State: APuU4Z+aRJLKjiTX3tTm6fmcO0d/94hvrVOzyNkT5d9fPaKrc+VwIDzJ
 DkZjzHGjEYJdKr0vXnIKLZZkknERGWGidGystaLOuPDENNeOgp2Jo1aPE9fvnI7EDvEIIwk3N46
 kkKmsZblPv/rNO1m++iCjYM3XIr3CHys=
X-Gm-Gg: AYBFou2o3VwoiYDU4S+er+HgS4PRpi+fQhqSYVAacZRyVt77MHiKLN4uPCg9HO5H16W
 WNLSouRhYn5AaH9WV1zUZZTQYRGAejLlJkZbiYgcP7EmTooaxySvDGxK4H2q4pW+fPYMt4u7aYW
 HX99UvQPelk3WPjTE3fuH2HYwHyW8u5ozJWIN18m0SkHWk7ZUoaelBjSZqfELk+fBl4XglOhUP1
 xdI21KcyTS7MyfIwMziUoT+bTKqCvbj8bR4T2k+Drx685wnr3QbLFiFsZ7/6GbQc7RtIHxw2mxJ
 vp1rlJriP1IfcqqEJrjb7p+naCp7JCH0edEOcGH4KdT105ymRRDIUBTWbso4yyOigt3zmX0QuXA
 iEp3YfWU/mqWiIISw5OHPNj7xnAFq2d2dGnjHdlUKU88ddvT9gIPWmefI9xiUVLDHQDg09jrKu7
 FZMvQWJd4igINByuqlc+olx1uXduEfnsP/AHRAFHj3USK5
X-Received: by 2002:a05:6808:bd1:b0:4f4:d7:b168 with SMTP id
 5614622812f47-567e1038151mr4054525b6e.3.1793998943491; Fri, 06 Nov 2026
 13:02:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000525.3850296-1-alexander.deucher@amd.com>
In-Reply-To: <20261105000525.3850296-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Nov 2026 16:02:11 -0500
X-Gm-Features: AclHuK_UE-Uj1GToMd7fTSjTP28Ayd5EIJX9z6CKCVjxudApuB8vNIFpLBDIjP8
Message-ID: <CADnq5_OURODcuZ0JqM=Sfg+LxRDjS5jPjB=pONY_2=09X4rZcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update mem rsv table
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping?

On Wed, Nov 4, 2026 at 7:11=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> 1. enlarge table number into 8
> 2. add table id filed in table info
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/discovery.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/am=
d/include/discovery.h
> index f5629a4ad04a1..0ed270406208b 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -45,8 +45,9 @@ typedef enum {
>         VCN_INFO,
>         MALL_INFO,
>         NPS_INFO,
> +       RSV_TABLE,
>         MEM_RESERVED_INFO,
> -       TOTAL_TABLES =3D 7
> +       TOTAL_TABLES =3D 8
>  } table;
>
>  #pragma pack(1)
> --
> 2.56.0
>
