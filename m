Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B94CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D6810E6DE;
	Wed, 22 Oct 2025 07:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MZt92+Hv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6828610E6DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+lTstQ1N4tcNU+4EcLsPBBCAuu3YOK2Z9LK9VWTI/QhURSqM0QMfgstPe0AXIVicTzifXtC8gq2h52EyqOn1Dwe7EcUI8mGoowbZaxWIYq87WjbuV+fSVSt0t7CwyA6WFQ3+e86R6kEYUA9JJKgUTAaYpAfd01RtJLSPP3u08m0ulHdtivKZLDzq0WUZtVPIIaWZeTJEghYuNUQ1XFmdOAlPjiYPiT31xuBbKDrNvKR+UHELmwqX6Fy1IbzFf1zLwYI7D8ud+jbIdtchou4cA7EPTotXaROEn9+2U5vr65n/01WrT8BfxRTkI8ZTtFJnigxZDZBh4hk3feePNy0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOxt/nwvCnLNWqLKPFZ6IdTCHu4VvgrKGRs7yfYpYSU=;
 b=Z17bvc+6XWzL72+NKbDhJOaCpCrS6gx9wQrkY5sVJX7GvKjp3VRivPNuDayiY7loFGdLIPJm+VdKxgDM5g8ZDIrI4s6DZEZnNlGqp47SEvNT/Z98WHpL1gobv7pUSZUcz61syQEVsjcqblA5XG1PkfBAKnFoFUJOjfL/S98ccP4o6Rp/ivJU5z1EZUOpJfzmxfe7F89nFXrPK8Zdeu4LYhZzsFyEOJjYPm9RrTpeH3z2hkAiwDb/fozVUW4X5H4AlR/FwuBYLZtMjm6hwsNZ9HNNojhRrWmEN58CURa/4qfQlkUW3makLVcVlI+0kD2RgXEjnoBgC0Cf5ADh3of+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOxt/nwvCnLNWqLKPFZ6IdTCHu4VvgrKGRs7yfYpYSU=;
 b=MZt92+Hv2/27E84Wq1y/XdsYP9/0Rbs461ZgOgWX6HZv5792QHbk9YF4MY2/66oZ9qettw6R3cuc5sjAgorO71iWSnD+7jzTrom3txmTH4e6XO8/JPdrj0eElardROAoUY//GpNA3RwKRWG//L22RrIYt4hiEuJ2sa4I50JvWcE=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:34 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::92) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:33 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:32 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 14/18] amdkfd: record kfd context id into kfd process_info
