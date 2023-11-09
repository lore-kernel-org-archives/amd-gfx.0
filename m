Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7102C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 20:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FEC410E912;
	Thu,  9 Nov 2023 20:51:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C7A10E914
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 20:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsDRhJfE5PEFMr9T3a/jakgyCr3glGzFEP/CS/UjBWk7AWKGOzMWrK2Xb6K2qM1PGUXgczWlwy690ImD5LVPoUddpZslH9bL0w5XJPSruvszJIvhuGMKMDW4e7mKvBf4hgZAEGZSnE/JjqG5Oi3aDJ/QfeK8Pb6GNdk/oXXOvmgZV0Yu+1WB3/odGbK181gdYJ7hbB35p7W1TO3fSxe5WdD4GbX5e3LoIVsAYJj3tpu3Qh+8jG8eGS5WTIyyUKwWyXLVy2vrStvkwBRnok4ugZOg/x4D7vp45tJHo3mlrrnZfzPx1aWfnVasymlgAjFhogrtD9AHsC0KQIPDKIitKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5sVN9LrbLZms68ut6Ab7EIYwoNSD8BXBZcBEWDaA5M=;
 b=gSfaCOmWvMXV/ILaimSDjUBgAJoPbpEya4cIAWXzeZHnnW4yzz/K9y5VNS7GqVOEqaxhhlJcqKg6GYa8Z7kT7IzcOsSRS+ef8mkvrvQKJ23xwT0GHtksuIO+p9U//+H1hK255dGcrA3obZ188oRtk+jevXgnOX3PO8JmKXw3CmEPHHF43YMByZA2apd22HqbPKqTtEJDHPm1NglVmXcEV8GKwndhcUsG62dION1wzPoO4Ry5/pPrHSmsyyhV+GTYl+PDhdqx3bezCkNsBPooCPD5oJVZ2j9GKVetn84te43hWqLKGyRixIu9GW3YpR2PlnnQngSEBBxLLco8GHweRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5sVN9LrbLZms68ut6Ab7EIYwoNSD8BXBZcBEWDaA5M=;
 b=zPMfgoRd2nANzSOmTbzA2qxs9QLfH3BUJhaeJBLzUGzQLRM1hDPB7I+BSCczI0he++DY5C8SawIjg5GmdnSNybCJTGxmNZXE42etnQi2mrryXJjy0HovgwrfX3r4H2kTBBtTTmTi+9+lZT+BdeouP7WnmyGx8OsPGVr3Ktu6jpM=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Thu, 9 Nov 2023 20:51:40 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::3c) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 20:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 20:51:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 14:51:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu/gmc11: disable AGP aperture
Date: Thu, 9 Nov 2023 15:51:23 -0500
Message-ID: <20231109205125.513643-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109205125.513643-1-alexander.deucher@amd.com>
References: <20231109205125.513643-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5a27aa-b4e8-4b7d-96e5-08dbe165ac38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXxnY3IxxkNBs2JHBVpWk7DwiZZI3m3sQzlKEJLIkPD4Z7q6KzQ8QU9IJVnIOYAKpVMt/bjh571eHNy5lKozooHMSfYGNGt27ODRU4uCJR+BDUnduHn7fZ8qIkcrDa6qWCglQiCBtWT+FU4a+ltyUuzQxOlcQuOsHTiXsm02Bu5tR8Pls6Lbik32GxTdJQ6d2QtvfWx5Pjykax3zAbetm2iefqK7/FpX6ALynnmuIEvG5Qx+l2DTzuhpLbpBJ8cO2Tnv3B+3fr7AoxxnE/fNidGIPbuxHETQEhlWAdWExnnfe7dQUzNLreNf7GCPrMFK40BKROjmsAhLhSKzUd9jvackCy8QWedh5ynOgPHf87jDlV4yFInY9g1d6uTxzsKlJSG02lC9xRBqJaNgIqSOJ4tprMjZLpSq4QOEyP5X7Y0WP6K5XINlAEBdZJaQKK1LOzppZSDZ27MGcKqyiVJ6mgmvlVbt2/1zt74E4zQJZOirDw0Hvq0skAIt1jIIIeCir7IZh7dIfl7uVPWVl5Aaojh/xqBFTtX53q+vwqTiB+J06ZZXQyuCEdAGMgUd7JStrToZp6C42QRKgk8lIU3FE95zvKbN3YT0ivrpv2gLw4GK6Owleofya8tk+ngpOujuwFpKJ4V50ODLfRA1+yoECzdEaQPuqixe1rgpTSfG/2iXfpiueysEBGzpqDTDo0gul9p1FbsJi4koFHmXsAtu2aU9WKbE8DzyRNmuWUEoDZKf5D2R7oh5PiT8PYXz7KnExv6SZgclkDwInB67pbGgog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(40480700001)(40460700003)(478600001)(2616005)(6666004)(7696005)(36756003)(36860700001)(356005)(54906003)(81166007)(82740400003)(86362001)(83380400001)(8936002)(316002)(5660300002)(70586007)(2906002)(426003)(336012)(16526019)(47076005)(70206006)(1076003)(26005)(6916009)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:39.9612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5a27aa-b4e8-4b7d-96e5-08dbe165ac38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've had misc reports of random IOMMU page faults when
this is used.  It's just a rarely used optimization anyway, so
let's just disable it.  It can still be toggled via the
module parameter for testing.

v2: leave it configurable via module parameter

Reviewed-by: Yang Wang <kevinyang.wang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e1078b53e942..23d7b548d13f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -642,7 +642,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)) &&
-	    (amdgpu_agp != 0))
+	    (amdgpu_agp == 1))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
-- 
2.41.0

