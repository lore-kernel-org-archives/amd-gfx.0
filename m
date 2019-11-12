Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFBDC17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EFC2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EFC2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554E66EBB6;
	Tue, 12 Nov 2019 18:04:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A12F6EBAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMCglvGlEJUWNwgSasKZAqu1kAE/zP4LNLI0SXHhSFmWB1uB1RX6ZJg4ZgytnO89x1GwfVhqAqOHcyggkKN6rpjdg8A9TaFdip3Cbs0f9OdE62AVxF5+hsfLuCRDJ4yAjA+yqxoCE5Z73rmZEBmJ2qLO/OEuXJI+P4msAI4w+sXZt9p+fbygKk8Fr7+n+eNFkHC67YRZKMekbPgXzvTn83MvnLYooQj7Drk+5dP8D/Oy2Ea9PsE/yihj3sNNGuQaDWTVpu62K+zvwduoP9xGM/9cz8m33h2wRDyYUY2GVUT1HPXjoALWAaae+hKBp76dBwQ8l6equ/6aLZlt0XSg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXpw0ZEhjznPkku4v6Ta6QyVxsGIaoddgoFMQ5AriRc=;
 b=M0hmSYg2aQe5h3mhQ7Fc5TulvkCzx6x8+25htALOmM83ZO4ndGDMh4gPZZtyZs8ZoZ6dq6ZEkaaTzPR2wZgxDMuP4YP6bibRHu7B8dJwviDjyM7L9sMcmQd9JwpG+ZZyssA89yfNX4SGswExcWJfW1HwMeFQtUVfjrywHykCW1jPEIHEAkI7xTFC4TlkIHydi5eWr29ovGNTeJxFzgQFrvjkR+VwYL7lGcS9hMvHyt1VCFWVgS0RXdIpt00hb1UraUnMYBdeGequMlHHpU55AQ6sxbrGN3Oo0RZpygSGA6UI9+cLBCdUB4AoghMqsnkEz2NQxWpSl9+wg2Le85mfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:15 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:15 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/21] drm/amd/powerplay: add Powergate JPEG for Renoir
Date: Tue, 12 Nov 2019 13:03:21 -0500
Message-Id: <20191112180329.3927-14-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: faddbdcd-5470-48d9-47f3-08d7679aba99
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1580D357F7C288D96E5C98FEE5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /u0FuZww83fmPe0ibkd9P9YWReyiUBWOzaLs7TAMUClsBsL4TSUNOl7lDK7iOoiQq6abQC1huFKT4UwCFkPjwEQZjvh0G/p0S218OpsGCT8W5VYJcBs3P9flt7ddyFCbdlkxBKxBjv8bxplDneJnOQRn1SGxXgN4rgwhRwq28ACnxXb7XCNyooggphdguzHyugCSY6OC59NXfyYl5EhEN9e5cHtucftbNasoRkIQSSFVSUrbku8NwfLKwrl6BQBG1DpInntGPQSy0HyHyo7sfHGLLV/yOISwpXDmeCyIh8RllU6ZzlgrHrwn/TqdKRcFBWLUH+fIaRHj7CyfVUkFRDbHBB/XX78z+Uj3UBbE7u6KpqV+DOdu699n4yrqSgrwmm607aatdzHAzad5nBZGh7qc5F2rRarvdU5Gggcdf7jz/JhbAY98TadHjc05iC1T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faddbdcd-5470-48d9-47f3-08d7679aba99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:15.1515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQqyfT5MBxkVsuJJzaetRekxFFYmfIAzBXCQqDz2sr3X+kREWlV3rpfAK6ER+tHG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXpw0ZEhjznPkku4v6Ta6QyVxsGIaoddgoFMQ5AriRc=;
 b=bqXvjQSyuvTqhl3lSYqAN05jojHugNpL48eZc6r0oxrCLReWAI5TVNeS65RKCh5R+MArndrLSIJnZ6FYuX/uMpMJi/357VqVfJEMZf56AiqlHMccrTQSouJmZUvaolq5rG2HffbTvcMWe9AKQ1F7z4zWKBWfb2sM28hpnyF80g0=
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
Message-ID: <20191112180321.BKLYdtDnz4xLv-ssX66qua43YESaqCs1ZqPJcktSndk@z>

