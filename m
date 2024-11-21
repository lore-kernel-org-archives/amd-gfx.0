Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F1D75BA8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 03:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D7C10E84C;
	Thu, 21 Nov 2024 03:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/ZoVRkV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A20D10E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 03:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inMcCaFYld7k8Fi/sjgUBjnuXB1Nufb7ieEMHLnbNXqMFAo6FhEc3McbW1LOX/hXo2VQZXB4HaUPpMTJRDiuPkuPALeSKTmmGe0a1s0sgxEnjV1kGwqBezMI9zhtMuPmknw/NRtoOZJWUAxkc/kSx33rR8CHowuZ+8Xg8IV5w0vu8wz/zIEX5VNudxXw0IDt1FO8FIx8muYmPMhfjsBKVNtlHXrwNP4mX8hamuSE1I13DVaqaszYn2wmTC5I6MFXJRdnHoPpFGhl6HTGFo+94XYOPr6fmDhqrQR0w4yDyBwnGvGLKzoXLekeBHhRQa1V5jyvb6yCI4JgR0v5VuqzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2IDjIi1hBOiRIRqkM/GS9Sz24SslAYRv5dxpt1MyZw=;
 b=qfh2lxTOG1tXU6MUkP6bZuLlAMzdX+zbU7VIGxuQAi/rjY3pSwr33VhVifHJnmCpEOZcExlym2YeEziGOzdh3kJI2v6kePPjegLiEu0LVQr2o0nC9y8tJDzpTxYTw/KGa2as457mxAA19LyUGbU4HNBagEZuILIUpHv6UwdPTSCZIeTpWMFzvXayEPIt6MNN+KhuYtu2CrJTl1aU77Mg0sVZZilLJo9vbXiuWlONAERG7i+uKaVjoNz3dbzVcFcGB26UpRknyvJPXEJJBRr5gTibQ3YF87RV8EbsAAwD0hOoDY49nFilmtiuSmg6UQmcDgYdn0d76G9EdZ79n83yhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2IDjIi1hBOiRIRqkM/GS9Sz24SslAYRv5dxpt1MyZw=;
 b=O/ZoVRkV0C/vIYcbE9OM1YGxDBK+SSpFfOaOvdiMgPeQzOSRMOc8eOJSj1imRX5jtw/gA0FUzfS93xrpG7rK0CBwm8Z2e1vCvQC+gzo1pWSrwXPUYaANxpMML/R92+XLPzTwpmppcF23RnLIOc6/4TQkurB5D/KAEIG1PLrPrHU=
