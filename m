Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A08CD5BDE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 07:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B9E10E245;
	Wed, 27 May 2026 07:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="a4hLXOEK";
	dkim-atps=neutral
X-Greylist: delayed 380 seconds by postgrey-1.36 at gabe;
 Tue, 26 May 2026 15:11:08 UTC
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [170.10.129.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F6310E20C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1779808267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/o58ejGK8onng0/VtWpFh4esMZPeGuyDS78DK9Me7Zs=;
 b=a4hLXOEKBNAzIXcuJGzQLxrtURNj+fAZwh70tIn202fqKq4w4l7Wts8RHpbmL4VN/UWmPI
 UQ+tVu9DnMl4kYG4/hhmMbkXaPfbeef0zR+DiYlhSibfyGFPMFar4jdnQLdS/NhkEcb3+p
 kHO1MBQU2o+I0jTa3UPaH2pTwVfKLyE=
Received: from smtp-02-tuk3.valvesoftware.com
 (smtp-02-blv1.valvesoftware.com [208.64.203.182]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-175-gErr4YA9M2ydJSj8lratow-1; Tue, 26 May 2026 11:04:44 -0400
X-MC-Unique: gErr4YA9M2ydJSj8lratow-1
X-Mimecast-MFC-AGG-ID: gErr4YA9M2ydJSj8lratow_1779807883
Received: from antispam.valve.org ([172.16.1.107])
 by smtp-02-tuk3.valvesoftware.com with esmtp (Exim 4.97)
 (envelope-from <peihsiny@valvesoftware.com>)
 id 1wRtKf-00000004spO-0BWK for amd-gfx@lists.freedesktop.org;
 Tue, 26 May 2026 08:04:43 -0700
Received: from antispam.valve.org (127.0.0.1) id h2mr8m0171sr for
 <amd-gfx@lists.freedesktop.org>;
 Tue, 26 May 2026 08:04:43 -0700 (envelope-from <peihsiny@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
 by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
 with ESMTP id o202605261504430076524-5; Tue, 26 May 2026 08:04:43 -0700
Received: from mail2.valvemail.org (172.16.144.23) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 26 May
 2026 08:04:43 -0700
Received: from mail2.valvemail.org ([::1]) by mail2.valvemail.org ([::1]) with
 mapi id 15.02.2562.017; Tue, 26 May 2026 08:04:43 -0700
From: Pei-Hsin Yang <peihsiny@valvesoftware.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Topic: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Index: AdznyYW5KuL81IotTPmWr+1olc6y4wAnk9yAAAH0cTAALvV0AABCoHewAMb8EYAADFKRAA==
Date: Tue, 26 May 2026 15:04:42 +0000
Message-ID: <17aabac2d51c411c8e9aa230d799ab49@valvesoftware.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <431e78bafdc7402398d5b7bc85d81252@valvesoftware.com>
 <1fb98dd3-55fd-4269-91bd-292b1167718b@mailbox.org>
In-Reply-To: <1fb98dd3-55fd-4269-91bd-292b1167718b@mailbox.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.15.76]
MIME-Version: 1.0
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260522120322; ds20230628172248;
 di20260507172443; ri20160318003319; fs20260522203510
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: peihsiny@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202605261504430076524
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZJlMNnaTz3tKIiK-0RefyiamxJ4kaaA2TqG9Kql03mk_1779807883
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Wed, 27 May 2026 07:46:23 +0000
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

PiBJbiB0aGUgZnV0dXJlLCBwbGVhc2Ugc2VuZCBwYXRjaGVzIGlubGluZSwgdG8gbWFrZSBnaXZp
bmcgZmVlZGJhY2sgZWFzaWVyLg0KDQpXaWxsIGRvLiAgVGhhbmtzLg0KDQo+IHZzZGJfaW5mby5m
cmVlc3luY19zdXBwb3J0ZWQgYWxyZWFkeSBndWFyZHMgc2V0dGluZyBmcmVlc3luY19jYXBhYmxl
ID0gdHJ1ZSBpbiB0aGUgZmlyc3QgcGxhY2UgKGdpdmVuIGVpdGhlciBvZiB0aGUgb3RoZXIgdHdv
IGNvbmRpdGlvbnMpIGFib3ZlLCBzbyB0aGlzIGlmLXN0YXRlbWVudCBsb29rcyBzdXBlcmZsdW91
cyBub3cuDQoNClllcywgaWYgaGFyZHdhcmUgZGV0ZWN0aW9uIHZpYSBNQ0NTIFZDUCBDb2RlIHJl
YWQgaXMgbm90IHByZWZlcnJlZCwgdGhlbiB0aGlzIGlmLXN0YXRlbWVudCBjYW4gYmUgcmVtb3Zl
ZC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBtYWlsYm94Lm9yZz4gDQpTZW50OiBUdWVzZGF5LCBNYXkgMjYsIDIwMjYg
Njo1NSBBTQ0KVG86IFBlaS1Ic2luIFlhbmcgPHBlaWhzaW55QHZhbHZlc29mdHdhcmUuY29tPg0K
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW0V4dGVybmFs
IE1haWxdIFJlOiBUZXN0IHJlc3VsdCAvIGZpbmRpbmcgb2YgImRybS9hbWQvZGlzcGxheTogQ29u
c3VsdCBNQ0NTIEZyZWVTeW5jIGNhcCBvbmx5IGlmIHJlcXVlc3RlZCAmIHN1cHBvcnRlZCINCg0K
T24gNS8yMy8yNiAwMDoxNSwgUGVpLUhzaW4gWWFuZyB3cm90ZToNCj4+IE5vdGUgdGhhdCBzb21l
IGtpbmQgb2Ygc2hvcnQtdGVybSBzb2x1dGlvbiBpcyBuZWVkZWQgZm9yIHRoZSByZWdyZXNzaW9u
KHMpIGluIDcuMS1yYy4NCj4gDQo+IEhlcmUgaXMgbXkgc3VnZ2VzdGlvbiBhcyBhIHNob3J0LXRl
cm0gd29ya2Fyb3VuZDogIA0KPiAJLSBKdXN0IHJlZmVyIHRvIHRoZSB2c2RiX2luZm8gZGF0YSBz
dHJ1Y3R1cmUgdG8gc2V0IHRoZSB2YWx1ZSBvZiBmcmVlc3luY19jYXBhYmxlLiAgZnJlZXN5bmNf
bWNjc192Y3BfY29kZSA9IDAgZG9lc24ndCBtZWFuIEZyZWVTeW5jIGlzIG5vdCBzdXBwb3J0ZWQu
DQo+IAktIENoZWNrIGJvdGggZnJlZXN5bmNfc3VwcG9ydGVkIGFuZCBmcmVlc3luY19tY2NzX3Zj
cF9jb2RlIGFsb25nIHdpdGggZG9fbWNjcyB0byBjYWxsIGRtX2hlbHBlcnNfbWNjc192Y3Bfc2V0
KCkuDQo+IAktIE5vdGUgdGhhdCBNQ0NTIGNvbW1hbmQgb3ZlciBEREMgbWlnaHQgYmUgZmFpbGVk
IGF0IHJ1bnRpbWUsIGJ1dCBhdCBsZWFzdCwgaXQgd2lsbCBub3QgaW5hZHZlcnRlbnRseSBkaXNh
YmxlIHRoZSBWUlIgaWYgKDEpIHNpbmsgaXMgRnJlZVN5bmMgc3VwcG9ydGVkIGJ1dCB2Y3BfY29k
ZSA9IDAsIG9yICgyKSBkbV9oZWxwZXJzX3JlYWRfbWNjc19jYXAoKSBmYWlsZWQgaW50ZXJtaXR0
ZW50bHkgYXQgcnVudGltZS4NCj4gDQo+IFBhdGNoIGNyZWF0ZWQgYmFzZWQgb24gY29tbWl0IDUz
ZjAyMzVjMDI4NGZjNjc2ZDE1MTBhNDYwZTFjNmMxMTFkZTNlYTEgaXMgYXR0YWNoZWQgYXMgYSBy
ZWZlcmVuY2UgZm9yIEFNRCB0ZWFtIHRvIHJldmlldy4NCj4gDQo+IGNvbW1pdCA1M2YwMjM1YzAy
ODRmYzY3NmQxNTEwYTQ2MGUxYzZjMTExZGUzZWExIChIRUFEIC0+IGFtZC1zdGFnaW5nLWRybS1u
ZXh0LCBvcmlnaW4vYW1kLXN0YWdpbmctZHJtLW5leHQsIG9yaWdpbi9IRUFEKQ0KDQpJbiB0aGUg
ZnV0dXJlLCBwbGVhc2Ugc2VuZCBwYXRjaGVzIGlubGluZSwgdG8gbWFrZSBnaXZpbmcgZmVlZGJh
Y2sgZWFzaWVyLg0KDQoNCj4gQEAgLTEzNjgwLDExICsxMzY4MCwxMCBAQCB2b2lkIGFtZGdwdV9k
bV91cGRhdGVfZnJlZXN5bmNfY2FwcyhzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLA0K
PiANCj4gICAgICAgICBpZiAoKHNpbmstPnNpbmtfc2lnbmFsID09IFNJR05BTF9UWVBFX0hETUlf
VFlQRV9BIHx8DQo+ICAgICAgICAgICAgICAgICBhc190eXBlID09IEZSRUVTWU5DX1RZUEVfUENP
Tl9JTl9XSElURUxJU1QpICYmDQo+IC0gICAgICAgICAgICAgICAoIXNpbmstPmVkaWRfY2Fwcy5m
cmVlc3luY192Y3BfY29kZSB8fA0KPiAtICAgICAgICAgICAgICAgKHNpbmstPmVkaWRfY2Fwcy5m
cmVlc3luY192Y3BfY29kZSAmJiAhc2luay0+bWNjc19jYXBzLmZyZWVzeW5jX3N1cHBvcnRlZCkp
KQ0KPiArICAgICAgICAgICAgICAgKCF2c2RiX2luZm8uZnJlZXN5bmNfc3VwcG9ydGVkKSkNCj4g
ICAgICAgICAgICAgICAgIGZyZWVzeW5jX2NhcGFibGUgPSBmYWxzZTsNCg0KdnNkYl9pbmZvLmZy
ZWVzeW5jX3N1cHBvcnRlZCBhbHJlYWR5IGd1YXJkcyBzZXR0aW5nIGZyZWVzeW5jX2NhcGFibGUg
PSB0cnVlIGluIHRoZSBmaXJzdCBwbGFjZSAoZ2l2ZW4gZWl0aGVyIG9mIHRoZSBvdGhlciB0d28g
Y29uZGl0aW9ucykgYWJvdmUsIHNvIHRoaXMgaWYtc3RhdGVtZW50IGxvb2tzIHN1cGVyZmx1b3Vz
IG5vdy4NCg0KDQotLSANCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICBcICAgICAgICBH
Tk9NRSAvIFh3YXlsYW5kIC8gTWVzYSBkZXZlbG9wZXINCmh0dHBzOi8vcmVkaGF0LmNvbSAgICAg
ICAgICAgICBcICAgICAgICAgICAgICAgTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdA0KDQo=

