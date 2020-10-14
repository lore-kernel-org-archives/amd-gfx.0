Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B256C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AA622201
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rIljUmil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AA622201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D216EA54;
	Wed, 14 Oct 2020 15:06:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7CE6EA54
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 15:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmBa4Vxo4bMDDbk/CWxpgN8Tceb4VyabVANvVyNR8QeO9P1XoaistTFgSuHM7x+F1kOA9YUClR5ZdTSZ5H/HNDAFV7BhiXwf4E14f69Fob3/kT72dIJS0MpbXYvdTWnA0s2Q8YH0MCd7bNzLSc7VYZD8l4Vsss3AuIw6Noj/ySSMkjfNmuSgX0tL0nmeuKjlXVLTOs2Zrs6BbhN7IBWLeNKy7Ap3xgoq26bTnDKRP6REyk0nYhj0BOJc92sJqifvIUXrN0xxJp6FGdNUh+bfogaRdBF0s8W67AoRRZRuVb66SKzgvl6DRz6JEFK9Fko2guIStoWLnloZp2pWRmLgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrmVR3htwnfde8eNFyopKtDQghnEgTM69um7kZIiT0=;
 b=UqqjzTAYBGw3zabsKe1wrgnFYMmvdO1oFfJiQmRe4TFH720s0I0BMFFVhXMTH8gqBuREVL28bfLFN5WjWh+FakIcSbtat9u2a3IjDIQfm1dSaHJmIByNZYjjs80sV0Ls6oOZlkXpncUFD9hPJ/FsNRch6xmHNvBWNNnyk6idMTzUWmMNjlnJbxDFihMUnftpEzd66iJunoLegd26V1JRKpuq8mGeXMqjl3KjPiEIKw/RcNWCDQyzCqUPBWaEFgATdfTbOAMN7VOeHwUKwX8wUtMbQK1VYA2m/ja8wyeKOnG0oyDFPcmQsrmM71w/rIfNPWSXWdj4dBiTR3T4AWfxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrmVR3htwnfde8eNFyopKtDQghnEgTM69um7kZIiT0=;
 b=rIljUmil4LQxvXTzTgHPXdW12zhbbnzIXUfMO+BzgLcQgXwX8ODsuYHUyiK1MHOAgHgweBBTorWVSkGba+3qjc/5mn9FblBCC/h6PxgT+g7lf+s8v3LL77DfE3GfoFtuM2vc284VO5aKCLIy1tWVd2DAF25XTpawSEIGmsgymzY=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 15:06:19 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:06:19 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Thread-Topic: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Thread-Index: AQHWoYN2yF83VjUl8kiqEt4gSjFJx6mWwrLggAAEdwCAACmA8A==
Date: Wed, 14 Oct 2020 15:06:19 +0000
Message-ID: <BL0PR12MB243361E0298DFFB3C70CD7969C050@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201013170820.1548-1-christian.koenig@amd.com>
 <BL0PR12MB24337593D8FB1AA27A5E1AB89C050@BL0PR12MB2433.namprd12.prod.outlook.com>
 <6e57bfbc-fe17-7e1c-5f9e-b5bad7ffad17@gmail.com>
