Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 19:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F74F89D5C;
	Tue, 19 Apr 2022 19:38:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3CE89D5C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 19:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaGXkPBXD3+r3QmK9gcDsphBV1oFghbm0DEjy8uPRXv7f5L84tz2Bsfu8FgAGPrGhVd6whR+P52hpMlje27HlTYRLEQNSvACnikisMdX8pxMYwE2R0wH+Px0xkNoFNNMqUo38eIxBV0Q8h92KQUhJnbIBIyCCAhiwlsvrMIkscUvEzpYH+nJ/txQqWWCcl43ALKLn3x5mOCwc3PgQ6enxrHG1FUL40yGMhtB+X8PIR4sy5bLfrxNteFjBS4C7yAXAlmPQ9k7Qd2JkJN6vqSlZQ1jq5xxtMO11KLH5t5QP/qXqzPRRYDqZAeO3ii/MzGt2OBJOGr6AQn6KiselBmxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9oipWpkHc5cc2sZuWYv9Nj/25bkAY7acup97LiLfj4=;
 b=HEqZ9DkJPRGXiq3ZrTHgV164YHJXZ6vy8cBx/wpF6kLbQB2aCGBaO2PXJ+0ZcsGq+FFZbDCFY6Ffm+AMPmsihayQ3aqk/DZBA/lzpYaATRw441tiVnVhDuj/DN5KT2SPo2xyUOC7RxEbkFukviyAY4YC0PRELq5IGJrtuVl41jwlH6g2RH2PvX4iBE4CunemV+KSvlma5nBbGNSwbJNOF5o30oo2WtWDJHWecFr3Lis7klXpDshWz1sNwoOIqS1KOVN+4AsYYfH0JbnCD+mvw0Uja7pkJ6pf2jOnKAe3k1UpKeDkPuf4S7W3OtrPImE924o4saOzxxuX1ZpKZa8tGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9oipWpkHc5cc2sZuWYv9Nj/25bkAY7acup97LiLfj4=;
 b=iQlzRQxkv8dXtbbN0Rgfu8biRyBGjZdkkBq1i/23XuZUmwdTCYyfDKAQ6EVvjz9vSm+2/pLfShxIbENkj7trckSwlXBTjRF8GwaNIOe1SK1/I7zP8sgDa6mwLkj9puKy7nznIuX6VEKeOKf8GrruD9wYBCBn2uYCDOqDhKDYuFM=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 BN8PR12MB3441.namprd12.prod.outlook.com (2603:10b6:408:49::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 19:38:33 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::60) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.21 via Frontend
 Transport; Tue, 19 Apr 2022 19:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 19:38:33 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 14:38:32 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Execute IP's hw_fini when hw_init failed
Date: Tue, 19 Apr 2022 15:37:51 -0400
Message-ID: <20220419193751.1856508-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd3d69e-c740-4e50-044f-08da223c3097
X-MS-TrafficTypeDiagnostic: BN8PR12MB3441:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3441972C3B77DA9283FC0DF5EBF29@BN8PR12MB3441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ao3GD8CC0crEz2k5BG00zKl36/+0OpeTLPB+Uo1jRq77dmaDv6uydQxtqtsQnhnrSu68UEAQmYW8EcfaKAvSCpD+pLaE83ICMeMXe/vaXl/CyeChfrW/vZekvB9I8Qanjd4s80kJVHby9ofxJMJXDBbD7TVJN2rIbjbVXsPd/Yz04JFJkIl7/sPN9FyVZ9BIN6WHe4lyV3SLsCpqU1VmWnHW7j8uiNUnt1rUQf+mdaXofyFLMqTc9IERhC6JqT2lzCYPQvye9zC7+SeKg1JNe+ylyHSKiySH1dqvxcbFp9opPebZZ6+EeEeKQritLQss6Tsok3Dd49GVqELr/PhYRW1+9SJ+J7dKXGmtl94bz3XJ/FIpxaJyK/AJezRZ+os/LxlOC4pMIn+WijcZ4V8d+QMe9uHrjlm+lgVAbYGMxjeBtm3jkpDybTbUq0uJ5NbSg2oP2hCOKEDEh04KqY+jdc7QecmAPEtuIrCGy1ihUe+/Avv+GbMEeL72KYAVzHE+VCtxmoWvHPCu7QGFlE8TLPqpYScmIrfbc3RksI3/kiLPC6nFnUUxVRTcuu4sEnNXeV5NtVBVFrc3kxhtIV/u3ShKDd2lYDIZo0MhUp9IRZ3YvJSkrINFd/Jo0ZulHmwLxapF3H71DLNPK5Nj3T63FTeoKMnjb3gcP0qShDOMbUOJlqdO04IHhZY0ET8w1GTmXo4XqvomwGA8W5uI19rCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(8936002)(40460700003)(2616005)(6666004)(508600001)(83380400001)(26005)(4326008)(2906002)(426003)(8676002)(47076005)(336012)(36860700001)(316002)(70586007)(5660300002)(86362001)(70206006)(16526019)(356005)(186003)(82310400005)(1076003)(81166007)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 19:38:33.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd3d69e-c740-4e50-044f-08da223c3097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3441
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
Cc: Alice Wong <shiwei.wong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_ip_hw_init_phase1 and amdgpu_device_ip_hw_init_phase2
call IP blocks' respective hw_fini when hw_init failed.

BUG:SWDEV-332449
Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ec38517ab33f..3abe647bbd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2281,6 +2281,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 			if (r) {
 				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
+				adev->ip_blocks[i].version->funcs->hw_fini(adev);
 				return r;
 			}
 			adev->ip_blocks[i].status.hw = true;
@@ -2303,6 +2304,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 		if (r) {
 			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
+			adev->ip_blocks[i].version->funcs->hw_fini(adev);
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
-- 
2.25.1

