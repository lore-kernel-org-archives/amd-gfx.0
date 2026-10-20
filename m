Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A840606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=niU0G+r1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023D610E3DA;
	Tue, 20 Oct 2026 16:27:01 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E5810E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:26:55 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-363cd582f45so179982eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 09:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513615; cv=none;
 d=google.com; s=arc-20260327;
 b=H++aDwpGk11+Zdlyi1wSIUSO1mXbSqRLPNqX7aERm5r4PVMXhvOYR9QzQ5Lt+S5JwR
 g496YpfZcfTLZbPYnDqkK2s2FUdt1KtfaRP696wOCOjUGq2+hB3/7hTQ5xE77TGKY6Jc
 qYmtrTMBrCW2vk5Q4B66Bnsk8E+p6Ks/IVAv8e1Axen3Xg58Dt9tiCqW1GwKOGzyUH/I
 wqB5UfL6mJ2Eo6oTKTgB28AYR0zcNwezYWC2+kV0fw3boY4JM9nvDhH9gx/jeKQtkpzw
 sNY7XWuwulUYGPr9RZxFS9mrnvcCQ7VsRaTBdqfIvALKZaATrS7JVaa7pgbKQV0QfuaT
 j/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
 fh=DcWh9Tt7swQ/3Gkr9KHS2DL3gYfJsMZ76YUiqFfvBV8=;
 b=pNF/vNbah8XQvUf8FcsCN8An+E1KgCijNMZbRK9nuwfNIyAh43ApdYmunH9Ya9sSUj
 6UUqI6OO+lbpd8/2PCCSdHviHjykywGI/5W5Glu8NhiGB+xv4xQMZSiXYgWSk9QWECY5
 TGWlGdVuO9bEqcNEq3P10OZDzQSWkPsltMV3jSFajlT+V/ze0lRHdvqR5cNcBYeXS7kI
 j6B9PqE1EYCore1DmlMVjYtQDig3/mVjMrVFIva7qRfGpsbZ/qqUYg08eApifuQpkB2j
 uBtqELXNknkmtNQ2spjQ9lRNlILj/GRs4qbsLsbHW2OHdfMuIyOLUtNHAUrXHqPnDiNf
 nvFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792513615; x=1793118415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
 b=niU0G+r1fgLPtm6sWvVOqhGVmBvCGU9gRSKvjdCpV4M5vksPExVTwIfW1vY1oohWDd
 5sTgdVgYUdMmEQeytDO42ZzbkA86ORPcjaFgl5x1yhGYiB2LE0eW+hgJRi3a2QZV5Shq
 1rcmNezuTGV7MM2cdLRJBhbn9Zq+HthIChzJV0XYSzQUmbnt9+aTourJ/Lg/hCDrW1zS
 P4hV+SMcOA+ntsCFEKf4z5yQh1ySWGSgFxO2NIBRtXvG6VGgGEP1OFDzO0ycXon/MPpQ
 SXCJfQ29bJvRHwDJDa18NvcQOa4oQ2/zIOLhkKS8f3e7k55iERva5sLazNAEDNUP2f+H
 HhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513615; x=1793118415;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qOESWozW3cJc2E6iGkcUb3B9JJiCfcQEn0fPW36B1sc=;
 b=Ui1Mt670UCzzb5GlQXlEVA5iuknsRAUkMI2pgNgzHv/l2nqJhImRCTgJRhVNI/fKvp
 hOxT96WZH1qwi4J0f2cBTIBIbpOPlfePuSTk5s9eJONjMy4gbsU/5dJ+V1Tv9GLozRpj
 HupMQC7xmfNauBSTw/4VDJrt6qWOMBS9569D4mLv1EQf0wQmu+nVzDzcW/nDwRlbXmci
 4Y388LZ832go72iP/UheXg7Ta5fCgg0pMcexIrwGzN9HJzZkpshkEBLnys01iF501W83
 kprUHFuaf5RWCmZwhZTpXrfuMpGcZNPLp2nlG7WxwwLA3DONtpXp1TQCxJbSsw18RpcF
 9kiA==
X-Gm-Message-State: AFq9FYK8TOdeWmyldFlKbTUmQzuJYsIKanQzrniYrOvoFOlRwKAyZJQs
 A9TUFq7jvCbqhvgT9FmLyoKq98v84lpJVPwob8jFSR1+d5ZAelbTaPAbgA1VVNasMOznFqFGKnB
 18f139x+IxabmMJDnwwSEtMCLNVxyerM=
X-Gm-Gg: AYBFou1WcD6fEQg4osrBjaG1u5NEsVGrofXhgDfpXDOkxL+AgT4GVKnGLt5Y4G9JCfl
 3UDbIsDQQeQLnno7dna2kRQ8wZPypXRPS0t8QdT5L28pg8NJ1jwjCEIP209IBnyUw982AINeT29
 5GS1HHkLqlltp3MAJHOxZVGPV0mBIZTLoDtBAiKvBBCrO0jBk1bpOlFPuS0Fk9/MJAEuc5Tz+gF
 2+DLE+yh6QYzJuM+BRq+/hu0qKiMprW/X+DqdiSPO09ujtv/3+hR8ZP1C+yck1tLzqoM+vt0e4b
 MADq9eUDHEeRQ31FTUD1Kb7DNdB6yxuh2F3c0CG6NGgw5COajgOpWEypmBOsELG/2cUGCutN/eb
 H1WUKQkaXFnDYTFhZAKQK5/pSDTFbY9Zm/TgYm8GvioSljX+2MdGi
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-18507ce1c04mr24731580c88.0.1792513614444; Tue, 20 Oct 2026
 09:26:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019153942.4067-1-leo.liu@amd.com>
 <20261020152701.18355-1-leo.liu@amd.com>
