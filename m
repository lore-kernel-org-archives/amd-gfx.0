Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A44EC7EE22
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 08:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB95010E5A0;
	Fri,  5 May 2023 08:24:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1875310E5A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 08:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWqAeul6uJ0JrtmuJtOZWhPzXx0GBmdAMbH+/2FRRswhkcVUJAJDZDTi0Cyru1zOzCm/0Ts+jnuUzlSLgGM9upTPQ8NnccZ5K/0xiJYPYlwFSODey6PXDG/qArk7Ijcw0bF8Cw5Tj4spdiiJh+9glzxiQp1c+iFmD8HJmYZWjnq2NBx4I1Yr8P3hNTMXtIW1+zUVScQHBScqBseyjLPswzm+o+87edR/AIrkYnhMn/jDg1PAny68nsEkTKOFaJuASEw1SAm78/1iIL0wE6ljwefhGdgtdpMc0Z3LHUKn7aLhrrEHz2pdoL2HD65EmlfxrLZAzaG7cIuz9O0RnVTgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ8vwGGNl2oQewX8pucAUJpW3b5JzLXZ7CjTxGOBlgc=;
 b=V6qEQjawqysUoPWJtPxQJlV2LhtQNiN6iPu9ErnNzpU4xVHGrJ7tNW/XFU+a3R9I5fyMLcj/RzYgAy9Om3W1NeIZGKQISntrhnEw2WNbmA1g1mu+alfqijLYF0huY61L21ix2LlSF41Ejz2DYtkkXOKn9zbZfzHBS9np+opQIaqi0/ihFCypOIkgeMijQhTjOUT3QUF2pIsxfGeU3GOqiy2QqzAygy6TjSAp0N8y+u9ExTRPdiNGizLJUdgTkctZYk32WcFJtOrvMrP0ePxQGpf6P2mTLzmVpkhI7Pe7SxOWc8X8mhAS0Y0uQeVLk7pSPyYDqetNcGTMZH16bLZx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ8vwGGNl2oQewX8pucAUJpW3b5JzLXZ7CjTxGOBlgc=;
 b=1Ca1xX1lhmh4iNeWbjHw1/if3h9CGXVJwV8vS9b2hFYkQ4qqf2agxdEg5C92mT7iE3NyubvRnJ43FMemoHzuCa1WrBi7TjcosoD7Tu4NoO83wymp/1MrIN5fjopdN5dDUjZ+Fyp3Saj0fNDAc1KHvOiAH6OJ0M/4w9IhQVyGp6U=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 5 May
 2023 08:24:31 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::30) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.12 via Frontend
 Transport; Fri, 5 May 2023 08:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 08:24:31 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 5 May 2023 03:24:28 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Date: Fri, 5 May 2023 16:24:14 +0800
Message-ID: <20230505082414.1194477-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: bcab151f-e07d-46ba-1452-08db4d4226bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFfbeBdrBti5WZYvgger7saZiiVrxk9u5kR5E6Z5UHT+Ip1JkPSXXAQ1QO6JP/lMZLwHMxwMQZqFycCYsGjqcC8q7RIL8NPB+qowrvMIWb/9iDA325gXaYme2Q+jVRzBjOg5iq2J18sODpO3nXFHiAF+A7Rq6JFAs2fV6/6IK0WeWvp2AVsaUeKVjo9DbOtTyUHw8xVWPKuombX/I4Jy5kETI6DG9u9HnAABvS2HrJ+PLXjrTiho+yK4XEvYspMPB0zV9d3aLJvCN9DqfSQu8hRF2IbFWhkHazKBBEy/BqM0Lpkai9CfeuVd0/kcWT/hf9SQRNRwETwsb296Z/DAG7EmEJI5CHehUD3aqoWj18f2E1XBGUwBCYbjWo6YjAvq7T8RwMUtyAhOd5a64LWV1d0Zs2c5bqL0EjurCfJ9dd5qbImy/hA4rlSa0EPrusO1gJjVcudvm2s1T1eDp2L5MMRkH7hl0uUltcBCFtVHbWRE62mUIbHBTXBEuqaTcn1GKj6iy/ZORKDz8GOEPCmAaiarxSnFUa4ZUjF3G/BNg6x/HHPRLr/DTNpC6bXPgm4ORMXoEcJTSngsC59vBfcOVUS1un/jAXAfFXq+6qK/gEH9NAzDBLs4Wxw0VFv9e4bZ0u705OC18kL7JlEXNpSQtpUdrTgs32XH4i3pRWkEW0Au4GJVaG81wgTU8gMpBCFq+xfManNY1uwCiSlX3XgDsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(426003)(1076003)(336012)(26005)(81166007)(356005)(316002)(82740400003)(47076005)(83380400001)(2616005)(16526019)(186003)(44832011)(40460700003)(86362001)(7696005)(2906002)(6666004)(82310400005)(41300700001)(8936002)(8676002)(5660300002)(110136005)(70586007)(40480700001)(70206006)(6636002)(4326008)(36756003)(966005)(478600001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:24:31.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcab151f-e07d-46ba-1452-08db4d4226bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_dpm_is_overdrive_supported is a common API across all
asics, so we should cast pp_handle into correct structure
under different power frameworks.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
Fixes: ebfc253335af("drm/amd/pm: do not expose the smu_context structure used internally in power")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f0068df2d073..ae45abeab5b5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1455,13 +1455,15 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
-
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
+		if (smu->od_enabled || smu->is_apu)
+			return true;
+	} else {
+		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+		if (hwmgr->od_enabled)
+			return true;
+	}
 
 	return false;
 }
-- 
2.25.1

