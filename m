Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68643C61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 09:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B898810E782;
	Mon, 31 Aug 2026 09:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgXqNG50";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEAA10E782
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 09:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoazqaqypDgs+MFiPtLqv0UZYaKHNpeVb6Up1HInRWKYmFwm5Cx3qulSDateBKzbmcG/b0rhblhNWPdW5VvM1qH15fUZXa8Q16RaTKbhHe1veLcfz1r7IZqxqBEiwAkapETHuSVlx6jJKpPdNOu54AZ6u4z9fAVbTxBfc4RFJE24K9WFKKljobT6c5sStQeT3QoPmOSXXQHNbjHdSvmv3WcSnynkfj4NFgFXu1e4aGGNbMAu1eQtQ/FqT8w8KpyFtzp4RqN1AnD8R1K2qtMMPKgKABE5HLIbD/9SBNWdxwaoGUt4tuSXRzompVTplCUU8D4qgBwYImrO9vcbDbcGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrHgM54S9btEdSt0MsUm8YT4TTTyIlxXvfHGwHbfSDw=;
 b=fXvLWlzBQTod7DJDHGa+zUSbvxw4yGgwGEh9Des3/nAQCGRem4aYXuTwDmjbnNiuS5ifSSwM1Nt+wsaSXih4h7Lm3PIDC+ftCIgNAp9CGuZl4nBgRPuDqhlh5QH7QMY975rBy2B2hxF+N0jhJm5lrLTf70PPJKubMFJJcDkpcgHsSwe3mr2WDpszWV+HF3rVO3SnDKTUrEebp5i0JIHANdKSQ/9wID0dbznRARnAK0zmcnPqzzcWk7MfzL9iy0O76WoHNzzLbxxwGTCq3voBDsw88xhUlZ2GI38rVKWKBeyjzGJdcnhgdHDG5f/iA5B5MTpSqSK53F6GDHkTX+4XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHgM54S9btEdSt0MsUm8YT4TTTyIlxXvfHGwHbfSDw=;
 b=sgXqNG503sySUTHW8D+QgbK9HlJ3G+ItLheg4ZjIpMEnfRjmkLEeHcDMBJBEaNrbnLDpTXRH9vmTqrnuStuTeSRQPx7p3/JGbsZ3WnYY8eDrbPyHwe4Y44wbjkSPx25Nwo0+3Px94GSsWygyfwYeqUt2S3F0ZKCf1DKQcX4QAcE=
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 09:09:13 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::59) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 09:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Mon, 31 Aug 2026 09:09:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 04:09:11 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 04:09:09 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Shiwu.Zhang@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1
Date: Mon, 31 Aug 2026 17:09:09 +0800
Message-ID: <20260831090909.30544-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b27153-9b65-465e-729d-08df073f864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: GDljxPHUyJCXYN+nlcFAq/ObCyKbXnm62TUD+M9pKiE140wcyd8FHOPQB5OCpH2CWhD11ZCf8KLewEimKgAfpCqPO4enHqL7kFBz23S4EJUmjK2CYr8rCKtQY3AOH+hn1ikBptPxLVkpT01ACJzVjGnxX0IkKwZBC2Nlh5M9+zxBVky0E8XL3nmBTOZ9/dv47FdSJanNrhWafWg8POZOQLJIUPNajnouHS6bZV6WELqZSEGAieorO2TMTzQY+hUbnG4F0LmPb8/Imm3v6DfhTS5chuF3sw6R8YFU/u8Gn1aJse4ZbmBpDEJDVMu/CGoAyjhMQK7N4YPzDZJouGYozShAM8RUW8n9TCXMt0GJgoPTrNRD7OSQ/MNL0IEE8k7BX/fA3rZCoo8gDs0r06sTkNpgmhj5+vZeEaDCQtJ8+c1OC7oLPjHcjLONilZN07xSOvwlzkyaTST8t52j8fL82qjmWcXveSlwZwXLvFJ5kMJ0IqWedF/6CXZeh3qmDMVFv7cSP1FfceUcsj7j0qkuqZkeNt6Z7bp7neMUONFQ6/Sd50MOaNPmIdJOH31Yb5JuGerOcS8CVqIEOhQTwjNs6zt43WNoaIaP1tHefF/NVsUSfZc5BiNKZgEXOf27BDj58AWMqfQiP8/yWUC/ZU9eaJOjkF1iR1zKD/GXdU8YnPO3iNqrtuO3IJwN0rHhrwDUovTNooBdgejwdAxUXT91yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MU2kDgHyKCEOTE2brHsVs8zW0H6ehFqNe1Ov480QdkFvkBzl91mclyIYNSoyazGhzzrRQicPmcxWj88Hd/gfpN94jihNyqH/wkx+im+isJ44rrwtMiKvIBbYmrbe/urYa9uHXh8n6XO6jEmz9gPigg554svVgrG+OiuzcuTl1MVY6L3Ra8iEuOzMvEoWXZEU+ouePjRCpvlsCYpPbUfEtv7sc4yuVkoTWP5dYCpCn6bva93EoQoLBYr8dF0db6T489U3Bn9IjVqiYuwJlgJUVtcjoWg51CHblDtTrvQs6nfg7WlqzMHMS95bLkqeM31mDc1Lrj+En35c7WtE84rWIFuPOyvQncw/JdV+tJZHJBLq9VnsVtCGVuXEGfE/4BMzQtxrYe0IOZ4PQOvB7+qqoYQBU7plNAcC9pq1pVTgajzWT3l1WLjmavIQ7rMFQdyT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 09:09:12.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b27153-9b65-465e-729d-08df073f864f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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

vBIOS has the support of IMU firmware. Requesting it now fails and
aborts GPU init:

  amdgpu 0001:01:00.0: early_init of IP block <gfx_v12_1> failed -19
  amdgpu 0001:01:00.0: Fatal error during GPU init

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 82ac39239d78..db06360873eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -581,7 +581,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.mec2_fw = NULL;
 
 	if (adev->gfx.imu.funcs) {
-		if (adev->gfx.imu.funcs->init_microcode) {
+		if (adev->gfx.imu.funcs->init_microcode &&
+		    adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 			err = adev->gfx.imu.funcs->init_microcode(adev);
 			if (err)
 				dev_err(adev->dev, "Failed to load imu firmware!\n");
-- 
2.43.0

