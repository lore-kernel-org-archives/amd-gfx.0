Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC3C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 16:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29032084D
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ism+GeGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29032084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFB16E22A;
	Sat, 11 Jan 2020 16:34:26 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D566E22A
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 16:34:24 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id w15so4597809wru.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HHMk6+0pYNZS/knbJ+8Gjb+yF9qN2AWd5yEZMj5Sp2Q=;
 b=ism+GeGmXjjWYNPox9/H3UHEXqZmqZtSEyZDvBLxk904GKw9e8/wy92oDdiJd3NjDw
 QuJCb2NfEZgDou2Nuf2VnHVXmzVIlmtnzHEXyGdhrmAyU9PU/Qr01Vnh5S24+O4T4SeM
 MWYPr75AbT2foz0wpzJgA3QpHebrKxwp9wni+fEiowSSDfeGsOEDaS4+gSo1ML9EKfyP
 4hOlXVPiJ7eYvJas5Ow2AnYx+El39vF9fETlMA0Utt2ZoCMvAtUGOaeb3zogI1IVQSFx
 cODT6usddYADOFA5o66XYamrykqoBqUbM9QEnQ0NRSgKnTIob59Cu7uxo5mxLJcnjhIN
 HA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=HHMk6+0pYNZS/knbJ+8Gjb+yF9qN2AWd5yEZMj5Sp2Q=;
 b=TINTc9MJJIOzuyRBCiKc0TD1FwD0gD2xdzE4Agv7jawpa7Ql84I+eeWzPcxtVRP0jt
 j0G/L2GyUarYMmezbarAUJk+LAC+xtAGzgOUSTJ8b4Gd6LC7rfMtHP5qidQDyEWHosXX
 xsHwQ/p7fTw13i58Uws/U/NDYhn7nNprBu1GFZZbgmEXRW7/FQGhLXddryyyiChtpdWQ
 v04K/+UZJX5B2ktmFcxQVQ9pCGLC7a2wb1A2TTW7aOOJ7KzETpZvGVFFpgyRFjU9AIpy
 7m25l18LbHZpelBCIL3oDmTC6SJRXH/qAjhPtlRbFMjB2d1CsuKnWDzZVC3OfG2A5RtG
 0/Nw==
X-Gm-Message-State: APjAAAXbKzZAM0RmZvYRtZ/dr8UxDoo8HMOfCP5mMWU7nYXMVquT4P5/
 qQWy98Mp9sSPPvQSWoCvBzt5/KhU
X-Google-Smtp-Source: APXvYqwzJf93L03ueFJwtXIrucOVk1vjkpg+Lodok9cgpT7dXT/5T2iqMatTm5IfO3jxiC8c2lSZiw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr9597255wrm.293.1578760463591; 
 Sat, 11 Jan 2020 08:34:23 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u1sm6886125wmc.5.2020.01.11.08.34.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 11 Jan 2020 08:34:23 -0800 (PST)
Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
To: Harry Wentland <hwentlan@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
 <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
 <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <3b143333-21a8-6075-ae85-026180eae286@amd.com>
 <ea175487-1c3c-c7f9-e3be-267e6d2c6566@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f7783fc7-aeaa-f582-2a8b-b6c497d4f512@gmail.com>
Date: Sat, 11 Jan 2020 17:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea175487-1c3c-c7f9-e3be-267e6d2c6566@amd.com>
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
 "Tsai, Martin" <Martin.Tsai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDEuMjAgdW0gMjI6MzAgc2NocmllYiBIYXJyeSBXZW50bGFuZDoKPiBPbiAyMDIwLTAx
