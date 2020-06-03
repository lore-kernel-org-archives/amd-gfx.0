Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D9620738
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 02:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="peNzozc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D9620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FE06E4AF;
	Wed,  3 Jun 2020 02:27:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098026E4AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 02:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIQn0zbaUuPAgpztjYhghll8rdU+LgPUsSo44mcd7Os7JKd4y9HlGGt8IBWYEtzy0BityN14rVWHrAjiFetW4UzSz/YY28sb8FaQinRNlVzNdNCcGprsfEuXG+oTIoV2S4oT00vpDVISxdQfoKDTet42WieHZjFiSuTXj9n7EtqkCrPL/NEVQSFCSYIKc41yd+X36rekS39LbqDoeNcVr4SeHkwr2S4XmWs/jmMFSSWBy0stq7V1DgqhWsaM0C2b9r5W+3Wa4RVPgkhOoifEXsS1TMFwIcSCL103lFVxSUBASszmfyeE6YKyjopmdgBFrw2i6fs1OMokPzQMeWvLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoz6SRSOAqu0Kvld0z9k24HgY+168raKwB/tDNQjsPk=;
 b=nGoFLq72s48j31UDY3vgb/Q+xEUyK3NQxkHnwnHpIBOhY9Z4RmYn2JhdOFHQcZs7uYoa6yXbygwdAtlKu8nwQsTE59n77nJi8ftHJrH+YqpvCH/rLNMbArFZpTIi/DGpzSc98C1JkkfiQPJ1h1ckX1Go40FLdHyBRNiZaRHz+vxwp3iDlh6N7u1i4kczMWBEoebABTAQQ3YsFWWf07pszLWHrTQ6ZWVbvUXaFKOdyOPgCtXWo/TK0aY6jZ2R4me5mJDIY1dPV3qFCWcFiOlGcRdmFEGAkQaZDcG2SsLxNAKKTmF60S+ziBMdMZIYs9NIkB+BfkBCRMgmuzXqb7CBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoz6SRSOAqu0Kvld0z9k24HgY+168raKwB/tDNQjsPk=;
 b=peNzozc29Kg7Jko0w5T2/78C1rB4jOEU4JTEUi/imhhHI7R0vPVJO5S9oagu/i2+z9UQMSjpJNwtPMVwkdNer1D9w7vImvLPUPpFp9lISrP326hlG9Pqg7egVOuKzKNlwxxK98P6lkuGkA+eHpI3D7omF9Q1tObWhLc2UolsB9A=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 02:27:13 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::c4c1:ff62:fa6c:18b8%9]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 02:27:13 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONRHOcIppdIJ50ObNi5qBLFWX6jFO1MAgAAEhsCAAOtSwA==
Date: Wed, 3 Jun 2020 02:27:13 +0000
Message-ID: <BY5PR12MB41153DF35FDDAFA118EF096E8F880@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <1591098822-12353-1-git-send-email-Emily.Deng@amd.com>
 <BY5PR12MB41158534A80BB0A0D3DC328F8F8B0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <DM6PR12MB350083730A045D351FF41F49E98B0@DM6PR12MB3500.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB350083730A045D351FF41F49E98B0@DM6PR12MB3500.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0f8d91d1-4103-43d1-9ad8-00004b637f65;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-02T12:08:15Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bb3ee51-4180-4bd8-90b1-08d80765a04f
