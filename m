Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5B4C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 20:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DBA10EE75;
	Tue, 26 Mar 2024 20:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gO1uGu9E";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A192B10EE75
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 20:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Qm0ULwIw+sKm8iZtGreVd6ea+jR5FvakUErWsEvn+Y1y+Z+KS2c72XvPGLoBQ4dnspB4hXUGIItwLqWgdyBwrOsBTy/cMN3xgZjCJZ7elFJXdR7pTp3QDN4wM1sZrrPnOBXNishCDxU6dANTUy76kXNSFPGPv1HbEgf/e7blUGIJO8d7sRb23NHhWF3pcQdyPJ2K6sfLi845LmiaZDE8QU0dM82FDqRnIk+nYV9JhuxsnN7/uEUevJVNrGLUT+hmBfcG7tlrvJzm0sQf6p+ck28D1Lt6ZKbGo/A3BDy2ohn0mZluqSkwWCgeAHWCn7B+zxrqPgTE0OvdWApmwTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkBwzsK/WpIbvP9LHSOX1s2egMhJv2CQG5nYEUqXcXU=;
 b=SwXxYPbCxB1CkJodIqCIjhdPsqwSENRKONPOIsYz5jGLHgW4YhP1i4NmRd4U3ndnUtfIySdzOrRbXGNjCBDbMVUCjHL9ecC4LQHwbbmThVl7Yx1FwVb3Zufj+7gNJyD+3cpbICGBD5hlxtcWmAvjCDVLFEG3Z9jjOia1grSdCd/1W7rXv7WczUujiGOX79RKwsw4ePaw5fQXPqxV6oY66cYsTrGNP8HMkSRvR11bYDj1/cHpifXb7Pi42FsLQhkt0bAuO4njofHXuEacMWhszYqKxXvCVN8/8XPQZ0YU5HQvCjwtXnZUC5c6ABFyMUg06NEAiEV9ou2KQr3OM2QzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkBwzsK/WpIbvP9LHSOX1s2egMhJv2CQG5nYEUqXcXU=;
 b=gO1uGu9EGHtxm4Td881w0IR5nWuZ6T43HN2tVHY4cX0UZ4Z9MYOanzpDbOu9yNaTSmygpJJ8n6fI9CMs+kQztdGyb6Pkb05zRJddV7vWlzPXDM3xAhEkql1qzQt8nuUBGMgcwHAWVIXSixDdhrN/LnSda9GCdTjGj9fqASH8L9k=
Received: from MW3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:303:2b::23)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 20:02:22 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::ea) by MW3PR05CA0018.outlook.office365.com
 (2603:10b6:303:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 26 Mar 2024 20:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 20:02:20 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 15:02:17 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Reset GPU on queue preemption failure
Date: Tue, 26 Mar 2024 16:02:06 -0400
Message-ID: <20240326200206.100727-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 189c1765-4ee8-47b6-01e7-08dc4dcfa578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZtV1tDS46pBy0vlVzC1DQHonU2n6ExaEGiC1sSDl9v+l4nOEvfMpJwfUu6qmNT4C4BBIrPdpbbh+YLJHfW4xp6n4qb6L+7HlN/mD8xWhlIUY8I90JxXV18mEswTf/DhPanlrwiFfayZo3XsMi4CMN7veTDTIfAg90kDepPOvStYFyv3OHEnNb5/bXHbUQSE/cXWcIAQlBjT1wiJgtxJQ007Ssg5KroCRqr+vC6hOGOznma1gDEDLrVpNAKgfx7joOb4Qw6KyAWs+L/HBThm/8weENMKr7ZXaOzI/P6ebYdb8qPCfRu7SLnVWWauhtzUy0UojNB3WoXsUP+yKiv/Hom+vpEEypK4DmAOaC9aGRGCjUeFPX+e1k1k3oprd40Fi3sz7T2gpx+xcxO2nyfGAdta9aOZ4hZhGmGaXFXP/y/jy9iUhV5t3Kyv2XSTsfYfyFDOrOPGohksfwRgwMLWadZLlgG7NFlFnf/1H7MsLFgwDE+AVwvNZoUgZ4xool6BT8m9qyaF38NCOpFj/HsZoRCj6gO2MSlZFG+aWtqFghAg4VYmXskKejeDY/Kjq6L1Pnt2EzdtmTpxD3J742/xps1+gjmvEeRKoQUCifcLUg4ov32c9v1ewXEv1d7OcVhDo8V1nEHkZ4TYWx4Seal51mFRvuKlHhkowNZd2Ku5HlVghWdaU/+6P7rpK96Hgv/bQq4yseW8Zh4zdbRYqFlaFw+Wf1/belygY7xfr5DzT3aDmtIZS+ykpW3s4gPbB9e6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 20:02:20.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189c1765-4ee8-47b6-01e7-08dc4dcfa578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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

Currently, with F32 HWS GPU reset is only when unmap queue fails.

However, if compute queue doesn't repond to preemption request in time
unmap will return without any error. In this case, only preemption error
is logged and Reset is not triggered. Call GPU reset in this case also.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 151fabf84040..c08b6ee25289 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2000,6 +2000,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
 		while (halt_if_hws_hang)
 			schedule();
+		kfd_hws_hang(dqm);
 		return -ETIME;
 	}
 
-- 
2.34.1

