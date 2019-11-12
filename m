Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86BCC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A754A206B6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A754A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2406EBAE;
	Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87726EBAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRy8sR2i0fIHvYh+5JdfvIlQ0sBEpVqCOEFWz8FIwvXw6MJPoyuwHOn+A6b643g6YBqzSJxk2G/0wMYpARJb3LLdnx45mQO/j6WaqLu4oknIv0fJDd28JkvKpqxABybqQNlV0upXJ17aE3GQMUQZAOX+V9B2veHEoP5Fzz2tgQx8sL3ZWtqv3ZM8m/E2oCbCC8Wb0W0tEH2mwHF5C4wPVtKa0zRyTiBSzpdOQmgK+CjsQ+mPQBI4frLeva4F6BCeV0wnZrIlgciohs3MJ3qFTp60g6XTb4O2E3o0k9BMW2DJkyKZ3S/P0KSzQMzPLUt1t+huKSyn2+BVp2HIa+TRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAdXMn63jYgH+bSc2l4IMKUsLuEL5Qy3kp8QZBnkRug=;
 b=lVEaqWinIumg3s5nl+OxA4ca6mEHiv8aReWUeS0gUKrReFtrdWSh6qMtqhnvYTz2AuCj43O72/d3PUvoCZziDzWwtJxRvs4zhq78hK1CVcahNhcdC3iDgY75lxb00pr3IXjxuokwmheC81eIgCRDG8ocIycEwL3Bd89PfWw4zJkPYP/X0Eo91jtIBosBntIZ0e8KSe5WnhcatCQ1psIIrOg4SDsgdgOg+tpym079twg6f1yEOFqWTETGTtQmGAi8WtymDIQ23ujsYqvfnKq6AICW19aNb67TMwSEdKq3UHkQ9oRYXk6ew/R3vNwnM6RF4gC3mwi8Bb7gKmmjOGI6Zw==
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
Subject: [PATCH 12/21] drm/amd/powerplay: add JPEG power control for Navi1x
Date: Tue, 12 Nov 2019 13:03:20 -0500
Message-Id: <20191112180329.3927-13-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d734710-1d3a-4b33-9c0b-08d7679aba48
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1580F87BE3737D8D4615A766E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(86362001)(11346002)(50226002)(6666004)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rINNiLHUYt+fYV4kLxi5eLObvvWrULIuhhzhHicdat1RuaZ4IkTvYTDW+FzCu5Zm1c/iS86JefMvibHajyqPJwQ8qCvl5mj/PJpKqZbqar8H3Um8yE04uRP4xuDxyM5HfPTO4VdeoJswnXDMCHT85JAoEH7dtAC5wBOIDc2+cI1HIpEmqngyS+f7jd89L4YqM9x9JNg8fAVrV1NH2gDu03yuCMuYkWf684TK4fg7Qr8iix/Q5rxfSnJna7yacoztkR6xkwH4czVUkTCnRbsufeZB4BfZhO3e2bW5OeJ18wQmLP0CUlcObOqdIgooaIVKKIZuEj3hzwx8GjK/TGKADvbp+R68a47ZPOENsoVw0y9TtJqTMkuYoKaP+eM6Oy/f9V7j/buEPEk+UeK28FH1XbhQEH9J7HJcw5KNHdhmh1DzuGa+1cpZbqFwCLKOZvDR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d734710-1d3a-4b33-9c0b-08d7679aba48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:14.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WnmTlv7nV8aV6HIZWVZQ17WAf4UmybJhO8nTiVaoDgRmVTSqm17yKuPbqFZqZG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAdXMn63jYgH+bSc2l4IMKUsLuEL5Qy3kp8QZBnkRug=;
 b=hqvhawEqghjy+QMV5+xttke0twMV8B06c66UknWh5wvt54UFZTwY1HZtNiTRbXcp8QI+O6jAUaeToRT2/bUn+3fFu+N/FLXNjEOMLjoOfhr1nezv6bNB7BSKSYzn/U0PD1a1cmIg2IzcW1U/bxCSJH/kpGhuTJjHPHwYdtqz1II=
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
Message-ID: <20191112180320.UPycXBvpr1fNDSsncdUtRFHHNH4AJKj1urGFSc0935s@z>

