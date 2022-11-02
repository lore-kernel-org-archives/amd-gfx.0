Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35986C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C16E10E4F5;
	Wed,  2 Nov 2022 16:08:30 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E7010E4F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:08:26 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 a13-20020a9d6e8d000000b00668d65fc44fso10527459otr.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBmsHeS2eZJAKNTW7cQ1+Qo5njaXgxxpurKAk/rvuk8=;
 b=YH2KVl2+AnpvKyawcd5MicxMkpD5frdhqL3XZi9yjzgCfEn4sXqjDMrkxJ0LkbD0BZ
 jY74i93aH+RbV1m0WSBUW7zQrhUXzrSpb8yW1In5UVJkWfBQ0z1qHqcYc6zD6tZ7vPgX
 jMu3RwV/ro9k+FJseFsR0B6kFLGi90dxaVvWZ7yCNheWaDmolwfN9RDS+1DDgOZB9WE6
 EcK1zN0f+R4WMGIWGoUH+iciJSR1C+U8NS69ZHrbnuuqve1H1l6Mg+sYCawrFadPok1b
 Z8EB9hNRURzUXyE7n5pu+RkJWEIbV8IbyQU8qCOUBNC20zratzea6++b/qk5vkefjK5m
 HuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBmsHeS2eZJAKNTW7cQ1+Qo5njaXgxxpurKAk/rvuk8=;
 b=SFMETsYJ/i9lZNlhEExYrQwqOCMnqoWBGOnsmyJM5EM1xcQ2qWbSnLivKt+aOSNNH0
 LOP1pvSTn1tvmCV1/GU1dJU8h6Rz7dnOx/V1av3lJfXsvfScpQR/3bqVqTM4nVO5IPL7
 6OC6CWZPmzdAaikhT66AVke52bAajYSnPcDQ8QLa0p+mMcztZfd7Pp+CAGtFXTX3NiDN
 u8DtgNm3dKIdGdFaqR4Phau0jxl3E0VXS979T5BUJEkoSuCzfxNq6Gm4uDCcQzmlwBS2
 1pHusv/5PDQED3aMtM0JCLgAySvU81wu76ijLZxG/TFybiB+L4BYVU/85vYICIFkGy3d
 0kVQ==
X-Gm-Message-State: ACrzQf38HY6PaX8hVQDDf4tDFjEDe3Sg6rY95K99VR+bGb1x/eNvUcZb
 4YBGOeJvE2AxL3J+aP/V0gEtMgUnVZ+5rnzFUN0=
X-Google-Smtp-Source: AMsMyM49aLFQIkSUnCL8kAdbMp8sKy0J1fSHedR9/DlNBXKuS5wsyWpmMuPNusCTvHycv6/A1QDLXQOtfhYiG2hwX/Y=
X-Received: by 2002:a9d:4592:0:b0:66c:6922:8629 with SMTP id
 x18-20020a9d4592000000b0066c69228629mr5224436ote.233.1667405305777; Wed, 02
 Nov 2022 09:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221102145811.17968-1-christian.koenig@amd.com>
In-Reply-To: <20221102145811.17968-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Nov 2022 12:08:13 -0400
Message-ID: <CADnq5_NyEfJspT=A3rRWh5+CH=9jPZFiDoTrXDa9gu+5fuR=Ng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: workaround for TLB seq race
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 2, 2022 at 10:58 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It can happen that we query the sequence value before the callback
> had a chance to run.
>
> Work around that by grabbing the fence lock and releasing it again.

workaround

> Should be replaced by hw handling soon.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..e51a46c9582b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -485,6 +485,21 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm,=
 struct seq_file *m);
>   */
>  static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>  {
> +       unsigned long flags;
> +       spinlock_t *lock;
> +
> +       /*
> +        * Work around to stop racing between the fence signaling and han=
dling

Workaround

WIth that fixed up, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>


> +        * the cb. The lock is static after initially setting it up, just=
 make
> +        * sure that the dma_fence structure isn't freed up.
> +        */
> +       rcu_read_lock();
> +       lock =3D vm->last_tlb_flush->lock;
> +       rcu_read_unlock();
> +
> +       spin_lock_irqsave(lock, flags);
> +       spin_unlock_irqrestore(lock, flags);
> +
>         return atomic64_read(&vm->tlb_seq);
>  }
>
> --
> 2.34.1
>
