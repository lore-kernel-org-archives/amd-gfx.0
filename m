Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC55C77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 11:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8E310EAC7;
	Thu, 13 Apr 2023 11:32:35 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A57510EAC7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:32:34 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id ud9so36393240ejc.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681385552; x=1683977552;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axvkBQSmxOfnY4cBDgnBbqj5aCtLZOml1jKskyCcB8E=;
 b=PAgX2DfuTeaOPWv9JmtJc0KBP6MnMTotvE+xPOmgW4cyhNOXGrrz5DGeSgkFDGTEY6
 8Mt0cd1UEH126PzXJ2QlJSXdwWGOadS1912SSelSwhN7HYMF2FdQSpMzqFuTTqQPgW7h
 7buytMG5wdaw9M9LkKugVncwnVAG+uAOvKltg+JdUqH84oaQ+lSjmYqiMN1Uocm0uzU7
 UtUXlnIJIIQ0WSPxg7Q1tmsWaToJYD7NWO8Gzt4QXdMJbJg1wdERSU2/0I6CkfCARofA
 eCeGBAb9MpN22sophOCv+Rtw7vC/mlgvj3iQ7e60kw3bnM4D0I8AwdPL1LLaUCcshBty
 Crdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681385552; x=1683977552;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=axvkBQSmxOfnY4cBDgnBbqj5aCtLZOml1jKskyCcB8E=;
 b=bKKLKSZGtl4mTXJfRX54z/tfA68PF94VMOI0wqsHJWZKq9LHjboCiO2XsoyTVSoN1Y
 7H24PSTBtQUBInM6AtDTFgsFE+KJ2SmneodmdXtc3V/DLxsIftae/odfKoF2VJuP4pM1
 dc2sbrW1CgagBoOYZ1pRE5X3yXkXqZiQ3b6w+YP48KnAlJZsvHd9NbFEwBaVUzwz0roS
 NV9Ssnl71ykFHuznYAcgX4IPhW36BeLbzvEuAw/urcionxrFaSCtwRr3dB+DEd+KVoOd
 4uqocgmpF/DJPpHsktGCF4Utkwjo96xpAEjbOIWtI2Mg3s7Ua2qyGYkGikVo8TN2nWaQ
 +DmA==
X-Gm-Message-State: AAQBX9dPYnZZRwTrDDr6Combzdpx0l34scifFWITBOth6pKV2gY3F68Z
 euG36htcsBohfSw6+q4tp54U7uMe/ac=
X-Google-Smtp-Source: AKy350aNo5wNuO9+6lFcyuycVfWBGj2xYRS7GCBevDx7fK4ijfuvbtiG9Zn3RW1fY4gnpPghUlHrDw==
X-Received: by 2002:a17:906:aad4:b0:933:4dc8:972d with SMTP id
 kt20-20020a170906aad400b009334dc8972dmr2399236ejb.20.1681385552721; 
 Thu, 13 Apr 2023 04:32:32 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a170906711a00b0094a89683dd9sm831583ejj.218.2023.04.13.04.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 04:32:31 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------UHCX8rPdaKSxJunDKcNyb0kx"
Message-ID: <0e2e1902-54e8-0626-c7ca-3f818f8792fb@gmail.com>
Date: Thu, 13 Apr 2023 13:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 03/13] drm/amdgpu/UAPI: add new CS chunk for GFX shadow
 buffers
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-4-alexander.deucher@amd.com>
 <CAAxE2A7nvmXdUaXESi4g6HVBFxk+dooz7tZYQfjGE8O2fKFi-w@mail.gmail.com>
 <8a98b160-5276-54f5-d166-e12a572892e9@amd.com>
 <CAAxE2A4LzFudfzTNRr290ORZvcF6-xzKiyNM6LZ3uiZDPerf5Q@mail.gmail.com>
 <b1485943-5f0a-1a7e-f0a4-b35771b48a23@gmail.com>
 <CAAxE2A6m346bTD7G=wMa=8OcRmk6OHui9N=Z9B5xHCS4VxxYwQ@mail.gmail.com>
 <2897fa79-f0ef-1ddb-dc38-05ef429fe0d9@gmail.com>
 <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com>
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
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------UHCX8rPdaKSxJunDKcNyb0kx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ok, then we have a problem.

Alex what do you think?

Christian.

