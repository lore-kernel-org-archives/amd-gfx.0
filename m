Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2321CA9EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6922166E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6922166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA5C6E1A2;
	Thu, 24 Oct 2019 09:13:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EE56E1A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 09:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYLM1yG4bgHhngyWbMlzC0NFAQHAYeNKAVlQ1a0ZOzGqCSG3+09SYPVgW7Avw5g32IgJPTEk5X4e3hQeWq5YDnyTiIHvUKHfvEQ6rnazSVviUj5yEm3047XJb2yOcaQ21YeBL5IjLNV1pSi+Q1s2onWVEPlS5gWlIJ+HT81OQSWXS0Wi7m7ZkvDa9atn7Se+AsRgPBh9BKe7vi2UVezxB4C1DV3ocCTv5g25ZGl4SLl5ts+M/yDS8I/yvez/jZlIBMzqtplUCrMYlkrYPPRVUIFsZRYKnovL4xORlmF1E3HVIQvwtl/c/VL8UYloouURSfrGNF24yT+ZBR+mew8B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y90djHJmWl1kxc2q7OQzbkVQctimt0rWEAq3i7aDzQQ=;
 b=NX8+ds3KeWhAax2zEh7GhUab0SyTPpeoqfY/mml2eUs3fEessKghNnNnwJFh2Bx/lwhy3BXihAlrreu+2c86fsTQ5atjE5ASTF+JCT+/XivMLO33VuDFr1+AkqBe3kQzn8475IAYlzH4zL4w+q3pj/mkVgdaRtTmmtj7nDyB7me6bG8F3QKFZoFQyrkRlUVBadng0EKCvzBuhIqYDry2t3vsQ+e+Pj9ZvBc0dZmjGGGbjHh8+J2BOx0wwG+HgZnLqS+Up0wbVUUckcWmZOpTuI5UjZbClSPiVYgmsucXEAY4kIppiiPGAenbK01wcSzHHxukDCaXnZ670DH7L6zHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3839.namprd12.prod.outlook.com (10.255.237.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 09:13:18 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::282d:ad6c:e8da:3b34]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::282d:ad6c:e8da:3b34%4]) with mapi id 15.20.2387.021; Thu, 24 Oct 2019
 09:13:18 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: modify the parameters of
 SMU_MSG_PowerUpVcn to 0
Thread-Topic: [PATCH] drm/amd/powerplay: modify the parameters of
 SMU_MSG_PowerUpVcn to 0
Thread-Index: AQHViklgZNZU0s/JLUOvmy369pX71adpgdvg
Date: Thu, 24 Oct 2019 09:13:18 +0000
Message-ID:
 <MN2PR12MB3838E06D487F8BE6792A9569F06A0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1571907564-18087-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1571907564-18087-1-git-send-email-curry.gong@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b72205fe-37a5-44e3-2da4-08d75862690f
