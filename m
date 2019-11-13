Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39EC43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1941F222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1941F222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E806ED3B;
	Wed, 13 Nov 2019 14:13:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB416ED3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 14:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL17ovmwxWg1HRXM9c/AAKwBNbJaPmBRzUUomxB2MowGu2QSS6UB3G35H1kruS59VGfqYj9Wjq3tfl7AmQPL7QJ8MBjHsMxgv/IGpkQWC/3bvPs0E+gq8A08nGR4PKnQXaAxM7h5b9tL/0reFf+ct73xuSyRFWrOeSR9ZklwHEnGDPymGAQKEci9Lv5/TSYLSB2i2BhMlburrIicBR/I/B0F3kZvn7R4GkfP2UXS7vwH60itrdwFmFX0ROwLAVnAqp74KNX09gSNXTjKmk5k929a84t5d9Zput0SZeRqhkAM0B6JRLOTqXxXr9RvDTSp6B6MstC8zrMNE+xqIKJFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeJ6G8P8g9KdB8Sr24VAlUGSR1+Ted6C0ZVVAjDCVvE=;
 b=VZjwbwU0ETvwk0HCpd9GNCnnlekC0Iy00YhQ067THEb3TDtOgiWPQfqOFTwpAoY9lKL9w/mQRtED46yhkNKSX25nfXIhHgkuWSVEA5twJi3MlQ7vVW9iyeUCp3L2Kg8oxg5Z8m4cST1F6iInDVHTU4E7PK6vzycrVkoqMrVppRoZPkvbOqEy7W9/5KWONANXICTlcFnh7z4DP2HKHgBaguQgFETEx77mkHjfGE174dDMRUe9yZAITXZwu41IWGJ0Y+q0DHe7XONnHV98UJpG8cdGvoB9bpvIxiQdDY44T7jHWdxK/oWhHduKD3w1Zbtczfpib3rkkCdth4TRG9kKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1721.namprd12.prod.outlook.com (10.175.88.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 14:13:17 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:13:17 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/21] drm/amd/powerplay: add JPEG power control for Renoir
