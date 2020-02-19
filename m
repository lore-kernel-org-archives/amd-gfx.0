Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA9C34031
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 01:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D56F24654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 01:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bF8BLGIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D56F24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA80C6EAF6;
	Wed, 19 Feb 2020 01:54:18 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0021D6EAF6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 01:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb2OerEOaUE5OaAVsFPRzDC2Jsb89PHeD4oaboS3ttuoWJLoccdpr2b553OcLP/n7OKM7e5nmioLe8O55J2HvoOQn5gwep2rgrbeNTjb9kX08G61WVfSAzn+tbS7H7hIb3Y6Mf9SjbheN5w/2AGXfdUyStSnMQebFe1H3fZAUtKsxrZio5RuCf5dSxZa3dovEljMElyy/qioZvqrhfWoVrPuVYw44uwtni2ZfwyN+hsrQkU55TFu+/5cFiezlcJcnUDs5TbQPjMdhPZhWcLfbykgdeaJXfMhWHRlJnMOSqmd0chF+C377NDU6MC456qwF+3wMPF4UnWWUHiYkvRI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37AyGWrkZwwRLbgvom5qEyFgEqArqcziARlXdxRzEwo=;
 b=jn7m+n6nWlFqV9dT2WqG9UevesjnktkD8uD5lm0CUOZbqmf02on6oz+O2kns3GmsB0tw7fMqmLdCsQvCyzrchHe30sPFaJJ+OyO6dyWpcR0HZnlBlvCLR+3Yg5l3j395h8hwIQnkVKCVraqmWdCxQYcjLjq/0NfXZxGykeN7XGu8zqnSScBIOQOR/4rUThMcYJZuZovMlFmT3KAOBd1f4FDRRCbyMhu7QedUAX5gd/R5IN+qPvEDlNc6Hvu/Hos3d95EixEXvrqhGicjMCoScwCXYEqO+MfoannrigKie+CMlVGeOZVmb2tRBNC2/Axwe9CbzS+M975IBLDQiYxFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37AyGWrkZwwRLbgvom5qEyFgEqArqcziARlXdxRzEwo=;
 b=bF8BLGIiIP6g0VXLkro5EGYxuU4wSmK5rYb7S2XfD0iuTjEkcVqUOfekVIUqxmO4SAY4suZI4L8Uaq4cO2BepmUnfdUE8g//A/HtuI6dK1dmBLzxzJCQNGaQZXF1O9/Ew+J8YGc4spobE8nUvD5WlpjLpTyaPC3x1zIY1xyx0xc=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2813.namprd12.prod.outlook.com (52.135.100.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 01:54:16 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 01:54:15 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before
 release bo
Thread-Topic: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before
 release bo
Thread-Index: AQHV5gy7+gsetChEyk2VzY9fzPD5O6ghlP2AgAAt44A=
Date: Wed, 19 Feb 2020 01:54:15 +0000
Message-ID: <DB6DDBF8-FFA0-457E-8D87-B55FDD9B9D75@amd.com>
References: <20200218033650.7665-1-xinhui.pan@amd.com>
 <76285bd7-70df-09be-2e05-a4b75bb3e879@amd.com>
In-Reply-To: <76285bd7-70df-09be-2e05-a4b75bb3e879@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d457a485-fa90-46b3-c57d-08d7b4dea019
x-ms-traffictypediagnostic: SN6PR12MB2813:|SN6PR12MB2813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2813B4685AE96BBA8B8F58E887100@SN6PR12MB2813.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(71200400001)(6512007)(37006003)(26005)(54906003)(478600001)(316002)(2906002)(186003)(6486002)(5660300002)(53546011)(6506007)(4326008)(86362001)(6862004)(2616005)(66574012)(81156014)(6636002)(66446008)(64756008)(81166006)(33656002)(66946007)(8936002)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2813;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMwUddJMr/PoNl8sHxYS+cRuH6gJ5zsk0dsX+cClHUoUmNmks9aGrVH1SJNxEdikGFGVDO68L11EZ6DKVWLpPO0KwkLpQGt5CG44QejAAZUDPlqScM+VmwmBuQos1swLUhJxi9xxt4M6lML3/7sAVMCxFP6BqSRjUqcLsvrtxJXARvFrEIHfHSaaxzDvvzctFbuVhzlFt+l32ZcGix9Bq7LTDC4v4Gu7j0mP/WW7+hqOsd2vItxYXeqWgEMla0jPuTxkrDRg7YXNoVZg+yxDYZwTf0gtcsIyG3OFm7K7tN3GMNtVq68HAsx4BIEJ25Qgr1hUIsiCHwkwoIQnAPSEsYPHFaQ1B8cqIpkebckt4gSMzjeXo18yZ9N7Klug3zfoSnsTZ7kRSGAmdo6U0wBCRvt3UUPSvZ5Zgf5bz6ngD8Gg6iiy7r3xQPu+7GsPivS+
x-ms-exchange-antispam-messagedata: T7AOnfBhPvkcggB3ty07eUK8Sr1PHSBBY4+RwOYjhlpbv7QRMujw1TEFJT96HYsKp2bnb9tkJrla4hbEY0q6aAwe6/YRJtcN8qD6u7s2gkUOGeYr+zW5sNj5dU1SJhLLNCMiKS+dbLJd+sHf86Fxdw==
Content-ID: <FD5245244B732B48A85391B188AD15B4@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d457a485-fa90-46b3-c57d-08d7b4dea019
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 01:54:15.7437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oo3Zvaw792rUsH3PYtFVEycME7796PevlBw95ypVmY7/nDLSfCDL7HmWrjfQk/l9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2813
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDLmnIgxOeaXpSAwNzoxMO+8jEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4g5YaZ6YGT77yaDQo+IA0KPiBIaSBYaW5odWksDQo+IA0KPiBUd28gc3Vn
Z2VzdGlvbnMgaW5saW5lLiBMb29rcyBnb29kIHRvIG1lIG90aGVyd2lzZS4NCj4gDQo+IE9uIDIw
MjAtMDItMTcgMTA6MzYgcC5tLiwgeGluaHVpIHBhbiB3cm90ZToNCj4+IE5vIG5lZWQgdG8gdHJp
Z2dlciBldmljdGlvbiBhcyB0aGUgbWVtb3J5IG1hcHBpbmcgd2lsbCBub3QgYmUgdXNlZA0KPj4g
YW55bW9yZS4NCj4+IA0KPj4gQWxsIHB0L3BkIGJvcyBzaGFyZSBzYW1lIHJlc3YsIGhlbmNlIHRo
ZSBzYW1lIHNoYXJlZCBldmljdGlvbiBmZW5jZS4NCj4+IEV2ZXJ5dGltZSBwYWdlIHRhYmxlIGlz
IGZyZWVkLCB0aGUgZmVuY2Ugd2lsbCBiZSBzaWdubGVkIGFuZCB0aGF0IGN1YXNlcw0KPj4ga2Zk
IHVuZXhjZXB0ZWQgZXZpY3Rpb25zLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFu
IDx4aW5odWkucGFuQGFtZC5jb20+DQo+PiBDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KPj4gQ0M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0Bh
bWQuY29tPg0KPj4gQ0M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4+IC0tLQ0KPj4gY2hhbmdlIGZyb20gdjQ6DQo+PiBiYXNlZCBvbiBuZXcgdHRtIGNvZGUuDQo+
PiANCj4+IGNoYW5nZSBmcm9tIHYzOg0KPj4gZml4IGEgY29kaW5nIGVycm9yDQo+PiANCj4+IGNo
YW5nZSBmcm9tIHYyOg0KPj4gYmFzZWQgb24gQ2hyaXMnIGRybS90dG06IHJld29yayBCTyBkZWxh
eWVkIGRlbGV0ZSBwYXRjaHNldC4NCj4+IA0KPj4gLS0tDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggICAgfCAgMSArDQo+PiAgLi4uL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgIHwgMzcgKysrKysrKysrKysrKysr
KysrKw0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAgICB8
ICA0ICsrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgNCj4+IGluZGV4IDllOGRi
NzAyZDg3OC4uMGVlOGFhZTZjNTE5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmgNCj4+IEBAIC05Niw2ICs5Niw3IEBAIHN0cnVjdCBhbWRncHVf
YW1ka2ZkX2ZlbmNlICphbWRncHVfYW1ka2ZkX2ZlbmNlX2NyZWF0ZSh1NjQgY29udGV4dCwNCj4+
ICAJCQkJCQkgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0pOw0KPj4gIGJvb2wgYW1ka2ZkX2Zl
bmNlX2NoZWNrX21tKHN0cnVjdCBkbWFfZmVuY2UgKmYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsN
Cj4+ICBzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSAqdG9fYW1kZ3B1X2FtZGtmZF9mZW5jZShz
dHJ1Y3QgZG1hX2ZlbmNlICpmKTsNCj4+ICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vf
b25fcHRfcGRfYm9zKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsNCj4+ICAgIHN0cnVjdCBhbWRrZmRf
cHJvY2Vzc19pbmZvIHsNCj4+ICAJLyogTGlzdCBoZWFkIG9mIGFsbCBWTXMgdGhhdCBiZWxvbmcg
dG8gYSBLRkQgcHJvY2VzcyAqLw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4gaW5kZXggZWY3MjFjYjY1ODY4Li42YWEyMGFhODJi
ZDMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYw0KPj4gQEAgLTI3Niw2ICsyNzYsNDEgQEAgc3RhdGljIGludCBhbWRncHVf
YW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShzdHJ1Y3QgYW1kZ3B1X2JvICpibywNCj4+ICAJ
cmV0dXJuIDA7DQo+PiAgfQ0KPj4gICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25f
cHRfcGRfYm9zKHN0cnVjdCBhbWRncHVfYm8gKmJvKQ0KPj4gK3sNCj4+ICsJc3RydWN0IGFtZGdw
dV9ibyAqcm9vdCA9IGJvOw0KPj4gKwlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKnZtX2JvOw0K
Pj4gKwlzdHJ1Y3QgYW1kZ3B1X3ZtICp2bTsNCj4+ICsJc3RydWN0IGFtZGtmZF9wcm9jZXNzX2lu
Zm8gKmluZm87DQo+PiArCXN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlICplZjsNCj4+ICsJaW50
IHJldDsNCj4+ICsNCj4+ICsJd2hpbGUgKHJvb3QtPnBhcmVudCkNCj4+ICsJCXJvb3QgPSByb290
LT5wYXJlbnQ7DQo+IA0KPiBUaGlzIHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5LiBFdmVyeSBwYWdl
IHRhYmxlIEJPIGhhcyBhIHBvaW50ZXIgdG8gYSB2bV9ibyB0aGF0IGhhcyBhIHBvaW50ZXIgdG8g
dGhlIHZtLiBTbyB5b3UgZG9uJ3QgbmVlZCB0byBmaW5kIHRoZSByb290Lg0KPiANCj4gVGhpcyBz
aG91bGQgZG8gdGhlIHRyaWNrOg0KPiANCj4gCWlmICghYm8tPnZtX2JvIHx8ICFiby0+dm1fYm8t
PnZtKQ0KPiAJCXJldHVybiAwOw0KPiAJdm0gPSBiby0+dm1fYm8tPnZtOw0KPiANCj4gDQp3ZWxs
LHdoZW4gZnJlZSBwYWdlIHRhYmxlcywgaXQgY2xlYXJzIGJvLT52bV9ibyBmaXJzdCB0aGVuIHJl
bGVhc2UgcHQvcGQgYm8uDQpBbHNvIHdlIGNhbiBjaGFuZ2UgdGhlIHNlcXVlbmNlIGxpa2UgSSBk
byBpbiBWMiwgbG9va3MgbGlrZSBoaXQgc29tZSB3ZWlyZCBpc3N1ZXMuDQoNCj4+ICsNCj4+ICsJ
dm1fYm8gPSByb290LT52bV9ibzsNCj4+ICsJaWYgKCF2bV9ibykNCj4+ICsJCXJldHVybiAwOw0K
Pj4gKw0KPj4gKwl2bSA9IHZtX2JvLT52bTsNCj4+ICsJaWYgKCF2bSkNCj4+ICsJCXJldHVybiAw
Ow0KPj4gKw0KPj4gKwlpbmZvID0gdm0tPnByb2Nlc3NfaW5mbzsNCj4+ICsJaWYgKCFpbmZvIHx8
ICFpbmZvLT5ldmljdGlvbl9mZW5jZSkNCj4+ICsJCXJldHVybiAwOw0KPj4gKw0KPj4gKwllZiA9
IGNvbnRhaW5lcl9vZihkbWFfZmVuY2VfZ2V0KCZpbmZvLT5ldmljdGlvbl9mZW5jZS0+YmFzZSks
DQo+PiArCQkJc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVuY2UsIGJhc2UpOw0KPj4gKw0KPj4gKwlk
bWFfcmVzdl9sb2NrKGJvLT50Ym8uYmFzZS5yZXN2LCBOVUxMKTsNCj4+ICsJcmV0ID0gYW1kZ3B1
X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2UoYm8sIGVmKTsNCj4+ICsJZG1hX3Jlc3ZfdW5s
b2NrKGJvLT50Ym8uYmFzZS5yZXN2KTsNCj4+ICsNCj4+ICsJZG1hX2ZlbmNlX3B1dCgmZWYtPmJh
c2UpOw0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW50IGFtZGdw
dV9hbWRrZmRfYm9fdmFsaWRhdGUoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRvbWFp
biwNCj4+ICAJCQkJICAgICBib29sIHdhaXQpDQo+PiAgew0KPj4gQEAgLTEwNDUsNiArMTA4MCw4
IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9kZXN0cm95X2NiKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LA0KPj4gIAlsaXN0X2RlbCgmdm0tPnZtX2xpc3Rfbm9kZSk7DQo+PiAgCW11dGV4
X3VubG9jaygmcHJvY2Vzc19pbmZvLT5sb2NrKTsNCj4+ICArCXZtLT5wcm9jZXNzX2luZm8gPSBO
VUxMOw0KPj4gKw0KPj4gIAkvKiBSZWxlYXNlIHBlci1wcm9jZXNzIHJlc291cmNlcyB3aGVuIGxh
c3QgY29tcHV0ZSBWTSBpcyBkZXN0cm95ZWQgKi8NCj4+ICAJaWYgKCFwcm9jZXNzX2luZm8tPm5f
dm1zKSB7DQo+PiAgCQlXQVJOX09OKCFsaXN0X2VtcHR5KCZwcm9jZXNzX2luZm8tPmtmZF9ib19s
aXN0KSk7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+
PiBpbmRleCA2ZjYwYTU4MWUzYmEuLjE2NTg2NjUxMDIwZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+PiBAQCAtMTMwNyw2ICsxMzA3LDEw
IEBAIHZvaWQgYW1kZ3B1X2JvX3JlbGVhc2Vfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8pDQo+PiAgCWlmIChhYm8tPmtmZF9ibykNCj4+ICAJCWFtZGdwdV9hbWRrZmRfdW5yZXNl
cnZlX21lbW9yeV9saW1pdChhYm8pOw0KPj4gICsJLyogV2Ugb25seSByZW1vdmUgdGhlIGZlbmNl
IGlmIHRoZSByZXN2IGhhcyBpbmRpdmlkdWFsaXplZC4gKi8NCj4+ICsJaWYgKGJvLT5iYXNlLnJl
c3YgPT0gJmJvLT5iYXNlLl9yZXN2KQ0KPiANCj4gU2hvdWxkIHRoaXMgYmUgYSBXQVJOX09OPyBX
ZSBleHBlY3QgdGhpcyBjb25kaXRpb24gdG8gYmUgYWx3YXlzIHRydWUuIElmIGl0J3Mgbm90LCB0
aGVyZSBzaG91bGQgYmUgYSBub2lzeSB3YXJuaW5nIHRoYXQgc29tZXRoaW5nIGlzIHdyb25nLg0K
DQpnb29kIHBvaW50Lg0KDQp0aGFua3MNCnhpbmh1aQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiAgIEZl
bGl4DQo+IA0KPiANCj4+ICsJCWFtZGdwdV9hbWRrZmRfcmVtb3ZlX2ZlbmNlX29uX3B0X3BkX2Jv
cyhhYm8pOw0KPj4gKw0KPj4gIAlpZiAoYm8tPm1lbS5tZW1fdHlwZSAhPSBUVE1fUExfVlJBTSB8
fCAhYm8tPm1lbS5tbV9ub2RlIHx8DQo+PiAgCSAgICAhKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VN
X0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRSkpDQo+PiAgCQlyZXR1cm47DQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
