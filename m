Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8680C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EAB610FB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1EAB610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1A96EB40;
	Tue,  5 Oct 2021 08:01:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D756EB40
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 08:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZPGQQHC31C/KeONUBRadjT3ly8Tz6yrXVn3JPKI/iAq8EsJOR4MC3HHZ7z/Jp0l2wZlmONPeJ75WKMVKySoHBNZqHIyFL4ShT3Qo6333dZg9IavdQrUIFq4eYSlbQRii6w4kZhxtovb9cHHU1wDEzz95osPI6RAHx4I3iTsS5N0wXmhohWdUi6XzETaQyVCOMmDUEgaMAH8AQ+7K4IwKQcsb0cHoWSwAH+Lf8Vds0lD15M3ZSshZU7pTs3J2Z9zyjH6zg6kUm9TP0f2p3kWCMepDGGCItA/WJvyup9xx7fTDxg6wGuUDdSBvU2ChXUiqFvUnGV2ziGtcw2cer+HWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsF4kZJZzwQdIz7JEiFfOKAVBNgQs0TWqJ/snY46W08=;
 b=HhJkQ8WzoSWL/4aoQvnk1kxcbcNKtqIqu5OLxcaUac2PeI92jZvctIHJZHUSQCD+jHeA1xl23hThA3n+3musr1X2o6oHySQBAEn6QHvfRkbRL0HNJzDOL0E9T+33mKHhVBCUM19pRwp0NKpnmI76FoVi2UxtCoPVBVnzxmUk92i144Uc3eCtqAVP+GTDXRDUMUTLod2vGPwyOxc3A9JPiARq+l+2XlVGxKjnePpXxM9sklGvpeJ0aKDpVih2rqdl6VQnLJfhQ7PFSX9hjnR9y7cISC3oSKCCiTU5YtK68DA1DecBlo+HLWMe3cwsg0t9puo9IvxsPlk7pZLiJzHs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsF4kZJZzwQdIz7JEiFfOKAVBNgQs0TWqJ/snY46W08=;
 b=Mgae9ilZbFfrSk08HzRDP020u060ynZhlzgoCdDaVCuEQas9BY/ihlwj50DZ8BjCMlpyHJxLG8LMyky7+XKjotWteDjn4fSQtXhlcTsTEByK8D1kvGxigZXXLHCZyE9S9KoYj73Pa/cjBunTkkrioFTw8hWK3d3q+YJH5uwZZqw=
Received: from MWHPR11CA0035.namprd11.prod.outlook.com (2603:10b6:300:115::21)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 08:01:53 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::d0) by MWHPR11CA0035.outlook.office365.com
 (2603:10b6:300:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 08:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 08:01:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 03:01:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 01:01:50 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 03:01:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 22/23] drm/amd/display: Fix USB4 Aux via DMUB terminate
 unexpectedly
Date: Tue, 5 Oct 2021 15:52:04 +0800
Message-ID: <20211005075205.3467938-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db315b22-cb35-4900-85e4-08d987d66454
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4910318FBD307FFAB638D549FCAF9@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYaXeB5cItq8mSDqr/VsBfrKyD0QVTPP6r4jguDhG5n/a27AC7HoT8CvP0DiqTD7DL/df16dPhGOgIpZp5SIw6yqHhvhi+6rQ5y9L7jYYfWJZCbzxbC0mlXuZXvgtlSq/f0CkBQPFEOvGUOAQk1KzijdBVG2Uz145GjqrI5tQbvpw9aV6IM14hA5VsE9JcUuQTQAgynnZh/ivg0puUcTuizqclfncdBOPhgn76pr0kWe8h4L8Bb6sisK3+fGKH1teZPrhSXSdKGS665RlFJdS1D5aD9uMP+beYQ6ShAGSe5l9MIM48Eha0S0iuEJGtX+eb4EB0WbNnbHNdPQWnR9iU13AowKrtYnp42IoPyXiK/Jmz9BkU3GTApYgoOJl8fFyRj4NbzvcmyaZwnFGQZ+zfuREP18QePINBYcge0rAIdNbXzzveofXEd8fBOt95/WhI1BTW+2rEKgKiabcqKOK1MbaTF1sb8ayKuuT3jpaADVI7E1F2ne61BhSflqkZEuCUCTc2/lb+uQsrrDE9iCdVT9j80KwiPPQHwt0pgfTWntlZ7TspEfUF/FNIn9QVdxjJZTzc8K8Byq6QUFqdvMWSUUL0onDvLf/nNOVKuWZ0Cwc1rIh0RrfJ1BzFQ9REqcB3BWRcF4/asbOCeLuLX6sqaf08NFVMA4r5eXBQkYtIE/KnzhSxa1BWVnw0TqEyXDiMSP2CnoRvlxBdz/VmczG24GuSAsyuscNzGF0uRRhHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(36860700001)(82310400003)(83380400001)(5660300002)(4326008)(6916009)(47076005)(86362001)(36756003)(70206006)(6666004)(426003)(7696005)(186003)(8676002)(54906003)(26005)(508600001)(316002)(81166007)(356005)(8936002)(2616005)(2906002)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 08:01:52.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db315b22-cb35-4900-85e4-08d987d66454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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

From: Jude Shih <shenshih@amd.com>

[Why]
Condition variable sometimes terminated unexpectedly

[How]
Use wait_for_completion_timeout to avoid unexpected termination of CV

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cbf83a6e56b9..2962123b5f7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11398,8 +11398,9 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
 					(uint32_t *)operation_result);
 	}
 
-	ret = wait_for_completion_interruptible_timeout(&adev->dm.dmub_aux_transfer_done, 10*HZ);
+	ret = wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ);
 	if (ret == 0) {
+		DRM_ERROR("wait_for_completion_timeout timeout!");
 		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
 				ctx, DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT,
 				(uint32_t *)operation_result);
-- 
2.25.1

