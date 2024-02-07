Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2400C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 05:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E0610E107;
	Wed,  7 Feb 2024 05:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQ7tYKtN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E733E10E107
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 05:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KILq3DB7Fz5zg8MNQXVyhh2CY08FXPCEeEJ+assLrJrFlFjfeHYHvYc5XrKz5gUxpxyu8K/wNInl8oe1MI/iT8+OiLeP6TWqc1Flm4b0urgNbkSLbr6OTbPA0rY1tALpliv9ve32pAQXTH3nFymsaTQ4HOOT1xnMcviyjT5r92VxNwJw7/vnSrw6h+HRBDOMGifIj5W8BfWeKq6fhHQ+VvLRLBHHkkl43Ch2mAA/LzH4WFOj6h5mJ33Fhbs6aSFNGb1SgBsKGuBPsS7mG0qRDDBsQhdx5ChHhWxlR3eN1NtGZNfsDRunac/d6bosgNBWx3bpIT/3l+cjhhxC5hrG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QHN1lYV/nNypr3ze/RUlghImVbifyZPngQrwmeJepw=;
 b=a2Fuk2pHTQfl+M5cc6aWYL/nGUE4EWzlFQy7H/AeQzK4nRgaSgX8oZuXFBhMzVP1tT8hWz93FDIJO/KrWGRe14ET3DGMPIGD8ueSNuKuztQbYjbkM8QEePdX3uUEBgMGlsJxueO1B4aF14G83HF2Y/b/AmFIDcJx9cPHienn4OC1ipAwIYwiF5MC0GedPXY/1khQ0AdWVj4Oq8tVtItWcGutDNCkHihFXwjnDBaF3bCWrYxaA/4BZX7HP2ypT1DTlrQaYnQi+C5Nu3mhhh9nCEw0ji7RXht6lf2o19Q3snzbE6EEYaQoaylhj5E8/JwJw1mDKMnWT4tXSY8LxvRF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QHN1lYV/nNypr3ze/RUlghImVbifyZPngQrwmeJepw=;
 b=rQ7tYKtNh0nkuzdhh+Psxi8GcqL7tVv1wE6spHJeem4QMF7KQkf87H5pFOFlRH7f0drAW7l96kg/q/dW7KddOUkYYFPkHiTT14yUnRM4bTu48Ox5lGZuH23nnhwTsBL7l0h/XG/MmMkiC60kIk1mw7jb110zVXKg5h3N932Uvgw=
Received: from CH2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:610:51::26)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 05:33:04 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::b) by CH2PR15CA0016.outlook.office365.com
 (2603:10b6:610:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 05:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 05:33:03 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 23:33:03 -0600
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: <Alexander.Deucher@amd.com>, Joseph Greathouse <Joseph.Greathouse@amd.com>
Subject: [PATCH v2] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD topology
Date: Tue, 6 Feb 2024 23:32:00 -0600
Message-ID: <20240207053200.2903401-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
References: <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: ead89341-daa4-4fb6-bf0d-08dc279e4189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89OWbF1C+rMyiO8ZjyXwdTEuYwkTDF74AUdMQXiOxibq9Ahh7B2tryUHeQb4HbP9EulIDl3V4IiQYji7WGh7mHDccN0JE/v8dkiCQ6uSCYgygttoorL6Z8VwRNWCc6FYVtntQ7BqY7pjQVKX7zVtIfzq5/tlpXXevDb1L1TS4/OJ7a6TGjjNjcUPCHPLkj62CiHu5WLtAK3GFqMPJCZ5H3kALgs4vD6AACoIbbFT9nPBLXzxPHZHA6Fl8snmLwcNpaVUgYXWWkgzhp2xE1y5L8bkQSncoa5H8M2f/wTmIJJmnqFMI+LRw6HpphhbfpM4XlT6FJw0lX9k4+U5wv1Kf/xGKFkXUa7LZrbR6xsxn38G7ISC+Z+k8ojo6QDSvwbC65m9NpWh/2iF5Gty01gNmzGAxM0njgKUzgYCSoV4XPo6hLBnTQnAhScS/nhVN84YY8WcUg5RSvJ5G0YuceCv+BlCZXd+Qe5usKbC7tarUtiPGyM7U7CR3tMXe9ENoLWPeaoryesRfJOgcTlYg4lClTCAJKUQLBrXJXjNcfRPgSDoCjxmoFxQW5ODyr1takxlgsTrpI1QRyhYGU476Xns8eE6FdGGa4FlqnSJ2u2hpuj8QfAMQ3PyjB0YYxxg93IIPsmEDLOnukQ8LVB026KGU277PExab1hxNPij37MkY+KEHamelbBAyi970clkMUH/q8dFyaaeqMToxD7B6WbvyV7aM43VRjaYwm5NQrnqz15eoC1TMCkfOTFTHIow9Gh0f1ABuZK/4bTVC3tOYPEDTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(8936002)(8676002)(4326008)(40480700001)(40460700003)(110136005)(5660300002)(70206006)(54906003)(316002)(6636002)(70586007)(2616005)(47076005)(478600001)(81166007)(82740400003)(1076003)(36756003)(41300700001)(26005)(356005)(86362001)(426003)(7696005)(336012)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 05:33:03.6848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead89341-daa4-4fb6-bf0d-08dc279e4189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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

The current kfd_gpu_cache_info structure is only partially
filled in for some architectures. This means that for devices
where we do not fill in some fields, we can returned
uninitialized values through  the KFD topology.
Zero out the kfd_gpu_cache_info before asking the remaining
fields to be filled in by lower-level functions.

Fixes: 04756ac9a24c ("drm/amdkfd: Add cache line sizes to KFD topology")
Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3df2a8ad86fb..5cb0465493b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1707,6 +1707,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 
 	gpu_processor_id = dev->node_props.simd_id_base;
 
+	memset(cache_info, 0, sizeof(cache_info));
 	pcache_info = cache_info;
 	num_of_cache_types = kfd_get_gpu_cache_info(kdev, &pcache_info);
 	if (!num_of_cache_types) {
-- 
2.20.1

