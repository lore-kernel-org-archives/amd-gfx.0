Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AABC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6B921850
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6B921850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA926E05D;
	Wed, 20 Nov 2019 06:48:11 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820087.outbound.protection.outlook.com [40.107.82.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C036E05D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 06:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc0T/2+iZ0HQWzXPjs+vA4KjFBOwXbc7J3H1pmcH2VIzPSpetkB+Qaakq5yjhnxKo5dUa9imPB9RcTPgUZKzrvJ3q/Zz869b+EOmBTSf4uhWO96b+VMS1HYcd9YYZzu+EdGwTHuqqUsCDMZ8dfSFmWC4izGmwcASCiFttad+sNbPr9HA/wO/6CMktBwDa0P9bG4f5x2PmyirdNCIe9BhcdKNHM1Eya990nSM28XWGxtdKaIQFqEQoKFl2Sii8B7ZW45Er28S1CkcYd3PbQZH7OM/UKaHWlQQfyqcCW4hGmTsUfsRcUEtG5Y1TKz521PRFGTdhNLI4hd1ql6A1EsKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFkCgK7AW9KBztQu6xbpwm4D6lbBPLB4LJEaeBKPrQ8=;
 b=PQ2hJ5lGHiIzfMINIsYK4nfpFeA9GXBRJ9tk3ViD+OvmP8jPLPADFfDrpaVxTI+1s3/bdoTD7Binc2uyAJhtQM+j2oX5Gv7EPGBKBbdAkkDGWnYbLPy4wTZ4tA990Y+Ilfu7Bbotab7EVcWcqLtgqZETg6AeMASA7rYvOvuOEUrT9dq39Bfsxx02RKRccPT9ZAAOu7/a15X15KoW3bBclOh52TopkDdgmBq52N2n3BzBAMqI+hXJVEdYJqebX1qzANsCgDHNWl6K6IHD4o8mwY/B/8wf9Ata0jTzdNlF95rUR2VciCjGbkyTZSMPWtjmAB1kMC/REbhIZ6QAee24Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3518.namprd12.prod.outlook.com (20.179.82.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Wed, 20 Nov 2019 06:48:07 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 06:48:07 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: fix out-of-bound mqd_backup array access
Date: Wed, 20 Nov 2019 14:47:53 +0800
Message-Id: <20191120064753.3020-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK0PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::17) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7d41858-a1ab-4cd6-fd48-08d76d859976
X-MS-TrafficTypeDiagnostic: MN2PR12MB3518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB35181E7CA81015B71528377D894F0@MN2PR12MB3518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(8936002)(50466002)(4326008)(26005)(386003)(2351001)(47776003)(186003)(2616005)(3846002)(6116002)(6486002)(52116002)(6506007)(66066001)(25786009)(316002)(6512007)(6666004)(86362001)(2361001)(36756003)(2870700001)(2906002)(6916009)(14454004)(478600001)(8676002)(7736002)(305945005)(6436002)(66476007)(81166006)(51416003)(14444005)(81156014)(66556008)(66946007)(48376002)(1076003)(99286004)(5660300002)(4744005)(44832011)(476003)(486006)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3518;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hq9HYVq40HP8Wbf1AEP8efb00ZSiBFoGwOJNwUryQyEpOJflg9Z/s7Hjou15YmufetvyVRap65hf9RXI0qX8mKNHEeWtUzSB9qLC4dg7LuYH4/IKGsm/mFStn4vBoUuRB4ZrgZlqVAONlyGB+jic2migQEwPtIV674y/1YSUu3OM4njssTSAsjbSoh6U7GoVVRogaMOnalXxERzsswkahBzMi6gaiDSnib7P2AtiYCkYuJsWHF/Jbb1KOtkua9FCU4vA0FVAak2LfV5SwN7vkqCMVcdEb2M9OIlRet2ketznk7y0sAmqeHAb3+lRZC0XOZd325y8u41x8D+YUAQ7gqgsWAm0iOfoMTCOSV0HtwcH3zgXv/Rh9cXNpjc4jFUs7cGGZq00phQvnjgsGwuH1Pw5/UDF7Spnzf2PZ8RVywS2RXCoFblR9emTLHO0vNm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d41858-a1ab-4cd6-fd48-08d76d859976
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:48:07.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zluCPWu8Y6ZOs89x+hWJg5gkNdVifSRduS/PD3ehrH5ur1IqBGm+DyFpo/yePEEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFkCgK7AW9KBztQu6xbpwm4D6lbBPLB4LJEaeBKPrQ8=;
 b=ujruhAvnedhSJy76Pu0ztQQbEOVSMmRD/y1giX+aEE2sbJykvrwhWI/yJ4cCX6NmHoRUPRT12F+4VD2M8rYPq7ERar5XYURVhKmrKYpMrJg67Gxx8korsifPVC6leRSw8PeARutC2kWZUZlTRzB/qFvy/ZPtzAkmuDGHgVqiKms=
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120064753.fQhUejxSFJm4IrWRn-44643uJZY7SRw8qNu8j6lRKNQ@z>

Rml4ZXM6IDQ5OTBmOTU3Yzg0NSAoImRybS9hbWRncHUvZ2Z4MTA6IGZpeCBtcWQgYmFja3VwL3Jl
c3RvcmUgZm9yIGdmeCByaW5ncyIpClNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2pp
ZS55dWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dm
eC5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCmluZGV4IGE0OTIxNzRlZjI5Yi4uNTJjMjdlNDliYzdi
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jCkBAIC00NTQsOCArNDU0
LDYgQEAgdm9pZCBhbWRncHVfZ2Z4X21xZF9zd19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCX0KIAogCXJpbmcgPSAmYWRldi0+Z2Z4LmtpcS5yaW5nOwotCWlmIChhZGV2LT5hc2lj
X3R5cGUgPj0gQ0hJUF9OQVZJMTAgJiYgYW1kZ3B1X2FzeW5jX2dmeF9yaW5nKQotCQlrZnJlZShh
ZGV2LT5nZngubWUubXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9SSU5HU10pOwogCWtmcmVlKGFk
ZXYtPmdmeC5tZWMubXFkX2JhY2t1cFtBTURHUFVfTUFYX0NPTVBVVEVfUklOR1NdKTsKIAlhbWRn
cHVfYm9fZnJlZV9rZXJuZWwoJnJpbmctPm1xZF9vYmosCiAJCQkgICAgICAmcmluZy0+bXFkX2dw
dV9hZGRyLAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
