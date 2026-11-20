Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB58606A6E7
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f/hhfWbY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33ECF112AAC;
	Fri, 20 Nov 2026 19:28:20 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6E1112AAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 19:28:13 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-843ed9d1683so158295a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 11:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795202893; cv=none;
 d=google.com; s=arc-20260327;
 b=nk5v/t0Cg692VdetcXNMLxn8ffphF7Mw4+putN21yKY+NUXSXMUTsUfJY2U5iPd34x
 SJCxY2+4YirLknz0XsqR2mYYBJWira5mWOCIF/ujgNqN6h/+Tc5htWEMLpzyPh0EgeP4
 xSusj0heseBDX51IYnj6B2TOp2zE593vxT/ROa23WfjTkn4R5zNbRLE9HlcnxVNfLkra
 BbgeE9auuLMAFtJOh0uykRqFQvLxwL0zOEwFlzDBpbJ1AKrzv0BQbTVUbd8SY//XN4Vg
 XHwM9mT+XHifScgfkxpTOuuZd8vpXr2gzQXGlMrgyHe3ytYwG28b1mCI9VDUk+HmlOOc
 eYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Akomdmovs3xcZWSfU+DS/jMpvbStaxWbqZKSUB0yepg=;
 fh=ktYtEnv9QQ3qigxiZuB/kpt/ezdFuKenXcgZsx4cp7M=;
 b=F85xH48tsKXiSleQs4Udo8oeGpgD62YVqFoJhw67QHBUh605ELxASZ2IIsxOXdJqWj
 ydF56uIJkFpnquLSM3FqDy37wI2GQbUn08FQwmGaO36NCSZxrcBpDu8I6XQJweSERNjp
 sKVFzYeo82xOe3T++/CJAlL13lkxqxZg+OFtirwc4cKlmeoRO0yf8ANPK0pnU8FbU1YH
 DANFXYgr4yFxeY45MUwlUQXflN6riyKyfzZN6UrXbG3zvbV2OOclSOansQLPJ9XmUaK1
 Ye9r6Dt/ILJQn3CdFkv9cYnoT2R5lRK0XV1GI2/xPqh3RuTJ351uGxG+pK1HTAYApFQk
 kmmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795202893; x=1795807693; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Akomdmovs3xcZWSfU+DS/jMpvbStaxWbqZKSUB0yepg=;
 b=f/hhfWbYFf3RsIjmy66enFoZdV741zI+NEUZ5K9k3XtQA9CQZ/IEF8s7SiRarJzNpO
 j+mm+H3ROefMOXeAp8/57I+yxHVLxLWC7mo6oFBrmxtAzGbOpc+mp+QhPaSqdNC7sZRz
 2b749nUvv+UoIEr5RaOs4nOPG+59PMM1gPraZWILqQnMEzYeqQhShuW1FNXUTlHgGvJx
 QQIY4QwqVCjhN7Qu9TIfZ193JAl9EK37OEXh7puL12zI+X156wSjegCFwOwL12HGjuJu
 4b7P74QXGL2t6dR1yf5jlscCcLvXsDpxkae/3arKmb6TN9ZWf6sxWRY1RwSxB69wX/1z
 lYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202893; x=1795807693;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Akomdmovs3xcZWSfU+DS/jMpvbStaxWbqZKSUB0yepg=;
 b=yws93Mu6xbeqj5geuR3ON9dXAhup8N8PLGQrnZO5BW5uzSvalARhv3fmC66uB2+4Xb
 Q6qV2rS8lPnfhu2UvsBQuWeYzSjNlBZea1ZwIQjDcxlzSPrj42vI4GxjVGq8EnkDGoUX
 YjkTR9GjbESa10PG824eRzNuVJdQK8ad2G9wBxxFo4a/cIPVrjZxv90o6Wnvb2GmTLlI
 MvTCvtFBqTjRSJc246KxS2sRre+TqXXmXirfJzOJW6d4JUmCq7CYFbAY6aOtx4rhArFv
 2+5t1xcKNl6fTuu4NhZWI+UbW6dQqYihAKCix4/682NnikPbMi6otY79P/EMuuII4mew
 HhPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFWSZ2i592zLyTxR0jZcC6XNOizerYBHA6MbEPvsPjwt9pVhD480N5U29fGoFQ0siwGOCp928Vw@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9sGDFdKAOtl/2imZaQVZRUIB6lrXX4mtt74HTf0ROBnj4Kyz2E
 Q8l8uMc0JdQ4VN9qsf2o1rgHw+JLMI5jre6vkUpUKXU4nlu+PFqeBS8hJWSNCZeDeiWS7OBbKr4
 iJAhZ2DmWDfByrpE/Cvtfdy5q+jEyPWwLpQ==