U2ltaWxhciB0byBTRE1BLCBWQ04gZXRjLgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxp
dUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
YyAgICB8ICAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8w
LmggfCAgMiArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jICAg
IHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmggIHwg
IDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTJfMC5jICAgICB8IDEx
ICsrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggNjkyNDNhODU4ZGQ1Li4y
MTE5MzQ1MjFkMzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211
LmMKQEAgLTEyMjksNiArMTIyOSw3IEBAIHN0YXRpYyBpbnQgc211X2h3X2luaXQodm9pZCAqaGFu
ZGxlKQogCWlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpIHsKIAkJc211X3Bvd2VyZ2F0ZV9z
ZG1hKCZhZGV2LT5zbXUsIGZhbHNlKTsKIAkJc211X3Bvd2VyZ2F0ZV92Y24oJmFkZXYtPnNtdSwg
ZmFsc2UpOworCQlzbXVfcG93ZXJnYXRlX2pwZWcoJmFkZXYtPnNtdSwgZmFsc2UpOwogCQlzbXVf
c2V0X2dmeF9jZ3BnKCZhZGV2LT5zbXUsIHRydWUpOwogCX0KIApAQCAtMTI4Nyw2ICsxMjg4LDcg
QEAgc3RhdGljIGludCBzbXVfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJaWYgKGFkZXYtPmZsYWdz
ICYgQU1EX0lTX0FQVSkgewogCQlzbXVfcG93ZXJnYXRlX3NkbWEoJmFkZXYtPnNtdSwgdHJ1ZSk7
CiAJCXNtdV9wb3dlcmdhdGVfdmNuKCZhZGV2LT5zbXUsIHRydWUpOworCQlzbXVfcG93ZXJnYXRl
X2pwZWcoJmFkZXYtPnNtdSwgdHJ1ZSk7CiAJfQogCiAJcmV0ID0gc211X3N0b3BfdGhlcm1hbF9j
b250cm9sKHNtdSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9p
bmMvc211X3YxMl8wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3Yx
Ml8wLmgKaW5kZXggOWI5ZjVkZjA5MTFjLi4xNzQ1ZTAxNDZmYmEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjEyXzAuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmgKQEAgLTU4LDYgKzU4LDggQEAgaW50
IHNtdV92MTJfMF9wb3dlcmdhdGVfc2RtYShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBn
YXRlKTsKIAogaW50IHNtdV92MTJfMF9wb3dlcmdhdGVfdmNuKHN0cnVjdCBzbXVfY29udGV4dCAq
c211LCBib29sIGdhdGUpOwogCitpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV9qcGVnKHN0cnVjdCBz
bXVfY29udGV4dCAqc211LCBib29sIGdhdGUpOworCiBpbnQgc211X3YxMl8wX3NldF9nZnhfY2dw
ZyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpOwogCiB1aW50MzJfdCBzbXVf
djEyXzBfZ2V0X2dmeG9mZl9zdGF0dXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCmluZGV4IDA0ZGFmN2U5ZmUwNS4u
NDkyYTIwMTU1NGU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9y
ZW5vaXJfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3Bw
dC5jCkBAIC02OTcsNiArNjk3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwcHRhYmxlX2Z1bmNz
IHJlbm9pcl9wcHRfZnVuY3MgPSB7CiAJLmNoZWNrX2Z3X3ZlcnNpb24gPSBzbXVfdjEyXzBfY2hl
Y2tfZndfdmVyc2lvbiwKIAkucG93ZXJnYXRlX3NkbWEgPSBzbXVfdjEyXzBfcG93ZXJnYXRlX3Nk
bWEsCiAJLnBvd2VyZ2F0ZV92Y24gPSBzbXVfdjEyXzBfcG93ZXJnYXRlX3ZjbiwKKwkucG93ZXJn
YXRlX2pwZWcgPSBzbXVfdjEyXzBfcG93ZXJnYXRlX2pwZWcsCiAJLnNlbmRfc21jX21zZyA9IHNt
dV92MTJfMF9zZW5kX21zZywKIAkuc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0gPSBzbXVfdjEyXzBf
c2VuZF9tc2dfd2l0aF9wYXJhbSwKIAkucmVhZF9zbWNfYXJnID0gc211X3YxMl8wX3JlYWRfYXJn
LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFs
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfaW50ZXJuYWwuaAppbmRleCA4
YmNkYTc4NzEzMDkuLjcwYzRkNjY3MjFjZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvc211X2ludGVybmFsLmgKQEAgLTQyLDYgKzQyLDggQEAKIAkoKHNtdSktPnBwdF9mdW5j
cy0+cG93ZXJnYXRlX3NkbWEgPyAoc211KS0+cHB0X2Z1bmNzLT5wb3dlcmdhdGVfc2RtYSgoc211
KSwgKGdhdGUpKSA6IDApCiAjZGVmaW5lIHNtdV9wb3dlcmdhdGVfdmNuKHNtdSwgZ2F0ZSkgXAog
CSgoc211KS0+cHB0X2Z1bmNzLT5wb3dlcmdhdGVfdmNuID8gKHNtdSktPnBwdF9mdW5jcy0+cG93
ZXJnYXRlX3Zjbigoc211KSwgKGdhdGUpKSA6IDApCisjZGVmaW5lIHNtdV9wb3dlcmdhdGVfanBl
ZyhzbXUsIGdhdGUpIFwKKwkoKHNtdSktPnBwdF9mdW5jcy0+cG93ZXJnYXRlX2pwZWcgPyAoc211
KS0+cHB0X2Z1bmNzLT5wb3dlcmdhdGVfanBlZygoc211KSwgKGdhdGUpKSA6IDApCiAKICNkZWZp
bmUgc211X2dldF92Ymlvc19ib290dXBfdmFsdWVzKHNtdSkgXAogCSgoc211KS0+cHB0X2Z1bmNz
LT5nZXRfdmJpb3NfYm9vdHVwX3ZhbHVlcyA/IChzbXUpLT5wcHRfZnVuY3MtPmdldF92Ymlvc19i
b290dXBfdmFsdWVzKChzbXUpKSA6IDApCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjEyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Nt
dV92MTJfMC5jCmluZGV4IDEzOWRkNzM3ZWFhNS4uZjVkODcxMTBlYzM0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYwpAQCAtMjAzLDYgKzIwMywxNyBAQCBpbnQg
c211X3YxMl8wX3Bvd2VyZ2F0ZV92Y24oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZ2F0
ZSkKIAkJcmV0dXJuIHNtdV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX1Bvd2VyVXBWY24pOwog
fQogCitpbnQgc211X3YxMl8wX3Bvd2VyZ2F0ZV9qcGVnKHN0cnVjdCBzbXVfY29udGV4dCAqc211
LCBib29sIGdhdGUpCit7CisJaWYgKCEoc211LT5hZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKQor
CQlyZXR1cm4gMDsKKworCWlmIChnYXRlKQorCQlyZXR1cm4gc211X3NlbmRfc21jX21zZyhzbXUs
IFNNVV9NU0dfUG93ZXJEb3duSnBlZyk7CisJZWxzZQorCQlyZXR1cm4gc211X3NlbmRfc21jX21z
ZyhzbXUsIFNNVV9NU0dfUG93ZXJVcEpwZWcpOworfQorCiBpbnQgc211X3YxMl8wX3NldF9nZnhf
Y2dwZyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpCiB7CiAJaWYgKCEoc211
LT5hZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX0dGWF9QRykpCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
