Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE4C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960D6224B8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960D6224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A99E6E3E3;
	Tue, 15 Dec 2020 15:29:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CAC6E3AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608044775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n33BH0JIpwfiII+0rJOgiNcurtN16qylVgIcObIawoA=;
 b=iDE9x+5C7n61O/ORPiaWnSpaGbLka/T5+Zndn2HQCsGUNdIVzdnMS1Uiq1baQrL9/1MF/n
 P5dg7A5aPwhNrcBtqO0p7OpNuRoaAq6wHie+2f4saP57Dzk+ct2T8QqilIpghC/8rWmzVi
 mgXqHWUZCSpRXmtydBbkKYC3OPXydE0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-fDqa8FxWOROq_j78vYfLTg-1; Tue, 15 Dec 2020 10:06:11 -0500
X-MC-Unique: fDqa8FxWOROq_j78vYfLTg-1
Received: by mail-qk1-f199.google.com with SMTP id u9so15469950qkk.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 07:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=n33BH0JIpwfiII+0rJOgiNcurtN16qylVgIcObIawoA=;
 b=S2LsENlT3t4zI1ReAYMP27nPtdhIBeKjY8za3u8JJcJiAod4/rkEhkqF+8ZrZhm3x0
 3NzuovuWJWY+Dnf/tHKeVzfTETTvI5yBcCfv5+ZTmQHdEisP0vn/znxl1zz+LW00GIm0
 04+CPbFC2vM0w6wvdqoMn2vSAGpSsQ6ubPazw7ONlWqJ9TNbNwIFRBLBZh2Sk3UxMMd3
 1eSCGPbfxcCLCoeTzqRlhVjS4fICBXBJmIbUR+Zjt7xicdgNCb8wAzFegvVHjle/FEEo
 8K9SupMI9TMqNzhoETVg+nQtXKlevxDVu+eBdwcCyw9AfvVKVB1X0pLVbjY2BzxNmDOO
 b2aA==
X-Gm-Message-State: AOAM531PoF3kDp31EbbCZuNFJ9Skx0TQ+CDgBh8rFMw4YbYfGs69xsYZ
 gCmr23U/xAsMS0VfEBtbeADPgVTMtK1bWHtH7dB58lTKqMBv4jdP/swiNhBDTFxf9cnTERzd1j9
 C3X22n1JKoFlYFH7rfNZIKPTWqw==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr39525676qtu.136.1608044770767; 
 Tue, 15 Dec 2020 07:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFWLICLYxp/LajEPgP+Bc0xGN7GikJoY2NZ3c7YmeWN2ZadsxKAo+IZFmpbsdTfwGwLgskfw==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr39525658qtu.136.1608044770554; 
 Tue, 15 Dec 2020 07:06:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id a25sm13343088qtg.20.2020.12.15.07.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Dec 2020 07:06:09 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: remove h from printk format specifier
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 lee.jones@linaro.org, Felix.Kuehling@amd.com, nirmoy.das@amd.com,
 sonny.jiang@amd.com, xinhui.pan@amd.com, colin.king@canonical.com,
 James.Zhu@amd.com, leo.liu@amd.com, thong.thai@amd.com, vegopala@amd.com,
 boyuan.zhang@amd.com, Monk.Liu@amd.com, mh12gx2825@gmail.com
References: <20201215143835.1874487-1-trix@redhat.com>
 <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <a741836e-7f33-dcbb-d2bd-603091b9a2ad@redhat.com>
