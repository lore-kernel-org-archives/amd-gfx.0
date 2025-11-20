Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B3ECF64A5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 02:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4B110E6D4;
	Thu, 20 Nov 2025 02:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5dEZ11fq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D465A10E6D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 02:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/yiZVY3M1+7TuOJXBO8+W0syS4vICFk9Vg1FGKpNLu2UwhF6JPt8qIcSy2b2enBflfcF4N6bzVxerlvkehkRcntOW+KNcp6i28hLY4MUzNo/+hMxrbc1gy+Vi0V6ZeqGPRZysCMjI6Xr8nlPr/WpX1ITCLj0dP6UItHxQ3x+/ZKjtM6nd4YKuXMvOvrTP+yAvEPtFaOWdXtXRjT3YerRWtgjHbrVsnPD4PBVNJHKH5myShOOKedh97xjhrngAT1wDpZlpumme4WicvCGKJB1T9JfkSOL6QUr3TWEAuBNhvSFIpbOHIegSzS+sDsPiFwnKufA6hkvj4FylpCYeme2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOOxEhBQWKSsca7j2DFCR1KwUWDDYaWnA9zEZ2YOH8A=;
 b=LYQd9rhWOus86ffcBCnm5SqZma0tiwYgUHKDopuK81EDv7BGOwWkS+OrTKr4wsLjWioDNJwjTspx9n+4Kiz7toZCXNSt3SQLBYWrAY6Kk2HuNL7rjVOx4cVu/m1/zGirFdTJSIV4ZS6gNGLpaXfAkDDyh4kS/YIE4jhjtTtQ9/NHA5mZwEABb/+cwVEHOZWYb9brOwqbs6lshkDwlu7fawmkyQiDx4lboKU9E5CByYRb/eD++ycS47kfD9EhSwADjFmhyihngRsr8yRuhEdPkRxON76DM/YFltzs9DRs+TuRatgUsD+qo/pn3+U/Ms3LZ8ah8ZvQ/HU/7i7AhSjZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOOxEhBQWKSsca7j2DFCR1KwUWDDYaWnA9zEZ2YOH8A=;
 b=5dEZ11fq+ZDS/7WxfwVQYsy23l0EYmLP7QHb2xf0XbcBBJe9rJsoshdVWZ6pGhK0y4ra6k2QNcxJWzAHaRwmv68OvSwi8SOCQdgoqpOO1NwPrMcJQ1bAZzwB9lxZ4vp13RP1128BrNmWlvZ+YEGtm35A4+xE2Gv9/VomWKFGWQs=
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 02:33:36 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 02:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 02:33:35 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 18:33:31 -0800
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <candice.li@amd.com>
Subject: [PATCH v2] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced on
 smu v11.0
