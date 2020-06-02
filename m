Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83117C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DEA20738
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 06:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dE+5KKfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DEA20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A78789CD7;
	Tue,  2 Jun 2020 06:03:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6A789CD7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 06:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmx/SlgqSy7917JtH8njV2ktzi3xN3ReCzoOvqLi6tLkRwPklJD79mO1SeXiJNvfi2zxqgTC81xRGS92yKCBxc8n/90TeCCaJkZtHekDNEITfHxyHbAqvnlfkiuA+Qa0oAyiETb5q3eMo1iH+3u5x3Pge+qz/rRTGLRKdZh4D9W9RUZgM9jdXHiUXxSbypHH5GtZMLhZS+86ydoxJPI0G4SoONi2ckuoz0wxgC3xDrnjBZdYILNEAvCXKg51idlbCL9q/q3pI5BKq3878ftrj378NoDZlrUr374Jbc42l15JtCyekQzhbyXrHj6RRGAOZ6BSQySiFiEfZbpP2D2YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3ELNOY1ZeI1kVG/Y505zoXvsHEtnrM2+b1A/rrtu1k=;
 b=C43m5w4fHE6s+k/VmR1S9mC9KjO5yIkGICBVOkE+epB+0DOFX0I7u1Xtd6PoSuV7Oic6JbGV3LywGWz9oBZhL/2tfeNWbVU0EAEoQAxuBtKTtZn79aYr7cDiQipYKBiKew/h9LC3CLV6INrq5QJMHy6copeaa1hGZ0l+6j2ZyUevkqSUV+QxCbmSSPmfMSzEQm68JbtyvahSyrg4tuKWR1eUfgVqgltGLOspidRtWjgJJzCx+yHuqd7tpTytzp57mNnllbO22fQQ1GGjIk2XI9NW9zv8McRMyhwOSt3dhzWaH1TRlDZIxl6LoCpo/vzdqL5qCRC/llcJ3C7xMvpaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3ELNOY1ZeI1kVG/Y505zoXvsHEtnrM2+b1A/rrtu1k=;
 b=dE+5KKfOYZx55THHZAqie/1mcIpNwjn1VuVEYhOsRHn33MEQBGzy+Wh2x4udQ/2K2EdONlCGtA1C+vjF7I6+zbVLbwZMCwH9V2WUPABQW7y7P/51dm+PVxUqaCAfYRaaukRK7AfS/lSlcMHNKmkcSvexhOGqHA7o99bRa3AMAV0=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 06:03:16 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 06:03:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix RAS memory leak in error case
