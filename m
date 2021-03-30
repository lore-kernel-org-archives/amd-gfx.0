Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2254C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A8D61935
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8D61935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF0B6E862;
	Tue, 30 Mar 2021 07:20:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578636E862
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWKJm7zw6hN4xeLPSKc6gAVOFLQq1A8fgy4E4rzF3ShO8GQdcwKPgMVZiIA7s2eWmwdGgysCl3Ya1noDehlJqOjvtkS4Zj0yB2tKnwX+o9gO9of5LzS9c3F24GTTmZKdPr59nN9o4yjnHCOzq/rjulSIPw53QT8FIy1+VSVodESvccZMLzuA6lqeAGtIUoKk2+1WokyuOavO41uwbSRe0jBGo66oVCYRpAiwQL2cSs6nZCJnMjHCnos2ZvEgeHTWP1DLTi/mRcfNNHb0eBxQVlVPK/lMIXw8b0lD1z4rJyKLbhssOmnWkyYgsgtZIpbwThzy71gQfr6KQjKPc5JIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwwH1SegV4bb8AZHYyLlyF63Td7gwxGZimWe0zcVh9k=;
 b=e7PQ2tFenVd46jOKGDfy8upvCV1L0As8u8zOLU6EritEEcnbF7kakLQJss5lHWhWcgAttqDgwzJBobVbHtkK9SNkT1yf25DeQhK3m8OK8m6uNor4oiAql3W2dpySNgcm4SE8SHdq9CczQrzZr+EMcDHOhDKJsW11VlDr0l9n+i84p1pmsQDIeWM0fqkhcJI8PdizLV/rW2PDuYyF6e6wLPIvyUcvgan24szcLPHmjZmbzyFewk64vFiR+oS0IFwHr4XElvUzJGBt5eZcRsA3GYWitgtCOXwLQgJ2sjo79+hE2FtpluvXxVKd2Y1sHX79RJQuLzcNEzgX+DntCuLcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwwH1SegV4bb8AZHYyLlyF63Td7gwxGZimWe0zcVh9k=;
 b=xJ1etz7HXw+CjXcLpSaP2gvgm1Af1Y/Kt4N7Y+02A2qJO8LRzAcdp/tmnZHTuYkVjG9i73kEmjt7mNydm5mPdLDPt/XK4nRSNbTdOvInwT+kaG+/dEQXMTzYBq5L97ruPvXYGZoh3TTJpNsPb1pZDVlUWZvnLgGgFHLHYit4HWU=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 07:20:11 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 07:20:10 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Thread-Topic: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Thread-Index: AQHXJR8JmB0dRodUVkKvlN3EO71MMaqcHfQAgAABt9A=
Date: Tue, 30 Mar 2021 07:20:10 +0000
Message-ID: <BY5PR12MB4115EEED8927FFF414AF966F8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-5-Emily.Deng@amd.com>
 <4ccce70f-bd74-87ab-a280-5c45b74a7d39@gmail.com>
