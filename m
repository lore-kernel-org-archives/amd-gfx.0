Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E9CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 18:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B429C20659
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 18:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B429C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D06F6E5E6;
	Thu, 24 Oct 2019 18:46:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24A56E5E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 18:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGzpJaVPAA1zV/csAs1fyJ1utAelo+GXqVQY6MR03iwv07jz/4TvyqdmZcTXODorrEVhgBGBXoTv1cdbETeZ1vMbSgB5op4Bzlo5b52r31YM/iSEtS9T0PdyAyo/QrIOwOtoL0pcJTMFIfUK5ruA2x3gaWys+8X3pR2vY3LgnvN67JPXFn8R6m7ymyRN8Fu1uLEFoeHVKMGhoa8CPfnrmKxeDzfKWPeEfs9wEQH3eDMlmWEHgOYUNiTBSA4NeWCmYrLUMwtH93K05IBzlkU7Js2WUM/L3Z6BCC2+4hIEoWcNHXq3uss2ekJPzV5da/stsmyCQTNHmGb9EbBleWtu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6/XqeGEVJ/M6pOMBTVdAYDNFUHrNAFaziUx8sTFvbM=;
 b=agcyRONjxenoC8gg64d3+HDxt/SIZrHVNHooeOXJ1VxilL82iVPLkoJCDWHYRQOks81+s04uecZEoqRlAN8tr3dshVlmyoVpW4tCluhYCshRu+QbxxxNSkGl5jpzw6YUSOn2aEskRczQX0YAZV5sSz027Ovw9soBweBORNBq5hh4zDKa1Pe7xHqIvof5j8tD1beyWsm74PcwukP5ipgmyI+lCJlPDzbp+tJlSbpltgX9w6Gb0e8HSFiWN0SrYzQ/keH1fmzbzY2MxAF880g/ARUIOd5j+33BkD7MKoM4sD6ySkO6pO/dO3kHIgdwtfssVVgh6YMu41IkrpyZiFeFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 24 Oct 2019 18:46:20 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::6427:ed27:708e:9f02]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::6427:ed27:708e:9f02%7]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 18:46:20 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: bug fix for out of bounds mem on gpu cache
 filling info
Thread-Topic: [PATCH] drm/amdkfd: bug fix for out of bounds mem on gpu cache
 filling info
Thread-Index: AQHViptTWCbaLNLDyECItdAclb8HCA==
Date: Thu, 24 Oct 2019 18:46:20 +0000
Message-ID: <20191024184604.127737-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:805:a2::49) To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20910006-03dd-402c-f75c-08d758b275f3
x-ms-traffictypediagnostic: CH2PR12MB3926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3926887BDA955F0F7F927618FD6A0@CH2PR12MB3926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(71200400001)(486006)(71190400001)(256004)(14444005)(50226002)(478600001)(25786009)(5660300002)(2906002)(316002)(4744005)(86362001)(2616005)(36756003)(3846002)(476003)(6116002)(81156014)(81166006)(1076003)(8936002)(14454004)(186003)(2351001)(4326008)(8676002)(66476007)(66556008)(6436002)(64756008)(66446008)(6486002)(6506007)(386003)(2501003)(6916009)(52116002)(26005)(5640700003)(305945005)(99286004)(102836004)(7736002)(66066001)(6512007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3926;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhg2qGMsgNnRoGlZDJIx8T9Wb4Hwe1/cyfQjx2SAC02yG1gt1gpPzFOWbGLjY25hVq9BuhrkIJuATZn9Wwrvdxmsh2mMuTmZs4YADFFCY0tEF0K5I+qBZrAPcBFvqhimTSmh1FjF9Ue39QaR6dEhnHSmEz1xJFKRA/wEbwkgXUWliP0RUdeq8gZ52DokGCDrxkm4I3TJbXL0euphKZvNXHPVecdzRnj1vb/gQKXa471TFKwCVso/4FMiAoGIjOViulh0DmlZZOQYneDyXZT+j1TCYiduLXf1DExTr+CIxdv8YfrpLgMeAHvAxbrs+E+o3IyN2i9AaEpzXTSMXh68+z/qiD9HX3f6Hi2j4KHQAbMw8e4AmUtKDahyCUbiCwkuHOFLfwftSlnfV8rmpgTa5jgdEjWmTTKfP2VD9vhzLmY1SVaICWq5WMrcBv3LVvZi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20910006-03dd-402c-f75c-08d758b275f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 18:46:20.4452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbZhnWLaOKPthCQOLYT6OzlgXz1Dboy+r7Ir2NImm/7FIY6RFFJNnSGbox4yCrmvO6BJNXuUHfFbvw+nHonceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3926
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6/XqeGEVJ/M6pOMBTVdAYDNFUHrNAFaziUx8sTFvbM=;
 b=U38Oj1aO8uxC6NeOXygngouRcPQ7ozEWKD6YgJVX6LoDfhWO9UPVAKv/ivP4q+5FJ+x6/1L3cBJfcnSZ8WNBNOAwLfS9i7D7HEIqXVngYSgyITKwYQryRVUIpSxYYl186iX8lGCezNLpGAkWiNpc0RhIjlOHXJgiTBfNWYtpyoY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: "Sierra Guiza, Alejandro \(Alex\)" <Alex.Sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024184620._eJcOHFDjMQc2nMAW2_Ns2TrMHLPlGOQVlLWlEDStjk@z>

VGhlIGJpdG1hcCBpbiBjdV9pbmZvIHN0cnVjdHVyZSBpcyBkZWZpbmVkIGFzIGEgNHg0IHNpemUg
YXJyYXkuIEluCkFjdHVydXMsIHRoaXMgbWF0cml4IGlzIGluaXRpYWxpemVkIGFzIGEgNHgyLiBC
YXNlZCBvbiB0aGUgOCBzaGFkZXJzLgpJbiB0aGUgZ3B1IGNhY2hlIGZpbGxpbmcgaW5pdGlhbGl6
YXRpb24sIHRoZSBhY2Nlc3MgdG8gdGhlIGJpdG1hcCBtYXRyaXgKd2FzIGRvbmUgYXMgYW4gOHgx
IGluc3RlYWQgb2YgNHgyLiBDYXVzaW5nIGFuIG91dCBvZiBib3VuZHMgbWVtb3J5CmFjY2VzcyBl
cnJvci4KRHVlIHRvIHRoaXMsIHRoZSBudW1iZXIgb2YgR1BVIGNhY2hlIGVudHJpZXMgd2FzIGlu
Y29uc2lzdGVudC4KClNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2NyYXQuYwppbmRleCAwYzMyN2UwZmMwZjcuLmRlOWY2OGQ1YzMxMiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCkBAIC03MTAsNyArNzEwLDcgQEAg
c3RhdGljIGludCBrZmRfZmlsbF9ncHVfY2FjaGVfaW5mbyhzdHJ1Y3Qga2ZkX2RldiAqa2RldiwK
IAkJCQkJCXBjYWNoZV9pbmZvLAogCQkJCQkJY3VfaW5mbywKIAkJCQkJCW1lbV9hdmFpbGFibGUs
Ci0JCQkJCQljdV9pbmZvLT5jdV9iaXRtYXBbaV1bal0sCisJCQkJCQljdV9pbmZvLT5jdV9iaXRt
YXBbaSAlIDRdW2ogKyBpIC8gNF0sCiAJCQkJCQljdCwKIAkJCQkJCWN1X3Byb2Nlc3Nvcl9pZCwK
IAkJCQkJCWspOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
