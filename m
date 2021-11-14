Return-Path: <SRS0=NSSR=QB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85424C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Nov 2021 17:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDCD608FE
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Nov 2021 17:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DDCD608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D9F89F55;
	Sun, 14 Nov 2021 17:55:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F0189F55
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Nov 2021 17:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e94TEz2EHXFDrCRAOBev7qq0MMyTtojHk8wv6MlIslIHSbHb0qTf956oHHxy/okFXCaKcSmMMk0OSjRHGjQqDrwATN8Vy6fb+EdcXuB6OztU6/eIt2+SN7Icv+UIDXM3Z0XZ1zbLCyH1AQ6vKf6mcSi4QuXsG4+ym9YNYD2xFZVvKgcpEJl7837rQR+RE2sgvDKWZ0nlq34a5wxeM+Nj9yRa+mskW/YzJDOqG+kkeg+SB32kki/7zw/hPVR8x77U4L9ZasYxc6BzKY024+W4Uslf0/d+7XCWbWHBKXWpPnFdGuii0xbbYMRSmHpydDT5ncSiwSuoDHwf0B1jWbEV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdDD2XGU/iE43/qfES3e+LbqMPjxkLu5oKIpZrhH8Cs=;
 b=XaFuiXcHhV8sRddC9GwQWCK1rKzGGcfMrWQubvnH32qJTk6Htf/puiw742s8CXYeHOlKSPGC1vnBJjveI/wFmP8om1raZARnlnbzUdho1JMzUxcprwOrdTySU01GlWAOKB7ubaTqPd2iMvPwg6YTbsIZJt6Ubbl4nJ5wo/wUq1P7nvy5u17d/8eg9bATb8Kzg9F3Ze/9kbSopIDOhPmVAnnsEcn+Jd6q+WVpKSNa3nQKIzfjppuSTFv+6Ma+LD9l14A74Tn6nsYIH2UlUNH6V8IZeROZcFbx9E2Q6qAg6ajzwaufdW93PtO8iy9TuzccHjztLMGWaJB++rfLHO8/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdDD2XGU/iE43/qfES3e+LbqMPjxkLu5oKIpZrhH8Cs=;
 b=uVi3XavGNIoB0i+a77vtJJpq1Bizyy7jsO21PbzHELLdZqF5TpouHdiJ5MLxZkmFAIbWJWcoakod8KVYfc27AiuE23hbz/pAxPj7UfohN+mY/EJW8RUCTsxhmpWk8Iy1P/zumfWZB7VrDGFTZy/yVyjD7XGtPYi8aNzvWIcHXYE=
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Sun, 14 Nov
 2021 17:55:18 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::42) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Sun, 14 Nov 2021 17:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Sun, 14 Nov 2021 17:55:18 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 14 Nov
 2021 11:55:17 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and been
 triggered again
Date: Sun, 14 Nov 2021 12:55:03 -0500
Message-ID: <20211114175503.10197-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09f0157e-e378-45be-a778-08d9a797eb78
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB183338FB6A5B3C25230C2185F4979@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsvVu6l5um2TdntDqxjRpcM8SZpM9lf0zQFuO2hULxtIBfhV2dj3WSGpP0883FBboCCWFXdTR65OBW9s+BBbqGcm0hilV20yUJd6Xzsp6gAkPlIBnCoPvKPPpSOMGVRR5rBe8ZS9Ww59WssTQMGDmFYOseIo5YFzQ+sldCJD+SKxsFbfdqcgMeb81dS14cNv/J0zImRIrQRZwnh8PqOMp0jw8I6uwDjK3mkVbdTrry5pCY0DGzt9znk+T4OSw/eIKvqqqtzd0gdQjfN4vuGwYH6YQrakAYim7OTsvKCHKw/jNd4NZ30S+V8b5i+1Mx6n+EoFNUGnQNZYjk4JS1bSVPgQo4isj1dQeNUFtWtZs2A19CDCgGVMUdT26woohUhx/R1F4SZBspn6ksEDBWw3CuVDxYP/tKqz5LGCNp8uAvpd4WXvcL/J/7t2EODKRNLwr0uSFR2Pe6XyZ9ndDhciNIojBxnb9efpwVlelCf+rLkgrjjKcSutgGgarUSL93kngBb/q9AVDx4VDZy2UeJvjythT9h8777QRvIm7BsjshkraLF/ynkvaQHrb0NwDIrvHh8bN2Y1hrtoFZSPxiOwbqViCyo1KyYueFkOBOTPElL4Kheo0WOu/RQzwvWG1yn5k0kCD39wjTqjkuX/X4kwCbPoS0piIjprRnOqKSlW+wiNNGZpJ5XzRW8WCrNZrIzVfBd6SOBSccoYUgGzmOhin8NzybO7WEyrj6pK8Lr6w7va0jKO5/ugLlVzP3djY8LSo8BR+waNwxyK26IAuAx5Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(508600001)(2906002)(186003)(6916009)(4326008)(82310400003)(8676002)(70206006)(1076003)(70586007)(2616005)(426003)(26005)(83380400001)(336012)(5660300002)(8936002)(16526019)(6666004)(356005)(81166007)(36756003)(47076005)(86362001)(36860700001)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2021 17:55:18.0509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f0157e-e378-45be-a778-08d9a797eb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV configuration, the reset may failed to bring asic back to normal but stop cpsch
already been called, the start_cpsch will not be called since there is no resume in this
case.  When reset been triggered again, driver should avoid to do uninitialization again.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 42b2cc999434..bcc8980d77e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1228,12 +1228,14 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm->is_hws_hang)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
-	dqm->sched_running = false;
 
-	pm_release_ib(&dqm->packet_mgr);
+	if (dqm->sched_running) {
+		dqm->sched_running = false;
+		pm_release_ib(&dqm->packet_mgr);
+		kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
+		pm_uninit(&dqm->packet_mgr, hanging);
+	}
 
-	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
-	pm_uninit(&dqm->packet_mgr, hanging);
 	dqm_unlock(dqm);
 
 	return 0;
-- 
2.17.1

