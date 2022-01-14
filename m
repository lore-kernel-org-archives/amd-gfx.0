Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AE9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4FB10E219;
	Fri, 14 Jan 2022 20:38:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8499510E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcMiFSCOj9lnZMscOTIJeGy1zS+FyTjvzyMI+aYk+eVZjQuFMQzwRWcywLki3BXTxric0mVdaH+uF9tWYv3f8QVQqTfN4CUJXPvYkKi2HW9LVLgcaYQKWGPpJjRFZmpV/NViqLKoh0Rxcy3E5aWSs7w61tobNfdMmltrYHgdAD724qbvYRsbnUWhCYJug6KXo1L7qQ1fQKha+UCnOjwR+YSjr7+1TSKgSlA2q9X4ssBndjF2hqyJbQzE+3gfmFIysuHuVx2ndohgnK8kjByoQz5UenNp2pxoSPE7ZHcWIeDgpmyrWT0k9JhapX07BsVmztbJLkyVRtFdr7CyGQxGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipNJyYqByt1zbAT9mdtRFPEZ7hm7mSSwf3G6T5RysDs=;
 b=iXa/IO/B4hIEjiJNX1uiFFnEIRiUw67PC9dlY3JvNfbrN90iTJfg3YOQIzR2Og9bO1phFaqKF0AA1Nb2SpnCEcZpN3LrMvkFn9FvWQHxRCE74R05ZFSR9Xe/cFZTJgOeJy3q3OcUQWycRh5xnY6GKV9cd7cfOwSh0jw4/PhH1odMXbPjRb0a4Bf747Uawk3hub6wX/04AIAX6u7EIscYFE8Emwwin5V/+C6BatN9OL+5F79erRAPTZwWuYahq6MnZgolyq1CBvL4onxo7xdxkSBrZGYOESrWfXAnWQ+R+CNJLtiaHxBXCGjmUt8tCQhMSkfTv7pQRBV+6hcCOcq7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipNJyYqByt1zbAT9mdtRFPEZ7hm7mSSwf3G6T5RysDs=;
 b=5ZJRj3vf3i9XL0MkAp+/bZw+OqWAL2sBeHb/6/Ee5pWcv/j8odLArJpcu8d/Q5qTdklj2JDAtCFlizUOclgwXdY9FOc7o66S7437cdisgqKV3mpWkDGD1gF42+H7nWoz+0XynGHBrpHfyBBytyYmiF/BFbx3jvoGpk4rQzYlPr0=
Received: from DS7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::13) by
 SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Fri, 14 Jan 2022 20:38:54 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::7b) by DS7P222CA0024.outlook.office365.com
 (2603:10b6:8:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 20:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:38:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:38:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] HMM profiler interface
Date: Fri, 14 Jan 2022 15:38:34 -0500
Message-ID: <20220114203839.21707-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efef99dd-e247-4777-47b8-08d9d79de10f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44319F3B048C5367BDF05C4DE6549@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAOdarNzEA86OjgR8Jj+/SuXt1ky5WnYDSEXa7Bcd9imy3AJi8ZhXasitir6S4SzDy6lYnxFqOLNjAb1p/4qyHfhinHOyICljazIGNL5LZ2s/ZL9KSfRFtp+UAwXMhgz3aCGRnyzO/A7FYr/KtEW+IIc4vbqN+ypnmB9Kyu/vmJ2E+0KlMg/yQApFmijQEETGQg2bfWDeCGbYjApgybAOV2vjUFxn3X6SMcpaEPMOL8ro84xRr3kOe+9Sv/oSJxJw3X7dZQ0UJdBFyogqq+1k1gdL7/x9F6bZOGiNMIpzwdqoCwAFoPGK1dJrVQaG50Fonp2vAHLrYlme4Wf4d32jfoybRoH1ylbruaaUurW/QHK10ffa2slEwLn1jyNtSxkwlcKq6IFVmOABktENa+wqt956gmLG3jh1uXlWa26oXlQJDOA1PlvNuwIN9YrZJ/6tihGa7JRaikAP9uZKLnM29B1o4o+JIn1YXUUtdwg40dHx+mL8aX8K3aQ0MdKpdoRodkVJZjLXyhUqc9LYfXYWgDsXCF+jWuiYsFT1ydrdgoQY1boruVF0rbyxdBM1jIuhp+GxNyJLRv3VRDixPVdfQR8odSUb/RQHtOdgL3royUCP8BdVi2Y17UgkxKbDAxXlMn5E/gX6mHf140vFTPGC/jIW8vry+VD9GF8SvhnpzO+86+m/CqNzczvTp/lWA22UKkFNj+ddmp1lTYwQACJIVHYMf3t/6q/HEr3RGyLDT46ymP1lmlMj2w+gu4A8/bfjZbV//pd6zOhsmk0yxrwbtK3rE0Zt9zhVRi0J6/2wjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(508600001)(70206006)(70586007)(186003)(26005)(6666004)(7696005)(36860700001)(2906002)(356005)(5660300002)(16526019)(81166007)(2616005)(40460700001)(316002)(8676002)(8936002)(4326008)(336012)(6916009)(82310400004)(36756003)(426003)(83380400001)(86362001)(1076003)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:38:53.4566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efef99dd-e247-4777-47b8-08d9d79de10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ROCm profiler would expose the data from KFD profiling APIs to 
application developers to tune the applications based on how the address
range attributes affect the behavior and performance.

Per process event log use the existing SMI (system management interface) 
event API. Each event log is one line of text, starting with event id, 
and then name=value pairs for the event specific information.

Philip Yang (5):
  drm/amdkfd: correct SMI event read size
  drm/amdkfd: enable per process SMI event
  drm/amdkfd: add page fault SMI event
  drm/amdkfd: add migration SMI event
  drm/amdkfd: add user queue eviction restore SMI event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  67 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  36 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 133 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  12 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  34 +++--
 include/uapi/linux/kfd_ioctl.h                |  27 ++++
 11 files changed, 282 insertions(+), 56 deletions(-)

-- 
2.17.1

