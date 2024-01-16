Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2873AC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 10:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF6810E46C;
	Tue, 16 Jan 2024 10:31:34 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECF010E46C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705401088; x=1706005888; i=friedrich.vock@gmx.de;
 bh=FCzL+VgUrQ9Ss9+iPgvivIiBQzbBScmBMNEyAnJ+YMM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=WVGPua8r4kHuMvKHD8+XQrAp75hbAiRyoVuUUfoeRqf6L+ZKn535XexZ0cbwh4/F
 yuKaN9RevjxVKBVMVB8BB4sl+S0UtUPpGgsEa2jtfCn6fix4pXLsFKDTVx5LEoSeA
 7LRckXXLtzFQoAMuiKPsK83RMO+eEA7sS6cJM7pN5trI2IO2lThQCut6HMYjB9jVB
 M96un4ANBA0cJuNVo+1H5q4GxtnHwoi50Z3tTWYpHagV2HJx8nNALqZI5pZSBwEU9
 gquTDsf4C/a11S5KfDz1TCakB2Gxeic86RNVnY1xVPboVKy1KoUDQpaO8Ae0UG0iZ
 Ku1/8ZcoyuVs44/4vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1r5gou3hE3-017Ef8; Tue, 16
 Jan 2024 11:31:28 +0100
Message-ID: <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
Date: Tue, 16 Jan 2024 11:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q90P310MBrTwjFgFag1bMKG8529P540cItju/VL6ymzDJM7hGxB
 A0I51yF9HzfbApj9WMTiSorzmcgSJQ64ua0gozseyUDjXLUCZNsAbjY4zeGHTJwEUg2GkVf
 wxmzZQXmTznWztYQl+Bz4OYI9THm2d4hcjxRnMfbNAk7ThYGYv8YlXEEe0ujhz+qcZhCF23
 UoGciP275T2fbmAXa+LrQ==