x-ms-traffictypediagnostic: MN2PR12MB3839:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38390A7D94D8354E12D7124FF06A0@MN2PR12MB3839.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(13464003)(14454004)(33656002)(6116002)(6246003)(3846002)(102836004)(76176011)(14444005)(256004)(71200400001)(71190400001)(7736002)(26005)(53546011)(6506007)(7696005)(305945005)(486006)(186003)(446003)(11346002)(86362001)(2906002)(99286004)(476003)(5660300002)(66946007)(66446008)(64756008)(66476007)(66556008)(6436002)(52536014)(76116006)(66066001)(4326008)(81156014)(81166006)(8676002)(478600001)(25786009)(110136005)(8936002)(966005)(316002)(55016002)(2501003)(9686003)(74316002)(229853002)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3839;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jfqb+xaYxRUX1TS0olXacP+NooEFfq2X7DvW1tRUa2id2OaNK9AzIVatdYZ+Xk11+xAmoT1CisDsXq0vIC2qaTAv8dH9VEfMSACntVEer+ranTQcpqB7lhb8v3GD7QalEMxiOEwWF8K6+1StaURgb8d8uBC9aj5TT+rr5q6qAZ3oKy0rEC7B7jrp70ArGjlpyhHn07UYAEZB3rIXshs4x81fMO7bYIzoLYdbIJpdBlfqxVSozddPXf7LbxktU40vEax2bC/jnjlm599rXu13N8EhLesg8PG/IDGu2zYQBQA5FdOApVgYFK0NyCwVPi2fxTRdi2BUfGm1PogRIWmROCH/4eBZjY2R+HWWMnZE3cN9bb/jBnFU5hxZ8dAGWKEEAsZQGZacenpphJPvHAOBJysnxbGFdsCuE/2XZodE0y93B9WbZc0MtwrV+OXpP9IILb/detvNnH3mj3XAlw25HX5fzI6vH1Q2EWkkcW7tDw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72205fe-37a5-44e3-2da4-08d75862690f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 09:13:18.6957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RAaxVAXB7XUrAOB8l3biawXA1qJ9pesWq+vihH1FVvDRGaMlB8NjcjcQ7PCCpxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y90djHJmWl1kxc2q7OQzbkVQctimt0rWEAq3i7aDzQQ=;
 b=IDFKQnGvou5QSQFTUhyzoHGkei8F/3opz5S6clS8aowp4HYXCEuqb6QkxwHVsOkV/hIBHSV2p14m74CHd3auUvx+xPGSD90sN8khgReitvP6DMgttZF+TTfyE0P8oUMHCdDEmnbG1ISS4QcGhevUUjs40C6/km9QGY79NysMnjc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024091318.GYfQKwySMJyWBZbHN6m5mpQmnrgb0Smy3HjtNLPgPsQ@z>

UmV2aWV3ZWQtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+DQoNCkJSLA0KQWFyb24g
TGl1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIGNoZW4NCj4g
Z29uZw0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNCwgMjAxOSA0OjU5IFBNDQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogR29uZywgQ3VycnkgPEN1cnJ5Lkdv
bmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogbW9kaWZ5
IHRoZSBwYXJhbWV0ZXJzIG9mDQo+IFNNVV9NU0dfUG93ZXJVcFZjbiB0byAwDQo+IA0KPiBUaGUg
cGFyYW1ldGVycyB3aGF0IFNNVV9NU0dfUG93ZXJVcFZjbiBuZWVkIGlzIDAsIG5vdCAxDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBjaGVuIGdvbmcgPGN1cnJ5LmdvbmdAYW1kLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMNCj4gaW5kZXggNDVjNWY1
NC4uNGE5NzUxOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
cmVub2lyX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9p
cl9wcHQuYw0KPiBAQCAtMjgyLDcgKzI4Miw3IEBAIHN0YXRpYyBpbnQgcmVub2lyX2RwbV9zZXRf
dXZkX2VuYWJsZShzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpDQo+ICAJ
aWYgKGVuYWJsZSkgew0KPiAgCQkvKiB2Y24gZHBtIG9uIGlzIGEgcHJlcmVxdWlzaXRlIGZvciB2
Y24gcG93ZXIgZ2F0ZSBtZXNzYWdlcw0KPiAqLw0KPiAgCQlpZiAoc211X2ZlYXR1cmVfaXNfZW5h
YmxlZChzbXUsDQo+IFNNVV9GRUFUVVJFX1ZDTl9QR19CSVQpKSB7DQo+IC0JCQlyZXQgPSBzbXVf
c2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LA0KPiBTTVVfTVNHX1Bvd2VyVXBWY24sIDEpOw0K
PiArCQkJcmV0ID0gc211X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gU01VX01TR19Q
b3dlclVwVmNuLCAwKTsNCj4gIAkJCWlmIChyZXQpDQo+ICAJCQkJcmV0dXJuIHJldDsNCj4gIAkJ
fQ0KPiAtLQ0KPiAyLjcuNA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
