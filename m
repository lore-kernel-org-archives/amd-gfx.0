Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A3606A338
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrmDvF2b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21201122FB;
	Thu, 19 Nov 2026 11:47:46 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A0F1122FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:47:40 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1328131f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088859; x=1795693659; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cGLfZXBKIAWN/N4v7PR79WON2EGEzqgVLpM4gi7Ir58=;
 b=hrmDvF2bYi08bdupI0bs770rA4y0jw3eG0FITxE8IaRca4PnS3xpftlP1QkF/eeOY4
 su4Bh38QgBqy1C05rlfp0rOjcxVuM+cYV+Kv30RnV/WKxvrzezI/7cSqQPJUkG1iMdEj
 et50fif48DBrKNqf8o37rbfDBouHxgcapCh7Mx1IRExuHlHcfMxLDnqXiyvfzcrK1hY9
 oNO8GblI+ihtnmzrGZTOmkqolUJPzk9IPYGsggrAb/AYm3qh5ZeDe5OaCB5Qh5GIMmks
 65qwRBvtrenmkp+P38Qp5DDG3xaR8B8T9Oi/8U6qd4rdw8bdMBRA5f7jPcJaC4xe9wZr
 NjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088859; x=1795693659;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGLfZXBKIAWN/N4v7PR79WON2EGEzqgVLpM4gi7Ir58=;
 b=jndolo1MV0khRBpp0q576T2W7leeSnFEsLMmwLT7bkZVLh4KbQalXql6oetqIE/zdw
 NtG9JeQwvcblLLU7iWXOxDiUXn+lSKiTle6+aQRLciv7OVKhjzAjijKsU32wHOiZ8Fme
 UqDWwqZ703kORjABIGhxvsD2xRmyNr9AmnlyZDRbrBmV1nUYBlW0JJE/KI59uY4Y+Nph
 M7hAxby42GhgerNFxOaI+Nanqyxl8XobmVeTidxS+tRJfh2+3a/IlSVEgvuFjWgXQbov
 US/3i/nf3DMJ1BZ7bnw93wemRo6QC73nn2krnEKKwh4y4hhicwSM1zpN6oT/no1RLt11
 qKOg==
X-Forwarded-Encrypted: i=1;
 AL+hErFRmvkTKT6uHmSAQVKao7Nsy/fHVVVS1lQJ5HvZeM/Pat9Z9/ALKi2Vxug62S5Urwhyd+U29dmJ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9QQRzZauirGsEgHupoHnJ4rx9H8bok1vWO4gBhaid+Qinwfi4D
 dqcMsKwE4bzQGZ7s4J+z5nyqLKhtNB4sAgucCLu5XzBfV4VzvB5LvV3VCZ39mJIn
X-Gm-Gg: AZFdTZfhLLnCJNJY3S5CuiKs2/CCePaiBXIXG4QxIlDwbUPTWEu1DrzelZ9KsIdw/DS
 CIkMQd8nz1k292wk0Rf0xXLw9sz7r98yUCEYXsEIKxKLYIRigZx4GI0lgQnK56dMYtshnH5/PpJ
 xKiR/uBNyY6PZ01XAkd0NS3mlhvev51MdOYEjLE4jRAOzCgcjrWXAIpW2jt99w+9/kQK9YZ1W4m
 EYDeDtSOZPKPjbgh3DwzKiO3GgxHZbP+CYyRcq/LDZ01viHsN6ood559PJv7K8I9UFSzTbCvnjC
 iXqfNZJ4ptWceqRzhO080HjPXZO9dEIYHSNNpRzYWk+201Q764NQxJyNnyAjSSo1QyUI5QpCRl/
 uxBwIfxzRFx9eLHoG6Inf23cOrQn8+g9QUsXIWgKZ3vRgpa7HhGAg8VDdQBek2cUOPOWhy+IXql
 1InlbMmTWlxPMkQtaWS7i0laYa6ONecovgls/F4FJBwFZXR2U7Uh39+WzyBEZHJZMEQQBkvwfe8
 4uZbM9p9SWYeiQMWqzfH21M89dig3o6VhoSggsblZ/rtChAN7lknc71CqjBhFcnrqGAFuT4RncM
 +F3KKntb/WSXzsT/4aUZrQu7z6gLHEoJ4d+jn4mqH+p4/6NfwZgJuTCfKVkZ7Aam376MQQQJpwC
 5oU1Zc1LXB44lLbC3+abdjmLX8g==
X-Received: by 2002:a05:6000:4612:b0:488:88ec:59c3 with SMTP id
 ffacd0b85a97d-4a6389ec4bfmr12781452f8f.14.1795088858908; 
 Thu, 19 Nov 2026 03:47:38 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11f4bsm10344446f8f.51.2026.11.19.03.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:47:38 -0800 (PST)
Message-ID: <c166332638f3f5cc04b7cbde72cdc31a13e1ff67.camel@gmail.com>
Subject: Re: [PATCH v4 13/13] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:47:37 +0100
In-Reply-To: <20261105030612.726542-13-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-13-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with
> MES,
> which the reset uses to map the kernel gfx queue again. Not on SR-IOV
> VFs.
>=20
> The kernel gfx queue and gfx user queue resets then fall back to a
> soft
> reset of the gfx engine before a full reset. The IP block soft reset
> of
> gfx11 only resets the gfx engine then; the whole IP block
> soft_reset()
> isn't used.
>=20
> v4: Not limited to the RS64 firmware anymore, the reset restarts the
> F32
> =C2=A0=C2=A0=C2=A0 PFP and ME of the APUs too (Timur). The soft_reset_eng=
ine()
> callback
> =C2=A0=C2=A0=C2=A0 is set by the patch that adds it. No async gfx ring ch=
eck: they
> are
> =C2=A0=C2=A0=C2=A0 always used now.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 80b91459f5b0..396fe3f6678a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1941,6 +1941,11 @@ static int gfx_v11_0_sw_init(struct
> amdgpu_ip_block *ip_block)
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> +	/* The reset remaps the kernel gfx queue through MES. */
> +	if (!amdgpu_sriov_vf(adev) && adev->enable_mes &&
> +	=C2=A0=C2=A0=C2=A0 !adev->debug_disable_ip_block_soft_reset)
> +		adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
> +
> =C2=A0	if (!adev->enable_mes_kiq) {
> =C2=A0		r =3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE,
> 0);
> =C2=A0		if (r) {
