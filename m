Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336AC010C6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A825C21D6C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A825C21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624726E9FB;
	Tue,  5 Nov 2019 11:55:18 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730056.outbound.protection.outlook.com [40.107.73.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DC66E9FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 11:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaOpoQQMn5hOHo7KvDjbjn6DmkGKKoe4GyFzrCgQsIZNHf4EGVdhNogl+4U/TQZjIyl0m0O+ZhGyNsJ0Rj2IJvPrZWKb7AMmt8hP5Sa/EkM0C/m6gl7r5X7M2N4FcSAFhEWeZr5JramIcQggCA86grQXmvcMP2xuplBjpEBHUM0WcLp/iQcNP/0J6XQf+Qp8Ru8kPH/3JAKxKpvVE/58Ls5RrKucOt9OAl5Na8oemdl3VhDbl0o4WNMZpuzEAddWzO9EhJxwwXGuAjwddkMNd73GmdNL5BnpQcY5BIBT0B7bJg3I2dYnHiazUH0EoriZKAO/5i5Z3mOR2aBIjNZRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PpoCuk1pGVwHjGWJ9OZzxUHeAeXtb5SoFkKrGi6yo4=;
 b=d1iTxLPfXF9b7WTnZgf63X7VMYu72PGNLgdePo10Cmo6W95SUiRn4zzuNxkbb7BMEIUwHh5b70SvacimrxUZG1rcZdLcT8EUMuF7Pkw7SO5ZBavn3QkYDGUqxmOqK7gIcsk6gut5XNjhHlRaf0uRHC2Gwoyde4dRqsFy4qelUBoErzZRO9iljq9zycBFt37qRJ3BCWwgre362Lp3j5y79sw/GGLoLFUyJmr6aFaRjDCSFuR6jnCVSf91/4rvMuR3yCcV5tCdbRc+GIelZP+ym+o6lqsO5m9AztGFGkQ1VkimsViAqaoyQ24RTQUA8+qFYdWOvsXw5j0tYL8n8AAggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1739.namprd12.prod.outlook.com (10.175.90.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:55:15 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 11:55:15 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add warning for GRBM 1-cycle delay issue
 in gfx9
Thread-Topic: [PATCH 2/2] drm/amdgpu: add warning for GRBM 1-cycle delay issue
 in gfx9
Thread-Index: AQHVk84hxCMD9AXHyEKy5OVLzPpXyKd8eCKA
Date: Tue, 5 Nov 2019 11:55:14 +0000
Message-ID: <c9a6f8bc-5385-a92a-f0f6-4e719ce78a87@amd.com>
References: <20191105114219.4797-1-changfeng.zhu@amd.com>
In-Reply-To: <20191105114219.4797-1-changfeng.zhu@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR07CA0089.eurprd07.prod.outlook.com
 (2603:10a6:207:6::23) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df2641f9-1aca-4bf6-7cfe-08d761e7050f
x-ms-traffictypediagnostic: DM5PR12MB1739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1739A16EE981C9F30D39EFDB837E0@DM5PR12MB1739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(110136005)(316002)(14444005)(71200400001)(5660300002)(229853002)(58126008)(8676002)(71190400001)(36756003)(6486002)(25786009)(305945005)(446003)(31686004)(99286004)(478600001)(486006)(66574012)(476003)(11346002)(7736002)(6436002)(6636002)(6506007)(64756008)(66556008)(66476007)(66446008)(52116002)(386003)(46003)(76176011)(102836004)(186003)(66946007)(2501003)(6246003)(6512007)(81166006)(14454004)(31696002)(65806001)(2616005)(65956001)(86362001)(6116002)(8936002)(2906002)(256004)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1739;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0L4JD2+DorR/NIDOi8A1pkJ2UdAWwGrm8QM1knjTGusnv+5TouMwBN/+vyL9vm4MjGvMeWrKl/ukBqiqRZNRxxZdMc88wSEKvUY+nWlXiql9wWbsZXpnLCO4HVRb30QQsQyqjytz8qM67hHZ2mh2Xl8v/NLEC5yPzxc1Jtxx6ARid3T4FULIaqgGn9MVr6nG2Qemkrxlc9jkN37OrdgyW9bgbNxTr0VGt5U9OA8f+XDMSJg5gbvGoxHzRq9c5b4awL1VjXWAEpfpd2xiZgqu+PQZXLYXrTtQ5x21VUh6GM966lLNCpkjkOevmo//5JJttQ5md7rNxSSjYBlI8YHQ8ODCktU1xO1GMpx1NaHvG1FYckGZJHK9PsLzaqjM1Dwy9VB2KZEyudK3aHs+4OWxV+IcIgNuDCfhdTBHx3IW9R4RRUeT3mNN+HR0oHxEdi5I
Content-ID: <A814FD50048D3F43BA5405A9B2CDEEBC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2641f9-1aca-4bf6-7cfe-08d761e7050f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:55:14.8924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+mw/c/jI1rCxH6zjYxkbaR8C9VcfQ7OVYDoqrXkq/jkeeoMiwfx36JubSeLBdOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1739
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PpoCuk1pGVwHjGWJ9OZzxUHeAeXtb5SoFkKrGi6yo4=;
 b=DRsf0OswFFgPRAdyg0LeG22Qqnv4Rch79jXKJQ62LB4AyQlF+9PrPA9q3CfX51OlIJGDA5TQc6qsAmbbrNg+fnkBT/fYpfQlXIvKO3qU+jMRvyqHYFMHyII2OQMIjYk7pPypEbstiQJGIDJFjdT8kD7ooR0b4tyatv3V850iKGY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Message-ID: <20191105115514.Vw_LXbIHyOiNmo3Ux314BfSeKjQMOWSgdd4UVm_ErbM@z>

QW0gMDUuMTEuMTkgdW0gMTI6NDIgc2NocmllYiBaaHUsIENoYW5nZmVuZzoNCj4gRnJvbTogY2hh
bmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NCj4NCj4gSXQgbmVlZHMgdG8gYWRkIHdhcm5p
bmcgdG8gdXBkYXRlIGZpcm13YXJlIGluIGdmeDkNCj4gaW4gY2FzZSB0aGF0IGZpcm13YXJlIGlz
IHRvbyBvbGQgdG8gaGF2ZSBmdW5jdGlvbiB0bw0KPiByZWFsaXplIGR1bW15IHJlYWQgaW4gY3Ag
ZmlybXdhcmUuDQo+DQo+IENoYW5nZS1JZDogSTZhZWY5NGYwODIzMTM4ZjI0NGYxZWVkYjYyZmRl
ODMzZGQ2OTcwMjMNCj4gU2lnbmVkLW9mZi1ieTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1k
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4gZm9yIHRoaXMgb25lLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMgfCA3ICsrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiBpbmRl
eCA5ZDVmOTAwZTNlMWMuLmYyZGViMjI1YzhhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jDQo+IEBAIC05ODIsNiArOTgyLDEzIEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2NoZWNrX2Z3X3dyaXRlX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAg
CWFkZXYtPmdmeC5tZV9md193cml0ZV93YWl0ID0gZmFsc2U7DQo+ICAgCWFkZXYtPmdmeC5tZWNf
Zndfd3JpdGVfd2FpdCA9IGZhbHNlOw0KPiAgIA0KPiArCWlmICgoYWRldi0+Z2Z4Lm1lY19md192
ZXJzaW9uIDwgMHgwMDAwMDFhNSkgfHwNCj4gKwkgICAgKGFkZXYtPmdmeC5tZWNfZmVhdHVyZV92
ZXJzaW9uIDwgNDYpIHx8DQo+ICsJICAgIChhZGV2LT5nZngucGZwX2Z3X3ZlcnNpb24gPCAweDAw
MDAwMGI3KSB8fA0KPiArCSAgICAoYWRldi0+Z2Z4LnBmcF9mZWF0dXJlX3ZlcnNpb24gPCA0Nikp
DQo+ICsJCURSTV9XQVJOX09OQ0UoIldhcm5pbmc6IGNoZWNrIGNwX2Z3X3ZlcnNpb24gYW5kIHVw
ZGF0ZSBpdCB0byByZWFsaXplIFwNCj4gKwkJCQkJCUdSQk0gcmVxdWlyZXMgMS1jeWNsZSBkZWxh
eSBpbiBjcCBmaXJtd2FyZVxuIik7DQo+ICsNCj4gICAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUp
IHsNCj4gICAJY2FzZSBDSElQX1ZFR0ExMDoNCj4gICAJCWlmICgoYWRldi0+Z2Z4Lm1lX2Z3X3Zl
cnNpb24gPj0gMHgwMDAwMDA5YykgJiYNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
