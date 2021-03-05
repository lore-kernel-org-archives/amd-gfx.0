Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB30B64F59
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB30B64F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CCF6EB18;
	Fri,  5 Mar 2021 08:51:46 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84746EB18
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 08:51:45 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id lr13so1907034ejb.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=zoc+H2LslO9nF8lc5e+mHo3+2PKfdmavJTteEhz+Ajw=;
 b=EqivxP7+Xy4eCzvFn8lspVmJpifRuXizOrfJUfFJnMcWISIvZUvYGVMAvHVeoxpwB9
 xLl+cGYL3kuiFK1j6jZ8PbxXtDMTT6+zRl2EQllCN17IoAMA9YuJIqiT5np6w4PYjnJP
 5ZXnDjIjnPU0/L9YBYBFe1Iv4sir8N+KUPT2oYeWIAW1+58v/ZwXnMfcvjWTJ2tkydJb
 y8TXTZgiA9KoIqU2x5xUJKivk9ol8gEF6LnjJDsVAfKUiH/fm9UpW6vX6MaieB6OYZrw
 cHQqb21Da2roNFB7vQc3usHRmLQ9HBCA+fKd+OeKyaBfLw9D37Qf/gKJnA+wR3BQ1Qwk
 M/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zoc+H2LslO9nF8lc5e+mHo3+2PKfdmavJTteEhz+Ajw=;
 b=s65YyV3QuT3WICoYrBaXhzsSsHIsDqkVv/y4XpxOrQ9cBab2PpVEXhs53H5BSwrwdX
 jZQu0kdqebsN7uPnlqHAbhlViQv67rn23PQHnVkvCCNqKYPTjAVqE0hS2lbQPbpo16g4
 AANQw0wPBT2cj2HUxMrqC1L4ukojda4hBD+laFqWVfOBBoj1eaLud9x9lq7SrCwPUEpW
 zSQmhKhK5bPb0iPJmaoc26J9z50CmbAdwSBjwRERI2I1o5XWSIrgk3yNjM65ewPdCe9F
 UsW+UzuDZ/Y08NfHDYXm9rhRL+QjxTDyNdo2L1hP4nHGeB9o6tFdSBXfJ51em7itSi6E
 lBHQ==
X-Gm-Message-State: AOAM530yTjmNiwWRm72kTMmkU/DTPSORHYb5OgyMlhyc6ev4ZR8OOY88
 M/2y6oEIjHel+17/Z4jUeCP7EV108MffWw==
X-Google-Smtp-Source: ABdhPJx6IPJeaGo92AkrZoRL6lyEW/J93gXv7d6umYtdBK1rKAOsfBgAm4A+QeC3T8M25rSQFtZx8g==
X-Received: by 2002:a17:906:f02:: with SMTP id
 z2mr1380129eji.469.1614934304568; 
 Fri, 05 Mar 2021 00:51:44 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:9f0d:d59a:6448:4a90?
 ([2a02:908:1252:fb60:9f0d:d59a:6448:4a90])
 by smtp.gmail.com with ESMTPSA id q11sm1137326ejr.36.2021.03.05.00.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 00:51:44 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix some unload driver issues
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210305012019.58196-1-Emily.Deng@amd.com>
 <3c929a45-c8d6-904b-25ce-2909e530dead@gmail.com>
 <BY5PR12MB411507D0009D10FFA11F0C648F969@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <aa8bca56-919f-55fb-4618-aac21428213a@gmail.com>
Date: Fri, 5 Mar 2021 09:51:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB411507D0009D10FFA11F0C648F969@BY5PR12MB4115.namprd12.prod.outlook.com>
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

