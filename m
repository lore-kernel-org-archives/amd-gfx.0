Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A87C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DAB10E2F8;
	Mon, 31 Aug 2026 17:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REXcaEXz";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D541610E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 17:02:34 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so444319a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 10:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195754; cv=none;
 d=google.com; s=arc-20260327;
 b=ToNL1nPooolnQukT3DSKRTg82ZH2pNwsGdOEfhNqP6Piw1QwPLhYYtmd1CZYkK2cnd
 Jercu2xoFbtHN2a6VN6gMHclSzE5NfAPzZwYC8AT5i8nFjVDT1LHKv4YNssrfOK3mnOq
 vboY/3lgzRnNCieyML+HusAcryDwmn+09KkKCm6ryScdk0PbFyk51+siiEI/Or1eyPYR
 dEYzNUaiwpp/xPTaYkEkizrlQZh4Jqmq59L1W1dzlnxV6Ng06QOoWrjvGAE/fx/6VWXP
 L7cd47KEdWF1tj79x8wV1qb7r6Bl0HONMAtmR6LquU6AM/R7xe7eA3s5gZjWclqB58j0
 bmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ydVbTgToiXg8lfdc+6VerVJTyD3t94BF8aF7LaDqtDQ=;
 fh=R1ORUM3nj1k0Dk6Ofo6CkqM9I9Y5fwVJFMv87r6Ht+o=;
 b=lQIe/6C2FumT2AKF6t8QYwQm0ae4I5gs5+IHauM/upUZi3iUW2KbjN4lQ7XxnBZOCn
 f6RQ5OOjIh9IHCV/qAOmsZLokksNj2DpIugBO+F9RoCKGBg90wb3JJgSk6RdIFl8pHNw
 yV1AMg0TAOXv4HbVv6aj9GKeW4/nYztJmVsqDW2QXo2oav2K/AmSSMhsHCHWszPYhEel
 XNt2Nbpjw7jXhLQDUxAuYM06OeDahvDhbynXuoEGqQGNiOtwssVw7+rEeZSU6cg2+fAD
 mkS6BF/GoXpWlKnIed7FdpyidOPEi2PhgXIQ5NtEM5jh3AXRyQlzQgDTy6ABPrMBZwTE
 Nmeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195754; x=1788800554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ydVbTgToiXg8lfdc+6VerVJTyD3t94BF8aF7LaDqtDQ=;
 b=REXcaEXzou+jbPhbn45F9wCw0cRYwk6GQWvPtyRVvVS20tHePVSX6aioElwdb1MIk4
 zji5PcaHeGxLwAJlBtmlFN3aa7hoq7v/5Rpuw4JozzCy3ynwKz/7qGtfbRp35U9mdraF
 FW39ojpJN/Je8UEmRmFV0ZyQc1f1Osi/Wsl753k6VygZ95s1XO6JfT7aQLiEfrPtA681
 wuuXdCU4cgPGp6SU6lqAapk4LIE2a/kZJ9P6hzB6PUrQW8I4Eap6NBeUIr9880S1yeHW
 GlPJDcjFplhKE2VBb7VnLTlHSAnBwK/CPeOsoBPvYdrR8WsWmdz6dVvr76je4Xsw2The
 W/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195754; x=1788800554;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ydVbTgToiXg8lfdc+6VerVJTyD3t94BF8aF7LaDqtDQ=;
 b=r4Yz07vQWxVUL3Mlmg5sYCDy+7u6sQBcbwLOmWLiCQcVo9FajOMsmMLy4ALF9Mxzy2
 a1Q9UAme2Gw1MlGeK+dyZyWSX7FuiVk1KvQAA0+Zo7TpvcPuRZLzVUDuEgVHt888SqkN
 KRN0+FmyhPCbKNorLzuED0axcEvFXaKHgSR55TJgknhcgjxHQBh8gwxNiXn/XeZRKZRT
 F0QDxyXhPp7yWVxls6RRJc9SSW5YdgerHTYxDJ30BwLaE2Nj8Y+mRiAeJB6EgEi3HiT5
 TuJ5bbNVI1KAbUOWikzg7nexOmf2PtEAktZnNp2z43j6xr6kVKOEpZ8S/i46rhinwUKn
 aitg==
X-Forwarded-Encrypted: i=1;
 AKwUvByfc3w8dve4qCYWajoAN/P33AB/xRip8TcmZBlHtD0NZUlqbTBr3euK1KSwAhDfwhrsJSJLKlTA@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9lBNdlkenVLi1U2hAPhIMyJdBGDsOl4nuTam3Qo5e6wSroenX
 MCINE7YKH+DoMwx5nLLLhUy3/8GHCzdXSPNCESjrqftozRLgh65+wkpflF/fFXn/BUfX81DEocX
 PIAl/a2VSBUcycZEHfoVHJrrh5qRQSkbfEw==
X-Gm-Gg: AYBFou1aBQz3eXX6wyH7nZTXBu09QvriQXMbiPPKNR8MwHUeHuce7aOyqr/0FcUtV2c
 cxRqypKP5mLu9gaygPiyEe2ZOjBFlMhChGfO94x0qWS1O+a2UWm9/mbY54UHm72uhURdiV/yew4
 +LGj4a+By2MP4xz4R2ztdEsBBq18XatZsj3WrXb26oPZ9+LKvBPNEP+uRVACPsmtWkeQ35niD9l
 3iAxD9d+/JZ9uuW+dlSqgK8g++GXW+ksqQrqbDTQAfAcrwXQ8RuAuKKChaz94eu2LEehdxIQ9nZ
 dxGfFGdu9kdqq9u+Jzzu/MINqWMRE4qyAbPOLo+WjGUqOs8wkLzjJDl0yzv7uqA4bugFfrL6Lyy
 rlt+g+06kfwLmdWhulqEOm5C/3XmTUXs=
X-Received: by 2002:a17:90b:3c82:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-398ba95da1bmr15142926a91.1.1788195754054; Mon, 31 Aug 2026
 10:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260831152701.1162137-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20260831152701.1162137-1-Kanala.RamalingeswaraReddy@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 13:02:20 -0400
X-Gm-Features: AcwNN1UO4YMUXw-lyMJlc2voIjQr1OGXX0etM-lm-dKGH6q8zKoy5DGl4abf1Pw
Message-ID: <CADnq5_PvpFBFmRmOCMz-D78JupxgmmRaKivG0y7m2mXF1XSDxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip accessing psp rum time db for APUs
To: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
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

On Mon, Aug 31, 2026 at 12:05=E2=80=AFPM Kanala Ramalingeswara Reddy
<Kanala.RamalingeswaraReddy@amd.com> wrote:
>
> Psp runtime DB is for dGPUs only.
>
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@am=
d.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index a0f6df5067e6..62d906ede42a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -398,6 +398,13 @@ static bool psp_get_runtime_db_entry(struct amdgpu_d=
evice *adev,
>         bool ret =3D false;
>         int i;
>
> +       if (adev->flags & AMD_IS_APU) {

You can drop the parens around this.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +               /*
> +                * Runtime DB is for dGPUs only.
> +                */
> +               return false;
> +       }
> +
>         if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0,=
 6) ||
>             amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0,=
 12) ||
>             amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0,=
 14) ||
> --
> 2.53.0
>
