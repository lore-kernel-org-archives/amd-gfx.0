Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BA5CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5075010E2C4;
	Thu, 21 Aug 2025 01:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2tS9u4DW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE79A10E2C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN4TaxI6PU2u3oOby3asIAabWcnb6fAhpGRervDDPPi4jxNTLC5mqVyU+sATspNNlFfqmDYGuH1Dv0I7F+3dJ0ciWsg2MiDnZE8IaW54+lXUmO2XU6bz3XKw+Kvu1jv0AvINnVlP/6I9Y/w4AMbkwprn+TALXF8GbxwH/aFSNz+QR1BWRn/m6aEbJVy4W+tRO6H+5Bt2ZiWtUWXYJECq3B906ei+EPYaqhLiOPy942iTndl8UbuN4v8ypvw3vbbGYM6nbXCBiSaj4SPWFu4PRzKtAQzbJWfj1/zYi/BobWpPRoygLjAKtTCyUbyX2N+7B13DyY+AMVxWNogqYuskjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VPrwT1wOXlNIHZh4uk8Q1G/OL5cWksVV8b62SjS8mA=;
 b=s55nGrXjNSZnsuFTlELBlsoZ4a6Rq7U2+4Z8aQg7IFcNL5OxVPznA7ZFhkaiKLfHnDhRV2PhWI7fDObIirHJdvTvw5ulLwvj5aosow25/Ejh4FdqnrmxdOAZDE0utQUJvMR+UGKa3So5VJ+s7VuxJuW9hRqtzAFMngmX+P2HW13Q0KZm2r6WLcnOG968XhoqqCKzF7SaO7W9xe2pBReH+wwjGd97z16lGNWNTgpU7I8IKuwTnXr0HmWURjarhkUyH7OMUtF+sS2hCrcxI4C/qowtZRM/4VSZgt4fC2LDSnNG+IA5D4CGrY2dGFsbViaCAnA0Y/TVi1LY0UuTrupZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VPrwT1wOXlNIHZh4uk8Q1G/OL5cWksVV8b62SjS8mA=;
 b=2tS9u4DWIro2xh6KpmIaxNXZfUEwqziCx+k9r8TV3S4+j4AreD8hd31WT2E/MvoaY0STWbBdYKSFvrQVTtVT5sYYjhsdlQoB/PeyOoAKcdSAI/3n8frWnEAgDUugsZmE547Pgv3U4v/2S148dcKkQQm8X1RyMlBeDJF6RqRyL1A=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 01:41:55 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::dd) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:41:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:41:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:41:54 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:48 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Thu, 21 Aug 2025 09:36:07 +0800
Message-ID: <20250821014115.566598-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ae8af9-6f21-4ee2-705e-08dde053e8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IGDEv7sghJdaWd4/AMiA96sxeQiLpJnGXCpfq8XAx0dXxTwCnovOucIuPvdI?=
 =?us-ascii?Q?31k3CcBKNPjCyL4a+1GMbV3w/5SM9uFGbufOujnyhLbTdwa85STONn9D63Ag?=
 =?us-ascii?Q?uD7rPuiBnHD7+plxIuW6mlNMxEdTgZBLBZZ6jcQDFdaDOVbDKzQDvxfoqYft?=
 =?us-ascii?Q?sIkbKlVEDnfAniwVvf2f2PaJqsxy56MJQPeL4XCm3mPtq95hB/V3kp0rVySh?=
 =?us-ascii?Q?ti+716LzX68+vmEUkR/LftLJDTAEFWQubhCf5P0sAF0DJBFWhRcgSZLhqNDC?=
 =?us-ascii?Q?2ArECQVGDRJU7Kf5wBYkqTkYoFXuP1miTRA+/GJlJXL3KQtvGnolWoXm4yqv?=
 =?us-ascii?Q?WvuDt+NsDGAcWS7mE2KNTpCGtoc1WDrHEKwx4xpzpkEoLj+dBaV26mHf7wIT?=
 =?us-ascii?Q?XjVCUI8p/PrgH7M1BrlLDq8/Pp7X9IsDv8QV+2VZdWaJDiKZtzaIqHA0Is0C?=
 =?us-ascii?Q?aPwJwLOBz59YhLrcA+WijPOqVz571yNugN+O5N++i0TFr7P6fqUx1qBfvuzZ?=
 =?us-ascii?Q?vYGAMr09Fs5MBYKIyWYhGQCNhHgfu/SewsRFUBlVwZIZd9ovCM37vViClU1e?=
 =?us-ascii?Q?dBBl5uENUU91EHdzm02y8FQn/bX5i7prOHUXVHwEr448RjvGpvJcBDtXS8Lz?=
 =?us-ascii?Q?4WSWCtlGbu39fdCdw8VBa88BZkXxhzOockWPPf+/n6ms7nkKlc+pr7zmwb6D?=
 =?us-ascii?Q?LmuzJjlFq523ilkymU8Bvz6lIbhhhjTXpDcNbejPpL9xJ9XVFFJLm1hUOezd?=
 =?us-ascii?Q?Sd70jFwa9pbddDTde8QU2PCDsh2GcCSgOvOTVvRgOsiDG0oyo33GZ8RLJO2m?=
 =?us-ascii?Q?2Y+EieckpQcexbvPcs1fGtMTnHTLLOSC7FIbVGF6E0jyP7foGZ+ew7nNCUYK?=
 =?us-ascii?Q?D4Dbanv9HRu/TvVR/WMuQ1ducFTDUwdK4IUhcd7R/NBHrwKVn0RIIhrJkzAZ?=
 =?us-ascii?Q?pe75hjDv760zE3hFtcr8yJ46okXCuHzJlD7KbRFuRJFjgtaBnCon9HKZ4/SA?=
 =?us-ascii?Q?3AWVbWPuTaxxC6yASD4gGRrLCZh4V+dQwsa4ssvtk0lNq9yvY/rPqO33rkod?=
 =?us-ascii?Q?VzhoRmjaKPjdqOOCspTg2Pk/gR/bVWkUa6QS5psP+erOOSICY17fNdrjl4+d?=
 =?us-ascii?Q?IvafqHTxDOcgNJG5CmD8CKeoRghDTYqo2EGQfNv6iGxCHaKAQqCXHYaGP91+?=
 =?us-ascii?Q?K+Szeo8OjzspdHell6MCp4JZHd4J/zWD/G+Wo1CaKVBmWqwlL3MhCUbQJhlg?=
 =?us-ascii?Q?xJNIGncGgpAvb9bd8cl9qCEDw5Z4UbDbYACSVeR7B5dlg7vqJ34jJJ+OoI6E?=
 =?us-ascii?Q?pMudLp8KwaP8RnXCrqdMHueP+LxNEcdqN6kHzIPC70hg/b0sW69NENlZZxZa?=
 =?us-ascii?Q?Psq8jwMJlM1mJXnGjT3/wCWX1Uk6LH7m0Y/UUwmENCfbfrerdGzyAHiT3M8l?=
 =?us-ascii?Q?+FULIWzaDf7mf3cd34G02bUm/z9jfu7a23sB/Fa2Ej2O9kCazkFWY/YC4rhU?=
 =?us-ascii?Q?HLBkwTgsge8OiM+IBKEBjv8urkioXtAuo7AT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:41:55.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae8af9-6f21-4ee2-705e-08dde053e8fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

