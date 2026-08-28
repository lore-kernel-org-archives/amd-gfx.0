Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3097DC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5211C10F238;
	Fri, 28 Aug 2026 04:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SR4SuH8U";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A033310E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jao1vtNjaA7AE6pzc5BBa8q7zG8eIU3ZSJq5506mZq0l0Li4LjGBQ8kRPacAdBzSKNlUwMmsX3j1kVF25gG3fOIaKnG8ym+IToSRUDr0HvvjpswvcjeLbJ5L5rTKD24lEXoPZhm0g6deYwhnuwUwsJO/okLz0JJC1PR7AvyExoGIswS5EDkhwhaK9m/3/hWxD1xz6aLlONY2oBP+F0RaaFPR9J05HUqWgOblGauqK7cCx7boJpkbK2a2LNm6nBbYnOGT0tMRBF6PCzB7OTmB5MvFb2D9pCEIZzeaoBE0Gpih/IiVG5Z6lf2wrzeqTMz2D7eIPBxKL/hTrwV/OyFZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbs5iUSXrvIExS+aXXi3HxPKwaGxN3fMb4fTTzc54NA=;
 b=VSGdLC2wUiWFnqKNv/amwK8rtOpnmZZIi7OPZoDgUirgHjaPBeCXFKTILLR4htYjHf3xFcvX4Bad4r5Ij9uUFUC7tQUBWu8xV2sAG4xNsSAZcBfY7uG2uHoHK4BkI3VYnqgva0gY4Ety73tBNuMbWq0LK5tp4IzZsRSdyS0v3mDlaZLnE5OCb8S5N9Y6JDS9vJ/Z1ljLwNMS4sA3ofZ8LAWHsr9Uq20+tm4uGq+aSfsgojMGvuahPxJZF4jzb15++rP56wRFDsFfIK5FGCm53oRMl/nNeEG1HCnySqsKRIljwDR5AnE/E4gzjPoxhTR8W/yKlz9+NOKZS/iNiGZTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbs5iUSXrvIExS+aXXi3HxPKwaGxN3fMb4fTTzc54NA=;
 b=SR4SuH8UNcvnU0FyuHnQ3LXi1fare3BvdhReejTTdLidhAUx4G6Qey8fZX7rmzt/uB1npanHokiDO9EUXEyYmj1BDDLW3Mc8DCMragYlFAQhTtbSklVEvKYKLFtqexIcxhcQUcbr6Q0b2vVMtIsJHBUvx5rUhgWieRoWp81GM3g=
Received: from BN0PR04CA0200.namprd04.prod.outlook.com (2603:10b6:408:e9::25)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:15:50 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::48) by BN0PR04CA0200.outlook.office365.com
 (2603:10b6:408:e9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 04/10] drm/amdgpu/gfx12: implement compute and GFX
 update_mqd