Date: Wed, 22 Oct 2025 15:30:39 +0800
Message-ID: <20251022073043.13009-15-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 374dd5d9-85c0-41bf-31ae-08de113d06f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7YfvmN8A+WSxLJbjXL0cnZ/IKuCKhCShae6VHHMb8I7f+g9OzqI8+UOqbetV?=
 =?us-ascii?Q?HIdiQR2P4pnPxtzxZe8qekPspZtWxagjmgZgDWO1DXMjyNN8xAlRjLuZ250N?=
 =?us-ascii?Q?zPZyH7AS+/m5Zpyuts7XvAXegwN32r7PTuKB/BMx0/nOVk/Qe/zJikrNJN9W?=
 =?us-ascii?Q?fwF2LW7FQb0cFl1pw+czZ+3J21RztdEbzRyPnhhKdtbeIdamv7Q0wD8NdVM3?=
 =?us-ascii?Q?vPlGK60kQXGZ8ebmFEs2c1ZJMe1XePLMPJ4B9SU4PfobJfRixLPR3Ppc+y5Q?=
 =?us-ascii?Q?OE8GHVg4z/V833nLRBc+bdOxsoZ1NU5BijP/j4jdOfxBMdiYqfglSf1ruSty?=
 =?us-ascii?Q?zJLDOcyTBc4I/NWN9PZYuFuw0GhjOGMY99tvyhRg/FTO96EOkblxNsBefaZj?=
 =?us-ascii?Q?tQJ3vDuLqNzFxCda6RLeyC/GLKXhBDH5prCfchctlEW39CGGS8LG5ja2Ve2g?=
 =?us-ascii?Q?1mBEvUem7KGYrKCU+gm2Gx2l4vruKNPpX35746rIflOIKjah8FTwT23Le+lQ?=
 =?us-ascii?Q?zdzD+6yyS088WNvz74lm8q9UTi+zP++c+8R+cmD7jcqsDyX02ULUFvr7zlkV?=
 =?us-ascii?Q?25y1pUvvFiKhquy4Xohktb2Brnfe7lH3I3BH2ch8upHQTLuUKO+8/OQrORv1?=
 =?us-ascii?Q?Hz3Ld0vjkrn9M5iQY8mFPABmHkGMOimK0aGSCilaoh1d4coElzo+szQILd6k?=
 =?us-ascii?Q?k376RASGDDVR28mYj4qfHxyIvj1nHDpTC40e3c+uRZwYo9EfUFgRvLKLQAB/?=
 =?us-ascii?Q?UmHD62sYtYVwMRKH4PZLe2ur8MfV8NeBRKAqMYp84O+UHeaAC3CLTmwtYL9A?=
 =?us-ascii?Q?A2Js9Ait8SZsuVTLkr7kfMJSysA7K22ZlLJSWn2oB9FfT4b1eH/IbReSkYiY?=
 =?us-ascii?Q?FrDhEUoDlam704hyffTLCAKUeBMBWQspmyvD2gGtCjtX+EN+jDe542oR3C/H?=
 =?us-ascii?Q?5lk8HMn0fQlONZVklFZWQ4HqljjC9SEwxV4c2Bwt7VzUTYY/aVA893RXl7uT?=
 =?us-ascii?Q?g9X5IfWkP5AVmXqL3xUH9bQVU04TC9jQq3cMIOy0UsUajuPvkCQQ4bmj8aJQ?=
 =?us-ascii?Q?sWr2OUQ2lliWL5xIp7B9hHnfood765uUUjtTUs4b6luWJ/NPaRyU8aI00MC2?=
 =?us-ascii?Q?pB1TKyMPAQZGQoI3SjMr1Kv2x7cD8+bEMdv2/udsydpvrf+RFKgKRBS4InYY?=
 =?us-ascii?Q?RytOWILEs+H2UXf9427LlIbr2sxulbLvH1r8VEoKXWCrTYRPf0J3X3l6RmFX?=
 =?us-ascii?Q?edBLgMXGAlOaBqhtXz2q+N7Vh5HA7R7Wux/WdbzOXFuw2V9LDzW/FXuU+Grj?=
 =?us-ascii?Q?Qx4zbuIaB085XsZWozq7VORo7BinrYvd5X0kRDMufHO5aMD20lOU/lS3cptt?=
 =?us-ascii?Q?tda/Yngszz1H+Csz8aJMplzzgb2L1C3YUOSg76IJu4kJ3fz+t/BiN1H7e87q?=
 =?us-ascii?Q?cjFSx9zhnLKFdZKEikio1HMmIzRZqh9lAbVfydjMoX7eDGdkr+8OH724B5VK?=
 =?us-ascii?Q?8DQzqlUPIuJ0qbCl8AwcaIEfnjA40nfj9hKmTylrnPBr2G15vpEsPg/bAhK3?=
 =?us-ascii?Q?oEmH2J1I8gn8DG+Z0fA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:33.9067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374dd5d9-85c0-41bf-31ae-08de113d06f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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

This commit records the context id of the owner
kfd_process into a kfd process_info when
create it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 9e120c934cc1..28b54d7ee1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -148,6 +148,8 @@ struct amdkfd_process_info {
 	/* MMU-notifier related fields */
 	struct mutex notifier_lock;
 	uint32_t evicted_bos;
+	/* kfd context id */
+	u16 context_id;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a2ca9acf8c4e..722440d62290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1386,8 +1386,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		       struct dma_fence **ef)
 {
 	struct amdkfd_process_info *info = NULL;
+	struct kfd_process *process = NULL;
 	int ret;
 
+	process = container_of(process_info, struct kfd_process, kgd_process_info);
 	if (!*process_info) {
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
@@ -1414,6 +1416,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
+		info->context_id = process->context_id;
+
 		*process_info = info;
 	}
 
-- 
2.51.0

