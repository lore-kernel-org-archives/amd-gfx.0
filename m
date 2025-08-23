Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4407CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536D610E1BD;
	Sat, 23 Aug 2025 07:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfDTzzrC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FDB10E1B9
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2EV9tsyTLxeL5ceyPeOCYo0NZlpe7P/Swlo1ZYYW0xHudS1DkkhD4XKNvvXShJ2Lp4qHade7zU3xJNIaKIIfLLmnQX3+SqpuYi8FQI/5wXZyXbBAerX4lccHe3b0NGwJ6hLeoGImiO6vHKPrSdBeOktkQsjeUBKn+kNqll4qgAhS/p9g9Kf9QgY+pusGINHjDezFHE4Aljf7Z3vLv+xV6ZiChSYINmiY7MXhCuuCbUDR1s/QIPzC7UdQPyOGupv8OmLqxH/5QIxZ34fzYqoCKXsRMYL6NMUyx2X+kt+FkxOElCpHVA46enHKajO937rO6WOqZQLDsxjZ9ukbtHUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=Jq/HT0mahz9VqxVjGKh3YIaTnZXA3rgZSo0aoWwKf4rFA+fazTJEWdwGgznBMByjYjNSTIZ8+CIR+Lc1fMqvbTS3vHiA74MJ/y5GvkhEY0eDrA7mxGWXB1KiIkXHvBDctS1SQYSe/ZG+RmU+9Q+fFQzxFVidsFJVHx3eDIXeFHZDZGnVngf811NCRQszUbUe2VkoUGmnyg93pBytrWBzccDUWeQAbbCLLXT2FEs2CYWerZIRpRC70SVDzRQ6/jJNO0x5FwuchGUpoGp7GcWoj/N9gy+Dm/h6qrn5j2/VPa2yEoUnG0yrkP8ftMY4Z4zDGAqiW2HJSZlujngFsPFl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z3gQHsVCG+EEtLX9O6fRVEJ6H2gWp+xeuxWD1UXfsI=;
 b=wfDTzzrCjRF3t+TjhlMNdG4EjgiTGw1Y8UTebSUB3hd6g1RyGw7Oe+WVxX6F+irQ0kPuwrCVMKTpQvB0tra3lnnpozFbYL0tgNgSVun2SZthxTJFuIEGUwJlT5iK4+v4Y5f9c1iLjEeN9xxeYTG6MXRma4Ur852yhgHMGRAGdmE=
Received: from SA1PR04CA0007.namprd04.prod.outlook.com (2603:10b6:806:2ce::12)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sat, 23 Aug
 2025 07:20:41 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::15) by SA1PR04CA0007.outlook.office365.com
 (2603:10b6:806:2ce::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Sat,
 23 Aug 2025 07:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 4/8] drm/amdgpu: Add mmio_remap bookkeeping to
 amdgpu_device
