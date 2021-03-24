Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA726C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6549E61A14
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6549E61A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166676EBA3;
	Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06666EB8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 14:14:39 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id r12so33145114ejr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FCHZXs+Na6H0beDmf/OCng/T5K6DKQZL7k9xPgulymE=;
 b=CSmURK4SwSnVaLiGIPpo0hW0XaafR3WnY0Kktfn6Q8w2WAkQ2pI/vtZsaqDMr+Rrqm
 3j9+izYQ4UqWXHMKZToSCUpFRjOnIXY8UJy2FWXpJpqMTZ1LwLqfqxHXjI3T7WuIhnJ3
 rDX0OvQ/BcN4cPnIJD1S57p05tgOJZ1lraw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FCHZXs+Na6H0beDmf/OCng/T5K6DKQZL7k9xPgulymE=;
 b=F6GHMyJaJZI3ujdWTGsY47Kh5Mt859zNZrYLotWeUq0dRwGZ7agm1/ZCZscdbS9qB5
 pRZTmGCCjciLAjf3aYRa88QifwqdjrUIZVxmOUcv2/V9QTk/Zklx2Jx3v+hZHK2dYFLT
 s2jxRf4SSKx3oZ5zlmNLFtQlS9KxRhv+c7q6KKgS+1ahS9r8l3ZkWT7ToWvMO7YOqQmD
 3PmKqlBraDaHf5O15MtdgaTayxe80/zgH2ZZvBC7JYIHU4tCSR+tfZa3pks+5apwD71I
 6VsmaQ64s+qNG/6qWp3zrsvfZSpBgqhoF1WQhLS0VkMoTeNzUnJ/6+Wff6HwHnj6Y8ng
 27Uw==
X-Gm-Message-State: AOAM530nvJVb89a2sodpU/Dv6kENIK+sM39bLuQy+g8mjCY+jZWTVP/0
 I2gQ/Mcd3Yaa0pZPz8cS8IUheA==
X-Google-Smtp-Source: ABdhPJww1pdM64UL62x05vVdAART6xCBNzDfZeqUIHi/5inBRmV8dfVIuzHdABjEJtiJD1nhk3/fww==
X-Received: by 2002:a17:906:8447:: with SMTP id
 e7mr3979848ejy.523.1616595278353; 
 Wed, 24 Mar 2021 07:14:38 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
 by smtp.gmail.com with ESMTPSA id c10sm1179885edt.64.2021.03.24.07.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 07:14:37 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To: Arnd Bergmann <arnd@kernel.org>
References: <20210323130430.2250052-1-arnd@kernel.org>
 <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
 <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4e63dbbc-0aa3-2950-dda1-1e6aa19d7d5d@rasmusvillemoes.dk>
Date: Wed, 24 Mar 2021 15:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 24 Mar 2021 14:16:42 +0000
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 24/03/2021 14.33, Arnd Bergmann wrote:
> On Tue, Mar 23, 2021 at 4:57 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On 23/03/2021 14.04, Arnd Bergmann wrote:
>>>                       if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
>>> +                             int pos = 0;
>>>                               memset(i2c_output,  0, sizeof(i2c_output));
>>>                               for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
>>> -                                     sprintf(i2c_output, "%s 0x%X", i2c_output,
>>> +                                     pos += sprintf(i2c_output + pos, " 0x%X",
>>>                                               securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
>>>                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
>>
>> Eh, why not get rid of the 256 byte stack allocation and just replace
>> all of this by
>>
>>   dev_info(adev->dev, ""SECUREDISPLAY: I2C buffer out put is: %*ph\n",
>> TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
>> securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
>>
>> That's much less code (both in #LOC and .text), and avoids adding yet
>> another place that will be audited over and over for "hm, yeah, that
>> sprintf() is actually not gonna overflow".
>>
>> Yeah, it'll lose the 0x prefixes for each byte and use lowercase hex chars.
> 
> Ah, I didn't know the kernel's sprintf could do that, that's really nice.

If you're bored, you can "git grep -E -C4 '%[0.]2[xX]'" and find places
that are inside a small loop, many can trivially be converted to %ph,
though often with some small change in formatting. If you're lucky, you
even get to fix real bugs when people pass a "char" to %02x and "know"
that that will produce precisely two bytes of output, so they've sized
their stack buffer accordingly - boom when "char" happens to be signed
and one of the bytes have a value beyond ascii and %02x produces 0xffffffXX.

%ph has a hard-coded upper bound of 64 bytes, I think that's silly
because people instead do these inefficient and very verbose loops
instead, wasting stack, .text and runtime.

Rasmus
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
