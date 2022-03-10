Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E4FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 09:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EF110FCC8;
	Thu, 10 Mar 2022 09:07:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0977110FD04
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 09:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIMYE9kwKKX5GgtPzVTKsffdXL90m/v3DV/o4Xm9FoMXcMQuW0/eyxX5ZJjscCaGAvNGfUMcpEmtv87jMfubAe50QEjzBsKJoq7CfC6WfpBCrS6ZHgvZmHvmNYYWP7QCtCZTdWYEZ9Ggl2MMWjNsb38PzdDcLJ80hxmQ9iFZoUd5Sxx8qZq2MZWL2g5rjAhMZ+0yifM7fYvg4BQ5umgjEouXD5UbABRS8pciEKU0CqM1ZIAKoMCj1JhMZIcaqmN1QH+oZg0v7KKcEP6EFzOOKPjTWyVeGtmrJs/L3TFfXxKSfNpOB653U+l6c4lxdf17bDzHqU36Df86alIb06kdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrZ4e01qqABicmL00T/hfl2IDmzOyrmRhlHU2ZgGQG4=;
 b=c2TektEbTT90BUktkKh4+dDMc2y+Alo5ccLr/1uAVSr7HSVg9Sg0ilOEBupuqKT8mQYhxtUx5pL1FyvKojajynMSvk0dtVQr0/1rnv31qeOYxdIhmyhLGPCn0tQgy++xwuvGWOuHKoz0NtgJK2T8q6FnzJxCORvtQgsRmznCfbjWK572EGPEwF3dfx/Wb3Om5zi5I3BHIqs9mfx+4WOmA1ALkUi+/Utdpln4VYPvS109lU8f6htGsnggs2d13YFurgKLP/3/DMTLkCf9uzSMCK8/9WijRpYA3i72K7zbOvZgJidaMszS4fmQ3lc7Drkc/KAe0FGk4gUzXYJhlv0O7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrZ4e01qqABicmL00T/hfl2IDmzOyrmRhlHU2ZgGQG4=;
 b=f6uh+xSDamghSza0qpTg6k+6Nnw1jw0XLvZGp3Mt4ixOuIIwR6bZUIrxrz+aTE43kwMICy5IFQtz1tuCvrff8uBAuBh97GMVsf2kpUOLZaqiqnTByvvufvI5cxFYWmCrCK2NCsqRMYmoGwHaa30/9NwNVfNK68zQSMpjvarXjq8=
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 DM5PR12MB1740.namprd12.prod.outlook.com (2603:10b6:3:10f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Thu, 10 Mar 2022 09:07:35 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::c8) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 09:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 09:07:33 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 10 Mar 2022 03:07:30 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: schedule GPU reset event work function
Date: Thu, 10 Mar 2022 14:37:02 +0530
Message-ID: <20220310090702.52749-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b771d1a0-c7ca-44ab-74a7-08da02756993
X-MS-TrafficTypeDiagnostic: DM5PR12MB1740:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1740E9EB4F91B30F1E5B1F2FF80B9@DM5PR12MB1740.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAei2mtyHjCNbV2TPux4JMUYMg8ALe280GsWVqrvZufVXt/utmY6FTS/apbQRqdQxkacoUlgK70rXTlcVLYoIYXiQrnFjs1UQVdCphE2Aw5JMe8G3ZjJYui11EDnorhUl4pSprBBeI3fTuYcBpFZq+Ngj9+EAmwfGulSSa4VR67Fw9budLie6WN431SaZPMw3dfUqpKvWAvS+QzpIImIUNoUkMJ137KEwsCf/Wu7jZ8nSw4X7aVm05HCSZxYzPMm/sxBW4cQyxIBNx/Yme2odXi4C92T9dy+3Ren6u5cZHAQ0Oy4SGhZpTpdF/YHxK6ueqCoo0lTikVQH2ZKelfwkEokECIB5A/KgwO/Nqzb4LSMkqlSJ4eRj6NSBMVb0hroX7IMXn0l0aLNJmX8KagIhBNAxadx7qB0wNSpCdCOg3F8dcpueBhkXDOOK6pti0D61gEAffaEFkCQYgNqBmcYixnq7qKK7qiq9EuB4S72TT5hPyzYHUxKfON8uH2nZn1GQGcWTE4SnwJBXjn3BrQ36Ic+nSJmkZnf2KhUbEUwj9RKsrTV+kFumdXozZymemdhQycwzKooa2UHIRyqZ3Nmat7+bd/JUvCpxXMd1cPoDb3I0P30XX1Ety/h2VT40ZriO3DJb0nQjVkIkVy3IvTL3qji5QCMDRbpMHPSbVQMiA+GCcqPh6WV1XqPEgM0nyXBG4lCinxCxV588ctLUw7jUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(2616005)(8936002)(5660300002)(8676002)(4326008)(70586007)(70206006)(86362001)(1076003)(36756003)(2906002)(508600001)(26005)(316002)(186003)(7696005)(36860700001)(6916009)(16526019)(54906003)(81166007)(426003)(336012)(47076005)(40460700003)(356005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:07:33.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b771d1a0-c7ca-44ab-74a7-08da02756993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1740
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Schedule work function with valid PID, process name and
vram lost status during a GPU reset/recovery.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 02843479e1ef..7ca4f52e393f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4805,6 +4805,19 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
+				if (reset_context->job && reset_context->job->vm) {
+					tmp_adev->reset_event_info.pid =
+						reset_context->job->vm->task_info.pid;
+					memset(tmp_adev->reset_event_info.pname, 0, TASK_COMM_LEN);
+					strcpy(tmp_adev->reset_event_info.pname,
+						reset_context->job->vm->task_info.process_name);
+				} else {
+					tmp_adev->reset_event_info.pid = 0;
+					memset(tmp_adev->reset_event_info.pname, 0, TASK_COMM_LEN);
+				}
+
+				tmp_adev->reset_event_info.flags = vram_lost;
+				schedule_work(&tmp_adev->gpu_reset_event_work);
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
-- 
2.32.0

