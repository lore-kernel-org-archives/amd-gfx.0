Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A9BC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 12:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B969206BE
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 12:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBGtQaSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B969206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F6E6EBCA;
	Thu, 25 Jun 2020 12:45:11 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F7F6EBCA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 12:45:10 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q15so5410093wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=FYW0odikNfF0+o7n5Gye0tlVDuhir789YZMOLAcKs6c=;
 b=RBGtQaSmYbx/xzJ6jk+4kueU6KO2VgDcYS6gkwyZD0l5Pd7noHrvlO/sYdNcY1RgQQ
 xtA3bVxqxzL51gsSA9IPmWzN+AfLD/9ciid5wZaBDxyMt6xQhgWFmWY2srJA1XDKVs92
 JLr50FA1FkcJnx5aKdWSoRDzK5CvTLq6V9kaZBexbug8EK/n3u6ih9KShcJfpM9gdZD2
 KC14cWkd447cYwcZk6unuTgiK1fGghV4oMgBMW7y9cO2IUuEsAWd+HWQ5Y9uBPkIUXBv
 /TjUHDbXz+nIIJZ2900RSLAylFn3BqRHR0H/zFnb4T4Aair05nk1TtRTFZVcOnVdNDW/
 RT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=FYW0odikNfF0+o7n5Gye0tlVDuhir789YZMOLAcKs6c=;
 b=mg56A7gw0DJqCwU9ZgYCQkf+8TBk/ilPreFvD2q0oPj1F8qNcCVleh5N8+EFO0OpIy
 X8gAB0ANfpcNTPzs2rtZRfwJUHAQF3Ypo/B3edxZl88b9ZeUmKyH+oFAlS805O/z5V0J
 D6/65qwULELR5/vBh3DxMabh7xrKuuuhDPfxktw6jlKcR0sEgl36k52bGgRYwm22qjBb
 nJnhTp+5pZ0VJRwr9hD3U2mPIcVCcwKRkLnbWJwvIfKbcgu64OtJW0tdIdYSfzlgzQNG
 8L/W+y6Xqikzbl5pQ6JWsOUWZxUosGXVXuDbbIk6RMZZa4UBFLlfaDLJCbg7i6+6xfsa
 FuQw==
X-Gm-Message-State: AOAM531/OgiMzJnkx+UIDR/WGaa2QTFTDuGq+LAxVnHJNw+sr1R1OfDP
 vtv211eqiag0xu/LUyHN0gg=
