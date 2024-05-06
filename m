Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F4AC25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 09:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6856A10EBC8;
	Mon,  6 May 2024 09:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AO10AWJy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF87D10EA13
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 09:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S28hCEidooIqOZbdrnoN2JDfh3PX8f+4BSfFRtOZV5tA+zjVQ3e3Py7yBzFtC5b32GFoMA0p3Squ2bnFPPgl9NBNQtHlUBPGshrU8A4DIsw24+L9ZUh75Lj+ZS5HuR9wV4kUvhjbeJcV9IhAgMfIDN4Wstpbh63JWpz7g5+s8lDoUk3SiL7E5eqn7gfLqblTSmgGViAS9M5s+RN4q953SHq4W3pdM3JWo0WIslJHupT8rSEOg1GW3nFXhQPr5E8U3GnHZ2you2dHVLhFXveZTQRL67q8+BXHbMpSSJkyNNwtmuFWr0XD2bV6YEcwNyIoo1YeWwsBICAWfZQOW72cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/2p5pm+fwsdwKy/4p4lb2ZzS1JAImOL3/7LDSYOqiM=;
 b=Jo7juIX1kHMnfsATK8VYLGELEBy67PToze6rWaKC89xZ6Pc18Fd8qrLLrafMzKYKwLWERTZ0kmPM9GzY0etsd4pmufugvcC/IDYR37ugwqoysPnt2fmOQOH2jXpXXCKqLSu8ykQqRdPd+evOg4oYzplQYVm34LUmRfuOnuesfI4ilxLFvDsb418WJqLi3qiv0zZDIn+BbggxOboFZ/UPDOdhcLr14a7es9iO/KED1b9MO4sNQVvcWFnpvMY2Yi6HcxW8lKeMEStSnd2HaWIGyEFiYdtixlO6dqn4D2qs/CqKBexCwNU9bp+Mwb+y03EOTAp5mke+gowIxD1sjsWWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/2p5pm+fwsdwKy/4p4lb2ZzS1JAImOL3/7LDSYOqiM=;
 b=AO10AWJy4aPfnKEzL13GNG1HnpCWe2xl0xlgaSxIAlhkA1LcLW9gu5OU+jSTRLQKZf2FI94Lm4zoTUM6kD7ObxS/Uau2paOj2EQjdTCR0+UnXRIMFGwsDeSRVrXMgdzksRg8ZgtwZm9MtHUpwu/2Fr8U43oqR3idbgG/I2EHHvA=
