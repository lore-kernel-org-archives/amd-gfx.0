Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E616CC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 13:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE3A10E244;
	Thu, 15 Oct 2026 13:27:04 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3D110E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 13:26:58 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-35e8253292cso132244eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 06:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792070818; cv=none;
 d=google.com; s=arc-20260327;
 b=Ydq9Q6kV4ruG4dpfVkcYhV2+zoNttT41VY9KQYM9h1nNwi8z6yMKGnIUa+cnXfPmMS
 mqzoiA5JvY8lPiJQq30OEba/8nFUtLYrsP0m7KTwYY8R7tGlMMe35W2zMKQmG2Zb7MLK
 9EeZhHbuOAnXXmybT8XSNACQMQGQjEJ4AdL3MoeGkKhgjjcYTcxEZ4gitsCKa0VGySqe
 TFUCgEY9MlWaMxXDjdm4g8h4yJlSvhJbthB+VQNGVWLaAM4koNTV6EsJmGKAcYHXj8yD
 qUgvqEvSfNL1lhucmPm+3JBuD1cY/JxkqdbEY4eCuFDUKmGKgN3G5rTqr4ysx507Vdeu
 oi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
 fh=a2f/LvdhjqUeRcRNYsvv98+ed8stCgzmhl320sJJ1jw=;
 b=o2sc2Ch7ayJVRqMAXkCRVMmOu3VooiSZ2c27Mx7vYN9H5oOqe3jhs9/BSEJODXZHYD
 lKYzfugenlA7IR7Nmj5cvVQh2YAWxC+dHHa/K9omMzh3KRD7oWm4dwigalzcap/7xm33
 qTsE8wGo5/FdnFhQXdXXbpaU/2CGl2lx1acKEg18ETdRcQkVDvI8u+tHZNi4UF8TpkZs
 goKZOcwWiYJuJylxVA5Xi1zpsX7KP4Sh6mA0BAMCVvjavEVGLv6n8odouODUjJkcRllM
 Umf3M8WUsA0QmRHTuZ2MhBJd7Og3xuzCg/nSu5/1mzsHAOfjAIGF0+24QragxO4PRK57
 Dh3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792070818; x=1792675618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
 b=mgeMvIpMV3raS6hv+lwzmHWdSktZrJYyjOqSCLzVQIRmVsn3n3IOJHSCG2y/91K7c2
 Ff21Gx40pqZ2wPJcgowkBin4eiQpqKRrHzI3zzWG8Wa6gBHASxOalc4u9L5m/0kfJsFg
 5c6p05dPsnuctsNb6/t9rVKVr3qmdN8wsX2S5YrXZU2OLcrdbVKXibaXCWi140OQvVW0
 GiaX1G2C+vqAVkB9AYWnqEIyslSRtRe+lC7ywmVtK5eGfPfh/Nvs/rraXo6ycyDnHdYi
 Ph2KnkG6Gfx4e8h0W8q82LIzG0dBn/2jPPGIwGbUdvdXms83AsUBkfXa6bTZrSAnMC/w
 k5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792070818; x=1792675618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cATmI4j38U/J4hHVR3or+1yt/KGxYmxG3amR1w2998s=;
 b=F0JTM1yY4rZaaY822iYUO1Ge7WDFwWTP6200Gz5pGUDpi9dEDoZrXPWym+2xs79DUG
 HEq3K0j53Gew+rHoVexVlGN8sijmtSCeRNkgLVMZ0G5JQ4STx3b3x4MwXxx/I8dnc9lr
 rSfzZVCtZhPidPo4kSsXToBDqstfu1il9ZVFbWr7PHrRfrEfmsthq1BDuxFKtKetp3by
 QWDXZv+UJDoXJ/fTDgTWCp6H9OaSVa0yb7XDC/D5BX81rrJARBZkgixSeXiFIkuQieMi
 lKChz7Ou8m80PVMVdE3KP30exlPckeyiTdcDUzCDSdnp4oKmK3g0x5nMfE+H/VgNrG+z
 iudQ==
