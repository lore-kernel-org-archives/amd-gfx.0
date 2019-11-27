Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A2C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC80206CC
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC80206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677286E23D;
	Wed, 27 Nov 2019 03:26:11 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCFF6E23D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 03:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyvqygq3wNhvrlM0HFRqszUip+ozmF3Q8OKVtGMrdx//mthJ1bIHQ4m3yI/+PNbeDezb4U0CcbBGrY5GJkRykCpu8dxCv2GRPU9GnJCkZ0uS+HN+rGnzqp6Qk2m/Z7qcywfh8koUZxwy15uzSffBCvWCq3M6chfx2TUyPmvQ0D+HRsh5jyJwzIziqiFgQ4lAfq57uH3u09C+fFXo0Srbm4drB65+LBfHGj8cWACr0lQ63v2P0grQphMnPOjlL2rKyBPNSCgDpxb+eOfTWihVbci+adhyEsu8ULeiPoLKaV0WIc2P9Pz3NdnBPUi4Mv0GCRhoT3XeJjuk1YKMP1u+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFpu6wyvbZ3GGnx9GMJTwioGJEkHgL0C2gLB75jgHWg=;
 b=CVIga3hpCOLcQ7jNQqBCmh45+13bz1m1+FS2ogb1slAS4R9WV3BaM4/jzFE0Y+TqATm9oIfgsRKhQzFTQWeEMTBNqaz+fWIwDRewelnmV+X3X8K8tdb5VEPg7ZH/I2dr3qauepd7CP/WGwGyjh60+0pP3ULuMrzHBYpNYjsNOWXEnz9AqL2IDgvBLdZPeaPeXcx6+LCQEpLAHM7GtMcWY7rcVOejKGqMAn1U60tVvjN08MRXW6yQMbWLo8DAyPOMTiVoJ37cEcRpM8faPO/PxWgiS02+yLQBqVUOjti4EQNG2YCDrtpe45Fpjv9VtvksHynzbkSBy2NYMJeviIX/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1130.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 03:26:08 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 03:26:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx: Clear more EDC cnt
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx: Clear more EDC cnt
Thread-Index: AQHVpJBvNaRlCubNhEKJjQN1kRS6DKeeVo4QgAAEpaA=
Date: Wed, 27 Nov 2019 03:26:08 +0000
Message-ID:
 <DM5PR12MB14180556A8347F6991FD69D3FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
 <DM5PR12MB1418C276613502A0CD12F1B6FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418C276613502A0CD12F1B6FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T03:24:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e1d636bb-b5d8-4af9-8e4a-00002c01b6dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-27T03:26:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 50f3280d-7faf-43e2-be8b-00005c6837b7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a911d18-2ab7-4881-8e5d-08d772e98b72
