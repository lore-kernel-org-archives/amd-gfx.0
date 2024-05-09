Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E867C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EE510F692;
	Thu,  9 May 2024 21:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aonE52G";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3B910F678
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKG8PIRniM/nZ5rRiAginoN0xzdpgosfPj/DcU4wmr67XIeZRkXZPPJuWN94lTLPW1nLXJNox1tv0yPt0D1/StEXkR3NNOZfp9cQbEhR3DIGivmRf0Ns7KL5E7gJMfdxMmAOgiOwPrkTbSweR1+AUssS6Cm1wyAwPEKRgDG92buFkDaZMWBgL6JS4awwQYMW/iFxs+yYIFXkVvQdt1U4d3bUAOr8zJCO6vi7UJXSXE+a7APDBN1mkDZShaGDzWbN4tDNb3o63TQnOhnSMjefnMGusOHuCkoJM9W0/en1eSidEQCjFi5jGHXTtHhne/sCbKEtqyHcdiBISWQHU9Mj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ76yVeim5MDHhsE0IXHfqbpxqZkVKO8flKgOL6Yem0=;
 b=cJm/yFcrLh1IxdJOqJk4nLcOwsZd+M8qWiMoS0OZoelTT9ewcYB20Ti9xwDwdarLcEzdBWJTyhd8qtUZHf0hqX2DpKqL01+WHNF24Th0Q2PTfr51dEpZQ3mktZFTulFWAU1RbHts7obXdPHK1yKk6ZfRJM77xB6pBBaKV7Fxwl2VR9sxKdBZMlBoQPksdOBx7Jj/294toT35BAgO/fZilvT1BaTxHuCJRY3yd4pVh6TFQsrXtCgqpgJvwQtp9pOKI2arF51AI7vdIv1yyiFLvICi7s/AwQ02FOIDxNhnvlZrmXPcs6abwCalxG7+QXuUnI9HsUXlEGeXELIamJ+LPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ76yVeim5MDHhsE0IXHfqbpxqZkVKO8flKgOL6Yem0=;
 b=5aonE52G+psMjirLkPAk5xxecG3YfBMhBqwrgOQjLv1Z7d0ZC2+KVaW2uqjt+tqUqDFm8kZ+dlghLz2uHde8aBYBogB72zoOhTbd8B7tOQM8DCUBfCbpjsWxJQFfTwbsbfcKKQlPjDjYGIpexq4MJK2YNR5Ns5craw56hNlGJXo=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 21:50:24 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::3b) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.14 via Frontend
 Transport; Thu, 9 May 2024 21:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 21:50:22 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 16:50:21 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] drm/amd/amdgpu: Enable ISP in amdgpu_discovery
