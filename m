Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F21CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0251D10E78A;
	Tue, 13 Oct 2026 09:22:16 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1236710F66A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA6ZGUmHTMQ2Ix376PL8l30fgqM/v7Ls3A7OLmIbry8rlUhKisYO/xpwn1Vzg1tqICDGvNeRoMUnYRsHcZut1z9GXbnyQAfHPNpkUtn/jm9EJ2GgRPz5X23wBPARkfNrHjcM01M5nczL96TiCB5tZPga8udixaK49bDwXQwWA9lYnF1/8Kp79OcCd5qQsvpBRStw7iXuIhhgtVVcB4uPW4z4akBaNGo+I0NH6TKy7CxOKFFexaqCe9wQxtGqjg/gGYug5DACTk5mpxx3AH7YczUK+VrX9bV1bgPTIxGWHlp7KR6gMOEbn34RcGedSgqDv+ma7D+qa20mJ7330bwDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTjBLOsc/5hl5eBEIQcAgJfwkLvnkMsgdfSPf0mMyW0=;
 b=WYO+0AYjpQ69WbspqiQtoet8n7JDF/YgjUVSC9CC2DIRaPYRkGfq3PMW2i6FtnFB6Rn2j603+A2OvMZfFv23hC3cPDAfsT5jWNVWPBl1qaYt0UWYAJw6EBk1LVEK+DAY/+vXO494nJAyZx6YyJ5OSEkOYzTkbTBjAu7O9mwPdpK9d8JdrLuqn1962GflsHNPITc90H8I0e73v4VJZHdkWkgWkht8qiXuPOLYA61YdI7aPRF5qU4Yd1SLaDED2f5Nig6Y070yQkhAhAt/H1vcSBWNkZSQrisxI1+lppsWbHB7FoWRzrmGtk2wtz4CDlonW1pf1u8sNoC/4urtOd5+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTjBLOsc/5hl5eBEIQcAgJfwkLvnkMsgdfSPf0mMyW0=;
 b=tSkccrLKCWrU0QUVMJuqYR7mZ2qrKrCg6RMxF9v/OfFf7pgfRv3TKiliZeBZQbD64eDDVR2MNV7dnGYSAs6h77cWmP/YHCKe6gVDPl7TL/rkp83YWJEETPIISWzQQZTTiebjJ0lcV9Ujo6LLu2JH3Gbc89Y/vAgEU2+UpS6WV+g=
