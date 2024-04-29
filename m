Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5112C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CCF112B08;
	Mon, 29 Apr 2024 07:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wce6ty/a";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C657E112B08
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4h/i+qFy85K3DXdlt/iNQDsbx7rY60ms4MiMAMS97//anbQDW6Sc8k+eAEhekk+BsA4pcGXe3Ip3vsKHLG3HBnQHG9UmD2bYD2mQbUneU5MrMw+nC0TLXN0SCW6YUj+4649S/TsfyTYrWtuyAzpOWJni1EcmgUpNNDg06yKGpqdJ5kdHUtMqsDHN8WIxPdgoi82qdlddW1FJzi4SWXJGZd7oC1fQQiDrFXQAP7ywA2T6W9XxY4zYJjBH5OC4TIRELXUn3qa51RuJ8+B0r4XJsHVlfNUn4g/LlKWjmWIaYCqFPdbYXy0RKzfruQog7+U/mVdgotiGmfa/deHAJYzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF8z5JdOyI7pyFCktMmUFOwxK/gX19HKRPNckxrBIis=;
 b=HeSUGd0ukRDCy2xaCiWtcL08Um7YXkAYAobbS6qzgmJn+JuUu6M8nj+s2ZhWmiWCP2aBza6qr28FwKnAfZ9YOGzFnDSk5GOBV9F+83hkFgA3o6JDryJUlFUqMexFHhdESNOaPpI2LVM+/Iya+DV9gSAHVjQVFVzpPIQoSgVxcRw7LwutvnxDhXh6Pv0EwGkDCLVYh0Iqga7Msh9BDfDeDVo+WHUVred/MmOx1xkRTsBIQzfqAGhiAOUMk7OLNbdxw8bpomQWBNAXPs/sWvBnN40wRP95qOAKyBwOU/UH0SFJ2M56Gew5GSytDPxJw9uwl9R3rUEMlQUIjUy4//XNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF8z5JdOyI7pyFCktMmUFOwxK/gX19HKRPNckxrBIis=;
 b=wce6ty/aMmN00DAx61DvnmXaNaDp+gaTRuAKFpimVtPqnnQ54dEeBqDY/zOvPIL9USwIr7PFOcZSe2LSiyQv3tEcMOJkoCnBHUewHh88Q8BOcNbgMrbs0HJlNuO+v/bFTsG4R4zkYHu1P5pYOlNNmlqhwVT+GvgAVnfskq7jRH4=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 07:31:40 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::92) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 07:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 07:31:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:31:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 02:31:39 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Mon, 29 Apr 2024 02:31:37 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Owen.Zhang2@amd.com>, <Maad.Aldabagh@amd.com>, <Qing.Ma@amd.com>, Kenneth
 Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: use the default reset for ras recovery
