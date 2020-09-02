Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF398C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33CE20773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ9FEhKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33CE20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFC96E926;
	Wed,  2 Sep 2020 15:07:16 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5316E926
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 15:07:16 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j2so5615077wrx.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XBgZNHn/bHxcTa4njuvyMCDTc4iJNB89XiWMV5gbO10=;
 b=hJ9FEhKcgqGhcnyJJIZbSRff1vEdWqa7p/t3psyLvN2usvH3NZp1S8F+cxvDJF8ayC
 5dKJ6OszrxUNtD+HCcm+Kog/9mRjL6YvYKchUW1vFbFnZE4KsgkLEoOkvBUTAqgHDlMK
 rINLFfcgghqTFR5ecbNUsV5RbmrlDgjerAeN/Hk9z+OwHf0CeeaLlnfSitMPzb3NAYfo
 LU+80WaCdirAg6y7efY1Sli7r88WIhO6RbqZzzis7SrK/CHhhCQX+uARl4T8LKhjNpTZ
 70GhVEcLC4Nuo8D3i27g3cef8+hqEFkqyEw7EWHJ0HMEb+JkIVZNsPUmd9QIs+PkpdIT
 uXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=XBgZNHn/bHxcTa4njuvyMCDTc4iJNB89XiWMV5gbO10=;
 b=tQNKD0Y8hFM3MAyOmp0t+LmKUC6T4kWRudEDrvRRa5Vae1kVSqKs1EOCMMxClOVd5p
 F4HIrbR9vUieBetZgHmqLO8WoPT+GRO3eveG0WRsL6JyjsBHMLV8XvxglIfkzFOCXwjz
 ua3JyOkFE3OfF99kaIsrSODbCWLXYl8PqXjDyhTQiPqmnVgSSus3+De4RIsW1litue+u
 brNiz5HHdtpI1l940ga/r+xFydSelWp8yPP3N7GzVyxRTOm09CQ5r/Ykpibicq3w/SIa
 OHJpzrzBeV9MLEmi3NjGZ3RF59hW0cQtxis1VV+/BjvC+tqhWEWIdjWnefgVXh9EZIbV
 N+yQ==
X-Gm-Message-State: AOAM5324Yyi7yDk+XxMePmESf5NjiGQfEVQqHnTVkuAGZhWweVUYDifr
 GG2Rt7LsUEEdv+EfJ0TzBBTbGOU1Aws=
X-Google-Smtp-Source: ABdhPJz/ZiePO1swHl6g78cJ+0dqhD2xQOPRcRooD9lev/u5+MXHCeIZ/Y3W8/Cem9SLJtIityj5pA==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr7146541wrv.138.1599059234453; 
 Wed, 02 Sep 2020 08:07:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f126sm6944809wmf.13.2020.09.02.08.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:07:13 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v2
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20200902140512.2343-1-christian.koenig@amd.com>
 <32A985F3-1C3B-45E4-B90F-7C023CCE7B71@amd.com>
 <98a58d52-81a3-c7de-f848-e612c1f52e59@gmail.com>
 <D6AE689D-F89B-484C-9591-B8C4EEF56393@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <79c0cb65-c7a5-9093-ad3d-d1518497c0bd@gmail.com>
