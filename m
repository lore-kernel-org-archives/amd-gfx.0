Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46083C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED6E20675
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED6E20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C898D6F443;
	Wed,  4 Dec 2019 08:16:45 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790088.outbound.protection.outlook.com [40.107.79.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18666F443
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 08:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHTHL1iJi4T72dg6UZQ3HTHN431c7NwGFDabaBNWWpMJXjMwJdC8IsOKrvyV41y6T4A+mV/7TJjMdcmyQXh0KX2Pe8khRr2/qJaYfuvVpqq88VTFNn2ZHbiOeNRyJtrLHQfsthq1yXZft1H9potTMWI8YLaO57g2wjkO+j32cVgmK6FOBstetJQCTqtnLqozjy9yN5VL+CdPOBc3Aq2qDpYdh28f3lVKlE95Q0ZIsu/ZyYlpBG0nGya2GFamuYRkQ+Rd/6ltwkaEf5xRxn7M7CeklapmaSqDTRMJ76rdCf9NzJrIvgvtEWFGa0M2HXG+KcbRF11Y1VMb8WePxYQE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3+ChQswpr1iNNu1JLQjfNgVdh6tuC8AMIwPRPbEVac=;
 b=FM+NDddpTt2CSra+UDvlQIQAmSF4wavCAmXRPQmKUVLjoz6OHxAKTL+10R4ANf7Mq7D3VS7iCphHj+4VJ3/2CbZzsniwYXdXeMXWp81jqXgDbOY8u+sWI7+PKXGiDZFg+Rz5RVoNQiovSdYKSetJg3RZhvMWaTDhqugYV6m6QYAvUqI/gpvHXLALnUhWKK49eSSEHidqmzPBNQv4M1lwmTzPIrB3xFjKkYLQd/UMA1NRA8VYs6zuQaMYoZp8SHbvYu3ChEKeM3Rwtn2Hv/1IOL7NIWk1bhbAbA5p8vU3Fpz/jzuWCoEzpdDh5mH+5pbWwbko9nZo7+3YM/ipGnchnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3224.namprd12.prod.outlook.com (20.179.93.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 08:16:43 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 08:16:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add check before enabling/disabling broadcast
 mode
Thread-Topic: [PATCH] drm/amdgpu: add check before enabling/disabling
 broadcast mode
Thread-Index: AQHVqnjtkwH+ROVhyUunmDKDdrwg9aepoHoAgAAAsWA=
Date: Wed, 4 Dec 2019 08:16:43 +0000
Message-ID: <BYAPR12MB2806C38ED78013E2246B8B00F15D0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20191204080024.7229-1-guchun.chen@amd.com>
 <DM5PR12MB14184AFF92C3430194D1BABBFC5D0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB14184AFF92C3430194D1BABBFC5D0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-04T08:16:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=941ca442-7ed6-41d8-afec-0000b5373ee6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-04T08:16:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 44728fe4-c50f-4f74-9258-000080cde5ec
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 848e098c-5488-4be5-6efb-08d778924c44
x-ms-traffictypediagnostic: BYAPR12MB3224:|BYAPR12MB3224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3224F951B1916A2233641C08F15D0@BYAPR12MB3224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(13464003)(15404003)(199004)(189003)(2501003)(81156014)(66476007)(81166006)(8936002)(6246003)(66556008)(76116006)(66446008)(25786009)(14454004)(66946007)(8676002)(3846002)(6436002)(6116002)(478600001)(229853002)(110136005)(9686003)(52536014)(64756008)(33656002)(74316002)(99286004)(55016002)(2906002)(5660300002)(86362001)(256004)(14444005)(6636002)(71190400001)(7696005)(6506007)(53546011)(76176011)(11346002)(446003)(316002)(26005)(71200400001)(186003)(7736002)(305945005)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3224;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++oStdJnEBwEMla9DVqG8Xo1Cu5RuUzUbqZuoOYcpFD21tmsHS9OSlOW7lIdVRS/hPDCgD/WoXMM9I9XyaUFd2rgdOM/SbYrjUPtDyTL+Vvk/nxElT3DsaVrU9uBdp3RzkLSbQI89fula/vm4+ggycuY1pLkPpqKTbmenBEXIXMe3vCQt7q44tSkZAPaRYxlj7MvBg5XlaOScaU0AzGX6c1MKHcZlPRB+5sQ2nxEeiXB6DbupiiSc9T2BPhy9Ve/MsQjug5louvXl403eU6ivJx5Zy5R3lYXADNYa/iHUihCf+iSadTLkmvDppwqAjccdNVvxQ/1C4Xj4Xwg7sPfjVZ6/xsKcqb3dH6V5J/b3EPI1huW1Tmx0BIfrN9g/R2cSmxRc3OHkBAEr8FvK93LmURMSyRQ7B2lUCSEctSY+lrOOqMIbJPaUyPlEuZGXIvnkQ2jeryHiyl3ySPZPe5kRRj/76auzmaIlsAjZ2/mXZmq+QeIfaeQmHVw/N6abhMqyrpZg1uVJ5KCbM2JDrzAUw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e098c-5488-4be5-6efb-08d778924c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 08:16:43.5156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNDCGY78+hxfHNVolNdlEeR4vmtJtP45KnDoaOUrQLXgUhO2Zu//EtZUG7Z0F1Zbu55mTDk0ytPPCEX/ERy/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3+ChQswpr1iNNu1JLQjfNgVdh6tuC8AMIwPRPbEVac=;
 b=gJANkwXANv99R7gcKl+sq2lFpVoaEQASkAV8aSiss4dBLwZL2Hxqxq3DbC4OY0GUBMAlrqC1DSNsgpXkQu8e6ag/60viOEUlj2Aw+SHOiz+fH1+Hp6d2uxqACsLkd6K/pGZwt+Nn6CMVeDt4OYPLLHQNrsmHDud21Odn0mAUZ3Q=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQoKVGhh
bmtzIEhhd2tpbmcuCkkgd2lsbCBjb3JyZWN0IGNvbW1pdCBtZXNzYWdlIHdoZW4gcHVzaGluZy4K
ClJlZ2FyZHMsCkd1Y2h1bgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogWmhhbmcs
IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4gClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1i
ZXIgNCwgMjAxOSA0OjE0IFBNClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPgpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBh
ZGQgY2hlY2sgYmVmb3JlIGVuYWJsaW5nL2Rpc2FibGluZyBicm9hZGNhc3QgbW9kZQoKUmV2aWV3
ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KClRvIGJlIG1vcmUg
YWNjdXJhdGUsIHdoZW4gc2VjdXJpdHkgdmlvbGF0aW9uIGhhcHBlbnMsIERGIGlzIGluIHJpc2sg
dG8gc3RvcCB3b3JraW5nLiBUaGUgZGlyZWN0IGFjY2VzcyB0byBtbUZhYnJpY0NvbmZpZ0FjY2Vz
c0NvbnRyb2wgc2hvdWxkIGJlIHByZXZlbnRlZCBmcm9tIFZCSU9TICM1NSBhbmQgb253YXJkcy4g
CgpSZWdhcmRzLApIYXdraW5nCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IENoZW4s
IEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4gClNlbnQ6IDIwMTnlubQxMuaciDTml6UgMTY6
MDAKVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPgpDYzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPgpTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBjaGVjayBiZWZvcmUgZW5hYmxpbmcvZGlzYWJsaW5n
IGJyb2FkY2FzdCBtb2RlCgpEdWUgdG8gbmV3IHZiaW9zIHNlY3VyaXR5IHBvbGljeSBjaGFuZ2Ug
YW5kIGxhY2sgb2YgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgaW50ZXJmYWNlLCBoYW5nIHdpbGwg
aGFwcGVuIHdoZW4gZGF0YSBmYWJyaWMgdXBkYXRlcyBjbG9jayBnYXRpbmcgb24gdmVnYTIwLiBT
byBhZGQgb25lIGNoZWNrIGJlZm9yZSBwcm9jZXNzaW5nIGRhdGEgZmFicmljIGJyb2FkY2FzdCBt
b2RlIHRvIGJ5cGFzcyB0aGlzIG9uIHZlZ2EyMC4KClNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVu
IDxndWNodW4uY2hlbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Rm
X3YzXzYuYyB8IDM4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9kZl92M182LmMKaW5kZXggNzJiZmVmZGJmYTY1Li45Mzk1YWE4YjhmZDAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9kZl92M182LmMKQEAgLTI2OCwyMyArMjY4LDI5IEBAIHN0YXRpYyB2b2lk
IGRmX3YzXzZfdXBkYXRlX21lZGl1bV9ncmFpbl9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsICB7CiAJdTMyIHRtcDsKIAotCS8qIFB1dCBERiBvbiBicm9hZGNhc3QgbW9k
ZSAqLwotCWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfYnJvYWRjYXN0X21vZGUoYWRldiwgdHJ1ZSk7
Ci0KLQlpZiAoZW5hYmxlICYmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX0RGX01H
Q0cpKSB7Ci0JCXRtcCA9IFJSRUczMl9TT0MxNShERiwgMCwgbW1ERl9QSUVfQU9OMF9EZkdsb2Jh
bENsa0dhdGVyKTsKLQkJdG1wICY9IH5ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyX19NR0NH
TW9kZV9NQVNLOwotCQl0bXAgfD0gREZfVjNfNl9NR0NHX0VOQUJMRV8xNV9DWUNMRV9ERUxBWTsK
LQkJV1JFRzMyX1NPQzE1KERGLCAwLCBtbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXIsIHRt
cCk7Ci0JfSBlbHNlIHsKLQkJdG1wID0gUlJFRzMyX1NPQzE1KERGLCAwLCBtbURGX1BJRV9BT04w
X0RmR2xvYmFsQ2xrR2F0ZXIpOwotCQl0bXAgJj0gfkRGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0
ZXJfX01HQ0dNb2RlX01BU0s7Ci0JCXRtcCB8PSBERl9WM182X01HQ0dfRElTQUJMRTsKLQkJV1JF
RzMyX1NPQzE1KERGLCAwLCBtbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXIsIHRtcCk7Ci0J
fQorCWlmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX0RGX01HQ0cpIHsKKwkJLyog
UHV0IERGIG9uIGJyb2FkY2FzdCBtb2RlICovCisJCWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfYnJv
YWRjYXN0X21vZGUoYWRldiwgdHJ1ZSk7CisKKwkJaWYgKGVuYWJsZSkgeworCQkJdG1wID0gUlJF
RzMyX1NPQzE1KERGLCAwLAorCQkJCQltbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXIpOwor
CQkJdG1wICY9IH5ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyX19NR0NHTW9kZV9NQVNLOwor
CQkJdG1wIHw9IERGX1YzXzZfTUdDR19FTkFCTEVfMTVfQ1lDTEVfREVMQVk7CisJCQlXUkVHMzJf
U09DMTUoREYsIDAsCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlciwgdG1wKTsK
KwkJfSBlbHNlIHsKKwkJCXRtcCA9IFJSRUczMl9TT0MxNShERiwgMCwKKwkJCQkJbW1ERl9QSUVf
QU9OMF9EZkdsb2JhbENsa0dhdGVyKTsKKwkJCXRtcCAmPSB+REZfUElFX0FPTjBfRGZHbG9iYWxD
bGtHYXRlcl9fTUdDR01vZGVfTUFTSzsKKwkJCXRtcCB8PSBERl9WM182X01HQ0dfRElTQUJMRTsK
KwkJCVdSRUczMl9TT0MxNShERiwgMCwKKwkJCQkJbW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dh
dGVyLCB0bXApOworCQl9CiAKLQkvKiBFeGl0IGJyb2FkY2FzdCBtb2RlICovCi0JYWRldi0+ZGZf
ZnVuY3MtPmVuYWJsZV9icm9hZGNhc3RfbW9kZShhZGV2LCBmYWxzZSk7CisJCS8qIEV4aXQgYnJv
YWRjYXN0IG1vZGUgKi8KKwkJYWRldi0+ZGZfZnVuY3MtPmVuYWJsZV9icm9hZGNhc3RfbW9kZShh
ZGV2LCBmYWxzZSk7CisJfQogfQogCiBzdGF0aWMgdm9pZCBkZl92M182X2dldF9jbG9ja2dhdGlu
Z19zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLS0KMi4xNy4xCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
