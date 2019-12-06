Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9658C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816BD2466E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816BD2466E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5146E049;
	Fri,  6 Dec 2019 08:07:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FEA6E049
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 08:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DATPugY0sqZBne4CdfxWsZaylg6a19tCnWoxLTo316K6Mbr8/w4AAWRdnw7OkEqBp4c70jGlOvUOGcMRJFkvVrAcUFkRe9IV8qy8KuOFO+sTFEcTexIp6vvo13h7DG2ivVTw3FFSlyMVGnGeMmfPp0dBv1iq2jyvz3e642rBt7qSBSh7G0/1fLHu//QDTZTxVxByuaoZQCiQ8z5YW+DZwQpgBpxQ/8rdp2TsR+kv1dMzT+n/dzXkhZt3u+c8P3tvGSPNe1cD9eUcz02O4pMuO4x9yrQppykxrdJxy4AL9XVqPLZowk+EXVDlWdqqHEKdxzlpDrVhTNPXAZxoK5AbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgPuaU2ueVtC3+zOvGkKm0c+x2EvAigLpcXyGZC3P4c=;
 b=RFsDeDDVKe/Ci5B36u2VrnP5gENA8mtv4DxrZZwl4wNwAw5VxfPTtpmDzLHTjS0mED9dVR6pLBVVuS7qRbHYfgzDALbymFf5JdbB5XnxFdKCw6LG6OpfTJE58AciG534Z0UtYe65qe3bFFhAHT7Enf09RAYrPKBKHgRcSQL/jNUn4/U7u9j89RkwCS/exil5RmEPwvmGVe3SWULuwi8AW9odl65yeHRNjLyYVJrr248IPmsFuuKIDJDxt6ReW/mfyNhCcFzcgfFNepOBluX99qormGFwqn+v66YhtsCC1aaVRZ6eLpXPq2ZIKrzrkmKvnLNPMfPXh7l7UmOL7nd7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1424.namprd12.prod.outlook.com (10.169.206.135) by
 MWHPR12MB1501.namprd12.prod.outlook.com (10.172.55.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Fri, 6 Dec 2019 08:07:24 +0000
Received: from MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::e931:14f6:ce41:812f]) by MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::e931:14f6:ce41:812f%8]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 08:07:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, 
 "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Topic: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Index: AQHVq+ZVAtbmf8jej0a7L9A8c6Be7aesgQcAgAASzgCAACtuoA==
Date: Fri, 6 Dec 2019 08:07:24 +0000
Message-ID: <MWHPR12MB142482E36A82A54C0BD53F6DFC5F0@MWHPR12MB1424.namprd12.prod.outlook.com>
References: <20191206033543.3131-1-evan.quan@amd.com>
 <BB0A14B8-3288-4EE0-8352-162F81477E1A@amd.com>
 <MN2PR12MB334455F883AD2A8F4DD09AD7E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB334455F883AD2A8F4DD09AD7E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=74d7fe04-4d38-4c0d-98d9-0000961feb3b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T05:16:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5aa14c6e-30c8-4c4f-ae17-08d77a2353dd
