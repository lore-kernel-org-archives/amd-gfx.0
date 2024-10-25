Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2DCD1039E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E58110E9D7;
	Fri, 25 Oct 2024 02:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qV4E9vI1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BDF10E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBRiKmER2YbBeTU11R7fbhKweT5V3inASIn+iwHEpbM6lV3P/MSM64IDl5duqzunBFONur67apLxGVhlLhm6WsBAVqzplByq+jU3Ayxjyw96W/efOkrrxAOPaMgqUmLM/Wdf/wHv6pmK7+SB5NzodNp7OpZZPPX+iHF/MxT1wFUVcZFokW9va5iw+sJEQVkcL53uNxUkwmgMLFPBIOBQ44uG3llAgub4VsoNIH2IV+dZenvkmRjIJ1WRC9e12MtXRUAOqhrqVv+ciWHeYkKEOQ72YvWZP5kkRiwhq2hugNRprnx4IHiGf63qrPxgA8Sqgfl5MiBJ1Ezwbagv9JKr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsLWIldGwvDG7PAxr3tyas+wqEXi6+ZmH3iNczkqtC4=;
 b=uKfzHCV9T1xnG9m1l5fXONMkcsgwbaLNDYM32QXSKiYnj9snzBlIxmJa+ZMvXjRgR0aQVBkjwzZB1D223KE+y2ZpOQGp49ipBvdDNJB89ERK5xeEUK8jeUp4vdOFnDDwubyl31JyMptrY2CCDGpGPQcWF79HJv+2yHM9LxfHT0ivN6Wf9wS5azyKKCWxSZqKh4D0jPoW/aZWcJpPoidZ1hvrwAlQXj1QOhgrVQdIJNTw7+tvD30pvXCJxjTb8Oi26jGnDfxl1j0/p+3+ARgjrIWCXpwC1fmkCqN82jPFDxO0FD/RgkznJsvQqr69GJOCnptb0pSI3whAxaK38zQ2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsLWIldGwvDG7PAxr3tyas+wqEXi6+ZmH3iNczkqtC4=;
 b=qV4E9vI1IEPT9GuIZ2EmLny2Yi1ajZNyot2z3iYc6ytbpRjb/HY4aomP5xOawxD0lf4Ngnv0aywtFU/rsCZukRhLKk4Npcj9hKu8wRWpRm0u3wz/pJpYdeWxnRu5h1LWoHtv548RCXmMc/Cv39cpPbppoKY2ExYWNQeEtOJyNCo=
