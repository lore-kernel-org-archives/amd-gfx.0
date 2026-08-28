Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E965C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A32C10E44E;
	Fri, 28 Aug 2026 04:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8+8mdC+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFE910F233
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iem/QzJlc4Q97Le//iGhQulivn3cf2+9NwLg90kFC4HNsfkbQ9+r5ay6/X4AxjADkx7XBZm/1nXXHdy9KGPRF72ZZEx6M9hfC0D0EEjECqBPBG9ERxbEUWgQ/5a7dRofWXf9HZGpcXW4w4cyKrxVo22MdpzMYkE7wCo5JnKzFBdpRCTwy120jo3IcF6yk2ULeAUA43NwQ9vhRkXMJeFIkTgl9yQ6s+llR5SqBp3xs7onwBuoOt4Qn3VScU4JIFZ3XRFe2FKQh5FXKpit0Uif4DVzwGpgupqHXYuRlxywe2cQi/3KTTmyXbX4lZZFN98FhJw2XKBlDi/4HyZMr4OBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkJoMMh8fZe9/qeFzI0pJqDfcr5efaO5D/7mePV/DmE=;
 b=ZryDgVrli9cNieaCXPEJsHM0wtt2jMHRoBXrfsj2WF/eFbCAjZtZ41VH8JkSwfO9Do20wg7FtN+5g8FBm6NnawI7g42Ryz3693Oy6yxpmlMJXZrxbDfgQx4FNzqXlejmipTIv3o3KBzS7BThKslvVAcrF3aHV+hDXBVdQmf4zg5j3ho7akDAzqVg7KDRnI7gK7Gzli1wcxObsi42B+6lW4Vjxm03i3e/HgQyMaLtIOJcsv94mR/AMuDJvy4O7VzlA17f7Fy+/bMZUQHpjeE4tVpvAfrzkAVF1eih0jVBhBRxTffqzO+pG9ZgZnz9IZgcvVyHDQXFLpL4Mm+BZDWeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkJoMMh8fZe9/qeFzI0pJqDfcr5efaO5D/7mePV/DmE=;
 b=i8+8mdC+WOBBlyiBHO6tI8mPRGA6bJ5fMzrQq3rxUKFESlD/AJctTplrHTyDb/RibDM8ZkgoliBVS8KQEtePSTBIHz0K677cwouVEhGa5bOAfGKGGgTFUXsGgPBgfSbRWhsRCjMIJOqnQ0j3Hzs0Oc1VhR/IU0sUEkGiw7YtGoE=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 04:15:47 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::95) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 02/10] drm/amdgpu: add update_mqd callback for queue MODIFY
Date: Fri, 28 Aug 2026 12:15:08 +0800
Message-ID: <20260828041537.3464782-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 26718418-6919-4115-2bbc-08df04bb0950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5vHTZ6P+O44mxqcnKDpLGqVNLg9AANQrZUaypL6nI9tRGOJXZR71R5amzQoWkaB4YXf9lYvrWGVpeGCNwZClm+3xqTuzfKtF3CaF/jJoFcI/K1yruvo9bi9QPuEq8PvYjpBLPsuIcmgUKKMWdvQp4Id/F0MufZU47NCYz06D439jtpi5JFzKnEU/ddqLo9yfTUapKg/7fi9P3BLQeYBeNePlmYGs1mM114wiCK3tL5Fvsa49w9bQDyEk6oZgNs2lCNbhuBKojmNqJvunK1NHV3849uJqqHm1+IQ5+a7kjCHr7ydqNvHBQ7nozfnamMj73Tl0uPMY23J4TeDsQaoLBucN4EK0s83tVmemtRdlh7u+n/Kd3mZWPwE0Tji78Q06X71plVEIpr/HWwqzegucnQs2uPRO2C3vgbDtZitGRFSoLsWMK6n5KfhWHeTe62HVjLUZnbLjPt4t5wwKucw9zwv4l34z7NnLta4g0bRy+4Dml8j2BKZz4sjeinG1smkvKGEHLtzMcoUEpgwq8GN9Kf/Am97k2HlCAgpo4c15XN71ivfTzJTErYl2I3Q0Ar/Gu0egn/iDItCnLR8SAj11ET0+ZHowXDjVb4wjeSPo8fuQyr+e6I5Mkts/qim0A7YXR7f8LbH+T8GjxUuYWtHtsl4Q+oz4IbMRVsKktZGlOOs51TTbydpMQn0AGSf71CUYZ+Xjcrk5FdJkNQm/Z1BJ4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yqbBjx0uGl3whwGkuskwrY/BUKSG4HgFMNP02D2Mm9LgIm+Y3xqwxw2WrxDrwgwVpIiA1FNY+qhknIY3r6/Fi+PbQOkB/UXhe9AGcQfq5o6LywglVxARBIxyL6VXjf3b8YPCwxAO/W6Z1prs/rfWRzg8JIVyJkSwnHNQKai5VJc6IOpuKAtJ/j+ug88eAHJUH1fi9R5C7Wwe7U+ITYfczqVKFtdJPczDGXyjoATg0pSyZI1a4uByuRn7VqXl/YbOBuxCtLFTci1hyu7Pf12+gpSZkovufiCMf9LA1wdYN6YyTqsjjJbKGl1uO764FxJAAIHsI7BnhVp86ERM7wyS8eOZ4/GDbUdOIE4FUhGspF0oKTPr9NTg22yIAbNaCL92zWgV88vSfvgqtKT6YdPgHvpPkA+YDFN2IJVrrjp9srjaDs8jrDXXmVk6hYhkKe6a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:47.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26718418-6919-4115-2bbc-08df04bb0950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A queue MODIFY (e.g. re-enabling a queue after a queue_percentage == 0
disable) must not rebuild the MQD with init_mqd: init_mqd rebuilds the HQD
from power-on defaults and zeroes the ring pointers, discarding the state
firmware context-saved into the MQD on unmap. The re-mapped engine then
comes up idle, drops the packet queued while disabled, and wedges into a
GPU reset.

Add an optional update_mqd hook to struct amdgpu_mqd for IPs to patch the
MQD in place instead - preserving the saved ring/HQD state and forwarding
user_wptr into the MQD write pointer. KFD already handles the same
disable/re-enable sequence by patching the MQD in place rather than
re-initialising it.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 63670b41c26c..2f73eceea57d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -500,6 +500,12 @@ struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	/* Patch an MQD in place for a queue MODIFY: keep the ring/HQD state
+	 * firmware context-saved into it (init_mqd instead rebuilds from
+	 * defaults) and forward @user_wptr into the MQD write pointer.
+	 */
+	int (*update_mqd)(struct amdgpu_device *adev, void *mqd,
+			  struct amdgpu_mqd_prop *p, u64 user_wptr);
 };
 
 /*
-- 
2.49.0

