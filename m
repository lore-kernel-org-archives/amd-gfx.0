Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA53C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 13:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B2710E4FC;
	Wed, 19 Mar 2025 13:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LptDpZf9";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00D810E4FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 13:28:18 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff62f9b6e4so1142586a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742390898; x=1742995698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8kVuygQcuneFW+VFFQPQqEn6xF8A922wxnry1H16sQ=;
 b=LptDpZf9ABrgUhCuvuE3eRZePqMzE4qsfapjLn+I+akIdzAVITKfHOhNHvhQiAruAF
 l8WCu87DScwPDVEjFXqB+A8Ef0OANaYHd4XXY/QxcG/izggzPnD5VVn7HpVwpcxZxnH8
 x2m9g1nJN/s4YlcpdEdfUwYyaS4Q38XtgNJxcVBmR+BTB+tKHaEOHuchzu/jGkMkzjog
 hZ4DwcmlyVb85+edDHcYxw1zbyj1a4W6SPjjGLedMVcnJGbvichhAl1LlV3aWagU+Nqz
 Gar/M5pRt0MbnpJcsZ5plgVeC4hK/z3nUedF9riMHW9IieTfZDtcofPhp66nQCyVyIP2
 g35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742390898; x=1742995698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8kVuygQcuneFW+VFFQPQqEn6xF8A922wxnry1H16sQ=;
 b=I0/DMADrFFwCNXAtyB8NrHHtAVu+XgFZTC2stPIIoiwOq5e08xyAkQwufemgzRuA+8
 MESrvkeKCMY/by7adfqm1UY3Lh/izNFnITC9XSCSt3C0F0zwZWeVztV6+Aau2bDjfl3p
 AzcYxU0sF91I7KCvnZq+01eSrBGIEnUGlwDLnPa72Dr2Ja3bqUXSf/aPkms7NzcZkK/h
 Tmd72rfjzzW/h2MvcqVZKjez28g1FCCcU9Qfp/imtoWfqbbwDsA5cD2Tux5CXE1TqJKD
 XieyMjLOWD0lDlyvXTgr+serm5qEHqPCVuNXBpjoweLxKNNXowoiv3WcApjJgCQzfeFH
 Cg4A==
X-Gm-Message-State: AOJu0YwQEV6lq4fadzReEpDginIZD24d7lJII9pxFJI56gu4hrytz0Jg
 wduYJry507qXcU0j1flTx8xgZvrxv52Is0A2SkNlGUriYKO1D+UorGM+KvvemN7WdAALAlVMXKH
 7+Z1Glc5gOk1VlLP57swlrm9Q2f0=
X-Gm-Gg: ASbGnctu89A8QwqYFumjrdXyBLl45UaqaFsYM2jlgbb9tXpC/WlKcmDBemCOdX+MjVm
 j67LMOaB8NBdjtkW5uIrfKmwyE5yTNBw8+FixQQTGi5C++TlV0j/ZAWenXwa0PAUkPkDU/7FX46
 C7DnjHJRvISFMgvPTNmK4Jrd8NcQ==
X-Google-Smtp-Source: AGHT+IGbslDHsqi2jvJr5zaJuwx4+rTxN33nFGDUYlw5T3B3L9YyrrietDTz4yibISapButVlUyOcDhRSinc4HxlR7o=
X-Received: by 2002:a17:90a:e7c3:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-301bfb3ba7emr1540997a91.0.1742390898191; Wed, 19 Mar 2025
 06:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250319111243.14206-1-dominik.kaszewski@amd.com>
In-Reply-To: <20250319111243.14206-1-dominik.kaszewski@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 09:28:06 -0400
X-Gm-Features: AQ5f1JqQSavicrQsc8jReBn7qnS0_kcDg348IOqyGiv1dF41YmR7ovvVchTuLWA
Message-ID: <CADnq5_MMs_LC-7zKbEO47eygJ=MzdVotLNfRDCNWj5Cju9HRZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo in DC_DEBUG_MASK kernel-doc
To: Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 19, 2025 at 7:23=E2=80=AFAM Dominik Kaszewski
<dominik.kaszewski@amd.com> wrote:
>
> Add missing colon in kernel-doc for DC_DEBUG_MASK enum.
>
> Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index 4c95b885d1d0..c8eccee9b023 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -366,7 +366,7 @@ enum DC_DEBUG_MASK {
>         DC_HDCP_LC_FORCE_FW_ENABLE =3D 0x80000,
>
>         /**
> -        * @DC_HDCP_LC_ENABLE_SW_FALLBACK If set, upon HDCP Locality Chec=
k FW
> +        * @DC_HDCP_LC_ENABLE_SW_FALLBACK: If set, upon HDCP Locality Che=
ck FW
>          * path failure, retry using legacy SW path.
>          */
>         DC_HDCP_LC_ENABLE_SW_FALLBACK =3D 0x100000,
> --
> 2.43.0
>
