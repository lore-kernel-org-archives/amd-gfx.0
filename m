Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42605C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2577B2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2577B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75E76EBB0;
	Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FF46EBAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbL3IAcLobn0uA66khlapCqS8T8iS/yREAK4TwY0tzwZtQ8Y0/RFG3B1R2jvQWoZNyuppmusc8yGppKi8al9vidZNPrl1CniZSEBRhh1WYbVVwj2xkqtxRrbMuwCoCHzqlzuSmXRPf7gXKRON+GP5DMSb5q3u0JanZdjCDnvX+UmSymoCGKUtwX4cDl2e0NhdZQPjlIR2htbQK4Sc7lqDyV8F/PnqcHAqXP+yRClVX00AEv/oBf9f9cJNj//ZTzpDEKD7oCySk+kgf/uP6pTyBNIy9VhA//szV8iRb9crg6XHcaMOtHOVfxPMvUqPS3TR/sAyGJRfmFre4KjQlzk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiLfZMN0kYBy1PausdefVUnbseRpLPgqIhIWO5j1hHY=;
 b=F0U0b82FLUJRJ0HxYL4BST4R7aquGGO1NFxPo5oR5qmYap4IfHmEgrDCpqLFXEOU5OhGgsLTTsrvvFSRj/JXXB44CtfLu0lMa0sZOIEdGsEIVj3ZlWkWzkmIkEgZ233PXTqDV/aFvJ3ktR0TIsukGXcdRq+M8li5/WLR4xb/H1P1E/ZKlsg/skRPZJqM7TS53Cs6C1F8jsbiLxroj8WRuLogEgPVbHia0Xzs7DY2f+vnTwLbLlU1/jU3rfkKbt6IRWCB5k9v2feDPI1Avs3b5+O+F03yga0BmxWfMmr7tr8DeEWR8FtG4ameiaJVFVapCYSAVovd1WoZFezl56JuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:14 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:14 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/21] drm/amd/powerplay: add JPEG Powerplay interface
Date: Tue, 12 Nov 2019 13:03:19 -0500
Message-Id: <20191112180329.3927-12-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b104c0b0-d0c9-4c80-4ed5-08d7679aba02
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15804A8813D716D1EE766963E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCmtfIXfmexebo1j3C6wBf0CF5PTPCRWA8EU0nCsq71dQxgKAYvArbe7INpxI+ySMbALIlO5xomLO4Ch7dWr7CP1bBcu4eQfRLkfLHcmjWxyNQKqZW60Vg7VunQ3Cn3gO7YbcC21phYNacgu8TZ9f8+zxatEy8s2E6k8FaAbbwUl85PGgztcD01cPetcROgATHYavv8BNuoXWVnJx/Qg7YKUxw0ocnxUVC8V7DWfBdRv0OfVxe2WN8IYFULb8lh7RRtdhXRF8D6ivvoCNolo4G6DK4Cnsn/gNTh23wN+vRx1jOo5h3lRvgx+RDyjb3yMFgV2yR4eIkuviiXB5mO4KaMuoIysZF99CTeKat+0tLSL+9zJvxo7OUh0iI65Fi1yKuwQwZebBvoxEMslmVMCdmCKY5rh9fn+9DdnkoVCcTHfogtsVU9WQzbLoHDpa5EK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b104c0b0-d0c9-4c80-4ed5-08d7679aba02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:14.1001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnys1/JV+Hcv148peXYsJudwhnKUtgA8rIKOweYF4EJ5hgxxsTFD4Zb2ETI6szGn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiLfZMN0kYBy1PausdefVUnbseRpLPgqIhIWO5j1hHY=;
 b=S+c3UMbP+bQyHbCa3gV2LD18SFz3rFUBHN3HAoz+3ofAHruqp2XpjlB2e5sqHDtFfsyJtS+o4Gf9RLuBpzR5p9QpV+uGW3oQMd/O9FvLRFBRFqsCr94/QKTIGGpAqWaIeF7TxGYcemXq23p9mTRhd6uxaMZ5nqXh0d/F8CdCetU=
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
Message-ID: <20191112180319.WURquuVFrk8gXQffFGWpK8lkMn88w4fo2Gbg0uj9iTo@z>

SXQgd2lsbCBiZSB1c2VkIGZvciBkaWZmZXJlbnQgU01VIHNwZWNpZmljIHRvIEhXCgpTaWduZWQt
b2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aW5jL2FtZGdwdV9zbXUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRn
cHVfc211LmgKaW5kZXggOTk5NDQ1YzVjMDEwLi5jZGQ0NmNkYWZmYjggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaApAQCAtMjgyLDYgKzI4Miw3
IEBAIHN0cnVjdCBzbXVfcG93ZXJfZ2F0ZSB7CiAJYm9vbCB1dmRfZ2F0ZWQ7CiAJYm9vbCB2Y2Vf
Z2F0ZWQ7CiAJYm9vbCB2Y25fZ2F0ZWQ7CisJYm9vbCBqcGVnX2dhdGVkOwogfTsKIAogc3RydWN0
IHNtdV9wb3dlcl9jb250ZXh0IHsKQEAgLTQzNSw2ICs0MzYsNyBAQCBzdHJ1Y3QgcHB0YWJsZV9m
dW5jcyB7CiAJaW50ICgqc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZSkoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsIGxvbmcgKmlucHV0LCB1aW50MzJfdCBzaXplKTsKIAlpbnQgKCpkcG1fc2V0X3V2ZF9l
bmFibGUpKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVuYWJsZSk7CiAJaW50ICgqZHBt
X3NldF92Y2VfZW5hYmxlKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpOwor
CWludCAoKmRwbV9zZXRfanBlZ19lbmFibGUpKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29s
IGVuYWJsZSk7CiAJaW50ICgqcmVhZF9zZW5zb3IpKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBl
bnVtIGFtZF9wcF9zZW5zb3JzIHNlbnNvciwKIAkJCSAgIHZvaWQgKmRhdGEsIHVpbnQzMl90ICpz
aXplKTsKIAlpbnQgKCpwcmVfZGlzcGxheV9jb25maWdfY2hhbmdlZCkoc3RydWN0IHNtdV9jb250
ZXh0ICpzbXUpOwpAQCAtNDg5LDYgKzQ5MSw3IEBAIHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHsKIAlp
bnQgKCpjaGVja19md192ZXJzaW9uKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7CiAJaW50ICgq
cG93ZXJnYXRlX3NkbWEpKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGdhdGUpOwogCWlu
dCAoKnBvd2VyZ2F0ZV92Y24pKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGdhdGUpOwor
CWludCAoKnBvd2VyZ2F0ZV9qcGVnKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBnYXRl
KTsKIAlpbnQgKCpzZXRfZ2Z4X2NncGcpKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sIGVu
YWJsZSk7CiAJaW50ICgqd3JpdGVfcHB0YWJsZSkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOwog
CWludCAoKnNldF9taW5fZGNlZl9kZWVwX3NsZWVwKShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
