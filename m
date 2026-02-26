Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F58FD8FD9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 16:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6789110E9D3;
	Thu, 26 Feb 2026 16:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AwRMxKjA";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9898F10E9D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 16:53:34 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-124a5810e41so62101c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124814; cv=none;
 d=google.com; s=arc-20240605;
 b=U+6BmX50SC/wNdyjxZRNFav6OhRb3G8E/WagbZg5DrMYMnVSrqN6snThXCyhrWTMR6
 16JR8H1wjBDpTK9iCCKJwJqF/hHATWlnjfpdHs+i3/DaAXdv0PEqLhQ7Ad6674RrkjBR
 FVHdUpR/Txd0QNqj0dZgmt3r6Sn6KO53WDUic0KLwNHZkUQkzeIDP1OJ815Y2Xe+mdJu
 Kwq/N2XNi0m32FOxpy8ALIrbnHvFPXrOd8SBWHoH9QwgDyL16nfOzk/vdqZhG58h4hhw
 C5vuHsgSK+hd55O+5PG4O3mpA7cMVcQpV8H4bofugH6mDc32pprWeaJ0DHoWPApXjbNF
 AXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nSMaYfcAaczcS5xedZ+A5sc4SxyyrrIlz7xrQ4/9ZI0=;
 fh=oksQNGgXrGE2SUW2788ZYyt1S1PqjrPr6QAfkcQ4xZk=;
 b=euWvwmb8fzcYhaW6HCWOqiLX5jam4WT6DfHzA+G/tPUPYQXXBbX/hFJSO0NVf4lZ56
 fNe2/r/nxqTM3gEqywcqRBCM7ajLA/0lTAEExuOkM2uDPz7GCTYx9wbteXyrPSZj4/lD
 mgKN5vOAiIslxcsQFVGwex/bSJEgZvF0c4gchzq4s1xpATVGePOKaDYYrs/+W39EsqsX
 UVaDBzhPfayoPdm3ql3BZ6ZUef6joaHBgjmNBHMGdEZ+BtLU6EGgNtU8DbKmPuFs0Cb/
 tHORha1FE0fGPSYXi0cdh+0h02d499IybJbWjZdEl7a9KIa/VaOC8g1E3En4Y2aNC/fq
 NmVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772124814; x=1772729614; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSMaYfcAaczcS5xedZ+A5sc4SxyyrrIlz7xrQ4/9ZI0=;
 b=AwRMxKjAsUHiqfy4c/NJU4iuytLg90dnQ1QgihGt1xQRJdeAyQMrZyu0G8NEyQhUkt
 7FaRwbg6t0fpIbM1ZCMyvvkP4dlYZG4EuzcB1osHkObpDPujyvU6vnt2zsQPXMzeV8vG
 ZTwRGTAPN2s+V+C2uIjrbIFXHAPrigJe/dhxNZy5RE8R0ZgyW+no0zfIjEt1EnY3dWVp
 bUSaedoY+sA3+L9vWmyitg+Ni+zuJW5fjSqRufqmfaXKVVxl8MJXal9BVJ+RotOSYk9p
 JSqzoGZ+DmUSWEyVBEw7Su9jgp4DOEsxiErdgvrabRauHF5b79K3Uo2qbzEApETKiPUo
 qHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124814; x=1772729614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSMaYfcAaczcS5xedZ+A5sc4SxyyrrIlz7xrQ4/9ZI0=;
 b=mOU9xPddK99FpbaQV4/e1lIkMliyfPZ3S9O2BqfHh7XhgyzD+RgcKO65NfXfUGXYT4
 bhgvhZTkk/jB3p/B954EFADjZUjwUsv7V+Zxd8u91r2qo5IHLR1/fF0LdXRkddpaN6V2
 H7pwcVwAdHr8rv3kdjyVqLwG0Mi/uVg7yzRu9YO1cQGqJLtDkQnvqM3PP9gnYv11nc+8
 DFNCMLef15/rXZBBNeATAeLcrOWyIias4tkgLJPCtkYqENot+eZLgSBUDvtd5qbIeuMB
 VVc4Tep6i7xP99tSQt4DXK0FBwr3YIhyvhWMP3Ral2gmzfXR4/pTqFqtVn1TdzOuwLkC
 +mHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH2Ubc3rWGZTGwhSlByqpHkPFL0GZgms927aEf+Rc2aiwwvGc8bkSe/BBs9pISuJj6omXqubqN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCCF6skqx+FSn0FOejQi0L2F5JSkAh598RgGy3NMZXP+BP+DHT
 jVwOR3yfn65ZzstV1kHZpWhgBO+/6KXL1xxbs++lWFy6Js6MnP1v5x57PB5Pp1Ehl61NkHLMu8l
 kC9M7XnOocjSZM90bwDnViFTc/fD7za8=
