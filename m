Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DFCC77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB2710E170;
	Tue, 30 May 2023 15:04:39 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C13B10E3A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:04:35 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6af93a6166fso3480778a34.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685459073; x=1688051073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LoPTxMWCI97VPsuSsPz3Z1nL2bbH+PZurAylu0c7tk=;
 b=UdOIYEQfb4CfIxjLDF8XZdqHNdRYZrOU3zVkgAEfz4GsP91lNkyHza+Eu5pdamhxBO
 vGLaGs3hjk0eJ3TaMGnCimxg7/ICe8XhXRKKuIiseVMp6xe4lZCOhtrOtRIX3NZ3vEDc
 WUrlYK/zEV+5FVkMI87a1Ok/C2f6aJELkQazvDbUKvcjyu+Ug/cSdQKVtBolqXUoIdPb
 q9Z5UJuNMgPIonQTDNmuUw82TZQlgKlwXPPKKPL9olfKkIYDHkV7rac4UhTHKVi4QCrp
 letciOXJdiFkaeaw4csWQJgr8cTRTpQnE8EGEyXHP+3pl5OLNnjL6LtmdL76pgAc0BAz
 1shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459073; x=1688051073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LoPTxMWCI97VPsuSsPz3Z1nL2bbH+PZurAylu0c7tk=;
 b=BxU+QWJHxyvrtBhm0dlmDqu7DcvSfbBzON33y55Nh/HX2WHHqH/Ex5k0MHHHX3xVfJ
 x2frKcahRoXqtIhQ3o6NMdA8UbRrW/erQ4xvb7bblkwxCvDZYwfD6GJWdu9BvpM5bl+7
 V/hj0W9CDvAUvD6VDAJN5AxdAKR6Q4kgGtHCWvtMXRLjCyCCyFF5p8x3pNxilNZ+OCtL
 PIzY6M2ytlEHJcpjyeVp9Zjbna2BGfvpElZhMpSoHSxAsMGQIN4+olbRues61Jo8tQyy
 VbVo+IxbwSLOqJXLpayYv+U1roXkw0006rxPQxBUC088fqLLf7P/tKT6/xP/ZJU+NwZC
 OzRw==
X-Gm-Message-State: AC+VfDw3xbtURKclYUyMG9z+CKwc3/9/nwXiVPZiHFeRedZ8BOCTmJyq
 nxdhAuu/ieHjUPGrirH4H5EBQcVxzTPIAVRN7/M=
X-Google-Smtp-Source: ACHHUZ54QjzEw7inlSTYqrZ/wMcne1eNJeH/fprolETZAW28jEbXTkQbj6DycPQArNmidTPOIagnEudIfKK4F75oQ1U=
X-Received: by 2002:a9d:644a:0:b0:6af:91d3:dd41 with SMTP id
 m10-20020a9d644a000000b006af91d3dd41mr1136903otl.27.1685459073411; Tue, 30
 May 2023 08:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230530095218.418845-1-bob.zhou@amd.com>
In-Reply-To: <20230530095218.418845-1-bob.zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 11:04:22 -0400
Message-ID: <CADnq5_OTmn+f129C28MPCXr6FiiJQ4VUZ695zJNS6j+237VqNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdxcp: fix Makefile to build amdxcp module
To: Bob Zhou <bob.zhou@amd.com>
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
Cc: flora.cui@amd.com, guchun.chen@amd.com, amd-gfx@lists.freedesktop.org,
 asher.song@amd.com, jun.ma2@amd.com, yuliang.shi@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 30, 2023 at 5:52=E2=80=AFAM Bob Zhou <bob.zhou@amd.com> wrote:
>
> After drm conduct amdgpu Makefile, amdgpu.ko has been created
> and "amdgpu-y +=3D" in amdxcp Makefile isn't used.
> So modify amdgpu-y to amdxcp-y and build amdxcp module.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdxcp/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdxcp/Makefile b/drivers/gpu/drm/amd/am=
dxcp/Makefile
> index 5e1bd70748d4..870501a4bb8c 100644
> --- a/drivers/gpu/drm/amd/amdxcp/Makefile
> +++ b/drivers/gpu/drm/amd/amdxcp/Makefile
> @@ -20,6 +20,6 @@
>  # OTHER DEALINGS IN THE SOFTWARE.
>  #
>
> -amdgpu-y :=3D amdgpu_xcp_drv.o
> +amdxcp-y :=3D amdgpu_xcp_drv.o
>
> -obj-$(CONFIG_DRM_AMDGPU) +=3D amdgpu_xcp_drv.o
> +obj-$(CONFIG_DRM_AMDGPU) +=3D amdxcp.o
> --
> 2.34.1
>
