Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E93C55199
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 14:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF51206BF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 14:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODSMzNXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF51206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E0A6E2F9;
	Mon, 27 Apr 2020 14:53:41 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B536E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 14:53:39 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id h4so6601466wmb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=5z0hJo2r8CKMccXJpZB9UkALHoeXnVsqfXClUfLKb2k=;
 b=ODSMzNXo2SyH4tIonlO9O6ZL5IY4/rA33wgooDpbHIKbp3plLuwVfLbvWNg+Cm65ML
 PA92dgPo9QC2zI6GQo8Gdh46i7aVsYtZ9GfwfXYtdtPzYX1nXQO2uGD978MVNa0gpSgA
 VB9nlk6Kv9miHHLBU4heZNR/SjsjxZz1AcFnpwehlbXp2oDJ4LqbIw6FpSdZdumwNnLf
 afXFr4nDRYqRsCXpE1WQ6epIpfLpFDo2I7XZWVO2GFU+aqlIzOMZjlV56T+EvjVfXq/Z
 yWYjYX/35meAJYLggndgSa8Py9dHWWB8HYv3lDdnGv0GRHnu73Rgqtz7dz1eQ6kGwXGY
 sMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=5z0hJo2r8CKMccXJpZB9UkALHoeXnVsqfXClUfLKb2k=;
 b=c/2dHizTM4TYtOfWWK7xpRVmz6FVog1NrxeihZsNsw9lHweMCTBmL/a9u/J8EHYd6j
 JNPEup/XwkjcRRQVL27GBmflc/979KEyFtrBByJPpXhlNhnxNaSRt+SOnCappBl4344P
 XmDfux929MCRia00jFcFm+Rg/ZBCjLrfuG+Vfbc7jTVUpYQ9cqUxCAhNwqQnzhNXNKnU
 5hKQW/ErZz5gNE95tbpkgu6ajfz73HvuX36YaF+f2aHZzaBXfvxw+GBspdplJS6rpHJV
 OUap+6jrWSmPqZ0UmYkyg+3KNHPI6hlm4UZuBSXPceb5KFRSNCwBYHynVqAOTRJqRTS+
 znkw==
X-Gm-Message-State: AGi0PuZl+ECAnl8XEbIg8rYcKsvCwBU84KuU02CIbACR/peDM3va9dCD
 Qub+yyO3SWRLRTWxCh/zRwTAYkqX
X-Google-Smtp-Source: APiQypLOOSn70YQf6wTx5U+jvxZlezMiFLb/f9md7nl8IFNwgULLambtJryb7lzTm3cH9gPhUkC/cg==
X-Received: by 2002:a05:600c:c8:: with SMTP id
 u8mr27548571wmm.142.1587999218068; 
 Mon, 27 Apr 2020 07:53:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q17sm15175549wmj.45.2020.04.27.07.53.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 07:53:37 -0700 (PDT)
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
 <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
 <MN2PR12MB448809E68050B9A61B1CC7FAF7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <217db438-608d-d28c-6678-4173a6291d8b@gmail.com>
Date: Mon, 27 Apr 2020 16:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1580426976=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1580426976==
Content-Type: multipart/alternative;
 boundary="------------7DEC071B4FC31AF86CE85191"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7DEC071B4FC31AF86CE85191
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, but is Mesa going to use it?

Christian.

Am 27.04.20 um 15:54 schrieb Marek Olšák:
> PAL requested it and they are going to use it. (it looks like they 
> have to use it for correctness)
>
> Marek
>
> On Mon, Apr 27, 2020 at 9:02 AM Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>> wrote:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>
>     Do we have open source code UMD code which uses this?
>
>     Alex
>     ------------------------------------------------------------------------
>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     *Sent:* Sunday, April 26, 2020 4:55 AM
>     *To:* Marek Olšák <maraeo@gmail.com <mailto:maraeo@gmail.com>>;
>     Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>
>     *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
>     <mailto:Alexander.Deucher@amd.com>>; amd-gfx mailing list
>     <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>     *Subject:* Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to
>     compute IBs too
>     Thanks for that explanation. I suspected that there was a good
>     reason to have that in the kernel, but couldn't find one.
>
>     In this case the patch is Reviewed-by: Christian König
>     <christian.koenig@amd.com> <mailto:christian.koenig@amd.com>
>
>     We should probably add this explanation as comment to the flag as
>     well.
>
>     Thanks,
>     Christian.
>
>     Am 26.04.20 um 02:43 schrieb Marek Olšák:
>>     It was merged into amd-staging-drm-next.
>>
>>     I'm not absolutely sure, but I think we need to invalidate before
>>     IBs if an IB is cached in L2 and the CPU has updated it. It can
>>     only be cached in L2 if something other than CP has read it or
>>     written to it without invalidation. CP reads don't cache it but
>>     they can hit the cache if it's already cached.
>>
>>     For CE, we need to invalidate before the IB in the kernel,
>>     because CE IBs can't do cache invalidations IIRC. This is the
>>     number one reason for merging the already pushed commits.
>>
>>     Marek
>>
>>     On Sat., Apr. 25, 2020, 11:03 Christian König,
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>         Was that patch set actually merged upstream? My last status
>>         is that we couldn't find a reason why we need to do this in
>>         the kernel.
>>
>>         Christian.
>>
>>         Am 25.04.20 um 10:52 schrieb Marek Olšák:
>>>         This was missed.
>>>
>>>         Marek
>>>
>>>         _______________________________________________
>>>         amd-gfx mailing list
>>>         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&sdata=%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=0>
>>
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&sdata=%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&reserved=0>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------7DEC071B4FC31AF86CE85191
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, but is Mesa going to use it?<br>
      <br>
      Christian.<br>
      <br>
      Am 27.04.20 um 15:54 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A50b_+oX9wmF2D6LZs9GvG9Rhug8AQU40aeDbMDm_kFqw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>PAL requested it and they are going to use it. (it looks
          like they have to use it for correctness)<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, Apr 27, 2020 at 9:02
          AM Deucher, Alexander &lt;<a
            href="mailto:Alexander.Deucher@amd.com"
            moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <p
