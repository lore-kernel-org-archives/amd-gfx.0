Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE193CA9EAF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B707F20717
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707F20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C7F6ECBE;
	Wed, 30 Oct 2019 08:19:18 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9CD6ECBE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 08:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKZ1lp20MfSsx6QfuXLK3OS5l1wKDXtOJO1UETp3xO40IkV6BHvxZGdttu+lA4oaKvLvllcGFCm8B+jmoW65MnuP5lz8JreRjM8gNiLr2ek5PIZMO4PTpeSIbw7JQfBLBkhI5ShBX1jEK7bovQV4a2LuPVP0bsTT+5ZeW+Xt4tLyuQM2oWFBw8XX4+iYnBkkYYD9K936XlDWxPeiiQeOOmVgqVAcJmsWeVtPsXCNdP8hSX8MlvyzVpYXbbv+2fLcHTrVlC23fW8w3O4KkVMYeP5HwAKbyeiczHBiyFaV0xOZn6g0ZZtjOiqRgaivMVxVBeFvIlqzMKeUZpj6n1f7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZn+NuwNQfur+p4fSWJU7Njd64KtYnI+7stM0iTn86o=;
 b=Uuts604VDr8pDyEr6tXnqYQ/TjM3eLalOzFCccOJR7NrpER4nDYwy4DXa2XFHDYw96O1t6SgL6TvZ21d3ol58/iHPM/jH4Qpa+SPxalBbgdtX/xn7UTJGUd3+yw/rQHSxVAo2Agm8H3OjIfQba/AWv/70ae+v90DnYO61EnUtQ/psSstF/jBdc43nhE/OZ2XkLZHQzT7/QtRL5rnDPJy33JYNMyaow7++c1h3E0UhOJiTZNR/86HFp0VDwPTba8eG6Gs9WVs3eIrrPnf3uPqr3Zi7XO01FkD8RBkBhAvo8B+XsG3Jm1wBU6jqFUxPu0mg/YaO88buIy4wpFOSc7+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3602.namprd12.prod.outlook.com (20.178.212.86) by
 BN8PR12MB3043.namprd12.prod.outlook.com (20.178.209.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 08:19:14 +0000
Received: from BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05]) by BN8PR12MB3602.namprd12.prod.outlook.com
 ([fe80::adae:509b:748f:cd05%6]) with mapi id 15.20.2408.018; Wed, 30 Oct 2019
 08:19:14 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: print the pptable provider
