Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7827C4BA35
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 02:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D83222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 02:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eN5cGV8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D83222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189926E3A6;
	Thu, 27 Feb 2020 02:03:10 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690040.outbound.protection.outlook.com [40.107.69.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735516E3A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 02:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb4Udpf2+m9gTFCmQYgBnMhJmBDsSu/k60tcHvvNvjJxSCPmoNIvY8b0YqYsKKDDAlud095JKSm9bESnZ+JzcCStLfP4vHYcRQexGKp568vEzIrMs5X49hvggT1d/vE8b3dwTmPzPoVOU/X4sysOebDYjKBJrNxQXQvGYBLhUM9/VETyqccgSxIorHuerK3BM1mnhIEb6vmNyglnwA4kPLn6AadjX+A2FvZEB4J/M5JwFrOngc62AWUT0XSSzUsCe2+2vYfB0Y7vsq57ItWmWD+bjHghJ6cW2q1lBS5/+NWXdovn5hef/RaHyWYixreqW1yOkCogFnkKDMNthSuHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufeJ6XiUgofEFpMih2/3ghZ+mObmc/dyEXRFOC2HdKE=;
 b=Gs3aEVOOvONeBUBWwMCUHInAST7r3N/C/Cyd2ysZzCCXWo05IKeV5RHDFLmYqaoz+mmR7aLWUTefb5ILuH3wGQT2K5MFwoy3FW0VmH3EYliUH/Y4SMBHelK4HII3vIYy+F9cXal6SiDSH/dNIwnNNxeGL79gk8tk++PQcin20D9hwekMw0W5sJG8N3qB3dLrQtRsbDJGLOqG32aeMRVSm8Zas/vKB+jm8I0UkTCqGpuvpAL7bnGiRcqF94ds3M9l4UVlGqILaorG3lrmUdlbGqkXeBd0NEXZtpTit6HVDC7KS7rnwY/Ci2JaJwHhhEL5Cm0NcORgYS60KHpE0ZOXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufeJ6XiUgofEFpMih2/3ghZ+mObmc/dyEXRFOC2HdKE=;
 b=eN5cGV8sN125+ROlmNBPfmeuURH35sP1wy6WTGAssY2zao02TLjm6L9OlLmL55hplO7TrvTYCGbOnZ9oPUK7guWBbn2W4llFkRcUxBjD5gZcvaVp6JFfqaqtA07Xdsc9/fqSvFjG9UZXM36JmTS8WUwi7/afsuVs884usILgIS0=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 02:03:07 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593%3]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 02:03:07 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Topic: [PATCH] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Index: AQHV7F4D3CwZ1fNOQkKvDQmzR2JxqagtiakAgADAwtA=
Date: Thu, 27 Feb 2020 02:03:06 +0000
Message-ID: <MN2PR12MB2975FEC3ACF49D022233E3598FEB0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1582691649-4876-1-git-send-email-Emily.Deng@amd.com>
 <CADnq5_NEnQoDRQzyk4v9Nie+qUJo3q5eZUGoC1j+CoY+SG25hg@mail.gmail.com>
