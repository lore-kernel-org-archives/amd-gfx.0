Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFAC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3504820715
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 08:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH0oaxDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3504820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86926E997;
	Thu, 17 Sep 2020 08:26:55 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C906E997
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 08:26:55 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id i1so1645407edv.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=n3iu26Xvj02deOTLRe8XMpLvKL9wLx+2ZsB5xPzuzAo=;
 b=NH0oaxDoA6kUFpcuToSsFf6nzFWh21+qeLojYSmsA8qNOmtqPhMXxpuhdaMTK0/6Z4
 nY/kQCq4oIWBS+XueWVhjPitEhNgPuk4r3O9kH+jhavnItTBQcGVeGgvNt4uLn+aasGk
 tG2hsR0NIVjMUsq25AG4Jd8WLsDslzMl9EjS8pcX+C/ZcRhC0cnLDDReafDhIed8+RTy
 BEkuGvBZeCyL2BxCKedXuJVwaPECLrYClOXvbiD90SOsL+SRC2Etg3Sl8eTwFGB4z6u1
 s9iuZweyaDqVVPzPkQb9MNN3VZNGUIByOJadecUbDrxRXEANQQGBCL1fEd7snDIo+vBE
 C5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=n3iu26Xvj02deOTLRe8XMpLvKL9wLx+2ZsB5xPzuzAo=;
 b=bIDd48UJKnACyAxg5FbS8/Rq5sP0h8wVEydMMUrADp+p/zSbueCLc607h94YV2PCk9
 1uE1CJ0D4AUM9w4mV7HvYXQw2Y9FMRKb3PDNXKsbIh65X55fT792yvS53WazZ6PFTOgb
 PklQe/RlzdoHVjFfrug8yK1AvSojxV0vkMrsyQdxyJGc3R8VGR++Q0lfHaFTRJJrkn6F
 wfcq/AKDzTpk8GrdlKBCL7CyDLL3IgxTNe1voM9GlamXbDuzIMoo0SKl6Fvp6hTy5TJv
 IXU5vrRq3DRe4o3wt7+ezoEbL0Nw8gYnKXWadwZA1lXX2cqd4Jq0wvWwtFXw9MnCgVpv
 324A==
X-Gm-Message-State: AOAM533bywBUBKADR1n1GEzm/zWy4UCEczC4io66gLn/fkpYyBulEdZ+
 kfREELrwVRLS2pzFPA27YI4vkm9m+dA=
X-Google-Smtp-Source: ABdhPJx+foUX9zFu+ZRlSdGdU+I9ctjDoJZ31lcFtFMJYwFgIYSADbw5/kBKA8itEqCyblRt1FY/Kw==
X-Received: by 2002:a50:8062:: with SMTP id 89mr30933695eda.241.1600331214239; 
 Thu, 17 Sep 2020 01:26:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o6sm16067554edh.40.2020.09.17.01.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 01:26:53 -0700 (PDT)
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: Alex Deucher <alexdeucher@gmail.com>,
 "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
Date: Thu, 17 Sep 2020 10:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jinlong" <Jinlong.Zhang@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.09.20 um 00:18 schrieb Alex Deucher:
> On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>>> From: jinlong zhang <jinlong.zhang@amd.com>
>>>
>>> [why]
>>> while read edid return defer, then it enter to msleep, but it actually
>>> took more time during msleep, this will cause remaining edid read
>>> fail.
>>>
>>> [how]
>>> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
>> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
>>
>> Alex
>>
>> ---------------------
>>
>> Hi Alex,
>>
>> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?
> I think ARM has a limit of 2ms for udelay.

Yeah, there is even a define somewhere for this.

If you need a delay which is longer than this but still more precise 
than msleep() then there is the high precision timer sleep as alternative.

I've forgotten the function name to use here, but there was a LWN 
article about this a few years ago. You just need to google a bit.

Regards,
Christian.

>
> Alex
>
>> Thank you,
>> Lillian
>>
>>
>>> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
>>> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
>>> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> index 743042d5905a..cdcad82765e0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>>>                                          if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>>>                                                  (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>>>                                                  if (payload->defer_delay > 0)
>>> -                                                       msleep(payload->defer_delay);
>>> +
>>> + udelay(payload->defer_delay * 1000);
>>>                                          }
>>>                                  }
>>>                                  break;
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cqi
>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961fe48
>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHpiup
>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
