Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 11:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0685420801
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 11:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWvGAjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96D16E93F;
	Fri, 12 Jun 2020 11:20:08 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC956E93E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 11:20:07 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id q25so7965270wmj.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=0zXZqJTIKftwQYbXDCqY5bU40dbKpaWd0r+uv7y++bM=;
 b=OlWvGAjM6OC82iGypSzv26z8uhastUYyNgFSfl5GPD1CAZMZk30QHMYDvwL65F21AE
 3g3CmVb7x3AK06i1QOyo9szEv7nAJXh1fXOEEOAZXk++pA7WaYoWYCgd6+kiT+5y8i32
 DiY5UQ4+TdQ40ExNmnLjWZuxhOfmd+GUaGEspZE89kRWhlGdQUVIu+tLMsSgscjYMu4U
 K3ZDCehL4ilWTRyj8wn357QdAteleIoSyKML8JhuKymACmTByW8nL+kxFFZSuzSM8MoX
 hMj3taUHq16jm90nbO1mT7A8h2uQgunuk22QlZYP4beoZkiVturH7l0fG7zz3N3NWXO/
 2rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=0zXZqJTIKftwQYbXDCqY5bU40dbKpaWd0r+uv7y++bM=;
 b=ZCX0mFY+0YR7rIEgSQLaBy6LCMgjhDIWQ0wd8PhXJOxwmdY/e6Ra0vI6Qt16Anu4dy
 w/fn3CxB74Fdk7w11A25Jmt+3unJbFfbfmQ2DaotHqj2wkyITanJHkTuCic17uYMYhlz
 4IU1FE5OI8i5U3Jxv1tNHe+kuCU+nQeGh63Ns7oYmQNEdi9gF94RFrQC+UE/cT6TfL6w
 Gm4N054PsGZja864/u2yIwAbdgx/Q30yg2vfzIFR6wY2GhY8VjFEIG47nnFyQzL0EPak
 t6WCj47KY4MKQsJxUWBQdAlscXpAU/WwLm+xHwrwtL3hPb6NOkwmuBmUiAeIHRJ7v0yW
 b5BA==
X-Gm-Message-State: AOAM532t1/xWqfhiDv25BbegV1+MtyLUi8sxJN7g4dqtHyHO1hNL8JTU
 bGFFmd3YgdUYA1qGzZLzIkdbVCQq
X-Google-Smtp-Source: ABdhPJyf3pEk71zxbYajwe5urh6ba2Xv6mUPS1X1EMlCnYXC1zfISRNaZBedWc43iHBIFPs2cxAGvA==
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr13251017wmh.181.1591960806205; 
 Fri, 12 Jun 2020 04:20:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m24sm8255678wmi.14.2020.06.12.04.20.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jun 2020 04:20:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: Chunming Zhou <zhoucm1@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
 <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
 <CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com>
 <161297ae-c098-27fe-ed80-2b46f64c1065@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3ac25184-1260-fdb6-ecb1-36e0ed80ea27@gmail.com>
Date: Fri, 12 Jun 2020 13:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <161297ae-c098-27fe-ed80-2b46f64c1065@amd.com>
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
Cc: "Zhou, David\(ChunMing\)" <david1.zhou@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0748743958=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0748743958==
Content-Type: multipart/alternative;
 boundary="------------2C9B80BE71BD76FBA0A363F0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2C9B80BE71BD76FBA0A363F0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

My only concern is that this becomes UAPI as soon as we increase the 
minor number.

So if we find that this has some negative side effects we can never go 
back again.

But the choice is up to you guys, from my side it is perfectly good to go.

Christian.

