Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D1CD6E45
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C5910E56C;
	Tue, 26 May 2026 07:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="WjOGzlrw";
	dkim-atps=neutral
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [170.10.133.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E9D10E0C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1779488126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WbGeRSmieSX02oFIxSL7sYZ4IN41etaUo4I72wb2Kj0=;
 b=WjOGzlrwkT1gcwYqH9QFiJynvPEP/HAhqEaEjDP8bwmjPufIyu5NptPaOLAeYBVvg6V0b6
 lQFWY25i8qnBDsqgT1DBA+qr07akTR8CiEUwKTWxhPHaUoH+8ikAJn0lTtUTgvm6XggVx5
 6j4Ks5yy2fHHYn9Lf1odXyyiS6nyT5g=
Received: from smtp-02-tuk3.valvesoftware.com
 (smtp-02-blv1.valvesoftware.com [208.64.203.182]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-206-TIAz--gdOAypeyHnuz5jxw-1; Fri, 22 May 2026 18:15:24 -0400
X-MC-Unique: TIAz--gdOAypeyHnuz5jxw-1
X-Mimecast-MFC-AGG-ID: TIAz--gdOAypeyHnuz5jxw_1779488123
Received: from antispam.valve.org ([172.16.1.107])
 by smtp-02-tuk3.valvesoftware.com with esmtp (Exim 4.97)
 (envelope-from <peihsiny@valvesoftware.com>)
 id 1wQY9L-000000074zQ-0rAl for amd-gfx@lists.freedesktop.org;
 Fri, 22 May 2026 15:15:23 -0700
Received: from antispam.valve.org (127.0.0.1) id h23anm0171s0 for
 <amd-gfx@lists.freedesktop.org>;
 Fri, 22 May 2026 15:15:23 -0700 (envelope-from <peihsiny@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
 by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
 with ESMTP id o202605222215230058122-5; Fri, 22 May 2026 15:15:23 -0700
Received: from mail2.valvemail.org (172.16.144.23) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 22 May
 2026 15:15:22 -0700
Received: from mail2.valvemail.org ([::1]) by mail2.valvemail.org ([::1]) with
 mapi id 15.02.2562.017; Fri, 22 May 2026 15:15:22 -0700
From: Pei-Hsin Yang <peihsiny@valvesoftware.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Topic: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Index: AdznyYW5KuL81IotTPmWr+1olc6y4wAnk9yAAAH0cTAALvV0AABCoHew
Date: Fri, 22 May 2026 22:15:22 +0000
Message-ID: <431e78bafdc7402398d5b7bc85d81252@valvesoftware.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
In-Reply-To: <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.11.65]
MIME-Version: 1.0
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260522120322; ds20230628172248;
 di20260507172443; ri20160318003319; fs20260522203510
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: peihsiny@valvesoftware.com
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202605222215230058122
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XTjXhZRR92yLGi7llw5kSk7daSN12scfeZ96eSll3zs_1779488123
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: multipart/mixed;
 boundary="_002_431e78bafdc7402398d5b7bc85d81252valvesoftwarecom_"
X-Mailman-Approved-At: Tue, 26 May 2026 07:53:08 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_431e78bafdc7402398d5b7bc85d81252valvesoftwarecom_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiBOb3RlIHRoYXQgc29tZSBraW5kIG9mIHNob3J0LXRlcm0gc29sdXRpb24gaXMgbmVlZGVkIGZv
ciB0aGUgcmVncmVzc2lvbihzKSBpbiA3LjEtcmMuDQoNCkhlcmUgaXMgbXkgc3VnZ2VzdGlvbiBh
cyBhIHNob3J0LXRlcm0gd29ya2Fyb3VuZDogIA0KCS0gSnVzdCByZWZlciB0byB0aGUgdnNkYl9p
bmZvIGRhdGEgc3RydWN0dXJlIHRvIHNldCB0aGUgdmFsdWUgb2YgZnJlZXN5bmNfY2FwYWJsZS4g
IGZyZWVzeW5jX21jY3NfdmNwX2NvZGUgPSAwIGRvZXNuJ3QgbWVhbiBGcmVlU3luYyBpcyBub3Qg
c3VwcG9ydGVkLg0KCS0gQ2hlY2sgYm90aCBmcmVlc3luY19zdXBwb3J0ZWQgYW5kIGZyZWVzeW5j
X21jY3NfdmNwX2NvZGUgYWxvbmcgd2l0aCBkb19tY2NzIHRvIGNhbGwgZG1faGVscGVyc19tY2Nz
X3ZjcF9zZXQoKS4NCgktIE5vdGUgdGhhdCBNQ0NTIGNvbW1hbmQgb3ZlciBEREMgbWlnaHQgYmUg
ZmFpbGVkIGF0IHJ1bnRpbWUsIGJ1dCBhdCBsZWFzdCwgaXQgd2lsbCBub3QgaW5hZHZlcnRlbnRs
eSBkaXNhYmxlIHRoZSBWUlIgaWYgKDEpIHNpbmsgaXMgRnJlZVN5bmMgc3VwcG9ydGVkIGJ1dCB2
Y3BfY29kZSA9IDAsIG9yICgyKSBkbV9oZWxwZXJzX3JlYWRfbWNjc19jYXAoKSBmYWlsZWQgaW50
ZXJtaXR0ZW50bHkgYXQgcnVudGltZS4NCg0KUGF0Y2ggY3JlYXRlZCBiYXNlZCBvbiBjb21taXQg
NTNmMDIzNWMwMjg0ZmM2NzZkMTUxMGE0NjBlMWM2YzExMWRlM2VhMSBpcyBhdHRhY2hlZCBhcyBh
IHJlZmVyZW5jZSBmb3IgQU1EIHRlYW0gdG8gcmV2aWV3Lg0KDQpjb21taXQgNTNmMDIzNWMwMjg0
ZmM2NzZkMTUxMGE0NjBlMWM2YzExMWRlM2VhMSAoSEVBRCAtPiBhbWQtc3RhZ2luZy1kcm0tbmV4
dCwgb3JpZ2luL2FtZC1zdGFnaW5nLWRybS1uZXh0LCBvcmlnaW4vSEVBRCkNCg0KVGhhbmtzDQpQ
ZWktSHNpbg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAbWFpbGJveC5vcmc+IA0KU2VudDogVGh1cnNkYXksIE1heSAy
MSwgMjAyNiAxMjoxMCBBTQ0KVG86IFBlaS1Ic2luIFlhbmcgPHBlaWhzaW55QHZhbHZlc29mdHdh
cmUuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTog
W0V4dGVybmFsIE1haWxdIFJlOiBUZXN0IHJlc3VsdCAvIGZpbmRpbmcgb2YgImRybS9hbWQvZGlz
cGxheTogQ29uc3VsdCBNQ0NTIEZyZWVTeW5jIGNhcCBvbmx5IGlmIHJlcXVlc3RlZCAmIHN1cHBv
cnRlZCINCg0KT24gNS8yMC8yNiAxNzo1NCwgUGVpLUhzaW4gWWFuZyB3cm90ZToNCj4gDQo+PiBU
ZXN0ZWQgd2l0aCAzIEhETUkgc2lua3Mgd2l0aCBkaWZmZXJlbnQgRnJlZVN5bmMvSERNSSBWUlIg
Y2FwYWJpbGl0aWVzLiAgSSBzYXcgb25lIGNhc2UgdGhhdCBhIEZyZWVTeW5jIHNpbmsgKERlbGwg
UzI3MjFIUykgd2l0aCBFNmggVkNQIGNvZGUgc3VwcG9ydGVkIHdhcyBkZXRlY3RlZCBhcyBGcmVl
U3luYyBjYXBhYmxlIGF0IGJlZ2lubmluZyBidXQgaWRlbnRpZmllZCBhcyBub3QgRnJlZVN5bmMg
Y2FwYWJsZSBsYXRlciDigJMgYWZ0ZXIgZG9fbWNjcyBpcyBjaGFuZ2VkIGZyb20gdHJ1ZSB0byBm
YWxzZS4NCj4gDQo+Pj4gQW5kIHRoYXQgZG9lc24ndCBoYXBwZW4gd2l0aG91dCBteSBwYXRjaCBh
cHBsaWVkPw0KPiANCj4gVGhlcmUgYXJlIG90aGVyIGlzc3VlcyB3aXRob3V0IHlvdXIgcGF0Y2gg
YXBwbGllZC4gICBPbmUgaXNzdWUgaXMgdGhhdCBpZiBhIEZyZWVTeW5jIGNhcGFibGUgc2luayB3
aXRoIE1DQ1MgVkNQIENvZGUgPSAwIChtb3N0bHkgYXJlIFRWcyksIGl0IHdpbGwgYmUgZGV0ZWN0
ZWQgYXMgbm90IEZyZWVTeW5jIHN1cHBvcnRlZCBhbmQgVlJSIHdpbGwgYmUgZGlzYWJsZWQuDQoN
ClRoYXQgc291bmRzIHNpbWlsYXIgdG8gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9hbWQvLS93b3JrX2l0ZW1zLzUyODYgLg0KDQoNCkkgd2FzIHdvbmRlcmluZyBpZiB0aGUgc3Bl
Y2lmaWMgaXNzdWUgeW91IGRlc2NyaWJlZCBhYm92ZSB3aXRoIERlbGwgUzI3MjFIUyBpcyByZXBy
b2R1Y2libGUgd2l0aG91dCBteSBwYXRjaCB0aG91Z2gsIGluIHdoaWNoIGNhc2UgaXQgbWlnaHQg
YmUgYSBzZXBhcmF0ZSByZWdyZXNzaW9uIChhbmQgd291bGRuJ3Qgc3BlYWsgYWdhaW5zdCBtZXJn
aW5nIG15IHBhdGNoKS4NCg0KDQo+Pj4gVEJIIEkgZG9uJ3QgcmVhbGx5IHdhbnQgdG8gYmUgZml4
aW5nIHRoZSByZWdyZXNzaW9uIEkgaGl0LCBJJ2QgcHJlZmVyIHRoZSBBTUQgZGlzcGxheSB0ZWFt
IHRvIGhhbmRsZSBpdC4NCj4gDQo+IFllcywgYWdyZWVkLiAgQXMgRnJlZVN5bmMgTUNDUyBzdXBw
b3J0IGhhcyBpbW1lZGlhdGUgaW1wYWN0cyB0byBWYWx2ZSdzIFN0ZWFtIGRldmljZXMsIEkgd2ls
bCB3b3JrIHdpdGggQU1EIGRpc3BsYXkgdGVhbSB0byBoYW5kbGUgaXQuICAgSERNSSAyLjEgVlJS
IGFuZCBWVEVNIHBhY2tldCBzZW5kaW5nIHN1cHBvcnQgbmVlZCB0byBiZSBpbmNsdWRlZCBhcyB3
ZWxsLg0KDQpOb3RlIHRoYXQgc29tZSBraW5kIG9mIHNob3J0LXRlcm0gc29sdXRpb24gaXMgbmVl
ZGVkIGZvciB0aGUgcmVncmVzc2lvbihzKSBpbiA3LjEtcmMuDQoNCg0KLS0gDQpFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgXCAgICAgICAgR05PTUUgLyBYd2F5bGFuZCAvIE1lc2EgZGV2
ZWxvcGVyDQpodHRwczovL3JlZGhhdC5jb20gICAgICAgICAgICAgXCAgICAgICAgICAgICAgIExp
YnJlIHNvZnR3YXJlIGVudGh1c2lhc3QNCg0K
--_002_431e78bafdc7402398d5b7bc85d81252valvesoftwarecom_
Content-Type: application/octet-stream;
	name="asdn-freesync-mccs-caps-use-vsdb.patch"
Content-Description: asdn-freesync-mccs-caps-use-vsdb.patch
Content-Disposition: attachment;
	filename="asdn-freesync-mccs-caps-use-vsdb.patch"; size=907;
	creation-date="Fri, 22 May 2026 22:11:50 GMT";
	modification-date="Fri, 22 May 2026 21:57:05 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CmluZGV4IGFmMGFmNzUxOTUxNy4uZmZjMDI3M2ZjZjYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTEzNjgwLDExICsxMzY4
MCwxMCBAQCB2b2lkIGFtZGdwdV9kbV91cGRhdGVfZnJlZXN5bmNfY2FwcyhzdHJ1Y3QgZHJtX2Nv
bm5lY3RvciAqY29ubmVjdG9yLAogCiAJaWYgKChzaW5rLT5zaW5rX3NpZ25hbCA9PSBTSUdOQUxf
VFlQRV9IRE1JX1RZUEVfQSB8fAogCQlhc190eXBlID09IEZSRUVTWU5DX1RZUEVfUENPTl9JTl9X
SElURUxJU1QpICYmCi0JCSghc2luay0+ZWRpZF9jYXBzLmZyZWVzeW5jX3ZjcF9jb2RlIHx8Ci0J
CShzaW5rLT5lZGlkX2NhcHMuZnJlZXN5bmNfdmNwX2NvZGUgJiYgIXNpbmstPm1jY3NfY2Fwcy5m
cmVlc3luY19zdXBwb3J0ZWQpKSkKKwkJKCF2c2RiX2luZm8uZnJlZXN5bmNfc3VwcG9ydGVkKSkK
IAkJZnJlZXN5bmNfY2FwYWJsZSA9IGZhbHNlOwogCi0JaWYgKGRvX21jY3MgJiYgc2luay0+bWNj
c19jYXBzLmZyZWVzeW5jX3N1cHBvcnRlZCAmJiBmcmVlc3luY19jYXBhYmxlKQorCWlmIChkb19t
Y2NzICYmIHZzZGJfaW5mby5mcmVlc3luY19zdXBwb3J0ZWQgJiYgdnNkYl9pbmZvLmZyZWVzeW5j
X21jY3NfdmNwX2NvZGUpCiAJCWRtX2hlbHBlcnNfbWNjc192Y3Bfc2V0KGFkZXYtPmRtLmRjLT5j
dHgsIGFtZGdwdV9kbV9jb25uZWN0b3ItPmRjX2xpbmssIHNpbmspOwogCiB1cGRhdGU6Cg==
--_002_431e78bafdc7402398d5b7bc85d81252valvesoftwarecom_--

