Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D6460FC4
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50D6460FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAD57362F;
	Wed,  3 Nov 2021 15:05:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C03473636
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 15:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzcv7/ReWLqR5HUsNnUAIc9ULeJ0uPCxo6xQvIo5iDsEieQy1uhU/zGvRYXusMsH+Mgv1+3GwkVHwyBPEmiK5Qk6gsESHw97hdgGI0G35ip3lClKOAwnAqvhT4maQbsjAGjxCTKAH7Py2U92ea+U0J9C+gilX9GKKBXiZp8kfrNUE09lRxlHz/0zeXI09Oh14rOSTnyPVlVyy+rfM3+Wd/L9tLQ9c/J68F3fLJaHNkkbfZKb+pajHeyMsAyraM9iBpPyrNdeOMqDkQBtG6Nl5AKzSG2zyjNPegXKsLU5Q1ZIlbzeWLG1ZC2IhHStLvCZWPVdt/EKvr8QpBnlJdRhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CMpbS3mc2yD/4sHfG5rMWvpGII5vEs8ix26KXWcs1I=;
 b=DfHokK+g7qserDaNtxnGQojGIp8akb2avPqlnbP9etR0M9XWqTBHJIq26W6zah1UnWs8+9anwPXUDH+4dTYV1w9Gw0+aXvcaMkX6BfW6ru7pkYAjYfsTZBNLDw1fVrdnQNiozHzWZ9WnlA9wCNdnz4ICn3SP6vYoK+djLmKTHfL5HOxP7xCUuW1usNA0rJBO+uDJQ1PSVgMMf6H6z5ERVBeg39gWIY1tXmoTmdOoaDNQNlGlFoORdFpyOAXrqZo6U1Jzhjpujvcdd7Ib9C6+KyoTEnauSLmNdS7WfHcDhv3UBDyZkIVdEGvKdW4CZSnDfq3tmcIXcvYli6I0WUU9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CMpbS3mc2yD/4sHfG5rMWvpGII5vEs8ix26KXWcs1I=;
 b=rB4Jo226xmWKSTxU2BjpkhGfxXmX27D+4Tx5FHak2WyleDwhuuZZUVcy9VroS1KW9Nu+ajPNNoviwSYY2AMy7urrX1z4qr8PvvEofp+l8Gss2X7Hlmt6Qon5hCi3WitLB4JxSd/iaRT0c9TCvBIMxf6N3tO/CR6CDaQD0yWpUV4=
