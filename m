Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F9DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D37273D7E;
	Mon,  6 Dec 2021 10:19:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCFE6E0DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Dec 2021 10:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/BvaFep/lJgaaBpYA55IbWhqCIzs6TEogP/28ETh+3PneBDQzRgwSsOd3gZe6PeS8dCTUXxqyKSIZOKW57SywJw0iKVpu8UuOfPfIUvHAWYYGCtYQseMKhpQPjrNkdT5sg1mr1Z10fO1qsNbWujUBp3x+NxJLfRJV75K81F3OHQdMtTnVgBPIZA6Udbyx5min5Zb2EdO90YnsypFGkBoXttmY8CsdpQHDV5nl9Ux9yoqtmOMm9jGl2zb/ByI8JFuLM/Kt9IGmi5vsSnIUuTPMLO9ymJOcHSvbE+pULso+8c6BRbmXXqVSWd4ky+T3+zXkr/OwhVyoRxvPBrbUjR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6D+a2dEt7aRbp0QyQyir6giDo+UV+kjgUyd6wWud4o=;
 b=gGgUSdBtYWtx92jQJ8zw4nfrfCHjZBNmBggph6mjoax3MVGPsueVI82CIzQLVm4hRMw/FqTzMp2AOHH1jtitLoKw4Z5MOziyaWIv6GFvaVeTypfgKorV0ZQ3xYJeMHiFNg6/YiFzWMEi8tdUzu6UX+IPD8fKYeMBzquE8ZNhYxvjGGZWsqInyqq+Obzwcxguf3pCJY8OSrAOMTcrNX1o3rDK+mZcIQzofF4Ewv+pFptAi2UPjGbVdaZxXWXwwsxL5V0JqmPQu6l9x1/k526PSo7w22C7s0eNg183DSU89sKQAM6SjZ1vDd2tMI2Fh+4YcrsequGfFEGKchyLNON/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6D+a2dEt7aRbp0QyQyir6giDo+UV+kjgUyd6wWud4o=;
 b=q4CgOPTeIn+ZeLiJJRva0Oj1s6+Bh6aiPC1YaawGo+1GoynsoZ+r93ufGZqNX8/sORs4oar/OR5P83tOSTRwak41VpFdG9ODidcX5fWo3aqIwdg+Dt1sB5nB/UlKs0lTjUB5C6FUpxCQFhVWUj8zymJ465Kar03WlJ4ZclF/TzY=
Received: from MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16) by
 DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Sat, 4 Dec 2021 10:20:52 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::62) by MWHPR01CA0030.outlook.office365.com
 (2603:10b6:300:101::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 10:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 10:20:51 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 4 Dec 2021 04:20:49 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: rename discovery_read_binary helper
Date: Sat, 4 Dec 2021 18:20:30 +0800
Message-ID: <20211204102032.3063-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211204102032.3063-1-Hawking.Zhang@amd.com>
References: <20211204102032.3063-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc8c6d1d-666d-4071-89dd-08d9b70fbf9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4562:
X-Microsoft-Antispam-PRVS: <DM6PR12MB456236604E1778B2B64D517CFC6B9@DM6PR12MB4562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4dI5Tolhk70SKR7VGDAOjiGKyj63nqNUBXfZF8mjBCX6PFa43Yqtoc9vyJyCVXPyvVvrA7/NG6yKpX8SHL+NCX7iugRvLzt13eclgG6CWI2rUPkEedVrksmWP3Xc8SYLnRrIFYfl8EwX8d0v8AWqJ1bLzaqSBQwf2F7smchN0d7IZSHyxvpLFHqimjR3Dp8V+JdNW/ne6TkXJhh/v41F7vtbn3dFpqtBYsNCet3VBzwbKivRaMjr32SnBRmaLg5qJTE62g17o/owmIt+MW03sZrOK/LDh4cCSP8jCLsyDpSSGHYhK5eR2TnXm04/iOPhChXx2uqXCGEGuvLVkoZiw9Fz8IK3CtPw2QfdBmBrlvOfMVherkCfY9whtfbiHGd6BU0Vyye4g9wBxyMc6QKihXRN8Y5AkYQO24acY6xAW2bhfxvasSU63dhkqNNazEhdN1JVCUA0b6zan1HzmhCTirv3VMFpZHb8cpKmjUhc199LnUPY8WJr8kHpVLB0h7NpG0fHg07YWLiNoUxe6Nz2VZJE8EID5SSoc8iocwX4zwBp6Ud21mWfBzUMDgjhaMgl+W5VoE2kSAfjsU3N+g0YTEEratmGiJyr7UevzCZOCj9iteTqFduHyrBH8PK38gW7KvQ2Rmeo5gOq3IPQ0rRtpWOtae4H8cZEOr4SREV+tp2dXcxBc1nmgQjmPXYruDPCkhg/aVplWbjnQ6vhL+w2+sJ2QmcO8v3GNaE9MOvRJ6RIIMi8VpKGjiGcxjotjGfLCRYFwosFcWY6KX3vbQTjC68DqjN/2d5vgzfYaEqGvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(316002)(26005)(426003)(5660300002)(40460700001)(16526019)(508600001)(336012)(8676002)(86362001)(186003)(6666004)(2616005)(1076003)(8936002)(4326008)(83380400001)(81166007)(7696005)(2906002)(47076005)(6916009)(70206006)(356005)(70586007)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 10:20:51.5304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8c6d1d-666d-4071-89dd-08d9b70fbf9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add _from_vram in the funciton name to diffrentiate
the one used to read from file

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8ec60f826c7e..cf9f09044eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -178,7 +178,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[DCI_HWIP]	= DCI_HWID,
 };
 
-static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
+static int amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
 	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
@@ -260,7 +260,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		release_firmware(fw);
 	} else {
 get_from_vram:
-		r = amdgpu_discovery_read_binary(adev, adev->mman.discovery_bin);
+		r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
 		if (r) {
 			DRM_ERROR("failed to read ip discovery binary\n");
 			goto out;
-- 
2.17.1

