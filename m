Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D01CC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5907E20708
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5907E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DD46F565;
	Fri, 22 Nov 2019 20:23:29 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318086F565
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 20:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyVtUTl2G8FuiCp/cnmA9vIkUxp5n6hcv1GZd5x0vCXXDIUM7tqNey4b80hwQ24pzwMv7sNqd9RhQUz8bwAm6f0VQA8Q07CkXCCqGoRdKRdVo0c4TPRzhGGT2kJbHk1u+8EhE2qrjUhhmKHzZfFnv9BDvGzD6pcEP6GWcVw/B4Y0Fc8NJrpvbCtaCKaRgNdj5EetwPpAAm76OTqHodwfi/DLYoJEyeWxQUK6rFizooeer5v2cEN6ZRBoq9DA/V1fGht/wA4umXDoUgwxTyMUKYawdZxaZ2Al9+NWjcZYdzlwJAqxG1UbwIiSyv+saxDla0lhIgfrshNbogd/HUnRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMzT1UsSwlBhtMSBnVdLA0lnFb23niDhznTypCHUxmo=;
 b=N8iAPF8KpuuaU0adlCTAgTbXYkaesx+fHFBo2QGshmYgjZGL3dvdLHtCIQCaarZUIUXslkIN084pSSXHhHw7p/0D0txMaXmmgOuPOdC0Go/qNgy74Ucff7JxWCdaZfughcjohzTX68irTn4JV0v0NC9/vcQ/gehChvUcb7dN448s3+cbELfd8FVbowffCOLb4a0Ij6BesDGKzEsDQeQ509weowyB8pvK3ayiwYqhfJ5VDW5jlcrsDd7rPmJA29GmCkKNb447uAFsF/qkTSVS1cJCEWJH3t3ThdspVkiFmOh6sHUNTlUpYbK9IzT3hnZN6IwX7zT+SDJolAZPVjWy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2513.namprd12.prod.outlook.com (52.132.9.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Fri, 22 Nov 2019 20:23:26 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 20:23:26 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Apply noretry setting for gfx10 and mmhub9.4
Date: Fri, 22 Nov 2019 14:23:17 -0600
Message-Id: <1574454197-13273-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To BL0PR12MB2580.namprd12.prod.outlook.com
 (2603:10b6:207:3e::19)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5acb643f-1a35-45bf-86a5-08d76f89d435
X-MS-TrafficTypeDiagnostic: BL0PR12MB2513:|BL0PR12MB2513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB251329C6C9A415623A1C488080490@BL0PR12MB2513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(99286004)(50466002)(48376002)(7736002)(305945005)(5660300002)(66556008)(316002)(66946007)(6512007)(66476007)(36756003)(16586007)(50226002)(14454004)(2361001)(6506007)(26005)(186003)(81156014)(81166006)(8936002)(6116002)(3846002)(6486002)(6916009)(51416003)(52116002)(2351001)(6666004)(6436002)(8676002)(86362001)(25786009)(2616005)(47776003)(66066001)(2906002)(4326008)(386003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2513;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6R+3yQZCnmmKzIaG1laxaJB/bpSL/Q8IPzQG1XxIiUD4ZBvGQ+wxIA28dOUv?=
 =?us-ascii?Q?ke4WwhAwKUZeEZyAC3XXk9Wlqp6atx4jeKliovWWFcV3bBXruFukJGKesm+n?=
 =?us-ascii?Q?hsHFlTyqLmRS+04t6QaJ8Xf8nUB2tUT8lS/xZxSoHuBbEFTIREiNU2U56ZNf?=
 =?us-ascii?Q?oQOVD1A2VXt9hMG1Cq9lQOJ5duolqbFdNUhG0zXcuH/PFs7Nj3bkK4moekqR?=
 =?us-ascii?Q?LQDztp12mDjJZW0JVqnU+/5nJAfHJPvBaHD6JoqaCdQwkeH8LXKurqYBWmUp?=
 =?us-ascii?Q?I7nqxRc7nT7Hm4Ac8hM0+/JjM3aKNOjsHq8rnnYFB5WrcPtdg/HJMa+rTpvr?=
 =?us-ascii?Q?JzFlHFs4Bc0Tstef6L6WkYfGoIe0XDtedhMKQhBMdfAdSD6TGcuGPon5UfZM?=
 =?us-ascii?Q?1cLK29BNE9cgqVOyneXoZD+EChqqrbwsV0stYr4EoZ4zOa/MzEcM6RiV2r0O?=
 =?us-ascii?Q?qAz4tixY3sFFEmL+cRyn9tfqYIRx7+/8eziu7xyUnUJz2n8HZiXBuznJ3q+7?=
 =?us-ascii?Q?A0NfkuYqiqS0WZMnneH8z9RSp36bYO24+knB0a+WiNhYWqZplv+K1wW/UM9U?=
 =?us-ascii?Q?IH2hLDVbRq4xRJBXvjXYkEzIUXtsis/hokeNv1+CdyyO+F2XnxfBHNyIYvGP?=
 =?us-ascii?Q?0RK3cTC7AmiPriRmytYLFrlKP/IYJWO4UzlRBtarFgJED0KImWleby3gALFe?=
 =?us-ascii?Q?7nTZ3zps8tealHho0GZVfpSj8p4507Dtblipb/qqKRt1u+LtZpqQEZfY59yo?=
 =?us-ascii?Q?9+52HWaPaUDreV6zzYei4BgeixV4lq53s1PVXMQcXBDSLZe/cyRxVwl+1wxx?=
 =?us-ascii?Q?3ctN5SbFQRRYxemctm1F2hmMqvM4GNdWiLLimoq2Y6cM4ChRLDzwphKrDsYu?=
 =?us-ascii?Q?YzUKyN4eopZlgg4bGhCOC/xA04bMYxXdBoad6e2T3DLeHhCfZI/kgYLdzsIz?=
 =?us-ascii?Q?9kggEQ643UnXDYxEvm0TkkG8/d4V6S1Ckyeb7+tsyXNPEbPUzg8CWiRzMwpo?=
 =?us-ascii?Q?zbZ80BUpi7K+oYPktLF8Ex16r1UV4iBDii60NSQgTgy8ovctgXptc31YD08p?=
 =?us-ascii?Q?3wN7HCmYnP6uYyhyA8Jx9+8DmA0HCZXwVzOYmz40i8cSTmNytEIIZp596rIg?=
 =?us-ascii?Q?8J8/M2dpjwPWcqmYclRtJqokEHEti8LWj+fPruHS1ssAIX1V3K5hIJbm5UrC?=
 =?us-ascii?Q?XSf9NZWhLi7l8JzrJnQYGbZljUBOb7TZ0J5MYhZB7yd2HP5+kDyt0ZPAmshU?=
 =?us-ascii?Q?oflULRsWpEhZHigU8CLiWk2z2BTVchv7dnGZWPtUGPYuITmz618SXwhKZLNY?=
 =?us-ascii?Q?bzkyRGPiY/UASpH8XK56ekwgN6fiFTokl5WbLu2UPFNBOnnKYIUHZJxZboKq?=
 =?us-ascii?Q?R08qtpPRPlFNEKVakELWfXJzU9V5BfZZzlqNKlC7adHlBv15lrGtK/frVR6G?=
 =?us-ascii?Q?Ws05Ank16wE1JqYxCwwtN2vrieG+QTM7tMAtDAYeAjGgqQrumkDpxYgMzGRe?=
 =?us-ascii?Q?LNr6AhCrsaWIYvm9msNDqsZuH1+cXwcmuxa9WCa/J/h5UAmgtG4bUpfNWAN4?=
 =?us-ascii?Q?gXNpe/wC/0MMRD96mPOKAwksgo4XTR81cG+C/pH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acb643f-1a35-45bf-86a5-08d76f89d435
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 20:23:26.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwfjrKe5NURtD5GryqHr2IVflJ3z7pqnOAsAww77HfKlhBDkwIVrQ5L9WddYBrHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMzT1UsSwlBhtMSBnVdLA0lnFb23niDhznTypCHUxmo=;
 b=qFwIPSljS9e6B+e/1FTxEzsqyfUUjS6CTyMpZe12np6SYPwvJh37n+Sp5aeTuppc9iAd08ZUSu8jHnKUgHKB2zJidjgHCFexGf9E9RTqYyRLSLL3xuhgMULkKlvzY18hyLIVZOaBQ6sEdGx5gs05q7j5FCegwe76kORRC8JX5mc=
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
Message-ID: <20191122202317.Ngf6VgdQSvhJCd1NIIkkAByrXE6XWV01vxub5hv4lhg@z>

Q29uZmlnIHRoZSB0cmFuc2xhdGlvbiByZXRyeSBiZWhhdmlvciBhY2NvcmRpbmcgdG8gbm9yZXRy
eQprZXJuZWwgcGFyYW1ldGVyCgpDaGFuZ2UtSWQ6IEk1YjkxZWE3NzcxNTEzN2NmOGNiODRlMjU4
Y2NkZmJiMTljN2E0ZWQxClNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29t
PgpTdWdnZXN0ZWQtYnk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgIHwgNCArKystCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgfCA1ICsrKy0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92MTBfMC5jCmluZGV4IDRkNmRmMzUuLjc0MzU0ODcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0xNzUxLDcgKzE3NTEsOSBAQCBzdGF0aWMgdm9pZCBn
ZnhfdjEwXzBfY29uc3RhbnRzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJZm9y
IChpID0gMDsgaSA8IGFkZXYtPnZtX21hbmFnZXIuaWRfbWdyW0FNREdQVV9HRlhIVUJfMF0ubnVt
X2lkczsgaSsrKSB7CiAJCW52X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIGkpOwogCQkvKiBD
UCBhbmQgc2hhZGVycyAqLwotCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tU0hfTUVNX0NPTkZJRywg
REVGQVVMVF9TSF9NRU1fQ09ORklHKTsKKwkJdG1wID0gUkVHX1NFVF9GSUVMRChERUZBVUxUX1NI
X01FTV9DT05GSUcsIFNIX01FTV9DT05GSUcsCisJCQkJUkVUUllfTU9ERSwgYW1kZ3B1X25vcmV0
cnkgPyAyIDogMCk7CisJCVdSRUczMl9TT0MxNShHQywgMCwgbW1TSF9NRU1fQ09ORklHLCB0bXAp
OwogCQlpZiAoaSAhPSAwKSB7CiAJCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKDAsIFNIX01FTV9CQVNF
UywgUFJJVkFURV9CQVNFLAogCQkJCShhZGV2LT5nbWMucHJpdmF0ZV9hcGVydHVyZV9zdGFydCA+
PiA0OCkpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlf
NC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCmluZGV4IDc1M2Vl
YTIuLjg1OTliZmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHVi
X3Y5XzQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKQEAg
LTMxNCw3ICszMTQsOCBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92OV80X3NldHVwX3ZtaWRfY29uZmln
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaHViaWQpCiAJCQkJICAgIGFkZXYtPnZt
X21hbmFnZXIuYmxvY2tfc2l6ZSAtIDkpOwogCQkvKiBTZW5kIG5vLXJldHJ5IFhOQUNLIG9uIGZh
dWx0IHRvIHN1cHByZXNzIFZNIGZhdWx0IHN0b3JtLiAqLwogCQl0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLAotCQkJCSAgICBSRVRSWV9QRVJNSVNTSU9O
X09SX0lOVkFMSURfUEFHRV9GQVVMVCwgMCk7CisJCQkJICAgIFJFVFJZX1BFUk1JU1NJT05fT1Jf
SU5WQUxJRF9QQUdFX0ZBVUxULAorCQkJCSAgICAhYW1kZ3B1X25vcmV0cnkpOwogCQlXUkVHMzJf
U09DMTVfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNTDJWQzBfVk1fQ09OVEVYVDFfQ05UTCwKIAkJCQkg
ICAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZTRVQgKyBpLAogCQkJCSAgICB0
bXApOwpAQCAtOTA1LDQgKzkwNiw0IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfcXVlcnlfcmFz
X2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogY29uc3Qgc3RydWN0IGFt
ZGdwdV9tbWh1Yl9mdW5jcyBtbWh1Yl92OV80X2Z1bmNzID0gewogCS5yYXNfbGF0ZV9pbml0ID0g
YW1kZ3B1X21taHViX3Jhc19sYXRlX2luaXQsCiAJLnF1ZXJ5X3Jhc19lcnJvcl9jb3VudCA9IG1t
aHViX3Y5XzRfcXVlcnlfcmFzX2Vycm9yX2NvdW50LAotfTsKXCBObyBuZXdsaW5lIGF0IGVuZCBv
ZiBmaWxlCit9OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
