Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A168C433EA
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 09:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D1B20684
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+0thnaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D1B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F316E2B4;
	Mon, 20 Jul 2020 09:25:19 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733CE6E2B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 09:25:18 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id 22so21550822wmg.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 02:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aP2PcmFp5opdfXctEnlFMMfQhzubUVkesSqaIHX4p3U=;
 b=R+0thnaD03+Uk1HXYNHrOsDDv5Ovv2xK9J/iwkLJdUdRuyK4m3YpJhtGqTVurLgBTP
 0EomOdHpyPDNqWFveHCdnCbO2mei6CTxeFsc7RoYCnCgxgudpUbBEvK9LRLVQc9LrlJz
 9HdY3mgtt/1DfuoSgQByvNAUQ6/BU6avWpHaS7MT8i8/DENv5M6OXQhbreHN2G/RqiES
 nY37HHsJpU/6/drYOaFWpE0owSvMt1YJGGeBj1zyYVHOOm3sdcaWvZIh/WtDgr2FJcz3
 gQxssW+qrfGEiaD5RNOCe5Udiu45fJclhKnGJ4IEgzfKMv0OM8Rt61C1yeAJbEBJsfjv
 0IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aP2PcmFp5opdfXctEnlFMMfQhzubUVkesSqaIHX4p3U=;
 b=gdlxQuZcr6KFpSwE4v/PrRsbYmIfzaEa+o5p65O5fOUD9tcAPkoIePZv6Xar/eNd+u
 Uc2BKEh13XJsiyltxbYR0bPI/4EUlmsytfNSuLBlL8sjV3nxYgRIEFo/z9RBtFpbjgyY
 V8fjJ5jHqiHs2Vm2lse8fbM9Q7FyTcqnLeU9aQjdRMWVMbMrDUsMxvG2GkblcERQVnYA
 3Na50A7aHd85hr7/v3lgk1n+2jBWSQd3LBoxCtoSqrT41BxMkSbEvZML69LVRJVoIvlv
 kM9I1UFcu7KWuPdBGR6dehHbZWEUYGIdEUg73OR8hgibH89YwP0jDk5jc3a0rNzgU82Z
 7wwQ==
X-Gm-Message-State: AOAM5320iRDu4QgKlCPjhf04L/Fr4UDTMyomektQcx5tJKo5PJ1YbdSp
 h+yHnM+4DtD7CupCSywvkCuNfrFm
X-Google-Smtp-Source: ABdhPJxh42qlYUODL1GLq+6M9lJPkbg6LPCat3Y9b6RKjf2qycoewRBbXIFwzSShtOqKxC/732Uleg==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr20164811wmj.71.1595237116797; 
 Mon, 20 Jul 2020 02:25:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 65sm37588648wre.6.2020.07.20.02.25.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2020 02:25:16 -0700 (PDT)
Subject: Re: Failed to find memory space for buffer eviction
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <9f1607ce-3f40-41f5-662f-501434625773@amd.com>
 <b9d9f58c-fdcb-1708-b19c-9da492e9d917@amd.com>
 <e70417e0-82ae-2f9c-87a7-6e28a23ed6a0@amd.com>
 <3ad7692a-905f-c2e9-c93e-7f407a05204d@gmail.com>
 <906ea9fe-4503-a764-3521-c781b6b0b658@amd.com>
 <3265311d-e68c-4153-6424-285db83f42e7@amd.com>
 <72f3b5f6-6003-40c7-79f4-ff0aadb313c5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b0136856-ea69-140b-ec11-041ebed59222@gmail.com>
Date: Mon, 20 Jul 2020 11:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <72f3b5f6-6003-40c7-79f4-ff0aadb313c5@amd.com>
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

