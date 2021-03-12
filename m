Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8375CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3646465021
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3646465021
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE446F567;
	Fri, 12 Mar 2021 10:52:16 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDCD6F567
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 10:52:15 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id a11so3383176qto.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 02:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=F4SkBtA6rcC+GCWbxMlyTDSO+/whMlBJp8DqYYM811w=;
 b=Vt+giw9+28hi2WpQVqnSvDRlRsBXBq0X+gNQ2MDqi0syyR2205npHR8zYFQ8NLs0Xf
 c3glBS+V2S1iz1GBywnIMLHs42bjP4+V/pwNGFlvX+xqqzinSZJJ3H3iz2z+SxQ3tb3r
 CR7NYiZ0PA3ZaRCKG1Zf+J4SsqbdCVIumAdM9e4XUev/B0N9UlRB+1yYDdBr31EThBlA
 egpZgfwJuDE5//k4yb8xKg5l7zYpTunM6YKI/q3W9d7BhG0EgstbFPcm4HplwuaAdCxH
 /ADYULgf+eO+Su9SsQ8/S7k9bK7wReTmomPHBcoZmBqjj30VV2ElL7vHyV7S6ZAAFkO8
 JLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=F4SkBtA6rcC+GCWbxMlyTDSO+/whMlBJp8DqYYM811w=;
 b=Xb32CtFQYGl7wEsKQ7pNNKwE+z7C0B+XTtS77D6vsGbe3yckA+dHpPCn8qa6xzCSbq
 qTYa89ppJMyyx0SLWAfqY7hwkuzTkFsLeWciN2isDueq9XJa+F7RXj49lMkKsvn5Ohwm
 nrRd73qLf3lKiA3gaUXfgRjZeXuksqfArj6iLXbYwyL9eUbdJoEDCHlo8VUdZzwnEc3b
 maNYi3b5saagWG9SFOx3Czev1Sp1vFheSM2/zhO2HW3EofljwvLVQkbSSmptsyrdeLML
 4JbiE0mAaGzwahl2dBucP+eBipyRsJg1m3DmnH0o5VXOKzsY/w5pSeKQFkDG7BKFKhvR
 BIwA==
X-Gm-Message-State: AOAM531/j+TkWgTYsKt7dc4YZAhyDZ7LlBJ9gRCIzfLv0J0DQJWdpy3b
 r8c4EKAFyXEgjwTfB8xiP6rrKt8im14=
X-Google-Smtp-Source: ABdhPJyetzAydaIHbJYjsHWGC4tJewIKA0kUntAxxDDxd92T/B1w95+ZP5cT19JgG6fHRUDBdgnUIw==
X-Received: by 2002:ac8:4f10:: with SMTP id b16mr477890qte.235.1615546335103; 
 Fri, 12 Mar 2021 02:52:15 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:4899:2887:b509:9393?
 ([2a02:908:1252:fb60:4899:2887:b509:9393])
 by smtp.gmail.com with ESMTPSA id n5sm3925376qkp.133.2021.03.12.02.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 02:52:14 -0800 (PST)
Subject: Re: [PATCH 1/8] drm/amdgpu: new resource cursor
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Arunpravin.PaneerSelvam@amd.com, amd-gfx@lists.freedesktop.org
References: <20210308134044.133658-1-christian.koenig@amd.com>
Message-ID: <b95c5f36-0b12-347d-8d85-4e24cdb37003@gmail.com>
Date: Fri, 12 Mar 2021 11:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210308134044.133658-1-christian.koenig@amd.com>
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

