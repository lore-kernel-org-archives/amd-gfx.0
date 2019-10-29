Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8ACA9EC0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 01:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D3F217D6
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 01:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D3F217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D32A6E05C;
	Tue, 29 Oct 2019 01:27:40 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740053.outbound.protection.outlook.com [40.107.74.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D316E05C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 01:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok8sUlkjEgXF5bsWPkrDgkZdiY5NTzTzPSOaHLr7Z4e1dd6kVOUz38laq3IRrMLoW31aVTWPKQ7QwhcWqk8UdNL9T0mgwA62TfvGlOjH4xkU0UJFBMCNfw7mbgpTC0FQgWBKDuwScY93shaqlV97/Poq18ioz4nUhxGn54eQw6hZ6qbG2H9iKatVoeNUTW5DS4ZjnKHMajPwxZZIvZTnX9DAF243ING8ArE8OBjd6O2E6n1LDVs/2OzunUjXFWGURBXEr7aGYpBXI7U7HPX/54dT58UMvMOQV21ORV6H0GZuMDcCK0b55I02gPa2bSjm0TqbFQutvWM62UQbbTMz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYwqneXMsDOwWXuEztx2NDTnzDWRvfgdDbs3GkW1zz4=;
 b=EEBN9mGl+aLX6O//dTrBfuauqF/P2hFYiYhQiI5WsJbsU37iyzL7zsV4Mi51j7Of9/+UEuWaVsbBTPd1jUJ9kwkMXJRlzcAFHwySJ/n4U01pSbB+NZ6QOXxicnACEU3r4CUfQ+IQSSUVCEL9i+uFI5LfxuagEBKcFrbhwuEddzOlJ7O8jcNrr3U78Lmwl7ESfUof7ifHVZ+01TEEZlfbFA3fnCxLX8/T/02fO7HOg7dgNeKaRV/Oc5gDYCRzuqo0vbjjr+uqR2/6rtMCea7GTPYE2c4IUN5duG0AKwjC71b5jtveWXiHGVsmA7uvDvaYUsIZ2HzHYqCoU5PjNF+QKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3415.namprd12.prod.outlook.com (20.178.52.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Tue, 29 Oct 2019 01:27:37 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::cd:2613:ee29:5acb]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::cd:2613:ee29:5acb%7]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 01:27:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: reset err_event_athub flag if gpu
 recovery succeeded
Thread-Topic: [PATCH 2/4] drm/amdgpu: reset err_event_athub flag if gpu
 recovery succeeded
Thread-Index: AQHVjYM966qPrhCaWU+iX6C19Ny86adw09Ag
Date: Tue, 29 Oct 2019 01:27:36 +0000
Message-ID:
 <BYAPR12MB280615A3803ADC31A4AE9C8EF1610@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
 <1572262269-14985-2-git-send-email-le.ma@amd.com>
In-Reply-To: <1572262269-14985-2-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c0381a3-5e7c-471b-f89a-08d75c0f2e89
x-ms-traffictypediagnostic: BYAPR12MB3415:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34151036269149B57CE8BC43F1610@BYAPR12MB3415.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(13464003)(189003)(199004)(8676002)(76176011)(33656002)(229853002)(256004)(14444005)(66556008)(52536014)(71190400001)(71200400001)(316002)(2906002)(6306002)(6506007)(7696005)(81156014)(66446008)(86362001)(9686003)(55016002)(2501003)(81166006)(66946007)(76116006)(6116002)(11346002)(99286004)(446003)(53546011)(486006)(476003)(8936002)(64756008)(3846002)(66476007)(966005)(25786009)(6436002)(305945005)(186003)(66066001)(6246003)(7736002)(5660300002)(26005)(74316002)(4326008)(14454004)(478600001)(110136005)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3415;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8+zjF+do0CY0SBXEQcrlpSKgNpA9KiQjPM+9h6P4+NvOgXjKTzghcPCAs7vHPlFelNZVys6nBcW25hRBIZYUrLdzI7yz50Lmya4UhuHkqoCZQpluOGacD+IhnJ1/nIC5hOBMFmklF4CpFKLu1AhLNLRRr1mNAvSwym52GBcNJMaB5jpRUp6aZdaQHk2GB6NHZ2DQfU+LlWEi7QmXicyjJzwH7R153mdpIHl5oOqdLdIFllbhtNmctD8uIY+uIcupn6CMEB+EryG4UdH1+aqhSAdw7/hUvtTmanqHts/OKCMVit2iOwR4aj2E1LkUwn1UUp+TrZ7xfuD1q1rIvqstqAge9kXj0wmBxAtRqludCncfI4hgqVLz50uii3eQVIOBU+U406SLRR6PbuPMJecN0ofAzTjBVxugNg3oHJ1J9YYSi3toDmYgJCL2Ar8diefEFMQjLru2LUUMo+1KB9iE88VnxxJpsXkCDgxssiNDZs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0381a3-5e7c-471b-f89a-08d75c0f2e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:27:37.0165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBz+GnM2sHzGtfgpyhKL9fdYqzAn5hux4rbLqeUTXCSnr/MEC76WjCvTBq+ccEUytCZX5ESz6C7kqMa33Rpw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYwqneXMsDOwWXuEztx2NDTnzDWRvfgdDbs3GkW1zz4=;
 b=TFMkJVZa3fI3sjQrlshsgzwXLccm+izKADcBLd50nNchV/hX3DCmQjrQXnzs4C2QalW7jMUm5cxcw0Yy80PCozcsNibDV9hJ2cSxJ/CHw/qP/K1AsAaZuQT3vLtw3NJ0Zo7ZEsEmXrAQzQGld8s5HVxJjxbaOGK3r8ZCIS4JcVk=
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
Cc: "Ma, Le" <Le.Ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029012736.J992-1o-Ts1R_47_Z3TlWT0JgP3nRaZq64z1sZwpceU@z>

DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFs
ZiBPZiBMZSBNYQ0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDI4LCAyMDE5IDc6MzEgUE0NClRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT4N
ClN1YmplY3Q6IFtQQVRDSCAyLzRdIGRybS9hbWRncHU6IHJlc2V0IGVycl9ldmVudF9hdGh1YiBm
bGFnIGlmIGdwdSByZWNvdmVyeSBzdWNjZWVkZWQNCg0KT3RoZXJ3aXNlIG5leHQgZXJyX2V2ZW50
X2F0aHViIGVycm9yIGNhbm5vdCBjYWxsIGdwdSByZXNldC4NCg0KQ2hhbmdlLUlkOiBJNWNkMjkz
ZjMwZjIzODc2YmYyYTE4NjA2ODFiY2I1MGY0NzcxM2VjZA0KU2lnbmVkLW9mZi1ieTogTGUgTWEg
PGxlLm1hQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KaW5kZXggNjc2Y2FkMS4u
NTFkNzRiYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQpAQCAtNDA4OSw2ICs0MDg5LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCQl9DQogCX0NCiANCisJaWYgKCFyICYmIGluX3Jh
c19pbnRyKQ0KKwkJYXRvbWljX3NldCgmYW1kZ3B1X3Jhc19pbl9pbnRyLCAwKTsNCltHdWNodW5d
VG8gYWNjZXNzIHRoaXMgYXRvbWljIHZhcmlhYmxlLCBtYXliZSBpdCdzIGJldHRlciB3ZSBjcmVh
dGUgYSBuZXcgZnVuY3Rpb24gbGlrZSByZXNldCBvciBjbGVhciBpbiBhbWRncHVfcmFzLmggb3Ig
LmMgZmlyc3QsIHRoZW4gd2UgY2FuIGNhbGwgdGhhdCBmdW5jdGlvbiBoZXJlLCBsaWtlIHdlIHdl
IGRvIHRvIGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQgaW4gdGhpcyBzYW1lIGZ1bmN0aW9uLiBU
aGlzIHdpbGwgZG8gYXNzaXN0IHRvIG1vZHVsYXJpdHkgb2YgcmFzIGRyaXZlci4NCg0KIHNraXBf
c2NoZWRfcmVzdW1lOg0KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlz
dF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpIHsNCiAJCS8qdW5sb2NrIGtmZDogU1JJT1Ygd291bGQg
ZG8gaXQgc2VwYXJhdGVseSAqLw0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
