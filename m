Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40136CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEF020679
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEF020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF5B6EA4E;
	Wed, 30 Oct 2019 14:44:06 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740043.outbound.protection.outlook.com [40.107.74.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242D86EA4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGtTas/5pkzuvt4QhOrXGjwQgAKdFRcilau6lYw+JTpC+r73L76kP7dghEawQUDmavIZtk3wHuMAYGCt85shbxtwn5lK8IzazAgTmKHN31FzZ+loLOxDtS0iEcms3GK7UiHw7vQ467uJ4hZ6MLClRxha1FndZ6rOUt7U4G+u1Rkj+SHg2vQ2EAgsTJw3BgfdiKNBE5VAL3sw3aVgziYB8bBAntlb0rhmGCQDx8cvVCBwKlugZdXr3IlFMnqpDF3BThycoEhSzDWq3nkIBIQe6dS5zLhSU13+f/Y4KjzwpvgF95T63+DFP8x0po7O0ornOfZY7iiq2jPc2yKQsbatNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y//gz+kWDH6r6jC9H63mwCvpvdUgp2/AffthKcv1FI8=;
 b=oVR+0rd1PS3z+0Z/RrTEVgbrLykOmE/f9EoUmRF3hxVGWRtvg36tlQIO+53lElOxoIwZd+vCM9x6osL2rV3Rmi6mGhgepbiaKqo9u3Qgsc8gJMkvk5K6gfZa6BZeQvQNYGikC9C2gN+ZWapVrsMnhuqT12EFPjBJauQFNClDlUKO8amzdyOhHglpPkbLovtDtlQ/U+CuQU9mFU8G53F5/Bt1BA1IpjH8x+hD3l6oF9gSq5DNumgbpwK/oGnfj/l7+PdkbpjCBbBOFrybEJ0jV7FR76taEcyQft/vG2eh3jAQRc0RR4iFwFqLzFswn036NvSJEXJK5aGrV7KuA5Xm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1709.namprd12.prod.outlook.com (10.175.54.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Wed, 30 Oct 2019 14:44:01 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 14:44:00 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Topic: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Index: AQHVilnzZQjKfUg1H0yk/qIOzcWqzadpoAIAgAABf4CAAFpggIABEdoAgAAA2QCAAAgngIAAAQcAgAAkQ4CAAEkwAIAAAV0AgAdhNwCAAGRvAA==
Date: Wed, 30 Oct 2019 14:44:00 +0000
Message-ID: <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
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
In-Reply-To: <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29ccd352-96d0-468e-9b2a-08d75d4799b4
x-ms-traffictypediagnostic: MWHPR12MB1709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB170916CE085F899A7ABF0D89EA600@MWHPR12MB1709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(25786009)(26005)(305945005)(53546011)(66556008)(66446008)(6436002)(66476007)(64756008)(6506007)(5660300002)(386003)(229853002)(76176011)(81166006)(81156014)(52116002)(8936002)(8676002)(2906002)(31686004)(186003)(7736002)(66946007)(6512007)(102836004)(6486002)(256004)(316002)(478600001)(476003)(36756003)(2616005)(86362001)(14444005)(6636002)(4326008)(446003)(14454004)(31696002)(11346002)(99286004)(71200400001)(71190400001)(6246003)(66066001)(486006)(110136005)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1709;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vJqDzSy3eVc3qm9tRv8l1PDBTtPoQPtuuMNOUHCSfY1NmcJpRPYa/JSzyPUcin/5+Qp5ME8S74bwisdxr0puOcRGaB+47S/SPTNSwHeHm9jzevFvx51VSVIWL6q3KjTd6+c0jMVqsRKOQqEOkJLQdVVzuJXcDej5wfCFe9YYLwHN42nGuBapei2or1cV/nKDdUq1UTw6wVnEUMLq0Ab70GHX5S8vDodzRzThdzdpVvyeOUaGEyk8HZ0jj9d8itpGzZAMz2ZOzi8uD3PmiaOSOf5ssCPBj6I7cQHBZ9JW7aDlJ1x6tKc2R2swX++GLLWBNRrEO5eahApZLUU955rp1I7Vv5W7pDEhRdDPKEOk36WEjSNMZE4JlnSzO426ANiMFvh/n2AxBTS2w1xThvTqio3haOAoGjLFfUZjEIc7aao7Rw+Elx7mZsDyxlnAbof
Content-ID: <D70DDD5809F97E46B6595D21BA0F4C1F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ccd352-96d0-468e-9b2a-08d75d4799b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:44:00.5223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwWua7VO1E6IIyw0qaDux0Qdgozjj5WRqPXtl5hbxHtTjqYNbeF3BAXIfBRxPaw4sik16+m1lfJ5IAgUHnJk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1709
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y//gz+kWDH6r6jC9H63mwCvpvdUgp2/AffthKcv1FI8=;
 b=kWkl47rs2Q6XeYTepwCqxRlN2RG8EUDCdwER6jVGtIO5EZd0q9qvw1VYwbhLbz0zXtGACwokIuQ68962/Bwq9qRfXbdPrhNlSMzsL6v5o6RR63+QBFR8InwIIqDOXxN0R/79BsRQP31cvo67HveEGv6V/twyAFP680alr9uYC+o=
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
Message-ID: <20191030144400.0Ct_89L7t0MbM_wvdDoBg9ZzUkrpvDlN_jbDyzh56bY@z>

VGhhdCBnb29kwqAgYXMgcHJvb2Ygb2YgUkNBIGJ1dCBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBn
cmFiIGEgZGVkaWNhdGVkIA0KbG9jayBpbnNpZGUgc2NoZWR1bGVyIHNpbmNlIHRoZSByYWNlIGlz
IGludGVybmFsIHRvIHNjaGVkdWxlciBjb2RlIHNvIA0KdGhpcyBiZXR0ZXIgdG8gaGFuZGxlIGl0
IGluc2lkZSB0aGUgc2NoZWR1bGVyIGNvZGUgdG8gbWFrZSB0aGUgZml4IGFwcGx5IA0KZm9yIGFs
bCBkcml2ZXJzIHVzaW5nIGl0Lg0KDQpBbmRyZXkNCg0KT24gMTAvMzAvMTkgNDo0NCBBTSwgUywg
U2hpcmlzaCB3cm90ZToNCj4+Pj4NCj4+Pj4gV2Ugc3RpbGwgaGF2ZSBpdCBhbmQgaXNuJ3QgZG9p
bmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbSANCj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9m
aW5pIHdoaWxlIEdQVSByZXNldCBpbiBwcm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUgDQo+Pj4+IHB1
cnBvc2Ugb2YgZHJtX3NjaGVkX3N0b3AtPmt0aHJlYWRfcGFyayA/IElmIA0KPj4+PiBkcm1fc2No
ZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFkX3VucGFyayBoYXBwZW5zIEFGVEVSIA0KPj4+PiBkcm1f
c2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0
aGlyZCkgDQo+Pj4+IHRocmVhZCBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwg
YmUgcGlja2VkIHVwIGJ5IHRoZSANCj4+Pj4gdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkg
dG8gc3VibWl0IHRvIEhXIGJ1dCBmYWlsIGJlY2F1c2UgdGhlIA0KPj4+PiBIVyByaW5nIGlzIGRl
YWN0aXZhdGVkLg0KPj4+Pg0KPj4+PiBJZiBzbyBtYXliZSB3ZSBzaG91bGQgc2VyaWFsaXplIGNh
bGxzIHRvIA0KPj4+PiBrdGhyZWFkX3BhcmsvdW5wYXJrKHNjaGVkLT50aHJlYWQpID8NCj4+Pj4N
Cj4+Pg0KPj4+IFllYWgsIHRoYXQgd2FzIG15IHRoaW5raW5nIGFzIHdlbGwuIFByb2JhYmx5IGJl
c3QgdG8ganVzdCBncmFiIHRoZSANCj4+PiByZXNldCBsb2NrIGJlZm9yZSBjYWxsaW5nIGRybV9z
Y2hlZF9lbnRpdHlfZmluaSgpLg0KPj4NCj4+DQo+PiBTaGlyaXNoIC0gcGxlYXNlIHRyeSBsb2Nr
aW5nICZhZGV2LT5sb2NrX3Jlc2V0IGFyb3VuZCBjYWxscyB0byANCj4+IGRybV9zY2hlZF9lbnRp
dHlfZmluaSBhcyBDaHJpc3RpYW4gc3VnZ2VzdHMgYW5kIHNlZSBpZiB0aGlzIGFjdHVhbGx5IA0K
Pj4gaGVscHMgdGhlIGlzc3VlLg0KPj4NCj4gWWVzIHRoYXQgYWxzbyB3b3Jrcy4NCj4NCj4gUmVn
YXJkcywNCj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
