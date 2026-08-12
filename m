Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8FFC5B572
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 14:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3454A10F02C;
	Wed, 12 Aug 2026 14:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qKTzfrxK";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C75710F02C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 14:30:37 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-81bd69f4f6fso761617b3.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 07:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786545036; cv=none;
 d=google.com; s=arc-20260327;
 b=P/7fc/Cxc6zAWHN6Jk8hYl6ph/SNxvjC3Gw23aBzQXHWtMQh5kgXxpPKcgwvLdvL6+
 1XWfPoPs288RD6ERm+Oqgy+GOqquhIDhMGXhoX/WL+IyEerx09W7YZONynWomVX0vVI0
 yWS7fzzo0Eaxdhy2PO/vP+k2uXChAn/9AXH9+UJJuSfFN5xvu5F5D5cndF2MHqQQFhka
 WI6L4JLmQdPASMjCJfoRr91whlEAey/b6iQog1eiSyMYUB84+1CZsG2sLt7p09Wsd45l
 rPZd0HBcKBK6RyO2YvgmtT/fRqpOk9RePb2nROf0BmJj7LIcSAzfMgi1wmjKufbAe4sa
 6HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=unaVSsEtvY+hPuXdERf5Wge0Y/VU4wyQ40nI2MLwHoA=;
 fh=/cF5cQq/FqPFGBykVUp25+67vl7d+1caNPg/4Qq4xxg=;
 b=lzcPWV2teLrn0eUaGw0zVJGWxcOBDEyVeXDKCOj4USI/TSHV6hnSPA8C8DWpO97Wsi
 6+qUF6HnFw5Y20pJsAY0DRheL7ky8N7PqJzl24avZ584YHPPjkTb//gV/ckWVg6ejDTx
 TDx6R6F1zjV4SKLHVTZ0BwycFHvY/ma9ojMl3pVTnyVzdgNOXhbqPnBVkoaH4u8f5izC
 lgOdtyK8taRMIF2RkarOdVQzoa/9vZ38+0n+1SR2rJIyQmeBbNqeYBWt5XhqoWApxTeU
 sTX89BXaM/pPOv/Ivqnx5/hHTzeVPe1Tstn/JJHVzdRNQ5INqQpSyOJmQ/Hrj5O2IHwV
 b8XQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786545036; x=1787149836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=unaVSsEtvY+hPuXdERf5Wge0Y/VU4wyQ40nI2MLwHoA=;
 b=qKTzfrxKvybgtA9xiUuUWF0v5kHeVKlsKmo3lyJtPtaDUy2H/BcnJ1UFm8gFpPHytq
 yOKAFCN1xASeQdkq1PO0ipxfy7IeG4YI3h0vvAL7vHA2J4g7iuOTaBevpNq0AtEc3wMQ
 hOKQikGBYzw8E5LaiPbwVK+iBZZrGjhWKdFmu0coEeeMrFlxwNLz4Q5yijxntp4OXq3x
 wYXgHJDn+K3OBu3vgFTNyWJ5l66y1AHLPSP8+LC21AbVS9VunUjJsTiKReAE5demShFd
 a9Yjb/oNcFiYB1r6XsPqdRhEr7683i7A5MNEmrBF1BWkw0T4OK4YM1rS8l2eePt/cnPo
 F3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786545036; x=1787149836;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unaVSsEtvY+hPuXdERf5Wge0Y/VU4wyQ40nI2MLwHoA=;
 b=pDgy4ll8MkL6deRGyCBq21Wb+EOAk2BmXIsYleFn9EkG61V1zZkN2AECeT9wU2C+eN
 vA8tQfF9/kDAum/85UkkURNhsY+9uiB1JTQPiSWfPESBJUUow69X64G2dIWSTBo3RArC
 GjAjtfhm4vOP7axdveV86S4EQfFTFIFEKAwP3/suKCzVd6EodqFULH9wkdHuUpGYbwpN
 iNnnYROUN1ThS8n3FchSqurFv8nzEFtG86zM+v7Dlsiq1OIk4KWcmrOjxc9fe8yoXYUk
 kPKOCQdBTYclhG6yXLk98EYVEAVWhUbB7EYMwvC2rj9yODOdgMkA0aHvOcHo+sqPJATF
 andg==