In-Reply-To: <CADnq5_NEnQoDRQzyk4v9Nie+qUJo3q5eZUGoC1j+CoY+SG25hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-27T02:03:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ab8f2197-9279-4f61-b8f6-0000d8811932;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-27T02:03:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c8011172-7a54-4940-b38a-0000ec609419
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f89b0462-e124-4374-f864-08d7bb293008
x-ms-traffictypediagnostic: MN2PR12MB3104:
x-microsoft-antispam-prvs: <MN2PR12MB310485C260C06ADA87730BDB8FEB0@MN2PR12MB3104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(4326008)(5660300002)(316002)(45080400002)(81156014)(81166006)(71200400001)(966005)(2906002)(6506007)(478600001)(76116006)(66556008)(33656002)(6916009)(26005)(66476007)(55016002)(66946007)(86362001)(8936002)(9686003)(186003)(8676002)(66616009)(66446008)(64756008)(7696005)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3104;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebvCwXhuGJyc5K+uk+Q7W5VbDZkGA+OfZL59LpAnwtleP//YR7NSUncEJsfcCe49VjIEIECzyxkO/pfBHqSQQsz/XiryZwxWclG+wJ+QtPC/P8ey9guifTRTteFHJo2ntCaDyds7VKFkhJIPX+2Db5Mx95ozlcenb14tIz9UC/8pLNsgIw3M1bh8g0p4ZmrjevduSfg7TzYkrr2bpTbfDQz+kfrvf0n08Gzz0FqFfJPRhpT9e22iQwpsftnfg5flATMD/1Xqeg/WSbAG5IOSqcEWMput+msCDlvJt1xq4I1rCDKgDb94yiCXF/PoZDv3wZY9MZdXf7mhHyWvv/a5GZpxqto/b0lXG5UWvWkFH4X1BT3KtJDOTjiQf1c8Unxn87XyvHx5CJl+2mxWohiKtGqw+CF/XJH1BwA6CD79lGqhdCh9xpuNJck7XEybq2oOvzDkH9xa1EBUMpwdo0fOoHccdUFQKDVh0xGBaQzY0Tcd+UZyYTt3Z21+2TDSAOUlhIOW6u/XDhVZvUbnTBy92/E0vUodt/LvNFruIQQX9NcJgMBcOFmWa2tj5QCvSDV16ZZm5z8qVC8KsQajBw4+d7YfvblEXMXlASFiVfFdcPmUb20dOypbxub9zH9lIH4h
x-ms-exchange-antispam-messagedata: 6SHfpguaFZgeOzF86p+boPMLx/9gxNSsJLLjISGEE++pbNmxi94YuI54MloLlUmLRr7OmHZiI8LWaB80ebzkVQ/TYoCnMS8GoCWSuKjqY3dlwVmaIJDNnQtTgsM/4vFfiAb1+G81lpXqNbqtYjcKdQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_002_MN2PR12MB2975FEC3ACF49D022233E3598FEB0MN2PR12MB2975namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89b0462-e124-4374-f864-08d7bb293008
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 02:03:06.8622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbVq0mqsy+1F64t0nZf6sGsC/R1IUms4h3EUVOEff5XscubX8QAjLdZ5iutp27eP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_MN2PR12MB2975FEC3ACF49D022233E3598FEB0MN2PR12MB2975namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGFua3MgQWxleCBhbmQgQ2hyaXN0aWFuLiBBbHJlYWR5ICByZW5hbWVkIGl0IGFjY29yZGluZyB5
b3VyIHJlcXVlc3QuIFBsZWFzZSBoZWxwIHJldmlldy4NCg0KQmVzdCB3aXNoZXMNCkVtaWx5IERl
bmcNCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjYs
IDIwMjAgMTA6MzAgUE0NCj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCj5D
YzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj5TdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3NyaW92OiBVc2Uga2lxIHRvIGNvcHkgdGhlIGdwdSBj
bG9jaw0KPg0KPk9uIFR1ZSwgRmViIDI1LCAyMDIwIGF0IDExOjM0IFBNIEVtaWx5IERlbmcgPEVt
aWx5LkRlbmdAYW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRm9yIHZlZ2ExMCBzcmlvdiwgdGhlIHJl
Z2lzdGVyIGlzIGJsb2NrZWQsIHVzZSBjb3B5IGRhdGEgY29tbWFuZCB0bw0KPj4gZml4IHRoZSBp
c3N1ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5j
b20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwg
NjgNCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4+IGluZGV4IDFjN2ExNmIuLjcxZGYwZDkg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+PiBAQCAtMzk2
Myw2ICszOTYzLDYzIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfc29mdF9yZXNldCh2b2lkICpoYW5k
bGUpDQo+PiAgICAgICAgIHJldHVybiAwOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIHVpbnQ2NF90
IGFtZGdwdV9raXFfcmVhZF9jbG9jayhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4NCj5Q
bGVhc2UgbmFtZSB0aGlzIGZ1bmN0aW9uIGdmeF92OV8wX2tpcV9yZWFkX2Nsb2NrIGZvciBjb25z
aXN0ZW5jeS4NCj4NCj4NCj4+ICt7DQo+PiArICAgICAgIHNpZ25lZCBsb25nIHIsIGNudCA9IDA7
DQo+PiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiArICAgICAgIHVpbnQzMl90IHNl
cTsNCj4+ICsgICAgICAgc3RydWN0IGFtZGdwdV9raXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOw0K
Pj4gKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAma2lxLT5yaW5nOw0KPj4gKw0K
Pj4gKyAgICAgICBCVUdfT04oIXJpbmctPmZ1bmNzLT5lbWl0X3JyZWcpOw0KPj4gKw0KPj4gKyAg
ICAgICBzcGluX2xvY2tfaXJxc2F2ZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdzKTsNCj4+ICsgICAg
ICAgYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgMzIpOw0KPj4gKyAgICAgICBhbWRncHVfcmluZ193
cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfQ09QWV9EQVRBLCA0KSk7DQo+PiArICAgICAgIGFt
ZGdwdV9yaW5nX3dyaXRlKHJpbmcsIDkgfCAgICAgLyogc3JjOiByZWdpc3RlciovDQo+DQo+SXMg
c3JjIDkgdGhlIGNvdW50ZXI/DQpZZXMsIGl0IGlzIGdwdSBjb3VudGVyLg0KPg0KPkFzc3VtaW5n
IHRoYXQgaXMgY29ycmVjdCwgd2l0aCB0aGUgbmFtaW5nIGZpeGVkOg0KPlJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICg1IDw8IDgpIHwgICAgICAvKiBkc3Q6IG1lbW9yeSAqLw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMSA8PCAxNikgfCAgICAgLyogY291
bnQgc2VsICovDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IDIwKSk7
ICAgICAvKiB3cml0ZSBjb25maXJtICovDQo+PiArICAgICAgIGFtZGdwdV9yaW5nX3dyaXRlKHJp
bmcsIDApOw0KPj4gKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCAwKTsNCj4+ICsgICAg
ICAgYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgbG93ZXJfMzJfYml0cyhhZGV2LT53Yi5ncHVfYWRk
ciArDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtpcS0+cmVnX3ZhbF9vZmZz
ICogNCkpOw0KPj4gKyAgICAgICBhbWRncHVfcmluZ193cml0ZShyaW5nLCB1cHBlcl8zMl9iaXRz
KGFkZXYtPndiLmdwdV9hZGRyICsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
a2lxLT5yZWdfdmFsX29mZnMgKiA0KSk7DQo+PiArICAgICAgIGFtZGdwdV9mZW5jZV9lbWl0X3Bv
bGxpbmcocmluZywgJnNlcSk7DQo+PiArICAgICAgIGFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsN
Cj4+ICsgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgma2lxLT5yaW5nX2xvY2ssIGZsYWdz
KTsNCj4+ICsNCj4+ICsgICAgICAgciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywg
c2VxLCBNQVhfS0lRX1JFR19XQUlUKTsNCj4+ICsNCj4+ICsgICAgICAgLyogZG9uJ3Qgd2FpdCBh
bnltb3JlIGZvciBncHUgcmVzZXQgY2FzZSBiZWNhdXNlIHRoaXMgd2F5IG1heQ0KPj4gKyAgICAg
ICAgKiBibG9jayBncHVfcmVjb3ZlcigpIHJvdXRpbmUgZm9yZXZlciwgZS5nLiB0aGlzIHZpcnRf
a2lxX3JyZWcNCj4+ICsgICAgICAgICogaXMgdHJpZ2dlcmVkIGluIFRUTSBhbmQgdHRtX2JvX2xv
Y2tfZGVsYXllZF93b3JrcXVldWUoKSB3aWxsDQo+PiArICAgICAgICAqIG5ldmVyIHJldHVybiBp
ZiB3ZSBrZWVwIHdhaXRpbmcgaW4gdmlydF9raXFfcnJlZywgd2hpY2ggY2F1c2UNCj4+ICsgICAg
ICAgICogZ3B1X3JlY292ZXIoKSBoYW5nIHRoZXJlLg0KPj4gKyAgICAgICAgKg0KPj4gKyAgICAg
ICAgKiBhbHNvIGRvbid0IHdhaXQgYW55bW9yZSBmb3IgSVJRIGNvbnRleHQNCj4+ICsgICAgICAg
ICogKi8NCj4+ICsgICAgICAgaWYgKHIgPCAxICYmIChhZGV2LT5pbl9ncHVfcmVzZXQgfHwgaW5f
aW50ZXJydXB0KCkpKQ0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gZmFpbGVkX2tpcV9yZWFkOw0K
Pj4gKw0KPj4gKyAgICAgICBtaWdodF9zbGVlcCgpOw0KPj4gKyAgICAgICB3aGlsZSAociA8IDEg
JiYgY250KysgPCBNQVhfS0lRX1JFR19UUlkpIHsNCj4+ICsgICAgICAgICAgICAgICBtc2xlZXAo
TUFYX0tJUV9SRUdfQkFJTE9VVF9JTlRFUlZBTCk7DQo+PiArICAgICAgICAgICAgICAgciA9IGFt
ZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywgc2VxLCBNQVhfS0lRX1JFR19XQUlUKTsNCj4+
ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICBpZiAoY250ID4gTUFYX0tJUV9SRUdfVFJZKQ0K
Pj4gKyAgICAgICAgICAgICAgIGdvdG8gZmFpbGVkX2tpcV9yZWFkOw0KPj4gKw0KPj4gKyAgICAg
ICByZXR1cm4gKHVpbnQ2NF90KWFkZXYtPndiLndiW2tpcS0+cmVnX3ZhbF9vZmZzXSB8DQo+PiAr
ICAgICAgICAgICAgICAgKHVpbnQ2NF90KWFkZXYtPndiLndiW2tpcS0+cmVnX3ZhbF9vZmZzICsg
MSBdIDw8DQo+PiArIDMyVUxMOw0KPj4gKw0KPj4gK2ZhaWxlZF9raXFfcmVhZDoNCj4+ICsgICAg
ICAgcHJfZXJyKCJmYWlsZWQgdG8gcmVhZCBncHUgY2xvY2tcbiIpOw0KPj4gKyAgICAgICByZXR1
cm4gfjA7DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyB1aW50NjRfdCBnZnhfdjlfMF9nZXRfZ3B1
X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4+ICphZGV2KSAgew0KPj4gICAg
ICAgICB1aW50NjRfdCBjbG9jazsNCj4+IEBAIC0zOTcwLDE2ICs0MDI3LDcgQEAgc3RhdGljIHVp
bnQ2NF90DQo+Z2Z4X3Y5XzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQ0KPj4gICAgICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsN
Cj4+ICAgICAgICAgbXV0ZXhfbG9jaygmYWRldi0+Z2Z4LmdwdV9jbG9ja19tdXRleCk7DQo+PiAg
ICAgICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9WRUdBMTAgJiYgYW1kZ3B1X3NyaW92
X3J1bnRpbWUoYWRldikpIHsNCj4+IC0gICAgICAgICAgICAgICB1aW50MzJfdCB0bXAsIGxzYiwg
bXNiLCBpID0gMDsNCj4+IC0gICAgICAgICAgICAgICBkbyB7DQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoaSAhPSAwKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
ZGVsYXkoMSk7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUo
R0MsIDAsDQo+bW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX01TQik7DQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBsc2IgPSBSUkVHMzJfU09DMTUoR0MsIDAsDQo+bW1STENfUkVGQ0xPQ0tfVElN
RVNUQU1QX0xTQik7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBtc2IgPSBSUkVHMzJfU09D
MTUoR0MsIDAsDQo+bW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX01TQik7DQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICBpKys7DQo+PiAtICAgICAgICAgICAgICAgfSB3aGlsZSAodW5saWtlbHko
dG1wICE9IG1zYikgJiYgKGkgPCBhZGV2LT51c2VjX3RpbWVvdXQpKTsNCj4+IC0gICAgICAgICAg
ICAgICBjbG9jayA9ICh1aW50NjRfdClsc2IgfCAoKHVpbnQ2NF90KW1zYiA8PCAzMlVMTCk7DQo+
PiArICAgICAgICAgICAgICAgY2xvY2sgPSBhbWRncHVfa2lxX3JlYWRfY2xvY2soYWRldik7DQo+
PiAgICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAw
LCBtbVJMQ19DQVBUVVJFX0dQVV9DTE9DS19DT1VOVCwgMSk7DQo+PiAgICAgICAgICAgICAgICAg
Y2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLA0KPj4gbW1STENfR1BVX0NMT0NL
X0NPVU5UX0xTQikgfA0KPj4gLS0NCj4+IDIuNy40DQo+Pg0KPj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdA0KPj4gcy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+Z2Z4JmFtcDtkYXRh
PTAyJTdDMDElN0NFbQ0KPj4NCj5pbHkuRGVuZyU0MGFtZC5jb20lN0M5ZWJlNDkwZjg4NjQ0ZGUz
NWI5YTA4ZDdiYWM4NWQxYyU3QzNkZDg5NjFmZTQNCj44ODRlDQo+Pg0KPjYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3MTgzMjQyMDI3ODY4NDE3JmFtcDtzZGF0YT02bWRibw0KPlElMkJl
ZUgNCj4+IEtlUVhuRW0lMkI2bEZmTXVCbk1TZkdoeHBXWEhqZmc2VnNvJTNEJmFtcDtyZXNlcnZl
ZD0wDQo=

