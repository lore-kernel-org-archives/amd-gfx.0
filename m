Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7384CC4332B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139BA64DA5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139BA64DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E056E5B4;
	Mon,  1 Feb 2021 15:09:40 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663B6E5B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:09:40 +0000 (UTC)
Received: by mail-il1-x12b.google.com with SMTP id q9so15860154ilo.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gwja9zyXrMyyMhw1BT2FNjCMKDGVxPJq2vZzbZSckFg=;
 b=uFgxy8UyGWHr/OVFMZfBoCuXe/zrbDvy+L02IvHgXdJQziTGJwyyGkOnLL2pC1C1dC
 UDIO9avlyJEj4jYN4DXNsXj+KUc1nVqYJUdPLJgjN8eTnCeezwPb16cNdG0oHtIE5k8i
 fdkoVr5shjq01yQPp7bWz24bBFUFIdf0A2JfpM+6WZOJuHKh3jopZSEiM18WzsXCillL
 7jLlXzncREwjJSDTkDWM36WrcAURwj2s+z2iSZ5P060+cw69IASeiqEi+l73MIzRToPd
 ntkv7OCzno6wx5Rj15scKAgRQMWLhfbUTqZIYIXnmpj3h1Dk7SJxVRUC0a4SSmMc9oy+
 8Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gwja9zyXrMyyMhw1BT2FNjCMKDGVxPJq2vZzbZSckFg=;
 b=R2cZhLuoCe8Ypo2UWM+mkJgSdFcLi3UE3QUgAK61Lw/hFtcvHEwXs17Gxc/DOEw8Ca
 ROvWVzPjyzMzUV0IHHfg/rpZSCcNLp8tbyGJbvtHR34DjAFbQCX5wiwWLFoOGslHnOiP
 xTqnhEf/l4RQjnbsdRTDGXz1QbNshWAhV/HCFJP2CL1IsWH0M+q8zyeWJ0kif1SigMSk
 SoK1z70FZW3VyQB/I/u3gJzmlQKk0BwU5RM6djjrDq5quvRJw2tmIzRR295Lf/jTIrSB
 12OC3YKzcW67KoLLjrHj5oSOM0NpYhNVCfnL/TdGblQ9+gcfc5cLRU4NPqpYU8vD9LB7
 jSOA==
X-Gm-Message-State: AOAM531w5tDEL268v7ZI0DOQ7xDiiBIR0TL7G70SXTDe+pLzCRPWxH8W
 s1AbBtMHlhNecUgKsH8UUKBfK98JDNc=
X-Google-Smtp-Source: ABdhPJzkhfD3hS/hVmByMtAou+WOa3Szhsv6LyiwRAKqTguAZZ1FtpkFszeVdpfExeGAH+M75XIVAA==
X-Received: by 2002:a05:6e02:b25:: with SMTP id
 e5mr12820425ilu.37.1612192179251; 
 Mon, 01 Feb 2021 07:09:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l20sm8748744ioh.49.2021.02.01.07.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Feb 2021 07:09:38 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: enable freesync for A+A configs
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201143408.81475-1-christian.koenig@amd.com>
 <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7c3deeb7-8dfd-5a04-297f-292c4d1ded79@gmail.com>
