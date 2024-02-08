Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8571DC4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA95B10EC6A;
	Thu,  8 Feb 2024 20:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MVKVjP+v";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFB110EC6A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsMK06113xBrHppxd5qRMP/rMiqZCejLTwKx+bdod0Oo04AqZMlN9M0S1S/9WspvVi3YwRzcp8z6uqffUYsyP/WAlfpfVejHtTxzPlRZt3LseprXx+MTPeQCd3G+L54kE9PlYwSzHX+KGWjCvDDRnhU5pouRDzgZ6Fcxf6iFbBqoke0ICWQ4qDO6B4Tie+mjfUDYWWJ80/mdxDQRY/HNRXc9+Xi360EYAnrSal0gX8YfhZMN9w4tqGeicz/14piWIlEyxIbFHwZvAmo54ebp25B0H0CRnRR/r5RJd4I4oqJ1rXsA+CI2SWgfQaCzsxny3j68KvMKFDaSB7KFH3uFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GR4YeZppgr9X7YwcsKjj3pI4KxNUMJmU1cHSBzTRe0=;
 b=Rm077hySILZwT+3AhFVXXBUM/kMLPfauNkerXMq/S/2ZN21BNfR+WU0ZGkAoDBRHTpUCklhDQOaXeWrOaGEey9McGA/w/sPEMRBi8V0l8nfVNo9PQbvX8T5CLV92pidJZUgUj8+xhyGhSO0dwujMiC3hW2+TahJIfQZxp9qXEDXLuDjbPhpsFZpT4eTTNbSiHkgzCDCqouuTUBMXkaeHhYkJQUt/3qvlAJ9QwAyokJKqUm66+gVkc0oDuNoq6uPH0btmQ2VYHlYxFne4sGE3Y6+GSip8rMe1eKD4w9cqSbr3IS5/XdPsYF15hneLIOjVhVHWuAKVz0VUUnD4PTBaKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GR4YeZppgr9X7YwcsKjj3pI4KxNUMJmU1cHSBzTRe0=;
 b=MVKVjP+vYgx2G4gmig7RngDrngYvZyEcpLnmeaOQMRz8jUXu0wKqPaL2rdQV0uOoVBWMmPk+wXjyyLJZUGtYQ5e1nf6ba2jTf1a3eyZbMNq/CCvyFF9Fkq2NPm6dME07pGQFxGpPtrNzIPP0TNdg4DJE4XWReQhyIUNu1GA1N/U=
Received: from DS7PR03CA0141.namprd03.prod.outlook.com (2603:10b6:5:3b4::26)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 20:03:16 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::81) by DS7PR03CA0141.outlook.office365.com
 (2603:10b6:5:3b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 20:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:03:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 14:03:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Add jpeg_v5_0_0 ip block support
Date: Thu, 8 Feb 2024 15:02:53 -0500
Message-ID: <20240208200253.409130-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208200253.409130-1-alexander.deucher@amd.com>
References: <20240208200253.409130-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: a83089b1-231f-4d0f-5f9b-08dc28e0fcdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QblIFe8hpMxRqiyHSeafODUOsLHgs87P2YzoB9UxjIt5UVPYEw8vDBCBdeAbSSR3NIW3gPmHeemihtQyNPk1hfcF+0u6gvsN8hKfJgufr9bn/KqoLsJnUcab1PFuG9g1AS5eEnYC6cRRqr1rZOXvyR7whAqUw6T2v1jD5NkjNbE9wTzCJt8iMxmey3bMdHkNzMaa4eEHurKWbFVSnGTbuhldj5y+djlX2hVFCPkUZ8nEh/t9l7tDV1v6Jw2JhTbKGUNTZZWFGPyXwIy7tcXGZbngmoyQUuuvA8AGHeSazhGMQ5UIId/F2d7iqddYmxUdU0R/9gkGmVgTRs2CKEwKXRLk8sGI74hVG3OtnSL5I03Ia6UsfknEAjIRBS3f4ESMyAruDvRCEdtW0eOp+GHz9Mykldq4tszlqTp4fedpVU4Nnubifn7AMSqDBueQtgbNIx1885NZCymatf+Ne5xKtB0tPyCSO20aNeToJiOEsh+iVIzjc/lldd4JTJaAYLikqqiiS2/9tmvgaZSIqw197hEcLFFSaMf/E+jd+1ZXcN2jvxuCZSDskILGS++eIdbnfm3sZwY919DuW6gpDjts2S3toGCKEWxvUjYKtpl8JsU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(81166007)(356005)(86362001)(82740400003)(54906003)(478600001)(316002)(6916009)(26005)(6666004)(16526019)(2616005)(70206006)(336012)(1076003)(70586007)(7696005)(426003)(36756003)(5660300002)(41300700001)(8676002)(8936002)(4326008)(4744005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:03:15.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83089b1-231f-4d0f-5f9b-08dc28e0fcdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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

Enable support for jpeg_v5_0_0 ip  block.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 399428054c0d..2b6e0eb5aa3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -97,6 +97,7 @@
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 #include "vcn_v5_0_0.h"
+#include "jpeg_v5_0_0.h"
 
 #include "amdgpu_vpe.h"
 
@@ -2135,6 +2136,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(5, 0, 0):
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
-- 
2.42.0

