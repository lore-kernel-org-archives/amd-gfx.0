Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A95E9A04A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F2C10E701;
	Thu, 19 Feb 2026 16:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1l4vRzhC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A02E10E6FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABiRRUBU2zM2EZTHbZhXMhPD57imLv6yoNXPd4Ej0RMvij3tLQXlGHLo56pK4O8dW13cnxWF3eDJpZDJzYcOloRt1ZjxvvTx6xY+iclkkprTsi1lwz+8gTTRZjAY2+p8OvS7z7xFcThOKuJKItcG946PTmhe8HV6Q7SZBVwXyPZ9dHUEFvj8DeZuWbX0Yv3VNAi1vxbGRNn1Ng9LQYfsZTNvzAeKLafcbu5FYJQhu84ArbYNySym076e1L+jQejFwh5aMtJ5mjFkZmnG0+X6jC0dYbBD2zTCyWOh+P1DPsU70zmFY5gTqsJZLCncCd+4ZrLjVU7TtDFLZuY+taXbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifR22s1NsQLhluDjZtWvrC4yGOIYHVoNRljYzBKuxYo=;
 b=KUvQfPXASc/Mhh5BzvHv32Q4aCW3j+Z294iaAqVP2gEwrv59GYL94x1HYlgZplOwI7761f27Eu709rMjqv1eeq61LXWjvyymDuaxCZ1b5h/VtnZkRNQWGm1WypzY5fJwMWEa9PWwycxba2TPfC39j16ER79WiqRLMq02eKMTLjiUrgtsWeKUUts6en5ig7DL5nPaaR5KWY8xW+caLYU0WtPPYNQoo5NmIVDYNJrz2HhdZGWYTblkbsqIjJudREG5IpZXZWmLA9QbSfk2Mp6hTIB81QZTynCGw75NAAfJfz/qMydaxTe3fsumdA626AbOcZeEJcwp8vwTHPy1TxOq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifR22s1NsQLhluDjZtWvrC4yGOIYHVoNRljYzBKuxYo=;
 b=1l4vRzhCiBC3EnGejHha+i8x4m9KroRgbefBlv53laxj1oKAi7EKbLITSOq3vMeWKCWmFRWUnKzRE/hVABWEZ46qdd+x18oFqaLnWU2rSh016IwroxNSs2kLoiGciTMDm8Cvb3IuN/QbgMPGaY3YiSrFp8PMC5LhTvFhds23YQ4=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 16:02:40 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::af) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 19 Feb 2026 16:02:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:39 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/sdma5.2: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:21 -0500
