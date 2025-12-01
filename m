Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E144D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 21:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23EB10E491;
	Mon,  1 Dec 2025 21:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2oeXc+F";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7829E10E491
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 21:01:09 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7bac5b906bcso535979b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764622869; x=1765227669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOG2RH1yuolpiTNGM8Opz9SbQnFHScgW0efJOkQ9Frw=;
 b=b2oeXc+F9mzz/xe8PPCq5KtXK1Caqr3lFo1cWm9Sfr/RUvhxaarkj513G23xEmeTla
 +uexRKuZyPcx2PIRPRCS4JFLqcXMtSCpIDbszFgQXvJNHgSw00EXpRM506UQjgfBrck4
 7IUG1COfNAXmkrIxzKPRyMsg7PNrPPVS9sRDaIqTBxPV+TOhe3ikAiXyBH00+5RBFWA9
 HBIx/nP7prIEAKc+0Hb4f1tNoTljUFrh6Pp+pPkISm/KcZOYYGfClzD9zv7Z/zgMJXUl
 TXphmUwk9TzWloT3hd6E7hZG0w5B3dlz9mDSWO3veEB1LqSdxGeTpjKhomhjWMlKLS1F
 2mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764622869; x=1765227669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xOG2RH1yuolpiTNGM8Opz9SbQnFHScgW0efJOkQ9Frw=;
 b=H6lrczTxkOxcTbU88UoB9lbHBfiHSqC108EsxDzLVPSt/mAK2qXwsWWBDcqgLSH2NR
 tUoOM/o291k7F2g2KERiQJwYoudbtx94CvMuteVl7BxpxL4acuTf2P3xLlc2EzSGeUPZ
 FhcwBnaUcQsjr9OMXw/G15aQfVquI/Q6Inee1pnrb+j025wfq7nFbsWRK9ZZ4phEY9FT
 io/IuumXMIeRCs56B9G6wkJ5kFwFpk+RP02y/j1bzmYinGYJBqHgxHsOSBkJEIXqHMk0
 nLW0vX08ugUG/ul42BFTOFDxb80V8OO751z+Jr4tnySKmEP5Az186z3aQk5LE0ul2YnT
 +b+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ1ueZzzWK+lm7h+CbrIHYiPoSnwXt4e1dykyteCy5QCdUMk8qBBE5fpL9Kqdusxmz8Eku67Y0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgRovCIZchVpgLt6+8gMBmkqIEJ4tIMEX+sRSidpK0ER/mn/yg
 vVNbUJ0UX7yOoH39KxjBSFyqqkhVcCl4/74CCs8d/Z+fwVqF7HuKgiDdO1X7yO5ewvObsuUYMgw
 ilLTCuaMhU10+xC8hwcZliHN8IXpGYBs=
X-Gm-Gg: ASbGncvp7nKGFth+cU/11h0xESyLRZBqFi+2aat3h5iiz+WX2p+6WBKd1trYismPV9r
 sCqTbgVqDbvgzIsAKN+MW8EaRS7FJZMzh762CvLBnRJlMlCC8pgSLG0CyjSTEELqKD1iZlYBYAM
 zXvKAF+I6sQ4KRPUWZv7Cxl1PWB3TJNGxHHHz45DF4ciB7vQPPicBMAgt7RKJl1qmNSnzcMohmu
 sRV7NDheX/qQ/pYTKbX3j6P/iErOBgaXzvHfwbkUMRYcrv4yXeiIqL+b9Rzz9WL19wgN+g=
X-Google-Smtp-Source: AGHT+IHkMGIF1my/jphD6WKaVSgqFvhYiFPgOMcHTl24lExp+Zw4s1dfC0nBjnv5TnJKjpS2HzjzEvowgxf5M6z0R4g=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr23923739c88.2.1764622868566; Mon, 01 Dec 2025
 13:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
 <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Dec 2025 16:00:56 -0500
X-Gm-Features: AWmQ_bnAhgmjHgP2EppWA0Vj-kGl0ww-Dgk2CV93fTE5IpSLgo5MpVT5M2dZpT0
Message-ID: <CADnq5_NimLgWZ8M2u91VDJyViCZynKqJv7oyLO+JGjjB0n0U6w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/sdma6: Update gfx11.0.3 SDMA FW version to
 include UMQ protected-fence fix
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Nov 25, 2025 at 11:14=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> On GFX11.0.3, earlier SDMA firmware versions issue the

here and in the patch title,  s/gfx11.0.3/sdma 6.0.3/

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> PROTECTED_FENCE write from the user VMID (e.g. VMID 8) instead of
> VMID 0. This causes a GPU VM protection fault when SDMA tries to
> write the secure fence location, as seen in the UMQ SDMA test
> (cs-sdma-with-IP-DMA-UMQ)
>
> Fixes the below GPU page fault:
> [  514.037189] amdgpu 0000:0b:00.0: amdgpu: [gfxhub] page fault (src_id:0=
 ring:40 vmid:8 pasid:32770)
> [  514.037199] amdgpu 0000:0b:00.0: amdgpu:  Process  pid 0 thread  pid 0
> [  514.037205] amdgpu 0000:0b:00.0: amdgpu:   in page starting at address=
 0x00007fff00409000 from client 10
> [  514.037212] amdgpu 0000:0b:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STAT=
US:0x00841A51
> [  514.037217] amdgpu 0000:0b:00.0: amdgpu:      Faulty UTCL2 client ID: =
SDMA0 (0xd)
> [  514.037223] amdgpu 0000:0b:00.0: amdgpu:      MORE_FAULTS: 0x1
> [  514.037227] amdgpu 0000:0b:00.0: amdgpu:      WALKER_ERROR: 0x0
> [  514.037232] amdgpu 0000:0b:00.0: amdgpu:      PERMISSION_FAULTS: 0x5
> [  514.037236] amdgpu 0000:0b:00.0: amdgpu:      MAPPING_ERROR: 0x0
> [  514.037241] amdgpu 0000:0b:00.0: amdgpu:      RW: 0x1
>
> v2: Updated commit message
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index e3f725bc2f29..4996d60751ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1390,7 +1390,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 0, 3):
> -               if ((adev->sdma.instance[0].fw_version >=3D 27) && !adev-=
>sdma.disable_uq)
> +               if (adev->sdma.instance[0].fw_version >=3D 29 && !adev->s=
dma.disable_uq)
>                         adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_me=
s_funcs;
>                 break;
>         case IP_VERSION(6, 1, 0):
> --
> 2.34.1
>