--_002_MN2PR12MB2975FEC3ACF49D022233E3598FEB0MN2PR12MB2975namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Thu, 27 Feb 2020 02:03:04 GMT";
	modification-date="Thu, 27 Feb 2020 02:03:04 GMT"

Received: from CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:208:71::21)
 by MN2PR12MB2975.namprd12.prod.outlook.com with HTTPS via
 BL0PR01CA0008.PROD.EXCHANGELABS.COM; Thu, 27 Feb 2020 01:48:22 +0000
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 01:48:21 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::97) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 01:48:21 +0000
Received: from mail.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 01:48:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 26 Feb
 2020 19:48:19 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 26 Feb 2020 19:48:18 -0600
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Topic: [PATCH v2] drm/amdgpu/sriov: Use kiq to copy the gpu clock
Thread-Index: AQHV7Q/+PyUMC7v5AE6VoWaZS6HRHw==
Date: Thu, 27 Feb 2020 01:48:15 +0000
Message-ID: <1582768095-7917-1-git-send-email-Emily.Deng@amd.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: SATLEXMB01.amd.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id:  ff985ba4-2da6-4423-3a7d-08d7bb271ff1
X-MS-Exchange-Organization-SCL: 1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-organization-originalclientipaddress: 10.180.168.240
x-ms-exchange-organization-originalserveripaddress: 10.13.172.64
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-publictraffictype: Email
authentication-results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; amdcloud.mail.onmicrosoft.com; dkim=none (message not
 signed) header.d=none;amdcloud.mail.onmicrosoft.com; dmarc=permerror
 action=none header.from=amd.com;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff985ba4-2da6-4423-3a7d-08d7bb271ff1
