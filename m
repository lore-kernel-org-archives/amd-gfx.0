Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D531C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30295204EC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 22:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30295204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD276EB75;
	Tue,  5 Nov 2019 22:26:57 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800088.outbound.protection.outlook.com [40.107.80.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B256EB75
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 22:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWPWgBYLJhN7x2LdSg6Yutw+8r0hR/4yodreUgqgNYOr+OOeAuyDMOe8JBeVIfv/IsbV1UABnzuFv2tEX+Gqf8wKXcuofY/xvideHekD+m2t3rPLadiy0F0KDxc8cBtlJgu0wTvWiB4qJZsbVhAyqZxKO6wGVgk7p901DJYJpDODARngWOgn5laXQZffdrpSCTb3mX0OIUvzcirbjlXmCrl8dRBO6Drxqr80S9lhUwL1QqgW2/i16HUGSEY1JcKVFfjwUUFuuUb6QKzWlheuFksshxPmDTnEHq1zUOsqIn3zUVVnBoqy2Y0E9VmEg4YVjBzLK6psbip6zroqZp7sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlUo/yGx9Fy/vxXLJqG2d9dIm88SLt0bVnmRSzEllTw=;
 b=bqH5pk3+M3AdiDSlwtt/VPf44ZZkAHgb+qzyXUI23GY1Kddr8XDvlIAufdnubiFxwjXBK4oyk2Dg//gR0K1CidB7pPgsg4zSMkfM4oMiKDP9zaNKCmcC+vKW3PoPIjiIyZeci8lDQEX71RXzG2CMN89orob1kXJqXMPKtw3U52drKU2RhG7+664qk4w9EkwGIFtZkW+8u4QUQ2fRAetKVSHpYPssNBBGRPDITdrltJdjVRQhEup8J+OuQHZ59SuJuZvAIh6lhvQ0TgjqZtfK2N+1h8YAFX1am0GQZ9BXxBbe+ycq78VR2lhLs+LjTUzrhRUR8JopO/0sjVvQ01P9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1159.namprd12.prod.outlook.com (10.168.163.145) by
 CY4PR12MB1207.namprd12.prod.outlook.com (10.168.165.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 22:26:52 +0000
Received: from CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::cde1:b263:67e2:94]) by CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::cde1:b263:67e2:94%2]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 22:26:52 +0000
From: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Topic: [PATCH] drm/amdgpu: change read of GPU clock counter on Vega10 VF
Thread-Index: AQHVlCgfmdBRrOtnp0CjqhT72Mz92Q==
Date: Tue, 5 Nov 2019 22:26:51 +0000
Message-ID: <1572992808-20397-1-git-send-email-JinhuiEric.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To CY4PR12MB1159.namprd12.prod.outlook.com
 (2603:10b6:903:36::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bb3c6dc-926b-45df-e23a-08d7623f417d
x-ms-traffictypediagnostic: CY4PR12MB1207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB120717D5D7A3C99B4673B2A6827E0@CY4PR12MB1207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(386003)(26005)(6506007)(8936002)(71190400001)(6116002)(2501003)(81156014)(52116002)(2351001)(7736002)(86362001)(478600001)(3846002)(305945005)(6512007)(5640700003)(476003)(486006)(4326008)(6916009)(5660300002)(81166006)(66066001)(50226002)(316002)(14444005)(14454004)(256004)(2616005)(36756003)(102836004)(186003)(66556008)(25786009)(99286004)(71200400001)(66946007)(6486002)(66476007)(6436002)(8676002)(66446008)(2906002)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1207;
 H:CY4PR12MB1159.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgABpd+pmtNxc1E5huDVJdirxWXqs1RA8rtSO9t2JDCkIESntD/GCbT7Y0wgIbhTQXhXlLXwTuXO+AMuiS3nKLMMCR8Vrc/igof2tDkIii9cunMB0HJrrLlvXCa7vS+IRNv6L6fcaEtSah7Ua1eArNYPSTCuxcSzez3Q31bd6vLb9GjI4CVHoiE4OWRSwbj7PNsfYB8VMLBEG0xROs9QCYDZ+dzMMm6hhiEVpg6cpNBnkl1OzFVgI3yoe+1TxAsBSHeK4f5CHbkPk/UETZs5fdOrTBVVgrEz5Ow5mDaq7GRGuO74t7xzWEmR8Inc9gjI+H0bXmpE9mDgRIaG6+mQ7+7rqjz8lM5XrGHFzVQsNlfXXSvY5dDQd8PuZk5F0sZ/5z6JBW5BFSNiJijpb7uG8uJa3Hy3KJaYvH7NLJRJ0rcK808sozTp5YNlEu/Kxemk
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb3c6dc-926b-45df-e23a-08d7623f417d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 22:26:51.9004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSAPRpXv4naQ9h/OE8shLPUwiAuRu192RhXRQF1Vt6O9NrtDTHjTo6vdxw7KziizhSAqHSxb+s99tFQzx5u3aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1207
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlUo/yGx9Fy/vxXLJqG2d9dIm88SLt0bVnmRSzEllTw=;
 b=RGjES0lvgcGTMnfV66cwVwCH8B3L38SHIkusjJEC+nc9ACdaBBtVOkMnxdpqOnWRzRjc2qA7vuV/Np4+lU5XgVrBhvws7TZKnBGEHd9q6534Jiv2gPI5Y4PDMg1GbYORtrXbzXzH6H78GGmbojMbAWMBoYb+VSUlcilYrg9ef6Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105222651.UFRHm1a1qSdHWZwxq46eng9Z8YUeAaRP28nwvP8RASc@z>

VXNpbmcgdW5pZmllZCBWQklPUyBoYXMgcGVyZm9ybWFuY2UgZHJvcCBpbiBzcmlvdiBlbnZpcm9u
bWVudC4KVGhlIGZpeCBpcyBzd2l0Y2hpbmcgdG8gYW5vdGhlciByZWdpc3RlciBpbnN0ZWFkLgoK
U2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxOSArKysrKysrKysrKysr
KysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCA4MjlkNjIzLi5lNDRhM2Vh
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTM4ODUsOSArMzg4NSwy
MiBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4X3Y5XzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogCXVpbnQ2NF90IGNsb2NrOwogCiAJbXV0ZXhfbG9jaygm
YWRldi0+Z2Z4LmdwdV9jbG9ja19tdXRleCk7Ci0JV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19D
QVBUVVJFX0dQVV9DTE9DS19DT1VOVCwgMSk7Ci0JY2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NP
QzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTFNCKSB8Ci0JCSgodWludDY0X3QpUlJF
RzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVfQ0xPQ0tfQ09VTlRfTVNCKSA8PCAzMlVMTCk7CisJ
aWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0ExMCAmJiBhbWRncHVfc3Jpb3ZfcnVudGlt
ZShhZGV2KSkgeworCQl1aW50MzJfdCB0bXAsIGxzYiwgbXNiLCBpID0gMDsKKwkJZG8geworCQkJ
aWYgKGkgIT0gMCkKKwkJCQl1ZGVsYXkoMSk7CisJCQl0bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAs
IG1tUkxDX1JFRkNMT0NLX1RJTUVTVEFNUF9NU0IpOworCQkJbHNiID0gUlJFRzMyX1NPQzE1KEdD
LCAwLCBtbVJMQ19SRUZDTE9DS19USU1FU1RBTVBfTFNCKTsKKwkJCW1zYiA9IFJSRUczMl9TT0Mx
NShHQywgMCwgbW1STENfUkVGQ0xPQ0tfVElNRVNUQU1QX01TQik7CisJCQlpKys7CisJCX0gd2hp
bGUgKHVubGlrZWx5KHRtcCAhPSBtc2IpICYmIChpIDwgYWRldi0+dXNlY190aW1lb3V0KSk7CisJ
CWNsb2NrID0gKHVpbnQ2NF90KWxzYiB8ICgodWludDY0X3QpbXNiIDw8IDMyVUxMKTsKKwl9IGVs
c2UgeworCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NBUFRVUkVfR1BVX0NMT0NLX0NPVU5U
LCAxKTsKKwkJY2xvY2sgPSAodWludDY0X3QpUlJFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19HUFVf
Q0xPQ0tfQ09VTlRfTFNCKSB8CisJCQkoKHVpbnQ2NF90KVJSRUczMl9TT0MxNShHQywgMCwgbW1S
TENfR1BVX0NMT0NLX0NPVU5UX01TQikgPDwgMzJVTEwpOworCX0KIAltdXRleF91bmxvY2soJmFk
ZXYtPmdmeC5ncHVfY2xvY2tfbXV0ZXgpOwogCXJldHVybiBjbG9jazsKIH0KLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
