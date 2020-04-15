Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325EC3815B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B3C20575
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zCvHKRv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B3C20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0326D6E974;
	Wed, 15 Apr 2020 11:27:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FFD6E974
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 11:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dACnjOxe65reyh+twb1xBCdBKWt8kcTUn+6Bz4Rh2FNy9vkDvgvEPnqDGbyamzcdbauIu/Imj7pfLm1NfVvrSlY+9PHT7raDR/deiDl/NUsAb77YKcQ0q6JIYTTziMyHt6c8QT9auYrqWuSJVE/0pVT4Il9FNYuKY0gSoHQFo7Men9+aDpaZIYRtfx9yxK/8CNpQFqod006fDoAQzUqmed2NBpzLnwzW0iD2FOl4k2aP6Tl64cMTWH/bxr++O+L3ZyPGKWfOgC4kxJ73I8JAI4jem3mXDAsQ+RgFduXG3uPZYiiJX9gLGkhubIELh5w4M9PDSKAWFnrc82HG4NJQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa1eQEWiRV+R5eJ0VeIT1JMFWPmf7DGz4PzXcdmj0og=;
 b=HJCrOq6sz/6NkG+5h2PV6pGTQOenwg7zVUUcztkSUtuWcZiaNI1WJ4PLYLkwIBwW6cymyMsOocuBsbiirvGrKk+0yqtVi1ne0cYCjBHQ9Fbln7BoRoAYFr8TedBA8gRITik7XMrVIfkszBjPM7TLyebziwlyV3w3KsKm/sgQgkO/Ry4Zf6w0EWfsAmgLkTJYGvtz+2FIpd1xYcfvQSgkGkzOPhEJcUj4K2d4dyzr+Y9Ivwbxd1aLymFi4SLSgne7qyasnOEzuXatCw65+f+Og0v1zMhUz+HJYGf2SXAHgdMFeLEWAwJ/E0fA/z2QjusB4oNHnoFZho9fHlQBhSuyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa1eQEWiRV+R5eJ0VeIT1JMFWPmf7DGz4PzXcdmj0og=;
 b=zCvHKRv7aXs3xAXaIH26mFZhZCHls4zF1ZtowOr1yGCPolPStgIcY4vCQZlcfX/nxdog2SyfBLbuFzhok6dsil/a3gayaoKkDnD6D+d1ScWoNW+x9wPPwd8kYalGtG5urgBeevJ7/4eBvTolZUZfYrEeVLKRsU8zbTIvJqNoTt8=
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 11:27:16 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::5a1:1ed8:9866:e1dc%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 11:27:16 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElT5MMa9hF5D/kyPXcmir4uROah4q6cAgAAISgCAAAIWAIAAyrKAgACLilA=
Date: Wed, 15 Apr 2020 11:27:16 +0000
Message-ID: <MN2PR12MB289650886705D4BB2185C90DFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
 <MN2PR12MB40785C6264E06349DAC18DB2FCDB0@MN2PR12MB4078.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB40785C6264E06349DAC18DB2FCDB0@MN2PR12MB4078.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T03:05:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c49aabf-e335-4b21-ae1f-0000b7e4fce9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T11:27:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f041a069-2970-4834-9232-00007f35b3c4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: addebe14-297a-4659-3dac-08d7e12ff3bf
