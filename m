Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239D560FD7
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 239D560FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6076E83A;
	Thu,  7 Oct 2021 14:06:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC5C6E530
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 14:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncfXku0t6VZPJVNAfPm/0tVDrp9nHZBSkhXHGNLERNbVXcAFtqDwLus8ZZLfgu/kNqPy9CNjpD8cw2p2eW/hWQRGryU1VDpuT0+PNLVG0FrsCIT1ABZ04eGfEBiUeUmZDREfcwo9WQe6MHcLGdJ1Fqi6aX341kxsuVbFxkIee4XoIiYLTXFjyeYN0rAWjk1vQDM5lXnLvB98hAFRgsEkR+Y3uSeSxpsAxa6OUznUkPsHugb1YfazI9ujZPZgDAirGpPnqKetzloMdOk+eYiSpizx6+UxYG/CvCpMQqBEGXT1qwKlNie4AOJsUwGjrAPXJlVV/22/sPi5mopGLnpwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzOvjc1BUvVXhlGyF+JQ1py+eJm1SXzJN+kC0rDHgSk=;
 b=OpbHF8twsFVTk01hlSDUua5naiAFF6A+voh0snGWsOLghOx6KnmvWbgnjePFhfqLGgO1eLa7XKpCKY+rE4WytGsyQjw/1HDZCAXPKlX6tWeMIG0zsr1mvZ7fKKZnNlYXNsKKNsyZjdLCGCW9oJYPKmhTmyZcnCFJ0kSiI8FhPg1KOZm7wbSlnobBUJ+6xGjPRokdvkosaj5nhr+GhMzPJLdmwjCmzRbLwBZCqige/xdRU4G6hAyIAiNtxx8kjz9+Czt9lpeIOeESW5zLMzBiZIMaEI1Aj3n4qWufQIMCG1LAxMAvdIDE9MflPxEcWP2MlWMctdR4VsS+s/EBqjQZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzOvjc1BUvVXhlGyF+JQ1py+eJm1SXzJN+kC0rDHgSk=;
 b=RwpFpV8meIJm4a6C9BBVq1LSZE83oW114ipqp+Yzt87KZEC0N6yJLegFzl1af/5yZdF3DnYVZ+x+e2KuuD7m5kyAs9AlfuuW9xovXEfa6XbCuImrW+qHQNhFCM1NmrxFKehRtHY/u3ts9/8GVJNE2t50WlKk5APokH0lQ0M69mA=
Received: from CO2PR04CA0154.namprd04.prod.outlook.com (2603:10b6:104::32) by
 BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 14:05:57 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::90) by CO2PR04CA0154.outlook.office365.com
 (2603:10b6:104::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Thu, 7 Oct 2021 14:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 14:05:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 09:05:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: add missing case for SMU 11.0.5
Date: Thu, 7 Oct 2021 10:05:40 -0400
Message-ID: <20211007140540.223897-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951ff6a0-2df6-476e-a93d-08d9899b952e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5099ED4DB11B2E1B120699C5F7B19@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgSAPZlGENxz2FeDt/si4WrPsUlmp+dR0E9DuALcWge/eWBpCYt4chnfxd2S2tObsSgeUZmS/L2u7KpuTJHJhlOyIa0MJktu+dmZndBTft8CWzHtCMJWs7LxnFQta0IQwapry+1zS1gi330e8w2kEnbvdyKdLjNVPFXT/aFeSRUo7U8KvcoL0ZQUD39YAYz6lcPgY7XciBqEG9aVu4ZoFrXICOMNgyYDGav7XC0MnYDJ6Ap4H8lyj5gg6n1qAHJRv4nQsbCXKj++EH7eCETIiZ15b0IA8CI3O7quZ8qaBzWUScspsFN7OGXfbpu48pVxpVWaNcwINH5dPHO/+2waEfX1ywioAoRCsIJNEd3TRDP1QYD1lGbNlUPXiiYH7vU60h+DI9f+LBwcolUJlw6cljvU9YKq+kys9/jY2mb7rBOwA2vFpdTzY0LJpQR9WqeoJ1iIl7h7uoKpmlopLvvwncsbQj6efNwQU45NNhf8Y23W1IhA5p9fYfSD3UlXKIy3sheIwJEgSwtAS1Jmy/Qd48+MlGjoGGhvRKiP1jcclP6Mne4BVs+05Gk6wdPm8QqgNW4B7dif45vK6MW+WZiBEFTwxbxRtIJjHRG0r4JzfFvzG6KPgmPq/e4HJECFDih7iJBQky62pTgmIh99LBUyjoOBz3a9A4Eb3kGJ667wGXf1achbBVxkoWIbnwS9I9PBibmc8bv52L5fxJNvoSeIv+CIzo4KAe1l6IMZE6Z1Ps0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(8676002)(4744005)(82310400003)(2906002)(4326008)(1076003)(2616005)(36860700001)(5660300002)(7696005)(86362001)(36756003)(316002)(81166007)(356005)(508600001)(426003)(336012)(186003)(6916009)(16526019)(26005)(70206006)(83380400001)(6666004)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 14:05:56.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951ff6a0-2df6-476e-a93d-08d9899b952e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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

Was missed when converting the driver over to IP based
initialization.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index daa798c5b882..90d7de17d81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -700,6 +700,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 8):
-- 
2.31.1

