Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CCC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8127F2071F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 16:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127F2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5CD6E247;
	Mon,  2 Dec 2019 16:48:48 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe41::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A616E247;
 Mon,  2 Dec 2019 16:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY5qNvjrjgwX1enZbsGMrG/lXIFtGS8HQ87OH1muaJXuheWoofZ3zqdPTGishQwx8JlqJDWh72mcAvIsmHpm10d4N+qt9GtIvtMsLXkITXd2IB8dCNEY2vyGH/3cLZdYP7ryoQWiFzloZhGL5SAm6jeusoOXXrdfZ/Ogkt3dAkbKf3a5uH0d3Z7PScTVGsoCUv4S/UURVq4eA5rn2DVgtLN6Vua2Ck5qw3PtliJgt3PhD4z3UWIve3IbG+VXfgS16OQAcioodULpEsl1pg5LiukTafOsGTv40R/agaWWLybMCisLFxWwPV+UNCBOOxfCQz8BQoEA6lFramifVg3ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsaY3pabrrIyTxzpWAWvWeg5SNwBFpDfHHGwgrOe73Q=;
 b=IDk4qoXhwbj+LAXk8fMr7/6AJ944uFYyHA9bCuyJs97wTbxriMKMe5eOEn35BWTUc6US8kzlEVc7OoO4XLI8zs+MibncD6M3mCrS3Fg2WEprFcr6ZujPWoHVImtCsc6ba/hWBt+g+AWjLLFoDWgbcdSbVKohtiEd3aj9eMEbcGc7rUUUgAnqTlvv6MbWqqOso1/ZmjBi8p6OScaC+0Rx/6KF3Pw1TWy5kygLm42Y3NB54Ao7AIDhfbqp8eDl/82dc4esUkGtMLos8YrvQtxfxqs4ppXDBQSXg9xrIru6iiYDLC6zH7ZSGBzw6ZR+dHn3ybO1h7o6e2H6yU0U2PjXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3571.namprd12.prod.outlook.com (20.178.208.159) by
 BN8PR12MB3073.namprd12.prod.outlook.com (20.178.209.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 16:48:44 +0000
Received: from BN8PR12MB3571.namprd12.prod.outlook.com
 ([fe80::dc09:fffe:e6c0:d702]) by BN8PR12MB3571.namprd12.prod.outlook.com
 ([fe80::dc09:fffe:e6c0:d702%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:48:44 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx-bounces@lists.freedesktop.org"
 <amd-gfx-bounces@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix typos for dcn20_funcs and
 dcn21_funcs struct
Thread-Topic: [PATCH] drm/amd/display: fix typos for dcn20_funcs and
 dcn21_funcs struct
Thread-Index: AQHVpmhrDwtRIvlna0KSnc4QYFGOq6eiOFyg
Date: Mon, 2 Dec 2019 16:48:44 +0000
Message-ID: <BN8PR12MB357163B623E7A058386E3FE4F3430@BN8PR12MB3571.namprd12.prod.outlook.com>
References: <20191129035214.10102-1-Stanley.Yang@amd.com>
In-Reply-To: <20191129035214.10102-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8da309d5-e2c7-4d04-b2ca-0000859d8890;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-02T16:48:12Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2d959f6-70a3-47a3-7ab6-08d777477ea4
x-ms-traffictypediagnostic: BN8PR12MB3073:|BN8PR12MB3073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB30730C10B72FB4E52F6C2A2BF3430@BN8PR12MB3073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(189003)(13464003)(199004)(305945005)(25786009)(86362001)(2201001)(450100002)(66946007)(4326008)(9686003)(6436002)(55016002)(256004)(66556008)(64756008)(66446008)(66476007)(76116006)(99286004)(71200400001)(71190400001)(110136005)(316002)(6246003)(5660300002)(52536014)(478600001)(14454004)(229853002)(81166006)(8936002)(7736002)(74316002)(102836004)(2501003)(446003)(6506007)(6116002)(81156014)(3846002)(11346002)(186003)(7696005)(76176011)(66066001)(2906002)(26005)(33656002)(53546011)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3073;
 H:BN8PR12MB3571.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jOh5at+FnVyXvYR/C5C3eNxq7Y1bk4bQjCsMzcXQbJdGPb5KxecI9VodpOOqJM654HMywDOWOuKI6WHLJhyPCDAOG3c7AHdCSnL6MnRBT0CDcC7SxevZ6/TXUnJgAJYsAnVNgObylx9bqGGpkgWROAS1O/0tcNYqna0AVPk5scr02S8M7UzwANsiwf/SIfKH5H1E1lZ74ogkPWG8XW1o8w3vvUZrnhZdUEP4HQlsftS/Q9bzvDKMFvMW3a64wbrKWrD0JiK62K8EKpLtsTxDvPYRvbZuQYRPm25jT7+YLbT2njolELr6P41z3atH7jPmLGC9UzE3DXPKPnXLPRYwBI9678LEyj7spB3UukeQqVHMHsFWZEzMWUItLyrh/e8jlua3Afg9/R6EsAlSIacHrD/+762X+P9ubuuN837rZjlr+tq7GVffefmY5CMg0mx
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d959f6-70a3-47a3-7ab6-08d777477ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:48:44.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDAX6ziy2m+4jajnkYao3Pgf+rTiGO7CcBKbds9etwqBYPwG3KS4oHW7hlbnW/Cv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsaY3pabrrIyTxzpWAWvWeg5SNwBFpDfHHGwgrOe73Q=;
 b=L2pBuKrVnluMsqDy0MBdqZrzDEm9lF2MF1bMT5ztkEJKhJfIkBxzqZ1vLch1F0JZqGkIZWuhvbYzLHiVuaRoepFLZ9mXV82OG139Kndrus6qd0vsvKwz0CviEayyscCPy9hqzlcw59w90HQ26eVK7e3fVd1glsMKGyNxYEeEuLA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anthony.Koo@amd.com; 
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEFudGhvbnkgS29vIDxBbnRob255Lktvb0BhbWQuY29tPgoKLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogU3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1kLmNv
bT4gClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyOCwgMjAxOSAxMDo1MiBQTQpUbzogYW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogS29vLCBBbnRob255IDxBbnRob255
Lktvb0BhbWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+ClN1Ympl
Y3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBmaXggdHlwb3MgZm9yIGRjbjIwX2Z1bmNzIGFu
ZCBkY24yMV9mdW5jcyBzdHJ1Y3QKCkluIGRjbjIwX2Z1bmNzIGFuZCBkY24yMV9mdW5jcyBzdHJ1
Y3QsIHRoZSBtZW1iZXIgIi5kc2NfcGdfY29udHJvbCA9IE5VTEwiCnNob3VsZCBiZSByZW1vdmVk
IGR1ZSB0byAuZHNjX3BnX2NvbnRyb2wgYmUgYXNzaWduZWQgdG8gZGNuMjBfZHNjX3BnX2NvbnRy
b2wuCgpDaGFuZ2UtSWQ6IEljMjQwOTVlNzljZGFjMjNlNTAyOTk1ZTA3ZTc1ODg2NTczZDFjMTEy
ClNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2luaXQuYyB8IDEgLSAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2luaXQuYyB8IDEgLQog
MiBmaWxlcyBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9pbml0LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaW5pdC5jCmluZGV4IDUxYjZjMjVhYTNjNS4uZTVk
ZWJiN2M1MDBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfaW5pdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9pbml0LmMKQEAgLTk0LDcgKzk0LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBod19z
ZXF1ZW5jZXJfZnVuY3MgZGNuMjBfZnVuY3MgPSB7CiAJLmVuYWJsZV9wb3dlcl9nYXRpbmdfcGxh
bmUgPSBkY24yMF9lbmFibGVfcG93ZXJfZ2F0aW5nX3BsYW5lLAogCS5kcHBfcGdfY29udHJvbCA9
IGRjbjIwX2RwcF9wZ19jb250cm9sLAogCS5odWJwX3BnX2NvbnRyb2wgPSBkY24yMF9odWJwX3Bn
X2NvbnRyb2wsCi0JLmRzY19wZ19jb250cm9sID0gTlVMTCwKIAkucHJvZ3JhbV90cmlwbGVidWZm
ZXIgPSBkY24yMF9wcm9ncmFtX3RyaXBsZV9idWZmZXIsCiAJLmVuYWJsZV93cml0ZWJhY2sgPSBk
Y24yMF9lbmFibGVfd3JpdGViYWNrLAogCS5kaXNhYmxlX3dyaXRlYmFjayA9IGRjbjIwX2Rpc2Fi
bGVfd3JpdGViYWNrLCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjIxL2RjbjIxX2luaXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MS9kY24yMV9pbml0LmMKaW5kZXggMWQ4YjY3YjRlMjUyLi5kNzMzZjhmY2ZhYjIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9pbml0LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2luaXQuYwpAQCAt
OTUsNyArOTUsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGh3X3NlcXVlbmNlcl9mdW5jcyBkY24y
MV9mdW5jcyA9IHsKIAkuZW5hYmxlX3Bvd2VyX2dhdGluZ19wbGFuZSA9IGRjbjIwX2VuYWJsZV9w
b3dlcl9nYXRpbmdfcGxhbmUsCiAJLmRwcF9wZ19jb250cm9sID0gZGNuMjBfZHBwX3BnX2NvbnRy
b2wsCiAJLmh1YnBfcGdfY29udHJvbCA9IGRjbjIwX2h1YnBfcGdfY29udHJvbCwKLQkuZHNjX3Bn
X2NvbnRyb2wgPSBOVUxMLAogCS5wcm9ncmFtX3RyaXBsZWJ1ZmZlciA9IGRjbjIwX3Byb2dyYW1f
dHJpcGxlX2J1ZmZlciwKIAkuZW5hYmxlX3dyaXRlYmFjayA9IGRjbjIwX2VuYWJsZV93cml0ZWJh
Y2ssCiAJLmRpc2FibGVfd3JpdGViYWNrID0gZGNuMjBfZGlzYWJsZV93cml0ZWJhY2ssCi0tCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
