Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6840C4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 21:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D15110E925;
	Tue, 13 Feb 2024 21:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o3QhZrZk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F3E10E913
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 21:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSnFp+z74Cq5sSoG2ajgO3Gj2wHHhJL/uyQQmGp5jDoHC5kwcElDqQxUANeFF760f3auIYQKJ8Ct7QWurMhh0hF6/K3w3XD1xmu5QXh6Zr0AUGc4A0LAY0lTHq2wBdRaU61WkaiDXQPIUtm4NxknbRwSHo/4EX2uxjr1cTh01F3MyofY/1pfV/PpsamlEFUp396CAqf1ECw/Vn1x/4GixkuE9mSuFakIow0DLm2OuylwiGDQlcwDs5YVR2FVTMQx8zC2Xc+pqSwMezH6+4lFK5g2yyG1IDekPxeGR00WqBFfNGhzAnW4vf8HVl8KHgOH64fd0XQDr7pLO97EyuCnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxp+HKzYH/v97xK99mFc1yUbGnF3C88PUbTRSHSe02A=;
 b=FK0SPT826l4vDLgaPGcAw9saL8fv5fHgYZeNxB7Gk82IzvSdMOuXS7q0P1p5SxK7IfUSCZZ9p8R7/4GE9hOVxXXE6P3+pFHMMBPrmu9NdQdHQNIyb5e1XYBPAzCN133Bs6AetJVWGyhkPq0Y7HhlS3cmTlU0xTmmUOdmOOSd9D66bOAPJh56UrwLrq/JFMLV12BqkdZytIHQgJoLbAF8oDQWvzqRvWNSuwK7uEkt29uGww2HnF44gAvf/eW/vsjpaLo4orlFMDS1cmuNVWIVf/Sacge60cajdBphLBa3uGOYyUOOjcx6ZWvZi3vqQjAgwuLR/T6PFL9MQ1m+JK8eoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yxp+HKzYH/v97xK99mFc1yUbGnF3C88PUbTRSHSe02A=;
 b=o3QhZrZkYFmj45kA5J6+5uht0sTToA1xfOMqx1o1oZmTHrseuFichCPKA3F7eeOE47teAIyzQIp/hD0p4tCUslMgc7dK0wWTGQLSAHcGm1NUjzcbZK/7hwRcuT9nR6wM//kWKcVh1cTB6n1R5gc4dCPTA0/cyr0fvOjczEdYcUk=
Received: from PR1P264CA0108.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::19)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 21:39:55 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::75) by PR1P264CA0108.outlook.office365.com
 (2603:10a6:102:2cf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 21:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 21:39:54 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 15:39:51 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [Patch v2 2/2] drm/amdgpu: Fix implicit assumtion in gfx11 debug flags
Date: Tue, 13 Feb 2024 16:39:34 -0500
Message-ID: <20240213213934.1086279-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213213934.1086279-1-rajneesh.bhardwaj@amd.com>
References: <20240213213934.1086279-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 50781ff7-e6ae-42b0-cce6-08dc2cdc5111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evVur20lXOWD3V+aQkdgXmn/gcMgRyo/Z1S9WY6zOFiERMbh7jvpr9yEj11CuqL6hyKuxHcPZC1lrLZEO8/cton+W97wt0Xk/z27nGfVMw6mXAtDdpL17MVFJwC6XmmDcGWfA3Cj2lQPJzSkYZK9tm3uheBK+92bQEspPykCDgAcQ4MzT9Of2jiTsymYWcLw8W+tu8712+8dz57IC3zM6PnTgpx/6piiKQiDbiJsIQRamig4o6wPjKrjQaUR1t4P/Wesg9Tb0g2dT25oQWfwOhHECYvtSPvAAQGCaV2Td5ehHgMdxy6OM4bcMHLz3sRphkBNmqmpJVhsTxYeMB0CRTNtUg+WSUDm0XpuLRZrCE6m2rWlDU5KXc2WrPTvqhEOEI3FiCaTS8+8FKalL7yAvTygL8VmHhMGvcyiqqb3EI5h+qQG6YbV1POhaBBvZF7kN07p2pyv4NtSOQVdmX8UJJY/vKReCO6oHWn1nmnm4ShCPBiRI6MXCS+z/e3bIokL0FLIqDlNbXZlLqIC7dh+ht3QoFJVgurAMy97RhtUn2GXf3JSa6nwghz9GfUXbuQbtcHUbTfFQ8yo/gH6pWqdCYy+i2qgY4dsNtOroU8fhNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(4326008)(8936002)(8676002)(2906002)(44832011)(5660300002)(336012)(426003)(83380400001)(2616005)(26005)(1076003)(16526019)(36756003)(82740400003)(86362001)(356005)(81166007)(7696005)(316002)(6916009)(70586007)(70206006)(54906003)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:39:54.3534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50781ff7-e6ae-42b0-cce6-08dc2cdc5111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
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

Gfx11 debug flags mask is currently set with an implicit assumption that
no other mqd update flags exist. This needs to be fixed with newly
introduced flag UPDATE_FLAG_IS_GWS by the previous patch.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index d722cbd31783..826bc4f6c8a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -55,8 +55,8 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 	m = get_mqd(mqd);
 
 	if (has_wa_flag) {
-		uint32_t wa_mask = minfo->update_flag == UPDATE_FLAG_DBG_WA_ENABLE ?
-						0xffff : 0xffffffff;
+		uint32_t wa_mask =
+			(minfo->update_flag & UPDATE_FLAG_DBG_WA_ENABLE) ? 0xffff : 0xffffffff;
 
 		m->compute_static_thread_mgmt_se0 = wa_mask;
 		m->compute_static_thread_mgmt_se1 = wa_mask;
-- 
2.34.1

