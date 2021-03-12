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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 12:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCBD64FF5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 12:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCBD64FF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8516F5F2;
	Fri, 12 Mar 2021 12:16:56 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D59F6F5F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 12:16:55 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id bm21so52941235ejb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Bvs0UGv2V66ycr5D3K7ACz/VknW7H9SVM+CYmQFn6ng=;
 b=gyYaYdj5iAlGqaJuJJm7ZX3qePEn5S3+wOONrRQf7foP6z8m54CK6rfjOiZwEDXtkh
 FCW3RJMNgNlgeePSmrj4t9I+JStOd/JbgtDJIauQDhQoBCAUR7pfIMNt0MC1Ax7khxTo
 wEiqOJe8ZYvVtKZVQc1/1N9hbn9/2+0fqmP0KfgjRr/8n1h5khW06TSLinxa5Qh1GX4v
 VDA5SCsCtTWKnsS1kFctWshrgUFpAorhBCfYkvhEVjJoTJ6y9BSm1H7LoIt9pUhhN4sb
 PrIMVI+Wyk59sfoIMhAOfREHPVM5xDxC6xKildjB3brWjyYKeTWFzVS8MxgyfTJIn5vS
 C9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Bvs0UGv2V66ycr5D3K7ACz/VknW7H9SVM+CYmQFn6ng=;
 b=Jva2k+NFGCRjrKIj7I5bmSbZiKdjl8BKD9MNrkacs95vTeBGztGrm1s/tTYoDltOiR
 Emg1BL8LCusOzu3s5QRn//lfK8rB7IZ1IYq/xuQ2NdEJH2k2MxwNQ0wQnCp7kLg01POf
 Dp+92zAH76XU5veXVpiybuVE/GyCxBl8H9TL2PQyd2aY76YUZYMVrU7oBumor9K0PRAs
 Rx1y2s5S17CedLVTIf1qTOAVcKwfZ2DAI2l4rJZjfWZ5uUklrRTMy/8g5jIk/Yr5Vu3f
 BR8FjTeKqNHWwXy8exUdueqv28Mc/TwidLQ65XD0ofOQssbXtSNUasB7cMt1/xI9Szhp
 QW6w==
X-Gm-Message-State: AOAM533cm3QPpeT4qBXn7JegVmz1BbAdLa/lfkZaMeqEPSH7Rjj0xVK9
 uwJXFaB/+NTvQt6LRhLDOyrp/2EC9bw=
X-Google-Smtp-Source: ABdhPJw1EClM477pAVvnL++D41mkPfoUf+UmOuUYWUrHxpzJ+wBP1AGT/VmScHJxjDoquL6uv+iwvA==
X-Received: by 2002:a17:906:da0e:: with SMTP id
 fi14mr8499539ejb.188.1615551414322; 
 Fri, 12 Mar 2021 04:16:54 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:8238:34c0:2ed9:a97?
 ([2a02:908:1252:fb60:8238:34c0:2ed9:a97])
 by smtp.gmail.com with ESMTPSA id z17sm2730651eju.27.2021.03.12.04.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 04:16:53 -0800 (PST)
Subject: Re: [PATCH 1/8] drm/amdgpu: new resource cursor
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210308134044.133658-1-christian.koenig@amd.com>
 <b95c5f36-0b12-347d-8d85-4e24cdb37003@gmail.com>
 <DM6PR12MB41887EA09B1AC220B3B45282E46F9@DM6PR12MB4188.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ec57c4eb-3550-34b2-a83a-6d1aaffdee03@gmail.com>
Date: Fri, 12 Mar 2021 13:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB41887EA09B1AC220B3B45282E46F9@DM6PR12MB4188.namprd12.prod.outlook.com>
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

