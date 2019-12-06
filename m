Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80085C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 01:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F68F2075C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 01:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F68F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B446F943;
	Fri,  6 Dec 2019 01:04:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C556F943
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 01:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bql4MN+ksHCTBYIpDQSoZRV2U32cHqL1MoXhTS5LLpbXAwzCJYI9LWedyR5WeX3jCArna8sm/ZGpw4fI9RPU8ssE82RQfkZgSCvYJDU8qLdYnTaImTfnsLmDpRorQRKxLasWDuikB7XGbu5Oj3GKqymRkrRmjDHsZRRLppYjjkDB7IF+FjW+YSMGFgJReZWiChX4toVf7VvNFpUjvLYB8okRAPo61x+SuMLsj+NYaAJbF+05xNQzfZo6VM1+eNMlWfkHU53+EPlaRjNAjEtauNSbsirqQljFrI14Tr6GIQFL2J3gznMnScAK5SZYSZHfex/xTmQtpEOZcKgcGxPz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt20GZ95ewp6KDPqEr/cyUhVEYaMU88K/XxK7u6W20s=;
 b=VfTsaIeuk3T8DB5gh+jTB0Qz52Q0KU1eQwUA7m3wj+Sy0VInNu4a6yyR5QhGsmmz5zP4TmujirHHCPogJV5mOVx+0eHD7259xvXqoQw5HJPJI9VPHdJx0KM8rn+Yjr3gJzqKiGc9YdGwucVI+cJNl+v3Pri0OWIeyMl1meMwcYRwjPcSRK594/gOMw0tPohoPjxR3M63/06ou93vzHsqbvXwNDmXza6vBKnlfBSpPzvcVy5kp4Y6B1XCJvgmGBQFatD8e+Aq2UTZjf8O22w1gTTP/e4cEZl/TeNgb1cX4IexuqMGTBQt8uTUUBjaELdRDUe4ItwK4scpw2Ks3/PeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3214.namprd12.prod.outlook.com (20.179.83.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 01:04:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 01:04:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix BACO entry failure in NAVI10.
Thread-Topic: [PATCH] drm/amdgpu: Fix BACO entry failure in NAVI10.
Thread-Index: AQHVq6JjjGV4zb8iuUatLOdHw5mtg6esSsGg
Date: Fri, 6 Dec 2019 01:04:07 +0000
Message-ID: <MN2PR12MB3344E456673DC7D9EB2B2844E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1575574175-20765-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1575574175-20765-1-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a96d0a51-79a0-410d-a8b0-000025f40c92;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T01:03:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5725ad46-8976-4ec9-8022-08d779e8326c
x-ms-traffictypediagnostic: MN2PR12MB3214:|MN2PR12MB3214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB321459E6D04E4AB816757DC5E45F0@MN2PR12MB3214.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(13464003)(14454004)(54906003)(33656002)(74316002)(14444005)(110136005)(478600001)(81156014)(966005)(8676002)(8936002)(81166006)(45080400002)(76176011)(55016002)(26005)(11346002)(4326008)(66476007)(66556008)(6506007)(66446008)(186003)(102836004)(25786009)(66946007)(64756008)(53546011)(86362001)(7696005)(2906002)(5660300002)(9686003)(76116006)(71190400001)(316002)(99286004)(71200400001)(52536014)(229853002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3214;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZq5jCXHz4stKl654ZR7L0bHQKmlo13djYJgAEK0cuyubAxlZIk4i55juy0nKuMKc07bgId+2k5b83G2fu6Ghomcbq+mGj4Y9ASpUwTfeE+JerUY58wVY7+iKYgbdmbAgrtunrWF98QT47YaD59q7WkhVLpWxahNDZMi7WKsmFd4WqQNO0yhuHP8MZ5/mtrPPap+CtGUpNS2SuonfRM0wiQV/o9RfhNOEbg106WeTJGd5sBB37SYR9xHUlD141iHt3u/BqFTjeHr53EMt0lI+9t3eVkL5MIHwjhZiHZKpGK7YghpBlk5NipNTtQ5umcNTldXCYZSRaKj6KlUew3+GBlatG8YsKp3q87+1hwz8pdFBKhp1VtQ8u8e3MI2orlwiQcC2pPVKpS0qZSAOJHXp46KuUdxjcN/gre7V80IRN1jtAP619csdkTQNfWQhaq9DSFZ22Pv+XVv7viptzRJxWIX/Wma8whoBlZm+3IWnElwF7QETfriffRC9f62MoEERt631vNUUswy7+JoDvVF0H+VE5vH6aEeJbBqyaTguJI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5725ad46-8976-4ec9-8022-08d779e8326c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 01:04:08.0330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlqNkcjvFcIkwUHKJRBmjgjqrSMdoFJSWZmdQPk8mBT6PVoR2uJ+UnGCgEzkR0W+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3214
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt20GZ95ewp6KDPqEr/cyUhVEYaMU88K/XxK7u6W20s=;
 b=t8TL7eLvD/sbkiO37TyzKw/q7eIl4FVWLQ1kv3WKJCZr15ZNKQGsaHQjdgQcVhXju7Eq3TnCDh3IP5/xDOrlFEKh+ZOcxc/+vqXQ5ENUIH6EIf6lDmMob6R86u8hPy6BTqlyqkupe0KP1lWAh3AvGniBTkQauidsuhUmz5ciThc=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFuZHJleQ0KPiBHcm9kem92c2t5DQo+IFNl
bnQ6IEZyaWRheSwgRGVjZW1iZXIgNiwgMjAxOSAzOjMwIEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgR3JvZHpvdnNreSwgQW5kcmV5DQo+IDxBbmRyZXkuR3JvZHpvdnNreUBh
bWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBCQUNPIGVudHJ5IGZh
aWx1cmUgaW4gTkFWSTEwLg0KPiANCj4gQkFDTyBmZWF0dXJlIG11c3QgYmUga2VwdCBlbmFibGVk
IHRvIGFsbG93IGVudHJ5IGludG8gQkFDTyBzdGF0ZSBpbiBTTVUNCj4gZHVyaW5nIHJ1bnRpbWUg
c3VzcGVuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXku
Z3JvZHpvdnNreUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYw0KPiBpbmRleCBjMzBmOWEyLi42ZGRkZDc4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQo+IEBAIC0xMzgzLDcgKzEzODMs
NyBAQCBzdGF0aWMgaW50IHNtdV9zdXNwZW5kKHZvaWQgKmhhbmRsZSkNCj4gIAlpZiAocmV0KQ0K
PiAgCQlyZXR1cm4gcmV0Ow0KPiANCj4gLQlpZiAoYWRldi0+aW5fZ3B1X3Jlc2V0ICYmIGJhY29f
ZmVhdHVyZV9pc19lbmFibGVkKSB7DQo+ICsJaWYgKGJhY29fZmVhdHVyZV9pc19lbmFibGVkKSB7
DQo+ICAJCXJldCA9IHNtdV9mZWF0dXJlX3NldF9lbmFibGVkKHNtdSwNCj4gU01VX0ZFQVRVUkVf
QkFDT19CSVQsIHRydWUpOw0KPiAgCQlpZiAocmV0KSB7DQo+ICAJCQlwcl93YXJuKCJzZXQgQkFD
TyBmZWF0dXJlIGVuYWJsZWQgZmFpbGVkLA0KPiByZXR1cm4gJWRcbiIsIHJldCk7DQo+IC0tDQo+
IDIuNy40DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlDQo+IGRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGYW1kLQ0KPiBnZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2V2YW4ucXVhbiU0MGFtZC5j
b20lN0MzMDIwN2VkZGRmNjQ0NzA0ODgNCj4gYjgwOGQ3NzliOTdiYjElN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3DQo+IDExMTcxMDAyMzYwNTU4NSZhbXA7
c2RhdGE9OXZYV0pqc2tScG5sYlBSNWJhSmElMkJEdDRLWml5Y1NpVXlCOEZsMmINCj4gdnNuayUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
