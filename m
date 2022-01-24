Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D67C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2790F10E2EB;
	Mon, 24 Jan 2022 03:21:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF3410E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh5AAgJwDW81YizZz4laQ9y0hzkMJUw148SlQlUyqdh5jpB9Vv+qYiN48ZYnpTnXhXYWUV0nvNBmvIlQhsPgQkyyoj78OczMf2v/f2DxgR4Sw6ipRwofToWHSlQPUt9TuWh0u7IXUkhxxcK6bM9nmYyyds37uXb/AUn19aiPcY3jvSVkq/foSquB1i7afbysF1auB1yLwzjCUXecWcQ/pZSqFiR+NZEBCb9AP7f/O/pzCu/0KY3NUBg4fpxzVR8yZNzadsHaIjcJWkwKxT+kBGpriv2GkR3oakbQszRroSKm18w/ZjXg2KO+4TaD6NFWSSj1TRR9b4tchWh5xSCYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OCh/Ury9rueo2YIV9crqw+3XOn5INkMznrwFtTiAjo=;
 b=CIAWS5G1f/Pp3OGw+xddAUREiXLoslsB80Q1+i0s4uw9ucz11nHOR1ZOzt7bTNY+4ZtB5SOjMsmsoQ/FE8zCSZtBXuV7K/bJeODFNxQ5N1CBd+YlvgxRq7ZiyMjqcKjQ6sFfere8kIK274zLQDg6XOnyMLvyDwijO9LlmNt7NpFpT7GFaz/eSII5DvOuA9FCnPCZB+j6otZW9YhlqtyjYPJuM/15MEfabcd9e72IDnORiOPGkzRQRX5992ve8KSWY3bFInOvx6Sh7zqHZhmStZvz/9XFP0MKmmFu8/FHBLlig4XCQqlRrq589RQHEDG4Ecq2wTQMw84CFPk9Xov3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OCh/Ury9rueo2YIV9crqw+3XOn5INkMznrwFtTiAjo=;
 b=Jk1bG2qC3No4si63Yk3PSDe8+L4bcS3uYO1Tv+53jW4MqIkfOkugMl4L+8vR0O4TShO+FvC3f7KladV7lf1W5aU//+kzeKG/wh/HsPQmxKJ86HZvL0Wk+W4+IydS/ymNmKB9GONPP1duHtPwn13V+xKKAa+Ak1HrY2knayfq+zk=
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 03:21:37 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::da) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 03:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 03:21:36 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 21:21:34 -0600
From: Tim Huang <xiaohu.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: convert to DCE IP version checking
Date: Mon, 24 Jan 2022 11:20:42 +0800
Message-ID: <20220124032042.1974371-3-xiaohu.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124032042.1974371-1-xiaohu.huang@amd.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a68d524-875d-420f-34d2-08d9dee8a147
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53433EC7B8AF3CBA821F1713F65E9@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jpm+7u+2q/Xk2ofpAeEQNx8IDASAaS2gSd02a1nqyKj5el19ewdPCaSM5eANaPNaem59v7cnUl+Rmh6eiDuHpQ86oTtvDtk4mmwgRaDwHh0zw2fu1K4Ud1bJPimpIx87SOz46TGW2tVFzvSFD7i+d5vF5VyTmLXwsBGsIBVpI7tbl0e3kpq8gSOLAG1OZAr8AY/mwlUDpatg1AzYj8Dl4wUWaZr1L8CbD9IAMcbOKr5guj1lnxuFQvugTrKKTHOdwZ5/fo0H4zL/jIm/dKMSfMDLp7y6F3pGi6EMv8sSozoQwz3AVRc9G0miNkEz/MXiZ5OFl5lWzx1gqNagK7gVCtbU/ptO6qmFDZSrGdvVAJXN4N6Hu66uTkFTp9O8EX+YQozu+x6eDt9RrR1+07u/4/q767niEclsAaoXUUEyFbkd7lQQM3/XK3RyrMrqCh2sJk/uMu+riZiv2Ld46bhcC9oMWRM7YRoawt8Ffa0YGNzrgSAfrJr0XuTebYojVZfHdL59YDBFdhpMiFBn2bFMvtwyPPbJIBGoubcFJ4YlWAzUAGR63kahHPkEYjx9HYpt14udDqojIh5DMIxCCh/FPR4OdukpEVddvyRqUX1VcUkqmwCcBROHtoEB7iro3geUPZCVe4tfMJcbWNrnAbc9kd1/WAH9pfe4BnrcFsik1WjLNxGS2hBB4EFQiniaGwEg52JXiB82yBQRVGzVoQtv/GMwYtaOOrnFEPxehNeKNMgmiN1kTcP7yYnD36VUwPeuFCKEDhGZLmjy21gHh5rE1ydM7i7AUTcLgs2SMut5bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(26005)(8936002)(83380400001)(2906002)(36756003)(5660300002)(356005)(40460700003)(47076005)(508600001)(16526019)(336012)(186003)(82310400004)(70586007)(70206006)(6916009)(2616005)(1076003)(7696005)(81166007)(6666004)(426003)(54906003)(36860700001)(8676002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 03:21:36.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a68d524-875d-420f-34d2-08d9dee8a147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron.Liu@amd.com,
 Tim Huang <xiaohu.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate IP version specific features.

Signed-off-by: Tim Huang <xiaohu.huang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87299e62fe12..c967e1e344e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1119,19 +1119,17 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	for (i = 0; i < fb_info->num_fb; ++i)
 		hw_params.fb[i] = &fb_info->fb[i];
 
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		if (dc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_A0) {
-			hw_params.dpia_supported = true;
+	switch (adev->ip_versions[DCE_HWIP][0]) {
+	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
+		hw_params.dpia_supported = true;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-			hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
+		hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
 #endif
-		}
 		break;
 	default:
 		break;
 	}
-
+	
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
-- 
2.25.1

