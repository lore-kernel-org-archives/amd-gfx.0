Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B0CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F8E20656
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904616EA6A;
	Wed, 30 Oct 2019 15:47:56 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720047.outbound.protection.outlook.com [40.107.72.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC606EA6A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 15:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlwhPvTyP5uMN5jR0tpXbqIG2uFariLduvHB5L8wHRKxOpGVXe8DhyMVmfTxl4AftQpAOn/wHwDeI5EWJsMjJf8VjMHj5Ua8ZkgsG6fshl7cBQdIbgi2q2EvKEL0hnkVjwWcfTuaNotoZIygmykCULZekFnMivQNzGYnUHwT1Al6bJiPKulSgfsn1Fgm7+6kp5dAZ8+FfS5ShDpMecxGaesHEvBdWNBroeijW0cZY991lnuwQEadUbv+X0Vaght9dhED6QkHHV7T8H4qwqE7IQAsK/81XaoIXvK+WnKNr+NuoTNvwdGNCkGTTi9jF8Jirej2wN5RK7MDf6I/oEBuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vij2UCVxlXoPHQgswMNvxJddJhPsULCBvOt3SWsKTCY=;
 b=XCZi42UN6xkyLM20NnBHPuYrXXCEKkWVP2wetlfhUQ01vfrgYlcvCDFG4GMg5uYbMgaS9cm3CKCSptOBXujSLAf+yi4Y17X3MAuUHiDw0uYW+lPoJpgPhab49xlO+QhL4hH98SyRIfdFoMrz832iq8sFGxZfBSbqshB6KeAVZTVqIjWo7yPrOqHW23EA4bf3QpGwketdn0euvsBWiwOrlZFPb1FoOxEEulpp/gAL1N4X0MltQUCEqzRmEypKkvOAx8twlMeVtfXfuHNFmn1UYCduxNiAMPAV6NOAs6M28yxyQqLVz795rrdfQtVzPIqPRje4VlnCuASSvHHIWhyBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB3034.namprd12.prod.outlook.com (20.178.30.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 15:47:53 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 15:47:53 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Thread-Topic: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Thread-Index: AQHVjpRhG4qMUtf7g0GYUhVpnQA386dzNXiAgAAgJIA=
Date: Wed, 30 Oct 2019 15:47:53 +0000
Message-ID: <ef1c1862-2c4e-1a76-5df0-943b6a972698@amd.com>
References: <1572379585-1401-1-git-send-email-JinhuiEric.Huang@amd.com>
 <ebd653c8-d9e9-b104-769f-e68dee0e4c65@gmail.com>
In-Reply-To: <ebd653c8-d9e9-b104-769f-e68dee0e4c65@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca004606-92b5-4727-a8cc-08d75d508660
x-ms-traffictypediagnostic: DM6PR12MB3034:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30340C09165D1FF866024CFD92600@DM6PR12MB3034.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(66556008)(52116002)(3846002)(186003)(4001150100001)(66446008)(31686004)(6506007)(386003)(53546011)(110136005)(2906002)(66476007)(6116002)(86362001)(316002)(26005)(99286004)(102836004)(5660300002)(66946007)(58126008)(64756008)(76176011)(2501003)(66574012)(25786009)(71190400001)(81156014)(8936002)(6436002)(229853002)(6246003)(6306002)(8676002)(65806001)(14444005)(65956001)(66066001)(256004)(6486002)(6512007)(81166006)(486006)(966005)(14454004)(7736002)(305945005)(71200400001)(31696002)(446003)(2616005)(11346002)(478600001)(476003)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3034;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9L6bwwZd6GgsAwRLhdThH5+1z/jhm8okcA0RyQsUesi4Rhn37+nVH2t1DDKu2kTl2yu2Lr/wuJmgx5Wpnc9+GQuENXlkg8j8RjkJ/NwL0eOUIEFecuxeiiSOT+Ga0YFxYa1fcAY1/jKtgbucFS0k9t+97g5shYkJ5Zqt1WEQGTPaySDQDla1ENESQiMxBXEg6zUpdjt6OhzXvvNyyX3+a/JvcgWP1nMLP0Sotll3NTU6nvJZKTtEr3EEda0PvQu64AlTKlGvZsnIs87tjIzps04dy0ai8lk2nBjrk737rnmMiz35KweSyRGMH9kadq04k0j40R/o2rTkvUYA3SNQo/L6PCiVZuTy+L+nGc2GK+cCL0mumQJAeeIufaCqGz42BZxC5VFM+v1arkOSY1jOtIBeepIUPNBJylq7xpUf9F6+hfHop2L+5QLhhwi6rolb0kFlRdws9gAcusPS1Dg9+OJYNNJx83LYBcGJSNNyd8=
Content-ID: <819BC549570C2C4A85DEDE0D0D3A15F8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca004606-92b5-4727-a8cc-08d75d508660
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 15:47:53.1052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heG1fkZsMOiSrUnxylvJS86jO8aU1z6IxIMbcTvUiKe+JCiiObzS4SAfczbTBpBPJ109bfWDIb6b+FUef3w7fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vij2UCVxlXoPHQgswMNvxJddJhPsULCBvOt3SWsKTCY=;
 b=v3MGToVrXZJ3bvyhQHzjeSWXZwazydYnzXhFb2cWWIwUg/LnB3VMrLyK7uiKWLtBIFVVrxIArwDW1dcZrYBdazNITjHf3Mq6Sz8c5b2hiDlzUurzJIN2mPaSZ/+Vqy/QvKl6j4CUorFUZsTXfJNkxg+C5HscbVQs2nu8H3ayK9c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030154753.pt2yI2EZwwRTPg0QGoqR1fAjisqTRkQh5-JmljhTa_Y@z>

T24gMjAxOS0xMC0zMCA5OjUyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEFtIDI5
LjEwLjE5IHVtIDIxOjA2IHNjaHJpZWIgSHVhbmcsIEppbkh1aUVyaWM6DQo+PiBUaGUgaXNzdWUg
aXMgUFQgQk9zIGFyZSBub3QgZnJlZWQgd2hlbiB1bm1hcHBpbmcgVkEsDQo+PiB3aGljaCBjYXVz
ZXMgdnJhbSB1c2FnZSBhY2N1bXVsYXRlZCBpcyBodWdlIGluIHNvbWUNCj4+IG1lbW9yeSBzdHJl
c3MgdGVzdCwgc3VjaCBhcyBrZmQgYmlnIGJ1ZmZlciBzdHJlc3MgdGVzdC4NCj4+IEZ1bmN0aW9u
IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZygpIGlzIGNhbGxlZCBieSBib3RoDQo+PiBhbWRn
cHVfdm1fYm9fdXBkYXRlKCkgYW5kIGFtZGdwdV92bV9jbGVhcl9mcmVlZCgpLiBUaGUNCj4+IHNv
bHV0aW9uIGlzIHJlcGxhY2luZyBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoKSBpbg0KPj4g
YW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKCkgd2l0aCByZW1vdmluZyBQVCBCT3MgZnVuY3Rpb24NCj4+
IHRvIHNhdmUgdnJhbSB1c2FnZS4NCj4NCj4gTkFLLCB0aGF0IGlzIGludGVudGlvbmFsIGJlaGF2
aW9yLg0KPg0KPiBPdGhlcndpc2Ugd2UgY2FuIHJ1biBpbnRvIG91dCBvZiBtZW1vcnkgc2l0dWF0
aW9ucyB3aGVuIHBhZ2UgdGFibGVzIA0KPiBuZWVkIHRvIGJlIGFsbG9jYXRlZCBhZ2FpbiB1bmRl
ciBzdHJlc3MuDQoNClRoYXQncyBhIGJpdCBhcmJpdHJhcnkgYW5kIGluY29uc2lzdGVudC4gV2Ug
YXJlIGZyZWVpbmcgcGFnZSB0YWJsZXMgaW4gDQpvdGhlciBzaXR1YXRpb25zLCB3aGVuIGEgbWFw
cGluZyB1c2VzIGh1Z2UgcGFnZXMgaW4gDQphbWRncHVfdm1fdXBkYXRlX3B0ZXMuIFdoeSBub3Qg
d2hlbiBhIG1hcHBpbmcgaXMgZGVzdHJveWVkIGNvbXBsZXRlbHk/DQoNCkknbSBhY3R1YWxseSBh
IGJpdCBzdXJwcmlzZWQgdGhhdCB0aGUgaHVnZS1wYWdlIGhhbmRsaW5nIGluIA0KYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzIGlzbid0IGtpY2tpbmcgaW4gdG8gZnJlZSB1cCBsb3dlci1sZXZlbCBwYWdl
IA0KdGFibGVzIHdoZW4gYSBCTyBpcyB1bm1hcHBlZC4NCg0KUmVnYXJkcywNCiDCoCBGZWxpeA0K
DQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPj4NCj4+IENoYW5nZS1JZDogSWMy
NGUzNWJmZjhjYTg1MjY1YjQxOGE2NDIzNzNmMTg5ZDk3MmE5MjQNCj4+IFNpZ25lZC1vZmYtYnk6
IEVyaWMgSHVhbmcgPEppbmh1aUVyaWMuSHVhbmdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA1NiANCj4+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyANCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMNCj4+IGluZGV4IDBmNGMzYjIuLjhhNDgwYzcgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IEBAIC0xOTMwLDYgKzE5MzAsNTEg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX3BydF9maW5pKHN0cnVjdCANCj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPj4gwqAgfQ0KPj4gwqAgwqAgLyoqDQo+
PiArICogYW1kZ3B1X3ZtX3JlbW92ZV9wdGVzIC0gZnJlZSBQVCBCT3MNCj4+ICsgKg0KPj4gKyAq
IEBhZGV2OiBhbWRncHUgZGV2aWNlIHN0cnVjdHVyZQ0KPj4gKyAqIEB2bTogYW1kZ3B1IHZtIHN0
cnVjdHVyZQ0KPj4gKyAqIEBzdGFydDogc3RhcnQgb2YgbWFwcGVkIHJhbmdlDQo+PiArICogQGVu
ZDogZW5kIG9mIG1hcHBlZCBlbnRyeQ0KPj4gKyAqDQo+PiArICogRnJlZSB0aGUgcGFnZSB0YWJs
ZSBsZXZlbC4NCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IGFtZGdwdV92bV9yZW1vdmVfcHRlcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X3ZtICp2bSwgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCkNCj4+ICt7DQo+PiArwqDC
oMKgIHN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yIGN1cnNvcjsNCj4+ICvCoMKgwqAgdW5zaWdu
ZWQgc2hpZnQsIG51bV9lbnRyaWVzOw0KPj4gKw0KPj4gK8KgwqDCoCBhbWRncHVfdm1fcHRfc3Rh
cnQoYWRldiwgdm0sIHN0YXJ0LCAmY3Vyc29yKTsNCj4+ICvCoMKgwqAgd2hpbGUgKGN1cnNvci5s
ZXZlbCA8IEFNREdQVV9WTV9QVEIpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWFtZGdwdV92
bV9wdF9kZXNjZW5kYW50KGFkZXYsICZjdXJzb3IpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9FTlQ7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgd2hpbGUg
KGN1cnNvci5wZm4gPCBlbmQpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfdm1fZnJlZV90
YWJsZShjdXJzb3IuZW50cnkpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIG51bV9lbnRyaWVzID0gYW1k
Z3B1X3ZtX251bV9lbnRyaWVzKGFkZXYsIGN1cnNvci5sZXZlbCAtIDEpOw0KPj4gKw0KPj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIChjdXJzb3IuZW50cnkgIT0gJmN1cnNvci5wYXJlbnQtPmVudHJpZXNb
bnVtX2VudHJpZXMgLSAxXSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTmV4dCBw
dGIgZW50cnkgKi8NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNoaWZ0ID0gYW1kZ3B1X3Zt
X2xldmVsX3NoaWZ0KGFkZXYsIGN1cnNvci5sZXZlbCAtIDEpOw0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3Vyc29yLnBmbiArPSAxVUxMIDw8IHNoaWZ0Ow0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3Vyc29yLnBmbiAmPSB+KCgxVUxMIDw8IHNoaWZ0KSAtIDEpOw0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY3Vyc29yLmVudHJ5Kys7DQo+PiArwqDCoMKgwqDCoMKgwqAgfSBl
bHNlIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5leHQgcHRiIGVudHJ5IGluIG5l
eHQgcGQwIGVudHJ5ICovDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfdm1fcHRf
YW5jZXN0b3IoJmN1cnNvcik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaGlmdCA9IGFt
ZGdwdV92bV9sZXZlbF9zaGlmdChhZGV2LCBjdXJzb3IubGV2ZWwgLSAxKTsNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN1cnNvci5wZm4gKz0gMVVMTCA8PCBzaGlmdDsNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN1cnNvci5wZm4gJj0gfigoMVVMTCA8PCBzaGlmdCkgLSAxKTsNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV92bV9wdF9kZXNjZW5kYW50KGFkZXYsICZj
dXJzb3IpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8Kg
wqDCoCByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+PiDCoMKgICogYW1kZ3B1X3Zt
X2NsZWFyX2ZyZWVkIC0gY2xlYXIgZnJlZWQgQk9zIGluIHRoZSBQVA0KPj4gwqDCoCAqDQo+PiDC
oMKgICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcg0KPj4gQEAgLTE5NDksNyArMTk5NCw2
IEBAIGludCBhbWRncHVfdm1fY2xlYXJfZnJlZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+PiAq
YWRldiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNl
ICoqZmVuY2UpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fdmFfbWFw
cGluZyAqbWFwcGluZzsNCj4+IC3CoMKgwqAgdWludDY0X3QgaW5pdF9wdGVfdmFsdWUgPSAwOw0K
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNlICpmID0gTlVMTDsNCj4+IMKgwqDCoMKgwqAg
aW50IHI7DQo+PiDCoCBAQCAtMTk1OCwxMyArMjAwMiwxMCBAQCBpbnQgYW1kZ3B1X3ZtX2NsZWFy
X2ZyZWVkKHN0cnVjdCANCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhX21hcHBpbmcsIGxpc3QpOw0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsKCZtYXBwaW5nLT5saXN0KTsNCj4+IMKgIC3CoMKgwqDC
oMKgwqDCoCBpZiAodm0tPnB0ZV9zdXBwb3J0X2F0cyAmJg0KPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWFwcGluZy0+c3RhcnQgPCBBTURHUFVfR01DX0hPTEVfU1RBUlQpDQo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbml0X3B0ZV92YWx1ZSA9IEFNREdQVV9QVEVfREVGQVVMVF9BVEM7
DQo+PiArwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV92bV9yZW1vdmVfcHRlcyhhZGV2LCB2bSwN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG1hcHBpbmctPnN0YXJ0ICsgMHgx
ZmYpICYgKH4weDFmZmxsKSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG1h
cHBpbmctPmxhc3QgKyAxKSAmICh+MHgxZmZsbCkpOw0KPj4gwqAgLcKgwqDCoMKgwqDCoMKgIHIg
PSBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoYWRldiwgdm0sIGZhbHNlLCBOVUxMLA0KPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwcGluZy0+
c3RhcnQsIG1hcHBpbmctPmxhc3QsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbml0X3B0ZV92YWx1ZSwgMCwgTlVMTCwgJmYpOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGFtZGdwdV92bV9mcmVlX21hcHBpbmcoYWRldiwgdm0sIG1hcHBpbmcsIGYp
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkbWFfZmVuY2VfcHV0KGYpOw0KPj4gQEAgLTE5ODAsNyArMjAyMSw2IEBAIGludCBh
bWRncHVfdm1fY2xlYXJfZnJlZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+PiAqYWRldiwNCj4+
IMKgwqDCoMKgwqAgfQ0KPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+IC0NCj4+IMKgIH0N
Cj4+IMKgIMKgIC8qKg0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
