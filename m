Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDAC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 08:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F95F10E073;
	Tue, 12 Aug 2025 08:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a009Iy2f";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC7010E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 08:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHpsU6Ni8oli6pVCGbjGGOnlKPTKaDXPDNCHfrhuV5PL1Qq7SX3DWlv5F6VLuMCsOpeKyfZCcYSLbfNL1p/LoFrDxmdUd4uxRP0DbZDBS1U3hbc0sebJE+x9ZYTVpXQG2sqvrxuVr2S8hFMOLk3t6L+SEeDbqEU0rXMSPUvTg0NX8QlO9vDRxI3gZ2uNygJ+zhUcPASblumzPQcvoDWUBxY4ile3/1W/l5Q9KAzpii3337csCvaQ8xy/23L23Sp3l1m2aBA/d1mSNay+Cbi3YsmaxcwRUkxyTlRcWe4Pm5quWz7dxNGuEmKCxjvyeLqtwbHAahHEzqfmsyTvv7EbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkQGwrGWKhY8NYCS0svPTDuIUyG3FSuaQmdsu06wfKo=;
 b=CZ2iIcpIHqhjiM1DMucGPcV5LDpoBu2a9rVN1AeaSvuKJlKVywAa/cM2KVeZYH7H/KeiyFF9RhOcAMyFpQWAHxRk2BKk1AgFwc9SfoSWAewda08KOFCrtvgH4e4krW0ltO/sodrUBHmNWxrR6C/UGo7kx1672O4NV1zyjJnfXioqC1aWl7/DGdvp58knVLC/OoB2176pxQeV2r2MzhgDU8vMMq3WEtMgKm4Fcv6b4GcDV+8mNn21AzvwCcWLZNo1JjuTDUH14lXzo89iEj18UUqpAv5VDY36dZCDVXCEGMFGj1Tckmb3G7X6qi3osWiL9Byx7DjbWLl9rke+K2+yxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkQGwrGWKhY8NYCS0svPTDuIUyG3FSuaQmdsu06wfKo=;
 b=a009Iy2fgB8j7yhZmiRMNZRGsfKrygYGG9nCYJamN8l8bXAQ6OXJL/okbt4ytmkIG+i7onHQ6/5Gte1wPx7T9y4acQCxCCDoHlyXqplqYSESu7th3Mjl+/55+j01yZEYOoD8eVa6mvZC3E4g1B7BD0yQZJHNkmQpfEK6shPcP7Y=
