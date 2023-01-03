Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045DEC46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 08:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EF810E3AF;
	Tue,  3 Jan 2023 08:34:18 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708F710E3AF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 08:34:16 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id l26so20537247wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 00:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0izzhhrNWdFVx/zCcb3G0H1KZC0DlC5pPS44RRkZIJI=;
 b=QPnhwYm8UDRKA+tnTfSy1s3tF4YxHTDgJbNYwdsNmglLN/nj/KDGdGMonVBUGcePdP
 4kfaiSW3FYJUuJRfMG4yV3/luyejLJFCo/1RssL+paw894Fp8tCIz5RdkDh0UgPU4Ela
 ccCiKchEDE5LR/oRxbZD43P8yvH2rZn/ow4FRi8C8D1RegS75xpnvA8lgRDxwEgBGnQt
 2qB6kpSX47G8cXnYro2qYAW54zldeNt8pv39IpRsaUziqxmqiJxH6RXyowIJP31EjLez
 7izHivLl38bc+IuebVSoxNggwnubkI7L/7UNh+NwZoQYXL6Kwg8gJuw4/wPGwRwsMcTV
 aP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0izzhhrNWdFVx/zCcb3G0H1KZC0DlC5pPS44RRkZIJI=;
 b=mwVHWNSNHSNtSe5OkJyV9jn7lsARnpCGQGKk3BlioJs/fjVdZ/RCL+17WyKB+rCz0I
 J3xddJw0wi/UxJ6CHNEdUCXmzKAlXZ34tG+VBtIP6x7Qi5wwZY08aDKknsIWe5qNYv+/
 4QtIb3DCyB+wwaLTnV+sxWaukgDV7c5PEOqmjIOCY/6uN2hY5bXvwKa9Yi2RLgAttRyO
 ukr1OEjgjfWuWsJHUIoxO+FYoY9LYXsuOB28v0nCZAE+JBJMpCYIQxClZIupd7CHJ8O1
 QgLRMtJXe59/QMjAM8PugOtfVnfkVW9WWSgxHNHzBmyGTazNzHq+rtboMPnkt2bfgPfG
 U6zA==
X-Gm-Message-State: AFqh2koM0uoHT6FonCJe2g3FcIn4YDDk0DAdXIEv+WXpYa9KgmtQl771
 Cc+zKP6qqgFZPV8nUl7GOx8=
X-Google-Smtp-Source: AMrXdXufoTEmA3R8mVipWkwBM/iDQjbrNpkN2CCsMOuIMnn8S+A6ek52J0Nlkt3V7Zip2qwavhGxgA==
X-Received: by 2002:a05:600c:17c6:b0:3d2:20ec:24be with SMTP id
 y6-20020a05600c17c600b003d220ec24bemr31525545wmo.38.1672734855002; 
 Tue, 03 Jan 2023 00:34:15 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a05600c355100b003d9980c5e7asm22135882wmq.21.2023.01.03.00.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 00:34:14 -0800 (PST)
Message-ID: <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
Date: Tue, 3 Jan 2023 09:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Borislav Petkov <bp@alien8.de>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: mikhail.v.gavrilov@gmail.com, michel@daenzer.net,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I assume that this was already upstreamed while I was on sick leave?

Thanks,
Christian.

Am 21.12.22 um 22:10 schrieb Alex Deucher:
> Applied.  Thanks!
>
> Alex
>
> On Mon, Dec 19, 2022 at 3:01 PM Borislav Petkov <bp@alien8.de> wrote:
>> On Mon, Dec 19, 2022 at 11:47:18AM +0100, Christian König wrote:
>>> That function consumes the reference.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM updates")
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>> Thanks, that fixes it.
>>
>> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
>>
>> --
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette

