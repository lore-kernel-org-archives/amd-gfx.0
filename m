Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F44C11D04
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD01208C4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JOPO2CHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD01208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC866ED81;
	Thu, 20 Feb 2020 13:28:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F396ED80
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 13:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlDDb8iMqIqYFuz1GP7DIFR28gFpNl6JWpQdKGxmoHFi/u7QvnXhY1D/OhFldottxDk23OsgRWA6apHcrGo5E64g9kahwFqzXbwwI7czTnEn2fsA996sqhW2QGuFIPiLXLM8KGL1ohmcYDBS4X0UYa31sVaz5McrhcYnq+vcOZPrl0OcJOYuVrVg3olW8j1YNcETYuTH9h2kbwONVNf6AyHty0An5uYunz4r/e3nJBzddv1yJ5eTw9FkgXMhuFhONJDUZVJM/s8n4CPUl9+OhA442+UrY9eYRzF55cAmwvHxphPvhPDOcbEP6EcI3CLVAfb0XOlKdJciA2WoHmM1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aVW945+bmdG+oCgzjVt1siZ44HHM6kMDOQRcvrofr4=;
 b=YIXEzHAiJCl4tUae5xCFFMfhIb4Q/PvxU0re/T5yvE94QBkIEZcnNTTFePNZVSSeTTc+leaNRikvdkcuUJxWcHnU6ApwQxZeTkIAr+w0xaTFkAh6KxQiwLQEK1gEDqgtUrK5VTAHy4rlrOsxCq3RhhzkHmAl4hqBmaB+CiCu37i0AsTfHNW8SxxMqrQsIUOqosocCFmqDBQ0nfmJX65TXyfJUXGEW0eX+BwAdT3nXq5qVz5sOPuQ5qjiOwy0vrcxF4xuWCHsHZ50mHM+SYmKiPE9eYwyY9UtYdDbQ7C2of8N7XwW2mAaQjKeo655CCw5GtlSknR5fC+70UCHf+zbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aVW945+bmdG+oCgzjVt1siZ44HHM6kMDOQRcvrofr4=;
 b=JOPO2CHInNcObvouYDl8hrmxFuT65xx7SRyxAvCjl+vFiqsBGQ88rYq6VNjpWlFCvaAHsHDOUZgnfcgQC3drKdChSbWhEnqItMjVqb3cof0URM8CCXY2HcL5obWS7wJVp8Td7UgvPyTA/BKHqLLX1UsGYd/vy1I3CRuqoiIRedM=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (10.255.174.140) by
 DM6PR12MB3753.namprd12.prod.outlook.com (10.255.173.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 13:28:04 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 13:28:04 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBv?=
 =?utf-8?Q?inter_dereference?=
Thread-Topic: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Thread-Index: AQHV5tpejmUZxmzr8E+/dIkRGLqWv6giDTkAgABJr4CAAArysIABY3CAgABGJdA=
Date: Thu, 20 Feb 2020 13:28:03 +0000
Message-ID: <DM6PR12MB39317635C3FB63265B9216D084130@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <20200219040445.11112-1-Dennis.Li@amd.com>
 <DM5PR12MB1418062D884DBE08E1FB9997FC100@DM5PR12MB1418.namprd12.prod.outlook.com>
 <e7ea478f-95ff-69c6-e81e-709b44904209@gmail.com>
 <DM6PR12MB393104A6C93ED039BAA5ED1C84100@DM6PR12MB3931.namprd12.prod.outlook.com>
 <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3167C68A5B6AF0E97613A6A4ED130@MN2PR12MB3167.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T08:41:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=07d59223-3cd1-4cdc-9e57-0000c5aac1ea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b381969f-7645-4267-e279-08d7b608b731
x-ms-traffictypediagnostic: DM6PR12MB3753:|DM6PR12MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37534763737787D910A4692D84130@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(66556008)(66476007)(64756008)(81166006)(6506007)(76116006)(6636002)(81156014)(53546011)(86362001)(66946007)(66446008)(52536014)(33656002)(2906002)(8936002)(186003)(966005)(26005)(7696005)(224303003)(45080400002)(55016002)(478600001)(316002)(5660300002)(9686003)(110136005)(71200400001)(921003)(21314003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3753;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DWajKLPJIbJ92tP7dRrU4nNFvJpuSpn3F7H40WgcwhhmdEN2HlwysvC99TSzsHeUIG01giSdGRvib7zW3Xa3qopQsWaRQXHNQaufa2M+ufPgqxVyqthDvIO9fUJPZNUHoLTp4wsJlwk7b8VY+m0S6mBQwMop91u+OxvySP1/0fRdvrfH81Z89X3h937D3k/xpy5JMw+sy/iKo92KSoqh9FipwX2x0DcALOwWQLgOsJGbf/1wof1IwbzDIVOMK80D2eCB3clUYBua/4XiwBEMUhP2+ZLLFXQb0ml/f4aCSDat7iI3sI6HyiuQ7jXtCpxVL7GWB0XRppit8XbrrvdgEoJcDLB6GfSLzl8UuPF48PiyvckqCz3SoMo+jncgLNScLAUoXtvvaKHTjIu4dWI5TkWiqLLY42cpR+SBK5XgZHxCJ2SKiZ8fmW8jFZ07ELkZQFSGHs9qC1UShPHvIUnQ4tZ4BzNvZJegxRLYvJdq0re8XM1NathEQ8v/iFvlpM4CE78ANZ2JR312HfOZhwuNn7cDzg4yFxCLv+kpRfC3ON+SgHnC64nErrD/EY26kHSY0P3C6vomPqOboQ6f7A2N3k7cCALarEvuT0LWb+C3qJaU1VBMHHzOUPmEgspWv7sct/RlFChXo2jLLe9SaOJn8BHjbr502oM11dayEFOxxV79AVBAa2VGto32OXj9Fb2orwcwSaz38vJQBxxPdLmLw==
x-ms-exchange-antispam-messagedata: jvsiSBeLmeNeJc5vWxaEZhXHa/fhhlvz45xm0Qg652aqqhAk7UFAqX8/ZzR1kojE/U054BNjN724xoyhpYS5OzKAvzyxtuIYcCDb02NLvCklh8tA+RtuO0CW9zlKRj3KEiiyAOPzCpubydWv3tZ6AA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b381969f-7645-4267-e279-08d7b608b731
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 13:28:04.0151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRFYdiOIo/r3MKv3QVO2SYh4A+jVOhLtSSBQ8JmW0v1Fmzim3Pk/vWVG241wljRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

c28gdGhlIHNjZW5hcmlvIGlzOg0KS01EIGRvaW5nIHBhZ2UgdXBkYXRlIC0+IEVDQyAtPiBiYWNv
IHJlc2V0IChtdXRlIFNETUEgc2NoZWR1bGVyKSAtPiBkcm1fc2NoZWRfZW50aXR5X2dldF9mcmVl
X3NjaGVkKCkgcmV0dXJuIE5VTEwgLT4geW91IGdldCB5b3VyIE5VTEwgcG9pbnRlcg0KDQpBbmQg
eW91ciBhcHByb2FjaCBpcyB0byBpbnRyb2R1Y2UgYSBiYWlsIG91dCBpbiB0aGUgYW1kZ3B1X3Zt
X3NkbWFfY29tbWl0KCkgc28gdGhlIG9yaWdpbmFsIGFtZGdwdSB2bSB1cGRhdGUgam9icyB3aWxs
IGJlIGRyb3BwZWQsDQoNClRoYXQgcmVhbGx5IGNhbiBmaXggeW91ciBOVUxMIHBvaW50ZXIgaXNz
dWUsIGJ1dCBhY3R1YWxseSBicmluZyBhbm90aGVyIGlzc3VlOiB5b3UgZGlkbid0IGZpbmlzaCB0
aGUgdm0gdXBkYXRlIHdvcmsgIQ0KDQpteSBpbml0aWFsIGlkZWEgaXMgeW91IGRvIHNvbWV0aGlu
ZyBsaWtlOg0KDQpzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX2NvbW1pdChzdHJ1Y3QgYW1kZ3B1
X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsDQoNCgkuLi4NCg0KCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gcC0+YWRldjsNCgl3aGlsZSAoIW11dGV4X3RyeWxvY2soJmFkZXYtPmxvY2tfcmVzZXQp
KSAvL21lYW5zIEdQVSBpcyB1bmRlciByZWNvdmVyaW5nIAkNCgkJbXNsZWVwKHh4eCk7DQoNCgku
Li4uDQoNCgltdXRleF91bmxvY2soJmFkZXYtPmxvY2tfcmVzZXQpOyAvL3RoaXMgcHV0IGF0IHRo
ZSBlbmQgb2YgdGhpcyByb3V0aW5lDQp9DQoNCg0KdGhhdCBkbyBtYWtlIG91ciBpbXBsZW1lbnQg
bW9yZSBjb21wbGljYXRlZCwgYnV0IGF0IGxlYXN0IGl0IGRvZXNuJ3QgZHJvcCB0aGUgbmVjZXNz
YXJ5IHZtIHVwZGF0ZSwgb3RoZXJ3aXNlIHlvdSB3aWxsIHJ1biBpbnRvIG90aGVyIHByb2JsZW1z
IC4uLg0KDQpAS29lbmlnLCBDaHJpc3RpYW4gZG8geW91IGhhdmUgYW5vdGhlciBzb2x1dGlvbiA/
DQoNClRoYW5rcyANCgkNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBMaSwg
RGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQy5pyIMjDm
l6UgMTY6NDENCuaUtuS7tuS6ujogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhvdTEsIFRhbyA8
VGFvLlpob3UxQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQrk
uLvpopg6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBhIGJ1ZyBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlv
biBPbmx5XQ0KDQpIaSwgQ2hyaXN0aWFuIGFuZCBNb25rLA0KICAgICAgV2hlbiBkb2luZyBTRE1B
IGNvcHksIGEgUkFTIHVuY29ycmVjdGFibGUgZXJyb3IgaGFwcGVucywgd2hpY2ggd2lsbCBjYXVz
ZSB0aGlzIGlzc3VlLiAgVGhlIFJBUyB1bmNvcnJlY3RhYmxlIGVycm9yIGV2ZW50IHdpbGwgdHJp
Z2dlciBkcml2ZXIgdG8gZG8gQkFDTyByZXNldCB3aGljaCB3aWxsIHNldCB0aGUgc3RhdHVzIG9m
IFNETUEgc2NoZWR1bGVyIHRvIG5vIHJlYWR5LiBBbmQgdGhlbiBkcm1fc2NoZWRfZW50aXR5X2dl
dF9mcmVlX3NjaGVkIHdpbGwgcmV0dXJuIE5VTEwgaW4gZHJtX3NjaGVkX2VudGl0eV9zZWxlY3Rf
cnEsIHdoaWNoIGNhdXNlIGVudGl0eS0+cnEgdG8gTlVMTC4gDQoNCkJlc3QgUmVnYXJkcw0KRGVu
bmlzIExpDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBNb25rIDxNb25r
LkxpdUBhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxOSwgMjAyMCA3OjMwIFBN
DQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpoYW5n
LCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1k
LmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NClN1YmplY3Q6IOWbnuWk
jTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
DQoNCj4gKwlpZiAoIWVudGl0eS0+cnEpDQo+ICsJCXJldHVybiAwOw0KPiArDQoNClllcywgc3Vw
cG9zZWRseSB3ZSBzaG91bGRuJ3QgZ2V0ICdlbnRpdHktPnJxID09IE5VTEwnIGNhc2UgLCB0aGF0
IGxvb2tzIHRoZSB0cnVlIGJ1ZyANCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiDku6Pooagg
Q2hyaXN0aWFuIEs/bmlnDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQy5pyIMTnml6UgMTg6NTANCuaU
tuS7tuS6ujogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpLCBEZW5u
aXMgPERlbm5pcy5MaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpob3UxLCBUYW8g
PFRhby5aaG91MUBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0K
5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYSBidWcgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlDQoNCldlbGwgb2YgaGFuZCB0aGlzIHBhdGNoIGxvb2tzIGxpa2UgYSBjbGVhciBO
QUsgdG8gbWUuDQoNClJldHVybmluZyB3aXRob3V0IHJhaXNpbmcgYW4gZXJyb3IgaXMgY2VydGFp
bmx5IHRoZSB3cm9uZyB0aGluZyB0byBkbyBoZXJlIGJlY2F1c2Ugd2UganVzdCBkcm9wIHRoZSBu
ZWNlc3NhcnkgcGFnZSB0YWJsZSB1cGRhdGVzLg0KDQpIb3cgZG9lcyB0aGUgZW50aXR5LT5ycSBl
bmRzIHVwIGFzIE5VTEwgaW4gdGhlIGZpcnN0IHBsYWNlPw0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFu
Lg0KDQpBbSAxOS4wMi4yMCB1bSAwNzoyNiBzY2hyaWViIFpoYW5nLCBIYXdraW5nOg0KPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IFJl
dmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+DQo+IFJl
Z2FyZHMsDQo+IEhhd2tpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
RGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFy
eSAxOSwgMjAyMCAxMjowNQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlciANCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFpoYW5nLCANCj4gSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBDYzogTGks
IERlbm5pcyA8RGVubmlzLkxpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogZml4IGEgYnVnIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPg0KPiBjaGVjayB3aGV0aGVy
IHRoZSBxdWV1ZSBvZiBlbnRpdHkgaXMgbnVsbCB0byBhdm9pZCBudWxsIHBvaW50ZXIgZGVyZWZl
cmVuY2UuDQo+DQo+IENoYW5nZS1JZDogSTA4ZDU2Nzc0MDEyY2YyMjliYTJmZTdhMDExYzEzNTll
OGQxZTI3ODENCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4N
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9z
ZG1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+
IGluZGV4IDRjYzc4ODFmNDM4Yy4uNjdjY2E0NjNkZGNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMNCj4gQEAgLTk1LDYgKzk1LDkgQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFy
YW1zICpwLA0KPiAgIAlpbnQgcjsNCj4gICANCj4gICAJZW50aXR5ID0gcC0+ZGlyZWN0ID8gJnAt
PnZtLT5kaXJlY3QgOiAmcC0+dm0tPmRlbGF5ZWQ7DQo+ICsJaWYgKCFlbnRpdHktPnJxKQ0KPiAr
CQlyZXR1cm4gMDsNCj4gKw0KPiAgIAlyaW5nID0gY29udGFpbmVyX29mKGVudGl0eS0+cnEtPnNj
aGVkLCBzdHJ1Y3QgYW1kZ3B1X3JpbmcsIHNjaGVkKTsNCj4gICANCj4gICAJV0FSTl9PTihpYi0+
bGVuZ3RoX2R3ID09IDApOw0KPiAtLQ0KPiAyLjE3LjENCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdA0KPiBzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3
Q21vDQo+IG5rLmxpdSU0MGFtZC5jb20lN0MyOGU3MjYwYWYzYTI0ZWVjNzU4ZjA4ZDdiNTI5NzVl
MyU3QzNkZDg5NjFmZTQ4ODRlNjANCj4gOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc3
MDYyMDAzMjEzNDMxJmFtcDtzZGF0YT12TVhtaHdUbE44bEFhdg0KPiB1cWhZaHBtS0xNNlYlMkYl
MkIyJTJGdWJGQmJzayUyQkdZJTJCanclM0QmYW1wO3Jlc2VydmVkPTANCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0
DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdD
bW9uay5saXUlNDBhbWQuY29tJTdDMjhlNzI2MGFmM2EyNGVlYzc1OGYwOGQ3YjUyOTc1ZTMlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc3MDYyMDAzMjEz
NDMxJmFtcDtzZGF0YT12TVhtaHdUbE44bEFhdnVxaFlocG1LTE02ViUyRiUyQjIlMkZ1YkZCYnNr
JTJCR1klMkJqdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