X-Gm-Gg: AYBFou1jFlRd/P1OldxExK4vYTqtJUIczQ+C5k/0T3z2O6kIXL0oPwXGtCwxuOoM7Py
 zP7KM4DPlnBaOvnp3EXop+gKhHXQudcZhgn9VxSLx+TG4FcTYFtXXlJQlN7v6wq0I1TkVPXJvgV
 rbgGJpGtXAJBnbz1vrgBfQLdQbG8clC+ehZQ+WiVNkYKNf5D7WgrILlwK/TYW1jJ/LXaU5yN011
 BWWXKAYTXPlOEp0Fbs4KZFVQgcpVZXxh2+dyIEHSvng5zXZJkan3APuZNGM1kLGaHQG6gb7RM0H
 xVmjOFgWFMAm0oCelm4/+CN/TfSK2jHLqCUaMvhmJvOrHrTLzt0zPPdCkj/A93Sj3wJwawXQQLK
 8GwU/RwJaU2DOFrNNyglxNF4FJfJa4slVQDdAKnxVWsauyyIzdjz1Iew/bZCwI/NEybcQi3es2w
 3BX8oR8iTYNicAzjYcRHr/EjlOzecC50FKPRl6gOEhL6D5re5KMnATJ7GsJ3w=
X-Received: by 2002:a05:6808:c123:b0:53a:5069:cdef with SMTP id
 5614622812f47-57a09b0c52emr7022818b6e.4.1795202892978; Fri, 20 Nov 2026
 11:28:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
 <20261118223712.2518580-9-alexander.deucher@amd.com>
 <IA1PR12MB7493735875C5F18F03D1A87BFF782@IA1PR12MB7493.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB7493735875C5F18F03D1A87BFF782@IA1PR12MB7493.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Nov 2026 14:28:01 -0500
X-Gm-Features: Aa3M54p0xey0WZkoM80vTn_WEvlwV_LR42zEDcoxZUYsblPSMNDjpAohPotArlw
Message-ID: <CADnq5_Nhsk0TyC8AhAz0dauGL9UsumaSc9RegstbeA4+e5py9g@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 12:21=E2=80=AFAM Mohan Marimuthu, Yogesh
<Yogesh.Mohanmarimuthu@amd.com> wrote:
>
> AMD General
>
> MES firmware names the ganged queues as slave and master. Mesa radv calls=
 it as follower and leader.
>
> Can the primary/secondary naming please be changed into and existing name=
 slave/master.

I went with primary and secondary because some people find
master/slave objectionable.  There was an effort in the kernel a few
years ago to remove the usage of those terms.  If you feel strongly, I
can change them to align with mesa.

Alex

>
> Thank you,
> Yogesh
>
> ________________________________
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Thursday, November 19, 2026 4:07 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mohan Marimuthu, Yoge=
sh <Yogesh.Mohanmarimuthu@amd.com>
> Subject: [PATCH 09/11] drm/amdgpu: add UAPI to create user queue gangs
>
> Queues in a gang will schedule together.
>
> Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 86d42a5d683c0..bfb982f1d1757 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE  1
>  #define AMDGPU_USERQ_OP_FREE    2
> +#define AMDGPU_USERQ_OP_CREATE_GANG    3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -422,6 +423,15 @@ struct drm_amdgpu_userq_in {
>          __u64 mqd_size;
>  };
>
> +struct drm_amdgpu_userq_in_create_gang {
> +       /** AMDGPU_USERQ_OP_* */
> +       __u32   op;
> +       __u32   pad;
> +       /** Queue ids passed for operation USERQ_OP_CREATE_GANG */
> +       __u32   primary_queue_id;
> +       __u32   secondary_queue_id;
> +};
> +
>  /* The structure to carry output of userqueue ops */
>  struct drm_amdgpu_userq_out {
>          /**
> @@ -435,6 +445,7 @@ struct drm_amdgpu_userq_out {
>
>  union drm_amdgpu_userq {
>          struct drm_amdgpu_userq_in in;
> +       struct drm_amdgpu_userq_in_create_gang in_cg;
>          struct drm_amdgpu_userq_out out;
>  };
>
> --
> 2.56.1
>
