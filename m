Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61046C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCEE2073D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3kOfP1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCEE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36366ECAA;
	Fri,  6 Mar 2020 09:39:12 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95816ECAA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 09:39:11 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id u9so1605708wml.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Mar 2020 01:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=amdSP316P3gtMeVz99w62GBnvDWxW3S2V881kHfBMpA=;
 b=M3kOfP1KM7oRoJqDn+1hObgohlokW+2WPhL6jrOTizoUGO8C71cnmax4tTfG8O3EkY
 ezEoWZpzsbAPzfTKly/1w4kYtRRz6V6QnVNe/7zYws55zWtY8xomo62Y9IkyUY8KX6Fb
 Q+8olzhWGlaxHyRBkfh4NzdiueA8pqmPEJ3MghNBb+P6PN8X+brXx1rqXomZdXAWVEJv
 EXnjIxNVZttqRuvyfikxguBjIEw1DDz/XNQ+2bbWSMuj3+ZEByAVw/mVboQP4WSQ52E6
 cY22JfXabcSs5Rtvik5Xx69Abdfk3dzaE/3lS9qhQ2Ke6fLesHMHuqBDdD0wkEkMTiWq
 wbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=amdSP316P3gtMeVz99w62GBnvDWxW3S2V881kHfBMpA=;
 b=ADcaDjYfA2zilNq7f2EI3IN3IuyToVQ+GSTnDVTOpFxa5/JxK93iFuQac24jVo/cqV
 TPYVtrEDic/1zi1qhnsc8kQDzf9GdNT2MI9OsEGXQ374Of8x3kQ/UHUFAo5y/gsEpE82
 4IpIWYfkt9WWQ/v0DgW+HOze9/yLJ1rKh05adhcDGFz67Fve/JRxW6VVFnXMzVtLwNQ8
 LlDsu1XgXtPK80ueBoucNHsyTfIS7Wt8i6x9aHgBcOCrxawQL2auAI1PAx7Gg+tfDbBu
 8HLGSpWbOMI1y52JwK9GSexHJHR7ivu+UcZZjzVFf7eX8eebZKgTPs717tCYDIp/wQhk
 BOyA==
X-Gm-Message-State: ANhLgQ2gMBMI4y6bWoEuZbZfZgOPhPBvMa0fUETT05mUQzCSeqUfGMb6
 SjH9ChLlARbskNPQrYwqvHOzckZZ
X-Google-Smtp-Source: ADFU+vseDz8X4bKFAKcvbuZ4eKXs1wdV73MOqa1DcO43je2ZoDIchpiwbhJLAEgB1h18OtzMeuzFVQ==
X-Received: by 2002:a05:600c:410a:: with SMTP id
 j10mr3179796wmi.59.1583487550285; 
 Fri, 06 Mar 2020 01:39:10 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e7sm28483152wrt.70.2020.03.06.01.39.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:39:09 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/amdkfd: Signal eviction fence on process
 destruction (v2)
To: Felix Kuehling <felix.kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200304210637.27283-3-Felix.Kuehling@amd.com>
 <20200304215023.11551-1-Felix.Kuehling@amd.com>
 <72EFF772-7B30-4BCC-8DC5-E985100C31B8@amd.com>
 <53154a08-d2a0-3460-6ef6-b80a2226160b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4bf7ef97-cb4d-cc6d-e2fe-d41905198cb0@gmail.com>
