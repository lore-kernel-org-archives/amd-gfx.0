Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F56CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 19:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89F52166E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 19:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89F52166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C40389F2D;
	Thu, 24 Oct 2019 19:40:56 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730080.outbound.protection.outlook.com [40.107.73.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DF989F2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 19:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxUIsr3DOzug+opAXuz9iruoZ5WBBLhOTIPQRi05ljskOIjUUKIrld9ZgThKS7yEDC/dxF7ABowhhpByCySrd2cUXom1nLo31/sEqFvNO1cMtGpMmWwAq48jVR2evjHT4zrcvusQdMno09iWEf4+90DmjeMTCVMERHFFmLi/X4wO3QeK1i4CmZdGAMV35LHD3gi1GEpDE0DdQHefAPQbQt+AyV2V6Tx5fHFdMLb4qMmrZfyYnANWq8b4fE+NCs3aIxb9Z77/UVuwpOLxZP1JS9RucUBWLJoRj3GSOMWcii/aCr1MAGsPbc7fxQHu7VFeXsvvyUl5BFIsiY2ZelzCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTS3Mmgq7NXOYZ7sHQ0BwYWqOjfszcmv+Ze8ysk8wWU=;
 b=Z5t8MZHtsUJL4MTa+cz8y282diIMEaNyOXPR4keyJKPDtUUEE98sV1YPgWJY1ah4LuOyE5Ubg/WB1/RVdZ95tkqi1qwO/2xw4ZXC7nW7KLS+cPUCtMAXHcFo55FxKXneORYss//fICv2EoH57tdcnk9ltU/FqQh0fLeB2yAVTQULbFdCpeckd1tTxxoALm6l6KFS6QmdRFcOMTG57cdUx7CwBivlYPD0WMRQ4U0e+Uw95xmmCK94xFiK/O/ptmXPexc7SF++v21uZv+2DpeBbooMUdPYo/y8pg2Com3IAEMPAZvUYvbu4GyOWBdXBs51YkuA5cWuVQf4MDKTSCMMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3689.namprd12.prod.outlook.com (10.255.76.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 19:40:54 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::e56a:1c63:d6bd:8034]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::e56a:1c63:d6bd:8034%4]) with mapi id 15.20.2367.025; Thu, 24 Oct 2019
 19:40:54 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: bug fix for out of bounds mem on gpu cache
 filling info
Thread-Topic: [PATCH] drm/amdkfd: bug fix for out of bounds mem on gpu cache
 filling info
Thread-Index: AQHViptTWCbaLNLDyECItdAclb8HCKdqMKwA
Date: Thu, 24 Oct 2019 19:40:53 +0000
Message-ID: <d86f66b9-deef-3ee2-4d4e-7bd7cdda52af@amd.com>
References: <20191024184604.127737-1-alex.sierra@amd.com>
In-Reply-To: <20191024184604.127737-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1961050f-3101-471b-1bc6-08d758ba1524
x-ms-traffictypediagnostic: DM6PR12MB3689:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3689C0B6BB5E02916398FDFB926A0@DM6PR12MB3689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(186003)(14454004)(8936002)(8676002)(81166006)(81156014)(64756008)(66066001)(7736002)(102836004)(305945005)(99286004)(6246003)(6512007)(66946007)(76176011)(229853002)(386003)(53546011)(6506007)(66446008)(6436002)(6486002)(52116002)(26005)(66556008)(66476007)(65956001)(65806001)(2501003)(478600001)(25786009)(4001150100001)(5660300002)(71200400001)(486006)(71190400001)(446003)(256004)(58126008)(14444005)(110136005)(36756003)(3846002)(2616005)(476003)(11346002)(6116002)(2906002)(31686004)(31696002)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3689;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGWdGY6w3hcYFrANTifxjeS6/x9gepoSt3CzsPohRTmQqjhKXS4pSsOtT11Q8dmS1ju/5gsO+bukZDKc+0UcGYUvMijhU/Crek+canPJkbllhG0xyrQXooliS6xL4yAXwuhOQlnjmGR9+jdSK2dCIzTeUxmrYW0FnsQQ7Zz0Y2/y9x2/0RVbX+yfpcLbDXqYMnzPyb1v+mZwacwpEc7kRyc1Ffj4uoO8TvCUmw8u8kbZc2Vbw3LsJ8k27iWwfixPEHNEo1bklKUxE3Vd1wSNNCGOzeAzbhstbS5cSK6RXMy9yN3DqM+ldfITRPay4Ajz/el4il38XwKQcu1/SCtATc3LX/M67pxpEkBooNm4B1RbT0MkzRGR9OiAHPD457KeBvBD6vf/Tu5McFFiNX3rUOju9W1IFnboeximwYxDXRz7/8yy15LShuQL/mZYQ/J0
Content-ID: <4AAFEDA036122B4F8E60D427F8587C2F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961050f-3101-471b-1bc6-08d758ba1524
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:40:54.0262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IG9h53VO70yDVExXJjv8QwgPaXP2mB/LjX86dDj+nu32rNHFYlO4TIl+eyk5jBlw4578sUeL0ouiEb6ZNwL54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTS3Mmgq7NXOYZ7sHQ0BwYWqOjfszcmv+Ze8ysk8wWU=;
 b=xwnJxy56TV5sNJj9S6F0CXJ2HiW3DEwje1k9PjKlTJKENVCWoc8BhY3fJZ96xdoIdjOJEdfJVWd6eatVQz3QldbX3o07Oys77ALHBk/5xxxyrSrXAkohrMguzLQcHnsNfX7zr8KdQPM4oJUDrodknfpF7SdMuZGZ1IgiIkQyqu0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Message-ID: <20191024194053.k2DqbSzdB64tmMO87hR3NJqCTRu9HbDQGP5zIQHd-ac@z>

T24gMjAxOS0xMC0yNCAxNDo0NiwgU2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpIHdyb3Rl
Og0KPiBUaGUgYml0bWFwIGluIGN1X2luZm8gc3RydWN0dXJlIGlzIGRlZmluZWQgYXMgYSA0eDQg
c2l6ZSBhcnJheS4gSW4NCj4gQWN0dXJ1cywgdGhpcyBtYXRyaXggaXMgaW5pdGlhbGl6ZWQgYXMg
YSA0eDIuIEJhc2VkIG9uIHRoZSA4IHNoYWRlcnMuDQo+IEluIHRoZSBncHUgY2FjaGUgZmlsbGlu
ZyBpbml0aWFsaXphdGlvbiwgdGhlIGFjY2VzcyB0byB0aGUgYml0bWFwIG1hdHJpeA0KPiB3YXMg
ZG9uZSBhcyBhbiA4eDEgaW5zdGVhZCBvZiA0eDIuIENhdXNpbmcgYW4gb3V0IG9mIGJvdW5kcyBt
ZW1vcnkNCj4gYWNjZXNzIGVycm9yLg0KPiBEdWUgdG8gdGhpcywgdGhlIG51bWJlciBvZiBHUFUg
Y2FjaGUgZW50cmllcyB3YXMgaW5jb25zaXN0ZW50Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfY3JhdC5jDQo+IGluZGV4IDBjMzI3ZTBmYzBmNy4uZGU5ZjY4ZDVjMzEyIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gQEAgLTcxMCw3ICs3MTAsNyBAQCBz
dGF0aWMgaW50IGtmZF9maWxsX2dwdV9jYWNoZV9pbmZvKHN0cnVjdCBrZmRfZGV2ICprZGV2LA0K
PiAgIAkJCQkJCXBjYWNoZV9pbmZvLA0KPiAgIAkJCQkJCWN1X2luZm8sDQo+ICAgCQkJCQkJbWVt
X2F2YWlsYWJsZSwNCj4gLQkJCQkJCWN1X2luZm8tPmN1X2JpdG1hcFtpXVtqXSwNCj4gKwkJCQkJ
CWN1X2luZm8tPmN1X2JpdG1hcFtpICUgNF1baiArIGkgLyA0XSwNCj4gICAJCQkJCQljdCwNCj4g
ICAJCQkJCQljdV9wcm9jZXNzb3JfaWQsDQo+ICAgCQkJCQkJayk7DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
