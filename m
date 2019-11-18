Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8D3C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7C320726
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C320726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D9889C14;
	Mon, 18 Nov 2019 05:19:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E65889C14
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 05:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBb7Qe4qvoN2WmuW1PVnpckkimFIq96Qibo8DJpFOUPtSnWBnnFFYr7/vibGBUhG2fR6LTn5NDIVA5bDGvMsSQ0amrx+lFBq8pVKXuj8EfGIX+jgO67w4wAEiKRcAI6GS/nZHeCSwDJcYur5qpTLuXsgWcJ8oMSzZIx+JjWwogAQ51BoyrQb7drDlFe/iNc+tb40XXNQddBRvDPgF7sxFL68aJPs08cdceqAP7Xcy9ZfTujZtlX9Fq/S9xVJciNnzep4MU6nbaIPLoEMpF/5BaSSFxZ/TlcPLMVJ3NqRIhNPqqM9+XMJHeulO/CGeAgaHwKW7zyQPB2zHiqGf9Tn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6duRcrWPiWA+9wihzCWib4+fjrKAtrpPLj8Sz7e408I=;
 b=Md/hs8t0GYtW0INXyebZzvoTK83tzvRxvHNnEUc+TtHGYMZn3S1IBkWwvnDwnm6G9/dk63GdJUpphPAtZDprrgvAHFvINs1B5vg2sGrHtRe+0NddPyF9td9+UR414S4gKIb6fkzip9qiiSkVEKNhI97S/Xx3wJCX369oGjiSEDg/qFk5UCLo3Y5IhLj6bhlqCq7ShHLnedYdvwWX7VAwaNnV8rJhrIDPVD1L/X2sfm9OBTnIV80VY+5ajUF1cSjshBcMFUa4G1ky121xGKiLKx/IOOmsaNWhCIpwR53903IyBcylk2UzfIVARhjrW/V/gE2/K0mu+hpzykQvaDiNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 18 Nov 2019 05:19:00 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 05:19:00 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: enable TMZ bit in FRAME_CONTROL for gfx10
Date: Mon, 18 Nov 2019 13:18:36 +0800
Message-Id: <1574054316-2802-5-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f2e7fd8-2564-4703-de8b-08d76be6d1b7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3712660BA9310032C9496C9BF04D0@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(4744005)(86362001)(486006)(44832011)(2616005)(476003)(2351001)(66476007)(11346002)(25786009)(5660300002)(446003)(386003)(6436002)(66946007)(36756003)(26005)(6512007)(50226002)(8936002)(186003)(81156014)(8676002)(81166006)(66556008)(6486002)(66066001)(478600001)(305945005)(14444005)(6506007)(2361001)(316002)(47776003)(16586007)(6116002)(50466002)(3846002)(52116002)(4326008)(51416003)(2906002)(99286004)(76176011)(6916009)(7736002)(14454004)(48376002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yprL7fSu7gc6DY2R8W+LFyeLDot7YqAUiWxVN/dsZlG2jhTd/xNjtQffNB6VT877GKq+63SZZvQ7FG4009OpHU8ZJ1lUJ1crF/Cpg1S0lgb/8yLYJ2IsI18mvmOG0NfsE3Y/3yqEhdXvByBRfps8d4ha7V+4iXm+WHlcc0T1vJhBJhh5TKVtMu7auvJsFRiyIAfMnVwsGvYS0kkQn63Resof7qcNqN7Y3LQosTgBB8hk4DgS1Y31ecXi+Es+EJEzs4UmmN9lF+qUuGjYwqneEDIxvtxa0AZ4YojUbDJdGXDMb6BvSIBVeVimzF4RkABvO/8cWIuQMDtDeF8kXgH3yO6gcdItGdrBaaHYErZydRtGPqpE/Ke0BhfpNXJdk3OdrS/J1wrzgt6TRVX9sDQDXSoGYa8loCSs2Eno8zXW1bG6qqzA3ESe9G4oq28E19M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2e7fd8-2564-4703-de8b-08d76be6d1b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 05:19:00.5410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R20Xoi4YqLUA1l2M+D3AVFwk0Mzz6w8a7K9+Qj0GjAWd/P3zn/N8R36zcjbDIQUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6duRcrWPiWA+9wihzCWib4+fjrKAtrpPLj8Sz7e408I=;
 b=ZMYgtATFp+FyDhCkjAa9b4V1wZxdIJ3ZoHAo7J1CduORhFTUXWzRfsjXAJnbqClc7nY8V4xagGpeuLTEAisRRkluNd+mF3TW4tJk222gvXa3KuKz5NGc4Q7S+QBzb26TWkL+RbtCzH/GWkwctGqfHDiW4PieGeErsEO0ZdhCFPY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Alexander.Deucher@amd.com, Luben.Tuikov@amd.com, Ray.Huang@amd.com,
 Christian.Koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118051836.2BnPjKoeYC2bvEwo7DGHhf8IpjjJXTdX1Jn5kVxAka4@z>

VGhpcyBwYXRjaCBlbmFibGVzIFRNWiBiaXQgaW4gRlJBTUVfQ09OVFJPTCBmb3IgZ2Z4MTAuCgpT
aWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwppbmRleCBkNmUxMWVlLi44ZGNlMDY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYwpAQCAtNDU4OCw3ICs0NTg4LDcgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8w
X3JpbmdfZW1pdF9jbnR4Y250bChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCiAJCWdmeF92MTBf
MF9yaW5nX2VtaXRfY2VfbWV0YShyaW5nLAogCQkJCSAgICBmbGFncyAmIEFNREdQVV9JQl9QUkVF
TVBURUQgPyB0cnVlIDogZmFsc2UpOwogCi0JZ2Z4X3YxMF8wX3JpbmdfZW1pdF90bXoocmluZywg
dHJ1ZSwgZmFsc2UpOworCWdmeF92MTBfMF9yaW5nX2VtaXRfdG16KHJpbmcsIHRydWUsIHRydXN0
ZWQpOwogCiAJZHcyIHw9IDB4ODAwMDAwMDA7IC8qIHNldCBsb2FkX2VuYWJsZSBvdGhlcndpc2Ug
dGhpcyBwYWNrYWdlIGlzIGp1c3QgTk9QcyAqLwogCWlmIChmbGFncyAmIEFNREdQVV9IQVZFX0NU
WF9TV0lUQ0gpIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
