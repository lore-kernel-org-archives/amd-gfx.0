Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C22C5479D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 15:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2556B10E04C;
	Fri,  6 Jan 2023 15:27:56 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64AAE10E049
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 15:27:54 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so4188051ejb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/at81Ea7UHlmLqxhR/oF/gmCtaBDzvwl6qyvGSMyOE=;
 b=I0XSgTicO7P1guxBgd/zB8Q85NKVFw5OY84AJurYnxYxjKI7gEGI/OEsn8XVb3MUhB
 SlrH6YENsA+Vf58qBl3Y71Us4s3bzoTtz82GNcRA9sLqNHzUc0IU4ru0PBNJDGkwlDUG
 aP2SXhAm+kcO7uXydCvBvuyX01oYWx0jYoHKuiCmoiUEwmnY7SUOk1WkkKD7wnKwX8PC
 WQRkmo5GZGH0reoRsK+gi3BTVHKhhdtWNnOMiwD62TQCj1raRKMj600UFzga1QBG4QSs
 lBwU7pKVdypv/B5QiVfu0HOD+iACc3tSP7ittTeyOdjqSJ7DAfGve6JvIs1IhQVKkiam
 JHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/at81Ea7UHlmLqxhR/oF/gmCtaBDzvwl6qyvGSMyOE=;
 b=NvN2zACK/0iMU+2/gWGrciqOCSBGsXj4aMTkJ8KAITkHdxI3P9GIhuIUfgKcgxxQ7l
 JiT41d/j6YUtpOFja2KVbDTGHhxTRBa2APA6bNddmvH6T/blERL/aTuqlLQlBKjisDSZ
 xKIKvOL5ucD7aJ8hTNKXDq+XfcXEFS6cGjUDYAF3w0DF2FUAZyvE9lJjkVqy0WGZyA1H
 F5p9foq03CmASurpM0wcNepQ4gW7kit4C6dt9alx9nw4vj3WXa7Ob+TRnl2Em5JhfwBs
 B08ds0FbARuY+l12VZo0VKpo5qfXH2OTxURp7ASNVLJSiLDoer6CBjwY7CWrhocA3Mpn
 wLLA==
X-Gm-Message-State: AFqh2koaaNLgM9A13gn7GEZKDc2PvroKQPTr4+M4lxCq/frwAvqgV3dF
 WjElmvYjkmL0a93dbFSgf/I=
X-Google-Smtp-Source: AMrXdXs0xzEW0DKUg2wqZSePvhjFNksQJVvsiyfPN7ONKqY/A6cTvJMxVBE6nu51u5K6DdFPqGsVVg==
X-Received: by 2002:a17:906:36c5:b0:829:594c:8ec8 with SMTP id
 b5-20020a17090636c500b00829594c8ec8mr43407022ejc.29.1673018872879; 
 Fri, 06 Jan 2023 07:27:52 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:9acd:ebc4:b6ac:3425?
 ([2a02:908:1256:79a0:9acd:ebc4:b6ac:3425])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a170906768b00b0084d242d07ffsm274970ejm.8.2023.01.06.07.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jan 2023 07:27:52 -0800 (PST)
Message-ID: <f4c965d9-d985-0030-7411-6d8d0f750058@gmail.com>
Date: Fri, 6 Jan 2023 16:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
 <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
 <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
 <CADnq5_P0Nq-y1U5X4EgYyPSKXOdVsjxX+UOCmzZKnX8FfHC86w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_P0Nq-y1U5X4EgYyPSKXOdVsjxX+UOCmzZKnX8FfHC86w@mail.gmail.com>
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
Cc: michel@daenzer.net, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.01.23 um 15:24 schrieb Alex Deucher:
> On Fri, Jan 6, 2023 at 8:00 AM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>> On Thu, Jan 5, 2023 at 3:03 PM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> That one should be fixed by:
>>>
>>> commit 9f1ecfc5dcb47a7ca37be47b0eaca0f37f1ae93d
>>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> Date:   Wed Nov 23 03:13:03 2022 +0300
>>>
>> Christian,
>> This patch was written Nov. 23, 2022, but still not submitted in 6.2!
> It is in drm-misc-fixes and will be in 6.2 soon:
> https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=69555549cfa42e10f2fdd2699ed4e34d9d4f392b
>
>> Why?
> Patch review and end of year holidays.

And it looks like Dmitry submitted it initially to the wrong branch.

Because of this it wasn't scheduled as fix for 6.2, but rather queued up 
as new feature for 6.3.

This is fixed by now and the patch should show up in the next -rc.

Regards,
Christian.

>
> Alex
>
>> It will close my questions about amdgpu right now.
>>
>> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>
>> --
>> Best Regards,
>> Mike Gavrilov.

