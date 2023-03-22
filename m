Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DFAC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C9A10E359;
	Wed, 22 Mar 2023 14:52:47 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188A410E359
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:52:45 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id bj20so4379459oib.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679496764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mz0rCRdVWN4AoMt/DnNAfMqGuO+gF5G3WzPKlE1w1R4=;
 b=gvkklTAMqmIRtYK6KNjZaSVPprhNZ90bLYGH11xfxoTgYwJnpr9qGF06dd9YAT36xG
 Pksk7X+Yddz2c9u7LY7RpXCeHdXYyjxc1JBRdbJRMZY/fnqDRmOXdOXUvrjc0uBwgW7F
 TtrKSgg0G7KYgY26F+zrA8dpnMGpY7dejQkiFXhEmAKVdPHzjc4Uro29eweUVh7yWaE1
 ZIamWEH8UNxQJeqIowSb/PouvEdcXZynU+USaMTMTzcgmkRZh+RWRUSn1mN+v+kHr6/H
 9W7VDZEMcinFU+Qc2nb3mSa9cqL5rPRcNvFgyFCpczDTURozba/Mvhg7cekUYou5ysbW
 SSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679496764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz0rCRdVWN4AoMt/DnNAfMqGuO+gF5G3WzPKlE1w1R4=;
 b=aU558p3ELhy7NzVd0zYcN0o+4+KuI6sZ43M9RRysExw6IBDPT4AH73U11hbikNq6Jg
 AGkHw08GFJQeR+zDq5Mbrh4+KAnRXAIsy8j24wAJP4rPEhC3y2YENn4LjeQ2pFBeEfXj
 eUVo3N+a/ulOgjjQHdtuFbTuNWSrRACEeQK11f0W5XctodQh6aJ2iU6rsx7WT1o+fH/9
 4a2wvxDUjZjaRGahI/weT3YCY8vTcgrFlb2roq8GExkEAt2sbL4YafLn7Q5PIH3o6k2I
 NHU/rwJKQzUUOS3CRAENa47FGVpqkteuehSy3HefTvGM46l+INMNRjuY4/L3U+VM/ICo
 mhuw==
X-Gm-Message-State: AO0yUKXcZsKwIaX98hAKTZLGA3rZlqu4UozatlUCs4yAYFAXHgYZD72b
 pCx/gGpMJjOEllVRBdvwYzDepzxAQTKjOJJNbVL3MbL5
X-Google-Smtp-Source: AK7set86wIYZRZEaYkFC9QVpYVKiIBO8acrEowV60/3hESk3PLHr20kdyDmTvPVdYO+Uta0LH6UKprQgD0dPRRccn58=
X-Received: by 2002:a05:6808:203:b0:387:2dbe:7902 with SMTP id
 l3-20020a056808020300b003872dbe7902mr1040937oie.3.1679496764257; Wed, 22 Mar
 2023 07:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
 <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
 <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
 <CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com>
 <ea9ce74c-664c-47de-c750-bd4f3893ac72@amd.com>
 <CAAxE2A7qaVseu8zJRe=2T0QobsT_SErrLS+s0D50CJPkCiVedQ@mail.gmail.com>
In-Reply-To: <CAAxE2A7qaVseu8zJRe=2T0QobsT_SErrLS+s0D50CJPkCiVedQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Mar 2023 10:52:32 -0400
Message-ID: <CADnq5_McsW5Xthrhn2YNWHZQwsgXTW46HaSZM5-+=-YNpe5fDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 22, 2023 at 10:37=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>
> It sounds like the kernel should set the hint based on which queues are u=
sed, so that every UMD doesn't have to duplicate the same logic.

Userspace has a better idea of what they are doing than the kernel.
That said, we already set the video hint in the kernel when we submit
work to VCN/UVD/VCE and we already set hint COMPUTE when user queues
are active in ROCm because user queues don't go through the kernel.  I
guess we could just set 3D by default.  On windows there is a separate
API for fullscreen 3D games so 3D is only enabled in that case.  I
assumed UMDs would want to select a hint, but maybe we should just
select the kernel set something.  I figured vulkan or OpenGL would
select 3D vs COMPUTE depending on what queues/extensions the app uses.

Thinking about it more, if we do keep the hints, maybe it makes more
sense to select the hint at context init.  Then we can set the hint to
the hardware at context init time.  If multiple hints come in from
different contexts we'll automatically select the most aggressive one.
That would also be compatible with user mode queues.

Alex

