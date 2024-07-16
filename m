Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB5C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 18:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747CC10E2BF;
	Tue, 16 Jul 2024 18:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="p6gL7eOT";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C1210E1B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721154036; x=1721758836; i=friedrich.vock@gmx.de;
 bh=YhQrpoPdnLH7VOeato48tH3U2D9kYu8E/pV/lVLBU/g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=p6gL7eOTVdU5EB73TMOX9Qz4KpwKM4Zqix3fc+dDQeJJFlTKKG2GCCYUxWNigspt
 aZg2jR536eorK41QPks92tTefWv4RlOKTEAXFEzTGYQdBAEyxH+kvI9FpxZG0fehC
 xRa+Npdyg4YGEGImUQS1aG9WyqbuNfiNY4QJHfTtSS57fIXgkwNMse3tfHTKbKEhQ
 bAlDa1UtA9jOdm1P8SHKUkNR8XMqAYm/jIxqR/xAkOaObFRxZBw9NrtUiM8r0lQj7
 Gds20OCzBoGy0qAhe1AT9/0vchNxJdUKWn/kG7R+rNJgyu+8i0CdeamofPxyfRQh7
 r+u2M+mj8CB9+PAUGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.117.92]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1sdv7x0Z6j-00DsKW; Tue, 16
 Jul 2024 20:20:36 +0200
Message-ID: <7ee9f17f-8a75-4818-b54d-efb71a1cd92c@gmx.de>
Date: Tue, 16 Jul 2024 20:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/sdma5.2: Update wptr registers as well as
 doorbell
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240716155449.3203419-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240716155449.3203419-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hsij1UXXblkI13p8+NPMsZaeCYv5gdH3qux1W8iAsVe3OuiH2U4
 u0z+Tm/E4higwXCHL4Rb+bfykNq/v1lHRj8TweBCX5jeXu9FC+wJIHRaeN/9OFhZCm3mKsP
 ZURpgTf5j1H21eJTCvktdzVHsOdJW2zZIfRwDTYU/4yusbLkC1NoIwpGhzl2uK3GKyZYaEl
 xeXJrmlXsXRhWU0cAn3NQ==
UI-OutboundReport: notjunk:1;M01:P0:O2HO9zLIeLs=;rfEDMTurXIkHuLK+Jl8JJwCWCCI
 3Ext4YtVTr3UQUCEn2AqP3lB1ACIvnv5XPRqMYIYmV0b64NYu+smYrAZL03GP1DrJXsW4ihd0
 DZ9rDFCWl8LxiJg7MpqmK41MzLEPVtDv/kjuEK+fpvMAVBGLeXLOKl3RntrwMNug9SqzSgGrp
 1tyhCsrv41toktINq1es+iNls9HxEbspFli1Y/6h/385IKofOGRpvjv8rb4gEh2rn1nXunyGj
 lij1EtoBb3oCTc3gFOfFYPjIBRvaKLcM8a7uo5nHZPOX+93BS+wEUjq0ktJMi+0mQBtTfSwI7
 aANX4a83MuMiqk+MTe9NbBm1w0LaMGkaVbS6WFiFb3CkNCj4wIXfBAP3hMnaqXewMLiBx8tX6
 QOMVOX4lwHRVbvIgqCqWYZQaDCvWb6N+GL+VYpNy7RzbD0mlCgN6QWMf/UyFeL7WFgDflKLJB
 ZaXFTqjk6kCuLNIJdRYyBFgh31h9avyGt4KaUBCnaTL9l7BYATW3zLWghM2y+thtVTTu/47oF
 pA9TSJRs0deRu/HNdt42/KVML07GYV5VScgI6IhQq6jyBHmNL7470HxJnItsZjA0a4x520AU2
 tjkz5xaAoK0h5E3YoWNliCWPO57L20WolaejH6LfBRLZdTWfjW6SzGwJ9DQlT5I0lMtEpQrTA
 wW0OsRzkR69PeLeivUxF6lcs/AfsYLwoeRKgo38pWYOzjBbp1fIKFgURxrKZdWZgd2P7N0Fvs
 kJd11kY1CbrpT8L5FBDpKcwzGENuQMsvL2TiHBbhhLsWtvGfBiby967TtGlW/9v0OaxcYXAV0
 AWOnJp2Poegenp0+hZvO1FtQGvS76WNlEcNsjS3exvb5g=
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

On 16.07.24 17:54, Alex Deucher wrote:
> We seem to have a case where SDMA will sometimes miss a doorbell
> if GFX is entering the powergating state when the doorbell comes in.
> To workaround this, we can update the wptr via MMIO, however,
> this is only safe because we disallow gfxoff in begin_ring() for
> SDMA 5.2 and then allow it again in end_ring().
>
> Enable this workaround while we are root causing the issue with
> the HW team.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/3440
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Looks like it works for me.
Tested-by: Friedrich Vock <friedrich.vock@gmx.de>

Is there a particular reason you chose to still go with the doorbell
path plus updating the wptr via MMIO instead of setting
ring->use_doorbell to false? The workaround shipping in SteamOS does
that - if that has some adverse effects or something like that we should
probably stop :)

Thanks,
Friedrich

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/am=
d/amdgpu/sdma_v5_2.c
> index 7e475d9b554e..3c37e3cd3cbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -225,6 +225,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_r=
ing *ring)
>   		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>   				ring->doorbell_index, ring->wptr << 2);
>   		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
> +		/* SDMA seems to miss doorbells sometimes when powergating kicks in.
> +		 * Updating the wptr directly will wake it. This is only safe because
> +		 * we disallow gfxoff in begin_use() and then allow it again in end_u=
se().
> +		 */
> +		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
> +		       lower_32_bits(ring->wptr << 2));
> +		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_H=
I),
> +		       upper_32_bits(ring->wptr << 2));
>   	} else {
>   		DRM_DEBUG("Not using doorbell -- "
>   				"mmSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> @@ -1707,6 +1715,10 @@ static void sdma_v5_2_ring_begin_use(struct amdgp=
u_ring *ring)
>   	 * but it shouldn't hurt for other parts since
>   	 * this GFXOFF will be disallowed anyway when SDMA is
>   	 * active, this just makes it explicit.
> +	 * sdma_v5_2_ring_set_wptr() takes advantage of this
> +	 * to update the wptr because sometimes SDMA seems to miss
> +	 * doorbells when entering PG.  If you remove this, update
> +	 * sdma_v5_2_ring_set_wptr() as well!
>   	 */
>   	amdgpu_gfx_off_ctrl(adev, false);
>   }
