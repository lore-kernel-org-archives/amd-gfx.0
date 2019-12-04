Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C8BC43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C727820675
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C727820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741466E891;
	Wed,  4 Dec 2019 08:13:34 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740043.outbound.protection.outlook.com [40.107.74.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B175C6E891
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 08:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA5knc6cSdM6lTf3hbLQ+hBIixnr7jakZFIMkLWM9uuMzhsxcrCbQc368OtJBmbPNtHxua+5sYTAp7/KonKJLlV5qTzG3np/L0VM87tdx5SRqLyjAZK9fKtvSntnt/NpXRtSVoRWcU4rp/mctscXFggTJ+btPgM6S1ai89M3r7LykT7uh085KAjd08zY2PkjpY69knvGKM8QIEF6xP1XqhwemhNedFSJV4Qv1Q5WLwzVXGORu3BFglQPDGgAbQ6cmm9yVkLC1PBx8o7XYw2kEMZJiwEGNefJaUXxhhu0DY9N2keeV6xsdx8ZLeVbs64inTe1lN0A3dgKsKdQT58TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB0PyT2FJIn4uJritHyMznmeJzNpGAQR9tppmGpl9dw=;
 b=dplk3/QPwWH+C3et8E2YdXwqoLlc1hCbRu8I8JxErOlYBXs1uo3qOge43Nk9WeTtcycSKTU2RJA/cBDzuwY+OmLimO46X8ZnYh1Ak6WOXXTLOaLeo33YTmkyT67uDk7hx/f8SMduIkzQarO6E9bYFcQOO4AXxPLhRDTWjxFBAIaCoJSxKhtOVtmegvD3fxx0MOwKAIt6cZtVTpG88/6Qp+eHNhzDoF6qYNrKze7pKLhjOPps6SVekEBMNfwKeYPRKgUkhoj7g/zG7X9szCcdJemYTPPSPa0Q0yQT6f6WRibLlzVI5vjqPpAoSOrCSBnHq/DpllbZpeJ2+BE9wx+VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1388.namprd12.prod.outlook.com (10.168.239.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 08:13:30 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 08:13:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add check before enabling/disabling broadcast
 mode
Thread-Topic: [PATCH] drm/amdgpu: add check before enabling/disabling
 broadcast mode
Thread-Index: AQHVqnjule3LNT256kiCHKNIXRsMVaepntgg
Date: Wed, 4 Dec 2019 08:13:30 +0000
Message-ID: <DM5PR12MB14184AFF92C3430194D1BABBFC5D0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191204080024.7229-1-guchun.chen@amd.com>
In-Reply-To: <20191204080024.7229-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e11849b-adf9-43aa-5b9d-08d77891d919
x-ms-traffictypediagnostic: DM5PR12MB1388:|DM5PR12MB1388:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1388FD600CB2EE9934A920E9FC5D0@DM5PR12MB1388.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(13464003)(15404003)(71190400001)(3846002)(2906002)(55016002)(9686003)(66476007)(64756008)(66446008)(6636002)(76116006)(66556008)(6116002)(6436002)(33656002)(66946007)(229853002)(2501003)(7696005)(5660300002)(25786009)(6246003)(478600001)(14444005)(256004)(99286004)(7736002)(8936002)(14454004)(76176011)(81166006)(52536014)(186003)(8676002)(305945005)(316002)(6506007)(71200400001)(26005)(53546011)(74316002)(102836004)(446003)(86362001)(11346002)(110136005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1388;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z572927nyHvCTWh/due+azXeZvwzOSJ2/tAyqZFTMs+5Jzu1xzPEvhJ5INxmRE3j+2+EzAK47muRs2WGEgsG4OaLUUBtAAkh74MoPwGcy3fsxdPz7nik8Vr09cCoFYsDIPGZeLYDblG3JorSrlXwMNWk7R5ep4bkCk9eQNM5C1LWLMs8QUg1cezn/cOB4QuAIdgXZd8PIPOxymAzDoPUU0Fd6h1R+svWuekurXJg6o2mZGHqz1LuhLVV/N2cTSsqGlNe0hF7lQLqgd09ZhHkXqY2cjCGSerPN8igg8rWfg4aJ//ylJ8dRm/Yb+EnQPFI83M1XKbp3F3OhMH4HkiPJv/p93XmTZxteFbtpVyWACwEIxDtGHeJWrhPjp/oPylFF9CXYc5i9hhbHC+zbqd4ru9cNkBbPFEafUfAZyNZ5k8ur/1M8R+T9BnqXduV0x21xfJFKK72AwqcOdgq3VVa5B1o0yH/9Wbo4cmV15XPQHJX1RYaFPXv3SfyR1HqXcn+/ztkRdxDERmo9WfWm+jnfg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e11849b-adf9-43aa-5b9d-08d77891d919
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 08:13:30.2204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiVxGwdr8Zzjq5hXm+qlOj4NkKGmALLbd2tL4Ifo0cdsaqDHslG14AAUUdUIMlF/ImrTiefCWPRKDWX/rqvmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1388
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB0PyT2FJIn4uJritHyMznmeJzNpGAQR9tppmGpl9dw=;
 b=MgIMi3BD4cgyfbSKp3nbbG3+jdwzilvfWDWUgcE21YofiWTxFSrp3R4IwWL6DkJx8jwxquz4Zbqi8cQakr6JDBWq2G3vlX83qsKbSyLL8NCVq1rqS3HW1NKOU21CIbJI29KxsdaXKmN/0jYLB6RNXAG9GfgSZwVguPV320LE2RA=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KVG8g
YmUgbW9yZSBhY2N1cmF0ZSwgd2hlbiBzZWN1cml0eSB2aW9sYXRpb24gaGFwcGVucywgREYgaXMg
aW4gcmlzayB0byBzdG9wIHdvcmtpbmcuIFRoZSBkaXJlY3QgYWNjZXNzIHRvIG1tRmFicmljQ29u
ZmlnQWNjZXNzQ29udHJvbCBzaG91bGQgYmUgcHJldmVudGVkIGZyb20gVkJJT1MgIzU1IGFuZCBv
bndhcmRzLiANCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+IA0KU2VudDogMjAxOeW5
tDEy5pyINOaXpSAxNjowMA0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5A
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIGNoZWNrIGJlZm9yZSBl
bmFibGluZy9kaXNhYmxpbmcgYnJvYWRjYXN0IG1vZGUNCg0KRHVlIHRvIG5ldyB2YmlvcyBzZWN1
cml0eSBwb2xpY3kgY2hhbmdlIGFuZCBsYWNrIG9mIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IGlu
dGVyZmFjZSwgaGFuZyB3aWxsIGhhcHBlbiB3aGVuIGRhdGEgZmFicmljIHVwZGF0ZXMgY2xvY2sg
Z2F0aW5nIG9uIHZlZ2EyMC4gU28gYWRkIG9uZSBjaGVjayBiZWZvcmUgcHJvY2Vzc2luZyBkYXRh
IGZhYnJpYyBicm9hZGNhc3QgbW9kZSB0byBieXBhc3MgdGhpcyBvbiB2ZWdhMjAuDQoNClNpZ25l
ZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jIHwgMzggKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYw0KaW5kZXggNzJiZmVmZGJmYTY1
Li45Mzk1YWE4YjhmZDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9k
Zl92M182LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYw0KQEAg
LTI2OCwyMyArMjY4LDI5IEBAIHN0YXRpYyB2b2lkIGRmX3YzXzZfdXBkYXRlX21lZGl1bV9ncmFp
bl9jbG9ja19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsICB7DQogCXUzMiB0bXA7
DQogDQotCS8qIFB1dCBERiBvbiBicm9hZGNhc3QgbW9kZSAqLw0KLQlhZGV2LT5kZl9mdW5jcy0+
ZW5hYmxlX2Jyb2FkY2FzdF9tb2RlKGFkZXYsIHRydWUpOw0KLQ0KLQlpZiAoZW5hYmxlICYmIChh
ZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX0RGX01HQ0cpKSB7DQotCQl0bXAgPSBSUkVH
MzJfU09DMTUoREYsIDAsIG1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlcik7DQotCQl0bXAg
Jj0gfkRGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXJfX01HQ0dNb2RlX01BU0s7DQotCQl0bXAg
fD0gREZfVjNfNl9NR0NHX0VOQUJMRV8xNV9DWUNMRV9ERUxBWTsNCi0JCVdSRUczMl9TT0MxNShE
RiwgMCwgbW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyLCB0bXApOw0KLQl9IGVsc2Ugew0K
LQkJdG1wID0gUlJFRzMyX1NPQzE1KERGLCAwLCBtbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0
ZXIpOw0KLQkJdG1wICY9IH5ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyX19NR0NHTW9kZV9N
QVNLOw0KLQkJdG1wIHw9IERGX1YzXzZfTUdDR19ESVNBQkxFOw0KLQkJV1JFRzMyX1NPQzE1KERG
LCAwLCBtbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXIsIHRtcCk7DQotCX0NCisJaWYgKGFk
ZXYtPmNnX2ZsYWdzICYgQU1EX0NHX1NVUFBPUlRfREZfTUdDRykgew0KKwkJLyogUHV0IERGIG9u
IGJyb2FkY2FzdCBtb2RlICovDQorCQlhZGV2LT5kZl9mdW5jcy0+ZW5hYmxlX2Jyb2FkY2FzdF9t
b2RlKGFkZXYsIHRydWUpOw0KKw0KKwkJaWYgKGVuYWJsZSkgew0KKwkJCXRtcCA9IFJSRUczMl9T
T0MxNShERiwgMCwNCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlcik7DQorCQkJ
dG1wICY9IH5ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyX19NR0NHTW9kZV9NQVNLOw0KKwkJ
CXRtcCB8PSBERl9WM182X01HQ0dfRU5BQkxFXzE1X0NZQ0xFX0RFTEFZOw0KKwkJCVdSRUczMl9T
T0MxNShERiwgMCwNCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlciwgdG1wKTsN
CisJCX0gZWxzZSB7DQorCQkJdG1wID0gUlJFRzMyX1NPQzE1KERGLCAwLA0KKwkJCQkJbW1ERl9Q
SUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyKTsNCisJCQl0bXAgJj0gfkRGX1BJRV9BT04wX0RmR2xv
YmFsQ2xrR2F0ZXJfX01HQ0dNb2RlX01BU0s7DQorCQkJdG1wIHw9IERGX1YzXzZfTUdDR19ESVNB
QkxFOw0KKwkJCVdSRUczMl9TT0MxNShERiwgMCwNCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9i
YWxDbGtHYXRlciwgdG1wKTsNCisJCX0NCiANCi0JLyogRXhpdCBicm9hZGNhc3QgbW9kZSAqLw0K
LQlhZGV2LT5kZl9mdW5jcy0+ZW5hYmxlX2Jyb2FkY2FzdF9tb2RlKGFkZXYsIGZhbHNlKTsNCisJ
CS8qIEV4aXQgYnJvYWRjYXN0IG1vZGUgKi8NCisJCWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfYnJv
YWRjYXN0X21vZGUoYWRldiwgZmFsc2UpOw0KKwl9DQogfQ0KIA0KIHN0YXRpYyB2b2lkIGRmX3Yz
XzZfZ2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KLS0N
CjIuMTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
