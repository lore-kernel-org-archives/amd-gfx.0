Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 03:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054AB10E074;
	Tue,  7 Nov 2023 03:06:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0440910E074
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 03:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZYszzMOpHWTKVZUtUxp6CZ3dBxHRtPFDGwh2PZyYLrwUt4V4om+VSA5SJ4j16QlmloR1EcQAyt8EJoOCpKrbb2Zh1tbwvghcCwOoiH/8fSg5XyNaV70UnOzK83bUr2no06p36u1kNZKXVsJuzeU8feO6KWZbYaZj4Inmc5WQXj/3p1Bz9zi1rR6CIFEdkjpbsk+ux6crvge/UMbOQN8ilqGJseyhZaVmqCcXgB6EzSrHrneC0eO7j9QyGSyn9Kq9lFWYoS1ZQgdLynyJ0HiZQZv4b8aE1Oa5ZnnfcrM/5qAZI7CnMltPjBza09EDZ/vVyeyOASSHmElrUVHznEz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MM9Erg8uBsl1VbrzUC9TcGLoAqm41lUkPaNzbHYd9s=;
 b=KxVuOp+yrTLKEHSgDBI5ihrp186E3qSSyPzZRI2nqruiSqiYpBtrdRdEdwOmVipXXHqmWSNRglpikmQXWbjFp7e9g8/2V4X8Fo14snWeP909/HF0rAHirxzyGjOlw9Jb1DBoIAwR/Lsw8X+rie+OJi6pzYApA65NUPyBiBkeNNcijMVkvKErkJzrf/Z6eFZELZnimePA/xOKXeazn2JONirqwPbfBmOg+bbdB+drlpO77PolSCdTl/wLF91G4dI2w9U7wKNNB71W7Zz6C5pxbBFtoX5nirrfTwrKp4UOlvwZDDWKdVkxNFtRtkYbp/osS12H2SJ4rMPiQzHkcIc4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MM9Erg8uBsl1VbrzUC9TcGLoAqm41lUkPaNzbHYd9s=;
 b=tcIZX5KtaqBph4l1pCL9RXVrFW9wmKHz36Eajnh/YAthsrTD/RK1s50egeYbGp1ktX24sAvU/W5o9bfkjeN6jDNtWXBySCvzVYjxJL79c034xGr/d63UsqupFpxfja38O3TwlNSrZqtS6rejALic1u8sjxr2Wls+dyy9z09Utpw=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:06:25 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::bb) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 03:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 03:06:25 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 6 Nov
 2023 21:06:24 -0600
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add and populate the port num into xgmi
 topology info
Date: Tue, 7 Nov 2023 11:06:10 +0800
Message-ID: <20231107030611.31109-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a26d27-8ff6-4499-5470-08dbdf3e8742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyIfEErjy8aF0IxXWVhXLJFG32Dvr0aMvzirnDeWeerZ3G6mdG16ODvUJjwlzxFRnl7b4FVKozuOVVusxKEITJj8xKE4CkUqXkXbcFSeteEV3EwlAOwOInZtxzKY7Btl+eI65qeMI4RLlJX52R/HKeTu2o1W/qYkUTHllUQ58QjgZadZvD2cjwdtkP5VzUuQicO59HjCTZtLIDbhxZG5Y6zBCAfkrIF8TLsRM3Um2PaXwbl7gFW3Gd5MCbdKLx04F9+oh6W50aUOlZe/NwnkzZHTdkbymynZOtqcE+6gF1HJGuESB3/KhrdYJmHnwsSGlI4ta9/UdfH54UnfUqQejy+XbiJc/xYGkwAe53cdMkSTCzTM/3dCBI/4xaEliNCJe9Y7vphMPy6o1FfCk93pyjedK7yrRcs2HU06e9xXP41t7VKKeYYxd1jQ1vjjXYweHrrcTFVkt/pg3Fmi8yOJXt8lERkG+O/pI/muOBMZP3xXWuoHX7sb0cEf7JrM5U8f3NlTvZkcvHk9v4GDcQiIyxOv4EYuv/a1kf5gKLuES7FSmawISbGkjhkN6ZmKjDJuzUa0jGo5QfpssAbzsFZz8Hh7MUR7GmIjXc4oE2ge+2WGnUp/Me+TRoYXyZ7A9y+qiwGsaT/2Sv1NW4LF1BSdTHuGuMbFKjiFvxc5lWnj93lB87JypHrHpVkgWc05ibpJIluQWk5yCeUrS6StqgljYTLRo/KaT6hF49ttZ93WA391siGjZ3NSGOemfY9VZcMDb4Qn2e6MYbq7XRMBNGIT6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(478600001)(47076005)(44832011)(41300700001)(7696005)(2616005)(6666004)(336012)(316002)(8936002)(426003)(8676002)(5660300002)(2906002)(36860700001)(70586007)(16526019)(1076003)(26005)(70206006)(6916009)(356005)(81166007)(86362001)(82740400003)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:06:25.2825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a26d27-8ff6-4499-5470-08dbdf3e8742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

The port num info is firstly introduced with 20.00.01.13 xgmi ta and
make them as part of topology info.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e6dc3cfbac0e..dd82aaec1922 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1473,6 +1473,11 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 				topology->nodes[i].num_links = (requires_reflection && topology->nodes[i].num_links) ?
 								topology->nodes[i].num_links : node_num_links;
 			}
+			/* popluate the connected port num info if supported and available */
+			if (ta_port_num_support && topology->nodes[i].num_links) {
+				memcpy(topology->nodes[i].port_num, link_extend_info_output->nodes[i].port_num,
+				       sizeof(struct xgmi_connected_port_num) * TA_XGMI__MAX_PORT_NUM);
+			}
 
 			/* reflect the topology information for bi-directionality */
 			if (requires_reflection && topology->nodes[i].num_hops)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 7111dd32e66f..d185a58de935 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -149,6 +149,7 @@ struct psp_xgmi_node_info {
 	uint8_t					is_sharing_enabled;
 	enum ta_xgmi_assigned_sdma_engine	sdma_engine;
 	uint8_t					num_links;
+	struct xgmi_connected_port_num		port_num[TA_XGMI__MAX_PORT_NUM];
 };
 
 struct psp_xgmi_topology_info {
-- 
2.17.1

