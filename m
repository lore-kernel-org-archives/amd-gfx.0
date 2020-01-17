Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB56C33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 08:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1A22072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa3Miu4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1A22072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD67A6F422;
	Fri, 17 Jan 2020 08:17:52 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DE86F422
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 08:17:51 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c14so21726314wrn.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 00:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ROD4LXLmoCZNTjqaNd+dtPKddFID62kcNqe+8NzBgps=;
 b=oa3Miu4W4DMoL5YFI5ekgDJ64zFXNp66HkhOdlobnw4wfxVIMJiGkZVo8GShtQLsog
 5CaqaqC/NLPicXmDLSMpdoPN+Q5/fXgUecg33orzdt5iddrjtV8/SuvRHgJFgW3GLPbo
 kAGQhPBV4yUTiLPQInb1BwQF5R7lAWtFePRhK8bm4Rwj/081zdSLIDUiv95suKiTgsId
 pgLIenTEkwCvmL3XQ7cRU7JdCi2VPoa4nKV5JbpX82uN1KImWthZ40tCCcDZzDhwAXHo
 YaRg4JXGiUYO2Pj8kIZT6Wvyrwi5aA+1/w3curqvc6F0nf5Z/H69358WNBIwsz343gjO
 1CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ROD4LXLmoCZNTjqaNd+dtPKddFID62kcNqe+8NzBgps=;
 b=iUVklkvzs88X/nIEUeeTIu5k/4kKc38yam/iaG4fOexDtzJWXJSG9+Y/1G2lYaUR3m
 DAnfTTb3unTOrvhuJcCDMAYrwbYUtwkKssKDjD3ECUku/uQ56F21AihMRVuv8/M8EJro
 tOcQTBey7l61ZGpMuqMzX2ni1I+XqngYMkb23Au0JZlWk2hh2BzPA8pPj1HHw6mgajHc
 1VT3wWq1OYo+QwTrvnlMoJ0rl7XvHnc2cRR7d2UQA4Hx+Y6YdgY6yUfbTuFhO0d+lNYZ
 tljqoCuGtyWYbxWJjK/ryZMsw0hQaoGKdAhFkq9F0vFP73MoiuhPn2T9weooaNjX4yv/
 ht5Q==
X-Gm-Message-State: APjAAAUdu75R/Mq9P1wp6t4q3n8bUoc7OuikmKRXHpGXMGptk/rUqgTU
 ZnMziOAUlIYI7Gq+zG15gwGbpbKz
X-Google-Smtp-Source: APXvYqxWhAuPhGE7zcppgwSCWfBG4+KlSFl2I/HIGdejog/5gmxX/p3DBl9Uj9C+uvOQr5kgQXGehw==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr1796512wrw.188.1579249069977; 
 Fri, 17 Jan 2020 00:17:49 -0800 (PST)
Received: from [192.168.137.21] (aftr-37-201-195-117.unity-media.net.
 [37.201.195.117])
 by smtp.gmail.com with ESMTPSA id i5sm8504362wml.31.2020.01.17.00.17.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jan 2020 00:17:49 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
To: Felix Kuehling <felix.kuehling@amd.com>, fredrik.bruhn@unibap.com,
 amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
 <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
Date: Fri, 17 Jan 2020 09:17:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDEuMjAgdW0gMDM6MDEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDIwLTAx
LTE2IDg6MDksIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IENvcmVib290IHNlZW1zIHRvIGhh
dmUgYSBwcm9ibGVtIGNvcnJlY3RseSBzZXR0aW5nIHVwIGFjY2VzcyB0byB0aGUgCj4+IHN0b2xl
biBWUkFNCj4+IG9uIEtWL0tCLiBVc2UgdGhlIGRpcmVjdCBhY2Nlc3Mgb25seSB3aGVuIG5lY2Vz
c2FyeS4KPgo+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5ICJuZWNlc3NhcnkiLgoKTmVj
ZXNzYXJ5IGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UuCgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCAzICsrLQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIAo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMKPj4gaW5kZXggMTlkNWIxMzNlMWQ3Li45ZGE5NTk2
YTM2MzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18w
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+PiBAQCAt
MzgxLDcgKzM4MSw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y3XzBfbWNfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAKPj4gKmFkZXYpCj4+IMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfc2l6ZSA9IHBj
aV9yZXNvdXJjZV9sZW4oYWRldi0+cGRldiwgMCk7Cj4+IMKgIMKgICNpZmRlZiBDT05GSUdfWDg2
XzY0Cj4+IC3CoMKgwqAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgewo+PiArwqDCoMKg
IGlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUgJiYKPj4gK8KgwqDCoMKgwqDCoMKgIGFkZXYt
PmdtYy5yZWFsX3ZyYW1fc2l6ZSA+IGFkZXYtPmdtYy5hcGVyX3NpemUpIHsKPgo+IENQVSBhY2Nl
c3MgdG8gdGhlIHdob2xlIFZSQU0gaXNuJ3QgcmVhbGx5IG5lY2Vzc2FyeS4gSSB0aG91Z2h0IHRo
ZSAKPiBtYWluIG1vdGl2YXRpb24gZm9yIGFjY2Vzc2luZyBGQiBkaXJlY3RseSBvbiBBUFVzIHdh
cyBiZXR0ZXIgCj4gcGVyZm9ybWFuY2UuIFlvdSdyZSBkaXNhYmxpbmcgdGhhdCBvcHRpbWl6YXRp
b24gb24gYWxsIEFQVXMgd2hlcmUgdGhlIAo+IEZCIGlzIHNtYWxsZXIgdGhhbiB0aGUgYXBlcnR1
cmUgc2l6ZS4KCkNvcnJlY3QsIHllcy4gRm9yIHNvbWUgcmVhc29uIGNvcmVib290IHNlZW1zIHRv
IGV4cGxpY2l0bHkgc2V0dXAgdGhlIAptZW1vcnkgdXNlZCBmb3IgdGhlIEZCIGFzIHdyaXRlLXBy
b3RlY3RlZC4KClRoZSBHUFUgY2FuIHN0aWxsIHJlYWQvd3JpdGUgaXQgbm9ybWFsbHkgY2F1c2Ug
aXQgaWdub3JlcyB0aGF0IApwcm90ZWN0aW9uLCBidXQgdGhlIENQVSBjYW4ndCBjaGFuZ2UgdGhl
IEZCIG1lbW9yeSBhbnkgbW9yZSB3aXRoIHRoYXQgc2V0dXAuCgpObyBpZGVhIHdoeSB0aGV5IGRv
IHRoaXMsIG1vc3QgbGlrZWx5IGp1c3QgYW4gb3ZlciBjb25zZXJ2YXRpdmUgCnByb3RlY3Rpb24g
b2YgYSByZXNlcnZlZCBhcmVhIG9mIG1lbW9yeS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBS
ZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFw
ZXJfYmFzZSA9ICgodTY0KVJSRUczMihtbU1DX1ZNX0ZCX09GRlNFVCkpIDw8IDIyOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfc2l6ZSA9IGFkZXYtPmdtYy5yZWFsX3ZyYW1f
c2l6ZTsKPj4gwqDCoMKgwqDCoCB9Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
