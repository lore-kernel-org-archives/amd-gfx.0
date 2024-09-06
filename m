Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3023CE7B1D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBBF10EA83;
	Fri,  6 Sep 2024 14:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XibTMZ68";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E0710EA83
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:58:36 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2056129a6d7so956505ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725634716; x=1726239516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhCU0ApTWxTPQOdmeDVGEHjqVj3W87/vURvKLwJm3dI=;
 b=XibTMZ68AMkXAaRmGzCEtKzMhkJ8ZK60xqmEa9e1PlF/6Edt/z4qF9UHsNuAXSKVHL
 musrBFZAicFDb8EpGkghRTXAPNrRUvYbXds063OzpsvHJlD8pUgNLS5KPT+TbmdQT56I
 2bhwynoWIhOK4VcHkjiHgToiac/E4AH4FwnOTdRc/EQ+FWfjeAyFXWYVbRrt7WOmFIKC
 Al/qlf1gB3cM0emZpB+bHsEB8337HtNbcl64IOlzWiukb3CstltaHvZJjlVYvVxPDYRP
 Jnt78ZAs34nTr5aYjZWiKrt+gL/kB5ayRCcXWf4zaLzg7mdAQ+qBVyFcBdHTP/kYwwU1
 JoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634716; x=1726239516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhCU0ApTWxTPQOdmeDVGEHjqVj3W87/vURvKLwJm3dI=;
 b=FDeb+lpgYqrZpgslyAXR6pGkRwhv4rhrM0vIkSbQfOJyynjuEUzO3fvTyrw24gTn3z
 W/o1ZkzvYmnioBkbz7G4o7ERsuDYvX+laN8pSQj2raJApcLhTmvWD85QUxaa05b4p0lD
 CjPjheQE2nyOtJljt/10QFIn5MNqG51bgpyvarDmsGPCaxBzIbtuJ3eRtTF98Wuk/5r1
 yVL2oGSgJDMsp1II6lXTvyixuEYvcoH5MCkaWhX6IT9GSsPQfylcU+89m91eyed3jy/N
 okEcRJtv+hzIk4C4oB9uhshYrlt73YoKP7iJ6VB9c+JXOl+450L4/GkEhSvMNroW79kQ
 KLIg==
X-Gm-Message-State: AOJu0YzwAth9MXnzxqIzVbC/rkEXzuW6Psf+jCZSLs76oi3RusJE8d8H
 Dhkp0B50b1HWSUHCDyvt9qGXRiM7tNXY3LzwP5sUIRfM9Ybiu4Bl7oMwf5i83yF8hE0I+EyyXh6
 GCLmKgshPxvQneZCnmVhpbjhKyh4=
X-Google-Smtp-Source: AGHT+IFI+hrzhF5h1es2fasBahGV6wGZUUlDY4M72Whn/8QsnKmB+d9q3+SngFMcEmRhFODJM2Ysih6Mmh5w2T3TDEQ=
X-Received: by 2002:a17:902:c946:b0:206:b1fa:ccb9 with SMTP id
 d9443c01a7336-206f05faf24mr15086565ad.6.1725634715392; Fri, 06 Sep 2024
 07:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240906094820.405313-1-bob.zhou@amd.com>
In-Reply-To: <20240906094820.405313-1-bob.zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 10:58:23 -0400
Message-ID: <CADnq5_MRq69M+LDRWv7pW6R5n_Rdapze5dBd=zcDN334fgScuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing check pcie_p2p module param
To: Bob Zhou <bob.zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Rahul.Jain@amd.com, felix.kuehling@amd.com, 
 Ramesh.Errabolu@amd.com, Flora.Cui@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

On Fri, Sep 6, 2024 at 5:48=E2=80=AFAM Bob Zhou <bob.zhou@amd.com> wrote:
>
> The module param pcie_p2p should be checked for kfd p2p feature, so add i=
t.
>
> Fixes: a9b55f03989a ("drm/amdgpu: Take IOMMU remapping into account for p=
2p checks")
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 61a189e30bcd..20910c0187c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6189,7 +6189,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu=
_device *adev,
>                 p2p_addressable =3D !(adev->gmc.aper_base & address_mask =
||
>                                      aper_limit & address_mask);
>         }
> -       return is_large_bar && p2p_access && p2p_addressable;
> +       return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
>  #else
>         return false;
>  #endif
> --
> 2.34.1
>
