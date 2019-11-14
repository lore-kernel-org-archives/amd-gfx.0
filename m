Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1BC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 03:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51508206EC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 03:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51508206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850C66E117;
	Thu, 14 Nov 2019 03:09:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680076.outbound.protection.outlook.com [40.107.68.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2046E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 03:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czSaA+TJQSl7QkHdBZ5Dzyl1vL9MeDMKlZ6wfJ6F1GlL8D9ZCAQnOnzmXpTTDv6J/wLb9FuKowwYdMTPYSs73jxZMY/YFjTlTd4EZ1TNkXu3WN7Lw9kz8nzCx+Rb4GkNrOfgjy/i3IThpVUmWSPYSucj9CHK0dRX4Ub2ITOnrMy2UMxjHA3VD97t3RprA0St4UutRmLwfPVGLDawkqN36NE+vTIm9egEFbVKM6Dp9n3H1CoUmmPyjndavaddUAcwVHM3lk/Zp9QDkS2mTXWoroshsopP1WQLzOkZ8hdX5+S0uLzu7fVGdk7zCHDNbEdr1PpNBz1nTmhYvsWRNkcD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XbBZd51TNiPseL2Chezbk7/ax66VELfbt62IqL530c=;
 b=g7r5e7RI8AVjKZ0Vb1higsHHAsAf3GACZLETZUGYB6iI94RFINXwAiQT3hTtenzhTqzUU/TUEB8d3GvVjVqATS9Yn20vr1FOelCQAG2hbpN9knC8cYnE3USrF78wyupwbgc/UfSvEgsRmZudH1EdZd2/JVWmOSWn77A9G1ZBewc/6G/mhLHqAZJeyv9caO1wKmgm6VHWH9awi2h8pRkbSNeIeGg1V+IwOdqjfVjGGQmxH8BS3gpE1S3mKdIu8bC1lyQkeft3td/3qPgaXcSMDLVufX8T4PXXojQK/Wc1SwZOAxQsuF2BShPtzp6gHhyfjPCeuoijJZHj03Roqspg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) by
 MN2PR12MB3984.namprd12.prod.outlook.com (10.255.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 03:09:46 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::2935:2980:666:3c79]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::2935:2980:666:3c79%5]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 03:09:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages
 from amdgpu_ras_reserve_bad_pages
Thread-Topic: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages
 from amdgpu_ras_reserve_bad_pages
Thread-Index: AQHVmnQVkT0p84mqpU2gKUvRSF5mjaeJ9S3Q
Date: Thu, 14 Nov 2019 03:09:45 +0000
Message-ID:
 <MN2PR12MB3054761DA7F4EDEC9975F8AAB0710@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4efdf59b-c9f2-4b04-f189-08d768b01a64
x-ms-traffictypediagnostic: MN2PR12MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39844802B1287486735F4FADB0710@MN2PR12MB3984.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(13464003)(199004)(189003)(64756008)(446003)(66476007)(66946007)(476003)(11346002)(66446008)(486006)(102836004)(26005)(66556008)(33656002)(54906003)(186003)(110136005)(76176011)(2906002)(53546011)(6506007)(7696005)(76116006)(52536014)(99286004)(14444005)(5660300002)(66066001)(2501003)(256004)(6306002)(305945005)(55016002)(9686003)(8936002)(6116002)(478600001)(3846002)(71200400001)(71190400001)(25786009)(81156014)(81166006)(4326008)(966005)(229853002)(8676002)(316002)(6246003)(74316002)(86362001)(7736002)(14454004)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3984;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrMDD6uISLKeqJxT3PXL35ci+bVvbMTKKofNwL8PwESwJrbCK6ikQVyew49WTnycHpJUQq29YfkvZcHs/XbDsHtvXQOI29/R0YwEccloblAEhscG4re7DqZGfgkXIWroQarN4DYtCtaG8vaNNcZhDaQdnICJqXtRXwr8OsdU9kuajVy+S86bIhOkrBctg4ZBsTIOgNWyaB6xAdh8BmuKFe8BoEZWtf3wgUD5hhbUkOzRum+PQ6P0Vyadb8VedlWHD+Ly9oJJV1J/fLlis9mJDWMsOCXLS8T7j8p97893h1tceIwjLixREQDg6pj11mIVT82KI57catLkN7PaIDyJn15gCCY5t2zD6iXgeM9m2Uqn+CS6YElmP5utvDvzwb6/adxZwuvEcQpdq91toJRBmr7w1ikyKxZ6Gu8ZspOIdQxwe05HX6Vcw1P2S/r3TQIy
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdf59b-c9f2-4b04-f189-08d768b01a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 03:09:46.0541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaXwGIOEQQKmR5aNfBdOH7hSrBCevVXfOD/Dtr1iy3c/znFRcktj89ACRsEr1FE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3984
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XbBZd51TNiPseL2Chezbk7/ax66VELfbt62IqL530c=;
 b=ivUPPEOuVDPVhgOSXHqnEnyR42dPPdM42p62kQbwKddswl96txOLvqKg2o/Io8CpcH1D3Gl6vxzbfShUfZbMGmGWbGxqyYtqHJ23otThwIZ2OWaRxX8LQRLGWFQ1F9k/rV4xvi63GGJjSJrGfCA4MRsDaeq1TMDEPmtuYitoXwI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114030945.JVJC-t-71aXIwmhnvsxtz9CShioeYTLvIaurCham0LU@z>

