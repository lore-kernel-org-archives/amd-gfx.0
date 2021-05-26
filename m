Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D3DC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4FB6101E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4FB6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560926E4A2;
	Wed, 26 May 2021 12:44:11 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499406E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:44:10 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 n5-20020a1c72050000b0290192e1f9a7e1so432718wmc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=BRmhB5aN/yVDY4wIdaHP/dNZeCpCgz5VuiuyJz6KLxw=;
 b=cAUalqGXArmkUXaFT57+SPba9U8mzJV5QspD+FKFj1w4Y/lySx3xBh5o0UohZztynJ
 6EoU1vsXek7392Vjofd2r6M9qFJK8/voHyviNvwJaQsVQLftTKR+8QabYAa7pLPjhxSZ
 r/ZpnRoO9URa4Ag+/e2NW1/IGep5qQ3zcElv97pNbRHqYKYWpoyc5tnDAxe4pCcPpNBn
 1vfbqcVlAwx3U5VnszO6RwOfPtFY+7d/6x05izFx0fajoimOWw0hLFOMBJyB/O9dX4GE
 KNN3iE1gAR+E5aIpn1rfBBSfzLRpxMpnaOTdWxiIfd+L032FdTfvt3gS/wY0MG1DUVKh
 BSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BRmhB5aN/yVDY4wIdaHP/dNZeCpCgz5VuiuyJz6KLxw=;
 b=b/f9QoMA7NWHEjFLlzN4GfUH2GOzibOwpnZR0MiBTfhoeeC7c+ZItDJsu9gu074O7w
 RyrKQJ9HzwW3unrxtnv8nXfXmcOBWlppRfQR3YqRQ2k5nzvMO1PJ1XxqYVHfEL883F/E
 Tz5k7WT6QazHYfI0J+5eYcRE5EH+QrtHV137m7gFfZkRS1zt18FQlDuk+uMMVJxYKWiK
 QupaXH0FASaUcDr0mEIoUJjYdfsrqX781//TpfQIqijWwCg+dBbtTyh/C+EzlFyJIryx
 BB7cHyJ+xAz0Jc/E7/+1ewZh4T/vl8kTLDo+Ew1nb76d3RD3KTPGrj7bL/65rUnSnB7T
 LphQ==
X-Gm-Message-State: AOAM5334JC+Hx5UubJKA3RmpfI8cWHCU7XY17T41QBIAw0hxQfxyqEVi
 Ouphh8WGpocjJ/864nzTf/Y=
X-Google-Smtp-Source: ABdhPJxeShJczo9oCAdFRX5ub+jlSEF4FeoqITQ+O/fcd0moJBM/7I/c3XhyBHMTQpTkijcNxkSBDw==
X-Received: by 2002:a1c:9d4b:: with SMTP id g72mr2152087wme.111.1622033049044; 
 Wed, 26 May 2021 05:44:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3ecd:562c:67c6:4afe?
 ([2a02:908:1252:fb60:3ecd:562c:67c6:4afe])
 by smtp.gmail.com with ESMTPSA id b81sm6912890wmd.18.2021.05.26.05.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 05:44:08 -0700 (PDT)
Subject: Re: [PATCH] free the metadata buffer for sg type BOs as well
To: Shiwu Zhang <shiwu.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 nirmoy.das@amd.com
References: <20210526034625.5805-1-shiwu.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <152919d2-6ded-3121-1be5-a423cfd3b531@gmail.com>
Date: Wed, 26 May 2021 14:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526034625.5805-1-shiwu.zhang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WW91IG5lZWQgYSBjb21taXQgbWVzc2FnZS4KCkFtIDI2LjA1LjIxIHVtIDA1OjQ2IHNjaHJpZWIg
U2hpd3UgWmhhbmc6Cj4gU2lnbmVkLW9mZi1ieTogU2hpd3UgWmhhbmcgPHNoaXd1LnpoYW5nQGFt
ZC5jb20+CgpXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IDJkODc2ZTFlYWE3Yy4uZTlmODcwMWZk
MDQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
IEBAIC05NSw3ICs5NSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ib19kZXN0cm95KHN0cnVjdCB0
dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+ICAgCX0KPiAgIAlhbWRncHVfYm9fdW5yZWYoJmJvLT5w
YXJlbnQpOwo+ICAgCj4gLQlpZiAoYm8tPnRiby50eXBlID09IHR0bV9ib190eXBlX2RldmljZSkg
ewo+ICsJaWYgKGJvLT50Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKPiAgIAkJdWJv
ID0gdG9fYW1kZ3B1X2JvX3VzZXIoYm8pOwo+ICAgCQlrZnJlZSh1Ym8tPm1ldGFkYXRhKTsKPiAg
IAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
