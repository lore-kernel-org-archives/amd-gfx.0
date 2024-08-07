Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24FAC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649B010E4B8;
	Wed,  7 Aug 2024 09:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FX8dnPp3";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C1E10E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMzEu/Gr5YywGU5k6PAfCE8jINsU1+BwPFDIzQ+CT1JHzLV6BZkB0o8vP+0/7Q5JsZPW98ymMioNV09z17ENLWe+Ak0DLniX4BsTaQyzgUEJ/XWAC2+QjpxslsMcIjqJ1jPdXLvq/u0dxE6JD71Y5FnaYMhZnSoLZsX03YUKE/NkUi4a/Pvu+h9GOM5rSh/9UJ7qwcZFa1jE0x+NEiuzni2YnJ3cG39M0coTNXELsdQ1KuLm8DtHFvVABcRWxByyXghqjtRl4mbXbDWIcCAXSe2xz0rcEYk4OF8U0A/6dvXmWR7E8AxL9gxQ4hUK684oQPMsTv8b7mXB6XKnPyWL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2MlJYUeO3cUZ8SZXNcszfY+UZ+dnt0rBf3NTeZGnTo=;
 b=phbKOTVajQrlPoB376Otw4xUiNqRbd8LV1lQIfOlftO3ZLDR+ruiUDdinmWYl/W4FQyscaNlebNODu58C8bLe5a4//DplaDQHsQKzvM438co9rOstj4is3CrlmylIGhAek+XkVs0EG5ntZYahopaej2UjJd//upNkPyzXybwm3zJEsOTlbO2FTrvxafd1kvmtk/c4H5ur9Lle8ihP68JnLwKjqu1oXeMhOJ4AxGoU3g+a1TVG/smLoPl0xhvV/CQDi7bXxNpMFpa2zXRzdb8MCzLatlh8BkVmVSioxDGJBCgQ7roMrbJrolM3OMjq+0XqHRy3vewQVla7rJUlXYoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2MlJYUeO3cUZ8SZXNcszfY+UZ+dnt0rBf3NTeZGnTo=;
 b=FX8dnPp3Mmdik7bdIAxeUXQy9w2XBpRl6oV/DahMB1di2lDx5PYtYLGkgvXG/C9LYIGcsgSQfBzJVRuXJGtokI8bfjR+1H4WoOJUX1nAWenOkCMa9zaahM6NKreFurr9kcSPj66GjUcjuq0f1wXpVPlvwE4wjPaud/a+lw/7y3s=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 09:39:19 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::6a) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:19 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:17 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 7/8] drm/amdgpu/mes12: sw/hw fini for unified mes
