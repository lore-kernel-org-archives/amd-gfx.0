Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A4C34021
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937002070B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFJZMAWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937002070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512D06E97C;
	Mon, 17 Feb 2020 15:08:43 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED696E97C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 15:08:41 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y11so20135081wrt.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9WnLCdE0olQ/qwRSIAiEEjEoM39AZ2VSqIJNpRsHR7c=;
 b=fFJZMAWfHoORhYAcQysmgA45ZybuA33511zbOmR4zqy9z+nInxpAgqNqAdQB+lcp7f
 Wr2XiHbzg6OtpELONpYYhwGGHHIQkLXw5W5cG5XMBl4577+iuh88pp1Hs96uj7/jE7yP
 j3uHdZlNWEYrinMvkSTa5Ot5dnxd26vrh3IaGV46L6SMo2r526Vt4lOpOOtMdY8Fd6rI
 /SNlIYKcV9jhYqSJvajHgIPTU/uXq4r8suobYKSfsItELmJlRLLpvBGTJ13eQ8iy9glJ
 tCkuR3r1emugt/Db4SDTsGxIBun4HwsaXWR1UR/aHsXddD4TjNa/7eUbGZt2v1Fj27KI
 gY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=9WnLCdE0olQ/qwRSIAiEEjEoM39AZ2VSqIJNpRsHR7c=;
 b=oqK5L3kqM9Hth9W4yJXD+vNA/Sdxq975qDfDXHPpUM/6HnT4LsGoCgPzzSelyoBw62
 5VV7sf4xwTWQSUnRWFxECg7to1CmN+p2uJsPQMlNaDR5SRS0gyabjMkoUj7gkAbJeYjw
 Qt+fowIGWZ9AdOKtjythRgIFdRYk32PkA7Gin5+QYjKuMsIfa8dz48MEfIAdSXQaVkrp
 4qQWuZuwBDa3Sngm/fa3p0cclB0Jk3cPJ5s/joPdXy1nYPp90u0QL0z30lQbD+KURA78
 TYBPCAqWtrVHpPMSh2U9OEEXIW3ijTBmoG42ayBSbAzVZfglpYQeUvTGlowOhmlxNijD
 kKaQ==
X-Gm-Message-State: APjAAAUSmKJMqjn40CxEL0jbmN3BoiprwVN44wZ0+hy04z75BS7Pp7Z5
 O34XsN82m0xjJ3hAesMLqO+fjMM1
X-Google-Smtp-Source: APXvYqw1IkNWvuoDdIspnTuVN0Z1+5RIpw2u+aWZdYxXLey+fcMHdaitz1mwfEyM9P1F9AblyzlJzg==
X-Received: by 2002:adf:b198:: with SMTP id q24mr23387233wra.188.1581952119883; 
 Mon, 17 Feb 2020 07:08:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z10sm891654wmk.31.2020.02.17.07.08.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Feb 2020 07:08:38 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: Alex Deucher <alexdeucher@gmail.com>, Luben Tuikov <luben.tuikov@amd.com>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
Date: Mon, 17 Feb 2020 16:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.02.20 um 15:44 schrieb Alex Deucher:
> On Fri, Feb 14, 2020 at 7:17 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> Add a AMDGPU_GEM_CREATE_MASK and use it to check
>> for valid/invalid GEM create flags coming in from
>> userspace.
>>
>> Fix a bug in checking whether TMZ is supported at
>> GEM create time.
>>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 ++---------
>>   include/uapi/drm/amdgpu_drm.h           |  2 ++
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index b51a060c637d..74bb79e64fa3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -221,21 +221,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>          int r;
>>
>>          /* reject invalid gem flags */
>> -       if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>> -                     AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>> -                     AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>> -                     AMDGPU_GEM_CREATE_VRAM_CLEARED |
>> -                     AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>> -                     AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
>> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
>> -
> I'd rather keep the list explicit so no one ends up forgetting to
> update the mask the next time new flags are added.

Additional to that this patch is bogus.

We intentionally filter out the flags here which userspace is allowed to 
specify in the GEM interface, but after this patch we would allow all 
flags to be specified.

Christian.



>
> Alex
>
>> +       if (flags & ~AMDGPU_GEM_CREATE_MASK)
>>                  return -EINVAL;
>>
>>          /* reject invalid gem domains */
>>          if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>>                  return -EINVAL;
>>
>> -       if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
>> +       if (!amdgpu_is_tmz(adev) && flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
>>                  DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
>>                  return -EINVAL;
>>          }
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index eaf94a421901..c8463cdf4448 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -141,6 +141,8 @@ extern "C" {
>>    */
>>   #define AMDGPU_GEM_CREATE_ENCRYPTED            (1 << 10)
>>
>> +#define AMDGPU_GEM_CREATE_MASK                  ((1 << 11)-1)
>> +
>>   struct drm_amdgpu_gem_create_in  {
>>          /** the requested memory size */
>>          __u64 bo_size;
>> --
>> 2.25.0.232.gd8437c57fa
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
