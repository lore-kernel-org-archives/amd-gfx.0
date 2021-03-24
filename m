Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6201C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 07:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2FC61477
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 07:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2FC61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1B36E204;
	Wed, 24 Mar 2021 07:40:27 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC086E204
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 07:40:26 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id a7so31220945ejs.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6HYIBeHvxznqdBVWa6bpdj2EIZXSwbheny+1CxshnTQ=;
 b=o/f6A1cofWZF9XakRLTXrza62eTuKgC3zo/NQ48RQrmZ7nGYykbqhztUsb79PzDuJZ
 t/7n8cJOv/SlbAFhMzX0Pt2v0WTsOr7YfgQr/Mnk90xS4d1CwgGEwUsSaRrbG/QUDAlR
 EdLRwPEU5tnewF/Yec6FwfsbWDeYsgArfoiqha0NeHzx5ZAt9AHJ9O2Ze6jjVyjjx+Ar
 co9O9FYoMnKLXGHWa0f0MJcAkWx/UYNFQa7JQOG2fHwYcUKWESdri2GxHatk+Blk9lRB
 ltrt8ME2uOSVYfpHqI2eGj1PfzBc1+mfLGnQWkloZu08tnLNmhUhdhYp49wIM/1vVwEC
 nqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6HYIBeHvxznqdBVWa6bpdj2EIZXSwbheny+1CxshnTQ=;
 b=auvmKfmRgTzoDzR7Ax9D56VuJLldJbKbVvHpZ84GlKFT/Te+bay+t6gWCNLvxJ6IXt
 O5hWe1uQzKDC7b8YIS7Qjlb4cmeebv0RNPR6c8wMoqRRSYAw3DUwy38D4Kya6WATZ7hh
 Oolwg9jhxTKZvrMhxGbLASc3/EClx4AwMr0FAf8ZQUl7m1excugCgBSXT63zKgpDboIz
 ifMfSU5vjwvwH+SZn1J/SurHyl1kveogBTg6CMKsj+NjKq2k4ACqPSJt8SCMyGviBbf6
 /cFBDqOmjV27LzaLw//X7zPEWzbAsHZPs8NotR4BEPont0dfYXO54+M93yuwAMzsNrK9
 3lJA==
X-Gm-Message-State: AOAM532NGnITGcHemKIUzVb9nURIfD5ZsL1a8RzZYLIhkQna+SihuE5R
 JuKI/G9JRdaB4MBEZXc8Y8AH55Q6mUo=
X-Google-Smtp-Source: ABdhPJwt1FOzqCF+vuJFl9f/v7tnoQzNh7C54b8ASBY9kI4zsAWeVPxiM3NsZhEhZsvgkE+5duNRWQ==
X-Received: by 2002:a17:906:4107:: with SMTP id
 j7mr2272273ejk.185.1616571624793; 
 Wed, 24 Mar 2021 00:40:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:88b6:b57f:c215:b543?
 ([2a02:908:1252:fb60:88b6:b57f:c215:b543])
 by smtp.gmail.com with ESMTPSA id t17sm699325edr.36.2021.03.24.00.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 00:40:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: use zero as start for dummy resource walks
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210323145458.38910-1-christian.koenig@amd.com>
 <DM5PR1201MB0057700875E337FCB79A11A787639@DM5PR1201MB0057.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5a534ba0-7276-a236-e268-7b9feb23f3de@gmail.com>
Date: Wed, 24 Mar 2021 08:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <DM5PR1201MB0057700875E337FCB79A11A787639@DM5PR1201MB0057.namprd12.prod.outlook.com>
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjQuMDMuMjEgdW0gMDQ6MjYgc2NocmllYiBQYW4sIFhpbmh1aToKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBJIGRvbuKAmXQgdGhp
bmsgc28uIFN0YXJ0IGlzIG9mZnNldCBoZXJlLiBXZSBnZXQgdGhlIHZhbGlkIHBoeXNpY2FsIGFk
ZHJlc3MgZnJvbSBwYWdlc19hZGRyW29mZnNldF0gd2hlbiB3ZSB1cGRhdGUgbWFwcGluZy4KCkdv
b2QgcG9pbnQsIG1obSBuZWVkIHRvIHRha2UgYW4gZXZlbiBjbG9zZXIgbG9vayBhdCB0aGlzIHRo
ZW4uCgo+IEJ0dywgd2hhdCBpc3N1ZSB3ZSBhcmUgc2VlaW5nPwoKV2Ugc2VlIGEgQlVHX09OKCkg
YmFja3RyYWNlIHdoZW4gdGhpcyBpcyB1c2VkIHRvZ2V0aGVyIHdpdGggUFJUIG1hcHBpbmcgCmlu
IE9wZW5HTCBhbmQgVnVsa2FuIGJlY2F1c2UgdGhlIG9mZnNldCBpcyBqdXN0IG5vbnNlbnNlIGlu
IHRoaXMgY2FzZS4KClRoYW5rcyBmb3IgcG9pbnRpbmcgb3VyIHRoZSBpc3N1ZSwKQ2hyaXN0aWFu
LgoKPgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENocmlzdGlhbiBL
P25pZwo+IFNlbnQ6IDIwMjHlubQz5pyIMjPml6UgMjI6NTUKPiBUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogRGFzLCBOaXJtb3kgPE5pcm1veS5EYXNAYW1kLmNvbT47IENo
ZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBk
cm0vYW1kZ3B1OiB1c2UgemVybyBhcyBzdGFydCBmb3IgZHVtbXkgcmVzb3VyY2Ugd2Fsa3MKPgo+
IFdoZW4gd2UgZG9uJ3QgaGF2ZSBhIHBoeXNpY2FsbHkgYmFja2luZyBzdG9yZSB3ZSBzaG91bGQg
dXNlIHplcm8gaW5zdGVhZCBvZiB0aGUgdmlydHVhbCBzdGFydCBhZGRyZXNzIHNpbmNlIHRoYXQg
aXNuJ3QgbmVjZXNzYXJ5IGEgdmFsaWQgcGh5c2ljYWwgb25lLgo+Cj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaCB8IDIgKy0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4gaW5kZXggNDBmMmFk
ZjMwNWJjLi5lOTQzNjJjY2Y5ZDUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPiBAQCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgYW1kZ3B1X3Jlc19maXJzdChzdHJ1Y3QgdHRtX3Jlc291cmNlICpyZXMsCj4gICBzdHJ1
Y3QgZHJtX21tX25vZGUgKm5vZGU7Cj4KPiAgIGlmICghcmVzIHx8ICFyZXMtPm1tX25vZGUpIHsK
PiAtY3VyLT5zdGFydCA9IHN0YXJ0Owo+ICtjdXItPnN0YXJ0ID0gMDsKPiAgIGN1ci0+c2l6ZSA9
IHNpemU7Cj4gICBjdXItPnJlbWFpbmluZyA9IHNpemU7Cj4gICBjdXItPm5vZGUgPSBOVUxMOwo+
IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0N4aW5odWkucGFuJTQwYW1kLmNvbSU3QzAz
MWM3NDNiZDdjNDQ4ZThkOTE1MDhkOGVlMGJhNDAyJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUyMTA4MTA1MzEwNTI5NSU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1scko2azNRQlhxTTlHNkdSSzI1ZnJGbHFB
TmtiZlI0a0F2NkEzJTJGOG15QmMlM0QmYW1wO3Jlc2VydmVkPTAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
