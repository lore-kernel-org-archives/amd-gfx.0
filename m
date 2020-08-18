Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A3C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 15:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD847206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 15:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSX8AEJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD847206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DEE89857;
	Tue, 18 Aug 2020 15:07:00 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BE589857
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 15:06:59 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id g8so16543872wmk.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=Ef1jYq7fQO1GqHf8CUeZDpfZA9rKQIf6oAG+0VruZBs=;
 b=kSX8AEJ2+e4lpN1SlgpbNszv1HJw7HQpsxYErNnsWMmryfnK5nLUS+7DXaaviyrzAQ
 MfPYHbeYnSgPNXK59tDEQ8KRnpaDPfLC88sJUR+Fg7omQtQHDUSHvxCMhC367zb+9P5F
 TV2Jx8MoGv4lyWcqnsJ1Q1bWZWMDnTTfUSW5gw072ektLGy+2C/8tuSkI99RiYOHdTzy
 FfJCdNPr947baUHW8NC05YPZ2H2sVRx88e/WNkrFgUYAltCU4XggNK63ATgMwq1NDLDW
 IJ+4Z4JVq61CJawA8a2i622fxVs9QXeyEamwZfkfiFFJHBjsC4TouTnCyjknZxKWwMJg
 JmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=Ef1jYq7fQO1GqHf8CUeZDpfZA9rKQIf6oAG+0VruZBs=;
 b=i2rRyFYh+Z86olAhxxpe9z6ZpXhUpxdWOiQJpkQvstyM/M7tZIrqYAFJUelBMNU5Qe
 NQs5qyxZ8exl/v6QIKtmUR8kbYX9N8gSLMLUc3tF/CsaZmAkkiUeAJtyapBOzrrE653L
 QUcj5zSBI8pHAP+4TlLWfxMpBitnUzYY4c0bIyl9pFg3w6nW6V4qVYiYo7OnpPjJAN1E
 xe9wiZJZUF7kEpTTqYlhHzrHwMX4wm9Lg/7FtYrPfjXDALrVzP5t6hhI75YKkYIOk89Y
 qFmF5tR13MDa625BI9MvVHlRPAOVyPsf7XUdTrpZRGVbkzCPrgtOa+akgJk2nOUW6ztk
 WKGg==
X-Gm-Message-State: AOAM533ZVmOudtq2Lw5Ou/3Vso3Ecb5VF+Zf/9u8wDLzNZ2sZJvyc4cT
 RVU+JzsmbTlXVlP9ubAUYtimftzB/dU=
X-Google-Smtp-Source: ABdhPJyckhHFaJSZzimPlTk4rAcFXls3SYtylOSdf/cY1ONzvVQipDS3Bp4sl3gT0Za/VvvdmtLzeg==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr321870wmc.123.1597763218151; 
 Tue, 18 Aug 2020 08:06:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g18sm36340434wru.27.2020.08.18.08.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 08:06:57 -0700 (PDT)
Subject: Re: TTM/nouveau conflict in drm-misc-next
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
 <737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3f600794-7d37-8b3c-a8e9-b0ff1170a61d@gmail.com>
Date: Tue, 18 Aug 2020 17:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0839066307=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0839066307==
Content-Type: multipart/alternative;
 boundary="------------DB93F5407CABE81C2A64E4F2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DB93F5407CABE81C2A64E4F2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.20 um 08:31 schrieb Thomas Zimmermann:
> Hi
>
> Am 14.08.20 um 18:21 schrieb Koenig, Christian:
>>
>> Am 14.08.2020 17:53 schrieb Alex Deucher <alexdeucher@gmail.com>:
>>
>>      On Fri, Aug 14, 2020 at 11:22 AM Christian König
>>      <christian.koenig@amd.com> wrote:
>>      >
>>      > Hey Thomas & Alex,
>>      >
>>      > well the TTM and Nouveau changes look good to me, but this completely
>>      > broke amdgpu.
>>      >
>>      > Alex any idea what is going on here?
>>
>>      What's broken in amdgpu?  There shouldn't be any ttm changes in amdgpu
>>      for drm-next.  Those all go through drm-misc.
>>
>>
>> It's not a TTM change.
>>
>> The backmerge of drm-next into drm-misc-next broke amdgpu so that even
>> glxgears doesn't work anymore.
>>
>> But each individual merge head still works fine as far as I can say.
>>
>> Any idea how to track that down?
> The backmerge brought in
>
>    Fixes: 16e6eea29d7b ("Merge tag 'amd-drm-fixes-5.9-2020-08-07' ...)
>
> which has quite a few commit. Maybe it's in one of them.

Nope, I have just double checked that I can revert either parent of the 
merge and the problem disappears.

I somehow need to figure out how to cleanly revert all patches in one 
branch one by one and then do a reverse bisect. Oh, sometimes I love my 
job :(

If anybody has a good idea how to do this please speak up.

Thanks,
Christian.

>
> Best regards
> Thomas
>
>> Christian.
>>
>>
>>      Alex
>>
>>      >
>>      > Regards,
>>      > Christian.
>>      >
>>      > Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
>>      > > Hi Christian and Ben,
>>      > >
>>      > > I backmerged drm-next into drm-misc-next and had a conflict between ttm
>>      > > and nouveau. struct ttm_mem_res got renamed to struct ttm_resource. I
>>      > > updated nouveau to the new name, test-built, and pushed the result to
>>      > > drm-misc-next. If either of you has a minute, you may want to double
>>      > > check the merge.
>>      > >
>>      > > Best regards
>>      > > Thomas
>>      > >
>>      >
>>      > _______________________________________________
>>      > amd-gfx mailing list
>>      > amd-gfx@lists.freedesktop.org
>>      > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637330172275088649&amp;sdata=X2ZJUETwoq884Xtg66sDudjXB%2F3s%2BgRglnh33gpU4Hc%3D&amp;reserved=0
>>
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------DB93F5407CABE81C2A64E4F2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 17.08.20 um 08:31 schrieb Thomas
      Zimmermann:<br>
    </div>
    <blockquote type="cite"
      cite="mid:737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de">
      <pre class="moz-quote-pre" wrap="">Hi

Am 14.08.20 um 18:21 schrieb Koenig, Christian:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Am 14.08.2020 17:53 schrieb Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>:

    On Fri, Aug 14, 2020 at 11:22 AM Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
    &gt;
    &gt; Hey Thomas &amp; Alex,
    &gt;
    &gt; well the TTM and Nouveau changes look good to me, but this completely
    &gt; broke amdgpu.
    &gt;
    &gt; Alex any idea what is going on here?

    What's broken in amdgpu?  There shouldn't be any ttm changes in amdgpu
    for drm-next.  Those all go through drm-misc.


It's not a TTM change.

The backmerge of drm-next into drm-misc-next broke amdgpu so that even
glxgears doesn't work anymore.

But each individual merge head still works fine as far as I can say.

Any idea how to track that down?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The backmerge brought in

  Fixes: 16e6eea29d7b ("Merge tag 'amd-drm-fixes-5.9-2020-08-07' ...)

which has quite a few commit. Maybe it's in one of them.</pre>
    </blockquote>
    <br>
    Nope, I have just double checked that I can revert either parent of
    the merge and the problem disappears.<br>
    <br>
    I somehow need to figure out how to cleanly revert all patches in
    one branch one by one and then do a reverse bisect. Oh, sometimes I
    love my job :(<br>
    <br>
    If anybody has a good idea how to do this please speak up.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:737111f0-3789-5e7d-3862-ca1a7c5050e8@suse.de">
      <pre class="moz-quote-pre" wrap="">

Best regards
Thomas

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Christian.


    Alex

    &gt;
    &gt; Regards,
    &gt; Christian.
    &gt;
    &gt; Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
    &gt; &gt; Hi Christian and Ben,
    &gt; &gt;
    &gt; &gt; I backmerged drm-next into drm-misc-next and had a conflict between ttm
    &gt; &gt; and nouveau. struct ttm_mem_res got renamed to struct ttm_resource. I
    &gt; &gt; updated nouveau to the new name, test-built, and pushed the result to
    &gt; &gt; drm-misc-next. If either of you has a minute, you may want to double
    &gt; &gt; check the merge.
    &gt; &gt;
    &gt; &gt; Best regards
    &gt; &gt; Thomas
    &gt; &gt;
    &gt;
    &gt; _______________________________________________
    &gt; amd-gfx mailing list
    &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
    &gt; <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637330172275088649&amp;amp;sdata=X2ZJUETwoq884Xtg66sDudjXB%2F3s%2BgRglnh33gpU4Hc%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Ca1aefc1ee22a4e733df908d8406a395c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637330172275088649&amp;amp;sdata=X2ZJUETwoq884Xtg66sDudjXB%2F3s%2BgRglnh33gpU4Hc%3D&amp;amp;reserved=0</a>


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
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

--------------DB93F5407CABE81C2A64E4F2--

--===============0839066307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0839066307==--
