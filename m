Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5682D0EE0D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 17:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A5810E558;
	Tue, 25 Nov 2025 17:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHOWsJNA";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E0210E558
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 17:01:52 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-bceaaed0514so477004a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764090112; x=1764694912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/DRUBJR039HbL9LSMPNJeVJ8T9IQW05SbkysljOCWk=;
 b=MHOWsJNAq9V2jlDUDatSeuinhxLn7Rx7HtPhxLI0451ksaiNxDBs4W88ibbUG+lyaq
 iysId9wRk7rG08eS61embrdp+i40jNDKUpNLQnXTVA5/I6hoW9SEV8jkIs3C5wkFC/tV
 d/kRaA4QsZfSohFiP4+X3kcLKXxSmGXNa4N1aszRE5Y7ixo7fHoJHjcsISl5HUCeqf+W
 gAWkJm8WwgtEoYQjgE3m43m7QwbVpCgq4Wwa70IMAlg24jKKmB4ipB+rzDyC3GnU2WlS
 XbMW3FAv/wC6AwfPaVEI0kH1IhPjNoIZg2G5uLyLc9Hml8sILKaRdVa9rmfOOhGKDDzJ
 44xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764090112; x=1764694912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/DRUBJR039HbL9LSMPNJeVJ8T9IQW05SbkysljOCWk=;
 b=PVL7RYpvhS+LeW9BNPJDR5WaaZC1EDt78ftxQDHcpdZRYqW4UTbTTdJK27LaiwhjuV
 uxhXcfjJgIkZT9i6A1WkTXeHsgT/V+bdEn1R6SCcfxy9LJenL2hgvytfFqlWDWVFCVS3
 PSWU3OAQ1HzHrovQQkxJXkN0aqJeJYs/TdA0G+UHKtIN/wUM+BSjLfmcWYonkEy+2NlJ
 tMem+K55zQwPDlz/AbQ6n+4w0XgniEAOa3qwb/5qVCoJXpTZ3Xqere3DzL6X7BKW6Puk
 Qd10yXa0+iDjmOc7CkHtXHhB36mlF/SSgSgob5HM+r+5cH2smOJ10BzZ3gvywPk0gcWT
 VYOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoAn478nsper7U3/Qli6tZu5d8oMtf+moIt2s5OrejQWf/lfjdkP6mo0YGgh2yu4qFTdUs2NOG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYFQcFsl1ZwFDjDCLpCghZdN10A5NxGI+ujzX3Qauaukkuc0Bi
 o+UJzuJIfAWkuJnde5nMwIkIF6riwKXhppzMyi3WLPsYF4U+oLAt/Gnaj3/7ve2K5qNR1m/zyx6
 S/3h2P+5VFRPoZqXyePQF7bG3mAKIwQ4=
X-Gm-Gg: ASbGnctB4zdWawJpLXVET1uwprm2b1vUe38k0u/i1p+87Cbyy0nYdKPLQ751bs50L02
 83ExQyMjHz6R5LjO2BN6sqPWJuBLsZy5PE+SFIgPoxE1hOt0irczKLrH1XaiGTpgVtZ7pE/vMOf
 juav9EflFiogedArB+4sITosJMSJ6P/Q9YymHINsqP4rGvEY2pJJjuCR6ra4qmHr6a85pWCuvlg
 cIo+r3rNe0f4oRGW/sKsNi/U0S28YzSh0sDyFNOixU2giw6l8lWuuPjj3wweKj+qmk=
X-Google-Smtp-Source: AGHT+IGUSpSvZx+8SjwbDG5CJ6XJTIwZ9B7bk4hbAltJXdKhnHwkOc4wg8yEfc99VuRH+Ikc/jSMpf0NtuuLdmf8frc=
X-Received: by 2002:a05:7022:921:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-11c9f37aa52mr8951127c88.4.1764090111480; Tue, 25 Nov 2025
 09:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
 <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Nov 2025 12:01:39 -0500
X-Gm-Features: AWmQ_bksHNJvdJQULVy9rVTXjUPQ7JYsXzFi_YFYCmaPvK7dmxWT4vX8DbCYcvQ
Message-ID: <CADnq5_OP9m0jc026bm3qtOzAwtZPaaVgE_p2tfvK6bBnzho76Q@mail.gmail.com>
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

Can you check if other IP versions need similar updates?

Alex

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
