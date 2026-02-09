Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B389E94617
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 22:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DB310E05B;
	Mon,  9 Feb 2026 22:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q24/9OCb";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E9410E05B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 22:38:33 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so347436c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 14:38:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770676712; cv=none;
 d=google.com; s=arc-20240605;
 b=XFJoBdeE9s7pNHKptN4TRVWXi0bC1v+M80+Bk7H0vDOuAt02saE7Ezkdbz5D3xzuSm
 g0mlO/7wvY6XxjK7ixdJradvrSUfEmUmjKcVIuEwciapmpvrMPtvEmcUONmZnPWKipbJ
 JT4+ExZ0slKf/I/MZ75K3C9aEoPAAjCuZWsUU4D9pD8ydSwHowxtV9v0VUvT1yS+ZJTx
 d1Jd+L1gytnBbzv0Xn+LQkRsxbxZlBsxv4q609eKbRAeM2nqSWXxhY6QVoEQjuweaXIl
 2xb9WQODuny3Jh4Cdq/J9syrODqdk8nm9Wz2hkuJssTbenLVMn72eFEJYxQqGnYJrxkm
 jJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cfqpb0EiK0NbVGZ/NXV45to4g6ynuuAOCUrrfWIy2w8=;
 fh=hxQk/uZpkXs5H9xvSBgSM9HoyHLdZh6wDCcQc548gy4=;
 b=ebNx3Nbe1YDD3muJELwBp+vlkXTL2IiN8x/Hyhi5f3SqkyxZ6yvwVjHqVN6yTL3kGV
 fYdjL9JSEPef9G92GyC0uI2fWfdYGirDy4djIDBznvLqJ81ttaobWHyMrLS+E5BqYv06
 6bNeOykkghmYVrMZBU2W0Jc/DkxBWRE/EfrBmTM9MdgviaEmXxu+bbJyJpxYgk98Jmk8
 t5An95lzJVAjEJdJSuvSSWkZYfUZSxk+IM6bXa7WK81hCBye6LLnsSMQOSjAKWgnPUGb
 9Bgs3yNqnIYpQ3bBM8P8SyQFNYKmdS50iA/lLlgQ+e5TrE1cc5V5qk5uK86mGj05ERqU
 ftCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770676712; x=1771281512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfqpb0EiK0NbVGZ/NXV45to4g6ynuuAOCUrrfWIy2w8=;
 b=Q24/9OCbB3OXQeN7IDTDKB0oi4WiJGCmsAJnYqVQDVOS73xD4Jy4k0l/eI9XvUWhOr
 j3E33Dma8CvrKs2K08dhivY8JGSUgmuaAkVQwtFoQuW4Mi/Oi2zp6r1W5LWEuFWmvPRs
 edgvqeBqeTnDH73KA6tMxlvp23ys2NtVSoNvkucuqalU+cOM+IqM0rRdVZq7qHPT6y2d
 32br4w60UZtNeNuYq9UVhi9kCZbzmBLikHfos1mIkBHFc5wfkhkvC+cmF5MWcBtCHXJa
 0MVuYJc7zLsq1lNMTHCE0GnUWWloYFH7XVEjTfEE3SN7EqTMUnrt2A9+Y5+mKVTN124p
 21UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770676712; x=1771281512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cfqpb0EiK0NbVGZ/NXV45to4g6ynuuAOCUrrfWIy2w8=;
 b=hPbJISr5EtqUJIs5NEK91+GkhNqVqoCWWO+AsHYfLKgNMQZj7yl3jdf7nt4PNtI6/Q
 PFgAzQrJn+5tLGfMZwNfI/P3ejl+6BqAlUCoqmNFHVGWHCmfVa4N5UzVhKvZbmqnXom3
 tq8NbxyP/Wuk1n0+l9uDk8mfEC1yDEqg0y2P8FuX6PyDo8r8r53kmO7M/cEoSNJOQlKq
 Zn0Veb+I6QIS3qpbDkOPAJVXEH0q0xB9fuNrbeBWnNWDM7QO6tu7WQgAldCMiuWQUI4K
 skIM+SfSc74p6GUFRLTTSSFe4NbThQbq7FP9JOUN9Xq0Vlavh3I0HPRxD7n/+t19cVAb
 YD3A==
X-Gm-Message-State: AOJu0YxfK+iMzJVppT4Aed8xyh5KsBqmfMg879Hx94GVe1zIckgNcdY2
 m7e37ask9bkF8IhqdHC5ykwBX5fSTZur69zF0IvdaOdccLd1eDielZUZUuUklws/TTKjr/TSF8C
 iRMosgja9/VGb9u8RZv2nJosxbejDREw=
X-Gm-Gg: AZuq6aKzqZsxgM10elXDI1Pvq8ZQotIRgN2F9GREBYLG/3hDcKYg4fF/YiImtyFlmNT
 RaB1zUEYf965vW6YkUkTdUcUsDln5dU7Jvj7ISjNoE8fP71mMmparmoe+Cp4oGxgDAjjpWnigFc
 +wzxyCrLfMb+ejKlA/47np52yc6hqXQ32RfJeCh4qUo6smCPCrgm4USy75ycdgVlE4hq+VxQB5C
 /0pA4fwVeh+1RF0cnzUXv5BoMvzV+QGHdsUEJZQjojYX7cRbpfWILhmAQvAwS/T3eTc6AEU
X-Received: by 2002:a05:7022:f8e:b0:124:9e46:830e with SMTP id
 a92af1059eb24-12703f83cebmr3454314c88.1.1770676712330; Mon, 09 Feb 2026
 14:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20260209212702.561630-1-siwei.he@amd.com>
In-Reply-To: <20260209212702.561630-1-siwei.he@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Feb 2026 17:38:21 -0500
X-Gm-Features: AZwV_QjZbH-c6bDU7USet4WMkq-6OVZg5BL0li3yoi13fC1wsyQiqXu10svfrPE
Message-ID: <CADnq5_NTrngTOkfxu908qcxZj2yRGLT=Lg=Gy4wi=g-HWgSyfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix APU to use GTT, not VRAM for MQD
To: Siwei He <siwei.he@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 harish.kasiviswanathan@amd.com
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

On Mon, Feb 9, 2026 at 5:17=E2=80=AFPM Siwei He <siwei.he@amd.com> wrote:
>
> Add a check in mqd_on_vram. If the device prefers GTT, it returns false
>
> Signed-off-by: Siwei He <siwei.he@amd.com>

Fixes: d4a814f400d4 ("drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index d4659a438be5..80e428f70725 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -111,6 +111,9 @@ static void set_priority(struct v9_mqd *m, struct que=
ue_properties *q)
>
>  static bool mqd_on_vram(struct amdgpu_device *adev)
>  {
> +       if (adev->gmc.apu_prefer_gtt)
> +               return false;
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(9, 4, 3):
>         case IP_VERSION(9, 5, 0):
> --
> 2.43.0
>
