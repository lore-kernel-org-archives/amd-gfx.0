Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345BDC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 16:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE5110E039;
	Thu,  8 May 2025 16:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Os3ox55R";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5A510E039
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 16:44:30 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22e560996a5so2424285ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746722670; x=1747327470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnZDSp59SEoP6Hdrgfj8gUWqgNhqhi4Rs5kL/iHa2EY=;
 b=Os3ox55RyFWiZquA4dRAbVgob6U0g9qcoL6InHOTN1VVJNdoPl4VZj5xXht9nnFdHH
 QC4/81TOtILxxK+PQXWWVtXIClgrQiHjOWKbJzK9goV9IEon62RLmtCMu8+OxGVkwP51
 5eLloHSiCkSRbUMKwBnlTd7yDmqxqK9dQj0iX4h25lIXDxKjWSca3e5h03F61J34prWv
 n+m08YXOR6RcVsBx9sNdKrY+sOGm9EkfHGBzq7swWyDOAPgjYTBKZMU2JU/6TsWMj+4A
 NS4oT5ZmzdeB9NMYZCpq6D2n1kjADpIOe9Cmnzou7gbxjqPfYNjG/HEWkYafH15KxqUE
 ZQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746722670; x=1747327470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnZDSp59SEoP6Hdrgfj8gUWqgNhqhi4Rs5kL/iHa2EY=;
 b=WzUFSiRZL44zVFez38xR/YX//rbrrg6bfZEohXsRerjUM2MkyBl/3MhNrZ3P2gXdDC
 4FQ6C1GxhKf8T+OuXBM/nxzbtQeOhpLfEJBe9bvw95W6WaaK14Xrz+jb0XtyA+HSZDNj
 YDtejA16o1HXeKY/Ef/83I3hSMspVOEsIMFafFBrVUZCxkPk0FgwF0hcKBM6VYMTC2zB
 nEJFsQa/wgudCk10rDNtmuBT4gUFnPDGug8v6wvVTKrF3/+3D3g91XAuM845RKYi4ssf
 afxqeudDLFZddFEFP+cxbudlJWeenUrpWj3cxtRxxImO1YKI0FPehfDBGk1BYuHu9Yux
 8kZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8TxZMhWuvD3h3LdOWckx1BCJDPnHLUZUNe134Lt+BsxmZnfFgNQ4/CdaBGhfbax8CfEQbik2J@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzI6Zj338bjYGRePFdLduLm2NYVqWKn4ZRhGOFTx3Wl1xh0RGOt
 k/OTSTiqg6hCiU9TpJ9yokaDDxbkGNnflH8MS1aHSeNZgtSkrVV8pXokcQ3odWQespjWmijbQWo
 8P5iA7Yf6+wfxtwnQLLWJAoNzLMI=
X-Gm-Gg: ASbGncvdWzcrtplwZdzA7Kth20tzshXLBcIGhTqSIZlSmkYLFvQ/PGqm20Di8+QMX2f
 BjPsZu6fLqawq1dMnVp+XF+lmIGUXnfOBK09CtLknC8JAnHscvVwLsKyokfxm5RtcuPTc2FuebX
 1MY82z4vhhflz/Ce3IKEu8QA==
X-Google-Smtp-Source: AGHT+IFzix7ivWxXTCUd/Fx/JX5WuK2M0mCKkiOub+TNkovAq1guqfTV4vvGr7RlnaVXXCuA7hR6YfwZ6JqFBh1ZumU=
X-Received: by 2002:a17:902:e54f:b0:22f:b00d:fe59 with SMTP id
 d9443c01a7336-22fc8d98a69mr59975ad.9.1746722669691; Thu, 08 May 2025 09:44:29
 -0700 (PDT)
MIME-Version: 1.0
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
 <20250506155900.3866874-3-alexander.deucher@amd.com>
 <DM4PR12MB5152A6774D0989F6ED7582F0E388A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152A6774D0989F6ED7582F0E388A@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 12:44:18 -0400
X-Gm-Features: ATxdqUFS6d9cdJbaogOvAONpLEfWjMZdwpIM3dVAUOIc5gQr_6eKzFvzC-ueN_s
Message-ID: <CADnq5_OCFMOdmNBk7Z0=i1w33d7yDvb6a29ZEibJGLoXXYp_Qg@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Wed, May 7, 2025 at 2:55=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Tuesday, May 6, 2025 11:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
>
> Used to reset a hung queue.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba0..650fdb68db127 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
r,
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);  }
>
> +static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
> +                          struct amdgpu_usermode_queue *queue) {
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct mes_reset_queue_input queue_input;
> +       int r;
> +
> +       memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
> +
> +       queue_input.doorbell_offset =3D queue->doorbell_index;
> +       queue_input.queue_type =3D queue->queue_type;
>
> Do we need to set mqd addr and queue wptr  here ?  like this:
>         queue_input.mqd_addr =3D queue->mqd.gpu_addr;
>         queue_input.wptr_addr =3D queue->wptr_obj.gpu_addr;

No, those are only valid for kernel queues.

Alex

>
> Thanks
> Jesse
>
> +
> +       amdgpu_mes_lock(&adev->mes);
> +       r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> +       amdgpu_mes_unlock(&adev->mes);
> +       if (r)
> +               dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r=
);
> +       return r;
> +}
> +
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
> +       .reset =3D mes_userq_reset,
>  };
> --
> 2.49.0
>