Date: Sat, 23 Aug 2025 12:50:12 +0530
Message-ID: <20250823072016.1272328-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 961fc084-cbf3-416c-2d6b-08dde21590e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDB2V3hrR01RRWtzUjJhWXl2cUNjakVrOVN3R3liNENHUFlZcGI3UzBKeTE0?=
 =?utf-8?B?VXFSU1I0ZG80bEtVMmlRdXlqM1NBTys1NjhJWjdzV0JKZ2d5cFNFWW85Nm4w?=
 =?utf-8?B?Tkk1TTlPdFl1NU1qbDVOckhzYkdkOHNIT2ZSOWVwTVRlS0V0WlRHeFpnWjhk?=
 =?utf-8?B?RHMvMXErMzF1aThCaXJMcFRrU0tlVmJKQ2pDVVMwckNxRHovVHZyNmFlUm03?=
 =?utf-8?B?aWU3TjY5R3loWjhhMDNKdkIyS256eVIrREZjY3NQNHM0VmdOUVJnaWpFbFU5?=
 =?utf-8?B?QUJGS2owRkVOYVdXU0JoT0lqRHlvNnU0N1NKaHJ6bnV6dmx2UHY3TlE3cmJO?=
 =?utf-8?B?LzZsMmhvN09NQlhXYldzWWNiME5pblVHc0c0Y2paenByTUYyMXJVV0w3M2hy?=
 =?utf-8?B?Qkl2ME9hV0xBOFFKVy9kVklkSG56N2k3WHl5KzdwajZnbEVnbVZpdFhVT1Zw?=
 =?utf-8?B?OHhHcDFpWkw2V3FsQko5NEJPUlFkUWhXaFg0dDZ0RTVOQTdYNnc0OGNENE54?=
 =?utf-8?B?a0ZVZVpCQ05yV2Nlc281VDFtNW5DcVROOTd1MG55bzlOdklyQWJVYmp0TzJG?=
 =?utf-8?B?ZXN5eXFLbTF3Z2wrekE2cDBlUXBSdmwwZUw0ZFJpSVo1aXB4cnl4akZUdmFD?=
 =?utf-8?B?UHExQzdxZkdGNzJndkhQa2hpamQvdVZvWFE5TW1FY1JrN2diUFFTTmlTR2Zv?=
 =?utf-8?B?Z3pGdW9FdWtIaHF2U3c2Y29KU29zLzRZSm9zbHUyNmdveDJjRzJVbE5zM1JM?=
 =?utf-8?B?WWpWeitlNzlqZTY5Mi9EaUExQm9RalJJTlhQdmNXWTFpRUJONVVERlh3U2Ez?=
 =?utf-8?B?M20vd1dPeTJ2TXpxckNJTE04MnlWRXJvbERVWGNIOUtndU95Q3RTT3A1bk8r?=
 =?utf-8?B?QnlUK0RSR1RGZWR3c29tVTB4anVvTnI3RVZydFVWekRWWnNzVS92dVR5R0Zp?=
 =?utf-8?B?bGh3ZU80YjZQWjBZdkR4dUFBNUNHWXErV2J3QlRNS0FQWDQ3Z05Ka1lRaWxQ?=
 =?utf-8?B?QnBNRUk3TXdYMlU2RVU5OENGaGN4WjBoV1dVditaYXBNampBQmlmQzY0NXZH?=
 =?utf-8?B?K3M4S2FDY1BUQ2tpWnNwaGZXdVRmV09LS3Y2NExuTmF1VzluVld0N0NMVUxD?=
 =?utf-8?B?SVVnT1JxVTRIZ3RQUUVMYS8xWDBCcXJKcTVDWmRhN0htY2NEenJtTkJiRTFx?=
 =?utf-8?B?VDhrNDA3bFZuMzhHZit4VFljRnliSjNxbHh0czNqQjhscDlMa2d1NXZrYTVE?=
 =?utf-8?B?K2Y4OUhsRW9BQzZjQklDU29INXRZUU8wN1dHdnlPTE9XVmpZSmdVNzZpWkIv?=
 =?utf-8?B?QUQ5UmZid3pHUjlFQXAzckJYa3d1QkxOd25OT1o2cCtGdnRHM25MTWQ5RHM1?=
 =?utf-8?B?WjgrT2lnSEo1Sk1nWURiU09ocUxuOVJkMTlPWDNnUGNiTFFQc1hLSHpkaFd4?=
 =?utf-8?B?NWNMNWdib25FcmtlQ01LM01TYVZXNG4zZEpESHpVdzBWRjBmZWdMRllRTDI5?=
 =?utf-8?B?UWYyOThOL1hnUEViTWtjTkZ3NUlNY3lnd0pDMmdtY0tTWUxDMWNLQ2JvdFVG?=
 =?utf-8?B?amRJUnFDZ0QrbVVJamxLZ2hjZW1KUEU3dFU5S3V0bWp1eFJuUjVnT3lNNENw?=
 =?utf-8?B?RmNTTkZBbG1Ba0dFOXhFV0djOWJhQXBZUWFRT21hcjBZVWZsdVpzQ3pINVpu?=
 =?utf-8?B?UlpweXhXOFJGSWwzY054Vk1yTzhLWEkzd0xMSkJSY3Jta21mK1psRnNxSmhz?=
 =?utf-8?B?R2tJRWQvY2gydlEvRVFtOVE1TzRYZ1U5bFNLcEJieWRGNi9LMUM5alM4RTRO?=
 =?utf-8?B?MFh1WUJrVy9rNnExaFVrcHh3YThzV0VBZ2kyTjJneXV4Vm1BWkFCMXMyV1Zx?=
 =?utf-8?B?Tk1pVTErSUdGYUw0VEltNUJoMDFDRklYNmU3R2cxQ3JPbVludmpQTFhFdTdy?=
 =?utf-8?B?b2psS2toa3hadjd0eXc0SWl4MU1zaW1tM3BFZEdwUFQ1K2hsbFdHZVY4V0ky?=
 =?utf-8?B?VGdwZXNOS3lFV0N3dWNPVlVEVk54MERRcGpRM3U3NWpzRlJWbkc1NTNCTWJS?=
 =?utf-8?Q?zTg2Qb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:40.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961fc084-cbf3-416c-2d6b-08dde21590e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

Add bookkeeping for the remap page to struct amdgpu_device:

* bo:	kernel-owned singleton BO

v2:
- Use existing amdgpu_mmio_remap container; remove per-field members
  (Alex).
- Use AMD_GPU_PAGE_SIZE (always 4K) per Christian/Alex.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24501d3fbefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
 };
 
 /* Define the HW IP blocks will be used in driver , add more if necessary */
-- 
2.34.1

