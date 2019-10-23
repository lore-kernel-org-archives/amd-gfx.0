Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6335CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBA82173B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBA82173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6F86E10F;
	Wed, 23 Oct 2019 15:21:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D896E10F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 15:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8k6xfYNiR24PVMjhsE1cauXeZuGExOF5BHlxAHqMK6TVu7M69UWtJ5N0NwfAz3zNMqA4RGQQXHJFSgsT+6zsueZos7RYkposbebCtj9NSgq3cNDYndFCHvjBoORQrfPZ3GjRvbPk6DAnTIlKTMqBVQl05isTop/Vc0EuPnT96RjjS9nr0BDS+l04K+qbhBSB8s/OfhTAnIyGPGVr81i27UMzsAv0JQIYl/oZfvbk2KzBK2CHPkhNd8b3Wd58LKOTmVnrvvIE9BItuGCI5LjRlWrXAGWhegw9ED9Mf7RhcbYqdj/PoA4+8IY6d+nCCBUoQV5MiugiD/gFLaJuEdysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAbKeiEXhsz4FP+Qfc6cKuq1XEFsxEqYt/nnw9mOfqg=;
 b=J+VBnz6axauvF9fLFihz3HQdxatLYCcMPG5ZTn9HsSTncNgwc8L5qJ+f28Cb/Q1kWUMhR87Mntq85V74e68tsZIgrom0Y3rYd2ysWZZ19oXbKxhCS4Lt3Qp3OPHiOszopJr543Nk4RrPRIPKSWdwIGKWnZE1PdQNzvLhGgtUlAGvnuomTLSzKkGEjY/e1mheJr0mISg6BnHK+SwhdPWS1wfF6OCiEhYfZUVRZye7l0xvLAcnrk6dj6Nou+0i4bixQMD8nsd94Ovt9RzpqZbzgaQxJJVHGHf4HhO1w9cs9Sd8Ep/NJyNgv0XD0t+EDi65dBObTQMvvAtQNXXq72yFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1547.namprd12.prod.outlook.com (10.172.38.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 15:21:55 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e%10]) with mapi id 15.20.2367.022; Wed, 23 Oct
 2019 15:21:55 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_gfx_kiq_free_ring
Thread-Topic: [PATCH] drm/amdgpu: remove unused variable in
 amdgpu_gfx_kiq_free_ring
Thread-Index: AQHVia8lCWpF/y+bzkmS1PgXid/N4adoV84A
Date: Wed, 23 Oct 2019 15:21:55 +0000
Message-ID: <b1569003-1b14-d71d-32b8-3695677189ac@amd.com>
References: <20191023143517.57753-1-nirmoy.das@amd.com>
In-Reply-To: <20191023143517.57753-1-nirmoy.das@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR10CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::12) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ba2f6de-7dc5-4b24-b8ed-08d757ccbd17
x-ms-traffictypediagnostic: DM5PR12MB1547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1547F43C1E6C53C15ACCFFCB836B0@DM5PR12MB1547.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(31686004)(25786009)(52116002)(66946007)(6636002)(64756008)(76176011)(31696002)(86362001)(66476007)(66446008)(5660300002)(14454004)(99286004)(478600001)(66556008)(65956001)(65806001)(486006)(446003)(6116002)(110136005)(54906003)(7736002)(46003)(186003)(11346002)(476003)(58126008)(305945005)(2616005)(386003)(6506007)(71190400001)(71200400001)(2906002)(316002)(102836004)(4326008)(6246003)(6486002)(256004)(6436002)(229853002)(8936002)(6512007)(36756003)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1547;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MtHLsob9Zdzpp9ihFQuze2/+g7Ro4Ozrdv3/E2vzwz8MsYn3xn8mtZ4yDz45L4tXK++whIStbT3dbkhpHEe6QSEL5KKZUrR5/YJfw6rkyL9VxPWg1CNVQQgj5388w5jsu+LTzfgFCrc38qelu8D0AYftyVMuID/Mf1DBr697NZr/zfR3AD0YiuOPggbRrZLe20LdCIox+FvUwRGO9VXZy03IlgYhAzzILeyRkdO5rI7ZLlORU/ttSZXpTaBWkAsP2znn1otF5hkdfSaKV/YCLLZLRhUTovqWtzuMOBh/Em+BVNhYdj/khiXohwFXQILPqByOI/94esMr0wp/1Lgox5r3rUpqUKmJwaYyMJSjUVqNfhGDrRo5nzbLi6VNGD/VRrtgdFeRLjtwzxE2Go0OMsZ4UB3KBkKS9l+dkzxT/y1Qob867rimlKI3glZVLOIh
Content-ID: <2AD441D46FBFF94C9E8EB0ED30CF2A2D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba2f6de-7dc5-4b24-b8ed-08d757ccbd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 15:21:55.6606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkwCHNcSpamB6JkHa7Q+kE6046NjFl2eq1SPgzolgvNi5aVi+GngTPBBIESAsdd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAbKeiEXhsz4FP+Qfc6cKuq1XEFsxEqYt/nnw9mOfqg=;
 b=29qWJhOBVYmMRYmqdS/x/eHFafzr4OuI2htyYUwk9ufRemHOCcjfzr8fNY+qoKkq5YhPLSTgWcRH6Dpv3aghrhjy58hjMEc0ePMIlFQZZXmP/A1s6PmvhvaMGeITTf3YJYwxY+S2QRG2fbZjGd0aDDWPXMPIvbFI+J3Q2loQMlI=
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023152155.RQwbZv85GkhIrGj4sPHZPZ0SWJp7zSQlqK-3euID1Kc@z>

