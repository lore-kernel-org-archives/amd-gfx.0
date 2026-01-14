Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C80D31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD4710E5D8;
	Wed, 14 Jan 2026 09:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVlVtaxy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3561610E3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz8HXIqEp+eNYNpkK1Eiy89LRrIuWDGKW1CNTO8Zp1YJKbQZidCrTbmwX+vUaVWKccWU9JND4M2cQ48BfAEmEeMqrpXWcHXfSh6cDsH4PdCBY6xkUSYkXKEWe2EUlF82FEDpd+g2JjWv2nl9GVjKVbmY85ddEMKIPdQnbuWiWwwjSXZxpzkL2mboGMdtqwMvpq4L1kSrQJT3UY7uEPnfBD9ogLMnDqrAL5Eh7NSiiS2xpdjGZ6x1occiRDNjbL36cZQN+zZaaxlsk4/Gb8dTnrKNciQjBljp5hbvHcyHZ7jjeKkRk0zTcMP1zxK+Q3unQvRr8x35F4lvgWqWOsN+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVhFAUqHCHgKpx9nRFHgka3NfF3ncygY2ZvtG7Rw+rQ=;
 b=a6kvhbVdQ8Vy5m8lmXV1zVbU4yr0a/LiRHnhqQUtFX1zxTo2mTVcAVaZNVLPSblu2FuNjxgbgBBKtrGYEEsDL+zjqHcqovqRvTozTAZ2/oKjpU/CVobWSqlMx6leJMLAbS8G8FIC7wVaDbBjpb8BraTqnUPStx4XZBycepMaFBwhv2scHtbdRZ7BoWCPyocRJIrmhEX9qkfrDDXW+MS5H8f1BN3mdqoV45AE+mDvjI3jcJXlMABTVtfSoav2vY9SYNhupes52M6ZnT7oeJMk9qJSBYpVLkNbPQT2vvZQEasvjNwDw7Ce7jHyoaZmsruUyx6cE17k9THFQDFhaLoZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVhFAUqHCHgKpx9nRFHgka3NfF3ncygY2ZvtG7Rw+rQ=;
 b=rVlVtaxypfvvIxbqHk3DL5r8hVDRZfZ3Snoze3bqMPcyG+SON8YGNO5ZMYfheW4jU5q93diVN3Rt23ZbDkh4gHGgglzUpEQFRZss0vI9TTCuET8Ksz0s0Yhcmn4zjvWf5QbGhaLibvk8wdyRIddzx9Vf6528gepR2erpzK9khP0=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:01:31 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::b5) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:01:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 03:01:30 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 14 Jan 2026 03:01:23 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/vcn4.0.3: ensure JPEG is powered on during VCN
 reset for VCN 4.0.3
