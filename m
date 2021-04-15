Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC1C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 07:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3454361103
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 07:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3454361103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8B46E9EA;
	Thu, 15 Apr 2021 07:11:34 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048616E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 07:11:33 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id s7so22093303wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=vI6PDo4FLx9qBbbGoBw5JJ+d3hJfLVaG3Hxl8spI1yU=;
 b=g64U/t5QMMtWtHMbgB/u6eMK6Q6/T0f2g+gS5tqK3rjq9VhTlPXpZm25JQvQlBKyMz
 X/ZHFCZqlpqnKg2uECV2qRkw9rJrKw6e/B7jaNGlCSPmh1iwFPVMV0fVtjIZraJ+0tWE
 tgxGRN7Ho15E3gRR4tirDBALugMlQEvrRw2oPhT1DVAV/3NRvwJUZVqsLiycnx6O4o49
 5uyS2RmCqixJ4H562Pjn/fUaAp+QJcd5b9UxdiOOQMzWFtvSwh1X23KhzPe3SVFEcxB3
 TQC6Z+jSxCaRtNDpLbbko9HqPgRI8F9hDnwGHL6j570SnhslNZZ0KrrNGJmZwmOAiqMd
 ouvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vI6PDo4FLx9qBbbGoBw5JJ+d3hJfLVaG3Hxl8spI1yU=;
 b=aYloHY1+NFM3nnAYJDuELZhYx5zwyzUNJuLaURDhRU0Bm0x/R9Z6Plj9cajTYiKOkY
 RV2H/61o+0ESLx/8dGuyfJcgKWSIC2QZnOM6kPRWQvuDofw1hGrAIqsnK1M+bvls2raP
 V5A5p1JoIviRodNSe2JDxfvT079m6MD4rIRMp4YgZyrmJocZy2QbOonI7/IqxU2GcgnG
 Y8vFLYZG1jXf6K0YxS7RHZag7KJnf/mlqwQ58H7e/T3pVtDIbgEtCzpV3AxnCNzpocvg
 d7dNFvsM7vNlHrZ6f9l41MPl1tHc9YcACCogsNGN6YHmHNBjet0zPs/LxctCCLB3ChrW
 lELA==
X-Gm-Message-State: AOAM532owDmYsRdZ9UjC/SWQ8IirznBUoQ6kUJUbzXLfW8cUuG6sYZ76
 A+3UfxwwXCWoDDXsxR+NwYUh9AXhg4c=
X-Google-Smtp-Source: ABdhPJzaIryMHKfJF8lY71YcTkEDq1lHk03OX/E1D8DHUJwPELceUSW6mD5YIy0N+l5tdrufS6DudA==
X-Received: by 2002:a17:906:4bce:: with SMTP id
 x14mr1817472ejv.383.1618470169812; 
 Thu, 15 Apr 2021 00:02:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4ce1:cb0:6e15:a3ac?
 ([2a02:908:1252:fb60:4ce1:cb0:6e15:a3ac])
 by smtp.gmail.com with ESMTPSA id m5sm1560369edi.52.2021.04.15.00.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 00:02:49 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
 <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
 <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
 <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
 <bb13794d-1067-6b91-c2dc-138118c3ef0d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cd66c76d-5678-f495-75a8-b8c4f6458353@gmail.com>
Date: Thu, 15 Apr 2021 09:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bb13794d-1067-6b91-c2dc-138118c3ef0d@amd.com>
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