Thread-Topic: [PATCH] drm/amdgpu: fix RAS memory leak in error case
Thread-Index: AQHWOKGkSF9BVXFHwkmes3Kx7Zhil6jE1KaQ
Date: Tue, 2 Jun 2020 06:03:16 +0000
Message-ID: <BYAPR12MB288803482DE70A296502B216B08B0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200602054936.17387-1-guchun.chen@amd.com>
In-Reply-To: <20200602054936.17387-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-02T06:03:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=46ec5cbf-a52b-45ef-a2cc-00009c1800b5;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-02T06:02:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5987699d-1bf0-42e1-b741-00005af4800b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-02T06:03:13Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 47de8bd2-d255-4fd5-912a-00006bd79670
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.232.44.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 097ab9f2-c29c-4db5-2708-08d806baa492
x-ms-traffictypediagnostic: BYAPR12MB3367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB33670AABF31CFD85FDF429B7B08B0@BYAPR12MB3367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hUAQ99e3mkYLAjJ6ewFhs2XXci3q7o9bwsyz+wi1U1vKbox/wO+IDOoRmt6QeXVOGxzD0H0DTOoLQrxA5WfEA1f3stpmnomUoWbls5DnyBn8NZku8z9uNcprmmJEKv/uNzkDVvOylzRK+4bEO/N7HstgyWSAuEV2jZdkR9urU0z2Ee3RkfbFm3XWBXhGtP3eYB24CKnGTh3WCfCx21Occ2HS2pJ1eJCZWLX2F8NYNw38zdbRVH2QouwShd0OiYMqQn1HOF8E7WRVa0+uQpow/TBK/dTRgtXpD+xNfCNIeuwiOYi5R9QJgoOXr/bUi6tMlY+vBPgaHkIrfRcne5QDWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(6636002)(9686003)(316002)(86362001)(33656002)(55016002)(5660300002)(66946007)(66446008)(52536014)(66556008)(64756008)(71200400001)(7696005)(76116006)(110136005)(26005)(186003)(53546011)(6506007)(66476007)(8676002)(2906002)(478600001)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +wOnDtaa57rIE5uZ3AnATXThKd5WpMLHmUKdDcSt6lyTJ6dtm7XczSdyVIgG4TTH19s2p1tJbiqzWNVKKntJXX0jwqbK3a1U7YNIt5Nb8OtdzvYxXac6GKrnLYduugwd3RtIhQEV67PFCvF/inRGqApvpPOwOQxHPWFSC7hWiFSeqbZwvcLC8TnWEttBoF1y1Lb4WQQJSI31HoLeXWhkqOCK5O8M9GNZ9oYAFaC/vTqkHaurA+WJjRtixD2GWDiRP4J21DCEVqcJuKhd4DWSPpIG6u16Qlre371a7rlu0oWpl1EGJOOnSgRY9w1fVatqH3qvhXNwWOkjF98kH42E8Hf6Q4ky98BBu2NpYLJmIWTa6PlCtBqjoLrE9fo0mU1s+sdeOES2Uk6Imqa7hGETUWoHX1GryUdbdEyXYM7RNeBcQJN0PqsHn2stLVt/hi9sNahiKpxI2Ud6aLDiXF3sqckQ78cwBGhCSd5VENAquYw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ab9f2-c29c-4db5-2708-08d806baa492
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 06:03:16.5471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQgSmkCaUPALsbqjcQhnloPAyWYuhqcEAA7/SsRyikqeSQwXIjjkLwoN1v+CkMEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQu
Y29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIEd1Y2h1
biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogMjAyMMTqNtTCMsjVIDEzOjUwDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiBDYzog
Q2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGZpeCBSQVMgbWVtb3J5IGxlYWsgaW4gZXJyb3IgY2FzZQ0KPiANCj4gUkFTIGNv
bnRleHQgbWVtb3J5IG5lZWRzIHRvIGZyZWVkIGluIGZhaWx1cmUgY2FzZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDE5ICsrKysrKysrKystLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBpbmRl
eCA1YzczZjQ0NGVhZWYuLjc5YmIwNWQ3OTFiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBAQCAtMTg4MSw5ICsxODgxLDggQEAgaW50IGFtZGdwdV9y
YXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAlhbWRncHVfcmFzX2NoZWNr
X3N1cHBvcnRlZChhZGV2LCAmY29uLT5od19zdXBwb3J0ZWQsDQo+ICAJCQkmY29uLT5zdXBwb3J0
ZWQpOw0KPiAgCWlmICghY29uLT5od19zdXBwb3J0ZWQpIHsNCj4gLQkJYW1kZ3B1X3Jhc19zZXRf
Y29udGV4dChhZGV2LCBOVUxMKTsNCj4gLQkJa2ZyZWUoY29uKTsNCj4gLQkJcmV0dXJuIDA7DQo+
ICsJCXIgPSAwOw0KPiArCQlnb3RvIGVycl9vdXQ7DQo+ICAJfQ0KPiANCj4gIAljb24tPmZlYXR1
cmVzID0gMDsNCj4gQEAgLTE4OTQsMjkgKzE4OTMsMzEgQEAgaW50IGFtZGdwdV9yYXNfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikNCj4gIAlpZiAoYWRldi0+bmJpby5mdW5jcy0+
aW5pdF9yYXNfY29udHJvbGxlcl9pbnRlcnJ1cHQpIHsNCj4gIAkJciA9IGFkZXYtPm5iaW8uZnVu
Y3MtPmluaXRfcmFzX2NvbnRyb2xsZXJfaW50ZXJydXB0KGFkZXYpOw0KPiAgCQlpZiAocikNCj4g
LQkJCXJldHVybiByOw0KPiArCQkJZ290byBlcnJfb3V0Ow0KPiAgCX0NCj4gDQo+ICAJaWYgKGFk
ZXYtPm5iaW8uZnVuY3MtPmluaXRfcmFzX2Vycl9ldmVudF9hdGh1Yl9pbnRlcnJ1cHQpIHsNCj4g
IAkJciA9IGFkZXYtPm5iaW8uZnVuY3MtDQo+ID5pbml0X3Jhc19lcnJfZXZlbnRfYXRodWJfaW50
ZXJydXB0KGFkZXYpOw0KPiAgCQlpZiAocikNCj4gLQkJCXJldHVybiByOw0KPiArCQkJZ290byBl
cnJfb3V0Ow0KPiAgCX0NCj4gDQo+ICAJYW1kZ3B1X3Jhc19tYXNrICY9IEFNREdQVV9SQVNfQkxP
Q0tfTUFTSzsNCj4gDQo+IC0JaWYgKGFtZGdwdV9yYXNfZnNfaW5pdChhZGV2KSkNCj4gLQkJZ290
byBmc19vdXQ7DQo+ICsJaWYgKGFtZGdwdV9yYXNfZnNfaW5pdChhZGV2KSkgew0KPiArCQlyID0g
LUVJTlZBTDsNCj4gKwkJZ290byBlcnJfb3V0Ow0KPiArCX0NCj4gDQo+ICAJZGV2X2luZm8oYWRl
di0+ZGV2LCAiUkFTIElORk86IHJhcyBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHksICINCj4gIAkJ
CSJoYXJkd2FyZSBhYmlsaXR5WyV4XSByYXNfbWFza1sleF1cbiIsDQo+ICAJCQljb24tPmh3X3N1
cHBvcnRlZCwgY29uLT5zdXBwb3J0ZWQpOw0KPiAgCXJldHVybiAwOw0KPiAtZnNfb3V0Og0KPiAr
ZXJyX291dDoNCj4gIAlhbWRncHVfcmFzX3NldF9jb250ZXh0KGFkZXYsIE5VTEwpOw0KPiAgCWtm
cmVlKGNvbik7DQo+IA0KPiAtCXJldHVybiAtRUlOVkFMOw0KPiArCXJldHVybiByOw0KPiAgfQ0K
PiANCj4gIC8qIGhlbHBlciBmdW5jdGlvbiB0byBoYW5kbGUgY29tbW9uIHN0dWZmIGluIGlwIGxh
dGUgaW5pdCBwaGFzZSAqLw0KPiAtLQ0KPiAyLjE3LjENCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