x-ms-traffictypediagnostic: MWHPR12MB1501:|MWHPR12MB1501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB15012D2DCA6115F63017B71CFC5F0@MWHPR12MB1501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(13464003)(43544003)(25786009)(9686003)(4326008)(55016002)(229853002)(71200400001)(14444005)(71190400001)(11346002)(26005)(186003)(6636002)(33656002)(99286004)(478600001)(52536014)(45080400002)(110136005)(8936002)(81156014)(81166006)(7696005)(316002)(76176011)(5660300002)(14454004)(86362001)(66946007)(66556008)(64756008)(66446008)(2906002)(66476007)(76116006)(966005)(53546011)(102836004)(74316002)(8676002)(6506007)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1501;
 H:MWHPR12MB1424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSv89nnMw2M+/9v5K26wE+904UZniA9n0cl63HPWreQrjF2q1ArO/zi2OfgOnI/uMnyRGXorE7tjpfRWfO0rtAZZdIvBj9OKpkcuGNZU3taENI6LoSvd8wgvawDZ9lAHDS0ahmaP7bUtH6U7II2y6qr6/Ayus0pLZxn61VSz0cnD4clUg1QkRIVB7mh2vwQiqYJurgWGsOTWkfX4P2FFWlcV+nGuGQfM85UCHar3ecbvgt7zISMhGBCVJdlTxQ9Tfk5YBBXxQw3J3NX2XM5NWr9FBD9dFlecM3jB8pDW8Vg+IYZhaqaXIIHzcRY1X0kgFXI2K4NuWkt9UTvbF0fqdxFp8qcouwGBtEOx9/Seazlz6+S5j1bQrSZb1YuVYP4xWCmEFo2vetAb8sJfj0CUAu0MSX+PIs9n+rWFkhuv55NFPIUbFMEJ9e6N6Fp+CNWoC0U3nD2fAWrkFZPKado0KLExgR2arQbojbzhjhuZ8s9ejprjNeN1dhq2GXfWkHVArMrTc60Pb+slU/Cmjd2DfrGC2BOkQVOVXf5sVZ9XqeUumCwvpP+Q3GkAHyw5MbV3
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa14c6e-30c8-4c4f-ae17-08d77a2353dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 08:07:24.4356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPSgDPSmz2xeFb1IJadGGgTDeAB736hsxQFQ0MjlEnPtC/282SMM0gZN3PGgphKHzBDc9OpGsWAqoOmRHD5Bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1501
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgPuaU2ueVtC3+zOvGkKm0c+x2EvAigLpcXyGZC3P4c=;
 b=18naCMGmncN3F2+EQeTcbZlo/ps7cWf9PpdTR1fB6g/0dYCv1wRn09z5n0kYd3rV7EP/ZyfmXsDPtDSkufSPWwjGZEm13M+kguPH/ubComkIr1l+cDEGSbSxKWBQpEU9qfhp6QrQ61Rd+CGVMoj0YC5WWr8HXx4OfnA9BGv9dS0=
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBpbiBoaWdoIHJpc2sgdG8gYnJlYWsgc2Vjb25kYXJ5IGdwdSByZXN1bWUgYW5kIHJl
c2V0IGp1c3QgYmVjYXVzZSB5b3UgY2xlYXIgdGhlIEFUT01fUzdfQVNJQ19JTklUX0NPTVBMRVRF
X01BU0sgZmllbGQgaW4gc2NyYXRjaCByZWdpc3RlciA3LiBBbmQgdGhlIGF0b21fYmlvcyBpbml0
IHdpbGwgYmUgc2tpcHBlZC4NCg0KV2Ugc2hhbGwgdW5kZXJzdGFuZCBhbnkgbGliZ3YgZml4ZXMg
dmVyeSB3ZWxsIGJlZm9yZSAiY29weSIgaXQgdG8gYmFyZS1tZXRhbC4gTGliZ3YgZG9uJ3QgbmVl
ZCB0byB0YWtlIGNhcmUgUzMuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIFF1YW4sIEV2YW4NClNlbnQ6IDIwMTnlubQxMuaciDbml6Ug
MTM6MjcNClRvOiBZdWFuLCBYaWFvamllIDxYaWFvamllLll1YW5AYW1kLmNvbT47IEx1bywgWmhp
Z2FuZyA8WmhpZ2FuZy5MdW9AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9wb3dlcnBsYXk6IGNsZWFyIFZCSU9T
IHNjcmF0Y2hzIG9uIGJhY28gZXhpdA0KDQpIaSBYaWFvamllLA0KDQpUaGlzIHdhcyByZXBvcnRl
ZCBieSBaaGlnYW5nIHRlYW0uICBVbmRlciB0aGVpciBzcGVjaWFsIHVzZSBjYXNlLCBzY3JhdGNo
IHJlZ2lzdGVyIDcgaGFzIGJlIHRvIDAgdG8gcGVyZm9ybSBhc2ljIGluaXQoQEx1bywgWmhpZ2Fu
ZyByaWdodD8pLg0KQW5kIGNvbnNpZGVyaW5nIG9sZCBhc2ljcyh2ZWdhMjAvMTApIGFsc28gYXBw
bGllZCB0aGlzIGNoYW5nZS4NClNvLCBJIHRoaW5rIGl0J3MgcmVhc29uYWJsZShhbmQgcmVjb21t
ZW5kIGJ5IFNNVSBmdyB0ZWFtKSB0byBhcHBseSB0aGlzIG9uIHRoZSBuZXcgQVNJQ3MgYWxzby4N
Cg0KUmVnYXJkcywNCkV2YW4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
WXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVj
ZW1iZXIgNiwgMjAxOSAxMjoyMCBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTHVvLCBaaGlnYW5nIDxa
aGlnYW5nLkx1b0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3Bvd2Vy
cGxheTogY2xlYXIgVkJJT1Mgc2NyYXRjaHMgb24gYmFjbyANCj4gZXhpdA0KPiANCj4gSGkgRXZh
biwNCj4gDQo+IEp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgbWF5IEkga25vdyB3aGF0IGlzc3VlIGFy
ZSB5b3UgdHJ5aW5nIHRvIGZpeD8NCj4gSSB1c2VkIHRvIHNlZSB2YmlvcyBwb3N0IGZhaWx1cmUg
KGhhbmdzIGluIGF0b21iaW9zIGluaXQgdGFibGUpIGFmdGVyIA0KPiBiYWNvIGV4aXQgb2NjYXNp
b25hbGx5IG9uIG5hdmkuDQo+IA0KPiBCUiwNCj4gWGlhb2ppZQ0KPiANCj4gPiBPbiBEZWMgNiwg
MjAxOSwgYXQgMTE6MzcgQU0sIEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gVGhpcyBpcyBuZWVkZWQgZm9yIGNvbWluZyBhc2ljIGluaXQgb24gcGVyZm9ybWlu
ZyBncHUgcmVzZXQuDQo+ID4NCj4gPiBDaGFuZ2UtSWQ6IElmMzY3MWEyNGQyMzllM2QyODg2NjVm
YWRhYTJjNDBjODdkNWRhNDBiDQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1
YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVfdjExXzAuYyB8IDYgKysrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMN
Cj4gPiBpbmRleCAzOWVjMDZhZWU4MDkuLmFiODA5ZGY3YmMzNSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jDQo+ID4gQEAgLTE2NTksNiArMTY1
OSwxMiBAQCBpbnQgc211X3YxMV8wX2JhY29fc2V0X3N0YXRlKHN0cnVjdA0KPiBzbXVfY29udGV4
dCAqc211LCBlbnVtIHNtdV9iYWNvX3N0YXRlIHN0YXRlKQ0KPiA+ICAgICAgICB9DQo+ID4gICAg
fSBlbHNlIHsNCj4gPiAgICAgICAgcmV0ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0df
RXhpdEJhY28pOw0KPiA+ICsgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgIGdvdG8g
b3V0Ow0KPiA+ICsNCj4gPiArICAgICAgICBXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1CSU9TX1ND
UkFUQ0hfNiwgMCk7DQo+ID4gKyAgICAgICAgV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklPU19T
Q1JBVENIXzcsIDApOw0KPiA+ICsNCj4gPiAgICAgICAgYmlmX2Rvb3JiZWxsX2ludHJfY250bCA9
IFJFR19TRVRfRklFTEQoYmlmX2Rvb3JiZWxsX2ludHJfY250bCwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgIEJJRl9ET09SQkVMTF9JTlRfQ05UTCwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgIERPT1JCRUxMX0lOVEVSUlVQVF9ESVNBQkxFLCAwKTsNCj4gPiAtLQ0KPiA+IDIuMjQuMA0K
PiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+ID4NCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdA0KPiBzLmZyZWUNCj4gZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDWGlhb2ppZS5Z
dWFuJTQwYW1kLmNvbSU3QzY4MmMxNDJlZjMwNzQ4YmJkDQo+IDAwNTA4ZDc3OWZkNmY4MiU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcNCj4gMTEyMDAyMjA4
OTI3NzMzJmFtcDtzZGF0YT1iYWphYWozQ3cySXhXNW5SdWNnM0ZYVWpjeUlpNTBrQ1NQUTdla25x
aw0KPiA0byUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2luZy56aGFuZyU0MGFt
ZC5jb20lN0M1YjliMDA4YTA4Njc0YjlhZGY0NjA4ZDc3YTBjZjczZiU3QzNkZDg5NjFmZTQ4ODRl
NjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMTIwNjg1MDYwNTg0NjAmYW1wO3NkYXRh
PU1BdTRMcWFjOVRhMEhXR0tVcG5yNkJEcnFITndsZmxqYURUaVVJdW9vcm8lM0QmYW1wO3Jlc2Vy
dmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
