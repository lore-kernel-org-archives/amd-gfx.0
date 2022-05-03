Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB02C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA41610F4A2;
	Tue,  3 May 2022 20:51:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE9B810F48F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHJ/aRx4uFoZ5BYOW8LrwWJrZ1ByvR7a080saWAk990fHjmP6WqFP3bb9MuQQ7QvLsY47xlu2zZqSP3teyXkdwGAevuOx8rJbdbm35BlJIn/NogXnZ6KC0L0cIME0sh3I/QoSxMx3sYCu/dB9PFWisbWX5MK8y5VnnldCJIK7QpI8X/R+rWbsL7j0ULtmyQatgDL4X2uTPQ3gSxfaOLpKBBmKGtSVv1FDah429Ifm7tkRHQHPgdKI9WzXWLcqAzN6VcPeEQziba6sRnJXj5BrerD63ytjZOAoY98mJoPW6N+DpfPzL/rtiKyanTHg0llyNziDLelF8kqgtxCgHODYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3ei+PTcnvt+K+aySr4Iy9439tqItTz3W503otoL+Lk=;
 b=HJicqTAeuvax03+NdzjRjDlDpZbHHQyxLBY4StkzYba1qTDpyQH1c/Q+6VcICvdaANZreLM75oFtihjOUEoZXTl7L0NO9mNLdR2vflq6//sUcv+xCU7G9Nq7zHVlYLW9muBYN8QN/gMrAiPO13affeWt8/wgE8ExwKIhYR2fM6JdVUJWnB128OgNcEcmqA3FH0LZ8Kpgly3eil82Ofuebd2PS0f2MMafvM8WgWlkujPX/HE5hM7qdKy5gAjIkjjnI7CxFknAOJk+rQDmk8R7sPf4elXxurKixS1d7OQzxNKzKBBvKvOk0VtkeKJRd4RX960OsktjoIxxdmw1MzE+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3ei+PTcnvt+K+aySr4Iy9439tqItTz3W503otoL+Lk=;
 b=zvgLOFO3P9nvJFKO6iJScO+xuzEj3dYj517pj+aa8DmycIHH3WXnL3KZT6K7CeglAMc1Ph1fPz0xxVbVmHniMPhDh1uLIWK48YFOrBQciBVrQzrQGDQ4967227dXnkwyid8IjAIhFAtgcgfTX47OkxfCDz729miJRdlW9t0DLOA=
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:51:24 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::1c) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:51:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add mmhub support for MMHUB 3.0.1
Date: Tue, 3 May 2022 16:50:55 -0400
Message-ID: <20220503205112.1285958-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06fe6c18-bf71-409f-fdac-08da2d46afc2
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5712AEE61C6BE32FE29C13EDF7C09@PH7PR12MB5712.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbxZcHXbtHOELahJcY663hTOwhjgLVPAudN+Raj3mAt9Q45PupR4+kpUcFX1vLycLERQMWxjXl0Tdmi8Buaa6N/labWELaGfe/K0J539rFXt75sHLErCwFpiaXJz7NVWlPBa3I87n695Pk3C2mCwhVMAOJy3IP0+pHcjSa5ywZA5FSDdbVHvyGktIcuMHL3zZRNPTmthz2DEd8F3TYL0WW7m5piS1GDyBa4bh3NTpOzylE1rSPW+XbJIViRcRXB5J5yQuLC4HoBpTon0FDjoY2V9F78G6QHHjcAlXtLsyGQxK79o9J5SJt6nJU0Hruj/6q8h/YEdGAGpZetYljc3MiHYI+Qmp9uA7o3WhNgCNcGAsXsjI0nOk83yIqe8Rn/fvGsNKSzGrf82tS+UidQ8sVvPYwDWoyEQcMa6wfR9BT7mmNjCS3o2EODxgPWGkMzYHBaf7YTLgONmjmGmG3d8E9i0yHrQnkkk9uJBXc7aUJ+20/G/XevshVdFBi7zwgl7MnbPO+ErlswZO0MHmVPC9G9NFwJEXmp7TxEsAfvibkvDOdTpEyI+IW2pLSxBAChkfYUGfTNbnskcvufZ2mU4uu6uD2KhTBEKH4Q6QbgtSFnjArXW6VgE596BAfdIEN3VlnThkQPF0BLQbrIpS0++9l7vij01XpF+TZgnyS4IlYCgQ37rpppVbqUgH20Cr9eodwjjlTUaSRiTofSbLMio6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(508600001)(7696005)(82310400005)(54906003)(36860700001)(4744005)(26005)(2616005)(70586007)(356005)(6916009)(70206006)(86362001)(4326008)(336012)(8936002)(426003)(316002)(5660300002)(47076005)(8676002)(1076003)(2906002)(40460700003)(36756003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:24.5161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe6c18-bf71-409f-fdac-08da2d46afc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add the mmhub support for MMHUB 3.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 682d7842aea1..bc11b2de37ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -109,6 +109,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 1):
 		mmhub_cid = mmhub_client_ids_v3_0_0[cid][rw];
 		break;
 	default:
-- 
2.35.1

