Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05FCA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BD820856
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BD820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403336EA47;
	Wed, 30 Oct 2019 14:56:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8D46EA47
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuOjcdog2KPI/3hIbcVL/7vjcM+UhSz9AgcOYHpuLAn9GbW3IyXqjfjT1Jx8ngh6lb2l/la59/kTbzt9pCy2F1x1c3Dax8CuDaCqW04DqpEjsiT4xHUCvuFB/iTOCdP4deUQGob5Xj9NJCLJJAhO1jbVVBTrc+5UCPkVm8ZUhwNUFOq/h2lsoCuw/EZXMk8lmxMmriHjTjAVYKIagd+jeIPZDdycmrPYsJi0iCMacFIqkoQSHKoQOnaj1RIR4unoS9qfM0rSZdDpH4rxtkS3a/atCnWoQuX0rHqU9APYsOwl272A/7ir9DhDLFIJFNhIJqgaaktUOhO0bA2GmV35YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCQipmIZVdo1Hs8HRINxxGScj5AZ3oFTAzYPhOW3hG0=;
 b=iLcPHrAxR740DhA0EdSGZlCyhu31hHsxrwg/YCMv5n8QdaTZtXfrUPu7o946KwUPTMZ6GNWZPOaSgz8FlgUOKJBsTR19K/6mrvOQjwPqY4RUuiGgCFmYbPUsMVIVygF4z8pHcjVSJQKg5oBh9UdvWvUv8IVOzi7pE0ywd4LMPoeplX9ABRrGd8sCEJMJz9xHa+rGKoDmxHCmZcO3Dxj7nSEzhXTKiPojhL/FoMa5585XbrxcgSTjD/cnXM7wJwgMP9oYNKyXQ9o5HbxLOw4cTpcZzjkjNy0dLH/zC59ph1s0O+7DMnUrhzAK9FAPPSCIGCVllSTrMFRAdy3zeOANVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1184.namprd12.prod.outlook.com (10.169.204.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:56:47 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 14:56:47 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "S, Shirish"
 <Shirish.S@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Topic: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Index: AQHVilnzZQjKfUg1H0yk/qIOzcWqzadpoAIAgAABf4CAAFpggIABEdoAgAAA2QCAAAgngIAAAQcAgAAkQ4CAAEkwAIAAAV0AgAdhNwCAACFhAIAARPGAgAABrgA=
Date: Wed, 30 Oct 2019 14:56:46 +0000
Message-ID: <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
 <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
In-Reply-To: <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 268ba8e3-4d19-49cc-b1a9-08d75d4962b7
x-ms-traffictypediagnostic: MWHPR12MB1184:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1184398E33CE7D19528887AFEA600@MWHPR12MB1184.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(8676002)(6486002)(66574012)(5660300002)(25786009)(476003)(966005)(110136005)(102836004)(26005)(486006)(86362001)(6506007)(53546011)(386003)(81156014)(81166006)(14454004)(66066001)(6436002)(2906002)(3846002)(31696002)(8936002)(66446008)(64756008)(66556008)(66476007)(6512007)(6636002)(66946007)(256004)(14444005)(229853002)(99286004)(446003)(11346002)(71190400001)(71200400001)(6246003)(7736002)(2616005)(76176011)(316002)(305945005)(478600001)(52116002)(6306002)(6116002)(36756003)(4326008)(186003)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1184;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Na2kqJWoGA1PXr7rMZY2U57HWyU73qY5/Y9gjX1lX2SJTCFzIctS+GTHQU44TfybvTnc//H0qYQ7ir2fR4IdPSYTyEiEaWl2aMnljeY1u2uqcN7WIXOYDrBM1DAo6hDznWUUhP6q8TkF8y1tRywfqovadK4/BVzXAqTVA3dlEvwTWYi8/GcA8Vnupu6+AOMjS7fivJMYpEAf1NzcpDC2GWpz6qu/cYRbQLJKh57pStdzP8EevpuY+oYp+3BWCDKAiX8cmWh1NNBbYeLne8Pk9fNVDwvHsuuj+eHHrpZpSjQI0A6OacfbubG6kSIguSw20eLp3gdjY8Uwp+jfa/k2QTt0+mV0d3iPfgwgICqAVrUMgZ3BBc3UJe2BGI7EpRQkgsjdJwlDgPTibsHhCYUhWEu88rQPCeYHt2MUkWQ177ANN4mX9tc03SZ1qcwHbCfi5c8O52zton7QPFOOZTapGVLpyiBghPVD3zPzGb8Y1DI=
Content-ID: <9BE4A3191A2E944DAD79E16C4D213B83@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ba8e3-4d19-49cc-b1a9-08d75d4962b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:56:46.9124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUmoOuEQsbENNtp38mazPdwsNZH1LDkNbY8VScRK089jG7dRYRDu9WNw0XFUIVjiKxfnz1QyrnDdxqm6Br5S4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCQipmIZVdo1Hs8HRINxxGScj5AZ3oFTAzYPhOW3hG0=;
 b=VM6ehj74stsyiRN3Euje8ullfepzOkTKv70Hrh4ileuDhAPnLYgf1GWWRwOXpcePjhUF/EolgRiYBHOWejW8S2jr26+PVIPlyaXy4E/kM4KR/sSxDQmxBYp3GwqdXcmwj6B6U9E9YYwyKbkSisUu4GlCrbN4n3G2+V+5GwKsY4E=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030145646.60g2nuMgEX2Lry266yZtwPJZ5EkAW2WbE8unQxJL1qE@z>

Q2FuIHlvdSBlbGFib3JhdGUgb24gd2hhdCBpcyB0aGUgdHJpY2t5IHBhcnQgd2l0aCB0aGUgbG9j
ayA/IEkgYXNzdW1lZCANCndlIGp1c3QgdXNlIHBlciBzY2hlZHVsZXIgbG9jay4NCg0KQW5kcmV5
DQoNCk9uIDEwLzMwLzE5IDEwOjUwIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBBIGxv
Y2sgaW5zaWRlIHRoZSBzY2hlZHVsZXIgaXMgcmF0aGVyIHRyaWNreSB0byBpbXBsZW1lbnQuDQo+
DQo+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8gZ2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFy
aygpIGhhY2sgaW4gDQo+IGRybV9zY2hlZF9lbnRpdHlfZmluaSgpLg0KPg0KPiBXZSBjb3VsZCBk
byB0aGlzIHdpdGggYSBzdHJ1Y3QgY29tcGxldGlvbiBvciBjb252ZXJ0IHRoZSBzY2hlZHVsZXIg
DQo+IGZyb20gYSB0aHJlYWQgdG8gYSB3b3JrIGl0ZW0uDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gQW0gMzAuMTAuMTkgdW0gMTU6NDQgc2NocmllYiBHcm9kem92c2t5LCBBbmRy
ZXk6DQo+PiBUaGF0IGdvb2TCoCBhcyBwcm9vZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ug
c2hvdWxkIGdyYWIgYSBkZWRpY2F0ZWQNCj4+IGxvY2sgaW5zaWRlIHNjaGVkdWxlciBzaW5jZSB0
aGUgcmFjZSBpcyBpbnRlcm5hbCB0byBzY2hlZHVsZXIgY29kZSBzbw0KPj4gdGhpcyBiZXR0ZXIg
dG8gaGFuZGxlIGl0IGluc2lkZSB0aGUgc2NoZWR1bGVyIGNvZGUgdG8gbWFrZSB0aGUgZml4IGFw
cGx5DQo+PiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQuDQo+Pg0KPj4gQW5kcmV5DQo+Pg0KPj4g
T24gMTAvMzAvMTkgNDo0NCBBTSwgUywgU2hpcmlzaCB3cm90ZToNCj4+Pj4+PiBXZSBzdGlsbCBo
YXZlIGl0IGFuZCBpc24ndCBkb2luZyBrdGhyZWFkX3BhcmsoKS91bnBhcmsoKSBmcm9tDQo+Pj4+
Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVzcyBkZWZl
YXRzIGFsbCB0aGUNCj4+Pj4+PiBwdXJwb3NlIG9mIGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bh
cmsgPyBJZg0KPj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfZmluaS0+IGt0aHJlYWRfdW5wYXJrIGhh
cHBlbnMgQUZURVINCj4+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5vdGhpbmcg
cHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkNCj4+Pj4+PiB0aHJlYWQga2VlcCBzdWJtaXR0
aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlIHBpY2tlZCB1cCBieSB0aGUNCj4+Pj4+PiB1bnBh
cmtlZCBzY2hlZHVsZXIgdGhyZWFkIHRyeSB0byBzdWJtaXQgdG8gSFcgYnV0IGZhaWwgYmVjYXVz
ZSB0aGUNCj4+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLg0KPj4+Pj4+DQo+Pj4+Pj4gSWYg
c28gbWF5YmUgd2Ugc2hvdWxkIHNlcmlhbGl6ZSBjYWxscyB0bw0KPj4+Pj4+IGt0aHJlYWRfcGFy
ay91bnBhcmsoc2NoZWQtPnRocmVhZCkgPw0KPj4+Pj4+DQo+Pj4+PiBZZWFoLCB0aGF0IHdhcyBt
eSB0aGlua2luZyBhcyB3ZWxsLiBQcm9iYWJseSBiZXN0IHRvIGp1c3QgZ3JhYiB0aGUNCj4+Pj4+
IHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuDQo+Pj4+
DQo+Pj4+IFNoaXJpc2ggLSBwbGVhc2UgdHJ5IGxvY2tpbmcgJmFkZXYtPmxvY2tfcmVzZXQgYXJv
dW5kIGNhbGxzIHRvDQo+Pj4+IGRybV9zY2hlZF9lbnRpdHlfZmluaSBhcyBDaHJpc3RpYW4gc3Vn
Z2VzdHMgYW5kIHNlZSBpZiB0aGlzIGFjdHVhbGx5DQo+Pj4+IGhlbHBzIHRoZSBpc3N1ZS4NCj4+
Pj4NCj4+PiBZZXMgdGhhdCBhbHNvIHdvcmtzLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+Pg0KPj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGFtZC1n
ZnggbWFpbGluZyBsaXN0DQo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo+DQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
