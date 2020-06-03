Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D86C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 08:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B2F2077D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 08:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5osFtqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B2F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C6B89CAC;
	Wed,  3 Jun 2020 08:19:44 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27E089CAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 08:19:43 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id r9so978927wmh.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jun 2020 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=koJfObSZX/tGUMFL1rP6i9TOCWzm9Ezgk30xM6pNOik=;
 b=J5osFtqiZAa6tgsi8u0RuKJj85e18OoQ3fAoYNen40lUK9ccp3MupoIbpjQlb9zdlm
 8UoWYEBDXpEXmdy4C/3TMW0Ju7c3OTdlykiYNH67Y5FyyymLgHEmjMLJAUCgP2OcPFHM
 gC+uSJYSVew1TRfB6gGAK6pW0f/rIUiZG3M4ojWNpIb6V2A25c1dDxwkEYJyQ0DvM6Mw
 YCq81KaunP5TS9up7U9yA5VbWnQ2QKqJc+1kD6Q/rY8JMn7qo+RP6BEJrqWLPlX/DiHS
 +VXi8uRmw1Vp0DON5EBbBLYdHyOaxlKQQQpyX8ec0eB9gyY9h7hwSG+cN6JT/lUF5V1Z
 m/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=koJfObSZX/tGUMFL1rP6i9TOCWzm9Ezgk30xM6pNOik=;
 b=qvdAHlLnY7G2tjDmNp7QjIg2qFwdCVT0tJFg5AR4qwsdhR+ge2jGinqBmCk4Aq6G7O
 JgR7TZtBsMx8FUYQVU6G/WEOXAqOGwfzHX06EaBZG7dTrEwrhTMBXrK56SQJZx9yzyeY
 hzN0C3SaAzX/tCRGS5gBEpeF1MiqhEVriWDo36Mz+k8yjjgGg0aFJE8dxvupsWmY0/EF
 rYf94hhKkx5ht0ZOVliKqVBu6G99RpXYXPZcTIOmEB/NzErq1cbKPuJH7yEwSbOk7EFX
 85Z2uG9iB/GM2HgQN2mndmFTjCkIMM3AlTHUXs8rmWpQTm1xPK3uscKf96M3azckuuHw
 Gq2Q==
X-Gm-Message-State: AOAM533r51qaNk5Sa66gAuRMAnRtqJ1E1LOPyGtVBEeO8lu21YIL5chn
 HHyylqheORJS+8bmtGizNlVbkbAG
X-Google-Smtp-Source: ABdhPJzrAQYqd6bc3ApW+CBqJwCyDZpMxEznjeXL1x9nKRza1yR0MhqGH1dbHDSyDmduJpV3gk58KA==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr7546293wmb.69.1591172382410;
 Wed, 03 Jun 2020 01:19:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n189sm1792559wmb.43.2020.06.03.01.19.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2020 01:19:41 -0700 (PDT)
Subject: Re: [PATCH] Revert "drm/[radeon|amdgpu]: Replace one-element array
 and use struct_size() helper"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200602191013.1346247-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <35bbf868-f164-be6a-1b14-0bdf54d067a9@gmail.com>
Date: Wed, 3 Jun 2020 10:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200602191013.1346247-1-alexander.deucher@amd.com>
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