Date: Wed, 14 Jan 2026 16:59:20 +0800
Message-ID: <20260114090056.356633-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114090056.356633-1-Jesse.Zhang@amd.com>
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 779e8462-ed72-41b0-d067-08de534b8263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?899BHVQMBdZUGLU+tWbK0HcFqefyX3F9zFQNaUaAZpwcJKi7M7l/riNkUUX3?=
 =?us-ascii?Q?Y986Oyo8Q3VbGsR9R9ROR54z0hd05hokOkXPPJrYxsACWE0JSXmqE+fAiAyR?=
 =?us-ascii?Q?hC+NShERqYCqN2YEpWkCcGzw4Cq3RY3CHlKf0xJ4goeRcxUm+B+4sqhEpgrX?=
 =?us-ascii?Q?1llpHvg/wR8i5pCur9MgXOVuVK/g4Af5WsvFMcHbHh5ZISMWC0r9UyXPO14l?=
 =?us-ascii?Q?/y3Ux7m+UpV1HSoNx9Uoqz2EhkEmoWa/ZyMnli5b6DLHC149zlQQhxzujcPG?=
 =?us-ascii?Q?HrOdGift3Z+uAaO4L4++k+7MQV1jYjCl+yWsOkgLdTmg7vz0c2uVVFV4BFcq?=
 =?us-ascii?Q?+gY6IYsNOTQZ1no90a+BZWIGiDqhvFqbJOYP1irR4ogxokDvLVnO/rxcr98b?=
 =?us-ascii?Q?rfuzLhnFxt86HqZJMMpPBx3wsrLk/GZ9E6n97TCpN6yzIdDUCrBhuy7y0rlx?=
 =?us-ascii?Q?eq67aXYuzEfgm3qo9vubVQl7K+d0qXxswXmoxbI72kxqNU2d3w49ZyYmlZkI?=
 =?us-ascii?Q?qr1YpsfCQc5uIcimbRLW/RFW6pg1/8cIjWnwvfbFpnjSTp26NeTAhVONyPLU?=
 =?us-ascii?Q?QXxqFSHpd4KWQqNNXF7txhumZq1SwM7smxjbaB4Sq60MqfrbOsUExHye+PU7?=
 =?us-ascii?Q?69sYc+ud8JxYmLautKcMaPS6FhdOh9LJVeNX7o+r9iDvC50stDpmMZ+FgL4w?=
 =?us-ascii?Q?5WtOhl9pAn4Z/DRFSC+0WkrZUWsSNXeZMu+usAHup53NKuFr1BTnVrqKLGXG?=
 =?us-ascii?Q?suEqEmIHeEOepLyd6sV2101tPBc1L8fYv5pCU6EBFfi6gVjYr3qfT2e3PcMf?=
 =?us-ascii?Q?xTKSsCNadGIpVXdAA2gLPwajg9CRfPnmJCejIKd3rFyqN+Z/YC6k2QJgCvay?=
 =?us-ascii?Q?N8y2RVvqE4VDFa9fUoX/an92sYzPlI13B8PrajRoW7DU73UokKo0bzWRA1iI?=
 =?us-ascii?Q?ZzD9vfICwPqnbaHsecYNOQdqz16Gp0IGc5AzCDxna89d+8y3d2OfJejlAmdK?=
 =?us-ascii?Q?iVkx9K+3e4vqlIDCSS67qzp86vaFzy/4e0yVt/Jul//34kKEtoj641TVJorE?=
 =?us-ascii?Q?RyBz1X8Fqqswmt6JIeFIR8HkYDuhK/rNg58lfJwN/CElNQkdRSnAuXfsdinD?=
 =?us-ascii?Q?+05mPsrUa0gXubsTtRjBJPNpLA4YD2zMY54/Evusi/0N1YQnJ8MO0HpJm3FG?=
 =?us-ascii?Q?ekD0uKL64HGeb+qS2XLGGt5TjcKKandnnQU27JcApRE3DQlwRYwiqLGIe6sJ?=
 =?us-ascii?Q?H/ov0ixIkIFyj02/vvY+iXRL+uXh11iGJPYK0lvQaaiStf6ib2RQB/m9asM9?=
 =?us-ascii?Q?32FagcRRCZijNtAb4hLUj4PobQMRbcir5+POICLzSifrOGr7UxK0uc7HDHg+?=
 =?us-ascii?Q?ywuPsALl8GU7JlnbBjNApm4j5IwaPErmc90CSaQiCh5Aa32Yw+h/W5Hjaa5y?=
 =?us-ascii?Q?8MBPUYiaHpRcYq3G1InYYk/YpC8jjdpppsc1gJ4/np8jdWOf76YaM2aX1Z8l?=
 =?us-ascii?Q?J8fAyISW4DBUIY+fp1oIeq1rhcZQCeshypXvpuSW6ZqDyE/ckwqKj71S31eh?=
 =?us-ascii?Q?hjRrBk1lZAdnMEukAw4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:01:30.7167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779e8462-ed72-41b0-d067-08de534b8263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

Resetting VCN resets the entire tile, including JPEG hardware.
When we reset VCN, we need to ensure the JPEG block is accessible
for proper reset handling and queue recovery.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 31d93c10dfb1..0ff2a1241bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1630,9 +1630,17 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	int vcn_inst;
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	bool pg_state = false;
 
 	/* take the vcn reset mutex here because resetting VCN will reset jpeg as well */
 	mutex_lock(&vinst->engine_reset_mutex);
+	mutex_lock(&adev->jpeg.jpeg_pg_lock);
+	 /* Ensure JPEG is powered on during reset if currently gated */
+	if (adev->jpeg.cur_state == AMD_PG_STATE_GATE) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_UNGATE);
+		pg_state = true;
+	}
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
@@ -1641,6 +1649,11 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 
 	if (r) {
 		DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
+		/* Restore JPEG power gating state if it was originally gated */
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
 	}
 
@@ -1651,9 +1664,18 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 
 	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
-	if (r)
+	if (r) {
+		if (pg_state)
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+							       AMD_PG_STATE_GATE);
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 		goto unlock;
+	}
 
+	if (pg_state)
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
+						       AMD_PG_STATE_GATE);
+	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	r = vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
 
 unlock:
-- 
2.49.0