X-Gm-Message-State: AOJu0YyWmcGtoSCr/Gh5y/djndrU7B4Dlo6QB1qtOJIwzLxyLb78MUPr
 LYPo/xV0r1kreQe7CJhRJGZXSSjSeCFaBgiv2R52Gu1wSs3tOn119eN60q5HuVXRbzEHpKNnnWE
 +1dWd7y+yERNdYpXXWqFBGyC3cwu+hq8=
X-Gm-Gg: AR+sD12v242Do5ZjmFVS3mmyWgPCa5fZNKFYDoP7W/y507YdkqvfdAu01rpEGZ107+6
 P1NNpx/MU4cje6PMS52YEbL4UPZmMQ35xDKHcaTXCXOs9FYT1VnFEpleuBw835xM6nGvfGataOS
 OUgr+Lpo9kquW4/ONuad6u4eTmbbIFlGx9kctTpxWmGXu1p3AHaeO9u1coHQsJI/mVPF7OIRiIq
 glZgTe2QNfK4Riqoh3tqgHtaNO/zvuEttdOp01ccwlGQiWflmhbLd8K+Rwm/YohHmICRQgOtict
 BPVljcUyKYcghomD+krZudZpyfKRVLfUmQtGJLKfS2oHLTD1ZviCnrbXxLraCSJS/JfJhrwzWy3
 iyvivd7TSchSLWYu4ifZYg98j+unDTK8=
X-Received: by 2002:a05:690c:4d44:b0:81d:bb95:9f84 with SMTP id
 00721157ae682-8310aa9669amr23978527b3.3.1786545036076; Wed, 12 Aug 2026
 07:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260812080841.2936007-1-kevinyang.wang@amd.com>
In-Reply-To: <20260812080841.2936007-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 10:30:23 -0400
X-Gm-Features: AUfX_mxV5P8rp1kJgHQyT61I83uL9agpNtC6fc8Dolgk3YgGlnnLCuxlFCal4_Y
Message-ID: <CADnq5_NDBUquX6CgaLEZ3YZMpkUHn757J=FQYTJO-Ld8KW-pqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, kenneth.feng@amd.com, candice.li@amd.com
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

On Wed, Aug 12, 2026 at 4:45=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> pci_is_thunderbolt_attached() requires an upstream PCI bridge with
> is_thunderbolt set from an Intel Thunderbolt VSEC. This does not cover
> the affected ASM4242 USB4 PCI hierarchy:
>
>   00:02.2
>     \- 0f:00.0 [1b21:2421]
>        +- 10:01.0 [1b21:2423] -> 45:00.0 -> 46:00.0
>        |  -> 47:00.0 -> 48:00.0 -> 49:00.0 [1002:7590]
>        \- 10:03.0 -> 76:00.0 [1b21:2425] USB4 Host Router
>
> The host router is outside the GPU upstream bridge chain, leaving no
> ancestor with is_thunderbolt set. PCI core propagates DEVICE_REMOVABLE
> below the external-facing PCIe tunnel. Disable Runtime PM when either
> pci_is_thunderbolt_attached() or dev_is_removable() is true.
>

I could see BOCO being an issue, but shouldn't BACO work?  That should
be self contained to the driver.

Alex

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 8ebe24d59ab6..a4b4f9645c84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -609,6 +609,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amd=
gpu_device *adev)
>         int bamaco_support;
>
>         adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> +       if (pci_is_thunderbolt_attached(adev->pdev) ||
> +           dev_is_removable(&adev->pdev->dev)) {
> +               dev_info(adev->dev,
> +                        "Runtime PM disabled for externally attached dev=
ice\n");
> +               return;
> +       }
> +
>         bamaco_support =3D amdgpu_device_supports_baco(adev);
>
>         switch (amdgpu_runtime_pm) {
> --
> 2.54.0
>
