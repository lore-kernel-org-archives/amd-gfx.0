Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F74C74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 17:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787BD10EF67;
	Fri, 17 Mar 2023 17:18:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549A310E116
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 17:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2mcGU+pHEnWZR285uStFp7HkVTcgq4d73+KGE4PIKbvDxifQ0Kq1VkR5oyqUjFRZYCP+gLw+IHjL42c54KNY5S0oSi4gvYTe/iqx1Pg6lJONACyd24BOhz7yIJ6/jbnpBcUyxC9icS+JZGi/itpCITHGsq0H/n7huTjmvNdMpyv2zCode83l6jjulBQp+GBO6Vs7+3Refx3ANkcjon3ZA/uLtsBEbWT+7Rn0N3Rgsi1rw+I43eUkxMT57YUCrx+MaGM6WeKgOGTMunOaclvXqzJ2gWgSFT42nyU0lAcldzLvo+QpeZspWYZsONSvXcu+v4bjQ/xmzSb+BcsRZc/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIL8UyeCpht6mTWs5J8lsOKOf0FEvCVqKVQ8jiQKn6o=;
 b=dp6RFKdLLAZfB22sLSCHiY5U8O8gpm0xk6JJzPTfOo/B+X5C4WFmmojBY/evUjQry9fc+Keo6NbqJ9VTgkg8XsS2vuwDQXt/xAdjlh1EaaRoE0kNk+iNJiKJ3lHb/y3ElQRvIHllptcco2wT0yb6Q66uYI/cS82rRwonMzoTL6FVEIPBKgEXxDdHNT6n/slwyryWLmcGbByYt9NbbXPAGmEa+iPYkdeOAFRtK7PgKZy4UugddUUo696BBxKGJLjKfFVBYRl0BCtoEpVE+LXWwmxiqVJR8I+jqEWKLmesXdTgbp539ZMmfkeib+7UmdCbWqPGRIYI4/fA70JICsixMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIL8UyeCpht6mTWs5J8lsOKOf0FEvCVqKVQ8jiQKn6o=;
 b=awPqPfKaxVR1A45NDnCE2hcXEBMZI5B/nCDjImYyVr8UsuroJioGu7Ug3ouJLsPYIuANjwmAJKySibfQOqpbH1d5JIBk8+y8s3NLf4P+eGpwaIJ4U6xX7GvZuQ4iyVmAySJXZ1tS5I13yq4sNDUnoTs546rvKTDnQYWULNrMoNw=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:18:10 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e6) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 17:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 17:18:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 12:18:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amdgpu: don't require a job for cond_exec and shadow
Date: Fri, 17 Mar 2023 13:17:44 -0400
Message-ID: <20230317171748.682691-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317171748.682691-1-alexander.deucher@amd.com>
References: <20230317171748.682691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7459b7-8bea-41c1-6bdb-08db270b94ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGDBNz99owB3XyjoshRFiRh6e/j6Q0T7yLhHLA4l/br4Yr3rQu+9aJ5cBQh5qWpuXZTSFbOZk5L7dd013uoGTF4gY29pCmdP0AUCJOuIHfGIOtbwns6O4eS8OWn5wwUN37Psl54KX/IFRidLf7hFPR5IqbvXjkVmOqN72ymmiS/RDTFNlgGnfpfNRrubuXhrZKDki8yMhjpcsaFAEyneWB90BN5uGPfUD8O6pLnSR9txoyJBZIvxdAbxpbntOrlTPuz6IBQdQbmp5WYefg9aVj/+ENf2UKoWdKESgb8MVC8ZGLDvlzh3OGIQqx1tszs7iKX/9kaaH008uj7CpEJCtJu5zDYmzl+djsGJvMUBw7RYGcEegk5C+l+DUNlKpREiPBRVUkYb7Hkoall4iCT0oO5pAYQLrId5hkw8m8lgS/TtqYqvIcem1nd5A1RNCrU9Yvo7LycddfRpPUZyoiLRXiZs6w/z569opT9NdogI9z1bYprkvxUDBRc1lZkdFnkyMUs4NF3Wd9GWpzqf73vJoWZhAiwBc974jvVEww19c8n66qlgqHp8haQDeGRztDX9SIyhHIoP9qOIdNObAHHxHRye9jomEhNDHWNOUOmiUar3lVe1hKEsTCwp/23g2ZCtWgU0NSZ4UjfV0XCKcVn9OAzOeiGUIzvc/SFS0wH+H95bSs9OqNtwhoEaisn2Lnq2ERbyg+PJD7OzEy8C+yAUFfHwgWBfutQur/FMkjFTVYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(5660300002)(8936002)(2906002)(82740400003)(81166007)(356005)(86362001)(36756003)(36860700001)(7696005)(478600001)(8676002)(70586007)(6916009)(6666004)(70206006)(4326008)(40480700001)(82310400005)(47076005)(426003)(83380400001)(336012)(316002)(186003)(1076003)(26005)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:18:09.9118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7459b7-8bea-41c1-6bdb-08db270b94ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset the shadow state every time we submit an
IB and there needs to be a COND_EXEC packet after the
SET_Q_PREEMPTION_MODE packet for it to work properly, so
we should emit both of these packets regardless of whether
there is a job present or not.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d88964b9407f..cd5b0df44ffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -213,10 +213,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (job && ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, job);
 
-	if (job && ring->funcs->init_cond_exec)
+	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
 	amdgpu_device_flush_hdp(adev, ring);
-- 
2.39.2

