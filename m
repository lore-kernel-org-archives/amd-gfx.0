Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46D4C678DA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA5010E937;
	Thu,  5 Jun 2025 01:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uomPCcvo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD5510E839
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgTwLpLTtKuQyOrhgIV/7Yz1QAHM8vdDH3giHXFZdiyeQzgCHN9bqG4S85KeosITJyiAuW6nhW18FoMwBcBAYd8OdzQTqXQj0yn9uLH8RUiZwjEfT9aA4xRo9qeABvWHAEDS2VuBzreeOY5aPf6FWtgf+OQU5k/ysgPIaTkmN4RusPzpbAcO5VR9KFRbTRXiG8xfGzu3y8+++vrGI9tZDiW3mvtu8WC82uArzSKGWUAeXM/ZThuDde4JKF7cJNrgrHVUrLo0tGcjVYcnBbzG9fjdV9Na//4ou5WrbTjf94/nWxZs41lC3Or05cuX1yAFDcjQRJWgZ9pa/WxVKAgIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBbqTbZ4ewOyjWjY/p4EBasoPrX86XLRPlTvQ6DoSN0=;
 b=Y6ykWMnGIxpT4jTzcA/CRBloqVvMTB6z8d3zBaCYj8dWY3XWuBZTkLnFPO2fbxv3ghJTydm+ohx1hhtKemNcpX4BPdcor93sd+HoxCxlZKMAD/H16VCw9w7ykbUd0GpeyuVHvEDK18oYs3bE0Qo9lcN06FrKgMWSgqaDCJaWFG3NNFr/sF/pYntyT8DbxOOl8WE7Fu78b+Sf/XoadRwvw6/aHTyXOq3tEXQth2qF0Sv0BnQ0nEnyQvpteS9YwHtAF+wC5g8eoyck4AT+Ati1Fv9uoxClQUpLS5P5IJtgTuGo446gqUavPA9CuswuLZvBweNNooGafyAtaimh76jeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBbqTbZ4ewOyjWjY/p4EBasoPrX86XLRPlTvQ6DoSN0=;
 b=uomPCcvom1xWPExYkAP4UlgoUZRd6qqnIqHoh1CJ5fThVK65pX00W//RdnehVmT5w/6sEWM9vGXJoxWrGVnW3X33NOseYUXkT7px/3Nrj0mW63cvSWyRqhYHMPj8OKFc0r3MBQozp9Dx7DMOVgCi/4cxPq0C7sZlveOynvUDTGo=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:27 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::7c) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/31] drm/amdgpu: optimize
 amdgpu_ring_reemit_unprocessed_jobs()
