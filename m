Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2FFC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 05:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054312154A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 05:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054312154A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB0F8997C;
	Thu, 28 Nov 2019 05:27:43 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800073.outbound.protection.outlook.com [40.107.80.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F1B8997C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 05:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUSYkuDpuwbzquVat9FP2gNOQj6T4oXOv6ec+AIA8JtkrwCPmXCSY9nYhT0Ez8TIMnR9iMImc3WHY5cP2vHycijytB76STw9IoSLCroJ7tjFivnxvqmCEPvEr5TK08YXLfQiJJDs4RQvQQW4rNI+1BBHvjr75Xq8uXHDXak7V8+qe2qFUJFKAQ/shmCb4bU5wxJZUri5d595XyVmo9xeG23InljaHtaB70hz/SA/cVbvIs46mv669NOYx+QgCuy2vK3/TePbzbcedskllW4wtiBGgbbRkre63XoL+k4MdbDEOnU3PNdkCk0fFphKdCvEJ60WcQnel5pL9cL2S5QNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+GR2IU+6uYxbjmvRGqrdC1dBBRnXtSMn8wOqYlsN7U=;
 b=BiZJJEeQMkgExKV/OBBrX+es63qA0ljwp1QRROKWExYUX6uPJkY/59sSDtEzRQbvtlyAztnz0M9wAsIUAuymMzgov5k6DX/vs1g1IawFCpPtBAz+E7PQMenjm3elhqFg7d66/xciEHtbW3Kn9Ku9iNQYPrCRGVOxJ7ApSMxYKpd/O9n/8fZB8nfl78R/ZF2mGOsz4FpUMn2B1p4W91bemY8GhWeFJknrLjXa075uE386QKFByHO8T2QvwRmPJwXewygBzuzzfn24CiGMowJCM/E6cimhQl7vPXvbNxao1KcjVvfGEDg33KJX6V1Ke1ATAPA68l0ntKyrc637I4yZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1515.namprd12.prod.outlook.com (10.172.35.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 05:27:39 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 05:27:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/10] drm/amdgpu: remove ras global recovery handling
 from ras_controller_int handler
Thread-Topic: [PATCH 01/10] drm/amdgpu: remove ras global recovery handling
 from ras_controller_int handler
Thread-Index: AQHVpQM9uJhZ1/fWtEmMWNUhGzSFCaegDnww
Date: Thu, 28 Nov 2019 05:27:39 +0000
Message-ID:
 <DM5PR12MB1418A6DF4E81A0C5582330F5FC470@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-28T05:27:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d55ae33-b23b-414a-9457-00002a0836d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-28T05:27:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 03ce5770-8183-4735-a202-0000bb907643
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b7eeb80-6571-40bc-830d-08d773c3af8e
x-ms-traffictypediagnostic: DM5PR12MB1515:|DM5PR12MB1515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1515B58BF3953445C2F51792FC470@DM5PR12MB1515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(13464003)(189003)(199004)(256004)(14444005)(102836004)(446003)(11346002)(14454004)(6436002)(66066001)(6506007)(53546011)(6246003)(4326008)(186003)(26005)(66946007)(76116006)(66556008)(64756008)(71190400001)(66476007)(66446008)(52536014)(5660300002)(71200400001)(7696005)(229853002)(76176011)(86362001)(478600001)(55016002)(9686003)(54906003)(8936002)(33656002)(81166006)(2906002)(316002)(81156014)(8676002)(305945005)(74316002)(7736002)(99286004)(25786009)(2501003)(6116002)(3846002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1515;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvHTSsUghgf+z999QLstOd47lDCvkKNHtVE6YLE/46OQpWtCHgpSgVuYVvfC0GTpxkwMjyBw3UzJJWiHrQhanoJIdnoxWpMDHWlRFG2e0EBRgda5OMyjGPYjaD6Ka3/OEEHekaOdDIfFrQ60Kscgxpl5b6V2DKG3m5Y3mY23kP0EwqteVBte/IcSdpzSXhYZSfidf+35uujcHICGGM8O1qwsVqaSxO4BxxJOWg/9FEEeEyIY4uJmPr3ydmthf5m7OhlQyT1sXX6FXZ25QK/kxjDzTbvejZ+m673AOYBEaPQZ8ymVbr4w3UaPaqpT/crC2GP71dTIs1PIa8qeJLOmkk39qlNLgEzkFlC3rxQeeEw4kEbdah1f+DpRbypAVhG3TgS3eDZ7xuYYDfHQd1PoDJroqWaPeWoDNeeadIUkFzZx22c+GaQzUYZvccw/TRUX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7eeb80-6571-40bc-830d-08d773c3af8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 05:27:39.3445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7h1UpaiZvItl76aW0mQxpbLrtSs9Kt1HWQCq9u77BY6JVY89mbvdiX7RWL/oXQJHtxUNX544I8aooavtHJ0hXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+GR2IU+6uYxbjmvRGqrdC1dBBRnXtSMn8wOqYlsN7U=;
 b=vvnch2/F6GBtDaS6FOPpB2hrsgFDhQ/m7uw9Nk6YVKASUiIKk/JR3ItRePYdXjZyOORJ4uehImE476L2rPlMoBeZglLvD8Rmcey5SV5qI6N0lcKmv9prjURlR72bJrQOom7LEs7xtwL6h0xnI/zFw6TOBT/WIbJ1qGHsO9TtPZs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128052739.SgjOYDMnYDor3sqq5YG7NJ3KK_K7ef_s8vTEaceXszA@z>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpX
aXRoIHRoZSB2MiB2ZXJzaW9uIGZvciBwYXRjaCAjNiwgIzcgYW5kIHRoZSBmaXggdG8gZW5hYmxl
IGRvb3JiZWxsIGludCBhZnRlciBCQUNPIGV4aXQgaW4gUGF0Y2ggIzUsDQoNClRoZSBzZXJpZXMg
aXMgDQoNClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
TGUgTWEgPGxlLm1hQGFtZC5jb20+IA0KU2VudDogMjAxOeW5tDEx5pyIMjfml6UgMTc6MTUNClRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBa
aG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTWEs
IExlIDxMZS5NYUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDAxLzEwXSBkcm0vYW1kZ3B1OiBy
ZW1vdmUgcmFzIGdsb2JhbCByZWNvdmVyeSBoYW5kbGluZyBmcm9tIHJhc19jb250cm9sbGVyX2lu
dCBoYW5kbGVyDQoNCkZyb206IExlIE1hIDxMZS5NYUBhbWQuY29tPg0KDQp2MjogYWRkIG5vdGlm
aWNhdGlvbiB3aGVuIHJhcyBjb250cm9sbGVyIGludGVycnVwdCBnZW5lcmF0ZXMNCg0KQ2hhbmdl
LUlkOiBJYzAzZTQyZTlkMWM0ZGFiMWZhN2Y0ODE3YzE5MWExNmU0ODViNDhhOQ0KU2lnbmVkLW9m
Zi1ieTogTGUgTWEgPExlLk1hQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYmlvX3Y3XzQuYyB8IDcgKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L25iaW9fdjdfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180
LmMNCmluZGV4IDBkYjQ1OGYuLjI1MjMxZDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9uYmlvX3Y3XzQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bmJpb192N180LmMNCkBAIC0zMjQsNyArMzI0LDEyIEBAIHN0YXRpYyB2b2lkIG5iaW9fdjdfNF9o
YW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9ub19iaWZyaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNl
DQogCQkJCQkJUkFTX0NOVExSX0lOVEVSUlVQVF9DTEVBUiwgMSk7DQogCQlXUkVHMzJfU09DMTUo
TkJJTywgMCwgbW1CSUZfRE9PUkJFTExfSU5UX0NOVEwsIGJpZl9kb29yYmVsbF9pbnRyX2NudGwp
Ow0KIA0KLQkJYW1kZ3B1X3Jhc19nbG9iYWxfcmFzX2lzcihhZGV2KTsNCisJCURSTV9XQVJOKCJS
QVMgY29udHJvbGxlciBpbnRlcnJ1cHQgdHJpZ2dlcmVkIGJ5IE5CSUYgZXJyb3JcbiIpOw0KKw0K
KwkJLyogcmFzX2NvbnRyb2xsZXJfaW50IGlzIGRlZGljYXRlZCBmb3IgbmJpZiByYXMgZXJyb3Is
DQorCQkgKiBub3QgdGhlIGdsb2JhbCBpbnRlcnJ1cHQgZm9yIHN5bmMgZmxvb2QNCisJCSAqLw0K
KwkJYW1kZ3B1X3Jhc19yZXNldF9ncHUoYWRldiwgdHJ1ZSk7DQogCX0NCiB9DQogDQotLSANCjIu
Ny40DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