x-ms-traffictypediagnostic: MN2PR12MB4112:|MN2PR12MB4112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4112B953EFF15E8146354A7CFDDB0@MN2PR12MB4112.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(64756008)(110136005)(66556008)(66476007)(76116006)(316002)(7696005)(54906003)(6506007)(186003)(53546011)(26005)(66446008)(4326008)(5660300002)(66946007)(81156014)(8676002)(55016002)(83080400001)(9686003)(52536014)(45080400002)(33656002)(2906002)(71200400001)(478600001)(86362001)(8936002)(966005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 177MeaDgEGHCpCzKxgHEIIsmRiT8XVXsUGH+Uu7KMugqxmQykT1m8T2PtUX3qpmMQ4M48x2yQvpWMHCMMfqyO9/xxebO4ifi5krLjfIjvAQru8rLlbOu4OtKx3TpVz5gERfgDumsh/Pg/aZwv6VpALtyiEDPQbJ/gYLewHNkVOUrIIf+e8VJDVGU+AkEX4DvISWT12VxOZ9qtp18TcrB2XThEubCCukbqFdizOeVSPJ760nmNfQaoYEn8afrbQHwIRSfw/jNZNtjRmKZx8dOnle2nPfq/xYK2p84y0zAOVSF2THy7UdI9rjx4i5McTGbap36881Up+suqhX5GVXTT8bF2Hj0UtT3gHC8hfKO5bStHL0kEDElMUxzsiK/7GsZmsRYz7W9B7GDRIJlP4uWcxTk2m/bCCkQsizdJ34RAypJFY0HIAZrRyDrTy7zJ/K/PuPETHrPPjVABKNR24NN2D7m4ZivZjaPqkQ/ATzJbV7n5EIGve+Wb4i32E8D8rSRKJddJ73Zmlk45Y3kOV1YXQ==
x-ms-exchange-antispam-messagedata: tO33N83vncK++f1BtVtVfQSKQV52wqlOi6zJKAw5Jv2fEL4PoHz6V+PJ6KIp2oFiDuWmgLk2LFAFl3gJTowu1W/5UJdiodCIl1JgcsmXkdNxDzJEO0B3ld8hjsHMRLznpePBZlWLtxYqzzVa8tJJlA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addebe14-297a-4659-3dac-08d7e12ff3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 11:27:16.3704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZIV3WtrtwWyBLkU12oz8TUoL80VLbjKL2wKtb1gUd6TFlKY/E5O3YkSAghft0HUoFl9Ql0bWZvcoFxqhWApVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpB
ZnRlciBkcm9wIHRoaXMgV0EsDQpJdCBjYW4ndCBlbnRlciBHRlhPRkYgb24gcmF2ZW4yLiANCkFu
ZCBpdCBjYW4ndCBydW4gUzMgc3VjY2Vzc2Z1bGx5IG9uIFBpY2Fzc28gYW5kIHJhdmVuMS4NCg0K
SSBzdWdnZXN0IHRoYXQgaXQgY2FuIGFkZCBjaGlwIHR5cGUgYW5kIGRyb3AgdGhpcyBXQSBvbmx5
IG9uIHJlbm9pci4NCg0KQlIsDQpDaGFuZ2ZlbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAyMCAxMTowNSBBTQ0KVG86IFpodSwgSmFtZXMgPEphbWVz
LlpodUBhbWQuY29tPjsgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBaaHUs
IENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3Vi
amVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdS92Y246IGZpeCBnZnhvZmYgaXNzdWUNCg0KW0FN
RCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpUaGlz
IGFjdHVhbGx5IGludHJvZHVjZWQgYXQgdmVyeSBlYXJseSBzdGFnZSB3ZSBlbmFibGVkIEdGWE9G
RiBmb3IgdGhlIGZpcnN0IHRpbWUgb24gUmF2ZW4gcGxhdGZvcm0uIEF0IHRoYXQgdGltZSBnZnhv
ZmYgY2FuJ3Qgd29yayB3aXRoIFZpZGVvIHBsYXkgYmFjayAodGhpcyBpcyBnZW5lcmFsIGlzc3Vl
IGFjcm9zcyBhbGwgT1NlcykuIFNvIHdlIGRpc2FibGVkIGdmeG9mZiB3aGVuIHRoZXJlIGlzIHdv
cmtsb2FkIG9uIFZDTi4NCg0KRm9yIG1vc3QgQVNJQ3MsIGl0IHNoYWxsIGJlIHJlbW92ZWQuIFRo
ZSBvbmx5IGNvbmNlcm4gaXMgc29tZSBvbGQgUmF2ZW4gcGxhdGZvcm0gd2hlcmUgdGhlIHJsYyBm
dyBmaXhlcyBhcmUgbm90IGF2YWlsYWJsZS4gDQoNCkkgaGFkIGEgcXVpY2sgY2hhdCB3aXRoIEBa
aHUsIENoYW5nZmVuZyB3aG8gd2lsbCBoYXZlIGEgcXVpY2sgdmFsaWRhdGlvbiBvbiBoaXMgb2xk
IFJhdmVuIHBsYXRmb3JtIHNvIHRoYXQgd2UgY2FuIHNhZmVseSByZW1vdmUgdGhpcyB3b3JrYXJv
dW5kIGZpbmFsbHkuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+DQpTZW50OiBUdWVzZGF5
LCBBcHJpbCAxNCwgMjAyMCAyMzowMA0KVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPjsgWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+OyBaaHUsIENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS92Y246IGZpeCBnZnhvZmYgaXNzdWUNCg0K
K0hhd2tpbmcNCg0KSGkgSGF3a2luZywNCg0KY2FuIHdlIGRyb3AgdGhpcyBXQT8NCg0KVGhhbmtz
IQ0KDQpKYW1lcw0KDQpPbiAyMDIwLTA0LTE0IDEwOjUyIGEubS4sIEphbWVzIFpodSB3cm90ZToN
Cj4gK1JleA0KPg0KPiBUaGlzIGlzIGludHJvZHVjZSBieSBiZWxvdyBwYXRjaC4NCj4NCj4gY29t
bWl0IDNmZGVkMjIyZjRiZjdmNGM1NmVmNDg1NDg3MmEzOWE0ZGUwOGY3YTgNCj4gQXV0aG9yOiBS
ZXggWmh1IDxSZXguWmh1QGFtZC5jb20+DQo+IERhdGU6wqDCoCBGcmkgSnVsIDI3IDE3OjAwOjAy
IDIwMTggKzA4MDANCj4NCj4gwqDCoMKgIGRybS9hbWRncHU6IERpc2FibGUgZ2Z4IG9mZiBpZiBW
Q04gaXMgYnVzeQ0KPg0KPiDCoMKgwqAgdGhpcyBwYXRjaCBpcyBhIHdvcmthcm91bmQgZm9yIHRo
ZSBncHUgaGFuZw0KPiDCoMKgwqAgYXQgdmlkZW8gYmVnaW4vZW5kIHRpbWUgaWYgZ2Z4IG9mZiBp
cyBlbmFibGVkLg0KPg0KPiDCoMKgwqAgUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4NCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5a
aHVAYW1kLmNvbT4NCj4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4NCj4gT24gMjAyMC0wNC0xNCAxMDoyMiBhLm0uLCBB
bGV4IERldWNoZXIgd3JvdGU6DQo+PiBPbiBUdWUsIEFwciAxNCwgMjAyMCBhdCA4OjA1IEFNIEph
bWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+IHdyb3RlOg0KPj4+IFR1cm4gb2ZmIGdmeG9mZiBj
b250cm9sIHdoZW4gdmNuIGlzIGdhdGVkLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMg
Wmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA4ICsrKysrLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPj4+IGluZGV4IGRhYjM0ZjYuLmFhOWE3
YTUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+
Pj4gQEAgLTM2OSw5ICszNjksMTEgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0
cnVjdCANCj4+PiBhbWRncHVfcmluZyAqcmluZykgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZh
ZGV2LT52Y24uaWRsZV93b3JrKTsNCj4+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9j
aygmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsNCj4+PiAtwqDCoMKgwqDCoMKgIGFtZGdwdV9nZnhf
b2ZmX2N0cmwoYWRldiwgZmFsc2UpOw0KPj4+IC3CoMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV9p
cF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwNCj4+PiBBTURfSVBfQkxPQ0tfVFlQRV9WQ04s
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNRF9QR19TVEFURV9VTkdBVEUpOw0K
Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnZjbi5jdXJfc3RhdGUgPT0gQU1EX1BHX1NUQVRF
X0dBVEUpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZ2Z4X29m
Zl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
bWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LA0KPj4+IEFNRF9JUF9C
TE9DS19UWVBFX1ZDTiwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEFNRF9QR19TVEFURV9VTkdBVEUpOw0KPj4+ICvCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+
PiBXaHkgYXJlIHdlIHRvdWNoaW5nIGdmeG9mZiB3aXRoIFZDTj/CoCBXYXMgdGhpcyBhIGxlZnRv
dmVyIGZyb20gYnJpbmcgDQo+PiB1cD/CoCBDYW4gd2UganVzdCBkcm9wIGFsbCBvZiB0aGlzIGdm
eG9mZiBzdHVmZiBmcm9tIFZDTiBoYW5kbGluZz/CoCBJIA0KPj4gZG9uJ3Qgc2VlIHdoeSB0aGVy
ZSB3b3VsZCBiZSBhIGRlcGVuZGVuY3kuDQo+Pg0KPj4gQWxleA0KPj4NCj4+PiDCoMKgwqDCoMKg
wqDCoMKgIGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpwqDCoMKg
IHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHBnX3BhdXNl
X3N0YXRlIG5ld19zdGF0ZTsNCj4+PiAtLQ0KPj4+IDIuNy40DQo+Pj4NCj4+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0DQo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+PiBodHRwczovL25h
bTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
aQ0KPj4+IHN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElDQo+Pj4gN0NKYW1lcy5aaHUlNDBhbWQuY29tJTdDM2RkOTEzNWM3
MTdhNGIzMDExZTMwOGQ3ZTA3ZjUyYjYlN0MzZGQ4OTYxZmUNCj4+PiA0ODg0ZTYwOGUxMWE4MmQ5
OTRlMTgzZCU3QzAlN0MwJTdDNjM3MjI0NzA5NzYzMzkxODQ1JmFtcDtzZGF0YT1ZJTJCdA0KPj4+
IHNKUU5CMVRYQ1E5djg2RFclMkYwRkM2M2dPU0hzZnp6WkZ1ME1EdkNIdyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KPj4+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
