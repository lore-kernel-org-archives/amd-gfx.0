Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A0C55199
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 08:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206EC20700
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 08:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxvjg3Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206EC20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1C76E029;
	Sun, 26 Apr 2020 08:55:56 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27ABE6E029
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 08:55:56 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id x17so16051403wrt.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=gX8iDBtEE7A5QVM/mKjOL6KAfcBkAWSuuGog5vO4rMg=;
 b=Nxvjg3GjLzVZOKBWHbZem7fvvNHQfoCSWsQbyhkGH5DsmodLLHkZosig/wVglaZXTR
 hwwemY7u1aDAlKmxR7v+bY6G4O3aKGGFIrzeRF/QnyXAsO5bE2fYiHlePnasJRn2ixyQ
 nG8bWtu9JoGfzAZbaaTI8NN4Xqm6bE+rLZRP3nF/zmMpXRWUrSS/4FMDXnPzeSOhmDwJ
 RNLrEWZIqG3/KBgkSPh18ygZha1G72+1YtgtxgQGyLiPROiao3alwda9cgvGSSTFcXUJ
 uXAon8ic3yCkmIhjylEhcJ/Eh3XyeC61TKibXCjz0LSpS/N9TDQUP8+a8Cj7GsEU/1Sf
 X2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=gX8iDBtEE7A5QVM/mKjOL6KAfcBkAWSuuGog5vO4rMg=;
 b=L4UGNtKYgQhv68O2BQm9QMDH2sqNQv2y02IW68EMLM0s447z+OsR7DLmtj2WVYrkNX
 yDAmc2pNeTDKYDODSVHQm6mIT5IZCrRs3EhCKvy6bNVasQQXk4ZYW+rHIhs9lgbBG2hX
 vZftg2GaNJBahxVmzrBCPH6QhHAxISTuL86j97+xbY1LXDFMXe9Fd0T3H16j9jDfw3UO
 FZprl74Qur4sZNDZVSnuXwzSGGvhinn8vu0G+cdYRiP6l6KN0xPytswt8DVwZw7pcwod
 7iOtmxusaKtTRepuBeEvyT86f7V4qEpGKrI7XB1W0TYXH9cm48hwb4YCU+UwJalHpzXf
 bZ6A==
X-Gm-Message-State: AGi0PuarasNmJmb5nExpFEhEvRMnHaw8cVvC2agqw6+8scmHS3CmKMC7
 F9PScpPqAfcU6K3dt5A09TrHnguj
X-Google-Smtp-Source: APiQypJB30WmY0vQ/DaQFPa7uE2boH2SJ7DgCp4QCrVQeKo8QLQVgprMp1W2i01dJtchg6iyYbW+Kg==
X-Received: by 2002:adf:c109:: with SMTP id r9mr21165197wre.265.1587891354464; 
 Sun, 26 Apr 2020 01:55:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k184sm10593145wmf.9.2020.04.26.01.55.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Apr 2020 01:55:53 -0700 (PDT)
Subject: Re: drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CAAxE2A64Z91LiB9FduJf-8OO3He+1gZ9sxDfD+BVwc+-9Z7BnA@mail.gmail.com>
 <64c5a883-1933-c494-7a93-dc19e0bd0445@gmail.com>
 <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <328ea10b-1453-371e-7392-54e1a4051715@gmail.com>
Date: Sun, 26 Apr 2020 10:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1128717730=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1128717730==
Content-Type: multipart/alternative;
 boundary="------------88446086A237EB520A238403"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------88446086A237EB520A238403
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for that explanation. I suspected that there was a good reason to 
have that in the kernel, but couldn't find one.

In this case the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

We should probably add this explanation as comment to the flag as well.

Thanks,
Christian.

Am 26.04.20 um 02:43 schrieb Marek Olšák:
> It was merged into amd-staging-drm-next.
>
> I'm not absolutely sure, but I think we need to invalidate before IBs 
> if an IB is cached in L2 and the CPU has updated it. It can only be 
> cached in L2 if something other than CP has read it or written to it 
> without invalidation. CP reads don't cache it but they can hit the 
> cache if it's already cached.
>
> For CE, we need to invalidate before the IB in the kernel, because CE 
> IBs can't do cache invalidations IIRC. This is the number one reason 
> for merging the already pushed commits.
>
> Marek
>
> On Sat., Apr. 25, 2020, 11:03 Christian König, 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Was that patch set actually merged upstream? My last status is
>     that we couldn't find a reason why we need to do this in the kernel.
>
>     Christian.
>
>     Am 25.04.20 um 10:52 schrieb Marek Olšák:
>>     This was missed.
>>
>>     Marek
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------88446086A237EB520A238403
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Thanks for that explanation. I
      suspected that there was a good reason to have that in the kernel,
      but couldn't find one.<br>
      <br>
      In this case the patch is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
      <br>
      We should probably add this explanation as comment to the flag as
      well.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 26.04.20 um 02:43 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6Hgnq_zBjQQoa51S7KfVzddjndRGjrJYtjY7v9+vuwDw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">It was merged into amd-staging-drm-next.
        <div dir="auto"><br>
        </div>
        <div dir="auto">I'm not absolutely sure, but I think we need to
          invalidate before IBs if an IB is cached in L2 and the CPU has
          updated it. It can only be cached in L2 if something other
          than CP has read it or written to it without invalidation. CP
          reads don't cache it but they can hit the cache if it's
          already cached.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">For CE, we need to invalidate before the IB in
          the kernel, because CE IBs can't do cache invalidations IIRC.
          This is the number one reason for merging the already pushed
          commits.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Sat., Apr. 25, 2020, 11:03
          Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          <div text="#000000" bgcolor="#FFFFFF">
            <div>Was that patch set actually merged upstream? My last
              status is that we couldn't find a reason why we need to do
              this in the kernel.<br>
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
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" rel="noreferrer" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" rel="noreferrer" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
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

--------------88446086A237EB520A238403--

--===============1128717730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1128717730==--