Date: Fri, 6 Mar 2020 10:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <53154a08-d2a0-3460-6ef6-b80a2226160b@amd.com>
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVhaCwgdGhhdCBvbmUgbG9va3MgaW1wb3J0YW50LiBGZWVsIGZyZWUgdG8gYWRkIGFuIEFja2Vk
LWJ5OiBDaHJpc3RpYW4gCkvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCkFtIDA1LjAzLjIwIHVtIDE3OjA2IHNjaHJpZWIgRmVsaXggS3VlaGxp
bmc6Cj4gW21vdmluZyB0byBwdWJsaWMgbWFpbGluZyBsaXN0XQo+Cj4gVGhhbmsgeW91LiBJJ2xs
IGFsc28gYXBwbHkgcGF0Y2ggMi8yIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0LiBJdCdzIG5vdCAK
PiBmaXhpbmcgYSBtZW1vcnkgbGVhayB0aGVyZSwgYnV0IGl0IHNob3VsZCBtYWtlIGNsZWFudXAg
YWZ0ZXIgcHJvY2VzcyAKPiB0ZXJtaW5hdGlvbiBtb3JlIGVmZmljaWVudCBieSBhdm9pZGluZyBk
ZWxheWVkIGRlbGV0ZSBvZiBCT3MuCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPiBPbiAyMDIw
LTAzLTA0IDEwOjQ2IHAubS4sIFBhbiwgWGluaHVpIHdyb3RlOgo+PiBTZXJpZXMgaXMgUmV2aWV3
ZWQtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPj4KPj4+IDIwMjDlubQz5pyI
NeaXpSAwNTo1MO+8jEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4g5YaZ
6YGT77yaCj4+Pgo+Pj4gT3RoZXJ3aXNlIEJPcyBtYXkgd2FpdCBmb3IgdGhlIGZlbmNlIGluZGVm
aW5pdGVseSBhbmQgbmV2ZXIgYmUgCj4+PiBkZXN0cm95ZWQuCj4+Pgo+Pj4gdjI6IFNpZ25hbCB0
aGUgZmVuY2UgcmlnaHQgYWZ0ZXIgZGVzdHJveWluZyBxdWV1ZXMgdG8gYXZvaWQgdW5uZWNlc3Nh
cnkKPj4+IMKgwqDCoCBkZWxheWUtZGVsZXRlIGluIGtmZF9wcm9jZXNzX3dxX3JlbGVhc2UKPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4KPj4+IC0tLQo+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyB8
IDUgKysrKysKPj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyAKPj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+Pj4gaW5kZXggZDVkNDY2
MDIyMWFmLi4yNmY3ZjE3OGI2NmQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcHJvY2Vzcy5jCj4+PiBAQCAtNjI1LDYgKzYyNSwxMSBAQCBzdGF0aWMgdm9pZCBrZmRf
cHJvY2Vzc19ub3RpZmllcl9yZWxlYXNlKHN0cnVjdCAKPj4+IG1tdV9ub3RpZmllciAqbW4sCj4+
Pgo+Pj4gwqDCoMKgwqAvKiBJbmRpY2F0ZSB0byBvdGhlciB1c2VycyB0aGF0IE1NIGlzIG5vIGxv
bmdlciB2YWxpZCAqLwo+Pj4gwqDCoMKgwqBwLT5tbSA9IE5VTEw7Cj4+PiArwqDCoMKgIC8qIFNp
Z25hbCB0aGUgZXZpY3Rpb24gZmVuY2UgYWZ0ZXIgdXNlciBtb2RlIHF1ZXVlcyBhcmUKPj4+ICvC
oMKgwqDCoCAqIGRlc3Ryb3llZC4gVGhpcyBhbGxvd3MgYW55IEJPcyB0byBiZSBmcmVlZCB3aXRo
b3V0Cj4+PiArwqDCoMKgwqAgKiB0cmlnZ2VyaW5nIHBvaW50bGVzcyBldmljdGlvbnMgb3Igd2Fp
dGluZyBmb3IgZmVuY2VzLgo+Pj4gK8KgwqDCoMKgICovCj4+PiArwqDCoMKgIGRtYV9mZW5jZV9z
aWduYWwocC0+ZWYpOwo+Pj4KPj4+IMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZwLT5tdXRleCk7Cj4+
Pgo+Pj4gLS0gCj4+PiAyLjI1LjEKPj4+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
