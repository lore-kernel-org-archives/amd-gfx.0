Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD5CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 13:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4248910E2E1;
	Tue, 26 Aug 2025 13:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eaBBqN36";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796D410E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:55:26 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b4717384710so750319a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756216526; x=1756821326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlnOkMcbcdeOaoGrWjiJBdWxLdnan0LKLqZITuDwAv0=;
 b=eaBBqN36EbG9t9aRvd+9wDBC6MDIc1b4eBlTM4b3xPM/nfPg34SGPumwo7f5ajpJc0
 fiawxw5qC3Wit38qSQ5XyIyOpjL96HXJ2OrSG03eBlfRmAScIb0N10Z7v2JCK1KodC1Z
 IpX5CzGsc9WrHl8DX+KJLGszeNkeAFzhmuS1eFwDViJnMHYI7uMsccx+aVu2vfFF2tBv
 FPy6LkQJart8K1frNiH1XGDL21Tr9r4iK29peUwYyXMC0jAH70OI2+w90qOOin1lUY0a
 0zECg2g6BXaVaOsY+pccZ/LO5Eaq5x1UNXbtVI3Q1pixAoa2+ZRkjeLrCbr46PomvFgc
 sa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216526; x=1756821326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlnOkMcbcdeOaoGrWjiJBdWxLdnan0LKLqZITuDwAv0=;
 b=lUjACKKPx9TG5KKkDqqlYc2CYPH1tDeqa/Rru0W6qQbg/PWrCpq8BNEPgewLCgywjL
 QsucTyAJi3YpuBbq6wP8Ey9mGHjJxhKMDBm7C0P1C/mp4Xfld+h4MxVbf650IQaIRI2s
 ikQ9R9VRXNFOb/qEKrmlfbsWAw0Kow0RiU7oOjckb2p3Tx/nSErS6Ig+SgEANy5ILnV2
 aiTcdsZWI1gFOL/ZbEwHdwEnrfCe9Y2q1yO7MyN2Bt+d63SbpjKYBwdgqhxHm8nQ6L1G
 8uWdTKwYVL11mvt7sv0TxKSLNuAiVpYxTa1TEcJc8YU5QrtrAyPN3neRUnRC5yCC2llw
 FlZA==
X-Gm-Message-State: AOJu0Yzm3RUj8FJYAzAFLX0whirgQwj7R1c2ZYQevtvF+M8Av+Is9EPY
 tagO6fZb0m++zEA5l0Ck7E8qJqUlJkeBpvC4sb1BMld927gDeOVNBbJK08Hauk9DP7C/GK9dtna
 J5hC4NVwDrhGaSzYuR2am16I55TQe8Vk=
X-Gm-Gg: ASbGnct8DjbQkoHrwvOhCIlmJv8XlybqI+LSKgrBGIvHVGVo4WNkeZT5EerL02Inkg3
 Qiiy3dI/NkKabsMstdcJVXLoyUUb2CABIeSqUOz0FEezZHnJmJZzYKm9R7hZ0K+k4KRRetyMJ79
 kxcBbD/oqY+1NsUGagDzYQaw1w5ffsPZVXIBeARne4cZ541Ou42/2YTmJ+H4kDNNbgkPnyw37DV
 wX87KOdcrvTsgQ/Bw==
X-Google-Smtp-Source: AGHT+IFfvfGSIdBNJkDYeUdxV48fBo+LEJb+cR8NqDhWsDBWdS4ZeJK2cVGlsxlhA7snhXpEkoKyxq5YnTMxtiIe+o4=
X-Received: by 2002:a17:902:f711:b0:246:5d07:842f with SMTP id
 d9443c01a7336-2465d078881mr97920825ad.1.1756216525912; Tue, 26 Aug 2025
 06:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250825210113.182727-1-David.Wu3@amd.com>
 <20250825210113.182727-4-David.Wu3@amd.com>
In-Reply-To: <20250825210113.182727-4-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 09:55:13 -0400
X-Gm-Features: Ac12FXwNAls-6_r9SCySiW7Gdzukui3TcLaDE8EB-o5jWy0HOTPDav0P2VwOOZk
Message-ID: <CADnq5_Mg_C7Lx190ezufMqtqsK-9pe_7s78reb3SgLh05SzuKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: add instance number to VCN version
 message
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 25, 2025 at 5:28=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> For multiple VCN instances case we get multiple lines of the same
> message like below:
>
>   amdgpu 0000:43:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: =
9 VEP: 0 Revision: 11
>   amdgpu 0000:43:00.0: amdgpu: Found VCN firmware Version ENC: 1.24 DEC: =
9 VEP: 0 Revision: 11
>
> By adding instance number to the log message for multiple VCN instances,
> each line will clearly indicate which VCN instance it refers to.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index fd8ebf4b5a824..5a90abcea0ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -185,16 +185,16 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, =
int i)
>                 dec_ver =3D (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf=
;
>                 vep =3D (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
>                 dev_info(adev->dev,
> -                        "Found VCN firmware Version ENC: %u.%u DEC: %u V=
EP: %u Revision: %u\n",
> -                        enc_major, enc_minor, dec_ver, vep, fw_rev);
> +                        "[VCN instance %d] Found VCN firmware Version EN=
C: %u.%u DEC: %u VEP: %u Revision: %u\n",
> +                        i, enc_major, enc_minor, dec_ver, vep, fw_rev);
>         } else {
>                 unsigned int version_major, version_minor, family_id;
>
>                 family_id =3D le32_to_cpu(hdr->ucode_version) & 0xff;
>                 version_major =3D (le32_to_cpu(hdr->ucode_version) >> 24)=
 & 0xff;
>                 version_minor =3D (le32_to_cpu(hdr->ucode_version) >> 8) =
& 0xff;
> -               dev_info(adev->dev, "Found VCN firmware Version: %u.%u Fa=
mily ID: %u\n",
> -                        version_major, version_minor, family_id);
> +               dev_info(adev->dev, "[VCN instance %d] Found VCN firmware=
 Version: %u.%u Family ID: %u\n",
> +                        i, version_major, version_minor, family_id);
>         }
>
>         bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> --
> 2.43.0
>