In-Reply-To: <20261020152701.18355-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 12:26:42 -0400
X-Gm-Features: AclHuK8Cp_D7QapbPE0L8K1pGGV7MXeckR-FGl5_FE_xGeWy-d5hcCGBTW_amtI
Message-ID: <CADnq5_O3Bst-E_BUH_JYiQH4m-G8HzNxK8zd=sUdnhywROv7ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cancel idle work in hw_init failure paths for
 vcn/uvd/vce/jpeg
To: Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "Liu, Leo" <Leo.Liu+amdeng@amd.com>, 
 stable@vger.kernel.org
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 12:06=E2=80=AFPM Leo Liu <leo.liu@amd.com> wrote:
>
> From: "Liu, Leo" <Leo.Liu+amdeng@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
> because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
> and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
> idle work queued during the partial hw_init() is therefore left pending
> after sw_fini() frees the adev state the handler touches.
>
> Cancel the idle work in each hw_init() error path, immediately before
> returning the error, so that hw_fini() remains the sole cancel site on
> the normal teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync=
 call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 11 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  9 ++++++++-
>  29 files changed, 166 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..c88cedfd4aa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -163,7 +163,11 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       int r =3D amdgpu_ring_test_helper(ring);

Don't mix declarations and code.  Some compilers will complain.

> +
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v3_0.c
> index 564e40899df2..0e4dee12db11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -178,7 +178,11 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                 (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>
> -       return amdgpu_ring_test_helper(ring);
> +       int r =3D amdgpu_ring_test_helper(ring);
> +
> +       if (r)
> +               cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                         VCN_JPEG_DB_CTRL_=
_EN_MASK);
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 ring =3D adev->jpeg.inst[i].ring_dec;
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                                                     VCN_JPEG_DB_CTRL__EN_=
MASK);
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         amdgpu_ring_commit(ring);
>
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD initialized successfully=
.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>         }
>
>  done:
> -       if (!r) {
> +       if (r) {
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       } else {
>                 if (uvd_v6_0_enc_support(adev))
>                         drm_info(adev_to_drm(adev), "UVD and UVD ENC init=
ialized successfully.\n");
>                 else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>                 }
>         }
>  done:
> -       if (!r)
> +       if (r)
> +               cancel_delayed_work_sync(&adev->uvd.idle_work);
> +       else
>                 drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized =
successfully.\n");
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         dev_info(adev->dev, "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         for (i =3D 0; i < adev->vce.num_rings; i++) {
>                 r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vce.idle_work);
> +       return r;
>  }
>
>  static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error_vcn;
>
>         for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error_vcn;
>         }
>
>         ring =3D adev->jpeg.inst->ring_dec;
>         r =3D amdgpu_ring_test_helper(ring);
> +       if (r)
> +               goto error_both;
> +       return 0;
>
> +error_both:
> +       cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +       cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *i=
p_block)
>
>         r =3D amdgpu_ring_test_helper(ring);
>         if (r)
> -               return r;
> +               goto error;
>
>         //Disable vcn decode for sriov
>         if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>                 ring =3D &adev->vcn.inst->ring_enc[i];
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..be198680334b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,25 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings=
; ++i) {
>                                 ring =3D &adev->vcn.inst[j].ring_enc[i];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return r;
> +
> +error:
> +       for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
> +               if (!(adev->vcn.harvest_config & (1 << j)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[j].idle_=
work);

Do you need to remember how far you got when you do the unwinding?  If
the ring test failed on the first instance, will cancelling the work
on any of the other instances cause a problem?

Alex

> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..a532fe72ed75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,25 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>
>                         for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; ++j) {
>                                 ring =3D &adev->vcn.inst[i].ring_enc[j];
>                                 r =3D amdgpu_ring_test_helper(ring);
>                                 if (r)
> -                                       return r;
> +                                       goto error;
>                         }
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8345c45ec5df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,18 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..a2d5b9901fef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,18 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return r;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..86d766f0c61e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,17 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..a4d0de29fd26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,17 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                 r =3D amdgpu_ring_test_helper(ring);
>                 if (r)
> -                       return r;
> +                       goto error;
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..e64ca2bb05e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,18 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ebf98878c2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,18 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>                         r =3D amdgpu_ring_test_helper(ring);
>                         if (r)
> -                               return r;
> +                               goto error;
>                 }
>         }
>
>         return 0;
> +
> +error:
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               if (!(adev->vcn.harvest_config & (1 << i)))
> +                       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_=
work);
> +       }
> +       return r;
>  }
>
>  /**
> --
> 2.43.0
>
