Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DBC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 07:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2186101D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 07:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2186101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9945189D84;
	Tue,  6 Apr 2021 07:18:17 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD4889D9B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 07:18:15 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id u21so20232217ejo.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Apr 2021 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=37O4gAOuYSPlU8i6q3QTfAAbwSJq1xi7m9l2elaesZM=;
 b=MYysaw+Wbh1xZXZziMKLxevHgU1ponoexkGpdylpqs4Xe0xOS3PLyIWBybCelIhXwK
 rruq1wCuJecoN9A4zUwI/Gci4Czs4h43HMhSIzhb3ZjzPcU6eOKsHx5LwP2QJILKW3SO
 LwyjGrFnJUTHJLQ17P+y0B6/aN5YYENeVkVynEhTF8aa88toW0z3unkxelIgKGZrzZpF
 KX0mK+hbJmC+p734HHYLfb8E3UeGF2/2LnLo33A5PIvcvQNWx7e0e96bCmLeASLIVJ4K
 rArVQMHrjBxierlvvvWoSKn6nRjbQzLHcyWx3LU0D478xepvL7/jGYfZPHbXwC/OkJn1
 6TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=37O4gAOuYSPlU8i6q3QTfAAbwSJq1xi7m9l2elaesZM=;
 b=ghSM1XUcIf8aM4+u6aGS0VmPIFrPVxEhJroiqUI0Ru6iyqMh2sqT27KGm/b/Wvj7UI
 OHxiFDO3SbpgAw26D3kuhCylROjZ7sQvZ3vg2nKL+EevXQiV66L/yVh/b7CH7bH1fGIy
 T3/ZilzoYlc3smFSi2Cs0JCic7znUDX35riXRgVgRndMhpxdf8AIxl+Nw/rzkNHAqnW5
 S7PwBDPOuGb9VnO0NPjPpXPcYASWfJO+bEg3267c9FFGE0EXNZZVTRtlft8nDbICM4Rg
 ez7aBkaU5lVTtVPJ3KdUBY/lO2xpnuiv8ueJdJrfbmOjgiN0sH/jZrITJQP2NOfZHOhJ
 O/8w==
X-Gm-Message-State: AOAM531xAc/6Ug7JYEyFAoXjfJGnxwCTx7QePOOvhhUiMqVnoaRBC5D5
 Uja4P+3Qw2eMy75FX1GJX7w=
X-Google-Smtp-Source: ABdhPJw1GvIGCZ62kf5KDsbhT8qhDe/HLO+tMiKRXZmma+Yw+6zuN2B3nzdyjxqt2B8w7LJ5wkGPhA==
X-Received: by 2002:a17:907:ea3:: with SMTP id
 ho35mr32759128ejc.219.1617693494410; 
 Tue, 06 Apr 2021 00:18:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8475:9991:cfb3:4162?
 ([2a02:908:1252:fb60:8475:9991:cfb3:4162])
 by smtp.gmail.com with ESMTPSA id r5sm13441168eds.49.2021.04.06.00.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Apr 2021 00:18:13 -0700 (PDT)
Subject: Re: a quetion about buffer migration for user mapped bo.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 258454946 <258454946@qq.com>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
References: <tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com>
 <729f8458-4586-2fd8-6232-012907c47ccc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2fccc3c7-a396-02aa-a258-60d2a215aedd@gmail.com>
Date: Tue, 6 Apr 2021 09:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <729f8458-4586-2fd8-6232-012907c47ccc@amd.com>
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
Content-Type: multipart/mixed; boundary="===============1033347104=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1033347104==
Content-Type: multipart/alternative;
 boundary="------------7F65E21722C355E1048A4E7D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7F65E21722C355E1048A4E7D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Yes, Andrey is right.

A top level explanation is that we don't prevent moving the buffer but 
rather we prevent user space from accessing it.

Regards,
Christian.

Am 05.04.21 um 18:34 schrieb Andrey Grodzovsky:
>
> From my understanding and looking at the code I think we don't prevent 
> but rather invalidate current user mappings and use subsequent page 
> faults to map into user space process the pages from the new location. 
> Check what this function is doing during move - 
> https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238
>
> Andrey
>
> On 2021-04-05 12:01 p.m., 258454946 wrote:
>> Hi Guys,
>>
>> I am a newbee of gfx development. Recently, I am researching amdgpu 
>> open source driver, and encounter a problem, but do not find the answer.
>>
>> We know the user maybe map a gem backing buffer for reading/writing 
>> and hold the mapping for a long term. while, kernel driver will also 
>> moves the user mapped bo to other memory region. vram ->gtt, 
>> gtt->vram, even it may be swaped out under OOM case.
>>
>> So, my question is how driver prevents kernel ttm from moving the 
>> user mapped bo while user is accessing it?
>>
>> Thanks for your attention!
>>
>> Lizhi.
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------7F65E21722C355E1048A4E7D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Yes, Andrey is right.<br>
    <br>
    A top level explanation is that we don't prevent moving the buffer
    but rather we prevent user space from accessing it.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 05.04.21 um 18:34 schrieb Andrey
      Grodzovsky:<br>
    </div>
    <blockquote type="cite"
      cite="mid:729f8458-4586-2fd8-6232-012907c47ccc@amd.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <p>From my understanding and looking at the code I think we don't
        prevent but rather invalidate current user mappings and use
        subsequent page faults to map into user space process the pages
        from the new location. Check what this function is doing during
        move -
        <a class="moz-txt-link-freetext"
href="https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238"
          moz-do-not-send="true">https://elixir.bootlin.com/linux/v5.12-rc5/source/drivers/gpu/drm/ttm/ttm_bo.c#L238</a><br>
      </p>
      <p>Andrey<br>
      </p>
      <div class="moz-cite-prefix">On 2021-04-05 12:01 p.m., 258454946
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:tencent_826EEA87BF2072281A8B94B2955DDCA14E05@qq.com">
        <div>Hi Guys,</div>
        <div><br>
        </div>
        <div>I am a newbee of gfx development. Recently, I am
          researching amdgpu open source driver, and encounter a
          problem, but do not find the answer.</div>
        <div><br>
        </div>
        <div>We know the user maybe map a gem backing buffer for
          reading/writing and hold the mapping for a long term. while,
          kernel driver will also moves the user mapped bo to other
          memory region. vram -&gt;gtt, gtt-&gt;vram, even it may be
          swaped out under OOM case.</div>
        <div><br>
        </div>
        <div>So, my question is how driver prevents kernel ttm from
          moving the user mapped bo while user is accessing it?</div>
        <div><br>
        </div>
        <div>Thanks for your attention!</div>
        <div><br>
        </div>
        <div>Lizhi.</div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7F65E21722C355E1048A4E7D--

--===============1033347104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1033347104==--
