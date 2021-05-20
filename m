Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D06C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF29F6135A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF29F6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5245D6F4FD;
	Thu, 20 May 2021 19:18:54 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532096F4FC;
 Thu, 20 May 2021 19:18:51 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 g7-20020a9d12870000b0290328b1342b73so8016587otg.9; 
 Thu, 20 May 2021 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k4cJT0t0XqH8XRsIxYqfk56ojXIbxXc2e35W87HcykQ=;
 b=qHh6R09e+J7BzRLsfIkrZMaQF90Gh7tDIXX+qeJYMxDO8auMYJ3XchSJ7PZTfNmgWB
 mzdqLCK4X8jPmwYddiEy/c17ZzX1r6f52WgqcYNpLxnre/4+n7JnLiIOGg6b342lwt/M
 RMLeDi31SjXNTCrr6jKqvsRm/x5lldWcKuzMftPWdqjw/DxJXlp2foLpm/nsqPOZEaPL
 tG0Kj7P+apd+zhYkpPBZz2ka2jU8ZlGEAWURsAH/mXDIRhDNGNMjfR4fAqeQu5dn3be+
 oz1NzWMfb2KNeLNLqypWB5HL77m5jsBd9OCSBbSEzWg2b33NwDdr/lM9Kojo91N+3WDr
 oNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k4cJT0t0XqH8XRsIxYqfk56ojXIbxXc2e35W87HcykQ=;
 b=JC5DXS/fBAILahMRfPy/fESZrFaTT5fevcJK9lyLujL/+t03jE7+WuNpDJaWHU4H1S
 afbuFZwMAzlotVg63Yfrg4MQuw6ESUJx7M3tTXfRUNSLIDyxX/8DRlZVP1LQ9+qCU2bE
 lcQa0k75H+syfh947zwUphk6NhLU4gKpEPNxT3HIXOwzwUNc0qq8AudLGWERa+lpBpRE
 84SfGinhMwPtYxPcAXidGcTkjkxD+GwS+LjRnmvGAykBRcLa028F9K18fjIYVasRQF7G
 xMwKR49EdaCm+O7hBZDQHFNsEynnsNqHfrALM022iKoK7O03ZKAbXKbpKdnt/BnrS6Gj
 OFfA==
X-Gm-Message-State: AOAM5330/2y6+JGcABvviMBORtpwGFhkLP6mtFLCG2YVPzTBuC8JGKvV
 Xw0/ddxXKKW0Eh7BQ7fQIi2BLITIefzs5vAC1zk=
X-Google-Smtp-Source: ABdhPJwbhch6P7kEoQ/7IE2/9EGX+cfUBP3J4UMXaGAyK0/P18gcZ6qVrnDYx1H+9tG35FMsygm5TBUusV0zgaq6Cpo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5113995oti.23.1621538330703; 
 Thu, 20 May 2021 12:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-24-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-24-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:18:39 -0400
Message-ID: <CADnq5_M0=6O3jzTZ-fwbwf4fnJM3YzyodsH0_56Kj7vSt1JZ5Q@mail.gmail.com>
Subject: Re: [PATCH 23/38] drm/amd/amdgpu/gmc_v7_0: Fix potential copy/paste
 issue
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjdfMC5jOjUyNjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgZ21j
X3Y4XzBfc2V0X2ZhdWx0X2VuYWJsZV9kZWZhdWx0KCkuIFByb3RvdHlwZSB3YXMgZm9yIGdtY192
N18wX3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdCgpIGluc3RlYWQKPgo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCAyICstCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCj4gaW5kZXggMjEwYWRhMjI4OWVjOS4uOGUyODIxNjlm
OTllYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+IEBAIC01MTYs
NyArNTE2LDcgQEAgc3RhdGljIHZvaWQgZ21jX3Y3XzBfZ2V0X3ZtX3B0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPiAgfQo+Cj4gIC8qKgo+IC0gKiBnbWNfdjhfMF9zZXRfZmF1bHRfZW5h
YmxlX2RlZmF1bHQgLSB1cGRhdGUgVk0gZmF1bHQgaGFuZGxpbmcKPiArICogZ21jX3Y3XzBfc2V0
X2ZhdWx0X2VuYWJsZV9kZWZhdWx0IC0gdXBkYXRlIFZNIGZhdWx0IGhhbmRsaW5nCj4gICAqCj4g
ICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICogQHZhbHVlOiB0cnVlIHJlZGly
ZWN0cyBWTSBmYXVsdHMgdG8gdGhlIGRlZmF1bHQgcGFnZQo+IC0tCj4gMi4zMS4xCj4KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
