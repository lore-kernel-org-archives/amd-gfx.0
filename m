Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D372BC3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F8A10E3F9;
	Tue, 23 Jul 2024 08:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtMcee48";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26FA10E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 08:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piCx7UDjKqR85zrLyMZrhqfp1MO6fWCE8ebm+SulU8HRr4w0+Ha3nYshZsAnJ6dv7lmvPmL6iIJQ8rJl7DDD9L3LY6/i4gSI6EU3CmdzXyL0K2EZ7MoPija/Gd694BlgDLjfKqEZ9VczvsTIGb87zlyhNfA0hDNO12P4EQSZgvn2vVm3hVo1sprIc640eiBy/5go7Qo/4XfIzPjGoJedK6qrOf+E5qXCAdCRUUFuOgneb8pjMukmtL93C1gUer6iuj531EiccITGfQKmnjs5PoiU95jTToXF54ysDNhJAjPl8cBiBCEu7U7ffvgUyof5BLeNr7UO0hD1yNvt2S3MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT31idaCTkrBGAqTcgM2UNsoJJnZNFB5G4iueFVo8Q0=;
 b=o9XMUnhMJzaCNkxFJsHWGGgWV8plPqaLVMqM3f2b20m322aM0MhedD3ghMsQgTfB9RGV0c1/CDqPiEzMMXV4N4LTrNKVyl+xDsHw6zSlTMmCqLUFl485n28U+C6E+ivMMdfdpdTGfs0eA3L6pWIFj2vmeNN6YXa4dWVTOwSam2UgwacfeF+8I9P/Z0FWQIDFZ7H02PIHNWrssoJizBjXfbrNPt1SnhBdFKcQM+MVZx5RVJToNaDLCJJD76K0WdryYBsEw41/O4s85NtnYBaKycDplQfHHDPZqgXmR201I+UiyJIQ3dNce8pdm7VAd8p4sDj/pmzhm6JCm2VWTt22Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT31idaCTkrBGAqTcgM2UNsoJJnZNFB5G4iueFVo8Q0=;
 b=MtMcee48WtK6G7w0HD69z3PnzTwGJfUX/ukXekRqhb1N69GESTUuyFATizjQY9AxawTuwzBP7ubvhS9hE7f4oPUeVGayMlvACfe1gEVi+tu3dIEHcc00d75OGRXqeP8ZmsTP2hpU7n05OlvZ9gb53+ZkA0+WDFKnySyy1Cmwlnc=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Tue, 23 Jul
 2024 08:28:16 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4a) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Tue, 23 Jul 2024 08:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 08:28:16 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 03:28:12 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <ckoenig.leichtzumerken@gmail.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
