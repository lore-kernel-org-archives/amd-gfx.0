Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A584C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 22:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736352070E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 22:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736352070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC85C6E0DA;
	Fri, 22 Nov 2019 22:56:00 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740041.outbound.protection.outlook.com [40.107.74.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFD06E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 22:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfl6W7ajyoCNhCI7EcA6j5kT22Pql/bDeUPJ00me4sCArOlNI+8OssKq7Q63ETPK0iPW6vSVf5UEHrHpQFdrcUY+HsvPVYO+mzisxVEqc9W6XgL+uJkF8VmBm/eI8REfMix9r5mFQfznNGvV3oGCl3ASazdbUQUOWScXiWMusiaC76QgIbErP1Wvv2MR95+PBM4taVSzEGn0DZPjoEFKNU46l4fyUIp+deQQx9UmP1O1w5xDvx9Tls+0ZLMkB4TL+wlG5+9w3QF2+kufqNUJ+V2NMFk3pJUAyRbtLYhQ7Nf+DUpPg+OkfrrBgZItDUYzaL8Gx021siQsVuIEyCqFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kMwIBRtaqWYtWfoHDCcJJPqV/Wz9rmow6VdIFf/QD8=;
 b=F7Ypun71QRMXTJcsU7oE1JwdrJfZerK0zkvCSzqFc/cPw8dNJ5NUjILNQJk64/+l7a+gQ+9pyrElB7lI3FZkikUjG3D0C7KRIigvlLWG3B1cUid8Lf2hVWkbGFAASu7p9rip4HvtcvRtPdYbbcGiRc8/xYBSq5QbtzaeSRkUd1TGJSkLtmDuspZt5mSGFH3KF05YphmpblQC6bcilVKXoZ7kkIvzWT3mjbScXcGeMv7JBs3+wPZUHwqIvQrkrS1DkKp8r+8+BvE0SZXe/tTMsjykYRGk1sc7JCwGovg2MsymmOAWv8K59dk+NaiX4zgcDc9TrS/Yz1RZMh3hfidpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2513.namprd12.prod.outlook.com (52.132.9.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Fri, 22 Nov 2019 22:55:58 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 22:55:57 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Apply noretry setting for mmhub9.4
Date: Fri, 22 Nov 2019 16:55:47 -0600
Message-Id: <1574463347-27961-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To BL0PR12MB2580.namprd12.prod.outlook.com
 (2603:10b6:207:3e::19)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2884be34-e7a0-4d78-4a71-08d76f9f2314
X-MS-TrafficTypeDiagnostic: BL0PR12MB2513:|BL0PR12MB2513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2513E1A6CEADC3AB983D13CF80490@BL0PR12MB2513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(99286004)(50466002)(48376002)(7736002)(305945005)(5660300002)(66556008)(316002)(66946007)(6512007)(66476007)(36756003)(16586007)(50226002)(6436002)(14454004)(2361001)(6506007)(26005)(186003)(81156014)(81166006)(8936002)(6916009)(6116002)(3846002)(6486002)(51416003)(52116002)(2351001)(6666004)(66066001)(86362001)(25786009)(8676002)(2616005)(47776003)(2906002)(4326008)(386003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2513;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpzJbg39cu/vIIHzPd5d41VosEI9GZAXDKWlkC1+y1Ai24xAZpLXHXuVyKC/?=
 =?us-ascii?Q?xteKHJOVnKicjKFeDmE6bvavzPWDYy4CD2yoU2haBaSLVu1WWNLapSjqx/cM?=
 =?us-ascii?Q?TSkln/N6640Od8Co9QS2VmmonOPr0Zxg4P/+LYOu0G403K893srBTHGPOxC9?=
 =?us-ascii?Q?yls8wzycMI+5G3QdJcDhTHjro5aslk1Oas4h63l17IBgeo8RnXD7EDGrBEQn?=
 =?us-ascii?Q?sFDkYP4P5NfXTp8ivAN/vx/pXMxRH1RdOX3nAejWIJokGmsdrqvXGVP0P3Fh?=
 =?us-ascii?Q?kT68LSwjPaHCo3izFghuVy0yhmyL5Xf/lBr0c2DSA5DFRrBWNe3qvxmRvLaJ?=
 =?us-ascii?Q?dCXNf8/ZglTaQdoSWvUvbYRd4tujzPy5FBICAyIXGNMoeMTTENiaiQxRnCjk?=
 =?us-ascii?Q?rPgwHJRiqniKFVTHr9apcMpxSVTOv52+OnDZ7v2oYxkJmNXN40lq8ApSSTZp?=
 =?us-ascii?Q?ABgLdqCRmEIO6lYO7CK28+97/wPP08bUoBbr+XbR2KBVWIXOj16279FHuRqC?=
 =?us-ascii?Q?yBYL+mksV/fIubFPqR5u95KdPlyENKPcrBQwMFyHAAhA5iXf/XqYa8XQ9Pm0?=
 =?us-ascii?Q?Av3mEi3CMmW+EeIiS8b1jVYE3tuLQSRV0J7okXHilUd57g1x5iuvdqs0Q6zk?=
 =?us-ascii?Q?6vh4dyNkZygkGmenk+MaILsFyGR6Btzz+o40qd6g3d+wcTxNPhTG/FdVWouT?=
 =?us-ascii?Q?AARv9IAtQSy6aBFMLDGuEfXzmRqEKX8VOrd5tf6fo6HVqiTI8kxZw8zRMJa1?=
 =?us-ascii?Q?fQKmxuwH116gauCg7EvomRPJwzlX9oaewMfbKSVFApBbDrfkPhKA5X9AF8FU?=
 =?us-ascii?Q?S0CptMzjv9o5kiLAhg9tEHJFPbcXR0zlkd4ISuboEwZv6o/ewTw+dnE8Fdty?=
 =?us-ascii?Q?/smCMssT0laL8HXxHtp+Up9BDQtTxg6Zbp7j8SLEeR0HWGN1NBIB5TCVx5tQ?=
 =?us-ascii?Q?MO895BfaXipZS0IYr9/VX737fYE4l4nPmU9CdWAK8ZsALlMeo2F4uJ//ePnL?=
 =?us-ascii?Q?9KgtqiRKPl+tYF1Sz6x/4Q6C4yzjnSZqwvW8s7eU8X4d0fL9k7jlsophAAma?=
 =?us-ascii?Q?zZkSx7FaQg1RI/jBLQKHzxb0P8u98yThxtDOCgm8REn1gAH+Oxx4LAsw2lS8?=
 =?us-ascii?Q?s7jadzFtn5wLCBozWU+83UwYzbBwSMyH7wqIZu7Nbpjn/Pt+IJ2rua7W1sft?=
 =?us-ascii?Q?rax/o/67aLOWtaaendVie+Gm+FkCSKop+2zoqaFRFRxuzNhHbzrr2avhxOG+?=
 =?us-ascii?Q?xrYscwwYrDz/NqIQvgx2WKG5fwBYiZMDeK260EbMpLC7Pelf2WqgSyeEYFnz?=
 =?us-ascii?Q?HAvkPOGsBtBqGR9XmXCHnQdusl9swIJRf6e1xc/oGjhuzTgM+8gZfDa/d9eN?=
 =?us-ascii?Q?RNAQnhS5cw8ofHG4Fjqx+U/ycOiZel15Hsc9oxiVZFX9FyZRPW+o7l9Ao7da?=
 =?us-ascii?Q?sRO7uxxIxjxfks2yDFp3NU4skkjoTf0gQ4owRVaLtcWjOFP2zUDOMDlSKFG4?=
 =?us-ascii?Q?KqCj6afJmH2e4azDAGBOtG+tCkTPl8JKyMtD4O5IzWhE9AV6v39bJRbXKXLO?=
 =?us-ascii?Q?VVPKsppkdUmoIiLQwKXlEw6lbq+azwA2xZcRQ7FC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2884be34-e7a0-4d78-4a71-08d76f9f2314
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 22:55:57.7089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HWMGUb+PhYenSL7R9j/GVP0LueBxxk8B1qBcosLmMFc1RIjKSVQkja56NGnuYKD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kMwIBRtaqWYtWfoHDCcJJPqV/Wz9rmow6VdIFf/QD8=;
 b=XA4fgPmvZddvMiid948xHnufmbubpxPtNY+ostmsAXgEq6Cy5X8dy2OqlWJUOoVwYJ+ySHVLva5+mc7gG+OXDMgSlKR3VI07f4by3dMpMq85Rf19W+E1QJs9zQoONxhNlXpmppI5iHFUeaKU8NmNlPDWdZrZI+xJIsHpPJo5Fgs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Cc: Felix.Kuehling@amd.com, Jay.Cornwall@amd.com, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122225547.DFV1-GzH3wTu8X9GGkmLhU1a6rHkeCZaFQnwxhgEDjU@z>

Q29uZmlnIHRoZSB0cmFuc2xhdGlvbiByZXRyeSBiZWhhdmlvciBhY2NvcmRpbmcgdG8gbm9yZXRy
eQprZXJuZWwgcGFyYW1ldGVyCgpDaGFuZ2UtSWQ6IEk1YjkxZWE3NzcxNTEzN2NmOGNiODRlMjU4
Y2NkZmJiMTljN2E0ZWQxClNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29t
PgpTdWdnZXN0ZWQtYnk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIHwgNSArKystLQogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKaW5kZXggNzUzZWVhMi4uODU5OWJmZCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYwpAQCAtMzE0LDcgKzMxNCw4IEBAIHN0YXRp
YyB2b2lkIG1taHViX3Y5XzRfc2V0dXBfdm1pZF9jb25maWcoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIGludCBodWJpZCkKIAkJCQkgICAgYWRldi0+dm1fbWFuYWdlci5ibG9ja19zaXplIC0g
OSk7CiAJCS8qIFNlbmQgbm8tcmV0cnkgWE5BQ0sgb24gZmF1bHQgdG8gc3VwcHJlc3MgVk0gZmF1
bHQgc3Rvcm0uICovCiAJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyVkMwX1ZNX0NPTlRF
WFQxX0NOVEwsCi0JCQkJICAgIFJFVFJZX1BFUk1JU1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxU
LCAwKTsKKwkJCQkgICAgUkVUUllfUEVSTUlTU0lPTl9PUl9JTlZBTElEX1BBR0VfRkFVTFQsCisJ
CQkJICAgICFhbWRncHVfbm9yZXRyeSk7CiAJCVdSRUczMl9TT0MxNV9PRkZTRVQoTU1IVUIsIDAs
IG1tVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLAogCQkJCSAgICBodWJpZCAqIE1NSFVCX0lOU1RB
TkNFX1JFR0lTVEVSX09GRlNFVCArIGksCiAJCQkJICAgIHRtcCk7CkBAIC05MDUsNCArOTA2LDQg
QEAgc3RhdGljIHZvaWQgbW1odWJfdjlfNF9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCiBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21taHViX2Z1bmNzIG1taHVi
X3Y5XzRfZnVuY3MgPSB7CiAJLnJhc19sYXRlX2luaXQgPSBhbWRncHVfbW1odWJfcmFzX2xhdGVf
aW5pdCwKIAkucXVlcnlfcmFzX2Vycm9yX2NvdW50ID0gbW1odWJfdjlfNF9xdWVyeV9yYXNfZXJy
b3JfY291bnQsCi19OwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK307Ci0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