TWF5YmUgc2F5IHBhcmFtZXRlciBpbnN0ZWFkIG9mIHZhcmlhYmxlIGluIHRoZSBzdWJqZWN0Lg0K
DQpBbSAyMy4xMC4xOSB1bSAxNjozNSBzY2hyaWViIE5pcm1veSBEYXM6DQo+IFNpZ25lZC1vZmYt
Ynk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4NCg0KQXBhcnQgZnJvbSB0aGF0IEFj
a2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgMyArLS0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCAzICstLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jICB8IDIgKy0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jICAgfCAyICstDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgIHwgMiArLQ0KPiAgIDUgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IGluZGV4IDA2OTUxNWY1N2MyYS4uYzlkMWZhZGE2MTg4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IEBAIC0z
MTksOCArMzE5LDcgQEAgaW50IGFtZGdwdV9nZnhfa2lxX2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gICAJcmV0dXJuIHI7DQo+ICAgfQ0KPiAgIA0KPiAtdm9pZCBhbWRn
cHVfZ2Z4X2tpcV9mcmVlX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAtCQkJICAg
ICAgc3RydWN0IGFtZGdwdV9pcnFfc3JjICppcnEpDQo+ICt2b2lkIGFtZGdwdV9nZnhfa2lxX2Zy
ZWVfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQo+ICAgew0KPiAgIAlhbWRncHVfZGV2
aWNlX3diX2ZyZWUocmluZy0+YWRldiwgcmluZy0+YWRldi0+dmlydC5yZWdfdmFsX29mZnMpOw0K
PiAgIAlhbWRncHVfcmluZ19maW5pKHJpbmcpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeC5oDQo+IGluZGV4IDM1ZWZmOWU2Y2UxNi4uNDU5YWE5MDU5NTQyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+IEBAIC0zMzAsOCArMzMw
LDcgQEAgaW50IGFtZGdwdV9nZnhfa2lxX2luaXRfcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gICAJCQkgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gICAJCQkgICAg
IHN0cnVjdCBhbWRncHVfaXJxX3NyYyAqaXJxKTsNCj4gICANCj4gLXZvaWQgYW1kZ3B1X2dmeF9r
aXFfZnJlZV9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4gLQkJCSAgICAgIHN0cnVj
dCBhbWRncHVfaXJxX3NyYyAqaXJxKTsNCj4gK3ZvaWQgYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5n
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyk7DQo+ICAgDQo+ICAgdm9pZCBhbWRncHVfZ2Z4X2tp
cV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gICBpbnQgYW1kZ3B1X2dmeF9r
aXFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMNCj4gaW5kZXggOGZjYTZhYjVmYThmLi5hYzQzYjFhZjY5ZTMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IEBAIC0xNDQzLDcg
KzE0NDMsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkNCj4g
ICAJCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0pOw0KPiAgIA0K
PiAgIAlhbWRncHVfZ2Z4X21xZF9zd19maW5pKGFkZXYpOw0KPiAtCWFtZGdwdV9nZnhfa2lxX2Zy
ZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nLCAmYWRldi0+Z2Z4LmtpcS5pcnEpOw0KPiArCWFt
ZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nKTsNCj4gICAJYW1kZ3B1
X2dmeF9raXFfZmluaShhZGV2KTsNCj4gICANCj4gICAJZ2Z4X3YxMF8wX3BmcF9maW5pKGFkZXYp
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMNCj4gaW5kZXggYTdmZTBlYTI0
ZDFmLi5lNGM2NDVkYTRlMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4
XzAuYw0KPiBAQCAtMjEwMyw3ICsyMTAzLDcgQEAgc3RhdGljIGludCBnZnhfdjhfMF9zd19maW5p
KHZvaWQgKmhhbmRsZSkNCj4gICAJCWFtZGdwdV9yaW5nX2ZpbmkoJmFkZXYtPmdmeC5jb21wdXRl
X3JpbmdbaV0pOw0KPiAgIA0KPiAgIAlhbWRncHVfZ2Z4X21xZF9zd19maW5pKGFkZXYpOw0KPiAt
CWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5yaW5nLCAmYWRldi0+Z2Z4
LmtpcS5pcnEpOw0KPiArCWFtZGdwdV9nZnhfa2lxX2ZyZWVfcmluZygmYWRldi0+Z2Z4LmtpcS5y
aW5nKTsNCj4gICAJYW1kZ3B1X2dmeF9raXFfZmluaShhZGV2KTsNCj4gICANCj4gICAJZ2Z4X3Y4
XzBfbWVjX2ZpbmkoYWRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0K
PiBpbmRleCBkZDM0NWZjZWRiOTcuLjlmZTk1ZTc2OTNkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+IEBAIC0yMTUzLDcgKzIxNTMsNyBAQCBzdGF0aWMgaW50
IGdmeF92OV8wX3N3X2Zpbmkodm9pZCAqaGFuZGxlKQ0KPiAgIAkJYW1kZ3B1X3JpbmdfZmluaSgm
YWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXSk7DQo+ICAgDQo+ICAgCWFtZGdwdV9nZnhfbXFkX3N3
X2ZpbmkoYWRldik7DQo+IC0JYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5nKCZhZGV2LT5nZngua2lx
LnJpbmcsICZhZGV2LT5nZngua2lxLmlycSk7DQo+ICsJYW1kZ3B1X2dmeF9raXFfZnJlZV9yaW5n
KCZhZGV2LT5nZngua2lxLnJpbmcpOw0KPiAgIAlhbWRncHVfZ2Z4X2tpcV9maW5pKGFkZXYpOw0K
PiAgIA0KPiAgIAlnZnhfdjlfMF9tZWNfZmluaShhZGV2KTsNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