Date: Mon, 29 Apr 2024 15:31:32 +0800
Message-ID: <20240429073132.12611-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429073132.12611-1-kenneth.feng@amd.com>
References: <20240429073132.12611-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4e624a-f1d0-4f39-6156-08dc681e6917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?guRYlW/VyS7BJk1C08ltW9tGC1Mp193ab2Gt4Q+8RN4Rh39pidIy15cSrYPw?=
 =?us-ascii?Q?Xshf6WtAamySl+2IKxGKmnLic3LffWNSBKabyQso4u8htKEFg+MDCgtdMeL2?=
 =?us-ascii?Q?eOIjL9RFinwX9NdwrbFwNj1UTxAS+lwpsa5MwXalOegl8Fe3Z0cVnC29v2Dq?=
 =?us-ascii?Q?I4B48KAsRY0pVxJu8hPIhbMNen/PasCpzWigmrQJMWPfTDzGqf8Bspjy+8Ii?=
 =?us-ascii?Q?8EhcXNtLYhpE59VNa+jIzy5Keast2PchRlfsqCRi1qJGcYP2ZqcRAVgV8yBr?=
 =?us-ascii?Q?pMMB20DqwEwOwO5a0nnSs/YHtCLJgLWEhWTXGtTGsFe+w2f4H0TK6XT/KmIT?=
 =?us-ascii?Q?48BVYWiHvi56m9GNG1+/NWc0hS3y0l/riRcbl/r9YM0zzn/Ln1baM2xyaqWb?=
 =?us-ascii?Q?Ecv/3mbyULKxuNaJ1J4Xt3XLlCUBu+i1p6/P5KCdwVixYYaPsq3/rDQEk0Ig?=
 =?us-ascii?Q?n4LDxmnQx1sNFBoxTBpfmZ5FTctQm7/TLaIUCIjL8MwzjV07vy+JCCj+Ra8o?=
 =?us-ascii?Q?yQsuRr7yGGvkppn9jyrDk/NJZVr1ItVJFknNh8uG4Rny0CoU2Rxg7gNQbso8?=
 =?us-ascii?Q?GmfahTnfrj/KWofneuPy59MLGSVo9yq6u+wsKWtvbX6i9O9QDANSSwAA0jhf?=
 =?us-ascii?Q?9MmuNX9mMHDKenc4a9dPcfEO2GwIsQGQ2CNjK4XAK68dcb6rqZn5cDvQaFMR?=
 =?us-ascii?Q?yWX5DKzIFid5dbB5D7qJcZf4YoPzMAaKNbntcDWQEHwFpz+84bvkActdHMX7?=
 =?us-ascii?Q?x153mtc3Y+Hm/c22kX65KDhd6cBU9Fy9z622kPignnrHWypEJR2/CjA9JoWt?=
 =?us-ascii?Q?8/vQVSSRGNsL+ub+Y0dKMPZaMBuMteE83LXBbRxMHBjSKp+bKk1b1gJqJBRj?=
 =?us-ascii?Q?Gg5CHlE7l4hVVVJdzL3QuQCxl3v/PddNXdlFPVgTW48DAQBAQ5q4o0djh4Fs?=
 =?us-ascii?Q?uHkM4+17x1JPR28NMkRAfDdamf+WtmH/T2fG889HI84Jc7Tku4qJxP/3uVdN?=
 =?us-ascii?Q?7CdWz8x6FJMWQ5D9ateMLI/Z12WUoY5cFPIOOb+IIUfQQQK5LqfGCv4e3K7N?=
 =?us-ascii?Q?F2+NwDkoT9mMsaMXojj9ZxTncr2xQ79iw60ckLJbwKT/GjBfz/N/ZYtINKOb?=
 =?us-ascii?Q?Z0LHETHqlmhIgZqyuYmUeNX5ZCY5faK99MfEKVQMC794QS0R8WwePWo0+36J?=
 =?us-ascii?Q?gtVkVp4sQwkwfxBVOCHxqsCyprVhqIw0Aozb4w2ezh+1xhM0y/SJKWcfeiHQ?=
 =?us-ascii?Q?bum6+YChmTSvuJBRfT/5N8Bg3Y8gy60Zqp4JIr/L+PU8aKzde8P3Ky3E5nCf?=
 =?us-ascii?Q?CpdXnLUgOZruWUHCcTihAz2CpwToYxvWeA2VfgoZcmToywWGdT9HgeSXWz+j?=
 =?us-ascii?Q?4XBnXfaFuJIajKKAJ+mAJ7mWCr2M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:31:40.0590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e624a-f1d0-4f39-6156-08dc681e6917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
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

use the default reset for ras recovery

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a037e8fba29f..f92b2c4f0d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2437,6 +2437,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	int save_reset_method = amdgpu_reset_method;
 
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 1);
@@ -2501,7 +2502,13 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			}
 		}
 
+		if (amdgpu_gpu_recovery == 2)
+			amdgpu_reset_method = -1;
+
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
+
+		if (amdgpu_gpu_recovery == 2)
+			amdgpu_reset_method = save_reset_method;
 	}
 	atomic_set(&ras->in_recovery, 0);
 	if (hive) {
-- 
2.34.1

