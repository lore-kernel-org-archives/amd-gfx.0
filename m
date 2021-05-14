Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70401610A7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70401610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D96B6E0FB;
	Fri, 14 May 2021 07:26:21 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D01E6E0FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:26:20 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id k10so12096378ejj.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IuI9+xQQgh2PM07v6yiRO0xZYYhX/0DVNbwc3Y/gKVo=;
 b=EGIB13r3QxdMGEK6jWx19USrjODe8KWt+yPykl/0v8DnM132uIQRNe9buS6k6h6otb
 BU1KUiiVffZzGw3vllxTzIB31QRJtqxJClnjEwhC27o2n4rTaIvOQoAx47IhVdCBxTQp
 kybhNoiSWSzn2jI7PJpMqmJOTtiAYAWewimK7nHISrqqzF67u7r7O8FMpXG1JMhG+BDi
 qaGr+ZvthHta9z5Unx3hFsG/f+m8GPKbM2Y0LDIPtKjqShx56oqC7XoHKFNqHhnGAEkv
 3y27M5wCYzwLdEABDwVk1DdYkTm54evhDp0Uxjjrx6VY20YHLnBwNRwqYeTHWnO30ZcE
 7DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IuI9+xQQgh2PM07v6yiRO0xZYYhX/0DVNbwc3Y/gKVo=;
 b=r0B+5yMEHURKpiec3qAaFbxWohRpoBWWMufr9VqxTvgYhgNQRtfxpsk5OCgi3Srbti
 iF2hEKZhAKYiAUPPCX4CB8dpv6t9x3Blx/3VAVZYRqz6Xs36TtJKnarC47B57ltDg6wv
 jXhq/C/UB6nLG9q8dqgN9ij2Pes8hKtkXPKJhC1p3NqImoUiIl+Gyer2aWFF7qfgVMqw
 mvDICmtb1uro1EAmUWP2aLQLRppRVOXcxlDJsw4HZgPQpduYiGTg31d+EVO9cumSln4D
 2KfCRASixHSfzs/P/fBEdNHt38yl1nVve7oyLiaW985Lm+ch7TwT7N/v4vVRJ3CekQ4I
 Al3A==
X-Gm-Message-State: AOAM530A6I40QdIW+m8e+BzQekdJDs4JG2AHTsRBB1OaMEF5SpQSSwt9
 WjxvefJs22piPxL/eZP4xExDe6YvZM4=
X-Google-Smtp-Source: ABdhPJzixgLHG48uFdrWaBD+scQDR/5UaQ+x1FUDUVrE4vJJDSfcfkPrM8xHhc4JjmWKsxpG2AMDaA==
X-Received: by 2002:a17:906:a06:: with SMTP id
 w6mr47165113ejf.32.1620977179014; 
 Fri, 14 May 2021 00:26:19 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cf70:a0fd:8c48:efd4?
 ([2a02:908:1252:fb60:cf70:a0fd:8c48:efd4])
 by smtp.gmail.com with ESMTPSA id h23sm3125279ejx.90.2021.05.14.00.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 00:26:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
To: Alex Deucher <alexdeucher@gmail.com>, David M Nieto <david.nieto@amd.com>
References: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
 <20210513174539.27409-1-david.nieto@amd.com>
 <CADnq5_NtPNk_6uhgPu8dSE-RPgRwMXYBHFvQ50WzEj_3N2bbHA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <942da2f6-1aa2-3ec8-19fb-68be0da5f03d@gmail.com>
Date: Fri, 14 May 2021 09:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_NtPNk_6uhgPu8dSE-RPgRwMXYBHFvQ50WzEj_3N2bbHA@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDUuMjEgdW0gMjA6MDAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gVGh1LCBNYXkg
MTMsIDIwMjEgYXQgMTo0NSBQTSBEYXZpZCBNIE5pZXRvIDxkYXZpZC5uaWV0b0BhbWQuY29tPiB3
cm90ZToKPj4gRnJlZSB0aGUgcmVzb3VyY2VzIGlmIHRoZSBmZW5jZSBuZWVkcyB0byBiZSBpZ25v
cmVkCj4+IGR1cmluZyB0aGUgcmF0aW8gY2FsY3VsYXRpb24KPj4KPj4gU2lnbmVkLW9mZi1ieTog
RGF2aWQgTSBOaWV0byA8ZGF2aWQubmlldG9AYW1kLmNvbT4KPiBTZXJpZXMgaXM6Cj4gUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IFdpbGwg
cHVzaCBpdCBtb21lbnRhcmlseS4KClRvIGRybS1taXNjLW5leHQgb3IgYW1kLXN0YWdpbmctZHJt
LW5leHQ/IFlvdSBuZWVkIHRvIHJlYmFzZSBvbiB1cHN0cmVhbSAKZm9yIHRoZSBsYXRlci4KCkNo
cmlzdGlhbi4KCj4KPiBBbGV4Cj4KPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMgfCA4ICsrKysrKy0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwo+PiBpbmRleCAwMWZlNjBmZWRjYmUuLjkwMzZjOTNiNGEwYyAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+PiBAQCAtNjY5LDExICs2
NjksMTUgQEAgdm9pZCBhbWRncHVfY3R4X2ZlbmNlX3RpbWUoc3RydWN0IGFtZGdwdV9jdHggKmN0
eCwgc3RydWN0IGFtZGdwdV9jdHhfZW50aXR5ICpjZW4KPj4gICAgICAgICAgICAgICAgICBpZiAo
IWZlbmNlKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4+ICAgICAgICAg
ICAgICAgICAgc19mZW5jZSA9IHRvX2RybV9zY2hlZF9mZW5jZShmZW5jZSk7Cj4+IC0gICAgICAg
ICAgICAgICBpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCgmc19mZW5jZS0+c2NoZWR1bGVkKSkK
Pj4gKyAgICAgICAgICAgICAgIGlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKCZzX2ZlbmNlLT5z
Y2hlZHVsZWQpKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVu
Y2UpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4+ICsgICAgICAgICAg
ICAgICB9Cj4+ICAgICAgICAgICAgICAgICAgdDEgPSBzX2ZlbmNlLT5zY2hlZHVsZWQudGltZXN0
YW1wOwo+PiAtICAgICAgICAgICAgICAgaWYgKHQxID49IG5vdykKPj4gKyAgICAgICAgICAgICAg
IGlmICgha3RpbWVfYmVmb3JlKHQxLCBub3cpKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7Cj4+ICsgICAgICAgICAgICAgICB9Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGRtYV9mZW5j
ZV9pc19zaWduYWxlZCgmc19mZW5jZS0+ZmluaXNoZWQpICYmCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBzX2ZlbmNlLT5maW5pc2hlZC50aW1lc3RhbXAgPCBub3cpCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAqdG90YWwgKz0ga3RpbWVfc3ViKHNfZmVuY2UtPmZpbmlzaGVkLnRpbWVz
dGFtcCwgdDEpOwo+PiAtLQo+PiAyLjE3LjEKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
