Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C893CD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 07:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2BF11A4F1;
	Fri,  5 Jun 2026 07:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="EzYF49oQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-172.mimecast.com
 (us-smtp-delivery-172.mimecast.com [170.10.133.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AA311A1F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
 s=mc20150811; t=1780593680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZAZYCtRlc8SNcehVszFyDOwikU59Ywhqv6lyqh0UPM=;
 b=EzYF49oQfPAWOoBdhXj+cKorj2WNKcqm9uvMdSC0jDt9L6RVvJU809bRS00f/cR2t/hqN+
 xZwCRRPL1DIfdj0iGUzZ9C5S9pM/SyGkFCafPx6B848qYIUP/AAJnAW+fHg0hFFu5xhnG3
 3BQwsIJpuN1+p+LCQB5Vby5CixvoqvQ=
Received: from smtp-01-tuk3.valvesoftware.com
 (smtp-01-tuk3.valvesoftware.com [208.64.203.181]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-294-nb7TI3oHOJCY28Uifi0kcA-1; Thu, 04 Jun 2026 13:21:17 -0400
X-MC-Unique: nb7TI3oHOJCY28Uifi0kcA-1
X-Mimecast-MFC-AGG-ID: nb7TI3oHOJCY28Uifi0kcA_1780593677
Received: from antispam.valve.org ([172.16.1.107])
 by smtp-01-tuk3.valvesoftware.com with esmtp (Exim 4.97)
 (envelope-from <peihsiny@valvesoftware.com>)
 id 1wVBkq-00000008XsH-3iMS for amd-gfx@lists.freedesktop.org;
 Thu, 04 Jun 2026 10:21:16 -0700
Received: from antispam.valve.org (127.0.0.1) id h46q0o0171sa for
 <amd-gfx@lists.freedesktop.org>;
 Thu, 4 Jun 2026 10:21:16 -0700 (envelope-from <peihsiny@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
 by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
 with ESMTP id o202606041721160053737-5; Thu, 04 Jun 2026 10:21:16 -0700
Received: from mail2.valvemail.org (172.16.144.23) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Jun
 2026 10:21:16 -0700
Received: from mail2.valvemail.org ([::1]) by mail2.valvemail.org ([::1]) with
 mapi id 15.02.2562.017; Thu, 4 Jun 2026 10:21:16 -0700
From: Pei-Hsin Yang <peihsiny@valvesoftware.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>, "Alex
 Deucher" <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, 
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Linux kernel regressions list
 <regressions@lists.linux.dev>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Topic: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
Thread-Index: AdznyYW5KuL81IotTPmWr+1olc6y4wAnk9yAAAH0cTAALvV0AAForM+AABaOgIABQfl5gAAL1UIAAAFNC4AACERGsA==
Date: Thu, 4 Jun 2026 17:21:16 +0000
Message-ID: <399d0170414b4304823e866b04ab518a@valvesoftware.com>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <1c522568-1d5e-4210-8f25-1aa96e0d3c3a@leemhuis.info>
 <BL1PR12MB51447AB016BB28843BAD0216F7092@BL1PR12MB5144.namprd12.prod.outlook.com>
 <af4dff0f-0c62-4a7d-9a3f-fc029c8757f4@mailbox.org>
 <CADnq5_O9xMagapKQSO-6waXtmmFkDV-47ExVaNuiZd2xVdhefw@mail.gmail.com>
 <39ff584f-66ed-421a-918b-347d020a393a@mailbox.org>
In-Reply-To: <39ff584f-66ed-421a-918b-347d020a393a@mailbox.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.11.24]
MIME-Version: 1.0
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20260603144725; ds20230628172248;
 di20260526173604; ri20160318003319; fs20260604170745
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: peihsiny@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202606041721160053737
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jzx5pNs6my3lMRBEncBEDR2KBMtU-eTw89l5iVpFMfw_1780593677
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:35:12 +0000
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

SGkgTWljaGVsLA0KDQo+IE5vdGUgdGhhdCBQZWktSHNpbiByZXBvcnRlZCBhbiBpc3N1ZSB3aGVu
IHJ1bm5pbmcgd2l0aCBteSBmaXggYXQgdGhlIHN0YXJ0IG9mIHRoaXMgdGhyZWFkLCB1bmZvcnR1
bmF0ZWx5IGl0J3Mgc3RpbGwgdW5jbGVhciBpZiB0aGF0J3MgYSByZWdyZXNzaW9uIG9mID4gbXkg
Zml4IG9yIGhhcHBlbnMgZXZlbiB3aXRob3V0IGl0IChpbiB3aGljaCBjYXNlIGl0IG1pZ2h0IGJl
IGFub3RoZXIgcmVncmVzc2lvbiBvZiB0aGUgTUNDUyByZWxhdGVkIGNoYW5nZXMgZm9yIDcuMSku
DQoNCkFzIEkgaGF2ZSBtZW50aW9uZWQgZWFybGllciwgbXkgdGVzdGluZyBvZiB5b3VyIHBhdGNo
IGNvbmZpcm1zIHRoYXQgaXQgaXMgYSByZWdyZXNzaW9uIGV2ZW4gd2l0aG91dCB5b3VyIHBhdGNo
Lg0KDQpUaGVyZSBhcmUgdHdvIHJlbGlhYmlsaXR5IG1hdHRlcnMgaW4gbW9zdCByZWNlbnQgRnJl
ZVN5bmMgLyBNQ0NTIGltcGxlbWVudGF0aW9uIG5lZWQgZnVydGhlciBjbGFyaWZpY2F0aW9uIGZy
b20gdGhlIEFNRCB0ZWFtLiAgZnJlZXN5bmNfY2FwYWJsZSBvciBNQ0NTIHN1cHBvcnQgYXJlIGlu
YWR2ZXJ0ZW50bHkgZGlzYWJsZWQgb24gc29tZSBvY2Nhc2lvbnMsIGZvciBleGFtcGxlLCBhZnRl
ciBIRE1JIGNhYmxlIGhvdCBwbHVnLg0KDQoxLiBBTUQgVlNEQiBFRElEIHBhcnNpbmcgdmlhIGlu
dGVybmFsIGRtdWIgY29tbXVuaWNhdGlvbi4NCjIuIEFNRCBNQ0NTIFZDUCBDb2RlIGhlbHBlcnMu
DQoNCk5PVEU6IEkgZm91bmQgdGhlc2UgaXNzdWVzIGFmdGVyIGJhY2twb3J0aW5nIGZyb20gYXNk
biA3LnggdG8gU3RlYW1PUyA2LjE2LzYuMTguICBJdCBpcyB2ZXJpZmllZCBvbiBTdGVhbSBNYWNo
aW5lLg0KDQpUaGFua3MsDQpQZWktSHNpbg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAbWFpbGJveC5vcmc+IA0KU2Vu
dDogVGh1cnNkYXksIEp1bmUgNCwgMjAyNiA2OjU4IEFNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgVGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmlu
Zm8+OyBQZWktSHNpbiBZYW5nIDxwZWloc2lueUB2YWx2ZXNvZnR3YXJlLmNvbT47IFdlbnRsYW5k
LCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4gcGVuZyAoTGVvKSA8U3Vu
cGVuZy5MaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpbnV4IGtl
cm5lbCByZWdyZXNzaW9ucyBsaXN0IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogW0V4dGVy
bmFsIE1haWxdIFJlOiBUZXN0IHJlc3VsdCAvIGZpbmRpbmcgb2YgImRybS9hbWQvZGlzcGxheTog
Q29uc3VsdCBNQ0NTIEZyZWVTeW5jIGNhcCBvbmx5IGlmIHJlcXVlc3RlZCAmIHN1cHBvcnRlZCIN
Cg0KT24gNi80LzI2IDE1OjIwLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE9uIFRodSwgSnVuIDQs
IDIwMjYgYXQgMzo1OeKAr0FNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBtYWlsYm94
Lm9yZz4gd3JvdGU6DQo+PiBPbiA1LzI5LzI2IDAwOjAyLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3Jv
dGU6DQo+Pj4+IEZyb206IFRob3JzdGVuIExlZW1odWlzIDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5p
bmZvPiBPbiA1LzIxLzI2IA0KPj4+PiAwOTowOSwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+Pj4+
Pg0KPj4+Pj4gTm90ZSB0aGF0IHNvbWUga2luZCBvZiBzaG9ydC10ZXJtIHNvbHV0aW9uIGlzIG5l
ZWRlZCBmb3IgdGhlIA0KPj4+Pj4gcmVncmVzc2lvbihzKSBpbg0KPj4+PiA3LjEtcmMuDQo+Pj4+
DQo+Pj4+IFllYWgsIHRoYXQgd291bGQgYmUgZ29vZC4gTWFrZXMgbWUgd29uZGVyIGhvdyB0aGUg
cm91Z2ggcGxhbiB0byANCj4+Pj4gcmVhbGl6ZSB0aGlzIGxvb2tzIGxpa2U/IFNvdW5kcyBsaWtl
IE1pY2hhZWwncyBwYXRjaFsxXSB0aGF0IHdhcyANCj4+Pj4gZGlzY3Vzc2VkIGhlcmUgaXMgbm90
IGEgZ29vZCBvcHRpb24/IFJlbWluZGVyLCBMaW51cyBpZGVhbGx5IHdhbnRzIA0KPj4+PiBrbm93
biByZWdyZXNzaW9uIGZpeGVkIGJ5IC1yYzYsIHdoaWNoIGlzIHdoeSBJJ20gYXNraW5nLg0KPj4+
DQo+Pj4gQFdlbnRsYW5kLCBIYXJyeSBjYW4geW91IHNvcnQgdGhpcyBvdXQgZm9yIG5leHQgd2Vl
aydzIC1maXhlcyBQUj8NCj4+DQo+PiBMb29rcyBsaWtlIHRoaXMgcmVncmVzc2lvbiB3aWxsIG1h
a2UgaXQgdG8gNy4xIGZpbmFsPw0KPj4NCj4+IEkgZmlsZWQgaHR0cHM6Ly9naXRsYWIuZnJlZWRl
c2t0b3Aub3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zLzUyODYgMyB3ZWVrcyBhZ28sIGFuZCBwcm9w
b3NlZCBhIGZpeCB0aGUgZm9sbG93aW5nIHdlZWsuIFRoZXJlJ3MgYmVlbiBubyByZWFjdGlvbiBi
eSBhbnkgQU1EIGRpc3BsYXkgZGV2ZWxvcGVyLg0KPj4NCj4+IFRoaXMgaXMgcHJldHR5IHNhZC4N
Cj4gDQo+IEBXZW50bGFuZCwgSGFycnkgLCBATGVvIChTdW5wZW5nKSBMaSBjb21lIG9uIGd1eXMh
ICBJJ3ZlIHBpY2tlZCB1cCANCj4gTWljaGVsJ3MgcGF0Y2ggYW5kIEknbGwgc2VuZCBhbiB1cGRh
dGUgLVBSIHRvZGF5Lg0KDQpUaGFua3MgQWxleC4NCg0KDQpOb3RlIHRoYXQgUGVpLUhzaW4gcmVw
b3J0ZWQgYW4gaXNzdWUgd2hlbiBydW5uaW5nIHdpdGggbXkgZml4IGF0IHRoZSBzdGFydCBvZiB0
aGlzIHRocmVhZCwgdW5mb3J0dW5hdGVseSBpdCdzIHN0aWxsIHVuY2xlYXIgaWYgdGhhdCdzIGEg
cmVncmVzc2lvbiBvZiBteSBmaXggb3IgaGFwcGVucyBldmVuIHdpdGhvdXQgaXQgKGluIHdoaWNo
IGNhc2UgaXQgbWlnaHQgYmUgYW5vdGhlciByZWdyZXNzaW9uIG9mIHRoZSBNQ0NTIHJlbGF0ZWQg
Y2hhbmdlcyBmb3IgNy4xKS4NCg0KQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUgcmV2ZXJ0aW5nIHRo
ZSA0IGNvbW1pdHMgZDQ5MDg2NDkxYmNiLi44ZGM4OGM2YTU5NDguDQoNCg0KLS0gDQpFYXJ0aGxp
bmcgTWljaGVsIETDpG56ZXIgICAgICAgXCAgICAgICAgR05PTUUgLyBYd2F5bGFuZCAvIE1lc2Eg
ZGV2ZWxvcGVyDQpodHRwczovL3JlZGhhdC5jb20gICAgICAgICAgICAgXCAgICAgICAgICAgICAg
IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QNCg0K

