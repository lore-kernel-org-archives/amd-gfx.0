Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538BC43215
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32536206DC
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32536206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42006E373;
	Tue,  3 Dec 2019 02:47:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1856E373
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 02:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyL8dFkKS23TP9dMm/UNbCfEnnAuu2D3tWnQdti4jCk7q8vSmIV9vJCw9CqD0o9Py1i/JZY+uvR0mcLObgaYVY4Pa4x8s9EcVv+zoauuXnyo/S2SuSLkKoqDbZWHWbgAOZW6awOSsdhvgzPqe2eAullqZH6fbJveBdUph4Gyyi4+Fj3p9WIVki6eJaQ4NFNPqEfchzLsgl4E9lDVFoOs0zB7xHPt7Blv/eGFtVM6vyCh1sn1dT9w+qQxQZf61g0ae5LpA1udqNn//DfOZgv+Er+sS70WxQY6gS8fAPPwTTgzEVxexlXlJVD8RYy83iBInuKQriDEox68YqF2twZ4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x1EzMgTh8v+rB6+Yjh6tmvqyMYh4ML/tiVPguDI5mM=;
 b=Gak2MYnrsC4LdrqrYe+nX+66ZJ7vaefpKIVCPnp1UMp9KaaBV5k2Ef9iLE+/OWuwoAURIP0Zkyt8JiKfYSy3grEYFyGwFq3dTIYelXmfqefxSNaaNWS92wK41fmkN/aZAoOD4k3rxHq+0MmqAeoqBTpmqhOT6zs8SXrV6DtAedq2hk/PHSBDpx6MHciKiG7OOErSXhA9PAAa0sjkOE3rK3HiKQtoPq9CEAfKHzNfD1gmTg+qK9bhbBTNY5gtJYLjfy5foF7EapDcbK1hkHjDdp7nVsMQF6SXgT2/MXfMu84uXyah06dSr7n62mvZkgqMk/HdR8Cfv+/9hPlbywrnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB4326.namprd12.prod.outlook.com (20.180.16.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 02:47:11 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:47:11 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Topic: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Index: AQHVqQBrbxKqVIpFVE6sZB5cOr1m8KentWeAgAAATbA=
Date: Tue, 3 Dec 2019 02:47:11 +0000
Message-ID: <CH2PR12MB3672AE0ED2337D934C2D49BBBB420@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191202110519.3504-1-Jack.Zhang1@amd.com>
 <MN2PR12MB33443E4D35A2E56F584EFAECE4420@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33443E4D35A2E56F584EFAECE4420@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d1026164-0d2f-4b15-8098-0000ec740321;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-03T02:42:10Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ecbac79-776e-4305-e850-08d7779b1896
x-ms-traffictypediagnostic: CH2PR12MB4326:|CH2PR12MB4326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB43263F8AE49A493B3A461800BB420@CH2PR12MB4326.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(13464003)(189003)(199004)(55016002)(6436002)(6306002)(7736002)(305945005)(446003)(11346002)(86362001)(5660300002)(66066001)(45080400002)(66446008)(64756008)(6506007)(316002)(7696005)(229853002)(76176011)(14444005)(52536014)(53546011)(256004)(3846002)(66556008)(9686003)(186003)(66946007)(99286004)(66476007)(110136005)(26005)(76116006)(74316002)(102836004)(14454004)(478600001)(81156014)(81166006)(6246003)(966005)(8676002)(33656002)(2501003)(2906002)(8936002)(71200400001)(71190400001)(25786009)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4326;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpQbLALSLIeub3VSDKj97WlWtw2Uwr795qS2O6L7Y6zEX6CAowb4PG208YiTbnzupELoUZbe4lyYsbJVosm9geB1AjJpWtXHSotjescQhEWwK+YBxKDn6LJlI/Bf3oQ8YX+AoWgj642uZPnu0BCtEvoLI37FTXTz4LUQWHlPfHQ7PghGIHcA8S+4Ken/bKph7NX0Fn9Bk/itulWOXaZchi4nJ/PqvfwVyMuNpdf2vkrRqcG+Q0cfEu+qI3p1g0VrQP1PVBrBgNd1kBsStdJnof5ebUf531xyaRhIiH7Se18LI4IoeYFAidOnjC/yaQEdQADzPjatR5/JlRM5YhQ+UEBR5cu3Zs5iSVvVMn8KpvMUWqxbQ2K+f/KkhmHpBtgLETD/T9oZxn/1RcW1tzw9gm8hi4oK9xBzMjMVNsCjxOsThY01JzZEZZfSIebRuhMG
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecbac79-776e-4305-e850-08d7779b1896
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:47:11.0794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8zmDFACxjlk7d+JB8WoJFiEwMRL2OhozfeikngOgy7sR36dPcSrtGjrTvQAyTbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x1EzMgTh8v+rB6+Yjh6tmvqyMYh4ML/tiVPguDI5mM=;
 b=f0J/A2fY/Xr7VvL0tPhTafssUx4jDP7yiWmGz+SXOu2iyMpaW1bbS86/v+S03H4xCSkK6M1VXdV3gwdh923mvaEDGx49G5HWjYdsXSLagxCvEk2eGUOOpOOWlVbkMaP8GI5tvRD0NsWdH2YCeM4pvZe64Lrj05YCRU6KCTVm048=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

VGhhbmtzIEV2YW4sIEkgd2lsbCBhZGQgInsgfSIgYmVmb3JlIEkgY2hlY2staW4gdGhlIGNvZGUu
DQoNCkJlc3QsDQpKYWNrDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBRdWFu
LCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAzLCAy
MDE5IDEwOjQ1IEFNDQpUbzogWmhhbmcsIEphY2sgKEppYW4pIDxKYWNrLlpoYW5nMUBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSmFjayAoSmlhbikg
PEphY2suWmhhbmcxQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIXSBhbWQvYW1kZ3B1L3Ny
aW92IHN3U01VIGRpc2FibGUgZm9yIHNyaW92DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+IE9uIEJlaGFsZiBPZiANCj4gSmFjayBaaGFuZw0KPiBTZW50OiBNb25kYXksIERlY2Vt
YmVyIDIsIDIwMTkgNzowNSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IFpoYW5nLCBKYWNrIChKaWFuKSA8SmFjay5aaGFuZzFAYW1kLmNvbT4NCj4gU3ViamVj
dDogW1BBVENIXSBhbWQvYW1kZ3B1L3NyaW92IHN3U01VIGRpc2FibGUgZm9yIHNyaW92DQo+IA0K
PiBGb3IgYm9hcmRzIGdyZWF0ZXIgdGhhbiBBUkNUVVJVUywgYW5kIHVuZGVyIHNyaW92IHBsYXRm
b3JtLCBzd1NNVSBpcyANCj4gbm90IHN1cHBvcnRlZCBiZWNhdXNlIHNtdSBpcCBibG9jayBpcyBj
b21tZW50ZWQgYXQgZ3Vlc3QgZHJpdmVyLg0KPiANCj4gR2VuZXJhbGx5IGZvciBzcmlvdiwgaW5p
dGlhbGl6YXRpb24gb2Ygc211IGlzIG1vdmVkIHRvIGhvc3QgZHJpdmVyLg0KPiBUaHVzLCBzbXUg
c3dfaW5pdCBhbmQgaHdfaW5pdCB3aWxsIG5vdCBiZSBleGVjdXRlZCBhdCBndWVzdCBkcml2ZXIu
DQo+IA0KPiBXaXRob3V0IHN3IHN0cnVjdHVyZSBiZWluZyBpbml0aWFsaXplZCBpbiBndWVzdCBk
cml2ZXIsIHN3U01VIGNhbm5vdCANCj4gZGVjbGFyZSB0byBiZSBzdXBwb3J0ZWQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKYWNrIFpoYW5nIDxKYWNrLlpoYW5nMUBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDUgKysrKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCj4gaW5kZXggMzYw
MDFhNC4uMGI4YTUzYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kZ3B1X3NtdS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYw0KPiBAQCAtNTMxLDcgKzUzMSwxMCBAQCBib29sIGlzX3N1cHBvcnRfc3dfc211
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0g
Q0hJUF9WRUdBMjApDQo+ICAJCXJldHVybiAoYW1kZ3B1X2RwbSA9PSAyKSA/IHRydWUgOiBmYWxz
ZTsNCj4gIAllbHNlIGlmIChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9BUkNUVVJVUykNCj4gLQkJ
cmV0dXJuIHRydWU7DQo+ICsJCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+ICsJCQlyZXR1
cm4gZmFsc2U7DQo+ICsJCWVsc2UNCj4gKwkJCXJldHVybiB0cnVlOw0KW1F1YW4sIEV2YW5dIEFy
ZSAieyIgYW5kICJ9IiBtaXNzaW5nIGFyb3VuZCB0aGlzIGNvZGUgYmxvY2s/IFRoaXMgc2VlbXMg
YSBsaXR0bGUgd2VpcmQuDQo+ICAJZWxzZQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICB9DQo+IC0t
DQo+IDIuNy40DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0DQo+IHMuZnJlZQ0KPiBkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NldmFuLnF1YW4l
NDBhbWQuY29tJTdDYTAxMTkwOTlhM2RiNDUwNTU0DQo+IGYyMDhkNzc3MTc4YjVmJTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzENCj4gMDg4MTUzODQ3NzIw
NDAmYW1wO3NkYXRhPThSSjFReUR6SEVjbk9uazBFQkdraGZWbGplaVBXYVpTTmxPNk95QWENCj4g
ZW5jJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
