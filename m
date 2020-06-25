Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD5C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942F20706
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AK6xvgvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942F20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5C26E882;
	Thu, 25 Jun 2020 00:32:47 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760055.outbound.protection.outlook.com [40.107.76.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5E66E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 00:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxlzTWAAq7nWUAf1ufu98Lizpdy3jo8Wz9ScvHbA0k/Auw+twh5mZa9TLn/8UG290q6xsNBxgvzJPZny7MlNV8mMRMR39JzY/qSz4qEhjmXz/gSZYLy6dJhBb1ML5ObYJx9MPZFVtGEarlJv2TCCSqeCGwA2781B2HUBTLrR6qlfpr0hve14Xt2lUq/qu7evUU70tBDvfJWP/89PbaEkj2/D/zkGQLBXGr5Inf392kC37wsYxGSezxPWdA3CT2zeklLD+jya67hO5O08RNSMgWoTtN68ztL69C0jIapBEwCj2RTWnuRxADDG3hvpOYy759WBjBbss16L2yWRQMJfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLKkkZ07+8QiD9nBi2BC2z0pdrfIuKp/LjgcwAWFpGc=;
 b=OrCGMO4OUpXpvFijLUKO/n687CXSIrUGE+ns/kO4bUJTOcxWFCVnrznbCbmNLwYDQNGVe1xk2dz+yGYLOVNaIqXquMqz4DEg0Yvl84hJReDn/IuefsmHtc8ji6iJFimVldfo/wWuqx74SUQrAfkH7MagOuLIB1edb8MmLLgN6IM3B8FPlT2Pbceaqwz4ELytYyRVZrqWxRMPNbDZ3WeY2LUhhXGa84JO2pgISvb1nEeJMCmOK+VCeEFkJlA/FlToYnbTTwFdYvif3qhmOJ0LVdA4PiOPRNEr+QNOXyVy9yrQQrPti30MGX5GsR+6/9uU+MasK8Fdd4kiae5H4o2Gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLKkkZ07+8QiD9nBi2BC2z0pdrfIuKp/LjgcwAWFpGc=;
 b=AK6xvgvzy/tmnoeTeNj6w/PKlIRz8Rs9kl0aMrlNhBoRKRT/wYOYgHEObImu32bt1/XUlPwtGro4Nt/7WrwUxG/CTMkoPpGxX01EfnL87lTu/a+oeEVgPjCuoKaSezGKnIZApDnQNygqhtSvH0GDkMUmfErfjxr0XAF83VLllYc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 25 Jun 2020 00:32:44 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 00:32:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: merge atombios init block
Thread-Topic: [PATCH 4/4] drm/amdgpu: merge atombios init block
Thread-Index: AQHWSno1EvqtdJAcWkybm2yiLu7S7ajoe1Qy
Date: Thu, 25 Jun 2020 00:32:44 +0000
Message-ID: <C65444DC-8CE3-4973-82E1-645569067121@amd.com>
References: <20200624225232.7616-1-Wenhui.Sheng@amd.com>,
 <20200624225232.7616-4-Wenhui.Sheng@amd.com>
In-Reply-To: <20200624225232.7616-4-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.195.103.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7f6deea-156d-4ab8-454e-08d8189f474f
x-ms-traffictypediagnostic: DM6PR12MB3579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3579C0436B8E0F4A14BB3792FC920@DM6PR12MB3579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWjWAqcKMIthAcHYCMCYtHzfvpOvBXjz1lly8SW8CrzBl3jX83iieNr47qIlBq9qGA8HiKvD2AiWwBo5GQcL0YdLxMkBC8Vn++1zpHXX42RRDJZUd3i0pQVg0JdarOlXV0Yhflky04/txuoeOdLi1YF4LGYPpl8jP+lNdPsV9ysDDqfTzaoaDK7/BQV6lPCXgTXovfQyjvICBGuEeyGglyDMoavAi9s7+AIhhLrSE2AtPqiVSPG29PpdjnaxPOx26IpqrzDzQmL1Rbs6lcdAaKjdh7NPjnW3GrIsu2Jha36117KpCPCMinvsMDZ661sSYjB+gK+kZjBqGp1xT8Pz4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(8676002)(71200400001)(478600001)(33656002)(8936002)(6512007)(76116006)(6486002)(91956017)(66946007)(86362001)(66476007)(2906002)(64756008)(66446008)(66556008)(186003)(6862004)(4326008)(316002)(5660300002)(83380400001)(36756003)(37006003)(26005)(6506007)(53546011)(2616005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: v8LLD0zeQmqYkw/EEWd+/WY0cg3t1viMGrRzkO8fF1KenAEYl0rRd+4mGK4if19cOxlgF3WCmDgWbmYrUaRTFk1YtGL3P/BD59yox/G5SnCiiI+Fm1h0yGtkx5cYgUYDiFCGy5cWRQZvLe0XTq8trkOt2f1dBeiMeyZpZuelB7MXrGoVka7qV+r86i9J4QRbyCI0B9VpBPh1gcy+x6ARm4LlDeYhZ1cILQMkUHHmNIauzgIj57+tlmng7zL6eAcy9bmvV8JRD3JSAWdrUSmH3XbabgK6GlS+8/XCOHmqr3tIEPAtDR7Ns04+2KgfGQnhdSFyyxCiieevxhmkwx4KiAc7Y1utTV/Z0+iWf0+6AUUtILxbtNz1WPPzQkrNp7K32KXU4cIDGVTwDNd28aTVTAMphETnwaXPlHAuAepIYHSqUDjRG6n697JLuCG76iBJ+zH2ZukqI2VA1rcLZF7nXFFfDuj9jMqZGgbzMTrt6284clXQ1ObRZOVi3x53ODGS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f6deea-156d-4ab8-454e-08d8189f474f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 00:32:44.6456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdLVIeMaKUUsDeW6gSgb7XY699k11he02Zx/1f8QyAyfkyfjyOhP89yiaRKDHBmwnTUO26sZPjqAOVfYVVnMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzDQoNClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBP
biBKdW4gMjUsIDIwMjAsIGF0IDA2OjUyLCBTaGVuZywgV2VuaHVpIDxXZW5odWkuU2hlbmdAYW1k
LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79Gcm9tOiBXZW5odWkgU2hlbmcgPFdlbmh1aS5TaGVuZ0Bh
bWQuY29tPg0KPiANCj4gQWZ0ZXIgd2UgbW92ZSByZXF1ZXN0IGZ1bGwgYWNjZXNzIGJlZm9yZSBz
ZXQNCj4gaXAgYmxvY2tzLCB3ZSBjYW4gbWVyZ2UgYXRvbWJpb3MgaW5pdCBibG9jaw0KPiBvZiBT
UklPViBhbmQgYmFyZW1ldGFsIHRvZ2V0aGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VuaHVp
IFNoZW5nIDxXZW5odWkuU2hlbmdAYW1kLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIzICstLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXggMTM4YWNl
OWMyOGQ2Li5mNDBiYzZiNWJlODIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTE3MjMsMjYgKzE3MjMsOSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9kZXZpY2VfaXBfZWFybHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
ICAgYW1kZ3B1X2RldmljZV9lbmFibGVfdmlydHVhbF9kaXNwbGF5KGFkZXYpOw0KPiANCj4gICAg
aWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPiAtICAgICAgICAvKiBoYW5kbGUgdmJpb3Mg
c3R1ZmYgcHJpb3IgZnVsbCBhY2Nlc3MgbW9kZSBmb3IgbmV3IGhhbmRzaGFrZSAqLw0KPiAtICAg
ICAgICBpZiAoYWRldi0+dmlydC5yZXFfaW5pdF9kYXRhX3ZlciA9PSAxKSB7DQo+IC0gICAgICAg
ICAgICBpZiAoIWFtZGdwdV9nZXRfYmlvcyhhZGV2KSkgew0KPiAtICAgICAgICAgICAgICAgIERS
TV9FUlJPUigiZmFpbGVkIHRvIGdldCB2Ymlvc1xuIik7DQo+IC0gICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+IC0gICAgICAgICAgICB9DQo+IC0NCj4gLSAgICAgICAgICAgIHIgPSBh
bWRncHVfYXRvbWJpb3NfaW5pdChhZGV2KTsNCj4gLSAgICAgICAgICAgIGlmIChyKSB7DQo+IC0g
ICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJhbWRncHVfYXRvbWJpb3NfaW5pdCBm
YWlsZWRcbiIpOw0KPiAtICAgICAgICAgICAgICAgIGFtZGdwdV92Zl9lcnJvcl9wdXQoYWRldiwg
QU1ER0lNX0VSUk9SX1ZGX0FUT01CSU9TX0lOSVRfRkFJTCwgMCwgMCk7DQo+IC0gICAgICAgICAg
ICAgICAgcmV0dXJuIHI7DQo+IC0gICAgICAgICAgICB9DQo+IC0gICAgICAgIH0NCj4gLQ0KPiAg
ICAgICAgciA9IGFtZGdwdV92aXJ0X3JlcXVlc3RfZnVsbF9ncHUoYWRldiwgdHJ1ZSk7DQo+IC0g
ICAgICAgIGlmIChyKSB7DQo+IC0gICAgICAgICAgICBhbWRncHVfYXRvbWJpb3NfZmluaShhZGV2
KTsNCj4gKyAgICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAgcmV0dXJuIHI7DQo+IC0gICAgICAg
IH0NCj4gICAgfQ0KPiANCj4gICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsNCj4gQEAgLTE4
NTUsMTAgKzE4MzgsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfZWFybHlfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICAgICBpZiAocikNCj4gICAgICAg
ICAgICAgICAgcmV0dXJuIHI7DQo+IA0KPiAtICAgICAgICAgICAgLyogc2tpcCB2YmlvcyBoYW5k
bGluZyBmb3IgbmV3IGhhbmRzaGFrZSAqLw0KPiAtICAgICAgICAgICAgaWYgKGFtZGdwdV9zcmlv
dl92ZihhZGV2KSAmJiBhZGV2LT52aXJ0LnJlcV9pbml0X2RhdGFfdmVyID09IDEpDQo+IC0gICAg
ICAgICAgICAgICAgY29udGludWU7DQo+IC0NCj4gICAgICAgICAgICAvKiBSZWFkIEJJT1MgKi8N
Cj4gICAgICAgICAgICBpZiAoIWFtZGdwdV9nZXRfYmlvcyhhZGV2KSkNCj4gICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
