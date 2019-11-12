Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE89C17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23D32067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23D32067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003BD6EBB4;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690050.outbound.protection.outlook.com [40.107.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DFC6EBAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj2HTxFSlR0HMJtJb5bSEEws4Pcmp8RpiRQ0Fd5BSAxRGusKR8B5EgETUjZN/pH7rKGurAwu9Qtyi+vJd05naprAaZwxDWCBxFK0jEBow4sigqv2Y4M/k814RGQxwb7zAZMf8tNHu40mfXvpvfqSbNVYoaoS+AacoWONuuTmRciEU7EmxfWTg/5qkkNB4ozKj2FZHRgcBFJ6fSmVLiwdZXJhwe5sZc2E3W9Alv4XrYnWevkoX2c5r7LmQPISVYDsOrZHgd0Dd6K8hSslh9QM5kGiCrCcWXT31ndfvKkHTGP+fiMCpaXGGZufRzTxXEE8Br1jYx9q2+Ny9nGHFLmutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzXzApQTTWYJ4zrK0GFj32W8yEdcNVR8ed1wdYJm/Mg=;
 b=AfUqh/3Jl8ibE2hq1XvDGI2FhSTHiRiNleE3L2GCYyKAdhzWlKAJQsQMWXxH4sDFNaWINUuOmwmUiVe0f3fM+nQsDa38OoMzxQmC9LTjHTt92gQIq0XgJOSWygJ4BzKDvDoZq6s0eyO5hPFdZxZ3fum2zc0cVGHXPM2SBe0+1y5mNZYucrwRACs9fFNnxKCpEP1Eh8sKa2AFiGdpxmVgZKCXhq4EtrzPv0iOQqbmBXeKhx1uMSe+jP/y6SSoqacyIjOC5dyX3eWXaQiNv8JZd+H8GmHxzadYooclr3ZvBWNvUzMSqlJnyNbmdCyhRNCoUMdHCMPNiTrvRhmaGOE1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:17 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:17 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/21] drm/amdgpu: enable JPEG2.0 dpm
Date: Tue, 12 Nov 2019 13:03:24 -0500
Message-Id: <20191112180329.3927-17-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6ed2f68-08f5-42de-f663-08d7679abbb0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15807017919066366605ECCDE5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(14444005)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du5K9qasfdfa53oRJumaSvvDwVaoA2mOWsBmpjKphKAVDxKdLTNE9mZXpdPSXgVsM2+pSrslH2KdwRRKZuSaEyUiqDLKJwjQ0Tf14Is3OspiSHp7qZKd+XTnsSeOBdtFswjO3n2Y9zdfg72JNNFA+zQUS+pddbIGuWiR62bgnsbvy2v2YUFR1uf/YVXBJ3i4UN9NyADnqe0gj/dLD9ZUiKrwGn6vxwQPXlpNjYLV00f2Rc8mw3s+HiDF/xn31t1AGcR0YDHT2hhSA6Gzmo+lCbDNHIIqO7hclpWL/O4oANSPYse7/HJrUy12nqAdJyOc3FaAWTcm0jqo+7RrhZTKxeFrwwv22prfBMBTxSKR1Seuf7OisJb6UblDB9RjU79+HkeXEtNzRlJgIYmA+RIOERRN2McyQN07EZd/CZ0g5SnPmuxE5lhv/DJXIDTsVkf+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed2f68-08f5-42de-f663-08d7679abbb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:17.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBCRiXtFhn+UjLEXZPzsfenhAd0+1psDNfzOse/NpQpNk1J4UC3waq31Iv3VSlUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzXzApQTTWYJ4zrK0GFj32W8yEdcNVR8ed1wdYJm/Mg=;
 b=Pb7O+fMue2fAk7iwdsdeVFTIJOWxuR24N8MxMQLABUKf13JkNDZU1N8f1mKpUqmNjHVGb6ebbiRWJVjCanXxwyWR8nF0dSpBALaPrOWVJuQkObcauvWVvgjsFQ8HjyFIjzkr4FdFiUepZnXaIjNhRc3L3T/vsY8Bmds2MVkmy2A=
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
Message-ID: <20191112180324.1vkZQZnSwfLAzkCBQCsKVVheWw-84rdMklsYyFNkanM@z>

