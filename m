Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831EFCF9C73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 17:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0601110E791;
	Thu, 20 Nov 2025 17:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8Y+XFHF";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460FD10E791
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 17:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbqIqNn1RjsqFNnvDa3DlRj7HHbxaT51o3I054AaMvTWETdAmbz6tCKnoMC/YM5WkfZbwOnCv8dm+YPhteWkQy882i9OLNKpmODxxZezPAMqp0G9K+bgYnao1RFyYV6A10hOTjJF3QuCi8ThpHlHzJxA4nvn2x0NNCQ2IqKErDbOIDTvHV7S/1Q+6spnKi9jiEKaS5dUA7VONct4v0LZHSD+MWBlBBPwcv+01v2aoT7HoQYXmrM7jVPvaFQ5A2Jy7Vaqfm5J+SLTCp8B4AhWfy+ZQM6LTP9a4HF/LAX30vXKs9NcPvnAi9z5HpqLS2clomDaIUyVbr2ewTSWi5ZiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMgnKA91qN7RGr1B3QTie5GbHl7D5OkZHkpSmMpCJUw=;
 b=a5Y57s3ZFgfUYDadfVa+EU/gddCJHuEdSFVeyRVPumkzyQCN23F+wMZRY10ptswQmcPv9QlPXGXRvdRA57zMFnaA9nJPLaOo0aQSti9ilivTsXPa8m3xv6eHwF8HaXemacgY0U4/dLaZ/9I2al/K4d2Yn4icwm2oxyfY/f7CDVbk2C2KZJazPwf1jRXGPJmly7GcoRVCstFuIZZK5kJhopzTLf+1QtKhfU0x/pwwcKD2zMW9qKps0G2+XODppNVYsuYJnyupf/CDTyVlxr21vOKMXwrt8jyBNdqGWXpAuio6/mhjdLLqjnB29U6VcCeDU4+mDbZLhwqh906gcQoKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMgnKA91qN7RGr1B3QTie5GbHl7D5OkZHkpSmMpCJUw=;
 b=g8Y+XFHFbL7OVDPPnqhRSTY6WYoSbNtrbUWZKJex9qTJwQY7qtfDDiijXZ8RsvrCBY6USsNatoUMbWoK/n9Ms6w3Futt/79hBuGus1nGSCTbsIlo1ODSZnxdKODwCFRZqUdcmPsrOFYW8tDUK9h7BXGPXWEJlZvx360xx16xKf8=
