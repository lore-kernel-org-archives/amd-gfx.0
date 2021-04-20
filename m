Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E3C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 07:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEC061027
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 07:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEC061027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022236E0F0;
	Tue, 20 Apr 2021 07:39:19 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FB86E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 07:39:17 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id j7so6913952eds.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aJ0c1jOrwACHgXtLBez9zy8Ghs4O87o2O48wWwLz5p4=;
 b=t02Ha5hycIgmQSGxApdrB/tOx3ajBCm5dixwDjVU42Q3sd6OYfQJmbNrnk05jQuTy5
 TQsNoGQjC40RBG1MMifwhi7TLw35Jcjwz/7E0lqRxpztd5pBLVazgSoWVARZ+qtSzoGq
 dJ4tLQzILFKYkCwHpSN7KjdDXmcDBzPEIIYQyGfrO+O5N5SAYXl3I5i+puH5guPVqaRT
 aRL0H+ADCjxhELyngjcWI2nkRsc9abDl+wOyTC1TiznSaLuiEB0pqpMS3cLhtIsRqETL
 GYS6OBTB/9TdIh/tyCPMTFMiQbsO+KZ47UDuQTuNbWqumu2X9S8yW14bDX8V7Rf0h9CA
 GkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aJ0c1jOrwACHgXtLBez9zy8Ghs4O87o2O48wWwLz5p4=;
 b=VJMWPBX1OjIBIND/m44tNxkKVlWcYY/FK/HaaNeEPikt02mPIOokfMXxaKk5UigfhI
 OAycmNzOXM1chJoWkJOb86R+VT4zMD8UdMon+VPwsu4sG8GVuYlaVe6wbon0Vid1P24j
 Qw5L6+cVFjVuBWHDhqZZdHKfUpDPEO+1xzmTHvSqdDVUqQs9rYPBW497cFIe/xBaVCjw
 SrBzPiZ5QutuG7zmGNDygjsv14k46xtZ8Wxlz44KWGI+QSLEl5BlU/RIBhon3xYmNA1u
 /x74lI2WN6tUVY/DHFgMM0bMXfDRHp+jo4TYCAiOqEhj007TUIL3Eqdn8aRKukn/Wsaz
 TTVg==
X-Gm-Message-State: AOAM533Pcjpw1i+EasALvsrisTE/XATlzpUUOPE6SQ7KK1FUHS+z9nNo
 rFXI7FdgrpYlvFFo47hvZPg=
X-Google-Smtp-Source: ABdhPJy2Zi7CGRjblWmZIZZkOqK1Jue3tEy79hyVuFs8dppeQd2kW6DnTToJDvR3ShcVhhFM5agszg==
X-Received: by 2002:aa7:c90e:: with SMTP id b14mr30434932edt.93.1618904356203; 
 Tue, 20 Apr 2021 00:39:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3caf:a441:2498:1468?
 ([2a02:908:1252:fb60:3caf:a441:2498:1468])
 by smtp.gmail.com with ESMTPSA id t14sm11850554ejj.77.2021.04.20.00.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 00:39:15 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Add mem sync flag for SDMA IB test
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210420022340.365464-1-Jinzhou.Su@amd.com>
 <a5be6441-625f-3605-0ed7-c2cec03c9a18@gmail.com>
 <DM6PR12MB28128F8024704AC7C877B55190489@DM6PR12MB2812.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f895db2e-a86e-abcc-582f-65e76e538fa5@gmail.com>
