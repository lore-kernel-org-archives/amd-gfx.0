Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A78C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F872078D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oirNaDgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F872078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE0B6EBA1;
	Fri, 10 Jul 2020 08:39:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198FC6EBA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/IyzS6N1E6/4HOiOxclJepuXFRcA0VePH8zvsZ8D3UcZY8x71Ln+KDcBfDywgPhlrgEPeMxp2r0po3tLqiNhjkg1yIHkf+1nZ0Pp9TENUhXh1u9M1eHyVajtPLXZ8eI7I/ZJLiYqzRakPTT170rBQPFR5Vcl5QLYQZQs/YdoIp5CTny3Lns5llVG9WJrZNbkbVdQPGQleSEg1NHhj1OAcav9GJaj4Je5KQiW471F/AqllDvyZglQeByk30uVoUOQghWZ2jJBICdOSblzrAZtcvuDKDWOUNPnwtJt5k/FT3QJznYflRl8mLmSe9tbmmxOm8W3SOWy0vz0wmkfmXz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR0zrRfRqZMG/CxaaxC3FgjYMIuxs/1ZJV5X+hz/AcU=;
 b=RmLn8rEtjzJ8AcxT1UFBJaE/Wu0DHMc6xFGWy+3YOUTwI9lXkTkQ3eyvVmaz4zwsW0fD4xDJVX0+LDXYaEMKQOVyuGoaVW1Up2tBNdHpe5P22rQ3P/8L2Ikvm4CWRTfrfca01EgWagYkWkqzyTgiGOM7OPA96rLxqW65j3aXzPTApNv7qu7J3E7lNduDPjZ8zMxOOZ+9x0Rw/kkfNBNKERUE+Ij6Iup4JI+Zqpe3BO/yKyLu0Fxdao9uusFzLFwIRQC+IeW877OYUn5+efS18U8SB5pLl5dAfgvJeo9rSkBr5P1v5WRYuePeIPQeHDNA9YYxGDKMhfolHYcAaFxEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR0zrRfRqZMG/CxaaxC3FgjYMIuxs/1ZJV5X+hz/AcU=;
 b=oirNaDgiY7hzZMtqLrDrmXAwePF21bqV7bAIZcsk9hPWPUWBZmgrLO4ObrcTg6KIWyIHLUbQaxReRx0+02WbPvVlaBu1w7vE9CUUfmuGpe3gWKOmihPYsgelskb6wKa8lpOIroERiAY8NOO7klgp9YKTZLHv9/7tt5a0ixdyrlw=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.29; Fri, 10 Jul 2020 08:39:10 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 08:39:09 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Subject: RE: [PATCH v2] drm/amdgpu: fix system hang issue during GPU reset
Thread-Topic: [PATCH v2] drm/amdgpu: fix system hang issue during GPU reset
Thread-Index: AQHWVPw2uPUSRy+wOEGvOPUoL/1b2qj9j74AgALs6YA=
Date: Fri, 10 Jul 2020 08:39:09 +0000
Message-ID: <DM5PR12MB2533EF1CF7F4AC2D83DCC2DDED650@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200708074800.10093-1-Dennis.Li@amd.com>
 <b398cbc4-7dfa-c5de-e806-492e08f2da37@molgen.mpg.de>
