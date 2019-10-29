Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD583CA9EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 07:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C6A20717
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 07:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C6A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA766E0E5;
	Tue, 29 Oct 2019 07:43:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680040.outbound.protection.outlook.com [40.107.68.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE2F6E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 07:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz2YyhiEX6rGHqq0hDQ3BL1F4coqh6p6OKfA6mHohxhK00ajA0VgMjzZtGg2z30pZ6JDnDwnPwO8P59ztTMrM5IqtoUuiBplmlXWYYrIkVCMxsK2D9LCFdWJz4aGGM+QxC/78pE1EvIg6pyy5pNmXKY999PpgWD63U9cxCNR25b1GNLj1LkTqRK5krL3o4LvPoAOEWc1bzkQNYj6+xP4UmH9ZOgtfReuyZvMeLd+YdI1okgblf6TLMMOAFMEn7nvL1HhZFu4g0BHPXzMljtVk5iDG53y26Bs8jzIf414SreMMMtW0TajH771kMiBQrl1g3dsu7HcYRTP7qaSBNN5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKgOM7A6Aqr3OxYzK51D6wRSKZ/HUJKBcJHYi8gE3a4=;
 b=fmXiOfE4i25j79+DVw7O+7oMoD4tek/XBnEceiYlRrGaP9kpOU873GLP+YkRC0xeZQGepbTZu7jHSFCTRTF7+Gej8IY/5yYtdksMPoAXEs1MYw9OX7kmnUcntDO8WlEurtryDTgWNa4RyCN+gLhO8G1uMdAvvFKsdD+YW61fJl9JZwNaghM2EGXPPJgsOSphyqQ3T7u5jty/KIbdyXj7niOGaODQ4QK15b0o8BcDeT0ciIzSz2qPBBPQsH5He7qCwkKmo9E4Y4P6T/FxfWya4kbZOxS9+zMAQiQZL9+iKQ9E7WE7n6pDVLtBYwDkvNepK87dv1rBukKzH4ZksrMfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3047.namprd12.prod.outlook.com (20.178.53.220) by
 BYAPR12MB2631.namprd12.prod.outlook.com (20.176.255.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 07:43:10 +0000
Received: from BYAPR12MB3047.namprd12.prod.outlook.com
 ([fe80::558e:5107:e9d1:f02b]) by BYAPR12MB3047.namprd12.prod.outlook.com
 ([fe80::558e:5107:e9d1:f02b%5]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 07:43:10 +0000
From: <jianzh@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP
Thread-Topic: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP
Thread-Index: AQHVjiyC8kvX+eeTjE2pmaa0Hd10kQ==
Date: Tue, 29 Oct 2019 07:43:09 +0000
Message-ID: <20191029074248.11942-1-jianzh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:203:52::26) To BYAPR12MB3047.namprd12.prod.outlook.com
 (2603:10b6:a03:d9::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0aa51a61-e5b3-4223-ae33-08d75c43a4db
x-ms-traffictypediagnostic: BYAPR12MB2631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26312176F4FAC2DE21BE333BE1610@BYAPR12MB2631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(2616005)(316002)(476003)(8936002)(71190400001)(71200400001)(486006)(50226002)(64756008)(66946007)(2351001)(81156014)(8676002)(54906003)(66476007)(81166006)(66556008)(36756003)(2501003)(305945005)(7736002)(256004)(66446008)(5660300002)(52116002)(14454004)(14444005)(6116002)(6506007)(6916009)(386003)(186003)(6436002)(6486002)(478600001)(6512007)(102836004)(99286004)(5640700003)(3846002)(25786009)(26005)(1076003)(66066001)(4326008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2631;
 H:BYAPR12MB3047.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nhu8ne3jrISltHd32Dd9OPPM1E8MeWNaXvorr/SMY6gWDVqEkLO5l3oaya2VVaouoRa+i30vhVACVEgYPERmUe9JtsCpKdmJHhtFf3tRNWAtiX/rHzsIa31tP685+DR+VM/zF6DzIMA8oFUtZygqdKacPakxaCBXb6mhAOCGQKT+CbCmfmmeDWboT4bWEVcvq59TGmbZPRzaHY/pb1ZANsNiGwbLcPTjyzgMsLKDQiVL7dCUtJ9tAP6AgwA9efI8KfpXTy9f8ItOed1r8hYl31xJBfKxuR8v0mU4nNU8NDMSzi4PiOqryskh9GW7AcnBtRW851CuvLFLnahs8cr/S009b+7rjQfMPWG19XbXat5pjNTSd7evzA70tlynyNSuIr4CGEFXMFdHm5jBuRlb1rXtsGFT04J9aqmlb6yWEY3EdWZa3j78RaM1s3waz1sN
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa51a61-e5b3-4223-ae33-08d75c43a4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 07:43:09.9276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WmgDSG5XVYr/GjKBTvPQYUqIRw2afDeD9ZNPjDnjm06XGfRK6XMteWOBrtmQVDA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKgOM7A6Aqr3OxYzK51D6wRSKZ/HUJKBcJHYi8gE3a4=;
 b=QNSVgkiQxbAG3A3KkeXZi5/sTtqLOeqVVIRPl/G51yKC0nAVyS2JL45doqcnMqrc+Ge2bEb465eUZ3gVyk5+TLy55/LKSk+at1YgEkV7wc0YNCF10IMBupbQ8tC84KU1Z/ql15euEGFScFVERvlgVKMH2F+6eyI/GxPaslADCCg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiange.Zhao@amd.com; 
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Jiange" <Jiange.Zhao@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029074309.0JTG2in65tcRkL0j6Hai_vlkL13Qvp_rqZdwYhUYDFI@z>

RnJvbTogSmlhbmdlIFpoYW8gPEppYW5nZS5aaGFvQGFtZC5jb20+CgpJbiB0aGUgb2xkIHdheSwg
d2hlbiBkb2luZyBJSCBod19pbml0LCBQU1AsIG52X2NvbW1vbgphbmQgR01DIGh3LnN0YXR1cyB3
b3VsZCBiZSByZXNldCB0byBmYWxzZSwgZXZlbiB0aG91Z2gKdGhlaXIgaHdfaW5pdCBoYXZlIGJl
ZW4gZG9uZS4gSW4gdGhlIG5leHQgc3RlcCwgZndfbG9hZGluZywKUFNQIHdvdWxkIGRvIGh3X2lu
aXQgYWdhaW4uCgpJbiB0aGUgbmV3IHdheSwgb25seSByZXNldCBody5zdGF0dXMgdG8gZmFsc2Ug
Zm9yIHRoZSB0YXJnZXQKSVAgaW4gdGhlIGxpc3QuIEluIHRoaXMgd2F5LCBQU1Agd2lsbCBvbmx5
IGRvIGh3X2luaXQgb25jZS4KClNpZ25lZC1vZmYtYnk6IEppYW5nZSBaaGFvIDxKaWFuZ2UuWmhh
b0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA0ZWVlNDBi
OWQwYjAuLmFkNmQyNDUyZmVkOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwpAQCAtMjM1MiwxMSArMjM1MiwxMSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZp
Y2VfaXBfcmVpbml0X2Vhcmx5X3NyaW92KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlm
b3IgKGogPSAwOyBqIDwgYWRldi0+bnVtX2lwX2Jsb2NrczsgaisrKSB7CiAJCQlibG9jayA9ICZh
ZGV2LT5pcF9ibG9ja3Nbal07CiAKLQkJCWJsb2NrLT5zdGF0dXMuaHcgPSBmYWxzZTsKIAkJCWlm
IChibG9jay0+dmVyc2lvbi0+dHlwZSAhPSBpcF9vcmRlcltpXSB8fAogCQkJCSFibG9jay0+c3Rh
dHVzLnZhbGlkKQogCQkJCWNvbnRpbnVlOwogCisJCQlibG9jay0+c3RhdHVzLmh3ID0gZmFsc2U7
CiAJCQlyID0gYmxvY2stPnZlcnNpb24tPmZ1bmNzLT5od19pbml0KGFkZXYpOwogCQkJRFJNX0lO
Rk8oIlJFLUlOSVQtZWFybHk6ICVzICVzXG4iLCBibG9jay0+dmVyc2lvbi0+ZnVuY3MtPm5hbWUs
IHI/ImZhaWxlZCI6InN1Y2NlZWRlZCIpOwogCQkJaWYgKHIpCi0tIAoyLjIwLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
