Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 09:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF8E10ED00;
	Tue, 24 May 2022 09:00:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088B810ED00
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 09:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVwtNgShxTjeSxPAOirRVdzzU9ktCq3a0cmUpcR3xm/oFcjedict5cFFSKao8l16mzBGRSYaEHF4YG5H0aI09wqU7yU4GDRCFusai/x89pkwJX17dx6SGqGo71CcEhDIGWbagVRUP12weUdn3tD6zw5LQzGbfe6aajj8wjUw6CQt/aeTdS00nw3wTh3BHcM1NsnDHuGp8yE1JR3c2Ib+ETtzblXCMXcwxvVNDplT7Yla087R39oDP2dVMSuRYHEVtz4xFy58MTDLhChM1MwK+qdPJTDvMRfa0sAlfoSkIG5wHiXmJN3c8sWvfSczL/ddHcdZw7fuj/yCDKf1/YpOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1PYRVBbYY/pjsQpVNUo0bEqjgz1Dh92TXwBNqeA3wE=;
 b=a3bac7cTHf2ZnUZJTB/Nj5I1kZ8/BwDbzb5JfEW+u3JPual/6oAqiXoRqrj++OzkPmFqN3syf/25nL/8Y6TTWu5N5HQM3pbc+l61ARccnzLjXSRXJ95HhpeCe2fHBzMUER1NQRfrSCwebcae0ONirxSyzbWiHBP0QjjvPNYHQRek9JDW4xt25GiIZdo7SRFdhjY9bONbNXVVjAvf2ITvsz1FJ2w0xznKl1evluO682Q/V0gZwUpybB5XIYmtDTpLBKnAWqlE7Y+TrxMRgGSCwwvXuUMXqGcWi0olzE/lUbng+F+ruELB8qtPSEXzE2OvgLTclX7imthAAOOkDpJmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1PYRVBbYY/pjsQpVNUo0bEqjgz1Dh92TXwBNqeA3wE=;
 b=GOzefh6VoV+ypB/c7RC/LKc3IDF4kJUrYeBiQgIHZWSaF+0qvNOGVa4WsEC+uDt39+DHdSFJJTllSq+ofI+TIWO/ndqjEWGVhs5daFt1NPJxZr4PCBwTCVbP2lkGjvtlfdFFMObUWeqx2+05GYFCf6/Vracu9K3dDNYxyGQ6SWA=
Received: from DS7PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:3b7::6) by
 CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 08:59:58 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::8d) by DS7PR03CA0091.outlook.office365.com
 (2603:10b6:5:3b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20 via Frontend
 Transport; Tue, 24 May 2022 08:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 08:59:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 03:59:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: correct the way for retrieving current uclk
 frequency
Date: Tue, 24 May 2022 16:59:37 +0800
Message-ID: <20220524085939.33215-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b1f269-ae38-4502-c899-08da3d63c727
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0118B7CDADA056EDD7EBD01AE4D79@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wcOl/U9qfL4zK3cYJnL9YM42njGd6stdUw7m2wBVUeI6JyKK9ap82Q+ALY21PpPo+Fx7lEB0GkRxRU9cvTLyuQ/ATX2GeEEgNMP8qoKB2beOlJLM2AYGSzMcfq/jKHuGs/aGxRrKmkIgniyQOQrcYwXhEdgg8/1E8G0zw6A708xuz5F3qCLhFrxgUFsDIFbisHalDO2kydk4E8trgdzM/1PtOW9cDZoOAdgf77qfttigcMZD+oXWDjmAA2ojAprRY2LskMvvqiN6/I93M/TaNTpZISMFXFdhN42h/3DjBzRgNTFOkaq0uQWlPgGu8A7femx9o0cd2dXjaePgypNCdXtMTGpQIMspmknGcTCd9lXID8yTjZ6cikbAA7qie5rueXBTLuA+cM/UovhALWtxDHqfCUvEvfjufz0hId/rvI/3xWk4tic7PpTxyMhHEeTyLn7BrtTi/AKb4yFQ9KVUxTOWlk1dU/Qy6KwytppI6c+DWzq2GiuU4jLhTsqhvnMQoFqOPWBMHc1PNEv50VYDQgH/QXHAL3qX5PTkB8FBXf0sKJ/RRTSk5ImfC4e2w7nOXPyRIlR3lhNlY+vMxhq28X/CYknb0d/8823imrELaDS48kTtHPIGfWQVxYZhAhMASZVLxkq0keMP3ItssxS7M0mryfCUoX3qzIbEjByEnJglQ1Fhay06LM3YlFlSBYte1U+Gs5J7IKo64zbKD5U0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(44832011)(8676002)(356005)(26005)(6916009)(36860700001)(70206006)(2906002)(70586007)(40460700003)(4744005)(4326008)(8936002)(508600001)(54906003)(81166007)(82310400005)(5660300002)(336012)(1076003)(426003)(186003)(16526019)(47076005)(7696005)(6666004)(86362001)(316002)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 08:59:57.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b1f269-ae38-4502-c899-08da3d63c727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is some problem with average frequency reading. Thus, we
switch to the target frequency reading instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I50fd370bbca68159cb1a4f69b05232f907af2bb9
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f159930e0dc0..bfced430cd31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -823,7 +823,7 @@ static int smu_v13_0_0_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		ret = smu_v13_0_0_get_smu_metrics_data(smu,
-						       METRICS_AVERAGE_UCLK,
+						       METRICS_CURR_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
-- 
2.29.0

