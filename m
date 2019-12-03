Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89175C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6195C20684
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 02:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6195C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E980089D44;
	Tue,  3 Dec 2019 02:50:06 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C282089D44
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 02:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sma/USusnRV3GSDgPGNWoq7JTYV8Un+UpS7EwZValUPruqwpfqeUwdXkwrrtXwZ+pkuKcp0PXSqWnTw2P94vWMRei6/r0M61Ep8agz88u/5saxXmOGlrH1LSC4SodtFnvSZfz8zWqg0mO5sFevyIYObFGixEkiAE5/GoM48J2SAF7X/foqGss/CYrKiUGgFPfhSSpDAzy5+E/gu1IlY5Z07d0K3ezvPQVd5ECM0oSBbuUxToQ61+ddwfOdXGVML+KVdemjHe+T8AO/4l2y0NIn9ndq3wF65HXUXIi5AaGwiQ0WFdGWBKKQT9Ls8bXK5aqBnmicBWGuFHwopQLzvMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC41/3/UkIsio32q1Coais2elYxKkHOkiBB10jZWEvY=;
 b=Bo6LpGoBBQyU9rpciPT3AgmsD2RZS7ap5nBg9lTQsNAyg66n/5qg1TyC4q+F2BdN1dSwkVINtwV8dzpwqAspt7Pa2HV0ulDJd5qUMY22oPRhthZHqs87ip1VEWwY/8y7ksCyDD5tu7ct9hCUEgWL8Q5j6zhHqkReyM4FqRCv/u52Zz1qwEGDHdDhcMbSP//FmCqqB8MI3EWhak66r/Ues41kO3wu+wRl9C48u7VTVZ80YQUlljE8s9+taDIbzuUhP5goNe9Ra5to+R9eSROjsgsgOAvZiVBCWV6omxsqjY6D4On7Swsg0HrMbSOOQ2G48bbxd2USxkHZxfzpl9OTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3199.namprd12.prod.outlook.com (20.179.81.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 02:50:02 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:50:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: load np fw prior before loading the TAs
Thread-Topic: [PATCH 3/3] drm/amdgpu: load np fw prior before loading the TAs
Thread-Index: AQHVqNZP7XOsku996UmUsLzZlf0AsKentuZw
Date: Tue, 3 Dec 2019 02:50:02 +0000
Message-ID: <MN2PR12MB334436F8A80246BC15B7165DE4420@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191202060337.22435-1-Hawking.Zhang@amd.com>
 <20191202060337.22435-3-Hawking.Zhang@amd.com>
