Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E216C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6797120748
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138DD89EEB;
	Mon, 25 Nov 2019 14:10:47 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740085.outbound.protection.outlook.com [40.107.74.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592F289EEB;
 Mon, 25 Nov 2019 14:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPaZ5yejEs3z1loCkAagdCTDLT2OKVnbDjxuPdFGdZXRbohx1HMdNgkw9UCARuCC1GQUpeShOp8s68TA2SDBRAiME5oRpfjVZ7bBLY7PewkaZhiR+peHvBYVJBH4oX9Ajt39UvD897+IRljJVvTgx1Y160PSCSYYxDW/G5cOOkPFrT1OKQ0myiX3Ru84tsK1Kzar1xvGYdXA4F/OzBaWOE17/oKit0YgXc9/VkcurANzmWvkK4mAm3Rs3cu/H8BWLOdzBGXfq3urtPeXCSj1mNi8YonEha5opkNh8Re8kt8ON1AZ4BmdLgvlpi7yoC0yjipkJJXRaa1seIUuNTYN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQB2P7dzqtgJCuhlvrOp4O3VPy4MxsHmfUz8X1lVXBo=;
 b=aI9zVxt3/eK3vmo1E1dRP6td040l8ph548TrK8dP/65FxUJdjazaDjfOPT/TAnwcIqdZeFgSGnPMjS7fM8IvrUDdILBLw5Lk31eUlSRHWnqZWw2sPFCEWNsgB/yKRp+5rK1q6R4icN6pz54z6lEPUuGGFYFxYugbrDN3/mQuaDs7jDUM+ohcnB0aJjGKKOIVHEWGdIMiY05XbsIKadJxjJWk+fRIbMmb3HVHkaPYKpj1ugHID4Hvw/7bubsnoLBh+R2hy64gdQly8jgMm5PesBhQacZwWD5vYcjpHgeAXd0N+30kX2VHUC3dc2GvNsjGfy0BuZzLT2ZpLzO3VCb//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0010.namprd12.prod.outlook.com (2603:10b6:4:1::20) by
 BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Mon, 25 Nov
 2019 14:10:43 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM5PR12CA0010.outlook.office365.com
 (2603:10b6:4:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 14:10:43 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 25 Nov 2019 14:10:43 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 Nov
 2019 08:10:43 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 25 Nov 2019 08:10:42 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: 
Subject: [PATCH v3 1/2] drm/sched: Avoid job cleanup if sched thread is parked.
Date: Mon, 25 Nov 2019 09:10:40 -0500
Message-ID: <1574691041-5499-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(428003)(189003)(199004)(23676004)(7696005)(53416004)(47776003)(478600001)(54906003)(186003)(70586007)(70206006)(44832011)(426003)(5820100001)(316002)(450100002)(50226002)(336012)(8936002)(4326008)(2616005)(5660300002)(2906002)(8676002)(356004)(50466002)(36756003)(86362001)(81166006)(81156014)(1671002)(66574012)(26005)(14444005)(2870700001)(305945005)(109986005)(266003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2904; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e750e1-967f-4b09-b062-08d771b14277
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:
X-Microsoft-Antispam-PRVS: <BYAPR12MB290416FEE9E47B56BC97D3A4EA4A0@BYAPR12MB2904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tOukE7XvVgahiihCqJcL47Zu+efYZD7rsMoWzT/uX80Rsc4dWVsnmde0WLfLmZQIVSiPKOz47TwOvnzC92HPXeGo/L+s0InTz2yyh4ner9DSSBhHfOhmIMqGwcEHILTAEfxC0VYXfuqx2siPyJZ6mqPhmniOsGUH+v50wsW3GhpFzNAeD4TWinndWXQGa2/yCQSXIQsWd8Ul/hPeK3hd2CTet449Ruib4nW6KlOMJYEiEQTisI75ERqqOzjU55sfmZE3SCqDYH+gl2F+qLUrlW6AFVmWYQRHYDmGEINZvFZtOYzvzLMSEYXFWjjpDGGRJ5s2Fz/7H9GhaXTMVzv9kxmuOJWIziHaaCJD2mZ8nYVjaBztQQ0rNaMptZ2yaZ0ao6MEFV1BkBa7RmeEZS2ENBix0WhZhlEJxru8ejGbMwiK1+UTe9MOP4FkijQLCXC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 14:10:43.4074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e750e1-967f-4b09-b062-08d771b14277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQB2P7dzqtgJCuhlvrOp4O3VPy4MxsHmfUz8X1lVXBo=;
 b=kHcZ6diOMDKVnQb68GXL/IfsZ9oD27HOY4qKV2D+hr53Jv7BMsqI6RGe8C2QTbNg8qOT/axJa1oJ6wQ0ksnJ/dMHMFSHNhfZf1ZTsJVSi8DHoMDoUkIFQ87Dr+t3BtVLVYiTfeKSILKHcPYTzYJ3cT3EZWP4ksncKFijnqhHkj0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Emily.Deng@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125141040.b3nv1EbnzaiyA-RMPhPiD2WeidKoWeFFmqMtRh7mk6g@z>

V2hlbiB0aGUgc2NoZWQgdGhyZWFkIGlzIHBhcmtlZCB3ZSBhc3N1bWUgcmluZ19taXJyb3JfbGlz
dCBpcwpub3QgYWNjZXNzZWQgZnJvbSBoZXJlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6
b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9tYWluLmMKaW5kZXggZDRjYzcyOC4uNjc3NDk1NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9tYWluLmMKQEAgLTYzNSw5ICs2MzUsMTMgQEAgZHJtX3NjaGVkX2dldF9jbGVhbnVw
X2pvYihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQogCXN0cnVjdCBkcm1fc2NoZWRf
am9iICpqb2I7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAotCS8qIERvbid0IGRlc3Ryb3kgam9i
cyB3aGlsZSB0aGUgdGltZW91dCB3b3JrZXIgaXMgcnVubmluZyAqLwotCWlmIChzY2hlZC0+dGlt
ZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCAmJgotCSAgICAhY2FuY2VsX2RlbGF5ZWRfd29y
aygmc2NoZWQtPndvcmtfdGRyKSkKKwkvKgorCSogRG9uJ3QgZGVzdHJveSBqb2JzIHdoaWxlIHRo
ZSB0aW1lb3V0IHdvcmtlciBpcyBydW5uaW5nICBPUiB0aHJlYWQKKwkqIGlzIGJlaW5nIHBhcmtl
ZCBhbmQgaGVuY2UgYXNzdW1lZCB0byBub3QgdG91Y2ggcmluZ19taXJyb3JfbGlzdAorCSovCisJ
aWYgKChzY2hlZC0+dGltZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCAmJgorCSAgICAgIWNh
bmNlbF9kZWxheWVkX3dvcmsoJnNjaGVkLT53b3JrX3RkcikpIHx8CisJICAgICBfX2t0aHJlYWRf
c2hvdWxkX3Bhcmsoc2NoZWQtPnRocmVhZCkpCiAJCXJldHVybiBOVUxMOwogCiAJc3Bpbl9sb2Nr
X2lycXNhdmUoJnNjaGVkLT5qb2JfbGlzdF9sb2NrLCBmbGFncyk7Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