Date: Wed, 13 Nov 2019 09:13:03 -0500
Message-Id: <20191113141303.15495-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-15-leo.liu@amd.com>
References: <20191112180329.3927-15-leo.liu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51c7bacf-cd2e-442f-ad65-08d76843a14d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721253364AF26B8371420ADE5760@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(50466002)(48376002)(86362001)(305945005)(6116002)(7736002)(50226002)(3846002)(486006)(81156014)(81166006)(1076003)(6916009)(66476007)(8676002)(476003)(51416003)(66946007)(2361001)(52116002)(386003)(66556008)(6506007)(44832011)(5660300002)(2616005)(76176011)(2906002)(26005)(99286004)(6436002)(8936002)(66066001)(4326008)(446003)(478600001)(14454004)(36756003)(14444005)(6486002)(47776003)(6666004)(16586007)(316002)(6512007)(25786009)(2351001)(11346002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1721;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ey/iUVS6OKJzBjtBrLkYjV5bhXLomrX9iMW/UlRW4glAq4zw0pYrRdqLX/qVazif1b6Uqg4IQ45e0Fap3c2Bzl8fdwZMGw8dw0YODUgErSe18sjSd0WIjVkmf82/n5Zb2hK4MvIqAgnn/MzeMV+BfExC+lK/uWEUmdmY0RL+G2NF57VulXfKqQd4mQMjQ8U8c7VYf9f328h3F97jEdqQ0JKHxFcHNdmReoeR3Hl1m5elrRIb12A0CBtR8XXHLsW1jFK9gbcxACuVeoejvSwn6ReCn9x/V1JeVCzYXGjeSSc8WA3V5kGlF3Ier5aBckBeFg+7raSFNF/JoXxpMTQDlwf3M8zt5SbTjuJ0T0cxZyqffHaKXsKRgxlIDBoTwdknfC1N5UYOOCbEd0XzSkvs2qj4PZ8yuMoraWTG25ID9Rs8iCLLULR+ubClcugd0SeY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c7bacf-cd2e-442f-ad65-08d76843a14d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:13:17.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS76FgUWpFQQeTr/KUSpx8wtRl/RbVJOh5pp4FZmBrO8Ph0+i5fR4XMoBKF8Nm6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeJ6G8P8g9KdB8Sr24VAlUGSR1+Ted6C0ZVVAjDCVvE=;
 b=eCZNOgpgwnj9hFn+5ANeaMIdjWGqFoIBIHP8CCtfbVbp8hPm5Z/L+2CJT1P4pWPp+WGZTsrOvURe2DoPdllPLqJSdz10snWr9MvJXNNuopFpiBEYtkfRatTWCZv56w8YMztQk3NhwascT0VARo8I4cO8oRTXRE2watMaGiW7Q7s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113141303.o7Mi5kOMYYG19GRKHOyzliyFbp_qQn7Xrk9S6qclGUA@z>

QnkgdXNpbmcgaXRzIG93biBKUEVHIFBvd2VyVXAgYW5kIFBvd2VyRG93biBtZXNzYWdlcwoKdjI6
IGFkZCBhcmd1bWVudCB0byBQb3dlckRvd25KcGVnIG1lc3NhZ2UKClNpZ25lZC1vZmYtYnk6IExl
byBMaXUgPGxlby5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9yZW5vaXJfcHB0LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3Jlbm9pcl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9p
cl9wcHQuYwppbmRleCA0OTJhMjAxNTU0ZTguLjc4NDkwM2EzMTNiNyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYwpAQCAtMzAxLDYgKzMwMSwzMSBAQCBzdGF0
aWMgaW50IHJlbm9pcl9kcG1fc2V0X3V2ZF9lbmFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUs
IGJvb2wgZW5hYmxlKQogCXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBpbnQgcmVub2lyX2RwbV9z
ZXRfanBlZ19lbmFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlKQorewor
CXN0cnVjdCBzbXVfcG93ZXJfY29udGV4dCAqc211X3Bvd2VyID0gJnNtdS0+c211X3Bvd2VyOwor
CXN0cnVjdCBzbXVfcG93ZXJfZ2F0ZSAqcG93ZXJfZ2F0ZSA9ICZzbXVfcG93ZXItPnBvd2VyX2dh
dGU7CisJaW50IHJldCA9IDA7CisKKwlpZiAoZW5hYmxlKSB7CisJCWlmIChzbXVfZmVhdHVyZV9p
c19lbmFibGVkKHNtdSwgU01VX0ZFQVRVUkVfSlBFR19QR19CSVQpKSB7CisJCQlyZXQgPSBzbXVf
c2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0oc211LCBTTVVfTVNHX1Bvd2VyVXBKcGVnLCAwKTsKKwkJ
CWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKKwkJfQorCQlwb3dlcl9nYXRlLT5qcGVnX2dhdGVk
ID0gZmFsc2U7CisJfSBlbHNlIHsKKwkJaWYgKHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211LCBT
TVVfRkVBVFVSRV9KUEVHX1BHX0JJVCkpIHsKKwkJCXJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0
aF9wYXJhbShzbXUsIFNNVV9NU0dfUG93ZXJEb3duSnBlZywgMCk7CisJCQlpZiAocmV0KQorCQkJ
CXJldHVybiByZXQ7CisJCX0KKwkJcG93ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IHRydWU7CisJfQor
CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCByZW5vaXJfZm9yY2VfZHBtX2xpbWl0X3Zh
bHVlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGhpZ2hlc3QpCiB7CiAJaW50IHJldCA9
IDAsIGkgPSAwOwpAQCAtNjgzLDYgKzcwOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJs
ZV9mdW5jcyByZW5vaXJfcHB0X2Z1bmNzID0gewogCS5wcmludF9jbGtfbGV2ZWxzID0gcmVub2ly
X3ByaW50X2Nsa19sZXZlbHMsCiAJLmdldF9jdXJyZW50X3Bvd2VyX3N0YXRlID0gcmVub2lyX2dl
dF9jdXJyZW50X3Bvd2VyX3N0YXRlLAogCS5kcG1fc2V0X3V2ZF9lbmFibGUgPSByZW5vaXJfZHBt
X3NldF91dmRfZW5hYmxlLAorCS5kcG1fc2V0X2pwZWdfZW5hYmxlID0gcmVub2lyX2RwbV9zZXRf
anBlZ19lbmFibGUsCiAJLmZvcmNlX2RwbV9saW1pdF92YWx1ZSA9IHJlbm9pcl9mb3JjZV9kcG1f
bGltaXRfdmFsdWUsCiAJLnVuZm9yY2VfZHBtX2xldmVscyA9IHJlbm9pcl91bmZvcmNlX2RwbV9s
ZXZlbHMsCiAJLmdldF93b3JrbG9hZF90eXBlID0gcmVub2lyX2dldF93b3JrbG9hZF90eXBlLAot
LSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
