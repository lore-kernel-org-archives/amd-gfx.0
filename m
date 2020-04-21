Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6B9C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419B520735
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 09:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1gkmoZJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419B520735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B416E8F6;
	Tue, 21 Apr 2020 09:50:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF796E8F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 09:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds4ihSEgaFgN+AmvStCphH20TxI/IIEl3Egb0TwMcNFDOQ/eKln+SpXcHRTkqUuubMZ/OWdOpi3QH2OAWrwnm3yIctITkbPR+c6SiieO1tafX4J7G50eW7OzlhnGNVcqMiRbRY94CkEIg9IsWj6Y09CV4p2fKjRQZFdvWERaJLrkGKBkSw2p/N3BpkulcH48Jam6it/SwudJn23Pf1HwsOjJxRjDml5/OpQj/FC6vCROiXNhE7NO7QkYCUcUbZ346zvUQlIJjMHDfXtkT2fh93SStniLiQ1aS1xxI5Kiwygj/KeCLxJcGD2RAXtvYKFKjzM4/rEpMkcGCwSgUDf3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXfKOZ857bAWCxysGl6b73tseiFJwQfdSgJFHwLb8l0=;
 b=XJrC8YQuJX+RoqvfSjvj6qau6DawJWlirFFMyy5qgbiQXMpiJJoKLEBe/v0iNRbuaH+il3noheh+ty/3fefjiIhE+gcPAYjJmJFkP+35P7wX1GM8Glj2qCkgDuQj5IwWJ2kUHtt5sz5CtY+n5IN1xXQ+cScPVjn7ELywCV9tIMPe5eyInQz7hy4aGPuihgX1CnLre6iaX7AFRIy6ujniC0jLkLh9Xdgkgua9N9J54skDoR4tZXBILnfH+X/7iEmfqwonf2yp8tEQ8iBQdSfyJ9/3pl5swWFXsOZ0H4u9F5iJznou00WuymB3DlIrILDV4Dy9sfHy0h1UxGxnG7kdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXfKOZ857bAWCxysGl6b73tseiFJwQfdSgJFHwLb8l0=;
 b=1gkmoZJ5x0vjax5rEfh0UwpQQSCjMbqXbfH9f4+TTVHYO/eGrznY/DOsH5lJTgJHL3p2NHuhLfWZcKFbTvuMkaRxGbiLTX9IuanDGUDiBajQVWrcb+cdkqyYvjKLrF8DzT4+9JBET3/ofOx4lGIbeyKYXLMVV12fS4mxea7Aqcw=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 09:50:28 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::a8d8:ad45:3232:f8bd%8]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 09:50:28 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Tao, Yintian" <Yintian.Tao@amd.com>, "He, Jacob" <Jacob.He@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Topic: [PATCH] drm/amdgpu: cleanup SPM VMID update
