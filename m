Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA2C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293E9208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DttE91KJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293E9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D345E6E50D;
	Thu, 28 May 2020 09:11:36 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383896E507
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 09:11:35 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id c35so6285654edf.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=JQjIm0J3Sydujsa9IiwdExqb+7c362L9RdOEyJA8lPI=;
 b=DttE91KJogXQuib7OVG/V1e2eLVcmmzNm6AgfNbo4qDZF9AUAsu+z0UG8vEtpiZi9u
 Igpa7y7LSywzNOA1raWTQA+W7O5JXoA1M5d+ZHhTBBcxb+MZwdRkMJtmP3j9JX/W2JuD
 XrU413YklHKS76YjJjOUn9iGLvnJ//cKdj4yOGHIMxuvs4Z385cAPDhHyIr4eHy5rNJe
 00/ccGRsdscNg5RFPpzkzZXv4Dln31TI1cRVq9/0IYsOoo4UcMfN9Rvxt1Zxt6nXUSbL
 neQthtnvIWlaoNtKplx8E/pGM84WvWu+O7C6sMUCS0cAn6GpwzPkrsT99DzruyqmSbVw
 ORzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=JQjIm0J3Sydujsa9IiwdExqb+7c362L9RdOEyJA8lPI=;
 b=rdILIAR3jdwAWn4aJjvFEchOLdvTg7OaFplPOeMQfntlQxadMelGReiW3He8jTVUlN
 S6mp3jyxzV60eZAlPK5gbArWgWWhCxhoqW8bK6g0zTXIQNX60wfOAXQKSPVFJq8wTdNV
 EtM4gOOrBkm8b4b4HWBx1weeA8ZfnJV7AkFR8uV9U9Zfk1mQFiBSjdFvukdYArxc90lp
 Pq1gMQgbj6BOhFXFU+DZxf6XRD/t2a1T6Ii23/TzAPbGJXEYIKcbHHbEd1kdYRL8vwDq
 squW/CB3Tr/BFMKj94ZlsZ/OleuTI3OjJjLhohfRDSGcjaPZ0xoq0RIwUdZm1KDpjCu9
 tVaw==
X-Gm-Message-State: AOAM530DOModiL6+CiJJ+9hdJ2m23IQl6am12AFrE90V14NJmSlNd05Y
 lTLc8tLM04bxqyEI0MbTC2s=
X-Google-Smtp-Source: ABdhPJwvsn/Vf/VXg1woGJhIxnwPX0BDUlncpV+lXQtcMc+lcZ/JtRRKj+KOAwT4mXKHx2Mi7e8McQ==
X-Received: by 2002:aa7:c5c8:: with SMTP id h8mr1991889eds.222.1590657093872; 
 Thu, 28 May 2020 02:11:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id gx8sm3764338ejb.86.2020.05.28.02.11.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 May 2020 02:11:32 -0700 (PDT)
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
 <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1b4cc0a0-b690-3f54-d983-76975fe788bf@gmail.com>
Date: Thu, 28 May 2020 11:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0196845466=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0196845466==
Content-Type: multipart/alternative;
 boundary="------------745FB277CCD662DFE3C91EC9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------745FB277CCD662DFE3C91EC9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Well we still need implicit sync or otherwise the GPU scheduler would 
pick up the jobs in the wrong order.

See without this when we have the following sequence of submission:

Client IB1 using buffer A
Client IB2
X IB1 using buffer A

We could end up with the execution order

X IB1 using buffer A
Client IB1 using buffer A
Client IB2

And that is not correct. The scheduler is only allowed to do the following:

Client IB1 using buffer A
X IB1 using buffer A
Client IB2

And that's what implicit sync is taking care of.

Christian.

Am 26.05.20 um 00:07 schrieb Marek Olšák:
> If a user mode driver is changed to rely on the existence of implicit 
> sync, it results in corruption and flickering as reported here: 
> https://gitlab.freedesktop.org/mesa/mesa/-/issues/2950
>
> Marek
>
> On Mon, May 25, 2020 at 6:05 PM Marek Olšák <maraeo@gmail.com 
> <mailto:maraeo@gmail.com>> wrote:
>
>     Hi Christian,
>
>     Bas and Michel wanted to discuss this. The main disadvantage of no
>     implicit (pipeline) sync within the same queue is that we get
>     lower performance and lower GPU utilization in some cases.
>
>     We actually never really needed the kernel to have implicit sync,
>     because all user mode drivers contained hacks to work without it.
>
>     Marek
>


--------------745FB277CCD662DFE3C91EC9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Well we still need implicit sync or
      otherwise the GPU scheduler would pick up the jobs in the wrong
      order.<br>
      <br>
      See without this when we have the following sequence of
      submission:<br>
      <br>
      Client IB1 using buffer A<br>
      Client IB2<br>
      X IB1 using buffer A<br>
      <br>
      We could end up with the execution order<br>
      <br>
      X IB1 using buffer A<br>
      Client IB1 using buffer A<br>
      Client IB2<br>
      <br>
      And that is not correct. The scheduler is only allowed to do the
      following:<br>
      <br>
      Client IB1 using buffer A<br>
      X IB1 using buffer A<br>
      Client IB2<br>
      <br>
      And that's what implicit sync is taking care of.<br>
      <br>
      Christian.<br>
      <br>
      Am 26.05.20 um 00:07 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>If a user mode driver is changed to rely on the existence
          of implicit sync, it results in corruption and flickering as
          reported here: <a
            href="https://gitlab.freedesktop.org/mesa/mesa/-/issues/2950"
            moz-do-not-send="true">https://gitlab.freedesktop.org/mesa/mesa/-/issues/2950</a></div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Mon, May 25, 2020 at 6:05
          PM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com"
            moz-do-not-send="true">maraeo@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir="ltr">
            <div>Hi Christian,</div>
            <div><br>
            </div>
            <div>Bas and Michel wanted to discuss this. The main
              disadvantage of no implicit (pipeline) sync within the
              same queue is that we get lower performance and lower GPU
              utilization in some cases.<br>
            </div>
            <div><br>
            </div>
            <div>We actually never really needed the kernel to have
              implicit sync, because all user mode drivers contained
              hacks to work without it.</div>
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------745FB277CCD662DFE3C91EC9--

--===============0196845466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0196845466==--
