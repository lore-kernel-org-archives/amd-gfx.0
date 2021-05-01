Return-Path: <SRS0=4h+3=J4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2657AC433B4
	for <amd-gfx@archiver.kernel.org>; Sat,  1 May 2021 19:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61B661409
	for <amd-gfx@archiver.kernel.org>; Sat,  1 May 2021 19:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B661409
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F3A6E187;
	Sat,  1 May 2021 19:52:11 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Sat, 01 May 2021 19:52:09 UTC
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [216.205.24.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA076E187
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 May 2021 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1619898727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2b70AaPEU/ZOI0e0QCAG+0rMZkTQTgERlBsGR0yfTtM=;
 b=PRXDW8Sf1v0ZvYXgpTMnTzegmtFd8trUMtSTet+EIklg8OMoblMjdR0xKBPoyWGupTVyaI
 DdLqGMEJD8SZnKQ5vDbEEOpel3ZxGr8kiscIE02TBTRJV9VmgmZU7ckiZIjvVhyM2J4EI8
 gZDAeOxrZaUR5hLnWoCGa2x44sIVLtw=
Received: from smtp-01-blv1.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-mD5CjyXDOmuKT9LIBWpuTQ-1; Sat, 01 May 2021 15:45:19 -0400
X-MC-Unique: mD5CjyXDOmuKT9LIBWpuTQ-1
Received: from [172.16.1.107] (helo=antispam.valve.org)
 by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.86_2)
 (envelope-from <pgriffais@valvesoftware.com>) id 1lcvYE-0005ur-GC
 for amd-gfx@lists.freedesktop.org; Sat, 01 May 2021 12:45:18 -0700
Received: from antispam.valve.org (127.0.0.1) id hhmnss0171sq for
 <amd-gfx@lists.freedesktop.org>;
 Sat, 1 May 2021 12:45:18 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
 by antispam.valve.org ([172.16.1.107]) (SonicWall 9.1.3.3983)
 with ESMTP id o202105011945180022251-5; Sat, 01 May 2021 12:45:18 -0700
Received: from [172.16.36.23] (172.16.36.23) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 1 May 2021
 12:45:18 -0700
Subject: Re: [PATCH] Revert "drm/amdgpu: Verify bo size can fit framebuffer
 size on init."
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Bas Nieuwenhuizen
 <bas@basnieuwenhuizen.nl>, <amd-gfx@lists.freedesktop.org>
References: <20210429205024.892894-1-bas@basnieuwenhuizen.nl>
 <88f8bff1-7750-515d-24ca-24c76cad9bdf@daenzer.net>
From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <b2d718fe-dfbf-24e0-7362-8b5ffd3ced3d@valvesoftware.com>
Date: Sat, 1 May 2021 12:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <88f8bff1-7750-515d-24ca-24c76cad9bdf@daenzer.net>
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.1.3.3983
X-Mlf-License: BSVKCAP_T_
X-Mlf-UniqueId: o202105011945180022251
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA72A183 smtp.mailfrom=pgriffais@valvesoftware.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
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
Cc: alexdeucher@gmail.com, markyacoub@chromium.org,
 xinhui pan <xinhui.pan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiA0LzMwLzIxIDY6MjQgQU0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwMjEtMDQt
MjkgMTA6NTAgcC5tLiwgQmFzIE5pZXV3ZW5odWl6ZW4gd3JvdGU6Cj4+IFRoaXMgcmV2ZXJ0cyBj
b21taXQgZjI1ODkwN2ZkZDgzNWUxYWVkNmQ2NjZiMDBjZGQwZjE4NjY3NmI3Yy4KPj4KPj4gU2Ft
ZSBwcm9ibGVtIGFzICJkcm0vYW1kZ3B1OiBWZXJpZnkgYm8gc2l6ZSBjYW4gZml0IGZyYW1lYnVm
ZmVyIHNpemUiLAo+PiBidXQgYmVjYXVzZSBpdCBnZXRzIGNoZWNrZWQgZWFybGllciBpdCBub3cg
b25seSB0cmlnZ2VycyBvbiB0aGUKPj4gbW9kaWZpZXJzIGNhc2UuCj4+Cj4+IFRoZXJlIGFyZSBh
IGNvdXBsZSBvZiByZWFzb25zIHdoeSB0aGUgRFJNIGNvcmUgQk8gc2l6ZSBjaGVjayB3b24ndAo+
PiB3b3JrIGZvciBBTURHUFUsIGVzcGVjaWFsbHkgYXJvdW5kIERDQyBwbGFuZXMuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4K
Pj4gLS0tCj4+Cj4+IEZvciAtZml4ZXMuIE1pZ2h0IGhhdmUgc29tZSBjb25mbGljdHMgd2l0aAo+
PiAiZHJtL2FtZGdwdTogRW5zdXJlIHRoYXQgdGhlIG1vZGlmaWVyIHJlcXVlc3RlZCBpcyBzdXBw
b3J0ZWQgYnkgcGxhbmUiCj4+IGZvciBhbWQtc3RhZ2luZy1kcm0tbmV4dAo+IAo+IFRoaXMgaW50
ZXJhY3RzIGJhZGx5IHdpdGggNzlmY2Q0NDZlN2UxICJkcm0vYW1kZ3B1OiBGaXggbWVtb3J5IGxl
YWsiLCByZXN1bHRpbmcgaW4gQk9zIGdldHRpbmcgZGVzdHJveWVkIHByZW1hdHVyZWx5IGFuZCBl
bnN1aW5nIGJhZG5lc3MuIFRvIGF2b2lkIHRoYXQsIGF0IGxlYXN0IHRoZSBkcm1fZ2VtX29iamVj
dF9wdXQgY2FsbCBuZWVkcyB0byBiZSByZW1vdmVkIGZyb20gdGhlIGVuZCBvZiBhbWRncHVfZGlz
cGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZSBuZWVkcyB0byBiZSByZW1vdmVkIGFzIHdlbGws
IGlmIG5vdCA3OWZjZDQ0NmU3ZTEgcmV2ZXJ0ZWQgYWx0b2dldGhlci4KPiAKPiAKPiBJIHN1c3Bl
Y3QgNzlmY2Q0NDZlN2UxIHdhcyBhdCBsZWFzdCBwYXJ0bHkgYSBmaXgtdXAgZm9yIGYyNTg5MDdm
ZGQ4MywgdG8gY29tcGVuc2F0ZSBmb3IgZHJtX2dlbV9mYl9pbml0X3dpdGhfZnVuY3MgaW5jcmVt
ZW50aW5nIHRoZSBCTyByZWZlcmVuY2UgY291bnRzLgoKVGhhbmtzIG11Y2ggZm9yIHRoZSBwb2lu
dGVyLCByZXZlcnRpbmcgImRybS9hbWRncHU6IEZpeCBtZW1vcnkgbGVhayIgaW4gCmFkZGl0aW9u
IHRvIHRoZSBhYm92ZSBwYXRjaCB5aWVsZHMgYSBzdGFibGUga2VybmVsIG9uIG15IHNpZGUgYWdh
aW4uIApPdGhlcndpc2UsIHRoaW5ncyBjcmFzaCB3aGVuIGdhbWVzY29wZSBhdHRlbXB0cyB0byBm
bGlwIGl0cyBjdXJzb3IgCnN1cmZhY2Ugb250byB0aGUgc2NyZWVuLgoKPiAKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