In-Reply-To: <b398cbc4-7dfa-c5de-e806-492e08f2da37@molgen.mpg.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-10T08:39:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6bee5124-d5c1-457a-9ee9-312250961ad7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8007c1fb-63f4-4438-d986-08d824acb729
x-ms-traffictypediagnostic: DM6PR12MB3564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35644547964E6EE927E1B02BED650@DM6PR12MB3564.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 046060344D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA8VNJCA2FQNqjDRLOjUyGi3x2XFQZUp+7ODcr09ocfTyClj1RA8JvZWtJi70fxqMtVzHXmOWpOZ6tp+IsiGPdu0RvZkkKSf5fbtfVw7te4mM4gu6/UZ7lufm82mt3IvWGVId4UH+O4t3Ski+4r3LEJaku1YruZWd3jFaS9oU2Ys6kP2lVq61sxA3iNvQM4FHx+weol+Cs4uRZ7OPzov2uKelUqHa01jUtMnKuMmdyNLOsywN14jir8edscDrgnbHkeZ/ZT5oyousLspLXBVfKJKNewY3+oh/pWET3X83em6BAvvMq2UiDFm5j4Vu7TDJzRli0OKGZ2r68LlagrFwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(66476007)(5660300002)(6506007)(478600001)(26005)(186003)(55016002)(8936002)(9686003)(8676002)(7696005)(52536014)(33656002)(86362001)(76116006)(71200400001)(66946007)(83380400001)(66556008)(316002)(53546011)(54906003)(4326008)(66446008)(64756008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Q03MXfOqEUuRqqZDHKz0HaDiPeTsZIbODtKcOYl8tUCiUmMCfG5gMltbi7JSpDM+ZnCrHfEJziCnujnVJ4f5TjVp4p/kph/KSBxCawZ8GcU+kRAaZdmUt05wCb1+LJntbmvaGmT7yZFshteDgCvLNoVt9naL5fhm9ANuqg/RsuetmN/bKA621/GqvUEbh69anV9+JeJRyRP1yJG9kdQJ+wCYAMPreRxRgALpzG5HKN55yz6lzDWF0rVEYOm3DuK6NgNzw+NBMwDfMqmbQ7l9zqK2IymtLotbtYtGQHjDci536E5nSZntqg3G8K7We2kZlUk/l88F3eW32VhwDV4nB1AriHt4oXPM35cZoZfGAkyRHiEvWQq9jJhlOrx7AmW7DqtC1o9UeE6v0qT2Ur/HC9zZjiUWSvxDYNq2DjSaGNyWjgdGmP9eVV1ZmLo0Q0JvZ+lagugFCGMb5I23PuvAZ3HiFm+uxoSCtwPbEj3HjFK1Ub5J1rWT1/KUd2myzG9n
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8007c1fb-63f4-4438-d986-08d824acb729
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 08:39:09.7863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85szc1/asPtX2iPyDKC8ir5gOIbixCyg3jVzeo2SHY+bh9M7/qkdPS79wHUfMLmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgUGF1bCwNCiAgICAgIEkgdXNlZCBvdXIgaW50ZXJuYWwgdG9vbCB0byBtYWtlIEdQVSBoYW5n
IGFuZCBkbyBzdHJlc3MgdGVzdC4gSW4ga2VybmVsLCB3aGVuIEdQVSBoYW5nLCBkcml2ZXIgaGFz
IG11bHRpLXBhdGhzIHRvIGVudGVyIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIsIHRoZSAgYXRv
bWljICBhZGV2LT5pbl9ncHVfcmVzZXQgaXMgdXNlZCB0byBhdm9pZCByZS1lbnRlcmluZyBHUFUg
cmVjb3ZlcnkuIER1cmluZyBHUFUgcmVzZXQgYW5kIHJlc3VtZSwgaXQgaXMgdW5zYWZlIHRoYXQg
b3RoZXIgdGhyZWFkcyBhY2Nlc3MgR1BVLCB3aGljaCBtYXliZSBjYXVzZSBHUFUgcmVzZXQgZmFp
bGVkLiBUaGVyZWZvcmUgdGhlIG5ldyByd19zZW1hcGhvcmUgIGFkZXYtPnJlc2V0X3NlbSBpcyBp
bnRyb2R1Y2VkLCB3aGljaCBwcm90ZWN0IEdQVSBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IGV4dGVy
bmFsIHRocmVhZHMgd2hlbiBkb2luZyByZWNvdmVyeS4NCg0KQmVzdCBSZWdhcmRzDQpEZW5uaXMg
TGkNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bCthbWQtZ2Z4QG1vbGdlbi5tcGcuZGU+IA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDgsIDIwMjAg
Nzo0MiBQTQ0KVG86IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IGZpeCBzeXN0ZW0gaGFuZyBpc3N1ZSBk
dXJpbmcgR1BVIHJlc2V0DQoNCkRlYXIgRGVubmlzLA0KDQoNClRoYW5rIHlvdSBmb3IgeW91IHBh
dGNoLg0KDQpPbiAyMDIwLTA3LTA4IDA5OjQ4LCBEZW5uaXMgTGkgd3JvdGU6DQo+IER1cmluZyBH
UFUgcmVzZXQsIGRyaXZlciBzaG91bGQgaG9sZCBvbiBhbGwgZXh0ZXJuYWwgYWNjZXNzIHRvDQo+
IEdQVSwgb3RoZXJ3aXNlIHBzcCB3aWxsIHJhbmRvbWx5IGZhaWwgdG8gZG8gcG9zdCwgYW5kIHRo
ZW4gY2F1c2UNCj4gc3lzdGVtIGhhbmcuDQoNCk1heWJlIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3Nh
Z2Ugc3VtbWFyeSB0byByZWFkOg0KDQo+IEF2b2lkIGV4dGVybmFsIEdQVSBhY2Nlc3Mgb24gR1BV
IHJlc2V0IHRvIGZpeCBzeXN0ZW0gaGFuZw0KDQpBcyBJIGFtIGFsc28gZXhwZXJpZW5jaW5nIHN5
c3RlbSBoYW5ncywgaXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2ZSBtb3JlDQpkZXRhaWxzLiBXaGF0
IHN5c3RlbXMgYXJlIGFmZmVjdGVkPyBXaGF0IFBTUCBmaXJtd2FyZSB2ZXJzaW9uPyBXaWxsIHRo
ZQ0KUFNQIGZpcm13YXJlIGJlIGZpeGVkLCBvciBpcyB0aGUgTGludXggZHJpdmVyIHZpb2xhdGlu
ZyB0aGUgQVBJLg0KDQpIb3cgY2FuIHRoZSBoYW5nIGJlIHJlcHJvZHVjZWQ/DQoNCkxhc3RseSwg
cGxlYXNlIGV4cGxhaW4geW91ciBjaGFuZ2VzPyBXaHkgZG9lcyBgYXRvbWljX3JlYWQoKWAgaGVs
cCBmb3INCmV4YW1wbGU/DQoNCj4gdjI6DQo+IDEuIGFkZCByd2xvY2sgZm9yIHNvbWUgaW9jdGxz
LCBkZWJ1Z2ZzIGFuZCBmaWxlLWNsb3NlIGZ1bmN0aW9uLg0KPiAyLiBjaGFuZ2UgdG8gdXNlIGRx
bS0+aXNfcmVzZXR0aW5nIGFuZCBkcW1fbG9jayBmb3IgcHJvdGVjdGlvbiBpbiBrZmQNCj4gZHJp
dmVyLg0KPiAzLiByZW1vdmUgdHJ5X2xvY2sgYW5kIGNoYW5nZSBhZGV2LT5pbl9ncHVfcmVzZXQg
YXMgYXRvbWljLCB0byBhdm9pZA0KPiByZS1lbnRlciBHUFUgcmVjb3ZlcnkgZm9yIHRoZSBzYW1l
IEdQVSBoYW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1k
LmNvbT4NCj4gQ2hhbmdlLUlkOiBJN2Y3N2E3Mjc5NTQ2MjU4N2VkN2Q1ZjUxZmU1M2E1OTRhMGYx
ZjcwOA0KDQpb4oCmXQ0KDQoNCktpbmQgcmVnYXJkcywNCg0KUGF1bA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
