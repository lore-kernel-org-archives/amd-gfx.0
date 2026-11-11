Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA1606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAKNXSQX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8BD10FC99;
	Wed, 11 Nov 2026 17:07:47 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EA510FC79
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:07:41 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-37605faade6so91405eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416861; cv=none;
 d=google.com; s=arc-20260327;
 b=Fwoo4gGShf62WBYC9Be5UgVlcuYnQ4yl8TuqDOzo1Cx08BDZwPUUPcou96X988PFpE
 +hsMcfoT6hWaS96ZgTo0cQ3kQ4Lh5VzNX7dEohYCcQJjlVlLz+kmDGEzYsPw+ZYXDw+c
 ntcc8uPeM7H6cf/wbDwXeWhF8LJD/XzBISL0HrL9FOlF4KVlwnjlS8GIGm0mz6lUKnm8
 Ki4QICxtwIkqge/yOZNIoKgrq4b/WWbAWmCnGD7EWOFkHL6lSqUnDs23u6Rq1M9hyTpx
 zYd2QQ9kURG4qpXIbS5t74p5RdRHE91l0DL4IOT/l0EPjCd7NspZ+TglyzrLs7EVgnJa
 xScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
 fh=GZo5ZrplEoxCrb3VjtF9b+EdUWu37jlPswdCleFi1lg=;
 b=A37ceH4BnowQek9Tv08gdZ3v7suKphKeDTEraWDaoVFLa4nFe8MvqqvT+eGHcjQBnI
 JxqG7VZa7B3G79k+HsQpIUnM5feNDpI0e3dOwQSSOBnzHgRPLVMrVI9NoEY04UTu6ka1
 XMukm+UPfEFNcMClunsBi/zZaHGoacVGuMh8blD7WCTtjYtv0nCdZ6n5KnjwGzz8UbEb
 RZu+DPMg3w9F4NIyVby93Qdla8TM50uKnYmbkl/HhDw1NCVDYipBIsYFthJvrJXZI2Ca
 swIHaHdmM88QORz3Up9AUGSpks3owvxQZxmleeS9K4VrbThDXZa6USEpePJidYnHs1Fw
 Fn0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416861; x=1795021661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
 b=GAKNXSQXoFG3nw+yvoepzj24227Y9kdfP4f8jx6+VjzjaxSRGj3XSE3pQjSnZ/PVj6
 s0mKXRlpDJAggiaWAhVFWiAW74mJpH4SEjlOepwXpVdo6Yv50eKL0BCp7rwPMXB7CKJF
 +t+V1rLO+PXbsv61KxGrDFxI4RYN3+BUrKcAMZeMr7HGSpe5p1yWgpeARjeXKJSbJxUE
 98Tkyq8J3m7g0bNGOG/D6nj3jh7MjJW13/K2DJdvQGR4jt5762fuBcF/O/J3VU6Za7qS
 mgi8Ze+ypRqhtiyhoPVdvMqCroWTUQq61HpqvCHrMHZBM1SQ+LIBjLdGFobgBg+/fKPs
 2+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416861; x=1795021661;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m8C3iSuJZb/bfGc8EsYwKela7J4KFddbxGMaPc1LKNI=;
 b=OJ0nrgYmBVStYisUPY/40ju80P5BUmpmvyN1VxQkvTcFYxYKdp8t2lYdUUdCl4kbhP
 Bg9HxEbwVKNnKqZqAvqp47OhcYJpBkbieKa0TfCs9dh2msdvUzGQbGtQEQhT0d8HuutX
 lif8b3dE/WrfFKvSlgopxy89kTuwhuREL5/w6Kbg0Uoyk7S2cPZQgEup4tqZVaV1+GWv
 GrmppwaDE8b59BuwP1apvFsZeC0EWCYGAhuSOWFCqZxGnck5UC7pOgtZY2vjEWzosCOf
 t39DOFyZ5RjW+EdEhzaMTfliKFoigLxT/Uos15SwMwYxvOIEFky67N5NVL86oaV6RCGi
 ARWw==
X-Forwarded-Encrypted: i=1;
 AL+hErESlWmvBwmL4nlSMSdXuz2+p6GR96kcEeutu2jwDSgYiAa/UhSP2mk91J1OaIz9kcbQsccHDJ5+@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/chNkxZR38VEuW1Zzv1g0A2Xgu9yCSFlEnlSPNjJBmiANdFPFo
 1mkn7xUZW4FwAWMqnCtpdAn0Izg1kWUBjAFhxrW/zY1QxqjAEb2vP+RmxWCtfEa8pDUYDWLS8So
 T5PtTsBYXuIcBWKsfXodtgnanqP5BDF4=
