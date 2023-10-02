Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6653CE776DA
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 00:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C1210E137;
	Tue,  3 Oct 2023 00:25:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E5310E107
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 00:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWmgR+DMuan/XVE3bQtcbtfqTnEKwoI4kB7+KrMRwJLdUOl9BdGebl75CeLoANfsuUymj8mB0HOQ//yfPRLDDLaNqM9QtT5/X3PdpbATJwyRlsrnM/Kn3HXxc2HxccKvKDDCb+VnM41Q0lGXxN1b9SceplGSoym4OxUOS5cjMS4PQPyKms79cm1FreYD601iIhrWIQ/AfhZoSuXeTpiBnHOwOhSdXKcunSgg7aDJ5IWe3Kgw+utng3cDqT+KVWM5pFGTXIuXbnT6nvo459kjw4r67dYdus68DuIjmNxaVzKtBknqbMfJHY+7VV+bXlnLlLNkXYzf0QVDv53hfxTWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlEEpviJmSiW+phYOOHQOBb1B8vb/zfcS77ccE7Mglw=;
 b=M7aaUvZlX3MdMep9DgIOhdcDgwN39GNaCsL1Cw3VFN2GBCLKTkezLK+3Mbi/hS0pW0EpyFBb6bHFwDHfQ92catY1LYLE8Noozw8ab/kNSELCqSdJaARP94iDa+G05TxyDMfVAUS+JxwfgB0LOFMb+uWD3/sTbLhmRJiGjFFf1/LE9PpbYMjwBAvwrs76CN4MBlDsG6uccinQ0dgq46L98avbyGCLJQVDIhmEXoEfVkyQQ7Y3Q1nqgcL1tKmzd76yAa/U+kUk+EQmT0iwcCWH9XEyX+rLsxmhe54dQWYpmaqayq7N/oZKCmel3Iyi49vQuRWF5dazXi+AKEXYJpYCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlEEpviJmSiW+phYOOHQOBb1B8vb/zfcS77ccE7Mglw=;
 b=R+IQoZd2Apz4oTmxg67iEbqfbd3raEiXfXY+tGoXA4S9libCbu7REkO03Z+OywyyQQEQkGzqprVRy9mG0+KZT5fyBMrs4EE1yC/SNEiizZIXvKCNJ8G2ycPYfgX4yNUfZ9y/bpBMgSvpTVwHInGHAPFkY/9YspdwrQ3x4g/cXb4=
Received: from CY5PR22CA0016.namprd22.prod.outlook.com (2603:10b6:930:16::24)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 00:24:57 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::87) by CY5PR22CA0016.outlook.office365.com
 (2603:10b6:930:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 00:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 00:24:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 19:24:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd: Move evict resources suspend step to prepare()
Date: Mon, 2 Oct 2023 17:44:48 -0500
Message-ID: <20231002224449.95565-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002224449.95565-1-mario.limonciello@amd.com>
References: <20231002224449.95565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 09476d32-704e-4c55-31b6-08dbc3a72c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08vsyH9HlbU2QI9lm50NhWZ+fUknH4X1LZO8TiG4j04e4DezwC9UkodRC8JeE00P3UBxNcwtU72k64rU+BI0Nj6oUE6UanRC7W6Mop4Oaz0G2l8yzJLqCPj2DiFVAH1J2vqV5HlqCrUP4RYClg9ne/WJXy2CuDHL/Z0P4VweuvgRdWL0VQ1ux+U5OTRT5kFc1gQwuzrUExI59Df5EwWvmJkk2BFXyXHsSxbUqXkYnVq/wc0A20NFZ2D+wH5IdkhaneW42ivXcW5beNaTRkREMkAvsxAR95WiciKWOFtksX3WRdnEfVRk4iMUar/erl07mwroNl/hWJYMQBEQs1ovledfavFErktrW5N7G+unGPhpoHwObrJv/a6Cds+UT/gVIo7/p1ol1HoS5M+sUq04YnrZcCLH7k2n5zccv3bvNQLEV27xY4F3kFQhKPX1zNXV2mN/q0klqCFhiOwkm+wM4odvngqeyiOpYTzyhtxG8Vz8dlHCbbBFjNx1bw1YEzf0qumm9uWeLTWHgW0aWHdN9vmkcPJ8iltYwBQQ8aoJts548MJuhpSVq9UflCuoI5fY2mFFSKPlEt5w4BamBPgci6GUDTvbQpPSnJRVzqLy7SdkJUDbDh9XSj4MWqA6gRjN9t1lCVPmFh7lAVzzJZ0+Ws4EnjFdVAMcK7h/wLGZdJjq3lBBMoWVUuU09vLAV4OmP3st5t47oFXUnp0iW2dxVDkT0h0qaBMRZyzRvCtS9XGh1QZdNp0EukGZ0AtJpOza
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(46966006)(36840700001)(40470700004)(26005)(16526019)(40460700003)(966005)(426003)(336012)(8936002)(4326008)(8676002)(7696005)(15650500001)(2906002)(6666004)(36756003)(44832011)(86362001)(5660300002)(1076003)(2616005)(40480700001)(478600001)(41300700001)(6916009)(316002)(70206006)(54906003)(36860700001)(70586007)(47076005)(83380400001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:24:57.3313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09476d32-704e-4c55-31b6-08dbc3a72c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So instead move this step into prepare(), while leaving all other
steps that put the GPU into a low power state in suspend().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c41d69e7a8f5..bb0e753fb6f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4276,6 +4276,11 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	/* Evict the majority of BOs before grabbing the full access */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -4297,13 +4302,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	adev->in_suspend = true;
-
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
-
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
-- 
2.34.1

