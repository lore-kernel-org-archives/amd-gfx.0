Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C606C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D644B20748
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 11:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D644B20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B3B6E169;
	Mon,  2 Dec 2019 11:07:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5551F6E169
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 11:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV3qYfeXm/RUP9zoTDiMv2Y5O+COWhaDcjkSmRmTbTusN7vfKHWnZJemtA/YPDAoPCZl/nEcafbxQqnTbua4lAZuTbB6zNMNyjjREHHBcgMx2s/C90fzQXWpIcIFPVN10b1YQG3tm+gd90KXd8U0cdS5mL46/BdFGaEKbuzCnpSmk06bYNczqPvRitbrnOk8oTFS5AckdSUDogeE/maTyl3ALd7QKuj6tarLzYrZ3cfmhxkhZZVAzXZg2VzzpFl6si/pw6S/hrz38hl94KWdEyrCt9cYLtg4UicEPaHr5GI8Gu8UIpVLKnZL/6MS5daZoQSssfDe0RcWKt+KwP+XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo0HwqiXeRGnOi5kPAh1hFjFjsIS7sQeRKa+61KZBC0=;
 b=MhVyNAIsLmmk1L1RV1dZvgRnFbgEenLkYN95FDE2JZ1euzDNicwgBHvNQDWeync+B0MwXyFq0dt7eKwvrhwuBwmrRziGqFQGq+LOufCLMmTGgdJpXqvSfH+CYKwuyRII3wCbn/F0CatlEwEi9hqdcePSZrxw1Ok8QxhTjV+5qtW846/B7s0oROYSmolHfpJZD4+ZTFy34Pl/YP7fcadxnt6HbIgo01OwjafteZ9AOdASFDyQNMPUh1y2NOTwz3m6WRXW20zGo62UNYppU9IJnL3Ljta/HXLKVIdZa1AXjCqihNUsEp2ih97VZuR4dNHEFwabgPclfekDvLVZogQjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) by
 CH2PR12MB4053.namprd12.prod.outlook.com (20.180.17.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 11:06:58 +0000
Received: from CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d]) by CH2PR12MB3672.namprd12.prod.outlook.com
 ([fe80::8dbe:e9a8:801e:9b9d%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:06:58 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Topic: [PATCH] amd/amdgpu/sriov swSMU disable for sriov
Thread-Index: AQHVqQBrbxKqVIpFVE6sZB5cOr1m8Kemrt+A
Date: Mon, 2 Dec 2019 11:06:58 +0000
Message-ID: <CH2PR12MB3672171F856F23D669218E31BB430@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191202110519.3504-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191202110519.3504-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb66ebc8-f06d-4045-6191-08d77717bffe
x-ms-traffictypediagnostic: CH2PR12MB4053:|CH2PR12MB4053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB40537E7F963BCCB860E79A9EBB430@CH2PR12MB4053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(13464003)(199004)(189003)(186003)(478600001)(229853002)(86362001)(14454004)(6436002)(6636002)(6246003)(33656002)(71190400001)(71200400001)(5660300002)(55016002)(52536014)(76176011)(7696005)(66946007)(66476007)(66556008)(66446008)(102836004)(9686003)(64756008)(76116006)(6506007)(53546011)(81166006)(25786009)(7736002)(81156014)(74316002)(8936002)(2906002)(305945005)(110136005)(316002)(14444005)(4326008)(446003)(11346002)(256004)(66066001)(3846002)(8676002)(6116002)(26005)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4053;
 H:CH2PR12MB3672.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjnj1Kdivg040D3S9dS0keSMblDNVojJRbo2CKoaJcHDW+4/FLeFMGheFXxQEdR4TNylEED2IecWxOqNrRFPL/dGsvI/q9h5JzQNjbfh5bywU2fnl1g3s9ocwdHAlpNLZp5MWdwj+68/yuyscOQFvf1RXUWVLwW3Sw90yxJ/E+JAwasOypQOR2Y4jzJR+mRbezklpSZO2bGM47TLcV7+cI0LrZjAL0PEZ4ijnYgyRwy4NuKMQYLf3TFfEvHgs5hd/+KZt6cvxLBYaqBvAG6Cr1xa/HKtpd0S8dna/a/tfFEZ6OZMAjdyZre5O9UqznfJSW7U1he5UFlwXM5a+HfVWOim2LELOqIsVK3q+FL3fG04GKOoHuoIm7d41lqHHnyMmB00VF4iwL6PdhVvnumTuuV1FO9T5n/KMfbx3bn94j9+MWxu9/PU2nviQCiMX3/1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb66ebc8-f06d-4045-6191-08d77717bffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 11:06:58.3668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0t713ZPmU6FoUWxD6z4eOLtvpPvACRwXKSuOlNZ28qA6tu3bPU6VwCShpB0PDrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo0HwqiXeRGnOi5kPAh1hFjFjsIS7sQeRKa+61KZBC0=;
 b=nvLC/DQ8sr6LnnnG1xMgEL/2WwnaVN5HW6bC6xe71YSh+CftDSxcMMPYCgdt7u4U6A5kcnvanfmd/EWaT+nE9v/z+sqeXVOQI9X9i1olxBOPwVOTXdNeNhtV9+UEjWyvpjx6bWt3gUtLiYq2K6m2Oi/6pnbsKSMwD6vtKJIMTCk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jack.Zhang1@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksIFRlYW0sDQoNCldvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgdGhpcyBwYXRjaD8N
Cg0KQmVzdCwNCkphY2sNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphY2sg
WmhhbmcgPEphY2suWmhhbmcxQGFtZC5jb20+IA0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAy
MDE5IDc6MDUgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5n
LCBKYWNrIChKaWFuKSA8SmFjay5aaGFuZzFAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gYW1k
L2FtZGdwdS9zcmlvdiBzd1NNVSBkaXNhYmxlIGZvciBzcmlvdg0KDQpGb3IgYm9hcmRzIGdyZWF0
ZXIgdGhhbiBBUkNUVVJVUywgYW5kIHVuZGVyIHNyaW92IHBsYXRmb3JtLCBzd1NNVSBpcyBub3Qg
c3VwcG9ydGVkIGJlY2F1c2Ugc211IGlwIGJsb2NrIGlzIGNvbW1lbnRlZCBhdCBndWVzdCBkcml2
ZXIuDQoNCkdlbmVyYWxseSBmb3Igc3Jpb3YsIGluaXRpYWxpemF0aW9uIG9mIHNtdSBpcyBtb3Zl
ZCB0byBob3N0IGRyaXZlci4NClRodXMsIHNtdSBzd19pbml0IGFuZCBod19pbml0IHdpbGwgbm90
IGJlIGV4ZWN1dGVkIGF0IGd1ZXN0IGRyaXZlci4NCg0KV2l0aG91dCBzdyBzdHJ1Y3R1cmUgYmVp
bmcgaW5pdGlhbGl6ZWQgaW4gZ3Vlc3QgZHJpdmVyLCBzd1NNVSBjYW5ub3QgZGVjbGFyZSB0byBi
ZSBzdXBwb3J0ZWQuDQoNClNpZ25lZC1vZmYtYnk6IEphY2sgWmhhbmcgPEphY2suWmhhbmcxQGFt
ZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMg
fCA1ICsrKystDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQppbmRleCAz
NjAwMWE0Li4wYjhhNTNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kZ3B1X3NtdS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMNCkBAIC01MzEsNyArNTMxLDEwIEBAIGJvb2wgaXNfc3VwcG9ydF9zd19zbXUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9W
RUdBMjApDQogCQlyZXR1cm4gKGFtZGdwdV9kcG0gPT0gMikgPyB0cnVlIDogZmFsc2U7DQogCWVs
c2UgaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0FSQ1RVUlVTKQ0KLQkJcmV0dXJuIHRydWU7
DQorCQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KKwkJCXJldHVybiBmYWxzZTsNCisJCWVs
c2UNCisJCQlyZXR1cm4gdHJ1ZTsNCiAJZWxzZQ0KIAkJcmV0dXJuIGZhbHNlOw0KIH0NCi0tDQoy
LjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
