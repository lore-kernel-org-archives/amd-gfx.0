Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8265DC624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0195010E93C;
	Mon, 31 Aug 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5LVXYtg";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC2010E936
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:12:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-396affa9420so566341a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 08:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189162; cv=none;
 d=google.com; s=arc-20260327;
 b=UP4haBd44llsfF8t4Gd2AVNfUQEv5mM4YDwUdmmKUsUogW9o13iXHRao4av+iOjZ63
 BteV+AitwCgsVm9NpxM9clC/e/vvXtkTTnq3Hz70kWTlLLxyxxr8Y+PeH2zZtEXhp1/H
 muJL8D81Kp7W5MRPUTfBoZCeL7aec0Wy3huCbngaj2HIAVmYasM0jj7TH9lr82vjP4JP
 NPqKxecvXyivhT04CNXAboF16cFSQbSz9FwVt/W5Dt5uFh/rhEDHnJ7RdAV/QHipOlc1
 L9u7IXwlEMPS53ek+08IFNBUDDK9/lLmNhn6m6uAOk4/woIe36woZ/37drY1bnyQ2KK0
 awpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KNz2F5FL3X+97FKxlWbX688M3EAfnkieJCDZE187FV4=;
 fh=zEahUIOi7n4dSdyIGg557basUx0OAfQiRFwjBKA9ayQ=;
 b=oyyzzuYjS5TMIRkSnL9cPtX5dt5r60Crv7W4PUJgKOEQdaGMTf9VLv3vqggUH3csR5
 o8q41Oh8ArwVXwWeBQtTrclIUmd8cVOud8xzBGLUbZD5WOMHB5lDG1DlQsX++YoECiS/
 s4cLdwOa6i4UBK4PAi1elZn9wDy/pzYiE4etQXTvUrrzIO9BjxoRcUgikn7h4GJ7tgZi
 GGN4uupJbK1C79+RCVsMi0+KRFnurU8EQKHGkdz5iotq89rq9bSZHEWHOCRRcNTBhW0Q
 lrC79hbFpZD+mtC2k4pbWyhUDriZuXHFJVuNqQtrKo0RKDhZTGmnUJeUZVnHkrA2J69r
 fChg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788189162; x=1788793962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KNz2F5FL3X+97FKxlWbX688M3EAfnkieJCDZE187FV4=;
 b=N5LVXYtg+eL7qwiYZuGr/ldkM9HifkjPS7xfr+kmyyjnv3GCqX27f5/9eDCyQIfTWk
 eFOIHncTktF6DHNI9fVLtnuLndv3lOIpgKl9OP89GQUMnaQH5iT2ok2mBHipQmHX54fP
 IpZp4zvei/lg1pn2fUZYIhBMyD/ztZbuHuX1cAzB3OsEfzvfFTLFcgxxyTg7hZReCNrw
 HGMC8MTtZdXYQtUuzr+EGpYrJGOmPay7dUz4kdUPLEy75KUwfUR7ivTvI03vw/s4ywgI
 Qp5uFN0WiQcctwAm7rHFY6uWN7inzgDBRh8RZ/JpnyCjuxOZXdDrH6fwq3WNmgFuSJGd
 pA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788189162; x=1788793962;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KNz2F5FL3X+97FKxlWbX688M3EAfnkieJCDZE187FV4=;
 b=ZbbSlX/U+/Wp3ubuH7emz6HVv537h8NSQWvscQU4rkOkEBTkGo0KizioDC6+uyYWkt
 K0x2yn0sG4HgxwsMinKkb698aX1BjGYKR4x3HbRpTHo1gLwjYHO2Hpw06qdQZ+K0n7Z2
 Te59xkQn1cEEc9EKxyAwvz17gWqZZVPYQIuiI2Fm/pk/OB12UuSHCq5nBAhw3aCA2YEf
 c7yYMwIWN0Ibc6wtQ4Bx5pxOzKk+gYauVQTt/G7mso+wuJ34bA9a36Eq/6k29n8VHw9Q
 mMvbZwGSitoOLN1/aGd40rDLJgxVSLHuzS9raAqBp2VLKoky1E1Ze8TgRL1o9+Cdna29
 ioGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykS1pQU+s3MENJzG2PV5hVt3LZ7AolO+lawP/Qi57pbUATltYsv4I1Ew/eAH+l3V23Q7Ub8JqQ@lists.freedesktop.org
X-Gm-Message-State: AFuF++me+/jUTsGiFi3awYENaa6nIg1rRMt+2mupzO6/Q5nCkQWr43nS
 vdRY2Dfglle/ZazxIHK0ZWmH/v5EdYUji+ZFVRDkuzJKYfv7Iyi/YYUyX6F4pp1SIbM5cYL0OPF
 v1ctAPoA8D844xa2rSwgysDxS16g0NwI=
X-Gm-Gg: AYBFou1Z0zFFYpA0GRTYVGUyTaIWhRQkowDQy15sfqm6xvxZ5siqxfrhn121xs9rTH6
 L6jlZYzWPF5NPu7WuykPBMuTSe1oZCUh8Q8+sfMArD5a3CRM11bFsmAj8b+vKFgaxy2SxTTr5b5
 pfBwVomNb3U6VU0NGvGdWt4klCyU4jEiyBcNZzI2hXahybHGrY7SW0WD/QdjiN86I9Wfv9vPcuo
 B4wrpzjY+KcL3b0mTvTpjGTs/RqmVIUVFDBrQaO5Eq61sWOCg0KrjRbZEAxGyY3s+TuMjDFmzhy
 ZAXQETgu8Ox8C5kGTb2gbRn6M1asEqi6bPK8L250RrbAN005TR451RLL79mVcSkdcCu039+PZxO
 XxTfV6f32vPb1FsIVmEV2CB7Sa+Rkvek=
X-Received: by 2002:a17:90b:4fc5:b0:396:63a8:699b with SMTP id
 98e67ed59e1d1-398ba94e732mr14505544a91.1.1788189162213; Mon, 31 Aug 2026
 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
In-Reply-To: <20260831150211.1486154-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 11:12:30 -0400
X-Gm-Features: AcwNN1V2yltu9bjviHXJSmP_xwEeQNWpuWJriUypNt7tqns6Sur8CAC60yGsd58
Message-ID: <CADnq5_Mz1KrT70mLEbJ4EqikmFGGRiJLXXEWF++pfu2LQC+wQQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
 userqueues
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Patches 1 and 2:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Aug 31, 2026 at 11:02=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> Update to the latest stable fw versions where userqueues
> is working as it is expected with major fixes.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index d704ce328e6e..2c160ec9dc57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1655,10 +1655,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         case IP_VERSION(11, 0, 2):
>         case IP_VERSION(11, 0, 3):
>                 if (!adev->gfx.disable_uq &&
> -                   adev->gfx.me_fw_version  >=3D 2420 &&
> -                   adev->gfx.pfp_fw_version >=3D 2580 &&
> -                   adev->gfx.mec_fw_version >=3D 2650 &&
> -                   adev->mes.fw_version[0] >=3D 120) {
> +                   adev->gfx.me_fw_version  >=3D 3090 &&
> +                   adev->gfx.pfp_fw_version >=3D 3190 &&
> +                   adev->gfx.mec_fw_version >=3D 3450 &&
> +                   adev->mes.fw_version[0] >=3D 147) {
>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> --
> 2.34.1
>