Date: Wed, 7 Aug 2024 17:38:46 +0800
Message-ID: <20240807093847.2084710-8-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fdfca0-081e-40c3-e78a-08dcb6c4cfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BCJLaVJZcGXkQP4v1I7PNhfoTESI5rr7zcfECOVrtwKwjv5uBkMNzj+uleqP?=
 =?us-ascii?Q?tveDxIhSpbfcJmXZz5COmcxOJR+6uGymYS/pCPdcm4hvFq+Y32xFj78kGA54?=
 =?us-ascii?Q?zdEW+Y8RyMM2c3F8UAiERXGPbBOopyFJfaE2FtZf3JqarKnV5YO+LcqrDF25?=
 =?us-ascii?Q?eJZ+ieOXSCE5DXSfy3a7BdRaUH9TDWxiQNVGT/MyXNJKdCUWlVrIWtI5ovL1?=
 =?us-ascii?Q?2/gUFx11bN34ysa3w0I0QQhS677YvHGRQ9qS+dvoaBF1HgeeV5i1uDdD3O+s?=
 =?us-ascii?Q?NR8A6r+8VNRljbF5yCvLQMEXwXd7C2o7GgEvwEpQH5pYECS3lUchHwwQtNHm?=
 =?us-ascii?Q?/y2xfx6NLCQrbRRlGvWqUQizxqMcAUZSFcQ4Z9LWAqWXtcrpB2djals1r+Sj?=
 =?us-ascii?Q?BhKfzjdBVKpWctEM0Lqf6Gc8dB7gswhlYl73cQLMs5iiFY5y7Zri/ehp7BZk?=
 =?us-ascii?Q?Zlc02NQJ7y7Odz/rEsQwX4/g5pllU3M8q27J/m78xR3IGWoeyY8VH6pRkOtN?=
 =?us-ascii?Q?4evOCk165/vFTWid3EDwi7j/f04g33i1u8CnKaaKadJjpdJGwJTcHVB1mSiK?=
 =?us-ascii?Q?dxnF9reiPtCTamiEmQf+yyu/RkG3anIikFfA26ocACK0HbIyR5smIdc7tmVk?=
 =?us-ascii?Q?N1dg/XccaGoyBIQrnIVVxcDlhSWdB+iGUmFFFs+SNRsn3qOKu9ieYJWaZLp3?=
 =?us-ascii?Q?OLR8pyRC6+Kl7QglxU/A1et9/phoEarl9vXJDDLv1otNsrjdWVWhJdvqpO6h?=
 =?us-ascii?Q?w9XLnhy5W28bCYOa09fnVq9RlHvWL/gg3I7V4//jYzM2SJP7ApN65ylC0iS/?=
 =?us-ascii?Q?x/GFZAVXv5EEYoFf8wxZEH6TGVeXv2az/XqOTw9Amh0vrcFVAh9NxnAYlumg?=
 =?us-ascii?Q?CD/ODyiWXLrZtBLFDWEX4bvN/6ir2/XPNsustrgH+G306vXk7jp4GDaW2ofU?=
 =?us-ascii?Q?lCafPW08iwz49AaNwTZWuClcZ1z1jT20gwN3oHVIa3p+SgvAr6aA6ZpxwnJr?=
 =?us-ascii?Q?DTs52wcm7QRzFAhtoHc5tXF57bJuSMV0F3gLL2pj8iz/ZuVC/zN+fPF6Y/VV?=
 =?us-ascii?Q?BBwQvT8PT4oZ2oR6icBfSlLXErhFL4HFrOYNoscnqcNgXrNUg0aiQbEdntiG?=
 =?us-ascii?Q?eIHUb7ksYfClztgdm/8bINaJfJVQnobMfMgnEKDVPl32bpiDkaBVj7PloJtI?=
 =?us-ascii?Q?7ScOmT2waInRzpkYd4L/A+b0f2xJ/b1LgHA11D6Fos+0ItuHUwjUBZYprxoK?=
 =?us-ascii?Q?CRVFjlCS6ewNH9WklVdfAHfEi9QAA8tD9wLLTX465uiGWgoP2HoCS9b1GFlD?=
 =?us-ascii?Q?lUngvSTNRDwsbbaitlqeAe+CS1SIzUpyxs95BCe4tvhnKYBG9NbUTAJCTIVe?=
 =?us-ascii?Q?rbh/MrIIoISYE8sLZub0Ooomye/ty9GFwZgPcdI1Hq/knCOS8EgtiyMp5Jgp?=
 =?us-ascii?Q?Y1NAk3v8X8lS1njSb2Ly5OpM9VQC9WR8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:19.4569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fdfca0-081e-40c3-e78a-08dcb6c4cfc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290
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

Free memory for two pipes and unmap pipe0 via pipe1.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index aa56034f9e65..8d2e005bd62b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1301,18 +1301,21 @@ static int mes_v12_0_sw_fini(void *handle)
 				      &adev->mes.eop_gpu_addr[pipe],
 				      NULL);
 		amdgpu_ucode_release(&adev->mes.fw[pipe]);
-	}
-
-	amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
-			      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
-			      &adev->gfx.kiq[0].ring.mqd_ptr);
 
-	amdgpu_bo_free_kernel(&adev->mes.ring[0].mqd_obj,
-			      &adev->mes.ring[0].mqd_gpu_addr,
-			      &adev->mes.ring[0].mqd_ptr);
+		if (adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) {
+			amdgpu_bo_free_kernel(&adev->mes.ring[pipe].mqd_obj,
+					      &adev->mes.ring[pipe].mqd_gpu_addr,
+					      &adev->mes.ring[pipe].mqd_ptr);
+			amdgpu_ring_fini(&adev->mes.ring[pipe]);
+		}
+	}
 
-	amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
-	amdgpu_ring_fini(&adev->mes.ring[0]);
+	if (!adev->enable_uni_mes) {
+		amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
+				      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
+				      &adev->gfx.kiq[0].ring.mqd_ptr);
+		amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
+	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		mes_v12_0_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE);
@@ -1429,7 +1432,13 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
 	if (adev->mes.ring[0].sched.ready) {
-		mes_v12_0_kiq_dequeue_sched(adev);
+		if (adev->enable_uni_mes)
+			amdgpu_mes_unmap_legacy_queue(adev,
+				      &adev->mes.ring[AMDGPU_MES_SCHED_PIPE],
+				      RESET_QUEUES, 0, 0);
+		else
+			mes_v12_0_kiq_dequeue_sched(adev);
+
 		adev->mes.ring[0].sched.ready = false;
 	}
 
-- 
2.41.0