X-Gm-Gg: AYBFou2HQqapvzJ0EKHkyC4G4HlVzujg4ksDiFb5ivzz0TTRUzrgEUNmeBCy3RIqV70
 SgpdsQAcxW9Z1WoHVjb9iB68mSrvoBdkPJxoWCYhLICv0Pd3rUDoWoG4mrQM7NBCb2KSE5rAFGU
 3UyNPwn80fDP4UZR0oRHH41k1hU3wkvkLi1cFkayXSxx/TVUVjeihFRup3kdXsL0B3oOJndV7Es
 woMo027mmIr3tMSA0ZFjlnC/XyMKy4O/OO/wIGVRtmDrI36IL03zMLxjAi+jl/VYkE72jr3hPvp
 12gK46Ibm/WWhLKCJQDFILJq1aDxCmBjVsykzKS/XPUwEh34MMLnswMs+3AfotgWCKQKredQhPw
 VjTfCMsbbLSYBoWTKpSla4NujwFR0VB3fnVrwpYGpTPyUOvFBjfgglj25U05coRLppaYeDnE1yA
 xbaB2ILsv7hbVMUdcJxIilGxlarGws2jw0mDIeQCcznAxNU3YobvvFTMtv8Q0=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b3c01600d4mr4530976c88.0.1794416860548; Wed, 11 Nov 2026
 09:07:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
In-Reply-To: <20261109155215.3946844-1-amisiurov@cloudlinux.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:07:28 -0500
X-Gm-Features: AclHuK-_9BWEPd6xXKjNjzph_kbOJc93rFAg-o-qHWWs0SN7OfCKCcfKPgpijZs
Message-ID: <CADnq5_N=v=k0e=+aqwohNMoKEmoCbMj5PyEM38_fKa=h6O1Z=A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Bound GPIO I2C table entry count from VBIOS
To: Andrey Misiurov <amisiurov@cloudlinux.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 3:41=E2=80=AFAM Andrey Misiurov
<amisiurov@cloudlinux.com> wrote:
>
> radeon_atombios_i2c_init() derives the number of GPIO I2C entries from
> the size field of the VBIOS GPIO_I2C_Info table and stores a bus for
> every valid entry in rdev->i2c_bus[i], which has RADEON_MAX_I2C_BUS
> (16) slots.  A table that claims more than 16 entries makes it write
> past the end of the array into the rest of struct radeon_device.  A
> size smaller than the common header wraps the subtraction and the loop
> walks far past the table.  radeon_lookup_i2c_gpio() uses the same
> calculation.
>
> Reject undersized tables and cap the entry count at
> RADEON_MAX_I2C_BUS.
>
> Fixes: f376b94fbc0a ("drm/radeon/kms: unify i2c handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
> ---
> Found by code inspection.  Not reproduced at runtime; it needs a VBIOS
> with a malformed GPIO_I2C_Info table.
>
>  drivers/gpu/drm/radeon/radeon_atombios.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index 3dd9724..c4e1272 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -125,6 +125,22 @@ static struct radeon_i2c_bus_rec radeon_get_bus_rec_=
for_i2c_gpio(ATOM_GPIO_I2C_A
>         return i2c;
>  }
>
> +/*
> + * The VBIOS table size is not checked against the image; cap the
> + * entry count to RADEON_MAX_I2C_BUS, the size of rdev->i2c_bus[].
> + */
> +static int radeon_atombios_gpio_i2c_num_entries(uint16_t size)
> +{
> +       u32 bytes;
> +
> +       if (size < sizeof(ATOM_COMMON_TABLE_HEADER))
> +               return 0;
> +
> +       bytes =3D size - sizeof(ATOM_COMMON_TABLE_HEADER);
> +       return min_t(u32, bytes / sizeof(ATOM_GPIO_I2C_ASSIGMENT),
> +                    RADEON_MAX_I2C_BUS);
> +}
> +
>  static struct radeon_i2c_bus_rec radeon_lookup_i2c_gpio(struct radeon_de=
vice *rdev,
>                                                                uint8_t id=
)
>  {
> @@ -142,8 +158,7 @@ static struct radeon_i2c_bus_rec radeon_lookup_i2c_gp=
io(struct radeon_device *rd
>         if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_o=
ffset)) {
>                 i2c_info =3D (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + d=
ata_offset);
>
> -               num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER))=
 /
> -                       sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> +               num_indices =3D radeon_atombios_gpio_i2c_num_entries(size=
);
>
>                 gpio =3D &i2c_info->asGPIO_Info[0];
>                 for (i =3D 0; i < num_indices; i++) {
> @@ -176,8 +191,7 @@ void radeon_atombios_i2c_init(struct radeon_device *r=
dev)
>         if (atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_o=
ffset)) {
>                 i2c_info =3D (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + d=
ata_offset);
>
> -               num_indices =3D (size - sizeof(ATOM_COMMON_TABLE_HEADER))=
 /
> -                       sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> +               num_indices =3D radeon_atombios_gpio_i2c_num_entries(size=
);
>
>                 gpio =3D &i2c_info->asGPIO_Info[0];
>                 for (i =3D 0; i < num_indices; i++) {
> --
> 2.43.7
>
