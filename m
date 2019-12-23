Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717DC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 18:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C83206D3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWRDAv6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C83206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036326E2EA;
	Mon, 23 Dec 2019 18:53:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B4D6E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 18:53:05 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j42so17585010wrj.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ndLjh5blJBCC69EfzUuPJ9miIIvKKkiGWLOrzzImhQ=;
 b=nWRDAv6g0IrAmS+btSJhYaIl3elvQwNE6EvgFDB0iika9F1BZ0KByU6RQ9jQ7wutXk
 B0Anb/cdbN1wqXHx1h/bNWoKWf2nVDsqhqjKs+jrQfJQz9rTY6PtphbULLbGuDJ6WHPK
 jvYbwOxIF9yLobG6FX/QSuc4jnDeJTu+ChVpPVdr7jPWF5iJKTCx6W8gD28Li2c2XCtI
 6Yjjup0GnRgMgGiUMRVUVSe1EvllZVYZMDz/vbWV2UzYer7xYyWqK8ghY72m19Lo8+0L
 zhTRenIXToqTtkrjSvAhoh6SxsU0VF578dXCARWwwdAvDw99PGwwue1rySIA+uPvmDKI
 RWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ndLjh5blJBCC69EfzUuPJ9miIIvKKkiGWLOrzzImhQ=;
 b=nxssuVXPd74WZLw7qr5HQAvwlWjDMyU+lXFF637duknlZha9GjruXkYkojhLPynVDM
 x9/+/Cv4hudPmfv/E6E3zZ8O3a7bAiAmf4RoqZjkgmDQpS36zCa4qkKnzzn1Yq1qSkdY
 83V8TuKYTqlR7wdOFRVComU5nzrGf4rZ2Tq2CWLNCxCj5eEwU/kTkscwaJ5On2KHnDoF
 9uhw6SG42kHc0Y7250l8PZRG17Dx5k+RKycbOfYtfu3XlfsU6l3zzAmPJtmXue//EZAe
 YeyFU/g8T/I8Xz2YA/tli+Aj89ZY7lGb9N/HqV9Y6bW5HIKHaWtiuXNt02D1iLlhKkV5
 9sFw==
X-Gm-Message-State: APjAAAXoNyFp36WBFHbSq4GCQMui+HAtlgysNhK1OvvnSqRR0mRpP/BE
 doNWN0+MS0JYrq07k6ejoiDhig5mBACgNPX1LTSFAw==
X-Google-Smtp-Source: APXvYqxcuFDTft98wSxB02bAEb2IyGgTtgUoGCjT2vsM4Rp4ppzXrOlV16WFNxash82RKpDQr6KwD8qR9geGAS4IRAM=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr31856995wrn.50.1577127183428; 
 Mon, 23 Dec 2019 10:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20191221001142.1338192-1-alexander.deucher@amd.com>
In-Reply-To: <20191221001142.1338192-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Dec 2019 13:52:52 -0500
Message-ID: <CADnq5_M2P4k4E9T7rYfOCHqU2pa-hFaN2Kq+c86PSUg-Xvuo1w@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: simplify ATPX detection"
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Fri, Dec 20, 2019 at 7:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> This reverts commit f5fda6d89afe6e9cedaa1c3303903c905262f6e8.
>
> You can't use BASE_CLASS in pci_get_class.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/995
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index a97fb759e2f4..3e35a8f2c5e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -613,7 +613,17 @@ static bool amdgpu_atpx_detect(void)
>         bool d3_supported = false;
>         struct pci_dev *parent_pdev;
>
> -       while ((pdev = pci_get_class(PCI_BASE_CLASS_DISPLAY << 16, pdev)) != NULL) {
> +       while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
> +               vga_count++;
> +
> +               has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
> +
> +               parent_pdev = pci_upstream_bridge(pdev);
> +               d3_supported |= parent_pdev && parent_pdev->bridge_d3;
> +               amdgpu_atpx_get_quirks(pdev);
> +       }
> +
> +       while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
>                 vga_count++;
>
>                 has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
