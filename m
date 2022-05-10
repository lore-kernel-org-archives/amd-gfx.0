Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEFDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 06:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A460E10F171;
	Tue, 10 May 2022 06:30:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB47110F2A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNN+9GE2h5g2bmdBEvdBsSfZQE/BOaxVxgL8lh0fd6JH06oU+im5P4Mhv6lc8Ds15qjLZ2HGA48U+9KI3b3BMTdnTlcnwA0+mJNPcT1O6KfDuWEud9xVhVwm0V0Y9lrLEnn8yHkMj2wtp30rA89DqBuhzy7HQxdw++A3YSXNvp9R15/fK973klXGNKwtYsOKfcP7+8tAZIKS5xlcNqWJqNP6q/Vk3PIdjwv9cNTcb8gjFJIOu14P4Vsy00smMDKK4SiwJBj2PF0sDFaYQDc6bBjmW2K86UDEJIDaMHI52VZ6pL5vENAzl2IxK0QS8huuE8Cm0hj8Ew2udB9FTp8pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USNhFMsllXtuGS+17fCdPRO8IucAGDKooh9QKQv+QgE=;
 b=FM9Hb0U43c1Foh4Nuy+8Hi+pNSWzU2O2tikLhyfc6f+RTiiYaiTzuaXW5AkLekG5/29A/BvvztaPI/If7SE5sIMWFNAL79PmtN8Zgg5Mk0T6vX9S5eM5WR71/Ot22Ri1Zjw7WEDLwGBhMvMJVkg/jFQ8ltnX+43Phyt0gc2nbfGoSqmKboIDmVHMlDWqfSl6G70vZM0L/oKSL1FovCyYTmkB/FVwrYUVR/89iriX24zUoFIvAbBfHoBvyZTspq+3+ehxAzdVMR6zcbiW07FzLH4ZeCSdnJj7TGBcS3wE/mY6AMlC1Hwsib/HlFXGMV8Xxt15EsRUo39MKEki6Nykwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USNhFMsllXtuGS+17fCdPRO8IucAGDKooh9QKQv+QgE=;
 b=nj77hpIkedXsfS8cGEDtwHPLSqX8FdydiCNpvOMpGOPN1TX8WK96mn7wUguggU1Xv3LUvOEQO2JfnL2gPUa+xH33bApMjcF/W6yypUg2z7ITD3F/Ru7arB5ZYwN32zCyDXDmaBHmwcZmD28/19dLSsyGwwWP0sZXIMP4mMAmWcs=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 06:30:04 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::3d) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 06:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 06:30:03 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 01:30:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Mohammadzafar.Ziya@amd.com>,
 <Lijo.Lazar@amd.com>, <hawking.zhang@amd.com>, <stanley.yang@amd.com>,
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: enable RAS IH for poison consumption
Date: Tue, 10 May 2022 14:29:49 +0800
Message-ID: <20220510062950.11792-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368fbf1b-0577-4e95-2383-08da324e84a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4141:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41414863D130AD7DF537954AB0C99@MN2PR12MB4141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6TS18mk7iDbE1/HD/B6+FkyvyOQljljJfopBGFpnZvDtRSRUASkkzRPweVxy5C+OPCQEr2X/u5XINhOZkC79qad5ZdYEMT0Xrve+vmWWOYv/zHk4c50JeLM5ZnVwVs8sumWO5+N9kjEj0g1qxSk9X5JXgZ0OWodcXrbJSjs/hk50B6svjJfRBL1zZ7jNgzOkCDt/pJbpMnskmEgKj0Q8uW8q0gxP07Wsn7iM5NSBPZAOvNpcXlvs+KgA1fTa5YMqFe8hizkcar1oakj5S6bpi47FYqYtPMWOkvCaSf8NbIo003l9w5UPpwWiZbibBB5KB4FtjeN5JV1qsB/81WziHcOvYRFySYgaMk2OBC2yebw5ks+RUzVFeLTabycjSZrEnPThrjSPVuoowKmpwefhsKeGlLUEzGNxmncQ/2FVM+DPTMIoPZ7bEIhcp8fCvU8XOjBMkeJJkEO/cNojXOImdalCR1Te72dg77/Eev0Pb2XOUXh4cIEJtUEf+Cuw+SLW5MANzMbetRI5u3zFjI1zQ35bjslPfQQjHGo5yUY67bWQkAPg5JHaaeDeaCGlG/49zfnXuEhXDdWlXyIFVzKR9b0ziuuiDquMXkiXBR8rDdN1ePiaT+AJeqjvBNtzQ9P2uXCuTuZDUz+dgRRlHdtwNlblHhnbXRFBuTqtaj2p1OYO55d5PN4P6Ut84A+7jS2Bv1ZLdVxW5yOdfk8RL/Xvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(36860700001)(26005)(82310400005)(6636002)(36756003)(8676002)(4326008)(336012)(426003)(16526019)(1076003)(47076005)(186003)(110136005)(316002)(70586007)(70206006)(508600001)(5660300002)(6666004)(2906002)(86362001)(8936002)(7696005)(81166007)(356005)(83380400001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 06:30:03.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 368fbf1b-0577-4e95-2383-08da324e84a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable RAS IH if poison consumption handler is implemented.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index cac56f830aed..91d9e9969b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2516,7 +2516,9 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 		return 0;
 
 	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
-	if (ras_obj->ras_cb) {
+	if (ras_obj->ras_cb || (ras_obj->hw_ops &&
+	    (ras_obj->hw_ops->query_poison_status ||
+	    ras_obj->hw_ops->handle_poison_consumption))) {
 		r = amdgpu_ras_interrupt_add_handler(adev, ras_block);
 		if (r)
 			goto cleanup;
-- 
2.35.1