In-Reply-To: <20191202060337.22435-3-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9b018b02-e51d-419c-b560-0000af07f675;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-03T02:49:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96a95a3a-9d40-44a8-21d5-08d7779b7e8b
x-ms-traffictypediagnostic: MN2PR12MB3199:|MN2PR12MB3199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31991F69E720245CC9A6E517E4420@MN2PR12MB3199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(13464003)(3846002)(6116002)(2906002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(33656002)(6636002)(52536014)(55016002)(6306002)(9686003)(229853002)(6436002)(2501003)(14454004)(6246003)(25786009)(4326008)(478600001)(256004)(14444005)(99286004)(7736002)(966005)(7696005)(81156014)(81166006)(66066001)(8936002)(45080400002)(76176011)(8676002)(186003)(316002)(102836004)(26005)(446003)(11346002)(86362001)(71190400001)(6506007)(53546011)(110136005)(71200400001)(305945005)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3199;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NM3GjHgGwRnNdbcQitAICeImhrYEhFjy8SNKMgpROe3GliF4CVwZPH1bT4E7Xkgtt1M2GwUuGKrHd/faww6iHaAsUP7zVxHYw0E7cAEf2yzbmfvFEaivpsq6vTEAte4D/ObVmTkQh+KPyeUTelMbgFFxExHuOgPBoqscks3xKpcFgyXFFcVLDntdKa4Qp7dPsy2/gO8Y3xGLrtFx5ihPr7kjU9RLKFJanA+yDqONjAqjFIK6F0sfl6LrHDLlSVmoaywRCXRhErl1/P2G0KpBVvbi7t0DesvDcKlEVZV5+r4BsNNzZIeTcCimWCHoYvNVxMV7lNXlScHLkyT9P0gdnf50q/lPBa38lTqJ4FV8btwJqHMk8YTIF46DhWhq43IbNpOisyXBfVSZzFYvhaFtheVuDQqMZDjWV7kKFdg57lCdHEHIErkL2mUb/jOfD/y2mO4y1lxb0EkHpPrZJ/6e3ZSBsiU5R+FFA1DfjXGW784=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a95a3a-9d40-44a8-21d5-08d7779b7e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:50:02.1538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CihawDW84sybuumHCdcugvFxy9kxfp862mhXNJjciOupiS7AvLDTyr1fiD6G1vzi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3199
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC41/3/UkIsio32q1Coais2elYxKkHOkiBB10jZWEvY=;
 b=2/bP9P7N0EzurA/NA9MBvw1F6nUU/lgN2dXIzYPVRbWMJ3nvQAps5+fGdwyqO6XrWE2X/8FUfYAU4IvDrZNdrCIiekUrSk/bMq1Bu04Gsd1cWibuBXX77hmXD4f9vDW3MzOzAm+DuoFVBr8J58QdOTSKjogLJkVHpv2Vk6h1ofc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzIGFja2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBIYXdraW5nIFpoYW5nDQo+
IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAxOSAyOjA0IFBNDQo+IFRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgTWluLCBGcmFuayA8RnJhbmsuTWluQGFtZC5jb20+Ow0KPiBD
bGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
DQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDMvM10gZHJtL2FtZGdwdTog
bG9hZCBucCBmdyBwcmlvciBiZWZvcmUgbG9hZGluZyB0aGUgVEFzDQo+IA0KPiBQbGF0Zm9ybSBU
QXMgd2lsbCBpbmRlcGVuZGVudGx5IHRvZ2dsZSBERiBDc3RhdGUuDQo+IGZvciBpbnN0YW5jZSwg
Z2V0L3NldCB0b3BvbG9neSBmcm9tIHhnbWkgdGEuIGRvIGVycm9yDQo+IGluamVjdGlvbiBmcm9t
IHJhcyB0YS4gSW4gc3VjaCBjYXNlLCBQTUZXIG5lZWRzIHRvIGJlDQo+IGxvYWRlZCBiZWZvcmUg
VEFzIHNvIHRoYXQgYWxsIHRoZSBzdWJzZXF1ZW50IENzdGF0ZQ0KPiBjYWxscyByZWNpZXZlZCBi
eSBQU1AgRlcgY2FuIGJlIHJvdXRlZCB0byBQTUZXLg0KPiANCj4gQ2hhbmdlLUlkOiBJODNkYjFh
MjI1NzdhODRhZTY0N2U3ZTU3MGMyMDAwNTc2NTAwOTZjNQ0KPiBTaWduZWQtb2ZmLWJ5OiBIYXdr
aW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgNjYgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiBpbmRleCAw
ZTg5MDcxNzllMDcuLmNlZWE4MzE0ZDg4ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYw0KPiBAQCAtMTIxOCwzOSArMTIxOCw2IEBAIHN0YXRpYyBpbnQgcHNw
X2h3X3N0YXJ0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAg
CX0NCj4gDQo+IC0JcmV0ID0gcHNwX2FzZF9sb2FkKHBzcCk7DQo+IC0JaWYgKHJldCkgew0KPiAt
CQlEUk1fRVJST1IoIlBTUCBsb2FkIGFzZCBmYWlsZWQhXG4iKTsNCj4gLQkJcmV0dXJuIHJldDsN
Cj4gLQl9DQo+IC0NCj4gLQlpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4g
MSkgew0KPiAtCQlyZXQgPSBwc3BfeGdtaV9pbml0aWFsaXplKHBzcCk7DQo+IC0JCS8qIFdhcm5p
bmcgdGhlIFhHTUkgc2Vlc2lvbiBpbml0aWFsaXplIGZhaWx1cmUNCj4gLQkJICogSW5zdGVhZCBv
ZiBzdG9wIGRyaXZlciBpbml0aWFsaXphdGlvbg0KPiAtCQkgKi8NCj4gLQkJaWYgKHJldCkNCj4g
LQkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsDQo+IC0JCQkJIlhHTUk6IEZhaWxlZCB0byBpbml0
aWFsaXplIFhHTUkgc2Vzc2lvblxuIik7DQo+IC0JfQ0KPiAtDQo+IC0JaWYgKHBzcC0+YWRldi0+
cHNwLnRhX2Z3KSB7DQo+IC0JCXJldCA9IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOw0KPiAtCQlp
ZiAocmV0KQ0KPiAtCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwNCj4gLQkJCQkJIlJBUzogRmFp
bGVkIHRvIGluaXRpYWxpemUgUkFTXG4iKTsNCj4gLQ0KPiAtCQlyZXQgPSBwc3BfaGRjcF9pbml0
aWFsaXplKHBzcCk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2
LA0KPiAtCQkJCSJIRENQOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBIRENQXG4iKTsNCj4gLQ0KPiAt
CQlyZXQgPSBwc3BfZHRtX2luaXRpYWxpemUocHNwKTsNCj4gLQkJaWYgKHJldCkNCj4gLQkJCWRl
dl9lcnIocHNwLT5hZGV2LT5kZXYsDQo+IC0JCQkJIkRUTTogRmFpbGVkIHRvIGluaXRpYWxpemUg
RFRNXG4iKTsNCj4gLQl9DQo+IC0NCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC0xNTYw
LDYgKzE1MjcsMzkgQEAgc3RhdGljIGludCBwc3BfbG9hZF9mdyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGZhaWxlZDsNCj4gDQo+ICsJcmV0ID0g
cHNwX2FzZF9sb2FkKHBzcCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlEUk1fRVJST1IoIlBTUCBs
b2FkIGFzZCBmYWlsZWQhXG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlp
ZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgew0KPiArCQlyZXQgPSBw
c3BfeGdtaV9pbml0aWFsaXplKHBzcCk7DQo+ICsJCS8qIFdhcm5pbmcgdGhlIFhHTUkgc2Vlc2lv
biBpbml0aWFsaXplIGZhaWx1cmUNCj4gKwkJICogSW5zdGVhZCBvZiBzdG9wIGRyaXZlciBpbml0
aWFsaXphdGlvbg0KPiArCQkgKi8NCj4gKwkJaWYgKHJldCkNCj4gKwkJCWRldl9lcnIocHNwLT5h
ZGV2LT5kZXYsDQo+ICsJCQkJIlhHTUk6IEZhaWxlZCB0byBpbml0aWFsaXplIFhHTUkgc2Vzc2lv
blxuIik7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHBzcC0+YWRldi0+cHNwLnRhX2Z3KSB7DQo+ICsJ
CXJldCA9IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZGV2
X2Vycihwc3AtPmFkZXYtPmRldiwNCj4gKwkJCQkJIlJBUzogRmFpbGVkIHRvIGluaXRpYWxpemUg
UkFTXG4iKTsNCj4gKw0KPiArCQlyZXQgPSBwc3BfaGRjcF9pbml0aWFsaXplKHBzcCk7DQo+ICsJ
CWlmIChyZXQpDQo+ICsJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LA0KPiArCQkJCSJIRENQOiBG
YWlsZWQgdG8gaW5pdGlhbGl6ZSBIRENQXG4iKTsNCj4gKw0KPiArCQlyZXQgPSBwc3BfZHRtX2lu
aXRpYWxpemUocHNwKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWRldl9lcnIocHNwLT5hZGV2LT5k
ZXYsDQo+ICsJCQkJIkRUTTogRmFpbGVkIHRvIGluaXRpYWxpemUgRFRNXG4iKTsNCj4gKwl9DQo+
ICsNCj4gIAlyZXR1cm4gMDsNCj4gDQo+ICBmYWlsZWQ6DQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGlzdHMuZnJlZQ0KPiBkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC0N
Cj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NldmFuLnF1YW4lNDBhbWQuY29tJTdDZmE1N2I5Y2Iy
OGNlNGFmMWM2MQ0KPiAzMDhkNzc2ZWQ2ZjkxJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0
ZTE4M2QlN0MwJTdDMCU3QzYzNzENCj4gMDg2MzQ0ODM1MzMwMTkmYW1wO3NkYXRhPXdjMTVYZnNh
VGxUZ0lsYVAwJTJGMTJhOFNGRkJuayUyRjlSQ0tHd0sNCj4gb1JFeDhKOCUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