Date: Mon, 1 Feb 2021 16:09:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDEuMDIuMjEgdW0gMTY6MDYgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gSGVsbG8gQ2hy
aXN0aWFuLAo+Cj4gT24gMDEvMDIvMjEgODowNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gU29tZSBuZXdlciBBUFVzIGNhbiBzY2Fub3V0IGRpcmVjdGx5IGZyb20gR1RULCB0aGF0IHNh
dmVzIHVzIGZyb20KPj4gYWxsb2NhdGluZyBhbm90aGVyIGJvdW5jZSBidWZmZXIgaW4gVlJBTSBh
bmQgZW5hYmxlcyBmcmVlc3luYyBpbiBzdWNoCj4+IGNvbmZpZ3VyYXRpb25zLgo+IFNoYWxsIHdl
IGFkZCBzb21lIG1vcmUgZGV0YWlscyBhYm91dCBob3cgdGhpcyBwYXRjaCBoZWxwcyB3aXRoIFZS
UiwgbGlrZSAiV2l0aG91dCB0aGlzIHBhdGNoLCBpdCB3b24ndCBiZSBwb3NzaWJsZSBmb3IgdGhl
IElHUFUgdG8gZmxpcCBidWZmZXJzIHdoaWNoIGFyZSBjb21wb3NlZCBvbiBhbiBleHRlcm5hbCBH
UFUiIG9yIHNvbWV0aGluZyBpbiB0aG9zZSBsaW5lcyA/CgpIb3cgYWJvdXQ6CgoiV2l0aG91dCB0
aGlzIHBhdGNoIGNyZWF0aW5nIGEgZnJhbWVidWZmZXIgZnJvbSB0aGUgaW1wb3J0ZWQgQk8gd2ls
bCAKZmFpbCBhbmQgdXNlcnNwYWNlIHdpbGwgZmFsbCBiYWNrIHRvIGEgY29weSIuCgpUaGFua3Ms
CkNocmlzdGlhbi4KCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rpc3BsYXkuYyB8IDggKysrKysrLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMgIHwgMiArLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKPj4gaW5kZXggYTYzODcwOWU5YzkyLi44MjNiYzI1ZDg3ZGUg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+
PiBAQCAtOTMwLDggKzkzMCwxMCBAQCBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2Ny
ZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+PiAgIAkJCQkgICAgICAgc3RydWN0IGRybV9m
aWxlICpmaWxlX3ByaXYsCj4+ICAgCQkJCSAgICAgICBjb25zdCBzdHJ1Y3QgZHJtX21vZGVfZmJf
Y21kMiAqbW9kZV9jbWQpCj4+ICAgewo+PiAtCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOwo+
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2ZyYW1lYnVmZmVyICphbWRncHVfZmI7Cj4+ICsJc3RydWN0IGRy
bV9nZW1fb2JqZWN0ICpvYmo7Cj4+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+ICsJdWludDMy
X3QgZG9tYWluczsKPj4gICAJaW50IHJldDsKPj4gICAKPj4gICAJb2JqID0gZHJtX2dlbV9vYmpl
Y3RfbG9va3VwKGZpbGVfcHJpdiwgbW9kZV9jbWQtPmhhbmRsZXNbMF0pOwo+PiBAQCAtOTQyLDcg
Kzk0NCw5IEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsCj4+ICAgCX0KPj4gICAKPj4gICAJLyogSGFuZGxlIGlzIGltcG9ydGVk
IGRtYS1idWYsIHNvIGNhbm5vdCBiZSBtaWdyYXRlZCB0byBWUkFNIGZvciBzY2Fub3V0ICovCj4+
IC0JaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgewo+PiArCWJvID0gZ2VtX3RvX2FtZGdwdV9ibyhv
YmopOwo+IElzIGl0IHBvc3NpYmxlIHRoYXQgdGhlIGJvIGNhbiBiZSBOVUxMID8gSSBtZWFuIGRv
IHdlIG5lZWQgYSBOVUxMIGNoZWNrIGhlcmUgPwo+PiArCWRvbWFpbnMgPSBhbWRncHVfZGlzcGxh
eV9zdXBwb3J0ZWRfZG9tYWlucyhkcm1fdG9fYWRldihkZXYpLCBiby0+ZmxhZ3MpOwo+PiArCWlm
IChvYmotPmltcG9ydF9hdHRhY2ggJiYgIShkb21haW5zICYgQU1ER1BVX0dFTV9ET01BSU5fR1RU
KSkgewo+PiAgIAkJZHJtX2RiZ19rbXMoZGV2LCAiQ2Fubm90IGNyZWF0ZSBmcmFtZWJ1ZmZlciBm
cm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOwo+PiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
Cj4+ICAgCX0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
PiBpbmRleCA1Njg1NGEzZWUxOWMuLjBiZDIyZWQxZGFjZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiBAQCAtOTAwLDcgKzkwMCw3IEBAIGlu
dCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21h
aW4sCj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPj4gICAKPj4gICAJLyogQSBzaGFyZWQgYm8gY2Fu
bm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gKi8KPj4gLQlpZiAoYm8tPnByaW1lX3NoYXJlZF9jb3Vu
dCkgewo+PiArCWlmIChiby0+cHJpbWVfc2hhcmVkX2NvdW50IHx8IGJvLT50Ym8uYmFzZS5pbXBv
cnRfYXR0YWNoKSB7Cj4gV2l0aCB0aGUgYWJvdmUgY29uY2VybnMgYWRkcmVzc2VkIChvciByZWFz
b25lZCA6KSksIHBsZWFzZSBmZWVsIGZyZWUgdG8gdXNlOgo+Cj4gUmV2aWV3ZWQtYnk6IFNoYXNo
YW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4KPiAtIFNoYXNoYW5rCj4KPj4g
ICAJCWlmIChkb21haW4gJiBBTURHUFVfR0VNX0RPTUFJTl9HVFQpCj4+ICAgCQkJZG9tYWluID0g
QU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+PiAgIAkJZWxzZQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
