Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58A8C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C48A613C7
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C48A613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA386EE09;
	Thu, 27 May 2021 03:56:30 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F6C6EE09;
 Thu, 27 May 2021 03:56:29 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id c3so3812405oic.8;
 Wed, 26 May 2021 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m0jJCLmOTTk7R3I0dOOysXS/9UkIHt3JyqhG11vxOu8=;
 b=bhVAq5i/UwQ3hdFM6/4lFFKrEsLKys4PeBECdlxkFDsGZSH9uR5zIou5Hn48fGzrIE
 cdZRNIdiIJC79QcCtMHLoRsPfKzl3BGxraNIpTDD0JDqiUifLKCkrFoouE+Mqoa0RqKd
 TXxZigAH0zfBwsHG72QOJQzWqM04RIEWixdApmY87iWanX837uR96/2chzsRLRa4mEKq
 FjsetMfTlcqHk30WCuWfqvM2W07ZeDWBw6apDAUlz3M33WfCS8s57PJVtnWQiCagAJ0v
 8DdJOxFaNVdDuwoI72sffvFNR6dv7xECjeBuqyq7+C2HvS+KQ8UNStrnkVean1pJPCL0
 kW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m0jJCLmOTTk7R3I0dOOysXS/9UkIHt3JyqhG11vxOu8=;
 b=X7Pj4AvFlJWgJ68CUQn5eeQIl4sqjV5xfqEdihahnS59TzZEBUvaZ8SRTzTkR6wVI6
 pHxaGBPNMf8mBgYp3iOVPnfG+fgHr9QP/jtJIfsqT5JxPkk3/zL8oEjJ0+tUWc6URhOY
 jUv07b/PdqyIi20nsNzufDrzWX8QiuDOm1Rgoiz+xsvYUdV09zn+TxhAc6+DImUZzLs3
 UTR9WUh5zK6nxEoa1bj3h68Q8emL08Iluixid7ChfaU8kJswkoa4Bh3E3W1Phqjwe8+f
 0gurMIWEpH6VH11BP4vvfTg6mfG7B3yHjAYKVuCy1qM2dNt0yLkERWunXALq0XckXefb
 lgmQ==
X-Gm-Message-State: AOAM5323lI9RkPm8sgUs2Mf+v2uW4SEGv7RbEJejZm0Jfe4lvE5tRohW
 T7tV5Yo+0wdH6I+ozQ+gCX9TaimuvHtL5t5NpR8VOUek
X-Google-Smtp-Source: ABdhPJxdi3Mn6amONheYLR4VwqBYJHZISa2gtEudSqMqeC7zJHQsy0+SZo4vA8m8fcUpIEww3nOPrh/0Ukq0UoxZKYM=
X-Received: by 2002:a05:6808:206:: with SMTP id l6mr3994650oie.5.1622087788663; 
 Wed, 26 May 2021 20:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-10-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-10-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 23:56:17 -0400
Message-ID: <CADnq5_Oq0f+0e31pBBqej0Cvi2c_w2RFxbaChz+O2r4ezXkSAg@mail.gmail.com>
Subject: Re: [PATCH 09/34] drm/amd/display/dc/bios/command_table_helper2: Fix
 function name 'dal_cmd_table_helper_transmitter_bp_to_atom2()'
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZV9oZWxwZXIyLmM6MTQxOiB3YXJu
aW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciB0cmFuc2xhdGVfdHJhbnNtaXR0ZXJfYnBfdG9f
YXRvbTIoKS4gUHJvdG90eXBlIHdhcyBmb3IgZGFsX2NtZF90YWJsZV9oZWxwZXJfdHJhbnNtaXR0
ZXJfYnBfdG9fYXRvbTIoKSBpbnN0ZWFkCj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1h
bmRfdGFibGVfaGVscGVyMi5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlcjIuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5jCj4gaW5kZXggMDA3MDZi
MDcyYjVmOC4uNmQyZmIxMTJhZDlmOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlcjIuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5jCj4gQEAg
LTEyOSw3ICsxMjksNyBAQCBib29sIGRhbF9jbWRfdGFibGVfaGVscGVyX2NvbnRyb2xsZXJfaWRf
dG9fYXRvbTIoCj4gIH0KPgo+ICAvKioKPiAtICogdHJhbnNsYXRlX3RyYW5zbWl0dGVyX2JwX3Rv
X2F0b20yIC0gVHJhbnNsYXRlIHRoZSBUcmFuc21pdHRlciB0byB0aGUKPiArICogZGFsX2NtZF90
YWJsZV9oZWxwZXJfdHJhbnNtaXR0ZXJfYnBfdG9fYXRvbTIgLSBUcmFuc2xhdGUgdGhlIFRyYW5z
bWl0dGVyIHRvIHRoZQo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b3JyZXNwb25kaW5nIEFUT00gQklPUyB2YWx1ZQo+ICAgKiAgQHQ6IHRyYW5zbWl0dGVyCj4gICAq
ICByZXR1cm5zOiBkaWdpdGFsVHJhbnNtaXR0ZXIKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