LTEwIDQ6MTYgcC5tLiwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4+IE9uIDIwMjAtMDEtMTAgMTo0
NyBwLm0uLCBMaXUsIFpoYW4gd3JvdGU6Cj4+Pgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4+Pj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gT24gQmVoYWxmIE9mCj4+Pj4gQ2hyaXN0aWFuIEvDtm5pZwo+Pj4+IFNlbnQ6IDIwMjAv
SmFudWFyeS8xMCwgRnJpZGF5IDEwOjAyIEFNCj4+Pj4gVG86IFNpcXVlaXJhLCBSb2RyaWdvIDxS
b2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBhbWQtCj4+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+Pj4+IENjOiBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IENo
ZW5nLCBUb255Cj4+Pj4gPFRvbnkuQ2hlbmdAYW1kLmNvbT47IFRzYWksIE1hcnRpbiA8TWFydGlu
LlRzYWlAYW1kLmNvbT47IExha2hhLAo+Pj4+IEJoYXdhbnByZWV0IDxCaGF3YW5wcmVldC5MYWto
YUBhbWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5Cj4+Pj4gPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
Cj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAzOS80M10gZHJtL2FtZC9kaXNwbGF5OiBVc2UgdWRl
bGF5IHRvIGF2b2lkIGNvbnRleHQKPj4+PiBzd2l0Y2gKPj4+Pgo+Pj4+IEFtIDEwLjAxLjIwIHVt
IDE1OjQ2IHNjaHJpZWIgUm9kcmlnbyBTaXF1ZWlyYToKPj4+Pj4gRnJvbTogTWFydGluIFRzYWkg
PG1hcnRpbi50c2FpQGFtZC5jb20+Cj4+Pj4+Cj4+Pj4+IFt3aHldCj4+Pj4+IFRoZSByYXBpZCBt
c2xlZXAgb3BlcmF0aW9uIGNhdXNlcyB0aGUgd2hpdGUgbGluZSBnYXJiYWdlIHdoZW4gREFMCj4+
Pj4+IGNoZWNrIGZsaXAgcGVuZGluZyBzdGF0dXMgaW4gU2V0VmlkUG5Tb3VyY2VWaXNpYmlsaXR5
Lgo+Pj4+PiBUbyBleGVjdXRlIHRoaXMgbXNsZWVwIHdpbGwgaW5kdWNlIGNvbnRleHQgc3dpdGNo
LCBhbmQgbG9uZ2VyIGRlbGF5Cj4+Pj4+IGNvdWxkIGNhdXNlIHdvcnNlIGdhcmJhZ2Ugc2l0dWF0
aW9uLgo+Pj4+Pgo+Pj4+PiBbaG93XQo+Pj4+PiBUbyByZXBsYWNlIG1zbGVlcCB3aXRoIHVkZWxh
eS4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFRzYWkgPG1hcnRpbi50c2FpQGFt
ZC5jb20+Cj4+Pj4+IFJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+
Cj4+Pj4+IEFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Pj4+Pj4gQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNv
bT4KPj4+Pj4gLS0tCj4+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9od3NlcS5jIHwgNCArKy0tCj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCj4+Pj4+IGluZGV4
IDg5OTIwOTI0YTE1NC4uMGRjNjUyZTc2ODQ4IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4+PiBAQCAt
MTY0Miw5ICsxNjQyLDkgQEAgdm9pZCBkY24yMF9wcm9ncmFtX2Zyb250X2VuZF9mb3JfY3R4KAo+
Pj4+PiAgICAJCQlzdHJ1Y3QgaHVicCAqaHVicCA9IHBpcGUtPnBsYW5lX3Jlcy5odWJwOwo+Pj4+
PiAgICAJCQlpbnQgaiA9IDA7Cj4+Pj4+Cj4+Pj4+IC0JCQlmb3IgKGogPSAwOyBqIDwgVElNRU9V
VF9GT1JfUElQRV9FTkFCTEVfTVMKPj4+Pj4gKwkJCWZvciAoaiA9IDA7IGogPCBUSU1FT1VUX0ZP
Ul9QSVBFX0VOQUJMRV9NUyoxMDAwCj4+Pj4+ICAgIAkJCQkJJiYgaHVicC0+ZnVuY3MtCj4+Pj4+
IGh1YnBfaXNfZmxpcF9wZW5kaW5nKGh1YnApOyBqKyspCj4+Pj4+IC0JCQkJbXNsZWVwKDEpOwo+
Pj4+PiArCQkJCXVkZWxheSgxKTsKPj4+PiBXaHkgbm90IHVzaW5nIG1kZWxheSgpIGhlcmU/Cj4+
PiBBcyBmYXIgYXMgSSBrbm93LCBtZGVsYXkoKSBpcyBvbmx5IGRlZmluZWQgb24gTGludXggc2lk
ZS4KPj4+Cj4+PiBUaGlzIHBpZWNlIG9mIGNvZGUgaXMgc2hhcmVkIGJ5IGJvdGggTGludXggYW5k
IFdpbmRvd3MsIHNvIHdlIGhhdmUgdG8gdXNlIGEgZnVuY3Rpb24gdGhhdCdzIGF2YWlsYWJsZSBv
biBib3RoIHBsYXRmb3Jtcy4KPj4+Cj4+IEl0IHdhcyB1c2VkIGhlcmUgYmVmb3JlIHNvIHdlIGRl
ZmluaXRlbHkgaGF2ZSBpdCBkZWZpbmVkIGZvciBXaW5kb3dzIGFzCj4+IHdlbGwuCj4+Cj4gV2hv
b3BzLCBJIG1pc3JlYWQgdGhhdC4KPgo+IG1kZWxheSBpcyBpbmRlZWQgbm90IGRlZmluZWQgb24g
b3VyIG90aGVyIHBsYXRmb3JtcyBidXQgd2UgY291bGQgZ28KPiBhaGVhZCBhbmQgZGVmaW5lIGl0
IGlmIG5lZWRlZC4KClllcywgaW5kZWVkLiBBbmQgdG8gcmVwZWF0IG90aGVyIHBsYXRmb3JtcyBh
cmUgaXJyZWxldmFudCBmb3IgdXAgc3RyZWFtaW5nLgoKV2hlbiBjaGFuZ2luZyB0aGUgY29kZSBp
biBhIGNlcnRhaW4gd2F5IGZvciBMaW51eCBtYWtlcyBzZW5zZSB0aGVuIHdlIApoYXZlIGRvIHRv
IHRoaXMgYW5kIG5lZWQgdG8gYWRqdXN0IG90aGVyIHBsYXRmb3JtcyBhY2NvcmRpbmdseSBvciAK
bWFpbnRhaW4gdGhlIGRlbHRhIHNvbWVob3cuCgpDaHJpc3RpYW4uCgo+Cj4gSGFycnkKPgo+PiAg
RnJvbSB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIGl0IHNvdW5kcyBsaWtlIG1zbGVlcCB3YXNuJ3Qg
dGlnaHQgZW5vdWdoCj4+IGFuZCBsb25nZXIgZGVsYXlzIGxlYWQgdG8gaXNzdWVzIGhlcmUsIGF0
IGxlYXN0IG9uIFdpbmRvd3MuCj4+Cj4+IE1hcnRpbiwgVG9ueSwgZG8geW91IGhhdmUgbW9yZSBk
ZXRhaWxzIGFib3V0IHRoaXM/Cj4+Cj4+IFRoYW5rcywKPj4gSGFycnkKPj4KPj4+IFpoYW4KPj4+
Cj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+ICAgIAkJfQo+Pj4+PiAgICAJfQo+Pj4+Pgo+Pj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBt
YWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
