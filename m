Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B047C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EA92064B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bkXfrtiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EA92064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897DC89BCD;
	Tue, 28 Jul 2020 11:21:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A70889BCD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 11:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaHooAxitjrBTsQF3lkZGfcIDhK2e8nEQArTH6FDNgL6NUI783ikahY29POMQ8LgQQ9uguyBPSENXwnnPbiMR96Q9WIQE2kgBSZVbg5K3uvy/PK+HATDPDPP1MDQSIICJ6clvi/LPWM3+F2upNePQ0RH5/jIS+Ee45aDbZe47i+Z9qm0/jd1MunSUkriwGDYd4fzR6v61SfDTS/LLDxLKyn+xtyW7Klw89jZvkxSU0jQbMu7+dja6um15mwxrWMGIpy5oEgDO93+IyQkDT1aOPTh3O1tnvB+3ZixKtz08MAczv+YYoDDpzqaBjnJ96ku1AD8iS/CTjb/zRd+nqypDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrv50bs1OVyMs86rEMaVGysoiFD2qqk8EUk1JHf6pcM=;
 b=ecEr2XOmiQrKynfcuyGu1oZwM2KWuCEgThDaEiqGJl2m9+fYXNVDxoLd14w916gSm1+kJJdNBQjv/dE+02h05g/PRJv7kH7dHUF6dHfzXh7pRrtmBnt8cGTQZbw639/vTcMz7Qz88i9sEKD0Kzo20bl/3CqxigUbgYn68XDfAMc963mC4YQsV9ECuonHGjQVF1Crh3Oadf1EN7APZLkAnE5YXGMDDICPFhDN9yh32qmvGo/0UFwHcxriIYqxGVrrNTqyoZGIX5t++Hn4PXWgVMsemYyblmpN6Z5DQkpwwCWyo5LjLkI/3T/7d34ukjlBqSnBd2SFYgfgV/VD5qgyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrv50bs1OVyMs86rEMaVGysoiFD2qqk8EUk1JHf6pcM=;
 b=bkXfrtiKmlHaSE0lz9WW8rP8UPRPqJbEODlJ0lGviNAWqrMvzKscNxHxMy9rBMKWq2nXPClfQxaBjKrBEuPcZBomuqGtsIwVkQe+nkrmXjhYcUBJD66Mf/kPOoy71zDNPGvW1NNbm4f+w/O0Zno1ETXPu+eWw3HTj0QpaapvY0w=
Received: from MWHPR19CA0066.namprd19.prod.outlook.com (2603:10b6:300:94::28)
 by CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 11:21:26 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::34) by MWHPR19CA0066.outlook.office365.com
 (2603:10b6:300:94::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 11:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 11:21:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 06:21:24 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 06:21:24 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jul 2020 06:21:23 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: update driver if version for navy_flounder
Date: Tue, 28 Jul 2020 19:21:13 +0800
Message-ID: <20200728112113.1883-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d59c35a-ce32-43e0-e35d-08d832e85db6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3815:
X-Microsoft-Antispam-PRVS: <CH2PR12MB381515A9853B70D56E1261F1EA730@CH2PR12MB3815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIkYycmdbxWJjzJbX9wcMytPiWfRnB7iKi4b4sZVLDa/b0o9CZEc9/ggzZgRdN1XPBMf5SsQRpA7XrsCFmHiXx+5Vxy2GKPIJncla9EqcMKB5RBfomXmS/3ve/B3liYaRcjSgV0bWaLM7Ok3gttH6VYdRiVOz+CCOU6FOj6ypbq0Yq3/K0knCpgdir0olqBRosJGIBatR2JZw3IlJ38amgxwM1tzKn9Xoeth68/4lkJbgAtfEBsb9G4iZ2NZEihBDmsxBkaOZzRBTNS4itlyd8jZssqtLY2z+joa1jrnWsZynSNEOLjaHE/XQHIkGc495w3TjC239xXKWjpT3DX6Y0kGq/EGDkbb0EpWE5LVmvaNUitPCpdsAGFr1xifoEWAmKg2H4hIZw8FCs9TrDD84Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966005)(47076004)(81166007)(356005)(316002)(4326008)(6916009)(86362001)(8676002)(54906003)(82310400002)(82740400003)(36756003)(186003)(8936002)(4744005)(5660300002)(1076003)(70206006)(70586007)(26005)(2906002)(336012)(83380400001)(7696005)(2616005)(426003)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:21:25.7364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d59c35a-ce32-43e0-e35d-08d832e85db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.5.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I984a1147030264adbc02230e2e1dd416d4ad63b0
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 9504f9954fd3..6a42331aba8a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x34
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
