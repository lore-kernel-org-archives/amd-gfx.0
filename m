Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56BC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 17:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAE061042
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 17:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE061042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018D689E2A;
	Tue,  1 Jun 2021 17:38:05 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1AB89E2A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 17:38:04 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id l1so23004592ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=c25ZgGkOwNz9mPrz2VlWmx5lC+m/H9JTpceoZNO5IFk=;
 b=k7WcXDSgpyRCbYSAWl4SQIZbNTM6H/+6q11vx7USIinpgGJ1qn+otUSZ4h7ZxUWJA9
 QDmFy1L5bDsYvldO+T76Ly1w0nEtDOu38LMUNVjqRbHtvfLd7PLLg/kRF0uZYirktvat
 BRttrCc5Px30ZB+//9ocmPEDhOBTC6uzwTYvM/lCmCg3xEzXg6Gb49FS197qBqWNHv7Z
 SNCvak7YcjTbcjEwsfh+cr9EaMeKp1HlEXQ5U3O9qHWADDRFTN+gz8N1ovw9VqnMnNgz
 r6wHKEpQyx3ZAAQVOyokXyToNUp9m4QIHTuEa60qFxvUlX48QCMb+Z2Q3tIngmyTGdFK
 LLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=c25ZgGkOwNz9mPrz2VlWmx5lC+m/H9JTpceoZNO5IFk=;
 b=t59uOmBjvSu9w3XW3BnA5EqHBxx4YEzxe5aBZwiFlEJXrq6UEElabs8gBzewMP8Rjg
 3Q8N7k4EbmllgPfGX6Pb6jWRFp69O+EHNk0oUsXjovRkhmYYgGwm1/UcuBfXJJGx9WLM
 FryJIiiANfduStFc0+Wz0bN5scjR7eJW8NnOuWnFROazr2BSMoyBnYVyiKE7udO0ibL/
 kCnxgeU6PAS376y88lX1oPNr+pVNFlx8Oa4/SNtzu8JnPD9aGcbHhwzvYz5rvOaO7Pc9
 PH8hlYJvtJDfJXqFqkC+G8mH46Wg0H+ypb6v+5s0KOSlUvPv/7XADLju+XghulYsnvPu
 MOSQ==
X-Gm-Message-State: AOAM530gvz49xi2Zjh65VIpACQMfrsHEwUQXt1Ic0G6QxWt1rkPeLtxx
 brs7vmkDfMnY2lhHC+jBHZRauIqULOY=
X-Google-Smtp-Source: ABdhPJzGOVNyyYX6tkEL73rEQkW/L4kZeeXvpGmOPB0Y9EKOROHrJw+8eMD0pufuD36nETBkGGOO9Q==
X-Received: by 2002:a17:906:7203:: with SMTP id
 m3mr29657151ejk.381.1622569082909; 
 Tue, 01 Jun 2021 10:38:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7517:785b:7177:d6a6?
 ([2a02:908:1252:fb60:7517:785b:7177:d6a6])
 by smtp.gmail.com with ESMTPSA id t2sm5439249ejx.72.2021.06.01.10.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 10:38:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Don't flush HDP on A+A
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210601000625.551445-1-jinhuieric.huang@amd.com>
 <20210601000625.551445-2-jinhuieric.huang@amd.com>
 <21f80a3a-b48d-3ee3-fabb-d1b377a51600@gmail.com>
 <0da1d86e-b966-4103-119e-ed8ae6f53842@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c1769db6-030a-fc83-9a1a-87b5372b30ac@gmail.com>
Date: Tue, 1 Jun 2021 19:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0da1d86e-b966-4103-119e-ed8ae6f53842@amd.com>
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