X-Gm-Message-State: AFq9FYLAt/XGrCGbCKbXjInVTBR1C3EewRJPsGaRV16CUTbG7SjnMl9l
 3tb+5hi0VPJLMLPK6RI4NfLEPqXVj+KBHcQgmbp42NJ+ZnPqO4mM/5RnCkvgDH71OZN5SE4a33K
 iuYWxavbZDHgP/FVw+qXgskIane1KYbI=
X-Gm-Gg: AYBFou2qY6GSBxC0LIxnK/HmggKfnM5fKtFCGLMGjjGFPyMlYSfwe2vQZkF7LLG8Wg3
 yD5u8oIV4WDXIFIz5gj+J5gDZIsGH7Wpe/kF9KxzveGjxro8saX8L8zjFOVefWQNp0gJzNzPh5+
 +qClrMGRU1JqKDn4P6c431M3lFQk9BgakiQSADielsHFTPeUqDYiWGxRChmDrGFc4cMLeT35p4R
 /PMMrF6hZEKn8bylo6UjDRdNdPuDcDkKMPD1Q4dB0xxYOmRB5aaWXHnIEmelJbhxnWfOLCGqghr
 R0BDSRXK7gB0CNWeWSvHbhBC4OzFTnZU1cHi9auyKHY0jJFAxtpavLHalw7IbCSAizs295r81ER
 u381FJ+Gt5cGLEZEzo8SoLqsxc8ot7owPkmnR3Y0XzA==
X-Received: by 2002:a05:701b:4515:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-16a4e2f6033mr37343435c88.0.1792070817732; Thu, 15 Oct 2026
 06:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-4-qchcio@gmail.com>
In-Reply-To: <20261015095713.20560-4-qchcio@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 09:26:46 -0400
X-Gm-Features: AclHuK8CxSpv9Lg4OM681QE9BoRr-RmsT4lQNJ3FTA7MFQV8hzgXwL1ydnr1ZxE
Message-ID: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, stable@vger.kernel.org
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

On Thu, Oct 15, 2026 at 9:06=E2=80=AFAM Maciej Kucharek <qchcio@gmail.com> =
wrote:
>
> On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> reset) moves VRAM back to the VBIOS default.  gmc_v8_0 reads
> MC_VM_FB_LOCATION once at init and reprograms it only on SR-IOV.  On
> bare metal, the driver then keeps using the old layout.
>
> vi_reset_quirks[] handles this for the MacBookPro14,3 by PCI ID:
>
>   commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
>
> Add the test that SI and CIK use: an Apple subsystem vendor and VRAM at
> 0.  Other Polaris MacBookPros then get the same reset at load, for
> example the MacBookPro13,3 if its firmware leaves VRAM at 0.  These
> boards are not tested.
>
> Keep vi_reset_quirks[].  Its MacBookPro15,1 entries fix a different
> failure, a module reload after S3:
>
>   commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
>
> VRAM is not at 0 at that point, so the new test may not cover it.
>
> After the reset, FB_BASE is not 0, so the new test does not fire again
> on a module reload.
>
> Only compile-tested.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a0435fd55..cad6bbfce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1405,6 +1405,16 @@ static bool vi_need_reset_on_init(struct amdgpu_de=
vice *adev)
>         unsigned int i;
>         u32 clock_cntl, pc;
>
> +       /*
> +        * MacBookPros with switchable graphics put VRAM at 0 when the iG=
PU
> +        * is enabled.  Any later post (S3 resume, GPU reset) moves it ba=
ck to
> +        * the vbios default, so reset and post on load to start with the
> +        * vbios layout.
> +        */
> +       if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +           !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MA=
SK))
> +               return true;
> +
>         for (i =3D 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
>                 if (adev->pdev->device =3D=3D vi_reset_quirks[i].device &=
&
>                     adev->pdev->subsystem_vendor =3D=3D vi_reset_quirks[i=
].subsystem_vendor &&

Please drop the now duplicate quirk handling here.

Thanks,

Alex

> --
> 2.55.0
>
