Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80071C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A172810F818;
	Tue, 28 May 2024 17:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fw8WxJWb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6374D10F66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSsZrcgqHjBnUUhpADgYi3mgSDwdq1+p8IIXZLeTUJPpUIAzzJWi7Z0KOXmkYJBj3pFg12OOKpoPGK7DtObgZ16LZ6Q+XBJlwm2Li3mOMkbD+59xwBHqnBJBMRE3/OqAI7HmA9/7NuSvvtW/71OG7CfJ41OshjSw8n3sOMEpck0RzoVrR6BOTUzBRpgHtDJXa0otAFbLJVJwdzXFl6KrxqMXKkaA9yR2zcfwkrJi5n/K09L9K3g2CqzuV3WnbapYtR/uL3UfLjYDb8Fv6GX9yNFx6Mi76hQ/qSPZs1Q5cumfff2llrXm19suvaxTQvDzO3rMZYBMaejtdkh32JjBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwuFT7E96mUcZf9GhmPu2XvDSWdv0KRTADLnlhChi2c=;
 b=BxupdC04uzfGerDX5hUcJbmP++ZvlppPuJrUcKXh0a+mDHfMvJAdDc5fE2hZEUgpd04ToOUZbXkwAkztwtpvEwPuWprN4Q76CnUn8AMyqNRoy6ZRe6eQDoJcg3L706D05UN3d4LGGsS//VfkupWiTl8Um8ogOGaugYGs3qSYBk293t4UJjwpROmh3a4oFOKpfLrB9XatItZK34b3QZnmDK5PItvXdo9od0p2wfK/bWfHDrifYF75KKIeI9OON6dtvPUGcB6+5nJDdX7GfsbhVMG2LB6cmgHMVkr7OGpDQkPpMri5kvGJeBCD/Z1ptuCNnVdk3LbVpJSq0zmA+Bmpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwuFT7E96mUcZf9GhmPu2XvDSWdv0KRTADLnlhChi2c=;
 b=Fw8WxJWbNNsyChd2HQ8moLeo+tjyHli6Rphczy1//rO96sOFmdhTQXsXPWnmEu3tSuXvNRRV3nQx0B7RiZuJrj68Mt+WCbsiBpifWUjxL1duBOCa9aMEWvUXCfH7FGXNsYcbl2ygPzFPhviyGRpBUx9OOt5JTyQSRtjKCUBtm70=
Received: from PH1PEPF000132EF.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::37)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Tue, 28 May
 2024 17:24:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132EF.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:12 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:10 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Date: Tue, 28 May 2024 13:23:33 -0400
