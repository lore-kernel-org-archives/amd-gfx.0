Return-Path: <SRS0=NSSR=QB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8CC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Nov 2021 17:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4878A60F70
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Nov 2021 17:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4878A60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7E889F3C;
	Sun, 14 Nov 2021 17:54:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E6D89F3C
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Nov 2021 17:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boBSyAz4K/qiaQmoWbcvoBIocQLvzk2E2m7obiOU2bz0qKXWEaTtIf1IHSiyzTWMcw/1DXkQebEKKJGGGvHdzdv1S4qH5GD+2qYBkbuyRRnjDS/uvOi6nw0+mOGPipzoEqDSUYlj+KE0R7hRGcFUXGw8duhr9R4DFmpUnb2qf607MasDqaznHjf4vOkKDfZS3DN/vtYrwpG8GOqup04j0baymCc4h4nbmvzYfkh+UOoZ3fN/FqRSqR8NAkjRFiIXB8hLc7PjI6FquuX2WwQL6UrBfhQQqn0hvJjZ8E/0twh/hLElgWfs94/ihN8tDctnTg88az6Yeviy8soLnrVWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdDD2XGU/iE43/qfES3e+LbqMPjxkLu5oKIpZrhH8Cs=;
 b=MBMN3ULkFcnrkR9m964TINq9CCgk0uK4+9LoLFQxWpALBYZu9NrNiBoPQ/YV93w3oUGbwFnBQxq0fSC+t0p5vp4IpWp4XJ2oZ0elolyDjyx4wdpDOFKXk+gWvXgoxnjFgGeE5kKO35vGd2dMuTexhN7xjoGh91RBW9xkzBdFm6lQ3wRbe6WELnS3CDzDRjnyqx12c2cXcPzGSgXlH2t+Ur8jrfeRyJejz2/jsUcLsre9A4bUpXrYQQQ1xdyqgYaCV/DgMFIE82NWdZFapf8Bbql91sv4ha4gpuBd21eBmFaeugUe7kyTEmp+Xvrg++25VqETiRMFdwIINSbiTeNdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdDD2XGU/iE43/qfES3e+LbqMPjxkLu5oKIpZrhH8Cs=;
 b=F9DEy3Ne/LglUnCgUFIGFxXbhOF+t/kNLltE6l/1PTuuoeGKHkiZFz+oW8Ad9RMz6+3AV3KIr8iE/7Nntd9zLAiTZr7LAjRMg2M/TTYyW2hxfgZyBenAbRwEdrZ80BZR3VnNgzm2dp35XH/9yu318JhO/azbk7vL1TbyYpOQUDQ=
Received: from MWHPR07CA0012.namprd07.prod.outlook.com (2603:10b6:300:116::22)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Sun, 14 Nov 2021 17:54:13 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::b0) by MWHPR07CA0012.outlook.office365.com
 (2603:10b6:300:116::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Sun, 14 Nov 2021 17:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Sun, 14 Nov 2021 17:54:13 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 14 Nov
 2021 11:54:12 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and been
 triggered again
Date: Sun, 14 Nov 2021 12:53:59 -0500
Message-ID: <20211114175359.10141-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e21fd19d-d0b6-40f2-425d-08d9a797c4cd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1515686325F4A14F40F72A68F4979@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh++PVhbRILnquZwHuZ1k7R/P6dfbQbr0yHPJ9ML8QQyhPtW2Of7fo3yDCxYj2efExbqzYhKcu7UqiL9Xg1cvTG/92q3Wcuxz3B9IN70ZOR+hewRVPQoLxHQlxqpTDb5lpd3P5Y2SMlZpRT2Q/HLcEwTo3LQ3FYplJK8PufwDBe4M9r/vf81TYwpaNhUx7/+EXTy+FS3yOrPnAcGLXpGqCSKF+J5iXkIIephCBPPRrQVnzg13jTu3+Tl5t4YUy8Bp4HI7hiFnhnfp+HGceiYzhCSq49RcT1DbEDjze5DNG5GohA92FEg0L//+Vy+TfuI/aj5CbXY3lWzPDwNUSQtSvgUxIfZZtlj80Yu8mTRgTLQf0Pt1z8KlhYeQs5fHpOignBKoTWhMzEis5NaGHtZQdSbsHgXlZ59PUp4XshzGp9YbVgB8ZGNoxbTJDm43Re1V2Y85dwKB5jz52jTkpONHYWte4SwG1T5LyMnnLHGaA0N46LOm8ncU+85g5ONnDo4/ddTfgixAKsu0UXVnCC4FOm05EWAnY/TaV1c5Mc0+TYYIIxTFDd2F8S04X8zaGMUaMp4Gp8i3B5ynE1ueulemvb0aLwUhtagkt9TvBZu5CkMEhCIg/Jz6hTKoiiemO33CB7AJHIEOR3vSTWfbfeI7qu4jLJrSA+Rng9sjzWvsc8HAsy0QlNypUBT++OSPDm8trIF8dduJPSSq8ZlTlUQhyXe9x2gSL/+hkZV2jZLrZVvcADEM00nK+beWAm3W3waBU4XywCDLrVwgoeANjOO+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(1076003)(5660300002)(186003)(4326008)(8676002)(26005)(86362001)(82310400003)(16526019)(336012)(70586007)(70206006)(2616005)(2906002)(36860700001)(81166007)(6916009)(8936002)(83380400001)(508600001)(36756003)(426003)(6666004)(316002)(7696005)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2021 17:54:13.1683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21fd19d-d0b6-40f2-425d-08d9a797c4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
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