VHdvIHF1ZXN0aW9uczoNCg0KMS4gIndlIGxvc2UgYWxsIHJlc2VydmF0aW9uIGR1cmluZyBBU0lD
IHJlc2V0Ig0KQXJlIHlvdSBzdXJlIG9mIGl0PyBJIHJlbWVtYmVyIHRoZSBjb250ZW50IG9mIHZy
YW0gbWF5IGJlIGxvc3QgYWZ0ZXIgcmVzZXQgYnV0IHRoZSBhbGxvY2F0ZWQgc3RhdHVzIGNvdWxk
IGJlIHJlc2VydmVkLg0KDQoyLiBZb3UgY2hhbmdlIHRoZSBiYWQgcGFnZSBoYW5kbGUgZmxvdyBm
cm9tOg0KDQpkZXRlY3QgYmFkIHBhZ2UgLT4gcmVzZXJ2ZSB2cmFtIGZvciBiYWQgcGFnZSAtPiBz
YXZlIGJhZCBwYWdlIGluZm8gdG8gZWVwcm9tIC0+IGdwdSByZXNldA0KDQp0bzoNCg0KZGV0ZWN0
IGJhZCBwYWdlICh0aGlzIHRpbWUpIC0+IHNhdmUgYmFkIHBhZ2UgKGxhc3QgdGltZSkgaW5mbyB0
byBlZXByb20gLT4gZ3B1IHJlc2V0IC0+IHJlc2VydmUgdnJhbSBmb3IgYmFkIHBhZ2UgKHRoaXMg
dGltZSkNCg0KSXMgdGhhdCByaWdodD8gIFNhdmluZyBiYWQgcGFnZSAodGhpcyB0aW1lKSBpbmZv
IHRvIGVlcHJvbSBpcyBkZWxheWVkIHRvIHRoZSBuZXh0IHRpbWUgdGhhdCBiYWQgcGFnZSBpcyBk
ZXRlY3RlZD8gQnV0IHRoZSB0aW1lIG9mIGRldGVjdGluZyBiYWQgcGFnZSBpcyByYW5kb20uDQpJ
IHRoaW5rIHRoZSBiYWQgcGFnZSBpbmZvIHdvdWxkIGJlIGxvc3Qgd2l0aG91dCBzYXZpbmcgdG8g
ZWVwcm9tIGlmIHBvd2VyIG9mZiBvY2N1cnMuDQoNCmRldGVjdCBiYWQgcGFnZSAodGhpcyB0aW1l
KSAtPiBzYXZlIGJhZCBwYWdlIChsYXN0IHRpbWUpIGluZm8gdG8gZWVwcm9tIC0+IGdwdSByZXNl
dCAtPiByZXNlcnZlIHZyYW0gZm9yIGJhZCBwYWdlICh0aGlzIHRpbWUpIC0+IHBvd2Vyb2ZmL3N5
c3RlbSByZXNldCAoYW5kIGJhZCBwYWdlIGluZm8gKHRoaXMgdGltZSkgaXMgbG9zdCkNCg0KVGFv
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IEFuZHJleSBH
cm9kem92c2t5DQo+IFNlbnQ6IDIwMTnlubQxMeaciDE05pelIDY6NDUNCj4gVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBhbGV4ZGV1Y2hlckBnbWFpbC5jb207IEdyb2R6
b3Zza3ksIEFuZHJleQ0KPiA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT47IENoZW4sIEd1Y2h1
biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47DQo+IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHUvcmFzOiBFeHRyYWN0
DQo+IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMgZnJvbSBhbWRncHVfcmFzX3Jlc2VydmVfYmFk
X3BhZ2VzDQo+IA0KPiBXZSB3YW50IHRvIGJlIGJlIGFibGUgdG8gY2FsbCB0aGVtIGluZGVwZW5k
ZW50bHkgZnJvbSBvbmUgYW5vdGhlciBzbyB0aGF0DQo+IGJlZm9yZSBHUFUgcmVzZXQganVzdCBh
bWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzIGlzIGNhbGxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDE0ICsrKystLS0tLS0t
LS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCB8ICA0ICsrKy0N
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gaW5kZXggNDA0
NDgzNC4uNjAwYTg2ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KPiBAQCAtMTQyMSw3ICsxNDIxLDcgQEAgaW50IGFtZGdwdV9yYXNfYWRkX2JhZF9wYWdl
cyhzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAqIHdyaXRlIGVycm9yIHJlY29y
ZCBhcnJheSB0byBlZXByb20sIHRoZSBmdW5jdGlvbiBzaG91bGQgYmUNCj4gICAqIHByb3RlY3Rl
ZCBieSByZWNvdmVyeV9sb2NrDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19zYXZl
X2JhZF9wYWdlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gK2ludCBhbWRncHVfcmFz
X3NhdmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgew0KPiAgCXN0
cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOw0KPiAg
CXN0cnVjdCByYXNfZXJyX2hhbmRsZXJfZGF0YSAqZGF0YTsNCj4gQEAgLTE1MjAsNyArMTUyMCw3
IEBAIGludCBhbWRncHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdA0KPiBhbWRncHVfZGV2
aWNlICphZGV2KQ0KPiAgCXN0cnVjdCByYXNfZXJyX2hhbmRsZXJfZGF0YSAqZGF0YTsNCj4gIAl1
aW50NjRfdCBicDsNCj4gIAlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IE5VTEw7DQo+IC0JaW50IGks
IHJldCA9IDA7DQo+ICsJaW50IGk7DQo+IA0KPiAgCWlmICghY29uIHx8ICFjb24tPmVoX2RhdGEp
DQo+ICAJCXJldHVybiAwOw0KPiBAQCAtMTU0OCwxMiArMTU0OCw5IEBAIGludCBhbWRncHVfcmFz
X3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgCQlk
YXRhLT5sYXN0X3Jlc2VydmVkID0gaSArIDE7DQo+ICAJCWJvID0gTlVMTDsNCj4gIAl9DQo+IC0N
Cj4gLQkvKiBjb250aW51ZSB0byBzYXZlIGJhZCBwYWdlcyB0byBlZXByb20gZXZlbiByZWVzcnZl
X3ZyYW0gZmFpbHMgKi8NCj4gLQlyZXQgPSBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYp
Ow0KPiAgb3V0Og0KPiAgCW11dGV4X3VubG9jaygmY29uLT5yZWNvdmVyeV9sb2NrKTsNCj4gLQly
ZXR1cm4gcmV0Ow0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIC8qIGNhbGxlZCB3aGVuIGRy
aXZlciB1bmxvYWQgKi8NCj4gQEAgLTE2MTUsMTQgKzE2MTIsMTEgQEAgaW50IGFtZGdwdV9yYXNf
cmVjb3ZlcnlfaW5pdChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAkJcmV0ID0g
YW1kZ3B1X3Jhc19sb2FkX2JhZF9wYWdlcyhhZGV2KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCWdv
dG8gZnJlZTsNCj4gLQkJcmV0ID0gYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhhZGV2KTsN
Cj4gLQkJaWYgKHJldCkNCj4gLQkJCWdvdG8gcmVsZWFzZTsNCj4gKwkJYW1kZ3B1X3Jhc19yZXNl
cnZlX2JhZF9wYWdlcyhhZGV2KTsNCj4gIAl9DQo+IA0KPiAgCXJldHVybiAwOw0KPiANCj4gLXJl
bGVhc2U6DQo+ICAJYW1kZ3B1X3Jhc19yZWxlYXNlX2JhZF9wYWdlcyhhZGV2KTsNCj4gIGZyZWU6
DQo+ICAJa2ZyZWUoKCpkYXRhKS0+YnBzKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuaA0KPiBpbmRleCBmODBmZDM0Li4xMmIwNzk3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IEBAIC00OTIsNiArNDkyLDggQEAgdW5z
aWduZWQgbG9uZw0KPiBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCAgaW50DQo+IGFtZGdwdV9yYXNfYWRkX2JhZF9wYWdlcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gIAkJc3RydWN0IGVlcHJvbV90YWJsZV9yZWNvcmQgKmJwcywg
aW50IHBhZ2VzKTsNCj4gDQo+ICtpbnQgYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICsNCj4gIGludCBhbWRncHVfcmFzX3Jlc2VydmVfYmFk
X3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gDQo+ICBzdGF0aWMgaW5saW5l
IGludCBhbWRncHVfcmFzX3Jlc2V0X2dwdShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgQEAg
LQ0KPiA1MDMsNyArNTA1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgYW1kZ3B1X3Jhc19yZXNldF9n
cHUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAJICogaTJjIG1heSBiZSB1bnN0
YWJsZSBpbiBncHUgcmVzZXQNCj4gIAkgKi8NCj4gIAlpZiAoaW5fdGFzaygpKQ0KPiAtCQlhbWRn
cHVfcmFzX3Jlc2VydmVfYmFkX3BhZ2VzKGFkZXYpOw0KPiArCQlhbWRncHVfcmFzX3NhdmVfYmFk
X3BhZ2VzKGFkZXYpOw0KPiANCj4gIAlpZiAoYXRvbWljX2NtcHhjaGcoJnJhcy0+aW5fcmVjb3Zl
cnksIDAsIDEpID09IDApDQo+ICAJCXNjaGVkdWxlX3dvcmsoJnJhcy0+cmVjb3Zlcnlfd29yayk7
DQo+IC0tDQo+IDIuNy40DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
