Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC18BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A893A60235
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A893A60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0626E0E4;
	Mon, 15 Nov 2021 16:20:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1536E0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 16:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJtsj8e6jgcC9/2RjtxFyt2KtN92B57UGJ4LdyRHLrgeZANIFWzzEsS08nXjTOpYEHcYIVytLqLAAqK1ZsIsuOy6Z/GHCG1ftgooWx1HdT74Vg+28esDK3R6xtQn1++yXjTQyhtRYfsae4abcvVMD20M+W/S4dDCvwY/HBAuSw5c/p6n/DZajqf4zkZ/ut2RTvae+MYeajV5LQvsHN5uT5Mn2bhka61mmrJlFwa4XOqYSweEJFHc7rt34H9076tyRlDZi7WALab3IwQ9OxlOh+CIaR2/c7n+Uk5Ux38ACznInSJSCz2T+TyLasoq9K4Ob02jdNm59tZ/gHXWMaEeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGd+jVwv+tRUEd5AmEebJI4bpw3IMrJVDElM8hTzKYc=;
 b=BECEO459UtXpAHiPihlrOQ3lWiSf9pinbB8P+o1d6DchcCRoS50QfVwRwus8ApOl+fUy2LzKMezv6fLHlTL+zRdU/NKu4SF/gcgz7gf371kV/eQN4PCOborSYgGDLO+5GIY7Sm32Z2gO4Z+w9Eg1DuAYlqzmhp2CtKdOl3lgfGfwwqaoykUxXO8Om7Ev9/No0kShf/X4oobcg403PoFkBm7v84r+bcbD4LVDEotHp5fT29gkqFkgoAR1KEg8BPz+ygNAVXDwNUrQwg4jZwCcDvvdXz6pzz9wQmWS63fCMhAcRpfFGx9DoOi1ryCbmE5pgm4eWJIm1UY6xtR+cFZa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGd+jVwv+tRUEd5AmEebJI4bpw3IMrJVDElM8hTzKYc=;
 b=xsNR2hs1rDDzX8O4aiaZONkzd6apWaT6BtRiyUPZOvmhLc5n6G/NJ5xopdgD9CAgcGUGfAd5uRbbIRGWtZ6pUYpJHLe+wiKrcvbwDvVk43ojnPuB6wT+3opnxoZKwAFDTfqG0FsJYSL6gVS3aq36MuEdkxCg72wRt7ZSwjrG/FU=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Mon, 15 Nov 2021 16:20:36 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::10) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Mon, 15 Nov 2021 16:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 16:20:35 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 15 Nov
 2021 10:20:34 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and been
 triggered again
Date: Mon, 15 Nov 2021 11:20:21 -0500
Message-ID: <20211115162021.23856-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56fa28e7-7f49-4df4-2d3f-08d9a853db10
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2472659279FA196E96924D90F4989@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UResb43Blswr1wtK/qixCYdKm3EiTNWfzGUt7OG4GRS25yXrmTYl23pfneTkLctgjNu3H59YQ801G9uXTb9GfA50HXfSbqGTRrTxCrAajZtFgFNEplJ7nyzWM0aORYxKE7f0oG/wV+IphsVr2lIxACK5cSxstdYbTBAwvhWudJ937h8XcvHgk/au/JYpiNHxDuKZzA0xXi7OyLpLjVN/1Z1M7Wchliu/6687bDUj3IH8GxnQDQUzKVgS7XiP8GUqXOIjBWniBmpMUe3v9uTcj6bKLnFD+tk0xCPMP3WVTk6WIerX/NrSWiF5Q2oiVayBrNtg2Asoqi5jNvLSvIRWZsvGlruF8BVUJUBhw8vDGvFrVPJZ/JfPQ42mNkpCKPBzKlXbF2lXYYjTT4SD5BJGGnTAnqJiGQAx51/MZFZZcIcUCijqcjQSThJCmqe9JUeKGd8J3Uso0F6MN4d6+tAi6kPbn/O/Pz4WXG7l92hd8J1oPf0HeOG03WOUwQHHUgttM8d/AoOzr9MQbLNb2/D6LMmNdDYKCw3lT+La+pJtxC29rGymp5sE37K0FRaY596akTLfh1q/xdRJgCFs2xdp3jer3uIaHf0soMaZvbDyA1WKt7xYTcnJPRHD3vEeutaBPWHX4iTf0Pm/+AkSb4j38htnj3F+Mdb/SxwtZvDw37U/H23DBF9nqbjbxQorarAC6fcU6rsYjZMjdxtF7OzwWXkD4tpB5eCJYOmp90d/fXvWNsVCQxCqEc2Jo/IePdDxT0iwip5ua5TNdFlRhAGe1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(6916009)(186003)(83380400001)(2906002)(1076003)(26005)(82310400003)(81166007)(356005)(8936002)(86362001)(316002)(70586007)(2616005)(336012)(36860700001)(508600001)(36756003)(70206006)(8676002)(4326008)(5660300002)(426003)(6666004)(47076005)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:20:35.9578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fa28e7-7f49-4df4-2d3f-08d9a853db10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 42b2cc999434..62fe28244a80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1225,6 +1225,11 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	bool hanging;
 
 	dqm_lock(dqm);
+	if (!dqm->sched_running) {
+		dqm_unlock(dqm);
+		return 0;
+	}
+
 	if (!dqm->is_hws_hang)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
-- 
2.17.1

