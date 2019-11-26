Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE85C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0008420722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0008420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C531E6E2FF;
	Tue, 26 Nov 2019 11:50:41 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3866E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 11:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxZvzs0D7xrtDuji2Loa0Kz58nVVEw/31G0p1+sN+c736zy6lPYPNKg7Nacg4SrXp2qRqO/Rud5OhXLNW93fXKgCEnvkha+4Gx68Q76ko/PSAJ8lAQa+tyLopgPWz+V+7QIt13gMPatG8GvIx1i8EIQoIp01NI3TXfv5d7IpkjQda6rwxpdbUZYpm+2ILQ/SPduECJ60IflLnjgoMKAhHIAZa0p3YDCq/pgLQ/VLuQ8rc+Fr6Dr6ErOpqI8Jf4SICKAwGp3nIG4CREaBLupg1JQZIK+yxJM6PzKrmgieGCRMpfi5mRU/BscugPlLLr8VSEJuqM+KlKL1zt9kE5Nw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iklaUpienbTDsznGOWyVDXojH2WSBogdzdZXXo/HuZ8=;
 b=nEmjjJjmGhZPMxCt5Ywe9lP9Yw9oM6/vQb6PEfTiJEd9AninbMBtiU5fKiMvEYSBzWykE1+FzijXl8FujBXSU83TMjo4YjsJAiiAH5bp9Pud7tzkF9ZyOJRlgOBkqCm6C5+O/tlHpzpMquLcMwK3/i77odBYZROs457KwNXZyB3/SWS7DxMxGM4q8G8sBan+U7GtRp0n2RplqG+mxgaU8+nAQYWXLq4BfFjckCeWhDuMxB7Xzh/WjlsPhTaCPi6HFZeF6I36kaX+Husl64Efa1rf/Xeg9ZU9gKM5NdJsHgBjvBlyRuBd2/1jBhkL6RO5zbrQavpYUKi4bxqRHK/J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0073.namprd12.prod.outlook.com (2603:10b6:802:20::44)
 by BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 11:50:39 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by SN1PR12CA0073.outlook.office365.com
 (2603:10b6:802:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Tue, 26 Nov 2019 11:50:38 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 11:50:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:36 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:36 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 26 Nov 2019 05:50:35 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Date: Tue, 26 Nov 2019 19:50:23 +0800
Message-ID: <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(199004)(189003)(336012)(70206006)(2351001)(316002)(16586007)(14444005)(2906002)(36756003)(50466002)(47776003)(48376002)(70586007)(11346002)(6916009)(26005)(50226002)(8936002)(305945005)(186003)(51416003)(81156014)(76176011)(2616005)(8676002)(7696005)(81166006)(426003)(86362001)(53416004)(5660300002)(478600001)(6666004)(4744005)(4326008)(356004)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1572; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74af571c-68f2-44cb-1322-08d77266db40
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1572FEB016F40F19EA1A188984450@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfMPUm+lTkjD6DzsjN1gNznyIp6A/gJbMHoCdEI04s6O566Sfo98a2Muygm7xaZV898fyD1esbXtH/5chR3qjk8qBx7lYoK1knAM0udP/hFJ5YSu+DnVPhsEKSt8OOuGMvUeqUHTGpuNLphH/OswEjunJhILwmY6Oy2WmtZNjcceTYd75su6EAgg3GG6BLQk0UiBt3PR4GLb2pgZGC7wsWk0jc9eUiy9mgz9afyHK1GiZd7/dQ/osNgssVl+zvgS8lafyjVhcuSc0cCfcPAYMjDDhrU8ByLpNAaib6ktG76eWvEVH4yfFbSqrLwewx01QiDVLz0TqUKqcpaWEPsylITWr1Y9kVNZzNHwJhSQE9SjPn69sGx1L43nHqn8imkgSE8OAoZCibQZ7nAyvHZM+Yld+AWhXrwEo1upJYwlCE6YyQz5torgmJALg6Y4l5Uq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 11:50:38.5233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af571c-68f2-44cb-1322-08d77266db40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iklaUpienbTDsznGOWyVDXojH2WSBogdzdZXXo/HuZ8=;
 b=wZ50vhGqQ7NyFRMQslTmbfWuSArzgRaua+GrHphVd2Nq1gtTKoT9SZM7h9Y46BWre6NkX7k+VsrYYrYFt/6Bu2n22cP10YLPwz1amaHxNNF25YqlIo+w8IQ0XmAPUZB4gD2zu/pgMTJBrnW6Tm0cpvQQguQ0IYzK7OxSpyppBo0=
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
Message-ID: <20191126115023.RaaZEOqFqpIb9oIFdEwW0PWfXV5V6KxHbNSkT0_xSyo@z>

b3RoZXJ3c2UgdGhlIGZsdXNoX2dwdV90bGIgd2lsbCBoYW5nIGlmIHdlIHVubG9hZCB0aGUKS01E
IGJlY3Vhc2UgdGhlIHNjaGVkdWxlcnMgYWxyZWFkeSBzdG9wcGVkCgpTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjEwXzAuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCAz
MjFmOGE5Li40YmI0ZDI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwpA
QCAtMzI2LDcgKzMyNiw4IEBAIHN0YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF9ncHVfdGxiKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAogCiAJaWYgKCFhZGV2LT5t
bWFuLmJ1ZmZlcl9mdW5jc19lbmFibGVkIHx8CiAJICAgICFhZGV2LT5pYl9wb29sX3JlYWR5IHx8
Ci0JICAgIGFkZXYtPmluX2dwdV9yZXNldCkgeworCSAgICBhZGV2LT5pbl9ncHVfcmVzZXQgfHwK
KwkJcmluZy0+c2NoZWQucmVhZHkgPT0gZmFsc2UpIHsKIAkJZ21jX3YxMF8wX2ZsdXNoX3ZtX2h1
YihhZGV2LCB2bWlkLCBBTURHUFVfR0ZYSFVCXzAsIDApOwogCQltdXRleF91bmxvY2soJmFkZXYt
Pm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsKIAkJcmV0dXJuOwotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