Received: from SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::15)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 09:57:05 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::98) by SA1P222CA0132.outlook.office365.com
 (2603:10b6:806:3c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 09:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 09:57:05 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 04:57:01 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_info_ioctl
Date: Mon, 6 May 2024 17:56:29 +0800
Message-ID: <20240506095630.258594-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 031d8696-ca8a-4c1b-a6bd-08dc6db2e284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4M/OiZdxuwsmEqWbWlKvUBsFE+TC977ygdTKM/8gPS+oaujQRdPS0ZQxXJGE?=
 =?us-ascii?Q?mfUZXeH2jG39nxWhKzZ5gIoZNJ0qmrUulyEPYu11V4OJJJHi7IqkQs3iCU03?=
 =?us-ascii?Q?+UuFPIWphGhbCpCuVKxi5gso5Z9C00470F5fKDrGe8gVv5486Je7s3pTHlqy?=
 =?us-ascii?Q?0yVu1nuTbmjkXpymyfbVDg2CCLAQRgpv7M/7BkJZoIamXJAEAZBZC9h5xzfp?=
 =?us-ascii?Q?4tuKVEvaivmRhFfbhmyh3hcEcDPx3B1KE/yS5t00ydSLQa4+mtOXOLXwMm/t?=
 =?us-ascii?Q?aCrauBwfJEvwzTJoobLc2ZRHvj3k0YWF4KFgabkwvCVbRfge0bYVnBGUxx0O?=
 =?us-ascii?Q?XyagCtKXWaPOVNscXAd9c1vRt4AbSUNz0JHqiypufRIG3BoVcXayKbLKvG9B?=
 =?us-ascii?Q?hin8SMa4GceLMYnM6oAlcOaEt5Nsfdf8NDynOPjlvG1g9npr8ZUie0dmSXid?=
 =?us-ascii?Q?a7iJbIZM4uG8b6b0+f4PrP3ja2dJtiYlBjmny836+3qUagfV9fttIDesU4AS?=
 =?us-ascii?Q?AN1/X3bVeAZedkSup5kjdXyNQ8lYE/FBnOl8GGh5cfbwoxYIl52JNjBINL25?=
 =?us-ascii?Q?l30RbzSUL++YVZ0608IqmCNnG09gYLQoqpkKgLQpd5mclqsWPRLoVX8tynOM?=
 =?us-ascii?Q?ISzfzQKPxEGavqriORaxD3QZrxmx4wDsoUwMtYDEUKSo2K6rPMKEVfJYKvxh?=
 =?us-ascii?Q?imuqdtXuG7jpwqFdg3VzT4HuBJ6TjhIgHIvMd9VlvfpG9jqEa1u2NP5Blqya?=
 =?us-ascii?Q?0+83i6ZGKiVSxgLZYJj3klROyUyI+SE6qTBCOqkN0B+hF4R80/tpLdtcXjp3?=
 =?us-ascii?Q?aNLL7+pXxt84Qo3ajMEWCTxlh5Sh8ocquCOFtm50skIcXZ0AmAP37KufNwub?=
 =?us-ascii?Q?Jzas4e70BonJqjoh1BOi3ObMuO7h+XfvqglZRo9t1gExUDxub5KkBs1tPibU?=
 =?us-ascii?Q?otzsU/4Ima8oZBuOcrRboX3IdWG9gDu4GVCYFFuAuH+kYstPLutL2HTvSvIV?=
 =?us-ascii?Q?pChQH6RXFEhxO0Lx7nzuAUV9sFL0qL1DTfsDO0ITuPn3gbX8jEpYuB9F8um+?=
 =?us-ascii?Q?ycpQL8rd0h3sfTv7O5MzlDfCQ/u4lH69ifDvXZjapbFdBqLhsk0RJgtX0vfi?=
 =?us-ascii?Q?dAq7AfS+DLySvXeSTjTGViGwg5VHlp61ziVEqjWIdM6r5EYmFunIYAIV2Ykw?=
 =?us-ascii?Q?0oKmx90xaQt5JE1WqYV08vbk6pGVE0iUJ+gCf0RCBtKNaH0ze0nLFPEsdmgi?=
 =?us-ascii?Q?9+4qdYzVqEkhYhMPqBuuEnANgajqMncWJKzRGfuNuA/+InA9GJ99D8RGXg+b?=
 =?us-ascii?Q?3zqqGTHQG/mxkesdAuCPUWwBjVWP2NePjZGxCuDkgFKq1A231M9Ij/qkdq2H?=
 =?us-ascii?Q?CzMyxSNLBqJ9wqdehgd4KoLiUxjb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:57:05.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d8696-ca8a-4c1b-a6bd-08dc6db2e284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

Check the return value of amdgpu_xcp_get_inst_details, otherwise we
may use an uninitialized variable inst_mask

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a0ea6fe8d060..977cde6d1362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -623,25 +623,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			switch (type) {
 			case AMD_IP_BLOCK_TYPE_GFX:
 				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+				if (ret)
+					return ret;
 				count = hweight32(inst_mask);
 				break;
 			case AMD_IP_BLOCK_TYPE_SDMA:
 				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
+				if (ret)
+					return ret;
 				count = hweight32(inst_mask);
 				break;
 			case AMD_IP_BLOCK_TYPE_JPEG:
 				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				if (ret)
+					return ret;
 				count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
 				break;
 			case AMD_IP_BLOCK_TYPE_VCN:
 				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				if (ret)
+					return ret;
 				count = hweight32(inst_mask);
 				break;
 			default:
 				return -EINVAL;
 			}
-			if (ret)
-				return ret;
+
 			return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 		}
 
-- 
2.34.1