UI-OutboundReport: notjunk:1;M01:P0:hmuxsPDjNlg=;TUUaPh7sIZalVYLw3AMs+cAP5eb
 ct/ZXlyphWJyxnVs0j8npatUuOV61t5tki8wQoLrRRh1m45HbVmcGyrvAdnOMvS9liDeiZVXm
 mEWmf4E6BawQpYGNRXPpWqfQ3h2lPK0ZTx+eTY8b5Cdj2PYPpfwwx9J0u63q2F8dDHDJDVLT8
 Qx/PlXqeEUkNXesWtyj3+DIj2Z/3Yks56vFcIugoR793D11AOfSPpf+uqMWou0PQT7t9CkL21
 NDSKEQLT1lb6VZ6SgKbHsWQF9G4Wc25ZdTrrzgMUcfhvhejcGW6UVAql2EnFc9xKPN9DPirxo
 YGDD1XJ7W5d/QQvC0TFVlUw4/VdXw55J7WPJ9NpSiYVjPj6Fu5FKeryX6pU3fX4nZydpk+q6k
 Dhu8cUyHNXCN81cSIlPd6YdivXOHGKUuujwFiIKm58Glf6/RDzk/tQKzrSTCrC4mhjBnXz3DK
 jeoFJY9FS4c9man2Cos1LuRjHsHdxCp7m2W/453PbpBnSckkWj7gqmyliEzQwRpGIuvo7PmCI
 AmqYeT5w2UMhbcLY1tb+B/E9s+wLLDSnmr3WvSpMGLMju1zqTa4M7LPiiQYrZIJpbbWxj9KR8
 D4d38AoJIS8rm8rrihNjFWliLLg6aY8JYNbQgZyEyRKqMVoCtpnEj4ZxyLlVTTFyr8+3VfDlY
 oXfokwFFRzx8BqlCIEQvgnKq3CaThTK7qGj1RS+yj/5PCp0n2C9pfgfdNpWmgphyAQh9xLaMA
 CoySZlT9LZCDcnZbJPthWvc4fgwZ6IO4VxBMrCxMQMzE2DSyRODwk+iiZRNYBJUK4wCOh7y+d
 2YYybsEVFcz9vi8lzJu/hqC5NZJ7sCTBQ749YrJ5eVYBOKvN7OtgCTr06yWPPda+t9ukZnVpw
 yxTURPcXAKl/tUpC+rofrg1ofhSzttzZpgccFeDkvzq/v2VDlLgk+M83npL+guYGqwIK0o82T
 6nmbGnvUWRlHAojo30ADKQTqRnk=
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16.01.24 08:03, Christian K=C3=B6nig wrote:
> Am 15.01.24 um 12:18 schrieb Friedrich Vock:
>> Adding the original Ccs from the thread since they seemed to be missing
>> in the reply.
>>
>> On 15.01.24 11:55, Christian K=C3=B6nig wrote:
>>> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>>>> Allows us to detect subsequent IH ring buffer overflows as well.
>>>
>>> Well that suggested handling here is certainly broken, see below.
>>>
>>>>
>>>> Cc: Joshua Ashton <joshua@froggi.es>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: stable@vger.kernel.org
>>>>
>>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>>> ---
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h=C2=A0 |=C2=A0 2 ++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/cik_ih.c=C2=A0=C2=A0=C2=A0=C2=A0 | =
13 +++++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/cz_ih.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 14 +++++++++++++-
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 14 +++++++++++++-
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c=C2=A0=C2=A0=C2=A0 | 13 ++=
+++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c=C2=A0=C2=A0=C2=A0 | 13 ++=
+++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/navi10_ih.c=C2=A0 | 12 ++++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/si_ih.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 12 ++++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/tonga_ih.c=C2=A0=C2=A0 | 13 +++++++=
++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/vega10_ih.c=C2=A0 | 12 ++++++++++++
>>>> =C2=A0 drivers/gpu/drm/amd/amdgpu/vega20_ih.c=C2=A0 | 12 ++++++++++++
>>>> =C2=A0 11 files changed, 128 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>>> index 508f02eb0cf8..6041ec727f06 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>>> @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 rptr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs=C2=A0=C2=A0=C2=
=A0 ih_regs;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 bool overflow;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For waiting on IH processing at che=
ckpoint. */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_queue_head_t wait_process;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 processed_timestamp;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> index 6f7c031dd197..807cc30c9e33 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> @@ -204,6 +204,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32=
(mmIH_RB_CNTL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp |=3D IH_RB=
_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB=
_CNTL, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> =C2=A0 }
>>>> @@ -274,7 +275,19 @@ static void cik_ih_decode_iv(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void cik_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp &=3D ~IH_RB_CNTL__WPT=
R_OVERFLOW_CLEAR_MASK;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> Well that is an extremely bad idea. We already reset the overflow
>>> after reading the WPTR.
>>
>> This is not resetting the overflow bit. This is resetting a "clear
>> overflow" bit. I don't have the hardware docs, but the name (and my
>> observations) strongly suggest that setting this bit actually prevents
>> the hardware from setting the overflow bit ever again.
>
> Well that doesn't make any sense at all. The hardware documentation
> clearly states that this bit is write only and should always read as
> zero.
>
> Setting this bit will clear the overflow flag in the WPTR register and
> clearing it has no effect at all.
>
> I could only ping the hw engineer responsible for this block to double
> check if the documentation is somehow outdated, but I really doubt so.
>
I see. I wish I had access to the documentation, but I don't, so all I
can do is tell you what I observe the hardware doing. I've tested this
on both a Steam Deck (OSSYS 5.2.0) and an RX 6700 XT (OSSYS 5.0.3). On
both systems, launching a bunch of shaders that cause page faults leads
to lots of "[gfxhub] page fault" messages in dmesg, followed by an
"amdgpu: IH ring buffer overflow".

If I re-launch the same set of shaders after the GPU has soft-recovered,
the "amdgpu: IH ring buffer overflow" message is missing, even though
the same amount of page faults should've been triggered at roughly the
same rate. Running with this patch applied makes more "amdgpu: IH ring
buffer overflow" messages appear after relaunching the faulting shaders
(but not when processing any non-faulting work).

The only possible conclusion I can draw from this is that clearing that
bit *does* have an effect, and I don't think it's far-fetched to assume
the IH ring buffer overflows still happen after re-launching the
faulting shaders but go undetected so far.

>> Right now, IH overflows, even if they occur repeatedly, only get
>> registered once. If not registering IH overflows can trivially lead to
>> system crashes, it's amdgpu's current handling that is broken.
>
> It's years that we last tested this but according to the HW
> documentation this should work fine.
>
> What could potentially happen is that the IH has silenced the source
> of the overflow. We never implemented resetting those, but in this
> case that here won't help either.
>
If the IH silenced the page faults (which quite clearly cause the
overflow here), then how are the page faults still logged in dmesg?
>>
>> The possibility of a repeated IH overflow in between reading the wptr
>> and updating the rptr is a good point, but how can we detect that at
>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
>> then, because we're guaranteed to miss any overflows that happen while
>> the bit is set.
>
> When an IH overflow is signaled we clear that flag by writing 1 into
> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>
> What can of course happen is that the IH ring buffer overflows more
> than this single entry and we process IVs which are potentially
> corrupted, but we won't miss any additional overflows since we only
> start processing after resetting the flag.
>
> An IH overflow is also something you should *never* see in a
> production system. This is purely for driver bringup and as fallback
> when there is a severe incorrect programming of the HW.
>
> The only exception of that is page fault handling on MI products
> because of a hardware bug, to mitigate this we are processing page
> faults on a separate IH ring on those parts.
>
> On all other hw generations the IH should have some rate limit for the
> number of faults generated per second, so that the CPU is always able
> to catch up.

