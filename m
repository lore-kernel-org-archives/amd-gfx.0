Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0338C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB0F10E774;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4GZjvM1u";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA70710E252
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh3SdYxLbr7aXh3uQ+nYXGilSPPkJA4r8Pr6+Tyvc3p8yKu4dY5gArH0S6umA8ZOQgKI2C9v0p0L+0BSGwqjNR1khFoUvCNjqFdOjLi47tZVi/Ewa1leAUMMF3tU9jF+if9EtTozMIOaW3vaWDn4Mih3fepxgN+ZiocgZvIHw4UngPSiTZ6PODtXakTcO0EMyI06tQP+Rc3Lbhzw0o/Z02icd4QxyS9pCb6tErv4im665Y6m1SW5lpC5vMAfrE9x4L3oL0CsZc0QKoTTAY2W4lrAY4G2q1TH5hq3RAAYMCCxsQUH2adDMHMBmHLMm8XBRdQlljjaLbC1W00e/swoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yqEWPVrJlbTMXo9Mm80nEi04kKH8zoIgnLbTHFuQf0=;
 b=s/oMc4k/4gANksm8rN2DsaP2AZqpquwOuFRO+1p+ZMs0egKcRgwYsXm741Pq5WgjskwUA6Lsi2a0D+I01rgEEqmERigPSw3SbyAo2xLml2nLruWpXEX2tOQ+tijLpFTx0WrzDHyI56XmgDUq0ynnJnqyYYsPbn4YuRhKRpgUSAJVnq3Ly0VZYL7+iyo1M4/ICFThlxMWCvoM66k4qGn9ZgL+5SsCyTCBbOJUK0aQ7/JFsSXDGuH/1b7xrWZtTCWBkZqJQbR1LnWoZZ6AZ7rREMMbFLjN9Dh6fpq55MBq7suD5K+KXdQAy3wqO9RbcVYxTif3ThcIHDAOm0kt/LtIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yqEWPVrJlbTMXo9Mm80nEi04kKH8zoIgnLbTHFuQf0=;
 b=4GZjvM1uDo7tmQPNm7HoVI7jB7nRP0PLe+9y9AfglKi0V1hvvkHksZvzCWMlYiYAEhUNWEEFyyvZv0SPGB+HnjG5EdaS4SKCwH6gmcek4JddX7aYWQWRURs1yz7P6o1ArjjMSjUMLsTWDIW3RmS+kGoJLw2VQf4+EerOMkzkJjo=
Received: from MW4PR03CA0050.namprd03.prod.outlook.com (2603:10b6:303:8e::25)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 20:08:27 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::73) by MW4PR03CA0050.outlook.office365.com
 (2603:10b6:303:8e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 29 May 2025 20:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/28] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Thu, 29 May 2025 16:07:42 -0400
Message-ID: <20250529200758.6326-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 125067e4-2220-4def-e94d-08dd9eec92aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pc1/fHMs45UbzmkTnD8+isYj/L6pPnCmCn9rDrTLHyqdTDD9el4WWhRHQRuX?=
 =?us-ascii?Q?4iIX6oaX5pXRzZRvdzcw57YNoOLg6b8S9tLDyquVq4L+51spPNHEuJBtMddV?=
 =?us-ascii?Q?AMukGuPr9gFGWAvCnxXgqKPeI2NXJCAg1Ce2lfYOtoLJBrWtuh4y/e9AxeXF?=
 =?us-ascii?Q?IAIkmQNCTNt/64LocQU/0WeiPtVTf+RrBulsALk28Wy+qzaGVN7pFgqHXqkW?=
 =?us-ascii?Q?FIf7g76YgA7eSknGc3SFkGkqmyikkpa4jIGCnRIEn1B0mCkx9OOZ1UCAeudn?=
 =?us-ascii?Q?suCR+sVvyUyRJgaXMqj6yPXXgTeQRpReQYNp6JdZZVpie25bVcyY1bmbRYHd?=
 =?us-ascii?Q?FECC105efWu1nsA79AnobIPsyKog+/61OEsILfijiX9pT8UqRNt9vwtgmwd0?=
 =?us-ascii?Q?TvL7DQdh5CqoUF6roaYt/kQahu9loF2nrYDLPLF2qSATxCtwtkS89Rqwa5ng?=
 =?us-ascii?Q?7zrkrtcjhg2+/if21cdK1Beteeh3rlgDMGm/9fwzkpAhmrTMgqReRsOJK1Ho?=
 =?us-ascii?Q?wNDdyagisvsXVmhScb3GB7W6QRoe+M/G/JdVyyQTOjHooQMefGmldfKFgbgR?=
 =?us-ascii?Q?sNbDCtqsAi1ptVu88yKdu+Rnb5bMm+XlDY1QEfrAS1MebyaXUDlkxEX98J2I?=
 =?us-ascii?Q?9Ljun764wQ1FOtV+aAjMt6m+cu1FEbgybTfzzY9oY2rTZf9vJ7K0ONxx+slu?=
 =?us-ascii?Q?oSPycbMxe6S7VNfFSf5LKZ93nkd8oy2HJzSAUlzhvzi24qQ8zM0+d2eG21OI?=
 =?us-ascii?Q?FEYDmIigvmWBSE6aOgy05a8b9V2Hhs2kTHWSLdj9RHIuQEA49SRvfX7i2Jpz?=
 =?us-ascii?Q?kEOnkqN/xPYsOY9amcKHn9KvALM/zMQPcIN+s0T+cwh51k/EzVPSIBYjv1YQ?=
 =?us-ascii?Q?34EGNyv+k0JQDmEAmz1lw7HSt7sPST3nc6r5yhFmPNVndJJ4Us7OLygZxDY3?=
 =?us-ascii?Q?uGyHcyS9KfX30vfocPB9LA+l/JZizCHSWZbtNLLoUZNHPh2kA/mM36fe40Bc?=
 =?us-ascii?Q?mXJRKrrNc2mfatFXVOTPqNTDGKylfGDq4HgtHPJaiP5tYqdqY8iapJxEG5Ev?=
 =?us-ascii?Q?e0NZTvP7qJjpgXHi0WHAQFB3yo56afuoT6+uY2gRUBYliPCvaG+t30gKHAOY?=
 =?us-ascii?Q?ed5wt4EjWsBAVV7E2HEEiOLc0Ks8xKiMV5aR8/P5CZBoRX3cr+cwUdf9BXJx?=
 =?us-ascii?Q?NrjxfN336HHXCm0Fty4UCP8hGmBtJ5YlmtTMRDK/S0nd96DJmefYWjGpQDta?=
 =?us-ascii?Q?DQG1XnX2ac02CporhyDImiwXrtZIfMeLL95d43T0O5QUyjzuBUy1mH35SgOC?=
 =?us-ascii?Q?E7nAmtlxbTMcbv4vgCI7vOPBV4cf0VDCTXuTYeWZks713P7qlEqIB/qZVAM7?=
 =?us-ascii?Q?oSxegr1un96QHSWq3QRdt50fkUjAVdB/tskH3BM06pXgD9V2YbQRjXy18WAb?=
 =?us-ascii?Q?Tc0djLeNiqavNn1UgY0JQjyXsiGvfz+AU0rlOFViIcKleDbg69udCDveArnf?=
 =?us-ascii?Q?w8uFO6DmrsgWewv1v8aEFke8/nZ4XdjFousx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:26.5347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125067e4-2220-4def-e94d-08dd9eec92aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..409cfdfe54ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3612,14 +3612,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

