Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B7DC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F6D10E321;
	Mon,  3 Jun 2024 08:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T3SS5cfD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A9E10E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4fAdaX0P7X6vHhrDa594afCZlOPF/vabves0Byd0rHsLqBE3VaEopKu/6Jx8bnJl6ikqPPB3FWoaKesYlGiYu0pBE9P2kOZxxbojSzschYd49Tbu4h1yQCzHn8GbHzH8U9+XLxmgqsFqu5Gr/R4hVg7CLFWSNjUZASKZae1IvWk2zn9QyIEE8wC72ywEEWIpUR3XfYknHyRYPQjvgHxgHCCc408aHZ9XEYxmrtafecVwtLobx8FVG4Do+dmjSDo3KgsrmW2ARk0mPpopk9S4sDPXH4JETWV6R1lmVlVb5O0H3Bp4X/eGK/fjLKOTd/JBmW+esmovd6xhWq3iWCQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GyB7b4oAf+7CS/fo/VIABbDyY0l9p9mpr3w+yNXTUQ=;
 b=Ugz17FXHo7P3BIF8p8OyQCMDL9VkDcAY76dBq9dBMm6m5HXgVmnu79sA9KcMQjjexHG9WGp7qU5u+zyYCWzJ/m77X2KIVk+ZrupDonM1ONnDPJl2u3wA/Ee7UzsKrvFvDj/AstrjnQb/nwwgnGHBYn50bsiqgUdQtH2U+zBELsJeXc8dibV1FUusKjpoaphBaefnSH0moyox/hxIBVPydyvO1qUeMpHRc4q6Oc1WOHR2uHq6QDxkY4p+oGSbHt8JsBWd4oJ9zuIlvunj6FJXtEZCZrw8T4ap9oPcgs/2JnJNRD+QzXBId6Dn9O5jnKNcx+0+OyX5U+ezx0qY/h4m2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GyB7b4oAf+7CS/fo/VIABbDyY0l9p9mpr3w+yNXTUQ=;
 b=T3SS5cfDqmZfAx/o8ym/NCSla7GV8pstcmnKz5iCtao3uXhynpjp9U60O2GHiz6EqTwCd40Cs9y06i8thnVYx5A96n+c5FuIhh0oqK3YVEi5OdLFjr5ofL1VLzqZ49rXIsUN9NAkX+4/sWXuJx4xRX/aOiU++kCxu8y7XMkYdN8=
