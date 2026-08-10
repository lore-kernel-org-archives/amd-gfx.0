Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1068AC5AE5D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B1D10E5E3;
	Mon, 10 Aug 2026 03:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KAqJ1fZH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FCD10E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4+28+DF58dxsnWKbymEiRIwaeszt0I4ucmIOLXZci7P7loZj+gTO6Md0DUlltxTHJ5XdtJKdGBOnGCD7UXMXVwG56byhtj1+wFFR5Xis2TLv4yyk2/gEvAhWmaC3/QIBRTUlX3lXpiCcKMeeff4YRUzYT90qgaRnLYfbhREhxac0bmSeGpZ9XZKW6zHrthk7C60QZCjoEhmKmkYL+lqSIi2R/OI4ucqhpbNb+4GN59pfRGdpEDbZY/bd98+3XyN3AES3zFoTosFXt8/8pny7DmNDDl9rbbFnJ3D5RcVok9i7fFpmj1WoZLOJ+lzYByw0jScI2fgQd0bPSL0afIvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFk+OoJhnXj4iuhpta0M/9Zxpfa+UzprGzwUA57mh9o=;
 b=UlNAVsfqSwi1MSVYK3frxOR8KxH3QrarIv4gB6Wb+wR4QbdQ4Lj0UM1xS+dT225QZdtbaQgIiudbA9od9LkfvphIbT2GFhLr1ZfCT0zyn+sVG9d2g3Xoj42XocNDNc+gFa6AvViJv9oWGRsDjEKy5M1YHbYNRwe/bnmuIWPGJ8H7psVsu4pYO3Y6Ii+HwvqJ61EpG2j+CspElZrzn3i86Ga6k3wP92V3a/Tn3klOM5YbBCcScyVw2dNnOX7tNIuG/85x5zu6wqXTBRqtguUKb2mDcU9Vl38cCyvLBbhsWoTGZILsIxYS/vB1DFHwk7uSF7JclDXzcYyJwZqoUuZtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFk+OoJhnXj4iuhpta0M/9Zxpfa+UzprGzwUA57mh9o=;
 b=KAqJ1fZHO8sLn9u1Vo+Z6Q0j4HgIM9JMOAcOZfBpX+TeqqDMEIHlygnqILn04YT+tfFjMYdEfDYml393GuXoZ09A0GUZ+fadoZ92C92bWXypV/RCcvuDxJjl/66izaYOKxv0/X0SDoNIPiQa9iCZHDjafBgVjVSF0ebhbwnqTWE=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:13 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::a9) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:13 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:10 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: JPEG 5_0_2 enable multi-instance
Date: Sun, 9 Aug 2026 23:36:44 -0400
Message-ID: <20260810033644.118194-13-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 96867f7b-33ed-4365-2e7a-08def6913a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rDbCKN9G721WIGO1ZnqYbmWaUzt8mcKiKh5n17/ZqhKGrBZ7MDzKUA1IKOk0uE3yGHtff8ly6aIdEQPKklYVPr4QQW4HKVcaAR4KxL0T1DbmCKtFm2hju4xaQzJsBkgZ7FV5m/E+GjoUj/psCRiW9ONVRzFcvMtfO+0zBsBIArIO6x93rFVOkfUcEL8NIB0P6GY1+I375X1wroLGGoFHPBvVJgwMaAw1ANyVE50TduzNd6Si/sQ02nyQOfeeT9FbkZ/+QL4eANEO828PgsR2LhVQca+o8FADuh/zwA0WJAnET2/7B+1XkVTmJ90M/WD3c2f98tvgAdPMjfuMa3oxMP1cl9UbLJZhWNOaDBa6GcpJ32u6tag6CgmawASviZNJimdoKzsMjfSZIKps/en4RHHkit1giDrDzvkZIfiQKjA0mT39hITOp0JY3u4Ao4VHEFZOFWiKWz7emH9/FGNLkD0pikaKI+czF9kz+w4FxJ9PrOjCL+jcuRFCqstkNFpQMxRjAcUCVJh5Xx1IARcValDsCLdrInFa1t8YmcamO17UCO4ie/vsGe/XVGwHZexXUtvZDDHGvn4LqUlR702xOtzKkEg9b/Cvhj1aAHe1QtNwsGWC7nB3Uop5XUPG5stpfuAWHBxGh7fzu9FUeizyMEVtvXWLO8OWwYJFLaXUTcAtOtV8j5eZrTzBHTcXtAQ2ej65ypP0uj7kIg/tamChOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eZ1unkYJ6bt7yb2wSTIWGUMfP29PUtxyGd6C/Y9NreWTwXgH0zrljTNZUcU+WG07VTcGfIkmWaNO8id4sveCTgcu29PhZu3ArqDURui1mnVVBRyhJ2IbezOr5jsN+KIUcJDMi+qnNOO+mTthX2v5vH8+7FFlpxR/KNCV5wfSx2mKdsNeIqmQNtGzclL+6tzVQE9k2Kak44Cepc8p5JzhUwy+4n3F+y15Yjna73QYaPPuYJ4KXJboR0wIvAqUpOVTp3KsdkVdM24OwvdQHy/6GuKrU8tS4kT7el5uvqqy+3d/MdMovejrasmg81YHWYW9FLX25tGXwNfwuR6uswfMebpMroXW+IsRnmEo5zgqGjTAuhuJ4bJOQRzuHXjz+7wrdnPP7wFx/XZNV2OTPiMzyBFSWaWcv5z+jCdyOCapZUw7HccGpC3Mh5vf/tJFJeoS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:13.6596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96867f7b-33ed-4365-2e7a-08def6913a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable JPEG 5_0_2 multi-instance.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 7531890ec005..7322526a09ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -855,7 +855,6 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 
 	adev->jpeg.harvest_config = 0;
 	adev->jpeg.num_inst_per_aid = 2;
-	adev->jpeg.inst_mask = 1;
 	adev->jpeg.num_jpeg_inst = hweight32(adev->jpeg.inst_mask);
 
 	ret = soc_v1_0_xcp_mgr_init(adev);
-- 
2.43.0

