Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B2CC71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D74C10E486;
	Tue, 17 Jun 2025 03:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hb4te+ye";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1E10E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/1EeDP8aUgtrL7pgfdRcnUTcAsyw+DRyW5nRsP40NMkn15QlzIEYzlV0vONocrAw+c6HQ6M+0r//fGqDKV9gZ5GCJJb9fHzXb/WQ5VHNNs83U/YDDY4fYAK4TI44oAlrjjQ6tGQhk6h4iqPQtX1XcHI53apnuJ9HIUnDcvnz13ErCccj0Hk75kZKt4cD3VRob0t6k/KENoqbRYwVCRGxIXSaU7EQcVPPpQKX1GenTJHC/yUesUdiQhweJcqhSNvKwhmiHWggvZz+1aLmHrW0PqtJObnGjQIejfnQP0xzYTCO/gaKrpYIYmKsIv1ggQgR4hLXOwAbgTO1kN8AMoTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ewjfwLs71ffii5kJDf0jtux0nJwhbXWGeEbKFnOqw=;
 b=lMkRxyuvI4vWdNWMSO04wIkzJ8TfYEdZf3KMj5Rs6736onevMRj7LEfLpvvKaXsIKWvtbq9z16SEsJcjW3PXYupyRt+pGrF+pdNqUuvjUvSGjcQXBSyfboxHJqPmHTbzyDYc0FF94NC1RFis5mPmCIxKy3kSOOwx02raEE57jFuIVx/eck0Bjk0QiKsMUUve0nD6Q3DTj+kIuaMYT4FGdk1M+qwOGkkJXdAlHvuZ+DQUB2SGhSc6eAQNreh9YoLFecXBOWzr3csRWweNWpTpGkaeathDUBaA8MaGqlECoTd41ltHM7aYKH6tOD9djwGB9gJBxRY17z4a63d/M88YTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ewjfwLs71ffii5kJDf0jtux0nJwhbXWGeEbKFnOqw=;
 b=Hb4te+yelSL3A4oikUX4f5YxO8gF4VqtW7WeY05ML1EkDJBu3vViwJEKn5hk0daCvxLkhUw2MEogMoE/y1M3G2CEb2RHK6e4jQ7W727YDfnbEJOuNIakwuq5LDFh7NtwvuS04kkypgWb7mPXrjyBwpDzc53fAxBhjxkqV0sFnAk=
Received: from MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:47 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::d5) by MW4PR03CA0157.outlook.office365.com
 (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 03:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/36] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:02 -0400
Message-ID: <20250617030815.5785-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b987598-f86b-475e-df4d-08ddad4c469e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+XsNH1L9TaeFK7+swmvSs3eNnWyhmHrK4qD2jqyFg90jAZMFEvRiU+DeA73l?=
 =?us-ascii?Q?7ECALbDJEkq93wAjkY3egsjVh1ia5VnjGg1USzTiproU+L/mXnxpJs/oUxau?=
 =?us-ascii?Q?XD3iJEArvXD58cvnURiGVgCESDch2CSjdotl5WPIs0Ln2/+VI2PP7Ymu+hty?=
 =?us-ascii?Q?9nP5K15zrRjDTlPo7ty7v+Qdc/11LwxC5ak8zfNi5f9iMQtv2/NrI1gnML54?=
 =?us-ascii?Q?hnb6vcN7O0SS3nchJ7mzd1At2dR0s54rP0xsv54BPYGFT3icrU/jnXpI1azn?=
 =?us-ascii?Q?tsxG4ZVf/CJNfwby97OJBESO/oNvN3YNZtg03N0QR9qXiaEZNQQ2U/9wwTYA?=
 =?us-ascii?Q?IXoeQMLtkoDPt4ZCGAguPIVW4VRkf1w/GIYeTobbqUjRbpq9hjS6jTdiJjds?=
 =?us-ascii?Q?QlwEqXsbV+SlhWJWbFDWZBYxIDyVmryX8SeCyKPSQQDBG3dhHQkJZr8xKoPK?=
 =?us-ascii?Q?ysTqreIgA1DlC1rC1W5sJ0kJLHHBXD+h5d/ptpNGz1x7MlZZ7Kwi9xxlExD/?=
 =?us-ascii?Q?4VtiSybEcUC6itvVfSPwgINJRN8wHF7/qDgFoMG0jO66m3YDl7EI58QnOTKN?=
 =?us-ascii?Q?8oGGcwoiEUSv4Vnhv0tIpQyKvnkHCxHKHzZDUpc/WPi465uAV7iQrroWcLj7?=
 =?us-ascii?Q?4OsT53TgDNgCCMvCuv18rOTrFLcfmGkngM84Zz10imXsgjWYXo1C5CmtJQw3?=
 =?us-ascii?Q?weX66NyXHjjbSat6VDJBHPbZ5q8ItN6xBGY2JwCQI55Ept3sKcMkTXfzH5ye?=
 =?us-ascii?Q?xNYKRfRNKO2kRgJ/WwODdOpb21l15hoSj/u9KvyDgeueHIqZxn2f5YiYCZ0W?=
 =?us-ascii?Q?GkiPlBNCj0/7ivTKTClBQp1LSTTFUa7+IpwJ2YBH2ADwRTrYj7gT5LeUWMld?=
 =?us-ascii?Q?wULjRuQvht+xURKMEwp2NG79v6TlLkUCQ7ylUFP5GgqavB9912UUqf1ZtNcT?=
 =?us-ascii?Q?g9EnVX7FnUaYpTKa6+di9kMEyApaJiw+P94PHLapKsq4kUhcSvZ9wgw67cB2?=
 =?us-ascii?Q?Xw5u1uScFCZBrQmHmswXydq7Dqbvhw3WOhXlEYV5W1Y+M2t9T1S5o44arr1E?=
 =?us-ascii?Q?t6Ofkr+gbB21NnjD9ThqCH0QMQyNMOWvA3HU9gIIKYNda+LOe61aKPrcETbf?=
 =?us-ascii?Q?EBrD9VW6Q4ijwFDqqCkDrpQ6+ptXG/koyduQQcqFNOOzKcPoj6Qmc9yIysUb?=
 =?us-ascii?Q?0tQH6OQk8Y6lXUqiX8aqf3Vr640xA9rzLEEw8nEdVVR/eeAAu2mpe1vGziyl?=
 =?us-ascii?Q?r4Ed7Z4GgeN6xaVLwR3N/Ah8PAlKdtKqjARGvhhrfqt20puv/G+yn1bi1zkE?=
 =?us-ascii?Q?hk+7X6r2hbLXUNGGqdN6ohnueF+BsBPC9wYsDv8djbozm/21GaeEN+X7Q4t6?=
 =?us-ascii?Q?ORQgNiqh9q2OcUrJIKGD3uYDvz/kD0wDer5Q7tuazHnosnl6rR5YymnbMEKU?=
 =?us-ascii?Q?pb2uzJtIGWu56Ug7PnMlSufSa4Snyro6AH/b/LFRtTgx73uuugAkaYbwUChV?=
 =?us-ascii?Q?BOsccHCkqb+Kj1BxTl89enB8d/6v/E3CyJ+5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:46.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b987598-f86b-475e-df4d-08ddad4c469e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 60ab0f2afeeff..87b080eb0adef 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,17 +559,10 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.49.0