Date: Wed, 4 Jun 2025 21:45:39 -0400
Message-ID: <20250605014602.5915-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0e4f06-ae73-4099-f8bc-08dda3d2c8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gYKZBVS3nT6IJ3F02TGm9QGkUL8WpToHfOXWrUiDwtpQM89N6rFeWzMKu/nc?=
 =?us-ascii?Q?M2m67LkNf6fkCZX/gY5QVnjrQKTD9ZY1DpHFXfFUeIV8y4IKiSlOpx7jbHjs?=
 =?us-ascii?Q?VvdM1aiYD9Y1rxWZ70l9gqMNtffj1H9+m5wnn2ohBgCpcPWrCOERXukTowvl?=
 =?us-ascii?Q?XOUBuHBTME9cjHM6VJBP3fD1a71gvfe/9taFLlBlVtM0ASZnD74HeK1B4Tha?=
 =?us-ascii?Q?rXh42hTbMo5iJVv4F1JsUBgCCxHJp0Ubh8S6kVqm+4tTlEl2M/ByYqkBy5uJ?=
 =?us-ascii?Q?ERPp9krZVCmhrYfETtIDpdfHHXPjOcrpQ9jp2LobbcFL+6g7VTHvNW7xLRKb?=
 =?us-ascii?Q?/NOyeyRhIlYpbSX38G7Ys3PhYCVYxjvfFqSWP6wWEKaynkYhelHCzroSlDPs?=
 =?us-ascii?Q?qWS3+ivHiH18zi4J60S2yKA5Y6mje3SW+CfJv2exUJtVwxXPWoBqJIR1CACy?=
 =?us-ascii?Q?X3/7vLYkHxxA2zOcZmtomHEJpDKzrIEjLj1GOjMU1WD1F6rHE2k73llGdYAC?=
 =?us-ascii?Q?3zeBqZLu+gqPEKLIllhzJKbXwUm3qEwMaP0e70UgPVtlICY6Qmi/s2yxF4TU?=
 =?us-ascii?Q?alzorrhgQcrV1waW1LlJPcD7ixHfJKA7mLfUGtdvDRSucbfKnlKBMoyqDDA1?=
 =?us-ascii?Q?iXWlilUzz0DQeLBVTPV15wEeIaoO0WyM4Mt9ny7zbCyiLMAWi5tXtT+yaUuw?=
 =?us-ascii?Q?ogM4CPLVWKu3gDARc2gy1880OeCiNdAJTIFSEh5xPN/ho0DrdLKSpeUuAAB5?=
 =?us-ascii?Q?6iRGTkwyNOzwKx9ARj91KTdug1ppJ/osqTP2bnY3hIjypHLFbwyy1G9gxmsK?=
 =?us-ascii?Q?vuNHYyx9LbdN+TTefyMJ5vp7ZWG2grjc/bGU1NBWvBL+YCe+xkXXHmrGWBT5?=
 =?us-ascii?Q?v2d7O2mitmwD6QB39tP++RfYTUjWlw2HsAJFGhaw4iPBo/cPSWY/mGKRcAb6?=
 =?us-ascii?Q?+uspUwRWxDuGbK2z82U6hTJcbZ5bz7NAnCN3m8AEDAqUBth/3OhcThBH/KQ5?=
 =?us-ascii?Q?EwjX5GmtOTxJBBa/Z13N1cxYBMlXPiWK84xgpcAE7lBVWEdB1q/+U0zzYeS+?=
 =?us-ascii?Q?hPACzdxqWdkXrNOZuVS4dSa7zXWgK4O7IeWE47UUL/6fPFN5+c2IK8ZqTz4B?=
 =?us-ascii?Q?UHmZWwiaRzbbsLbqg1bsZN09WADN1ZzXJNBWaLcRbYFceHY8N3LNFA7nSMy/?=
 =?us-ascii?Q?0FUwBjtbtOsGsPMhmxEVK46d69XNBiDCRLLt+eurO8RtCNK6MAsZQyg78jWs?=
 =?us-ascii?Q?B4X6kOioDxYHGokncbKbO34kCVVV0tt+CyfMdxgL15bo6ShUPj56dP3qjBhh?=
 =?us-ascii?Q?kdfWlD8KsjoYLR46WlneYeJyhSduu/DMonWaJlsZf2Z4AS/8eVTagFaSuVJ6?=
 =?us-ascii?Q?dkOBs+RFlQO09zkSYIJ1t4COolVhA00VAjssI2gwiipCDwDHH278gbc7GB66?=
 =?us-ascii?Q?HNFSOoi6jhtveV2asOre+YWajou4K3HfliZiIN4jLaIAizP/nOgBMvwQfPfC?=
 =?us-ascii?Q?JCyMKITh+4CU67JwRoWD7KnqmgdEPv45tGhy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:26.3254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0e4f06-ae73-4099-f8bc-08dda3d2c8cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

If we fail to allocate enough ring space to reemit the
previous contents, process all fences, but return
success to avoid an adapter reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 3a0e0883bd8e7..717c128b2d6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -831,8 +831,13 @@ int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
 	/* re-emit the unprocessed ring contents */
 	if (ring->ring_backup_entries_to_copy) {
 		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
-		if (r)
-			return r;
+		if (r) {
+			/* if we can't re-emit the rest of the ring contents, force completion
+			 * for all jobs, but return success to avoid an adapter reset.
+			 */
+			amdgpu_fence_driver_force_completion(ring);
+			return 0;
+		}
 		/* signal the fence of the bad job */
 		amdgpu_fence_driver_seq_force_completion(ring, ring->ring_bad_seq);
 		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
-- 
2.49.0