Received: from CYZPR12CA0003.namprd12.prod.outlook.com (2603:10b6:930:8b::16)
 by SAWPR12MB999164.namprd12.prod.outlook.com (2603:10b6:806:4e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:22:05 +0000
Received: from CY8PEPF00000050.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::7f) by CYZPR12CA0003.outlook.office365.com
 (2603:10b6:930:8b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 09:22:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000050.mail.protection.outlook.com (10.167.247.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:22:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:21:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 04:21:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: evict the queues only once for CRIU
 PROCESS_INFO
Date: Tue, 13 Oct 2026 17:20:43 +0800
Message-ID: <20261013092158.2261502-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
References: <20261013092158.2261502-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000050:EE_|SAWPR12MB999164:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b9e336-0f1e-44b8-a0b6-08df290b72c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|261009223027099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Z0GXuOAWZKtF7iytS7THrnsQw99b1jGrfk2f1R4/fyKSYfe617if+331H5A7WAscwH7S5/SGjfCf5Af/XRyT0ROhJF1Oq5NcM1q0hGFEn81gxfN+8lwfsg8LEu1VyylG/iH6HhBukK9W1IXIaTOAlaRtUNlxafyp+QROt90haO/nzlRdTEK2yPy1q3hlRdfyYxzKWMkRbEA2z2hVdg20WzbVA21fKtHYz8f6JBZ05CzPEjuoXnbA34+G/86ZM3fndGjFMUgkCaRcGA3dgk/AxDWvyixbqGsZh1TWjcZ8GJivdIFR/wzjlY0lxeZsBgEkfw1uBH+vsEU6MB+KYPRMzVQLGiQ/v4fqIVSEsZNReS5a76VptAzaAuvoJpGF51hAvBS5DFe5+njSPXTRE2mBNwO/PgzZtsrLpGcPQQhRiLVhYwGKNoYHN0DuruhDsic3L13olVhnrgoR2cb28QkISZExb0MmNv/eGx6Yb5a73cMxkfwb+ZFWO2YfRcojnBusv/el7xw405eNDui49Gn88HLsHIDp9URH1UoywOzvyTePHdYe9BqHOIH8ZyCBTMdwwP2ctg+LbvnStLO7AmidCQTsTuR7kDldA3DZOWToerpx5JqfHP/h2AynqyBhn+GJbkjsR1AyGxKa5Xo/wQF+iH0Si2BrMmmXqt766Z51rIzwwZGCfS7yuVM6x9v7zGSGYO89pnKa+98wrEDqWPkPEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(261009223027099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9kjTiOZjO/kQDpfPJOdKxeFi6b0xZkCz/eIRZxv71MSvTzoIo/12gyjrPCa/MzIBju8hQU2euxBEuUOw5WldZF9L29/rSt73ivzpaT49etSWpNmvKGc8JehycAEcjVhNs5R+/v2nUGCM19GS5SQXpMtj1lGxezHV+jpUYaXG3/GMOe4jQmYzerfdrEruPVICv/pgttIos5NHmZGNX23Aa9aiwGtTyf2gmmi7qqwDoA+6FbTfVjzzxixKhCZZNCII4ZeqChrPSV/l7bvE4g5J5jvpjWApj35RAotIunZ81SyEFJOtCabM2Y7eEtBTsE79gm2//VbO6KShykkEszETuWb1+hNOsL+Uz4o6A2HWYu4j9PpTHFCl6qUX46nJiqlNZst0ALBV12MedZsBBFg3vo0sT/N8JOFbOFI4hViSzR6347cphfRyVq37FMtQSPOQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:22:05.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9e336-0f1e-44b8-a0b6-08df290b72c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000050.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999164
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

criu_process_info() evicts the queues of the process on every call, and
each kfd_process_evict_queues() increments qpd->evicted, but CRIU UNPAUSE
restores them only once. After PROCESS_INFO twice and UNPAUSE the queues
stay evicted for good. On navi31, a barrier-AND packet on an HSA queue
completes after PROCESS_INFO + UNPAUSE, but times out after
PROCESS_INFO, PROCESS_INFO, UNPAUSE.

The error path has a related problem: when kfd_process_evict_queues()
itself fails, it has already rolled back its partial eviction, and the
kfd_process_restore_queues() in the error path restores once more.

Evict only when the queues are not paused yet, and on errors only undo
an eviction done by this call. The barrier now completes after any
number of PROCESS_INFO calls followed by UNPAUSE.

Fixes: cd9f79103003 ("drm/amdkfd: CRIU Implement KFD unpause operation")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d86ddfd6bde..2e1d412a0e6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2869,6 +2869,7 @@ static int criu_process_info(struct file *filep,
 				struct kfd_process *p,
 				struct kfd_ioctl_criu_args *args)
 {
+	bool paused_here = false;
 	int ret = 0;
 
 	mutex_lock(&p->mutex);
@@ -2879,11 +2880,15 @@ static int criu_process_info(struct file *filep,
 		goto err_unlock;
 	}
 
-	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
-	if (ret)
-		goto err_unlock;
+	/* UNPAUSE restores the queues once, so evict them only once */
+	if (!p->queues_paused) {
+		ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_CRIU_CHECKPOINT);
+		if (ret)
+			goto err_unlock;
 
-	p->queues_paused = true;
+		p->queues_paused = true;
+		paused_here = true;
+	}
 
 	args->pid = task_pid_nr_ns(p->lead_thread,
 					task_active_pid_ns(p->lead_thread));
@@ -2898,7 +2903,7 @@ static int criu_process_info(struct file *filep,
 				args->priv_data_size);
 
 err_unlock:
-	if (ret) {
+	if (ret && paused_here) {
 		kfd_process_restore_queues(p);
 		p->queues_paused = false;
 	}
-- 
2.50.1

