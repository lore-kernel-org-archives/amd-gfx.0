Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337CC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C7521D56
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QXnBu6li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C7521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529BB6E1E0;
	Wed, 19 Feb 2020 11:29:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994E76E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ6NZiIh8UGYuezal1NAhi0BHMQL/jQ+pk2Q+RgGFM2XcjgF/p82r5Gi0i+I0ttmhVA8yZWorWLVvzryC7DNNcuOflT3WzCrHGtugVHEI3brlbxHX4zYhtEXr5TgU/PscqirHqirNULLAZpXm8IxXzVvqAxvnFNisTupe5u4DMdjnddmky3skc1Fa0rd+5s4fySZl3BGvDrLEKhiwvGngz5kPiJ0jFMDKSFkon3H/2s+uf4iWiNzrelXGAigwyppp6tiyFBhV2LIBvq05yBjuD7DITa749DaOkoQitRpwDXZ42tf2hw1I4iYMh+NnIQAsbfarx8EuEAcBujXmrNpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4b7AD16FPxtMLGLUu0lU0wEJ8oA5RT0BMQLw41hvdI=;
 b=M0WvK7UsDd4hF0s3C9Ctc+L9j5uKWw12vmMJ4Y2by43VDDiboVT99A19egZcMH3P0EQhw470txCZhRe7lkTYqnrAeSnWNm5/29L+oKP6GVLoEltllF9ksz1UyYnTBrGhGaGOong5SKIwW8J5fYCb5Pt0e93zBlsRAwnweT3qySZdwmsWhTJZ0pED2ewr0fOkGJjFzfwPyQ2Qdfskj7MAniGNsiqmNciuOyxYutaEfV+zTsKTj5pyXterj0N07x3nFHS4kgU3bF2NkfmIyl9pt5jmzn7JNDgohdREBv8MXGfxGeYk1TTGQ4eU2c6qQTmY85wfMpYO0FfKIvTJJi8wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4b7AD16FPxtMLGLUu0lU0wEJ8oA5RT0BMQLw41hvdI=;
 b=QXnBu6liRquCyNNfcMNzDXTSpPrZGMAOnESVSQ6q1EctQxgUPG8xAb/RdPm5eIIJ4BGBYYCGjI9LaRNjMdvWR9oEkkLgBxGpbHvZntbQ76to+zVJb7QE9o1JS60FThEkAz2EACoCbuN4V6IJCHctIF2/7jBXzeMOPL8pNmuTWTQ=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (10.255.174.140) by
 DM6PR12MB3867.namprd12.prod.outlook.com (10.255.175.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 11:29:40 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:29:39 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2lu?=
 =?gb2312?Q?ter_dereference?=
Thread-Topic: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Index: AQHV5tpejmUZxmzr8E+/dIkRGLqWv6giDTkAgABJr4CAAArysA==
Date: Wed, 19 Feb 2020 11:29:39 +0000
Message-ID: <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
In-Reply-To: <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3e805e6-56c4-4cc5-5008-08d7b52f0220
x-ms-traffictypediagnostic: DM6PR12MB3867:|DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3867E1349C04713EC743E8D384100@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(224303003)(5660300002)(81166006)(55016002)(8936002)(478600001)(64756008)(76116006)(9686003)(66476007)(66446008)(52536014)(66556008)(66946007)(81156014)(966005)(45080400002)(33656002)(6636002)(186003)(7696005)(86362001)(71200400001)(316002)(6506007)(53546011)(26005)(110136005)(2906002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3867;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyNQ4aNJL3RWwUOHesAQv3kLs9M0FzDNE/x1yFLLnNZMxYEKSC1tYk6Nxw9dg3XKvExv9PwDIIWLyE5/if6rPUeTHn6je34xZbMQ23Uyuw4DXL0/Xc5RPWZvcm2vKSulX0G43xneHIjNI2G7on6qz9eeTlQdgNOC3ZLgwJa/HBOoa5qH1ZLrAiyWFMp+JdAMhGFYmMAqaP7ml3UTF6LXScyiFe6Wg4O79cqu1wWo5gHeVwF21qCD1Kg6gELHezdRoU61+L22KVrylIECd2bQXlulmWEb3mVRAH6IaoCM4W0Ws28Weq0dYX2BsrkgsQ3NMoPfDcfhqheVFgUwI7+OcFThTneC0yJ//O8++LPo7IM4kxs+NRN6KaXEtbACcl8gupQWCC/MqYhs93erlAkm1PtXu0ROG6BGtCKSCSGber2AePhnYW7p1PlQMg4W8vPtxgyMWJNSTlVt5ipbtLW6heG1VFcEPhwNiY5TCInK8b3ls23pS5nBoYFOxOXp+6Ir01ql4+xFYD/l/amo+JTlAhWsbwdb3Pd0lwGYPYVav/AsdKO7Db2UsMVxELOAoAop/CjWEu2Z34rfBIcUDkYNXR/hQ3wtnlHxGcC1u/6yaBLWm+a8fv3bjt2geYwdJTtI8kp6uz4Ue7ItN0fIsYraHxJAv2Ub0KnDYfL/tfGxh4N/hcZmQGEqA++teIdgUynv
x-ms-exchange-antispam-messagedata: KE1BpzMWZ2ozSk08sJCFZN78MnMNwjqpA0VcLyQWxP/CHNNHYgXpRqZ8B/7iM34wZc3fTIDIzK2rR6h4RcsGxqgX3xdoHZjTEz3K6lXouqGkoM1EEpDWbSLFSsxtwXn77Tt1AMnSxFd36qQvhwwwVA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e805e6-56c4-4cc5-5008-08d7b52f0220
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 11:29:39.9357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qm478I6WDDD+qclfD61f59givOCGuZFAaxPsw5+gBYF404mFVuKvKdzO+u+8kVtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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

PiArCWlmICghZW50aXR5LT5ycSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCg0KWWVzLCBzdXBwb3Nl
ZGx5IHdlIHNob3VsZG4ndCBnZXQgJ2VudGl0eS0+cnEgPT0gTlVMTCcgY2FzZSAsIHRoYXQgbG9v
a3MgdGhlIHRydWUgYnVnIA0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gtPqx7SBDaHJpc3RpYW4gSz9u
aWcNCreiy83KsbzkOiAyMDIwxOoy1MIxOcjVIDE4OjUwDQrK1bz+yMs6IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IENo
ZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCg0KV2VsbCBvZiBoYW5k
IHRoaXMgcGF0Y2ggbG9va3MgbGlrZSBhIGNsZWFyIE5BSyB0byBtZS4NCg0KUmV0dXJuaW5nIHdp
dGhvdXQgcmFpc2luZyBhbiBlcnJvciBpcyBjZXJ0YWlubHkgdGhlIHdyb25nIHRoaW5nIHRvIGRv
IGhlcmUgYmVjYXVzZSB3ZSBqdXN0IGRyb3AgdGhlIG5lY2Vzc2FyeSBwYWdlIHRhYmxlIHVwZGF0
ZXMuDQoNCkhvdyBkb2VzIHRoZSBlbnRpdHktPnJxIGVuZHMgdXAgYXMgTlVMTCBpbiB0aGUgZmly
c3QgcGxhY2U/DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCkFtIDE5LjAyLjIwIHVtIDA3OjI2
IHNjaHJpZWIgWmhhbmcsIEhhd2tpbmc6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4NCj4gUmVnYXJkcywNCj4gSGF3a2luZw0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE5LCAyMDIwIDEyOjA1DQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIA0KPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsg
WmhhbmcsIA0KPiBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDaGVuLCBHdWNodW4g
PEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IENjOiBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlDQo+DQo+IGNoZWNrIHdoZXRoZXIgdGhlIHF1ZXVlIG9mIGVudGl0eSBpcyBu
dWxsIHRvIGF2b2lkIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4NCj4gQ2hhbmdlLUlkOiBJ
MDhkNTY3NzQwMTJjZjIyOWJhMmZlN2EwMTFjMTM1OWU4ZDFlMjc4MQ0KPiBTaWduZWQtb2ZmLWJ5
OiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQuY29tPg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyANCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+IGluZGV4IDRjYzc4ODFmNDM4Yy4uNjdj
Y2E0NjNkZGNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fc2RtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bV9zZG1hLmMNCj4gQEAgLTk1LDYgKzk1LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fc2RtYV9j
b21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLA0KPiAgIAlpbnQgcjsNCj4g
ICANCj4gICAJZW50aXR5ID0gcC0+ZGlyZWN0ID8gJnAtPnZtLT5kaXJlY3QgOiAmcC0+dm0tPmRl
bGF5ZWQ7DQo+ICsJaWYgKCFlbnRpdHktPnJxKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiAgIAly
aW5nID0gY29udGFpbmVyX29mKGVudGl0eS0+cnEtPnNjaGVkLCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcs
IHNjaGVkKTsNCj4gICANCj4gICAJV0FSTl9PTihpYi0+bGVuZ3RoX2R3ID09IDApOw0KPiAtLQ0K
PiAyLjE3LjENCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdA0KPiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vDQo+IG5rLmxpdSU0MGFtZC5jb20l
N0MyOGU3MjYwYWYzYTI0ZWVjNzU4ZjA4ZDdiNTI5NzVlMyU3QzNkZDg5NjFmZTQ4ODRlNjANCj4g
OGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc3MDYyMDAzMjEzNDMxJmFtcDtzZGF0YT12
TVhtaHdUbE44bEFhdg0KPiB1cWhZaHBtS0xNNlYlMkYlMkIyJTJGdWJGQmJzayUyQkdZJTJCancl
M0QmYW1wO3Jlc2VydmVkPTANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbW9uay5saXUlNDBhbWQuY29tJTdDMjhl
NzI2MGFmM2EyNGVlYzc1OGYwOGQ3YjUyOTc1ZTMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5
OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc3MDYyMDAzMjEzNDMxJmFtcDtzZGF0YT12TVhtaHdUbE44
bEFhdnVxaFlocG1LTE02ViUyRiUyQjIlMkZ1YkZCYnNrJTJCR1klMkJqdyUzRCZhbXA7cmVzZXJ2
ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
