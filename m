Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0980C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70230222CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 14:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70230222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2D16ED2A;
	Wed, 13 Nov 2019 14:12:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2AB6ED23
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 14:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ/6VDwwJG+pzrGuh6gWU4cHurrgXoRjD4iSYg5eaJtLHQXNvibJ/RGMO9cxuZmtfQ/O9/thpAmaEEQQnzcm1U19LrCwJ3zl4yjyee4LcHK70MP3Uihx161W0H3DNfUXD0OpPGNnjYjzqIZGsrPZZNIWEDE6go+UoXZ8ZPgJz79QkEtn682aeUPGtaioSPDYwpcr4Pu5psLE+nbNv89BVLP4q2CZGFg1/6n8usriomMT8mch+KaJ4yWms6bAK4b+0Ir+/esdrczjZvsmJf3XFKhjDz9VWaXi7zue7euLVPwcVRBFmmtnXgolJJfVrBWwGUTEgX17rZ3WriMtPSG6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO9q2KzTtPYVupvvCWf/7Q31NhvIefT2UqeAEqWXbgA=;
 b=dYWTVYH8WZCrVpFWzQBuNl7cVJtBDGS76q77tTksGX3MQuqMGZNi2x5yjn3VMLmiPlUvJ573ECrqYirEdgIK+sz0SmCMKBdrKeRz4M8lIa1bW5RHz8LRlehz9PYmNlBA2Da5wHfo2cNhZ4D41GKuFqoYrglYc7U0apHGIY0KMldzhUq0FQ+aqAB/JvMaMh1nynYtuEp6uugmgMzbPKTArMEIMtkG8eirKs46P3dEmIB3sFoHMTuVHa2BKj0RrmmLJS2orpBfVsbcz/+VXF55BtMm6MK9BqsL3plq00OJKsU7Szvy7TO9B0cmPRya3lug8pKwzIap8UJGGsJ4XJgBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1851.namprd12.prod.outlook.com (10.175.86.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 14:12:06 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:12:06 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/21] drm/amd/powerplay: add JPEG power control for Navi1x
Date: Wed, 13 Nov 2019 09:11:52 -0500
Message-Id: <20191113141152.15393-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-13-leo.liu@amd.com>
References: <20191112180329.3927-13-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3919b9b2-f6f9-4f93-7875-08d7684376ae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18519E655BEB2DBFB3FD1A6DE5760@DM5PR12MB1851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(446003)(8936002)(11346002)(2351001)(6506007)(6916009)(50226002)(48376002)(99286004)(2906002)(486006)(51416003)(386003)(81166006)(8676002)(476003)(6666004)(6512007)(36756003)(81156014)(2616005)(6436002)(26005)(14454004)(2361001)(186003)(76176011)(5660300002)(66476007)(6486002)(66946007)(66556008)(478600001)(4326008)(1076003)(86362001)(3846002)(305945005)(6116002)(52116002)(66066001)(50466002)(7736002)(44832011)(47776003)(16586007)(316002)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1851;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTm1D1fOV3f+dIUcQeteVtKH2+4n0wz/dt9LQm9z7PNymYq8hc1M6zLYDZxjpgb6MWrX9UkyuNiBDmYUR+WmwRLnAWiqOdt7blEwXPzMnm8hP0NqdUdp8No7ajbaLtlR9PiU6ViShZYax9DboUGG+YAw3QZDa3UwjdkHsPkdi/EEpzcXfr6fxMNUEWuLkYySYELFq1Fu3VbP2hQ8nJIzcMsOuEHEtl29I3TXpf+V+V8c+GuBofN9TRml2Zjw7EhFCRRkCDOHgKf8j1g4hGlxnLLBjww+Unh/qhiBn6qQE+r+JPoe5iumgmsUertfPoYwgq/M2wWLXvOytSPUgROEyNaPTmDBbjZvUgF5F83uUddSMmXgvXNNivNxPW71MdKUrXFsaZcOMxb9kkxapxRUL8PPy3tIH6W4qmInfBfejFpE9dRgKSfBxeB3TsmD8owN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3919b9b2-f6f9-4f93-7875-08d7684376ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 14:12:06.1366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH1qF6rZTJW2iLXYzSaQP9YmIWDNr+mxpbQ0EwcY97yJ6OTwBzVCXUSpTW2qKU7C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1851
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO9q2KzTtPYVupvvCWf/7Q31NhvIefT2UqeAEqWXbgA=;
 b=qGV9mn65dza096P7ON3DaFWlj2iEaArAnXCuyJAuj15NkkVE9KlSF4DirCia0PLfvYvMo/W0W2QyjEU0wSTfp5rZOGb37nd11k90MdPgnr77V1WpzmqsNi1uzQOsHegtQO3ZEDAeZ9ZVF0qZy9FtWB+UM8zKfyVZpCVfB94frGA=
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
Message-ID: <20191113141152.R0NhZ7-hxRpAbJMSAzTc5I9kQVjinDc_iafTvUoVt8U@z>