In-Reply-To: <6e57bfbc-fe17-7e1c-5f9e-b5bad7ffad17@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-14T15:06:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=35a24752-04d8-42a4-a18a-0000f029a650;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-14T15:06:08Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5fac3713-38c1-42f2-974c-00002fc7672d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-14T15:06:14Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 66551a99-5de6-4720-bafd-00001075a31c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd7eeed4-7d0f-45f9-77fb-08d87052b4f1
x-ms-traffictypediagnostic: BL0PR12MB2369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2369B44581FC2DAA79125CDC9C050@BL0PR12MB2369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5jFWLccAG3uMVcTNEObqqt+a3ToUfV+9F6jByc8fy7UqMt+D7r9Pye02BltqvvgEiS4sr6Vyf6I4o3smqs51t2X1FQUfV1+EB33SBLM5l1/lY+syVmpZTdTQ7mxOr9nao+w9zeqhWti+WkkH2uZlFEbDORPDg1tc2JKTmQFlVvQUrZ8w6EewZpXqqtq/rSedGnhtO9/wdSITs9CYbnyYb9mnrncfrUHIu0zynNbg13N7zuafm6vQ3d/E+GJp/6sk94jxSvmFYmxJsUcpxU9c8RrVG05xV4JGU0W3EYGrtx/MfNmDaolnH/fkcyXA05XS5LXBBMA541LoPYDXQvXFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(478600001)(5660300002)(33656002)(110136005)(316002)(6506007)(55016002)(186003)(53546011)(7696005)(86362001)(26005)(4326008)(76116006)(8676002)(71200400001)(8936002)(52536014)(66476007)(66946007)(9686003)(66556008)(66574015)(83380400001)(2906002)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mpHtwJEy0eehr+Psipdh2AFXvxiLYrgolFUL/gA29Oz9M7IluS10Uuj9l4HtU+o1ss2lhk6mHh5MYYgTyAQQ1O/2yAAyVQU2czyQvWfIS3L7KAeixEosLzbdV7UXkAOSUocu9YcpjSwXM2oMb3qkNx2u7svQdTS2HFvmf8OupqiwNmXWKZUfRAD8hYUMReRy55yE4aI5QyLRr3brobch2y2TqR4IlZuOy+WYIa7hF5psKadbnQWRUO3RYTPFOQmsDpfWQklHzasfvMgVhpR+IbPIi2lAwdALGChrOuzY3DTPOQTk3hwUhn4VuBShncsEMV2O1uytOEqzrn7TFbFJjqzavLd47e4PAgh9GkIrzg6g5GfM/xrRYw6zkt5qxq1dNM9Ner52tHQbEw7mwAyjgSaRhf57WWIrwjMP3Ji5uZSjW7Iv04lLTqJekXPWDsxUKod84aEw8X/eeF9/8jCte1qOEp/KuG4CQUlve+rhVIFL3mDWO3VSBHHKk9t/hGJJBQ5EOp1EMG0WevmlxMyWTff1bP/bKkuNu6vi79M3VEzpQm8XW9WaIYiVlGePjOvqtdblpmot+qIgd2ofxduuX/VaCEPNl239YP8WSwId1Z91Nl3hkWhG/6QTZM7sLhuKli/ErbsZmAJb+feZfAG+0w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7eeed4-7d0f-45f9-77fb-08d87052b4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 15:06:19.7188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEdvhBNv9OBjI5ppYJRgntPGyCQvEw/ULmVnQhuxU5ST9abMeencoz8TWX/eIR409dM8jKDyRAAkEKDUl0p1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBPY3RvYmVyIDE0LCAyMDIwIDI6MDYgUE0NClRvOiBDaGF1aGFuLCBNYWRoYXYg
PE1hZGhhdi5DaGF1aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdTogaW5jcmVhc2UgdGhlIHJlc2VydmVkIFZNIHNpemUgdG8gMk1CDQoN
CkFtIDE0LjEwLjIwIHVtIDEwOjI2IHNjaHJpZWIgQ2hhdWhhbiwgTWFkaGF2Og0KPiBbQU1EIFB1
YmxpYyBVc2VdDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDEzLCAyMDIwIDEwOjM4IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRoYXYuQ2hhdWhhbkBhbWQu
Y29tPjsgUGFuLCBYaW5odWkgDQo+IDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCAxLzJdIGRybS9hbWRncHU6IGluY3JlYXNlIHRoZSByZXNlcnZlZCBWTSBzaXplIHRvIDJN
Qg0KPg0KPiBJZGVhbGx5IHRoaXMgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgdGhlIFZNIGJsb2Nr
IHNpemUuDQo+IDJNQiBzaG91bGQgYXQgbGVhc3QgZml0IGZvciBWZWdhL05hdmkuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggfCA0ICsr
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgNCj4gaW5kZXggN2M0
NjkzN2MxYzBlLi44MWNjZDBhMGMzZGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5oDQo+IEBAIC0xMTIsOCArMTEyLDggQEAgc3RydWN0IGFtZGdwdV9ib19saXN0
X2VudHJ5Ow0KPiAgICNkZWZpbmUgQU1ER1BVX01NSFVCXzAJCQkJMQ0KPiAgICNkZWZpbmUgQU1E
R1BVX01NSFVCXzEJCQkJMg0KPiAgIA0KPiAtLyogaGFyZGNvZGUgdGhhdCBsaW1pdCBmb3Igbm93
ICovDQo+IC0jZGVmaW5lIEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFCQkJKDFVTEwgPDwgMjApDQo+
ICsvKiBSZXNlcnZlIDJNQiBhdCB0b3AvYm90dG9tIG9mIGFkZHJlc3Mgc3BhY2UgZm9yIGtlcm5l
bCB1c2UgKi8NCj4gKyNkZWZpbmUgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUJCQkoMlVMTCA8PCAy
MCkNCj4NCj4gTG9va3MgZmluZSB0byBtZTogUmV2aWV3ZWQtYnk6IE1hZGhhdiBDaGF1aGFuIDxt
YWRoYXYuY2hhdWhhbkBhbWQuY29tPiANCj4gQ2xhcmlmaWNhdGlvbiBvbiBjb21tZW50Og0KPiBX
ZSBjaGVjayB2YV9hZGRyZXNzIDwgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUgZm9yIGludmFsaWQg
cmVzZXJ2YXRpb25zLCBzaG91bGRu4oCZdCB0aGlzIGJlICJib3R0b20iaW5zdGVhZCBvZiAidG9w
L2JvdHRvbSIgb2YgYWRkcmVzcyBzcGFjZT8/DQoNCkluIGFtZGdwdV9pbmZvX2lvY3RsKCkgd2Ug
cmVwb3J0IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFIGFzIHN0YXJ0IG9mIHRoZSB1c2FibGUgYWRk
cmVzcyBzcGFjZSBhbmQgdm1fc2l6ZSAtIEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFIGFzIGVuZC4N
Cg0KQ291bGQgYmUgdGhhdCB3ZSBkb24ndCBjaGVjayBpZiB0aGUgYWRkcmVzcyBpbiB0aGUgcmVz
ZXJ2ZWQgaG9sZSBhdCB0aGUgZW5kIG9mIHRoZSBhZGRyZXNzIHNwYWNlLiBUaGF0IHdvdWxkIGJl
IGEgYnVnIGFuZCBzaG91bGQgcHJvYmFibHkgYmUgZml4ZWQuDQoNClRoYW5rcy4gSW5zaWRlIGFt
ZGdwdV9nZW1fdmFfaW9jdGwsIFNob3VsZG7igJl0IHdlIGFsc28gdmFsaWRhdGUgYWRkcmVzc2Vz
IGJpZ2dlciB0aGFuIEFNREdQVV9HTUNfSE9MRV9FTkQ/Pw0KQ3VycmVudGx5IHdlIGFsbG93IHRo
ZW0gYW5kIGp1c3QgcmVtb3ZlIGxhc3QgMTYgYml0cy4gV2hhdCB3aWxsIGhhcHBlbiBpZiBVc2Vy
IHBhc3NlZCAweCBmZmZmIGZmZmYgZmZmZiBmZmZmLCBpdCB3aWxsIGJlIHRyZWF0ZWQgYXMgMHgg
ZmZmZiBmZmZmIGZmZmYNCldoaWxlIGFkZHJlc3Mgc3BhY2UgZW5kIGlzIDB4IGZmZmYgZmZmZiAw
MDAwPz8NCg0KUmVnYXJkcywNCk1hZGhhdg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gUmVnYXJkcywN
Cj4gTWFkaGF2DQo+ICAgDQo+ICAgLyogbWF4IHZtaWRzIGRlZGljYXRlZCBmb3IgcHJvY2VzcyAq
Lw0KPiAgICNkZWZpbmUgQU1ER1BVX1ZNX01BWF9SRVNFUlZFRF9WTUlECTENCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
