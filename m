Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 14:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090E110ED81;
	Mon, 30 May 2022 14:57:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5059310ED81
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 14:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU1os0j9SuDJi9fz1neGuqIfPyyyT9eGYhQm1vFmTdlHo+AiEHfimSekEP5F08N+Jldj+4rnDa10Mk7e+FlSLOsBfmbcToxbfIonqHB48t4l2C+Klh5/VDFw+Vnav70QRwqpn0tWJL3J9Lq6P4fKhA3uorxFHLETDN3C8PldLtBoU7BcpcNEtkT26bh/UMDfSOPDvY4+CnRxfz4Ug5UY+WxHq3GkLRVNgGtDBqKfUgL+z9+oEsCxjkKkBLVTXBiI6vIWV8OtQyJ562NN5EpStNFyyJAlZCw2IwIY0NAbc/R8du7vfbb41VTDp1BH5sJz1udo6GKig1LoFRB/zh2Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0dHL40fdVYTW2NteUQB11lL3IveAAkxDS/Gc/JcYLw=;
 b=iC7YkRf+IwffynyvJl3ur75L5e+QanichEhujOVC+8Ox596EDpFufKyGxvJke4H12FEG96ea72UDdqMAmpNJs1pNFQle2xNm61NlhoxvQWyLZUupja0a2K2MOqQlttJhhZ1pdpa7RhJxI2IY6XZnmOuXW2pnhhV3qIgPOPIdSwL53yt+XarGp8zu0Fb8Y2bxneP9DBXhHhGxyy/ZbDWX0rwo/aOSdaXaDy/DjvuUkEm1Ank8KFh4RRRd+dFUUcYdZAftj8wQeobVI5f8+NTPxL/gz264cgk5WqXxKGwrTdTfxWdR8tjgLbzMGcAhYe1RfyvLrZNqRDPXfVFxzZDKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0dHL40fdVYTW2NteUQB11lL3IveAAkxDS/Gc/JcYLw=;
 b=P4as4/9lq+wTGsvBXEbqGs2ClXSDlC55invJ598E+xWLPiHT036l8dRGqn0JHYXbPXOixYRu6pRQ+CR3sXISXsfa/vywFmm38Spn0thVcURysxUK3RmbErp5CrMURl18tuZvufEE0gngc8991UZCoXWodmvRQ6Zcx2nwwRPP04E=
Received: from MWHPR04CA0054.namprd04.prod.outlook.com (2603:10b6:300:6c::16)
 by DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 14:57:51 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::61) by MWHPR04CA0054.outlook.office365.com
 (2603:10b6:300:6c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 30 May 2022 14:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 14:57:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 09:57:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: schedule fault recover work to another CPU
Date: Mon, 30 May 2022 10:57:01 -0400
Message-ID: <20220530145701.3881-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530145701.3881-1-Philip.Yang@amd.com>
References: <20220530145701.3881-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d59acfaa-cc1c-42ef-8d43-08da424cc4d5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5136D16AD8F5AFA8617AF148E6DD9@DM4PR12MB5136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OLAV4PhAaFadfBL5DXGBeCxc0xI+LZX2eIIxIKO8sjDHd5R5olppGorGkKORW9gDvDWKrPpYYe1+IOWFZtSnhHY/d9v4LZb4B4gjFMLEEqGJ2tiAxkG5cHxKyTuSbsXH6s2Rk1IU0hdz4hgN2zHX5DyaWrwRKXAeYkDi1E9P5VOT1QpsEUVKjw07n3+1REC+CcUXkQKcoPe4aKJKrpK6Rmy9INQZXCQ9zfqdHl8u58mTb5EtaIKwp54/d2nlYZUB3yg1G5zlPvR7LRzXQ/M2tl6jSVu7SPEzNNggkundnrxaQIRKYPBmlgVwZu/vwK+RWleY6fDoqFzWd8VXv4Mm/LnuXlNHSX2XGwoT68gCu5FwPOZogD8QypHE1s/srJ+SvLHD1Ncw2H2ZnWjvzP35Y/h/RiWubPHtuRqrsTdYwB59DkVUw+R8Br1Zn4OH/wn9KCnImx1rCcJ631Ce2KRI10rKo28kJjLFQJZ0va3kBrjQ/TE5EEwaOjuTPHfOScvrxWFDbTclcuB0iJtQR1QqBVdtj91yAW6Cpr74wTBducHqFjH760HQHxJKYHC1lvYHRr5o2t2rp4yiYF4b2ON0p141mNYMsaoLBhV44MNz74vL2fWQeNWj49ELm8TthXp4BAunq4AhXF0zVy9321eMadYausPw/j72CPEBU0hizIFs7IfN5+2scV8jQeokZc6XgATtXBWoUBHVCfwOJOYhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(36860700001)(2616005)(16526019)(81166007)(47076005)(36756003)(336012)(82310400005)(316002)(426003)(7696005)(54906003)(6916009)(2906002)(6666004)(83380400001)(508600001)(186003)(8936002)(86362001)(40460700003)(4326008)(8676002)(5660300002)(70586007)(70206006)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 14:57:51.0967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59acfaa-cc1c-42ef-8d43-08da424cc4d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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

Flooding GPU vm fault interrupt may hold CPU and delay the scheduled
recover work to handle vm fault, schedule recover work to another CPU of
same NUMA node.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index cdd599a08125..3a47107737a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -435,12 +435,21 @@ static int vega10_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
+	int cpu, new_cpu;
+
+	cpu = new_cpu = smp_processor_id();
+	do {
+		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
+		if (cpu_to_node(new_cpu) == numa_node_id())
+			break;
+	} while (cpu != new_cpu);
+
 	switch (entry->ring_id) {
 	case 1:
-		schedule_work(&adev->irq.ih1_work);
+		schedule_work_on(new_cpu, &adev->irq.ih1_work);
 		break;
 	case 2:
-		schedule_work(&adev->irq.ih2_work);
+		schedule_work_on(new_cpu, &adev->irq.ih2_work);
 		break;
 	default: break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 3b4eb8285943..a9465f0d8fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -487,12 +487,21 @@ static int vega20_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
+	int cpu, new_cpu;
+
+	cpu = new_cpu = smp_processor_id();
+	do {
+		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
+		if (cpu_to_node(new_cpu) == numa_node_id())
+			break;
+	} while (cpu != new_cpu);
+
 	switch (entry->ring_id) {
 	case 1:
-		schedule_work(&adev->irq.ih1_work);
+		schedule_work_on(new_cpu, &adev->irq.ih1_work);
 		break;
 	case 2:
-		schedule_work(&adev->irq.ih2_work);
+		schedule_work_on(new_cpu, &adev->irq.ih2_work);
 		break;
 	default: break;
 	}
-- 
2.35.1

