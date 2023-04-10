Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E56C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 15:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D931D10E093;
	Mon, 10 Apr 2023 15:10:42 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2975B10E093
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 15:10:40 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 j1-20020a05600c1c0100b003f04da00d07so6574094wms.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681139438; x=1683731438;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiHlHguPo/KztZ5mdx3wv7eJp4jdFYEK/SRzm4EWhzs=;
 b=CTi1v8fVc9rOA3ufMHse13vRfdWK63+EeUwf4ICeCl1nm87ALiB5QkQmovuekkarlN
 rS0j2zdiSs+AwTreg4snjQOO8SoHpwNrB7IGvFHdwbfJtGsG1Dzyn4Iv3Pc3Apu+NTR6
 UsQhGvZ26TT96V4r3rot3iseqVOl4d84z/c5NVaoELExdfz4NTg3IHMn9JH69plbsRIL
 EXFD0ZkAGPfbFFEskpWDUObJhR+utcyl7EoQKCQCo7YHW6dz7tDnsyWWoFGYOUEwLc4+
 F+QhV1QZB1WSskfTuZ3Qb4yc7ywj8pA8+Nu4aEKi1QGkq+6RrkZriPUyAm8MbZxDWE9f
 8Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681139438; x=1683731438;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MiHlHguPo/KztZ5mdx3wv7eJp4jdFYEK/SRzm4EWhzs=;
 b=Qk4Bnn0bqHH/F2hxVg/0/ksD5VZkoFVqKMH53Ohe9/3mHOsB+VAeZZpQp9Nd8mtbza
 PBy77fmSZCdGp0ezo1lFUwTVYeeYqcTJCcreQ4T5tgYHhuyu+t+WcbWhPDMjXQIT/dIe
 xw8xyzzGgt7oVFkHLJEkeEr/H/HcB6MnMfOccq/XCucu2ho3ODwzXYVkRealgbVvhIcq
 4V0NpfM2NCPAOQ2lU0zqL+4AHficzI5zjXJFbu6Qy55DARfkAYuL7dlbkrPjxajE7I0O
 ZPPOkeSgadV3ouXXM/4Or3YSEKo9PLkbp1akww5K5T4Qo0Y3uLBSZdSGYTiKGFcqNOEY
 o0AQ==
X-Gm-Message-State: AAQBX9eMDoGxTdMuil6/dZvUmrDJJnQxx+wJolYmUQmslEM+JGFtpuYe
 fUXE9uNPJI0lnmL+fygKbD8=
X-Google-Smtp-Source: AKy350btKvqveU8A9x2EqGMGR9+9ELGxcEl3RASYDjh5BbyV4d3aI7WFFfQwaA3jUiqTYVkC3iepNQ==
X-Received: by 2002:a05:600c:2158:b0:3ed:df74:bac7 with SMTP id
 v24-20020a05600c215800b003eddf74bac7mr7699948wml.21.1681139437811; 
 Mon, 10 Apr 2023 08:10:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:12bd:a31c:145a:22ea?
 ([2a02:908:1256:79a0:12bd:a31c:145a:22ea])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a7bc8c3000000b003ee10fb56ebsm14093102wml.9.2023.04.10.08.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 08:10:37 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------qGsNddny9VVlghjkLndkBZzC"
Message-ID: <8f184ac4-347e-9518-f41e-e1ffe8335516@gmail.com>
Date: Mon, 10 Apr 2023 17:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for querying the max ibs in a
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
 <20230409144445.374816-3-bas@basnieuwenhuizen.nl>
 <99dad825-894a-bc00-7a26-6b1b917477d4@gmail.com>
 <CAP+8YyF8-5aVoLBmAUy0rS6rturFk0GMYy6Y6wLA2p9U1P7iAw@mail.gmail.com>
 <7d5bb5e5-91a7-71ba-8fa4-6d1cbcb00b26@gmail.com>
 <CAFF-SiWRNMZazGazpbanW1kzjKFWhzUpbcErn6fKyGB8Q63rsg@mail.gmail.com>
 <CAP+8YyEzB9UoLuTYjmHXDYdTOdE2mFeYN5CzhzpJ3O=VuHTH5g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAP+8YyEzB9UoLuTYjmHXDYdTOdE2mFeYN5CzhzpJ3O=VuHTH5g@mail.gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------qGsNddny9VVlghjkLndkBZzC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.23 um 17:59 schrieb Bas Nieuwenhuizen:
> On Sun, Apr 9, 2023, 5:50 PM Timur Kristóf <timur.kristof@gmail.com> 
> wrote:
>
>
>
>     Christian König <ckoenig.leichtzumerken@gmail.com> ezt írta
>     (időpont: 2023. ápr. 9., Vas 17:38):
>
>         Am 09.04.23 um 17:32 schrieb Bas Nieuwenhuizen:
>         > On Sun, Apr 9, 2023 at 5:30 PM Christian König
>         > <ckoenig.leichtzumerken@gmail.com> wrote:
>         >> Am 09.04.23 um 16:44 schrieb Bas Nieuwenhuizen:
>         >>> We need to introduce a new version of the info struct because
>         >>> libdrm_amdgpu forgot any versioning info in
>         amdgpu_query_hw_ip_info
>         >>> so the mesa<->libdrm_amdgpu interface can't handle
>         increasing the
>         >>> size.
>         >> Those are not forgotten, but simply unnecessary.
>         >>
>         >> The size of the input output structures are given to the
>         IOCTL in bytes
>         >> and additional bytes should be filled with zeros.
>         > At the ioctl side, yes, but it is libdrm_amdgpu filling in
>         the size,
>         > while passing in the struct directly from the client (mesa or
>         > whatever). So if we have new libdrm_amdgpu and old mesa,
>         then mesa
>         > allocates  N bytes on the stack and libdrm_amdgpu happily
>         tells the
>         > kernel in the ioctl "this struct is N+8 bytes long" which
>         would cause
>         > corruption?
>
>         WTF? This has a wrapper in libdrm? Well then that's indeed
>         horrible broken.
>
>         In this case please define the new structure as extension of
>         the old
>         one. E.g. something like:
>
>         struct drm_amdgpu_info_hw_ip2 {
>              struct drm_amdgpu_info_hw_ip    base;
>              ....
>         };
>
>         This way we can make it clear that this is an extension.
>
>
>
>     Can we solve this in userspace by letting mesa pass the struct
>     size to libdrm as well? Or would that create other compatibility
>     issues?
>
>
> That is what the new wrapper in my libdrm patch does, but we still 
> need the new struct to deal with the old broken wrapper.

Let me double check what exactly goes wrong here. I clearly remember 
that while we designed this I've pointed out that structures can't be 
extended when they are part of the libdrm C ABI.

Because of this we added a general query function which takes an enum 
and parameters what to querey and an out buffer with size for the result.

I'm really wondering why this isn't used for this information.

Thanks,
Christian.