QW0gMTYuMDcuMjAgdW0gMTk6MDUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA3
LTE2IHVtIDI6NTggYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDE1LjA3LjIw
IHVtIDE3OjE0IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBBbSAyMDIwLTA3LTE1IHVtIDU6
MjggYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+PiBbU05JUF0KPj4+Pj4+IFdoYXQg
Y291bGQgYmUgcHJvYmxlbWF0aWMgYW5kIHJlc3VsdCBpcyBhbiBvdmVycnVuIGlzIHRoYXQgVFRN
IHdhcwo+Pj4+Pj4gYnVnZ3kgYW5kIGNhbGxlZCBwdXRfbm9kZSB0d2ljZSBmb3IgdGhlIHNhbWUg
bWVtb3J5Lgo+Pj4+Pj4KPj4+Pj4+IFNvIEkndmUgc2VlbiB0aGF0IHRoZSBjb2RlIG5lZWRzIGZp
eGluZyBhcyB3ZWxsLCBidXQgSSdtIG5vdCAxMDAlCj4+Pj4+PiBzdXJlCj4+Pj4+PiBob3cgeW91
IHJhbiBpbnRvIHlvdXIgcHJvYmxlbS4KPj4+Pj4gVGhpcyBpcyBpbiB0aGUgS0ZEIGV2aWN0aW9u
IHRlc3QsIHdoaWNoIGRlbGliZXJhdGVseSBvdmVyY29tbWl0cwo+Pj4+PiBWUkFNIGluCj4+Pj4+
IG9yZGVyIHRvIHRyaWdnZXIgbG90cyBvZiBldmljdGlvbnMuIEl0IHdpbGwgdXNlIHNvbWUgR1RU
IHNwYWNlCj4+Pj4+IHdoaWxlIEJPcwo+Pj4+PiBhcmUgZXZpY3RlZC4gQnV0IHNob3VsZG4ndCBp
dCBtb3ZlIHRoZW0gZnVydGhlciBvdXQgb2YgR1RUIGFuZCBpbnRvCj4+Pj4+IFNZU1RFTSB0byBm
cmVlIHVwIEdUVCBzcGFjZT8KPj4+PiBZZXMsIGV4YWN0bHkgdGhhdCBzaG91bGQgaGFwcGVuLgo+
Pj4+Cj4+Pj4gQnV0IGZvciBzb21lIHJlYXNvbiBpdCBjb3VsZG4ndCBmaW5kIGEgY2FuZGlkYXRl
IHRvIGV2aWN0IGFuZCB0aGUKPj4+PiAxNDM3MSBwYWdlcyBsZWZ0IGFyZSBqdXN0IGEgYml0IHRv
IHNtYWxsIGZvciB0aGUgYnVmZmVyLgo+Pj4gVGhhdCB3b3VsZCBiZSBhIG5lc3RlZCBldmljdGlv
bi4gQSBWUkFNIHRvIEdUVCBldmljdGlvbiByZXF1aXJlcyBhIEdUVAo+Pj4gdG8gU1lTVEVNIGV2
aWN0aW9uIHRvIG1ha2Ugc3BhY2UgaW4gR1RULiBJcyB0aGF0IGV2ZW4gcG9zc2libGU/Cj4+IFll
cywgdGhpcyBpcyB0aGUgY29yZSBvZiB0aGUgVFRNIGRlc2lnbiBwcm9ibGVtIHdoaWNoIEkgdGFs
a2VkIGFib3V0Cj4+IGluIG15IEZPU0RFTSBwcmVzZW50YXRpb24gaW4gRmVicnVhcnkuCj4+Cj4+
IFF1ZXN0aW9uIGRvIHdlIHN0aWxsIGhhdmUgdGhpcyBjcnVkZSB3b3JrYXJvdW5kIHRoYXQgS0ZE
IGlzIG5vdCB0YWtpbmcKPj4gYWxsIHJlc2VydmF0aW9ucyBvZiB0aGUgY3VycmVudCBwcm9jZXNz
IHdoZW4gYWxsb2NhdGluZyBuZXcgQk9zPwo+IE5vdCBzdXJlIGlmIHlvdSdyZSByZWZlcnJpbmcg
dG8gdGhlIHdvcmthcm91bmRzIHdlIGhhZCB0byByZW1vdmUKPiBldmljdGlvbiBmZW5jZXMgZnJv
bSByZXNlcnZhdGlvbnMgdGVtcG9yYXJpbHkuIFRob3NlIGFyZSBhbGwgZ29uZS4gV2UncmUKPiBt
YWtpbmcgZnVsbCB1c2Ugb2YgdGhlIHN5bmMtb2JqZWN0IGZlbmNlIG93bmVyIGxvZ2ljIHRvIGF2
b2lkIHRyaWdnZXJpbmcKPiBldmljdGlvbiBmZW5jZXMgdW5pbnRlbnRpb25hbGx5LgoKSSB3YXMg
dGFsa2luZyBhYm91dCB0aGlzIGNoZWNrIGhlcmUgaW4gYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92
YWx1YWJsZSgpOgo+IMKgwqDCoMKgwqDCoMKgIC8qIElmIGJvIGlzIGEgS0ZEIEJPLCBjaGVjayBp
ZiB0aGUgYm8gYmVsb25ncyB0byB0aGUgY3VycmVudCAKPiBwcm9jZXNzLgo+IMKgwqDCoMKgwqDC
oMKgwqAgKiBJZiB0cnVlLCB0aGVuIHJldHVybiBmYWxzZSBhcyBhbnkgS0ZEIHByb2Nlc3MgbmVl
ZHMgYWxsIGl0cyAKPiBCT3MgdG8KPiDCoMKgwqDCoMKgwqDCoMKgICogYmUgcmVzaWRlbnQgdG8g
cnVuIHN1Y2Nlc3NmdWxseQo+IMKgwqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoCBm
bGlzdCA9IGRtYV9yZXN2X2dldF9saXN0KGJvLT5iYXNlLnJlc3YpOwo+IMKgwqDCoMKgwqDCoMKg
IGlmIChmbGlzdCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAw
OyBpIDwgZmxpc3QtPnNoYXJlZF9jb3VudDsgKytpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmID0gcmN1X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChm
bGlzdC0+c2hhcmVkW2ldLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9yZXN2X2hlbGQoYm8tPmJhc2UucmVzdikpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFtZGtm
ZF9mZW5jZV9jaGVja19tbShmLCBjdXJyZW50LT5tbSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqAgfQoKV2hh
dCBjYW4gaGFwcGVuIGlzIHRoYXQgdGhlIGFsbG9jYXRpbmcgcHJvY2VzcyBvd25zIHRvIG11Y2gg
b2YgR1RUIGFzIAp3ZWxsIGFuZCBhcyBhbiBlbmQgcmVzdWx0IHdlIGNhbid0IGV2aWN0IGFueXRo
aW5nIGZyb20gR1RUIHRvIGFsbG93IGZvciAKVlJBTSBldmljdGlvbiB0byBoYXBwZW4uCgo+IEkg
ZG9uJ3Qga25vdyB3aHkgd2Ugd291bGQgbmVlZCB0byB0YWtlIGFsbCByZXNlcnZhdGlvbnMgd2hl
biB3ZSBhbGxvY2F0ZQo+IGEgbmV3IEJPLiBJJ20gcHJvYmFibHkgbWlzdW5kZXJzdGFuZGluZyB5
b3UuCgpUYWtpbmcgYWxsIHJlc2VydmF0aW9ucyB3aGVuIHlvdSBjaGFuZ2UgdGhlIHNldCBvZiBC
T3MgYWxsb2NhdGVkIGluIGEgCndvcmtpbmcgY29udGV4dCBpcyBtYW5kYXRvcnkgZm9yIGNvcnJl
Y3Qgb3BlcmF0aW9uLgoKSSd2ZSBhbHJlYWR5IG5vdGVkIG11bHRpcGxlIHRpbWVzIHRoYXQgd29y
a2luZyBhcm91bmQgbGlrZSB3ZSBjdXJyZW50bHkgCmRvIGlzIGp1c3QgYSBoYWNrIGFuZCB3aGF0
IHlvdSBzZWUgaGVyZSBpcyBvbmUgb2YgdGhlIHN5bXB0b21zIG9mIHRoaXMuCgpSZWdhcmRzLApD
aHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4+IFRoYXQgY291bGQgbWF5
YmUgY2F1c2UgdGhpcyBhcyB3ZWxsLgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
