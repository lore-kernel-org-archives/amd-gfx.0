Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1BF206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oyRfLdQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1BF206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134BC6E027;
	Fri, 22 May 2020 08:51:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCBC6E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsl6WFHd02ScOEzjWV60mAW1NTWfLwXiPbuie/igHP2gnRlvW+sjOstL6sR6nvCPBu4Xgy8UFTFHKpYC9wFE1qT/+dEewCwjXsP35HkbdHrS7dM0sGfNxBSCC3CmUbvIg5RRwqollJQ/N2F3GBGyjI2fdSfxvNkcNXZkf4/ZdfQgS5b6OeS++ax2LcLSKMknbCtDefp0qMstNLiZWzdqp20Czr/zSFSUPfQHeD8WziK6T5WnJwVygwuOA78/w9PXLYxXl+EKJ/9tIre8RgIkTdBvFsd5UaCbEEzaWsXDqjrQLVbUNZi8xf5MldiJcUf9YtlPODrKhRu0y1/D5KH51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLH0luOMVqQcW+os/AKUq7vLpYVYGw+SSfM5ySxBYoI=;
 b=aBUnk8Ic9w6vn63C56ha9syrAfcfokXIxi0yT0J95J/GaGBncvIxuZ845WaDXHd8KRnSrmbiwdRsOBmMi1zkaYMbcMNwhYEwzShr/Hmaa7N1oWUBHJz98+6xJ9zv3RQ+p9rj78bqmIz10ii2oRrxYpN/oCL7abbbfssKAPzizjM720qgVrxtSpmvo9lOfhElW6ydxCq5Or2Rd+KK4wg4F1W4NU0cuDydwGMPcJ+SRTVnweAeZDTBilznaklcGDx2IFPjNVclkJIMVHzGaoHHzkuNA91jwpazLzRkYXL+G//6KwGwxaaXHy9tjldYxIMjk9bKxLQ0frjckA+vlVja5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLH0luOMVqQcW+os/AKUq7vLpYVYGw+SSfM5ySxBYoI=;
 b=oyRfLdQsTLvZtyq5zk9dEUPeEz0vUx54UKeyMGk2hInskjodSYThJSARLeGn/v4mkeg0rvDWLrcvoa02J+kncmdavlQzbQoYFjGvPInQLqKwhzp9DS6ftybWLPAS8bT7sNi5Y7PwOu0BOmv/EZuZzfckuaRYYphMJHOX+NyX+sc=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (20.179.93.88) by
 BYAPR12MB2919.namprd12.prod.outlook.com (20.179.90.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.26; Fri, 22 May 2020 08:51:03 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::71b7:6da7:6272:5cc6%3]) with mapi id 15.20.3000.034; Fri, 22 May 2020
 08:51:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Topic: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Index: AQHWMA4UxYv6BkEbv0Gnlumf7FR0Uqizv3awgAAG/wCAAAK8AA==
Date: Fri, 22 May 2020 08:51:03 +0000
Message-ID: <BYAPR12MB2888EC9BD9FBADABDDAEE5C1B0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200522075304.22231-1-guchun.chen@amd.com>
 <BYAPR12MB2888E86B6A5017E5D55A5DFAB0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
 <CY4PR12MB1287F8AC265664C6227826C6F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287F8AC265664C6227826C6F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T08:23:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1a5bba39-b210-47a7-a48b-0000c15207cf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T08:50:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: aebf745b-bda0-4420-ae4d-00009fb489e3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.232.44.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 695d0072-335b-4868-b46f-08d7fe2d423d
