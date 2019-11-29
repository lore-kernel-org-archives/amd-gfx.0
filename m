Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87ACC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C312621774
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C312621774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3AC6E899;
	Fri, 29 Nov 2019 09:22:25 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730061.outbound.protection.outlook.com [40.107.73.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF716E899
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obmgQjEcmclMopd6H5dJLo1gMTGyLnoPFLtwZpnIOcqzNGNHuqJ4EZQUEUI7rAi6aCEA70EGOQn1C402GE5x/7LpffoLRsR7lLTofSL6xgoCnhEFiZsnnDFrNb2ascA58PLPF0CV02pZCi9w8b58MaMG2mdiofY9yCLrH/gZTVTJiNVZznGXRq5eLCQUaSU/hA0VyIJV0IewZfZxTtzkfBP5CyVtRvvN6HUqcSwJdNaLzGXVMmWNSy/UYev3boFWeQ7RdkkShglzLj0e3bwRQMRKeWn7qXaPuR2ejwMBHEyfnNyi2iCRx6sdRPaUew5FUiiMYD3qZD7uEsnxq4wFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRVdXEycn/SlBCaUAbmHmhWVaCNBXMtqHfVWqeDK528=;
 b=MB1espNZ7bkL5uaQub0xezTzhPqO+xdJcJzfVcFEhCkXE5wGIZ4hLDD5swQUUQNtv5U2+RCCQx+abHguv7wOCqnZnGTQjBSl+/1cRCfssXHSvdznYMAy0vTYdmYEAVn5xBT/9yxJEqep0w3Gvw7f47p0H9dALCJ5WlHqnpv+J1QvtxKNQBbL4fzJHQHCXneIoYY0MXObQ4mzo3x9JCzGLQe8NDbf1uVgZ/wVyL34AoRgllstujdMdMkEoDoIqRQRrwbot3ouhSuHlLyRJhoCQM/CjvIdMYfS9k5AHvVIszrP+IRiid5rNbE3YL7EmiMvXQgZ3hc6QzLBWl9OLXRS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1179.namprd12.prod.outlook.com (10.168.234.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:22:21 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:22:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpo6OZhUrafAMD0WsHkOCG51Braeh0m+ggAADfACAAANRsIAABPqg
Date: Fri, 29 Nov 2019 09:22:21 +0000
Message-ID: <DM5PR12MB141820DC9911BB959FD04C35FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
 <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
 <MN2PR12MB39330EA36530757CE5F3D0B784460@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM5PR12MB1418A6FEA53EDF93DCB472EFFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418A6FEA53EDF93DCB472EFFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-29T09:21:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=abc06a29-8711-4f88-a7f8-000034df0fa2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-11-29T09:22:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f9bed47c-a291-49cb-8140-00006ab10a45
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8c08666-9bda-429f-5690-08d774ada355
x-ms-traffictypediagnostic: DM5PR12MB1179:|DM5PR12MB1179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11795A7D54229916505415D3FC460@DM5PR12MB1179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(13464003)(189003)(199004)(966005)(64756008)(66556008)(110136005)(7696005)(102836004)(45080400002)(256004)(14454004)(11346002)(76116006)(66066001)(446003)(6436002)(6246003)(6506007)(186003)(26005)(53546011)(2940100002)(71190400001)(52536014)(71200400001)(76176011)(66946007)(5660300002)(66476007)(229853002)(66446008)(86362001)(6306002)(9686003)(478600001)(55016002)(8936002)(33656002)(25786009)(81166006)(316002)(2906002)(305945005)(74316002)(8676002)(99286004)(81156014)(7736002)(6116002)(3846002)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1179;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h22N/EtWzfPGfAvp3knBYfrPI6tl2tPXnDXuQjWW9LEAyMDGQkf+mSUSbzJ3ae194EQKzhpV6hKxdNh49uQT75XTb9xYck81pjFFv3cztnscQCU2eCtkEeLVKv6AZDNRlT25S7b/ojO/TP2kGrFRvgo1cFu2TV8D7bgoCirULz66esDAyrhkVPmiaRIT4TGEWpQEupB7m2K9AVLowThqW002kSl+zaPcWAwa4us5NOrnMM8APrDmKf8tMwolF3D1YhLGYf56iyFRphm/TX9mE4W0G3Qev/a4/P63nXl7WW2MHODdlpLThrK6eXbB7dVj/64l5aB/MoRTjl+LcmrfBcDmf4MQwsBZZlGwz3v2OIOtesPXMsiG3a6KoaU42n9/+bONmLaXTA+u2AaMKmwV4HuNiDHGnGUXCmoicR9ISCAslHNLiIxk9BaozMEWXhXx4UrnyVqcyec+BnrkAU5ygWy19Ngt3myN5pj6BFOjV5I=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c08666-9bda-429f-5690-08d774ada355
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:22:21.3458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWgrqgwqXtnYXPDhm4E3P/JUW/fgb9WOtBymiZpjFAL2r7+8hxh2u/GtfutEZ47LM4XB6aUDWD722xei236ukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRVdXEycn/SlBCaUAbmHmhWVaCNBXMtqHfVWqeDK528=;
 b=YsVz8TCb7AASrIG/LNuxeHDlrC/LS7xrBsVkmuXIfwGSksJA4DS3FCXDVz79EGDjEVwz/QKzn3NvYQlirSrLQqV+Wy5WYOKIO3MtzXsB4beUBRKlJNnTRZpHBJPW/mhxuqnkwDXyGLYXl/onffAE8VSPR8tPf86l/EcfgG7rkXc=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpCVFcsIFBsZWFzZSBhbHNvIG1ha2UgdGhlIGNoYW5nZSBmb3Ig
YmFja2Rvb3IgbG9hZGluZyBjb2RlIHBhdGggYXMgd2UgbmVlZCB0aGF0IGZvciBmdXJ0aGVyIEFT
SUMgYnJpbmcgdXAuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFpoYW5nLCBIYXdraW5nIA0KU2VudDogMjAxOeW5tDEx5pyI
Mjnml6UgMTc6MDgNClRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6
IGZpeCBHRlgxMCBtaXNzaW5nIENTSUIgc2V0DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KVGhlIGdmeDEwIFBHIGFuZCBnZnhvZmYgYXJl
IGZ1bGx5IGNvbnRyb2xsZWQgYnkgUkxDIGFuZCBTTVUgZncgYW5kIGRvbid0IG5lZWQgZHJpdmVy
IHRvIGJlIGludm9sdmVkIGFueW1vcmUuIFNvIHRoZSBsZWdhY3kgcHJvZ3JhbWluZyBmb3IgZ2Z4
X2lkbGVfdGhyZXNob2xkLmV0YyB3aWxsIG5vdCBiZSBhcHBsaWVkIHRvIGdmeDEwLiANCg0KTW9y
ZSBhZ2dyZXNzaXZlbHksIGxldCdzIGRyb3AgZ2Z4X3YxMF8wX2luaXRfcGcgYW5kIGp1c3QgaW5p
dCBjc2IuIA0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTHmnIgy
OeaXpSAxNjo0Nw0KVG86IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGRy
bS9hbWRncHU6IGZpeCBHRlgxMCBtaXNzaW5nIENTSUIgc2V0DQoNCkZvciBub3cgaW5pdF9wZygp
IGlzIGdvb2QgZW5vdWdoIGZvciBiYXJlLW1ldGFsIGFuZCBTUi1JT1YsIGJ1dCBjaGVja291dCBH
Rlg5LCB0aGVyZSBhcmUgbW9yZSBqb2JzIGluIGluaXRfcGcoKSwgc28gaW4gdGhlIGZ1dHVyZSBJ
J2QgZXhwZWN0IHRoZXJlIHdpbGwgYmUgTW9yZSBsaW5lcyBjb21lIGludG8gaW5pdF9wZygpIG9u
IGdmeDEwIGFuZCBieSB0aGF0IHRpbWUgSSBuZWVkIHRvIG1vZGlmeSBpbml0X3BnKCkgLCANCg0K
U28gSU1ITyB0aGUgYmVzdCB3YXkgaXMgdXNlIGluaXRfY3NiKCkgZnJvbSB0aGUgYmVnaW5uaW5n
IA0KDQpUaGFua3MNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk1vbmsg
TGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4gDQpT
ZW50OiBGcmlkYXksIE5vdmVtYmVyIDI5LCAyMDE5IDQ6NDMgUE0NClRvOiBMaXUsIE1vbmsgPE1v
bmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExpdSwg
TW9uayA8TW9uay5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSBkcm0vYW1k
Z3B1OiBmaXggR0ZYMTAgbWlzc2luZyBDU0lCIHNldA0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCkkgZG9uJ3QgdGhpbmsgeW91IG5lZWQg
dG8gaW50cm9kdWNlIFNSSU9WIHNwZWNpZmljIHBhdGggaGVyZS4gVGhlIGdmeF92MTBfMF9pbml0
X3BnIHNob3VsZCBiZSBnb29kIGVub3VnaCB0byBjb3ZlciBib3RoIGJhcmUtbWV0YWwgYW5kIHZp
cnR1YWxpemF0aW9uIGNhc2UuIA0KDQpZb3UgY2FuIGRyb3AgdGhlIHRsYiBmbHVzaCBpbiB0aGF0
IGZ1bmN0aW9uIGlmIHRoYXQncyB5b3VyIG1ham9yIGNvbmNlcm4uDQoNClJlZ2FyZHMsDQpIYXdr
aW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIE1vbmsgTGl1DQpTZW50
OiAyMDE55bm0MTHmnIgyOeaXpSAxNjoyNA0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpDYzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDEv
Ml0gZHJtL2FtZGdwdTogZml4IEdGWDEwIG1pc3NpbmcgQ1NJQiBzZXQNCg0Kc3RpbGwgbmVlZCB0
byBpbml0IGNzYiBldmVuIGZvciBTUklPVg0KDQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9u
ay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jIHwgOCArKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQppbmRleCA3
NGVkZmQ5Li4yMzBlOGFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
DQpAQCAtMTg3NCwxNCArMTg3NCwxNiBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9ybGNfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KIAlpbnQgcjsNCiANCi0JaWYgKGFtZGdw
dV9zcmlvdl92ZihhZGV2KSkNCi0JCXJldHVybiAwOw0KLQ0KIAlpZiAoYWRldi0+ZmlybXdhcmUu
bG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX1BTUCkgew0KIAkJciA9IGdmeF92MTBfMF93YWl0
X2Zvcl9ybGNfYXV0b2xvYWRfY29tcGxldGUoYWRldik7DQogCQlpZiAocikNCiAJCQlyZXR1cm4g
cjsNCiANCisJCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCisJCQlnZnhfdjEwXzBfaW5p
dF9jc2IoYWRldik7DQorCQkJcmV0dXJuIDA7DQorCQl9DQorDQogCQlyID0gZ2Z4X3YxMF8wX2lu
aXRfcGcoYWRldik7DQogCQlpZiAocikNCiAJCQlyZXR1cm4gcjsNCi0tDQoyLjcuNA0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWls
aW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NoYXdraW5nLnpoYW5nJTQwYW1kLmNvbSU3Q2MzNDNhZmE5YWEyMzRjYmI4Mjc1MDhk
Nzc0YTU3MjY4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzEwNjEyNzI3NzM1MzA4NiZhbXA7c2RhdGE9S3QlMkZkMTY4MFJjM2x5Rnd6NG5nNWVBN0p4aVlX
amYxd2hEQnBmbkh6VEpzJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
