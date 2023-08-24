Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16380C7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7818C10E5E5;
	Thu, 24 Aug 2023 21:59:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D249710E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjFM9VAC6w7qCswCFjB8UhHogfKX4TgYDj5nP3aNXY99x9cJOifpauSKdwctpIEuJNaa+Fc5J5inXmqnV9cBiWZnpOKNMEVWvTCvK9GAUBhWTZBpoFZYtm93fP7w6A6Aky6RGiw9jztJob2AJ5/LMaeY7APed3AdOCm2wwqZZ5YLSHH1Q9OrGbiNgK4QbZDCbzqfyVyI6iu1A/VvILyt921UaGRl6Kd47j94a7KJjAdaLMZ4Y5BRjYAlK6neGvHQTMCs8G0OuYCMwtc6AGFG/2RUVxlf2uW7CDxv0cglg586YznNnigAVa0ZrYHVkWjTch/xejzRsw15WJjbrp/SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COlUixIMBGTEXmbxQpFgHOSv3EZgHs/mU8uImEtUOZc=;
 b=NFGB9F9pp9F/NgubjDhDTvL+ae18OnEt/v5r7TQb+vn9nl6N5LnvitSJrrF3eCkEnA0HAC/zCZVazoSivqDCkULEI50RkMNPJp0waj3xc1a+fvmIKyn+YEJGF+712PGS13zyQo9u4aBxLZlBMaF8Vg6QHz4RLKO21EJuJHiZh6vq0cvtJgMpjE7JWx5uRfy36HKahe+3wDMpRuKMdOd/0M06pngcYZv3xZ4UExM64UP6Z48mmJUOYC2p8HDLn9EbVT03jewh1jof5BIyeBQvzPERnVtu3mcSVJetWwQwENZJXomoko/SYXqQxt/ljUPbdZ7a2aUSgBAbmQfFXpUazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COlUixIMBGTEXmbxQpFgHOSv3EZgHs/mU8uImEtUOZc=;
 b=BnGy9Go8TiPrJdqEHd6lxFwoguZB4TPmludl1G17rjncye17cQnzIfzgWF4olYZCRcCmS532Cjut7AxzJFq1IHz5N7aBFNkyqLiYKyOsNbrmevz73pCcesil+SdVPk1uQ6BTpDxC00gRn12DrSdNTRSHTJcRp8GR8WKd17EXfwQ=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 21:58:59 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::e5) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH
Date: Thu, 24 Aug 2023 17:58:35 -0400
Message-ID: <20230824215835.2740115-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: c9db1be1-8122-46dc-2ab5-08dba4ed51c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhQdqcPm+sa9l+LTdPgeXiXqmFo+WR5QWWyfSJNVHw8QBekro92WSdEOBix5TjxlJG4WsVa6WQA78XjT6eos3yOcz/vn1mBIV72IChSWIT15B9ftG9dVtqC5bD+/4zxKIspmwV0db4u48cCn5NYudk14KAB5/490dwI0JPtNSxCkBC//x77PaRGrGR9FQVoXQiiEUJZUtuy7xnV+EzUYYD47RMmZG2GJ0BvKQWJG2WD/G8OxwGkIZNBg+nTbjMeSE2tj8Bwc4NmBpNHiGd9X+2O8yyUcsc5R6Y+DhFjE7VBs26/OHfxfcWhdQxsc9Ob3l6wl9gjBMK/Dg2hOqyNZHuUkLHRtxXWoWG3DH0g5SfEhsNuL4jEnv+Q9mfc5Qg6KXuLqfBmAiyA08VesC8BUoHj0EdXSzXiimh9orHG8cYj5PmEGitwH1mks44/jTeMuvktVrSGmxVkltD4JMH++FPtyJcisH3CnTV8rs4l1lViMC6Lv7FawjDVtRphtixqRB3eyKB8i2/0kj/5nSEtBdKqehDjc/ZHR3ES6qHjzt/MAiMnrOtrWlAPd53ghfsr2irZTzGHJYlO27OBg6shXUJJfyX/KpXTlBdsxOSl3uaZNwD4T8jM5eqi5sl7uMyjoKt8fb+M6tJ9Kmnkau6XScJboxS0udM3NcNC/8SA3CJQQVvIii2st9hoBBvJImApvv7o1JNCIGqS8ZyFAGfpI/mg9vDNQ1SKMIGJJQTsEGmWie7eBBYDjFSrHI3pzPacEWFnP88cg9yQUwyy+xMLi9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(16526019)(40480700001)(26005)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4326008)(8676002)(8936002)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:58.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9db1be1-8122-46dc-2ab5-08dba4ed51c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Align with FW changes.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c         | 3 +++
 drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index d3dec5f21bec..67164991f541 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -279,6 +279,9 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 	       sizeof(uint32_t) * 5);
 	set_hw_resources.osssys_version = adev->ip_versions[OSSSYS_HWIP][0];
 
+	set_hw_resources.vcn_version = adev->ip_versions[VCN_HWIP][0];
+	set_hw_resources.vpe_version = adev->ip_versions[VPE_HWIP][0];
+
 	set_hw_resources.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
 	set_hw_resources.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
 
diff --git a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
index 086ce7792c29..beadb9e42850 100644
--- a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
+++ b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
@@ -212,6 +212,7 @@ union UMSCHAPI__SET_HW_RESOURCES {
 		union UMSCH_API_HEADER header;
 		uint32_t vmid_mask_mm_vcn;
 		uint32_t vmid_mask_mm_vpe;
+		uint32_t collaboration_mask_vpe;
 		uint32_t engine_mask;
 		uint32_t logging_vmid;
 		uint32_t vcn0_hqd_mask[MAX_VCN0_INSTANCES];
@@ -223,6 +224,8 @@ union UMSCHAPI__SET_HW_RESOURCES {
 		uint32_t mmhub_version;
 		uint32_t osssys_base[UMSCH_MAX_HWIP_SEGMENT];
 		uint32_t osssys_version;
+		uint32_t vcn_version;
+		uint32_t vpe_version;
 		struct UMSCH_API_STATUS api_status;
 		union {
 			struct {
-- 
2.41.0