Date: Tue, 23 Jul 2024 16:27:37 +0800
Message-ID: <20240723082737.2359410-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2fc008-88cd-4007-df31-08dcaaf16681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9bq0UTz8mKs2RjtUQu4XROAdYA7Itgt9/HX+orJVPSKMpWGVnlTPfgmHu7UU?=
 =?us-ascii?Q?Y79YHM8ZuYgAF52hgomKRV9I57ivId4zrH3RMd33frqBgyb0HazcF2jXH88v?=
 =?us-ascii?Q?g2I+EvZPjQuf7JRyT1doO33hAt58oP0vyZ7LHra9G/3J2h0JE7cqV2qhJG/C?=
 =?us-ascii?Q?3qxdF+sLH7JXKWokEvpCqM/voEnL0eMgRlwjd+A2dFOcwcSIhE4YuYM0OSAa?=
 =?us-ascii?Q?pPGHliCJQ67E3dK9a+PobqjgjdhFA0RYpW/YrCFQHZv4ki96Q8qfqb2/mibo?=
 =?us-ascii?Q?K+Lq8sM2cqK4Cw05rKOoCfEBDYFhTTCCdVVzXH94i/ZN0GkiaFW1AP33kDdP?=
 =?us-ascii?Q?DWLJ2uc4e9KeJErL1XRjqoyKXf00YUyQLQWO182sw3R3NF9phzCBzAfgJoCh?=
 =?us-ascii?Q?tUZqBBihH5Aerg9NDpjpB1//uFlxMB5vHYrR3Y8S7nyVpHwaCRR8lvJCWALE?=
 =?us-ascii?Q?L2ks1L5JVVJMqV2TC7bt5PrS+xI+WcXMdWCJEHoQaBWFsLA7mtye2nG4rgLk?=
 =?us-ascii?Q?YCtYeI0wvWMqYhURn7za7VzZzbqvEzLWxxxpp7Dbw5yxZL7wB3tRVYhwEHE5?=
 =?us-ascii?Q?QrexMO+ozUe35rEIPiOTAX2X3UxeOefEvIgMPx8HXme0ehxxIV3vCsdPGFWx?=
 =?us-ascii?Q?iiz5PfU4c9hDEB9+mYTe0xXLt+Ga8YCZdymWha0u9YHOk3S1imC7QeKqb9yE?=
 =?us-ascii?Q?uilNJhlYCaDPgN/T00S/eNEGg7NDv8lD+6E1cVgSjr4C9cXgXAaFdJFT1s8Z?=
 =?us-ascii?Q?w8IW2De67MaPw/bOnA8tOm7jf4uqVI1aNw8kxNC/aiD7pDWIYZfFLCxfEuyP?=
 =?us-ascii?Q?tMoFrzyY5qPsW5Q0kKhu26blcaT1GpvdKHMeRYbzsWDpSgNHKBwAtXC0W1BU?=
 =?us-ascii?Q?iLbnEzjPN3O5HToWwGNd/kf0WgQf0VlpRtgKXI6H02o+cIgVV3ESamyuZuVd?=
 =?us-ascii?Q?FhVNTR0x4QkPjq+OY0zIfjy06s/9HCPB2bcXouuxzegIT7r/EQZ6jQeHljD9?=
 =?us-ascii?Q?/eMeu6yfe5xOyO9jWp8ZTq+fGhomvwBz9pP1n3uGOu/DBCCCqMxjYjPy/AOe?=
 =?us-ascii?Q?Dr+H8xh7SVgSmW4uNzwQ/ZymCmbmRjLRy7X7r/zvI3jswek3fGfCmvr+9s2S?=
 =?us-ascii?Q?sTZiS51TQ6i4trCS8mAFkwtiTAL9SxGwL4lkuC80FaymG1eoqMuEUAOljxtn?=
 =?us-ascii?Q?HjyKWCvMdC/oJVN/UB87IPP9U/HCebaLsJvzWVQymojMPmyMg6qBUfFHwcrg?=
 =?us-ascii?Q?DkR8DPDQzLEHD7uCuX+LPZCJtxB6GCq953+NskThkqmqzb+Km1oRC7aTa+rD?=
 =?us-ascii?Q?z4DmSK4ExlZ18eIHCScc09DJdqFfAZROUEGb/B4RGJ3Ttt0OG/nwMIog6MN5?=
 =?us-ascii?Q?KB2k1gkL7faKk/hM6b+ECg06M0V1BoqTjO0FNNXGefU/sWEzu1zZq1LbtNPn?=
 =?us-ascii?Q?elFU7PyySeQPL6uLE4dyKD6ceL+ubvEF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:28:16.1989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2fc008-88cd-4007-df31-08dcaaf16681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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

Only allow API_NUMBER_OF_COMMAND_MAX packet in mes ring buffer,
refine the code for maximum packet execution.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..dfe487521a4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	 */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		sched_hw_submission = max(sched_hw_submission, 256);
+	else if (ring->funcs->type == AMDGPU_RING_TYPE_MES)
+		sched_hw_submission = 32;
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 68c74adf79f1..951f13e01ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -198,7 +198,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 
 	seq = ++ring->fence_drv.sync_seq;
 	r = amdgpu_fence_wait_polling(ring,
-				      seq - ring->fence_drv.num_fences_mask,
+				      seq - (API_NUMBER_OF_COMMAND_MAX/2 - 1),
 				      timeout);
 	if (r < 1)
 		goto error_undo;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 48e01206bcc4..dc65f28d1795 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -184,7 +184,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 
 	seq = ++ring->fence_drv.sync_seq;
 	r = amdgpu_fence_wait_polling(ring,
-				      seq - ring->fence_drv.num_fences_mask,
+				      seq - (API_NUMBER_OF_COMMAND_MAX/2 - 1),
 				      timeout);
 	if (r < 1)
 		goto error_undo;
-- 
2.41.0

