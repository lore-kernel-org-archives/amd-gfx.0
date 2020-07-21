Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2BC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229E620729
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HSfXS9tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229E620729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFE76E55C;
	Tue, 21 Jul 2020 09:53:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277A76E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0BeWnGP2Nsqo1FvtSX4ypFAPLvrqniFIclp5Ad2NWBvIB+jMs/N9WRnsNlM9MyQixlb1OmaQxuqVF1v5h5nfEVR+eNSapyuFydEYWjn85F6KMx2KeY2T62E3cOht0I4kGhe5+pllSKA0Z/XsdLrcIp/EviaeFDjGZXu6+oznS70y2NZEfIy+Xjo7bxKk66UU2Nl18rQJmvUdY5bjVp/Ye2fKx2RBHI/ieBGeqer2GV60q1EHfBjBViv2kW/2iKL9a6uv4pYr0XjIskTTNwkCZGPnnSjQc4t8YAqfv5ldxNe1RW2nQ5xUtq5byRoUdiZhJIxX1AK8j6DybW7+VCuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib3N/8fyovGqJmorf47Ds0cEUrIzfS5GppH112YdzMU=;
 b=NmlewMtHVXnLCkHJGyu3niPK6veoWHp4OctG03zrPNV3/EmanXWl3iJyQhMGXiQa+4P1bLvVFPyEEY/fcM5pkciZON7+MgwJwBHVBBwFijyz+Uoz0QJHhGuQuU7vT/VRJaIpfruFxZjwElI0BdLuJYesIhtJAzDhysKDEruIm4g1XvO2tX4ciMeSv+zm5TkfWcoXLjpgso7IwoLjPpi56DjMScF5BocJqa06UuXgsWCteHmKHbtcj6v8jxqCEoHnwFJMpJBzqgwROx5IgVOaoO6nqbkVGjpWnhxCPxRAqnDWufrME+uAVnULQFNuUNN5YbNFlh1sXA0Na36t4vd/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib3N/8fyovGqJmorf47Ds0cEUrIzfS5GppH112YdzMU=;
 b=HSfXS9tRcxUx+iSssHaX8x95yge76HAzSBkComXHFqF6simzmmUIJkBWxEqUyQFKGPGSQYq8iVZkv70VT3e98JXTOt/CVuhsg6+fejmsf27d0W6j2bNPZUZDOBrdgFLfcWOhBjQWrySjiB+j8xFmNoMI10MeRu3AHIZUkMHtQVM=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 09:53:03 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3195.026; Tue, 21 Jul
 2020 09:53:03 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogcmV0cmlldmUgVkNO?=
 =?gb2312?Q?_dpm_table_per_instances?=
