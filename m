Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CA606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nkmPEGJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F1010E60F;
	Thu, 29 Oct 2026 18:07:09 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B3410E60F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 18:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in316XFN/YOfgbueRLPmmabL+Y2db4ctEUtjWR/kD8PMYzbkcO8/SIKK6+l5NIbjjTlcedZeXwApIJTpqkHqqeEDezE2mL8c9k08hFuzR7RBXStF56gMTTR2SBvQ40VT66z6MBIAKYqemiC+FLoK1qqWkBMECe69UNcM0etVTcj6y4VZvB9CyKtL8uAUhSz6X/cFjS4vHkOHFxHX154KfXfVCd7z9tjQssLEhl2AfswqVL5r8eZ/+UznE/tr1Qegp0fnpLbQCWpZWlTqLEc0aORHZnuoRrcLBHYx2tgBoKw/Ir09n4GtA+JBZCZuUMh4U75a5zAUEZpxNh1JYUL2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s1XKoiS6RSpl0k3Z8Yfz3GCfb/NzEIFMKa3m9O7Jdc=;
 b=eXJpIAuOEMaxFDxXqsCCfbq977sdOhthm3bITurQeZC5bTX+ipGoHEzTH3Wc1kJSnb/kwtMUY5qXMAZl65QrIo+zGkZ3rdvBiLzsxhVBIhzJa3k5VG5zPsOXTxLmJ/3TOz2Di+9HKy+7CigrXuFVnI1voUOlVJWi/RkJWGU18HjIVrrZeP3PU74PjLhk2aYhnAviNxjy/kr7dOwxvC4Ow5yEdPVR5lPm7sH22i6fUS/FtofDEJkaP437TlwEySs1UR65MCOxQa4Geg8uD5ZAKAivoO8eGeGeuVaUlEeTntTx0zV27C+m3+4CUeW/O7CC7yPUYnjzIT/wGlU8g9y9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s1XKoiS6RSpl0k3Z8Yfz3GCfb/NzEIFMKa3m9O7Jdc=;
 b=nkmPEGJrMB/NvmQdbYJka1e+sqdoX/xk+lNh4cA5Hf6TT2x2bD12Z85GR1c6E+qQHMmQbW+/i7B5rpUsccY0witXbYjnCeUKX2b8YEEi10reMqcoR/1Sgw2DamdKLPRiF9sGDvLKUJ47iKTFltBzTWGn3bMvdxz/ObslkQdNcc0=
