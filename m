Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6949AC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4576121774
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 09:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576121774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16ABC6E89B;
	Fri, 29 Nov 2019 09:28:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0570B6E89B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 09:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBBgi28w1R2aevTxwsapg4+jc5CUiYndMkGlMGn042ViUu33ckZ3SxfNTTowfogRHLyqsOKagBw4eSQ9uZeAnWzM+SkA1WAfLlIB4IlSXIGXs7jGxs9viRq/xBF7sVqlN4ZxmGdA3uXgMJl7VpRTAnhly0mC6MJLDkCi6eRXatGi07AHlhlhuCuQ1qz3UUp26TfIYQf1hTC6Tt+phJ80/ST/AByDbNKzaeVJosMikkCS3hIhbn+qNYvLeZBgoK5e2j1lTfFJpo5VKvf60vFHbFfe005mWVbN6cp2uku4RXB3KjCaNGZBGmfycFylmqL5eF1XCqNkM1QsDU34F0H56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz8klxOJxOWcdmJIXmS3oQqG4sTggD2h3K50bWW6S1Q=;
 b=SbEuRq5fWT7HM1Ia1w74MbP9Pw0XyWR3fh004zhCOPrXQNfH486ure+cBnnUbhU9IIysmpaXGB3k6eTcTCqwZWLm3xYU6ipvLR3QbA9DXuWx32L0xcBhr6WCgwhw4vLOc1DL+fqrZquReeUZHhUodHOEFK0FP/Fyhq+H4xHAvxLfm26zV37qEQPC4U5ivKg9U5JN9ID29OuIwKI1MJ/cdEU9QR5F+FEb81J4sE825f5HWIjhMXVbrjPWSf93bjx6xR0IRUPhrJqtKZ52xMabcoJSD1N9/9aQ+YpzCLkaEmB/cdOnBMBAFqZOeFLraocRvMd5V/4jPSFVktLFOFFN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1179.namprd12.prod.outlook.com (10.168.234.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 09:28:56 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 09:28:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix GFX10 missing CSIB set(v2)
Thread-Topic: [PATCH] drm/amdgpu: fix GFX10 missing CSIB set(v2)
Thread-Index: AQHVppWsP/VH0WO4okqDg43cICxCbaeh4CEw
Date: Fri, 29 Nov 2019 09:28:56 +0000
Message-ID: <DM5PR12MB1418FE37301D02C34B9A9FD3FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1575018965-30828-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1575018965-30828-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-29T09:23:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=31c6b16b-ad06-412d-a65f-0000758c8b98;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-11-29T09:28:50Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d92084f4-5c6f-49f8-b1c4-00002380c551
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a83476a-259b-4fab-afdc-08d774ae8e8e
x-ms-traffictypediagnostic: DM5PR12MB1179:|DM5PR12MB1179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11791B2846E02E6182C82CACFC460@DM5PR12MB1179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(13464003)(189003)(199004)(966005)(64756008)(66556008)(110136005)(7696005)(102836004)(45080400002)(256004)(14454004)(11346002)(76116006)(66066001)(446003)(6436002)(6246003)(6506007)(4326008)(186003)(26005)(53546011)(71190400001)(52536014)(71200400001)(76176011)(66946007)(5660300002)(66476007)(229853002)(66446008)(86362001)(6306002)(9686003)(478600001)(55016002)(8936002)(33656002)(25786009)(81166006)(316002)(2906002)(305945005)(74316002)(8676002)(99286004)(81156014)(7736002)(6116002)(3846002)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1179;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfFUWl1Rtt2a9frlW3hV0aDA32bvcqumOJCG8E2jnNIAfAEPXB0KrV6xQkP5pLSjH/wiLZtq6Lvp5rPbk84HVVkaTbfHRlcuW26FdeoKO/hoPEVb7XCvBsTkv1xp1pvFpjmqpOKclMRVa3W0W5k+jqWRSCW9BSK/hI1iWP5H5nOmptZfIa2uviGJhQaWuankt/1FqfA18qY7WCJDCrDrCG3xicCxskSGd6252kyP/Un4ztJ1nAgpz9TUIGpL8oRqS4z7lzUcMSNU65sn+BMT+SqufREXLzCXmm0ban9ZU2qmNTpD9wrO9oOQWgHkKPXzzvDO3GrhpQK1z3k34Uaw3EeBEzIf9KulQ9GDhKrxUvqJh177IGARSvU/ZmGVlGuPig0phLtdlkZOkesMMd9ZXZ6z/PuFE5cM/RYVes4LkFY9z5/e8EjcFsPEULAn98j05VSbejsdxnyAEdvJbDB9n8Q3oWj+HgF8j/HS8JCT72Q=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a83476a-259b-4fab-afdc-08d774ae8e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:28:56.0382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqYpgoi+UUZOkHN+MxWEPPaqQe43Td6jCw7Rvpe4NRBOGzFYqDhUZwLRbxhQjRR3qeZanaelTTdcF50AdTFyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz8klxOJxOWcdmJIXmS3oQqG4sTggD2h3K50bWW6S1Q=;
 b=nNjs8F27GS7CsIsZcCu7QP+PE903dEwQWlmhGSfwI0I0wKsdRd0CvYSMR+CvoXhXFlpfCpXqjXYc5MPeEqTDlJUqS+xOe687PULBVZoaRG5Qdn7Mg+TSP7r7SMWUC8GZcSn7v+nAJL9RT66On5+q2S2ZDuZZOCwJKA4qVrYWyjs=
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpQbGVhc2UgYWxzbyBkcm9wIHRoZSB0bGIgZmx1c2guIEl0IGlz
IHByb2JhYmx5IGZyb20gY29kZSB1c2VkIGZvciB0aGUgZW11bGF0aW9uLg0KKwkJZm9yIChpID0g
MDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykNCisJCQlhbWRncHVfZ21jX2ZsdXNoX2dwdV90
bGIoYWRldiwgMCwgaSwgMCk7DQoNCldpdGggdGhhdCBmaXhlZCwgdGhlIHBhdGNoIGlzDQpSZXZp
ZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KDQpSZWdhcmRz
LA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNb25rIExp
dQ0KU2VudDogMjAxOeW5tDEx5pyIMjnml6UgMTc6MTYNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KQ2M6IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogZml4IEdGWDEwIG1pc3NpbmcgQ1NJQiBzZXQodjIpDQoNCnN0aWxs
IG5lZWQgdG8gaW5pdCBjc2IgZXZlbiBmb3IgU1JJT1YNCg0KdjI6DQpkcm9wIGluaXRfcGcoKSBm
b3IgZ2Z4MTAgYXQgYWxsIHNpbmNlDQpQRyBhbmQgR0ZYIG9mZiBmZWF0dXJlIHdpbGwgYmUgZnVs
bHkgY29udHJvbGVkIGJ5IFJMQyBhbmQgU01VIGZ3IGZvciBnZngxMA0KDQpTaWduZWQtb2ZmLWJ5
OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jIHwgMzggKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCmluZGV4IDUzZDExZTkuLmE4ZWVi
YzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC0xNzY2LDIy
ICsxNzY2LDYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaW5pdF9jc2Ioc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgaW50IGdmeF92MTBfMF9p
bml0X3BnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAtew0KLQlpbnQgaTsNCi0JaW50IHI7
DQotDQotCXIgPSBnZnhfdjEwXzBfaW5pdF9jc2IoYWRldik7DQotCWlmIChyKQ0KLQkJcmV0dXJu
IHI7DQotDQotCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKyspDQotCQlhbWRn
cHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgMCwgaSwgMCk7DQotDQotCS8qIFRPRE86IGluaXQg
cG93ZXIgZ2F0aW5nICovDQotCXJldHVybiAwOw0KLX0NCi0NCiB2b2lkIGdmeF92MTBfMF9ybGNf
c3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCiAJdTMyIHRtcCA9IFJSRUczMl9T
T0MxNShHQywgMCwgbW1STENfQ05UTCk7IEBAIC0xODczLDIyICsxODU3LDIxIEBAIHN0YXRpYyBp
bnQgZ2Z4X3YxMF8wX3JsY19sb2FkX21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikgIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpICB7DQogCWludCByOw0KLQ0KLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KLQkJ
cmV0dXJuIDA7DQorCWludCBpOw0KIA0KIAlpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09
IEFNREdQVV9GV19MT0FEX1BTUCkgew0KKw0KIAkJciA9IGdmeF92MTBfMF93YWl0X2Zvcl9ybGNf
YXV0b2xvYWRfY29tcGxldGUoYWRldik7DQogCQlpZiAocikNCiAJCQlyZXR1cm4gcjsNCiANCi0J
CXIgPSBnZnhfdjEwXzBfaW5pdF9wZyhhZGV2KTsNCi0JCWlmIChyKQ0KLQkJCXJldHVybiByOw0K
KwkJZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0KIA0KLQkJLyogZW5hYmxlIFJMQyBTUk0gKi8N
Ci0JCWdmeF92MTBfMF9ybGNfZW5hYmxlX3NybShhZGV2KTsNCisJCWZvciAoaSA9IDA7IGkgPCBh
ZGV2LT5udW1fdm1odWJzOyBpKyspDQorCQkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYs
IDAsIGksIDApOw0KIA0KKwkJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIC8qIGVuYWJsZSBS
TEMgU1JNICovDQorCQkJZ2Z4X3YxMF8wX3JsY19lbmFibGVfc3JtKGFkZXYpOw0KIAl9IGVsc2Ug
ew0KIAkJYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcChhZGV2KTsNCiANCkBAIC0xOTEwLDkgKzE4
OTMsMTAgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCiAJCQkJcmV0dXJuIHI7DQogCQl9DQogDQotCQlyID0gZ2Z4X3YxMF8wX2lu
aXRfcGcoYWRldik7DQotCQlpZiAocikNCi0JCQlyZXR1cm4gcjsNCisJCWdmeF92MTBfMF9pbml0
X2NzYihhZGV2KTsNCisNCisJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKysp
DQorCQkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYsIDAsIGksIDApOw0KIA0KIAkJYWRl
di0+Z2Z4LnJsYy5mdW5jcy0+c3RhcnQoYWRldik7DQogDQotLQ0KMi43LjQNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBs
aXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRl
c2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAx
JTdDaGF3a2luZy56aGFuZyU0MGFtZC5jb20lN0MwYTNjOGZlZTBjOTE0N2M1M2Y1NjA4ZDc3NGFj
Y2Q5NyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDYx
NTc4NDA3NjQwMzgmYW1wO3NkYXRhPXliOXA3RWU5VDNuOXhOVTdScGdFMWNYT3ZFT2U5T1NSZ29C
ZmtaV0hWVEklM0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