Received: from MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 17:20:10 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::f2) by MW4PR03CA0111.outlook.office365.com
 (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 17:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 17:20:10 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 09:20:06 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Move ras data alloc before bad page check
Date: Fri, 21 Nov 2025 01:19:49 +0800
Message-ID: <20251120171949.7529-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 82622be7-fb56-48f0-4475-08de28590efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?izFtlGdBtZBz+Msazp4GmualbSkE72Yo+iyp5QH5aWs64cqRYk49EM6T6LOZ?=
 =?us-ascii?Q?a4lWIFAEr/OYcAWK3hNTmt24SskvE5tXRb/p8d9vJ4Ozmar67AI/yeEPBbxU?=
 =?us-ascii?Q?69on830OJ4npEtlm2uCV124Mq2YyF7Mok1Ry1zCN7XJOzAIzE6Y6d62cdb65?=
 =?us-ascii?Q?RHJlLJmteUPulSOt1lxCuG2VIAW1E4ChB6znyQPAW6F0r36kduJASUoyqf76?=
 =?us-ascii?Q?Mwe+yjjh5pIBncdvMY9Esxocc0o3aW61X/S7nvmymY8KaErGuNoxoxXS2Mct?=
 =?us-ascii?Q?Nn+z0r27mydKFZgxgFTWLuiMf/nmgft1RUknNgztWys7e9Ic9ZRMlceoOmzH?=
 =?us-ascii?Q?UnWNieEBtuoPxzzPINgO7p7Ph/Bp0UN7aSJ/VewBeyZMJ6G3Ke93gsLu96xM?=
 =?us-ascii?Q?0KKIVY1Kz3cD+PYAttFgFzVwnReSUS3f78g47xkPmyqYNhHS/rQxDArjsTrU?=
 =?us-ascii?Q?hRVMKZfQxWDtN5tizaDPxyUEAkKm+u0mo4m8NURpzhRic3Yz/ONKjI7WEiog?=
 =?us-ascii?Q?vFUU8ArRxS7zYOD1eCFrrNUPCGLad9bWLIfymqcWLoEKrktr6MOqLVGMiS+X?=
 =?us-ascii?Q?KQMe66r01aXW1w4cMyXU22Qtk+ZcVA68zkTKCESI/7UuWxXidq9+Kwtm0rmh?=
 =?us-ascii?Q?Y+zpB4tWfuH2moNybugSI/VJp2ZctYdmRYToG8im0ll4Wa3YeL4IrN/XxN8l?=
 =?us-ascii?Q?pAAAZ0z+tWfeiBMEv1IdnmPC97dqR0t39DlH0XCNTjUgc+/cZ+mjx+CnmCAK?=
 =?us-ascii?Q?rzNPbQyooprvHv2HrCvYq0QRRkS6hO4HVCHVckTu3t8Ok9ThawcTsqzvK2T9?=
 =?us-ascii?Q?8YNEEOby2tlf7r1i+nuCcC4WXOjVurplJg37oyOPV7Py4w8d+ZgtLLzqbdCc?=
 =?us-ascii?Q?ox6fOeNYr7wlN2ppmPn85XhzwXn78gmvjc5LXmZgzJXJoojHb3Us1fCXDZPe?=
 =?us-ascii?Q?EgcmplpM/s5lvTZ81C19lqjMckZGySuVLim8QXSX+5Fs5hpWgJfNM6k2ggLY?=
 =?us-ascii?Q?XH2EV//vr4qodbu/hc27eO7GXUYjCGXCqwHoZ8CfaebvVvJNmOQrZTqQ4E7R?=
 =?us-ascii?Q?3lrrV1Rth7LVi9zAqtfmooEpsESDaBZW0S43OFhL/xx4xWRvYDLFhd7h2IP6?=
 =?us-ascii?Q?BcomxofimIB3WDrqSMMvF2GXbQGMeq9gcYvyXPYla0jT4RumrRCCAqlv6Bzp?=
 =?us-ascii?Q?SVabh8xx8gFJqo+fW62ikJkMHg+YMrkAITx7uYMRx8LCY4v2X9KUO0UJm/yM?=
 =?us-ascii?Q?NuKNcplDjW2fYW61G94YbCLPoy8wyjBvTG0hKiDSn7SnCxT5gSTco6PMs5Sb?=
 =?us-ascii?Q?sBSK8QO8S8VAf9Qma3rwDLkhR3OyR4wCfQRRT3yqBUeFYLdGwbrC/VwzAJCu?=
 =?us-ascii?Q?SiOgpD8GdqWQDY3vUv2lvMrA+ckVXHbuuAlieNKZVny87PwPkZeIzWPfsu1y?=
 =?us-ascii?Q?yO5SsKoqlmKh8hwmkQYwQytl63Dq9Zog4zquwB++j9bSbXyd//88tQpwTI+p?=
 =?us-ascii?Q?QIQl1mHWxlUa3VZUM7RmTlMcU6VnIrFWEIAJ6otxZTa7fkBLW67VToa2VM0C?=
 =?us-ascii?Q?Xz1ovGOHWmn46g/Pjy4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:20:10.0891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82622be7-fb56-48f0-4475-08de28590efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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

In the rare event if eeprom has only invalid address entries,
allocation is skipped, this causes following NULL pointer issue
[  547.103445] BUG: kernel NULL pointer dereference, address: 0000000000000010
[  547.118897] #PF: supervisor read access in kernel mode
[  547.130292] #PF: error_code(0x0000) - not-present page
[  547.141689] PGD 124757067 P4D 0
[  547.148842] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  547.158504] CPU: 49 PID: 8167 Comm: cat Tainted: G           OE      6.8.0-38-generic #38-Ubuntu
[  547.177998] Hardware name: Supermicro AS -8126GS-TNMR/H14DSG-OD, BIOS 1.7 09/12/2025
[  547.195178] RIP: 0010:amdgpu_ras_sysfs_badpages_read+0x2f2/0x5d0 [amdgpu]
[  547.210375] Code: e8 63 78 82 c0 45 31 d2 45 3b 75 08 48 8b 45 a0 73 44 44 89 f1 48 8b 7d 88 48 89 ca 48 c1 e2 05 48 29 ca 49 8b 4d 00 48 01 d1 <48> 83 79 10 00 74 17 49 63 f2 48 8b 49 08 41 83 c2 01 48 8d 34 76
[  547.252045] RSP: 0018:ffa0000067287ac0 EFLAGS: 00010246
[  547.263636] RAX: ff11000167c28130 RBX: ff11000127600000 RCX: 0000000000000000
[  547.279467] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff11000125b1c800
[  547.295298] RBP: ffa0000067287b50 R08: 0000000000000000 R09: 0000000000000000
[  547.311129] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  547.326959] R13: ff11000217b1de00 R14: 0000000000000000 R15: 0000000000000092
[  547.342790] FS:  0000746e59d14740(0000) GS:ff11017dfda80000(0000) knlGS:0000000000000000
[  547.360744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  547.373489] CR2: 0000000000000010 CR3: 000000019585e001 CR4: 0000000000f71ef0
[  547.389321] PKRU: 55555554
[  547.395316] Call Trace:
[  547.400737]  <TASK>
[  547.405386]  ? show_regs+0x6d/0x80
[  547.412929]  ? __die+0x24/0x80
[  547.419697]  ? page_fault_oops+0x99/0x1b0
[  547.428588]  ? do_user_addr_fault+0x2ee/0x6b0
[  547.438249]  ? exc_page_fault+0x83/0x1b0
[  547.446949]  ? asm_exc_page_fault+0x27/0x30
[  547.456225]  ? amdgpu_ras_sysfs_badpages_read+0x2f2/0x5d0 [amdgpu]
[  547.470040]  ? mas_wr_modify+0xcd/0x140
[  547.478548]  sysfs_kf_bin_read+0x63/0xb0
[  547.487248]  kernfs_file_read_iter+0xa1/0x190
[  547.496909]  kernfs_fop_read_iter+0x25/0x40
[  547.506182]  vfs_read+0x255/0x390

This also result in space left assigned to negative values.
Moving data alloc call before bad page check resolves both the issue.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3140c20a6c81..83194eb6344a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3076,6 +3076,11 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 	struct ras_err_handler_data *data = con->eh_data;
 
 	for (j = 0; j < count; j++) {
+		if (!data->space_left &&
+		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
+			return -ENOMEM;
+		}
+
 		if (amdgpu_ras_check_bad_page_unlock(con,
 			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
 			data->count++;
@@ -3083,11 +3088,6 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 			continue;
 		}
 
-		if (!data->space_left &&
-		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
-			return -ENOMEM;
-		}
-
 		amdgpu_ras_reserve_page(adev, bps[j].retired_page);
 
 		memcpy(&data->bps[data->count], &(bps[j]),
-- 
2.46.0

