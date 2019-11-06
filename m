Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB8C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD7020869
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD7020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBCD6E174;
	Wed,  6 Nov 2019 06:18:27 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740047.outbound.protection.outlook.com [40.107.74.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB436E174
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+cEiPg/PrBleIwiX0s24O9Yy/oTkWYojTb1XdnU6z2hjhodXzYRDk+FNG01+zJMkX07WdbSmrXX5PbJq5LVFr6BewldKjWbI/ps1Yjb/vtu3YkHzJEziaq/U6Dj/2ad+FYuGoUCQ+Q9tNbr9ECV/F2fzP9O1721yKo0MsYoW3+sjKPM+tQ8YR03f7J8Bqg75jJB6ZVe9eUA3hBntjpQHdrzvaxn5oQlfDoSTB419LWJTneT/mFuq82FFhPzUvUtEx2KHmQmye2FcncWAKFOeXH8ys6Ge5YferfkAuMi/p51QmdgK19u6liO6GU3UJd9twwqDrO3BM9uEBKIfvtsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQO2VZzYWRcrzQHEFc3xSgLTmZYlDfGLn0TzOe7g3+0=;
 b=CWP8fvuAPl+IU/hFTsgaDNl4gE3n+dbRYOLZj87jH2Zobfz3l46P0V2GdqOmcP7ft64Mvhi9NUEfIPhoZTKzzHLVHwgyGrFG2nKUMyuOBOEucol6p9yWTygFf1o6iHdqTWh60fA0iAvmf5jcfxE9uMJpRQeMdg74eN9eK3Ysrc7BmOUt8qgC7xH7nME6EJhRxblvlun96M9i87pF7JaN7FQItkjYW6wGCmZQlsyHGo+gdG00InwghZMJpoEAWQYF1m7trTO/b60MXVIHoJab7iecX0NiBxhZDGoX5Jut49zYlJ1ZWkvh62kPTQSur4+ZU91140eJUJb1CkLAEDpzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44)
 by BN6PR12MB1619.namprd12.prod.outlook.com (2603:10b6:405:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 6 Nov
 2019 06:18:24 +0000
Received: from DM3NAM03FT051.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MN2PR12CA0031.outlook.office365.com
 (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 06:18:24 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT051.mail.protection.outlook.com (10.152.83.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Wed, 6 Nov 2019 06:18:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:18:23 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:18:23 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 00:18:22 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Date: Wed, 6 Nov 2019 14:18:09 +0800
Message-ID: <1573021089-14955-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(428003)(199004)(189003)(6666004)(305945005)(70586007)(16586007)(316002)(4326008)(48376002)(53416004)(2906002)(36756003)(26005)(2351001)(70206006)(51416003)(8676002)(5660300002)(50466002)(7696005)(356004)(186003)(6916009)(86362001)(2616005)(126002)(426003)(486006)(81156014)(8936002)(81166006)(478600001)(47776003)(336012)(50226002)(4744005)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1619; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e438ff7d-d36d-43c6-edd8-08d7628120fa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1619:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16193B42B649132093FCE1EF8F790@BN6PR12MB1619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z69ZtA2DJJAApN5/CXFDssgOaRNTvuR61olCpWU37chW+VICQBvunoV4nTYHpztK7qODVxXuMFEfYks+5eqZn/pF5QuG/cK44DzciHRq2b5J0acLtMvnG/B5REgBW3pmo0pSiSunxFPi8kSICHW4wWcp6F6zkRzTrzf1hPG89e50RUidMJhc1x96pZChywQMz2yKPm6y3OZjGAFRSGrUOEnX3DvdcwNtjmtK0fsJavhONfs1YrHcWvapRhwWl24BJuNOUfxjeq0FIWkwI8IRHQ97C4HQZ6dLSPUW/Ucbv0FyMqkdcAp1AX1bYkQKB6VRSrOPKh+C8dWdDPU7i3Lj4CEOEuWsuTUvgKc0FGbZnr2M/k5F131ayvNsZ6cvzANaPwa5nmjwK7DsIA+8LWHIbu56IKym4P3pd1/jytXoYc8vzmGn8Q1FSnhoAGTB+zs7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 06:18:23.8992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e438ff7d-d36d-43c6-edd8-08d7628120fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1619
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQO2VZzYWRcrzQHEFc3xSgLTmZYlDfGLn0TzOe7g3+0=;
 b=djfakoA+OAvP5vuNWxneUG6IYCUfh7XAcC7fklNI1DaAUHJ4nrtnbA/4VMLVAhXvrUW8bBoep5mHNJCPF+UtP87IrVdKExzz0IVZHncpz6HKNQmyY63SVhQt251W5p7R8WyyJz6/PMOFfXdD0xMJyzeeoRNuHwVxjKbBpjo2az0=
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106061809.mPC6PKPt3Y0_KS7oNwe0Q7JQ_1YyjKB_PYRI8f_zOcU@z>

Rm9yIGRyaXZlciByZWxvYWQgdGVzdCwgaXQgd2lsbCByZXBvcnQgImNhbid0IGVuYWJsZQpNU0kg
KE1TSS1YIGFscmVhZHkgZW5hYmxlZCkiLgoKU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1p
bHkuRGVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
cnEuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwppbmRleCA2MDQwZWIzLi40OGQ5Y2YwZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwpAQCAtMzI1LDcgKzMyNSwxMSBA
QCB2b2lkIGFtZGdwdV9pcnFfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJZHJt
X2lycV91bmluc3RhbGwoYWRldi0+ZGRldik7CiAJCWFkZXYtPmlycS5pbnN0YWxsZWQgPSBmYWxz
ZTsKIAkJaWYgKGFkZXYtPmlycS5tc2lfZW5hYmxlZCkKKyNpZmRlZiBQQ0lfSVJRX01TSQorCQkJ
cGNpX2ZyZWVfaXJxX3ZlY3RvcnMoYWRldi0+cGRldik7CisjZWxzZQogCQkJcGNpX2Rpc2FibGVf
bXNpKGFkZXYtPnBkZXYpOworI2VuZGlmCiAJCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3Vw
cG9ydChhZGV2KSkKIAkJCWZsdXNoX3dvcmsoJmFkZXYtPmhvdHBsdWdfd29yayk7CiAJfQotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