Thread-Topic: [PATCH] drm/amd/powerplay: print the pptable provider
Thread-Index: AQHVjvq3p/kOuy2k70OsNJT+A/PoQA==
Date: Wed, 30 Oct 2019 08:19:14 +0000
Message-ID: <20191030081858.2807-1-xiaojie.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To BN8PR12MB3602.namprd12.prod.outlook.com
 (2603:10b6:408:49::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb0e7faa-42fe-4767-3e6a-08d75d11d97f
x-ms-traffictypediagnostic: BN8PR12MB3043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB30433648A2F0CDC9AA90506389600@BN8PR12MB3043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(71200400001)(66066001)(71190400001)(186003)(26005)(256004)(316002)(102836004)(6916009)(36756003)(14454004)(6436002)(2906002)(7736002)(305945005)(4326008)(6512007)(5640700003)(66556008)(6486002)(2351001)(6116002)(54906003)(1076003)(81166006)(6506007)(2501003)(66946007)(478600001)(66446008)(81156014)(8676002)(5660300002)(52116002)(2616005)(66476007)(99286004)(8936002)(64756008)(386003)(476003)(25786009)(486006)(3846002)(86362001)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3043;
 H:BN8PR12MB3602.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeRrOWjiJu02b9ilby4GmeEAz9JFq9A48tJfeQWybDObjd0NytTzSv/BgFcWAPIrp0QtHIZTCo5wSfQWUDfZwYwnGBwjuUBld2zGLs5kqllTRwwOtyuBLjcHe5fKD7lyDSInVETIEi+NPDsLRJ/2Q2Fd2Ob1p5xnjs38D8N927b8c/E8vlI9a/yEJjqZpYnFk9gOFy/wzhqENXef3ZTQbXpLmU1VETPfQLX/ITWqwwvtbqZbZ0/1zAwY1ETgmkNFwaCWdpeEji79g25AN2gda5LrM+uPCELd2l8Dc8xRahS0Pn6MWW8vSxn/0Z5cTaSMU1AVh2VEjLTmlr8Vn1dD1prIHNxBzCaat+duB1NnHqYis0wsIuFJ3LfjmfRwMHxf3AYPngN+AhI9BsgBwrOyk/foOWhyRz5MLoyk5ytTjyw42OZXreHB0b6EWQNtDH93
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e7faa-42fe-4767-3e6a-08d75d11d97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 08:19:14.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDPKRXg9POxvhF3pvXCf0sWs6HgEZh/kvDlVdhea/U2792IM4Nym8dJf58T59FyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3043
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZn+NuwNQfur+p4fSWJU7Njd64KtYnI+7stM0iTn86o=;
 b=Rvtrk4sxTkOZZa64a5p5lYn1ttoTjSiY6SIdmSbRyR/itZQVk8s93qcCKTog8NvWrT+MsqttZU+LyEm4/FplftSc2lgdGQ/iKyaZFoDh/9+nm0CZ5jZUYuCMqcw5F4/9xQKixMfirhuw9hGYaBjKU+g3Zt6x7oBm0jFi3KaHaIg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Yuan, 
 Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030081914.3ERe0OT78S3sSOO3Q2a74JP_f5HJLYgfC3rrLvyC5fg@z>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYyB8IDIgKysKIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTFfMC5jCmluZGV4IDdlODgyOTk5YWJhZC4uMGY3NTA0YWUyMzk1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYwpAQCAtMzY4LDYgKzM2OCw3IEBAIGludCBz
bXVfdjExXzBfc2V0dXBfcHB0YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAl2ZXJzaW9u
X21ham9yID0gbGUxNl90b19jcHUoaGRyLT5oZWFkZXIuaGVhZGVyX3ZlcnNpb25fbWFqb3IpOwog
CXZlcnNpb25fbWlub3IgPSBsZTE2X3RvX2NwdShoZHItPmhlYWRlci5oZWFkZXJfdmVyc2lvbl9t
aW5vcik7CiAJaWYgKHZlcnNpb25fbWFqb3IgPT0gMiAmJiBzbXUtPnNtdV90YWJsZS5ib290X3Zh
bHVlcy5wcF90YWJsZV9pZCA+IDApIHsKKwkJcHJfaW5mbygidXNlIGRyaXZlciBwcm92aWRlZCBw
cHRhYmxlICVkXG4iLCBzbXUtPnNtdV90YWJsZS5ib290X3ZhbHVlcy5wcF90YWJsZV9pZCk7CiAJ
CXN3aXRjaCAodmVyc2lvbl9taW5vcikgewogCQljYXNlIDA6CiAJCQlyZXQgPSBzbXVfdjExXzBf
c2V0X3BwdGFibGVfdjJfMChzbXUsICZ0YWJsZSwgJnNpemUpOwpAQCAtMzg0LDYgKzM4NSw3IEBA
IGludCBzbXVfdjExXzBfc2V0dXBfcHB0YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAkJ
CXJldHVybiByZXQ7CiAKIAl9IGVsc2UgeworCQlwcl9pbmZvKCJ1c2UgdmJpb3MgcHJvdmlkZWQg
cHB0YWJsZVxuIik7CiAJCWluZGV4ID0gZ2V0X2luZGV4X2ludG9fbWFzdGVyX3RhYmxlKGF0b21f
bWFzdGVyX2xpc3Rfb2ZfZGF0YV90YWJsZXNfdjJfMSwKIAkJCQkJCSAgICBwb3dlcnBsYXlpbmZv
KTsKIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
