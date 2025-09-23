Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D507CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BBB10E57A;
	Tue, 23 Sep 2025 07:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLWkm0xF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A2F10E581
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwtOhkvWJax7m9GQm8bA9VF1esWPrNwFWnUx9YlSi0VUhSNs/bCcQ1w3TvZm7NzzH/DRTdPRGMElF2SPt2mq0e5hX3YBeaX17XK91vEgJoxcQ7IQbkmblYxkTBnbx7WzWiWU43CXV0MuCCpvvy0MbitR5hSPksNOgBTCgWur0tMYuqKdzFg3HWSXfq6UFOLGihDIqSyzIJTg1WILmc1T9dcbn0n1auajGnK1i7xRJYmMh3NA4iJmoBpquoL163eupuQJdPMAhZcqGkYKoHu8LMm519XyCHLJUPgNSaaf1EJ9/hVE6kt/fz4sAWvHQRIQk4fewvz+buBbpxSHrlljyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8unqhswvsjQYfr0pi1EN4JINfxJtROeaFEYno808xpY=;
 b=nZSM5uM0sdZ27wIbjptVatVFk1Rqe0f9LEOMrwMOi5JVWPtdj1YMJgQTb+UOffDiQFUNBJUv4WeWvjM0mv+fRob7/YXeMQRrPCbrDGfGqgLyiMPYgY3CmbIdpNvHiEZjiOiSv/wb2beTM+SRSHuzn0dxO0vitq2G8k6XaBZqpAi1IbYYWNKMyHHtxR3LqII/95MddtnoezPvzRW3Lb2WYhZCHxoQ6I9ZCvDnmL3B0QheFjufm4K3uzIqKaYN3yBDBYFjjaatrvcUtHSYc2XqHJmB1rP7D3HU/IuMP5ivH5fkYQgErU+QA9U89l64+frFYujxlMlbiOgeOuUtWs3TKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8unqhswvsjQYfr0pi1EN4JINfxJtROeaFEYno808xpY=;
 b=SLWkm0xFggA2FEJbRJwpoUXxVEc49y7XZS0AvxO3UElBOvOtY1is/20f14EsyZ3wP6zzcB24FsVLP4333I7gpJX4kpwcOjd+mTCk6VokSl2Ezw8rRnKFxfRpzjLwjl4deqjWlQERWR7765DixwJkL2abNCX5BTgICyOgRETp5OM=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 23 Sep
 2025 07:26:59 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::ce) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:58 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:54 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 14/18] amdkfd: record kfd process id into kfd process_info
