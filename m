Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59016C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D92206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nWM04f1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D92206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816806E041;
	Fri, 22 May 2020 08:10:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68216E041
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiusCIg9gHpcMoh8cITZbjdp8kcOecAjy/Q/ltFaQNOG8G58WhA4Kbit6oyWbJF3Ujnlyw4x0K3bezNjFnIKJUXSs1zq/fg7EASGuKX71/VJIwQJSwAivDF/B/7wtQjL7Q6M08Fhab5KeIrnElROad+4Cxte0XbIozFMnv7TTbHVhAnZodDsRRNOKSQglMKaKv28Nbtkpg1pHR6Z+kkkHltna841dM5kWuatS1Yc2Y69F4leOV56VvLE15dE2Pw5Xdsig2XK18uqlcBsh5xIOXir3Ao0ofM9L6yzD+OGszAeSFSWghIGU+9FDXr29Tq70aEttC0f4xGHJNhtXr/Xbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiEdKcUku6F8wbkDXQ8UODOUiRHzOMvJrjjfTeepNQM=;
 b=ksyO+Z88rZE6iJsFm1Vqp4/fjzjpKjPmmKt3Z/9dhF/qRW/o7DUn7EDFPeQk7+3TYmo9081LAfxmtuJCtbyOAUpLWXNrmrWwJfNVbHA7AWKy7xJfiA6ui/Gts8lJo+De93cnpV8Vj8dPW4bbjhxXRMsIVF4Ax+sF6aUpJwfdqLv5GtubSLsy5ak3zmPV61//y2kVBM7nzUDrCGIruju7bRskwiPvq+q0WoYj3BT8aMhKoQModySrMUrD17Z3EVxitwvPSYDLBu9fVFEfTPj68rL2geVlqnQoz+kPBxZP2rRP6rEiH3qovhJFKHrYJU1HtSURT/PEdrCoT2UHdjznEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiEdKcUku6F8wbkDXQ8UODOUiRHzOMvJrjjfTeepNQM=;
 b=nWM04f1XdQZvXEamgJou/OZ4q3N+XgYA6zd45QZcja3NSMow/iySGJFBYRxahpDrupPivwspijf7qRdQbnlOYJnobWULub3+bmtAt+QcSMs/TLNH2G235mTLch5+VZ4oaTxjdOgmyKjTEqQ/mPVap/uCyYluiRyltW/rP17Yna8=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (20.179.93.88) by
 BYAPR12MB3621.namprd12.prod.outlook.com (20.178.54.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Fri, 22 May 2020 08:10:39 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 08:10:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Topic: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Index: AQHWMA4UxYv6BkEbv0Gnlumf7FR0Uqizv3aw
Date: Fri, 22 May 2020 08:10:38 +0000
Message-ID: <BYAPR12MB2888E86B6A5017E5D55A5DFAB0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200522075304.22231-1-guchun.chen@amd.com>
In-Reply-To: <20200522075304.22231-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T08:10:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=17e7c18e-0fa4-4faa-9ba5-0000e8f0ed00;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-22T08:10:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8695586a-bf3b-4288-8524-000084105a7c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.232.44.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4971b5e6-83f9-4ec5-b24f-08d7fe279d26
x-ms-traffictypediagnostic: BYAPR12MB3621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36212B40C0A49AA23B386365B0B40@BYAPR12MB3621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnGT8CyVnrCb8fXsY4JQNttdKT0WxpJGxaV8gmD03Wj+rt2ywdU4A+sizh/F4+7O7e9CHagjJjSXzE+c+x0x/j/uT2s66Z5nSBwQRE0Nz0G/JHrwSaMuhZQ70AmvEX2BqIVTWcBzCDrK7/1qjqquPahyfDb54vLi9mXJKmHdHNWWT8TBJRTHfeV2W5WJ/kUlTEGgsp4xWOz2E+L26ubxEq41y/9PJRk7o19oRxZoAgctj9wCr9bbDpgEmsWQKIu54r0EsgsGNyd+eK1L5e5dtkxmZuuVo0ZvdIOf62EToRUAW1hUcttZanISaJzm4AqGOaHMhBvps8DXvV6h+6IoCIHjrpn1Tr4iT9ChxZiteIe4oHfRBub/MX2M+cNZDzyzwgBDzW0s6WHAJHKNpwZXc+XG6NWAB6wAs00xgwdWF4FVxpBMsLP2a2jg9sJe0azg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(53546011)(6506007)(6636002)(52536014)(2906002)(7696005)(478600001)(186003)(316002)(26005)(86362001)(66946007)(33656002)(66446008)(66476007)(66556008)(5660300002)(8676002)(8936002)(55016002)(64756008)(9686003)(76116006)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: lyUFBRvQHFbnabiZLGEaNYj4m3qJykDkC4oYelOlQeb6G5GQi9jaIxKr4Gu6WfqQxPyKuTxAed2iOzzoM9QDjZesav3CB0jC3ueBfY3s00R7FDbtyBGASTyAU8uG4m1Ubw04Ne/fYdiSnBPPuOWAFQG+x6BFHebm8ULOxuOpQ5raGNiFXZfOoh91qjGY6dkwo/HzvIZJSWYiLavDUAl4yI7rbHULHQl1s3XYtxmlGStsidK5ciPCq/Q2FsECGpcNRpij4Xh/cV/ZPHroW3F89IPP1oO81+eke1bHgfE6zXjc9ymqIqQQgNl8HjEe/DxdWZbKpKMxpdCuHFgjeTOs2Y55GRM7cO/XkM5Q0vLoelZl/0gzh2QzHvGrtmbU9eLbieXQZ5IMUl0Ud/NiTLkhYHUgqFShroGuJdfC9DhqwvQlahejOCTBruwjPhF2mAB2l6TYVf5XMpT2bpWSG6UdjhAdBXiXVEjXK4AYd7U3rZY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4971b5e6-83f9-4ec5-b24f-08d7fe279d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 08:10:38.8993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+vJpvNwR59+rIpqh8/LVaqTDKQyyancERcH7Zy3GakNy97pHFjHI/1XfYOoa/TT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3621
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuLCBHdWNodW4gPEd1
Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFNlbnQ6IDIwMjDE6jXUwjIyyNUgMTU6NTMNCj4gVG86IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+Ow0KPiBDbGVtZW50
cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgTGksIERlbm5pcw0KPiA8RGVubmlzLkxp
QGFtZC5jb20+DQo+IENjOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogcHJpbnQgd2FybmluZyB3aGVuIGlucHV0IGFkZHJl
c3MgaXMgaW52YWxpZA0KPiANCj4gVGhpcyB3aWxsIGFzc2lzdCBkZWJ1Zy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDIgKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMNCj4gaW5kZXggNmU5MTFjYTk3MDM4Li41YzczZjQ0NGVhZWYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gQEAgLTMxOCw2ICsz
MTgsOCBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfcmFzX2RlYnVnZnNfY3RybF93cml0ZShzdHJ1
Y3QNCj4gZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKg0KPiAgCWNhc2UgMjoNCj4gIAkJaWYg
KChkYXRhLmluamVjdC5hZGRyZXNzID49IGFkZXYtPmdtYy5tY192cmFtX3NpemUpIHx8DQo+ICAJ
CSAgICAoZGF0YS5pbmplY3QuYWRkcmVzcyA+PSBSQVNfVU1DX0lOSkVDVF9BRERSX0xJTUlUKSkg
ew0KPiArCQkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiSW5wdXQgYWRkcmVzcyAweCVsbHggaXMNCj4g
aW52YWxpZC4iLA0KPiArCQkJCQlkYXRhLmluamVjdC5hZGRyZXNzKTsNCg0KW1Rhb10gSG93IGFi
b3V0IHRoaXMgd2F5Og0KZGV2X3dhcm4oYWRldi0+ZGV2LCAiUkFTIGluamVjdGlvbiBhZGRyZXNz
IDB4JWxseCBleGNlZWRzIGxpbWl0IDB4JWxseC4iLA0KCQkJCWRhdGEuaW5qZWN0LmFkZHJlc3Ms
IFJBU19VTUNfSU5KRUNUX0FERFJfTElNSVQpOw0KDQo+ICAJCQlyZXQgPSAtRUlOVkFMOw0KPiAg
CQkJYnJlYWs7DQo+ICAJCX0NCj4gLS0NCj4gMi4xNy4xDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