In-Reply-To: <4ccce70f-bd74-87ab-a280-5c45b74a7d39@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2b9ba95d-95f4-444f-9eea-b3ad89934bfc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T07:19:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 256ec88c-6573-4bc5-55eb-08d8f34c4133
x-ms-traffictypediagnostic: BYAPR12MB3238:
x-microsoft-antispam-prvs: <BYAPR12MB323859AABD695EF577C534D38F7D9@BYAPR12MB3238.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J52jrggQpScKUJDKF46FgB33AKyUrSvUNoyXZAVAF+VhhetKGIF5mdoGwW6dCXChdI9XhpCVfhQJ5A03Rk0qC2PA/d5/dghyx8QyBbvaccI3tm7cfYJ3+JCYcSzDYgsowBqtpoN21REU5O3uADCpv+F9XVSuV3HyHQ2yIuaDXTiAzhVSUlfpkOytyrONnLwwiqHPEiTQbKoschxhwaKzpBskhapnIT8q8VEB/C5kR+kBbFzcVlLShym1dNxS1cz/GRXMEWiW7dtAeDtQnSwNrgYnKu/rKUBAfPSlepwIcweIIQT6grTGyDUpaPRnDvvITKQZYQDgdL0bx/tnrotD7dWOU2WhuD1XAoT+0GiMu3IDyr3gCXZVF8iznOrQ4g3SFwizZBJyLx2Ha3vCT03Tiw2gfso2O7/zX3XhFdsKg0eoHP18e1sR51SngvOo5a7p0iDmY2cXJUuz2CWP3oAYt68aDwokdmH6d9gDwWlux1AN+6Rb+Y8shV8gdYiwUu79osIwKV7qrofBBTPOk8GfZ7APwZ5IQQfckE8SOnzupgmiaWOd9um5MGfK6+/4gBkRgLURLuylf+SbdDDz31HwwXMGTDAQIvFKMB2mWgeldWyrlcoEfj01Lc9aQDJix+DZAtfJSP/3MXWix8rumPvXrZAtp7bGCLzTyDRgcuWL8SU1GJ7n9teNaKFelZ8p8MkC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(5660300002)(55016002)(2906002)(33656002)(9686003)(8936002)(38100700001)(7696005)(6506007)(66574015)(86362001)(66946007)(66476007)(64756008)(76116006)(66446008)(8676002)(66556008)(316002)(26005)(186003)(52536014)(110136005)(71200400001)(478600001)(83380400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: B0t2rIq+KNthO5l+sbmuMRuvUh0UT7E81W9v4dOAUg0URStzYPg9lg0RU1/hItvQs/LmOY7/DMhiWxoSeBxX5ndw6q0F3K7oqHHm2tPWwU1miGOb5aW0lN2Jb54h2etS8BxVEzZURL1OjA7nZfL1RjhupyjD1ViH9zuFB/Pg+aQ1v90tOQ561EgfqhZk9WRUN/a/ZeAXD/acTaKH+/qJ5TIhIR2MrglrYvGJRwnqoveudUDOVxgaGpvi4j8K6nKqtehOOpNhFQwEnt3Xa86XVccJFPdYKerryPg19ewDJpzQzVujT7Hh0bhhbKYw+NtwX7Wszr/CQPH7CIz9UfyJ8lHqyAT5O8SIa7OjWOb561XPW2cCckojrgo+ZRfzAcDHJfFKxu4rbaXvIqTL1QFiTV42KQ86q2RDFXsjat6/F5K/YB5gQWS5Nc+LtNKrEUFmc0Asg9MyBOYyz1la7k2oB2hYOjpZfs2YmipCyzyrdK9QFegM8Q4k+KohQpHNwkbtJRRJq0w6ImMLo5m+1vjjRy6+iYm1KF+ENFmJrGvJK2tBEugNyQepaRQ+3tLwlN0CIc2N/dsdDdK6NB0POBavccA+oyJFUgScs7LNlPSjmYL2QIvBgHYb6SrSqBcsZIZuCg/0EZFmQDb7yO768rl7QIzvQ48B/G0O77arn277HHJZ+FeSZlkdNyUT1fYdVCf3tEY8WEm24ummTMRy4djn0M2Hc8cp0275Uw0XcUmb61VJ+hXc4xrhquw/y2FAOjt7
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ec88c-6573-4bc5-55eb-08d8f34c4133
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 07:20:10.8160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O65bjaxnqn59EwlNkl+8QK5lg5iV1kvJXrDhkqsSRBE56J7PAS1oitVJw+xZ0ZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3238
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAzMCwg
MjAyMSAzOjEzIFBNDQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBkcm0v
YW1kZ3B1OiBEaXNhYmxlIFJQVFIgd3JpdGUgYmFjayBmb3IgbmF2aTEyDQo+DQo+DQo+DQo+QW0g
MzAuMDMuMjEgdW0gMDY6NDEgc2NocmllYiBFbWlseSBEZW5nOg0KPj4gSXQgd2lsbCBoaXQgcmFt
ZG9tbHkgc2RtYSBoYW5nLCBhbmQgcGVuZGluZyBvbiB1dGNsMiBhZGRyZXNzDQo+PiB0cmFuc2xh
dGlvbiB3aGVuIGFjY2VzcyB0aGUgUlBUUiBwb2xsaW5nIGFkZHJlc3MuDQo+Pg0KPj4gQWNjb3Jk
aW5nIHNkbWEgZmlybXdhcmUgdGVhbSBtZW50aW9uZWQsIHRoZSBSUFRSIHdyaXRlYmFjayBpcyBk
b25lIGJ5DQo+PiBoYXJkd2FyZSBhdXRvbWF0aWNhbGx5LCBhbmQgd2lsbCBoaXQgaXNzdWUgd2hl
biBjbG9jayBnYXRpbmcgb2NjdXJzLg0KPj4gU28gc3RvcCB1c2luZyB0aGUgcnB0ciB3cml0ZSBi
YWNrIGZvciBzZG1hNS4wLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5
LkRlbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y1XzAuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8wLmMNCj4+IGluZGV4IDkyMGZjNmQ0YTEyNy4uNjNlNGE3ODE4
MWI4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8w
LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jDQo+PiBA
QCAtMjk4LDEzICsyOTgsMTkgQEAgc3RhdGljIHZvaWQNCj5zZG1hX3Y1XzBfcmluZ19wYXRjaF9j
b25kX2V4ZWMoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPj4gICAgKi8NCj4+ICAgc3RhdGlj
IHVpbnQ2NF90IHNkbWFfdjVfMF9yaW5nX2dldF9ycHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykNCj4+ICAgew0KPj4gLXU2NCAqcnB0cjsNCj4+ICtzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IHJpbmctPmFkZXY7DQo+PiArdTY0IHJwdHI7DQo+PiArdTMyIGxvd2JpdCwgaGlnaGJpdDsN
Cj4+ICsNCj4+ICtsb3diaXQgPSBSUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFkZXYs
IHJpbmctPm1lLA0KPm1tU0RNQTBfR0ZYX1JCX1JQVFIpKTsNCj4+ICtoaWdoYml0ID0gUlJFRzMy
KHNkbWFfdjVfMF9nZXRfcmVnX29mZnNldChhZGV2LCByaW5nLT5tZSwNCj4+ICttbVNETUEwX0dG
WF9SQl9SUFRSX0hJKSk7DQo+DQo+VGhhdCB3b24ndCB3b3JrIGxpa2UgdGhpcy4NCj4NCj5XZSBo
YXZlIHRoZSByZWFkcG9pbnRlciB3cml0ZWJhY2sgYmVjYXVzZSB3ZSBvdGhlcndpc2UgY2FuJ3Qg
Z3VhcmFudGVlDQo+dGhhdCB0aGUgdHdvIDMyYml0IHZhbHVlcyByZWFkIGZyb20gdGhlIHJlZ2lz
dGVycyBhcmUgY29oZXJlbnQuDQo+DQo+SW4gb3RoZXIgd29yZHMgaXQgY2FuIGJlIHRoYXQgdGhl
IGhpIHJwdHIgaXMgYWxyZWFkeSB3cmFwcGVkIGFyb3VuZCB3aGlsZSB0aGUNCj5sbyBpcyBzdGls
bCB0aGUgb2xkIHZhbHVlLg0KPg0KPldoeSBleGFjdGx5IGRvZXNuJ3QgdGhlIHdyaXRlYmFjayB3
b3JrPw0KPg0KPkNocmlzdGlhbi4NCklzc3VlIG9jY3Vycywgd2hlbiBvY2N1cnMgY2xvY2tnYXRp
bmcsIGF0IHRoZSBzYW1lIHRpbWUsIHRoZSBycHRyIHdyaXRlIGJhY2sgb2NjdXJzLiBBdCB0aGlz
IHRpbWUsIHRoZSB1dGNsMiB0cmFuc2xhdGlvbiB3aWxsIGhhbmcuDQo+DQo+Pg0KPj4gLS8qIFhY
WCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8NCj4+IC1ycHRyID0gKCh1
NjQgKikmcmluZy0+YWRldi0+d2Iud2JbcmluZy0+cnB0cl9vZmZzXSk7DQo+PiArcnB0ciA9IGhp
Z2hiaXQ7DQo+PiArcnB0ciA9IHJwdHIgPDwgMzI7DQo+PiArcnB0ciB8PSBsb3diaXQ7DQo+Pg0K
Pj4gLURSTV9ERUJVRygicnB0ciBiZWZvcmUgc2hpZnQgPT0gMHglMDE2bGx4XG4iLCAqcnB0cik7
DQo+PiAtcmV0dXJuICgoKnJwdHIpID4+IDIpOw0KPj4gK0RSTV9ERUJVRygicnB0ciBiZWZvcmUg
c2hpZnQgPT0gMHglMDE2bGx4XG4iLCBycHRyKTsNCj4+ICtyZXR1cm4gKHJwdHIgPj4gMik7DQo+
PiAgIH0NCj4+DQo+PiAgIC8qKg0KPj4gQEAgLTcwMiw3ICs3MDgsNyBAQCBzdGF0aWMgaW50IHNk
bWFfdjVfMF9nZnhfcmVzdW1lKHN0cnVjdA0KPmFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgIFdS
RUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwgaSwNCj5tbVNETUEwX0dGWF9SQl9S
UFRSX0FERFJfTE8pLA0KPj4gICAgICAgICAgbG93ZXJfMzJfYml0cyhhZGV2LT53Yi5ncHVfYWRk
ciArIHdiX29mZnNldCkgJg0KPjB4RkZGRkZGRkMpOw0KPj4NCj4+IC1yYl9jbnRsID0gUkVHX1NF
VF9GSUVMRChyYl9jbnRsLCBTRE1BMF9HRlhfUkJfQ05UTCwNCj5SUFRSX1dSSVRFQkFDS19FTkFC
TEUsIDEpOw0KPj4gK3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKHJiX2NudGwsIFNETUEwX0dGWF9S
Ql9DTlRMLA0KPj4gK1JQVFJfV1JJVEVCQUNLX0VOQUJMRSwgMCk7DQo+Pg0KPj4gICBXUkVHMzIo
c2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFkZXYsIGksDQo+bW1TRE1BMF9HRlhfUkJfQkFTRSks
IHJpbmctPmdwdV9hZGRyID4+IDgpOw0KPj4gICBXUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zm
c2V0KGFkZXYsIGksDQo+bW1TRE1BMF9HRlhfUkJfQkFTRV9ISSksDQo+PiByaW5nLT5ncHVfYWRk
ciA+PiA0MCk7DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
