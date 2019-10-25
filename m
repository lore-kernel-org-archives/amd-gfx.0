Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B0CA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 13:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D2921D71
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 13:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D2921D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DF06EA1A;
	Fri, 25 Oct 2019 13:26:06 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790052.outbound.protection.outlook.com [40.107.79.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D246EA1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 13:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0a2I85jR5wUojUQlUNQlVDRgHlhBij3WxpvJXV3KzQrxtnc00j0dUSy47H5qaj+TCa0CkqkY76QL2REdBsAXrD8c3/2Ww6+/eeiyM6X+pZV9m5e3aw+6JWB8dP7EFxSyWTWg6MT7d56lE8alAbHWtUoZtUXLKBvCmXeJROMgGl/zQ3hCD/Gwbl0YMGNGqzZDKuDzyoSBNVXnzSxVeB/NVAqlT4XwTbvXlHGMF6DQQKJ2NzSmmLQ/KzzEw9UYMazIcWnG/RL+aOIRkwM62XCtkzSOP+IfHEgq1PumU1WXa1eSs+xehxmGMn2g5BeK61eNmc/vRUDL4zBkCIHJ3RgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqunWHXsV6WqQsO9bz15ia+HV5cu3S7Fm82WgVaWbUg=;
 b=O5I8ENC////g5H8LEZkhdEUa6qk62lJKjdUOdEY1rgFQXVnlLvQAVjLghhLtpkHqmPtECba5COSw+UrubgphPnTX2OQ+0Hks6F48i8+cq2GwGhe8mMHGVnDEA/qxFGj+kkf0MAQheAVKPjftRFia6V8Rja8n2nK/SrwZFfku46g+WiznpRco77jt32IQrldlkuxkFD4tlErPoMmcU/qf9phpqjFuLBy6vR0wfKNUpS0m0KCbzYf7mknuoD5Vkg8J++Zd9l7XVVDykOWXpUPKCn83cIS/7IlzturdF7Y1wa5gEs6HP8gfWdLQnqJ/ry+zBSGtDLxijyOXjxMje144Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3456.namprd12.prod.outlook.com (20.178.242.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 13:26:04 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::c1ed:2bee:8172:25d8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::c1ed:2bee:8172:25d8%7]) with mapi id 15.20.2367.022; Fri, 25 Oct 2019
 13:26:04 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Topic: [PATCH] drm/amd/powerplay: Disable gfx CGPG when suspend smu
Thread-Index: AQHViyRUHE5+TcRLx02/7aID0dGjk6drWJ4Q
Date: Fri, 25 Oct 2019 13:26:03 +0000
Message-ID:
 <MN2PR12MB3309AD7F0E9B0911A7AC9C5CEC650@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1572001610-9599-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.127.234.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1a90962-63bb-4f1b-ccba-08d7594ee2aa
x-ms-traffictypediagnostic: MN2PR12MB3456:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB34569D0FD65FBEC87B586E56EC650@MN2PR12MB3456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(9686003)(66476007)(66946007)(66556008)(229853002)(64756008)(6506007)(8936002)(66446008)(2906002)(76176011)(25786009)(3846002)(6116002)(14444005)(6306002)(71190400001)(55016002)(76116006)(256004)(66066001)(7696005)(2501003)(53546011)(71200400001)(99286004)(15650500001)(26005)(6436002)(52536014)(102836004)(14454004)(966005)(86362001)(316002)(110136005)(81166006)(81156014)(4326008)(476003)(5660300002)(8676002)(33656002)(6246003)(11346002)(305945005)(74316002)(7736002)(446003)(186003)(486006)(478600001)(9126004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3456;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eRVlW1YjKlFMhG2fzxDVOa/yzX34frJG9jNCtdGsscrGoE/AmDB5FaaFkGW/nrlEDMGl1mP4t4MiumAkjB9+XnxkJ4enW8BkyHSR/M6yvYZZfYON/ZFo0kTqM0sSDK2GEFGFZ3wGLxCMf7Qv2fkyze5V8Ao/ttg1x8Cu/gZHdnKf9l6wK8mi96TkO73QMHzxtxlQUWHt2ZICcxO6p6RPJRoSC3PX776pIUWIRH6NAnZkfGQlmNyYCBtYXMIjkUymi9cM6OCa8TLlId5KGDcWhIL1Qb0Jg/7w8k1Nnzg45+path7rQRf8SGBKyDZwyt7PqCNMYxRl7hTGWlewlQmI6qacRzcPBpl8gSK8ufY9dgolGeU42jCeLof+DuQDy4Xhx0Ad9UNhWkXlnHZmcyznH+CTML4r2xz3BC8PheGdpSvi+8AZXfVv8Rskty3iL8TVcpi/cMj4xlLJGC6a+SX8vv7K/bGtr1HttF70unTEmY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a90962-63bb-4f1b-ccba-08d7594ee2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 13:26:03.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9b5Io75BL3BJGkCNLzENnTj9Erp3VCWysz/LWhy5E05oUzN+Q3+GUzxx0PosKKRFYPUJemJAAeLEE+SXZtdvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqunWHXsV6WqQsO9bz15ia+HV5cu3S7Fm82WgVaWbUg=;
 b=MFKDFtbuMU+vsXfI9noBFgqlNOarfJWAih5i4DvXXF6Q5YGlLUXgZchPmVSvkTRlB2Zbwje4GSJjl5ARwFNZLUHAylnmmUXkM46C0LfxGLg9HZaH/480krt4CATVE1U6sgE2gyIPTHqtbOaI9ubKzymPvEF115+b+vEIkvOHz4s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
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
Cc: "Gong, Curry" <Curry.Gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025132603.qfNUzx4BmGpntx9d5h-IyHJYUeR6A9rVfZ2IGCOHXgs@z>

V2h5IGRvIHlvdSBkaXNhYmxlIENHUEcgZm9yIGFsbCBBUFU/DQoNClRoYW5rcywNClJheQ0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIGNoZW4gZ29uZw0KU2VudDogRnJp
ZGF5LCBPY3RvYmVyIDI1LCAyMDE5IDc6MDcgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KQ2M6IEdvbmcsIEN1cnJ5IDxDdXJyeS5Hb25nQGFtZC5jb20+DQpTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBEaXNhYmxlIGdmeCBDR1BHIHdoZW4gc3VzcGVuZCBz
bXUNCg0KaWYgbm8gZGlzYWJsZSBnZnggQ0dQRyB3aGVuIHN1c3BlbmQgc211LCBlbmFibGluZyBn
ZnggQ0dQRyB3aWxsIGZhaWwgd2hlbiByZXN1bWUgc211Lg0KDQpQbGF0Zm9ybTogUmVub2lyDQpk
bWVzZyBsb2cgaW5mb3JtYXRpb246DQoNClsgIDE1MS44NDQxMTAgXSBhbWRncHU6IFtwb3dlcnBs
YXldIFNNVSBpcyByZXN1bWluZy4uLg0KWyAgMTUxLjg0NDExNiBdIGFtZGdwdTogW3Bvd2VycGxh
eV0gZHBtIGhhcyBiZWVuIGRpc2FibGVkIFsgIDE1MS44NDQ2MDQgXSBhbWRncHU6IFtwb3dlcnBs
YXldIEZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMHgyZixyZXNwb25zZSAweGZmZmZmZmZiIHBhcmFt
IDB4MSBbICAxNTEuODQ0NjA1IF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBTTVUgaXMgcmVzdW1lZCBz
dWNjZXNzZnVsbHkhDQoNClNpZ25lZC1vZmYtYnk6IGNoZW4gZ29uZyA8Y3VycnkuZ29uZ0BhbWQu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIHwg
MiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KaW5kZXggMjY5MjNhYS4uNGU0NjhiMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jDQpAQCAtMTM1MSw2
ICsxMzUxLDggQEAgc3RhdGljIGludCBzbXVfc3VzcGVuZCh2b2lkICpoYW5kbGUpDQogCWlmIChh
ZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9OQVZJMTAgJiYNCiAJICAgIGFkZXYtPmdmeC5ybGMuZnVu
Y3MtPnN0b3ApDQogCQlhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKGFkZXYpOw0KKwlpZiAoc211
LT5pc19hcHUpDQorCQlzbXVfc2V0X2dmeF9jZ3BnKCZhZGV2LT5zbXUsIGZhbHNlKTsNCiANCiAJ
cmV0dXJuIDA7DQogfQ0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
