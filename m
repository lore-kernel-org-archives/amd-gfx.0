Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89966C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B5A20738
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEf1f1l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B5A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B5E89E9B;
	Mon, 27 Jul 2020 19:37:07 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED19D89E9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 19:37:06 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id z17so12991789edr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=M7oUVJCKZrXp3zN8xpHZjWvKUuh6q5Jgy3CyrqEss+Y=;
 b=vEf1f1l9wMjtyKh01Ers+SQtvUPsAIoQ31UX3HEXVS71Q/0ZTrc9AFHybPFezciI04
 T9nnLHxTsCQHy4HHlJgz3LR0sQlT00vS1k3aTtDHjpn7wNAwLHsO9cFftH20O0hSzwKo
 2cVQBG+/Na3Brv4YFRWsnubUAFt91hmpS5K7DPrJ5IfLyoKrEDxGqeaagMyf0mbJAduP
 VGXtLOwo0jt4P0bHrRQJewZ8bho480OehoKqhBFcJH7o7DvzqjYl8QNKIangGfAHCq9G
 9dC/vWWn3c1Yr+f/jJGopUcXhs1HZGOBukE/2J5etVA5/vCpHKHrlOkCwIsKjYRg2mBp
 or5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=M7oUVJCKZrXp3zN8xpHZjWvKUuh6q5Jgy3CyrqEss+Y=;
 b=sLTxOgjHN557w4dllZBNOiiOoDgtljPMID+Hi6r41e2InQZtdXdon76RhM8Mx/aJjR
 K2oSaUZicZnECwpv2hTEnezyQW8itPJytd+0B3P86+K9S48vJzuirPTfIiX1aCjM22/Z
 la9/uwgrFL7uKe1zd1WFJ2O/pepwM/YUALhAOaUPadstU7iq3HSeNNspfJy+HdfhcQtS
 zbtT2URXWgVKlxWi+4suMaETV/9dgGAQ8rwU4u6q1HG2ZM61XJ08zHWkMUtoOpm8/eeJ
 voFk/5ruYQW/o6nvB9hFDnw/wBY25+CCuGY1adv4AnKMT8Y/dVrwv1p7dbakLIBZsWpT
 9ibg==
X-Gm-Message-State: AOAM5308Ah7OoFNUx1TJ6eSZUGAIibUYCxTLFidjtHBUD5Ep2ZS8tkeL
 6WwkXFFz4Sa0gRDi1uNwvCE=
