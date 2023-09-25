Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D54CE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 06:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C8810E0AD;
	Mon, 25 Sep 2023 06:23:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E342010E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 06:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfE8W9KMEf7Om8oLVo0VIj8MqKeGCEp1ajMJz9PQCwCEY9451LcF8iQHjrzqmCMcPOESEqU73/JNU0bU/M9NPN505tsl0qMdS67gze3wwT1ij4VFTYdnCANmytzfPmCajSE4X85g5ghcYo/p/wfqG4zyQKTCz7fGqFUMej2RPFC+zoYf22c/c1qHzGPaC41Wx51EMqAoxZctav0T3tKRAhVAriHv+KdyX/t8wnFxHIRUd47eg1VI8S4p+T/CZZX9E/9Kl0eWHjhdoprsfNL2nWHKemRpv23nLxVpIbLLE/gvVytn3umn5eQlYeApaC0wsrpgEAPX72P7MghKnOTC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+msnqy2b9tEqvF3vn+tMRJBVbFkFy72GRtKEkzQj1tg=;
 b=dj/1GK9spHofDLYqd7vfAJhTln4RQeY0otNE9uKEQHEOb+pfABYLMDwZTaGQRBjZRBqHW5UY7/KuNd2CzDME+CcmUK9NP/wYd7x4UyIzxkVd0BzH3gTh7r2PC/+nIb1PocC+97xnIBUPVN5APf8KTLRcod7SZsFJEkquejuTWuyh2beIsqGdf/RcM1BcpsFBzPcVAtKQ27gGrDMaT04Sl4LUS4+KxphbNcOgTlio/OSs/yllw9JkSwpUYjzMYNMuStxQVhLK4ZoxxJB2x+pIcLWUiUuGMoEYoYbRnQ0qF1WsD4ifZwPqIm9Yy7uyonY6Z3SETWInIStUMN68pCwNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+msnqy2b9tEqvF3vn+tMRJBVbFkFy72GRtKEkzQj1tg=;
 b=l0pciXjrkYVpHRJo/lckHR5TunkA6qqtRWj2/3Bq9z64014HsUpsQLS3HDHqW/dCsROtb3k72PTCggtA5/d8cS9ehhRbKZW6Sq5BqzJNv2833XlZZwQKl3QOafjhuilCo0iLoGerJMYoTxC2zjWaJyWn65w7J5itSJzWX2qCuPk=
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 06:23:01 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::b6) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 06:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 06:23:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 25 Sep 2023 01:22:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Address 'srf_updates' not described in
 'could_mpcc_tree_change_for_active_pipes'
Date: Mon, 25 Sep 2023 11:52:25 +0530
Message-ID: <20230925062225.819007-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 61fa4b3b-fb67-4a6f-f19c-08dbbd8fddf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMezMai1rMpaXPAo8jnvq5LaU+hO0oN7ZskpyYGjBhEJL+Ak5X+lFPsHLESei7AVk9ZbTIOImAYhAHiQQ6YiDMT4P4aMOQmst+E5JoWudEo1FUVzoeeEZQBCzmwcKgVY93vjVlFXEUR3fOSpTr0SbsWUcyYvYUuaZ3fiuYfWPodjk85LJJ8AWulMhn/XT66+w2OLYASeOEl1sJopo7iKE/0J6GTIYAvgF/NlKEuGozASnhfqaupjtsEvXytsFD5FxHaWQHto79f9LzB3sSmOQkPNjYk5RXxNjgw/2DTcdTmodNmXzvGd3Y5OjUh78YgaRJFOy1VJoIdGfeI3eoEExKk5yd4qsqz/er0B0HNWfC0VNRM1gUDUg+gQ70/sNC5hwOWLYYntYGkczcHO3lIVtz0O+6RuZBfLr4e27iHRJrJWP1mzkYzNqIwFogYQo5SnRQy6hpRua+a9pp2SC6l/IxHfrJb5EgwxqMYjNHlAnzql5HsR4TMm9hm69ygqKm7dXmViGWybTrI4k2aMU8+r57xjVkvZm0FaXhC1CFi48hb9knjftLOTUXJbCPL5U1EpvmK5aZ1wXbQjlI96GjOUiy8E0APzWTPv53+DtvUccN3MVDI6EAvExw9TlyiUwBZsqRPzWJJDnRQ21O2BIu7HS4GKNwxCGraUZm1i5NIKkTqOJncaOQc+paRhn+n9mp8hWVK7TYdspofNPuRvs3+7zsgHcxSpvHyt4h/m+yTf+Ab2t5kgpX5qeSVvjyBXE0RbpTKzvKQQWcgYNfQSRzSFnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(26005)(40460700003)(2616005)(16526019)(7696005)(82740400003)(36756003)(356005)(36860700001)(81166007)(86362001)(47076005)(336012)(426003)(5660300002)(44832011)(40480700001)(478600001)(83380400001)(110136005)(6666004)(41300700001)(316002)(70206006)(70586007)(8936002)(4326008)(8676002)(54906003)(6636002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:23:00.3491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fa4b3b-fb67-4a6f-f19c-08dbbd8fddf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3928: warning: Function parameter or member 'srf_updates' not described in 'could_mpcc_tree_change_for_active_pipes'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c5a74b202bc8..ab403d2d9038 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3906,6 +3906,7 @@ static void commit_planes_for_stream(struct dc *dc,
  *
  * @dc: Used to get the current state status
  * @stream: Target stream, which we want to remove the attached planes
+ * @srf_updates: Array of surface updates
  * @surface_count: Number of surface update
  * @is_plane_addition: [in] Fill out with true if it is a plane addition case
  *
-- 
2.34.1