Date: Thu, 9 May 2024 17:50:01 -0400
Message-ID: <20240509215001.515866-4-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509215001.515866-1-pratap.nirujogi@amd.com>
References: <20240509215001.515866-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bae36e-6cad-4b18-bb09-08dc707206b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+YE0d8AOxFecfYhjJCUJUSCkYSSOKsvBzdiSfZyZFspesrKEn8vQU3tLLrTX?=
 =?us-ascii?Q?/6L4qXF4ViaYyN9gyxzf3g+nFAd/HOnjNaMW1plvj3DE/Bdy14wN3ipEB0TO?=
 =?us-ascii?Q?wmiplqmODm2c5D9RFbmQpg/TBao1I38LXoZp2cNjO+64yoKJXucRtiyc2Eyl?=
 =?us-ascii?Q?HF+pQgTBjw5fjaxxKPYU5da2vPB3nfAY+NU3i6B3dd0Sq6tF2SPa3gwJZWX1?=
 =?us-ascii?Q?YngfmUZCa6oCOEBqzeMIxRbZMjf9/ALJZxFvs3yJjzKlURcKrFxIGsfZFteQ?=
 =?us-ascii?Q?7MMOfcFnyicQxbv3oWYeO1M7CPrtn/zyY3CdDTwSjcRQIyDrG2GBCoolq0o2?=
 =?us-ascii?Q?6/t9mOsUAFVfaZCkLExiwogMliYT8z9SULB5+2b55s0f8qY7CGHlmLUiBJ2/?=
 =?us-ascii?Q?n4ZSG/LngljXJh8wvuTXISnoEpzm5UEye1LG1VcwwsU8WLCieFPv7fCOOLih?=
 =?us-ascii?Q?CNCxF3600gZ6IFnlXilppPzXKaRENgXlERP2MWrWD3Y7y3mCG6/y2WqLBVkv?=
 =?us-ascii?Q?r+WSF6zLJ2m6iKQrbmRMhQ6It+9zzCqgjI5MyHNNai+phoQFlrTKGJw4AQ8H?=
 =?us-ascii?Q?ybTdcnkuBwMp/7JXqrvMuOjfed8ZgwG+5IY+wzZaNaiPPTpNA5x3SI0c+olU?=
 =?us-ascii?Q?bFKtKMqsM9GZfLIebqqN07acOiKsivxy/Q498QbKeIKzu1llZ47ZjSkPh3gc?=
 =?us-ascii?Q?Z66/MkPgnxWl0ePpXrKlmyTBYED9Qd+FXR7v5rqjoMeb7EDpc4VlKSOD2CEG?=
 =?us-ascii?Q?fb9vdS4+Jrhd7K6sp7za0DEsHSNQ7Uyu96ru73oXuo91aP07XO7N2BcwLubY?=
 =?us-ascii?Q?A+I59+AXRaI88ZSz+NzfXH3OFICRfggTOOYHMUcOtZQJqYVQzc4GgrTOnjqj?=
 =?us-ascii?Q?S5560PBrVcXSK70VhS64dIFKJMKN7Q0L8G6cRaumN8mlJh8/Raqy8IXkOdzS?=
 =?us-ascii?Q?5uel2KyOIYx71Xa+oJjizobp963M9wOrkfiUAty8jzSzlWeBAvRM92xGTsmS?=
 =?us-ascii?Q?W4NKs8OFCiB7Tp7tIQFvA0XL5bJrO2T/pKqKp3jIfyoYAOvFuPMhVd1+jcVt?=
 =?us-ascii?Q?Q+pimh+Mu5Yor+9ezIJK/jsjdntoeSC5bJy4G1G6dOZS7/cmlV/4zulVzP6o?=
 =?us-ascii?Q?CVsIFFIvx4UXKtKIFiFR1Bc2pSix3FAUv77TvahTF6gDHeqdW2IN8v4yPsrC?=
 =?us-ascii?Q?sikD+uwjl7aUo3Iptn/Zfr0xR1VQb1SvNl6X70GVKZF/Xmz3vQON58RfoVat?=
 =?us-ascii?Q?e/7gfcBEpeX9+uMnjwmT/UKE9iRIE2ob6yGlUL3Ts58ZwSz+hC49sTdhqpAm?=
 =?us-ascii?Q?qWRWU2l5tQTd8JnH7IhKnIeW3ABLQuzVZQRwMSKeaT3fJeaiW3SOumzONFgf?=
 =?us-ascii?Q?Xcyt72A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:50:22.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bae36e-6cad-4b18-bb09-08dc707206b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

Enable ISP for ISP V4.1.0 and V4.1.1 in amdgpu_discovery.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6586feab8c2c..82d064adaa49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -107,6 +107,7 @@
 #include "jpeg_v5_0_0.h"
 
 #include "amdgpu_vpe.h"
+#include "amdgpu_isp.h"
 
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
@@ -682,6 +683,10 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 			adev->sdma.sdma_mask &=
 				~(1U << harvest_info->list[i].number_instance);
 			break;
+		case ISP_HWID:
+			adev->isp.harvest_config |=
+				~(1U << harvest_info->list[i].number_instance);
+			break;
 		default:
 			break;
 		}
@@ -2303,6 +2308,20 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+		amdgpu_device_ip_block_add(adev, &isp_ip_block);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -2829,6 +2848,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_discovery_set_isp_ip_blocks(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
-- 
2.34.1

