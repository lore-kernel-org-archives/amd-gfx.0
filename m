Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472BBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E75210F8AA;
	Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E06310F899
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fov6w8OGbpSMAXWg/1cTWyNN+J1HeRl2HxRWhh00idPAzziLlPFCuDVJ/XmTb6tRNf6U02hD51assV3hYA/9o+6y1jArdWlNYQds66kyqhl0EHwrIgUlzdLPxShQnzvu58Nz7mcv8Bn6JQVrEHM8LUD03Xoe90ferkMy6FbsDXuxS56/LDO29CgC/ojDaZh/MvSEQXn93VlPFK57J0LOX23MZoQso74WE+f1j+Uksi9cuV4c/RSAR3Sn6xHwtkXM85n+8CJ2beSVrVPe/Km0k4wOZRYxvYOlfdBOgaWsq0Dcjxd2TbLDl4phEIBxBxsc94iM2/CLfiSzcflPpQAy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZPhc2d+LPBPr23gun0Fo6U7i9YJx2kZ6ReJJJPZKlM=;
 b=SK6ZCT0yMps+83ZAXWnQDN43su0OysvNIzG6z27N2hFyeg+DGhcuNL2vJmcxYW18+CUYtfcHpCOh2KxbS/WZAxYnSA5R2AZjlTPt79B/lxAzyieUvTJ9tll4cHB2KwsjScVw/gQd+fYWCk8SSwpicgP4A1pHet5n8N+VKDWe/kdLBWcWFndLnqO3EPIzlzxlCf2EnqhNAAeb82oCCCp+iG1Erh0ZmYdbmF0Vqu24NJhpa5kU9GOVvSxR/ud6tpPsWY3XF38lhRFZY8P3Zu2fjr0Dna/jNjYhnHOSX3Z2M3+ccyTY2Ny9s8IUN1JUtQmsuZPl+G9dZ5HXpcuJp2aUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZPhc2d+LPBPr23gun0Fo6U7i9YJx2kZ6ReJJJPZKlM=;
 b=dRajVF6/HtmVo9NWQWi2oXJ8ewV7+bcZQgFZMVrggFjQik2m0a3ncgPm3Lne8b1g4bK6G/2DVQCQkBvbQ/wgU84EFKO61oYT6RGhCkxF69J1T3sCGDBJLbGC1hn1XY5+B1YCICTXoYNW281CYX0z00Lq+Fg53ziFQYV9g1B2AlI=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 BN8PR12MB4628.namprd12.prod.outlook.com (2603:10b6:408:a8::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 18:02:48 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f7) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/29] drm/amdgpu/discovery: handle
 AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO in SMU
Date: Fri, 29 Apr 2022 14:02:12 -0400
Message-ID: <20220429180226.536084-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43d64c8-6bd0-44d5-d7d5-08da2a0a7879
X-MS-TrafficTypeDiagnostic: BN8PR12MB4628:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB46287A3715BDDCB68AB0083CF7FC9@BN8PR12MB4628.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pnxek/7HnWt1D4yccuBRVh6I0j/8PL+xd5q5TexMOAOo83a4l8IEfl1T6VydjEIs/YpWGzFTEBoL5jXb8Hz5R05YvBHtt31p0eqhoGiHNeH6GpDtDUS+OD7yK8vP6Lyy8bQ2EY9VGebSR+0sNlbBRE22mxAglN+mIHgR7bM15A94aMG2k1woDA8lwl42cozvR9yp0QxcGFb8oxHTrad+K43BxUaARWNSal++gAEjPlfYQh8MDcf9xp1IEUMpv6LsvmsdiVXky0H0a5xvIgT/1FSgXHn4y5LzhMcQJbsRx8WkdjJNl4ia655lzgKQg/3Cap//sZgvon2wKj6vq8/umIWbyGelcQtEJx8IMXd23Xfp5a7TJxcSwZr5OGcr3tCfchMGw0roufvEzNLy9oK4741Xn2VcsviwRhdJ10oEyH/jLYiiGhtIiyQn9PoDcbz2asWgfQARg9++R+iAIvq7O4HEKrAAqNXkBFcb91znIQDJBEUQ4NTeuEBrpFOvu5JpNh0J7XlLBtcieRy1P9vGcr7eg/0LYl/qnnyj1KB9TbzfWbyAW8D/NM89oLLo3/vbbelJNwKdHJu8hX08uGF5QaGgOIyJTOc9E4t1r9UZiz+2/LHgPaCFBB/5CV0cSPnHA832G1XDB4lshJpF57WzM+qrhpgvB4XdYuaVQ/I/ZTPNNfSZtMlYr0wKZKd41G5uOZOBhPHbbVDWSUvIhD2bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(8676002)(6916009)(4326008)(83380400001)(70586007)(36860700001)(81166007)(316002)(356005)(82310400005)(36756003)(6666004)(7696005)(26005)(508600001)(2906002)(2616005)(1076003)(86362001)(5660300002)(186003)(16526019)(426003)(336012)(47076005)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:48.3762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d64c8-6bd0-44d5-d7d5-08da2a0a7879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4628
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

Handle SMU load ordering when firmware load type is
AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO.  This works similarly
to AMDGPU_FW_LOAD_DIRECT where the SMU load order is
different from the standard ordering when front door
loading is enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9c177ccc7ed9..0adcbd38cf61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2292,8 +2292,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-	    !amdgpu_sriov_vf(adev)) {
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+	     !amdgpu_sriov_vf(adev)) ||
+	    (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO && amdgpu_dpm == 1)) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
-- 
2.35.1

