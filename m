Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8206C4167B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7B522AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7B522AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA156E891;
	Sat, 12 Dec 2020 15:47:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919276E88F
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKv1RSfDZByUwTqLyYA7jHT6CzVagSNY7Z5VHxpouYfjXdM6+kw18yzivXCe0c/insW9SSuOxoSQdBZqpux+wk/l8ksemKsTTS0q7muLtRRVwquGAi/5HHeLrPigZyQa1ROJJAk5MWdk8Nrhg46+oUBmuaBKwjmqXypjEnjR8ac23fpSh1Ow07GCpYHDsfvQoopawZsjo+FIFF/rxQEMhR35imiLlA+rCJgLpPVIpCj7iHIDTQH0RAX1Mmk4TG0H/CGFIWGnW7SKTr08ViKFc9ZuY/ByqJArLvV6JoOpd2jp1NNhZ16pqsVxBlp7L/ySI/C1vR6p2oyXj7GKxNfLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NXiALaKa/6VKKuLQGegI0qia+/zFPbGQc5hjK9uHOQ=;
 b=J0xg37ZE7+yDaZOQtTQZtjn04SNn7VuIs4T8EcM7SrZSIJFL75F3n/HXLSX4ca8XuAd6+SXi3csLKmTrF/fheiFZos785PlXbt/X8njh71hLdiE3dMp/VCzid1yPWC1PxJx/4y20dnpq66moyohqXTUxO+zk5kCzatdPdMr0T9Jlxy4Fsy3cCmE47MbMbOSsCLC9Kku7Wj1pcihkCbuWxd3z7PO16SPiBn2ZDPp3UwnEm+yvQLimaSOHM6MXHFs9DJmuunk+rukriR3uYjS9TRHpFfPfmrK0ncCadnrNwEvx5fQHo9CSOlFez5DYGf1CgBAjDnnuqUVTXOui7bMLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NXiALaKa/6VKKuLQGegI0qia+/zFPbGQc5hjK9uHOQ=;
 b=2/DIJHb1m3LsJjHMzeYKdAM6stpUhooUmnEieo155+ORSb+NE5qfzb/j8zifaDkLEWtgDwHdOCFOcMkYGaht1mN0vfdfcryExHIVKN1OID7cPQe3vv/laXOrrhcAQCODC+dwvk8jdkzwAf3QXh6/p/P3J29GUU+OaauMT0RG3HM=
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by MWHPR12MB1597.namprd12.prod.outlook.com (2603:10b6:301:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:47:30 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::89) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:28 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:26 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 22/27] drm/amdgpu: switch to vega20 ih block for
 vega20/arcturus