Thread-Index: AQHWF7ynCIwJx8CEhk+r7oFgdDlF66iDUzVA
Date: Tue, 21 Apr 2020 09:50:28 +0000
Message-ID: <DM5PR12MB1708FB16B9145F9E146D97F984D50@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200421091004.130041-1-christian.koenig@amd.com>
In-Reply-To: <20200421091004.130041-1-christian.koenig@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74b8fb48-eeff-490d-aa69-08d7e5d96c69
x-ms-traffictypediagnostic: DM5PR12MB1786:|DM5PR12MB1786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17869AAB0AD64574244040A184D50@DM5PR12MB1786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(9686003)(478600001)(110136005)(4326008)(55016002)(66946007)(66446008)(66556008)(66476007)(52536014)(33656002)(71200400001)(66574012)(76116006)(64756008)(5660300002)(7696005)(86362001)(316002)(186003)(8936002)(81156014)(26005)(8676002)(15650500001)(2906002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ccZ5BV+KeXlm1cKuLtTdQnvi3qvP90AX+lZPZXnvzSBRKKpWQEVEaBmzgK2CW0Jb0y68CgxW8LEpEn9HW4Z5Qr93sZWhNzUCnHC56aS43dVRrFGtBd3jOKYEb6TFq6JJfT2ne1on2o4LChzCw7oSBpW07WDq2vY5gIBQV+mU3ZPzXOyvAOak6KDLwR6LkFL0sFhfu4oDOmrfRjY1keiBTm0R6mrDkAYBk/J3G8RPe1zKSo0g5TzqHgPhofgTeyyX6q621wJyOFu/sCWpz+ULw35ySM6QErRafI3QYm5XBtQx49svRPXHWU0YgVUr8da6h/4z0bTiunSyErM40e/qvlyuhwr79M3tYOtyc/Gm2vxKkRyUzUKpMr0TaAJC/jFEMhzIkWJnWUOr8cPGO0q8NGKjfS4Yw552X/vgnP10FavBEnUVYEVWwNOPl2V9YhT
x-ms-exchange-antispam-messagedata: ebvdu7fg5ZsPs+fLJcT1cP0rt9m+ln4qMWzt19Ult8AeFvWbvL1fuXQ3KMEMkwZysFqg+M3i63qTBaBBe1BLbtk53jT+GCiLZZ1pY8YEXQGW9D+9ilNjkHYjBwh+A6s92jKyASEUWiCte+k7gKIyEQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b8fb48-eeff-490d-aa69-08d7e5d96c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 09:50:28.3693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvN1rOoL4Ud5EcY5+wGWyyu/C+mkM35SPOKKXXpEtcT1ZrOTtJyKM73g2+3JQgbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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

Q2hyaXN0aWFuDQoNCk1hbnkgZmllbGRzIGxvb2tzIG5vdCBsaWtlIGdvaW5nIHRvIGJlIHN0aWxs
ICB2YWx1ZSBhdCBhbGwsIGUuZy46DQoNClJMQ19TUE1fUEVSRl9DTlRSCTUJMHgwCVBFUkZfQ05U
UiB0aGF0IGlzIHVzZWQgYnkgUkxDIGZvciBtZW1vcnkgdHJhbnNhY3Rpb25zDQoNCkJ5IHlvdXIg
Y2hhbmdlIHlvdSBhbHdheXMgc2V0IGFib3ZlIGZpbGVkIHRvIDAsICBpcyBpdCByaWdodCA/IEkg
cmVhbGx5IGRvdWJ0IGl0IA0KDQpCZXNpZGU6IHRvIG1ha2UgU1JJT1YgVkYgbGVzcyBwYWluZnVs
IHBsZWFzZSB1c2UgTk9LSVEgdmVyc2lvbiByZWFkL3dyaXRlIGlmICJvbmUgdmYgbW9kZSIgaXMg
ZGV0ZWN0ZWQgOg0KDQphbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpDQoNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0
aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJp
c3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBU
dWVzZGF5LCBBcHJpbCAyMSwgMjAyMCA1OjEwIFBNDQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBh
bWQuY29tPjsgVGFvLCBZaW50aWFuIDxZaW50aWFuLlRhb0BhbWQuY29tPjsgSGUsIEphY29iIDxK
YWNvYi5IZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBHdSwg
RnJhbnMgPEZyYW5zLkd1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGNs
ZWFudXAgU1BNIFZNSUQgdXBkYXRlDQoNClRoZSBSTEMgU1BNIGNvbmZpZ3VyYXRpb24gcmVnaXN0
ZXIgY29udGFpbnMgdGhlIGluZm9ybWF0aW9uIGhvdyB0aGUgbWVtb3J5IGFjY2VzcyBpcyBtYWRl
IChWTUlELCBNVFlQRSwgZXRjLi4uLikgd2hpY2ggc2hvdWxkIGFsd2F5cyBiZSBjb25zaXN0ZW50
Lg0KDQpTbyBpbnN0ZWFkIG9mIGEgcmVhZCBtb2RpZnkgd3JpdGUgY3ljbGUgb2YgdGhlIFZNSUQg
YWx3YXlzIHVwZGF0ZSB0aGUgd2hvbGUgcmVnaXN0ZXIuDQoNClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNyArLS0tLS0tICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjdfMC5jICB8IDcgKy0tLS0tLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYyAgfCA3ICstLS0tLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgIHwgNyArLS0tLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDI0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
Yw0KaW5kZXggMGEwM2UyYWQ1ZDk1Li4yYTY1NTYzNzEwNDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCkBAIC03MDMwLDEyICs3MDMwLDcgQEAgc3RhdGljIGludCBn
ZnhfdjEwXzBfdXBkYXRlX2dmeF9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsDQogDQogc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3VwZGF0ZV9zcG1fdm1pZChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgdm1pZCkgIHsNCi0JdTMyIGRhdGE7DQotDQotCWRh
dGEgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX1NQTV9NQ19DTlRMKTsNCi0NCi0JZGF0YSAm
PSB+UkxDX1NQTV9NQ19DTlRMX19STENfU1BNX1ZNSURfTUFTSzsNCi0JZGF0YSB8PSAodm1pZCAm
IFJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0spIDw8IFJMQ19TUE1fTUNfQ05UTF9f
UkxDX1NQTV9WTUlEX19TSElGVDsNCisJdTMyIGRhdGEgPSBSRUdfU0VUX0ZJRUxEKDAsIFJMQ19T
UE1fTUNfQ05UTCwgUkxDX1NQTV9WTUlELCB2bWlkKTsNCiANCiAJV1JFRzMyX1NPQzE1KEdDLCAw
LCBtbVJMQ19TUE1fTUNfQ05UTCwgZGF0YSk7ICB9IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuYw0KaW5kZXggYjJmMTBlMzllZmYxLi5hOTI0ODZjZDAzOGYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jDQpAQCAtMzU3MCwxMiArMzU3MCw3IEBAIHN0YXRpYyBp
bnQgZ2Z4X3Y3XzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiANCiBz
dGF0aWMgdm9pZCBnZnhfdjdfMF91cGRhdGVfc3BtX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHVuc2lnbmVkIHZtaWQpICB7DQotCXUzMiBkYXRhOw0KLQ0KLQlkYXRhID0gUlJFRzMy
KG1tUkxDX1NQTV9WTUlEKTsNCi0NCi0JZGF0YSAmPSB+UkxDX1NQTV9WTUlEX19STENfU1BNX1ZN
SURfTUFTSzsNCi0JZGF0YSB8PSAodm1pZCAmIFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX01B
U0spIDw8IFJMQ19TUE1fVk1JRF9fUkxDX1NQTV9WTUlEX19TSElGVDsNCisJdTMyIGRhdGEgPSBS
RUdfU0VUX0ZJRUxEKDAsIFJMQ19TUE1fVk1JRCwgUkxDX1NQTV9WTUlELCB2bWlkKTsNCiANCiAJ
V1JFRzMyKG1tUkxDX1NQTV9WTUlELCBkYXRhKTsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OF8wLmMNCmluZGV4IGZjNmMyZjJiYzc2Yy4uNDRmZGRhNjhkYjk4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KQEAgLTU2MTMsMTIgKzU2MTMsNyBAQCBzdGF0
aWMgdm9pZCBnZnhfdjhfMF91bnNldF9zYWZlX21vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogDQogc3RhdGljIHZvaWQgZ2Z4X3Y4XzBfdXBkYXRlX3NwbV92bWlkKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCB2bWlkKSAgew0KLQl1MzIgZGF0YTsNCi0NCi0JZGF0
YSA9IFJSRUczMihtbVJMQ19TUE1fVk1JRCk7DQotDQotCWRhdGEgJj0gflJMQ19TUE1fVk1JRF9f
UkxDX1NQTV9WTUlEX01BU0s7DQotCWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX1ZNSURfX1JMQ19T
UE1fVk1JRF9NQVNLKSA8PCBSTENfU1BNX1ZNSURfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQorCXUz
MiBkYXRhID0gUkVHX1NFVF9GSUVMRCgwLCBSTENfU1BNX1ZNSUQsIFJMQ19TUE1fVk1JRCwgdm1p
ZCk7DQogDQogCVdSRUczMihtbVJMQ19TUE1fVk1JRCwgZGF0YSk7DQogfQ0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQppbmRleCA1NGVkZWQ5YTZhYzUuLmIzNmZiZjk5MTMxMyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCkBAIC00OTUwLDEyICs0OTUw
LDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF91cGRhdGVfZ2Z4X2Nsb2NrX2dhdGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwNCiANCiBzdGF0aWMgdm9pZCBnZnhfdjlfMF91cGRhdGVfc3Bt
X3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHZtaWQpICB7DQotCXUz
MiBkYXRhOw0KLQ0KLQlkYXRhID0gUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19TUE1fTUNfQ05U
TCk7DQotDQotCWRhdGEgJj0gflJMQ19TUE1fTUNfQ05UTF9fUkxDX1NQTV9WTUlEX01BU0s7DQot
CWRhdGEgfD0gKHZtaWQgJiBSTENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9NQVNLKSA8PCBS
TENfU1BNX01DX0NOVExfX1JMQ19TUE1fVk1JRF9fU0hJRlQ7DQorCXUzMiBkYXRhID0gUkVHX1NF
VF9GSUVMRCgwLCBSTENfU1BNX01DX0NOVEwsIFJMQ19TUE1fVk1JRCwgdm1pZCk7DQogDQogCVdS
RUczMl9TT0MxNShHQywgMCwgbW1STENfU1BNX01DX0NOVEwsIGRhdGEpOyAgfQ0KLS0NCjIuMTcu
MQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