Date: Thu, 20 Nov 2025 10:33:08 +0800
Message-ID: <20251120023308.2628705-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bff6e6-6ea3-42d7-1942-08de27dd34af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xdo/vCemRC7/bwrUJnvfZtZZkUeDTJYyt7OqSdtZCf97D4kXp73cznOc40JQ?=
 =?us-ascii?Q?M8XPu4SBVV+BdUbsT1pap+QZGMxi6ag+CYnaCqI3wJnNoGSWYSHaQLgZVlvx?=
 =?us-ascii?Q?ZPrLVPQtgmOH6GQeznTCWuRk2DmUkkT2afrric9gdSo3+cmlBbWJph8x8Ivj?=
 =?us-ascii?Q?suwUzdR/7KPmSovE35yQXaxjtgatDmrKNFuW+sfTmie8zov48uHIDNHjil2e?=
 =?us-ascii?Q?NvJNXSEGKav12m2EkqbV4sZyLmgiCw48TvPChOJkGb80/UH7O/DULY+MvT8c?=
 =?us-ascii?Q?TJ95NxqoWwsXp2m1ObRQLzt0CpFaOWz8o4jS6UOk3s4z12iLzRy+BKc/TQdi?=
 =?us-ascii?Q?7vGuufKVXK9TMT/ejUKoYM8juKw8ElwJQxMUyybvuIUkVNlK+TO09tS5oJZn?=
 =?us-ascii?Q?XWr9olIBDp6M1XIjmsRIOqShIoKTUHb61dgDayl9RX/637Z0ecO9rT/qqZxN?=
 =?us-ascii?Q?IKYtX/S565ldvpFHYLiwfVbOXpebIgtnG4yiophRIQy8jOO2reieSmKDHvVG?=
 =?us-ascii?Q?1fuMT8+YJoYn+TGZjy5iaRfA3htLeHom+S1T6MWSEN9jp82pKR+YmpsWQ31v?=
 =?us-ascii?Q?haevYpyV98PeGcvJdzZp/vveqdTj4xuZ6mSnXNc8wCFssSP36u53BqL+PcGr?=
 =?us-ascii?Q?/UjZ6ppsuskAWFGopvhj2WvplU962qZmiKlX2Y/QrtmEn1+LTpoKyHoERqIr?=
 =?us-ascii?Q?trVdZLg72WFisrNf9skc2Ff/lTP5XG7pyLjyRE1+T2GGYxIPPOgQnPotqoOO?=
 =?us-ascii?Q?MzIedsfIVcKgrCcpdefsa0v181aAJycHIyy8cxp8WWGvKuPWhBIWicNCx+s0?=
 =?us-ascii?Q?440pjnUVrZhwt9P5VD8rPqpz3tcE+7Reit7rZtwHXhXtG/aBNIgkGxBcQ2nM?=
 =?us-ascii?Q?CHfEx+TVlYwMydxc8ptUbhNLm8lDk5RdDHQKBQ1mwTRCUJz2HNk9HiSq3pfe?=
 =?us-ascii?Q?KVoeBkSqrr75R591vnzEmAFOgdrMlHjyUlockI4pIlKqBFe/DUeUXGE5FDMZ?=
 =?us-ascii?Q?v0S4hyyT401wixMt3Zz+aYNBeHTv8y6nfDsrliUOIjVQO56OTSlY1yFeKISJ?=
 =?us-ascii?Q?4KyeKR1yDtENmWwe+XUENSKkUYaR3ehI6dqUQiLZQhOXLDdsbABL6d2lvMM1?=
 =?us-ascii?Q?2vPTec1SDJDYocx8d5vza1mu7eiGgKFyXts1jkIRKvC3QmVYnEbDgzodzJXv?=
 =?us-ascii?Q?xO3STrDIqywB3ijy7C+md/mwpQbbkvmuxdv8bcmw8cWZiZ3prn608ERk4WrU?=
 =?us-ascii?Q?J2Ejfv/PNiBL/H+e6g/EtLA2n0EgrUYd4d0wT7X/Aa/WIz3pumXPPm7vRmjT?=
 =?us-ascii?Q?ltm37gMjYB+F4zenUmZK87XGrqzli1/hXyS44+mwXrQp49Scfg44GsqyAhZ+?=
 =?us-ascii?Q?wRbiSoeD9pT3e1KgDD3ouLm6/DaCqQqr/TaEnwudvKDY7REmjEdmFM/GOLHr?=
 =?us-ascii?Q?fFKnLnsNQ8lOT+/YSZWTsaYESGRg/5rsJBqVB3q2Wm3PKm96Qn4x6+HjNfIZ?=
 =?us-ascii?Q?LH9tqLKIkohEWwLgU6JmzDnLGMwdzVRiRSjBzog2k73Axx7z8BRZRE/a+c3u?=
 =?us-ascii?Q?nFOZLiUQw/UMjsrJWmc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 02:33:35.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bff6e6-6ea3-42d7-1942-08de27dd34af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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

v1:
- fix amdgpu_irq enabled counter unbalanced issue on smu_v11_0_disable_thermal_alert.

v2:
- re-enable smu thermal alert to make amdgpu irq counter balance for smu v11.0 if in runpm state