Received: from CY5PR22CA0080.namprd22.prod.outlook.com (2603:10b6:930:80::19)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 08:02:15 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::9) by CY5PR22CA0080.outlook.office365.com
 (2603:10b6:930:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 08:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 08:02:15 +0000
Received: from amd-SYS-esther.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 03:01:28 -0500
From: Liu01 Tong <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <gang.ba@amd.com>, Liu01 Tong
 <Tong.Liu01@amd.com>, "Lin . Cao" <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: fix task hang from failed job submission during
 process kill
Date: Tue, 12 Aug 2025 16:00:56 +0800
Message-ID: <20250812080056.4072748-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 658080cc-cf1b-49f9-ccee-08ddd9768cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kHVJPeHjo5i4CK+2zL5i+CM6P7Bg8+v2rMChqMaSIPtJAes5K3U6hemlqzuf?=
 =?us-ascii?Q?S5rp5hhm6k8i2MEZ047DL78l9E202nLRi3ZKM8au0UYrPQwLHoLWRtQos7j+?=
 =?us-ascii?Q?hWqc06mc74o+1+MXpKKCVpVeWtfQz/TBqHYFK1HEDlib5ruHAmIprAi/B/Hl?=
 =?us-ascii?Q?wzbRwK1Km1nBB24d/S4PiI1zZb7ETYOfe/Xmf28j7ogSZM/8XcTwFsp0EZdH?=
 =?us-ascii?Q?PyPzOrZf4R1tNXBmsc8vqINBgmtnQGL2mYNSjcrbBqEmirFLA903Z3HsOuNo?=
 =?us-ascii?Q?GK2trHcPs9CQ2xatK0pTxbLDbAmXQvfmERdwsUcoV6LkeQbHU6BIvqmoVpHL?=
 =?us-ascii?Q?suNZdNIJ3RyZCAPte2EPRdwJm9VHPdhA/Yoi39ubfxKPGe9qsZ5WBP/HTGdV?=
 =?us-ascii?Q?3SIz1H1uo1jBdzG/uf91sO7kOrbYIkv6Aft6zy5d22N76QvHlAdKUoSg8Imx?=
 =?us-ascii?Q?cbFtor/nj26cf73a2UUUGy5gzP/lTUd244EpQtOuLNvbBZrYT2yKMKINN8Ic?=
 =?us-ascii?Q?UG17ajQKqW8bBh1vXMt46C9beRvbVlOQf7D1UOyGNM38TvgKNo2m/wAqHLlK?=
 =?us-ascii?Q?tibRb2PBUChGsl4GKzXeZYVIVaxBciXtdZTqrim3UpyxTT0+kQGiXtdlL2Gp?=
 =?us-ascii?Q?ROSohFLt74oaGmAvtuBuvhxYNJIDrsKpZvigSqH6UlYEl4q85/vSBDJRdOis?=
 =?us-ascii?Q?j4h4fsj6P0ZwUI29m62zlnRYjxkQClVlLJSIYakYftXIysegM7Jfu8xFk/dy?=
 =?us-ascii?Q?RNfKiPv72ydQ8EU8g9g5Mm87yO9WGAvIaxGU8A1eyZ5WUa//M6gOvEdTwz8X?=
 =?us-ascii?Q?V9djZJ8yAsuU5XOCrGQ3f3ptIQFRcnnfx2fipENxbUENO2J+ztJuO447reSJ?=
 =?us-ascii?Q?W2gcbt/HOQTL38dT/5QCMhkBFORJPM0kQQWiKxzysUWVt2ODLEQtSFZqJWro?=
 =?us-ascii?Q?A4esSymQPXLf+GeZj8How4//CKbtQmJauem1i2PhdOEDl8f6wkJUPXdBkQUF?=
 =?us-ascii?Q?pwArn01voQmkHttHv+Bb0OaSzpCSRrF+kwHoDrKkPvvri24AXuMjIkFgSkm2?=
 =?us-ascii?Q?aC6zEx41l6+1NvCRdRimZ3UvPCVVz+R1Mm8Wmg/m+RNe1QEnPXIo1Fp3B7Jg?=
 =?us-ascii?Q?u6aow6lMOQKO+1wnka7eDGCSaWugVV8iIBPCMWB68JeQc+o02HYbDmReW890?=
 =?us-ascii?Q?xJqU563HDaLRRO+9sSmABDEhhwi2RwsutQnylPmCIbV+R34fW9eBN2NxgTcR?=
 =?us-ascii?Q?wBBVQdfZqcM/tLRNrQwky4MBL6Shw9pL07Vf1MuNoHw25nFUjn8ITgt+FjoQ?=
 =?us-ascii?Q?b8YhRRF5Wuagx/5A0znoSXrOjLerOpLXzosQzoHK4t3u0xVIaSj5sXJI0fJi?=
 =?us-ascii?Q?BigoqHPIXnY5dech8SUSNIF+/B/M6azsYhRJyO4PSWvc2Z1TXRr1q5r+Ferd?=
 =?us-ascii?Q?c8icMTdE5hv/OquvK5OiYjiF6FulcuqYZXFKYIzO2/XV6j2vO3+3gbZmksRc?=
 =?us-ascii?Q?HAgLI3j9PCTtyT9ce/ng95lcCEhHQoMvAPUs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:02:15.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658080cc-cf1b-49f9-ccee-08ddd9768cf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

During process kill, drm_sched_entity_flush() will kill the vm
entities. The following job submissions of this process will fail, and
the resources of these jobs have not been released, nor have the fences
been signalled, causing tasks to hang and timeout.

Fix by check entity status in amdgpu_vm_ready() and avoid submit jobs to
stopped entity.

Signed-off-by: Liu01 Tong <Tong.Liu01@amd.com>
Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 283dd44f04b0..bf42246a3db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -654,11 +654,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * Check if all VM PDs/PTs are ready for updates
  *
  * Returns:
- * True if VM is not evicting.
+ * True if VM is not evicting and all VM entities are not stopped
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
-	bool empty;
 	bool ret;
 
 	amdgpu_vm_eviction_lock(vm);
@@ -666,10 +665,18 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	amdgpu_vm_eviction_unlock(vm);
 
 	spin_lock(&vm->status_lock);
-	empty = list_empty(&vm->evicted);
+	ret &= list_empty(&vm->evicted);
 	spin_unlock(&vm->status_lock);
 
-	return ret && empty;
+	spin_lock(&vm->immediate.lock);
+	ret &= !vm->immediate.stopped;
+	spin_unlock(&vm->immediate.lock);
+
+	spin_lock(&vm->delayed.lock);
+	ret &= !vm->delayed.stopped;
+	spin_unlock(&vm->delayed.lock);
+
+	return ret;
 }
 
 /**
-- 
2.34.1

