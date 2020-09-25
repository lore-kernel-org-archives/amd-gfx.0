Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B28C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E932074B
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKouqJ6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFDF6ED08;
	Fri, 25 Sep 2020 14:54:51 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5D36ED02;
 Fri, 25 Sep 2020 14:54:50 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id i1so2813922edv.2;
 Fri, 25 Sep 2020 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=AU0coRPy0KmLjTmER0avv4AG8965UfVnYUVUMrhkCMs=;
 b=tKouqJ6WKvUXRPTvQOkfYVC/5bKX3ODx14o55cLrZevQbA0ol9Bjb0f+N7JHpzM4KV
 X5G47ZIst6UMZEUVaB7MCXgVchLRETuwYqZotAQhAz1ToIy+ORq1tYUfbBYLFCpIJHkm
 VrwXK9OakoL4eOcebfdTGYzjktpUhwVLEWlmg1eHO0XmjZNd2boZmy5tHY2v7spg3sUU
 kQzNjzPoCRwJ40YpuOYxsOqdJA6guO5cWZP2i5VT4yNpOAWers6UAn4GfRVbgO/wtZux
 zzPeESnZeb05RSUDzXsfa680TLcgMYX8pmH3BaCjaDSVOv8KaspCjEC5Gmepvt98+yo8
 qSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=AU0coRPy0KmLjTmER0avv4AG8965UfVnYUVUMrhkCMs=;
 b=HnfWCnn+s1BOj4mJ7PARP7lmVMDW6DK8lt+BEnUgIKeTeAA7sZ1wMN6QzUrPkmUQxj
 xcjhkUBXXZV124DYX5Ci+K/Dp1HItyZqXaYcs2gm44ha7K9jOPZV4sxmuZVymH2/9yaM
 2f6mNr33jm/oSOVOpxwC3ioxGGfRlidpNeQuXA4/AVubfWlRnP+R2PWaYBQ+cvcwGQm2
 QUZNdKYqDYeYPkXv79NuhTwM1hwLRl5vLaG8mFaCwnLJWe8L+b/qsvSIO2GtqEvlSktM
 rO58D+zzFtGvW1gOgeegGAByj0Z+nv2zhCNYdG8gPxIO4IJcoHCwu6EUEuK5wlP6P2+I
 F7Pg==
X-Gm-Message-State: AOAM530rTdZ5Ga21b04eyuKsEm2VqTR1xK59AE1MqD8o4xw6QETpnZX3
 te+Q0Ec42c0A1mDA7ARoK5UE5FRNNkA=
X-Google-Smtp-Source: ABdhPJzPCA3pQbUCJxmgCD28BQU2Z9UzNkmDVCUCxJ7zQmwAJl6Bx9SOfgD0khc+pah8J5wrGJM2Hg==
X-Received: by 2002:a05:6402:696:: with SMTP id
 f22mr1701120edy.290.1601045688616; 
 Fri, 25 Sep 2020 07:54:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id dt15sm2029135ejb.80.2020.09.25.07.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:54:48 -0700 (PDT)
Subject: Re: CONFIG_AMDGPU triggers full rebuild
To: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5d0d4c05-a42a-a3d2-87a1-8520ab64a062@gmail.com>
Date: Fri, 25 Sep 2020 16:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de>
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
Content-Type: multipart/mixed; boundary="===============2070336703=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2070336703==
Content-Type: multipart/alternative;
 boundary="------------1D4CC7171B88AD110B1088DB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1D4CC7171B88AD110B1088DB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Maybe MMU notifiers? But honestly I don't know for sure.

Christian.

Am 25.09.20 um 16:29 schrieb Thomas Zimmermann:
> Hi,
>
> whenever I change the option CONFIG_AMDGPU, I have to rebuild the whole
> kernel. I guess it auto-selects some architecture-specific feature. That
> full rebuild might be avoidable if I could enable that feature permanently.
>
> Any ideas what this could be and how to avoid the full rebuilt?
>
> Best regards
> Thomas
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1D4CC7171B88AD110B1088DB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Maybe MMU notifiers? But honestly I
      don't know for sure.<br>
      <br>
      Christian.<br>
      <br>
      Am 25.09.20 um 16:29 schrieb Thomas Zimmermann:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e7f5e4ae-7a6a-0a3c-666c-05180a8fe726@suse.de">
      <pre class="moz-quote-pre" wrap="">Hi,

whenever I change the option CONFIG_AMDGPU, I have to rebuild the whole
kernel. I guess it auto-selects some architecture-specific feature. That
full rebuild might be avoidable if I could enable that feature permanently.

Any ideas what this could be and how to avoid the full rebuilt?

Best regards
Thomas

</pre>
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

--------------1D4CC7171B88AD110B1088DB--

--===============2070336703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2070336703==--
