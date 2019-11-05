Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C591C010C6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691832190F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 11:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691832190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298266E9F4;
	Tue,  5 Nov 2019 11:42:44 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730080.outbound.protection.outlook.com [40.107.73.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF576E9F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 11:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMhPUQcxAv2cF2tme78BgTCIUFTTrLJ/ayKn8L5EBSLsX6/C+XyeNx2dWmrqdOtxko9SUqbuVkI4/gJH7c1Zg9DwkTAuXI7IqXgpRN6zHf4/QllwrMbDHlIhWgC42uxkBhYpy8ZVyu+rAvLC+eZsm0HqxHggV5HKfrnn1aYQfko2V+AFL3Vgq2HLVOuY+FFhYt3qFUPu+1qy2ZxNlGmnsZrcl2d2LAtk4AXNfZU3HFQoMKkOhifDrwC8CCyD419mTXVkk8xBTg2m//Y1OGjtOGJ5oQ+uWRtPAzmPiMMUqBR7tRKuf4zGZAmObWmxvV2GLgOkIlDPnDU/qgLUR31ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4gy/on07qol20bohhwWUVRDZa4y4J/KT0g9Aa+ELA4=;
 b=fgRyUrVVl3acr/D0SN4Vb6lzV+dJNEUeX9xwGR38+hkSpVboHcD1rorXWPM02P+O33UA2bEnFWSm8aCUGki47fHPamN2aGmr+G9B6LYoNVNOoa5bwRa6vxRZx5zX0aHqvjQ+u7QmOJuHw9IyPmQXtRQaFl38a8lG3v3Eha4MSGQDLPTgwTjmzBoPysLbkHQBJvnGksS4z5pkis6qsN8jriLD+O5K3pxKP4mbhzFD0Xjg+jGIZWfDnar/AuhFsXnQDIu1FHMwxK0rNolqlcXcnemeA2ItYnvtMKgnF85/WsYrjOIlxk1067sSdKhyVt2hlkgoTRreBLRigvjZfFAIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:42:41 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9973:de2e:58b4:282a]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9973:de2e:58b4:282a%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 11:42:41 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov, 
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add warning for GRBM 1-cycle delay issue in
 gfx9
Thread-Topic: [PATCH 2/2] drm/amdgpu: add warning for GRBM 1-cycle delay issue
 in gfx9
Thread-Index: AQHVk84hxCMD9AXHyEKy5OVLzPpXyA==
Date: Tue, 5 Nov 2019 11:42:41 +0000
Message-ID: <20191105114219.4797-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 508211ab-401c-47db-df0d-08d761e543bc
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42568A53FDBF1DC590C94DADFD7E0@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(102836004)(86362001)(186003)(2906002)(1076003)(6512007)(4326008)(3846002)(110136005)(66946007)(36756003)(25786009)(99286004)(316002)(2616005)(81156014)(486006)(14454004)(6486002)(5660300002)(6636002)(305945005)(7736002)(386003)(6116002)(66476007)(64756008)(66556008)(66066001)(2501003)(50226002)(81166006)(71200400001)(71190400001)(478600001)(6436002)(14444005)(8676002)(8936002)(256004)(6506007)(66446008)(52116002)(26005)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHDlWcMnuH3apyPDk3M+GoxOoIt7xmYTHjZFVdt9vtpAwrNJzYyWdczF74q5ktZAAIynN2iV04zZNlKM8jkf+2Xz4CEngKkJpI9X1GYS0qlHKlsjhA2BJ+sn3WUVmpdk3EWRdBepsyXNCz6N616AlPTB8DGKI4rdlnJXOGpgkllQSdkbJCNPF7Emim+0YmMuWlztcQuL5dPPOelg6URiNHK6sTipXBHZx1+54MC7BXAltnOayoHggOzDANDscWGaxrUwmEMFgHVV72Iy5XpbX7UuoCrOxwZSxBZDwsC2UnvKTkjsuBpuudLcu5zPJBqzKiefYPUEE68CyTBBfFRLwypHz8LRWsAaBZDN3XbZXOHNZSF2NNVo04Xot4NhrFtHiRNjzH+nS2puUdmCoJj7bO7ZSyaaNaByIkIr3Zr5bpJf5iLwpHUU5/yKcd7P63Sr
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508211ab-401c-47db-df0d-08d761e543bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:42:41.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFnkwePEMUuij9pYkcCrE4b6aLht7qs1Mz4+33FPj2dapMyvDOfgvOlaEgJgYh3iMcYok3xean4STYWc8RoadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4gy/on07qol20bohhwWUVRDZa4y4J/KT0g9Aa+ELA4=;
 b=rVfquWfKuieCH518TH4iUa1LF88fgJiZbfSBqo4P+ghvpa2a0jU1u4kKNXpAn4xsTf9GRwvotxRjrhCxKVMKo5SETaILEwbnS5hQvfv2fAyObUCbjcmkViQbp6ulSjW/+Q0n/WQ4ufoG5BM4wEjdZTYeXqEsak1MJLjx0fCSNPE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105114241.ZUp9mQVcAlRd02kRtyi9Kkh5Ozs4QOeeFU5joth8mSQ@z>

RnJvbTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KCkl0IG5lZWRzIHRvIGFkZCB3
YXJuaW5nIHRvIHVwZGF0ZSBmaXJtd2FyZSBpbiBnZng5CmluIGNhc2UgdGhhdCBmaXJtd2FyZSBp
cyB0b28gb2xkIHRvIGhhdmUgZnVuY3Rpb24gdG8KcmVhbGl6ZSBkdW1teSByZWFkIGluIGNwIGZp
cm13YXJlLgoKQ2hhbmdlLUlkOiBJNmFlZjk0ZjA4MjMxMzhmMjQ0ZjFlZWRiNjJmZGU4MzNkZDY5
NzAyMwpTaWduZWQtb2ZmLWJ5OiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA3ICsrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwppbmRleCA5ZDVmOTAwZTNlMWMuLmYyZGViMjI1YzhhOSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jCkBAIC05ODIsNiArOTgyLDEzIEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2NoZWNrX2Z3X3dyaXRlX3dhaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJYWRl
di0+Z2Z4Lm1lX2Z3X3dyaXRlX3dhaXQgPSBmYWxzZTsKIAlhZGV2LT5nZngubWVjX2Z3X3dyaXRl
X3dhaXQgPSBmYWxzZTsKIAorCWlmICgoYWRldi0+Z2Z4Lm1lY19md192ZXJzaW9uIDwgMHgwMDAw
MDFhNSkgfHwKKwkgICAgKGFkZXYtPmdmeC5tZWNfZmVhdHVyZV92ZXJzaW9uIDwgNDYpIHx8CisJ
ICAgIChhZGV2LT5nZngucGZwX2Z3X3ZlcnNpb24gPCAweDAwMDAwMGI3KSB8fAorCSAgICAoYWRl
di0+Z2Z4LnBmcF9mZWF0dXJlX3ZlcnNpb24gPCA0NikpCisJCURSTV9XQVJOX09OQ0UoIldhcm5p
bmc6IGNoZWNrIGNwX2Z3X3ZlcnNpb24gYW5kIHVwZGF0ZSBpdCB0byByZWFsaXplIFwKKwkJCQkJ
CUdSQk0gcmVxdWlyZXMgMS1jeWNsZSBkZWxheSBpbiBjcCBmaXJtd2FyZVxuIik7CisKIAlzd2l0
Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewogCWNhc2UgQ0hJUF9WRUdBMTA6CiAJCWlmICgoYWRldi0+
Z2Z4Lm1lX2Z3X3ZlcnNpb24gPj0gMHgwMDAwMDA5YykgJiYKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