QW55IG1vcmUgY29tbWVudHMgb24gdGhpcyBzZXQgaGVyZSBvciBvdGhlcndpc2UgSSdtIGdvaW5n
IHRvIHB1c2ggaXQgCndpdGgganVzdCBPYWtzIGFjay4KClRoYW5rcywKQ2hyaXN0aWFuLgoKQW0g
MDguMDMuMjEgdW0gMTQ6NDAgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFsbG93cyB0byB3
YWxrIG92ZXIgdGhlIGRybV9tbSBub2RlcyBpbiBhIFRUTSByZXNvdXJjZSBvYmplY3QuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gQWNrZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgo+IFRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+IC0tLQo+ICAgLi4uL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oICAgIHwgMTA1ICsrKysrKysrKysrKysrKysrKwo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaAo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjEzMzVlMDk4NTEwZgo+IC0tLSAvZGV2
L251bGwKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNv
ci5oCj4gQEAgLTAsMCArMSwxMDUgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAgT1IgTUlUCj4gKy8qCj4gKyAqIENvcHlyaWdodCAyMDIwIEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4KPiArICoKPiArICogUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJl
ZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEKPiArICogY29weSBvZiB0aGlz
IHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdh
cmUiKSwKPiArICogdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dCByZXN0cmljdGlvbiwg
aW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgo+ICsgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29w
eSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwKPiArICog
YW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25z
IHRvIHdob20gdGhlCj4gKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVj
dCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6Cj4gKyAqCj4gKyAqIFRoZSBhYm92ZSBjb3B5
cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVk
IGluCj4gKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3
YXJlLgo+ICsgKgo+ICsgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9V
VCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgo+ICsgKiBJTVBMSUVELCBJTkNMVURJ
TkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSwK
PiArICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVO
VC4gIElOIE5PIEVWRU5UIFNIQUxMCj4gKyAqIFRIRSBDT1BZUklHSFQgSE9MREVSKFMpIE9SIEFV
VEhPUihTKSBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgo+ICsgKiBPVEhFUiBM
SUFCSUxJVFksIFdIRVRIRVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIE9USEVS
V0lTRSwKPiArICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRI
RSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SCj4gKyAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZU
V0FSRS4KPiArICoKPiArICogQXV0aG9yczogQ2hyaXN0aWFuIEvDtm5pZwo+ICsgKi8KPiArCj4g
KyNpZm5kZWYgX19BTURHUFVfUkVTX0NVUlNPUl9IX18KPiArI2RlZmluZSBfX0FNREdQVV9SRVNf
Q1VSU09SX0hfXwo+ICsKPiArI2luY2x1ZGUgPGRybS9kcm1fbW0uaD4KPiArI2luY2x1ZGUgPGRy
bS90dG0vdHRtX3Jlc291cmNlLmg+Cj4gKwo+ICsvKiBzdGF0ZSBiYWNrIGZvciB3YWxraW5nIG92
ZXIgdnJhbV9tZ3IgYW5kIGd0dF9tZ3IgYWxsb2NhdGlvbnMgKi8KPiArc3RydWN0IGFtZGdwdV9y
ZXNfY3Vyc29yIHsKPiArCXVpbnQ2NF90CQlzdGFydDsKPiArCXVpbnQ2NF90CQlzaXplOwo+ICsJ
dWludDY0X3QJCXJlbWFpbmluZzsKPiArCXN0cnVjdCBkcm1fbW1fbm9kZQkqbm9kZTsKPiArfTsK
PiArCj4gKy8qKgo+ICsgKiBhbWRncHVfcmVzX2ZpcnN0IC0gaW5pdGlhbGl6ZSBhIGFtZGdwdV9y
ZXNfY3Vyc29yCj4gKyAqCj4gKyAqIEByZXM6IFRUTSByZXNvdXJjZSBvYmplY3QgdG8gd2Fsawo+
ICsgKiBAc3RhcnQ6IFN0YXJ0IG9mIHRoZSByYW5nZQo+ICsgKiBAc2l6ZTogU2l6ZSBvZiB0aGUg
cmFuZ2UKPiArICogQGN1cjogY3Vyc29yIG9iamVjdCB0byBpbml0aWFsaXplCj4gKyAqCj4gKyAq
IFN0YXJ0IHdhbGtpbmcgb3ZlciB0aGUgcmFuZ2Ugb2YgYWxsb2NhdGlvbnMgYmV0d2VlbiBAc3Rh
cnQgYW5kIEBzaXplLgo+ICsgKi8KPiArc3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfZmly
c3Qoc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzLAo+ICsJCQkJICAgIHVpbnQ2NF90IHN0YXJ0LCB1
aW50NjRfdCBzaXplLAo+ICsJCQkJICAgIHN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciAqY3VyKQo+
ICt7Cj4gKwlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGU7Cj4gKwo+ICsJaWYgKCFyZXMgfHwgIXJl
cy0+bW1fbm9kZSkgewo+ICsJCWN1ci0+c3RhcnQgPSBzdGFydDsKPiArCQljdXItPnNpemUgPSBz
aXplOwo+ICsJCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsKPiArCQljdXItPm5vZGUgPSBOVUxMOwo+
ICsJCXJldHVybjsKPiArCX0KPiArCj4gKwlCVUdfT04oc3RhcnQgKyBzaXplID4gcmVzLT5udW1f
cGFnZXMgPDwgUEFHRV9TSElGVCk7Cj4gKwo+ICsJbm9kZSA9IHJlcy0+bW1fbm9kZTsKPiArCXdo
aWxlIChzdGFydCA+IG5vZGUtPnNpemUgPDwgUEFHRV9TSElGVCkKPiArCQlzdGFydCAtPSBub2Rl
KystPnNpemUgPDwgUEFHRV9TSElGVDsKPiArCj4gKwljdXItPnN0YXJ0ID0gKG5vZGUtPnN0YXJ0
IDw8IFBBR0VfU0hJRlQpICsgc3RhcnQ7Cj4gKwljdXItPnNpemUgPSAobm9kZS0+c2l6ZSA8PCBQ
QUdFX1NISUZUKSAtIHN0YXJ0Owo+ICsJY3VyLT5yZW1haW5pbmcgPSBzaXplOwo+ICsJY3VyLT5u
b2RlID0gbm9kZTsKPiArfQo+ICsKPiArLyoqCj4gKyAqIGFtZGdwdV9yZXNfbmV4dCAtIGFkdmFu
Y2UgdGhlIGN1cnNvcgo+ICsgKgo+ICsgKiBAY3VyOiB0aGUgY3Vyc29yIHRvIGFkdmFuY2UKPiAr
ICogQHNpemU6IG51bWJlciBvZiBieXRlcyB0byBtb3ZlIGZvcndhcmQKPiArICoKPiArICogTW92
ZSB0aGUgY3Vyc29yIEBzaXplIGJ5dGVzIGZvcndyYWQsIHdhbGtpbmcgdG8gdGhlIG5leHQgbm9k
ZSBpZiBuZWNlc3NhcnkuCj4gKyAqLwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgYW1kZ3B1X3Jlc19u
ZXh0KHN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciAqY3VyLCB1aW50NjRfdCBzaXplKQo+ICt7Cj4g
KwlzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGUgPSBjdXItPm5vZGU7Cj4gKwo+ICsJQlVHX09OKHNp
emUgPiBjdXItPnJlbWFpbmluZyk7Cj4gKwo+ICsJY3VyLT5yZW1haW5pbmcgLT0gc2l6ZTsKPiAr
CWlmICghY3VyLT5yZW1haW5pbmcpCj4gKwkJcmV0dXJuOwo+ICsKPiArCWN1ci0+c2l6ZSAtPSBz
aXplOwo+ICsJaWYgKGN1ci0+c2l6ZSkgewo+ICsJCWN1ci0+c3RhcnQgKz0gc2l6ZTsKPiArCQly
ZXR1cm47Cj4gKwl9Cj4gKwo+ICsJY3VyLT5ub2RlID0gKytub2RlOwo+ICsJY3VyLT5zdGFydCA9
IG5vZGUtPnN0YXJ0IDw8IFBBR0VfU0hJRlQ7Cj4gKwljdXItPnNpemUgPSBtaW4obm9kZS0+c2l6
ZSA8PCBQQUdFX1NISUZULCBjdXItPnJlbWFpbmluZyk7Cj4gK30KPiArCj4gKyNlbmRpZgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