QW0gMDEuMDYuMjEgdW0gMTY6NDUgc2NocmllYiBFcmljIEh1YW5nOgo+Cj4gT24gMjAyMS0wNi0w
MSAzOjA1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDAxLjA2LjIxIHVtIDAy
OjA2IHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4+IFdpdGggWEdNSSBjb25uZWN0aW9uIGZsdXNoaW5n
IEhEUCBvbiBQQ0llIGlzIHVubmVjZXNzYXJ5LAo+Pj4gaXQgaXMgYWxzbyB0byBvcHRpbWl6ZSBt
ZW1vcnkgYWxsb2NhdGlvbiBsYXRlbmN5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVh
bmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2hkcC5oIHwgMSArCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWIuY8KgIHwgMyArKy0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmPCoMKgIHwgMSArCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9oZHBfdjRfMC5jwqDCoCB8IDMgKysrCj4+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaGRwLmggCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9oZHAuaAo+Pj4gaW5kZXggN2VjOTlkNTkxNTg0Li4xY2EyM2YyZjUx
ZDIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaGRw
LmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9oZHAuaAo+Pj4g
QEAgLTQ0LDYgKzQ0LDcgQEAgc3RydWN0IGFtZGdwdV9oZHAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgcmFzX2NvbW1vbl9pZsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnJhc19pZjsKPj4+IMKgwqDC
oMKgwqAgY29uc3Qgc3RydWN0IGFtZGdwdV9oZHBfZnVuY3PCoMKgwqDCoMKgwqDCoCAqZnVuY3M7
Cj4+PiDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBhbWRncHVfaGRwX3Jhc19mdW5jc8KgwqDCoCAq
cmFzX2Z1bmNzOwo+Pj4gK8KgwqDCoCBib29swqDCoMKgIG5vX2ZsdXNoOwo+Pj4gwqAgfTsKPj4+
IMKgIMKgIGludCBhbWRncHVfaGRwX3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pYi5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4g
aW5kZXggYWFhMjU3NGNlOWJjLi5mMzFlYWUyOTMxZjMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2liLmMKPj4+IEBAIC0yMjYsNyArMjI2LDggQEAgaW50IGFtZGdw
dV9pYl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIAo+Pj4gdW5zaWduZWQgbnVt
X2licywKPj4+IMKgwqDCoMKgwqAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkKPj4+
IMKgICNlbmRpZgo+Pj4gwqDCoMKgwqDCoCB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJpbmct
PmZ1bmNzLT5lbWl0X2hkcF9mbHVzaCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZnVu
Y3MtPmVtaXRfaGRwX2ZsdXNoICYmCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhYWRldi0+
aGRwLm5vX2ZsdXNoKQo+Pgo+PiBUaGlzIHN0aWxsIGVtaXRzIHRoZSBmbHVzaCB0aHJvdWdoIE1N
SU8uCj4KPiBBcyBtYXR0ZXIgb2YgZmFjdCwgaXQgZG9lc24ndCwgYmVjYXVzZSBhbWRncHVfYXNp
Y19mbHVzaF9oZHAgd2lsbCAKPiBjaGVjayB0aGUgZmxhZyBhZ2FpbiBpbiBoZHBfdjRfMC5jLiBJ
IGV2ZW4gdGhpbmsgdGhlIGNoZWNrIGhlcmUgaXMgCj4gdW5uZWNlc3NhcnkgZm9yIHByZXZpb3Vz
IGFzaWMsIGJlY2F1c2UgYXNpYyBvdGhlciB0aGFuIEFsZGViZXJhbiBBK0EgCj4gaGFzIHRvIGZs
dXNoIHRsYnMgYWNjb3JkaW5nIHRvIGhhcmR3YXJlIHNwZWNpZmljLgoKQW5kIGV4YWN0bHkgdGhh
dCBpcyB3aGF0IEknbSB0cnlpbmcgdG8gZXhwbGFpbiBoZXJlLgoKU2tpcHBpbmcgSERQIGZsdXNo
aW5nIGlzIHNvbWV0aGluZyB3ZSBkbyBmb3IgQVBVcyBmb3Igb3ZlciAxMCB5ZWFycyBub3csIAp0
aGF0IGlzIHByZXR0eSBjb21tb24gb24gb3RoZXIgQVNJQ3MgYW5kIG5vdCBBbGRlYmVyYW4gc3Bl
Y2lmaWMgYXQgYWxsLgoKQWxkZWJlcmFuIGlzIGp1c3QgdGhlIGZpcnN0IGRHUFUgd2Ugc2tpcCB0
aGlzIGZsdXNoaW5nIGJlY2F1c2UgaXQgaGFzIGFuIApYR01JIGNvbm5lY3Rpb24gdG8gdGhlIENQ
VS4KCj4+Cj4+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8gaW5pdGlhbGl6ZSB0aGUgaGRwLm5v
X2ZsdXNoIGZpZWxkIGZvciBhbGwgCj4+IGFzaWNzIGFuZCBhcmNoaXRlY3R1cmVzIGFuZCB0aGVu
IHVzZSB0aGF0IGhlcmUgaW4gdGhlIGlmIGFib3ZlIHRoaXMgb25lLgo+Cj4gSSBkb24ndCB1bmRl
cnN0YW5kIHdoeSBpdCBzaG91bGQgYmUgZm9yIGFsbCBhc2ljcy4gQ3VycmVudGx5IG9ubHkgCj4g
QWxkZWJlcmFuIEErQSBuZWVkIG5vIFRMQiBmbHVzaCwgd2UgZG9uJ3QgaGF2ZSB0byBjb25zaWRl
ciBvdGhlciAKPiBhc2ljcy4gQW5kIGhkcC5ub19mbHVzaCBpcyBhIGNvbW1vbiBmbGFnIGZvciBh
bGwgYXNpY3MsIElzIHRoZXJlIGFuIAo+IGlzc3VlIGluIG90aGVyIGFzaWNzIGZvciB0aGlzIGZs
YWcgb24gdGxiIGZsdXNoPwoKU2VlIHRoZSBjb2RlIGluIHRoZSBJQiBoYW5kbGluZyBhcyB3ZWxs
LiBXaGF0IHlvdSBzaG91bGQgZG8gaXMgdG8gCmdlbmVyYWxpemUgdGhpcyBjb2RlIGFuZCBub3Qg
cmUtaW52ZW50IHRoZSB3aGVlbCBzcGVjaWZpYyBmb3IgQWxkZWJlcmFuLgoKSW4gb3RoZXIgd29y
ZHMgbW9kaWZ5IG9yIGV4dGVuZCB0aGUgZXhpc3RpbmcgY29kZSB3aGljaCBza2lwcyBIRFAgCmZs
dXNoaW5nL2ludmFsaWRhdGlvbi4KCkNsZWFuaW5nIHRoYXQgdXAgYnkgcHV0dGluZyB0aGUgbm9f
Zmx1c2ggaW50byB0aGUgaGRwIHN0cnVjdHVyZSBzb3VuZHMgCmxpa2UgYSBnb29kIHN0YXJ0IHRv
IG1lLgoKPj4KPj4+IGFtZGdwdV9yaW5nX2VtaXRfaGRwX2ZsdXNoKHJpbmcpOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGVsc2UKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9h
c2ljX2ZsdXNoX2hkcChhZGV2LCByaW5nKTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCj4+PiBpbmRleCAyNzQ5NjIxZDVmNjMuLjZlMWVhYjYxNTkxNCAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+IEBAIC0xMjIzLDYgKzEy
MjMsNyBAQCBzdGF0aWMgaW50IGdtY192OV8wX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPmdtYy54Z21pLnN1cHBvcnRlZCA9IHRydWU7Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSA9Cj4+PiBh
ZGV2LT5zbXVpby5mdW5jcy0+aXNfaG9zdF9ncHVfeGdtaV9zdXBwb3J0ZWQoYWRldik7Cj4+PiAr
wqDCoMKgwqDCoMKgwqAgYWRldi0+aGRwLm5vX2ZsdXNoID0gYWRldi0+Z21jLnhnbWkuY29ubmVj
dGVkX3RvX2NwdTsKPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqAgwqDCoMKgwqDCoCBnbWNfdjlfMF9z
ZXRfZ21jX2Z1bmNzKGFkZXYpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2hkcF92NF8wLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92
NF8wLmMKPj4+IGluZGV4IDc0YjkwY2MyYmY0OC4uZTFiMmZhY2U4NjU2IDEwMDY0NAo+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaGRwX3Y0XzAuYwo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvaGRwX3Y0XzAuYwo+Pj4gQEAgLTQwLDYgKzQwLDkgQEAKPj4+
IMKgIHN0YXRpYyB2b2lkIGhkcF92NF8wX2ZsdXNoX2hkcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQo+Pj4gwqAgewo+Pj4gK8KgwqDCoCBpZiAoYWRldi0+aGRwLm5vX2ZsdXNo
KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+ICsKPj4KPj4gSnVzdCB0byBiZSBjbGVh
ciBvbmNlIG1vcmUsIHRoaXMgYXBwcm9hY2ggaXMgYSBOQUsuCj4+Cj4+IENoZWNrcyBsaWtlIHRo
aXMgc2hvdWxkIG5vdCBiZSBpbiB0aGUgaGFyZHdhcmUgc3BlY2lmaWMgZnVuY3Rpb24uCj4KPiBB
cyBJIG1lbnRpb24gYWJvdmUsIFRMQiBmbHVzaCBzaG91bGQgYmUgc3BlY2lmaWMgZm9yIEFzaWMg
Zm9yIG15IG9waW5pb24uCgpObywgdGhhdCBpcyBjZXJ0YWlubHkgd3JvbmcuIFRoaXMgaXMgYnR3
IG5vdCByZWxhdGVkIHRvIHRoZSBUTEIgaW4gYW55IAp3YXksIHRoZSBIRFAgaXMgcGFydCBvZiB0
aGUgUENJZSBidXMgaW50ZXJmYWNlLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMs
Cj4gRXJpYwo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+PiDCoMKgwqDCoMKgIGlm
ICghcmluZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBXUkVHMzJfTk9fS0lRKChhZGV2LT5ybW1pb19yZW1hcC5yZWdfb2Zmc2V0ICsgCj4+PiBLRkRf
TU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIsIDApOwo+Pj4gwqDCoMKgwqDCoCBl
bHNlCj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
