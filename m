Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA92CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08E410E492;
	Wed, 14 Oct 2026 15:26:03 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C9310E492
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:25:57 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-7bf22dcb645so146107137.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 08:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791991556; cv=none;
 d=google.com; s=arc-20260327;
 b=BG7j+G+hmEqhQIjj6oIklANEX7SYaBllxepFWCUWZ67el7l4q5pavHp8mGtP/aubFG
 lMRoXrwCN+mmWik1CX+FDKuINUKZByjk1JS24ExiwhEk0jiyTrXg8cnqGKSz7fShzsya
 fUjgWydzk+SXNeiutCDKM/6bXIvXXjO5oDLE98sW7UCFVFVrTpDaMnJM+7qM3HYx1AE+
 Z1kc7YZVS4l7/QkA+SWol9KmLmXjnqGThA6kpZ5WQb9idxHv5vrOeJeetAgzdI4Y6+h2
 4BLbRTexgLHbn2bJWtAGBFFCvr+W52SpMarzw2hPbHCPnh24q+r133NJFl8mYyQTYmJV
 EEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B+hO8uXqRiwdeWipgAbg8TR0HAE2cdfln/mHoROBuGg=;
 fh=e3wwgkn8QDd9b3SoIw54SQYPmWVFBVy3s9v4EGzJeiI=;
 b=e1XKj7+cQBcWJTLKJwx7UEGE2Aixlk0MU/eRLZD5iZXgpsaVX5dnccJYzZ2aSRty/q
 q+YQS3BajMVb2rISce8nvJtYIZye6npkeIPKyANzOiGtjCpZezYZDU30/UG02WFiyArg
 ACPu9u/uHSX1oQjjHOswfsWbBTduuCzFcC2Y880n9HrvKM6N7omzwMSI/aHbL0uVa+io
 G6rclpOioU9pGvPJAtJqa2/qhSpRxGgwtHAj68EFeesNAt7SBApz4BcP7eoXjMGWbPAY
 dCFZbTTjyuizjqkdJerBWuTCwUl40Oav+Xo/VO0cyPo33ruW0gKg9yTGJ9swLljWRdhU
 EZlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791991556; x=1792596356; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B+hO8uXqRiwdeWipgAbg8TR0HAE2cdfln/mHoROBuGg=;
 b=LCiADi+arjeMHSznsvz9ZrpBD31pf8emt9fmKrJRyAt+VH0O/UTjtCpy67BNX7ogyt
 ssEXDhWKYnBaBFOzZaYjJIGE+JTwMaANP1MvZDhOG9ksHtapNLOx+4Zda+ilYUXzuCRl
 Hl1TW68fT3e8OIc4uFzQNoNKRreGr710QlM3xkgfRNJHu05BMc97EoWprpyQFfbrQR7X
 2bxJV9XSkIRPKZosd6udORUk0d9XebW/ajGg1V1/Zdgx19CDfRPme3yDST9G7cRKokpP
 IGPVStOb2VtPoJ7mF8XwVcLeAqDJHh2W0bkPCQDF5cXGH6ElumWKTZv8b9YGm2ZgfVcq
 NnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991556; x=1792596356;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+hO8uXqRiwdeWipgAbg8TR0HAE2cdfln/mHoROBuGg=;
 b=csBg7j1wnjOrZRksXdUqUjHZN7LCbXeP3HwwTRkzz79BhNH0F2eUs+6TlDYU1Ay429
 zyqiDvw93s4fT74u0pyNKQaIaAeEMz6u/s/rUQzYj4ini8AddQQnNaXgHUrf3rhTb/CP
 9pycie1CfAhwb1q8fDZq9q+Ul+SlO8I7VctqUEEw8Oy/vnH2klya16fWI5vDPAbhWfP9
 djpetodT6Xka8iP3nUK2HrshR/aXWVogfkikKiQRf/oqOfwUxwRJNpTxLpNI4myqLcXd
 yHW+AMGOtAZgkB/aQ2OmCKPHtxgWu0ICM1szzBlwFF8wJdQwUJ97tsY9gp8CgGJDBObq
 S7lA==