x-ms-traffictypediagnostic: BYAPR12MB2919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29197076DEF8D0D30BA1145EB0B40@BYAPR12MB2919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ezDjBdSIuzs++4OoZfrSwNhBqZYvfTwwERIFXlLTdLDcUV9+KgDvc8fCRqwLDC7HkMX0nEajoMswc3498m78RH08h2MBsLwn/BVf2IYqjN2DGm0na7hpz7i11b6gvHs+kXNVThcf/pWroXqpDTbRuisUy/bIkeUurM8OaS+jTrQ2f5dqMXmSClf7dja+ODHu8CxuwV6AAf7gn4t+1SRl4AkKmaLKaw1SSpTqqw/+mafQqv3htJCqyfc7vJQZAYqYEVi95gnxT7Lf3B6Ejki04wYrikHHBhxjpl6h9dfXJWyUoGZ4KKtUcYV2aapdtQJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(86362001)(52536014)(6506007)(53546011)(66476007)(64756008)(66446008)(55016002)(66946007)(2906002)(7696005)(6636002)(186003)(9686003)(76116006)(26005)(8676002)(33656002)(71200400001)(110136005)(8936002)(66556008)(478600001)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iXF73nq8MI6PvDaHRKXn8p1yk0Wb45OgG2wivYqB5HWi0UyyZZy+gHPXOJ6WJu6PImKkNOdkGRU+HBsebYfYbSqIf6XHxpgcuHFsq1lfbr/LYvTIXSPB6KHe938hv+MZvkbMy45jRvBStYzlU7uBQjvpYskDk5DGLbH5QoAxNJ0NZ2sVUQ2ymWIcqu5xzk3Xxs1tzPfHScsQt4MG9kWRYLcR8C5KjpubgU4tEB3exiYDjol2Va0ZXzzbPMYcyPRz7gfgxNdNSyX7XrmDaTfC5KUEyKArETjMCG8p5xx70oR70HKIDBZFDOsvDPGr9FogihzvOeWGvEbOLxqPVDJFphbD1Z9PEstkn7Mom1sY53rQ6cpeP0qEmwIZxHvPlvYLwy9naMihEzse7hgB5lgR/x8ASP0nWGDW9kp6uSKWYfpiuz4r4B3OPXO8n9HzXlAxuOaO6/oYTC+cXOtLv9OZ7meBDV5Ei9LraRMlaF/nqyI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695d0072-335b-4868-b46f-08d7fe2d423d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 08:51:03.2529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrblSF76wTO2kM7dLstdGeGEGYvp26WcN47BX24B8nVNFt5ljrHmKYZYG8ly8alo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpPSywgYnV0IEkgc3RpbGwgc3VnZ2VzdCBhZGRpbmcgIlJBUyIg
aW4gdGhlIHByaW50IHRvIGluZGljYXRlIGl0cyBtb2R1bGUsIHdpdGggdGhpcyBhZGRyZXNzZWQg
dGhlIHBhdGNoIGlzOg0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29t
Pg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIEd1Y2h1biA8
R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogMjAyMMTqNdTCMjLI1SAxNjozMQ0KPiBUbzog
WmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsNCj4gWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IENsZW1lbnRz
LCBKb2huDQo+IDxKb2huLkNsZW1lbnRzQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlA
YW1kLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcHJpbnQgd2Fybmlu
ZyB3aGVuIGlucHV0IGFkZHJlc3MgaXMNCj4gaW52YWxpZA0KPiANCj4gW0FNRCBQdWJsaWMgVXNl
XQ0KPiANCj4gSGkgVGFvLA0KPiANCj4gUGxlYXNlIHNlZSBteSByZXNwb25zZSBpbmxpbmUuDQo+
IA0KPiBSZWdhcmRzLA0KPiBHdWNodW4NCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXks
IE1heSAyMiwgMjAyMCA0OjExIFBNDQo+IFRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFt
ZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ow0KPiBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50
c0BhbWQuY29tPjsgTGksIERlbm5pcw0KPiA8RGVubmlzLkxpQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IHByaW50IHdhcm5pbmcgd2hlbiBpbnB1dCBhZGRyZXNz
IGlzDQo+IGludmFsaWQNCj4gDQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0NCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gPiBT
ZW50OiAyMDIwxOo11MIyMsjVIDE1OjUzDQo+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBaaGFuZywgSGF3a2luZw0KPiA+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91
MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47DQo+IENsZW1lbnRzLA0KPiA+IEpvaG4gPEpvaG4u
Q2xlbWVudHNAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPg0KPiA+IENj
OiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBwcmludCB3YXJuaW5nIHdoZW4gaW5wdXQgYWRkcmVzcyBpcw0KPiA+IGlu
dmFsaWQNCj4gPg0KPiA+IFRoaXMgd2lsbCBhc3Npc3QgZGVidWcuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMiArKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBpbmRleCA2ZTkxMWNhOTcwMzguLjVjNzNmNDQ0
ZWFlZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMN
Cj4gPiBAQCAtMzE4LDYgKzMxOCw4IEBAIHN0YXRpYyBzc2l6ZV90DQo+ID4gYW1kZ3B1X3Jhc19k
ZWJ1Z2ZzX2N0cmxfd3JpdGUoc3RydWN0DQo+ID4gZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIg
Kg0KPiA+ICAJY2FzZSAyOg0KPiA+ICAJCWlmICgoZGF0YS5pbmplY3QuYWRkcmVzcyA+PSBhZGV2
LT5nbWMubWNfdnJhbV9zaXplKSB8fA0KPiA+ICAJCSAgICAoZGF0YS5pbmplY3QuYWRkcmVzcyA+
PSBSQVNfVU1DX0lOSkVDVF9BRERSX0xJTUlUKSkgew0KPiA+ICsJCQlkZXZfd2FybihhZGV2LT5k
ZXYsICJJbnB1dCBhZGRyZXNzIDB4JWxseCBpcw0KPiA+IGludmFsaWQuIiwNCj4gPiArCQkJCQlk
YXRhLmluamVjdC5hZGRyZXNzKTsNCj4gDQo+IFtUYW9dIEhvdyBhYm91dCB0aGlzIHdheToNCj4g
ZGV2X3dhcm4oYWRldi0+ZGV2LCAiUkFTIGluamVjdGlvbiBhZGRyZXNzIDB4JWxseCBleGNlZWRz
IGxpbWl0IDB4JWxseC4iLA0KPiAJCQkJZGF0YS5pbmplY3QuYWRkcmVzcywNCj4gUkFTX1VNQ19J
TkpFQ1RfQUREUl9MSU1JVCk7IFtHdWNodW5dVGhlcmUgYXJlIHR3byBjYXNlcyBmb3IgaW52YWxp
ZA0KPiBpbnB1dCBhZGRyZXNzLCBvbmUgaXMgbGltaXRlZCBieSBib2FyZCB2cmFtIHNpemUsIGFu
ZCBvbmUgaXMgYnkNCj4gUkFTX1VNQ19JTkpFQ1RfQUREUl9MSU1JVC4NCj4gU28gaXQncyBub3Qg
bmVjZXNzYXJ5IHRvIGRpc3Rpbmd1aXNoIGhlcmUsIGp1c3QgcHJpbnQgd2FybmluZyB0byBsZXQg
dXNlciBrbm93cw0KPiB0aGUgaW5wdXQgYWRkcmVzcyBpcyBub3QgY29ycmVjdCwgYW5kIHRoaXMg
ZXJyb3IgaW5qZWN0aW9uIGlzIGJsb2NrZWQuDQo+IA0KPiA+ICAJCQlyZXQgPSAtRUlOVkFMOw0K
PiA+ICAJCQlicmVhazsNCj4gPiAgCQl9DQo+ID4gLS0NCj4gPiAyLjE3LjENCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