style="font-family:Arial;font-size:10pt;color:rgb(0,120,215);margin:15pt"
              align="Left">
              [AMD Official Use Only - Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Do
                we have open source code UMD code which uses this?</div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
              </div>
              <div
style="font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">Alex<br>
              </div>
              <hr style="display:inline-block;width:98%">
              <div id="gmail-m_-4239586701017450887divRplyFwdMsg"
                dir="ltr"><font style="font-size:11pt" face="Calibri,
                  sans-serif" color="#000000"><b>From:</b> Christian
                  König &lt;<a
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                  <b>Sent:</b> Sunday, April 26, 2020 4:55 AM<br>
                  <b>To:</b> Marek Olšák &lt;<a
                    href="mailto:maraeo@gmail.com" target="_blank"
                    moz-do-not-send="true">maraeo@gmail.com</a>&gt;;
                  Koenig, Christian &lt;<a
                    href="mailto:Christian.Koenig@amd.com"
                    target="_blank" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;<br>
                  <b>Cc:</b> Deucher, Alexander &lt;<a
                    href="mailto:Alexander.Deucher@amd.com"
                    target="_blank" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                  amd-gfx mailing list &lt;<a
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                  <b>Subject:</b> Re: drm/amdgpu: apply
                  AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too</font>
                <div> </div>
              </div>
              <div style="background-color:rgb(255,255,255)">
                <div>Thanks for that explanation. I suspected that there
                  was a good reason to have that in the kernel, but
                  couldn't find one.<br>
                  <br>
                  In this case the patch is Reviewed-by: Christian König
                  <a href="mailto:christian.koenig@amd.com"
                    target="_blank" moz-do-not-send="true">
                    &lt;christian.koenig@amd.com&gt;</a><br>
                  <br>
                  We should probably add this explanation as comment to
                  the flag as well.<br>
                  <br>
                  Thanks,<br>
                  Christian.<br>
                  <br>
                  Am 26.04.20 um 02:43 schrieb Marek Olšák:<br>
                </div>
                <blockquote type="cite">
                  <div dir="auto">It was merged into
                    amd-staging-drm-next.
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">I'm not absolutely sure, but I think
                      we need to invalidate before IBs if an IB is
                      cached in L2 and the CPU has updated it. It can
                      only be cached in L2 if something other than CP
                      has read it or written to it without invalidation.
                      CP reads don't cache it but they can hit the cache
                      if it's already cached.</div>
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">For CE, we need to invalidate before
                      the IB in the kernel, because CE IBs can't do
                      cache invalidations IIRC. This is the number one
                      reason for merging the already pushed commits.</div>
                    <div dir="auto"><br>
                    </div>
                    <div dir="auto">Marek</div>
                  </div>
                  <br>
                  <div>
                    <div dir="ltr">On Sat., Apr. 25, 2020, 11:03
                      Christian König, &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote style="margin:0px 0px 0px
                      0.8ex;border-left:1px solid
                      rgb(204,204,204);padding-left:1ex">
                      <div bgcolor="#FFFFFF">
                        <div>Was that patch set actually merged
                          upstream? My last status is that we couldn't
                          find a reason why we need to do this in the
                          kernel.<br>
                          <br>
                          Christian.<br>
                          <br>
                          Am 25.04.20 um 10:52 schrieb Marek Olšák:<br>
                        </div>
                        <blockquote type="cite">
                          <div dir="ltr">
                            <div>This was missed.</div>
                            <div><br>
                            </div>
                            <div>Marek<br>
                            </div>
                          </div>
                          <br>
                          <fieldset></fieldset>
                          <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" rel="noreferrer" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=0" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                        </blockquote>
                        <br>
                      </div>
                    </blockquote>
                  </div>
                  <br>
                  <fieldset></fieldset>
                  <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CAlexander.Deucher%40amd.com%7C6b35f61512d34bf2dc8b08d7e9bfa1a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637234881577782939&amp;sdata=%2B95wpbjY3Q675FaX9iH1BNIFyEz5jpN4PzjEOOpIu9Q%3D&amp;reserved=0" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                </blockquote>
                <br>
              </div>
            </div>
          </div>
        </blockquote>
      </div>
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

--------------7DEC071B4FC31AF86CE85191--

--===============1580426976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1580426976==--
