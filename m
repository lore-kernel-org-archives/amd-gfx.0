Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA0C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3122245C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3122245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FF76E96A;
	Thu,  5 Dec 2019 11:54:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083D16E96A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 11:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Espy4VooVbRVK5aj9MpyaN5hrzYasj1pnUcN314k+jnUwNN+U7YkYDyAcJO+eIMsWNYr7ZFG1VdoewxgjJSK/bKeutGVq+zTBhEc1x6nJqMSoITma9ADtNRNRZE5RwSyjw7x0M0m2hlND0/V9e06M9L+R0WZc4POEO0xLRcacqnIW0W541Ugpjs5ZeXafohD59f0Rj+rtqe7yCAFqdJOFfDRkgjoYyqGbmOULL1TrNZxmNDJqzD1f5qOeBlKYySCKULf6TnjCi3d/f1bUIv3x21R58yydeQYka224nzTd7g3q6ItbYt1EoxIMpPAFbWfiZ2mKZuxcmXJXhN5X+k+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBpk57DC0gbHF4dqYa4/OWQ86f31uaAiN4KMM3gpAQs=;
 b=Htlg2ZNpRZxG3F7/edcaXc6MqeSgt8l5AN2g7Fz1K/kb6VbUNePJZ6X/Ws21yp19z6VbtaSYG20GnDJZeJDlFWCVj7vhATpNX2QHyrJrrtx0A7t3FFQpybWpEjxZYVzQctaGGwzsFuCpDLBoGGJC+/950COgRmvg2Uma9KN0GLz9n6/WmW7NSG5f09JsoVMhDztEIBel364HUglV3a/zXiHMz3UDDnh2krg0yBfeZ4Pw2z/RBe5BZMN2ZezrdnOekZAxS1o9tSxmeVONlqgXUNGpHIk6s12ZAhKvEhcba0RhWe5t5zGEDiQVCaRkvbp4rerUHTWqKVb1slUa4jquvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (52.135.55.74) by
 BY5PR12MB4180.namprd12.prod.outlook.com (10.255.126.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 11:54:02 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 11:54:02 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: implement the get_enabled_mask
 callback for smu12
Date: Thu,  5 Dec 2019 19:50:30 +0800
Message-Id: <20191205115031.3822-3-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
References: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To BY5PR12MB4258.namprd12.prod.outlook.com
 (2603:10b6:a03:20d::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2087f0b-6913-4acb-2257-08d77979d290
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:|BY5PR12MB4180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41806FB9A710602617E194789F5C0@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(50466002)(14444005)(316002)(478600001)(8676002)(4326008)(48376002)(14454004)(186003)(2870700001)(86362001)(36756003)(1076003)(6666004)(2906002)(81166006)(66946007)(99286004)(6916009)(51416003)(11346002)(5660300002)(66476007)(6506007)(6486002)(76176011)(66556008)(25786009)(6512007)(26005)(305945005)(8936002)(81156014)(50226002)(52116002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4180;
 H:BY5PR12MB4258.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kkkr6apwnPgWnRiAoU51SSKaZryQoYdiW6B4hVgA4eqb5Q/mfLlqvWIrZy4u+jqZ1Hq4X3XmLmD6OYxFQ7gz4N+e6BI63MdD11wUHRNYOaatDCV2PFsjtSd4TClEgKV4yv3CLpVXx7AS1o2Z0juWjSle0s0J++UvB3hFozD154Vp7p1UXJHFKbYSWTlFaZ9rXoBb+rJj9SIKjmgiWaMtkoYSrVdBKkYcSkvhjDT2zvWs4MyqZOmd4xmEtFkyZtqnACLLr7Rm5FdtwNjLWtWuV7jvbFaaPvOHRWyU2vPVu3CbRKTwuPfTplTpMBB2UrXjQtoGupEZjt6DXI2c7e/Xe6rGZcyIYjQTmhPbAfouS0xCRrx0wGCui80Yw779NpI9keFFTAcHOFWqUEAgAkWRKVRc9eKBjPYIaCVKRBAF2SL9q+0yb9lqZl9m0cc9jZ1x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2087f0b-6913-4acb-2257-08d77979d290
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 11:54:02.7934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRNT8K/jlkSGlCIQgl8nL8AjZe8q6k8O9ool9T8xU8plKEdPP4+0SG2cDvOzqBYadJ05dIGG8Wt5FGNU+ioUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBpk57DC0gbHF4dqYa4/OWQ86f31uaAiN4KMM3gpAQs=;
 b=S3drGZfZ1J5g+OjuJsCNH0C6dWa500zYdw9dozUq2Z7OALQ/Ukc73+wOXLZaunHsklSS+OEZRkHVS9Sw/ImGbOR3TRHo9UfWdZsCYppnyxjofo/stOJ6S48lM7LsZPl+Sw32tCoVE44MT4cTVGmfvsUl2RZQWL/ZsUhq2kEFweQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaomeng.Hou@amd.com; 
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aW1wbGVtZW50IHNlbnNvciBpbnRlcmZhY2Ugb2YgZmVhdHVyZSBtYXNrIGZvciBkZWJ1Z2ZzLgoK
Q2hhbmdlLUlkOiBJYTA4NWFhYjRjODJiOTc4ZTFlOGM4ZGRjM2NhNjI3OGI5ZGVjODAwNQpTaWdu
ZWQtb2ZmLWJ5OiBYaWFvbWVuZyBIb3UgPFhpYW9tZW5nLkhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjEyXzAuaCB8ICAzICsrCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgICAgfCAgMSArCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYyAgICAgfCAyOSArKysrKysrKysrKysrKysr
KysrCiAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmgKaW5kZXggOGI0MDY5YzhlNjY4Li4xZTU4
ZWVmZWE3N2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXVfdjEyXzAuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3Yx
Ml8wLmgKQEAgLTc2LDYgKzc2LDkgQEAgaW50IHNtdV92MTJfMF9maW5pX3NtY190YWJsZXMoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUpOwogCiBpbnQgc211X3YxMl8wX3BvcHVsYXRlX3NtY190YWJs
ZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOwogCitpbnQgc211X3YxMl8wX2dldF9lbmFibGVk
X21hc2soc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCisJCQkJICAgICAgdWludDMyX3QgKmZlYXR1
cmVfbWFzaywgdWludDMyX3QgbnVtKTsKKwogaW50IHNtdV92MTJfMF9nZXRfY3VycmVudF9jbGtf
ZnJlcShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwKIAkJCQkJICBlbnVtIHNtdV9jbGtfdHlwZSBj
bGtfaWQsCiAJCQkJCSAgdWludDMyX3QgKnZhbHVlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L3Jlbm9pcl9wcHQuYwppbmRleCAxYzI2ZDc3OTgxNDYuLjFlNmI3OWNmZjIzYyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYwpAQCAtODk5LDYgKzg5
OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyByZW5vaXJfcHB0X2Z1bmNz
ID0gewogCS5pbml0X3NtY190YWJsZXMgPSBzbXVfdjEyXzBfaW5pdF9zbWNfdGFibGVzLAogCS5m
aW5pX3NtY190YWJsZXMgPSBzbXVfdjEyXzBfZmluaV9zbWNfdGFibGVzLAogCS5wb3B1bGF0ZV9z
bWNfdGFibGVzID0gc211X3YxMl8wX3BvcHVsYXRlX3NtY190YWJsZXMsCisJLmdldF9lbmFibGVk
X21hc2sgPSBzbXVfdjEyXzBfZ2V0X2VuYWJsZWRfbWFzaywKIAkuZ2V0X2N1cnJlbnRfY2xrX2Zy
ZXEgPSBzbXVfdjEyXzBfZ2V0X2N1cnJlbnRfY2xrX2ZyZXEsCiAJLmdldF9kcG1fdWx0aW1hdGVf
ZnJlcSA9IHNtdV92MTJfMF9nZXRfZHBtX3VsdGltYXRlX2ZyZXEsCiAJLm1vZGUyX3Jlc2V0ID0g
c211X3YxMl8wX21vZGUyX3Jlc2V0LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvc211X3YxMl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVf
djEyXzAuYwppbmRleCA5MDIyZTYwYWM5ZGMuLmY2OTkzYzQ3MGZkMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMl8wLmMKQEAgLTM1NCw2ICszNTQsMzUgQEAgaW50IHNt
dV92MTJfMF9wb3B1bGF0ZV9zbWNfdGFibGVzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogCXJl
dHVybiBzbXVfdXBkYXRlX3RhYmxlKHNtdSwgU01VX1RBQkxFX0RQTUNMT0NLUywgMCwgc211X3Rh
YmxlLT5jbG9ja3NfdGFibGUsIGZhbHNlKTsKIH0KIAoraW50IHNtdV92MTJfMF9nZXRfZW5hYmxl
ZF9tYXNrKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAorCQkJCSAgICAgIHVpbnQzMl90ICpmZWF0
dXJlX21hc2ssIHVpbnQzMl90IG51bSkKK3sKKwl1aW50MzJfdCBmZWF0dXJlX21hc2tfaGlnaCA9
IDAsIGZlYXR1cmVfbWFza19sb3cgPSAwOworCWludCByZXQgPSAwOworCisJaWYgKCFmZWF0dXJl
X21hc2sgfHwgbnVtIDwgMikKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlyZXQgPSBzbXVfc2VuZF9z
bWNfbXNnKHNtdSwgU01VX01TR19HZXRFbmFibGVkU211RmVhdHVyZXNIaWdoKTsKKwlpZiAocmV0
KQorCQlyZXR1cm4gcmV0OworCXJldCA9IHNtdV9yZWFkX3NtY19hcmcoc211LCAmZmVhdHVyZV9t
YXNrX2hpZ2gpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXQgPSBzbXVfc2VuZF9z
bWNfbXNnKHNtdSwgU01VX01TR19HZXRFbmFibGVkU211RmVhdHVyZXNMb3cpOworCWlmIChyZXQp
CisJCXJldHVybiByZXQ7CisJcmV0ID0gc211X3JlYWRfc21jX2FyZyhzbXUsICZmZWF0dXJlX21h
c2tfbG93KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJZmVhdHVyZV9tYXNrWzBdID0g
ZmVhdHVyZV9tYXNrX2xvdzsKKwlmZWF0dXJlX21hc2tbMV0gPSBmZWF0dXJlX21hc2tfaGlnaDsK
KworCXJldHVybiByZXQ7Cit9CisKIGludCBzbXVfdjEyXzBfZ2V0X2N1cnJlbnRfY2xrX2ZyZXEo
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCQkJCSAgZW51bSBzbXVfY2xrX3R5cGUgY2xrX2lk
LAogCQkJCQkgIHVpbnQzMl90ICp2YWx1ZSkKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