QW0gMTUuMDQuMjEgdW0gMDg6Mjcgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMTQgMTA6NTggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTQuMDQu
MjEgdW0gMTY6MzYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+IMKgW1NOSVBdCj4+Pj4+
Pgo+Pj4+Pj4gV2UgYXJlIHJhY2luZyBoZXJlIG9uY2UgbW9yZSBhbmQgbmVlZCB0byBoYW5kbGUg
dGhhdC4KPj4+Pj4KPj4+Pj4KPj4+Pj4gQnV0IHdoeSwgSSB3cm90ZSBhYm92ZSB0aGF0IHdlIGZp
cnN0IHN0b3AgdGhlIGFsbCBzY2hlZHVsZXJzLCB0aGVuIAo+Pj4+PiBvbmx5IGNhbGwgZHJtX3Nj
aGVkX2VudGl0eV9raWxsX2pvYnMuCj4+Pj4KPj4+PiBUaGUgc2NoZWR1bGVycyBjb25zdW1pbmcg
am9icyBpcyBub3QgdGhlIHByb2JsZW0sIHdlIGFscmVhZHkgaGFuZGxlIAo+Pj4+IHRoYXQgY29y
cmVjdC4KPj4+Pgo+Pj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGVudGl0aWVzIG1pZ2h0IGNv
bnRpbnVlIGZlZWRpbmcgc3R1ZmYgaW50byAKPj4+PiB0aGUgc2NoZWR1bGVyLgo+Pj4KPj4+Cj4+
PiBNaXNzZWQgdGhhdC7CoCBPaywgY2FuIEkganVzdCB1c2Ugbm9uIHNsZWVwaW5nIFJDVSB3aXRo
IGEgZmxhZyBhcm91bmQgCj4+PiBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iIGF0IHRoZSBhbWRn
cHUgbGV2ZWwgKG9ubHkgMiBmdW5jdGlvbnMgY2FsbCAKPj4+IGl0IC0gYW1kZ3B1X2NzX3N1Ym1p
dCBhbmQgYW1kZ3B1X2pvYl9zdWJtaXQpIGFzIGEgcHJlbGltaW5hcnkgc3RlcCAKPj4+IHRvIGZs
dXNoIGFuZCBibG9jayBpbiBmbGlnaHQgYW5kIGZ1dHVyZSBzdWJtaXNzaW9ucyB0byBlbnRpdHkg
cXVldWUgPwo+Pgo+PiBEb3VibGUgY2hlY2tpbmcgdGhlIGNvZGUgSSB0aGluayB3ZSBjYW4gdXNl
IHRoZSBub3RpZmllcl9sb2NrIGZvciB0aGlzLgo+Pgo+PiBFLmcuIGluIGFtZGdwdV9jcy5jIHNl
ZSB3aGVyZSB3ZSBoYXZlIHRoZSBnb3RvIGVycm9yX2Fib3J0Lgo+Pgo+PiBUaGF0IGlzIHRoZSBw
bGFjZSB3aGVyZSBzdWNoIGEgY2hlY2sgY291bGQgYmUgYWRkZWQgd2l0aG91dCBhbnkgCj4+IGFk
ZGl0aW9uYWwgb3ZlcmhlYWQuCj4KPgo+IFN1cmUsIEkgd2lsbCBqdXN0IGhhdmUgdG8gYWRkIHRo
aXMgbG9jayB0byBhbWRncHVfam9iX3N1Ym1pdCB0b28uCgpOb3QgaWRlYWwsIGJ1dCBJIHRoaW5r
IHRoYXQncyBmaW5lIHdpdGggbWUuIFlvdSBtaWdodCB3YW50IHRvIHJlbmFtZSB0aGUgCmxvY2sg
Zm9yIHRoaXMgdGhvdWdodC4KCj4KPj4gW1NOSVBdCj4+Pj4+Cj4+Pj4+IE1heWJlIGp1c3QgZW1w
aXJpY2FsbHkgLSBsZXQncyB0cnkgaXQgYW5kIHNlZSB1bmRlciBkaWZmZXJlbnQgdGVzdCAKPj4+
Pj4gc2NlbmFyaW9zIHdoYXQgYWN0dWFsbHkgaGFwcGVuc8KgID8KPj4+Pgo+Pj4+IE5vdCBhIGdv
b2QgaWRlYSBpbiBnZW5lcmFsLCB3ZSBoYXZlIHRoYXQgYXBwcm9hY2ggd2F5IHRvIG9mdGVuIGF0
IAo+Pj4+IEFNRCBhbmQgYXJlIHRoZW4gc3VycHJpc2VkIHRoYXQgZXZlcnl0aGluZyB3b3JrcyBp
biBRQSBidXQgZmFpbHMgaW4gCj4+Pj4gcHJvZHVjdGlvbi4KPj4+Pgo+Pj4+IEJ1dCBEYW5pZWwg
YWxyZWFkeSBub3RlZCBpbiBoaXMgcmVwbHkgdGhhdCB3YWl0aW5nIGZvciBhIGZlbmNlIAo+Pj4+
IHdoaWxlIGhvbGRpbmcgdGhlIFNSQ1UgaXMgZXhwZWN0ZWQgdG8gd29yay4KPj4+Pgo+Pj4+IFNv
IGxldCdzIHN0aWNrIHdpdGggdGhlIGFwcHJvYWNoIG9mIGhpZ2ggbGV2ZWwgbG9ja2luZyBmb3Ig
aG90cGx1Zy4KPj4+Cj4+Pgo+Pj4gVG8gbXkgdW5kZXJzdGFuZGluZyB0aGlzIGlzIHRydWUgZm9y
IG90aGVyIGRldmlzZXMsIG5vdCB0aGUgb25lIAo+Pj4gYmVpbmcgZXh0cmFjdGVkLCBmb3IgaGlt
IHlvdSBzdGlsbCBuZWVkIHRvIGRvIGFsbCB0aGUgSFcgZmVuY2UgCj4+PiBzaWduYWxsaW5nIGRh
bmNlIGJlY2F1c2UgdGhlIEhXIGlzIGdvbmUgYW5kIHdlIGJsb2NrIGFueSBURFJzICh3aGljaCAK
Pj4+IHdvbid0IGhlbHAgYW55d2F5KS4KPj4+Cj4+PiBBbmRyZXkKPgo+Cj4gRG8geW91IGFncmVl
IHRvIHRoZSBhYm92ZSA/CgpZZWFoLCBJIHRoaW5rIHRoYXQgaXMgY29ycmVjdC4KCkJ1dCBvbiB0
aGUgb3RoZXIgaGFuZCB3aGF0IERhbmllbCByZW1pbmRlZCBtZSBvZiBpcyB0aGF0IHRoZSBoYW5k
bGluZyAKbmVlZHMgdG8gYmUgY29uc2lzdGVudCBvdmVyIGRpZmZlcmVudCBkZXZpY2VzLiBBbmQg
c2luY2Ugc29tZSBkZXZpY2UgCmFscmVhZHkgZ28gd2l0aCB0aGUgYXBwcm9hY2ggb2YgY2FuY2Vs
aW5nIGV2ZXJ5dGhpbmcgd2Ugc2ltcGx5IGhhdmUgdG8gCmdvIGRvd24gdGhhdCByb3V0ZSBhcyB3
ZWxsLgoKQ2hyaXN0aWFuLgoKPgo+IEFuZHJleQo+Cj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4gQ2hyaXN0
aWFuLgo+Pj4+Cj4+Pj4+Cj4+Pj4+IEFuZHJleQo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IENo
cmlzdGlhbi4KPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBSZWdhcmRzLAo+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBCVFc6IENvdWxkIGl0
IGJlIHRoYXQgdGhlIGRldmljZSBTUkNVIHByb3RlY3RzIG1vcmUgdGhhbiAKPj4+Pj4+Pj4+Pj4+
Pj4gb25lIGRldmljZSBhbmQgd2UgZGVhZGxvY2sgYmVjYXVzZSBvZiB0aGlzPwo+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBJIGhhdmVuJ3QgYWN0dWFsbHkgZXhwZXJp
ZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyBidXQsIAo+Pj4+Pj4+Pj4+Pj4+IHllcywgZHJt
X3VucGx1Z19zcmN1IGlzIGRlZmluZWQgYXMgc3RhdGljIGluIGRybV9kcnYuYyBhbmQgCj4+Pj4+
Pj4+Pj4+Pj4gc28gaW4gdGhlIHByZXNlbmNlIG9mIG11bHRpcGxlIGRldmljZXMgZnJvbSBzYW1l
IG9yIAo+Pj4+Pj4+Pj4+Pj4+IGRpZmZlcmVudCBkcml2ZXJzIHdlIGluIGZhY3QgYXJlIGRlcGVu
ZGVudCBvbiBhbGwgdGhlaXIgCj4+Pj4+Pj4+Pj4+Pj4gY3JpdGljYWwgc2VjdGlvbnMgaSBndWVz
cy4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IFNoaXQsIHllYWggdGhl
IGRldmlsIGlzIGEgc3F1aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSAKPj4+Pj4+Pj4+Pj4+
IGFjdHVhbGx5IG5lZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBv
ZiAKPj4+Pj4+Pj4+Pj4+IHRoZSBpOTE1IGd1eXMuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4g
SUlSQyB3ZSBjb3VsZCBhY3R1YWxseSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4gYSBkb2NraW5n
IAo+Pj4+Pj4+Pj4+Pj4gc3RhdGlvbiB3aGljaCBuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJpdmVy
IG1pZ2h0IGRlcGVuZCBvbiAKPj4+Pj4+Pj4+Pj4+IHdhaXRpbmcgZm9yIHRoZSBpOTE1IGRyaXZl
ciBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBDYW4ndCB3ZSBw
cm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5wbHVnX3NyY3UgcGVyIAo+Pj4+Pj4+Pj4+PiBk
cm1fZGV2aWNlID8gSSBkb24ndCBzZWUgd2h5IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5kIG5vdCBw
ZXIgCj4+Pj4+Pj4+Pj4+IGRldmljZSB0aGluZy4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEknbSBy
ZWFsbHkgd29uZGVyaW5nIHRoZSBzYW1lIHRoaW5nIGZvciBxdWl0ZSBhIHdoaWxlIG5vdy4KPj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEFkZGluZyBEYW5pZWwgYXMgd2VsbCwgbWF5YmUgaGUga25vd3Mg
d2h5IHRoZSBkcm1fdW5wbHVnX3NyY3UgCj4+Pj4+Pj4+Pj4gaXMgZ2xvYmFsLgo+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gUmVnYXJkcywKPj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJl
eQo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgLyogUGFzdCB0aGlzIHBvaW50IG5v
IG1vcmUgZmVuY2UgYXJlIHN1Ym1pdHRlZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0byBIVyByaW5n
IGFuZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9yY2Ugc2lnbmFsIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+IG9uIGFsbCB0aGF0IGFyZSBjdXJyZW50bHkgdGhlcmUuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4gwqDCoMKgwqAgKiBBbnkgc3Vic2VxdWVudGx5IGNyZWF0ZWQgSFcgZmVuY2VzIHdpbGwgYmUg
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gcmV0dXJuZWQgc2lnbmFsZWQgd2l0aCBhbiBlcnJvciBjb2Rl
IHJpZ2h0IGF3YXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGZvcl9lYWNoX3JpbmcoYWRldikKPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGRybV9kZXZfdW5wbHVnKGRldik7Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1bGVycwo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+IMKgwqDCoCBjYW5jZWxfc3luYyhhbGwgdGltZXJzIGFuZCBxdWV1ZWQgd29ya3MpOwo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBod19maW5pCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKg
IHVubWFwX21taW8KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IH0KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
QW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2
ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+IHN0b3BwaW5nIGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGNvdWxkIHdvcmsgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IEkgZGlkbid0IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBuZWVkIHRvIHJldXNlIHRoZSBHUFUgcmVzZXQgcndfbG9jay4gSSByZWx5
IG9uIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0aGUgU1JDVSB1bnBsdWcgZmxhZyBmb3IgdW5w
bHVnLiBBbHNvLCBub3QgY2xlYXIgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHRvIG1lIHdoeSBh
cmUgd2UgZm9jdXNpbmcgb24gdGhlIHNjaGVkdWxlciAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
dGhyZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBzaG91bGQgYmUgY292ZXJlZCwgc28gYW55IGNvZGUgbGVhZGluZyB0byAK
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW1kZ3B1X2ZlbmNlX2VtaXQgbmVlZHMgdG8gYmUgdGFr
ZW4gaW50byBhY2NvdW50IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBzdWNoIGFzLCBkaXJlY3Qg
SUIgc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50LmMKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IFlvdSBuZWVkIHRvIHdvcmsgdG9nZXRoZXIgd2l0aCB0aGUg
cmVzZXQgbG9jayAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbnl3YXksIGNhdXNlIGEgaG90cGx1
ZyBjb3VsZCBydW4gYXQgdGhlIHNhbWUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gdGltZSBhcyBh
IHJlc2V0Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5IGluZGVlZCBub3cgSSBzZWUgbm93IHRo
YXQgSSBoYXZlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gdG8gdGFrZSByZXNldCB3cml0ZSBzaWRl
IGxvY2sgZHVyaW5nIEhXIGZlbmNlcyAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHNpZ25hbGxpbmcg
aW4gb3JkZXIgdG8gcHJvdGVjdCBhZ2FpbnN0IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2NoZWR1
bGVyL0hXIGZlbmNlcyBkZXRhY2htZW50IGFuZCByZWF0dGFjaG1lbnQgCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+PiBkdXJpbmcgc2NoZWR1bGVycyBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBnbyB3aXRo
IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4geW91ciBhcHByb2FjaCB0aGVuIGNhbGxpbmcgZHJtX2Rl
dl91bnBsdWcgYW5kIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2NvcGluZyBhbWRncHVfam9iX3Rp
bWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBzaG91
bGQgYmUgZW5vdWdoIHRvIHByZXZlbnQgYW55IGNvbmN1cnJlbnQgR1BVIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gcmVzZXRzIGR1cmluZyB1bnBsdWcuIEluIGZhY3QgSSBhbHJlYWR5IGRvIGl0IAo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW55d2F5IC0gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHM6JTJG
JTJGY2dpdC5mcmVlZGVza3RvcC5vcmclMkZ+YWdyb2R6b3YlMkZsaW51eCUyRmNvbW1pdCUyRiUz
RmglM0Rkcm0tbWlzYy1uZXh0JTI2aWQlM0RlZjBlYTRkZDI5ZWY0NGQyNjQ5YzVlZGExNmM4ZjQ4
NjlhY2MzNmIxJmFtcDtkYXRhPTA0JTdDMDElN0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20l
N0NjN2ZjNmNiNTA1YzM0YWVkZmU2ZDA4ZDhmZTRiMzk0NyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1Mzg5NDYzMjQ4NTczNjklN0NVbmtub3duJTdDVFdG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9NjQzNjJQUkM4eFRnUjJVajJSMjU2
Yk1lZ1ZtOFlXcTFLSSUyQkFqemVZWHY0JTNEJmFtcDtyZXNlcnZlZD0wIAo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWWVzLCBn
b29kIHBvaW50IGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5k
cmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRy
ZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Cj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
