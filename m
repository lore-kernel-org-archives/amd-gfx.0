Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760EC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 09:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4506135D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 09:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4506135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CF16E8E9;
	Wed,  7 Apr 2021 09:36:47 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C04A6E8E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 09:36:46 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id s21so1784151eju.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Apr 2021 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HlD/qulg6qMIerUJaRNrh5/jC2YfiRRIAIHF/B325Kc=;
 b=j8quD9d4E5vuMziGBow1U5P44o5HYQoFXYsIs1LYXc+Vfp4kN7pRXZD7k7jgQuSeg7
 cM6sjsnn0Dh8vxpptybQsVxEYA1HzGrSGh0AsfHklbLWkO+Aod/UFANWW/1uM/axLbP8
 JfuSgvz1H5tsjZr8ZFmvOj7MkqtPRa0Qo3RjiBEKGFAwQqbvqAyHnXM7+SALK3Iuv19q
 Q1+fZ9cyRaJl7EltIw4lzss6bywRH7k7cNQjQQDSqcWlvyPkseBjUtsCZcufjMgZmVRC
 uDf2Mb/nocZJqyeoNmiA2taMTmjrCG3gc5TCiqc16C7sVzBIVVtaxbsllUuUq0/l/GhF
 H6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HlD/qulg6qMIerUJaRNrh5/jC2YfiRRIAIHF/B325Kc=;
 b=X603BKlkGZLCVyPd54z1k7kj/9ZVaNA/Hav7AF9ok5odthwJAL304dCI9j2cs8rLei
 9dUUbnfjpJAHhIPD/iUdBLJTyd8/ZFYqVuFlIVgxHMfps2xAKBCK04Zp8/+lPZfq0oe2
 l1NYog6ku1SB4VFOLe/LGZq4QVjmPvzQXaEUb8AjBXJ2WNkz4sW+XbKXuyJZO0Z7l4Ok
 0cTbbeGAG6ObThKwGwRdPGkfxmz6Nb9vc4j1ICG490rdteHxBGw4YHHewU+nQDgcgoGP
 fwK6Z4XxppYadUbB81LazB3+4L9p3GGvpG5LXxobUbJMadZ8TAdM3odqxPqF5MWizgOt
 tDKw==
X-Gm-Message-State: AOAM530ApcyIhPY3eXbHr7YezAnLnQV6j+CVsrXnurqIqwJjNuTz99LH
 q86EefPVkZ9QJP8iBIkb3rgK2Z0dqXE=
X-Google-Smtp-Source: ABdhPJxzguw2sp3BS40mAZRv1PE9KfKVpYbXzZY9jpz2Fgo7msrw//p2Pu4HENbTWDEAcoh8lGYAaA==
X-Received: by 2002:a17:906:19d9:: with SMTP id
 h25mr2719632ejd.453.1617788204912; 
 Wed, 07 Apr 2021 02:36:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c8cb:bea6:b85a:47d0?
 ([2a02:908:1252:fb60:c8cb:bea6:b85a:47d0])
 by smtp.gmail.com with ESMTPSA id l15sm7172473edb.48.2021.04.07.02.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Apr 2021 02:36:44 -0700 (PDT)
Subject: Re: [amdgpu] Compute kernels still run when the host process exit?
To: Alex Deucher <alexdeucher@gmail.com>, Smith John <ls.cat.kth@gmail.com>
References: <CAGztBWXhxjoOAQ2AbiR0KGEV3g0dSxYaWwUGnOg8w70vCW1VuQ@mail.gmail.com>
 <CADnq5_NF6=_cDEW8gxrbEd38EAxfh0y9je9+F7fXKV1Eojdqqg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <133b93cd-f4c0-aa85-cdb1-231e8961ace4@gmail.com>
Date: Wed, 7 Apr 2021 11:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_NF6=_cDEW8gxrbEd38EAxfh0y9je9+F7fXKV1Eojdqqg@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 01.04.21 um 20:22 schrieb Alex Deucher:
> On Thu, Apr 1, 2021 at 10:08 AM Smith John <ls.cat.kth@gmail.com> wrote:
>> Hi, when I killed an OpenCL host process, the kernels it launched were not terminated, and still run.
>>
>> My OpenCL runtime is AMDGPU-PRO 20.20. OS Ubuntu 18.04.5 with  Linux Kernel 5.4.53
>>
>> I was wondering if it was a bug or the driver did not implement this "watchdog" mechanism.
> In general, once you issue work on the GPU it has to run to
> completion.  It is not stopped if the application that issued it goes
> away.

Well that is not 100% correct.

When the job has already been pushed to the hardware it indeed runs till 
the end.

But when the job is still in the scheduler and the process which has 
submitted it is killed we also throw away the job.

This obviously only counts for the classic stack and not for the KFD.

Christian.

>
> Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