QW0gMDIuMDYuMjAgdW0gMjE6MTAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyByZXZlcnRz
IGNvbW1pdCA0ZGVhMjU4NTNhNmMwYzE2ZTM3MzY2NTE1M2JkOWViNmVkYzYzMTllLgo+Cj4gVGhp
cyBjaGFuZ2VzIHN0cnVjdHMgdXNlZCBieSB0aGUgaGFyZHdhcmUgYW5kIGJyZWFrcyBkcG0gb24g
c29tZSBjYXJkcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KCldlIHNob3VsZCBhbHNvIENDIHRoZSBvcmlnaW5hbCBhdXRob3Igb2Yg
dGhhdCBwYXRjaC4gSXQgaXMgcGVyZmVjdGx5IApwb3NzaWJsZSB0aGF0IHNvb25lciBvciBsYXRl
ciBhbiBhdXRvbWF0ZWQgc2NyaXB0IHdpbGwgdGVzdCBmb3IgdGhpcyBhbmQgCndlIG5lZWQgYW4g
ZXhjZXB0aW9uIGZvciBvdXIgY29kZS4KCkFwYXJ0IGZyb20gdGhhdCBBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KCkNocmlzdGlhbi4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyAgICAgICB8IDUgKysrLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Npc2xhbmRzX3NtYy5oIHwgMiArLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyAgICAgICAgICAgfCA1ICsrKy0tCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCj4gaW5kZXggMGZjNTZjNWJhYzA4Li5jMDBiYTRiMjNj
OWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwo+IEBAIC01NzE1LDkgKzU3
MTUsMTAgQEAgc3RhdGljIGludCBzaV91cGxvYWRfc3dfc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4gICAJaW50IHJldDsKPiAgIAl1MzIgYWRkcmVzcyA9IHNpX3BpLT5zdGF0ZV90
YWJsZV9zdGFydCArCj4gICAJCW9mZnNldG9mKFNJU0xBTkRTX1NNQ19TVEFURVRBQkxFLCBkcml2
ZXJTdGF0ZSk7Cj4gKwl1MzIgc3RhdGVfc2l6ZSA9IHNpemVvZihTSVNMQU5EU19TTUNfU1dTVEFU
RSkgKwo+ICsJCSgobmV3X3N0YXRlLT5wZXJmb3JtYW5jZV9sZXZlbF9jb3VudCAtIDEpICoKPiAr
CQkgc2l6ZW9mKFNJU0xBTkRTX1NNQ19IV19QRVJGT1JNQU5DRV9MRVZFTCkpOwo+ICAgCVNJU0xB
TkRTX1NNQ19TV1NUQVRFICpzbWNfc3RhdGUgPSAmc2lfcGktPnNtY19zdGF0ZXRhYmxlLmRyaXZl
clN0YXRlOwo+IC0Jc2l6ZV90IHN0YXRlX3NpemUgPSBzdHJ1Y3Rfc2l6ZShzbWNfc3RhdGUsIGxl
dmVscywKPiAtCQkJCQluZXdfc3RhdGUtPnBlcmZvcm1hbmNlX2xldmVsX2NvdW50KTsKPiAgIAo+
ICAgCW1lbXNldChzbWNfc3RhdGUsIDAsIHN0YXRlX3NpemUpOwo+ICAgCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Npc2xhbmRzX3NtYy5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2lzbGFuZHNfc21jLmgKPiBpbmRleCBhMDg5ZGJmOGY3YTkuLmQyOTMw
ZWNlYWYzYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaXNsYW5k
c19zbWMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Npc2xhbmRzX3NtYy5o
Cj4gQEAgLTE4Niw3ICsxODYsNyBAQCBzdHJ1Y3QgU0lTTEFORFNfU01DX1NXU1RBVEUKPiAgICAg
ICB1aW50OF90ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZXZlbENvdW50Owo+ICAgICAg
IHVpbnQ4X3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZGRpbmcyOwo+ICAgICAgIHVp
bnQ4X3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZGRpbmczOwo+IC0gICAgU0lTTEFO
RFNfU01DX0hXX1BFUkZPUk1BTkNFX0xFVkVMICAgbGV2ZWxzW107Cj4gKyAgICBTSVNMQU5EU19T
TUNfSFdfUEVSRk9STUFOQ0VfTEVWRUwgICBsZXZlbHNbMV07Cj4gICB9Owo+ICAgCj4gICB0eXBl
ZGVmIHN0cnVjdCBTSVNMQU5EU19TTUNfU1dTVEFURSBTSVNMQU5EU19TTUNfU1dTVEFURTsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vc2lfZHBtLmMKPiBpbmRleCBiYWIwMWNhODY0YzYuLmExNjdlMWMzNmQyNCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9zaV9kcG0uYwo+IEBAIC01MjUzLDkgKzUyNTMsMTAgQEAgc3Rh
dGljIGludCBzaV91cGxvYWRfc3dfc3RhdGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsCj4g
ICAJaW50IHJldDsKPiAgIAl1MzIgYWRkcmVzcyA9IHNpX3BpLT5zdGF0ZV90YWJsZV9zdGFydCAr
Cj4gICAJCW9mZnNldG9mKFNJU0xBTkRTX1NNQ19TVEFURVRBQkxFLCBkcml2ZXJTdGF0ZSk7Cj4g
Kwl1MzIgc3RhdGVfc2l6ZSA9IHNpemVvZihTSVNMQU5EU19TTUNfU1dTVEFURSkgKwo+ICsJCSgo
bmV3X3N0YXRlLT5wZXJmb3JtYW5jZV9sZXZlbF9jb3VudCAtIDEpICoKPiArCQkgc2l6ZW9mKFNJ
U0xBTkRTX1NNQ19IV19QRVJGT1JNQU5DRV9MRVZFTCkpOwo+ICAgCVNJU0xBTkRTX1NNQ19TV1NU
QVRFICpzbWNfc3RhdGUgPSAmc2lfcGktPnNtY19zdGF0ZXRhYmxlLmRyaXZlclN0YXRlOwo+IC0J
c2l6ZV90IHN0YXRlX3NpemUgPSBzdHJ1Y3Rfc2l6ZShzbWNfc3RhdGUsIGxldmVscywKPiAtCQkJ
CQluZXdfc3RhdGUtPnBlcmZvcm1hbmNlX2xldmVsX2NvdW50KTsKPiAgIAo+ICAgCW1lbXNldChz
bWNfc3RhdGUsIDAsIHN0YXRlX3NpemUpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
