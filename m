Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C644606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tmIiEtax
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422E310FA9A;
	Wed, 28 Oct 2026 08:58:36 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4769F10FA8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl3cPbhhRXkJy0Btz9hruqEZOqlZHeriVxnQRuck23ZnXSpvYBY2v61pOmQRF1YV9ehGbxicoD2+pVLJ9EgGNeHmExjW1IWbGM12fJHHri4M6ZtIDWtcZhmqpGq6HqlosBo6Cmq8caSPziOIOiAZu3gF1+8sWbGOoXsh3mPlh1tmF/iPiOgWKWS6WyoE+vttPmrYzJPpsfgdYzoiXflcTq/At/3IwvvTGdBQ+eMnGuVJN0P4Nz4TufMIrsZRxCUgzv34Ik0/f8G5KSY+7JHV724+qYlnizaZHZ2dzgL++EfO3FHEB22ZXePR/uwA2ur5tAv/HSREz9pj8y65LOf4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxw9iGnIxXNWaQgA7GVZmQks3wCN+tWp4+rAFqDJMZ0=;
 b=lDyeKlsmZJ65AhM84xKvm+QZfcHA++BnRowDZWqmvfphcNQcjpFF2zS5ITTovhZfFdblfpvd20iM1Y7/MfXvXpWMzF1xL8H/EhnJdfyn1jXwYmgx3PWSHiAm2QXPSclPfj3ffNntEt5toWWKdhQnJKMZAKbg+QLIARl5xVIO1jxtpbp9tWzHS/1rqOoz0ozo4wSteiIIfpfrDQY/PvV8caPma9sIiSZbW82LCd+8NJW//WURXcozdYeZsf8XYgMlIe0KbyzXh5s8xIqGPF8u7siTpIb9ab9iIkal1W3jk/F+fXBYKLyLqZOm8PFB2adoobuT/F9MbI0slagt26HdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxw9iGnIxXNWaQgA7GVZmQks3wCN+tWp4+rAFqDJMZ0=;
 b=tmIiEtax0uadBfvhtLdSwaEEvLUw8Vd/IpXfP6Eb/dafKtElF0hfRApYHxWfJBNxts3J7xULxRcYzny7a/jngguX9aaByqj0/qhFnVIG4nMtZ9CztKApEsdIYLVcaz1jRr4cu82BQwlDSK6wP69RH86OjfNoY/rQHnczzjZIzgA=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:58:25 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::7c) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:58:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:10 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 14/15] drm/amdgpu/gfx12: enable the gfx engine soft reset
Date: Wed, 28 Oct 2026 16:56:45 +0800
Message-ID: <20261028085736.3808569-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 33258173-b631-429e-ef40-08df34d1a054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K7oWhyKRPtnmY+fklrRYyziebGF7PjM5l5E3APXEcxVljfca/i1mqrdMDbnJRHxs6sTAFAUl0F7hWq1fhq7lyObF/khg37tqWVstuQS4xii+ZrC//pVznf07gO3afgLaXHY4OQvPYkc922GHDlc/Bv0gm7jSPPffsICzAwvKSI4gNCAe9EUQDnVnVd4mAfeQbG5wtCcKlWvLAXdF5BJQUdRu2zbs2h2hBjvpZPXGBwSGMKFjQSnmcXow2wpxY9qcs+pkEl6s1mVPcnj8qorbDDBNQADGLbwWANMB55nfTn0bNKx9QB3L9xvditx8kJMtE3Px+ZH+FjvXmrhNPYhtBhl1VOmf5A+ML0lmwGSUIeNJ396MwKKePbcqxDlb5oquDzG1vWCLKfOoTpNvphwIKYPx3O0ut4kD2kOByTQXPZ7+KTJai+bksMNiuLY+C6MBQ29oYl2wr6kiVPS2INwA14GUdbv5ZDd4gk2u42yv0mBxeLzMp3dEXCtVAq+gMaMvZCXEikxZeUYqRfUpB6kx7jNBVndBKstPzf1znod0JCrjOQB3MSXh9WnB/Fz8ADdBYWcJo74uXo3XZvHdIW9CzVxpIwaPSbnXFf6DT0V6TQmuSAf7ywrz5PzgHDgOzfaF4OvEv3hsOjMjd6fu1pCmF5TNXWzRvHrE5tA6j/K9akTLsSvZzqHs5yo+ZHdC4Wrk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nBoWhpa2IqiaPIA/7hnJ7eLVdNnJeWSja37GEAVE6aDy9eGI3bmL94Ew2bna7LkjLGJMh/JawsB+Cj1B+YI6C/DoKVbjulQ67TAyfObK9HVCRC7oXnFCpwwf6gUkMBXUgH4oQ9ufyG5yTAtRNk3aNO5LJ5d7FyA2kXBTKIBPib7xWlvjyX9yzTrce3ZPn2Q1GB8pes+1PCqlsRcGcJnVXeu3hDxo2rmBdBHtnpD9b++aAh3X+YPDcBjW0Yss6McthDS/5bR0azchYKodAxQSnKa9VVXZc7Pe+XFxMsEq4TjCWMBHowMsB0JmrpVVIE/64kE5TgtEKQIFdEiJzJChqUBTZ9METeU1MUpSAw+L62RKW5nhH9qviIIAOw4wIuu0bx75OqiW4CWvRl+DtQdBONcvvOGWYvhKG4CKdHie0ButW1Fd6nv4AIMbxN8Cwnxc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:25.1374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33258173-b631-429e-ef40-08df34d1a054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings, with
amdgpu_gfx_soft_reset_engine() as the soft_reset_engine() callback, when
the reset_engine callback can be used: with MES and async gfx rings. The
reset remaps the kernel gfx queue through MES from its MQD, and without
async gfx rings the kernel gfx queue has no MQD. It is programmed
through the CP_RB0 registers, which the reset clears. Not on SR-IOV VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 708325e6bc7b..d1fe1ee71bcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,7 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev);
 static int gfx_v12_0_reset_engine(struct amdgpu_device *adev,
 				  enum amd_ip_engine engine);
 static bool gfx_v12_0_read_gfx_hqd_ptrs(struct amdgpu_device *adev,
@@ -1599,6 +1600,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	if (gfx_v12_0_engine_reset_supported(adev) &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
@@ -3860,6 +3865,12 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+/* The reset remaps the kernel gfx queue from its MQD: needs async rings. */
+static bool gfx_v12_0_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) && adev->enable_mes && amdgpu_async_gfx_ring;
+}
+
 /* The CP DMA and the interfaces its memory requests go through */
 #define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
 				 CP_STAT__TCIU_BUSY_MASK | \
@@ -5500,6 +5511,7 @@ static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.suspend = gfx_v12_0_suspend,
 	.resume = gfx_v12_0_resume,
 	.wait_for_idle = gfx_v12_0_wait_for_idle,
+	.soft_reset_engine = amdgpu_gfx_soft_reset_engine,
 	.set_clockgating_state = gfx_v12_0_set_clockgating_state,
 	.set_powergating_state = gfx_v12_0_set_powergating_state,
 	.get_clockgating_state = gfx_v12_0_get_clockgating_state,
-- 
2.50.1

