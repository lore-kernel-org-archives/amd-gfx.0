Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF30606A32D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B/s+LKbd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCC010E4AC;
	Fri,  6 Nov 2026 21:02:49 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B761F10E4AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 21:02:42 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36e895f329cso58501eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 13:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793998962; cv=none;
 d=google.com; s=arc-20260327;
 b=KobeavkKwa/8xkRMiu/q/Smq5byWTAH0F7Ut0U7Yd6H0CEbCo0gaMIRFzQg/v10o64
 p3/w/1ZNSIFmGAQaT7YSpzu5CD4OeVWImoPWantHA24diXd29y5Q4PrS+LnOxwVTCg/w
 +qNa2+SliCIquyeN8N7XOtia94UhQvf2qk/Eyirizm2K+vwdcwmzHc42Kt3FQ5L0zBdN
 58YHjMCFCNQ0SgnCtlQg563vflb8Gja56+kbzfq454BaIWR2uGULOimhLM73PHBWDOPM
 V52uD3lW3OmgJJzeFGajH6dVVKJtbgNd5BsRbuxMHns+7z36CwzW/mgQ/wFrMDmsKM41
 a3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xOPac7tGNUTnziYZFWrls4dnykH2KAlbPBiQtMK7+Zc=;
 fh=KHqT9ZOJ7FuoJsCwcnglru5vZtJXKWm+hLyUAXWWvBA=;
 b=mNMIhuAA92Zts/QIMd5KN4NQTjxNfcaEIRqsO7qBdMd/QZj57I7AoxI1Bycs+MpMtN
 6BiHvUVj+0NU6MADNRlIdH2xiKYGX2mBL/H41Jq7H74DGzSpZcpiYDw5ml7jAlQ0lSXC
 dEuu9zDzu+iwRWDu0zWljAonioXrEL6WBe/jTJgnRuWYfa6w3g4C3cumrbkvdbPGQB8k
 ET/YtvJfJxx+sydEfgaSxJ21TI1+IkEABTcFLlEDKnZ4ZXFjPm0XRsDjBAO0IIZETT9j
 N9WUW5ufvSrt/nwIoKUHI8aryAlBJ8A0fooN/0OrDr3lk2QdIDtaqHOBNTAmV4TN7e72
 626A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793998962; x=1794603762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xOPac7tGNUTnziYZFWrls4dnykH2KAlbPBiQtMK7+Zc=;
 b=B/s+LKbdyBI1BY5WupQQ+Hpu+I9RB5/nI79CTHm6x2Qy8r7QtS0SOl5kMhgtkbbFlX
 +tHGKLn1QJRODtNVKa1ykbpSSGa7/DxIj3ck1JFdAoj1L1kNvRKbQpBSMpwUaTwvwrzY
 nB8x98+9hqt1H3r33JMGH0YEJgEhfmbYz9RL6vsdNVLQTVIjgAjLTwsAJFCQ0OJN1WnJ
 tmlj32wgBfbMEf3ysxkaL3ULdZ8VYWqOAITxPOS5aV1D3lQvVG3CtrzHXphUxEa2qfo/
 DDKQQRwl83OsuJThQLjRoeGVZXiisVhGjnk/sZS1frhTxwtUk4jOBEpeHOkuXqFNGKod
 AH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793998962; x=1794603762;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xOPac7tGNUTnziYZFWrls4dnykH2KAlbPBiQtMK7+Zc=;
 b=MaF2jkFNp3GuEUS9BR9u1eZinI0102wJNGulu57lzp32FJfS2DuC8KbF+I6fA6P6YU
 djssJEZb6LzpbeHX6rKJaZZlgw7xYZtJwaZ1mAHreShJRy1cOTwUUJqaLeQiP4TOv5LH
 f9DRJb+cGYZWSQ+l+VmZNp1IMkJgho0iloiNw0ggm/8Rj5AvzBJsbwGHRSqllUpMiU3M
 GYyw0uuUFExcYX0sWT+s6mWZuCotPou0XBim9dsIJKVfMJfZaIdvsMfjPKKHhAAZOWN7
 2JG/ipFDq0gF7pYlhJq+ZhSBK0niCg/C57Jy6TmSEGKZohu6FuuojRET8GqN5vNf8w4J
 573g==
X-Gm-Message-State: APuU4Z89RFatZTH/A/1p7J4klByY6jE87V64jXoitcOmgmRgqrefvGFp
 gNFnj0QAMqxPD3GjJH15FaiOLRYTO/WaupS7VUZkdONyGLq8qJTS37CxjGmqWLeAoEpNOe4TSHk
 +BSalDAyiUau+ay5G+3lKVss8oIjT6yk=