Am 11.06.20 um 14:13 schrieb Chunming Zhou:
>
> I didn't check the patch details, if it is for existing implicit sync 
> of shared buffer, feel free go ahead.
>
> But if you add some description for its usage, that will be more clear 
> to others.
>
> -David
>
> 在 2020/6/11 15:19, Marek Olšák 写道:
>> Hi David,
>>
>> Explicit sync has nothing to do with this. This is for implicit sync, 
>> which is required by DRI3. This fix allows removing existing 
>> inefficiencies from drivers, so it's a good thing.
>>
>> Marek
>>
>> On Wed., Jun. 10, 2020, 03:56 Chunming Zhou, <zhoucm1@amd.com 
>> <mailto:zhoucm1@amd.com>> wrote:
>>
>>
>>     在 2020/6/10 15:41, Christian König 写道:
>>>     That's true, but for now we are stuck with the implicit sync for
>>>     quite a number of use cases.
>>>
>>>     My problem is rather that we already tried this and it backfired
>>>     immediately.
>>>
>>>     I do remember that it was your patch who introduced the pipeline
>>>     sync flag handling and I warned that this could be problematic.
>>>     You then came back with a QA result saying that this is indeed
>>>     causing a huge performance drop in one test case and we need to
>>>     do something else. Together we then came up with the different
>>>     handling between implicit and explicit sync.
>>
>>     Isn't pipeline sync flag to fix some issue because of parralel
>>     execution between jobs in one pipeline?  I really don't have this
>>     memory in mind why that's realted to this, Or do you mean extra
>>     sync hides many other potential issues?
>>
>>     Anyway, when I go through Vulkan WSI code, the synchronization
>>     isn't so smooth between OS window system. And when I saw Jason
>>     drives explicit sync through the whole Linux ecosystem like
>>     Android window system does, I feel that's really a good direction.
>>
>>     -David
>>
>>>
>>>     But I can't find that stupid mail thread any more. I knew that
>>>     it was a couple of years ago when we started with the explicit
>>>     sync for Vulkan.
>>>
>>>     Christian.
>>>
>>>     Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>>>>
>>>>     [AMD Official Use Only - Internal Distribution Only]
>>>>
>>>>     Not sue if this is right direction, I think usermode wants all
>>>>     synchronizations to be explicit. Implicit sync often confuses
>>>>     people who don’t know its history. I remember Jason from Intel
>>>>      is driving explicit synchronization through the Linux
>>>>     ecosystem, which even removes implicit sync of shared buffer.
>>>>
>>>>     -David
>>>>
>>>>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>>>>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>>>>     *Marek Olšák
>>>>     *Sent:* Tuesday, June 9, 2020 6:58 PM
>>>>     *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
>>>>     <mailto:amd-gfx@lists.freedesktop.org>
>>>>     *Subject:* [PATCH] drm/amdgpu: remove distinction between
>>>>     explicit and implicit sync (v2)
>>>>
>>>>     Hi,
>>>>
>>>>     This enables a full pipeline sync for implicit sync. It's
>>>>     Christian's patch with the driver version bumped. With this,
>>>>     user mode drivers don't have to wait for idle at the end of gfx
>>>>     IBs.
>>>>
>>>>     Any concerns?
>>>>
>>>>     Thanks,
>>>>
>>>>     Marek
>>>>
>>>>
>>>>     _______________________________________________
>>>>     amd-gfx mailing list
>>>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c674%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274567683552668&sdata=xIHDswGRsdCP%2BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&reserved=0>
>>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------2C9B80BE71BD76FBA0A363F0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">My only concern is that this becomes
      UAPI as soon as we increase the minor number.<br>
      <br>
      So if we find that this has some negative side effects we can
      never go back again.<br>
      <br>
      But the choice is up to you guys, from my side it is perfectly
      good to go.<br>
      <br>
      Christian.<br>
      <br>
      Am 11.06.20 um 14:13 schrieb Chunming Zhou:<br>
    </div>
    <blockquote type="cite"
      cite="mid:161297ae-c098-27fe-ed80-2b46f64c1065@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>I didn't check the patch details, if it is for existing
        implicit sync of shared buffer, feel free go ahead.</p>
      <p>But if you add some description for its usage, that will be
        more clear to others.</p>
      <p>-David<br>
      </p>
      <div class="moz-cite-prefix">在 2020/6/11 15:19, Marek Olšák 写道:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com">
        <div dir="auto">Hi David,
          <div dir="auto"><br>
          </div>
          <div dir="auto">Explicit sync has nothing to do with this.
            This is for implicit sync, which is required by DRI3. This
            fix allows removing existing inefficiencies from drivers, so
            it's a good thing.</div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">Marek</div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed., Jun. 10, 2020,
            03:56 Chunming Zhou, &lt;<a href="mailto:zhoucm1@amd.com"
              moz-do-not-send="true">zhoucm1@amd.com</a>&gt; wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div>
              <p><br>
              </p>
              <div>在 2020/6/10 15:41, Christian König 写道:<br>
              </div>
              <blockquote type="cite">
                <div>That's true, but for now we are stuck with the
                  implicit sync for quite a number of use cases.<br>
                  <br>
                  My problem is rather that we already tried this and it
                  backfired immediately.<br>
                  <br>
                  I do remember that it was your patch who introduced
                  the pipeline sync flag handling and I warned that this
                  could be problematic. You then came back with a QA
                  result saying that this is indeed causing a huge
                  performance drop in one test case and we need to do
                  something else. Together we then came up with the
                  different handling between implicit and explicit sync.<br>
                </div>
              </blockquote>
              <p>Isn't pipeline sync flag to fix some issue because of
                parralel execution between jobs in one pipeline?  I
                really don't have this memory in mind why that's realted
                to this, Or do you mean extra sync hides many other
                potential issues?</p>
              <p>Anyway, when I go through Vulkan WSI code, the
                synchronization isn't so smooth between OS window
                system. And when I saw Jason drives explicit sync
                through the whole Linux ecosystem like Android window
                system does, I feel that's really a good direction.</p>
              <p>-David<br>
              </p>
              <blockquote type="cite">
                <div> <br>
                  But I can't find that stupid mail thread any more. I
                  knew that it was a couple of years ago when we started
                  with the explicit sync for Vulkan.<br>
                  <br>
                  Christian.<br>
                  <br>
                  Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
                </div>
                <blockquote type="cite">
                  <div>
                    <p style="margin:0in;margin-bottom:.0001pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078d7">[AMD
                        Official Use Only - Internal Distribution Only]</span></p>
                    <p class="MsoNormal"> </p>
                    <p class="MsoNormal">Not sue if this is right
                      direction, I think usermode wants all
                      synchronizations to be explicit. Implicit sync
                      often confuses people who don’t know its history.
                      I remember Jason from Intel  is driving explicit
                      synchronization through the Linux ecosystem, which
                      even removes implicit sync of shared buffer.</p>
                    <p class="MsoNormal"> </p>
                    <p class="MsoNormal">-David</p>
                    <p class="MsoNormal"> </p>
                    <div style="border:none;border-top:solid #e1e1e1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b>From:</b> amd-gfx <a
                          href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                          target="_blank" rel="noreferrer"
                          moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                        <b>On Behalf Of </b>Marek Olšák<br>
                        <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
                        <b>To:</b> amd-gfx mailing list <a
                          href="mailto:amd-gfx@lists.freedesktop.org"
                          target="_blank" rel="noreferrer"
                          moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                        <b>Subject:</b> [PATCH] drm/amdgpu: remove
                        distinction between explicit and implicit sync
                        (v2)</p>
                    </div>
                    <p class="MsoNormal"> </p>
                    <div>
                      <div>
                        <p class="MsoNormal">Hi,</p>
                      </div>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">This enables a full
                          pipeline sync for implicit sync. It's
                          Christian's patch with the driver version
                          bumped. With this, user mode drivers don't
                          have to wait for idle at the end of gfx IBs.</p>
                      </div>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">Any concerns?</p>
                      </div>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">Thanks,</p>
                      </div>
                      <div>
                        <p class="MsoNormal">Marek</p>
                      </div>
                    </div>
                  </div>
                  <br>
                  <fieldset></fieldset>
                  <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c674%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274567683552668&amp;sdata=xIHDswGRsdCP%2BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="hAGAyoS6auIG5z/ymuBRZ8NQ1FyVyzxjLTP8d56vUWHt3KOGxnZA9JR3arWRHVNGShrJPcF8kl5FVDL8/CaUnIELQRxp+YA+LqJpUCIUiFkJQUnkS8xLZ4pFCx17bcOL632sj4r1sETdA7zJMsD8dR7TUlzPxzmmzFhKnYvV+/w=" target="_blank" rel="noreferrer" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                </blockquote>
                <br>
              </blockquote>
            </div>
          </blockquote>
        </div>
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

--------------2C9B80BE71BD76FBA0A363F0--

--===============0748743958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0748743958==--