Date: Sat, 12 Dec 2020 23:45:55 +0800
Message-ID: <20201212154600.21618-22-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db956bf2-45a3-47f5-ae21-08d89eb53b42
X-MS-TrafficTypeDiagnostic: MWHPR12MB1597:
X-Microsoft-Antispam-PRVS: <MWHPR12MB159736268EB884C9475D6913FCC90@MWHPR12MB1597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogjjEp6M5CRJbe6TqMs3yDQnBFtqSeuq1ko0ot1gt7aVa0hrvY5184DA5lZ8070oQAcjq8IOplB9L2r/0y3vVo/gq8NUonxhYZjL1W50RVXFj7Sk1hZ+4LSjr44tACbAboBW7gyGSjWSmIAXWHd1JUMnF88++mP3wU0uRgt8+gR8UQX9esx1Qrc73hfT+DaFqYfckFfO+meIQTeZk8kAPniRXj3l/xm65qrRX+UNIsa3/6SE3VUYk8M+lEp0zk974AE2trD2C/dRVZ1v0q7SA77TbB3DGpvDUfK1bidkMzevyAy15Xixzjcrdw+IQ+Xhq2QzfihoLtKy3YzV7E3h/HnljiUSVVbAvFel5bt0Vgbd2/33vAxoLBaR9Y+JBme4w+/ZG80N9BzVWj/HrgkXAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(47076004)(81166007)(336012)(186003)(6666004)(5660300002)(4326008)(356005)(7696005)(6636002)(508600001)(36756003)(8676002)(2906002)(8936002)(70206006)(70586007)(1076003)(426003)(82310400003)(2616005)(110136005)(86362001)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:29.2980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db956bf2-45a3-47f5-ae21-08d89eb53b42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1597
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cmVwbGFjZSBuYXZpMTAgaWggYmxvY2sgd2l0aCB2ZWdhMjAgaWggYmxvY2sgZm9yCnZlZ2EyMCBh
bmQgYXJjdHVydXMKClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpS
ZXZpZXdlZC1ieTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZl
aWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYyB8IDkgKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDhhMjM2
MzZlY2MyNy4uMGQzZGVmNzI2OWJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAg
LTYwLDYgKzYwLDcgQEAKICNpbmNsdWRlICJuYmlvX3Y3XzAuaCIKICNpbmNsdWRlICJuYmlvX3Y3
XzQuaCIKICNpbmNsdWRlICJ2ZWdhMTBfaWguaCIKKyNpbmNsdWRlICJ2ZWdhMjBfaWguaCIKICNp
bmNsdWRlICJuYXZpMTBfaWguaCIKICNpbmNsdWRlICJzZG1hX3Y0XzAuaCIKICNpbmNsdWRlICJ1
dmRfdjdfMC5oIgpAQCAtNzI5LDEyICs3MzAsMTIgQEAgaW50IHNvYzE1X3NldF9pcF9ibG9ja3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tf
YWRkKGFkZXYsICZwc3BfdjNfMV9pcF9ibG9jayk7CiAJCQl9CiAJCQlpZiAoYWRldi0+YXNpY190
eXBlID09IENISVBfVkVHQTIwKQotCQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYs
ICZuYXZpMTBfaWhfaXBfYmxvY2spOworCQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFk
ZXYsICZ2ZWdhMjBfaWhfaXBfYmxvY2spOwogCQkJZWxzZQogCQkJCWFtZGdwdV9kZXZpY2VfaXBf
YmxvY2tfYWRkKGFkZXYsICZ2ZWdhMTBfaWhfaXBfYmxvY2spOwogCQl9IGVsc2UgewogCQkJaWYg
KGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkKLQkJCQlhbWRncHVfZGV2aWNlX2lwX2Js
b2NrX2FkZChhZGV2LCAmbmF2aTEwX2loX2lwX2Jsb2NrKTsKKwkJCQlhbWRncHVfZGV2aWNlX2lw
X2Jsb2NrX2FkZChhZGV2LCAmdmVnYTIwX2loX2lwX2Jsb2NrKTsKIAkJCWVsc2UKIAkJCQlhbWRn
cHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmVnYTEwX2loX2lwX2Jsb2NrKTsKIAkJCWlm
IChsaWtlbHkoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9GV19MT0FEX1BTUCkp
IHsKQEAgLTc4Nyw5ICs3ODgsOSBAQCBpbnQgc29jMTVfc2V0X2lwX2Jsb2NrcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewogCQkJaWYg
KGxpa2VseShhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkK
IAkJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmcHNwX3YxMV8wX2lwX2Jsb2Nr
KTsKLQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYsICZuYXZpMTBfaWhfaXBfYmxv
Y2spOworCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnZlZ2EyMF9paF9pcF9i
bG9jayk7CiAJCX0gZWxzZSB7Ci0JCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAm
bmF2aTEwX2loX2lwX2Jsb2NrKTsKKwkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYs
ICZ2ZWdhMjBfaWhfaXBfYmxvY2spOwogCQkJaWYgKGxpa2VseShhZGV2LT5maXJtd2FyZS5sb2Fk
X3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkKIAkJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2Nr
X2FkZChhZGV2LCAmcHNwX3YxMV8wX2lwX2Jsb2NrKTsKIAkJfQotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