Am 13.04.23 um 11:21 schrieb Marek Olšák:
> That's not why it was removed. It was removed because userspace 
> doesn't use GDS memory and gds_va is always going to be 0.
>
> Firmware shouldn't use it because using it would increase preemption 
> latency.
>
> Marek
>
> On Sun, Apr 9, 2023, 11:21 Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     We removed the GDS information because they were unnecessary. The
>     GDS size was already part of the device info before we added the
>     shadow info.
>
>     But as far as I know the firmware needs valid VAs for all three
>     buffers or won't work correctly.
>
>     Christian.
>
>     Am 06.04.23 um 17:01 schrieb Marek Olšák:
>>     There is no GDS shadowing info in the device info uapi, so
>>     userspace can't create any GDS buffer and thus can't have any GDS
>>     va. It's a uapi issue, not what firmware wants to do.
>>
>>     Marek
>>
>>     On Thu, Apr 6, 2023 at 6:31 AM Christian König
>>     <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>         That's what I thought as well, but Mitch/Hans insisted on that.
>>
>>         We should probably double check internally.
>>
>>         Christian.
>>
>>         Am 06.04.23 um 11:43 schrieb Marek Olšák:
>>>         GDS memory isn't used on gfx11. Only GDS OA is used.
>>>
>>>         Marek
>>>
>>>         On Thu, Apr 6, 2023 at 5:09 AM Christian König
>>>         <christian.koenig@amd.com> wrote:
>>>
>>>             Why that?
>>>
>>>             This is the save buffer for GDS, not the old style GDS BOs.
>>>
>>>             Christian.
>>>
>>>             Am 06.04.23 um 09:36 schrieb Marek Olšák:
>>>>             gds_va is unnecessary.
>>>>
>>>>             Marek
>>>>
>>>>             On Thu, Mar 30, 2023 at 3:18 PM Alex Deucher
>>>>             <alexander.deucher@amd.com> wrote:
>>>>
>>>>                 For GFX11, the UMD needs to allocate some shadow
>>>>                 buffers
>>>>                 to be used for preemption.  The UMD allocates the
>>>>                 buffers
>>>>                 and passes the GPU virtual address to the kernel
>>>>                 since the
>>>>                 kernel will program the packet that specified these
>>>>                 addresses as part of its IB submission frame.
>>>>
>>>>                 v2: UMD passes shadow init to tell kernel when to
>>>>                 initialize
>>>>                     the shadow
>>>>
>>>>                 Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>                 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>                 ---
>>>>                  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>>>>                  1 file changed, 10 insertions(+)
>>>>
>>>>                 diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>                 b/include/uapi/drm/amdgpu_drm.h
>>>>                 index b6eb90df5d05..3d9474af6566 100644
>>>>                 --- a/include/uapi/drm/amdgpu_drm.h
>>>>                 +++ b/include/uapi/drm/amdgpu_drm.h
>>>>                 @@ -592,6 +592,7 @@ struct drm_amdgpu_gem_va {
>>>>                  #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>>>                  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT   0x08
>>>>                  #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL 0x09
>>>>                 +#define AMDGPU_CHUNK_ID_CP_GFX_SHADOW  0x0a
>>>>
>>>>                  struct drm_amdgpu_cs_chunk {
>>>>                         __u32           chunk_id;
>>>>                 @@ -708,6 +709,15 @@ struct drm_amdgpu_cs_chunk_data {
>>>>                         };
>>>>                  };
>>>>
>>>>                 +#define
>>>>                 AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW    
>>>>                    0x1
>>>>                 +
>>>>                 +struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>>>                 +       __u64 shadow_va;
>>>>                 +       __u64 csa_va;
>>>>                 +       __u64 gds_va;
>>>>                 +       __u64 flags;
>>>>                 +};
>>>>                 +
>>>>                  /*
>>>>                   *  Query h/w info: Flag that this is integrated
>>>>                 (a.h.a. fusion) GPU
>>>>                   *
>>>>                 -- 
>>>>                 2.39.2
>>>>
>>>
>>
>

--------------UHCX8rPdaKSxJunDKcNyb0kx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Ok, then we have a problem.<br>
    <br>
    Alex what do you think?<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.04.23 um 11:21 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5mf8J_1JJvgPgx-G07zcc3vcHOD6jWUXL8Mhx3g-Zufw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div>That's not why it was removed. It was removed because
          userspace doesn't use GDS memory and gds_va is always going to
          be 0.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Firmware shouldn't use it because using it would
          increase preemption latency.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek<br>
          <br>
          <div class="gmail_quote" dir="auto">
            <div dir="ltr" class="gmail_attr">On Sun, Apr 9, 2023, 11:21
              Christian König &lt;<a
                href="mailto:ckoenig.leichtzumerken@gmail.com"
                moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div> We removed the GDS information because they were
                unnecessary. The GDS size was already part of the device
                info before we added the shadow info.<br>
                <br>
                But as far as I know the firmware needs valid VAs for
                all three buffers or won't work correctly.<br>
                <br>
                Christian.<br>
                <br>
                <div>Am 06.04.23 um 17:01 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="ltr">
                    <div>There is no GDS shadowing info in the device
                      info uapi, so userspace can't create any GDS
                      buffer and thus can't have any GDS va. It's a uapi
                      issue, not what firmware wants to do.<br>
                    </div>
                    <div><br>
                    </div>
                    <div>Marek<br>
                    </div>
                  </div>
                  <br>
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Thu, Apr 6,
                      2023 at 6:31 AM Christian König &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        target="_blank" rel="noreferrer"
                        moz-do-not-send="true"
                        class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0px
                      0px 0px 0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">
                      <div> That's what I thought as well, but
                        Mitch/Hans insisted on that.<br>
                        <br>
                        We should probably double check internally.<br>
                        <br>
                        Christian.<br>
                        <br>
                        <div>Am 06.04.23 um 11:43 schrieb Marek Olšák:<br>
                        </div>
                        <blockquote type="cite">
                          <div dir="ltr">
                            <div>GDS memory isn't used on gfx11. Only
                              GDS OA is used.<br>
                            </div>
                            <div><br>
                            </div>
                            <div>Marek<br>
                            </div>
                          </div>
                          <br>
                          <div class="gmail_quote">
                            <div dir="ltr" class="gmail_attr">On Thu,
                              Apr 6, 2023 at 5:09 AM Christian König
                              &lt;<a
                                href="mailto:christian.koenig@amd.com"
                                target="_blank" rel="noreferrer"
                                moz-do-not-send="true"
                                class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
                              wrote:<br>
                            </div>
                            <blockquote class="gmail_quote"
                              style="margin:0px 0px 0px
                              0.8ex;border-left:1px solid
                              rgb(204,204,204);padding-left:1ex">
                              <div> Why that?<br>
                                <br>
                                This is the save buffer for GDS, not the
                                old style GDS BOs.<br>
                                <br>
                                Christian.<br>
                                <br>
                                <div>Am 06.04.23 um 09:36 schrieb Marek
                                  Olšák:<br>
                                </div>
                                <blockquote type="cite">
                                  <div dir="ltr">
                                    <div>gds_va is unnecessary.</div>
                                    <div><br>
                                    </div>
                                    <div>Marek<br>
                                    </div>
                                  </div>
                                  <br>
                                  <div class="gmail_quote">
                                    <div dir="ltr" class="gmail_attr">On
                                      Thu, Mar 30, 2023 at 3:18 PM Alex
                                      Deucher &lt;<a
                                        href="mailto:alexander.deucher@amd.com"
                                        target="_blank" rel="noreferrer"
                                        moz-do-not-send="true"
                                        class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;
                                      wrote:<br>
                                    </div>
                                    <blockquote class="gmail_quote"
                                      style="margin:0px 0px 0px
                                      0.8ex;border-left:1px solid
                                      rgb(204,204,204);padding-left:1ex">For
                                      GFX11, the UMD needs to allocate
                                      some shadow buffers<br>
                                      to be used for preemption.  The
                                      UMD allocates the buffers<br>
                                      and passes the GPU virtual address
                                      to the kernel since the<br>
                                      kernel will program the packet
                                      that specified these<br>
                                      addresses as part of its IB
                                      submission frame.<br>
                                      <br>
                                      v2: UMD passes shadow init to tell
                                      kernel when to initialize<br>
                                          the shadow<br>
                                      <br>
                                      Reviewed-by: Christian König &lt;<a
href="mailto:christian.koenig@amd.com" target="_blank" rel="noreferrer"
                                        moz-do-not-send="true"
                                        class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
                                      Signed-off-by: Alex Deucher &lt;<a
href="mailto:alexander.deucher@amd.com" target="_blank" rel="noreferrer"
                                        moz-do-not-send="true"
                                        class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
                                      ---<br>
                                       include/uapi/drm/amdgpu_drm.h |
                                      10 ++++++++++<br>
                                       1 file changed, 10 insertions(+)<br>
                                      <br>
                                      diff --git
                                      a/include/uapi/drm/amdgpu_drm.h
                                      b/include/uapi/drm/amdgpu_drm.h<br>
                                      index b6eb90df5d05..3d9474af6566
                                      100644<br>
                                      ---
                                      a/include/uapi/drm/amdgpu_drm.h<br>
                                      +++
                                      b/include/uapi/drm/amdgpu_drm.h<br>
                                      @@ -592,6 +592,7 @@ struct
                                      drm_amdgpu_gem_va {<br>
                                       #define
                                      AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
                                      0x07<br>
                                       #define
                                      AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT 
                                        0x08<br>
                                       #define
                                      AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL 
                                      0x09<br>
                                      +#define
                                      AMDGPU_CHUNK_ID_CP_GFX_SHADOW 
                                       0x0a<br>
                                      <br>
                                       struct drm_amdgpu_cs_chunk {<br>
                                              __u32           chunk_id;<br>
                                      @@ -708,6 +709,15 @@ struct
                                      drm_amdgpu_cs_chunk_data {<br>
                                              };<br>
                                       };<br>
                                      <br>
                                      +#define
                                      AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW 
                                             0x1<br>
                                      +<br>
                                      +struct
                                      drm_amdgpu_cs_chunk_cp_gfx_shadow
                                      {<br>
                                      +       __u64 shadow_va;<br>
                                      +       __u64 csa_va;<br>
                                      +       __u64 gds_va;<br>
                                      +       __u64 flags;<br>
                                      +};<br>
                                      +<br>
                                       /*<br>
                                        *  Query h/w info: Flag that
                                      this is integrated (a.h.a. fusion)
                                      GPU<br>
                                        *<br>
                                      -- <br>
                                      2.39.2<br>
                                      <br>
                                    </blockquote>
                                  </div>
                                </blockquote>
                                <br>
                              </div>
                            </blockquote>
                          </div>
                        </blockquote>
                        <br>
                      </div>
                    </blockquote>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------UHCX8rPdaKSxJunDKcNyb0kx--
