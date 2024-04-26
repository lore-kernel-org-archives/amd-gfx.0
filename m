Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28ACC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C09611A8E0;
	Fri, 26 Apr 2024 18:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mth+VRyR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC5511A8E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkStAaWlE/QyYCsttljoquZZWLq6VqB7Da1j2vPRd8PzJ9SA7aSz8rz2drPbvDaR9wNGNBCm4Y0QQheZ0NXiVvfBQIy9SE9MNxWixkY0x0XLnQmFyrnu7hlLv2RXTPULmrcQrSTElTwB+FKaH7QeNKqAfSFvihPLTvgttUTwLIukKxdQRK7mA/ZlmnazsVRWG36nQV+/ILV7XuNrCz2bb19LAqUV5/aqncQpW7CjCiLdQsmsu1ofRL6ABbb38tlzj+24B8IueB5QEj2/P0N2YYnBh/9gwYn4gWI/f8uJiYb5bBeJ8zThWC8eQsapd9WqhdB4U9YEIsnN23qIi0QUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsZ6z7224tv7cm4MLIc19WGWDduPlP17nNoChqynjSw=;
 b=M99XaJJuKBs62mKQ2/NWSCUJTJY4mo9/XI/R3+eK0EMDBdpapzwEziZouxBNHeve8XNVVRpwSkm91NTW1ih3aFdmJqPbBZ7qUHQeBsPj0LW/m3gBm9fL0r0iJhyg5vvgkodGEF1XvD9fD4NsON/oGPOCsi5rj0r5AX4DcY0CP8qOkMKDcv0WsZeYqYeddL+vPAOg9nBLN5pwzH9o2pU6dJdiAWwsA5fKcg8EnZLlLiQH4YarRScrf1faqVILIWxfgUOq4tagETofyGj4wccthhV5Lg6yQ2HNA8Jqm5wGmf/+bBqxErt+tdW8ti5ypZSJubdA720kzx2V9fH9MSnwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZ6z7224tv7cm4MLIc19WGWDduPlP17nNoChqynjSw=;
 b=Mth+VRyR0q+Qib6IJgZAcYKa9qXrbuHKP95KfvWfM5Cz8xYdYmgnNfdmkPSW/3HkOMqDgVVkpqTL8aDXEfmXvQiLk6z0qKWJCs9+T3fdlzoZaWY/lBC/NZA+oGTAX4kWRWjm9orkyoqFdTAOf4vDOkp8bmzisp2e58KC9cehUEI=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:55:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::5e) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 18:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:55:48 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:55:47 -0500
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: Flush the process wq before creating a kfd_process
Date: Fri, 26 Apr 2024 19:55:29 +0100
Message-ID: <20240426185529.529811-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bd1e08-91e2-4f96-b65a-08dc66227cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qsdg4hMHLijHzTMDvnfwPxpTs57+rcPB7TzMqDPHB1aODW/9MGUpdoq+s1S4?=
 =?us-ascii?Q?lmoDu982Bc8XeHILHSOWGFzUpxhE0S2CcfrA7B1Q3x6nNYyW+GVaqOzWAVHP?=
 =?us-ascii?Q?XC+7AEU0iCeDte8zTpzxuLvt71+ijUDW5nxWISgq8ch9krGErI/I6d3X9PcX?=
 =?us-ascii?Q?GO4iaqmFb9wlssX25b0Y5V5ztckvzaJyrKKxNaBoHyTaZ4q/BDVKqxagF7LJ?=
 =?us-ascii?Q?xHHCR7pAThTOR6KW1Za91i+dWGjar0HwGnRvdC08PEPJeFez3nhCkvk5CrGo?=
 =?us-ascii?Q?Sq+2DlQieXf156h4RjvI1vJDzLtHLQsHSlpzBePiaWMvb3svUlZlphvja/3X?=
 =?us-ascii?Q?ECi+EaZwTICTaQiZadWR/iKo+lGTSkrHu8Lem8k/9qsrSNAweeBWIlNlsTeh?=
 =?us-ascii?Q?KOSaGNZHnme+y0bXUF7BCJgl2tdy0euhcfzeB+6Kzho+atQQr/rveLm/DXxJ?=
 =?us-ascii?Q?kYwWOKW1uaxvWTA4NDy01E0Sofl/HW0nXO4czzFfi4MfRAMWbt4UgptnkdK6?=
 =?us-ascii?Q?Tal5KXlJ3OKrM269lVkj/pn5yOpOpY6wIUz7BF2EPzLdtBLKKmk/mWWgrC8c?=
 =?us-ascii?Q?zs0yPvioFIQPj+zzfrzkDgmkcCswIJ/gyP02F+Tg27VacXXV56W9YqdPyqjW?=
 =?us-ascii?Q?JGtWOdWQOmipdGcRYjiCNLlsZgg0vwS0zieRASiMp99zCJUg/X8WFOom62SX?=
 =?us-ascii?Q?KICVWJIA7c13vNvXhpGIejN8YJRBzgg4URRh1Ojjc2rS2lrZRkdYMPpxFPhw?=
 =?us-ascii?Q?XQJlhlRkNbBQHcA25L6M+7nxbVKjc2lKmgFrGF0nSNRrpYphnZ6tuOxzrqGW?=
 =?us-ascii?Q?zG3L8WC7bsxg+XibumdYAW9OQYy+fEIvnjjl8HDnHMmUSZCIBPO5FFrscGYN?=
 =?us-ascii?Q?yyixKat4+9CFSL8it0sf00N1nJAW0DHHQ+564jg3SlP2cJ3OHmGv0I++Fbap?=
 =?us-ascii?Q?MPrVa6N6op1CFRaJcd7rjC6VhBOQto6uxQuCfDp1xy4DOeYInmbuj3PgaiK4?=
 =?us-ascii?Q?/BWNZPI3FviItzYDS0gxs20sUaYUy9mqij7yIYf8siS37eJ6lmHfiv29nc9U?=
 =?us-ascii?Q?znLacA+uuF7rhVTDtBj1ZbOohXHoX/6nNax/TBcwrN/OoIFHBFYZT1Ww9ZwR?=
 =?us-ascii?Q?jv8KiGjwY7uc9udwTr/MB9252jbw0JA2E0YghADcN3oO3KmoHISGzNyf/nEC?=
 =?us-ascii?Q?zcSEsp5CQ3fW7eduqKKy4t5Ji4+4Bj3fvbRkrJqVp2BMLuWvZ1BQBl8mOXwn?=
 =?us-ascii?Q?mrWvvPJg2gPWoHx1Or5p1MX6ji6cCuAGGZuDJh+wC2LzPMTnE3U7haQ/BAKa?=
 =?us-ascii?Q?4DD9VSux6UA9/y1EuVobbZ9m77r29/pAq8GD/NvQ1g4bqq8kVCGdm9Mh0qDT?=
 =?us-ascii?Q?noRoJ4z5W+9VjFI0K8NoqOfoDowW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:55:48.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bd1e08-91e2-4f96-b65a-08dc66227cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