X-Gm-Gg: ATEYQzzwVrqVXX3JLu1rVlCIUl4dk29rMnc94A8G/Ssk8m06DpNsz8Rl74TaBtTsnxI
 HDPExtn095o/zz09Al6XtZvvCoCwyYGkX6Z95ho6+9JCKdUnc8d9NnlqmhrnC4cozHCm1wnuplN
 giFxUFkVP0QlTqosmzw+VGVcUxMszR2anVEtSneyisJ/aIk0RXINoQ4OfYZwzj+eW7xAQOK3L/N
 S6yBaeqq+VZ6yhQv92MNE6dg363HpN0v6r6+fPOhZvH3NQMnWpUPqtjHZMV4Wkk079RtsjAXYQJ
 OMnfYbSGuLOQStSVve/0ir8LsfWsHmeghoY/SY7jZi8id1zCfQZrOLl4R6u6akpX487KGA==
X-Received: by 2002:a05:7022:2383:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1276acad3efmr4459654c88.1.1772124813724; Thu, 26 Feb 2026
 08:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20260226030038.1182961-1-yujie.liu@intel.com>
 <20260226030038.1182961-8-yujie.liu@intel.com>
In-Reply-To: <20260226030038.1182961-8-yujie.liu@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:53:21 -0500
X-Gm-Features: AaiRm53PhKEH-H8S2VgmZZ1MUIfEIaZDuRwRMb5_ZanlUifF-Xs_VnxnKyGbvPw
Message-ID: <CADnq5_PD3DMPA5WY-wGS+NHmEQRXSx=WQNOygNXt8so-n2L2mA@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amd/ras: fix kernel-doc warning for
 ras_eeprom_append()
To: Yujie Liu <yujie.liu@intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
 Gangliang Xie <ganglxie@amd.com>, Candice Li <candice.li@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
 Michal Wajdeczko <michal.wajdeczko@intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Wed, Feb 25, 2026 at 10:02=E2=80=AFPM Yujie Liu <yujie.liu@intel.com> wr=
ote:
>
> Warning: drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_eeprom.c:845 funct=
ion parameter 'ras_core' not described in 'ras_eeprom_append'
> Warning: drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_eeprom.c:845 expec=
ting prototype for ras_core_eeprom_append(). Prototype was for ras_eeprom_a=
ppend() instead
>
> Fixes: 5c3be5defc92 ("drm/amd/ras: Add eeprom ras functions")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/d=
rm/amd/ras/rascore/ras_eeprom.c
> index cd6b057bdaf3..65c1812a10fb 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> @@ -829,8 +829,8 @@ static int ras_eeprom_update_header(struct ras_eeprom=
_control *control)
>  }
>
>  /**
> - * ras_core_eeprom_append -- append records to the EEPROM RAS table
> - * @control: pointer to control structure
> + * ras_eeprom_append -- append records to the EEPROM RAS table
> + * @ras_core: pointer to ras core context
>   * @record: array of records to append
>   * @num: number of records in @record array
>   *
> --
> 2.43.0
>
