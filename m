Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEB1C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 13:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B2810F4DE;
	Fri,  7 Aug 2026 13:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX/M1ssE";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB0210F4BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 13:04:51 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so485728a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 06:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786107891; cv=none;
 d=google.com; s=arc-20260327;
 b=H3WuUmZMok8W3hMFHpu46Dvi/t820wCdPFGrObsRJlQcEr2oNsW8TKzlcLmlX4CZiK
 2gIKANh1GSIMDoM6OaaIro1BrlvJpvFz6AwVN8CYLOeLC9nF+pYGYYnieUbzmpDWqQq5
 HZOrRIEmL4D83uuAQMvK5GnkU1sAmKCuS8ybQZaIifr8HCi9ZNg6I2fVaNTaR0y5pEIh
 ITAEKr0AdLoOnsOxSU8t+qsfNI/JddZKuhIgkG1jtaVFClNLXhRBUqBGGhoe7kfhJXpM
 NFjirUtHLc25860cQ+eqIVv+XtFWue2bK7tYaPPUnzuf8rgoX3RxpQ+I+EaCtRMBhQJp
 0eMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UgmBjwV6vk4C1sQQa1ekLuzHPfZEUtlLywxfPZMne40=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=dPikJ3wJentevkqB+C7nSJPQJaA45EjZA5tXa2LejFaZRWjhRxVc4MjVNwbirlccIt
 tDAjqEJSHDOf3pLCHJ/c8DPCwPjsU4FLLqJtBwfpxeDbOLlgO/MbkerBxNZMJmP0yqSF
 7JdDpBfObXT+S/9f6e9g8UzBS10h+j0iuZa1LB8SQ2/SCE4TMjTShFwld1EqRxf+3IQZ
 TgUUCFxZvudRRNpmi/YKyVgDJmlngwnUbd6XOAWPRPxyBUAZmV/Vh3IGuyU/DbbrFsWg
 rDrgD2pCJvIQ1CMKKkn3R3oGCBJ8FWVKX9uoMluMGGGScwP5WloPnH3zr+DddmbM2ymu
 UnDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786107891; x=1786712691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UgmBjwV6vk4C1sQQa1ekLuzHPfZEUtlLywxfPZMne40=;
 b=lX/M1ssEV5l92diaD5vxHJeuSpO8N/0mLhn0glL/99qbVFV7MvTGGvFdHrNMMWSvrP
 YFlFABLz6LDH6H2UExg3J+R+13czfsehMVrMfCSm1qOMuzIjMjUOJ0/w7/TmjzJhuaDP
 u6yCJ7/VMzOGZBrwS8cpAuJRHLt0dILcl1zry0If2P8NlFn+LWHUjmSCmVbiJgQQ53hC
 e3Is/Ar+78JtYPP4H+08y2KoMNo0vFV0fYPbEKcRXzcCMLGagIVWN+YK8dQg5CpTyR/F
 pqhpMe8F79VITpl4/n1cFrRPrrPQSIDGGCCs15ExlDHwh3J6pgdG0oWTKIuI9b5M5uwt
 UWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107891; x=1786712691;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UgmBjwV6vk4C1sQQa1ekLuzHPfZEUtlLywxfPZMne40=;
 b=VlLrTuQiDZebxlOGID5TrrMcqERCPnKv4+Xf3lgW5EDqlR6dQkG2BKwIqddnf6qJ50
 /NlxoP29Djzmxc7LY6zCy4UhQ3hiFrrPnkoA7tRIh4N3kcuxHj+rlcneuzUIjC3z0nNx
 gwNS5F+CiftWjZBp+Kr9R7ae2NceSDdvpTS1xg8MEaVNdm58+DOFopvEDCg29lUzFi77
 NLfv7Avrgo5Szk+RmJiG/1mmUl7lTPxetdLbn7WvIXj6ycbe6gPfb7XttmlVcD3qgsU+
 WTkAVQZdNP8kzCdeB0FT28hxjH5+8LxXSa+KjOrpiJ3r1CTVmHzk+daIfaiP8/3KWLCS
 7QCw==
X-Gm-Message-State: AOJu0Yyudim4pOYF4z+HOzD5NWRh52meFuQ+ZM/KbqOC8T09f1MNynRX
 1d9lwERWyFsrHxY2BYuL4K9FT9O+2NG/qDNusZF6DX7NKy7UQHQ79skl0GuQyULguwwT35ylIun
 YoGECOb0rWm73xObpIKLAoMxpdcF4oaU=
X-Gm-Gg: AR+sD11ydNNPPD34nPZ956nj1J+LLd23Tn5hFwqozV4Pt5hgQ5oLf5w8FIURFAQoLaq
 5epaQy8WCidZJCjxSbq3fnwFzuN3DY7XjENdRhtM/qxibiAxPtEMgLW+snvkF6Hu99kXZmJIL7m
 in3WSc9gZo/nLVxKnIvYUiIrwGEbrSr0pahn21Eb7S2as5jreWF6OBnDHCZb/jOTJtYFPesCtty
 Q+rzg4yxfaXnrEfuw6WxVyTcOvcWQQnk0UykicZwBhBVWzyMBf8mPe4J73imO+km69JuC4XStzq
 Bq33Hm7zVN/q+MYsOJS6ot80Zgeh4zWCjHjYNvdM5EPWy8rwkVB6BG/0iiD29p9aWJcrMzUCoLA
 PKNBKYyQYqinpHwHYfhf74/BLAHYaQ1s=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3903c7278f5mr16544401a91.3.1786107890475; Fri, 07 Aug 2026
 06:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260605221853.903153-1-alexander.deucher@amd.com>
 <20260605221853.903153-2-alexander.deucher@amd.com>
In-Reply-To: <20260605221853.903153-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Aug 2026 09:04:38 -0400
X-Gm-Features: AUfX_mzGiAA7-zmPCEmM1mSv5CaM9bOHbj9JK1lo3BghmwR2x1b8i6Rnt4Ti5tA
Message-ID: <CADnq5_MOVBmf5Y6mPumdjiTRx-ffJROo2vsc7QmoV6pbzijNEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: fix missing check in vm_flush()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

Alex

On Fri, Jun 5, 2026 at 6:44=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> We shouldn't return early if we need to emit spm update.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 7e0e2281719b1..13031e4b6f1d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -809,7 +809,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>                 &job->base.s_fence->scheduled =3D=3D isolation->spearhead=
;
>
>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -           !cleaner_shader_needed)
> +           !cleaner_shader_needed && !spm_update_needed)
>                 return;
>
>         amdgpu_ring_ib_begin(ring);
> --
> 2.54.0
>