VGhhbmtzISBHb2luZyB0byBwdXNoIHRoYXQgc3R1ZmYgbm93LgoKQ2hyaXN0aWFuLgoKQW0gMTIu
MDMuMjEgdW0gMTI6MTEgc2NocmllYiBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluOgo+IFtBTUQg
UHVibGljIFVzZV0KPgo+IEhpIENocmlzdGlhbiwKPiBSZXZpZXdlZCB0aGUgY2hhbmdlcywgaXQg
bG9va3MgZ29vZCB0byBtZS4KPgo+IFJldmlld2VkLWJ5OiBBcnVucHJhdmluIDxBcnVucHJhdmlu
LlBhbmVlclNlbHZhbUBhbWQuY29tPgo+Cj4gVGhhbmtzLAo+IEFydW4KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPgo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTIsIDIwMjEgNDoyMiBQTQo+
IFRvOiBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTdWJqZWN0OiBSZTogW1BB
VENIIDEvOF0gZHJtL2FtZGdwdTogbmV3IHJlc291cmNlIGN1cnNvcgo+Cj4gQW55IG1vcmUgY29t
bWVudHMgb24gdGhpcyBzZXQgaGVyZSBvciBvdGhlcndpc2UgSSdtIGdvaW5nIHRvIHB1c2ggaXQg
d2l0aCBqdXN0IE9ha3MgYWNrLgo+Cj4gVGhhbmtzLAo+IENocmlzdGlhbi4KPgo+IEFtIDA4LjAz
LjIxIHVtIDE0OjQwIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gQWxsb3dzIHRvIHdhbGsg
b3ZlciB0aGUgZHJtX21tIG5vZGVzIGluIGEgVFRNIHJlc291cmNlIG9iamVjdC4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
PiBBY2tlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4+IFRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4gICAgLi4uL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oICAgIHwgMTA1ICsrKysrKysrKysrKysrKysrKwo+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMTA1IGluc2VydGlvbnMoKykKPj4gICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vy
c29yLmgKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5o
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTMzNWUwOTg1
MTBmCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jlc19jdXJzb3IuaAo+PiBAQCAtMCwwICsxLDEwNSBAQAo+PiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgTUlUCj4+ICsvKgo+PiArICogQ29weXJpZ2h0IDIw
MjAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgo+PiArICoKPj4gKyAqIFBlcm1pc3Npb24g
aXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uCj4+ICtvYnRh
aW5pbmcgYQo+PiArICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3Vt
ZW50YXRpb24gZmlsZXMgKHRoZQo+PiArIlNvZnR3YXJlIiksCj4+ICsgKiB0byBkZWFsIGluIHRo
ZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dAo+PiArbGlt
aXRhdGlvbgo+PiArICogdGhlIHJpZ2h0cyB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1
Ymxpc2gsIGRpc3RyaWJ1dGUsCj4+ICtzdWJsaWNlbnNlLAo+PiArICogYW5kL29yIHNlbGwgY29w
aWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20KPj4gK3Ro
ZQo+PiArICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBm
b2xsb3dpbmcgY29uZGl0aW9uczoKPj4gKyAqCj4+ICsgKiBUaGUgYWJvdmUgY29weXJpZ2h0IG5v
dGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBiZQo+PiAraW5jbHVkZWQgaW4K
Pj4gKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJl
Lgo+PiArICoKPj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VU
IFdBUlJBTlRZIE9GIEFOWSBLSU5ELAo+PiArRVhQUkVTUyBPUgo+PiArICogSU1QTElFRCwgSU5D
TFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRgo+PiArTUVSQ0hBTlRB
QklMSVRZLAo+PiArICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklO
RlJJTkdFTUVOVC4gIElOIE5PIEVWRU5UCj4+ICtTSEFMTAo+PiArICogVEhFIENPUFlSSUdIVCBI
T0xERVIoUykgT1IgQVVUSE9SKFMpIEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLAo+PiArREFNQUdF
UyBPUgo+PiArICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05U
UkFDVCwgVE9SVCBPUgo+PiArT1RIRVJXSVNFLAo+PiArICogQVJJU0lORyBGUk9NLCBPVVQgT0Yg
T1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFCj4+ICtPUgo+PiAr
ICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgo+PiArICoKPj4gKyAqIEF1dGhvcnM6
IENocmlzdGlhbiBLw7ZuaWcKPj4gKyAqLwo+PiArCj4+ICsjaWZuZGVmIF9fQU1ER1BVX1JFU19D
VVJTT1JfSF9fCj4+ICsjZGVmaW5lIF9fQU1ER1BVX1JFU19DVVJTT1JfSF9fCj4+ICsKPj4gKyNp
bmNsdWRlIDxkcm0vZHJtX21tLmg+Cj4+ICsjaW5jbHVkZSA8ZHJtL3R0bS90dG1fcmVzb3VyY2Uu
aD4KPj4gKwo+PiArLyogc3RhdGUgYmFjayBmb3Igd2Fsa2luZyBvdmVyIHZyYW1fbWdyIGFuZCBn
dHRfbWdyIGFsbG9jYXRpb25zICovCj4+ICtzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJzb3Igewo+PiAr
CXVpbnQ2NF90CQlzdGFydDsKPj4gKwl1aW50NjRfdAkJc2l6ZTsKPj4gKwl1aW50NjRfdAkJcmVt
YWluaW5nOwo+PiArCXN0cnVjdCBkcm1fbW1fbm9kZQkqbm9kZTsKPj4gK307Cj4+ICsKPj4gKy8q
Kgo+PiArICogYW1kZ3B1X3Jlc19maXJzdCAtIGluaXRpYWxpemUgYSBhbWRncHVfcmVzX2N1cnNv
cgo+PiArICoKPj4gKyAqIEByZXM6IFRUTSByZXNvdXJjZSBvYmplY3QgdG8gd2Fsawo+PiArICog
QHN0YXJ0OiBTdGFydCBvZiB0aGUgcmFuZ2UKPj4gKyAqIEBzaXplOiBTaXplIG9mIHRoZSByYW5n
ZQo+PiArICogQGN1cjogY3Vyc29yIG9iamVjdCB0byBpbml0aWFsaXplCj4+ICsgKgo+PiArICog
U3RhcnQgd2Fsa2luZyBvdmVyIHRoZSByYW5nZSBvZiBhbGxvY2F0aW9ucyBiZXR3ZWVuIEBzdGFy
dCBhbmQgQHNpemUuCj4+ICsgKi8KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzX2Zp
cnN0KHN0cnVjdCB0dG1fcmVzb3VyY2UgKnJlcywKPj4gKwkJCQkgICAgdWludDY0X3Qgc3RhcnQs
IHVpbnQ2NF90IHNpemUsCj4+ICsJCQkJICAgIHN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciAqY3Vy
KSB7Cj4+ICsJc3RydWN0IGRybV9tbV9ub2RlICpub2RlOwo+PiArCj4+ICsJaWYgKCFyZXMgfHwg
IXJlcy0+bW1fbm9kZSkgewo+PiArCQljdXItPnN0YXJ0ID0gc3RhcnQ7Cj4+ICsJCWN1ci0+c2l6
ZSA9IHNpemU7Cj4+ICsJCWN1ci0+cmVtYWluaW5nID0gc2l6ZTsKPj4gKwkJY3VyLT5ub2RlID0g
TlVMTDsKPj4gKwkJcmV0dXJuOwo+PiArCX0KPj4gKwo+PiArCUJVR19PTihzdGFydCArIHNpemUg
PiByZXMtPm51bV9wYWdlcyA8PCBQQUdFX1NISUZUKTsKPj4gKwo+PiArCW5vZGUgPSByZXMtPm1t
X25vZGU7Cj4+ICsJd2hpbGUgKHN0YXJ0ID4gbm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKQo+PiAr
CQlzdGFydCAtPSBub2RlKystPnNpemUgPDwgUEFHRV9TSElGVDsKPj4gKwo+PiArCWN1ci0+c3Rh
cnQgPSAobm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsKPj4gKwljdXItPnNpemUg
PSAobm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0Owo+PiArCWN1ci0+cmVtYWluaW5n
ID0gc2l6ZTsKPj4gKwljdXItPm5vZGUgPSBub2RlOwo+PiArfQo+PiArCj4+ICsvKioKPj4gKyAq
IGFtZGdwdV9yZXNfbmV4dCAtIGFkdmFuY2UgdGhlIGN1cnNvcgo+PiArICoKPj4gKyAqIEBjdXI6
IHRoZSBjdXJzb3IgdG8gYWR2YW5jZQo+PiArICogQHNpemU6IG51bWJlciBvZiBieXRlcyB0byBt
b3ZlIGZvcndhcmQKPj4gKyAqCj4+ICsgKiBNb3ZlIHRoZSBjdXJzb3IgQHNpemUgYnl0ZXMgZm9y
d3JhZCwgd2Fsa2luZyB0byB0aGUgbmV4dCBub2RlIGlmIG5lY2Vzc2FyeS4KPj4gKyAqLwo+PiAr
c3RhdGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfbmV4dChzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJz
b3IgKmN1ciwKPj4gK3VpbnQ2NF90IHNpemUpIHsKPj4gKwlzdHJ1Y3QgZHJtX21tX25vZGUgKm5v
ZGUgPSBjdXItPm5vZGU7Cj4+ICsKPj4gKwlCVUdfT04oc2l6ZSA+IGN1ci0+cmVtYWluaW5nKTsK
Pj4gKwo+PiArCWN1ci0+cmVtYWluaW5nIC09IHNpemU7Cj4+ICsJaWYgKCFjdXItPnJlbWFpbmlu
ZykKPj4gKwkJcmV0dXJuOwo+PiArCj4+ICsJY3VyLT5zaXplIC09IHNpemU7Cj4+ICsJaWYgKGN1
ci0+c2l6ZSkgewo+PiArCQljdXItPnN0YXJ0ICs9IHNpemU7Cj4+ICsJCXJldHVybjsKPj4gKwl9
Cj4+ICsKPj4gKwljdXItPm5vZGUgPSArK25vZGU7Cj4+ICsJY3VyLT5zdGFydCA9IG5vZGUtPnN0
YXJ0IDw8IFBBR0VfU0hJRlQ7Cj4+ICsJY3VyLT5zaXplID0gbWluKG5vZGUtPnNpemUgPDwgUEFH
RV9TSElGVCwgY3VyLT5yZW1haW5pbmcpOyB9Cj4+ICsKPj4gKyNlbmRpZgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