Date: Fri, 28 Aug 2026 12:15:10 +0800
Message-ID: <20260828041537.3464782-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d628745-18e4-4521-45cb-08df04bb0af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RMhAMwTb6v5GhDR+H0kX0dkLr/RF9Tv+1BtpL3GabPOxRtGTt5ytlaVa1iulq2Jcrcl5PStD1dsgxu0yDs3gFvmKXx391MtFZzdYeoDTJmQ6RXREcxS8ML7J5kuStfPrmOivZw06fOT3i76ZMdqpENfPnNtPUv35JrcXHEHDVl8IvwkZ1SuNUwy3yxkj4soG2TYJUcLDYkfxiuhITkLCoQZ6VXBSfJ0cpp+HIT8qtLozudeAwRmKznijNarACcBB+YZy48FvkwtdXfDXLM8F7DS+BpuiLtD59LgL/It0X+g+mN4GWFEb5x8LWKDUKEvWTwtdir/6/SPWhmwPBAtlGeZSz4EdcSmiwGhtBRzuh5m+Sn7Lz29YRAfnwTccEgQHJXVsmEVp2+1Mi3N46SMPlVpxw4yzjOxms32IOY8EKJuGBqI808gkfpfyF2VmaAzyjaVHErRqKM+31IcmVkKjydYeRfDNevvlrU2LXJHjyfCldkS3WIQURUL0+O1t7qznRihpofLvZT/cwImep5I0frdQMbvqOZ5pN1c3CUJ4bTo3tp6lATQxkuwNm5aK7/JcT6Yhol1+Re5DQTfLqLHzL5+a6bL2f9k4Z8i2gyulqQY547rmPjGocWCtyTrg8La60K1GOnewx7gxwHW82yqVl2qWLb/VN0dNvdRfvTH1clYUK//PF3bY1zM3imy+B/wknSOUHKNniJik5qkovBnJQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c4afTG+zqmm17qVeLMBK+ufkhH4dDZdyZIzVYzyjPhtJT47jvbqremWbF2KeT95lr/k7+Si/hvKZwFMNtVg65Hp4uMJhgJ9Am/BMZJPWuXshL9v+QdLG8V5bDjGXkaniuBc8DrQpfC1MZnwAr8Mmb30va3JfThNbiLzm9hoywoqWpzzqUHgWYG6FJFIbdE/rWP+MiRe3NqPWAb7NxrtObsJsdXB5w3Lxq7RPvjyi0xoD6FmNMqmjkJ9+IH0tEeaUhumIc/ppKxzdPK1hQ/8Das/ZZT+eIRo4yjxvP9ze35xyvEhcM6Myr/UOd31uN1dvOkrK6Ajpj7AzlBjFYiurPm8UmQKV0sn6KEig5gs2z2ZBt69/dl+YvgJSaxBXddNodUEUUbqVG/4WXvonU4FyBr5Zb7GLFwVB2WQ5WMYWr2uwkHMd3K0XThrXb97gmAsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:49.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d628745-18e4-4521-45cb-08df04bb0af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
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

Implement the update_mqd callback for gfx12 compute and GFX user queues.
Save the read pointer, re-run init_mqd to rebuild the HQD, then restore
the saved read pointer and forward the write pointer to the user wptr, so
a re-enabled queue resumes at the first un-consumed packet rather than
replaying the ring from 0.

v2: rebuild the HQD via init_mqd and save/restore the rptr, matching the
    SDMA update_mqd style, instead of patching individual MQD fields in
    place. Keeps all update_mqd callbacks consistent.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a434b665d913..7395719d593c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3096,6 +3096,26 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * GFX update_mqd: init_mqd resets the ring rptr/wptr, so re-run it to rebuild
+ * the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int gfx_v12_0_gfx_mqd_update(struct amdgpu_device *adev, void *m,
+				    struct amdgpu_mqd_prop *prop,
+				    u64 user_wptr)
+{
+	struct v12_gfx_mqd *mqd = m;
+	u32 saved_rptr = mqd->cp_gfx_hqd_rptr;
+
+	gfx_v12_0_gfx_mqd_init(adev, mqd, prop);
+
+	mqd->cp_gfx_hqd_rptr = saved_rptr;
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(user_wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3334,6 +3354,26 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * Compute update_mqd: init_mqd resets the ring rptr/wptr, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int gfx_v12_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					struct amdgpu_mqd_prop *prop,
+					u64 user_wptr)
+{
+	struct v12_compute_mqd *mqd = m;
+	u32 saved_rptr = mqd->cp_hqd_pq_rptr;
+
+	gfx_v12_0_compute_mqd_init(adev, mqd, prop);
+
+	mqd->cp_hqd_pq_rptr = saved_rptr;
+	mqd->cp_hqd_pq_wptr_lo = lower_32_bits(user_wptr);
+	mqd->cp_hqd_pq_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v12_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5543,11 +5583,15 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v12_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].update_mqd =
+		gfx_v12_0_gfx_mqd_update;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v12_0_compute_mqd_update;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

