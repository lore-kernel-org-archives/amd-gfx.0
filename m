Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD26CC63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 09:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909EE610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 09:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909EE610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD6E6E8FC;
	Thu, 22 Jul 2021 09:25:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3236E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 09:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akTi/RZuw3XVfhI0+RRpflb2ALYgk3T9dLz3Y6Hy+4KHh8+U7gfxQtISWk1ODi1C+XVgx6VPOWf3Ng7GqAiggiiWs5BIHa7OsLEApwH8Bw4RrOr3SQEBpygL4fOi8A/dLRrUybRjaoy2sT/cyEhYwOVR7THLacsMTjaFts+aKXjcDYw1fDG5uamIZPYu9yQ2wZL2zrutkzEq/KkPozFe0VgvFBBieK5U8u/rAzk8klZQDsUMGW6OcInHc2IKdI8Ju9DOyZxah4PASoGrxWaZD1nCSDnLKcmWXrHmt8TPZ/as/dSEKvm3fNkFoTlkVov/zSv+F5C1Umcg95jHci7X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvJ6TcDJjdDa/jfLScZBWpiJO6uNUkfAAgIktr3mqQk=;
 b=gTCBbDOmJnDTmn8i6r28I0x7AE8U8o0csM6qfZAkeiWlClqDkBrOC6YndnWy48VYJ2w2JFUdzU3isrLKXkgWshrIx+HXefY5sZFf3UxBEukPvcRCJzoYLtiOO2o6lPQdq6GbBFzPdir/PnFdJlCM1s4NCH0oTuI45hvagTXkoCV0YO4mMjNuY9a1YuUYqbew0+3UxuBVfRtgrFq9RgsmNSEZlmUKCWseo/Qcn1wHiNr8iUbcIeXSrHtBPYKDPWIkmRxkT1d4NR4wzbxrBe3HM0B9fsl8SFZ9/qOJ36UYaExyLCsV0SSpXWAj1EKUfFwhq376iiZtg7KkaMOlTJJYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvJ6TcDJjdDa/jfLScZBWpiJO6uNUkfAAgIktr3mqQk=;
 b=4TXju+9UXzS7uH2LQrU7AePP0NTuYF0+m+yEM3yBajkoTiSVNNF7Rr1VJj6EqNb7jYr95ZYtYdN8lnmrT5jJGAjCBkkW1u9rIuHFXoQdMuye5y8d29gJH3k3XTMY0tu7QvCCaehs3Tym9WncRN89VZOqt16l92ZZlZJdA+KrZrc=
Received: from MWHPR22CA0036.namprd22.prod.outlook.com (2603:10b6:300:69::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 22 Jul
 2021 09:25:56 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::3b) by MWHPR22CA0036.outlook.office365.com
 (2603:10b6:300:69::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 09:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 09:25:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 22 Jul 2021 04:25:53 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <alexander.deucher@amd.com>, <luben.tuikov@amd.com>
Subject: [PATCH] drm/amdgpu: fix build error
Date: Thu, 22 Jul 2021 17:25:37 +0800
Message-ID: <20210722092537.27624-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3b45ac2-5c1e-458f-7dc9-08d94cf2b50b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045C221F6581A23CC32FD3BF1E49@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XufiXzCGMJL1Fmoq8TIvr6f0oPlzR4HWewbHpUhdZJUKkhcRhQZrV0TANkl5xexG8rwMizmw+5wBw3SwbiPJmajJi84d/P/gQHS1s59ZkPqpiZfeltw0My8oyoTXUqa91DPXAeEH9hBFdbZiWyIFH4Qw0Zm8SimcLfV/rEGc8AjPNzVJn3f8NRokM5mV3y8YIqzmSMPj/oghpS22J5hWE5yNWU3kvB6fpI0Bx6UckVNyj/KDq95njZ+8kaaOtX2//PyYf+qAKbAltkO4nEZnl9R0eRyR6kqcWLATj1UT2k6Htuwa4zgocJ9SQ00EfIH1qr6nsQ/NwO+D+2pLYeRuKUHvXMHDVaiZm2Iv0kNQdqIt3WGNEsbtl8gAIWzHwAEX0iUQU9hMKtrOXJdZ7bmUSfV2/UsCHeh2uTG9VgPfZ1mGz9MzbM5XfjQlWk/7UrX1H0/S2omuZqzj88PW3V7tt+zrMUcpEHWxOq2NxdMtmv1FMez9h05uaRwZVeF1FzHM3EZlO6b5274Bw9M4qVhbtuvR7agqlLg2Ibs8/qw2WW/7iH9VuJ9ay9GonI4bK4bZu2hk0lIxCAkDOdF/jyDiBV0Er9vor7pbeeH8JwEy4yONQedWUAi/xnD8e0gOj7sysArfRqeHjtuBSZF1nKUl4CDe0qHRFBl+3yOUyWcJBkXWzOxHuwv9Ab6XRVOidlHVr49J3hyJ9ziNIxZZ8ixirCuo30kDDhCrZoJsmkGMNZo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(6636002)(1076003)(36860700001)(186003)(16526019)(83380400001)(82740400003)(70206006)(47076005)(5660300002)(478600001)(26005)(82310400003)(81166007)(7696005)(4326008)(70586007)(8676002)(426003)(2906002)(356005)(36756003)(86362001)(336012)(316002)(6666004)(8936002)(110136005)(2616005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:25:55.1152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b45ac2-5c1e-458f-7dc9-08d94cf2b50b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: In function 'smu_cmn_send_msg_without_waiting':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:259:15: error: 'struct amdgpu_device' has no member named 'in_pci_err_recovery'
   if (smu->adev->in_pci_err_recovery)
               ^~
  CC [M]  drivers/staging/rtl8192u/ieee80211/ieee80211_tx.o
scripts/Makefile.build:272: recipe for target 'drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o' failed
make[7]: *** [drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o] Error 1
scripts/Makefile.build:515: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
make[6]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
make[6]: *** Waiting for unfinished jobs....

Fixes: e070ba49f3a7 drm/amd/pm: Fix a bug communicating with the SMU (v5)

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a48f18932357..a0e2111eb783 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -256,7 +256,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	u32 reg;
 	int res;
 
-	if (smu->adev->in_pci_err_recovery)
+	if (smu->adev->no_hw_access)
 		return 0;
 
 	mutex_lock(&smu->message_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
