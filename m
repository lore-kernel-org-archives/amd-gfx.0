Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8FFC54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B975021473
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SMz4+eBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BCD6E8F5;
	Tue, 21 Apr 2020 09:45:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9CF6E8F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 09:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6u4F/zNsFfUDFPJ87ysQTeKvFKf+gQgzb+IULkQ8hUxTFT9p/uOQ+k0yFT1tUvn7DiUpKKAzVvSZcQ7CcvZw3p8EQD91SfeQ30ZMUz2klQ3ehloiGA/QMOH+nI5o9Gc6H0w5P8rR74P9WCPVIrV2gDuMTPkXeZ6CED0tCu+M9ualFrijy00ELIqiJR1I5ifWu8ZrY6jKDlSuBZijhHedAjLbXm45Tk58nkFaF3mIfgZH+9lUPVwvw+wEwrxjjM/3P9TNSL2cWQ2gxEcbz//5JY2epXNNgxm3KBKNawRwWe/Z3KLd7ph/vgocr9Ig5+hhqKvc8QLyS1ORFPEswjabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilQI4COHpE3wSeKYdOmI910wsijMCUu1+BojhVNLzRk=;
 b=ev6WionF+ghbncxVPmXg/pIntX9xkng8a52JBl/MWW2hQyWpTRfqpzttLBRPebQEZa2AgWYGnLzfVQO7si1OjbpDThuX3ZOVXlTyxURQglPdrub6rmz7nj3fidj6C5PQf8JjPg8Vp9tf/+TA2vEYRrhEUkKknLRZIW7eyStL03IZNVUCWSw3luo5sQTySjer5fLtN2LpIyKrP73BKJBo2WydHPI48++jkGuO+pwWdlpLkqh1wepF0HpXV/6QCVnGF1QPFe/4WsnWZ2aLTta4QrN+zET7Nhb2CfzgO1whXw+aKYFJM6V6UPwCgxHT02XSgnkUOA83OAbi63gqeUHPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilQI4COHpE3wSeKYdOmI910wsijMCUu1+BojhVNLzRk=;
 b=SMz4+eBlqGJgIrib+klq3n25jm53WUSz/Rebv7IIf5nIrRsOhHvXlYqsA2ilRAAg5g30wHmFF8JMxZaj5iBx2puVTQI9ulUXyeFYTtdE9TpAPbqK1A5/7vZ7dlAEk3uNO5ve+5I4ZXLAeOkhKKAeMPQxQe+mtBANL5zuhMx03WM=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 09:45:42 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 09:45:41 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Topic: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Index: AQHWF7ynkmS/Im2lZk2HK+qrwvw0PaiDU1iA