X-Gm-Gg: AYBFou0tZoMcc8hBHua6FZE8b7LB1EUJxuiqqyGBDni+6id0WFwcBZ6Sa8J0Ey71ROm
 iqJcM3R9rlCjTm+QgyLGIi2BPW7d8wPIR682nswjzOuf9ROECnLzkGkCBmAvBoY2gP+7i/qRxFy
 0N/PQtKXUPEWDjuqVktOhyMNn3lCw0iRQVtmwRV7ESGL+btSlGXagEXyvuinDfoQPTaX3dq8ON5
 kv9kmH4sd4in3K3uG0O60uykWE7GaqUUeQG2Tl4kWsoA83usv3tHTwztPtlcxY1YllZvxaSmJTU
 Teh1Vvd1pwSGbpas68V/fJcORuiIVXFlQI7gINFt7MRNMDmrNo/FctVgMdy7IzRy94IPf9yQNfg
 eNWLWVKgkQxpYffSdZos7qQvLc/hDosrqgsQ0hkJuOlDn1n4QVW6ewFVz6ubEV898F0BlMXL8pi
 kW95aZta1JZg2Ot1QV9r0GcDE=
X-Received: by 2002:a05:7022:5f1b:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1b25d3042c1mr5986878c88.2.1793998961611; Fri, 06 Nov 2026
 13:02:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105000441.3850131-1-alexander.deucher@amd.com>
In-Reply-To: <20261105000441.3850131-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Nov 2026 16:02:27 -0500
X-Gm-Features: AclHuK_WomKLNLEno6dckFui_YNkyalt7LR6xtbzNiWxsX27e9ta8EZx-X5g6NA
Message-ID: <CADnq5_P1Fq=mUpe4UMPDWZDSE5BfhrDtVKmR+XuOp6E0DWnzKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: add spirom dump support for asp 15.0.3
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, frank.min@amd.com, Hawking.Zhang@amd.com, 
 Kevin Wang <kevin.wang@amd.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping on the series?

On Wed, Nov 4, 2026 at 7:21=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Kevin Wang <kevin.wang@amd.com>
>
> Add the PSP callback to dump the SPI ROM image on ASP 15.0.3.
>
> Signed-off-by: Kevin Wang <kevin.wang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c | 38 +++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/psp_v15_0_3.c
> index 029d4f4b09616..b5202aee40354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> @@ -602,7 +602,8 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_contex=
t *psp, int cmd)
>         /* Ring the doorbell */
>         WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_73, 1);
>
> -       if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> +       if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> +           cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>                 ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(=
MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
>                                                  MBOX_READY_FLAG, MBOX_RE=
ADY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>         else
> @@ -610,9 +611,6 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_contex=
t *psp, int cmd)
>                         psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPAS=
P_C2PMSG_115),
>                         MBOX_READY_FLAG, MBOX_READY_MASK, 0);
>
> -       ret =3D psp_wait_for(psp,
> -                          SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_=
C2PMSG_115),
> -                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
>         if (ret) {
>                 dev_err(adev->dev, "SPI cmd %x timed out, ret =3D %d", cm=
d, ret);
>                 return ret;
> @@ -628,6 +626,37 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_conte=
xt *psp, int cmd)
>         return 0;
>  }
>
> +static int psp_v15_0_3_dump_spirom(struct psp_context *psp,
> +                                  uint64_t fw_pri_mc_addr)
> +{
> +       struct amdgpu_device *adev =3D psp->adev;
> +       int ret;
> +
> +       /* Confirm PSP is ready to start */
> +       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0=
_MPASP_C2PMSG_115),
> +                          MBOX_READY_FLAG, MBOX_READY_MASK, 0);
> +       if (ret) {
> +               dev_err(adev->dev, "PSP Not ready to start processing, re=
t =3D %d", ret);
> +               return ret;
> +       }
> +
> +       WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, lower_32_bi=
ts(fw_pri_mc_addr));
> +
> +       ret =3D psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAG=
E_ADDR_LO);
> +       if (ret)
> +               return ret;
> +
> +       WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, upper_32_bi=
ts(fw_pri_mc_addr));
> +
> +       ret =3D psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAG=
E_ADDR_HI);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IM=
AGE);
> +
> +       return ret;
> +}
> +
>  static int psp_v15_0_3_update_spirom(struct psp_context *psp,
>                                    uint64_t fw_pri_mc_addr)
>  {
> @@ -826,6 +855,7 @@ static const struct psp_funcs psp_v15_0_3_funcs =3D {
>         .load_usbc_pd_fw =3D psp_v15_0_3_load_usbc_pd_fw,
>         .read_usbc_pd_fw =3D psp_v15_0_3_read_usbc_pd_fw,
>         .update_spirom =3D psp_v15_0_3_update_spirom,
> +       .dump_spirom =3D psp_v15_0_3_dump_spirom,
>         .vbflash_stat =3D psp_v15_0_3_vbflash_status,
>         .get_fw_type =3D psp_v15_0_3_get_fw_type,
>  };
> --
> 2.56.0
>
