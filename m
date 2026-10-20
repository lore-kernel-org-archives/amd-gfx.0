Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3792E606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RiLKq6Eb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4D710E090;
	Tue, 20 Oct 2026 13:08:38 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6549810E090
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:08:32 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-34c522572bfso329930eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 06:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501712; cv=none;
 d=google.com; s=arc-20260327;
 b=d/rZgM8FxYHVbrTLCKDdaZ5RRzBi7WghfHPh5cPKIw6RMgen6wXElLIn6eLeMqbDqB
 DDwH7ZljUvpECVUDKpNRGOdvtYQqKVWOxZi26JvzcR86mXrC8dmcRpNAYzIhbnGxjMY6
 +Sh70zADAL9BEtfw7GF49DrHftHWUOEXv0QqnH8JajS7+gABFLM3PZXRcCGsQrwGXgMd
 P06nDmg6KkDC5VseoNsizRTCuAjeg4DT/6l1jPteaNesCwGhRFwM1wL4+VSSz2r2ojRd
 MNxD7cDOIdWz7LbIj1ZCLwPG83RNOETQjUAbt1CFEXtm6eoVD1h76CKsKpP0nTjlFlbh
 bW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 fh=YjSsB3SmzXfES/XZ5fgEKGB68OjPRqSRq/v2ERDWsqE=;
 b=ZgvLItIKnBUSz+l/8X2um4gRbbiNnpRQcbQLzANPN/6e0mCUdZqZgA/wzY1acOQXd0
 yv7L45oeeGrg7HYQOEAcASMVcZ8JV/eAZleKUZlK/tY3p4bSsestAvkxnWCOrJWSLbEB
 7j0gwPKgrGiYlKZHmjcjLv/hky9EzioNGmfQEjDbgo8/W32nXtXf3v/Z3V4MRmaQgnCP
 hjbe68+QTrDXPUnmPIbnSNdu7dMUQfHsUr1cNW+xI+xkvqGPAFVhp2HFAIdveibq/R3/
 y7MNFZDh3HDC73jyh9RreAecg1z0Byir0sK2T8LIME/8GhOCqFezxGVhzJplntnzv9S4
 TXiw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792501712; x=1793106512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 b=RiLKq6EbAGm8aOmpDg7BNTXlV2KH7Pzm+s39neMZ7Sh9er5ADM80FoZh1pwFknugUM
 By6NbU1UN+C45QHPs+Cy8ryznE3iFVYIpUXBGi0ENqUC4/k1qJKHHczU8Q7PEu+1PCtd
 RzhPzXqZc2RmXtzOg0RG4GsZkMskr7a2eVh13OS/gD/mygLjlTweThDvqqxguuwSLXN9
 GbbGWSFO29Bg/qhtAUsu8pF2X61FswgU5998WxzyUndN0AV06qHEWzgMqO/A7IDVJTPb
 RBdvl2t5ceAUord3Pkxn9Ixnbf5SyUktD14qa5Qdk2bmr1dWs/f0OJAOOx89e6dP05Ce
 A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501712; x=1793106512;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQPT2RK/Bsa2DXu0Idtw0TN37aSAQhniynYTnVnEFQ4=;
 b=rqeZTDiqUfqInlxPMa9dTtdgsu4zdelhYFzZbDEvEZM6+uTJAGmqFk5JFFDhi1Qm2L
 reihJ93POWL15a277IhiiNA/m1XrTa/JiSSr29yQrX+AouGozS+DovPFAjje+nAsGKu7
 NZMtoZbT/PphEg/FyDzWvRmYtSjp7v6xHziDFE6GIWXRCdT8MfXmJh5dVgH7CRRDXWvY
 7/xzyDdS1RZ54mr/nPXBaylm3M63lsf7lqU0Fw5ZYDNTFJrJeqfH7eyPr/2NiEkpdvgs
 VXODTXeCeKTYitjBK8VAm2IbwFczzp+TwEcXHRp0DwsPJH44FKh3oNK4plXj7sQvfjHa
 LCwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+T3SYY9OLBnyQHbGFxq6E4tIO0pC1xGnHAg4qcO8fuJGhFPac48aXc+qMSIzCx7z6FtmpgIAd@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIh0I5GR+6ev1yGekVUcyFTbz+15nLChHNKyIQgmbYOR+x+WZle
 WBvognepn65+nGNaVCQZNOhpQIvHx7pUpKLl/sneJY869LiHE4uwTWL6TEeorLyc9G3ELNeYAKW
 QWtKDacRkUrmhwcijVE+LwoQlHqbFjIk=