x-ms-traffictypediagnostic: DM5PR12MB1130:|DM5PR12MB1130:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1130B258100F410BC251D734FC440@DM5PR12MB1130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(13464003)(81166006)(3846002)(8936002)(5660300002)(74316002)(33656002)(71190400001)(71200400001)(66446008)(66946007)(64756008)(66556008)(66476007)(76116006)(6116002)(26005)(102836004)(66066001)(316002)(53546011)(446003)(2940100002)(229853002)(6506007)(966005)(45080400002)(6436002)(14454004)(110136005)(256004)(186003)(6306002)(11346002)(55016002)(2501003)(6246003)(99286004)(76176011)(52536014)(7696005)(478600001)(14444005)(2906002)(25786009)(81156014)(8676002)(7736002)(305945005)(9686003)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1130;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tU0mqyEGHOC/linuOZ6gH22XBQQdoflMFx05YIFhEyhugoGsiKHZzccdGal2BXKaTY4abOUqDgKe77Yk7M5TVKDvLkhjj+BnVPSR03xkM0WfRAkXIBX+P14EyfzuVHJY0ELo6sUp3JomXhkdjW34FjZxp83ctiKo1KexirrF2DZnb2l1N5jZ9Gtc7Lggw9U0Du6jTJgZ5MQg6IOa8Q+zO3jk9o4LA6jMpOY/LFArFVJeJ/eI4yuFUbOGhSe+KnL8QLdWujm6+qFyi2Ku4AjsmzFPgg2wx13glBAXPH8bUMQAdSuDAWd5dvz3wpmnZnSHZC5ygkkaQ3FVxO8jhoF2OpUBcdaf9fOLZNR+rStcw4T6ADiHF9RMZ7Ho+H1QR6oCvo2lUvejeX6uhTPyjdrDtqYBskE4M/sQHShBo1QumF9LoZlhWUUX+LMa+rkQKgjNlnyz8HKVIiuvAbMRLR+rbzrk7u6DK0Xwu0feGmNgp+A=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a911d18-2ab7-4881-8e5d-08d772e98b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 03:26:08.7092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RALuNJ3FA17jsAQ1OrI6NHNW4KKRh21llgVEA4Gt/8cHS2pe9qTgu7NrZtM0ARPTRWlz73emJ30miPtMafSAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFpu6wyvbZ3GGnx9GMJTwioGJEkHgL0C2gLB75jgHWg=;
 b=pv5KqrsnfkXLkoAji2DzCHdpz9Dx+xnyMy2/PmQ7KxkWP5jI+apgU4XMFiheHqR7U6KnEi50KlUogSEYllSrAhfdaDtPKkbfCQ8URkhcvf54hfUIOqh8vhm6bYv+WzLc0jpUsRdB984s4+gT0Z2WHPktqMyg4JoqDVt+LeVZ1vU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127032608.6VwXUTOt_RyMSLc71kfpxcSGK2R2s7kVomba1_ribao@z>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpB
aCwgc2VuZCBpdCB0b28gcXVpY2tseS4gQ2xlYW4gdXAgb3NzIGVkYyBjb3VudGVycyBzZWVtcyBu
b3QgbmVjZXNzYXJ5IHRvIG1lIHVubGVzcyBpdCBoZWxwcyBjdXJyZW50IGdmeCByYXMgc3BnciBp
c3N1ZS4gKEkgc3VzcGVjdCBpdCB3b3VsZCBoZWxwIG9uIHRoYXQgaXNzdWUpLg0KDQpSZWdhcmRz
LA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcsIEhh
d2tpbmcgDQpTZW50OiAyMDE55bm0MTHmnIgyN+aXpSAxMToyNA0KVG86IEphbWVzIFpodSA8SmFt
ZXMuWmh1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpodSwg
SmFtZXMgPEphbWVzLlpodUBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9h
bWRncHUvZ2Z4OiBDbGVhciBtb3JlIEVEQyBjbnQNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpIaSBKYW1lcywNCg0KQXJjdHVydXMgYW5k
IHZnMjAgaGF2ZSBkaWZmZXJlbnQgU0RNQSBpbnN0YW5jZXMgc28gdGhhdCB0aGUgY29tbW9uIGVk
YyBjb3VudGVyIGFycmF5IGNhbid0IGNvdmVyIGJvdGggQVNJQ3MuIFRoZSBlZGMgY291bnRlciBp
bml0aWFsaXphdGlvbiBoYXMgdG8gYmUgZWl0aGVyIGtlZXBpbmcgaW4gSVAgc3BlY2lmaWMgZWNj
IGxhdGUgaW5pdCBvciB1c2luZyBkaWZmZXJlbnQgcmVncyBhcnJheS4NCg0KU2luY2UgZXJyb3Ig
aW5qZWN0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgU0RNQS9IRFAvU0VNIGluIFZHMjAgYW5kIEFy
Y3R1cnVzLCB0aGVyZSBpcyBhY3R1YWxseSBubyB3YXkgdG8gdmFsaWRhdGUgRURDIGZvciBhbGwg
dGhlIE9TUyBibG9ja3MuIEFzIHlvdSBtYXkgbm90aWNlIHRoYXQsIGRyaXZlciBkb2Vzbid0IGxv
ZyBhbnkgZWRjIGNvdW50ZXIgZm9yIGFueSBvZiBPU1MgYmxvY2tzIGFuZCBleHBvc2UgdGhpcyB0
byB0aGUgdXNlcnMuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mIEphbWVzIFpodQ0KU2VudDogMjAxOeW5tDEx5pyIMjfml6UgMzozNA0K
VG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmh1LCBKYW1lcyA8SmFtZXMu
Wmh1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1L2dmeDogQ2xlYXIg
bW9yZSBFREMgY250DQoNCkNsZWFyIFNETUEgYW5kIEhEUCBFREMgY291bnRlciBpbiBHUFIgd29y
a2Fyb3VuZHMuDQoNClNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgNSArKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jDQppbmRleCBjOGFjZTUxLi5kYzM4ZGY4IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KQEAgLTQ4LDYgKzQ4LDggQEANCiANCiAjaW5jbHVkZSAiYW1k
Z3B1X3Jhcy5oIg0KIA0KKyNpbmNsdWRlICJzZG1hMC9zZG1hMF80XzBfb2Zmc2V0LmgiDQorI2lu
Y2x1ZGUgInNkbWExL3NkbWExXzRfMF9vZmZzZXQuaCINCiAjZGVmaW5lIEdGWDlfTlVNX0dGWF9S
SU5HUyAgICAgMQ0KICNkZWZpbmUgR0ZYOV9NRUNfSFBEX1NJWkUgNDA5Ng0KICNkZWZpbmUgUkxD
R19VQ09ERV9MT0FESU5HX1NUQVJUX0FERFJFU1MgMHgwMDAwMjAwMEwgQEAgLTQwMjksNiArNDAz
MSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2VudHJ5IHNlY19kZWRfY291bnRl
cl9yZWdpc3RlcnNbXSA9IHsNCiAgICB7IFNPQzE1X1JFR19FTlRSWShHQywgMCwgbW1UQ0NfRURD
X0NOVDIpLCAwLCAxLCAxNn0sDQogICAgeyBTT0MxNV9SRUdfRU5UUlkoR0MsIDAsIG1tVENBX0VE
Q19DTlQpLCAwLCAxLCAyfSwNCiAgICB7IFNPQzE1X1JFR19FTlRSWShHQywgMCwgbW1TUUNfRURD
X0NOVDMpLCAwLCA0LCA2fSwNCisgICB7IFNPQzE1X1JFR19FTlRSWShTRE1BMCwgMCwgbW1TRE1B
MF9FRENfQ09VTlRFUiksIDAsIDEsIDF9LA0KKyAgIHsgU09DMTVfUkVHX0VOVFJZKFNETUExLCAw
LCBtbVNETUExX0VEQ19DT1VOVEVSKSwgMCwgMSwgMX0sDQorICAgeyBTT0MxNV9SRUdfRU5UUlko
SERQLCAwLCBtbUhEUF9FRENfQ05UKSwgMCwgMSwgMX0sDQogfTsNCiANCiBzdGF0aWMgaW50IGdm
eF92OV8wX2RvX2VkY19nZHNfd29ya2Fyb3VuZHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQotLQ0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
YW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2luZy56aGFuZyU0MGFtZC5jb20lN0MyMTkz
YThhNDkzZmU0OGQzMTAwYTA4ZDc3MmE3OGZhMCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzAlN0M2MzcxMDM5MzYzMjY3ODgxNDgmYW1wO3NkYXRhPURlT0M1eThlUFp2
MlR4aEc5bkQyZUtLa3V0TVNndENLQzB0SU5VdlhydmclM0QmYW1wO3Jlc2VydmVkPTANCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
