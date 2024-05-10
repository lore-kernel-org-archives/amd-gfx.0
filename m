Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DDEC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 15:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F2A10EE01;
	Fri, 10 May 2024 15:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rz1hALEy";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5652E10EE1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 15:48:52 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-6f45020ac2cso1795118b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715356131; x=1715960931; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na/vH6cb2y0fH7OnDp4XPe09GVJej475Q3l7xkCuTsA=;
 b=Rz1hALEyznNgnJFMoRNb0WNSGbyksZDuwFX5JiFenmTUZ4TwD6oRXIkD6fU4/WVweB
 /UZcKQS658H670Lctx9Qy2QvXoxH4M1Meu4f4L3FmZNymsZXBYdj1BwJpnGSBL2CHliK
 5G6z50Hi/M93kJKnqjxQlaLgw6Bw/cgC6/fw9KZuL7HzCOiZxLfg+Xh8qrqaapYaQBrn
 oFiQsQDhz/0FTrtr1U4Q9wqc881N1DopYs+lN2ulF9bpuV+aD4hG+vahgtPnu+Cx/5NT
 GiWIFKJKe8JxfCbDfKEwLk0+UTt/uiaMODUX22HpafB41LyDzP/CCz1NcC2yMlnIlLXe
 1TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715356131; x=1715960931;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na/vH6cb2y0fH7OnDp4XPe09GVJej475Q3l7xkCuTsA=;
 b=C8ow2EtqEf6JyblA1Y9ff4mTpOR4rkrWIfIkrWboVx6r5c7bBLdg4VHZKcN46PWTkI
 B1dP+nYxTil9exw0TtVBR9KBDn1G7DPIZITgB8CXrtbBprH81E2dBsT7qE/lvsNpmqN0
 yd/whJ6S8vlWvM9NhR2ySFMrCENS9cpZmQe8tkRu7YReG0mBy7h7W/n51QP+NN4KJyG0
 xrkBsjuOtW/l4O1UzAnLLTAjw5tnMRjWVkX1a1uZQzuW0aM7oklcIkJF7QV08Ao0HIFS
 Q7LQeVRXbHxZcz66uDcGPZkDjI0emkZDgtJFYnfmtWvWtd1TXB/mauY6ivR2n7TbhmWe
 8a4g==
X-Gm-Message-State: AOJu0Yw8Whsyd6MYsOHl2bU+04LOLH7oMvCuXfsWAAZNrBaDAIffMKsV
 8MMz4GhBW4JD8DAisQ5XiJriLzCzB3lMHaHZE//4NHQM8JWuUTT/uBsxqkk73xOXpaSb/XeYa8/
 6SJStAcC2sfBcoDw1NNEzNWkj0+HlMQ==
X-Google-Smtp-Source: AGHT+IEvtpFlUrIKLgVNYRTkdtMh6+FAlRfMQnVCcygZd1hczhZSrY1xVCotRbHYeLYmqqK67nlieG1Z1jtpPkEi3iQ=
X-Received: by 2002:a05:6a20:dd82:b0:1af:64fb:a04c with SMTP id
 adf61e73a8af0-1afde10f20bmr3376218637.34.1715356131540; Fri, 10 May 2024
 08:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240510150429.538312-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20240510150429.538312-1-sreekant.somasekharan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 May 2024 11:48:40 -0400
Message-ID: <CADnq5_OL2z_EZnfQbS_m9x7fn5m55iayPbp3RDbWBudipgQBWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add GFX1201 to svm_range_get_pte_flags
 function
To: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, May 10, 2024 at 11:12=E2=80=AFAM Sreekant Somasekharan
<sreekant.somasekharan@amd.com> wrote:
>
> GFX1201 was missed in the commit below. Adding it in.
>
> 'Fixes: 7c06cc729edc ("drm/amdkfd: mark GFX12 system and peer
> GPU memory mappings as MTYPE_NC")'
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index b1ec7ef844ab..28c2c1b66226 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1250,6 +1250,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>                 }
>                 break;
>         case IP_VERSION(12, 0, 0):
> +       case IP_VERSION(12, 0, 1):
>                 if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
>                         if (bo_node !=3D node)
>                                 mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
> --
> 2.34.1
>