X-Google-Smtp-Source: ABdhPJyO/WAp1NRis6MG2eeTTZ1OPYXvH5QIoF0OihpxeIZR0yFuvu03aKC8BikSJ79B7Ui+s5aRKA==
X-Received: by 2002:a1c:9d56:: with SMTP id g83mr3130147wme.130.1593089109539; 
 Thu, 25 Jun 2020 05:45:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k14sm8219490wrn.76.2020.06.25.05.45.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:45:08 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: call release_firmware() without a NULL
 check
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200623162637.26011-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fb40c220-7402-10cb-24a6-e697c85447d0@gmail.com>
Date: Thu, 25 Jun 2020 14:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200623162637.26011-1-nirmoy.das@amd.com>
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDYuMjAgdW0gMTg6MjYgc2NocmllYiBOaXJtb3kgRGFzOgo+IFRoZSByZWxlYXNlX2Zp
cm13YXJlKCkgZnVuY3Rpb24gaXMgTlVMTCB0b2xlcmFudCBzbyB3ZSBkbyBub3QgbmVlZAo+IHRv
IGNoZWNrIGZvciBOVUxMIHBhcmFtIGJlZm9yZSBjYWxsaW5nIGl0Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgICAgICAgIHwgIDYgKystLS0tCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgICAgICAgICAgIHwgIDYgKyst
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyAgICAgICAgICAg
IHwgIDQgKystLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgICAg
ICAgICAgICB8ICA0ICsrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVf
Mi5jICAgICAgICAgICAgfCAgNCArKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMTIgKysrKy0tLS0tLS0tCj4gICA2IGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IDI4NThjMDlmZDhjMC4uYTY0OWU0
MGZkOTZmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Ywo+IEBAIC0zMzgwLDEwICszMzgwLDggQEAgdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCWFtZGdwdV9wbV9zeXNmc19maW5pKGFkZXYpOwo+
ICAgCWFtZGdwdV9mYmRldl9maW5pKGFkZXYpOwo+ICAgCXIgPSBhbWRncHVfZGV2aWNlX2lwX2Zp
bmkoYWRldik7Cj4gLQlpZiAoYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncpIHsKPiAtCQlyZWxl
YXNlX2Zpcm13YXJlKGFkZXYtPmZpcm13YXJlLmdwdV9pbmZvX2Z3KTsKPiAtCQlhZGV2LT5maXJt
d2FyZS5ncHVfaW5mb19mdyA9IE5VTEw7Cj4gLQl9Cj4gKwlyZWxlYXNlX2Zpcm13YXJlKGFkZXYt
PmZpcm13YXJlLmdwdV9pbmZvX2Z3KTsKPiArCWFkZXYtPmZpcm13YXJlLmdwdV9pbmZvX2Z3ID0g
TlVMTDsKPiAgIAlhZGV2LT5hY2NlbF93b3JraW5nID0gZmFsc2U7Cj4gICAJLyogZnJlZSBpMmMg
YnVzZXMgKi8KPiAgIAlpZiAoIWFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQoYWRldikpCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGluZGV4IDA3MjNkZWUyOTU4
Yi4uOTM0MmE5ZThjYWRmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYwo+IEBAIC0xOTYsMTAgKzE5Niw4IEBAIHN0YXRpYyBpbnQgcHNwX3N3X2Zpbmkodm9pZCAq
aGFuZGxlKQo+ICAgCWFkZXYtPnBzcC5zb3NfZncgPSBOVUxMOwo+ICAgCXJlbGVhc2VfZmlybXdh
cmUoYWRldi0+cHNwLmFzZF9mdyk7Cj4gICAJYWRldi0+cHNwLmFzZF9mdyA9IE5VTEw7Cj4gLQlp
ZiAoYWRldi0+cHNwLnRhX2Z3KSB7Cj4gLQkJcmVsZWFzZV9maXJtd2FyZShhZGV2LT5wc3AudGFf
ZncpOwo+IC0JCWFkZXYtPnBzcC50YV9mdyA9IE5VTEw7Cj4gLQl9Cj4gKwlyZWxlYXNlX2Zpcm13
YXJlKGFkZXYtPnBzcC50YV9mdyk7Cj4gKwlhZGV2LT5wc3AudGFfZncgPSBOVUxMOwo+ICAgCj4g
ICAJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMCkKPiAgIAkJcHNwX3N5c2ZzX2Zp
bmkoYWRldik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPiBpbmRleCA1
ODM4MjY0NmQ5NjIuLjI5ODVjNjFiYzZhMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jCj4gQEAgLTU1OSw4ICs1NTksOCBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y0XzBf
ZGVzdHJveV9pbnN0X2N0eChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlpbnQgaTsK
PiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykg
ewo+IC0JCWlmIChhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3ICE9IE5VTEwpCj4gLQkJCXJlbGVh
c2VfZmlybXdhcmUoYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5mdyk7Cj4gKwkJcmVsZWFzZV9maXJt
d2FyZShhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3KTsKPiArCQlhZGV2LT5zZG1hLmluc3RhbmNl
W2ldLmZ3ID0gTlVMTDsKPiAgIAo+ICAgCQkvKiBhcmN0dXJ1cyBzaGFyZXMgdGhlIHNhbWUgRlcg
bWVtb3J5IGFjcm9zcwo+ICAgCQkgICBhbGwgU0RNQSBpc250YW5jZXMgKi8KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+IGluZGV4IDY3NTFhZDY5ZWQ5MC4uMWJhZWRkZjJm
MWU2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMKPiBAQCAtMTMw
MCw4ICsxMzAwLDggQEAgc3RhdGljIGludCBzZG1hX3Y1XzBfc3dfZmluaSh2b2lkICpoYW5kbGUp
Cj4gICAJaW50IGk7Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+c2RtYS5udW1faW5z
dGFuY2VzOyBpKyspIHsKPiAtCQlpZiAoYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5mdyAhPSBOVUxM
KQo+IC0JCQlyZWxlYXNlX2Zpcm13YXJlKGFkZXYtPnNkbWEuaW5zdGFuY2VbaV0uZncpOwo+ICsJ
CXJlbGVhc2VfZmlybXdhcmUoYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5mdyk7Cj4gKwkJYWRldi0+
c2RtYS5pbnN0YW5jZVtpXS5mdyA9IE5VTEw7Cj4gICAKPiAgIAkJYW1kZ3B1X3JpbmdfZmluaSgm
YWRldi0+c2RtYS5pbnN0YW5jZVtpXS5yaW5nKTsKPiAgIAl9Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NV8yLmMKPiBpbmRleCA5NTc1MWU3YmRmZTguLjMxOGQzMmUyYmJmNiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4gQEAgLTExNSw4ICsxMTUs
OCBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y1XzJfZGVzdHJveV9pbnN0X2N0eChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIAlpbnQgaTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2
LT5zZG1hLm51bV9pbnN0YW5jZXM7IGkrKykgewo+IC0JCWlmIChhZGV2LT5zZG1hLmluc3RhbmNl
W2ldLmZ3ICE9IE5VTEwpCj4gLQkJCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+c2RtYS5pbnN0YW5j
ZVtpXS5mdyk7Cj4gKwkJcmVsZWFzZV9maXJtd2FyZShhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3
KTsKPiArCQlhZGV2LT5zZG1hLmluc3RhbmNlW2ldLmZ3ID0gTlVMTDsKPiAgIAo+ICAgCQlpZiAo
YWRldi0+YXNpY190eXBlID09IENISVBfU0lFTk5BX0NJQ0hMSUQpCj4gICAJCQlicmVhazsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
PiBpbmRleCAzYmFkZjY4NTMzOGYuLjQ3NjdmOWVhMDM1MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC0xMzE4LDE1
ICsxMzE4LDExIEBAIHN0YXRpYyBpbnQgZG1fc3dfZmluaSh2b2lkICpoYW5kbGUpCj4gICAJCWFk
ZXYtPmRtLmRtdWJfc3J2ID0gTlVMTDsKPiAgIAl9Cj4gICAKPiAtCWlmIChhZGV2LT5kbS5kbXVi
X2Z3KSB7Cj4gLQkJcmVsZWFzZV9maXJtd2FyZShhZGV2LT5kbS5kbXViX2Z3KTsKPiAtCQlhZGV2
LT5kbS5kbXViX2Z3ID0gTlVMTDsKPiAtCX0KPiArCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+ZG0u
ZG11Yl9mdyk7Cj4gKwlhZGV2LT5kbS5kbXViX2Z3ID0gTlVMTDsKPiAgIAo+IC0JaWYoYWRldi0+
ZG0uZndfZG1jdSkgewo+IC0JCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+ZG0uZndfZG1jdSk7Cj4g
LQkJYWRldi0+ZG0uZndfZG1jdSA9IE5VTEw7Cj4gLQl9Cj4gKwlyZWxlYXNlX2Zpcm13YXJlKGFk
ZXYtPmRtLmZ3X2RtY3UpOwo+ICsJYWRldi0+ZG0uZndfZG1jdSA9IE5VTEw7Cj4gICAKPiAgIAly
ZXR1cm4gMDsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