X-Gm-Gg: AYBFou2KjPwJoPLA0ryIRcOfqjJGGWKa3o7IWJncEsmxsZ61BTXyUdKGNGSwsImZENO
 vnMqboz00jhnpmHZu9Sp0PlaZYi3ZIE63CH5AT8YOutcBdTF2IPgJLx8kzOvZGfv1UG5yUFM/9o
 BKE+Oy2rkHSWvgNo+sNXkgya4xhYTpRvK4zIEuu8/a6OgPgvlCalhYxZ24ti+D4/mddz2tNkAEF
 UywalwWAql01Xnk/kGXCmOZTAZ8a6TGzHGIx4GBPkBzmJxybDdckDqre8xD+jxn6itFiyDoAX0M
 JyWRx/eL7x5pLdEwkTk2/L+yxBn5F/ZniNI4/oCy/iQqlcuDnLdif6lC+SGA2RtroIMTXVNXcaT
 U4l1E++iQRVOOVbyDXzsHKqhdGtLzebxLzGAiJXScBFQil12fWMU8wTQfw6iQq/ojNQh35hKIxI
 MV0tPl2ILf7b4SZiJW7XN6+3E=
X-Received: by 2002:a05:7022:170a:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-185106a1606mr23666645c88.2.1792501711533; Tue, 20 Oct 2026
 06:08:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017130047.42080-1-emmaonana18@gmail.com>
 <20261019163538.28793-1-emmaonana18@gmail.com>
In-Reply-To: <20261019163538.28793-1-emmaonana18@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 09:08:19 -0400
X-Gm-Features: AclHuK8lOvRZuawupQHM8p5lVPKffeC8_Y4DUib8gb6AoG1RAy7GmZeIuewnb-8
Message-ID: <CADnq5_OP+ogqr8JHRNvqE7suYLjmyogWPXiejZJrSUv7KS2DZQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/display: remove unused cgs register accessor
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, paulmck@kernel.org, rostedt@goodmis.org, ast@kernel.org, 
 peterz@infradead.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org, 
 Arnaud Bonnet <abo@medichon.fr>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Tue, Oct 20, 2026 at 3:37=E2=80=AFAM Omokefe Emmanuel Onanaroghene