Received: from CY5PR15CA0168.namprd15.prod.outlook.com (2603:10b6:930:81::8)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 02:36:12 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::f1) by CY5PR15CA0168.outlook.office365.com
 (2603:10b6:930:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:07 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
Date: Thu, 24 Oct 2024 22:35:25 -0400
Message-ID: <20241025023545.465886-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f316b79-f089-4253-4cd9-08dcf49dca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkVPa2dHcWVqSkpENDVMZ1VJUW83RVlSSjUxanM5aDE3SERuamRiRnc3cEhl?=
 =?utf-8?B?WXNhN01sMlg4aE9ZY3hXOFJoSDlOR001TVdnbkh0dlNDakhuNWxDbkRvbFkr?=
 =?utf-8?B?TW05MDMzaWVRdUk0OXFRSkRBSTBWNHllOXVaK25oZnRxZElJN1htZXpEM1BG?=
 =?utf-8?B?RE9ZMFVMZ2ZNK05rQ29pWmM2aWo2L1QzU2IyT2xTWnVwYUk1bUNmWUhkLzhQ?=
 =?utf-8?B?c0NxdW5hTHNrQ2Y4LzNSd3JhL29iTlJ6bjErdVZSY3MyeFhrR0krekVzMmFL?=
 =?utf-8?B?cldIcDRmZXBDcVdVQVBKT1hkSW5uSjR0SUd6cDg0dm1uZS81eVVMcGcvSnVr?=
 =?utf-8?B?aDl1TjVLRXhDVFRZc0Z0THFwSnFlQ2Urdk9QK28weG9nOGh4NXZOK3pBcEVl?=
 =?utf-8?B?M3ErWFlXWHRYQTYwN0djc3lDL3diZzIycGJHQytVdEt5cEZWdkowMDdxV0xJ?=
 =?utf-8?B?TXcyUjRRZUMwVm5XdmthOGVCYzROUkRMZTFSV2N4NHdxUitubnEzYnpuQkZu?=
 =?utf-8?B?UExDTGtoT0orUnBHY0ZHZGI2RjFYWW8vZWRNaXRmd2tkUVZEOUIwVWRZSXMy?=
 =?utf-8?B?YTdibzg5QU5vUE5TbG1hQnFPcmxmK1dMM0xUemFQVjA5cERHTDBNNWFvVzJt?=
 =?utf-8?B?QUd6SXJpRXVSelBOdHZFS0tpUHhSZ0loYjVtSXEwTW94OTgwR2gzWkJvbDZT?=
 =?utf-8?B?ZEQ0ck1OMG5EWmhBamhrYjJBaTBvT2FHZnRRbm5LRlF3ZGhjMktvM29BQ080?=
 =?utf-8?B?d3VzRnFneXBzdlhaYzgyZlhXeC9qb2lxanllUUpvZUlaYW0rbFJQYnJONXVV?=
 =?utf-8?B?ODhPT09ZYnNKNUtiUDVPblpSTlVTZ2IyR1M0MkkyS1NTd1ErRmcwejZuTSsz?=
 =?utf-8?B?ek4zSExPemhScE1jS0dOOGFrY2IrNnp1US9sWFFIeXp4NWxyUTIrb3docllB?=
 =?utf-8?B?MjZxeTFkZzBGUU5zbVQza1RNQ0prWTNJQUhXR3JSNUpWOE4xT3IyRUpuVHJm?=
 =?utf-8?B?dVZLeDZvUjlwOHJmQllBVjBFdU0vVlcvNVZnK24vL2tFc3pZcVEzbVM4c2xO?=
 =?utf-8?B?VkFaT25KcjBJVWV1RWVTNjZpTkRhSDh2QjdzYzlrWEVnWWNYY3BNRGVYM3R3?=
 =?utf-8?B?eTBPSTlQV3dHUDFjTkVjbWNoVVFxYlB2Y3k3aUoyU25GSjY2S2pPdDl2UFVk?=
 =?utf-8?B?cWE5R21lYmFERU1raWRsVlkzeWZ3Q0JPT3BmcnQrWDNWVGFmZWQ4eWd4VllR?=
 =?utf-8?B?WXhjZDFTclJSZlNkenQ4V1ZkSFJFOHY2T3J4QTdDUlcvQm5rUENJQjRsTXp2?=
 =?utf-8?B?MWM1OVdUYzZwcURzVi9sZTZEaVRyQkVYOTZWdmhPbFpMSHJMZThnTURTNHFR?=
 =?utf-8?B?bXhMZjByMk1DT0ZDQkpiNTVyZTIxeVJzaWp4ZFVSdmVNL0p0dVdxa1J2L0JC?=
 =?utf-8?B?MHdBK2lia1RKK1V2d2dmQXVrTCtsekJZdGtqVnlUekprUE5uMmJ1MWpMQWZ0?=
 =?utf-8?B?R2dNb3llTGUzNGd3R0pvemZ6V0luMVdSa0JJU3hhZTRKYkhybjNRUm5TMEZw?=
 =?utf-8?B?MzVUTEZqZkk0dFpKakZQY2NvZjNraHNCalJ0dHBuS25qRFROU29TNE5YbURq?=
 =?utf-8?B?WmtwNFFsSzFLYzdUeGszaDFvMzhjMkZER1VGWWJGcVk2ZkRkSndrOHM4amdE?=
 =?utf-8?B?U3hqdnh1ajRFVG45RnNlUnFDRUVSYVhNQVlOaVhDUnA1V0kxNzRHVS92TmEy?=
 =?utf-8?B?NnhWKzhPSjlCa05LVG1td3M5aTFQSUtNbUdyd0JaOTFNUmg3b1dGZmJhblFx?=
 =?utf-8?B?NjJTUys4QWM4emduMm9VVUh1TXJYUDlMUlhCaXc3bis3RWpxWlZpclp1ZFJG?=
 =?utf-8?B?OGk0Uzh5VndPZnFtT0Z5dTFXK1dwL2lwRTdYZE8rdGZNTWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:11.7164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f316b79-f089-4253-4cd9-08dcf49dca31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add a new function to count the number of instance of the same IP block
in the current ip_block list, then use the returned count value to set
the newly defined instance variable in ip_block, to track the instance
number of each ip_block.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fba10ad44be9..2e2c6a556cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -390,6 +390,7 @@ struct amdgpu_ip_block {
 	struct amdgpu_ip_block_status status;
 	const struct amdgpu_ip_block_version *version;
 	struct amdgpu_device *adev;
+	unsigned int instance;
 };
 
 int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c06e3a9146c..065463b5d6a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
 	return 1;
 }
 
+/**
+ * amdgpu_device_ip_get_num_instances - get number of instances of an IP block
+ *
+ * @adev: amdgpu_device pointer
+ * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
+ *
+ * Returns the count of the hardware IP blocks structure for that type.
+ */
+static unsigned int
+amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
+				    enum amd_ip_block_type type)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == type)
+			count++;
+	}
+
+	return count;
+}
+
 /**
  * amdgpu_device_ip_block_add
  *
@@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		  ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
-
+	adev->ip_blocks[adev->num_ip_blocks].instance =
+		amdgpu_device_ip_get_num_instances(adev, ip_block_version->type);
 	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
 
 	return 0;
-- 
2.34.1

