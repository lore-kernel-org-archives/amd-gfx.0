Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5DFCD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A8010F186;
	Thu, 28 May 2026 13:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDhTfNHp";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23ABF10F186
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:34:43 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-134a84f0aa7so432521c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975282; cv=none;
 d=google.com; s=arc-20240605;
 b=GPSSD3nQdr3XhGqWfUEU8yZDOw3kfSt/LeXUFm/D9S+RxoLbCGKo7a1Vop31Z1Lo+f
 4X90Iu91Elp6l9x06h71CNl6D2uMY/sQmjxkAbjB/6wpCYg+Z1y7qP787HWZB0ItWlXo
 N0+nTJ/5E+XznjRINuY+ZoELemxFvn/nhDlMlfZCwohGpiqPqGc1QC6NOveOD/eEP6+0
 3wr6Par2T6DUyUWn9UGIgYv7FB7qDnFY+6oR09OUFP5VqSm3C7xNUgndaJymUt7I91/E
 T/HL690XqBbpGbsGljctv2aCyBUwIGnKq7+OMhlZ2cFpqNdSss55ytxE2R49kBHAHp7J
 4yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QBRjKpMiseTmmI/FD0gm9vDF3KRxIoBtPjXs1OInb5E=;
 fh=4IB8b9zzlNUt2YfTf/UTE23DxqjFS22fbCaDpQrB/U8=;
 b=LMveFBJgjHyM8RoCnnqtK4Q4Q+ImvFRKaJw+GHO6Jec/6rLLPEjJ0hR43woIQcpqbs
 4mTEBCBncSbjAtCktOyv7kg8VgZ+TLG9NKlxsYc7esB2C9EzV+JBE5pXWyR1iyqjN1jz
 bdZMW8iWgtoNXqWr0ZOl9UGSQ3yzVcjtqRx7XtHxIlJYu/cG8Pl8xOhYnPeYWJyiO9KP
 EHgw0WkwgEUpVscn7DHlYMSsxSQOph2OclxvebGQRO9oVkT1hK18COlgpVSF4ErTTqD9
 XzLpnM6BHnma8djP0jyxEtIVJsH5ou3RvVjcx9Lyqkt7DWPWC8iF7LJOwxuUkRp1XjdO
 U4ww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975282; x=1780580082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBRjKpMiseTmmI/FD0gm9vDF3KRxIoBtPjXs1OInb5E=;
 b=EDhTfNHpBZ61bMDTdryYsqfMwFivB1MjglccRkdNzayXjDgc+l3Rs7Hmf2mqlkW/+M
 NWEi4EbsXMPTjKymdhDvCskVIJck0QC2DlGc//7LcSnItpI8ipuS5puc8wluCYj9kWQz
 0BFOxyC5SBMruoVBTN4uILZyx2/PLWUv2M+B22wNmdP1repTXl/Ixl4r/+myEQiPXRoH
 adBSG1SOQHH+vdaArNI5oh5/Ofg1m6k23xpn1fW5TCoqPOc9i54lv2aGIhBx2KjhXY+J
 Im+BYAUue0hfFrsgJfmnp4wPoEMYOQH9iro91bwFNC2SpeLEGxEnFgev1+vdKbsQ2HTo
 Gd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975282; x=1780580082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBRjKpMiseTmmI/FD0gm9vDF3KRxIoBtPjXs1OInb5E=;
 b=GWhwvE2cR4aoCgFgpgbDQ83xRTiiEOvcL9gthsEOJ84XCY9sNiH4r2CdXQU7Y8nS7D
 3jZI5OUp3OZrLRhKBGe4LAMs4hxLlJ2dGr9M7MjqFgkKhLIN4hMYVSRPAKNNGXMUNEDk
 dLRkiDSTPM/D3412K4fODeE8CLmq7zi+Z6Pt7L91ddStl0myozMliDKl1/2694gep50v
 6AbnLSDFxdDZdL6fO3FTboKEW143OFLl1hycwcQX+Z5wxQ+3zz7O42+ibPZYZsud4AC3
 bnY4RqqbOTTxMuHHfhZGkSylt0m9xjh+RlBvK+mGm/0OUCiaiWWSMeK1mduOVTDbRdbx
 CDiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ95lZCqTem+H6nqJMl5Q7AW4pe7h6aijP7NpQ9csbqxMGZ1LK/6KmRU89Si+qJH8SXD46oEGuUm@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyi6bs+YVKHBjWCNg6Tw9/zU1QENVdLke2oMMe7lxhl9/y2lzGi
 gz0RFstaDEF368b6cpo0g63N9FsRLlqM1OthcTCUdckx1+4ikUUmirc+lgq/7NG0GLDLIcyC/HA
 ZHviR51e5HRvu1sqj0Q7Wi7XDIas10JKRATYC
X-Gm-Gg: Acq92OF4bAHx5tk1FKf8CZ4xXz4IgtSzYAuw0PBc80AYpvf+s4Wit162SIMbZH54vbi
 VEVasTbxz541Q2NqG+INXE6ut80aVNXBf2tPV3HrgOLoXvd8GyEel4z4Xr5n9p1C20JGG4YxsvH
 dWYSd2IO/Baf/9LH1xxNRwxT37sUCcwJnTqReLiV6hXFcd6FKPpErSXBp2kMWCmzsh150ehRjOz
 dhgU99R2+2OFV0o+yE4ElP3tn2bn5+pZCQ7L2KUy2f/1y45z6ncPDI1SRQVrgY4Pw08opH6bZbZ
 2P1QEHLXeJN+2LCLeJ5zzLwX8ww/WXC2EsDylcKiEFXJhJRwxPiXrkhEfjCgZlBtK/yAmCM9Qtf
 VQwsBwlItgj8ZL60=
X-Received: by 2002:a05:7022:30c:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1377cdc5095mr667249c88.3.1779975282424; Thu, 28 May 2026
 06:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-4-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-4-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:34:29 -0400
X-Gm-Features: AVHnY4ITnpl2XxUAGkKKCVeX-B_V8WulcxEhYoRv7OmtWFd3FtT8VL8xAseeX98
Message-ID: <CADnq5_NkL4f6BZwgc8D9R6_qLNKoSYDYneEC3+x-5gXDGYu+_A@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/amdgpu: add support for IH IP version 6.4.0
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 28, 2026 at 2:49=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> This initializes IH IP version 6.4.0.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 32ceab25ad29..968cac5bcd5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2206,6 +2206,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct=
 amdgpu_device *adev)
>                 break;
>         case IP_VERSION(6, 1, 0):
>         case IP_VERSION(6, 1, 1):
> +       case IP_VERSION(6, 4, 0):
>                 amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
>                 break;
>         case IP_VERSION(7, 0, 0):
> --
> 2.43.0
>
