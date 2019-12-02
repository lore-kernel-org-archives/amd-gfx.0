Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9504EC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8532084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8532084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBC36E225;
	Mon,  2 Dec 2019 16:05:19 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720065.outbound.protection.outlook.com [40.107.72.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375676E225
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 16:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk/GqRjMicVjif30BOdmV0OrJ2B8CK0nKfLg/MU7B982P8U6joL99Qo0iZprTaRxc30o1Nebmafx2HoObb01TrTAncY5e6gG0Nm1Hyx/okwZkQ/s2MwQxiEJo/jGx3rM8ycOKaF92SPWW9rE8kZCiEbtmesyPkgRI8vq0A8y60TGUZbnoU2gDXYKmIciENGkW6jI4kMXb4MQu013b3gH+GtDb5LGpdJs9Rqhu2XcMC1hkY8Mch90qzYeaNJbRvLnJUpzabeoIhKJBSc96Vc1M04lTQ8oYAbmnac3HinuG2cA+4/8brf6RRMoFyCtrDSyPxrg6cV+CkNMlfUvsJk8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9PnHMbfxzmu/2l4Ra78+RnxHi5HT0O/wpXnmbb2Yw=;
 b=GjXRAHd8Kzfl9Z4Zk64OTC+Qk7QEu4TYT9zqjFMTF7E7Fsyo5p/9l9T8tlpr2W6Y3e4upvyluU++hSVPOGhYejOY6RhdvCrYJhZjxWNWf5bulQeMaYvjLa6W3jXMO0/+nJPgxEUes3QBEpUnN2l2O9EqgXR8vt/i6DnZO11SAluYGGNLFW32sUb94M4zukQPV3o//ocTlNKrfqOKZKcc1dlBbXBtmS/VmUvCzkzl8wqVK8nt7LBVN7/7N4y2348+Hs+a1oqThlj5G4S78sMpmQRznxrZ4nkA9Ii9L41HKL5+LpnzxNddShTludNWD6ZfgUD6l+58f4EfdA0jrvXE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB4076.namprd12.prod.outlook.com (10.141.184.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 16:05:17 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:05:17 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: No need the event 3 and 4 now
Thread-Topic: [PATCH] drm/amdgpu/sriov: No need the event 3 and 4 now
Thread-Index: AQHVp89n7+r4vQXU7Um6O9nNXY3LU6enBNFg
Date: Mon, 2 Dec 2019 16:05:17 +0000
Message-ID: <DM6PR12MB3466FFD725C104B77B5CB72A9E430@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <1575153700-10434-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1575153700-10434-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29381d70-dcf2-485e-6d4b-08d777416c6e
x-ms-traffictypediagnostic: DM6PR12MB4076:|DM6PR12MB4076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB407628315D0CAAE03C1E781F9E430@DM6PR12MB4076.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(13464003)(6436002)(110136005)(66066001)(26005)(186003)(446003)(11346002)(9686003)(64756008)(76116006)(86362001)(66446008)(66556008)(66946007)(316002)(99286004)(5660300002)(52536014)(102836004)(76176011)(7696005)(229853002)(6506007)(53546011)(6306002)(55016002)(66476007)(33656002)(71200400001)(71190400001)(81166006)(81156014)(256004)(14444005)(8936002)(4326008)(25786009)(6246003)(478600001)(2501003)(45080400002)(2906002)(3846002)(6116002)(8676002)(74316002)(966005)(14454004)(7736002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4076;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rO4BVwG6+b906pBAyupEyboxFNdpd86TqVoxGvbHffauuaLDRSGaoENkOmrn/2VGAlClP1BlUXJIEHIM6x8a6pejUAmb7KMGYl+Uc6c4SEWgy/xUI2xq31lCIeEfmQEveEkni67Jn8lA/QPxQJXEC6wGtz7x1QK0NuMkCQMENvYFkFf1zCEbyCFUW95vnsz5omgZeEw7ZxnhkizmrpZ0s3qKcd3F5GQPqJReQ54rT1MUmGrXLtZw1kDqW1v/+CSMv5Y//ygjAwwKeorwib1zv7znxpou8HKEXbVh3U4u+C2V1tcvrcO3R/neNqcBniOYwhtRYODNY+Qfs0NonsFd3+vkO/c7pDrWxg5j+LyKR/zC1ayXJ6EcklLnjkkFKaMJaWae2E92jTz1OVV2p6w1Uie7k/ubbKhTe7aALufAar/3upUHdJGlbSKkdyCxfAN5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29381d70-dcf2-485e-6d4b-08d777416c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:05:17.1280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXcFbK3Z1Xlx3aLqOw5ocskqUdhOYvBNvDnylUDZtOUIV+YKYXm3rg48dskgFI6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9PnHMbfxzmu/2l4Ra78+RnxHi5HT0O/wpXnmbb2Yw=;
 b=2y47yWsFuw0ZFEowzV9oA9lZEu6t/pRRFpWvfIj8ie+YIHdK7NotP/xe0fa2IC0MkQHTX+jp8KpxhD+3v+8zyZRgGg5UX70yosTlW3nNtxW8TJGzZDhYUjMzsIF8Bk4bdO3zcSfu6GbJTRriRO2/6BQx/fhOteu52iZo+0Vq5E8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IEVtaWx5IERl
bmcNCj4gU2VudDogMjAxOS9Ob3ZlbWJlci8zMCwgU2F0dXJkYXkgNTo0MiBQTQ0KPiBUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdS9zcmlvdjogTm8gbmVlZCB0
aGUgZXZlbnQgMyBhbmQgNCBub3cNCj4gDQo+IEFzIHdpbGwgY2FsbCB1bmxvYWQga21zIHdoZW4g
aW5pdGlhbGl6ZSBmYWlsLCBhbmQgdGhlIHVubG9hZCBrbXMgd2lsbCBzZW5kIGV2ZW50DQo+IDMg
YW5kIDQsIHNvIGRvbid0IG5lZWQgZXZlbnQgMyBhbmQgNCBpbiBkZXZpY2UgaW5pdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFpoYW4gTGl1IDx6aGFuLmxpdUBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IGQxZDU3M2QuLjAzOTNlMzUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTMwMzYsOCArMzAz
Niw2IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFk
ZXYsDQo+ICAJCX0NCj4gIAkJZGV2X2VycihhZGV2LT5kZXYsICJhbWRncHVfZGV2aWNlX2lwX2lu
aXQgZmFpbGVkXG4iKTsNCj4gIAkJYW1kZ3B1X3ZmX2Vycm9yX3B1dChhZGV2LA0KPiBBTURHSU1f
RVJST1JfVkZfQU1ER1BVX0lOSVRfRkFJTCwgMCwgMCk7DQo+IC0JCWlmIChhbWRncHVfdmlydF9y
ZXF1ZXN0X2Z1bGxfZ3B1KGFkZXYsIGZhbHNlKSkNCj4gLQkJCWFtZGdwdV92aXJ0X3JlbGVhc2Vf
ZnVsbF9ncHUoYWRldiwgZmFsc2UpOw0KPiAgCQlnb3RvIGZhaWxlZDsNCj4gIAl9DQo+IA0KPiAt
LQ0KPiAyLjcuNA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuDQo+IGZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC0NCj4gZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N6aGFuLmxpdSU0MGFt
ZC5jb20lN0M5MDY0NTkzMGQ5OTQ0MDk0MQ0KPiBhN2EwOGQ3NzVlNjg0ZjMlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDDQo+IDYzNzEwNzUwNTMxNDg4MzUyMSZh
bXA7c2RhdGE9eW1rV2JucElHYyUyQk0lMkJmMXl4dGZybHIzR2Y0S0RRDQo+IDNYV2tTZWdsMXE1
MjI4JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