Date: Tue, 23 Sep 2025 15:26:04 +0800
Message-ID: <20250923072608.252345-15-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b8cb0c-91e4-4afe-05c4-08ddfa7294db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?02caltAMdIZgMeBFZKXlRp15rne3aGBa2RRV2UCDDdbNWQTz7+9+hmV047cS?=
 =?us-ascii?Q?QfkoLaCHsNfaPil1F2FmcFASkp0iCOrNkQRAl49qTZz67AEnB+32EboAzvUb?=
 =?us-ascii?Q?fmqa3ivw0FIKc9dKkoz4PZEcJfFt1Mmvy2sNMCc4lw2/oQ9JRSzdOXTU8Ro9?=
 =?us-ascii?Q?DrLcie9t9yzppxBFGEHpbo3bP+6adbZjHneU2VlhAdYEkKz848P5b3PKNqNU?=
 =?us-ascii?Q?kHDTk6Y966JdxjFtrit4qIfGaqb5ozP8GEDI3NTuG91jNpHr7h3G3ICBsrd5?=
 =?us-ascii?Q?17ytInJuq1adgHTItFSyByXF0ps0ADXT3oWxUBGQ79QtpeYL8JD//otf007U?=
 =?us-ascii?Q?s9uGKaxrAaGtYRVDOH0U++5cJ9U0zwDxO2DbntXVgDabPzI4IcC3J0XkjGbo?=
 =?us-ascii?Q?9OXpuIfxFHm27dDQ5GN7WG9Wiktuf2/OPhSH3a0itBi/reI01310xwO+ahwV?=
 =?us-ascii?Q?qdK0k1skJOKaPs8q31ypyZr6J0IhMG6CmdTrTxosj4Y6+aiT4TroPCPqB39z?=
 =?us-ascii?Q?FLNzK8Sz+mMNmFfzKBrba50dHaO0nJcXLBlao80XyGjGALp6jKkPvZQ3PVQR?=
 =?us-ascii?Q?kf1EwKs0eYzMe3tv+28XpsjJxyiPMJ4NJPKm/bBbeJYjIMF6vQBrFAkIooIt?=
 =?us-ascii?Q?z2Yuq1oB98PxFZ9onda94++vOzQdaFdSKeEJam8PEZ/u+9qx3XQJYi1zYqqT?=
 =?us-ascii?Q?nZCSWpVneBrd+lLqTcxc1nEEWL7OG/Dbpc6zz/5k0UT2plL9nTJoBq6hkD+O?=
 =?us-ascii?Q?rsE2Uhu4HWTcTRwwAgvh7aAW2rs8g89EybrmbrWHx5fMJ3F1EBdzE0SfvcTp?=
 =?us-ascii?Q?fxx7NsUv1zLmljHcH9ZZ4MxuvKuuJgw3X41OJUlS7MToJlQ/ELom0S7plBgn?=
 =?us-ascii?Q?IbSq/0N2fJ4CPdPqAeW2ZrQzpAyEDIMG7gCQvovknvyl9XXgvGJOMMil2FAA?=
 =?us-ascii?Q?tJC1OJjxM5s6J0NnETX4IL9zSIdDT1OYgdkddcOn1NFKAJ7IYWZAS+gBDQGA?=
 =?us-ascii?Q?Tns1yGfbPLG2QkZ3+lV2/TDbNv1qI20KQoXd7hs9Qyd4Qdt5eqR8MOd/FcDK?=
 =?us-ascii?Q?u2duUDg80M1Ur0GcCmF6fCZsm+fgLwEkMrHMDBX5Yf5taX+z63pkkXV6EXHg?=
 =?us-ascii?Q?N0DYWGxvU2Wzcdw3istObJz5j1PwIga6Vj1E+fFIg/AOCWTFK4dui2BrvXEy?=
 =?us-ascii?Q?6GeKTNKNeadDifA/vajSXuV28fgc2JYRMMB8TJPpEYB1ro4uaRpTy3F7oFLr?=
 =?us-ascii?Q?nEwCQh2i7kMLsVkVP+m0ErAgwrut9xiBpGSeViza8VNSvWvouyDlv5eHdnp4?=
 =?us-ascii?Q?53A17w4XMaIqt4EO789RogGWjQEyDAeHC7Yf/6vRSAEzVvh4kWS+EsFXS3pe?=
 =?us-ascii?Q?EtGFZHuqDTkTvPXWyxqtMQ7hofhEl7iX7lB6FPgZlaY/N3kc06ME5A93+Oim?=
 =?us-ascii?Q?3XuRfmUj59ylS5HZD0akrZUnOKCZtzLac2js14qWetJ/pP+DTp3/9fK+Mgf3?=
 =?us-ascii?Q?/5AVK1LzS8s59zwJ0dSRlc7eW9qtxDFVLz2l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:58.5738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b8cb0c-91e4-4afe-05c4-08ddfa7294db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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

This commit records the id of the owner
kfd_process into a kfd process_info when
create it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index aa88bad7416b..d867984a68da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -146,6 +146,8 @@ struct amdkfd_process_info {
 	/* MMU-notifier related fields */
 	struct mutex notifier_lock;
 	uint32_t evicted_bos;
+	/* kfd process id */
+	u16 process_id;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b16cce7c22c3..723d34921c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1382,8 +1382,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		       struct dma_fence **ef)
 {
 	struct amdkfd_process_info *info = NULL;
+	struct kfd_process *process = NULL;
 	int ret;
 
+	process = container_of(process_info, struct kfd_process, kgd_process_info);
 	if (!*process_info) {
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
@@ -1410,6 +1412,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
+		info->process_id = process->id;
+
 		*process_info = info;
 	}
 
-- 
2.51.0