There is a race condition when re-creating a kfd_process for a process.
This has been observed when a process under the debugger executes
exec(3).  In this scenario:
- The process executes exec.
 - This will eventually release the process's mm, which will cause the
   kfd_process object associated with the process to be freed
   (kfd_process_free_notifier decrements the reference count to the
   kfd_process to 0).  This causes kfd_process_ref_release to enqueue
   kfd_process_wq_release to the kfd_process_wq.
- The debugger receives the PTRACE_EVENT_EXEC notification, and tries to
  re-enable AMDGPU traps (KFD_IOC_DBG_TRAP_ENABLE).
 - When handling this request, KFD tries to re-create a kfd_process.
   This eventually calls kfd_create_process and kobject_init_and_add.

At this point the call to kobject_init_and_add can fail because the
old kfd_process.kobj has not been freed yet by kfd_process_wq_release.

This patch proposes to avoid this race by making sure to drain
kfd_process_wq before creating a new kfd_process object.  This way, we
know that any cleanup task is done executing when we reach
kobject_init_and_add.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 58c1fe542193..451bb058cc62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -829,6 +829,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
+		/* If the process just called exec(3), it is possible that the
+		 * cleanup of the kfd_process (following the release of the mm
+		 * of the old process image) is still in the cleanup work queue.
+		 * Make sure to drain any job before trying to recreate any
+		 * resource for this process.
+		 */
+		flush_workqueue(kfd_process_wq);
+
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;

base-commit: cf743996352e327f483dc7d66606c90276f57380
-- 
2.34.1