>
>
>
>
>
>         Thanks,
>         Christian.
>
>         >
>         > - Bas
>         >
>         >> So you should be able to extend the structures at the end
>         without
>         >> breaking anything.
>         >>
>         >> Regards,
>         >> Christian.
>         >>
>         >>> This info would be used by radv to figure out when we need to
>         >>> split a submission into multiple submissions. radv
>         currently has
>         >>> a limit of 192 which seems to work for most gfx
>         submissions, but
>         >>> is way too high for e.g. compute or sdma.
>         >>>
>         >>> Because the kernel handling is just fine we can just use
>         the v2
>         >>> everywhere and have the return_size do the versioning for us,
>         >>> with userspace interpreting 0 as unknown.
>         >>>
>         >>> Userspace implementation:
>         >>>
>         https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
>         >>>
>         https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>         >>>
>         >>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
>         >>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>         >>> Cc: David Airlie <airlied@gmail.com>
>         >>> ---
>         >>> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++++--
>         >>>    include/uapi/drm/amdgpu_drm.h      | 29
>         +++++++++++++++++++++++++
>         >>>    2 files changed, 34 insertions(+), 2 deletions(-)
>         >>>
>         >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>         >>> index 89689b940493..c7e815c2733e 100644
>         >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>         >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>         >>> @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct
>         drm_amdgpu_info_firmware *fw_info,
>         >>>
>         >>>    static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>         >>>                             struct drm_amdgpu_info *info,
>         >>> -                          struct drm_amdgpu_info_hw_ip
>         *result)
>         >>> +                          struct drm_amdgpu_info_hw_ip2
>         *result)
>         >>>    {
>         >>>        uint32_t ib_start_alignment = 0;
>         >>>        uint32_t ib_size_alignment = 0;
>         >>> @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct
>         amdgpu_device *adev,
>         >>>                return -EINVAL;
>         >>>        }
>         >>>
>         >>> +     result->max_ibs = UINT_MAX;
>         >>>        for (i = 0; i < adev->num_rings; ++i) {
>         >>>                /* Note that this uses that ring types
>         alias the equivalent
>         >>>                 * HW IP exposes to userspace.
>         >>> @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct
>         amdgpu_device *adev,
>         >>>                if (adev->rings[i]->funcs->type ==
>         info->query_hw_ip.type &&
>         >>> adev->rings[i]->sched.ready) {
>         >>>                        ++num_rings;
>         >>> +  result->max_ibs = min(result->max_ibs,
>         >>> +        adev->rings[i]->max_ibs);
>         >>>                }
>         >>>        }
>         >>>
>         >>> @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct
>         drm_device *dev, void *data, struct drm_file *filp)
>         >>>                }
>         >>>                return copy_to_user(out, &ui32, min(size,
>         4u)) ? -EFAULT : 0;
>         >>>        case AMDGPU_INFO_HW_IP_INFO: {
>         >>> -             struct drm_amdgpu_info_hw_ip ip = {};
>         >>> +             struct drm_amdgpu_info_hw_ip2 ip = {};
>         >>>                int ret;
>         >>>
>         >>>                ret = amdgpu_hw_ip_info(adev, info, &ip);
>         >>> diff --git a/include/uapi/drm/amdgpu_drm.h
>         b/include/uapi/drm/amdgpu_drm.h
>         >>> index b6eb90df5d05..45e5ae546d19 100644
>         >>> --- a/include/uapi/drm/amdgpu_drm.h
>         >>> +++ b/include/uapi/drm/amdgpu_drm.h
>         >>> @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>         >>>        __u32 enabled_rb_pipes_mask_hi;
>         >>>    };
>         >>>
>         >>> +/* The size of this struct cannot be increased for
>         compatibility reasons, use
>         >>> + * struct drm_amdgpu_info_hw_ip2 instead.
>         >>> + */
>         >>>    struct drm_amdgpu_info_hw_ip {
>         >>>        /** Version of h/w IP */
>         >>>        __u32  hw_ip_version_major;
>         >>> @@ -1144,6 +1147,32 @@ struct drm_amdgpu_info_hw_ip {
>         >>>        __u32  ip_discovery_version;
>         >>>    };
>         >>>
>         >>> +/* The prefix fields of this are intentionally the same
>         as those of
>         >>> + * struct drm_amdgpu_info_hw_ip. The struct has a v2 to
>         resolve a lack of
>         >>> + * versioning on the libdrm_amdgpu side.
>         >>> + */
>         >>> +struct drm_amdgpu_info_hw_ip2 {
>         >>> +     /** Version of h/w IP */
>         >>> +     __u32  hw_ip_version_major;
>         >>> +     __u32  hw_ip_version_minor;
>         >>> +     /** Capabilities */
>         >>> +     __u64  capabilities_flags;
>         >>> +     /** command buffer address start alignment*/
>         >>> +     __u32  ib_start_alignment;
>         >>> +     /** command buffer size alignment*/
>         >>> +     __u32  ib_size_alignment;
>         >>> +     /** Bitmask of available rings. Bit 0 means ring 0,
>         etc. */
>         >>> +     __u32  available_rings;
>         >>> +     /** version info: bits 23:16 major, 15:8 minor, 7:0
>         revision */
>         >>> +     __u32  ip_discovery_version;
>         >>> +     /** The maximum number of IBs one can submit in a
>         single submission
>         >>> +      * ioctl. (When using gang submit: this is per IP type)
>         >>> +      */
>         >>> +     __u32  max_ibs;
>         >>> +     /** padding to 64bit for arch differences */
>         >>> +     __u32  pad;
>         >>> +};
>         >>> +
>         >>>    struct drm_amdgpu_info_num_handles {
>         >>>        /** Max handles as supported by firmware for UVD */
>         >>>        __u32  uvd_max_handles;
>

--------------qGsNddny9VVlghjkLndkBZzC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 09.04.23 um 17:59 schrieb Bas Nieuwenhuizen:<br>
    <blockquote type="cite"
cite="mid:CAP+8YyEzB9UoLuTYjmHXDYdTOdE2mFeYN5CzhzpJ3O=VuHTH5g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div>On Sun, Apr 9, 2023, 5:50 PM Timur Kristóf &lt;<a
            href="mailto:timur.kristof@gmail.com" moz-do-not-send="true"
            class="moz-txt-link-freetext">timur.kristof@gmail.com</a>&gt;
          wrote:<br>
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div dir="auto">
                <div><br>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">Christian König
                      &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                      ezt írta (időpont: 2023. ápr. 9., Vas 17:38):<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">Am
                      09.04.23 um 17:32 schrieb Bas Nieuwenhuizen:<br>
                      &gt; On Sun, Apr 9, 2023 at 5:30 PM Christian
                      König<br>
                      &gt; &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        rel="noreferrer noreferrer" target="_blank"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                      &gt;&gt; Am 09.04.23 um 16:44 schrieb Bas
                      Nieuwenhuizen:<br>
                      &gt;&gt;&gt; We need to introduce a new version of
                      the info struct because<br>
                      &gt;&gt;&gt; libdrm_amdgpu forgot any versioning
                      info in amdgpu_query_hw_ip_info<br>
                      &gt;&gt;&gt; so the mesa&lt;-&gt;libdrm_amdgpu
                      interface can't handle increasing the<br>
                      &gt;&gt;&gt; size.<br>
                      &gt;&gt; Those are not forgotten, but simply
                      unnecessary.<br>
                      &gt;&gt;<br>
                      &gt;&gt; The size of the input output structures
                      are given to the IOCTL in bytes<br>
                      &gt;&gt; and additional bytes should be filled
                      with zeros.<br>
                      &gt; At the ioctl side, yes, but it is
                      libdrm_amdgpu filling in the size,<br>
                      &gt; while passing in the struct directly from the
                      client (mesa or<br>
                      &gt; whatever). So if we have new libdrm_amdgpu
                      and old mesa, then mesa<br>
                      &gt; allocates  N bytes on the stack and
                      libdrm_amdgpu happily tells the<br>
                      &gt; kernel in the ioctl "this struct is N+8 bytes
                      long" which would cause<br>
                      &gt; corruption?<br>
                      <br>
                      WTF? This has a wrapper in libdrm? Well then
                      that's indeed horrible broken.<br>
                      <br>
                      In this case please define the new structure as
                      extension of the old <br>
                      one. E.g. something like:<br>
                      <br>
                      struct drm_amdgpu_info_hw_ip2 {<br>
                           struct drm_amdgpu_info_hw_ip    base;<br>
                           ....<br>
                      };<br>
                      <br>
                      This way we can make it clear that this is an
                      extension.<br>
                    </blockquote>
                  </div>
                </div>
                <div dir="auto"><br>
                </div>
                <div dir="auto"><br>
                </div>
                <div dir="auto">Can we solve this in userspace by
                  letting mesa pass the struct size to libdrm as well?
                  Or would that create other compatibility issues?</div>
              </div>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">That is what the new wrapper in my libdrm patch
          does, but we still need the new struct to deal with the old
          broken wrapper.</div>
      </div>
    </blockquote>
    <br>
    Let me double check what exactly goes wrong here. I clearly remember
    that while we designed this I've pointed out that structures can't
    be extended when they are part of the libdrm C ABI.<br>
    <br>
    Because of this we added a general query function which takes an
    enum and parameters what to querey and an out buffer with size for
    the result.<br>
    <br>
    I'm really wondering why this isn't used for this information.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAP+8YyEzB9UoLuTYjmHXDYdTOdE2mFeYN5CzhzpJ3O=VuHTH5g@mail.gmail.com">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div dir="auto">
                <div dir="auto"><br>
                </div>
                <div dir="auto"><br>
                </div>
                <div dir="auto"><br>
                </div>
                <div dir="auto">
                  <div class="gmail_quote">
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      <br>
                      Thanks,<br>
                      Christian.<br>
                      <br>
                      &gt;<br>
                      &gt; - Bas<br>
                      &gt;<br>
                      &gt;&gt; So you should be able to extend the
                      structures at the end without<br>
                      &gt;&gt; breaking anything.<br>
                      &gt;&gt;<br>
                      &gt;&gt; Regards,<br>
                      &gt;&gt; Christian.<br>
                      &gt;&gt;<br>
                      &gt;&gt;&gt; This info would be used by radv to
                      figure out when we need to<br>
                      &gt;&gt;&gt; split a submission into multiple
                      submissions. radv currently has<br>
                      &gt;&gt;&gt; a limit of 192 which seems to work
                      for most gfx submissions, but<br>
                      &gt;&gt;&gt; is way too high for e.g. compute or
                      sdma.<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; Because the kernel handling is just
                      fine we can just use the v2<br>
                      &gt;&gt;&gt; everywhere and have the return_size
                      do the versioning for us,<br>
                      &gt;&gt;&gt; with userspace interpreting 0 as
                      unknown.<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; Userspace implementation:<br>
                      &gt;&gt;&gt; <a
href="https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection"
                        rel="noreferrer noreferrer noreferrer"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection</a><br>
                      &gt;&gt;&gt; <a
href="https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection"
                        rel="noreferrer noreferrer noreferrer"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection</a><br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; Link: <a
                        href="https://gitlab.freedesktop.org/drm/amd/-/issues/2498"
                        rel="noreferrer noreferrer noreferrer"
                        target="_blank" moz-do-not-send="true"
                        class="moz-txt-link-freetext">https://gitlab.freedesktop.org/drm/amd/-/issues/2498</a><br>
                      &gt;&gt;&gt; Signed-off-by: Bas Nieuwenhuizen &lt;<a
                        href="mailto:bas@basnieuwenhuizen.nl"
                        rel="noreferrer noreferrer" target="_blank"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">bas@basnieuwenhuizen.nl</a>&gt;<br>
                      &gt;&gt;&gt; Cc: David Airlie &lt;<a
                        href="mailto:airlied@gmail.com" rel="noreferrer
                        noreferrer" target="_blank"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">airlied@gmail.com</a>&gt;<br>
                      &gt;&gt;&gt; ---<br>
                      &gt;&gt;&gt;   
                      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7
                      ++++--<br>
                      &gt;&gt;&gt;    include/uapi/drm/amdgpu_drm.h     
                           | 29 +++++++++++++++++++++++++<br>
                      &gt;&gt;&gt;    2 files changed, 34 insertions(+),
                      2 deletions(-)<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                      &gt;&gt;&gt; index 89689b940493..c7e815c2733e
                      100644<br>
                      &gt;&gt;&gt; ---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                      &gt;&gt;&gt; +++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
                      &gt;&gt;&gt; @@ -360,7 +360,7 @@ static int
                      amdgpu_firmware_info(struct
                      drm_amdgpu_info_firmware *fw_info,<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt;    static int
                      amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
                      &gt;&gt;&gt;                             struct
                      drm_amdgpu_info *info,<br>
                      &gt;&gt;&gt; -                          struct
                      drm_amdgpu_info_hw_ip *result)<br>
                      &gt;&gt;&gt; +                          struct
                      drm_amdgpu_info_hw_ip2 *result)<br>
                      &gt;&gt;&gt;    {<br>
                      &gt;&gt;&gt;        uint32_t ib_start_alignment =
                      0;<br>
                      &gt;&gt;&gt;        uint32_t ib_size_alignment =
                      0;<br>
                      &gt;&gt;&gt; @@ -431,6 +431,7 @@ static int
                      amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
                      &gt;&gt;&gt;                return -EINVAL;<br>
                      &gt;&gt;&gt;        }<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; +     result-&gt;max_ibs = UINT_MAX;<br>
                      &gt;&gt;&gt;        for (i = 0; i &lt;
                      adev-&gt;num_rings; ++i) {<br>
                      &gt;&gt;&gt;                /* Note that this uses
                      that ring types alias the equivalent<br>
                      &gt;&gt;&gt;                 * HW IP exposes to
                      userspace.<br>
                      &gt;&gt;&gt; @@ -438,6 +439,8 @@ static int
                      amdgpu_hw_ip_info(struct amdgpu_device *adev,<br>
                      &gt;&gt;&gt;                if
                      (adev-&gt;rings[i]-&gt;funcs-&gt;type ==
                      info-&gt;query_hw_ip.type &amp;&amp;<br>
                      &gt;&gt;&gt;                   
                      adev-&gt;rings[i]-&gt;sched.ready) {<br>
                      &gt;&gt;&gt;                        ++num_rings;<br>
                      &gt;&gt;&gt; +                   
                       result-&gt;max_ibs = min(result-&gt;max_ibs,<br>
                      &gt;&gt;&gt; +                                   
                             adev-&gt;rings[i]-&gt;max_ibs);<br>
                      &gt;&gt;&gt;                }<br>
                      &gt;&gt;&gt;        }<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; @@ -536,7 +539,7 @@ int
                      amdgpu_info_ioctl(struct drm_device *dev, void
                      *data, struct drm_file *filp)<br>
                      &gt;&gt;&gt;                }<br>
                      &gt;&gt;&gt;                return
                      copy_to_user(out, &amp;ui32, min(size, 4u)) ?
                      -EFAULT : 0;<br>
                      &gt;&gt;&gt;        case AMDGPU_INFO_HW_IP_INFO: {<br>
                      &gt;&gt;&gt; -             struct
                      drm_amdgpu_info_hw_ip ip = {};<br>
                      &gt;&gt;&gt; +             struct
                      drm_amdgpu_info_hw_ip2 ip = {};<br>
                      &gt;&gt;&gt;                int ret;<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt;                ret =
                      amdgpu_hw_ip_info(adev, info, &amp;ip);<br>
                      &gt;&gt;&gt; diff --git
                      a/include/uapi/drm/amdgpu_drm.h
                      b/include/uapi/drm/amdgpu_drm.h<br>
                      &gt;&gt;&gt; index b6eb90df5d05..45e5ae546d19
                      100644<br>
                      &gt;&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
                      &gt;&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
                      &gt;&gt;&gt; @@ -1128,6 +1128,9 @@ struct
                      drm_amdgpu_info_device {<br>
                      &gt;&gt;&gt;        __u32
                      enabled_rb_pipes_mask_hi;<br>
                      &gt;&gt;&gt;    };<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; +/* The size of this struct cannot be
                      increased for compatibility reasons, use<br>
                      &gt;&gt;&gt; + * struct drm_amdgpu_info_hw_ip2
                      instead.<br>
                      &gt;&gt;&gt; + */<br>
                      &gt;&gt;&gt;    struct drm_amdgpu_info_hw_ip {<br>
                      &gt;&gt;&gt;        /** Version of h/w IP */<br>
                      &gt;&gt;&gt;        __u32  hw_ip_version_major;<br>
                      &gt;&gt;&gt; @@ -1144,6 +1147,32 @@ struct
                      drm_amdgpu_info_hw_ip {<br>
                      &gt;&gt;&gt;        __u32  ip_discovery_version;<br>
                      &gt;&gt;&gt;    };<br>
                      &gt;&gt;&gt;<br>
                      &gt;&gt;&gt; +/* The prefix fields of this are
                      intentionally the same as those of<br>
                      &gt;&gt;&gt; + * struct drm_amdgpu_info_hw_ip. The
                      struct has a v2 to resolve a lack of<br>
                      &gt;&gt;&gt; + * versioning on the libdrm_amdgpu
                      side.<br>
                      &gt;&gt;&gt; + */<br>
                      &gt;&gt;&gt; +struct drm_amdgpu_info_hw_ip2 {<br>
                      &gt;&gt;&gt; +     /** Version of h/w IP */<br>
                      &gt;&gt;&gt; +     __u32  hw_ip_version_major;<br>
                      &gt;&gt;&gt; +     __u32  hw_ip_version_minor;<br>
                      &gt;&gt;&gt; +     /** Capabilities */<br>
                      &gt;&gt;&gt; +     __u64  capabilities_flags;<br>
                      &gt;&gt;&gt; +     /** command buffer address
                      start alignment*/<br>
                      &gt;&gt;&gt; +     __u32  ib_start_alignment;<br>
                      &gt;&gt;&gt; +     /** command buffer size
                      alignment*/<br>
                      &gt;&gt;&gt; +     __u32  ib_size_alignment;<br>
                      &gt;&gt;&gt; +     /** Bitmask of available rings.
                      Bit 0 means ring 0, etc. */<br>
                      &gt;&gt;&gt; +     __u32  available_rings;<br>
                      &gt;&gt;&gt; +     /** version info: bits 23:16
                      major, 15:8 minor, 7:0 revision */<br>
                      &gt;&gt;&gt; +     __u32  ip_discovery_version;<br>
                      &gt;&gt;&gt; +     /** The maximum number of IBs
                      one can submit in a single submission<br>
                      &gt;&gt;&gt; +      * ioctl. (When using gang
                      submit: this is per IP type)<br>
                      &gt;&gt;&gt; +      */<br>
                      &gt;&gt;&gt; +     __u32  max_ibs;<br>
                      &gt;&gt;&gt; +     /** padding to 64bit for arch
                      differences */<br>
                      &gt;&gt;&gt; +     __u32  pad;<br>
                      &gt;&gt;&gt; +};<br>
                      &gt;&gt;&gt; +<br>
                      &gt;&gt;&gt;    struct drm_amdgpu_info_num_handles
                      {<br>
                      &gt;&gt;&gt;        /** Max handles as supported
                      by firmware for UVD */<br>
                      &gt;&gt;&gt;        __u32  uvd_max_handles;<br>
                      <br>
                    </blockquote>
                  </div>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------qGsNddny9VVlghjkLndkBZzC--