Date: Tue, 20 Apr 2021 09:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB28128F8024704AC7C877B55190489@DM6PR12MB2812.namprd12.prod.outlook.com>
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBzdWdnZXN0IHRvIHJhdGhlciBkbyB0aGlzIGluIGFtZGdwdV9pYl9nZXQoKSBpbnN0ZWFkLgoK
QXMgc29vbiBhcyB0aGUgc2l6ZSBpcyBzcGVjaWZpZWQgd2UgZ2V0IHNvbWUgbWVtb3J5IGZyb20g
dGhlIFNBIAphbGxvY2F0b3IgYW5kIHNob3VsZCBhbHNvIHNldCB0aGUgZmxhZyB0byBiZSBvbiB0
aGUgc2F2ZSBzaWRlLgoKVGhhbmtzLApDaHJpc3RpYW4uCgpBbSAyMC4wNC4yMSB1bSAwODo1NSBz
Y2hyaWViIFN1LCBKaW56aG91IChKb2UpOgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+IEhlbGxvIENocmlzdGlhbiwKPgo+IFRoYW5rcyBm
b3IgeW91ciBpbmZvcm1hdGlvbi4gV2UgYWRkIHRoaXMgZHVlIHRvIHNkbWEwIHRpbWVvdXQgZHVy
aW5nIFMzIHN0cmVzcyB0ZXN0Lgo+IFdpbGwgdXBkYXRlIHRoaXMgZm9yIG90aGVyIGNhc2VzIGlu
IHYyLgo+Cj4gUmVnYXJkcywKPiBKb2UKPgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4g
RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+
Cj4gU2VudDogVHVlc2RheSwgQXByaWwgMjAsIDIwMjEgMjozOSBQTQo+IFRvOiBTdSwgSmluemhv
dSAoSm9lKSA8SmluemhvdS5TdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBDYzogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+Cj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogQWRkIG1lbSBzeW5jIGZsYWcgZm9yIFNETUEgSUIgdGVzdAo+Cj4g
QW0gMjAuMDQuMjEgdW0gMDQ6MjMgc2NocmllYiBKaW56aG91IFN1Ogo+PiBUaGUgYnVmZmVyIGZv
ciBTRE1BIElCIHRlc3QgaXMgYWxsb2NhdGVkIGJ5IHNhIGJvIHdoaWNoIG1heSBiZSB1c2VkIGJ5
Cj4+IG90aGVyIHB1cnBvc2UuIEJldHRlciB0byBmbHVzaCB0aGUgY2FjaGUgYmVmb3JlIGNvbW1p
dCB0aGUgSUIuCj4gR29vZCBwb2ludCwgYnV0IHNob3VsZG4ndCB3ZSBkbyB0aGlzIGZvciBhIGxv
dCBvZiBvdGhlciBjYXNlcyBhcyB3ZWxsPwo+Cj4gSSB0aGluayB0aGUgb25seSBwbGFjZSB3aGVy
ZSB3ZSBzaG91bGQgbm90IHNldCB0aGUgZmxhZyBpcyBpbiB0aGUgQ1MgSU9DVEwuCj4KPiBSZWdh
cmRzLAo+IENocmlzdGlhbi4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBKaW56aG91IFN1IDxKaW56aG91
LlN1QGFtZC5jb20+Cj4+IC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y1XzIuYyB8IDEgKwo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMKPj4gaW5kZXggYjFhZDllNTJi
MjM0Li5kYTY3ZjQ0MGIxMDIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjVfMi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djVfMi5jCj4+IEBAIC0xMDAwLDYgKzEwMDAsNyBAQCBzdGF0aWMgaW50IHNkbWFfdjVfMl9yaW5n
X3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQpCj4+ICAgIAlp
Yi5wdHJbN10gPSBTRE1BX1BLVF9OT1BfSEVBREVSX09QKFNETUFfT1BfTk9QKTsKPj4gICAgCWli
Lmxlbmd0aF9kdyA9IDg7Cj4+ICAgIAo+PiArCWliLmZsYWdzID0gQU1ER1BVX0lCX0ZMQUdfRU1J
VF9NRU1fU1lOQzsKPj4gICAgCXIgPSBhbWRncHVfaWJfc2NoZWR1bGUocmluZywgMSwgJmliLCBO
VUxMLCAmZik7Cj4+ICAgIAlpZiAocikKPj4gICAgCQlnb3RvIGVycjE7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
