Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785BC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB31C2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II4hBAUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF976F47E;
	Fri, 21 Feb 2020 15:27:14 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43826F47E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:27:13 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r11so2499761wrq.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 07:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=G5FraDwQCmBrGaE1xnZHe6r79jhluOAhK8qkFUjFHw8=;
 b=II4hBAUPzKbHCWo6BVf183nTyFvSNgHeIhDTQkYpSY//Ow3FNMPe9+3mf/iX+YOhA4
 PrscW94JZ/DAvK77vLkiboUqTF2fk2rGqd9y9igJa9VtNtpKWzWZ96fyEIopjkl+xY8l
 gr3FvwP9cKKAhVdDkPt8rWSRZ2O4abV4VcWPDt+o+0cTGA15O3WS+3dbO10Cc63dOWBz
 jT7uW6OcUb/uYPZ0PEjGtnyrf4l5x9JUelE2qBST4mfmdz2o2htO59qio+1vZ27MGoal
 DkV+PNIRUwqWevGDs/MT1Ecgdt8wFTxd+w9jQd0bqYK8LZIdg/OEPookhPIEX/thzZ+A
 sWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=G5FraDwQCmBrGaE1xnZHe6r79jhluOAhK8qkFUjFHw8=;
 b=kGUblF/F8tz+5IXi/1351Ev5YD1PLcdlLvjE9EANDGlC5trOWKygz/Ibk/gDjb2LFC
 yNF3FcM0s/US0EEcnVoyq/iP06X8swXSjcXMWq1Mf9VOwfWCajsxmjNcSDzmh7LjaFdn
 gPty26ziBWGTzCt+DFHqHAHFPrNNuhjQwON3uh/Iyw9ApNCo35YtfJyM2lCy+cuHk2m+
 +D9jGxMgh7TGnkN+7pKdRtxil6HoA2pL1UEzNGdkyurS9rRManeLO29BBzh5nXnAQxLQ
 O2GWNpO4eO3iG86kMe1H01m3k2NKFkmR95+qwhOTnqT8IthhoYFp24flmvELonXxc0fe
 GA4A==
X-Gm-Message-State: APjAAAW8nm5W1/FiRmNSnflV7Nt84BQyT8pRiJCBf/KeA4zApodcUT3Y
 +dT6FYZzn0K1zr2b+88fYI7u+yEf
X-Google-Smtp-Source: APXvYqwq2vB72a3lB187ejWn8choNOGt1YJGw1OOMvS1dFGgPUfrluSiyHI49bdJuNPQQ3kS0CbP/w==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr51798777wrr.172.1582298832009; 
 Fri, 21 Feb 2020 07:27:12 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 5sm4425878wrc.75.2020.02.21.07.27.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Feb 2020 07:27:11 -0800 (PST)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogZGlzYWJs?=
 =?UTF-8?Q?e_GFXOFF_around_debugfs_access_to_MMIO?=
To: Huang Rui <ray.huang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
 <20200221152321.GH28698@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2e56e194-dceb-8315-987e-5825ad02a143@gmail.com>
