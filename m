Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A707C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Mar 2022 00:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D7F10E0E3;
	Sat, 26 Mar 2022 00:57:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E29F10E0A4
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Mar 2022 00:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNbtLmZXz9UwqwGmuBnBj7xTrdze1koFjcsqTJOwYbzfRlpVjlt8kgGkzboui3Hyv1F0mojO87cIB1heCJ4JY1O8kZrbBp/dVHXst3Aa8gWG2yJk+D404Hg8itAm3lyJaaAq5sm+npoHkN7KQvAYAzOgb+HWNV3+TOYpAwa6j59e29f0CihS9m114adGjJaFVaOQX7Ptr+wXzXFYOkJ9nSCIu0vwtUW/3Geyx6NKV7SVoAl6W3qcWn+OytmYk6stspMpOCiUB+LcgPQRJk+11Hh0iSB/1KC1fbrLXwcm6ZPfBwDGk0Gp+yGXq/0DG/JMIWn5tCOeckWrK2/s76pgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyx5f9GcqzYWfY309a8tHvwkHk4MhS+floSLoukQNAA=;
 b=nBjXoPgR40g77Zki6ey3ZN/lcRhCLhSCN+ELkcG40g4ea1VRlIv2PdJE7iNvDqzMwxeVzbT3yi9M4wRur3bN09UKaw5UhP/+bcGBoQZTeRM9omcUbta6dV/JoSoraZ2OtfsP8VpF3NMnOW1eJCYlugdvIMCL/Zixr9N+hhvx3lMsakqgNRGN9yB6xZ9bTRC/wZHPb9ZkKl3HOzht3MYewdzXC0r/K5nJjA9/mTo379XwNqs2MEIxuzNgGLInGBBT+Cf+VWxbqpygIj/BSNkMlWoedg8atuOfku9BDmZPePA9V+rBRAIPqXvZ3jnJHDtAeSbQutzdLksGWrQKyAON/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyx5f9GcqzYWfY309a8tHvwkHk4MhS+floSLoukQNAA=;
 b=m8AknXbJc9VGTzWqABXFXeB2krCQthzvS0CMSLbjBgadvtmsCLKE+qSyhDGOzRX899W2RXZt4TFveIfG5YFRuNQh/68WE+KCxSDFThyWjYZcTTGp/KissvIgy4j1pzFtkqhWEUz6HvzFDMdIP+x5Xjb46021zFb7UB6L7g+rKKs=
Received: from DM5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:3:9a::25) by
 DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Sat, 26 Mar 2022 00:57:10 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::e3) by DM5PR19CA0039.outlook.office365.com
 (2603:10b6:3:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sat, 26 Mar 2022 00:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sat, 26 Mar 2022 00:57:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 19:57:08 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Use atomic64_t type for pdd->tlb_seq
Date: Fri, 25 Mar 2022 20:56:40 -0400
Message-ID: <20220326005641.10284-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7ae224-6c99-4e2d-529c-08da0ec38e49
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5229AB699F030D2E62381C92E61B9@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXCj5TAoiWoH+DQ3JFjAkppDqvi/RCqGfYy6hG3vhBbrQLNPxYVZ1h5Q+PZc2l7tMPU5+kT2TT9xr2z+gFQtHffe89ePpdUWv+m1FxyIC3rBcskZXZftwCXQejjZZXxhTIvNoyOeCmvmYneIAwTrfe+ngdIh/KgkXP2dQeH0smzduQRG1roQ63I3vS62R4UA03oHGcCbJQmYVVPTm49GDomcSCMAWePXP5SVT6ieKbK/2BjNtuPEuydZqO686iCjCkRIWDJ1rycqIO9bCtPaxQuf2EwiF2c8QYzUKSXvYI9pv61pUnfXxhXdx7qC64bvmXGsOO31rFV1vBmtHjPSAKXfyGOGmtsrdwKLmLP25q6XDyjgMV5rlgVcuf/Pl3zhuLBeMXQ1MvmSZgppA1HiroBRpTwxwEt133O+sHFydIZgz8IYZWX82CrR4ITt4zflOnNVil7S6q749tzKD5Xi3n1IEhVM1/usEAAN8A8oxO2NqoN3ZqO0q8inZBJgkDJiNGLgRa3lv6P3pNGIGQ2Bm4KhvxNM9QrUjPBsV/kZH1cCT5BKFP6oUO7pGSBMAb2Pe4kDYyJByA60ndxyJf7HLfRdPdvEUWTWLoAbIiGy6MkpmASoFB1gmJ5wvVdITlQVUs2DOr+XCNtkrI+YJsG/CZdpOPhUgPxEHRnJJfmrM+If6N+arpVHvoquahu4UkZ0n7i+DxhV3M4bBcByk18yAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(8676002)(83380400001)(6666004)(82310400004)(81166007)(356005)(36756003)(6916009)(54906003)(2906002)(5660300002)(86362001)(4326008)(47076005)(1076003)(7696005)(2616005)(508600001)(316002)(36860700001)(70206006)(70586007)(26005)(426003)(336012)(40460700003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 00:57:09.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7ae224-6c99-4e2d-529c-08da0ec38e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: Philip Yang <Philip.Yang@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support multi-thread update page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 945982a5d688..e1b7e6afa920 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -705,7 +705,7 @@ struct kfd_process_device {
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
 	void *drm_priv;
-	uint64_t tlb_seq;
+	atomic64_t tlb_seq;
 
 	/* GPUVM allocations storage */
 	struct idr alloc_idr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac8123c1ee8f..43ed8ec1f975 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1560,7 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 		return ret;
 	}
 	pdd->drm_priv = drm_file->private_data;
-	pdd->tlb_seq = 0;
+	atomic64_set(&pdd->tlb_seq, 0);
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
 	if (ret)
@@ -1954,10 +1954,10 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_dev *dev = pdd->dev;
 
-	if (pdd->tlb_seq == tlb_seq)
+	if (atomic64_read(&pdd->tlb_seq) == tlb_seq)
 		return;
 
-	pdd->tlb_seq = tlb_seq;
+	atomic64_set(&pdd->tlb_seq, tlb_seq);
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
-- 
2.35.1

