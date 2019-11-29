Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616FC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110D0215F1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110D0215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CDB6E0F5;
	Fri, 29 Nov 2019 08:23:40 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650F46E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDaGPrAxEiacXwk1sw4U5HZXCU8jVuiE5hz/fh+Z7PQkDujGdJsVujd8eVa50kFb6x+PMIqQ7wHiEVkNfAHGSoC0rfawTv6LuUgIvX9YdCNhNwhMsFXDElO56Wf1L5yi9uVWBjhgbWh4xU0h2vDjmk1S/ynb3X94giVdhkc2p1qAfWgcJJyxYB3OJNTF6hWRoNZKA5jLQgs4JvJxcD9e14Zg37eeqkGPSUjlCWuxmhQ0TgqV8I1JMfrC25s/JzvOXOEfnI+jm6G0IYKFTT3gdAnogL82lDXtzEa/D1z+qi2wVX9EcI37J5ZmxzCXY3HLXrutInyvvL4LlfE8e6apJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8raKss+c1tzmuMRG2p7Un6RKYYgG8lL2DyotfXWapY=;
 b=g37R2x5W69SGn/SlaiaHjaHxS4RDI5KOwqIj+X01pauNpk7MgTK4cVZvbQQcjFwWG6Gn5QDX9hniArNKNaZN3JgngQXT5Ph1JedScruFVbMGkL86kjhqmj0bEQ32aqzsWYj5lM/5arpi+ACzwXMFMVlhqODo7WHiGUaE/e9UaYnyrKJyAr/0r7KeCDgZ2My4y9ZErj7zsKsGeTZWFcDzE0XDMGPi29R9KKr9dIqg41WbKs7lo47QiD99GGgdjDpql8Je24nlxJPF2iT6rHqfZx+uPIRUtzH0slxs1YEBqveNOLj1R/CAVFXRrb8Rs0eXk+r5M3lincV+0MUVqSS96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:405:4c::24) by CH2PR12MB4151.namprd12.prod.outlook.com
 (2603:10b6:610:78::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.22; Fri, 29 Nov
 2019 08:23:37 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by BN6PR1201CA0014.outlook.office365.com
 (2603:10b6:405:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Fri, 29 Nov 2019 08:23:37 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 29 Nov 2019 08:23:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 02:23:36 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 29 Nov 2019 02:23:35 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: should stop GFX ring in hw_fini
Date: Fri, 29 Nov 2019 16:23:32 +0800
Message-ID: <1575015812-26634-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(428003)(189003)(199004)(76176011)(48376002)(5660300002)(8676002)(47776003)(16586007)(426003)(305945005)(81166006)(4744005)(26005)(51416003)(36756003)(336012)(2616005)(53416004)(81156014)(11346002)(4326008)(446003)(7696005)(50466002)(2351001)(8936002)(50226002)(478600001)(316002)(186003)(356004)(70586007)(86362001)(2906002)(6916009)(70206006)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4151; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1695d110-820b-495d-46a1-08d774a56ea1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4151A1DB235FE1731BAB733284460@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0236114672
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55rKpKFS7Vm0lZLoUmGAz1AHuVRzmbsjrOYsNa5kmH1DDd2KpYPCh8G+3wq8T/ur5GawWm8B/eLB7Tg1NMn2NjsTKRkETfaacI8jmW8OYiAKOj7TH430XBkVi2iStdKFRcZoYhZ6YzLCW57hRx8mHGutXSR6KX6F1Hz1ni2qoa0Hslgs3CN87glqIPNgIz1fCnw8MWAyhevsF1EZjXiDA81msoXuBntVg/DGQV85ByBAW8Z+g+sc0/DgUOwZMKbFVse81oYWadr3w4AIfz3xB4Ye1R1xNH3P3L6A5L+lg0w7n7XgjEBaEIMhhy5uewCbBk2zcjyjw6Rp9hsWIhX42Vu0hBh5oewm7R352Lu5Nf6oQA4pKrTAY8OLldD4UOBC17kJsNsvotDp0oZzNuAkeDHzxzPNWwOQMoKBH5Pl4dcFSkqkR8euqK5XiG9nn5mK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 08:23:36.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1695d110-820b-495d-46a1-08d774a56ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8raKss+c1tzmuMRG2p7Un6RKYYgG8lL2DyotfXWapY=;
 b=io/7TXvrtA2g+20BNZqQYrPWnTEAy29nrgGooKma87J+kHuZugzr0tq61nfPFSt2qG4c7OhJfLHerTLrRht+BhPKFQvZG8wE1iTrVmXeR91k3SsZDTJ26vIgDThGKSzKlOmdnGKp5NeQbwtZBVTbibxUmTqDF+MvMeDmvWI0J9c=
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gYWxpZ24gd2l0aCB0aGUgc2NoZW1lIGZyb20gZ2Z4OToKCndpdGhvdXQgZGlzYWJsaW5nIGdm
eCByaW5nIGluIGh3X2Zpbmkgd2Ugd291bGQKaGl0IEdGWCBoYW5nIGlmIGEgZ3Vlc3QgVk0gaXMg
ZGVzdHJveWVkIHN1ZGRlbmx5CndoZW4gcnVubmluZyBhIGdhbWUKClNpZ25lZC1vZmYtYnk6IE1v
bmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDIzMGU4YWYuLjg4MmNmMWYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0zODA5LDYgKzM4MDksNyBA
QCBzdGF0aWMgaW50IGdmeF92MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAlpZiAoYW1kZ3B1
X2dmeF9kaXNhYmxlX2tjcShhZGV2KSkKIAkJRFJNX0VSUk9SKCJLQ1EgZGlzYWJsZSBmYWlsZWRc
biIpOwogCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJZ2Z4X3YxMF8wX2NwX2dmeF9l
bmFibGUoYWRldiwgZmFsc2UpOwogCQlwcl9kZWJ1ZygiRm9yIFNSSU9WIGNsaWVudCwgc2hvdWxk
bid0IGRvIGFueXRoaW5nLlxuIik7CiAJCXJldHVybiAwOwogCX0KLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
