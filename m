Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1BEC64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 12:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56B320770
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 12:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcq3x+UR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56B320770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653E6E4F1;
	Tue,  1 Dec 2020 12:07:01 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D860C6E4F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 12:07:00 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id d17so3585424ejy.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=2YhnYFJOOF4K2rE9B/PfUuIEd/cReVpu0OAx9dvER9Q=;
 b=mcq3x+URHeg1OcZuBzeCKYBZafSg1hqi1utCPIdaKBB+8gWwfdKOOBXUf3UuVZ292p
 FYmGPgJjooFftHe4M1nKv/jLRTUSd+AdykaVaASnD9RQJjoacz5S+UCELDWfnF0nwsj5
 NdPaOqcGHF4ucnhLMFvfL8TsJB0vHNGNh9Q0RRVQJIeOc0ishpMnt71dqgOqBNi7BLaW
 8+9yrQpvP9JF7OYrsYrnib/+Xlymo37MCrS92SpXWvnO5q5Qygq0gmxRp8VQohVC9s7y
 ccTMtOHbFfHTEbDslKi7XDIc7RVMrf4LpxnpVNHw5n3SY3z2uXvylXu+Tw0GKTWq14s5
 1HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=2YhnYFJOOF4K2rE9B/PfUuIEd/cReVpu0OAx9dvER9Q=;
 b=GIflka9bncQkKVb8bZBDedma8iTfaYUF8N2uzK5PbmmgYo68mDCgqbKWc4jOzY7hJ7
 qr+ymNzShVNNOupP1MDcJCC4KmIwKXyzBYa7k9+pKqJMpBjKo4i6s8BZESKg4M9OXNkG
 1QQeZ0AstLTpNI8BrKpa5BHGD3N4yKQdbtvb+kjkk4PRRwjs0xLamLpx+iKAE8Ux/n2v
 9v5x9FkA+kCaBD32xpKRy7JqKDzo2+l0TmzKF7fIySVA3O1+YQAuG4Bv5DnSBL39BRI4
 kZ9Dc3ZQjXnVT39iwQgMs4rpHXqE19BKNTytKnkd7ObDsxvhyeHsKVUC2foi/PeQFY0v
 2lZQ==
X-Gm-Message-State: AOAM530/BgVgYGwX+0aS/I/ZqACgM5W+39rAmcar5WtgYnF/kLa23GK8
 cqYb8kyAgKQsx/J6Sf1r12Uuvkn2UgY=
X-Google-Smtp-Source: ABdhPJxWPLi/thnqwXdry7fGlbkuGJXhI1tnJqBFD/qA8IXPby23I1LUJRaZm2JgRopOOB97scphRQ==
X-Received: by 2002:a17:907:20a6:: with SMTP id
 pw6mr2716919ejb.73.1606824419291; 
 Tue, 01 Dec 2020 04:06:59 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f24sm729976ejf.117.2020.12.01.04.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Dec 2020 04:06:58 -0800 (PST)
Subject: Re: [amdgpu] Is it possible to disable page tables and use the
 physical address directly in amdgpu
To: Smith John <ls.cat.kth@gmail.com>, christian.koenig@amd.com
References: <CAGztBWUy6a8oB9PuF3YmqKN0DdqXixTmxThyK0+BwTMFWYtTww@mail.gmail.com>
 <ee60c997-1c5c-cda1-74da-ed40c3ce6dcf@gmail.com>
 <CAGztBWVOhbMnjo7vGmCAa6LPN0USK9GneWyw8LaDJPeeK_x66g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <56567c1d-9d3e-39e1-ab47-ee0e9efa2749@gmail.com>
Date: Tue, 1 Dec 2020 13:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGztBWVOhbMnjo7vGmCAa6LPN0USK9GneWyw8LaDJPeeK_x66g@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0785510178=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0785510178==
Content-Type: multipart/alternative;
 boundary="------------F0BEBBC0F74AE58AE574C59C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F0BEBBC0F74AE58AE574C59C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The page tables can be enabled/disabled on a per VMID basis, but memory 
management in the core kernel works with pages.

So you need a relocation table just because of this. Additional to that 
the TLB is more than big enough, so there isn't much performance gain if 
you use huge pages.

Please note that the VM subsystem also supports giant pages, so if your 
application manages to allocate things in chunks of at least 1GB you 
only get a single page table entry for that.

Regards,
Christian.

Am 01.12.20 um 12:28 schrieb Smith John:
>  Hi Christian,
> Thanks for your reply. I agree with you that the VMID0 is special and 
> remapping is important. I was not sure if different VIMDs could have 
> different settings, such as enable/disable page tables.
> Or to put it another way, I was wondering if the hardware supports 
> purely physical addressing like the real mode in CPUs, or page tables 
> are essential for the hardware.
> More specifically, assuming it supports "real mode", to copy things 
> from A to B, one could allocate rings which are accessible by MMIO and 
> fill sdma packets using physical address to transfer data.
>
> Regards,
> Smith
>
> Christian König <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> 于2020年12月1日周二 
> 下午5:50写道：
>
>     Am 01.12.20 um 07:58 schrieb Smith John:
>>     Hello!
>>     I was trying to figure out the impact of gpu page tables on
>>     applications' performance. I noticed that there are 16 vmids
>>     supported by the hardware /Vega 10/. Is it possible to use
>>     physical address directly in some vmids, or use physical address
>>     globally?
>
>     No. VMID0 is used by the kernel for jobs like copying things from
>     A to B and even there we use the VM remapping functionality.
>
>     Regards,
>     Christian.
>
>>
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


--------------F0BEBBC0F74AE58AE574C59C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">The page tables can be enabled/disabled
      on a per VMID basis, but memory management in the core kernel
      works with pages.<br>
      <br>
      So you need a relocation table just because of this. Additional to
      that the TLB is more than big enough, so there isn't much
      performance gain if you use huge pages.<br>
      <br>
      Please note that the VM subsystem also supports giant pages, so if
      your application manages to allocate things in chunks of at least
      1GB you only get a single page table entry for that.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 01.12.20 um 12:28 schrieb Smith John:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGztBWVOhbMnjo7vGmCAa6LPN0USK9GneWyw8LaDJPeeK_x66g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr"> Hi Christian,
        <div>Thanks for your reply. I agree with you that the VMID0 is
          special and remapping is important. I was not sure if
          different VIMDs could have different settings, such as
          enable/disable page tables. </div>
        <div>Or to put it another way, I was wondering if the hardware
          supports purely physical addressing like the real mode in
          CPUs, or page tables are essential for the hardware.</div>
        <div>More specifically, assuming it supports "real mode", to
          copy things from A to B, one could allocate rings which are
          accessible by MMIO and fill sdma packets using physical
          address to transfer data.</div>
        <div><br>
        </div>
        <div>Regards,</div>
        <div>Smith</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          于2020年12月1日周二 下午5:50写道：<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div>Am 01.12.20 um 07:58 schrieb Smith John:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">Hello!
                <div>I was trying to figure out the impact of gpu page
                  tables on applications' performance. I noticed that
                  there are 16 vmids supported by the hardware <i>Vega
                    10</i>. Is it possible to use physical address
                  directly in some vmids, or use physical address
                  globally?</div>
              </div>
            </blockquote>
            <br>
            No. VMID0 is used by the kernel for jobs like copying things
            from A to B and even there we use the VM remapping
            functionality.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <blockquote type="cite">
              <div dir="ltr">
                <div><br>
                </div>
              </div>
              <br>
              <fieldset></fieldset>
              <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
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

--------------F0BEBBC0F74AE58AE574C59C--

--===============0785510178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0785510178==--