Date: Tue, 21 Apr 2020 09:45:41 +0000
Message-ID: <MN2PR12MB30398FD163EB6424F5E8E502E5D50@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <20200421091004.130041-1-christian.koenig@amd.com>
In-Reply-To: <20200421091004.130041-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d99e12c-df16-49ad-cc79-08d7e5d8c185
x-ms-traffictypediagnostic: MN2PR12MB4303:|MN2PR12MB4303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB430384E0FA9ABD896C2252CDE5D50@MN2PR12MB4303.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(478600001)(55016002)(64756008)(76116006)(66446008)(8676002)(6506007)(66946007)(66476007)(66556008)(15650500001)(8936002)(71200400001)(81156014)(4326008)(2906002)(316002)(26005)(53546011)(86362001)(110136005)(52536014)(9686003)(33656002)(7696005)(66574012)(186003)(5660300002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Koc6nacyv5JzgvIEo6LPPd6p3bmSVqo2D8T6MgbpFS77dNw6pV9sKgIUCp+1hDR9gcoVEMk6POqB2Df6UrLBu4e6xv4VbELBcFxneq3dftP8H0mpkBLDAeW0SbYdeaxYL8neW2uOgVchyN7Ujqk009OBck+8m6cIb0hbV7nA/Y6JBci1Oik6vxBuKfCqI9fbCCKjL+wOlffryPyyrgYKk3C5pwaHAjVQvIXhxblkEHmhiO1tWRCFrCUUUsGtdXj25cidVeOWk5rUKF7Nwb9065PgwpZq85txkjgOKYxvkfdFvr1bfGzSEuG0/J5GyLdOUfDXoVZfAvGyfxepZxfBKP+vKAqvZ8AQKrxuNJoS7B7P/y+3jYTyw8uU+0Gok81bbQTtKzrFgOETmtSGhp0fSzcgzdX4AN38Aj3PjBmksUMSYCpq0QK2YCx+oUzzV+1W
x-ms-exchange-antispam-messagedata: Uw1O6YWFRCDEXzZ22zQm5VNPOJporUXPS1oxj1pM3AQQJRXw9yN4rn6WTeUuqE1un2hhe1Ioayt6fZk6/fsXO+3yEknEyYh/y7yE+kehRU8jUEN7j9/2oBjWOHlns9yx0i9B1WKUoK0VhTuw1kQw2Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d99e12c-df16-49ad-cc79-08d7e5d8c185
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 09:45:41.3935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3A++rhwFYUzARe1pOg0IYinEDcMufqWGybXQ7DcWti1D4NEO49IISIE6bM0CnZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: "Gu, Frans" <Frans.Gu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxj
a29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiAyMDIw5bm0NOaciDIx5pel
IDE3OjEwDQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgVGFvLCBZaW50aWFuIDxZ
aW50aWFuLlRhb0BhbWQuY29tPjsgSGUsIEphY29iIDxKYWNvYi5IZUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBHdSwgRnJhbnMgPEZyYW5zLkd1QGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGNsZWFudXAgU1BNIFZNSUQgdXBkYXRlDQoN
ClRoZSBSTEMgU1BNIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgY29udGFpbnMgdGhlIGluZm9ybWF0
aW9uIGhvdyB0aGUgbWVtb3J5IGFjY2VzcyBpcyBtYWRlIChWTUlELCBNVFlQRSwgZXRjLi4uLikg
d2hpY2ggc2hvdWxkIGFsd2F5cyBiZSBjb25zaXN0ZW50Lg0KDQpTbyBpbnN0ZWFkIG9mIGEgcmVh
ZCBtb2RpZnkgd3JpdGUgY3ljbGUgb2YgdGhlIFZNSUQgYWx3YXlzIHVwZGF0ZSB0aGUgd2hvbGUg
cmVnaXN0ZXIuDQoNClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jIHwgNyArLS0tLS0tICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jICB8
IDcgKy0tLS0tLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgfCA3ICst
LS0tLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgIHwgNyArLS0tLS0t
DQogNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KaW5kZXggMGEwM2UyYWQ1ZDk1Li4y
YTY1NTYzNzEwNDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBA
IC03MDMwLDEyICs3MDMwLDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfdXBkYXRlX2dmeF9jbG9j
a19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogDQogc3RhdGljIHZvaWQgZ2Z4
X3YxMF8wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWdu
ZWQgdm1pZCkgIHsNCi0JdTMyIGRhdGE7DQotDQotCWRhdGEgPSBSUkVHMzJfU09DMTUoR0MsIDAs
IG1tUkxDX1NQTV9NQ19DTlRMKTsNCi0NCi0JZGF0YSAmPSB+UkxDX1NQTV9NQ19DTlRMX19STENf
U1BNX1ZNSURfTUFTSzsNCi0JZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQ
TV9WTUlEX01BU0spIDw8IFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX19TSElGVDsNCisJ
dTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19TUE1fTUNfQ05UTCwgUkxDX1NQTV9WTUlE
LCB2bWlkKTsNClt5dHRhb106IFRoZSBvcmlnX3ZhbCBpcyAwIHdoaWNoIG1lYW5zIGV4Y2VwdCBW
TUlEIGZpZWxkIG90aGVyIHJlc2V0IGZpZWxkcyB3aWxsIGJlIHNldCB0byAwLiBXaGV0aGVyIGl0
IGlzIGxlZ2FsPw0KIA0KIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMLCBk
YXRhKTsgIH0gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jDQppbmRleCBiMmYxMGUz
OWVmZjEuLmE5MjQ4NmNkMDM4ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92N18wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18w
LmMNCkBAIC0zNTcwLDEyICszNTcwLDcgQEAgc3RhdGljIGludCBnZnhfdjdfMF9ybGNfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KIA0KIHN0YXRpYyB2b2lkIGdmeF92N18wX3Vw
ZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkg
IHsNCi0JdTMyIGRhdGE7DQotDQotCWRhdGEgPSBSUkVHMzIobW1STENfU1BNX1ZNSUQpOw0KLQ0K
LQlkYXRhICY9IH5STENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9NQVNLOw0KLQlkYXRhIHw9ICh2
bWlkICYgUkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfTUFTSykgPDwgUkxDX1NQTV9WTUlEX19S
TENfU1BNX1ZNSURfX1NISUZUOw0KKwl1MzIgZGF0YSA9IFJFR19TRVRfRklFTEQoMCwgUkxDX1NQ
TV9WTUlELCBSTENfU1BNX1ZNSUQsIHZtaWQpOw0KIA0KIAlXUkVHMzIobW1STENfU1BNX1ZNSUQs
IGRhdGEpOw0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KaW5kZXggZmM2
YzJmMmJjNzZjLi40NGZkZGE2OGRiOTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjhfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jDQpAQCAtNTYxMywxMiArNTYxMyw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OF8wX3Vuc2V0
X3NhZmVfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiANCiBzdGF0aWMgdm9pZCBn
ZnhfdjhfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2ln
bmVkIHZtaWQpICB7DQotCXUzMiBkYXRhOw0KLQ0KLQlkYXRhID0gUlJFRzMyKG1tUkxDX1NQTV9W
TUlEKTsNCi0NCi0JZGF0YSAmPSB+UkxDX1NQTV9WTUlEX19STENfU1BNX1ZNSURfTUFTSzsNCi0J
ZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19T
UE1fVk1JRF9fUkxDX1NQTV9WTUlEX19TSElGVDsNCisJdTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxE
KDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlkKTsNCiANCiAJV1JFRzMyKG1tUkxD
X1NQTV9WTUlELCBkYXRhKTsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
CmluZGV4IDU0ZWRlZDlhNmFjNS4uYjM2ZmJmOTkxMzEzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYw0KQEAgLTQ5NTAsMTIgKzQ5NTAsNyBAQCBzdGF0aWMgaW50IGdmeF92
OV8wX3VwZGF0ZV9nZnhfY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0K
IA0KIHN0YXRpYyB2b2lkIGdmeF92OV8wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkgIHsNCi0JdTMyIGRhdGE7DQotDQotCWRhdGEgPSBS
UkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsNCi0NCi0JZGF0YSAmPSB+UkxD
X1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSzsNCi0JZGF0YSB8PSAodm1pZCAmIFJMQ19T
UE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQ
TV9WTUlEX19TSElGVDsNCisJdTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19TUE1fTUNf
Q05UTCwgUkxDX1NQTV9WTUlELCB2bWlkKTsNCiANCiAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJM
Q19TUE1fTUNfQ05UTCwgZGF0YSk7ICB9DQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
