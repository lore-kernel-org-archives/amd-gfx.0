Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0320C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C586109F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C586109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B026EC36;
	Tue, 18 May 2021 16:36:56 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BF36EC36
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 16:36:54 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id lg14so15568721ejb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=UzqW/neQbxbY98UYXd/lN+yPnD3t8F19D9pQYIqIHQ4=;
 b=i+seX2HSEuYvBuKw/65PfWMSbhRRNQKEmUBIK4+89XhIU3iqSNrVWLPTN2aWufifqT
 OKJ3NXtK6k0PK2IooAb/q5+VUo2bzKl5WmQCRzCAAzvpXFEat+QHkl29WOIu09xqrfB3
 sOmUm0fHKecwuvgr8SutX5RnlS+aAk7+o1kRLrkA+WiPpwYNOkjN24b63GIuV/K1epnB
 vu4Ss0cz5gExPShSZfr1wbMcvAjG07PXkIoZPdM/Kcr+biGwMy05QhI5EEE3TZYkDc8F
 vK90s0fhEz9XbgKpNGuKxljsCZLjSmDdGpFszh5RRMKXxWDjmpayqwfC+vDXEAFaiO9f
 2mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UzqW/neQbxbY98UYXd/lN+yPnD3t8F19D9pQYIqIHQ4=;
 b=IfaiFxuiCdO/8E0OjHA0ho7BsvZsBkJ02sr4ZJNjwmwtMjWlJS134UJkvyuXoTVDrs
 Jc3dyXJ5L2LVkXQvZqmJKk3kjNuedz1AxS6DWdL8fLN8uj4eRKux9bLTREQRQ9htbDt4
 ppq4A/QeBChmoxA13exGsN1mGHg4ULury01Rhi96u/yzKnmND1mO18Sd9WIyzQ7hiQLG
 YW9gki7YW6iVGZ6jhZhuCQNE8l7UHptT7WclBuA9Bv0F8aaegEgkzqNVFY/O18Dm9uXM
 vQ+COA7NAoXmKtmglejK1QpILU777jIhQ9rLF3Puk/KDp0SIcjxJ2GhCaYvpu53hjykF
 Valw==
X-Gm-Message-State: AOAM531WTnsNneTKmU537ligGKt3r1m3i1PZfY8DaNPTB8Sqki+x3rEh
 QyeGkEJgASW03To2/DFdFrcGeoTGtVA=
X-Google-Smtp-Source: ABdhPJx+4TJOPo4zSExyfrND39Xb0SZ7ra7rKPi951gf/8lfq2eP55XoY4E2zq0vrTmumjNUPeyZtQ==
X-Received: by 2002:a17:906:9e21:: with SMTP id
 fp33mr6974289ejc.488.1621355813533; 
 Tue, 18 May 2021 09:36:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:88c7:d7d9:22ef:f850?
 ([2a02:908:1252:fb60:88c7:d7d9:22ef:f850])
 by smtp.gmail.com with ESMTPSA id s26sm3299784edr.97.2021.05.18.09.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 09:36:52 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
 <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
 <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <efcc2430-836b-7fcd-71f9-b2ba45258177@gmail.com>
Date: Tue, 18 May 2021 18:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
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