Date: Fri, 21 Feb 2020 16:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200221152321.GH28698@jenkins-Celadon-RN>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDIuMjAgdW0gMTY6MjMgc2NocmllYiBIdWFuZyBSdWk6Cj4gT24gRnJpLCBGZWIgMjEs
IDIwMjAgYXQgMTE6MTg6MDdQTSArMDgwMCwgTGl1LCBNb25rIHdyb3RlOgo+PiBCZXR0ZXIgbm90
IHVzZSBLSVEsIGJlY2F1c2Ugd2hlbiB5b3UgdXNlIGRlYnVnZnMgdG8gcmVhZCByZWdpc3RlciB5
b3UgdXN1YWxseSBoaXQgYSBoYW5nLCBhbmQgYnkgdGhhdCBjYXNlIEtJUSBwcm9iYWJseSBhbHJl
YWR5IGRpZQo+IElmIENQIGlzIGJ1c3ksIHRoZSBnZnggc2hvdWxkIGJlIGluICJvbiIgc3RhdGUg
YXQgdGhhdCB0aW1lLCB3ZSBuZWVkbid0IHVzZSBLSVEuCgpZZWFoLCBidXQgaG93IGRvIHlvdSBk
ZXRlY3QgdGhhdD8gRG8gd2UgaGF2ZSBhIHdheSB0byB3YWtlIHVwIHRoZSBDUCAKd2l0aG91dCBh
c2tpbmcgcG93ZXIgbWFuYWdlbWVudCB0byBkbyBzbz8KCkNhdXNlIHRoZSByZWdpc3RlciBkZWJ1
ZyBpbnRlcmZhY2UgaXMgbWVhbnQgdG8gYmUgdXNlZCB3aGVuIHRoZSBBU0lDIGlzIApjb21wbGV0
ZWQgbG9ja2VkIHVwLiBTZW5kaW5nIG1lc3NhZ2VzIHRvIHRoZSBTTVUgaXMgbm90IHJlYWxseSBn
b2luZyB0byAKd29yayBpbiB0aGF0IHNpdHVhdGlvbi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4K
PiBUaGFua3MsCj4gUmF5Cj4KPj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQo+PiDlj5Hku7bkuro6
IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IOS7o+ihqCBI
dWFuZyBSdWkKPj4g5Y+R6YCB5pe26Ze0OiAyMDIw5bm0MuaciDIx5pelIDIyOjM0Cj4+IOaUtuS7
tuS6ujogU3REZW5pcywgVG9tIDxUb20uU3REZW5pc0BhbWQuY29tPgo+PiDmioTpgIE6IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4KPj4g5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdw
dTogZGlzYWJsZSBHRlhPRkYgYXJvdW5kIGRlYnVnZnMgYWNjZXNzIHRvIE1NSU8KPj4KPj4gT24g
V2VkLCBGZWIgMTksIDIwMjAgYXQgMTA6MDk6NDZBTSAtMDUwMCwgVG9tIFN0IERlbmlzIHdyb3Rl
Ogo+Pj4gSSBnb3Qgc29tZSBtZXNzYWdlcyBhZnRlciBhIHdoaWxlOgo+Pj4KPj4+IFvCoCA3NDEu
Nzg4NTY0XSBGYWlsZWQgdG8gc2VuZCBNZXNzYWdlIDguCj4+PiBbwqAgNzQ2LjY3MTUwOV0gRmFp
bGVkIHRvIHNlbmQgTWVzc2FnZSA4Lgo+Pj4gW8KgIDc0OC43NDk2NzNdIEZhaWxlZCB0byBzZW5k
IE1lc3NhZ2UgMmIuCj4+PiBbwqAgNzU5LjI0NTQxNF0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSA3
Lgo+Pj4gW8KgIDc2My4yMTY5MDJdIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UgMmEuCj4+Pgo+Pj4g
QXJlIHRoZXJlIGFueSBhZGRpdGlvbmFsIGxvY2tzIHRoYXQgc2hvdWxkIGJlIGhlbGQ/wqAgQmVj
YXVzZSBzb21lCj4+PiBjb21tYW5kcyBsaWtlIC0tdG9wIG9yIC0td2F2ZXMgY2FuIGRvIGEgbG90
IG9mIGRpc3RpbmN0IHJlYWQKPj4+IG9wZXJhdGlvbnMgKGNhdXNpbmcgYSBsb3Qgb2YgZW5hYmxl
L2Rpc2FibGUgY2FsbHMpLgo+Pj4KPj4+IEknbSBnb2luZyB0byBzaXQgb24gdGhpcyBhIGJpdCBz
aW5jZSBJIGRvbid0IHRoaW5rIHRoZSBwYXRjaCBpcyByZWFkeQo+Pj4gZm9yIHB1c2hpbmcgb3V0
Lgo+Pj4KPj4gSG93IGFib3V0IHVzZSBSUkVHMzJfS0lRIGFuZCBXUkVHMzJfS0lRPwo+Pgo+PiBU
aGFua3MsCj4+IFJheQo+Pgo+Pj4gVG9tCj4+Pgo+Pj4gT24gMjAyMC0wMi0xOSAxMDowNyBhLm0u
LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+Pj4gT24gV2VkLCBGZWIgMTksIDIwMjAgYXQgMTA6MDQg
QU0gVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPiB3cm90ZToKPj4+Pj4gU2lnbmVk
LW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+Pj4+IFBsZWFzZSBh
ZGQgYSBwYXRjaCBkZXNjcmlwdGlvbi4gIFdpdGggdGhhdCBmaXhlZDoKPj4+PiBSZXZpZXdlZC1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4+Cj4+Pj4+IC0t
LQo+Pj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwg
MyArKysKPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4+Pgo+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
Ywo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPj4+
Pj4gaW5kZXggNzM3OTkxMDc5MGM5Li42NmY3NjMzMDBjOTYgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKPj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+Pj4+PiBAQCAtMTY5LDYg
KzE2OSw3IEBAIHN0YXRpYyBpbnQgIGFtZGdwdV9kZWJ1Z2ZzX3Byb2Nlc3NfcmVnX29wKGJvb2wg
cmVhZCwgc3RydWN0IGZpbGUgKmYsCj4+Pj4+ICAgICAgICAgICBpZiAocG1fcGdfbG9jaykKPj4+
Pj4gICAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOwo+Pj4+Pgo+
Pj4+PiArICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwo+Pj4+PiAgICAg
ICAgICAgd2hpbGUgKHNpemUpIHsKPj4+Pj4gICAgICAgICAgICAgICAgICAgdWludDMyX3QgdmFs
dWU7Cj4+Pj4+Cj4+Pj4+IEBAIC0xOTIsNiArMTkzLDggQEAgc3RhdGljIGludCAgYW1kZ3B1X2Rl
YnVnZnNfcHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwKPj4+Pj4gICAg
ICAgICAgIH0KPj4+Pj4KPj4+Pj4gICAgZW5kOgo+Pj4+PiArICAgICAgIGFtZGdwdV9nZnhfb2Zm
X2N0cmwoYWRldiwgdHJ1ZSk7Cj4+Pj4+ICsKPj4+Pj4gICAgICAgICAgIGlmICh1c2VfYmFuaykg
ewo+Pj4+PiAgICAgICAgICAgICAgICAgICBhbWRncHVfZ2Z4X3NlbGVjdF9zZV9zaChhZGV2LCAw
eGZmZmZmZmZmLCAweGZmZmZmZmZmLCAweGZmZmZmZmZmKTsKPj4+Pj4gICAgICAgICAgICAgICAg
ICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5ncmJtX2lkeF9tdXRleCk7Cj4+Pj4+IC0tCj4+Pj4+IDIu
MjQuMQo+Pj4+Pgo+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+Pj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+PiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYKPj4+Pj4gbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3Cj4+Pj4+IEMwMSU3
Q21vbmsubGl1JTQwYW1kLmNvbSU3Q2JhNDVlZmIyNmMwMjQwZWQwMzZmMDhkN2I2ZGIyMGFhJTdD
M2RkOAo+Pj4+PiA5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzg5
MjQ2MDU1MjQzNzgmYW1wO3NkYXQKPj4+Pj4gYT0lMkZ5SGt2WVU1VCUyRjRpRnhSZXhzZyUyQklk
bTdzRHp5WGJqek5wSFVHQ083aDRrJTNEJmFtcDtyZXNlcnZlCj4+Pj4+IGQ9MAo+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bGlzdAo+Pj4gcy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0Ntbwo+Pj4gbmsubGl1JTQwYW1kLmNvbSU3Q2JhNDVlZmIyNmMw
MjQwZWQwMzZmMDhkN2I2ZGIyMGFhJTdDM2RkODk2MWZlNDg4NGU2MAo+Pj4gOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MTc4OTI0NjA1NTI0Mzc4JmFtcDtzZGF0YT0lMkZ5SGt2WVU1VCUy
Rgo+Pj4gNGlGeFJleHNnJTJCSWRtN3NEenlYYmp6TnBIVUdDTzdoNGslM0QmYW1wO3Jlc2VydmVk
PTAKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4g
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbW9uay5saXUlNDBhbWQuY29tJTdDYmE0NWVmYjI2YzAy
NDBlZDAzNmYwOGQ3YjZkYjIwYWElN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3MTc4OTI0NjA1NTI0Mzc4JmFtcDtzZGF0YT0lMkZ5SGt2WVU1VCUyRjRpRnhS
ZXhzZyUyQklkbTdzRHp5WGJqek5wSFVHQ083aDRrJTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