Date: Tue, 15 Dec 2020 07:06:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e71eb9ef-d5f9-0829-670f-d5c2c644a493@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Tue, 15 Dec 2020 15:29:11 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEyLzE1LzIwIDY6NDcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTUuMTIu
MjAgdW0gMTU6Mzggc2NocmllYiB0cml4QHJlZGhhdC5jb206Cj4+IEZyb206IFRvbSBSaXggPHRy
aXhAcmVkaGF0LmNvbT4KPj4KPj4gU2VlIERvY3VtZW50YXRpb24vY29yZS1hcGkvcHJpbnRrLWZv
cm1hdHMucnN0Lgo+PiBoIHNob3VsZCBubyBsb25nZXIgYmUgdXNlZCBpbiB0aGUgZm9ybWF0IHNw
ZWNpZmllciBmb3IgcHJpbnRrLgo+Cj4gSW4gZ2VuZXJhbCBsb29rcyB2YWxpZCB0byBtZSwgYnV0
IG15IHF1ZXN0aW9uIGlzIGhvdyBkb2VzIHRoYXQgd29yaz8KPgo+IEkgbWVhbiB3ZSBzcGVjaWZ5
IGggaGVyZSBiZWNhdXNlIGl0IGlzIGEgc2hvcnQgaW50LiBBcmUgaW50cyBhbHdheXMgMzJiaXQg
b24gdGhlIHN0YWNrPwoKVGhlIHR5cGUgb2YgdGhlIGFyZ3VtZW50IGlzIHByb21vdGVkIHRvIGlu
dC7CoCBUaGlzIHdhcyBkaXNjdXNzZWQgZWFybGllciBoZXJlCgpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sL2E2ODExNGFmYjEzNGI4NjMzOTA1ZjVhMjVhZTdjNGU2Nzk5Y2U4ZjEuY2FtZWxA
cGVyY2hlcy5jb20vCgpUb20KCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDQgKystLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMgfCAyICstCj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDQgKystLQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91dmQuYwo+PiBpbmRleCA3YzViNjBlNTM0ODIuLjhiOTg5NjcwZWQ2NiAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+PiBAQCAtMjQw
LDcgKzI0MCw3IEBAIGludCBhbWRncHVfdXZkX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXJzaW9uX21ham9yID0gKGxlMzJfdG9f
Y3B1KGhkci0+dWNvZGVfdmVyc2lvbikgPj4gMjQpICYgMHhmZjsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHZlcnNpb25fbWlub3IgPSAobGUzMl90b19jcHUoaGRyLT51Y29kZV92ZXJzaW9uKSA+PiA4
KSAmIDB4ZmY7Cj4+IC3CoMKgwqDCoMKgwqDCoCBEUk1fSU5GTygiRm91bmQgVVZEIGZpcm13YXJl
IFZlcnNpb246ICVodS4laHUgRmFtaWx5IElEOiAlaHVcbiIsCj4+ICvCoMKgwqDCoMKgwqDCoCBE
Uk1fSU5GTygiRm91bmQgVVZEIGZpcm13YXJlIFZlcnNpb246ICV1LiV1IEZhbWlseSBJRDogJXVc
biIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZlcnNpb25fbWFqb3IsIHZlcnNpb25f
bWlub3IsIGZhbWlseV9pZCk7Cj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+PiBAQCAtMjY3
LDcgKzI2Nyw3IEBAIGludCBhbWRncHVfdXZkX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBkZWNfbWlub3IgPSAobGUzMl90b19jcHUoaGRy
LT51Y29kZV92ZXJzaW9uKSA+PiA4KSAmIDB4ZmY7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbmNf
bWlub3IgPSAobGUzMl90b19jcHUoaGRyLT51Y29kZV92ZXJzaW9uKSA+PiAyNCkgJiAweDNmOwo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW5jX21ham9yID0gKGxlMzJfdG9fY3B1KGhkci0+dWNvZGVf
dmVyc2lvbikgPj4gMzApICYgMHgzOwo+PiAtwqDCoMKgwqDCoMKgwqAgRFJNX0lORk8oIkZvdW5k
IFVWRCBmaXJtd2FyZSBFTkM6ICVodS4laHUgREVDOiAuJWh1IEZhbWlseSBJRDogJWh1XG4iLAo+
PiArwqDCoMKgwqDCoMKgwqAgRFJNX0lORk8oIkZvdW5kIFVWRCBmaXJtd2FyZSBFTkM6ICV1LiV1
IERFQzogLiV1IEZhbWlseSBJRDogJXVcbiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVuY19tYWpvciwgZW5jX21pbm9yLCBkZWNfbWlub3IsIGZhbWlseV9pZCk7Cj4+IMKgIMKgwqDC
oMKgwqDCoMKgwqDCoCBhZGV2LT51dmQubWF4X2hhbmRsZXMgPSBBTURHUFVfTUFYX1VWRF9IQU5E
TEVTOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCj4+IGluZGV4IDQ4
NjFmOGRkYzFiNS4uZWE2YTYyZjY3ZTM4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZjZS5jCj4+IEBAIC0xNzksNyArMTc5LDcgQEAgaW50IGFtZGdwdV92Y2Vfc3df
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXplKQo+PiDC
oMKgwqDCoMKgIHZlcnNpb25fbWFqb3IgPSAodWNvZGVfdmVyc2lvbiA+PiAyMCkgJiAweGZmZjsK
Pj4gwqDCoMKgwqDCoCB2ZXJzaW9uX21pbm9yID0gKHVjb2RlX3ZlcnNpb24gPj4gOCkgJiAweGZm
ZjsKPj4gwqDCoMKgwqDCoCBiaW5hcnlfaWQgPSB1Y29kZV92ZXJzaW9uICYgMHhmZjsKPj4gLcKg
wqDCoCBEUk1fSU5GTygiRm91bmQgVkNFIGZpcm13YXJlIFZlcnNpb246ICVoaGQuJWhoZCBCaW5h
cnkgSUQ6ICVoaGRcbiIsCj4+ICvCoMKgwqAgRFJNX0lORk8oIkZvdW5kIFZDRSBmaXJtd2FyZSBW
ZXJzaW9uOiAlZC4lZCBCaW5hcnkgSUQ6ICVkXG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmVy
c2lvbl9tYWpvciwgdmVyc2lvbl9taW5vciwgYmluYXJ5X2lkKTsKPj4gwqDCoMKgwqDCoCBhZGV2
LT52Y2UuZndfdmVyc2lvbiA9ICgodmVyc2lvbl9tYWpvciA8PCAyNCkgfCAodmVyc2lvbl9taW5v
ciA8PCAxNikgfAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChiaW5hcnlf
aWQgPDwgOCkpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IGlu
ZGV4IDFlNzU2MTg2ZTNmOC4uOTliODJmM2MyNjE3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IEBAIC0xODEsNyArMTgxLDcgQEAgaW50IGFtZGdwdV92
Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGVuY19tYWpvciA9IGZ3X2NoZWNrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGVjX3ZlciA9
IChsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pID4+IDI0KSAmIDB4ZjsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHZlcCA9IChsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pID4+IDI4
KSAmIDB4ZjsKPj4gLcKgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJGb3VuZCBWQ04gZmlybXdhcmUg
VmVyc2lvbiBFTkM6ICVodS4laHUgREVDOiAlaHUgVkVQOiAlaHUgUmV2aXNpb246ICVodVxuIiwK
Pj4gK8KgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJGb3VuZCBWQ04gZmlybXdhcmUgVmVyc2lvbiBF
TkM6ICV1LiV1IERFQzogJXUgVkVQOiAldSBSZXZpc2lvbjogJXVcbiIsCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVuY19tYWpvciwgZW5jX21pbm9yLCBkZWNfdmVyLCB2ZXAsIGZ3X3Jl
dik7Cj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGludCB2ZXJzaW9uX21ham9yLCB2ZXJzaW9uX21pbm9yLCBmYW1pbHlfaWQ7Cj4+IEBAIC0xODks
NyArMTg5LDcgQEAgaW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZhbWlseV9pZCA9IGxlMzJfdG9fY3B1KGhkci0+
dWNvZGVfdmVyc2lvbikgJiAweGZmOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmVyc2lvbl9tYWpv
ciA9IChsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pID4+IDI0KSAmIDB4ZmY7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB2ZXJzaW9uX21pbm9yID0gKGxlMzJfdG9fY3B1KGhkci0+dWNvZGVf
dmVyc2lvbikgPj4gOCkgJiAweGZmOwo+PiAtwqDCoMKgwqDCoMKgwqAgRFJNX0lORk8oIkZvdW5k
IFZDTiBmaXJtd2FyZSBWZXJzaW9uOiAlaHUuJWh1IEZhbWlseSBJRDogJWh1XG4iLAo+PiArwqDC
oMKgwqDCoMKgwqAgRFJNX0lORk8oIkZvdW5kIFZDTiBmaXJtd2FyZSBWZXJzaW9uOiAldS4ldSBG
YW1pbHkgSUQ6ICV1XG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXJzaW9uX21h
am9yLCB2ZXJzaW9uX21pbm9yLCBmYW1pbHlfaWQpOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