Received: from MWHPR22CA0069.namprd22.prod.outlook.com (2603:10b6:300:12a::31)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 3 Nov
 2021 15:05:07 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::f5) by MWHPR22CA0069.outlook.office365.com
 (2603:10b6:300:12a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Wed, 3 Nov 2021 15:05:07 +0000
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
 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 15:05:04 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 10:04:41 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdkfd: Don't sent command to HWS on kfd reset
Date: Wed, 3 Nov 2021 11:04:27 -0400
Message-ID: <20211103150427.18518-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c49676-383d-4a3f-384c-08d99edb5109
X-MS-TrafficTypeDiagnostic: BY5PR12MB3713:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3713475DA1CFFE2C09497CE3F48C9@BY5PR12MB3713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7ZvkuOhOZvaVmh4k5tGl84TpsQJSvpusDFbejQp7WcT1B3HczNRv0lxr9pO7dy0pPtuD02HGE9373jOQTVXNK6L/O7XDAiAZ/ONqUhlvfs/yNAUVsx+OWhE+YAz9KyGA2xuXpjQvujKp/wT/UVPXn12DmNay4CrGxYFzC2J6j+Zl/WbIplyuGJRBR87dT0jDDWSq2RBqM+uuCwinuf5jXfvz4KsbDHMoW3GtPXV3gci+lPDzKwWlV00WZyaYQh5PJQZFQxuasrOhjoaE07XVGdv9y9GKYvYFfjK1vYdihebdFDllJ2jrpUUcS0pHWOokb390MC1VeZljhg/A1apZth2cJgeTFDSdLtEtzWCJpkHruH6RHDvqzYucxYttu0mRdR3uMOxXk0AZhB2WvNqYJ9Oc8ukgR7fpyGhReqD3nvTrqX3kFj0kU6Q88i304tTb/hBsvB3Z2/ZfxNGdjQp7jIr9m2E2ZpvSH0OjZmgFKKfCymLw4ne3L5rPHagCnYhiT+IIyPPBoKt67fsBdYUBsJ0dQmS0hf2JtNRFkxlZLFwXV4ATIfydtkSQH9IcKcs1fvtTXb2ECQ+d0sU5CZAIsAKtUiSHKt+9nugfsL7qAsCs+OHrmX3xrA4kuEOowFiD2wJJDPjuKhGD+j0OzbNM9m8cHXuWL959JbLmjMj/dnJCuQ5rWMLhaJZAKxe7fX6biQMnVvo2VbSc9JcCkdTQt2aA+u2b9hsTpNpf1bKfEL49dADow708kA8u7MfV5ptWoGD+WeVDuiOY3cW+dBW3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(83380400001)(81166007)(7696005)(508600001)(6666004)(70206006)(4326008)(5660300002)(8676002)(356005)(70586007)(82310400003)(2906002)(86362001)(47076005)(186003)(36756003)(16526019)(8936002)(426003)(2616005)(36860700001)(6916009)(26005)(316002)(336012)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 15:05:04.2461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c49676-383d-4a3f-384c-08d99edb5109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
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

When kfd need to be reset, sent command to HWS might cause hang and get unnecessary timeout.
This change try not to touch HW in pre_reset and keep queues to be in the evicted state
when the reset is done, so they are not put back on the runlist. These queues will be destroied
on process termination.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 6 +++++-
 4 files changed, 13 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_priv.h
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdkfd/kfd_process.c

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
old mode 100644
new mode 100755
index c8aade17efef..536ef766d09e
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1100,6 +1100,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	kfd->is_resetting = true;
+
 	kfd_smi_event_update_gpu_reset(kfd, false);
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
@@ -1132,6 +1134,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 
 	kfd_smi_event_update_gpu_reset(kfd, true);
 
+	kfd->is_resetting = false;
+
 	return 0;
 }
 
@@ -1168,7 +1172,7 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 		return ret;
 
 	/* for runtime resume, skip unlocking kfd */
-	if (!run_pm) {
+	if (!run_pm && !kfd->is_resetting) {
 		count = atomic_dec_return(&kfd_locked);
 		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
 		if (count == 0)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
old mode 100644
new mode 100755
index e9601d4dfb77..0a60317509c8
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1430,7 +1430,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 
 	if (!dqm->sched_running)
 		return 0;
-	if (dqm->is_hws_hang)
+	if (dqm->is_hws_hang || dqm->is_resetting)
 		return -EIO;
 	if (!dqm->active_runlist)
 		return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
old mode 100644
new mode 100755
index bfe7bacccb73..e4bcc2a09ca8
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -275,6 +275,8 @@ struct kfd_dev {
 	struct device_queue_manager *dqm;
 
 	bool init_complete;
+	bool is_resetting;
+
 	/*
 	 * Interrupts of interest to KFD are copied
 	 * from the HW ring into a SW ring.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
old mode 100644
new mode 100755
index f8a8fdb95832..f29b3932e3dc
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1715,7 +1715,11 @@ int kfd_process_evict_queues(struct kfd_process *p)
 
 		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
-		if (r) {
+		/* evict return -EIO if HWS is hang or asic is resetting, in this case
+		 * we would like to set all the queues to be in evicted state to prevent
+		 * them been add back since they actually not be saved right now.
+		 */
+		if (r && r != -EIO) {
 			pr_err("Failed to evict process queues\n");
 			goto fail;
 		}
-- 
2.17.1