QnkgdXNpbmcgaXRzIG93biBlbmFibGluZyBmdW5jdGlvbgoKU2lnbmVkLW9mZi1ieTogTGVvIExp
dSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wbS5jIHwgIDggKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
bS5oIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmMgfCAxMCAr
KysrKysrKystCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCmluZGV4IGYyMDVmNTZlMzM1
OC4uYjcxNTAxNzFlOGQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwpA
QCAtMjcxOCw2ICsyNzE4LDE0IEBAIHZvaWQgYW1kZ3B1X3BtX3ByaW50X3Bvd2VyX3N0YXRlcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogfQogCit2b2lkIGFtZGdwdV9kcG1fZW5hYmxl
X2pwZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5hYmxlKQoreworCWludCBy
ZXQgPSBzbXVfZHBtX3NldF9wb3dlcl9nYXRlKCZhZGV2LT5zbXUsIEFNRF9JUF9CTE9DS19UWVBF
X0pQRUcsIGVuYWJsZSk7CisJaWYgKHJldCkKKwkJRFJNX0VSUk9SKCJbU1cgU01VXTogZHBtIGVu
YWJsZSBqcGVnIGZhaWxlZCwgc3RhdGUgPSAlcywgcmV0ID0gJWQuIFxuIiwKKwkJCSAgZW5hYmxl
ID8gInRydWUiIDogImZhbHNlIiwgcmV0KTsKK30KKwogaW50IGFtZGdwdV9wbV92aXJ0X3N5c2Zz
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJaW50IHJldCA9IDA7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5oCmluZGV4IGVmMzE0NDhlZThkOC4uM2RhMWRh
Mjc3ODA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0u
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uaApAQCAtNDEsNSAr
NDEsNiBAQCB2b2lkIGFtZGdwdV9wbV9jb21wdXRlX2Nsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7CiB2b2lkIGFtZGdwdV9kcG1fdGhlcm1hbF93b3JrX2hhbmRsZXIoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKTsKIHZvaWQgYW1kZ3B1X2RwbV9lbmFibGVfdXZkKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7CiB2b2lkIGFtZGdwdV9kcG1fZW5hYmxlX3Zj
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpOwordm9pZCBhbWRncHVf
ZHBtX2VuYWJsZV9qcGVnKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSk7
CiAKICNlbmRpZgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192
Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYwppbmRleCAzODY5
NzMwYjIzMzEuLmE3ODI5MmQ4NDg1NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvanBlZ192Ml8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192
Ml8wLmMKQEAgLTMzMyw2ICszMzMsOSBAQCBzdGF0aWMgaW50IGpwZWdfdjJfMF9zdGFydChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSAmYWRl
di0+anBlZy5pbnN0LT5yaW5nX2RlYzsKIAlpbnQgcjsKIAorCWlmIChhZGV2LT5wbS5kcG1fZW5h
YmxlZCkKKwkJYW1kZ3B1X2RwbV9lbmFibGVfanBlZyhhZGV2LCB0cnVlKTsKKwogCS8qIGRpc2Fi
bGUgcG93ZXIgZ2F0aW5nICovCiAJciA9IGpwZWdfdjJfMF9kaXNhYmxlX3Bvd2VyX2dhdGluZyhh
ZGV2KTsKIAlpZiAocikKQEAgLTM4OCw4ICszOTEsMTMgQEAgc3RhdGljIGludCBqcGVnX3YyXzBf
c3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogCS8qIGVuYWJsZSBwb3dlciBnYXRp
bmcgKi8KIAlyID0ganBlZ192Ml8wX2VuYWJsZV9wb3dlcl9nYXRpbmcoYWRldik7CisJaWYgKHIp
CisJCXJldHVybiByOwogCi0JcmV0dXJuIHI7CisJaWYgKGFkZXYtPnBtLmRwbV9lbmFibGVkKQor
CQlhbWRncHVfZHBtX2VuYWJsZV9qcGVnKGFkZXYsIGZhbHNlKTsKKworCXJldHVybiAwOwogfQog
CiAvKioKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
