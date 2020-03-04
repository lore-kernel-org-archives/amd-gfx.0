Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C37C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A7120870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMiGRdb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A7120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD416E198;
	Wed,  4 Mar 2020 15:03:08 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2A16E198
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:03:07 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j16so2813455wrt.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 07:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=sRcXqfFNX+xxkCwcHfoD84CTr2cwPWGVqWwZBYsyqhc=;
 b=bMiGRdb91ss6sm7JLYBlZrMYKS4CiGrkUm4jgBg0ibhJSX4WYdzp2NlPQRrQ9g5FwE
 ptPONk+mTaiB4ai6GTLDWt16LEFu/Pqfr1BSkpqNJ3/UVyntim0nbKElgTbTBH0j1en9
 Py/Hc19D2Gh2cBE1KHOIO4bK0WvGnE4McaZORFYLRB1KdGkIGcm5zswejLRwbt3nJn23
 kndsQozD+zzw4tMBq6V37g+UsBgOKXNciAbYOlwE+ZnRbGMlgW9hekI1hMsBhNlrgQ+n
 drPNqODuL4iPnqYbhqCrDMh2WaeapoZC56ttp/y3S+w18krZp2/QPLHJC2RXwqHfW3sc
 9a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=sRcXqfFNX+xxkCwcHfoD84CTr2cwPWGVqWwZBYsyqhc=;
 b=FEbymg/isMlX0SeuZBJjv99cq39SBAvcQqSWEO7AYHXibWmwlqO2TgVOFJtWP4fMTe
 y+vFRuHLwk6hymotrvyq6vpMebnjsp+K7hroDbq3Ga29jLqhIpbcj+9gWDrsVQyt2DbR
 v8up0HFZP1dA+xGK9x4AE03Y8HTe3YSL7TM9TniHjyxb3iyd5/coa1uP+o0qEh1GPvRg
 XjltInaET2RZIsFGtpQ53OlFnCdbhf5eIyPoyLciDICWIZRqlAMZ1aomkn2UM0z4YJhh
 ArPKUp7WMyBr7Ki/TqL6eLzDeZ2Xbr2WrngD1xLmmUKw8mQ89ny3VGn11XsdQiygehko
 uaJw==
X-Gm-Message-State: ANhLgQ3bbnWE7YJoOzEUKPslFWbS7WKT74L+sWPrXJJ/JgfPHpS4JYnW
 xqnFdCDmiN7A55TyhxcWA1JEQPEu
X-Google-Smtp-Source: ADFU+vtoXUWINUwadq0uH9YZaBDd6+oilLWt7y+XeQReZ49hDfLE/tRXeOy3iGOLm+0RguRUOgoXvQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4290357wrn.88.1583334185661; 
 Wed, 04 Mar 2020 07:03:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t124sm5045895wmg.13.2020.03.04.07.03.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Mar 2020 07:03:04 -0800 (PST)
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: James Zhu <jamesz@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
 <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
 <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
 <11274ae4-da5e-5c7d-ba1a-877f22daea24@amd.com>
 <6294bcbb-e663-79e5-371b-28eb3a47dbfb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a9902a9e-09d1-abc0-05d0-885bb9ac4bb3@gmail.com>
Date: Wed, 4 Mar 2020 16:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6294bcbb-e663-79e5-371b-28eb3a47dbfb@amd.com>
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