CgpBbSAwNS4wMy4yMSB1bSAwOTo0MyBzY2hyaWViIERlbmcsIEVtaWx5Ogo+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4KPj4gU2VudDogRnJpZGF5LCBNYXJjaCA1LCAyMDIxIDM6NTUg
UE0KPj4gVG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
c29tZSB1bmxvYWQgZHJpdmVyIGlzc3Vlcwo+Pgo+PiBBbSAwNS4wMy4yMSB1bSAwMjoyMCBzY2hy
aWViIEVtaWx5IERlbmc6Cj4+PiBXaGVuIHVubG9hZGluZyBkcml2ZXIgYWZ0ZXIga2lsbGluZyBz
b21lIGFwcGxpY2F0aW9ucywgaXQgd2lsbCBoaXQKPj4+IHNkbWEgZmx1c2ggdGxiIGpvYiB0aW1l
b3V0IHdoaWNoIGlzIGNhbGxlZCBieSB0dG1fYm9fZGVsYXlfZGVsZXRlLiBTbwo+Pj4gdG8gYXZv
aWQgdGhlIGpvYiBzdWJtaXQgYWZ0ZXIgZmVuY2UgZHJpdmVyIGZpbmksIGNhbGwKPj4+IHR0bV9i
b19sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlIGJlZm9yZSBmZW5jZSBkcml2ZXIgZmluaS4gQW5kIGFs
c28gcHV0Cj4+IGRybV9zY2hlZF9maW5pIGJlZm9yZSB3YWl0aW5nIGZlbmNlLgo+Pgo+PiBHb29k
IGNhdGNoLCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPiBmb3IKPj4gdGhpcyBwYXJ0Lgo+Pgo+Pj4gU2V0IGFkZXYtPmdhcnQucHRyIHRvIG51
bGwgdG8gZml4IG51bGwgcG9pbnRlciB3aGVuIGNhbGxpbmcKPj4+IGFtZGdwdV9nYXJ0X3VuYmlu
ZCBpbiBhbWRncHVfYm9fZmluaSB3aGljaCBpcyBhZnRlciBnYXJ0X2ZpbmkuCj4+IEZvciB0aGF0
IG9uZSBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZG4ndCByYXRoZXIgcmV3b3JrIG9yIGRvdWJs
ZSBjaGVjayB0aGUKPj4gdGVhciBkb3duIG9yZGVyLgo+Pgo+PiBPbiB0aGUgb3RoZXIgaGFuZCB0
aGUgaGFyZHdhcmUgc2hvdWxkIGJlIGlkbGUgYnkgbm93ICh0aGlzIGNvbWVzIGFmdGVyIHRoZQo+
PiBmZW5jZV9kcml2ZXJfZmluaSwgZG9lc24ndCBpdD8pIGFuZCBpdCBsb29rcyBjbGVhbmVyIG9u
IGl0J3Mgb3duLgo+IFllcywgeW91IGFyZSByaWdodCwgd2l0aG91dCBjb25zaWRlciBtZW1vcnkg
bGVhaywgd2l0aCBhYm92ZSBwYXRjaCwgdGhlIGJvIGFyZSBhbGwgY2xlYW5lZCwgdGhlbiB3b24n
dCBoYXZlIGlzc3VlLiBCdXQgaWYgaGF2ZSBtZW1vcnkgbGVhaywgbWF5YmUgaXQgd2lsbCBoYXZl
IGlzc3VlIGluIHR0bV9ib19mb3JjZV9saXN0X2NsZWFuLT4gdHRtX21lbV9ldmljdF9maXJzdD8K
ClllYWgsIHRoYXQgaXMgYSBnb29kIGFyZ3VtZW50IGFuZCBwYXJ0IG9mIHdoYXQgSSBtZWFuIHdp
dGggaXQgbG9va3MgCmNsZWFuZXIgb24gaXRzIG93bi4KCk1heWJlIHdyaXRlIHRoYXQgaW50byB0
aGUgY29tbWl0IG1lc3NhZ2UgbGlrZSB0aGlzLiBXaXRoIHRoYXQgZG9uZSB0aGUgCmZ1bGwgcGF0
Y2ggaGFzIG15IHJiLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+PiBSZWdhcmRzLAo+PiBDaHJp
c3RpYW4uCj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5j
b20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDEgKwo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNl
LmMgIHwgNSArKystLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dh
cnQuYyAgIHwgMSArCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwo+Pj4gaW5kZXggYTExNzYwZWMzOTI0Li5kZTA1OTdkMzQ1ODggMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+Pj4gQEAgLTM1
OTQsNiArMzU5NCw3IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2
aWNlCj4+ICphZGV2KQo+Pj4gICAgewo+Pj4gICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiYW1kZ3B1
OiBmaW5pc2hpbmcgZGV2aWNlLlxuIik7Cj4+PiAgICBmbHVzaF9kZWxheWVkX3dvcmsoJmFkZXYt
PmRlbGF5ZWRfaW5pdF93b3JrKTsKPj4+ICt0dG1fYm9fbG9ja19kZWxheWVkX3dvcmtxdWV1ZSgm
YWRldi0+bW1hbi5iZGV2KTsKPj4+ICAgIGFkZXYtPnNodXRkb3duID0gdHJ1ZTsKPj4+Cj4+PiAg
ICBrZnJlZShhZGV2LT5wY2lfc3RhdGUpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mZW5jZS5jCj4+PiBpbmRleCAxNDNhMTRmNDg2NmYuLjZkMTZmNThhYzkxZSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5j
Cj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4g
QEAgLTUzMSw2ICs1MzEsOCBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaShzdHJ1Y3QK
Pj4gYW1kZ3B1X2RldmljZQo+Pj4gKmFkZXYpCj4+Pgo+Pj4gICAgaWYgKCFyaW5nIHx8ICFyaW5n
LT5mZW5jZV9kcnYuaW5pdGlhbGl6ZWQpCj4+PiAgICBjb250aW51ZTsKPj4+ICtpZiAoIXJpbmct
Pm5vX3NjaGVkdWxlcikKPj4+ICtkcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwo+Pj4gICAg
ciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOwo+Pj4gICAgaWYgKHIpIHsKPj4+ICAg
IC8qIG5vIG5lZWQgdG8gdHJpZ2dlciBHUFUgcmVzZXQgYXMgd2UgYXJlIHVubG9hZGluZyAqLwo+
PiBAQCAtNTM5LDgKPj4+ICs1NDEsNyBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+ICAgIGlmIChyaW5nLT5mZW5jZV9kcnYuaXJx
X3NyYykKPj4+ICAgIGFtZGdwdV9pcnFfcHV0KGFkZXYsIHJpbmctPmZlbmNlX2Rydi5pcnFfc3Jj
LAo+Pj4gICAgICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlwZSk7Cj4+PiAtaWYgKCFyaW5n
LT5ub19zY2hlZHVsZXIpCj4+PiAtZHJtX3NjaGVkX2ZpbmkoJnJpbmctPnNjaGVkKTsKPj4+ICsK
Pj4+ICAgIGRlbF90aW1lcl9zeW5jKCZyaW5nLT5mZW5jZV9kcnYuZmFsbGJhY2tfdGltZXIpOwo+
Pj4gICAgZm9yIChqID0gMDsgaiA8PSByaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrOyAr
K2opCj4+PiAgICBkbWFfZmVuY2VfcHV0KHJpbmctPmZlbmNlX2Rydi5mZW5jZXNbal0pOwo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKPj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+Pj4gaW5kZXggMjM4
MjNhNTczNzRmLi5mMWVkZTRiNDNkMDcgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2FydC5jCj4+PiBAQCAtMjAyLDYgKzIwMiw3IEBAIHZvaWQgYW1kZ3B1X2dh
cnRfdGFibGVfdnJhbV9mcmVlKHN0cnVjdAo+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gICAg
cmV0dXJuOwo+Pj4gICAgfQo+Pj4gICAgYW1kZ3B1X2JvX3VucmVmKCZhZGV2LT5nYXJ0LmJvKTsK
Pj4+ICthZGV2LT5nYXJ0LnB0ciA9IE5VTEw7Cj4+PiAgICB9Cj4+Pgo+Pj4gICAgLyoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