Qnkgc2VwYXJhdGluZyB0aGUgSlBFRyBwb3dlciBmZWF0dXJlLCBhbmQgdXNpbmcgaXRzCm93biBQ
b3dlclVwIGFuZCBQb3dlckRvd24gbWVzc2FnZXMKCnYyOiByZW1vdmUgUG93ZXJVcEpwZWcgbWVz
c2FnZSBhcmd1bWVudAoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDMyICsrKysr
KysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25h
dmkxMF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwpp
bmRleCBhZWI5YzFlMzQxYzcuLmRjZTZmNzZlY2JlNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L25hdmkxMF9wcHQuYwpAQCAtMzg0LDggKzM4NCwxMCBAQCBuYXZpMTBfZ2V0X2Fs
bG93ZWRfZmVhdHVyZV9tYXNrKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkqKHVpbnQ2NF90
ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFUVVJFX0FUSFVCX1BHX0JJVCk7CiAK
IAlpZiAoc211LT5hZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTikKLQkJKih1aW50
NjRfdCAqKWZlYXR1cmVfbWFzayB8PSBGRUFUVVJFX01BU0soRkVBVFVSRV9WQ05fUEdfQklUKQot
CQkJCXwgRkVBVFVSRV9NQVNLKEZFQVRVUkVfSlBFR19QR19CSVQpOworCQkqKHVpbnQ2NF90ICop
ZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFUVVJFX1ZDTl9QR19CSVQpOworCisJaWYg
KHNtdS0+YWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9KUEVHKQorCQkqKHVpbnQ2NF90
ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFUVVJFX0pQRUdfUEdfQklUKTsKIAog
CS8qIGRpc2FibGUgRFBNIFVDTEsgYW5kIERTIFNPQ0NMSyBvbiBuYXZpMTAgQTAgc2VjdXJlIGJv
YXJkICovCiAJaWYgKGlzX2FzaWNfc2VjdXJlKHNtdSkpIHsKQEAgLTY2NSw2ICs2NjcsMzEgQEAg
c3RhdGljIGludCBuYXZpMTBfZHBtX3NldF91dmRfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAq
c211LCBib29sIGVuYWJsZSkKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgaW50IG5hdmkxMF9k
cG1fc2V0X2pwZWdfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVuYWJsZSkK
K3sKKwlzdHJ1Y3Qgc211X3Bvd2VyX2NvbnRleHQgKnNtdV9wb3dlciA9ICZzbXUtPnNtdV9wb3dl
cjsKKwlzdHJ1Y3Qgc211X3Bvd2VyX2dhdGUgKnBvd2VyX2dhdGUgPSAmc211X3Bvd2VyLT5wb3dl
cl9nYXRlOworCWludCByZXQgPSAwOworCisJaWYgKGVuYWJsZSkgeworCQlpZiAoc211X2ZlYXR1
cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0pQRUdfUEdfQklUKSkgeworCQkJcmV0ID0g
c211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUG93ZXJVcEpwZWcpOworCQkJaWYgKHJldCkK
KwkJCQlyZXR1cm4gcmV0OworCQl9CisJCXBvd2VyX2dhdGUtPmpwZWdfZ2F0ZWQgPSBmYWxzZTsK
Kwl9IGVsc2UgeworCQlpZiAoc211X2ZlYXR1cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJF
X0pQRUdfUEdfQklUKSkgeworCQkJcmV0ID0gc211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0df
UG93ZXJEb3duSnBlZyk7CisJCQlpZiAocmV0KQorCQkJCXJldHVybiByZXQ7CisJCX0KKwkJcG93
ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IHRydWU7CisJfQorCisJcmV0dXJuIHJldDsKK30KKwogc3Rh
dGljIGludCBuYXZpMTBfZ2V0X2N1cnJlbnRfY2xrX2ZyZXFfYnlfdGFibGUoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsCiAJCQkJICAgICAgIGVudW0gc211X2Nsa190eXBlIGNsa190eXBlLAogCQkJ
CSAgICAgICB1aW50MzJfdCAqdmFsdWUpCkBAIC0xOTk2LDYgKzIwMjMsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgbmF2aTEwX3BwdF9mdW5jcyA9IHsKIAkuZ2V0X2FsbG93
ZWRfZmVhdHVyZV9tYXNrID0gbmF2aTEwX2dldF9hbGxvd2VkX2ZlYXR1cmVfbWFzaywKIAkuc2V0
X2RlZmF1bHRfZHBtX3RhYmxlID0gbmF2aTEwX3NldF9kZWZhdWx0X2RwbV90YWJsZSwKIAkuZHBt
X3NldF91dmRfZW5hYmxlID0gbmF2aTEwX2RwbV9zZXRfdXZkX2VuYWJsZSwKKwkuZHBtX3NldF9q
cGVnX2VuYWJsZSA9IG5hdmkxMF9kcG1fc2V0X2pwZWdfZW5hYmxlLAogCS5nZXRfY3VycmVudF9j
bGtfZnJlcV9ieV90YWJsZSA9IG5hdmkxMF9nZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZSwK
IAkucHJpbnRfY2xrX2xldmVscyA9IG5hdmkxMF9wcmludF9jbGtfbGV2ZWxzLAogCS5mb3JjZV9j
bGtfbGV2ZWxzID0gbmF2aTEwX2ZvcmNlX2Nsa19sZXZlbHMsCi0tIAoyLjE3LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