X-Google-Smtp-Source: ABdhPJw0JSNEW6gVEuXuqRALTeQbkPm/GUKsOYq1B/bZIH2WdBY0mkLK4NA5CTxpu9s9JDYEDRmIIg==
X-Received: by 2002:a05:6402:7d5:: with SMTP id
 u21mr6032237edy.235.1595878625639; 
 Mon, 27 Jul 2020 12:37:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id ah1sm7519100ejc.43.2020.07.27.12.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 12:37:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/si: initial support for GPU reset
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200727173437.117009-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d52adf86-9e88-382b-d56e-aeb7b7e4a911@gmail.com>
Date: Mon, 27 Jul 2020 21:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727173437.117009-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDcuMjAgdW0gMTk6MzQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUG9ydGVkIGZyb20g
cmFkZW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jIHwgOTIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgOTAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYwo+
IGluZGV4IDFiNDQ5MjkxZjA2OC4uYTdhNDVmMDZjOGYzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NpLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaS5jCj4gQEAgLTEyMTUsMTAgKzEyMTUsOTggQEAgc3RhdGljIGJvb2wgc2lfcmVhZF9iaW9z
X2Zyb21fcm9tKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCXJldHVybiB0cnVlOwo+
ICAgfQo+ICAgCj4gLS8veHh4OiBub3QgaW1wbGVtZW50ZWQKPiArc3RhdGljIHZvaWQgc2lfc2V0
X2Nsa19ieXBhc3NfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiArewo+ICsJdTMy
IHRtcCwgaTsKPiArCj4gKwl0bXAgPSBSUkVHMzIoQ0dfU1BMTF9GVU5DX0NOVEwpOwo+ICsJdG1w
IHw9IFNQTExfQllQQVNTX0VOOwo+ICsJV1JFRzMyKENHX1NQTExfRlVOQ19DTlRMLCB0bXApOwo+
ICsKPiArCXRtcCA9IFJSRUczMihDR19TUExMX0ZVTkNfQ05UTF8yKTsKPiArCXRtcCB8PSBTUExM
X0NUTFJFUV9DSEc7Cj4gKwlXUkVHMzIoQ0dfU1BMTF9GVU5DX0NOVExfMiwgdG1wKTsKPiArCj4g
Kwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsKPiArCQlpZiAoUlJF
RzMyKFNQTExfU1RBVFVTKSAmIFNQTExfQ0hHX1NUQVRVUykKPiArCQkJYnJlYWs7Cj4gKwkJdWRl
bGF5KDEpOwo+ICsJfQo+ICsKPiArCXRtcCA9IFJSRUczMihDR19TUExMX0ZVTkNfQ05UTF8yKTsK
PiArCXRtcCAmPSB+KFNQTExfQ1RMUkVRX0NIRyB8IFNDTEtfTVVYX1VQREFURSk7Cj4gKwlXUkVH
MzIoQ0dfU1BMTF9GVU5DX0NOVExfMiwgdG1wKTsKPiArCj4gKwl0bXAgPSBSUkVHMzIoTVBMTF9D
TlRMX01PREUpOwo+ICsJdG1wICY9IH5NUExMX01DTEtfU0VMOwo+ICsJV1JFRzMyKE1QTExfQ05U
TF9NT0RFLCB0bXApOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBzaV9zcGxsX3Bvd2VyZG93bihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiArewo+ICsJdTMyIHRtcDsKPiArCj4gKwl0bXAg
PSBSUkVHMzIoU1BMTF9DTlRMX01PREUpOwo+ICsJdG1wIHw9IFNQTExfU1dfRElSX0NPTlRST0w7
Cj4gKwlXUkVHMzIoU1BMTF9DTlRMX01PREUsIHRtcCk7Cj4gKwo+ICsJdG1wID0gUlJFRzMyKENH
X1NQTExfRlVOQ19DTlRMKTsKPiArCXRtcCB8PSBTUExMX1JFU0VUOwo+ICsJV1JFRzMyKENHX1NQ
TExfRlVOQ19DTlRMLCB0bXApOwo+ICsKPiArCXRtcCA9IFJSRUczMihDR19TUExMX0ZVTkNfQ05U
TCk7Cj4gKwl0bXAgfD0gU1BMTF9TTEVFUDsKPiArCVdSRUczMihDR19TUExMX0ZVTkNfQ05UTCwg
dG1wKTsKPiArCj4gKwl0bXAgPSBSUkVHMzIoU1BMTF9DTlRMX01PREUpOwo+ICsJdG1wICY9IH5T
UExMX1NXX0RJUl9DT05UUk9MOwo+ICsJV1JFRzMyKFNQTExfQ05UTF9NT0RFLCB0bXApOwo+ICt9
Cj4gKwo+ICtzdGF0aWMgaW50IHNpX2dwdV9wY2lfY29uZmlnX3Jlc2V0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICt7Cj4gKwl1MzIgaTsKPiArCWludCByID0gLUVJTlZBTDsKPiArCj4g
KwlkZXZfaW5mbyhhZGV2LT5kZXYsICJHUFUgcGNpIGNvbmZpZyByZXNldFxuIik7Cj4gKwo+ICsJ
Lyogc2V0IG1jbGsvc2NsayB0byBieXBhc3MgKi8KPiArCXNpX3NldF9jbGtfYnlwYXNzX21vZGUo
YWRldik7Cj4gKwkvKiBwb3dlcmRvd24gc3BsbCAqLwo+ICsJc2lfc3BsbF9wb3dlcmRvd24oYWRl
dik7Cj4gKwkvKiBkaXNhYmxlIEJNICovCj4gKwlwY2lfY2xlYXJfbWFzdGVyKGFkZXYtPnBkZXYp
Owo+ICsJLyogcmVzZXQgKi8KPiArCWFtZGdwdV9kZXZpY2VfcGNpX2NvbmZpZ19yZXNldChhZGV2
KTsKPiArCj4gKwl1ZGVsYXkoMTAwKTsKPiArCj4gKwkvKiB3YWl0IGZvciBhc2ljIHRvIGNvbWUg
b3V0IG9mIHJlc2V0ICovCj4gKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBp
KyspIHsKPiArCQlpZiAoUlJFRzMyKG1tQ09ORklHX01FTVNJWkUpICE9IDB4ZmZmZmZmZmYpIHsK
PiArCQkJLyogZW5hYmxlIEJNICovCj4gKwkJCXBjaV9zZXRfbWFzdGVyKGFkZXYtPnBkZXYpOwo+
ICsJCQlhZGV2LT5oYXNfaHdfcmVzZXQgPSB0cnVlOwo+ICsJCQlyID0gMDsKPiArCQkJYnJlYWs7
Cj4gKwkJfQo+ICsJCXVkZWxheSgxKTsKPiArCX0KPiArCj4gKwlyZXR1cm4gcjsKPiArfQo+ICsK
PiAgIHN0YXRpYyBpbnQgc2lfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgIHsKPiAtCXJldHVybiAwOwo+ICsJaW50IHI7Cj4gKwo+ICsJYW1kZ3B1X2F0b21iaW9zX3Nj
cmF0Y2hfcmVnc19lbmdpbmVfaHVuZyhhZGV2LCB0cnVlKTsKPiArCj4gKwlyID0gc2lfZ3B1X3Bj
aV9jb25maWdfcmVzZXQoYWRldik7Cj4gKwo+ICsJYW1kZ3B1X2F0b21iaW9zX3NjcmF0Y2hfcmVn
c19lbmdpbmVfaHVuZyhhZGV2LCBmYWxzZSk7Cj4gKwo+ICsJcmV0dXJuIHI7Cj4gICB9Cj4gICAK
PiAgIHN0YXRpYyBib29sIHNpX2FzaWNfc3VwcG9ydHNfYmFjbyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