Received: from DS1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:8:243::6) by
 IA6PR12MB841838.namprd12.prod.outlook.com (2603:10b6:208:600::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:06:59 +0000
Received: from CH7PEPF00000019.namprd21.prod.outlook.com
 (2603:10b6:8:243:cafe::7d) by DS1PR04CA0019.outlook.office365.com
 (2603:10b6:8:243::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 18:06:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000019.mail.protection.outlook.com (10.167.244.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 29 Oct 2026 18:06:58 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 13:06:57 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Victor.Skvortsov@amd.com>, <Zhigang.Luo@amd.com>,
 <Chenglei.Xie@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: initialize VF2PF work before it can be
 cancelled
Date: Thu, 29 Oct 2026 14:06:51 -0400
Message-ID: <20261029180652.213481-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022153132.211631-1-Chenglei.Xie@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000019:EE_|IA6PR12MB841838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dadf128-2800-4980-6b71-08df35e76c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261028144727099003|11063799006|261022105027099003|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261021121427099003|261026140227099003|261021123027099003|261026121527099003|261009220027099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tjNb5m7EaaNndIDjnhg8IVSKJp5d9Ig7Va5kzDsQxSGM3+6YKEvOoGUXWa830rR0LVDVTQpBDZT4UulDqF/wBOciG6gn214Vy1A6XcR4whQ0nPAVxYhEuvKu7TVtkWLvh15QsXlbNmwcW7cIMhNKN4jPiSYUwO4cw2mNEYoBfIhlXX129H2AQZnSl4+bG828TcsKF2CAFGSmH2EiV2nv6Zi+oP3rXFncY26229WXbVU6ZREuv+ZZuLX/8/SG8QHxogMf3cX2v8VOt7RdfGJ/TKhhjESoJJxQe7kvBfWX2raAyD6q4AF/wzQF9DyO6BE0fRAZq7807pthZZTuH2HvOuMaU9ssmrvtnnql7f4dNSmyAJG5E9NtAN5pDtwpgAsW9cwLiW2Y7CUoC7ung6K/0fUy/Ld3p2W9+FxdsnUp30iRFZFy+zM54FHJ9HoncZ6BJkg7KPcvpzlyoW2n0nvZEeQnQN3edYyQUW3c2xHz3B2dtJLDOGLBu2OvOV4N49oIfdBQPEl7TNvgqBDSlqrt2UW5m0q27gV52FqP95cuDHGFJ2xMOXC6GGcz/O+j9sVuq8v+hc501DCCvBKhg1ftt/zkZKsQMc8/mwp931CLg0to/0vTpiarks41GRm0A3mNv2Wc1qXoL/2r2qd6gL/7pTkARyIrPVPnqdmawE9kpTjKRI1qclj2BqPdrIMmY6JWr7wN6+A9PiA3LF70Ihz2SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261028144727099003)(11063799006)(261022105027099003)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261021121427099003)(261026140227099003)(261021123027099003)(261026121527099003)(261009220027099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r18d3BZqL65FFbFMYQ8KkbL6gKN1uksyS1jccRjrqFvYZgjpIv8gayN/qLjwerzoK9SJ0/+PZbGvzcIvKIDEa6cDvqAlvXr0wx+SawYbcbZpY6PxUomy/GLqnajgX+rmUPBPrPq7DHk8qZywZvp6AMjE0Mwb7/3pO+rHRNSkVXXw8xrZbvwu6UpItjgUAytODaS1Q3U27L/36slBN+FF0ILhx2gf2+vzw88DVFcPfNSm3hOmoAwvyt7bmRiSLfcgXhh4JvIJSICre/18v+8UtPp5+Gic+y+4uJt+8/mhT1WqiV7qSjoP0R6uZaP8MhhK0yQ7WUoEYuPdoZvZqsKNDb69OMJSZAt80FK0+Vy0F/XsXzq16w9YONY+K54sI9oqU+/WePhrd+BkrVc+ckJXALA7hSWHUhSN3nRA0Adk3N3ditMQSCs/CG7D724FAT5l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 18:06:58.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dadf128-2800-4980-6b71-08df35e76c96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB841838
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

The vf2pf delayed work is only set up on the ip_init path of
amdgpu_virt_init_data_exchange(), which also schedules it. But
amdgpu_virt_fini_data_exchange() decides whether to cancel the work from
vf2pf_update_interval_ms, and the early init path fills that in much
earlier through amdgpu_virt_read_pf2vf_data(). When init fails in that
window, teardown calls cancel_delayed_work_sync() on a work that was never
initialized and trips the WARN in __flush_work().

Initialize the work once in amdgpu_virt_init(), which runs before early
init fills in the interval, so the cancel is safe on every failure path.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
---
v2: Initialize the work in amdgpu_virt_init() instead of
    amdgpu_virt_init_data_exchange(), per review.

 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..576a818db522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -838,7 +838,6 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
-		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
@@ -1249,8 +1248,17 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
 
 	is_sriov = amdgpu_virt_init_req_data(adev, reg);
 
-	if (is_sriov)
+	if (is_sriov) {
 		amdgpu_virt_init_ras(adev);
+
+		/*
+		 * Initialize the vf2pf work here, before early init writes
+		 * vf2pf_update_interval_ms, so a teardown after a failed init
+		 * can cancel the work safely.
+		 */
+		INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
+				  amdgpu_virt_update_vf2pf_work_item);
+	}
 }
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
-- 
2.34.1