Date: Wed, 2 Sep 2020 17:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <D6AE689D-F89B-484C-9591-B8C4EEF56393@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMTY6NTMgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Oeac
iDLml6UgMjI6MzHvvIxDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4g5YaZ6YGT77yaCj4+Cj4+IEFtIDAyLjA5LjIwIHVtIDE2OjI3IHNjaHJpZWIgUGFu
LCBYaW5odWk6Cj4+Pj4gMjAyMOW5tDnmnIgy5pelIDIyOjA177yMQ2hyaXN0aWFuIEvDtm5pZyA8
Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IOWGmemBk++8mgo+Pj4+Cj4+Pj4gQ2Fs
Y3VsYXRlIHRoZSBjb3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBydW4g
YWZ0ZXIgdGhlCj4+Pj4gcGFnZV9hZGRyZXNzIGFycmF5Lgo+Pj4+Cj4+Pj4gdjI6IFhpbmh1aSBw
b2ludGVkIG91dCB3ZSBkb24ndCBuZWVkIHRoZSBzaGlmdAo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+IEZpeGVz
OiAxZTY5MWUyNDQ0ODcgZHJtL2FtZGdwdTogc3RvcCBhbGxvY2F0aW5nIGR1bW15IEdUVCBub2Rl
cwo+Pj4+IC0tLQo+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwg
MiArLQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+PiBpbmRleCA4
YmMyMjUzOTM5YmUuLmJlODg2YmRjYTVjNiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4gQEAgLTE2OTcsNyArMTY5Nyw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
Pj4gCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7Cj4+Pj4gCQl9IGVsc2Ugewo+Pj4+
IAkJCWFkZHIgPSAwOwo+Pj4+IC0JCQltYXhfZW50cmllcyA9IFM2NF9NQVg7Cj4+Pj4gKwkJCW1h
eF9lbnRyaWVzID0gbWFwcGluZy0+bGFzdCAtIG1hcHBpbmctPnN0YXJ0ICsgMTsKPj4+IFlvdSBu
ZWVkIG1pbnVzIHBmbiBoZXJlLgo+PiBUaGF0IGRvZXNuJ3Qgc291bmQgY29ycmVjdCBlaXRoZXIu
IFRoZSBwZm4gaXMgdGhlIGRlc3RpbmF0aW9uIG9mIHRoZSBtYXBwaW5nLCBlLmcuIHRoZSBvZmZz
ZXQgaW5zaWRlIHRoZSBCTyBhbmQgbm90IHJlbGF0ZWQgdG8gdGhlIHZpcnR1YWwgYWRkcmVzcyBy
YW5nZSB3ZSBtYXAuCj4gSSBtZWFuIHdlIG5lZWQgbWludXMgcGZuIHRvby4gcGZuIGlzIG1hcHBp
bmctPm9mZnNldCA+PiBQQUdFX1NISUZULgo+Cj4gSW4gYW1kZ3B1X3ZtX2JvX21hcCgpLCB0aGVy
ZSBpcyBhIGNoZWNrICBiZWxvdwo+IGlmIChibyAmJiBvZmZzZXQgKyBzaXplID4gYW1kZ3B1X2Jv
X3NpemUoYm8pKQo+IHJldHVybiAtRUlOVkFMOwo+IHNvIG1hcHBpbmctPm9mZnNldCBpcyBqdXN0
IGFuIG9mZnNldF9pbl9ieXRlcyBpbnNpZGUgdGhlIEJPIGFzIHlvdSBzYWlkLgoKQ29ycmVjdCwg
YnV0IHRoaXMgaXMgdGhlIGRlc3RpbmF0aW9uIG9mIHRoZSBtYXBwaW5nIGFuZCBub3QgdGhlIGNv
dmVyZWQgClZBIHNwYWNlLgoKSW4gb3RoZXIgd29yZHMgc3RhcnQgY2FuIGJlIDQsIGxhc3QgYmUg
NSBhbmQgb2Zmc2V0IDY0ayBhbmQgaXQgd291bGQgCnN0aWxsIGJlIHZhbGlkIGFzIGxvbmcgYXMg
dGhlIGJvIGlzIGF0IGxlYXQgNjRrKzIgcGFnZXMgaW4gc2l6ZS4KCj4gbWFwcGluZy0+c3RhcnQg
YW5kIG1hcHBpbmctPmxhc3QgYXJlIHZpcnR1YWwgYWRkcmVzc2VzIGluIHBmbnMsIHRoZSByYW5n
ZSB3ZSBhcmUgZ29pbmcgdG8gdG91Y2ggdGhlbiBpcyBbc3RhcnQrIG9mZnNldF9pbl9wZm5zLCBs
YXN0XS4KCk5vLCB0aGF0IGlzIGNvbXBsZXRlbHkgdW5yZWxhdGVkLgoKQ2hyaXN0aWFuLgoKPgo+
Pj4gVGhlIHJhbmdlIHdlIGFyZSBnb2luZyB0byB0b3VjaCBpcyBbc3RhcnQgKyBvZmZzZXQsIGxh
c3RdLgo+Pj4gc28gdGhlIG1heF9lbnRyaWVzIGlzIGxhc3QgLSAoc3RhcnQgKyBvZmZzZXQpICsg
MS4gYW5kIG9mZnNldCBpcyBwZm4gaW4gdGhpcyBjYXNlLgo+Pj4KPj4+IEkgc3RpbGwgaGl0IHBh
bmljIHdpdGggdGhpcyBwYXRjaCBpbiBwcmFjdGljZS4KPj4gVGhhbmtzIGZvciB0ZXN0aW5nLCBJ
IHRoaW5rIEkga25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzLgo+Pgo+PiBXZSBuZWVkIHRvIHN0YXJ0
IGluc3RlYWQgb2YgbWFwcGluZy0+c3RhcnQgb3Igb3RoZXJ3aXNlIHRoZSB2YWx1ZXMgaXMgdG8g
bGFyZ2UgYWZ0ZXIgdGhlIGZpcnN0IGl0ZXJhdGlvbi4KPj4KPj4gR2l2ZSBtZSBhIHNlY29uZCBm
b3IgYSB2My4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4+IAkJfQo+Pj4+Cj4+Pj4gCQlpZiAocGFn
ZXNfYWRkcikgewo+Pj4+IC0tIAo+Pj4+IDIuMTcuMQo+Pj4+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
