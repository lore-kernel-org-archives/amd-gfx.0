Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB5C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 11:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5379920767
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 11:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zemfl/Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5379920767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2186E9A5;
	Thu,  3 Sep 2020 11:03:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778516E9A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 11:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtWy0gwkATqeEIlZepwKblKF0IK5YQU8YLUArRUswkpWVc+8ObXTfuUcgkghNPvq6h6YU1MLlG9Xa0U9/Pzvx3ttkHhBDRRsqRPAgrbop1ASZmZSLesSwhkRBPJqa2CReFewQFKhMTvs6JXlQRXEoq88ENVIYUUSjBwPLK13OokKIANEloFcivE4L45cIKAkAQsJVGoMCH9DOCb96C2kveg/GX8brAolH9DY78GvPULkYQyVs43N0JG0bgjRlWFMw7DMu1MTRams1pADosi0AnN1CGyrOlUkY0pS1FUynSxZw357CK469JCRh2B8jwSODjOOt+LbrFfxivNBfnZgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEn0z9flUg8AEF4kfATBz8mzh0B/MmHzBRV0wxcNRY4=;
 b=EAbCYZr0AUcfKvgJL2Il4AR40vZDqw4pET2/BQ+bovCYazeYMc/G7fTZ6eVWK5amFlgr6/S9dfrTUYzPdqlm7th059gB+ceE6Gd1bnM39F8kp7UErqgfpetpyXNmgMoqkpl4vYEQR85kRzq8FHUVQwjvjE+qqiHacwX1QAlJhiJxYm/j5CZtmFmFYsGiRFmRqMLzMaEHCQdYhA2bkbDuFbE+zWxMAKSGStdZV8fUGaJ8vKrfsnpYSdGMtOQkSD3EM2pdgwbSReeUUGCToUx9M9L7Eq6305aURTBI3l9WKwXURGdBrUeHSkW8gs1Q1Oxh2zlvdInG/aLfoVsUgiw5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEn0z9flUg8AEF4kfATBz8mzh0B/MmHzBRV0wxcNRY4=;
 b=Zemfl/VlUl4Rdmb2ayY7+F586m2Ezm0V+LCWWqJ1AJKc4l+ho73hf+QRcKkZq8GlOSvXM2+3+QR9WkJnT8sy9YyqSQmzPmOHrpdehp4/f2pUA/18CvM0lz9Jb4f6aGVfEOEoCzW4c+WbMTgvc2dkp14wrZrhKeAWn7Q4+JU9V18=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 11:02:57 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 11:02:57 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v4
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation v4
Thread-Index: AQHWgdESX2OpUj9DbEq6XiWlQQ6LWqlWv+sA
Date: Thu, 3 Sep 2020 11:02:57 +0000
Message-ID: <7258A8C1-0053-4DC8-A4F2-B246E9614064@amd.com>
References: <20200903090316.2123-1-christian.koenig@amd.com>
In-Reply-To: <20200903090316.2123-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3813076-4d63-4bd4-6ff6-08d84ff8ea78
x-ms-traffictypediagnostic: SA0PR12MB4589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4589CB81516CAFEAA3AD6819872C0@SA0PR12MB4589.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIkEM2kHlnGMfMDd8hKBadr6pBZWJDuUA3PqGAwOIQUwO0n8IRfSfILz4HRScLl/VknbHTUjtWZYdsqiTqO/smljV/x1lvF7i6H6crJXM+69SUVokqB78tsHAQ0sExTtvidAnFey/sAMBGT2oNXORhmWEh5KeQtPOezWidVvKk8DKz4THvH9XEMN/ojpU3jUVihDuRMcCRYcTuZJ33n857hhel1Lu7tire4bWticCxqXdU8wHo/g8p3+GVuRMwIsOS7iWISzxvaIvc0pplBHdVfj2e/pWES9+Qg1CPwOQ7JQw7dY9+gVavNkYMNsHgG+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(66574015)(33656002)(316002)(2616005)(83380400001)(71200400001)(8936002)(36756003)(54906003)(8676002)(2906002)(5660300002)(91956017)(66946007)(6512007)(6506007)(26005)(186003)(4326008)(478600001)(64756008)(6916009)(6486002)(66556008)(66476007)(76116006)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pyLAy8A6VbZbaRJjEbgWjlVV76sjVl5iGExN7FEQ3eOjSIpuhQDjDXDjkB35m6Yol+P4rJ0af6x7QXPA7ZGqey+xGbrEiRhfBGYlv817bvSgkFlq2gQpnEeEbwv2hX0Jmk/42fekqaX5cjSjUBIwf1mJO8baXcqRgKx6x5HOnKhxS5RddrJ5if7jO0HCXE7RXScBYWptuqvpg848Cj7zzqpezOUzbXWskH88XPYJitxb+bD0KAOXWBJRUWY5ECt3QV3tritVbKzeNQvFdULtW9s4eo8BKZA8Bb6RP2He1pEwVHVGVe+kwDY1lvip3DcRezY+cwFoNLcM3faPbwbDb0R6ExDNstQKA8pf00iSb8ftSPvIT9s/C1enlhdjLMPC4W42gcRxFJPDzKz4S/EV3oAx3N+U6JfdAFWd2SY4UHR2FXlMLNuk+9D+DZpVIcBZbAsxswIArcZIKlvBjedh29iZ2+/vVhks3CMJjqAgBAtsOXkyi4k+ylko6bROKybDA6M8lY9LJanHNPBfrlivsa4OF5REBZDsFFDvE6NbDfCarBw9rGpeLb1NI/ZAQJQATNS+srq40TxsSs3xqQNrJkRig7OzCLCCS6Tvq/E0MCKSdR/dYYefAl+TIqlWh2yVoaQd0fL/XkLfa8OFMkCb0Q==
Content-ID: <1160DC9961D8B244806403456E1133CE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3813076-4d63-4bd4-6ff6-08d84ff8ea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 11:02:57.6640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMfRYTZRwUnzQH5KVcvb+XqAqsd4QtoOYEFT9BYnyyTuV7jwpyn5iK/cpLzSUUpE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCg0KDQo+IDIwMjDl
ubQ55pyIM+aXpSAxNzowM++8jENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPiDlhpnpgZPvvJoNCj4gDQo+IENhbGN1bGF0ZSB0aGUgY29ycmVjdCB2YWx1
ZSBmb3IgbWF4X2VudHJpZXMgb3Igd2UgbWlnaHQgcnVuIGFmdGVyIHRoZQ0KPiBwYWdlX2FkZHJl
c3MgYXJyYXkuDQo+IA0KPiB2MjogWGluaHVpIHBvaW50ZWQgb3V0IHdlIGRvbid0IG5lZWQgdGhl
IHNoaWZ0DQo+IHYzOiB1c2UgbG9jYWwgY29weSBvZiBzdGFydCBhbmQgc2ltcGxpZnkgc29tZSBj
YWxjdWxhdGlvbg0KPiB2NDogZml4IHRoZSBjYXNlIHRoYXQgd2UgbWFwIGxlc3MgVkEgcmFuZ2Ug
dGhhbiBCTyBzaXplDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IEZpeGVzOiAxZTY5MWUyNDQ0ODcgZHJtL2FtZGdwdTog
c3RvcCBhbGxvY2F0aW5nIGR1bW15IEdUVCBub2Rlcw0KPiAtLS0NCj4gZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCA4ICsrKystLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRleCA4YmMyMjUzOTM5YmUuLmQ2ZGNkNThhOGYxYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTE2OTEsMTMg
KzE2OTEsMTMgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gCQl1aW50NjRfdCBtYXhfZW50cmllczsNCj4gCQl1aW50
NjRfdCBhZGRyLCBsYXN0Ow0KPiANCj4gKwkJbWF4X2VudHJpZXMgPSBtYXBwaW5nLT5sYXN0IC0g
c3RhcnQgKyAxOw0KPiAJCWlmIChub2Rlcykgew0KPiAJCQlhZGRyID0gbm9kZXMtPnN0YXJ0IDw8
IFBBR0VfU0hJRlQ7DQo+IC0JCQltYXhfZW50cmllcyA9IChub2Rlcy0+c2l6ZSAtIHBmbikgKg0K
PiAtCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7DQo+ICsJCQltYXhfZW50cmllcyA9
IG1pbigobm9kZXMtPnNpemUgLSBwZm4pICoNCj4gKwkJCQlBTURHUFVfR1BVX1BBR0VTX0lOX0NQ
VV9QQUdFLCBtYXhfZW50cmllcyk7DQo+IAkJfSBlbHNlIHsNCj4gCQkJYWRkciA9IDA7DQo+IC0J
CQltYXhfZW50cmllcyA9IFM2NF9NQVg7DQo+IAkJfQ0KPiANCj4gCQlpZiAocGFnZXNfYWRkcikg
ew0KPiBAQCAtMTcyNyw3ICsxNzI3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRf
bWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gCQkJYWRkciArPSBwZm4gPDwg
UEFHRV9TSElGVDsNCj4gCQl9DQo+IA0KPiAtCQlsYXN0ID0gbWluKCh1aW50NjRfdCltYXBwaW5n
LT5sYXN0LCBzdGFydCArIG1heF9lbnRyaWVzIC0gMSk7DQo+ICsJCWxhc3QgPSBzdGFydCArIG1h
eF9lbnRyaWVzIC0gMTsNCj4gCQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKGFkZXYs
IHZtLCBmYWxzZSwgZmFsc2UsIHJlc3YsDQo+IAkJCQkJCXN0YXJ0LCBsYXN0LCBmbGFncywgYWRk
ciwNCj4gCQkJCQkJZG1hX2FkZHIsIGZlbmNlKTsNCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