Qnkgc2VwYXJhdGluZyB0aGUgSlBFRyBwb3dlciBmZWF0dXJlLCBhbmQgdXNpbmcgaXRzCm93biBQ
b3dlclVwIGFuZCBQb3dlckRvd24gbWVzc2FnZXMKClNpZ25lZC1vZmYtYnk6IExlbyBMaXUgPGxl
by5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBf
cHB0LmMgfCAzMiArKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9uYXZpMTBfcHB0LmMKaW5kZXggYWViOWMxZTM0MWM3Li43NjA1NjhkZWJlNmMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKQEAgLTM4NCw4ICszODQsMTAg
QEAgbmF2aTEwX2dldF9hbGxvd2VkX2ZlYXR1cmVfbWFzayhzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwKIAkJKih1aW50NjRfdCAqKWZlYXR1cmVfbWFzayB8PSBGRUFUVVJFX01BU0soRkVBVFVSRV9B
VEhVQl9QR19CSVQpOwogCiAJaWYgKHNtdS0+YWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9S
VF9WQ04pCi0JCSoodWludDY0X3QgKilmZWF0dXJlX21hc2sgfD0gRkVBVFVSRV9NQVNLKEZFQVRV
UkVfVkNOX1BHX0JJVCkKLQkJCQl8IEZFQVRVUkVfTUFTSyhGRUFUVVJFX0pQRUdfUEdfQklUKTsK
KwkJKih1aW50NjRfdCAqKWZlYXR1cmVfbWFzayB8PSBGRUFUVVJFX01BU0soRkVBVFVSRV9WQ05f
UEdfQklUKTsKKworCWlmIChzbXUtPmFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfSlBF
RykKKwkJKih1aW50NjRfdCAqKWZlYXR1cmVfbWFzayB8PSBGRUFUVVJFX01BU0soRkVBVFVSRV9K
UEVHX1BHX0JJVCk7CiAKIAkvKiBkaXNhYmxlIERQTSBVQ0xLIGFuZCBEUyBTT0NDTEsgb24gbmF2
aTEwIEEwIHNlY3VyZSBib2FyZCAqLwogCWlmIChpc19hc2ljX3NlY3VyZShzbXUpKSB7CkBAIC02
NjUsNiArNjY3LDMxIEBAIHN0YXRpYyBpbnQgbmF2aTEwX2RwbV9zZXRfdXZkX2VuYWJsZShzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwgYm9vbCBlbmFibGUpCiAJcmV0dXJuIHJldDsKIH0KIAorc3Rh
dGljIGludCBuYXZpMTBfZHBtX3NldF9qcGVnX2VuYWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSwgYm9vbCBlbmFibGUpCit7CisJc3RydWN0IHNtdV9wb3dlcl9jb250ZXh0ICpzbXVfcG93ZXIg
PSAmc211LT5zbXVfcG93ZXI7CisJc3RydWN0IHNtdV9wb3dlcl9nYXRlICpwb3dlcl9nYXRlID0g
JnNtdV9wb3dlci0+cG93ZXJfZ2F0ZTsKKwlpbnQgcmV0ID0gMDsKKworCWlmIChlbmFibGUpIHsK
KwkJaWYgKHNtdV9mZWF0dXJlX2lzX2VuYWJsZWQoc211LCBTTVVfRkVBVFVSRV9KUEVHX1BHX0JJ
VCkpIHsKKwkJCXJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0df
UG93ZXJVcEpwZWcsIDEpOworCQkJaWYgKHJldCkKKwkJCQlyZXR1cm4gcmV0OworCQl9CisJCXBv
d2VyX2dhdGUtPmpwZWdfZ2F0ZWQgPSBmYWxzZTsKKwl9IGVsc2UgeworCQlpZiAoc211X2ZlYXR1
cmVfaXNfZW5hYmxlZChzbXUsIFNNVV9GRUFUVVJFX0pQRUdfUEdfQklUKSkgeworCQkJcmV0ID0g
c211X3NlbmRfc21jX21zZyhzbXUsIFNNVV9NU0dfUG93ZXJEb3duSnBlZyk7CisJCQlpZiAocmV0
KQorCQkJCXJldHVybiByZXQ7CisJCX0KKwkJcG93ZXJfZ2F0ZS0+anBlZ19nYXRlZCA9IHRydWU7
CisJfQorCisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBuYXZpMTBfZ2V0X2N1cnJlbnRf
Y2xrX2ZyZXFfYnlfdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCQkJICAgICAgIGVu
dW0gc211X2Nsa190eXBlIGNsa190eXBlLAogCQkJCSAgICAgICB1aW50MzJfdCAqdmFsdWUpCkBA
IC0xOTk2LDYgKzIwMjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgbmF2
aTEwX3BwdF9mdW5jcyA9IHsKIAkuZ2V0X2FsbG93ZWRfZmVhdHVyZV9tYXNrID0gbmF2aTEwX2dl
dF9hbGxvd2VkX2ZlYXR1cmVfbWFzaywKIAkuc2V0X2RlZmF1bHRfZHBtX3RhYmxlID0gbmF2aTEw
X3NldF9kZWZhdWx0X2RwbV90YWJsZSwKIAkuZHBtX3NldF91dmRfZW5hYmxlID0gbmF2aTEwX2Rw
bV9zZXRfdXZkX2VuYWJsZSwKKwkuZHBtX3NldF9qcGVnX2VuYWJsZSA9IG5hdmkxMF9kcG1fc2V0
X2pwZWdfZW5hYmxlLAogCS5nZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZSA9IG5hdmkxMF9n
ZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZSwKIAkucHJpbnRfY2xrX2xldmVscyA9IG5hdmkx
MF9wcmludF9jbGtfbGV2ZWxzLAogCS5mb3JjZV9jbGtfbGV2ZWxzID0gbmF2aTEwX2ZvcmNlX2Ns
a19sZXZlbHMsCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
