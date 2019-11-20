Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A65C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC2208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A5E6EA89;
	Wed, 20 Nov 2019 17:16:15 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8316EA89
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:16:13 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t1so773090wrv.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 09:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=aATVQTys3F7SIEteA15bwxr94EOytMbUuGHpoY4Z1oY=;
 b=tUx5+mJL8eMIy1BO6tGC4qwZ6LS304Me00/t8Mwxe3j4onwxGPyaq5KcZWBqkg/h9t
 Jve0A4rDzpHz+XgGw1RXUeTpWHgk8TVBJc91hjL2Y6TjZpfJFaIPhKJ9jwFK5Ntby869
 oW6BMK48JwkJlO/MmWeBuwfYl+KY7uYHryXnWWhkcxKZZzTHGACx5+qd9oFelHlFF3tn
 f1yLu9x150nO+czxYNfZ8YRLiIfYC8kNh4cEaWz3sJr0kZuFxp29wGEYOSgoHVNgRdRz
 a2rZi/Ndd7In9Aug8RaVOmQHXdN8BSJciUImq0N9IRPraYwlsSOKAypG40KR5GcYli9y
 Q1tQ==
X-Gm-Message-State: APjAAAXGYrzUxF8aiffhKHHfig7QbtT4a1ezTaia6nD9AXDZteb2jinN
 rUOPJYdAW7fj5fJIxWnr+p4=
X-Google-Smtp-Source: APXvYqyws+CDSqBM4A7VAotb4Ib3KoGX3xnrWlu+3nVOX+vxueNV8+8Xy6Z40Aad1Wk8W2ZqWDKE6w==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr5033657wrv.304.1574270171818; 
 Wed, 20 Nov 2019 09:16:11 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u13sm6956077wmm.45.2019.11.20.09.16.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 09:16:11 -0800 (PST)
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Luben Tuikov <luben.tuikov@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
Date: Wed, 20 Nov 2019 18:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aATVQTys3F7SIEteA15bwxr94EOytMbUuGHpoY4Z1oY=;
 b=WL54riASaEKs4bDIskQjxGSUw9Og2ms7kXHR68U+iJd7ojWfEA1K4IZea8UOaY6XJJ
 nqYrG4Jrk3jiY9dV7HETnolQTsNd65TPGfYv2kjS8+1jE8/mtS4Gj1lZ6Z3StYP1qP5/
 g0FaHwePsw03rvc+LvhhEnJYys8ce/4OuAMVBQcouyky4L2t3W2nOtTUF1D2bsNAH2zd
 7WGuaKElULnffzxPI2ku5mb6iXy/X5oPaW/qeDRPCD1qNChuMKBDu2pQERMjMJQBV8FT
 2Y40CinssBKvAT16jUl7R0sVsdSSsTUlxENL5RG5JnkDY7QCy/brbe365qgYxT/soV6F
 o63g==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120171609.DbV_BAmL4UUxdor9N1o6aTTqTlXR_idrx2QrspZSZsY@z>

