Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D01661183
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D01661183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2643E72E08;
	Thu,  4 Nov 2021 16:53:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5131672E08
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 16:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaDbr/Ttl/VI8PqnAu6Z45iIqho7U2O4iKbHSupFOVosBrU65aj2HFE8K+SmoZ+tbPBLHfq+aWOS1c/KZ3HPql51uJ3SCYRECc8CkgRczJjcaHIUyLQhq3h/+TS61ch5IHCXcRz+fyCurYt6mBH+B3/ju1RKNjuJwlmBNPG1sE2NfMZya8ETXb40okjavjawaFcNXSrqlpkOurtsydA9zNgPnZhB4OrK93jf5QvjobYNjnrnpn/MrlkbRDtXq+3zUtHlMKQx9oyfWSDSJiZPAuRIQ7nR2p8jtsKGVjogao4L/kao7ywCDWVikqoQhhwKgatO5NUETEC7nHZoWdLJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZuPin92Uv8Q9RK1XTh/oCFowsh4QB5d8LT71Or/nU4=;
 b=HKbIhECeMcX+YtTArPBC28K7LDmA/vIkB/vG+Xfhnl3KGcDCVRnhGznkSu8JOjZvqyqXu9IMe6+TyRbrCP8xJEMOrK1AK5tBzM/wJ3JebL0I/XKZr6cWh0xzixlu6n5FbLctHudDIOWZMvwCmfXlDCC5xF04puAgXR6Od+AiwSuTgl0CCYVp1xlbhIrvm714KhpwZiKRQv8GqnK6+USuVFKaV9qKmYuB/cOELZVAndp8PaR/RpldxdSIFuL9nqIs/oiTCUP7oxYh+caHON0wbzH7xec3WkNjwcSn5tYCBNGLaijmg7Ay7Nm4646Uj7Ln9rUXKI1OC0om/2gBmbGcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZuPin92Uv8Q9RK1XTh/oCFowsh4QB5d8LT71Or/nU4=;
 b=Kg9ack6PxKc8TLlh0pwobeCd8cMj0wWwvxhWprih/XhlyZCeHTtGL2bzVW9iED0BswTwFYTYC+XMnX17XJEWwPUYVBpNFVqVZqc8PiMLS3BaEYtEdn7SABhyRTb+vXBdupKmXO/6bu57HMt4ov07ubagMWJc2lCQBeceDT8QSls=
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by CH2PR12MB3960.namprd12.prod.outlook.com (2603:10b6:610:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 16:53:44 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::dc) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 16:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 16:53:43 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 11:53:42 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdkfd: Don't sent command to HWS on kfd reset
Date: Thu, 4 Nov 2021 12:53:31 -0400
Message-ID: <20211104165331.26614-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6400542c-95a6-4063-de27-08d99fb3a932
X-MS-TrafficTypeDiagnostic: CH2PR12MB3960:
X-Microsoft-Antispam-PRVS: <CH2PR12MB396035D4CD1F38D5427350E6F48D9@CH2PR12MB3960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hWOsPvATCJr/8JOo52fzm28Sa9yhB8ziZ0IBBz3QPfWG28qTO5pJcdeK61E03zdQVjhtEn+6V8wYM4izRXf6ZSHyOj63a8YPhTyppDOLNWApAX2Y1+oynjwjYJiArcrwyi4i7mdFnf4JcAW27V5NIeA6ogZ/DPZo6m/uYk/h+BEFbch/Xm8KV+BFXFt0fIWtm7C3d8K60Gt3Ys3mQ4mSxU9PybXVcI6J82uYRqtLF13wOLe6A03wMkU9esBOQrhjvZtMFHgKcgLhJeIP+naclQZvyFSXs8GvMeXIMGTydSWvszU5HkCy/4DXJQcXt/iwN8iv0h9aPIrsqxNT38ccw7AlCwbJjM5cEUT9EfnCCgvVMJjm7KTRtkxXk26jPo8yKhqzGOKDGQ90n/qvGeHtkUJbQbCbWI0HXjuNoFDqkbTYaZiDNuFiCyjHsTv83X9XpqFGGUAjbRTbFNYg/uTlXjyshNvJu4pNJ9iIcAojLXQ0kgaGafCz3eF6xL9C3E92mvEh0hgt5OUGupr4Ht4tK1IWwoTBfpvPsjrwdk/OiJru95Fv2da2+TYpjvKyvp4GXF2qzfJmktpaUWhNu6G+1DxDVVv8J30wTNMEzMjcUoEhnj+u0rpBbQ9IcR1P0f5xDuGX6r2hjVTIKoz3jgdJGeSBQOgHfyqtZgfyxLCs/HLdlcvqADeqwXUFEpV2am9P34wH2V7klgvneW3Xu2kiXzD8FfXKg4iREoPdbdqUF10HFEmp3YuP+oDpaBJ0iG5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(5660300002)(6666004)(7696005)(16526019)(8936002)(36756003)(356005)(186003)(82310400003)(47076005)(508600001)(2616005)(70206006)(36860700001)(70586007)(336012)(426003)(316002)(83380400001)(8676002)(26005)(1076003)(86362001)(4326008)(6916009)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 16:53:43.5381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6400542c-95a6-4063-de27-08d99fb3a932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3960
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
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e9601d4dfb77..0a60317509c8 100644
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f8a8fdb95832..f29b3932e3dc 100644
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

