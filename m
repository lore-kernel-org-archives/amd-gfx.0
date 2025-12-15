Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B6D5B84C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A232610E544;
	Mon, 15 Dec 2025 16:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTMszwDL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA12610E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6dzB9nmlVe7Tdatp6MXMIkn6xTdJ3E+RmHtfTLivXEJWc24ZlvtKRpztNyRu/C/Tw7iExxbZHD6r0taiIhD1UbUMd/hNhYzivtY5aKzh5p5YppZpeRAAqpy8EBGN34mKqEQH2Oi/3mdpJzXUU0qd5TpEXDKf5HiWJa/QdVGPbReBc7E4OCXqz6ZxgvF4XmHFCN3YzPEHu2g+5RJ5TuDeQmiSX01k191O4Mfm1GlicCe5i4AonuDdeuXcCfZN5CxsbIkpAaUQBRERwSyWd2mNbkicT2yJYVB+A8bUeR20B9XRGo2TeR797SeIXXzNVt+OZKoCgaOvbrwVM1tO/PrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTjxxprpoPWl6mB4fc8eAYs1S1xQbD+nC7H+nr9HYq0=;
 b=SnQyfx8+gPestv3LGyta+2d95D+krA2Wd8/BmYGwmvDW0VTSLKdvD2lOw4xc9rRAr1C/5KjQO7rBiNHSMcw6Y7jlHAXG1+VGk9gdb5t8nAWETEe8xkSjzsoRidgzqtklPUp3LrY3VfWyXZQ2DRrr09juoJIulfbmEx9hO+/siVvKmYIqfvjWFPgv1f4Y9Uo/zFOvJRogs/O8VT4N6ZUkgqzMsEUYVHz1y4hiMt5FT4ubGih13xQnuV49+8I7IlYwntP/R+4m1xat8dTiOSSY6K0UdH9QP4MO3UdFXL3yeHnnBLspruuh8Q7GKqoAIUBLeymLVtqr+1J0gcTldzBwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTjxxprpoPWl6mB4fc8eAYs1S1xQbD+nC7H+nr9HYq0=;
 b=gTMszwDLkWBpxtIWyUA/VQuZJbrmle6gsgpD5+8i/kpHdr3bNh6yFKF5IVPyy8X5xZPTtXVeR7M73jp9i7d3HsvyO+jMtChKssXE+qtPxW2li0plkDf5MXtLVM4p39N2IVIjDnr0QGWpxSf4rWjqDY78QFtpw0SaMSKbR6lTe7g=
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:42 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::f8) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:08:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: use dma_fence_get_status() for adapter reset
Date: Mon, 15 Dec 2025 11:07:08 -0500
Message-ID: <20251215160711.11832-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f65f9c-a69f-4409-aaa9-08de3bf43758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1SJkVEpguhdw1xWd3THdBVizoYUzx+Eue8gMkKBUqGCle/N1stThg3gHgmcO?=
 =?us-ascii?Q?PauM4gZizLLxRpd8HSMW5fMhNvdPejj3GSr5upeeAlltX53u3ge4yQASjO99?=
 =?us-ascii?Q?TKJsqAh4PJ6WN9C3Oj09+riWFT9ivURuvxp69QWskQfyvBtdjUqMJw3ayroO?=
 =?us-ascii?Q?qLB7iSdTk8QlXpNpivt0guUv/INtRMl8TSGZXghjERuAKTjxNnECqvWmEMIp?=
 =?us-ascii?Q?QMvw8oTrosMALbIgrwHsFvtytHiqHelj5wBCBOtv6jM3GaBEY/tHOTEauomU?=
 =?us-ascii?Q?lYLQCbXpTGsZPfVFIn4WjWZa+lpwojE86T9nR5zNqJFBGvHnYnGuopdbhTOb?=
 =?us-ascii?Q?20AsjnOpAgmrb96lxQ46NkzNMx5ZqPpCO8mlhhHJMoU7sr2wPoCjxslKWP38?=
 =?us-ascii?Q?k3kKyRSjkz7vEDn1hU48wJryqzu9pUu77MPz18+6QectTpkKReLcAd9M1BZU?=
 =?us-ascii?Q?z3pBL3RuFjUam2qWh+aJ7cDCh0N455v8Zy39bCgy8rRhwdrS0THV+76IEeqz?=
 =?us-ascii?Q?NuY6aLVchhuCJ2Orm8WqPwxq7RhcVsVG5/skVT/33UH9adj0VVCLvaozpUUR?=
 =?us-ascii?Q?10z/wwAkVY13LXmubPDPghycdDuOrKakXm7i4wPzUjPRDQWhNnxnYX5K/D1u?=
 =?us-ascii?Q?pa7/P4/eAwk9Z1jG0UUMIP03u8a8OHh6bAPbwFHORMsCibqYC3Ppea5yndBM?=
 =?us-ascii?Q?/HVgNQqCzFN5B7WRxXS2cbwcbDHHLefvMemyJk0ctrUsMU8tTMHofUUsmrgk?=
 =?us-ascii?Q?qiqAy5yIma8OmtPIHdOIHzeoM0CRGpTecVilVifWz+0hGp6BCubGPK2b+/fS?=
 =?us-ascii?Q?M86eCrzpXU7KwgZBWLnKYCS5dA657qW5xJr3XK5MUC10oem4Zix4mxSy/tw2?=
 =?us-ascii?Q?NeX5MHysDhFRvlN9My3yNf5EZmVwLVZ8+YA8yqHBjr1Sjqd2XsY5IYbdTNTC?=
 =?us-ascii?Q?ujoAHe6j6hQjADkm3/+/gUpWGgZlFut6cJB7vbffnt+/Sl/0HrEZW4EwlPsl?=
 =?us-ascii?Q?fREYBJpaWn9NtahKu9cPfMy7UIS0lW1wWzHf2GhfHN4Dm7+knTA7lTPkUitC?=
 =?us-ascii?Q?UInUk+PBF/zzw+zBcPQ8TonMjAk0qsOCZLWpn2Hu+BBnJ0mOQDl7fxAz/nCL?=
 =?us-ascii?Q?23Qnq31EcvfpxthOhqbN1xAhDCagQ4cXC4tpJXTjcBk83sp9Yd85LkRUbdmW?=
 =?us-ascii?Q?fsuz9OYeP0Pyi1+DFCIAWB3Nsk5OX3pYvnlohCnRIpJE0DrgdUc2FpUDFqoJ?=
 =?us-ascii?Q?iU8dAm31UW7v8IBvzEwi2fw3UJ3AQznBltn9bLgGL2Lov5JzpLweiQJO73/s?=
 =?us-ascii?Q?yGidvS1JMMPN3E368O1NiZwqEb60BD8H+w1FRTLakFtiUpA2wD75UsvplODQ?=
 =?us-ascii?Q?IR62nk4GibNFeVzkDdsaX/S2f1SpTaMLsEcAf/9bdLoAF4GZrNuZDKf/OeXz?=
 =?us-ascii?Q?Hp3Ysira/JBdh5sx8ujYLILLEYQojLPOaxHXMITunE0Pqo6CXBUw6kRdAUSf?=
 =?us-ascii?Q?Qbofc+ofLsFanFumTazYRDMSMjvRKLMP0crlEVqs/4rMXJ2RdLLWCikMAXxO?=
 =?us-ascii?Q?IGpZWnnkLr7ldG9AG84=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:41.8940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f65f9c-a69f-4409-aaa9-08de3bf43758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B
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

We need to check if the fence was signaled without an
error as the per queue resets may have signalled the fence
while attempting to reset the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0c314d278b699..d6c44ecfc8356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6367,7 +6367,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
+	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
-- 
2.52.0