QW0gMjAuMTEuMTkgdW0gMTc6NDkgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAxOS0xMS0x
OSAyMTo0MSwgTWFyZWsgT2zFocOhayB3cm90ZToKPj4gT24gVHVlLCBOb3YgMTksIDIwMTkgYXQg
ODo1MiBQTSBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tIDxtYWlsdG86bHViZW4u
dHVpa292QGFtZC5jb20+PiB3cm90ZToKPj4KPj4gICAgICBPbiAyMDE5LTExLTE0IDEwOjM0IHAu
bS4sIEFhcm9uIExpdSB3cm90ZToKPj4gICAgICA+IEZyb206IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+Cj4+ICAgICAgPgo+PiAgICAgID4g
VG8gYWxpZ24gdGhlIGtlcm5lbCB1YXBpIGNoYW5nZSBmcm9tIEFsZXg6Cj4+ICAgICAgPgo+PiAg
ICAgID4gIkFkZCBhIGZsYWcgdG8gdGhlIEdFTV9DUkVBVEUgaW9jdGwgdG8gY3JlYXRlIGVuY3J5
cHRlZCBidWZmZXJzLiBCdWZmZXJzIHdpdGgKPj4gICAgICA+IHRoaXMgZmxhZyBzZXQgd2lsbCBi
ZSBjcmVhdGVkIHdpdGggdGhlIFRNWiBiaXQgc2V0IGluIHRoZSBQVEVzIG9yIGVuZ2luZXMKPj4g
ICAgICA+IGFjY2Vzc2luZyB0aGVtLiBUaGlzIGlzIHJlcXVpcmVkIGluIG9yZGVyIHRvIHByb3Bl
cmx5IGFjY2VzcyB0aGUgZGF0YSBmcm9tIHRoZQo+PiAgICAgID4gZW5naW5lcy4iCj4+ICAgICAg
Pgo+PiAgICAgID4gV2Ugd2lsbCB1c2UgR0VNX0NSRUFURV9FTkNSWVBURUQgZmxhZyBmb3Igc2Vj
dXJlIGJ1ZmZlciBhbGxvY2F0aW9uLgo+PiAgICAgID4KPj4gICAgICA+IFNpZ25lZC1vZmYtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+
Cj4+ICAgICAgPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tIDxtYWlsdG86YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4+Cj4+ICAgICAgPiAtLS0K
Pj4gICAgICA+wqAgaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgNSArKysrKwo+PiAgICAgID7C
oCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4+ICAgICAgPgo+PiAgICAgID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9k
cm0uaAo+PiAgICAgID4gaW5kZXggNWMyOGFhNy4uMWE5NWUzNyAxMDA2NDQKPj4gICAgICA+IC0t
LSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+PiAgICAgID4gKysrIGIvaW5jbHVkZS9kcm0v
YW1kZ3B1X2RybS5oCj4+ICAgICAgPiBAQCAtMTQxLDYgKzE0MSwxMSBAQCBleHRlcm4gIkMiIHsK
Pj4gICAgICA+wqAgwqAqIHJlbGVhc2luZyB0aGUgbWVtb3J5Cj4+ICAgICAgPsKgIMKgKi8KPj4g
ICAgICA+wqAgI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRcKg
IMKgIMKgIMKgKDEgPDwgOSkKPj4gICAgICA+ICsvKiBGbGFnIHRoYXQgQk8gd2lsbCBiZSBlbmNy
eXB0ZWQgYW5kIHRoYXQgdGhlIFRNWiBiaXQgc2hvdWxkIGJlCj4+ICAgICAgPiArICogc2V0IGlu
IHRoZSBQVEVzIHdoZW4gbWFwcGluZyB0aGlzIGJ1ZmZlciB2aWEgR1BVVk0gb3IKPj4gICAgICA+
ICsgKiBhY2Nlc3NpbmcgaXQgd2l0aCB2YXJpb3VzIGh3IGJsb2Nrcwo+PiAgICAgID4gKyAqLwo+
PiAgICAgID4gKyNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEwqAgwqAgwqAgwqAg
wqAgKDEgPDwgMTApCj4+Cj4+ICAgICAgU3R5bGUhCj4+ICAgICAgVEFCIGNoYXI/IQo+Pgo+PiAg
ICAgIFlvdSBoYXZlIGEgVEFCIGNoYXIgYmV0d2VlbiAiLi5fRU5DUllQVEVEIiBhbmQgIigxIDw8
IDEwKSIKPj4gICAgICBEbyBOT1QgYWRkL2luc2VydCBUQUIgY2hhcnMgaW5zdGVhZCBvZiBzcGFj
ZSB0byBhbGlnbiBjb2x1bm1ucyEKPj4gICAgICBJZiB3aGVuIHlvdSBwcmVzcyBUYWIga2V5IGEg
dGFiIGlzIGluc2VydGVkLCBhcyBvcHBvc2VkIHRvIHRoZSBsaW5lCj4+ICAgICAgaW5kZW50ZWQs
IHRoZW4gRE8gTk9UIHVzZSB0aGlzIGVkaXRvci4KPj4gICAgICBUaGUgVGFiIGtleSBzaG91bGQg
ImluZGVudCBhY2NvcmRpbmcgdG8gbW9kZSIgYnkgaW5zZXJ0aW5nIFRBQiBjaGFycy4KPj4gICAg
ICBJZiB0aGUgbGluZSBpcyBhbHJlYWR5IGluZGVudGVkLCBhcyB0aGlzIG9uZSBpcywgdGhlbiBp
dCBzaG91bGQgZG8gbm90aGluZy4KPj4KPj4KPj4gSSBkaXNhZ3JlZSB3aXRoIHRoaXMgMTAwJS4g
VGFicyBvciBzcGFjZXMgZG9uJ3QgbWF0dGVyIGhlcmUgZnJvbSBteSBwZXJzcGVjdGl2ZS4gSSBh
bHNvIGRpc2FncmVlIHdpdGggeW91ciBsYW5ndWFnZS4gSXQncyBvdmVybHkgaW1wb2xpdGUuCj4g
QnV0IGl0J3MgdGhlIGNvZGluZyBzdHlsZSBvZiBMaW51eDogbGVhZGluZyB0YWJzIG9ubHkuIFRy
eSBpdCB3aXRoIEVtYWNzIGFzIGRlc2NyaWJlZCBhbmQgZ2l2ZW4gaW4KPgo+IGxpbnV4L0RvY3Vt
ZW50YXRpb24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0Cj4KPiBzdGFydGluZyBhdCBsaW5lIDU4
OS4gQW5kIHByZXNzIHRoZSBUYWIga2V5IG9uIGFuIGFscmVhZHkgaW5kZW50ZWQgbGluZS0tbm90
aGluZyB3aWxsIGhhcHBlbi4gTGludXggaGFzIHRyYWRpdGlvbmFsbHkKPiBzaHVubmVkIGZyb20g
bG9vc2UgVEFCIGNoYXJzIGluIGFscmVhZHkgaW5kZW50ZWQgbGluZXM6IGxlYWRpbmcgdGFicyBv
bmx5IG1vZGUuIEluIGEgcHJvcGVyIGNvZGUgZWRpdG9yCj4gcHJlc3NpbmcgdGhlIFRhYiBrZXkg
b25seSBpbmRlbnRzIGFjY29yZGluZyB0byBidWZmZXIgbW9kZSwgaXQgc2hvdWxkbid0IGluc2Vy
dCBhIFRhYiBjaGFyIHdpbGx5LW5pbGx5Lgo+IFBlb3BsZSBtYXkgc2V0IHRoZWlyIHRhYiBzdG9w
cyBkaWZmZXJlbnRseSBmb3IgZGlmZmVyZW50IHRhYiBwb3NpdGlvbnMgYW5kIGluc2VydGluZyBh
IHRhYiBjaGFyIG1heSBkaXNwbGF5Cj4gaW5jb3JyZWN0bHkuIFRoZSBtb3N0IHBvcnRhYmxlIHdh
eSB0byBhbGlnbiBjb2x1bW5zIGluIGFuIGFscmVhZHkgaW5kZW50ZWQtYWNjb3JkaW5nLXRvLW1v
ZGUgbGluZSwgaXMKPiB1c2luZyBzcGFjZXMuIChPZiBjb3Vyc2UgdGhpcyBkb2Vzbid0IG1hdHRl
ciB3aGVuIHVzaW5nIHNwYWNlcyB0byBpbmRlbnQsIGJ1dCBMaW51eCB1c2VzIGhhcmQgVEFCIGNo
YXJzCj4gdG8gaW5kZW50OiBsaW51eC9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxl
LnJzdC4gKHdoaWNoIGFsc28gc2VlbSB0byBiZSBzZXQgdG8gOCBjaGFycykpCj4KPiBJdCdzIGEg
Y29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5ndWFnZSIuCgpXZWxsIHRoZSBzZWN0aW9uIHlv
dSBub3RlZCBhbHNvIHN1Z2dlc3QgdG8gZWl0aGVyIGdldCByaWQgb2YgZW1hY3Mgb3IgCmNoYW5n
ZSBpdCB0byB1c2Ugc29tZSBzYW5lciBkZWZhdWx0IHZhbHVlcy4gV2UganVzdCBnb3QgcmlkIG9m
IGVtYWNzLgoKUmVnYXJkaW5nIHRhYnMgYWZ0ZXIgdGhlIGluaXRpYWwgaW5kZW50YXRpb24sIEkn
dmUganVzdCBkb25lIGEgcXVpY2sgCmdyZXAgYW5kIGFyb3VuZCAxNCUgb2YgYWxsIGRlZmluZXMg
dW5kZXIgaW5jbHVkZS8gdXNlcyB0aGF0IHNvIEkgd291bGQgCnNheSB0aGF0IHRoaXMgaXMgcGVy
ZmVjdGx5IGZpbmUuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBMdWJlbgo+
Cj4+IE1hcmVrCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
