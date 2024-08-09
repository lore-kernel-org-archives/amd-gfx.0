Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803E8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 14:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA6210E933;
	Fri,  9 Aug 2024 14:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/73wZwA";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB5810E933
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 14:41:46 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cf213128a1so1672683a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723214506; x=1723819306; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0TIaszgCPOItPFBTwg+mbjvJUOARDBs2Zsf8+pyak8=;
 b=L/73wZwA8BVHmV9t9cvI2ADcs21EMI1S3xto+fzIHdbZ8PtrP/eVbOyRpxfMmjiYNv
 bC3ltTnUnK+MKXU3Y0E0rzDLv+PsQpBImQrGFjJrbkW0uOXtZ/rfULLNImy9FnPL8ZnT
 9fPirLXf7yZD19kL5tmPgLuHaUqjzA9Z/9WXOidzdX7m7AOtG4Btgtry8bi9uDupVrwr
 yRUfBwKoZQCNC6l4aRgWlf/gLG9yXq07AVMmOpABkYWPluitsjHD3lLG1fAtzy6jOEHQ
 7hXaXmauoVCwcTNz55LWiiI/80PtjyIs6geW/l7KuzRQ0YX0R0+v7p3zae/ddTYb1xwA
 T2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723214506; x=1723819306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0TIaszgCPOItPFBTwg+mbjvJUOARDBs2Zsf8+pyak8=;
 b=ZWhc+p+k3cOyLOtwzuTGa3iVQg4WH87ci7f5Wvca3dzl2LPWDlu9e3mMxpPysP5vwf
 FFoKd4dOSRx5VCk7x2gaXxo7DttpO6Mh/Ez5AhSmmmrgoMKNKNFqqkfXLkklvhd+HfoD
 K91V14SC3SZ1HBMgY0NT03B90A6J7uKIHsqJYRcwY387vwyBZG7vzUcSgllwxW5/lfDy
 OhCX50GKgzhJcjmrdBcXhX8PfPzRXy7YuERb56lW1nnolmeBZW052741TGUDIm39GJg0
 WYtGZEmbQpc/cMAoXAfZxbZEqJXdNSud10SmiPWPh2tWeXUFW2wMm/L/I2X+mUL5b0DQ
 PE/g==
X-Gm-Message-State: AOJu0YwgEprTAEK7NU3DKf6EWT1VIdyTxqJWIoPGbeHSDHDPSBjuoSDs
 cs/5m/sU+MYtf9ChExAQmcgfAioFPEyXx2tCRDCY9Gv4MP+tSwgLm1vLzdWNMWv1l3mqoL8FfcF
 5hpE8Ub/PzwWtpclp662pfvMZnzIXGA==
X-Google-Smtp-Source: AGHT+IF0BK/Vf+3uFjm9Qs3JvMuRwwyWTjgMDMRzVgaQdQZ3g8n4M0mpdLCCUHjRxgPi+ujLO4aUjbik8EdVfamrkbg=
X-Received: by 2002:a17:90b:4a83:b0:2d1:c9c8:301c with SMTP id
 98e67ed59e1d1-2d1e8049b4emr1700533a91.29.1723214506164; Fri, 09 Aug 2024
 07:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240808030707.2935006-1-Victor.Zhao@amd.com>
In-Reply-To: <20240808030707.2935006-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Aug 2024 10:41:34 -0400
Message-ID: <CADnq5_MEL1qN9dmVaE8eG3Xa-yCvDfqHHywe0StmeVnvjRkvOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/sriov: extend NV_MAILBOX_POLL_MSG_TIMEDOUT
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Emily.Deng@amd.com
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

On Wed, Aug 7, 2024 at 11:15=E2=80=AFPM Victor Zhao <Victor.Zhao@amd.com> w=
rote:
>
> on MI300/MI308 UBB products, when doing mode1 reset, since 1 gpu need to
> wait all 8 gpus finish mode1 reset and then do re-init. As observed,
> sometimes the gpu which triggered the reset need to wait 15s for all
> gpus to finish.
>
> If poll msg timeout, guest driver will send the reset message again, and
> may mess up the following reinit sequence on other gpus.
>
> So extend the time to cover the maximum time needed to recover.
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.h
> index caf616a2c8a6..1d099ffb3a5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -25,7 +25,7 @@
>  #define __MXGPU_NV_H__
>
>  #define NV_MAILBOX_POLL_ACK_TIMEDOUT   500
> -#define NV_MAILBOX_POLL_MSG_TIMEDOUT   6000
> +#define NV_MAILBOX_POLL_MSG_TIMEDOUT   15000
>  #define NV_MAILBOX_POLL_FLR_TIMEDOUT   10000
>  #define NV_MAILBOX_POLL_MSG_REP_MAX    11
>
> --
> 2.34.1
>