QW0gMTguMDUuMjEgdW0gMTc6NTkgc2NocmllYiBKYW1lcyBaaHU6Cj4KPiBPbiAyMDIxLTA1LTE4
IDExOjU0IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Cj4+Cj4+IEFtIDE4LjA1LjIx
IHVtIDE3OjQ1IHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pj4KPj4+IE9uIDIwMjEtMDUtMTggMTE6MjMg
YS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAxOC4wNS4yMSB1bSAxNzoxMSBz
Y2hyaWViIEphbWVzIFpodToKPj4+Pj4gQWRkIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYyBiZWZv
cmUgc2V0IHBvd2VyIGdhdGluZyBzdGF0ZQo+Pj4+PiB0byBhdm9pZCByYWNlIGNvbmRpdGlvbiBp
c3N1ZSB3aGVuIHBvd2VyIGdhdGluZy4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMg
Wmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgfCAxOSArKysrKysrKysrKysrKysrKystCj4+Pj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4+Cj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIAo+
Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4+Pj4gaW5kZXgg
MGMxYmVlZi4uNmM1YzA4MyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YxXzAuYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjFfMC5jCj4+Pj4+IEBAIC0yMzAsMTAgKzIzMCwyNyBAQCBzdGF0aWMgaW50IHZjbl92MV8w
X2h3X2luaXQodm9pZCAqaGFuZGxlKQo+Pj4+PiDCoCBzdGF0aWMgaW50IHZjbl92MV8wX2h3X2Zp
bmkodm9pZCAqaGFuZGxlKQo+Pj4+PiDCoCB7Cj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4+Pj4+ICvC
oMKgwqAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOwo+Pj4+PiArwqDCoMKgIGludCBpOwo+Pj4+
PiArCj4+Pj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT52Y24uaW5zdC0+cmluZ19kZWM7Cj4+Pj4+
ICvCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+Pj4gKwo+Pj4+PiArwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytpKSB7Cj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCByaW5nID0gJmFkZXYtPnZjbi5pbnN0LT5yaW5nX2VuY1tpXTsKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4+ICvCoMKgwqAg
fQo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgcmluZyA9ICZhZGV2LT5qcGVnLmluc3QtPnJpbmdfZGVj
Owo+Pj4+PiArwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+Pj4KPj4+PiBUaGlu
a2luZyBtb3JlIGFib3V0IHRoYXQgdGhpcyBpcyBhIHJlYWxseSBiaWcgTkFLLiBUaGUgc2NoZWR1
bGVyIAo+Pj4+IHRocmVhZHMgbXVzdCB0byBzdGF5IHJlYWR5IGR1cmluZyBhIHJlc2V0Lgo+Pj4+
Cj4+Pj4gVGhpcyBpcyBjb250cm9sbGVkIGJ5IHRoZSB1cHBlciBsYXllciBhbmQgc2hvdWxkbid0
IGJlIG1lc3NlZCB3aXRoIAo+Pj4+IGluIHRoZSBoYXJkd2FyZSBzcGVjaWZpYyBiYWNrZW5kIGF0
IGFsbC4KPj4+Cj4+Pj4gW0paXSBJIHBvcnRlZCB0aGlzIGZyb20gY3VycmVudCB2Y24zIGh3X2Zp
bmkuIEp1c3Qgd2FudCB0byBtYWtlIAo+Pj4+IHN1cmUgdGhhdCBubyBtb3JlIG5ldyBqb2JzIHdp
bGwgYmUgc2NoZWR1bGVkIGFmdGVyIHN1c3BlbmQgcHJvY2VzcyAKPj4+PiBzdGFydHMuCj4+PiBJ
dCBtYXkgYSByZWR1bmRhbmN5LCBzaW5jZSBzY2hlZHVsZXIgbWF5YmUgYWxyZWFkeSBzdXNwZW5k
LiBJIGNhbiAKPj4+IHJlbW92ZSB0aG9zZSBpZiB5b3UgYXJlIHN1cmUgbm8gc2lkZSBlZmZlY3Qs
Cj4+Cj4+IFdlbGwsIHdlICptdXN0KiByZW1vdmUgdGhvc2UuIFRoaXMgZmxhZyBjb250cm9scyBp
ZiB0aGUgaGFyZHdhcmUgCj4+IGVuZ2luZSBjYW4gYmUgdXNlZCBmb3IgY29tbWFuZCBzdWJtaXNz
aW9uIGFuZCBpcyBvbmx5IGJlIHNldCB0byAKPj4gdHJ1ZS9mYWxzZSBkdXJpbmcgaW5pdGlhbCBk
cml2ZXIgbG9hZC4KPj4KPj4gSWYgeW91IGNoYW5nZSBpdCB0byBmYWxzZSBkdXJpbmcgaHdfZmlu
aSB0aGUgZW5naW5lIHdvbid0IHdvcmsgCj4+IGNvcnJlY3RseSBhbnkgbW9yZSBhZnRlciBHUFUg
cmVzZXQgb3IgcmVzdW1lLgo+IFtKWl0gSWYgSSByZWNhbGxlZCBjb3JyZWN0bHkgdGF0IGh3X2lu
aXQgd2lsbCBiZSBjYWxsZWQgZXZlcnkgdGltZSAKPiBhZnRlciBHUFUgcmVzZXQgb3Igc3VzcGVu
ZC9yZXN1bWUsCgpZZXMgdGhhdCdzIGNvcnJlY3QuCgpCdXQgYmVmb3JlIHRoYXQgYW5kIGR1cmlu
ZyBHUFUgcmVzZXQgdGhlIHJlYWR5IGZsYWcgaXMgdGhlbiBmYWxzZSBmb3IgYSAKc2hvcnQgcGVy
aW9kIG9mIHRpbWUgd2hpY2ggd291bGQgcmVzdWx0IGluIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMg
CmNyYXNoaW5nIHdoZW4gdGhleSB0cnkgdG8gc3VibWl0IHNvbWV0aGluZy4KClRoZSBmbGFnIGVz
c2VudGlhbGx5IHNheXMgdGhhdCB1c2Vyc3BhY2UgY2FuIHN1Ym1pdCBqb2JzIHRvIHRoZSAKc2No
ZWR1bGVyLiBQcm9jZXNzaW5nIG9mIHRob3NlIGpvYnMgaXMgb2YgY291cnNlIG9ubHkgc3RhcnRl
ZCBhZnRlciB0aGUgCmhhcmR3YXJlIGlzIHJlLWluaXRpYWxpemVkLCBidXQgcHVzaGluZyBqb2Jz
IGRvd24gdGhlIHBpcGUgaXMgc3RpbGwgCnBlcmZlY3RseSB2YWxpZCBpbiB0aGF0IHNpdHVhdGlv
bi4KCkNocmlzdGlhbi4KCj4+Cj4+IElmIHlvdSBoYXZlIGFueSBpZGVhIGhvdyB0byBkb2N1bWVu
dCB0aGF0IGZhY3QgdGhlbiBwbGVhc2Ugc3BlYWsgdXAsIAo+PiBjYXVzZSB3ZSBoYWQgdGhpcyBw
cm9ibGVtIGEgY291cGxlIG9mIHRpbWVzIG5vdy4KPj4KPj4gSnVzdCBzZW5kIG91dCBhIHBhdGNo
IGZpeGluZyB2YXJpb3VzIG90aGVyIG9jY2FzaW9ucyBvZiB0aGF0Lgo+Pgo+PiBSZWdhcmRzLAo+
PiBDaHJpc3RpYW4uCj4+Cj4+Pgo+Pj4+IEkndmUgcmVtb3ZlZCBhbGwgb2YgdGhvc2UgYSBjb3Vw
bGUgb2YgeWVhcnMgYWdvLgo+Pj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiBDaHJpc3RpYW4uCj4+Pj4K
Pj4+Pj4gKwo+Pj4+PiArIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVf
d29yayk7Cj4+Pj4+IMKgIMKgwqDCoMKgwqAgaWYgKChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19T
VVBQT1JUX1ZDTl9EUEcpIHx8Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBSUkVHMzJfU09DMTUoVkNO
LCAwLCBtbVVWRF9TVEFUVVMpKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKGFkZXYtPnZjbi5jdXJf
c3RhdGUgIT0gQU1EX1BHX1NUQVRFX0dBVEUgJiYKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgUlJF
RzMyX1NPQzE1KFZDTiwgMCwgbW1VVkRfU1RBVFVTKSkpIHsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHZjbl92MV8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FU
RSk7Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+PiDC
oCB9Cj4+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