<emmaonana18@gmail.com> wrote:
>
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, e.g.:
>
>   drivers/gpu/drm/amd/include/cgs_common.h:89: expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
>
> Each of the four typedefs is used exactly once, as the type of a struct
> cgs_ops member, so they are merely an unnecessary layer of indirection.
> Drop the typedefs along with their kernel-doc comments and write the
> function pointer types directly in struct cgs_ops.
>
> While at it, drop the unused cgs_handle_t and cgs_get_firmware_info
> typedefs, and document the members of struct cgs_firmware_info.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Link: https://lore.kernel.org/all/981f01e1-0c3b-4854-9d72-8bf22af9fc64@am=
d.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> Tested-by: Arnaud Bonnet <abo@medichon.fr>
> ---
> added kernel-doc comments for struct cgs_firmware_info
>
>  drivers/gpu/drm/amd/include/cgs_common.h | 74 +++++++++---------------
>  1 file changed, 26 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/a=
md/include/cgs_common.hZZ
> index f40b6a03fe63..79522e1bec4f 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -63,6 +63,14 @@ enum cgs_ucode_id {
>
>  /**
>   * struct cgs_firmware_info - Firmware information
> + * @version: firmware header version
> + * @fw_version: firmware version reported by the IP block
> + * @feature_version: firmware feature version
> + * @image_size: firmware image size in bytes
> + * @mc_addr: GPU address of the firmware image
> + * @ucode_start_address: ucode start address (SMU firmware only)
> + * @kptr: kernel virtual address of the firmware image
> + * @is_kicker: whether this is a "kicker" (k) firmware variant
>   */
>  struct cgs_firmware_info {
>         uint16_t                version;
> @@ -78,45 +86,6 @@ struct cgs_firmware_info {
>         bool                    is_kicker;
>  };
>
> -typedef unsigned long cgs_handle_t;
> -
> -/**
> - * cgs_read_register() - Read an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, u=
nsigned offset);
> -
> -/**
> - * cgs_write_register() - Write an MMIO register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsi=
gned offset,
> -                                    uint32_t value);
> -
> -/**
> - * cgs_read_ind_register() - Read an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - *
> - * Return:  register value
> - */
> -typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_devic=
e, enum cgs_ind_reg space,
> -                                           unsigned index);
> -
> -/**
> - * cgs_write_ind_register() - Write an indirect register
> - * @cgs_device:        opaque device handle
> - * @offset:    register offset
> - * @value:     register value
> - */
> -typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, =
enum cgs_ind_reg space,
> -                                        unsigned index, uint32_t value);
> -
>  #define CGS_REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
>  #define CGS_REG_FIELD_MASK(reg, field) reg##__##field##_MASK
>
> @@ -133,18 +102,27 @@ typedef void (*cgs_write_ind_register_t)(struct cgs=
_device *cgs_device, enum cgs
>  #define CGS_WREG32_FIELD_IND(device, space, reg, field, val)   \
>         cgs_write_ind_register(device, space, ix##reg, (cgs_read_ind_regi=
ster(device, space, ix##reg) & ~CGS_REG_FIELD_MASK(reg, field)) | (val) << =
CGS_REG_FIELD_SHIFT(reg, field))
>
> -typedef int (*cgs_get_firmware_info)(struct cgs_device *cgs_device,
> -                                    enum cgs_ucode_id type,
> -                                    struct cgs_firmware_info *info);
> -
> +/**
> + * struct cgs_ops - Common Graphics Services operations
> + * @read_register: read register value
> + * @write_register: write register value
> + * @read_ind_register: read indirect register value
> + * @write_ind_register: write indirect register value
> + * @get_firmware_info: get firmware information
> + */
>  struct cgs_ops {
>         /* MMIO access */
> -       cgs_read_register_t read_register;
> -       cgs_write_register_t write_register;
> -       cgs_read_ind_register_t read_ind_register;
> -       cgs_write_ind_register_t write_ind_register;
> +       uint32_t (*read_register)(struct cgs_device *cgs_device, unsigned=
 int offset);
> +       void (*write_register)(struct cgs_device *cgs_device, unsigned in=
t offset,
> +                              uint32_t value);
> +       uint32_t (*read_ind_register)(struct cgs_device *cgs_device, enum=
 cgs_ind_reg space,
> +                                     unsigned int index);
> +       void (*write_ind_register)(struct cgs_device *cgs_device, enum cg=
s_ind_reg space,
> +                                  unsigned int index, uint32_t value);
>         /* Firmware Info */
> -       cgs_get_firmware_info get_firmware_info;
> +       int (*get_firmware_info)(struct cgs_device *cgs_device,
> +                                enum cgs_ucode_id type,
> +                                struct cgs_firmware_info *info);
>  };
>
>  struct cgs_os_ops; /* To be define in OS-specific CGS header */
> --
> 2.43.0
>