Message-ID: <20260219160224.1976043-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219160224.1976043-1-alexander.deucher@amd.com>
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 62aafd34-9ded-4835-39d2-08de6fd04ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjITWxOhe5IJ/B5kxaATJYvttG0kbHWXDgTGip23N9fQsmq1WgKrJwwf4diA?=
 =?us-ascii?Q?USisK0alzH5O6pxeqLVgimsJ/KFqR79UzywRlBr3nrrnIBGqzmmxWxp7Y3TH?=
 =?us-ascii?Q?XDIejTKKwr0VUBFBUz7OG2/jbJTWFKHNF7Eofogw8I4cJzjyjRhda+8BBQ7D?=
 =?us-ascii?Q?8OsZV46Kl1yBKx/7CBV4L0kAl5gs/eifB1/0SRRXM+D8gC9D6CRvC5vqI7DJ?=
 =?us-ascii?Q?KovtAdWNhFpGlqOI0g56G6+7zpKYKrw1iTxUvPppAksMKYmk1OtlsBFn4o90?=
 =?us-ascii?Q?Uuwnf+ks2L0ewFA8teWeuVPTuWR9ISHuVxJxkvWKOSEJIQPCrQ1yWlabwpr5?=
 =?us-ascii?Q?rztlM7GE+7DJQYj8beOB1NQtQShCcNl1dmKYlLnvjVNKHqjIEkV0/QlRDcXE?=
 =?us-ascii?Q?MgTozsfX6w7BvlM6wWiVjro6sTCGXe21R6HrGv6pYJxz33EbBzSDBClE1jzJ?=
 =?us-ascii?Q?3UOCCdrW/88Rx2qkOhx2hlWwKTzUQ2LJC66ucgJcbPWtXcZXbf1Q3aRwra6+?=
 =?us-ascii?Q?rcBFV7oRya9gHZTjrR3y5yvW586jxAXfCkuLYrPOfhYLnZk4tlRCF08yPsda?=
 =?us-ascii?Q?RpwhX8POqZEefNJkKm2pjecFwJruOsz7WPLxkbfToa6i9sSx9UKgxIY6jH+8?=
 =?us-ascii?Q?Wc/dIdCwd/IGBVZwlri5jTDI5+AoIy2YLUXTc3SPLXoRzUxvSGb3C6QGc9ve?=
 =?us-ascii?Q?xnn8hyI1JsLCmTn0xFJVvlSc+xMuxvXAxx2nZQtWOjJYiDT5I/YboYCkb/L3?=
 =?us-ascii?Q?zE1bFAN2GgaPBgfjyNYYsrqzEIWPfhY41LNgb/f3EZKR6n50EoexR2AThZwK?=
 =?us-ascii?Q?kWSONB1sVQY0hwdLQdWfBGc09CRdIgZFO4q7WHAsTlEEuw/6WX1kqlMvuRSi?=
 =?us-ascii?Q?8zGs/tX8WDyxRL8i2XJBqCZqV7IR4wRuhb6xWUIU4HDQaq/7Ba+GkBcJr28p?=
 =?us-ascii?Q?sll9HWc+qHsbHyRf/KkVn8klXvp69BGr5u9/zdD6Zh+O1atfsNmsad53PZ3+?=
 =?us-ascii?Q?z0sqH96Wc59lz/Cj0MWH+asstRLUQNsLkbhxMnCjm3sj3Z1bPyN7gFquy+73?=
 =?us-ascii?Q?cCu63dU12zXZHx4PXFFkoS9sO2MseXp45+S0/YgrQUl4+xjvRsCreJgiqrMI?=
 =?us-ascii?Q?/3q4o9VxxRjRgBA9negIzyHUd3erjpA+2ahtNR1mGA1WsG2lxX5+H3EjztUH?=
 =?us-ascii?Q?ornQBoCQ5st+bIwsH9S2uBUrgaliPYhvxMEi1giHxGt+MMd3QexTyzzlhbVP?=
 =?us-ascii?Q?7OOMsYCBXkQrSm0+yM/tk6eRNpZ0pO3e8r0vHvUkWwpdc9N39tbolhZtkMH8?=
 =?us-ascii?Q?1HZq0xuI0+zaYtnBda7xEgm9U8MQiEiQUpvHo+NC8t6KeGlQ8mlsCa/Q/K+g?=
 =?us-ascii?Q?aErZmfSOdXWSKCeM5h71EtdSqvtf3+vLCpRvrzdwinir36t224ibOeaPLli5?=
 =?us-ascii?Q?m3AgS9jrYKBBN54JlT7u0uPH1g2bSzN5l9QWk5XTZooROORlm+jC+127F7cs?=
 =?us-ascii?Q?vRhwsq3fC5NjKorjzRsy3O8j9OMRfQhMMg5hoaY26VvfbfRNChl6rczsRfUT?=
 =?us-ascii?Q?91GvOQpnbI5Pm62nQvFktydZZruVUwQK8YnqKBVjVmkcFHZeIsO65nFj6RiR?=
 =?us-ascii?Q?IjAORUBIV/GupHipG7eOUqcxGOHAhfE6w1KP5vlBl+NDQ2CFopMpLHde6L/D?=
 =?us-ascii?Q?R6WJOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PHWnxuYfM8+lxlqM4lI5RY/A8Q3UV0hWJRnCCfeEU1+OvdFpZZCPloQRxjWF4xk7jNDT4uNPKlNeZq+z0dSUnLWaWCqp9XZPmd05wYb+jgcWJGWsN6LE8Y2U6929iVviZFW0fOVP5eFjKc9hnS9LUKjX8h8OHlF0JY5GzApow5e9ISGtlvRH8Q0yJxDk8vKUHOQhGeQl+f0ertJ4y48sRlWShfViHdrR8HvJowbymSRzl1TQgWWdHx1omms6u3hwHwJQHsZ/wLAUDPkLUY1YU6VZbXwQFfyuqwxCZrpkvqv1lD/3wwgrl1TfZ+D8aftQYI0nFXiEO6RLUWNtjs00rk731VOi64Wk/s1By6DZQlbf5mY1JI//kKiDsRaseQl+V+xF/F1c2NHVXRFL2H6YT/6YpUUX2rPGXcAsIRWruwavGJnLQJA+vCL3Jm+7rpyL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:39.7714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62aafd34-9ded-4835-39d2-08de6fd04ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

SDMA 5.2.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious
v3: align const fill with PAL limits
v4: re-align with hw limits

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 491fe14ec0ba4..e7e53fdb9f8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2045,11 +2045,11 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v5_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30, /* HW supports 1 << 30, but PAL uses 1 << 22 */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
 };
-- 
2.53.0