Thread-Topic: [PATCH] drm/amd/powerplay: retrieve VCN dpm table per instances
Thread-Index: AQHWXz2HZkx3Uj1Dd0+HCqknThtn/KkRyuGg
Date: Tue, 21 Jul 2020 09:53:03 +0000
Message-ID: <MWHPR12MB1854D1AB19F6F2B863FB0C6BEF780@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20200721090109.2733-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200721090109.2733-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [240e:e0:a67e:8600:cc2e:5ea:6f2b:6b41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1593a0cf-bd16-4332-ae2b-08d82d5bdc95
x-ms-traffictypediagnostic: MWHPR12MB1663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB16638DC922896FC31437F5BFEF780@MWHPR12MB1663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7Qlbtb98eZJ/6Vz//eynElF4Nnrx9Wf8fu5epdhXLJBEHXRH7xvAHhccKS9d05vpwjARfetCynNDU6yuHGiUah5B/DbTvG2ltnXmeYLaCJe4FK0HIMFUdVy8kUIumg1hMCKdEKl8evXc0k+Rf6pDhZcTicbBdm7fq/Bik34cBWAHCVu0JR8M+vF5ZR3sU3C/te8pGBhpKFoegnobzuIbrsA3OXT0L9hmc2JsJmYSlFIWqiVbhs8mIwnYVZLWnE65rhynK3s2pAYsufpCe1vEAh4lrsh2iBWOZeFup0udCaaRD1IOA8QCZopMwT2PdGe+qqR+1dOU3D/Xf0gvo6bgJxL/fCEV/bDFlCVz31T9bI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(4326008)(54906003)(110136005)(6506007)(224303003)(33656002)(316002)(83380400001)(55016002)(45080400002)(966005)(478600001)(66476007)(66556008)(76116006)(5660300002)(8936002)(2906002)(7696005)(86362001)(71200400001)(9686003)(66946007)(186003)(52536014)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: izQelO+AgpxMgToBmlFqWNb3hd+EU4XqebRLIYPXawPn5QYcA/5JJ11oQse449qFio5JlPpi6FFHhgVSN9sFSfFvVhicrXR5Q8ysqFIv0p8JN/bgcIKVTETPgRmv4h4tUCNRxjOEAdiBU14ycuOiADwLGwBDzHOXLgUcLaKZITa/TnxIkkl46jTNBs2XkBmwn4v+uAQyP9NZZsm3VF6zysJjAEc6myhmJEYjx5Ec69BfBRYlw1ZZie+v2YPC67cn8+RhUvKuyoaS0Jo7H9P1gKzDfCaAtpR/4ldLYfNbsL2aftqjx00w7eFcE4iWK4PEW+T8RZtCPQ+xoBZLMX9/J3ONe36BhA684r/lWwAuCp/z25uozilLQJG2vojQYW5qOTYUYM3nLMt0YzcjP0v3L7FFVVFs55PUEXXc/X9N26MyhDA3lJYMTgeY4ODrAHX0Oai8NWJsKPguhv6Y2ZRofAIXXWd2EPfFuJINPAhRfxuSPpFPrcBcsgR1YhhfYsZw20+HXx+qjnUUMpF8+ts5QUv0f7K1PwqaeaalQfEkxLc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1593a0cf-bd16-4332-ae2b-08d82d5bdc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 09:53:03.6557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+yVj3dKs4n3xOh4eLE+uhYWEYGuzH3irssZ9/nWbnEOjdKKvvy5wcVWHkeW62RQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpM
aWt1bg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogYW1kLWdmeCBbbWFpbHRvOmFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddILT6se0gSmlhbnNvbmcgQ2hlbg0Kt6LL
zcqxvOQ6IDIwMjDE6jfUwjIxyNUgMTc6MDENCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCrOty806IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgRmVuZywgS2Vu
bmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+OyBDaGVuLCBKaWFuc29uZyAoU2ltb24pIDxKaWFu
c29uZy5DaGVuQGFtZC5jb20+DQrW98ziOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiByZXRy
aWV2ZSBWQ04gZHBtIHRhYmxlIHBlciBpbnN0YW5jZXMNCg0KVG8gYWNjb21tb2RhdGUgVkNOIGlu
c3RhbmNlcyB2YXJpYW5jZSwgb3RoZXJ3aXNlIGl0IG1heSB0cmlnZ2VyIHNtdSByZXNwb25zZSBl
cnJvciBmb3IgY29uZmlndXJhdGlvbiB3aXRoIGxlc3MgaW5zdGFuY2VzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBKaWFuc29uZyBDaGVuIDxKaWFuc29uZy5DaGVuQGFtZC5jb20+DQpDaGFuZ2UtSWQ6IEkw
YmZlMzFmMWY1NjM4ZDUzOWFjNmRlZDNiZmZlZThmNTc1NzRiYWZhDQotLS0NCiAuLi4vZHJtL2Ft
ZC9wb3dlcnBsYXkvc2llbm5hX2NpY2hsaWRfcHB0LmMgICAgfCA2OCArKysrKysrKysrKy0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc2llbm5hX2NpY2hs
aWRfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zaWVubmFfY2ljaGxpZF9w
cHQuYw0KaW5kZXggODdlZWRkN2MyOGVjLi5jOGI1OWE4OTFmNWQgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zaWVubmFfY2ljaGxpZF9wcHQuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc2llbm5hX2NpY2hsaWRfcHB0LmMNCkBAIC01MjUs
NiArNTI1LDcgQEAgc3RhdGljIGludCBzaWVubmFfY2ljaGxpZF9zZXRfZGVmYXVsdF9kcG1fdGFi
bGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQogCXN0cnVjdCBzbXVfMTFfMF9kcG1fY29udGV4
dCAqZHBtX2NvbnRleHQgPSBzbXUtPnNtdV9kcG0uZHBtX2NvbnRleHQ7DQogCVBQVGFibGVfdCAq
ZHJpdmVyX3BwdCA9IHNtdS0+c211X3RhYmxlLmRyaXZlcl9wcHRhYmxlOw0KIAlzdHJ1Y3Qgc211
XzExXzBfZHBtX3RhYmxlICpkcG1fdGFibGU7DQorCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gc211LT5hZGV2Ow0KIAlpbnQgcmV0ID0gMDsNCiANCiAJLyogc29jY2xrIGRwbSB0YWJsZSBz
ZXR1cCAqLw0KQEAgLTYxNywyMiArNjE4LDI2IEBAIHN0YXRpYyBpbnQgc2llbm5hX2NpY2hsaWRf
c2V0X2RlZmF1bHRfZHBtX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KIAkJZHBtX3Rh
YmxlLT5tYXggPSBkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0udmFsdWU7DQogCX0NCiANCisNCiAJ
LyogdmNsazEgZHBtIHRhYmxlIHNldHVwICovDQotCWRwbV90YWJsZSA9ICZkcG1fY29udGV4dC0+
ZHBtX3RhYmxlcy52Y2xrMV90YWJsZTsNCi0JaWYgKHNtdV9jbW5fZmVhdHVyZV9pc19lbmFibGVk
KHNtdSwgU01VX0ZFQVRVUkVfTU1fRFBNX1BHX0JJVCkpIHsNCi0JCXJldCA9IHNtdV92MTFfMF9z
ZXRfc2luZ2xlX2RwbV90YWJsZShzbXUsDQotCQkJCQkJICAgICBTTVVfVkNMSzEsDQotCQkJCQkJ
ICAgICBkcG1fdGFibGUpOw0KLQkJaWYgKHJldCkNCi0JCQlyZXR1cm4gcmV0Ow0KLQkJZHBtX3Rh
YmxlLT5pc19maW5lX2dyYWluZWQgPQ0KLQkJCSFkcml2ZXJfcHB0LT5EcG1EZXNjcmlwdG9yW1BQ
Q0xLX1ZDTEtfMV0uU25hcFRvRGlzY3JldGU7DQotCX0gZWxzZSB7DQotCQlkcG1fdGFibGUtPmNv
dW50ID0gMTsNCi0JCWRwbV90YWJsZS0+ZHBtX2xldmVsc1swXS52YWx1ZSA9IHNtdS0+c211X3Rh
YmxlLmJvb3RfdmFsdWVzLnZjbGsgLyAxMDA7DQotCQlkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0u
ZW5hYmxlZCA9IHRydWU7DQotCQlkcG1fdGFibGUtPm1pbiA9IGRwbV90YWJsZS0+ZHBtX2xldmVs
c1swXS52YWx1ZTsNCi0JCWRwbV90YWJsZS0+bWF4ID0gZHBtX3RhYmxlLT5kcG1fbGV2ZWxzWzBd
LnZhbHVlOw0KKwlpZiAoYWRldi0+dmNuLm51bV92Y25faW5zdCA+IDEpIHsNCisJCWRwbV90YWJs
ZSA9ICZkcG1fY29udGV4dC0+ZHBtX3RhYmxlcy52Y2xrMV90YWJsZTsNCisJCWlmIChzbXVfY21u
X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX01NX0RQTV9QR19CSVQpKSB7DQor
CQkJcmV0ID0gc211X3YxMV8wX3NldF9zaW5nbGVfZHBtX3RhYmxlKHNtdSwNCisJCQkJCQkJICAg
ICBTTVVfVkNMSzEsDQorCQkJCQkJCSAgICAgZHBtX3RhYmxlKTsNCisJCQlpZiAocmV0KQ0KKwkJ
CQlyZXR1cm4gcmV0Ow0KKwkJCWRwbV90YWJsZS0+aXNfZmluZV9ncmFpbmVkID0NCisJCQkJIWRy
aXZlcl9wcHQtPkRwbURlc2NyaXB0b3JbUFBDTEtfVkNMS18xXS5TbmFwVG9EaXNjcmV0ZTsNCisJ
CX0gZWxzZSB7DQorCQkJZHBtX3RhYmxlLT5jb3VudCA9IDE7DQorCQkJZHBtX3RhYmxlLT5kcG1f
bGV2ZWxzWzBdLnZhbHVlID0NCisJCQkJc211LT5zbXVfdGFibGUuYm9vdF92YWx1ZXMudmNsayAv
IDEwMDsNCisJCQlkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0uZW5hYmxlZCA9IHRydWU7DQorCQkJ
ZHBtX3RhYmxlLT5taW4gPSBkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0udmFsdWU7DQorCQkJZHBt
X3RhYmxlLT5tYXggPSBkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0udmFsdWU7DQorCQl9DQogCX0N
CiANCiAJLyogZGNsazAgZHBtIHRhYmxlIHNldHVwICovDQpAQCAtNjU0LDIxICs2NTksMjQgQEAg
c3RhdGljIGludCBzaWVubmFfY2ljaGxpZF9zZXRfZGVmYXVsdF9kcG1fdGFibGUoc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUpDQogCX0NCiANCiAJLyogZGNsazEgZHBtIHRhYmxlIHNldHVwICovDQot
CWRwbV90YWJsZSA9ICZkcG1fY29udGV4dC0+ZHBtX3RhYmxlcy5kY2xrMV90YWJsZTsNCi0JaWYg
KHNtdV9jbW5fZmVhdHVyZV9pc19lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVfTU1fRFBNX1BHX0JJ
VCkpIHsNCi0JCXJldCA9IHNtdV92MTFfMF9zZXRfc2luZ2xlX2RwbV90YWJsZShzbXUsDQotCQkJ
CQkJICAgICBTTVVfRENMSzEsDQotCQkJCQkJICAgICBkcG1fdGFibGUpOw0KLQkJaWYgKHJldCkN
Ci0JCQlyZXR1cm4gcmV0Ow0KLQkJZHBtX3RhYmxlLT5pc19maW5lX2dyYWluZWQgPQ0KLQkJCSFk
cml2ZXJfcHB0LT5EcG1EZXNjcmlwdG9yW1BQQ0xLX0RDTEtfMV0uU25hcFRvRGlzY3JldGU7DQot
CX0gZWxzZSB7DQotCQlkcG1fdGFibGUtPmNvdW50ID0gMTsNCi0JCWRwbV90YWJsZS0+ZHBtX2xl
dmVsc1swXS52YWx1ZSA9IHNtdS0+c211X3RhYmxlLmJvb3RfdmFsdWVzLmRjbGsgLyAxMDA7DQot
CQlkcG1fdGFibGUtPmRwbV9sZXZlbHNbMF0uZW5hYmxlZCA9IHRydWU7DQotCQlkcG1fdGFibGUt
Pm1pbiA9IGRwbV90YWJsZS0+ZHBtX2xldmVsc1swXS52YWx1ZTsNCi0JCWRwbV90YWJsZS0+bWF4
ID0gZHBtX3RhYmxlLT5kcG1fbGV2ZWxzWzBdLnZhbHVlOw0KKwlpZiAoYWRldi0+dmNuLm51bV92
Y25faW5zdCA+IDEpIHsNCisJCWRwbV90YWJsZSA9ICZkcG1fY29udGV4dC0+ZHBtX3RhYmxlcy5k
Y2xrMV90YWJsZTsNCisJCWlmIChzbXVfY21uX2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9G
RUFUVVJFX01NX0RQTV9QR19CSVQpKSB7DQorCQkJcmV0ID0gc211X3YxMV8wX3NldF9zaW5nbGVf
ZHBtX3RhYmxlKHNtdSwNCisJCQkJCQkJICAgICBTTVVfRENMSzEsDQorCQkJCQkJCSAgICAgZHBt
X3RhYmxlKTsNCisJCQlpZiAocmV0KQ0KKwkJCQlyZXR1cm4gcmV0Ow0KKwkJCWRwbV90YWJsZS0+
aXNfZmluZV9ncmFpbmVkID0NCisJCQkJIWRyaXZlcl9wcHQtPkRwbURlc2NyaXB0b3JbUFBDTEtf
RENMS18xXS5TbmFwVG9EaXNjcmV0ZTsNCisJCX0gZWxzZSB7DQorCQkJZHBtX3RhYmxlLT5jb3Vu
dCA9IDE7DQorCQkJZHBtX3RhYmxlLT5kcG1fbGV2ZWxzWzBdLnZhbHVlID0NCisJCQkJc211LT5z
bXVfdGFibGUuYm9vdF92YWx1ZXMuZGNsayAvIDEwMDsNCisJCQlkcG1fdGFibGUtPmRwbV9sZXZl
bHNbMF0uZW5hYmxlZCA9IHRydWU7DQorCQkJZHBtX3RhYmxlLT5taW4gPSBkcG1fdGFibGUtPmRw
bV9sZXZlbHNbMF0udmFsdWU7DQorCQkJZHBtX3RhYmxlLT5tYXggPSBkcG1fdGFibGUtPmRwbV9s
ZXZlbHNbMF0udmFsdWU7DQorCQl9DQogCX0NCiANCiAJLyogZGNlZmNsayBkcG0gdGFibGUgc2V0
dXAgKi8NCi0tDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDTGlrdW4uR2FvJTQwYW1kLmNvbSU3QzMw
OThkYjdkMzRjOTRjZWJiMDA2MDhkODJkNTRhNzM4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzMwOTE4ODkxNjQ4ODUxNiZhbXA7c2RhdGE9RUNTMFVKZng1
Q0NXbG4lMkZHNGtlYzdCZW9FM1EzV1ZVQmxxNUdWcTFxMWNvJTNEJmFtcDtyZXNlcnZlZD0wDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