X-Gm-Message-State: AFq9FYICT0VfUn59xEvdGbzVaqNyX+5pskRTpdIe2vXuB2X50mpIqLjO
 hxnfmaOSEnjks/oR/PCdBlvSxwODe0fkGO802BCiiHOAg2SSvBwyE+E14bVO6rIDgru6SrGhK5P
 WrIy+7LIxIyNWhI7GO5CEH0j2royx8XY=
X-Gm-Gg: AYBFou310rQ8tdmI2GtbZTW9C0vxfWkW40UreXmIwtP9XEMWxHeKBURVuEj0kfNJ15C
 uaSWTL6UGn7y+/8kl2doh2cXQaoytmYCp0BhJ3hLHgQuoEvElzXIVJzXvmslPeLMhycyxYfkgfO
 1eDl33VzaSPJo4qWIpcVinDcefV74+hXfOogseANxKuH3oao7HyUKg+kCT+TI1gNO4bpuSlMjik
 zwcRwDo88zQc/wTNHEOCM9pcxip6zuVjqJ5JnvPQuvVREnJbulpsAd05xwMIxiV1He7rwC7SYeZ
 Sp4cisPW4Ce17Quy218WOF6jI2qez3xj1/Gn87+EmO09AELB5+1QI38yM/T1qY6Vz/A5TaCZmxl
 hjETmGyZs4viCJB8YpNvecvCZF2OLuZklO4tvq30MMQ==
X-Received: by 2002:a05:6102:a4d:b0:7c3:83a9:edc9 with SMTP id
 ada2fe7eead31-7cb36485419mr4017003137.1.1791991555937; Wed, 14 Oct 2026
 08:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261013222951.763992-1-victor.skvortsov@amd.com>
 <CH0PR12MB51394DEA473C03FEE97A6359F79E2@CH0PR12MB5139.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB51394DEA473C03FEE97A6359F79E2@CH0PR12MB5139.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:25:42 -0400
X-Gm-Features: AclHuK90mpolMxLMmGGo3bZp6Rqil_SFz1b_k9fI53ZWKRRSgolJilYuHC7MKXM
Message-ID: <CADnq5_Nxi+BDOqk8YLWjsGRdwm3CfuEO=XUMryhdPJ8_erLR+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, 
 "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>
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

On Tue, Oct 13, 2026 at 7:11=E2=80=AFPM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> Public
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Vict=
or
> > Skvortsov
> > Sent: Tuesday, October 13, 2026 6:30 PM
> > To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Lu=
o,
> > Zhigang <Zhigang.Luo@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>
> > Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> > Subject: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
> >
> > VFs support same SDMA 7.1 queue reset capabilities as baremetal.
> >
>
> This goes through the MMIO path for kernel SDMA queues.  Assuming that is=
 ok for VFs,

I had a chat with Victor and even though the MMIO parameter passed to
the reset helper is set to true for sdma 7.1, the actual queue reset
code for mes 12.1 never uses MMIO so it should be safe.  @Victor
Skvortsov Please fix the caller to pass false.  With that fixed, feel
free to add my RB.

Alex

> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> > Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > index 21882f2cd2ae..6bea65622086 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > @@ -1333,8 +1333,7 @@ static int sdma_v7_1_sw_init(struct
> > amdgpu_ip_block *ip_block)
> >
> >       adev->sdma.supported_reset =3D
> >               amdgpu_get_soft_full_reset_mask(&adev-
> > >sdma.instance[0].ring);
> > -     if (!amdgpu_sriov_vf(adev) &&
> > -         !adev->debug_disable_gpu_ring_reset)
> > +     if (!adev->debug_disable_gpu_ring_reset)
> >               adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> >
> >       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> > --
> > 2.34.1
>
