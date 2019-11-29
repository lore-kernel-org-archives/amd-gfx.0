Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB04AC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8357B21781
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8357B21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7136E0F5;
	Fri, 29 Nov 2019 08:25:15 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800049.outbound.protection.outlook.com [40.107.80.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F0B6E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVnvgAROH1ZxoGOORxpXVtzsKCy6yVU7+9hKOdxa05YymM8yMoCcWr82MbCbtxeXdbDWo97zOWvnxHxui4oPtwtCrLYypoW5LBQvxEm2m0Wn4D8SMAOQMDnRqoB1XmyPlDsRtrmDyz9lQ3dhB6KduWJBKKiHRbsN5zTBLv8isxdKnY/oOtPLB0dsGnh/Upi0bFSiLDBGW/eQQtSrCDgArxSgU6cvplS1qXOed/WxxROTqW3yamwE1fa7+PO+472PK9qgzbsYCjS3ovUtjY9m4sNbmN4LTU3z7xSVFyziIUi1ZWZ12wTZGsXlSGkzKCPadXja+O2ZovTdHA4Czx+3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm8BzSebMyU25FGr9PFNo4A7tBE3vnXCJmOMXKtISLE=;
 b=kMVMuZqLRslvgxfN9TextXzG5wfg4RkQZft+026nUgixvZ7l6hdR1TJT7vfBcBqQGr729FlBkCT3RabvG0qUyDz8EqOxqsBMLSazDUDcCkIZ59kHdB0vwrvFzXMwbIeFwxS8CR+yTkNruefutURUZWGGgIEERV2djwWAIxwlPKpcW0AsVNYpteoYzuZxQA3P4xJ/uprw+5ic4VWLPVUj4HGrP6hx47liTQ8z49FhYzVjVzAaaGGyetUU9bCxI1WnzjEHU+4OIB9W4WMPmCkRNPEHHb+A8QpDr4QNGo2HdLTSdW6eFU6QMFPLnx5ECRHk1+EdGlyiTVaZWLH8fqyAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3423.namprd12.prod.outlook.com (20.178.242.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 29 Nov 2019 08:25:12 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 08:25:12 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Topic: [PATCH 2/2] drm/amdgpu: should stop GFX ring in hw_fini
Thread-Index: AQHVpo5N8B+hMi8Uk0ugQyJYA12FaKehz6wQ
Date: Fri, 29 Nov 2019 08:25:11 +0000
Message-ID: <MN2PR12MB3933E735B5CA1C94399A31A284460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
 <1575015812-26634-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1575015812-26634-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 662a7d68-0507-49f0-ae07-08d774a5a747
x-ms-traffictypediagnostic: MN2PR12MB3423:|MN2PR12MB3423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3423B09259E52577B297AD6A84460@MN2PR12MB3423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(13464003)(199004)(189003)(256004)(6506007)(9686003)(26005)(3846002)(6246003)(71190400001)(81166006)(14454004)(81156014)(66446008)(55016002)(53546011)(6436002)(11346002)(8676002)(74316002)(229853002)(6116002)(99286004)(66066001)(446003)(5660300002)(8936002)(110136005)(33656002)(52536014)(316002)(64756008)(186003)(305945005)(66476007)(66556008)(71200400001)(2906002)(7736002)(478600001)(66946007)(2501003)(25786009)(102836004)(76176011)(86362001)(76116006)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3423;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLEPMVFucMQ68ynxqd6MwPp4QZc32OKi7bXCH/zEZES24OsO0sBZ7eYV8qLcs3CAyFvnz6E431rD12sago+ldgJlZ+Z6RJdqOzFVNkk2CIrWmjwuom7fjgrlyoYqRMz9nMzH0PbQeXaFNUwME2IwOAIs5JRtbxhrg5Fk27UWr0g7I3E8QppBogDsqxPssdcvL2d12Xm3jBX+/E35w6vm3HVUlS0j4BpJSO3omkrJniK8KK7Hwz8HgkyscTeBT3c2lIYyFqPXpqjIXFBgN+M5awR2+cKEdpBzzTQwcC7b4zlpQZFgBNlBXsNjYnr3TlvQl9bWc95bilj62qAcuJJ4cEyOf4rPm10k1wzYL6hZ61kJzFHIKhRhDXD24fk014lPBV25R4tvzd/bTgSD8lGZ3s4PBPC+Io2qrl2M5X+SiSbdvdzflJ1ZnnhBG99xiS5E
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662a7d68-0507-49f0-ae07-08d774a5a747
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:25:11.9833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8qxvy72fJyR0yViR0QxnLeIAPjWuC4AEP+hyQJbh4p5fLABTS5sngHpyltmDy2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm8BzSebMyU25FGr9PFNo4A7tBE3vnXCJmOMXKtISLE=;
 b=DtF58NOo0WtmG84J5r4oKfPLg7VwDm0yBwVVgnQh0q0zymc9mJrDnSanEQIUws0ZumiYF0KCfrAV1GLNmmyjXQr1Cg9ub3t7BTVASJFt+rC2q4PkrI5+BVq9bPtXmg/xjVPOIJO0SV6UP+sBjUeQ939Qum8dErQo0WJTErD0+Iw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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

U29ycnksIHRoZSBkZXNjcmlwdGlvbiBvZiAiIHdpdGhvdXQgZGlzYWJsaW5nIGdmeCByaW5nIGlu
IGh3X2Zpbmkgd2Ugd291bGQgaGl0IEdGWCBoYW5nIGlmIGEgZ3Vlc3QgVk0gaXMgZGVzdHJveWVk
IHN1ZGRlbmx5IHdoZW4gcnVubmluZyBhIGdhbWUiIGlzIG5vdCBjb3JyZWN0CgpXaWxsIHNlbmQg
YW5vdGhlciBvbmUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk1vbmsg
TGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKCgotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQpGcm9tOiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4gClNlbnQ6IEZyaWRheSwgTm92
ZW1iZXIgMjksIDIwMTkgNDoyNCBQTQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4KU3ViamVjdDogW1BBVENIIDIvMl0gZHJt
L2FtZGdwdTogc2hvdWxkIHN0b3AgR0ZYIHJpbmcgaW4gaHdfZmluaQoKVG8gYWxpZ24gd2l0aCB0
aGUgc2NoZW1lIGZyb20gZ2Z4OToKCndpdGhvdXQgZGlzYWJsaW5nIGdmeCByaW5nIGluIGh3X2Zp
bmkgd2Ugd291bGQgaGl0IEdGWCBoYW5nIGlmIGEgZ3Vlc3QgVk0gaXMgZGVzdHJveWVkIHN1ZGRl
bmx5IHdoZW4gcnVubmluZyBhIGdhbWUKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxp
dUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jCmluZGV4IDIzMGU4YWYuLjg4MmNmMWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0zODA5LDYgKzM4MDksNyBAQCBzdGF0aWMgaW50IGdm
eF92MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAlpZiAoYW1kZ3B1X2dmeF9kaXNhYmxlX2tj
cShhZGV2KSkKIAkJRFJNX0VSUk9SKCJLQ1EgZGlzYWJsZSBmYWlsZWRcbiIpOwogCWlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJZ2Z4X3YxMF8wX2NwX2dmeF9lbmFibGUoYWRldiwgZmFs
c2UpOwogCQlwcl9kZWJ1ZygiRm9yIFNSSU9WIGNsaWVudCwgc2hvdWxkbid0IGRvIGFueXRoaW5n
LlxuIik7CiAJCXJldHVybiAwOwogCX0KLS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
