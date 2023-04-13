Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD409C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 12:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBCA10E297;
	Thu, 13 Apr 2023 12:26:55 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9966010EADD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 12:26:53 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1842cddca49so17802621fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681388811; x=1683980811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+PW/6zxqsjeDItmeDa1+vQktmJ7gpjXLSTkr+NmZiQ=;
 b=rj7Vw7UlCWBqgbs4zA2GwW70vcIfE4k8fCYC0DzT6i+xlkXO6KOpADXhSznU5h+V/M
 yw5mYBXXRiI5o6e+9/D29yhqPlk0nrQny6y4YaUisF5TQqPJ0dirikgxxeYtFaLqBOAS
 JgvscWvJg0lhRGOUaUnLofBU3CYUHHVTCeImKrMzrXh/PO5jYfNJy0xiZ7wNI/AE4LMo
 KFBpPuPHSFvczwdq6Yh7hFeTskV8WlW4Uz/WpXVuAHrkT6ih1euWIHOAAPdMSKVZuYFX
 t2HRhE5di2J4/rxnSQAX8lZP8XuqjHwxWk9eZOQhoNmZHrO16SPYGjJ+cBpJyY+4FRek
 NR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681388811; x=1683980811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+PW/6zxqsjeDItmeDa1+vQktmJ7gpjXLSTkr+NmZiQ=;
 b=Hr/FyQx04fIu1xtMXK/+UYdIs0TXcxBK4t+Fpl9uG4wV8pAuLBO/koMApz/pBM0PSE
 hRE0uNen+ABo62zCDWO6LW/QTZxVbXMXiyUuVn6AKnygaMUKrr0/UjdLYcckwKSYq35D
 ljMAHHJ2sFaX/GFbQOHdRXbak/ihjhwm/5hw7bSoH7jxEfS5SdNnB6UMyztFbMwjv0Av
 rjFX3S2Oc6gUNlGbeudgOsU1EZ/i0lWbY+w/NHvLygN4qVdPZ4GVQjVvpl1+GkbyFzyr
 DASDEFKNEuh2Y9qwVYQXoB5NwTsK/oDBeMhCTuyedKZd9olORmyRSuR2HzdY9mnsVCsJ
 elAQ==
X-Gm-Message-State: AAQBX9c2+KzMT0kiiVsMDswBH7PLKLKjsvQvvacKXI3kqmqj6EP+ZYB3
 KZ78uPI7eRqUvs4JUjIoDqdhS6IDaAEwsntXaUw=
X-Google-Smtp-Source: AKy350ZqvilMcDKL78aixttFNtnAU+T5kym1yHDi2eldtle/Rh71yd5Hodw/gXKPuBVsowaFA+KTu1ZFqnXfI2Dxz+E=
X-Received: by 2002:a05:6870:390d:b0:184:2e38:c7af with SMTP id
 b13-20020a056870390d00b001842e38c7afmr1223409oap.3.1681388811081; Thu, 13 Apr
 2023 05:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
 <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
 <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
In-Reply-To: <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Apr 2023 08:26:39 -0400
Message-ID: <CADnq5_MrY3QtU_--B=OYD+_+nx6jNyzJfOxBzfoPrmeLJC6h3Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 13, 2023 at 7:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Ok, then we have a problem.
>
> Alex what do you think?

If you program it to 0, FW skips the GDS backup I think so UMD's can
decide whether they want to use it or not, depending on whether they
use GDS.

Alex


>
> Christian.
>
> Am 13.04.23 um 11:21 schrieb Marek Ol=C5=A1=C3=A1k:
>
> That's not why it was removed. It was removed because userspace doesn't u=
se GDS memory and gds_va is always going to be 0.
>
> Firmware shouldn't use it because using it would increase preemption late=
ncy.
>
> Marek
>
> On Sun, Apr 9, 2023, 11:21 Christian K=C3=B6nig <ckoenig.leichtzumerken@g=
mail.com> wrote:
>>
>> We removed the GDS information because they were unnecessary. The GDS si=
ze was already part of the device info before we added the shadow info.
>>
>> But as far as I know the firmware needs valid VAs for all three buffers =
or won't work correctly.
>>
>> Christian.
>>
>> Am 06.04.23 um 17:01 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> There is no GDS shadowing info in the device info uapi, so userspace can=
't create any GDS buffer and thus can't have any GDS va. It's a uapi issue,=
 not what firmware wants to do.
>>
>> Marek
>>
>> On Thu, Apr 6, 2023 at 6:31=E2=80=AFAM Christian K=C3=B6nig <ckoenig.lei=
chtzumerken@gmail.com> wrote:
>>>
>>> That's what I thought as well, but Mitch/Hans insisted on that.
>>>
>>> We should probably double check internally.
>>>
>>> Christian.
>>>
>>> Am 06.04.23 um 11:43 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> GDS memory isn't used on gfx11. Only GDS OA is used.
>>>
>>> Marek
>>>
>>> On Thu, Apr 6, 2023 at 5:09=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
>>>>
>>>> Why that?
>>>>
>>>> This is the save buffer for GDS, not the old style GDS BOs.
>>>>
>>>> Christian.
>>>>
>>>> Am 06.04.23 um 09:36 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>
>>>> gds_va is unnecessary.
>>>>
>>>> Marek
>>>>
>>>> On Thu, Mar 30, 2023 at 3:18=E2=80=AFPM Alex Deucher <alexander.deuche=
r@amd.com> wrote:
>>>>>
>>>>> For GFX11, the UMD needs to allocate some shadow buffers
>>>>> to be used for preemption.  The UMD allocates the buffers
>>>>> and passes the GPU virtual address to the kernel since the
>>>>> kernel will program the packet that specified these
>>>>> addresses as part of its IB submission frame.
>>>>>
>>>>> v2: UMD passes shadow init to tell kernel when to initialize
>>>>>     the shadow
>>>>>
>>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
>>>>> index b6eb90df5d05..3d9474af6566 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>>>  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
>>>>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
>>>>> +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW   0x0a
>>>>>
>>>>>  struct drm_amdgpu_cs_chunk {
>>>>>         __u32           chunk_id;
>>>>> @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>>>         };
>>>>>  };
>>>>>
>>>>> +#define AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW         0x1
>>>>> +
>>>>> +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>>> +       __u64 shadow_va;
>>>>> +       __u64 csa_va;
>>>>> +       __u64 gds_va;
>>>>> +       __u64 flags;
>>>>> +};
>>>>> +
>>>>>  /*
>>>>>   *  Query h/w info: Flag that this is integrated (a.h.a. fusion) GPU
>>>>>   *
>>>>> --
>>>>> 2.39.2
>>>>>
>>>>
>>>
>>
>