x-ms-traffictypediagnostic: CH2PR12MB4085:
x-forefront-antispam-report:  CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(4636009)(428003)(199004)(189003)(5660300002)(356004)(6666004)(2616005)(7696005)(156005)(34756004)(8936002)(1096003)(6862004)(426003)(86362001)(186003)(36005)(336012)(36756003)(8676002)(81156014)(81166006)(4326008);DIR:INB;SFP:;SCL:1;SRVR:CH2PR12MB4085;H:mail.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Antispam-Mailbox-Delivery:  ucf:1;jmr:0;ex:0;auth:0;dest:C;OFR:CustomRules;ENG:(20160514016)(750127)(520011016)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info:  =?iso-8859-1?Q?AM57uYSgJXmDRnCjLT8KcsskrorizqmGXqk1DtPQtADGxRMOY9Lyb73s3i?=
 =?iso-8859-1?Q?7oP5KAqbSS935b9xYlJlsjY0TOPzGS7mNWPftCBVQEm+XOZibEF8jMVJ/v?=
 =?iso-8859-1?Q?Ud68qb74UAMf2HWm83kaN8DAg7lNjWB226qApTGxRAAW2EWJz5y8SqZ98P?=
 =?iso-8859-1?Q?dHz8VnxKeQMiIoenmLmqvMehj/0btQ+TNPmAqbZR5usob7+/xhsvQjaEL2?=
 =?iso-8859-1?Q?lfOoTyFdMAqLmZopeoqmhULoe4cgL50UDYmipJl+O0LIR+n0epAdAQrLMQ?=
 =?iso-8859-1?Q?0MYZysovDYXklWb/YDgnKrtYgGwv4jhgdA94HiiQeY6avlfM4Fj3hWL1Wt?=
 =?iso-8859-1?Q?+2fmJFcmRyn7hYbL0DjbPxhZU8trIn9gEcXD0TmuoCYAgYkbJdSHnmqo8E?=
 =?iso-8859-1?Q?bYorTrU7cbz8bIKXdpzxXmbIgcTi6geow87HQf7bwVsCQkJGpX5mtrsNaq?=
 =?iso-8859-1?Q?yaam7SodbXwM6Btep9WJwr0iFdJP7nTrmgTyA0SMpt4G6gXfk5B5B9wVOh?=
 =?iso-8859-1?Q?YYvaRkGueaP947I+M7e6YGC03dhZ/WF+0Cod1yW6mljmKiGkzZRf5mmTCR?=
 =?iso-8859-1?Q?B+efE+p1d8sMrJwKXzrZ2hF8DzbGwrSoM8f6lGM/Wuea4P6Ulu9r3x7eA7?=
 =?iso-8859-1?Q?Ce+uru1NecmhqFnV1aTh6lBWyZ05EQ9haSC/vnALAs+cmP4GbRhtNyApZ9?=
 =?iso-8859-1?Q?0vcpdlnNAngAnj8rDo160ENuw3cKgGQx6lRhR2UBx46UjgeGIDB4TBWfUu?=
 =?iso-8859-1?Q?CGS1x1HNpTe6zFyZYPI3gOeA5T7YHTL2HynDYYfND4WLNjZZ5Y8ZJ51bId?=
 =?iso-8859-1?Q?BBoWGIqvKmTB/g+w8bVgicK0HPtWJ+SwmLXh0k2jB09B1izeTetiZwqmVp?=
 =?iso-8859-1?Q?5qMgZtKaAbwrj00M139PQQmcnttHwmhkYVsPPqkpWvt/FVe5rZJDuVEq1b?=
 =?iso-8859-1?Q?8rMheAfWsxLdu7Ap2XcXuTVEc6esmk8XkEtjhb7gQtLzEAP+8+K6rembxw?=
 =?iso-8859-1?Q?wAiUr9oCkTAWnQEAaoYNYJpYqW1xJchi3YYXFWPBw9dqmFw6wZXT/7YF68?=
 =?iso-8859-1?Q?OTcYFhVpfbFYdiWgcPFyRt3lx1ADcYriei9vBTz4ylFB4cagXQpkvD/Pzm?=
 =?iso-8859-1?Q?OsfvnLyeb1nUnl6QyT7joxDNuBi73T1tGGZkmYvFNMMtiAwjViIrJ2yQW3?=
 =?iso-8859-1?Q?L0Z7GpuTKraA4GLnHrpioRORO2y6TPcn3hi1JsPG5Jr3PlTtjikRIjHlY9?=
 =?iso-8859-1?Q?H/mvEFamXczn0HV+n6IFHdDBSmA5GSHg7zhYd0EYzqNHQhN/4U0SxrzPnI?=
 =?iso-8859-1?Q?D63qzitCNThhxhp5op8IXvFxhFBXEF/Mph3i5XjtVseawNNOYt235bJCLq?=
 =?iso-8859-1?Q?WSon8r48wa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

