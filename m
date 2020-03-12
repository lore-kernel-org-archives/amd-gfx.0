Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E3CC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA45B20578
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Q/eM5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA45B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E70C891B9;
	Thu, 12 Mar 2020 08:50:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24715891B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 08:50:05 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 25so5120470wmk.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vXKwaQdkswyh0MjfRQhyHNfH380yE4rEng4TBhXMNTY=;
 b=O8Q/eM5PpowQ6BphL+cc8Uour4OG1ZKZIxp1PeAfdRBeAH0282clwWZ46fp0w6k7O3
 uuMwOqX7VWp/DeQRTgltGTYdNoanDu7JXG3UODo0k4afxkQTTXk+Z2qQyxPpBdXlC8+L
 e46Fd7ZFpiy2P1pUEYRlOcTOVbQ94CRfh4gjzj6STv/nAA4GMDaPihQcpl9+7qwAgcV1
 p6HRev8xZKTxXbf1KCI5Wq42YJH8FBnlWMnBxmbdMVYG2+6lI0LseQMTJs7wRhkKdKiM
 h2nLEktP9kWtywhO2Fvs90RPflGW9WA8Wrh+7vsJpEOIua2b1IX0EuuBvPYP0gVV2t7F
 ZttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=vXKwaQdkswyh0MjfRQhyHNfH380yE4rEng4TBhXMNTY=;
 b=f1Q0Vwr6HqgWIillfT4ClTAXaJleqHRCaw9pX7LGjolto8RqmZgIf/NqNCnylbJxjS
 KRov6OKs6s0X55Zdp6APo86kEJoM/ILKQC9l0q2OaC0Jpl93ic1xzjBp/eblkCMbLu+i
 KDHUevUDymqRDkGBAxKz1humvyBba4S1LtreWGBBdic7Tcv7lH+QeDskrUrtbyhAytHQ
 aLAPoGDBsRphCDA+UQ++qm1hgHoKrWipS/meH/ETvPtF5LKmcb7LYLZAcgvC+C1VepVq
 SKJjzN9m0/jXbJzqeL0AHYzLHwTPEjRj9o2S+stt8aBSRVKnoJYRGgVkjSX/8EaY0Tq6
 e2hw==
X-Gm-Message-State: ANhLgQ0HRRcxqt0q7p76uu4kXgc2cfOG77ZGkqbi60+7jgTBisB4wamQ
 FHF+3BB/OZvGTxmiQYbai7MhlDct
X-Google-Smtp-Source: ADFU+vuZyr96swihVNptcX1B0VsMJ/HeMPdhUlh6vmJTA1Hz2ATTHXxrslEVssVa+LQYyh3P7E443g==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr3599905wmb.141.1584003003708; 
 Thu, 12 Mar 2020 01:50:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id w15sm10309146wrm.9.2020.03.12.01.50.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Mar 2020 01:50:02 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: Nirmoy <nirmodas@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200311200032.50502-1-nirmoy.das@amd.com>
 <4fc782f4-8274-f69a-e4f8-8b087511a94d@amd.com>
 <745e7c4e-1dd7-ec7c-a787-88410414faab@amd.com>
 <4ee422df-5b57-ea1e-ae42-0ef702a657a8@amd.com>
 <ee63269d-8c95-cbb2-c64d-55a5061feb44@amd.com>
 <8b7ea4fd-01b3-72d8-8fa3-4745fe011fce@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f007d1af-08e8-eb20-1ef5-5d6f18e56273@gmail.com>
