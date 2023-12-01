Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62195C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 00:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E361D10E07A;
	Fri,  1 Dec 2023 00:58:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67A010E07A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 00:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBDl5GFDfQl2+Mh4LyQXnI7oX4KoCAbj7Gc9icemyFffMdJSChSZMCbErdUPVrMcZPdOt95sCU4tnpsRdEDaW0xSDo6AmTnyIFV5gAUySvVi7/hovyc3DcZyAea7fa1jrb+o+Cqp3OpVYb9twRdXG1JlWH3toLfiCTReVR3ySF0p9dI8awH/2ihuTWO2RARNCGjvnV/Yxcp9Bji4m4IiNXb0Pbje7R6MT307eMbum7P10VAkB0F+lh0sLJbyuPsPgrC4TiJ6eFAQEQuYgR1iber+/grYDCf3DjlhOQhYFa640HV6dhhAQoAkw3txgKoMDv5XbdlFTdpeGB85RHqu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O95LlRrfqsaTk5z3+eEE+LLMzz38mK5BhSQUnEjPUQc=;
 b=e6j5UVDOsrFkNOZx6G9QKcZd1/e4u4JloZDlQZiQKn+0f23boqCdRor/XofSvXZLDGtnBT2UKmL/yVonyOqaxUbnQ6BLQ5lUhjSxoaxpUD0s/lb9JBuGlVmfMUATapdw5JzPujQGcMc89iv3I+ptl1Pyyo+XzBp8PrSJKFEAuE3+mgBwKMfrwbZ4dTbDiLwMInMSAVqL/k3Ic9Bd5HaJCXq/EG4ikThKEv/1QIjiOfs36oey+TTrSVXIr9+GzhTfZuLlPh83Aruh/VWgEfJtrgcz0MQqbTByNBFNQosiHCZdQMp1jsPQMgWw6W37NgpR0LKTcfY0WubO82hJoHmvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O95LlRrfqsaTk5z3+eEE+LLMzz38mK5BhSQUnEjPUQc=;
 b=nSheuJSZ4AOXJq0tXelw3hQl+hWdAFZzTRO/ucia53BEngEN5FJR9Fb/OxrPwtYHerooonWMZrLEKgi7AbYFSx1M/Ejdg04kZf1BDOB0SYbH8/LOG0/WkBXbjDughdlnslc7Qh2OzIsr1xUZgCFVOgdtsxkADJ3+0DQch365rOA=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:58:07 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::56) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:58:07 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 18:58:06 -0600
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable MCBP by default
Date: Fri, 1 Dec 2023 08:57:51 +0800
Message-ID: <20231201005751.4194154-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: fb59f43d-7eba-436b-2bfb-08dbf20894f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3g7yNUuyy3WKIKwtNTsDPnTK/HshCGWSSsMCxfSKRdumIP5jVAkW5f04ycUgojBcyO22wDB5lAJJKDayjIMGHNY2eOUuS9U4thhv6lRo0Q2oC5ZY6HNaXWW8ORvvzLjC8sn/Oo2iTXbf70QhqryW4tgtAGmnc7zaUr727/qbLOA594s0DD4+QMvQZvMz8pfHLAxCnzSwwteP8kgZG/NsPNOuyo+M2qaoKt803lPz+qVEte0kf1WsrD06U44+qaA5h5O/2ju6pLlhrcCzlqq1KWB1mB8vuc3e5rrY74+ghS34OYUDYVVs9hE3irfkDy5aopSE0idqUgjKPjSWWBoSOM0EDpFFuU/6CvbiKULWf3+1BiDdiYA01tm8WYb9OsmeDW2NwNkayjWUsEgkK6s2YGB6XzUi1diR91oVtgFjz3JSpM5FDhqgddDs4MCfqIRNEyxMrJImXEAqEBORyyZhKdYfkNmJIebClXQKa5Bl2/sqKwRHeI3ix1dd4F6RIT58P0JSLNx1pYpdPECvfEbQmmdTTtzgSw18YxYJ/hcPMGi5WLO3ehohw68iGW3UPola2WVJpCAE0qdSW7il2VeZ1OmYOeIFJYd7m3qz/P9c6imQ1jsf27h/RVM9Uo4cEFZxqS1ZafqZEQCuUxNCKj3m+7aXkXkC8VGzhksU1KIs73ahdBk1h2bvW11Nn4OKfWQ8a2IFrJNSnMODE7nzN0fMggoobmp5dsGgrnlRAHO605puMoldhaAdbUZfYhJ57CLH3/UYQ8OSx/qLq/6rXmJvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(83380400001)(26005)(1076003)(6666004)(7696005)(2616005)(47076005)(426003)(36860700001)(478600001)(8936002)(5660300002)(8676002)(41300700001)(336012)(4744005)(2876002)(2906002)(16526019)(4326008)(316002)(81166007)(6916009)(70206006)(70586007)(36756003)(356005)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:58:07.5253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb59f43d-7eba-436b-2bfb-08dbf20894f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Disable MCBP(mid command buffer preemption) by default as old Mesa
hangs with it. We shall not enable the feature that breaks old usermode
driver.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 21b8a8f2b622..280fcad9ce93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3690,10 +3690,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 		adev->gfx.mcbp = true;
 	else if (amdgpu_mcbp == 0)
 		adev->gfx.mcbp = false;
-	else if ((amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0)) &&
-		 (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0)) &&
-		 adev->gfx.num_gfx_rings)
-		adev->gfx.mcbp = true;
 
 	if (amdgpu_sriov_vf(adev))
 		adev->gfx.mcbp = true;
-- 
2.25.1