x-ms-traffictypediagnostic: BY5PR12MB3778:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37786796CA4F09A7014C7E598F880@BY5PR12MB3778.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ru1FU7zKyZTNU0OXe3SJYW7/TC8UdXxqBzxojzdokVvvB5OSYNaB2+BbLDuWi2/hPWyPpTdP62QAs9rn9cb5ve1f73XiMzaz71dA8Eqwq8wiXcIcDMvWZ9d22v37x9nuh3hJ+s6aRZ4MndyS0/feEf8K9k68eBbzcOUVYJzG8R+7yePLmyka878WIzj/rPQsiBAarA6dBhmbGBUTc7PjciDo06Try7Bpm9lFlHoSIpP/3FC9L6NN8CwElnSlMNQTm3DGPeHK5zv5ss1tgsaZ8UKGX+qY7Z2wWO82gW7V7xQ9uFTCDCrl00+cSsWHHbMS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(83380400001)(33656002)(2906002)(316002)(186003)(76116006)(66946007)(8676002)(86362001)(110136005)(478600001)(7696005)(6506007)(5660300002)(52536014)(8936002)(66556008)(66446008)(64756008)(55016002)(66476007)(71200400001)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DBaP6NFBlKK/DRt5vwO++Br9eMir2WNPWDYxCvyChrfOMsZ6qiJDkahtUmYHjQ0/bd3RPRHi2gR2d1wBX57k6qGDtkaT9AHb3BWrNgstHkf6K0Ua5uf/r/npWsxAXKICG5R+afZJTpIjPQD/6xFrXyH4a6NfHDbeBMzOAZo7fZf6P0/OVcduAplwWpjbOaSS20wfw2QXxMKkoBcpycw1e5JCogE3m74mgUSd/yDiZYR2fVZkOXNjipk6XUnOi5sW9LfHqLoShqnJaXc+sGIj9BfL9WuflSJ5bYweM0rV7/jBcJ5I7x101Jqyw0sUVIw/60PdyPEiFiNHDrjusdpAqvVIweBlwO67ct1nO9lswnOaH1LGMCynjD/yaJZe1l8p3gnQv+Xi5OvYZIcUFSh8CF7r7Qbaaa4A6UWSN/oVVnVkMZgvP/79el93WBXB1JNayZghJpRQponNEkZxBn+aAX5cqTAk7ReEbVbEV4qOoedZpoLp/RuVzlGX+3FhrL/6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb3ee51-4180-4bd8-90b1-08d80765a04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 02:27:13.3604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xyrW+VuAo+mz1Gwnh0MrD92oqU7V7vGBFvuyvTcvabPMwOjJwRK/56cNsKt7B6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGFua3MgRnJhbmssIGFscmVhZHkgc2VudCBvdXQgdGhlIG1vZGlmaWVkIHBhdGNoLCBwbGVhc2Ug
aGVscCByZXZpZXcgYWdhaW4uDQoNCkJlc3Qgd2lzaGVzDQpFbWlseSBEZW5nDQoNCg0KDQo+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNaW4sIEZyYW5rIDxGcmFuay5NaW5AYW1k
LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDIsIDIwMjAgODozNCBQTQ0KPlRvOiBEZW5nLCBF
bWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj5TdWJqZWN0OiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZGdwdS9zcmlvdjogRGlzYWJsZSBwbSBm
b3IgbXVsdGlwbGUgdmYgc3Jpb3YNCj4NCj5bQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJu
YWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+SGkgRW1pbHksDQo+SG93IGFib3V0IHRvIG1vdmUg
aXQgaW50byBzbXVfaHdfaW5pdCgpPw0KPg0KPkJlc3QgUmVnYXJkcywNCj5GcmFuaw0KPg0KPi0t
LS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj7lj5Hku7bkuro6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5n
QGFtZC5jb20+DQo+5Y+R6YCB5pe26Ze0OiAyMDIw5bm0NuaciDLml6UgMjA6MDgNCj7mlLbku7bk
uro6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtDQo+Z2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPuaKhOmAgTogTWluLCBGcmFuayA8RnJhbmsuTWluQGFtZC5jb20+DQo+
5Li76aKYOiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1L3NyaW92OiBEaXNhYmxlIHBtIGZvciBtdWx0
aXBsZSB2ZiBzcmlvdg0KPg0KPltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0
cmlidXRpb24gT25seV0NCj4NCj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+RnJvbTog
RW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj5TZW50OiBUdWVzZGF5LCBKdW5lIDIs
IDIwMjAgNzo1NCBQTQ0KPj5UbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+Q2M6
IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+DQo+PlN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGdwdS9zcmlvdjogRGlzYWJsZSBwbSBmb3IgbXVsdGlwbGUgdmYgc3Jpb3YNCj4+DQo+PkNo
YW5nZS1JZDogSWMwMTA0NDBlZjYyNWY2ZjI5ZTkxZjI2N2E2ZjI4NGY5YjY1NTRlMWYNCj4+U2ln
bmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4tLS0NCj4+IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKysrDQo+PiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PmIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PmluZGV4IGI2MzMxNzEyLi5mY2JkODc1IDEwMDY0
NA0KPj4tLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PkBAIC0y
MDA0LDYgKzIwMDQsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfaW5pdChzdHJ1Y3QN
Cj4+YW1kZ3B1X2RldmljZSAqYWRldikgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+PmFt
ZGdwdV92aXJ0X2luaXRfZGF0YV9leGNoYW5nZShhZGV2KTsNCj4+DQo+PitpZiAoYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpICYmICFhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQ0KPj4rYWRl
di0+c211LnBtX2VuYWJsZWQgPSAwOw0KPj4rDQo+PiByID0gYW1kZ3B1X2liX3Bvb2xfaW5pdChh
ZGV2KTsNCj4+IGlmIChyKSB7DQo+PiBkZXZfZXJyKGFkZXYtPmRldiwgIklCIGluaXRpYWxpemF0
aW9uIGZhaWxlZCAoJWQpLlxuIiwgcik7DQo+Pi0tDQo+PjIuNy40DQo+DQo+DQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
