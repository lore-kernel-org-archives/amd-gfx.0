Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8897EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DB3AA480;
	Fri,  3 Dec 2021 22:58:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2732F7BB0F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxQ4DkcYVwghlYQVzlyojnzR7LUlVaUtJOWaLFY3pyZGNYKA9oSPSz0i8+AI4/Oq/uAgSNhJt5dkJihJ2GWCdNxdQQ43MHJ8wlI06oXQsbEZH7krPIMMWP+MOA0uSrhqb0qJw8+2asP36/krv+EiENkaFS+pu77rUvIsDE4xA5F++aFCrL9QmCXMV+WFxD5+zpDBIQT5qRjqRz/NxkUnIeAkiBq1bpdTv5m7EhcSeQ2lO6GRRrg1YL8FNuMrEnjzz0kCG+bWFQYM2yoMTq2Ui1QFGdaPYXjNVuZhhFIjT76aUdRm750EuH9CkYkxKTpiysMFLfXeV5RZ6IzBtrbKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuDYeJpGDYZVj6yvaoFQt+eZtX393YBdIBU70mmC+Ec=;
 b=VuOVvrWfpQJcmF3zjhdQvVpXhYQ06uS+Nw4WjJXin9IW0i3lfwpph42J11xcaXi25w1mykSfmJl/0sXKmIm0epUPcilETuXBBsE86W6xEguJMMZGvXNvVtXrDKRgiEsqkyd1tHFWlQPyV/4FgroOeCQY09MqWPRT+wuBamOu5OcVWCdS5iWJbQnL3BsDX3sSYWhQz/P0FLr+5A8lPRIiKQloCtx9nCgDlYsh7HORHSCFZ+3YIAdsgvJFOD8EYqOwPkaZ9dDwXTm6Q4E7ds3CvJiOn2bT9xDQGgPYaYj4Agkc1zWHbEgms8HzgHYMIJ7AFrG4/Qm9d63W8j9BNKMNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuDYeJpGDYZVj6yvaoFQt+eZtX393YBdIBU70mmC+Ec=;
 b=4kktqP26MmNm6ZyeJSASTuK23JuJ4WqkbgOH94zyYKxrsSfinrgsj5HxGWsV5pXQ+pJcnz+oOZNE1OtywZrd9A+F+j5Lw4odQKP+PT5VH1XyhgBtu7+0ZYDMLk6JIlNkA40e3zkpunsJgygTmDQCr6ktO6tHNOEdteHRvDnbQSk=
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:58:45 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::bb) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:45 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:41 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: Fix DPIA outbox timeout after
 S3/S4/reset
Date: Fri, 3 Dec 2021 14:57:50 -0800
Message-ID: <20211203225802.651367-4-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daaa126a-7d79-468a-1fd0-08d9b6b07576
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435676506985CCC23C1F7ED5FC6A9@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxwjuLDwknvpZun/Z9hOyWF+NrlcHyQklufUOitFC78GUaH+f9pV1HUVM7FfcnZiQNgc2wpbgTZ3M/pVVYYgfTEWQohsj+0Y1irt5ufBFrxRWNfpagwGBcFHOCUMZXXAhnFGk5sWHBlaNGaXrU/xxsi6pfBge0/OVa634wbVasNYqFIcQJr3uTiic5X6xD4r3eeR7ZpgZl8mQi+Ku3YCg4qGZXSuhJ3FhWBF05uDhXrCi8GdlqvD/07Xq6pb+rJJnnpqrsQnfcfj4J93wXepxbg/8aemSLp2rhh8HW4MZwevYJqwybX+/UMTA/J04YS1xXR86IJfeoCl5gD4mF/eU1vDL5v450P5HN/Nyy2B1cjaVedRBAHiQZUoWStNNManvrWOpA0dzcutcemKpAyBT69Sd7NuEHl1um1rk+Rclffsr6WOv1ZZsBtePRh4PGoY/3D8bnRGTrgh8foaBMToCuMjdqF6eXxbfjrvI85KB5BNoVHzMh+ozd71odE03mFPOzVExgGriV3S2s2t/Gv8GeCi3ri+KDIUjiLEI75KjZ9VQ0VZ83SSWKWh44wjIX2SbHvVIUqi1CKhOz9jNT1K9xGfARFdI16AxDudqXn4DIO2r0HgMfvnJOdw5+KHs//8l9gaKYqMhqK9K2UzTEx8lrl40WTeI8qkIzQfUoNgdHUw++L4F3veb13pjK81jmMBkjz7CpubL9bG6gljnRYBoc5Vk0GA/9mDPZQzuf+1Nhs8YkrDbS/DelknmjFSFUZJJxY1bmAQxngJDrwjqi2uVvv7+EUrFyakQzKt0sr+jjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(356005)(70586007)(8936002)(83380400001)(70206006)(508600001)(6916009)(7696005)(426003)(36860700001)(2616005)(5660300002)(47076005)(40460700001)(36756003)(6666004)(336012)(1076003)(86362001)(4326008)(16526019)(26005)(82310400004)(2906002)(8676002)(54906003)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:45.0341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daaa126a-7d79-468a-1fd0-08d9b6b07576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jude Shih <Jude.Shih@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The HW interrupt gets disabled after S3/S4/reset so we don't receive
notifications for HPD or AUX from DMUB - leading to timeout and
black screen with (or without) DPIA links connected.

[How]
Re-enable the interrupt after S3/S4/reset like we do for the other
DC interrupts.

Guard both instances of the outbox interrupt enable or we'll hang
during restore on ASIC that don't support it.

Fixes: 19fde255f248 ("drm/amd/display: Fix DPIA outbox timeout after GPU reset")

Reviewed-by: Jude Shih <Jude.Shih@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7837e0613717..3b6dd92b0f36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2575,7 +2575,8 @@ static int dm_resume(void *handle)
 		 */
 		link_enc_cfg_init(dm->dc, dc_state);
 
-		amdgpu_dm_outbox_init(adev);
+		if (dc_enable_dmub_notifications(adev->dm.dc))
+			amdgpu_dm_outbox_init(adev);
 
 		r = dm_dmub_hw_init(adev);
 		if (r)
@@ -2615,6 +2616,10 @@ static int dm_resume(void *handle)
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
 	dc_resource_state_construct(dm->dc, dm_state->context);
 
+	/* Re-enable outbox interrupts for DPIA. */
+	if (dc_enable_dmub_notifications(adev->dm.dc))
+		amdgpu_dm_outbox_init(adev);
+
 	/* Before powering on DC we need to re-initialize DMUB. */
 	r = dm_dmub_hw_init(adev);
 	if (r)
-- 
2.32.0