I'm wondering if there is another bug in here somewhere. Your
explanation of how it's supposed to work makes a lot of sense, but from
what I can tell it doesn't work that way when I test it.

 From the printk_ratelimit stats it would seem like >2000 faults arrive
in less than a second, so perhaps your theory about fault interrupt
ratelimiting not working is correct (but it's hard for me to verify what
is going on without the documentation).

Regards,
Friedrich

>
> Regards,
> Christian.
>
>>
>> Regards,
>> Friedrich
>>
>>>
>>> When you clear the overflow again when updating the RPTR you could
>>> loose another overflow which might have happened in between and so
>>> potentially process corrupted IVs.
>>>
>>> That can trivially crash the system.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 static int cik_ih_early_init(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> index b8c47e0cf37a..076559668573 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>>>> -
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0 static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 static int cz_ih_early_init(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> index aecad530b10a..1a5e668643d1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>>>> -
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_RPTR, ih->rptr);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 static int iceland_ih_early_init(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> index d9ed7332d805..ce8f7feec713 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_c=
ntl);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp=
);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>> +
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> =C2=A0 }
>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &i=
h->ih_regs;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs=
->ih_rb_rptr, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih-=
>ih_regs.ih_rb_cntl);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs=
.ih_rb_cntl, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>> index 8fb05eae340a..668788ad34d9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_c=
ntl);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp=
);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>> +
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> =C2=A0 }
>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &i=
h->ih_regs;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs=
->ih_rb_rptr, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih-=
>ih_regs.ih_rb_cntl);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs=
.ih_rb_cntl, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> index e64b33115848..0bdac923cb4d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_c=
ntl);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp=
);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> =C2=A0 }
>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &i=
h->ih_regs;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs=
->ih_rb_rptr, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih-=
>ih_regs.ih_rb_cntl);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs=
.ih_rb_cntl, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32=
(IH_RB_CNTL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp |=3D IH_RB=
_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_C=
NTL, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> =C2=A0 }
>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0 static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_RPTR, ih->rptr);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(IH_RB_CNTL=
);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp &=3D ~IH_RB_CNTL__WPT=
R_OVERFLOW_CLEAR_MASK;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(IH_RB_CNTL, tmp);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 static int si_ih_early_init(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> index 917707bba7f3..6f5090d3db48 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device
>>>> *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CNTL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring *ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih->use_doorbell) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX check i=
f swapping is necessary on BE */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ih->rptr_cpu =
=3D ih->rptr;
>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB=
_RPTR, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32(mmIH_RB_CN=
TL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmIH_RB_CNTL, tmp)=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 static int tonga_ih_early_init(void *handle)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> index d364c6dd152c..bb005924f194 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_c=
ntl);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp=
);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &i=
h->ih_regs;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs=
->ih_rb_rptr, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih-=
>ih_regs.ih_rb_cntl);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs=
.ih_rb_cntl, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>> index ddfc6941f9d5..bb725a970697 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_c=
ntl);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL,=
 WPTR_OVERFLOW_CLEAR, 1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp=
);
>>>> +=C2=A0=C2=A0=C2=A0 ih->overflow =3D true;
>>>>
>>>> =C2=A0 out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (wptr & ih->ptr_mask);
>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0 static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_ring =
*ih)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 u32 tmp;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ih_regs *ih_regs;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ih =3D=3D &adev->irq.ih_soft)
>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>> amdgpu_device *adev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih_regs =3D &i=
h->ih_regs;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(ih_regs=
->ih_rb_rptr, ih->rptr);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* If we overflowed previously (and thus set the =
OVERFLOW_CLEAR
>>>> bit),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset it here to detect more overflows if=
 they occur.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D RREG32_NO_KIQ(ih-=
>ih_regs.ih_rb_cntl);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D REG_SET_FIELD(tmp=
, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_NO_KIQ(ih->ih_regs=
.ih_rb_cntl, tmp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->overflow =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 }
>>>>
>>>> =C2=A0 /**
>>>> --
>>>> 2.43.0
>>>>
>>>
>