Received: from DS7PR03CA0325.namprd03.prod.outlook.com (2603:10b6:8:2b::34) by
 PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Mon, 3 Jun 2024 08:46:57 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::aa) by DS7PR03CA0325.outlook.office365.com
 (2603:10b6:8:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 08:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:46:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:46:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:46:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: remove dead code in sdma_v6_0_load_microcode
Date: Mon, 3 Jun 2024 16:46:48 +0800
Message-ID: <20240603084648.2569863-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: a7db27d4-802f-42db-6846-08dc83a9b990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jDWV+S4bBxJUwA68Lt8kftb4ambtihb9eljWqsr+TPjXiO5Y0BKBDZmiCudr?=
 =?us-ascii?Q?uRWyT8ajaFVuKUSDg0REBp4t8yn46H4wmrScs+1zuFiDr9gwHiS0slQCGbb4?=
 =?us-ascii?Q?cnEVeS6SBg0+nUKlI8lNZ/bE+wkxym8Sn2JBxsUccjadvsdSH5yn0lpqdWgt?=
 =?us-ascii?Q?MJqqBxu8x/Az3FkOmji/1Tp6BMZfkhbqkBGPjK4vGolIaUDYM2oUDlZ8+8O3?=
 =?us-ascii?Q?mu5jov0UC8jmoC3ho1GxjDFquuV0etN3hbJOxyIkEGir6yn7UNXos0UPKz37?=
 =?us-ascii?Q?jQbjLO+Ztqk5/jMgSit9JQu2kML7FbGoPpBDegAusRcNYo/u3KGAiuE1b1lR?=
 =?us-ascii?Q?yDDlZjjWn/+HCBWG14I/9SGwxsfg/q2yjmC2IJRlS494wD7+4xO1pzyW/LD/?=
 =?us-ascii?Q?h2lHjngKJ4+rjwKKH/+LjTz0FPLYf+YZ+YAKCfZ6/MfE4bOZBHKaNUXOqERx?=
 =?us-ascii?Q?6byIWZTfoTP92jxLGaqaa0jMGsRCo82VOK8EJ0zXjg4jXxJEHcw65jB7MwyR?=
 =?us-ascii?Q?8cA+806QInhCEWT7sMDeL9MyF8q/+BEg8u+zheCnBrk3nC8SCWp6ljeJcoqY?=
 =?us-ascii?Q?Ioq6hQv39Tjpw8szBxuN7u2B/gwUBF393LQNOtPF0sd5QCRwBC6Bj4VHScJU?=
 =?us-ascii?Q?Rs4NvqmQGDsrd7qMQF1Y/Fu11geosMnvPhd7oKeE6ygUAforZkqp+QIBf56O?=
 =?us-ascii?Q?Djp4SegBCJtYXM7Ivqlwl7kuMvNyNSZ13X6CHa6X+FNUD0FmuI2dSaRK8r5p?=
 =?us-ascii?Q?ZCusRvry4EyJoCwYEiWHd880TI0hCCcc+5x+NbeFoSERsdipPrmMQyNkVaan?=
 =?us-ascii?Q?BApvChR5tKglaSh9K7Y0Qf8jPa6N+wged/ki3H9HimBfXe/VNDktMBAD234F?=
 =?us-ascii?Q?03nTeQRY3Ep2U3jMbEdkeeRdriHwONnvuW7znsCHtgghmjoDI0yuihAe2J4j?=
 =?us-ascii?Q?bAhKpxFwlJpYnc/hV6VOwESBJnVOkqn4GTziuBFL7cO0Tab45ApIw7CT4cfT?=
 =?us-ascii?Q?9CgBCmhtlKz4Q1Dg+Y0bme76KkfJ4OEBJJCv9FKyugvoZks9FzNaePyxC9eu?=
 =?us-ascii?Q?JXNiK2NTvn3U9mA3l708eGvedjdkHSQzgnXA7SOfF38S/JL8Ic6V+2YWLR28?=
 =?us-ascii?Q?J0Ei6Fw3TvB/ObRwqcOpMBwV0mraIyc7G/EfKfhZzrY4q6VA+5VKzQRdv+A5?=
 =?us-ascii?Q?DcDsdZwvb8hBqnKOgBrQ/rz8JI8p84OcaGexw7ON71eMQRxI74aEGqf4xEIH?=
 =?us-ascii?Q?/OVZyXmhZiki+meH79cEZFMyl33FFtMcpqU20gDx9IYxBE3vH9dkddT1Z18V?=
 =?us-ascii?Q?FHYrDG1CA7nQh8az/6Gbq/BeVqt7rchahfTIAcxapYNbZYw5P2KSYDRwyh7Y?=
 =?us-ascii?Q?CBDCYkUI11XHUibPeuhmvXRGxkZP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:46:56.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7db27d4-802f-42db-6846-08dc83a9b990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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

Remove legacy method to load firmware mode, since that code cannot be reach.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 39 --------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c833b6b8373b..b54b9cc2bf75 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -631,45 +631,6 @@ static int sdma_v6_0_load_microcode(struct amdgpu_device *adev)
 				msleep(1);
 			WREG32(sdma_v6_0_get_reg_offset(adev, 0, regSDMA0_BROADCAST_UCODE_DATA), le32_to_cpup(fw_data++));
 		}
-	} else {
-		dev_info(adev->dev, "Use legacy method to load SDMA firmware\n");
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			/* load Control Thread microcode */
-			hdr = (const struct sdma_firmware_header_v2_0 *)adev->sdma.instance[0].fw->data;
-			amdgpu_ucode_print_sdma_hdr(&hdr->header);
-			fw_size = le32_to_cpu(hdr->ctx_jt_offset + hdr->ctx_jt_size) / 4;
-
-			fw_data = (const __le32 *)
-				(adev->sdma.instance[0].fw->data +
-					le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-
-			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_ADDR), 0);
-
-			for (j = 0; j < fw_size; j++) {
-				if (amdgpu_emu_mode == 1 && j % 500 == 0)
-					msleep(1);
-				WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_DATA), le32_to_cpup(fw_data++));
-			}
-
-			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_ADDR), adev->sdma.instance[0].fw_version);
-
-			/* load Context Switch microcode */
-			fw_size = le32_to_cpu(hdr->ctl_jt_offset + hdr->ctl_jt_size) / 4;
-
-			fw_data = (const __le32 *)
-				(adev->sdma.instance[0].fw->data +
-					le32_to_cpu(hdr->ctl_ucode_offset));
-
-			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_ADDR), 0x8000);
-
-			for (j = 0; j < fw_size; j++) {
-				if (amdgpu_emu_mode == 1 && j % 500 == 0)
-					msleep(1);
-				WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_DATA), le32_to_cpup(fw_data++));
-			}
-
-			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UCODE_ADDR), adev->sdma.instance[0].fw_version);
-		}
 	}
 
 	return 0;
-- 
2.25.1

