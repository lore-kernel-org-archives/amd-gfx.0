Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C80D6124B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C80D6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76AC6EDE3;
	Fri, 24 Sep 2021 05:49:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4444E6EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftKZ9ZsPiDNwvfUVuZvtf0N4+MMHNh47+NXnEfQsVkIj+vlLZLgcmBHkxwpbgMK+o/zg6HN2WYu2aQ5t05cwSKOLTir+zPuKpjpxG6LKuffR3pKzZIg7D/KFedxe3kPWtUdQ8ojCNBQ/Du9kKkIIj5YV1isDrYc9czwdjFMgfpcQtOI8O8AgKljzHlujjUZMmyjAAG5zPZUW/wbwNXEjYWTrARWZGVD7Nmafo1BF5pbwPupxiS1vU5TlvrD3Xjm1ITzC1bea5tpQSRrwygbjF/6KozwHQTcV3Xg0ndPIeD7uLJTe05KhHeCEg4u6oU8nBzWdXoXybJXr/2gTnmQe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=x+xeJTrCzZAW0ZaqmODPwymczMq05C40nJt7vgE0HtQ=;
 b=Icue+Hfgl9GIhQhK5BregpWrCcAHvqRt4iSwOS536JsRVE8TOJkdV76/VBsSP0Ln74Kn1BcuX4ULoapWpKY6mRgudnLZ/g03Fx0zTLO3ThK/zTOChz2qAJzY1dlSgRcT0iWit5c+cqU+G3ayT692ipA3eevttYLSo22i11dQg7uwI9F7VGRvVBxO1XGUGWqqMqGrFj7nDlKhFD/4Spa/6FzgVWZiVdoWi4XJ3uq4weloaA1oRwmQHCbunGvORUdiqe3d1Pci3IwbLgIYJjufht4D83XS7uZJOmddRCI+kUFt2LgndnnrxstQYNmj7wXrFRAXdjJ4awoDzexmlw7fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+xeJTrCzZAW0ZaqmODPwymczMq05C40nJt7vgE0HtQ=;
 b=Q3cUmVeTCnOuOFWwLSUYzLTGp2IeZdU9vxrRBn+EWh9hOQqnPbPI4XJH/P3vggyhdjd0W+VSjXy6fvoWUxqWbf2D85J51gEWFF2NR/lwLCKaf/HJrvvEe+Uoa3XfbC8Ghy3wTxDfnBrF0zaek5xQAVbcl1srSYIUSZ2evg2yyxs=
Received: from BN9PR03CA0194.namprd03.prod.outlook.com (2603:10b6:408:f9::19)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 24 Sep
 2021 05:49:23 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::6d) by BN9PR03CA0194.outlook.office365.com
 (2603:10b6:408:f9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 05:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 05:49:23 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 00:49:21 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: configure iommu when kfd init
Date: Fri, 24 Sep 2021 13:48:59 +0800
Message-ID: <20210924054859.2301209-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924054859.2301209-1-yifan1.zhang@amd.com>
References: <20210924054859.2301209-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e9c2a31-94a0-431a-fc62-08d97f1f0f9c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0169:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01692F6C0ECD8BE940CD22ECC1A49@DM5PR1201MB0169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zYENVRGxRogSGV+UG/xZ0cedAYzvcnF4uRYx3m/dyVSYQUuXlbmyiy8YmTeUYCoIX0WetUEB5T6CzyUPpK1rriQDzpycNdsDvuTmQdZuFbqA7wNzzCELj0bcQD3uzoQez3IvCGtxenkNoYoHVUM/v1f//H2tU4RMY2jZd5v8VwXojvLkE81y1tdxbYesrw6B4RsjvvgO1Oj5guKD4LLztgrz/aKHmGDigt8WwKK7p28CLTlO9B0p9qDt4Kh4UFZVF0VDEZdFgTdpX6rcUJUgWrKvSz6FCxeiPNXsFVzt7nLkdnk/Kxlo0edyyVfE2kIfpPreTkBxYAA6bW2vV1k7ivBzbsYzMWZQa0rYFYheg9csN4W2mnWiDryMumfkW5MUNzMdTjOUa3zOHzFPA+hA8BgcX017H2k+y45lB5xkvY0j70iDdU/7NBOowCKnGfU5fgxZrYaz34/kxBR0ynStXvVS9rYTkGe3UOkA39vyLs4iZajvBjNe7ldWxgPjTWx1XfUnVJn0ekrMAY68i5GukGzyyHAihBsIvm8boaz1cYcax/Xw15yAi6jyxDU+g4L1j7fwoMi6uCHpZhDRGebIMAeP3cE1ytPMxt1qLZDA4U/qy/huBaoF2jt/LAIUStKixZyWi4OpFyJVAZb3tyKxPQQX0kHRVps9zr3B+Bo6SxHKoagFd1h8kUePg0bikC1OX2gnLlEuNlybgD54mZafDqpSuBKAtS42h5MAkpPHHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(54906003)(36756003)(426003)(83380400001)(86362001)(186003)(8676002)(508600001)(47076005)(70206006)(336012)(5660300002)(8936002)(70586007)(316002)(2616005)(36860700001)(26005)(6916009)(356005)(16526019)(82310400003)(7696005)(1076003)(2906002)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:49:23.1866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9c2a31-94a0-431a-fc62-08d97f1f0f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix clinfo failure in Raven/Picasso:

Number of platforms: 1
  Platform Profile: FULL_PROFILE
  Platform Version: OpenCL 2.2 AMD-APP (3364.0)
  Platform Name: AMD Accelerated Parallel Processing
  Platform Vendor: Advanced Micro Devices, Inc.
  Platform Extensions: cl_khr_icd cl_amd_event_callback

  Platform Name: AMD Accelerated Parallel Processing
Number of devices: 0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4a416231b24c..16bd64852b61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -924,6 +924,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init((struct amdgpu_device *)kfd->kgd);
 
+	if (kgd2kfd_resume_iommu(kfd))
+		goto kfd_iommu_resume_error;
+
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
@@ -947,6 +950,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 kfd_topology_add_device_error:
 kfd_resume_error:
+	kfd_iommu_suspend(kfd);
+kfd_iommu_resume_error:
 device_iommu_error:
 gws_error:
 	device_queue_manager_uninit(kfd->dqm);
-- 
2.25.1