For vega10 sriov, the register is blocked, use
copy data command to fix the issue.

v2: Rename amdgpu_kiq_read_clock to gfx_v9_0_kiq_read_clock.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 68 +++++++++++++++++++++++++++++--=
----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index edd5501..5f7336a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3978,6 +3978,63 @@ static int gfx_v9_0_soft_reset(void *handle)
 	return 0;
 }
=20
+static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
+{
+	signed long r, cnt =3D 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
+	struct amdgpu_ring *ring =3D &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_rreg);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	amdgpu_ring_alloc(ring, 32);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
+	amdgpu_ring_write(ring, 9 |	/* src: register*/
+				(5 << 8) |	/* dst: memory */
+				(1 << 16) |	/* count sel */
+				(1 << 20));	/* write confirm */
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
+				kiq->reg_val_offs * 4));
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (adev->in_gpu_reset || in_interrupt()))
+		goto failed_kiq_read;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_read;
+
+	return (uint64_t)adev->wb.wb[kiq->reg_val_offs] |
+		(uint64_t)adev->wb.wb[kiq->reg_val_offs + 1 ] << 32ULL;
+
+failed_kiq_read:
+	pr_err("failed to read gpu clock\n");
+	return ~0;
+}
+
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
@@ -3985,16 +4042,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev)
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
 	if (adev->asic_type =3D=3D CHIP_VEGA10 && amdgpu_sriov_runtime(adev)) {
-		uint32_t tmp, lsb, msb, i =3D 0;
-		do {
-			if (i !=3D 0)
-				udelay(1);
-			tmp =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			lsb =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_LSB);
-			msb =3D RREG32_SOC15(GC, 0, mmRLC_REFCLOCK_TIMESTAMP_MSB);
-			i++;
-		} while (unlikely(tmp !=3D msb) && (i < adev->usec_timeout));
-		clock =3D (uint64_t)lsb | ((uint64_t)msb << 32ULL);
+		clock =3D gfx_v9_0_kiq_read_clock(adev);
 	} else {
 		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
 		clock =3D (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
--=20
2.7.4


--_002_MN2PR12MB2975FEC3ACF49D022233E3598FEB0MN2PR12MB2975namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_MN2PR12MB2975FEC3ACF49D022233E3598FEB0MN2PR12MB2975namp_--
