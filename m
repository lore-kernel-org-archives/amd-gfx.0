Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A61C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714B32073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1zFnP5Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714B32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4430C89EAC;
	Thu,  5 Mar 2020 13:39:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346E189EAC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joZsBiKERjKLe6iQNTvnY3+HSYkyMoQ7ziYnfqG6sNIsvZGcRH2IJGUXCz9GOINxRy8V0jmbIYPJEqXYXMsV9pDs/ka/M5oalLLmmOil7aDUatmg6+vRKsJGvRg0YjCjxIIEljGVziKS3F3a5Fu9AHd6nR7XCYoZyzszrBVFlUJtAZjEjzF3396AjxCrW0Qtd1uAO+YdzjFWYXe5BW9yGrqm/u+Rt+fkbqmP1M6SpA3k95hpKQ6LJxufGIFEBGdRgfS3dzKF/AyFhSrhs5bpArwETLzxKIC0hyKJBj7A5VlwIIb0qDjl5EHO1Dt/R30XFRgbLJd0A7MTJE8MmIABVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIlbXkz9r33QdNIpnUNsFZB0IRxVr9XOzb5RF05lbHo=;
 b=BWJs5IVmb9k7XVrmgQz8UpDnrKPbY/sp50nyOHFcQho4eJxA5kQzREX1QW9+BqsOAHW0eqnCbsUN2siFmtkrfCoOjgQvaj0/dewO4nUPsxB3MY4YoTCmUXDRiiNqAR2IWdxedQoZo5zI/77rJppUdddN28k5bde8daMWXPs9Zvihm+Mk5wFN2llf2E98gQZoGvXI98a9audWZlswzaTaS3iKYvRZxFFnInIP2DTj7oIw/4PfHxen/6SejJwKylSn8abp+73bSGl47DHDxr/HsF3iVv/LyHA1pZtpC9f67Wv4f/5xQqj3zXytV0AO5uw+cmo494FRpTVuEaJytAePOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIlbXkz9r33QdNIpnUNsFZB0IRxVr9XOzb5RF05lbHo=;
 b=1zFnP5Rgnp7ybo+4BMIBmNwZeNvOC5fDUVT+EoJQIDoL4jAoUhEK4qY2EiErPBkT/yPDekebaowV/iY6L7+T6de2kSXUonTu+Aqj/elmVpyC+LCw0B72hLFyMCMDkn2L+KsnOBCiC7/2hi111LEwu3neHkH8crJ63hPeMcUUPww=
Received: from DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 5 Mar
 2020 13:39:07 +0000
