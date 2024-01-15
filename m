Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32604C4707C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 11:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC2F10E267;
	Mon, 15 Jan 2024 11:18:49 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F3C10E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705317523; x=1705922323; i=friedrich.vock@gmx.de;
 bh=wFR4I7buKB5Bw/g8UZD4V16jR4rbvKJJWpE42QT+Cdg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=EcF/1qdZuX0UVcS3seLVjQGyNWRsuOLAgTPCjywqq8Ou62NhCGVSjIsTKKAkbx93
 M+ZCyDXAyCFcEapQHbEFfVdqImxOwfyj61nuYVE1R744devUSEEN1STCu3LRM7l9N
 O9O9kSgeAPIAWavNcH2bNqd4JZrjGKhGXVMdI+R7A/VW5AixVAzqlYn5ls9RLlFae
 0fTsLoZA6ZEXNK6BhpsyRTX4ceH9E7zUyHwQzxKCbv8BbF5WL8uafznEnkUosSdCl
 9Zm8yuMQUaNaJluXg5n1mqgog2MOGbAsTr1NC0F85OgxtBgZ/oHz7qYtUJnQL1iu4
 Vns2v+Ijlw41sNzxLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.95.157] ([134.34.7.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1r3Hvu25GD-014WT9; Mon, 15
 Jan 2024 12:18:43 +0100
Message-ID: <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
Date: Mon, 15 Jan 2024 12:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
From: Friedrich Vock <friedrich.vock@gmx.de>
In-Reply-To: <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0THP9mEoBGrGT0zK/xu34DtLLk/AwXAWPw/cCS+7gASxxyKFNt
 lCVnD9/t0A617+7337ser4Ie1Q1uZNdkYv5g2WJ4T6hpvcOiDoAzAk8QuMBidmxtxxCD22P
 /K9q6qbBIdLEwxoiT6/VC+a7l3Y+KUchc0tNx92jqO4zZ1CTV25UhKiEDiF74ARuP6Ipeaw
 ivNFFItIGkC8zGa/8o4zQ==
UI-OutboundReport: notjunk:1;M01:P0:dEHx8rujEDM=;B0j9l7ctrgz3IEFwj3ZStumZnsu
 ul73gTybed5nXkt2oK9Dlc0MA3SwpdjgRtQs7QnNox7Gr7gQysH2YOh/lP9n39/tyOBys7xsQ
 HVUmK0pVIKpdkTXetXRnw2hvbvK76IIl/n2oS1vxmXiwxQnmV3K9bHA0cHXWF/qcc4y40ew8h
 Q0tYXuJ1pw6pKvKMHb2imt+JZod453h4GaUK9lhp8PJgSl+yOqBNWHF2LV7jmi8wK7fUgYeU/
 snf+Ts++1UMoDipocBl/D3Lf7UkkIH+SRRPSAG+o9jwKOrNzZQsCv5v+Wg6ZDkVgjaWcniFhi
 k5G+jO3NdlMAzWgfZKLtCchOX2lH4a1FlCfb31721OnFfr9huWC4mS0zpiJLvWQH3DGeh6JI8
 WV6ikGFYJUPviJpFMWr4SNWG6ldZgAcLVYaLv6DzTWHwIyWIolmXPtEFfRxVNUlWTx82ieliD
 QKY0kQ46IriXbHlHPQD7wKr+dFiah7gH/j8wwRNgodp7Ii9QoxU/PFw8E6r6FNxnBGtmRFWiM
 XbKACrZnNerLO0Vq9/DR9HpEK+NmfDs7SXwgsxZ1P552UGU17+UnEHF2sgA41krQO5zhFQeLD
 7GAItZ+D25qASnv4ZFdL+/ZBD3fWVA2tNQIWgnNWaLO37aghX7jy8PVJw/dAgAF9h7NgFTocZ
 GjgDboQaSQG9s772iycTjqHDL+91d6rLQoTVMuQWpBJtCfnFU7yXFp5bkIOfHTeIfxXGR6EOy
 KtPW5pN9AP3joUcXRGYyJrSOOVVjL45Y1HnW3oKomTCaRjB88WkwYPhw++Ij/shX16tN8USHl
 +XMK8a3WHMl1u3lstfiDIrfxhERsigqxKY8XFDH3tu3nmtYqwz8vZ4+0GEQsq/yQAMF+RwvOr
 9hq62NKV1VF0qZm3FOHgxikG5djyo+Ltg+QP8XvWrtyn5HtBUXwNvhW8B2FpUtBec2RGy8YCY
 CHgRLNB2sRZAbX2rxVHIBxmspRM3Kbu/QdCPydwwHqNpPkDV2tti99Huo5i+0lWu5rwSuA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Joshua Ashton <joshua@froggi.es>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding the original Ccs from the thread since they seemed to be missing
in the reply.

On 15.01.24 11:55, Christian K=C3=B6nig wrote:
> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>> Allows us to detect subsequent IH ring buffer overflows as well.
>
> Well that suggested handling here is certainly broken, see below.
>
>>
>> Cc: Joshua Ashton <joshua@froggi.es>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> ---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h=C2=A0 |=C2=A0 2 ++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/cik_ih.c=C2=A0=C2=A0=C2=A0=C2=A0 | 13=
 +++++++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/cz_ih.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 14 +++++++++++++-
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 14 +++++++++++++-
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c=C2=A0=C2=A0=C2=A0 | 13 ++++=
+++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c=C2=A0=C2=A0=C2=A0 | 13 ++++=
+++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/navi10_ih.c=C2=A0 | 12 ++++++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/si_ih.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 12 ++++++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/tonga_ih.c=C2=A0=C2=A0 | 13 +++++++++=
++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/vega10_ih.c=C2=A0 | 12 ++++++++++++
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/vega20_ih.c=C2=A0 | 12 ++++++++++++
>> =C2=A0 11 files changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> index 508f02eb0cf8..6041ec727f06 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>> @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 rptr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs=C2=A0=C2=A0=C2=A0 =
ih_regs;
>>
>> +=C2=A0=C2=A0=C2=A0 bool overflow;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For waiting on IH processing at check=
point. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_queue_head_t wait_process;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 processed_timestamp;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> index 6f7c031dd197..807cc30c9e33 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> @@ -204,6 +204,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(m=
mIH_RB_CNTL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp |=3D IH_RB_C=
NTL__WPTR_OVERFLOW_CLEAR_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_C=
NTL, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> =C2=A0 }
>> @@ -274,7 +275,19 @@ static void cik_ih_decode_iv(struct
>> amdgpu_device *adev,
>> =C2=A0 static void cik_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp &=3D ~IH_RB_CNTL__WPTR_=
OVERFLOW_CLEAR_MASK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>
> Well that is an extremely bad idea. We already reset the overflow
> after reading the WPTR.

This is not resetting the overflow bit. This is resetting a "clear
overflow" bit. I don't have the hardware docs, but the name (and my
observations) strongly suggest that setting this bit actually prevents
the hardware from setting the overflow bit ever again.

Right now, IH overflows, even if they occur repeatedly, only get
registered once. If not registering IH overflows can trivially lead to
system crashes, it's amdgpu's current handling that is broken.

The possibility of a repeated IH overflow in between reading the wptr
and updating the rptr is a good point, but how can we detect that at
all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
then, because we're guaranteed to miss any overflows that happen while
the bit is set.

Regards,
Friedrich

>
> When you clear the overflow again when updating the RPTR you could
> loose another overflow which might have happened in between and so
> potentially process corrupted IVs.
>
> That can trivially crash the system.
>
> Regards,
> Christian.
>
>> =C2=A0 }
>>
>> =C2=A0 static int cik_ih_early_init(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> index b8c47e0cf37a..076559668573 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> -
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_device
>> *adev,
>> =C2=A0 static void cz_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static int cz_ih_early_init(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> index aecad530b10a..1a5e668643d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> -
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>> amdgpu_device *adev,
>> =C2=A0 static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static int iceland_ih_early_init(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index d9ed7332d805..ce8f7feec713 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cnt=
l);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>> +
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> =C2=A0 }
>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>> amdgpu_device *adev,
>> =C2=A0 static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &ih-=
>ih_regs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs->=
ih_rb_rptr, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih->i=
h_regs.ih_rb_cntl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs.i=
h_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> index 8fb05eae340a..668788ad34d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cnt=
l);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>> +
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> =C2=A0 }
>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>> amdgpu_device *adev,
>> =C2=A0 static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &ih-=
>ih_regs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs->=
ih_rb_rptr, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih->i=
h_regs.ih_rb_cntl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs.i=
h_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index e64b33115848..0bdac923cb4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cnt=
l);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> =C2=A0 }
>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>> amdgpu_device *adev,
>> =C2=A0 static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &ih-=
>ih_regs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs->=
ih_rb_rptr, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih->i=
h_regs.ih_rb_cntl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs.i=
h_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> index 9a24f17a5750..ff35056d2b54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(I=
H_RB_CNTL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp |=3D IH_RB_C=
NTL__WPTR_OVERFLOW_CLEAR_MASK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_CNT=
L, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> =C2=A0 }
>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_device
>> *adev,
>> =C2=A0 static void si_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_RPTR, ih->rptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(IH_RB_CNTL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp &=3D ~IH_RB_CNTL__WPTR_=
OVERFLOW_CLEAR_MASK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static int si_ih_early_init(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> index 917707bba7f3..6f5090d3db48 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device
>> *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>> amdgpu_device *adev,
>> =C2=A0 static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX check if =
swapping is necessary on BE */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ih->rptr_cpu =
=3D ih->rptr;
>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_R=
PTR, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static int tonga_ih_early_init(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index d364c6dd152c..bb005924f194 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cnt=
l);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>> amdgpu_device *adev,
>> =C2=A0 static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &ih-=
>ih_regs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs->=
ih_rb_rptr, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih->i=
h_regs.ih_rb_cntl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs.i=
h_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index ddfc6941f9d5..bb725a970697 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cnt=
l);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>
>> =C2=A0 out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>> amdgpu_device *adev,
>> =C2=A0 static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>> amdgpu_device *adev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &ih-=
>ih_regs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs->=
ih_rb_rptr, ih->rptr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the OV=
ERFLOW_CLEAR
>> bit),
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if t=
hey occur.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih->i=
h_regs.ih_rb_cntl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, =
IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs.i=
h_rb_cntl, tmp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 /**
>> --
>> 2.43.0
>>
>