[75582.361561] ------------[ cut here ]------------
[75582.361565] WARNING: CPU: 42 PID: 533 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xd8/0xf0 [amdgpu]
...
[75582.362211] Tainted: [E]=UNSIGNED_MODULE
[75582.362214] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS F14a 08/14/2020
[75582.362218] Workqueue: pm pm_runtime_work
[75582.362225] RIP: 0010:amdgpu_irq_put+0xd8/0xf0 [amdgpu]
[75582.362556] Code: 31 f6 31 ff e9 c9 bf cf c2 44 89 f2 4c 89 e6 4c 89 ef e8 db fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 a8 bf cf c2 <0f> 0b eb c3 b8 fe ff ff ff eb 97 e9 84 e8 8b 00 0f 1f 84 00 00 00
[75582.362560] RSP: 0018:ffffd50d51297b80 EFLAGS: 00010246
[75582.362564] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[75582.362568] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[75582.362570] RBP: ffffd50d51297ba0 R08: 0000000000000000 R09: 0000000000000000
[75582.362573] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e72091d2008
[75582.362576] R13: ffff8e720af80000 R14: 0000000000000000 R15: ffff8e720af80000
[75582.362579] FS:  0000000000000000(0000) GS:ffff8e9158262000(0000) knlGS:0000000000000000
[75582.362582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[75582.362585] CR2: 000074869d040c14 CR3: 0000001e37a3e000 CR4: 00000000003506f0
[75582.362588] Call Trace:
[75582.362591]  <TASK>
[75582.362597]  smu_v11_0_disable_thermal_alert+0x17/0x30 [amdgpu]
[75582.362983]  smu_smc_hw_cleanup+0x79/0x4f0 [amdgpu]
[75582.363375]  smu_suspend+0x92/0x110 [amdgpu]
[75582.363762]  ? gfx_v10_0_hw_fini+0xd5/0x150 [amdgpu]
[75582.364098]  amdgpu_ip_block_suspend+0x27/0x80 [amdgpu]
[75582.364377]  ? timer_delete_sync+0x10/0x20
[75582.364384]  amdgpu_device_ip_suspend_phase2+0x190/0x450 [amdgpu]
[75582.364665]  amdgpu_device_suspend+0x1ae/0x2f0 [amdgpu]
[75582.364948]  amdgpu_pmops_runtime_suspend+0xf3/0x1f0 [amdgpu]
[75582.365230]  pci_pm_runtime_suspend+0x6d/0x1f0
[75582.365237]  ? __pfx_pci_pm_runtime_suspend+0x10/0x10
[75582.365242]  __rpm_callback+0x4c/0x190
[75582.365246]  ? srso_return_thunk+0x5/0x5f
[75582.365252]  ? srso_return_thunk+0x5/0x5f
[75582.365256]  ? ktime_get_mono_fast_ns+0x43/0xe0
[75582.365263]  rpm_callback+0x6e/0x80
[75582.365267]  rpm_suspend+0x124/0x5f0
[75582.365271]  ? srso_return_thunk+0x5/0x5f
[75582.365275]  ? __schedule+0x439/0x15e0
[75582.365281]  ? srso_return_thunk+0x5/0x5f
[75582.365285]  ? __queue_delayed_work+0xb8/0x180
[75582.365293]  pm_runtime_work+0xc6/0xe0
[75582.365297]  process_one_work+0x1a1/0x3f0
[75582.365303]  worker_thread+0x2ba/0x3d0
[75582.365309]  kthread+0x107/0x220
[75582.365313]  ? __pfx_worker_thread+0x10/0x10
[75582.365318]  ? __pfx_kthread+0x10/0x10
[75582.365323]  ret_from_fork+0xa2/0x120
[75582.365328]  ? __pfx_kthread+0x10/0x10
[75582.365332]  ret_from_fork_asm+0x1a/0x30
[75582.365343]  </TASK>
[75582.365345] ---[ end trace 0000000000000000 ]---
[75582.365350] amdgpu 0000:05:00.0: amdgpu: Fail to disable thermal alert!
[75582.365379] amdgpu 0000:05:00.0: amdgpu: suspend of IP block <smu> failed -22

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 7 +++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 859a17c1f7e4..2aad25dce009 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1669,9 +1669,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		if (adev->in_suspend && smu_is_dpm_running(smu)) {
 			dev_info(adev->dev, "dpm has been enabled\n");
 			ret = smu_system_features_control(smu, true);
-			if (ret)
+			if (ret) {
 				dev_err(adev->dev, "Failed system features control!\n");
-			return ret;
+				return ret;
+			}
+
+			return smu_enable_thermal_alert(smu);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 78e4186d06cc..b0d6487171d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1022,7 +1022,12 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 
 int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
 {
-	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
+	int ret = 0;
+
+	if (smu->smu_table.thermal_controller_type)
+		ret = amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
+
+	return ret;
 }
 
 static uint16_t convert_to_vddc(uint8_t vid)
-- 
2.34.1