Received: from PH7P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::11)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 03:48:58 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::cb) by PH7P221CA0063.outlook.office365.com
 (2603:10b6:510:328::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Thu, 21 Nov 2024 03:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 03:48:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 21:48:55 -0600
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 21:48:38 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad jobs
Date: Thu, 21 Nov 2024 11:48:35 +0800
Message-ID: <20241121034835.1011382-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shikang.fan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d472c9-6b51-48f2-2bd8-08dd09df6dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mLqqloHxUdbMdWqI9koqyIc027B0QiqEJO+yhaHfxpDOwu/VmCO6NKTJdLxo?=
 =?us-ascii?Q?tRlokDUWhL2MMaiaUKrzT34FbUVONYO+8W1j6KegO626Wx6rDAM6fBAo18mp?=
 =?us-ascii?Q?Il3TruOphpIKEbE5EALwkmZZil8dVvPPFFv/a/rQ2qnNWG16bqwruhfaLzyv?=
 =?us-ascii?Q?jy5hWYgs0+h8PMfY6RI5z9TNYkXSNMy5wh4s7vgJxhyZQJnTnaP+q0sC+PVP?=
 =?us-ascii?Q?TWW0SubWcaYTE9jkukQ02l05PTMrUOh8yX6Dpj/oUXTtQpBO++6UYJOcFLck?=
 =?us-ascii?Q?qN85pVjdqi4shkc2qV1vU99HoTwGUZj1CGpqB00kUGNkX67O2ojwunPsIG58?=
 =?us-ascii?Q?HXfQ+NMPZz0XK+h47LbeA2DQP7KEJUPGb+9+M7J7Te0eJnnatkCHh8JHebv1?=
 =?us-ascii?Q?KVp7AVMNNKp5eblUw+eJpeC4yUgDlAFzdCw5VkBSTgwjJ7bktlYcv8x7FwlF?=
 =?us-ascii?Q?EG6v+DFAK3T/9hFE9KBjMv8/PPz6WnWGW6KmFCL2E0RNpq/7IiT9wgf77xZ+?=
 =?us-ascii?Q?n3Cdbvik12P/FMGXB0NTc4TdPsp9XARI0Xz1oKui+Hg+XvsKp0SF9oyZt7t0?=
 =?us-ascii?Q?PUx4dPngftrXBga4gigeWovYyeMJKPUAblMZwR3r0CAqPAY+peWEY2LjXoQ8?=
 =?us-ascii?Q?Y1yAJKE2jqHqaVPxJY8ufV9SpqUdgbiSh/4xWYEpV4awoz5habSzHE7+Xp9n?=
 =?us-ascii?Q?ZwUw8bHkALWfXXSyyEaht1sebCbR9tBfNaZclSCoPkZ10ba2IjRUi4gKrPIS?=
 =?us-ascii?Q?ulroc2vaMwdJi4p2CKLb+T231VGWs4wO5eXt91mXP/qk/bWWJdGXcyTXk818?=
 =?us-ascii?Q?6xXnwNCdCgCuObzRO7YrsIlnToPchl1hokTnUBvsFyR5ubyQCXSePIr9Xbwi?=
 =?us-ascii?Q?Gp0uv+05HXdjnu7+n/qNAo/iXumxb/dgj7TDS3/A/QOu4zRBALZIoYj99wdu?=
 =?us-ascii?Q?uvRXm8UFZtsGoHkOb1E6AiB1KRAPGzQFkecdVjX8KxvSXpypucShWXzUeJKP?=
 =?us-ascii?Q?oSFZZwrINqikTLw4hQbM7ffAE9RmlYanchnJ0RtrcOIScpORCWD+tpGeWJm6?=
 =?us-ascii?Q?paNi/Iqhi63CXy8SVuTdeT1S4XYo4EafXhW+PBzHoZtAoaMRa4GD/hkf3HHv?=
 =?us-ascii?Q?cQ9Y+m1RXB2UQHDopU4ZhwuVVHWcaejMLLOT6/r7EN5duKDrCqvFqT6H+5zT?=
 =?us-ascii?Q?2XHHr8B31mnm0/b/2u+lnoCiIgrEEWegw3zZH9EU1M2fmKmQXVC+BFJUy/yK?=
 =?us-ascii?Q?J4vA4wV6rFNKsCJ63F/yRZaG+a36oeonRtpKKDfve4LZ5aA/0QbzlmHwmCvV?=
 =?us-ascii?Q?WF9N5T1NU1pYJ1M07wuial6f7GtIEIB1rbPYkqnH5an34Nu26+LaLd84XjRi?=
 =?us-ascii?Q?AmJmuz5BR6jNuT90xU324sSGNWvxNbFfoOh7bS8hYZfBEu2vKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 03:48:58.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d472c9-6b51-48f2-2bd8-08dd09df6dd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d6..f53889ce71a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror list
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver receives
+ * FLR notification from host driver. If there are still jobs running, then
+ * the guest driver will not respond the FLR reset. Instead, let the job hit
+ * the timeout and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-	int i;
+	int i, j;
 	struct drm_sched_job *job;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		spin_lock(&ring->sched.job_list_lock);
-		job = list_first_entry_or_null(&ring->sched.pending_list,
-					       struct drm_sched_job, list);
-		spin_unlock(&ring->sched.job_list_lock);
-		if (job)
+		if (amdgpu_fence_count_emitted(ring))
 			return true;
 	}
 	return false;
-- 
2.34.1

