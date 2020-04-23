Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0961C54FCB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 13:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C2E20724
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FVT3Heap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C2E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486FF6E0B7;
	Thu, 23 Apr 2020 13:43:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C356B6E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 13:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6bNuAJlhoLKkWLm9tKcUg8YQJwO1vytMFrUxSiqu3a88MeKwofjl/mz5UHfPiay7Olry27tIhGauViGUEc+dgx/3iMHAFZpZoBtroZRGr0LPj/+rlPZ1hBu6536qfsU10Wvb6a55PMqjeQjj2hPmP9hPtFxP2SL3/LY+ezY/CCAnUy1/OnUIr+J69hZ3o+/oOx3LOqH/bSe9UhvFbnN8fk54IeIw4lW9FZZu1biXIpklnVtbjiPVFz4pgycKLZ4YBy0wF1mpYCAjggqHmailFxOV+o/Swx0ErWKZqtLRc/gt/BX71mRpv7wBJCGr8bWt5HVzkeI0zARZixWGlkv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En2u8cEI2zm3MRK0APPYO3FphBjgeiF38SYiwHDdU1w=;
 b=CBKu/xmUv7WWSkQ5RYtGh08n1hW01WDYAhE1GMdfXVu8RP/WTBkuyp7n1OsrXzmu0mmGH0Br1YnUvYZjI+XseJm9huWDq/nfN/yok9VZu9qSBEfnb9lQz3wb7Bw0/r7hhbxPfrzZ2rlcPw9qqxaDiHAXyfzQdJp0pijZD7OAXkL8g7cdCrFW/S89aun8OvZ7iVqZJMw1lh7+SCyqBx3+vyYzg+9/ZAd+vaTO6rTzTFwqPmer41sLQHtouhsZ3uJMYC/Hokxvn6RguhKbygp30+QJCJTr/Edit6R5cX6u30M6sd1iFa8oMsSk6Fs1KcVMVUsbb04He4263OR+RDH4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En2u8cEI2zm3MRK0APPYO3FphBjgeiF38SYiwHDdU1w=;
 b=FVT3HeapzfEXpBJR6l2j2m7sMxRH1im6Hd5a/GHbfNHOMiSyEvdWtjd8G81vdaiiKn0wEhGN6nUcaix7Mbw6NM+MeUpJRb4EN64+oQfZ4Z2s1bAerdW5hUx4u2t8HXjddXqCjUyuE/ooDUpq9aMAx8x4HT4/4dYPVo7lW1ym9I0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2745.namprd12.prod.outlook.com (2603:10b6:5:45::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Thu, 23 Apr 2020 13:43:09 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 13:43:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test
 failed
Thread-Topic: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test
 failed
Thread-Index: AQHWGU3brr73d+ixkUOhntzaNuMTJKiGo4QAgAAT3vA=
Date: Thu, 23 Apr 2020 13:43:09 +0000
Message-ID: <DM6PR12MB4075AD71C58D06670395B0EAFCD30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
 <fe584171-c45f-4b97-f141-5f2a516a88c2@gmail.com>
In-Reply-To: <fe584171-c45f-4b97-f141-5f2a516a88c2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-23T13:43:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fa9cf2f0-be5d-4fdb-aae1-0000acd3e4c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-23T13:43:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: aa5e2d5d-5c34-4584-89e3-000064b7c6ec
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 420fc4b0-e08b-4e31-e85c-08d7e78c42b3
x-ms-traffictypediagnostic: DM6PR12MB2745:|DM6PR12MB2745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2745EC9FE7D3F354C330A26FFCD30@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(53546011)(2906002)(478600001)(76116006)(6506007)(64756008)(66446008)(66946007)(5660300002)(33656002)(66476007)(66556008)(81156014)(8676002)(186003)(7696005)(8936002)(71200400001)(52536014)(110136005)(26005)(55016002)(316002)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QkIJeHy7k1XfRBpAILQJCk9f5Oil3nWWLLc0JMUWE6toGfqjLqYMpYeIVCAzE9QUrg216qBaTtw0bu+HrMVra1AJ81m4gN3hD/H5CdPnklyRj43dw7iIK4jELXQVgiCIIQ0nuJkRuBuZpvad6xrwad8UvBXBVvoJITduicx7I/ChCN/VY9OjxHwFwBqjmJfdWZiGg6avdoMXasHHHvTsgyUy1Ci2lr6GdiYlrOC+x/xVy26rPZzJbshHosl0mPrYnL+VjLn9XLtIf0OBF+xhypEJZ6yV6Ki+HPCZglqJ9ltImlrngcgRtTJm5msB4T3dxdhB1VOc5WxcVh2HlJdaqE5C4SIiZOe653i+BqoOJmhUG5ooXoV9VWX2ycSOtjHMR5BgHYSpp/UHTF8awTQEmg3lZJqOFyM7Lu9Xs/U6p2pGLjxyZ9JndfpoXhASJ0G
x-ms-exchange-antispam-messagedata: 63myqJUBBwlzt+pAF95OF9uwzoP8hut/8Fooi5kxoUX6zGYVz9T2aTf+HZaElpacZTQ4Gd20BHi3dQ0i+ZE9hpkdHlc+E0RzY5j6xUHt+MLbT2z0aTuD+g6NeZHnE3ndLkR8KYC0qPHmYBPl3jnkXw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420fc4b0-e08b-4e31-e85c-08d7e78c42b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 13:43:09.5842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnYyo40XvgjA//UfDig+wF1MnYhb7kfui45Dq9C8Ac4BWBuu9zjbBdh1x1Q/VRcbeiCKVMJgAU6Y+eWT5V446w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpX
b3VsZCB5b3UgbWluZCB0byBlbmFibGUgdGhpcyBhbmQgdHJ5IGl0IGFnYWluPyBUaGUgcmVjZW50
IGdwdSByZXNldCB0ZXN0aW5nIG9uIHZlZ2EyMCBsb29rcyB2ZXJ5IHBvc2l0aXZlLg0KDQpSZWdh
cmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlh
biBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAyMywgMjAyMCAyMDozMQ0KVG86IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHN0b3AgY3AgcmVzdW1lIHdoZW4gY29tcHV0ZSByaW5n
IHRlc3QgZmFpbGVkDQoNCkFtIDIzLjA0LjIwIHVtIDExOjAxIHNjaHJpZWIgSGF3a2luZyBaaGFu
ZzoNCj4gZHJpdmVyIHNob3VsZCBzdG9wIGNwIHJlc3VtZSBvbmNlIGNvbXB1dGUgcmluZyB0ZXN0
IGZhaWxlZA0KDQpNaG0gaW50ZW50aW9uYWxseSBpZ25vcmVkIHRob3NlIGVycm9ycyBiZWNhdXNl
IHRoZSBjb21wdXRlIHJpbmdzIHNvbWV0aW1lcyBkb2Vzbid0IGNvbWUgdXAgYWdhaW4gYWZ0ZXIg
YSBHUFUgcmVzZXQuDQoNCldlIGV2ZW4gaGF2ZSB0aGUgbmVjZXNzYXJ5IGxvZ2ljIGluIHRoZSBT
VyBzY2hlZHVsZXIgdG8gcmVkaXJlY3QgdGhlIGpvYnMgdG8gYW5vdGhlciBjb21wdXRlIHJpbmcg
d2hlbiBvbmUgZmFpbHMgdG8gY29tZSB1cCBhZ2Fpbi4NCg0KQ2hyaXN0aWFuLg0KDQo+DQo+IENo
YW5nZS1JZDogSTRjZDMzMjhmMzhlMDc1NWQwYzg3NzQ4NDkzNjEzMmQyMDRjOWZlNTANCj4gU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jIHwgNCArKystDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDQgKysrLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA0ICsrKy0NCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYw0KPiBpbmRleCBiMmYxMGUzLi5mY2VlNzU4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMNCj4gQEAgLTMxMzIsNyArMzEz
Miw5IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y3XzBfY3BfY29tcHV0ZV9yZXN1bWUoc3RydWN0IA0KPiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4
Lm51bV9jb21wdXRlX3JpbmdzOyBpKyspIHsNCj4gICAJCXJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1
dGVfcmluZ1tpXTsNCj4gLQkJYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7DQo+ICsJCXIg
PSBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsNCj4gKwkJaWYgKHIpDQo+ICsJCQlyZXR1
cm4gcjsNCj4gICAJfQ0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPiBpbmRleCA2YzU2Y2VkLi44ZGM4ZTkwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCj4gQEAgLTQ3ODEsNyArNDc4MSw5IEBA
IHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfY3BfdGVzdF9hbGxfcmluZ3Moc3RydWN0IA0KPiBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51bV9j
b21wdXRlX3JpbmdzOyBpKyspIHsNCj4gICAJCXJpbmcgPSAmYWRldi0+Z2Z4LmNvbXB1dGVfcmlu
Z1tpXTsNCj4gLQkJYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIocmluZyk7DQo+ICsJCXIgPSBhbWRn
cHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsNCj4gKwkJaWYgKHIpDQo+ICsJCQlyZXR1cm4gcjsN
Cj4gICAJfQ0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYw0KPiBpbmRleCAwOWFhNWY1Li4yMDkzNzA1OSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+IEBAIC0zODQ2LDcgKzM4NDYsOSBAQCBzdGF0
aWMgaW50IGdmeF92OV8wX2NwX3Jlc3VtZShzdHJ1Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3M7
IGkrKykgew0KPiAgIAkJcmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldOw0KPiAtCQlh
bWRncHVfcmluZ190ZXN0X2hlbHBlcihyaW5nKTsNCj4gKwkJciA9IGFtZGdwdV9yaW5nX3Rlc3Rf
aGVscGVyKHJpbmcpOw0KPiArCQlpZiAocikNCj4gKwkJCXJldHVybiByOw0KPiAgIAl9DQo+ICAg
DQo+ICAgCWdmeF92OV8wX2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQoYWRldiwgdHJ1ZSk7DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