Date: Thu, 12 Mar 2020 09:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8b7ea4fd-01b3-72d8-8fa3-4745fe011fce@amd.com>
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDMuMjAgdW0gMjE6NTUgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAzLzExLzIwIDk6MzUg
UE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pgo+PiBPbiAzLzExLzIwIDQ6MzIgUE0sIE5p
cm1veSB3cm90ZToKPj4+Cj4+PiBPbiAzLzExLzIwIDk6MDIgUE0sIEFuZHJleSBHcm9kem92c2t5
IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMy8xMS8yMCA0OjAwIFBNLCBBbmRyZXkgR3JvZHpvdnNreSB3
cm90ZToKPj4+Pj4KPj4+Pj4gT24gMy8xMS8yMCA0OjAwIFBNLCBOaXJtb3kgRGFzIHdyb3RlOgo+
Pj4+Pj4gW1NOSVBdCj4+Pj4+PiBAQCAtMTI1Nyw2ICsxMjU4LDkgQEAgc3RhdGljIGludCBhbWRn
cHVfY3Nfc3VibWl0KHN0cnVjdCAKPj4+Pj4+IGFtZGdwdV9jc19wYXJzZXIgKnAsCj4+Pj4+PiDC
oMKgwqDCoMKgIHByaW9yaXR5ID0gam9iLT5iYXNlLnNfcHJpb3JpdHk7Cj4+Pj4+PiDCoMKgwqDC
oMKgIGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoJmpvYi0+YmFzZSwgZW50aXR5KTsKPj4+Pj4+
IMKgICvCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5ub19ncHVfc2NoZWRfbG9hZGJhbGFuY2UpCj4+
Pj4+PiArIGFtZGdwdV9jdHhfZGlzYWJsZV9ncHVfc2NoZWRfbG9hZF9iYWxhbmNlKGVudGl0eSk7
Cj4+Pj4+PiArCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFdoeSB0aGlzIG5lZWRzIHRvIGJlIGRvbmUgZWFj
aCB0aW1lIGEgam9iIGlzIHN1Ym1pdHRlZCBhbmQgbm90IAo+Pj4+PiBvbmNlIGluIGRybV9zY2hl
ZF9lbnRpdHlfaW5pdCAoc2FtZSBmb3JhbWRncHVfam9iX3N1Ym1pdCBiZWxsb3cgPykKPj4+Pj4K
Pj4+Pj4gQW5kcmV5Cj4+Pj4KPj4+Pgo+Pj4+IE15IGJhZCAtIG5vdCBpbiBkcm1fc2NoZWRfZW50
aXR5X2luaXQgYnV0IGluIHJlbGV2YW50IGFtZGdwdSBjb2RlLgo+Pj4KPj4+Cj4+PiBIaSBBbmRy
ZXksCj4+Pgo+Pj4gRG8geW91IG1lYW4gZHJtX3NjaGVkX2pvYl9pbml0KCkgb3IgYWZ0ZXIgY3Jl
YXRpbmcgVkNOIGVudGl0aWVzPwo+Pj4KPj4+Cj4+PiBOaXJtb3kKPj4KPj4KPj4gSSBndWVzcyBh
ZnRlciBjcmVhdGluZyB0aGUgVkNOIGVudGl0aWVzIChoYXMgdG8gYmUgYW1kZ3B1IHNwZWNpZmlj
IAo+PiBjb2RlKSAtIEkganVzdCBkb24ndCBnZXQgd2h5IGl0IG5lZWRzIHRvIGJlIGRvbmUgZWFj
aCB0aW1lIGpvYiBpcyAKPj4gc3VibWl0dGVkLCBJIG1lYW4gLSBzaW5jZSB5b3Ugc2V0IC5ub19n
cHVfc2NoZWRfbG9hZGJhbGFuY2UgPSB0cnVlIAo+PiBhbnl3YXkgdGhpcyBpcyBhbHdheXMgdHJ1
ZSBhbmQgc28gc2hvdWxkbid0IHlvdSBqdXN0IGluaXRpYWxpemUgdGhlIAo+PiBWQ04gZW50aXR5
IHdpdGggYSBzY2hlZHVsZXJzIGxpc3QgY29uc2lzdGluZyBvZiBvbmUgc2NoZWR1bGVyIGFuZCAK
Pj4gdGhhdCBpdCA/Cj4KPgo+IEFzc3VtcHRpb246IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkg
d2Ugc2hvdWxkbid0IGJlIGRvaW5nIGxvYWQgCj4gYmFsYW5jZSBhbW9uZyBWQ04gam9icyBpbiB0
aGUgc2FtZSBjb250ZXh0LiBDaHJpc3RpYW4sIEphbWVzIGFuZCBMZW8gCj4gY2FuIGNsYXJpZnkg
dGhhdCBpZiBJIGFtIHdyb25nLgo+Cj4gQnV0IHdlIGNhbiBzdGlsbCBkbyBsb2FkIGJhbGFuY2Ug
b2YgVk5DIGpvYnMgYW1vbmcgbXVsdGlwbGUgY29udGV4dHMuIAo+IFRoYXQgbG9hZCBiYWxhbmNl
IGRlY2lzaW9uIGhhcHBlbnMgaW4gZHJtX3NjaGVkX2VudGl0eV9pbml0KCkuIElmIHdlIAo+IGlu
aXRpYWxpemUgVkNOIGVudGl0eSB3aXRoIG9uZSBzY2hlZHVsZXIgdGhlbgo+Cj4gYWxsIGVudGl0
aWVzIGlycmVzcGVjdGl2ZSBvZiBjb250ZXh0IGdldHMgdGhhdCBvbmUgc2NoZWR1bGVyIHdoaWNo
IAo+IG1lYW5zIHdlIGFyZSBub3QgdXRpbGl6aW5nIGV4dHJhIFZOQyBpbnN0YW5jZXMuCgpBbmRy
ZXkgaGFzIGEgdmVyeSBnb29kIHBvaW50IGhlcmUuIFNvIGZhciB3ZSBvbmx5IGxvb2tlZCBhdCB0
aGlzIGZyb20gCnRoZSBoYXJkd2FyZSByZXF1aXJlbWVudCBzaWRlIHRoYXQgd2UgY2FuJ3QgY2hh
bmdlIHRoZSByaW5nIGFmdGVyIHRoZSAKZmlyc3Qgc3VibWlzc2lvbiBhbnkgbW9yZS4KCkJ1dCBp
dCBpcyBjZXJ0YWlubHkgdmFsdWFibGUgdG8ga2VlcCB0aGUgZXh0cmEgb3ZlcmhlYWQgb3V0IG9m
IHRoZSBob3QgCnBhdGggZHVyaW5nIGNvbW1hbmQgc3VibWlzc2lvbi4KCj4gSWRlYWxseSB3ZSBz
aG91bGQgYmUgY2FsbGluZyAKPiBhbWRncHVfY3R4X2Rpc2FibGVfZ3B1X3NjaGVkX2xvYWRfYmFs
YW5jZSgpIG9ubHkgb25jZSBhZnRlciAxc3QgY2FsbCAKPiBvZiBkcm1fc2NoZWRfZW50aXR5X2lu
aXQoKSBvZiBhIFZDTiBqb2IuIEkgYW0gbm90IHN1cmUgaG93IHRvIGRvIHRoYXQgCj4gZWZmaWNp
ZW50bHkuCj4KPiBBbm90aGVyIG9wdGlvbiBtaWdodCBiZSB0byBjb3B5IHRoZSBsb2dpYyBvZiAK
PiBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVlX3NjaGVkKCkgYW5kIGNob29zZSBzdWl0YWJsZSBW
TkMgc2NoZWQgCj4gYXQvYWZ0ZXIgVkNOIGVudGl0eSBjcmVhdGlvbi4KClllcywgYnV0IHdlIHNo
b3VsZCBub3QgY29weSB0aGUgbG9naWMgYnV0IHJhdGhlciByZWZhY3RvciBpdCA6KQoKQmFzaWNh
bGx5IHdlIG5lZWQgYSBkcm1fc2NoZWRfcGlja19iZXN0KCkgZnVuY3Rpb24gd2hpY2ggZ2V0cyBh
biBhcnJheSAKb2YgZHJtX2dwdV9zY2hlZHVsZXIgc3RydWN0dXJlcyBhbmQgcmV0dXJucyB0aGUg
b25lIHdpdGggdGhlIGxlYXN0IGxvYWQgCm9uIGl0LgoKVGhpcyBmdW5jdGlvbiBjYW4gdGhlbiBi
ZSB1c2VkIGJ5IFZDTiB0byBwaWNrIG9uZSBpbnN0YW5jZSBiZWZvcmUgCmluaXRpYWxpemluZyB0
aGUgZW50aXR5IGFzIHdlbGwgYXMgYSByZXBsYWNlbWVudCBmb3IgCmRybV9zY2hlZF9lbnRpdHlf
Z2V0X2ZyZWVfc2NoZWQoKSB0byBjaGFuZ2UgdGhlIHNjaGVkdWxlciBmb3IgbG9hZCAKYmFsYW5j
aW5nLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1veQo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