Received: from DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3]) by DM6PR12MB3931.namprd12.prod.outlook.com
 ([fe80::c51d:4e6b:f0f1:b7a3%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 13:39:06 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [enable VCN2.0 for NV12 SRIOV 2/6] drm/amdgpu: disable jpeg block
 for SRIOV
Thread-Topic: [enable VCN2.0 for NV12 SRIOV 2/6] drm/amdgpu: disable jpeg
 block for SRIOV
Thread-Index: AQHV8vKlExVKHzDU60SHkxbu2XRac6g6AKQAgAAASDA=
Date: Thu, 5 Mar 2020 13:39:06 +0000
Message-ID: <DM6PR12MB3931DC79623D336FE09770BE84E20@DM6PR12MB3931.namprd12.prod.outlook.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-2-git-send-email-Monk.Liu@amd.com>
 <32d7916b-c783-4762-b1ad-5627011ba6b4@gmail.com>
In-Reply-To: <32d7916b-c783-4762-b1ad-5627011ba6b4@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85d54c04-a092-4583-c6a7-08d7c10a93cd
x-ms-traffictypediagnostic: DM6PR12MB3081:|DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB308102743C7104022509710E84E20@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(199004)(189003)(64756008)(6506007)(26005)(66446008)(76116006)(66946007)(110136005)(316002)(66476007)(66574012)(53546011)(7696005)(186003)(66556008)(52536014)(5660300002)(33656002)(2906002)(9686003)(55016002)(86362001)(478600001)(71200400001)(81156014)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3081;
 H:DM6PR12MB3931.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b49UUdgUwhfKF6Q5vgh/X4OdaqhHk3zWWknaAdafr69wGjitpL3v21XB5sd2dV+UZ/mPXzDaJFy1hndDATuaopH5hP0Vl5EqzCuSBShdnrwIt3Z6kbVoNrXFo3l3JT7Yty6WiLNukxQOBw2tUm8DxyiIp6ku/RvOYhQ1IQg3l7oaVAp4jxn0Xoouz7zBySY2DdNgKYqDNQ0o1rmHmvKXZjZft7GWrbsHNTXxhUzy6e/8UACm6VRAv6UfEs0AQfGMyIDT6nlCu2GlI4Qn+pyYjPZYCBfNez9hectEv+10U1R0mDDS0DPnqdRzxO6kgM+3yHRVlrwWvhlR3H7Xtcbbkbw8eRv4sNMUxqzZIjzgFJ89N5HGRZsan0nK2BpMkIMkzzYFlminvgtOzsQt8KUj9eWaCqU7dHQQGu8OYWLPLNIXL0uT3aaWyNidKQrLF3xr
x-ms-exchange-antispam-messagedata: CGsioXtlTQTtn2orAPqCVzgI19oRZmVCWamkm6DnzcXQ92/96YSeJZ1JYlEhz4gvK3zewLY+njq/RgHeNN5qT3yRHK1fYEKcawYHr9txa2O1kFaqu+mBnSxcy+q22v/iV1Xl278ESj3ADGwEEtFbVQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d54c04-a092-4583-c6a7-08d7c10a93cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 13:39:06.7775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YI2AkC3COFrbTf8eJrRzQWyLmjxoWC+RjyAlaxRNafQ/mNt25NnXGqoisXULB6Tx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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

VGhpcyBpcyBub3Qgc3VwcG9ydGVkIGJ5IE1NU0NIIEZXLi4uIA0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmlydHVhbGl6YXRpb24gVGVhbSB8
QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBLw7Zu
aWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBN
YXJjaCA1LCAyMDIwIDk6MzggUE0NClRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtlbmFibGUgVkNOMi4w
IGZvciBOVjEyIFNSSU9WIDIvNl0gZHJtL2FtZGdwdTogZGlzYWJsZSBqcGVnIGJsb2NrIGZvciBT
UklPVg0KDQpBIGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5pbmcgd2h5IHdlIGRpc2FibGUgaXQgYW5k
IGlmIGl0IGNvdWxkIGJlIGVuYWJsZWQgYWdhaW4gb3IgaWYgdGhpcyBpcyBwZXJtYW5lbnQgd291
bGQgYmUgbmljZSB0byBoYXZlLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDA1LjAzLjIwIHVtIDE0OjMz
IHNjaHJpZWIgTW9uayBMaXU6DQo+IFNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBh
bWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMyAr
Ky0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgaW5kZXggMmQxYmViZC4uMDMzY2JiYyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+IEBAIC01MTYsNyArNTE2LDggQEAgaW50IG52
X3NldF9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgCQkgICAgIWFt
ZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gICAJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChh
ZGV2LCAmc211X3YxMV8wX2lwX2Jsb2NrKTsNCj4gICAJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tf
YWRkKGFkZXYsICZ2Y25fdjJfMF9pcF9ibG9jayk7DQo+IC0JCWFtZGdwdV9kZXZpY2VfaXBfYmxv
Y2tfYWRkKGFkZXYsICZqcGVnX3YyXzBfaXBfYmxvY2spOw0KPiArCQlpZiAoIWFtZGdwdV9zcmlv
dl92ZihhZGV2KSkNCj4gKwkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYsICZqcGVn
X3YyXzBfaXBfYmxvY2spOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1
cm4gLUVJTlZBTDsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
