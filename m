Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEACC48BF3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DBF10E80A;
	Thu, 15 Feb 2024 20:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GkFXLjEx";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944A410E68B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPoTe9hyc5txsqvsUxDNgWVVG/O+IG/QHP4VtaQi/KtSv2+4L59jYTLOeAIC6EqSyf/P8Uo6CPoNVWiJFZojtf9Pm2QVUQ5O6jiQ/rBwbHe9lWY1oiQKyKO8lO0FZeQoZkjspAp1v1Q3xVEftse6o/zX24T/Zeoa2yS4/q44FzWfWZKjeLN0e7W0zCYH8r7U2YWZ04B+IUhnNUN1Mly04fRSYT8dTMLvlYI5za+i0bsqd4TPaeEgBeU0/HKzmUmIN6aml99MdJ/JwqJf/SDjaEgEMzwacYF5wlbYjsO3T5gObZF5GQ6Tmtkp73/TwFaKxgb+dSVE0K49pdWxPeUe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yea54+JF08B8HK0NQPxFHJU900b4UOm5YVWr/iYvga4=;
 b=Kc7N5QdzTlx7dJjCAXzQHMKjtcS8QKPW3VvwhPsmeQVOX7e6R0Re6AZa5Nt4/JdNbzIUo++RsP7lwMfIlDwQQt+SdKcb6iitrgPCHex5UywEJB1sLlTaQOjtK+ikgsnedC3XvwhUhDHKCrVUsJVmoVzcibUdduuZf55BhKYiPm+TWwl9aQDygIIraS+l+31lG33X4ob8G0Gxyl78ZFPq6CMIRnpcbAKzUHQXHNXm8eQE3DqL9A95fVwmHDHmPs/LOqSyNmReKat1b+FQHIlmF7BHKVvs/vxfLXd41oo1whT8DXluy3eL3Xz2ZNu9uyVRtYzPySI25wbKdIZvs5qXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yea54+JF08B8HK0NQPxFHJU900b4UOm5YVWr/iYvga4=;
 b=GkFXLjExwfCnQ80VzqqY5cC3ylEjsH6ZDUf/EjNrClXqk8uOAsQfRevHLwFd91Oprjy/tMxYNt+mLRRF3x9H5KE8vwCn6Ig//WI7pcPlBlQERaZshyZKXirYAiSTBEfIpXqJdV/kiGhjGpgidPbMTD0+Q+mZqIGiluCVMnau6ZY=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 20:40:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::2a) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <Tim.Huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: enable CGPG for GFX ip v11.5.1
Date: Thu, 15 Feb 2024 15:39:52 -0500
Message-ID: <20240215203955.415314-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db072c5-837f-4226-beb7-08dc2e6654cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0+t0RmM6LGmPcnGwgVtKBJCbyRMZMTk3WV2wktqZ05nPxdqH/fQlHGMNseTTblQmUWAiT72Af6tQ2uykk+xuoXyN3Lt2qvAVwIS9nkVIIhGSm/jIahV7HIP30jHSUw/TZYameDzhNePbGvVYiR5phYirhn7CHnpHB4wM6BpEzLzHTBrkigGqHjQi4dK/meIRYXfqSURdsQw0jeRSUtFgADK0flNnN791YXRoi4smSJh5ayymQ+gr2tZcQt0nu5I/oMhlOjvE5fyzdqShurU9uwCVVn8nSvNRGztzbE1ba8cb+2VWGCQq9LyyvVFtwYZLagR/V6ompQp4wHVnpeSx16HMrvgpMtIaXFMyz+djBvixmioPjhZeCJrAi5eyDeKgQZPWq3yQUt9uSg4GIx6jUmHgPxaYx5xRwU6JquIr19rbF2HUaFsefKfJgL7HY+uo5AMEi5sSQjQCQL/hyZqD0gIIE3Y8XDGhjDDy+J1NmtWLR4U9ei27JXDoqlh7dS3SCeAEAcBbzVfq3ln/D5m/naZ1Erp4KdWVvQr/ZM4qQVPjl1AM7VSavlvm4OJr+0mV924sVNmLhX0rwHmzxhtYa/oSniNmaarp0Mhn3rKUt47ea3TQJyQ+3zreVVqZPFNM3mt6b/SGZQAzgoxXkjLFjdBBqDRWJKyJFrVtla0KlI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(230273577357003)(186009)(82310400011)(64100799003)(36860700004)(451199024)(1800799012)(40470700004)(46966006)(4326008)(2906002)(70206006)(5660300002)(70586007)(8676002)(8936002)(6916009)(86362001)(81166007)(36756003)(356005)(82740400003)(83380400001)(426003)(26005)(2616005)(16526019)(1076003)(7696005)(54906003)(6666004)(316002)(478600001)(41300700001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:22.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db072c5-837f-4226-beb7-08dc2e6654cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

From: Tim Huang <Tim.Huang@amd.com>

Enable CGPG support for GFX ip v11.5.1

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 71b3a0688555..2c812701592b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -718,8 +718,27 @@ static int soc21_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	case IP_VERSION(11, 5, 1):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK	|
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS	|
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags =
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0xc1;
 		break;
 	default:
-- 
2.42.0