>
> Marek
>
> On Wed, Mar 22, 2023 at 10:29=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
>>
>> Well that sounds like being able to optionally set it after context crea=
tion is actually the right approach.
>>
>> VA-API could set it as soon as we know that this is a video codec applic=
ation.
>>
>> Vulkan can set it depending on what features are used by the application=
.
>>
>> But yes, Shashank (or whoever requested that) should come up with some c=
ode for Mesa to actually use it. Otherwise we don't have the justification =
to push it into the kernel driver.
>>
>> Christian.
>>
>> Am 22.03.23 um 15:24 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> The hint is static per API (one of graphics, video, compute, unknown). I=
n the case of Vulkan, which exposes all queues, the hint is unknown, so Vul=
kan won't use it. (or make it based on the queue being used and not the uap=
i context state) GL won't use it because the default hint is already 3D. Th=
at makes VAAPI the only user that only sets the hint once, and maybe it's n=
ot worth even adding this uapi just for VAAPI.
>>
>> Marek
>>
>> On Wed, Mar 22, 2023 at 10:08=E2=80=AFAM Christian K=C3=B6nig <christian=
.koenig@amd.com> wrote:
>>>
>>> Well completely agree that we shouldn't have unused API. That's why I s=
aid we should remove the getting the hint from the UAPI.
>>>
>>> But what's wrong with setting it after creating the context? Don't you =
know enough about the use case? I need to understand the background a bit b=
etter here.
>>>
>>> Christian.
>>>
>>> Am 22.03.23 um 15:05 schrieb Marek Ol=C5=A1=C3=A1k:
>>>
>>> The option to change the hint after context creation and get the hint w=
ould be unused uapi, and AFAIK we are not supposed to add unused uapi. What=
 I asked is to change it to a uapi that userspace will actually use.
>>>
>>> Marek
>>>
>>> On Tue, Mar 21, 2023 at 9:54=E2=80=AFAM Christian K=C3=B6nig <ckoenig.l=
eichtzumerken@gmail.com> wrote:
>>>>
>>>> Yes, I would like to avoid having multiple code paths for context crea=
tion.
>>>>
>>>> Setting it later on should be equally to specifying it on creation sin=
ce we only need it during CS.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>>>>
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>>
>>>> When we started this patch series, the workload hint was a part of the=
 ctx_flag only,
>>>>
>>>> But we changed that after the design review, to make it more like how =
we are handling PSTATE.
>>>>
>>>>
>>>>
>>>> Details:
>>>>
>>>> https://patchwork.freedesktop.org/patch/496111/
>>>>
>>>>
>>>>
>>>> Regards
>>>>
>>>> Shashank
>>>>
>>>>
>>>>
>>>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
>>>> Sent: 21 March 2023 04:05
>>>> To: Sharma, Shashank <Shashank.Sharma@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig=
, Christian <Christian.Koenig@amd.com>
>>>> Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to=
 ctx ioctl
>>>>
>>>>
>>>>
>>>> I think we should do it differently because this interface will be mos=
tly unused by open source userspace in its current form.
>>>>
>>>>
>>>>
>>>> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will=
 be immutable for the lifetime of the context. No other interface is needed=
.
>>>>
>>>>
>>>>
>>>> Marek
>>>>
>>>>
>>>>
>>>> On Mon, Sep 26, 2022 at 5:41=E2=80=AFPM Shashank Sharma <shashank.shar=
ma@amd.com> wrote:
>>>>
>>>> Allow the user to specify a workload hint to the kernel.
>>>> We can use these to tweak the dpm heuristics to better match
>>>> the workload for improved performance.
>>>>
>>>> V3: Create only set() workload UAPI (Christian)
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>  include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>>>>  1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h
>>>> index c2c9c674a223..23d354242699 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>>>>  #define AMDGPU_CTX_OP_QUERY_STATE2     4
>>>>  #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>>>>  #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>>>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>>>>
>>>>  /* GPU reset status */
>>>>  #define AMDGPU_CTX_NO_RESET            0
>>>> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>>>>  #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>>>  #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>>>
>>>> +/* GPU workload hints, flag bits 8-15 */
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLO=
AD_HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_=
HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_=
HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_=
HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_=
HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_=
HINT_SHIFT)
>>>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX      AMDGPU_CTX_WORKLOAD_HINT_CO=
MPUTE
>>>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >> AMDGPU_CTX_WORKLOAD_H=
INT_SHIFT)
>>>> +
>>>>  struct drm_amdgpu_ctx_in {
>>>>         /** AMDGPU_CTX_OP_* */
>>>>         __u32   op;
>>>> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>>>>                         __u32   flags;
>>>>                         __u32   _pad;
>>>>                 } pstate;
>>>> +
>>>> +               struct {
>>>> +                       __u32   flags;
>>>> +                       __u32   _pad;
>>>> +               } workload;
>>>>  };
>>>>
>>>>  union drm_amdgpu_ctx {
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>
>>
