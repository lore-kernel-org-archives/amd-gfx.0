Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52C7CD5BAE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F28910F219;
	Thu, 21 May 2026 07:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="eVkNDVpl";
	dkim-atps=neutral
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [170.10.133.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD1210E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1779292469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QC0YmIsanLoiRyxG4DmUrGh0QSwkWom/J3JAIjzDhXE=;
 b=eVkNDVplhyiCdYNdpl+QOv8Ac36d3okvTxdD76epqfzj+5RK7O1NAOI1T0Ac3zNzl2+1Oo
 AAjEaYgk66KsAkKHr3KuQKDCDfTuPkUf1RLyT8Q2mN2BtnLX5ncX6T9UKRLXKjM51kmzrC
 dl/ca9ZdfTgzbGModawwTjPc4TZMflY=
Received: from smtp-02-tuk3.valvesoftware.com
 (smtp-02-blv1.valvesoftware.com [208.64.203.182]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-360-UgAzB-7iMuucCVOxK_QDng-1; Wed, 20 May 2026 11:54:26 -0400
X-MC-Unique: UgAzB-7iMuucCVOxK_QDng-1
X-Mimecast-MFC-AGG-ID: UgAzB-7iMuucCVOxK_QDng_1779292466
Received: from antispam.valve.org ([172.16.1.107])
 by smtp-02-tuk3.valvesoftware.com with esmtp (Exim 4.97)
 (envelope-from <peihsiny@valvesoftware.com>)
 id 1wPjFa-00000003txU-0N2x for amd-gfx@lists.freedesktop.org;
 Wed, 20 May 2026 08:54:26 -0700
Received: from antispam.valve.org (127.0.0.1) id h1ncj40171s7 for
 <amd-gfx@lists.freedesktop.org>;
 Wed, 20 May 2026 08:54:26 -0700 (envelope-from <peihsiny@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
 by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
 with ESMTP id o202605201554250020756-5; Wed, 20 May 2026 08:54:25 -0700
Received: from mail2.valvemail.org (172.16.144.23) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 20 May
 2026 08:54:25 -0700
Received: from mail2.valvemail.org ([::1]) by mail2.valvemail.org ([::1]) with
 mapi id 15.02.2562.017; Wed, 20 May 2026 08:54:25 -0700
From: Pei-Hsin Yang <peihsiny@valvesoftware.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Topic: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Index: AdznyYW5KuL81IotTPmWr+1olc6y4wAnk9yAAAH0cTA=
Date: Wed, 20 May 2026 15:54:25 +0000
Message-ID: <16231b1742004f848af243ce398281ec@valvesoftware.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
In-Reply-To: <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.19.68]
MIME-Version: 1.0
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260520005434; ds20230628172248;
 di20260507172443; ri20160318003319; fs20260520154049
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: peihsiny@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202605201554250020756
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dOSOfUGL2j4dixIis34BHnbTpDpIBN9t-_OJQRWXfx4_1779292466
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:28 +0000
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

SGkgTWljaGVsLA0KDQo+IFRlc3RlZCB3aXRoIDMgSERNSSBzaW5rcyB3aXRoIGRpZmZlcmVudCBG
cmVlU3luYy9IRE1JIFZSUiBjYXBhYmlsaXRpZXMuICBJIHNhdyBvbmUgY2FzZSB0aGF0IGEgRnJl
ZVN5bmMgc2luayAoRGVsbCBTMjcyMUhTKSB3aXRoIEU2aCBWQ1AgY29kZSBzdXBwb3J0ZWQgd2Fz
IGRldGVjdGVkIGFzIEZyZWVTeW5jIGNhcGFibGUgYXQgYmVnaW5uaW5nIGJ1dCBpZGVudGlmaWVk
IGFzIG5vdCBGcmVlU3luYyBjYXBhYmxlIGxhdGVyIOKAkyBhZnRlciBkb19tY2NzIGlzIGNoYW5n
ZWQgZnJvbSB0cnVlIHRvIGZhbHNlLg0KDQo+PiBBbmQgdGhhdCBkb2Vzbid0IGhhcHBlbiB3aXRo
b3V0IG15IHBhdGNoIGFwcGxpZWQ/DQoNClRoZXJlIGFyZSBvdGhlciBpc3N1ZXMgd2l0aG91dCB5
b3VyIHBhdGNoIGFwcGxpZWQuICAgT25lIGlzc3VlIGlzIHRoYXQgaWYgYSBGcmVlU3luYyBjYXBh
YmxlIHNpbmsgd2l0aCBNQ0NTIFZDUCBDb2RlID0gMCAobW9zdGx5IGFyZSBUVnMpLCBpdCB3aWxs
IGJlIGRldGVjdGVkIGFzIG5vdCBGcmVlU3luYyBzdXBwb3J0ZWQgYW5kIFZSUiB3aWxsIGJlIGRp
c2FibGVkLg0KDQo+PiBUQkggSSBkb24ndCByZWFsbHkgd2FudCB0byBiZSBmaXhpbmcgdGhlIHJl
Z3Jlc3Npb24gSSBoaXQsIEknZCBwcmVmZXIgdGhlIEFNRCBkaXNwbGF5IHRlYW0gdG8gaGFuZGxl
IGl0Lg0KDQpZZXMsIGFncmVlZC4gIEFzIEZyZWVTeW5jIE1DQ1Mgc3VwcG9ydCBoYXMgaW1tZWRp
YXRlIGltcGFjdHMgdG8gVmFsdmUncyBTdGVhbSBkZXZpY2VzLCBJIHdpbGwgd29yayB3aXRoIEFN
RCBkaXNwbGF5IHRlYW0gdG8gaGFuZGxlIGl0LiAgIEhETUkgMi4xIFZSUiBhbmQgVlRFTSBwYWNr
ZXQgc2VuZGluZyBzdXBwb3J0IG5lZWQgdG8gYmUgaW5jbHVkZWQgYXMgd2VsbC4NCg0KVGhhbmtz
LA0KUGVpLUhzaW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1pY2hlbCBE
w6RuemVyIDxtaWNoZWwuZGFlbnplckBtYWlsYm94Lm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIE1h
eSAyMCwgMjAyNiAxMjo0OSBBTQ0KVG86IFBlaS1Ic2luIFlhbmcgPHBlaWhzaW55QHZhbHZlc29m
dHdhcmUuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBb
RXh0ZXJuYWwgTWFpbF0gUmU6IFRlc3QgcmVzdWx0IC8gZmluZGluZyBvZiAiZHJtL2FtZC9kaXNw
bGF5OiBDb25zdWx0IE1DQ1MgRnJlZVN5bmMgY2FwIG9ubHkgaWYgcmVxdWVzdGVkICYgc3VwcG9y
dGVkIg0KDQpPbiA1LzE5LzI2IDIyOjEyLCBQZWktSHNpbiBZYW5nIHdyb3RlOg0KPiANCj4gSGVy
ZSBpcyBteSB0ZXN0IHJlc3VsdCBhbmQgZmluZGluZyBhZnRlciBhcHBseWluZyBNaWNoZWwgRMOk
bnplcuKAmXMgcGF0Y2ggb24gTWF5IDE4LCAyMDI2IHRvIFN0ZWFtT1MgNi4xNiBicmFuY2guDQo+
IA0KPiDCoA0KPiANCj4gQXBwbGllZCBwYXRjaCBmcm9tIE1pY2hhZWwgRMOkbnplciB0byBTdGVh
bU9TIDYuMTYuDQo+IA0KPiDCoA0KPiANCj4gVGVzdGVkIHdpdGggMyBIRE1JIHNpbmtzIHdpdGgg
ZGlmZmVyZW50IEZyZWVTeW5jL0hETUkgVlJSIGNhcGFiaWxpdGllcy7CoCBJIHNhdyBvbmUgY2Fz
ZSB0aGF0IGEgRnJlZVN5bmMgc2luayAoRGVsbCBTMjcyMUhTKSB3aXRoIEU2aCBWQ1AgY29kZSBz
dXBwb3J0ZWQgd2FzIGRldGVjdGVkIGFzIEZyZWVTeW5jIGNhcGFibGUgYXQgYmVnaW5uaW5nIGJ1
dCBpZGVudGlmaWVkIGFzIG5vdCBGcmVlU3luYyBjYXBhYmxlIGxhdGVyIOKAkyBhZnRlciBkb19t
Y2NzIGlzIGNoYW5nZWQgZnJvbSB0cnVlIHRvIGZhbHNlLg0KDQpBbmQgdGhhdCBkb2Vzbid0IGhh
cHBlbiB3aXRob3V0IG15IHBhdGNoIGFwcGxpZWQ/DQoNCg0KPiBJIHVuZGVyc3Rvb2QgdGhlIHJl
Y2VudCBpbXBsZW1lbnRhdGlvbiB0byBkZXRlcm1pbmUgZnJlZXN5bmNfY2FwYWJsZSBpcyB0cnVz
dGluZyBoYXJkd2FyZSAodmlhIE1DQ1MgVkNQIHRyYW5zYWN0aW9uKSBvdmVyIEVESUQuwqAgQnV0
IGluIHJlYWwgd29ybGQgYXBwbGljYXRpb24sIGl0IGRvZXMgY2F1c2UgY2VydGFpbiBmYWxzZSBk
ZXRlY3Rpb24gdG8gaW5hZHZlcnRlbnRseSBkaXNhYmxlIHRoZSBWUlIuDQo+IA0KPiDCoA0KPiAN
Cj4gTXkgb3BpbmlvbiBpczogSWYgRURJRCBoYXMgQU1EIEZyZWVTeW5jIFZTREIgc3BlY2lmaWVk
IHdpdGggdmFsaWQgcmVmcmVzaCByYXRlIHJhbmdlLCB0aGVuIGl0IHNob3VsZCBiZSBkZXRlcm1p
bmVkIGFzIEZyZWVTeW5jIGNhcGFibGUuwqAgQXMgZm9yIE1DQ1MgVkNQIENvZGUgc3VwcG9ydCwg
aXQgaXMgdXNlZCB0byBzZW5kIFNldCBjb21tYW5kIHRvIHNpbmsgdG8gZW5hYmxlL2Rpc2FibGUg
dGhlIFZSUiBoYW5kbGluZy7CoCBSZXN1bHQgb2YgZG1faGVscGVyc19yZWFkX21jY3NfY2Fwcygp
IGF0IHJ1bnRpbWUgc2hvdWxkIG5vdCBvdmVycmlkZSB0aGUgZnJlZXN5bmNfY2FwYWJsZSB2YWx1
ZS7CoCBCZWNhdXNlIHRoZSBpbXBhY3Qgb2YgTUNDUyBWQ1AgQ29kZSBTZXQgY29tbWFuZCBmYWls
dXJlIGlzIHNpZ25pZmljYW50bHkgbG93ZXIgdGhhbiB0aGUgZGlzYWJsaW5nIFZSUiB3aGVuIHNp
bmsgaXMgY2FwYWJsZS4NCg0KSSBiYXNpY2FsbHkgYWdyZWUuDQoNCg0KVEJIIEkgZG9uJ3QgcmVh
bGx5IHdhbnQgdG8gYmUgZml4aW5nIHRoZSByZWdyZXNzaW9uIEkgaGl0LCBJJ2QgcHJlZmVyIHRo
ZSBBTUQgZGlzcGxheSB0ZWFtIHRvIGhhbmRsZSBpdC4NCg0KDQotLSANCkVhcnRobGluZyBNaWNo
ZWwgRMOkbnplciAgICAgICBcICAgICAgICBHTk9NRSAvIFh3YXlsYW5kIC8gTWVzYSBkZXZlbG9w
ZXINCmh0dHBzOi8vcmVkaGF0LmNvbSAgICAgICAgICAgICBcICAgICAgICAgICAgICAgTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdA0KDQo=

