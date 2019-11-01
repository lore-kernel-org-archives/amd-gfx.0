Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCBBCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E18217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E18217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0306F862;
	Fri,  1 Nov 2019 20:12:30 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800075.outbound.protection.outlook.com [40.107.80.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4669F6F862
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJlrcCiKhUyUcDp3GZIlyWxMRwMPecXP5063ae7Kx//kC0yAZ4Ga0+vQNnIdiUXZPjPPROY1QSFdXne3PcBGtNPZpjWkltHBPxh2Fdrccf2fft/vbcT8z5xDxM2+V1jVa+ZeSDGmrHo+ZGFrwAXbBLJ8nJVswA2hxrfG71JKnPKU/LhNpijpLyz/w5+E5sNInc9BS4k7mgfF5mKUo5Hm5s22ZTn+VRHd/4/wXeBj0VMhGuvoZgMGeHXu0sKczTPOmdujTvzqlCcnyeB9RdbiT74dOmk/4EWBKw+zZDTyy6tpVfqfN+b7RrYBha2uSNw1AsouW9yVhf8Kd0XeUzDkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J04iNYpzuvmSg57C2qGFwXZuKCkA+/z2IFSvQ+tAOPc=;
 b=Q2451XNIu9qlxlsIdu8A2LJo8uLI8eRECcSnYQFHD5uwG0USV7ZSl87tfU1rkcPVJtRTF8MzjPA6imOjwzCsqdE8c34Gkd9nhg7cjRj78Xl4siXhg8YD2jfcXvNTClN8YNrIy6T7SIIItZA6QDegD9RmdAYJnkeNAWcZ7Ru6KzXm09HRVdAze0B63VpwVcGjtyLpomSSw2VwmiUTEFkW3iXb8z4xch9pKknkKrWSoO1N9Wk/nT3dqB3Nbt4EFKypzifq/nVl61zuszbMgWXK3yOMsfqhkPalGb3N8M5PJGtB2LYlkPAL43idHaEPiJImKu/LLZP2R5ReZqdGYIZdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3740.namprd12.prod.outlook.com (10.255.172.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 20:12:28 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:12:28 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Rename create_cp_queue() to init_user_queue()
Thread-Topic: [PATCH] drm/amdkfd: Rename create_cp_queue() to init_user_queue()
Thread-Index: AQHVkPCuuG1t9ECWekiiZjqOr+EfXQ==
Date: Fri, 1 Nov 2019 20:12:27 +0000
Message-ID: <20191101201216.6205-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dccf37ed-1b40-401e-fdc2-08d75f07d14c
x-ms-traffictypediagnostic: DM6PR12MB3740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37406D97812C5D6BCFAD0CD3F0620@DM6PR12MB3740.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(25786009)(5640700003)(5660300002)(6436002)(6506007)(6486002)(14454004)(486006)(386003)(2616005)(476003)(6916009)(2351001)(2501003)(52116002)(99286004)(256004)(6512007)(36756003)(478600001)(81166006)(2906002)(26005)(8676002)(7736002)(1076003)(186003)(102836004)(316002)(66556008)(81156014)(50226002)(305945005)(4326008)(66476007)(66946007)(64756008)(66446008)(66066001)(3846002)(71200400001)(8936002)(86362001)(6116002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3740;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gnqr4bc64sPtwbzeiwSJIJ6SJIjMYdHjg/Oz1S+5ajdGVKwoI8TrDP53kY5lneASB7L/HGJ7AjqGnjrYCLA4P3Ufp9EByVoTHJ6rd/zCEnaqZ69tBQARa1NeO5qbLXJhgzTDHV996Si5SlaFyus87F/Hl6dgXFTbwn8X+ZNnddDDN/7Vtn9afJ/MqVlkl5ophDukGcD5t3M217qbqL+MzArqyCDa0/t8SvkOfsvG2PLf3iUQAk1KJNmhUGTTwa40HJtbmkozzgUpHIlCNE6QdRkdYl/8fKM3a8er8eIVnlv8p1Ik2wKqTRmTFYEGO3ZuDJkmS8+Fl0qhK9NSTH8NBdN5prEMsu3LUKl7MdaKWbjHgkIU1uwcUQ7NWkj1vRKtOgSNiYx99WQLgnJ0QPtTZIVT4DiD0JL8nL/mlHIwvYkpUNILYTZbC8nUgYkR9yU4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf37ed-1b40-401e-fdc2-08d75f07d14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:12:27.8177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsNbhbzCY7eaAvjLuK7AIEMi/eMnnFp0aQ0JJ+h6cNo21sXrPVN7+MNCox1Dsa1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J04iNYpzuvmSg57C2qGFwXZuKCkA+/z2IFSvQ+tAOPc=;
 b=yeFUe5/qz+55EGAx1dCiD48xfMnYX1yBlkN3H2menltL5YJ3vot/I+nz2VZLJKYpnIsdehTLF+IyboKxAgVsjZEP7UkYoQakkzf2YsRJxD3PYjNdWCHdzNAqtC5OI3Aj0e5wqpwIAQESuU0BwJPdY9qg+tF6IiJMAakdeew0PW0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101201227.MEGmjGlkcPfIlZ1hTbmdutW0F72J_H29wP63pguTsGM@z>

Y3JlYXRlX2NwX3F1ZXVlKCkgY291bGQgYWxzbyB3b3JrIHdpdGggU0RNQSBxdWV1ZXMsIHNvIHdl
IHNob3VsZCByZW5hbWUKaXQuCgpDaGFuZ2UtSWQ6IEk3NmNiYWVkOGZhOTVkZDkwNjJkNzg2Y2Jj
MWRkMDM3ZmYwNDFkYTlkClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFu
YWdlci5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3NfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3NfcXVldWVfbWFuYWdlci5jCmluZGV4IDQ4MTg1ZDI5NTdlOS4uZWJiMmY2OWI0MzhjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9t
YW5hZ2VyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVl
dWVfbWFuYWdlci5jCkBAIC0xNjIsNyArMTYyLDcgQEAgdm9pZCBwcW1fdW5pbml0KHN0cnVjdCBw
cm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSkKIAlwcW0tPnF1ZXVlX3Nsb3RfYml0bWFwID0gTlVM
TDsKIH0KIAotc3RhdGljIGludCBjcmVhdGVfY3BfcXVldWUoc3RydWN0IHByb2Nlc3NfcXVldWVf
bWFuYWdlciAqcHFtLAorc3RhdGljIGludCBpbml0X3VzZXJfcXVldWUoc3RydWN0IHByb2Nlc3Nf
cXVldWVfbWFuYWdlciAqcHFtLAogCQkJCXN0cnVjdCBrZmRfZGV2ICpkZXYsIHN0cnVjdCBxdWV1
ZSAqKnEsCiAJCQkJc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnFfcHJvcGVydGllcywKIAkJCQlz
dHJ1Y3QgZmlsZSAqZiwgdW5zaWduZWQgaW50IHFpZCkKQEAgLTI1MSw3ICsyNTEsNyBAQCBpbnQg
cHFtX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyICpwcW0sCiAJCQln
b3RvIGVycl9jcmVhdGVfcXVldWU7CiAJCX0KIAotCQlyZXR2YWwgPSBjcmVhdGVfY3BfcXVldWUo
cHFtLCBkZXYsICZxLCBwcm9wZXJ0aWVzLCBmLCAqcWlkKTsKKwkJcmV0dmFsID0gaW5pdF91c2Vy
X3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7CiAJCWlmIChyZXR2YWwg
IT0gMCkKIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKIAkJcHFuLT5xID0gcTsKQEAgLTI3Miw3
ICsyNzIsNyBAQCBpbnQgcHFtX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgcHJvY2Vzc19xdWV1ZV9tYW5h
Z2VyICpwcW0sCiAJCQlnb3RvIGVycl9jcmVhdGVfcXVldWU7CiAJCX0KIAotCQlyZXR2YWwgPSBj
cmVhdGVfY3BfcXVldWUocHFtLCBkZXYsICZxLCBwcm9wZXJ0aWVzLCBmLCAqcWlkKTsKKwkJcmV0
dmFsID0gaW5pdF91c2VyX3F1ZXVlKHBxbSwgZGV2LCAmcSwgcHJvcGVydGllcywgZiwgKnFpZCk7
CiAJCWlmIChyZXR2YWwgIT0gMCkKIAkJCWdvdG8gZXJyX2NyZWF0ZV9xdWV1ZTsKIAkJcHFuLT5x
ID0gcTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