QW0gMDQuMDMuMjAgdW0gMTU6NTcgc2NocmllYiBKYW1lcyBaaHU6Cj4KPiBPbiAyMDIwLTAzLTA0
IDM6NTMgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDMuMDMuMjAgdW0gMjM6
NDggc2NocmllYiBKYW1lcyBaaHU6Cj4+Pgo+Pj4gT24gMjAyMC0wMy0wMyAyOjAzIHAubS4sIEph
bWVzIFpodSB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIwMjAtMDMtMDMgMTo0NCBwLm0uLCBDaHJpc3Rp
YW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAwMy4wMy4yMCB1bSAxOToxNiBzY2hyaWViIEphbWVz
IFpodToKPj4+Pj4+IEZpeCByYWNlIGNvbmRpdGlvbiBpc3N1ZSB3aGVuIG11bHRpcGxlIHZjbiBz
dGFydHMgYXJlIGNhbGxlZC4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBaaHUg
PEphbWVzLlpodUBhbWQuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA0ICsrKysKPj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCB8IDEgKwo+Pj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIAo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+Pj4+IGluZGV4IGY5NjQ2NGUuLmFhNzY2M2YgMTAwNjQ0
Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4+Pj4g
QEAgLTYzLDYgKzYzLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKPj4+Pj4+IMKgwqDCoMKgwqAgaW50IGksIHI7Cj4+Pj4+PiDCoCDCoMKgwqDC
oMKgIElOSVRfREVMQVlFRF9XT1JLKCZhZGV2LT52Y24uaWRsZV93b3JrLCAKPj4+Pj4+IGFtZGdw
dV92Y25faWRsZV93b3JrX2hhbmRsZXIpOwo+Pj4+Pj4gK8KgwqDCoCBtdXRleF9pbml0KCZhZGV2
LT52Y24udmNuX3BnX2xvY2spOwo+Pj4+Pj4gwqAgwqDCoMKgwqDCoCBzd2l0Y2ggKGFkZXYtPmFz
aWNfdHlwZSkgewo+Pj4+Pj4gwqDCoMKgwqDCoCBjYXNlIENISVBfUkFWRU46Cj4+Pj4+PiBAQCAt
MjEwLDYgKzIxMSw3IEBAIGludCBhbWRncHVfdmNuX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgCj4+Pj4+PiAqYWRldikKPj4+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+Pj4gwqAgwqDCoMKgwqDC
oCByZWxlYXNlX2Zpcm13YXJlKGFkZXYtPnZjbi5mdyk7Cj4+Pj4+PiArwqDCoMKgIG11dGV4X2Rl
c3Ryb3koJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+Pj4+PiDCoCDCoMKgwqDCoMKgIHJldHVy
biAwOwo+Pj4+Pj4gwqAgfQo+Pj4+Pj4gQEAgLTMyMSw2ICszMjMsNyBAQCB2b2lkIGFtZGdwdV92
Y25fcmluZ19iZWdpbl91c2Uoc3RydWN0IAo+Pj4+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpCj4+Pj4+
PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPj4+
Pj4+IMKgwqDCoMKgwqAgYm9vbCBzZXRfY2xvY2tzID0gCj4+Pj4+PiAhY2FuY2VsX2RlbGF5ZWRf
d29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+Pj4+IMKgICvCoMKgwqAgbXV0ZXhf
bG9jaygmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+Pj4KPj4+Pj4gVGhhdCBzdGlsbCB3b24n
dCB3b3JrIGNvcnJlY3RseSBoZXJlLgo+Pj4+Pgo+Pj4+PiBUaGUgd2hvbGUgaWRlYSBvZiB0aGUg
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYW5kIAo+Pj4+PiBzY2hlZHVsZV9kZWxheWVkX3dv
cmsoKSBkYW5jZSBpcyB0aGF0IHlvdSBoYXZlIGV4YWN0bHkgb25lIHVzZXIgb2YgCj4+Pj4+IHRo
YXQuIElmIHlvdSBoYXZlIG11bHRpcGxlIHJpbmdzIHRoYXQgd2hvbGUgdGhpbmcgd29uJ3Qgd29y
ayAKPj4+Pj4gY29ycmVjdGx5Lgo+Pj4+Pgo+Pj4+PiBUbyBmaXggdGhpcyB5b3UgbmVlZCB0byBj
YWxsIG11dGV4X2xvY2soKSBiZWZvcmUgCj4+Pj4+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygp
IGFuZCBzY2hlZHVsZV9kZWxheWVkX3dvcmsoKSBiZWZvcmUgCj4+Pj4+IG11dGV4X3VubG9jaygp
Lgo+Pj4+Cj4+Pj4gQmlnIGxvY2sgZGVmaW5pdGVseSB3b3Jrcy4gSSBhbSB0cnlpbmcgdG8gdXNl
IGFzIHNtYWxsZXIgbG9jayBhcyAKPj4+PiBwb3NzaWJsZSBoZXJlLiB0aGUgc2hhcmUgcmVzb3Vy
Y2Ugd2hpY2ggbmVlZHMgcHJvdGVjdCBoZXJlIGFyZSAKPj4+PiBwb3dlciBnYXRlIHByb2Nlc3Mg
YW5kIGRwZyBtb2RlIHN3aXRjaCBwcm9jZXNzLgo+Pj4+Cj4+Pj4gaWYgd2UgbW92ZSBtdXRleF91
bmxvY2soKSBiZWZvcmUgc2NoZWR1bGVfZGVsYXllZF93b3JrKC4gSSBhbSAKPj4+PiB3b25kZXJp
bmcgd2hhdCBhcmUgdGhlIG90aGVyIG5lY2Vzc2FyeSByZXNvdXJjZXMgd2hpY2ggbmVlZCBwcm90
ZWN0Lgo+Pj4KPj4+IEJ5IHRoZSB3YXksIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIHN1cHBv
cnRzIG11bHRpcGxlIHRocmVhZCAKPj4+IGl0c2VsZiwgc28gSSBkaWRuJ3QgcHV0IGl0IGludG8g
cHJvdGVjdGlvbiBhcmVhLgo+Pgo+PiBZZWFoLCBidXQgdGhhdCdzIGNvcnJlY3QgYnV0IGl0IHN0
aWxsIHdvbid0IHdvcmtpbmcgY29ycmVjdGx5IDopCj4+Cj4+IFNlZSB0aGUgcHJvYmxlbSBpcyB0
aGF0IG9ubHkgZm9yIHRoZSBmaXJzdCBjYWxsZXIgCj4+IGNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygpIHJldHVybnMgdHJ1ZSBiZWNhdXNlIGl0IGNhbmNlbGVkIHRoZSAKPj4gZGVsYXllZCB3b3Jr
Lgo+Cj4gaWYgdGhlIDFzdCBjYWxsZXIgZ2V0cyB0cnVlLiB0aGUgMm5kIGNhbGxlciB1bmZvcnR1
bmF0ZWx5IG1heSBtaXNzIAo+IHRoaXMgcGVuZGluZyBzdGF0dXMsIHNvIGl0IHdpbGwgdW5nYXRl
IHRoZSBwb3dlciB3aGljaCBpcyB1bmV4cGVjdGVkLgo+Cj4gQnV0IGluIHBvd2VyIGdhdGUvdW5n
YXRlIGZ1bmN0aW9uLCBhIHBvd2VyIHN0YXRlIGlzIG1haW50YWluZWQsIHNvIAo+IHRoaXMgbWlz
cyB3b24ndCBiZSByZWFsbHkgdHJpZ2dlcmVkIHRvIHVuZ2F0ZSB0aGUgcG93ZXIuCj4KPiBTbyBJ
IHRoaW5rIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygpIC8gc2NoZWR1bGVfZGVsYXllZF93b3Jr
KCkgYXJlIAo+IG5vdCBuZWNlc3NhcnkgYmUgcHJvdGVjdGVkIGhlcmUuCgpPayB0aGF0IGNvdWxk
IHdvcmsgYXMgd2VsbC4KCkJ1dCBpbiB0aGlzIGNhc2UgSSB3b3VsZCByZW1vdmUgY2hlY2tpbmcg
dGhlIHJldHVybiB2YWx1ZSBvZiAKY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYW5kIGp1c3Qg
YWx3YXlzIHVuZ2F0ZSB0aGUgcG93ZXIuCgpUaGlzIHdheSB3ZSBwcmV2ZW50IHVnbHkgYnVncyBm
cm9tIGxlYWtpbmcgaW4gd2hlbiB0aGlzIHJlYWxseSByYWNlcyAKc29tZXRpbWVzLgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKPgo+IEJlc3QgUmVnYXJkcyEKPgo+IEphbWVzCj4KPj4KPj4gRm9yIGFs
bCBvdGhlcnMgaXQgcmV0dXJucyBmYWxzZSBhbmQgdGhvc2Ugd291bGQgdGhlbiB0aGluayB0aGF0
IHRoZXkgCj4+IG5lZWQgdG8gdW5nYXRlIHRoZSBwb3dlci4KPj4KPj4gVGhlIG9ubHkgc29sdXRp
b24gSSBzZWUgaXMgdG8gZWl0aGVyIHB1dCBib3RoIHRoZSAKPj4gY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCkgYW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpIHVuZGVyIHRoZSBzYW1lIAo+PiBt
dXRleCBwcm90ZWN0aW9uIG9yIHN0YXJ0IHRvIHVzZSBhbiBhdG9taWMgb3Igb3RoZXIgY291bnRl
ciB0byBub3RlIAo+PiBjb25jdXJyZW50IHByb2Nlc3NpbmcuCj4+Cj4+PiBwb3dlciBnYXRlIGlz
IHNoYXJlZCBieSBhbGwgVkNOIElQIGluc3RhbmNlcyBhbmQgZGlmZmVyZW50IHJpbmdzICwgCj4+
PiBzbyBpdMKgIG5lZWRzIGJlIHB1dCBpbnRvIHByb3RlY3Rpb24gYXJlYS4KPj4+Cj4+PiBlYWNo
IHJpbmcncyBqb2IgaXRzZWxmIGlzIHNlcmlhbGl6ZWQgYnkgc2NoZWR1bGVyLiBpdCBkb2Vzbid0
IG5lZWQgCj4+PiBiZcKgIHB1dCBpbnRvIHRoaXMgcHJvdGVjdGlvbiBhcmVhLgo+Pgo+PiBZZXMs
IHRob3NlIHNob3VsZCB3b3JrIGFzIGV4cGVjdGVkLgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3Rp
YW4uCj4+Cj4+Pgo+Pj4+Cj4+Pj4gVGhhbmtzIQo+Pj4+Cj4+Pj4gSmFtZXMKPj4+Pgo+Pj4+Pgo+
Pj4+PiBSZWdhcmRzLAo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+PiDCoMKgwqDCoMKgIGlm
IChzZXRfY2xvY2tzKSB7Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZf
Y3RybChhZGV2LCBmYWxzZSk7Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2Rldmlj
ZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgCj4+Pj4+PiBBTURfSVBfQkxPQ0tfVFlQ
RV9WQ04sCj4+Pj4+PiBAQCAtMzQ1LDYgKzM0OCw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2Jl
Z2luX3VzZShzdHJ1Y3QgCj4+Pj4+PiBhbWRncHVfcmluZyAqcmluZykKPj4+Pj4+IMKgIMKgwqDC
oMKgwqDCoMKgwqDCoCBhZGV2LT52Y24ucGF1c2VfZHBnX21vZGUoYWRldiwgcmluZy0+bWUsICZu
ZXdfc3RhdGUpOwo+Pj4+Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4+PiArwqDCoMKgIG11dGV4X3VubG9j
aygmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPj4+Pj4+IMKgIH0KPj4+Pj4+IMKgIMKgIHZvaWQg
YW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCAKPj4+
Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+PiBpbmRl
eCA2ZmUwNTczLi4yYWUxMTBkIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmgKPj4+Pj4+IEBAIC0yMDAsNiArMjAwLDcgQEAgc3RydWN0IGFtZGdw
dV92Y24gewo+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgCj4+Pj4+
PiAqdmNuX2RlY19zY2hlZFtBTURHUFVfTUFYX1ZDTl9JTlNUQU5DRVNdOwo+Pj4+Pj4gwqDCoMKg
wqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Zjbl9lbmNfc2NoZWQ7Cj4+Pj4+PiDC
oMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoCBudW1fdmNuX2RlY19zY2hlZDsKPj4+
Pj4+ICvCoMKgwqAgc3RydWN0IG11dGV4wqDCoMKgwqDCoMKgwqDCoCB2Y25fcGdfbG9jazsKPj4+
Pj4+IMKgIMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqAgaGFydmVzdF9jb25maWc7Cj4+Pj4+PiDC
oMKgwqDCoMKgIGludCAoKnBhdXNlX2RwZ19tb2RlKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPj4+Pj4KPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