Message-ID: <20240528172340.34517-4-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 216121fb-fb29-4c46-adb4-08dc7f3afdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AyTfR6/oQBdV7DXJ5klrAOH4CIDH6hWeDxa2uSW5u4lt1GocCK/O6DvStawK?=
 =?us-ascii?Q?OT9RPdjvh7oG6WAnNkEzPVewKyGryr9Yw/aaTRDXW3vsBo24Lko74YtIaft2?=
 =?us-ascii?Q?qgAb8v7Hgdo2gKqAIhMgDSyYsPlMZ2bzqx1b0+kRpU0S7BHPw92RM5vqhf0X?=
 =?us-ascii?Q?2OsWbf+QIsCbjVeF572dwsEH6VXkB9fmDM58fW/zEAbgiQ6bAzd7mtXXTfJe?=
 =?us-ascii?Q?Gd8vCXAztJ6BHdGPBYyl9A8EG2EKPO34tGhcVZNcq+fG10S4K4VcPDPHudls?=
 =?us-ascii?Q?S4XogCW/mvi10zsRfcGSIC9eqqZqMk29L08fdOrzrAQ+0DOGXuHjEU2KdGM2?=
 =?us-ascii?Q?dIXwELvOPafT2APkkrvhpkiKcMyFl75zgR6czGCzj5Xm4fbsrDEyvIAfNXCS?=
 =?us-ascii?Q?6n8ayOQR9+v9ih0aldiMHFW4HF8zF92skcfHGCOQ9h8HFvfKkMKevB98c2Fl?=
 =?us-ascii?Q?8vVAu+OKFSP0yySkl3nToVPyTWn+8UAneH2yOhOjHSnYMy+F6068/xJ1wa8O?=
 =?us-ascii?Q?m3KoLJ+mL00AcEDaEafeAAxngqDLVY/+TTk88DhCcou2C2W/GQ1Qlxhcj/6C?=
 =?us-ascii?Q?+pgnAMzYWk5Jz7ohaLKYIPyH/nl189jzLfYwafzflNyxJ9FPhDPvG45qwtZ6?=
 =?us-ascii?Q?41zMZeIQLiSbg37nN/8pnClzq4rNMeoqwrmmDne2Fx93aFLI3ujulHmMu6Nt?=
 =?us-ascii?Q?RrlHshYg3N9ANIXsNzBJDdftivnxJBEC/xm5l8A6u30vFsWHWqSch+NMPcoU?=
 =?us-ascii?Q?gcfEjsVqT76grFQgFe6a0+ZgLI9q9cOWLd+YqijP2YLhIvRqia+M2+IeX1ih?=
 =?us-ascii?Q?/SXAdKuK84dstuBMePpFCX6b6FtLsJzWypQ3NJOqe5UDrGB5Vf24R6OwvXVV?=
 =?us-ascii?Q?9Y+qn6BxA+fZx8EGuxxtTgVKpI7WhMaFFF1Yk/jf5nJJ8uzhsmCyw/hSXRw2?=
 =?us-ascii?Q?rj6tJGbhWcgq5lfFbMjR9fKtTOvajKpyAbKjwz+TWKxnjuqnxpMC0CH4M677?=
 =?us-ascii?Q?n823moL74KgZtxXOLaR832eGnB1d7Y00x/DBgEljy8HT7zBKr0btS23+Xitz?=
 =?us-ascii?Q?haHVwfIO8qaIum03UhpLGYOOWQYwx5FAdWLuWXSC6y+yqlMI8Cd2gYhuqK9d?=
 =?us-ascii?Q?r3G0nqWVRY7M4MLKx1/SlmfHAkvF2bfGmNf4Nly3MscQXwwRvLhgiF/kKTHX?=
 =?us-ascii?Q?lGu3rYKcBfEIDsG0DUt+Gz3YsQwyPRdLg1kdxg633BFXZY9Cw0wAJSLbNSs8?=
 =?us-ascii?Q?EDWrWu6rK5Wfivk6k+NimMb5z8QT05rwd7DP1O/KbLp0yJKGkSWd9SKUNh0O?=
 =?us-ascii?Q?osaMzivNlrSq9SEYIgj9vm3nDIdYw1X9ogPG6YLr28WWwJHM1ep204rVcUNt?=
 =?us-ascii?Q?cTfHCB2+wkZLeUX9YcHmiQOnjRZ0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:12.2471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216121fb-fb29-4c46-adb4-08dc7f3afdda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

If a reset is triggered, there's no point in waiting for the fence back
anymore, it just makes the reset code wait for a long time for the
reset_domain read lock to be dropped.

This also makes our reply to host FLR fast enough so the host doesn't
timeout.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c    | 2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..3c04f034d43e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -376,10 +376,12 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
 				      uint32_t wait_seq,
 				      signed long timeout)
 {
-
+	int in_reset = amdgpu_in_reset(ring->adev);
 	while ((int32_t)(wait_seq - amdgpu_fence_read(ring)) > 0 && timeout > 0) {
 		udelay(2);
 		timeout -= 2;
+		if (!in_reset && amdgpu_in_reset(ring->adev))
+			return 0;
 	}
 	return timeout > 0 ? timeout : 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8c6b0987919f..dd22fd93f572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -32,14 +32,17 @@
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
 
-signed long amdgpu_mes_fence_wait_polling(u64 *fence,
+signed long amdgpu_mes_fence_wait_polling(struct amdgpu_device *adev,
+					  u64 *fence,
 					  u64 wait_seq,
 					  signed long timeout)
 {
-
+	int in_reset = amdgpu_in_reset(adev);
 	while ((s64)(wait_seq - *fence) > 0 && timeout > 0) {
 		udelay(2);
 		timeout -= 2;
+		if (!in_reset && amdgpu_in_reset(adev))
+			return 0;
 	}
 	return timeout > 0 ? timeout : 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index b99a2b3cffe3..064cb3995a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -340,7 +340,8 @@ struct amdgpu_mes_funcs {
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 #define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
 
-signed long amdgpu_mes_fence_wait_polling(u64 *fence,
+signed long amdgpu_mes_fence_wait_polling(struct amdgpu_device *adev,
+					  u64 *fence,
 					  u64 wait_seq,
 					  signed long timeout);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 96629d8130b8..38edd60c6789 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -212,7 +212,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	else
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
-	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
+	r = amdgpu_mes_fence_wait_polling(adev, fence_ptr, (u64)1, timeout);
 	amdgpu_device_wb_free(adev, fence_offset);
 	if (r < 1) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c5a03b79f07e..73430b9c4b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -202,7 +202,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	else
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
-	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
+	r = amdgpu_mes_fence_wait_polling(adev, fence_ptr, (u64)1, timeout);
 	amdgpu_device_wb_free(adev, fence_offset);
 
 	if (r < 1) {
-- 
2.34.1

