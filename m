Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C638C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 00:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC2010F0E9;
	Fri, 29 Apr 2022 00:29:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A3D10F0E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 00:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vup3c0UifTDw9LktxrJ4MH0Y+TZ7rlp9gOfyHja2DJcf7DM1SsxXJBmnItVaP3CvjzOCBuPRyzjZjPiSLq0dZX1PY08yG52LPULLD2PLaZgL3AQ48oSH8pQO00a1Hq9wFQRhQdcwednZfh/bRXZOjDAqy+cn6fWfh+Nf2C/2w5Pt1LRGXSXVIhJRRueAq0TfbEZMe96jA57dEKV7h/9NQvp05TzmuQzCpOt8AFmKPPr8YwJMyCqobpuategEEcUj0EdTtv88uI/mzGpz1IDnVrbXut0h7S2n3eTb8bgDuvif5loa3q47F3khP/faagAENP6WeY/YzXE8Uo1oVWDGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kww7qTk1sZQLfJFXEX9TwmHY1cKnqwwvS2uvc7Y+yek=;
 b=aYtQXI02tjrwfppe8Y+1QfQzaqnu8qTOTsQzxlXRyb1BGWd/nU+CDyNbdso3MD3XvUEowEc80xazx1IEuak6PUbNtsrnBEHFuvuEy/QjaLXAsimwNsjEI2cY+WnLdUhm+SOdSQY/mmY1Nr4D72FMSfUm7DMo4u8a40EFqAdR69jYWydKgU1bEWJUr7HkptB6Nesc8kpOf9MRLsnRnCYWm4XIOmReVGEa0BikJ8+MwcbU6z92PWRg/cZE6uEDeQfR68JR6SgW1lxYYybr9zenh7XeQMV//ynVz2Ql4fhFI1wThTP8lFGxgtDG0B6i1S53j53XWRGFAjcghMtMLbu8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kww7qTk1sZQLfJFXEX9TwmHY1cKnqwwvS2uvc7Y+yek=;
 b=vUtShuazxGOPcKL2vRHXRlE+WqVRCL1qQsyUFrxZqcNryZr6vJfXVne2/T8GRJOdaBTHcaB+KvoxJF/LbOuXFoJ6hR8ItNCx0EbAumzIXTQs1WSGFp2CEKBiBvRU+tqyf/AJLVBsEh6/hqMgpi0YskM8qrXEL64G3X1TG/0McDU=
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 00:29:47 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::b7) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 00:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 00:29:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 19:29:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Free user pages if kvmalloc_array fails
Date: Thu, 28 Apr 2022 20:29:11 -0400
Message-ID: <20220429002911.8207-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4947416-0ceb-4f39-5572-08da29775d85
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534D70FD083DE9A2E31BD29E6FC9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnIj3B9T/23GOjmqyrwqmSlMZeMKa7Zxb5GUyHS6/WG4CPJsTqGTtUKrEKMMF7BiHMBDxv124r2Y7LNvY9t0xVpa6WKGmGCZJVn3kTffxyTYyyV2OXEkXWWFxnj5JJ7sQitQ6IHc+hd+Gz0q4LgM0sSZzevVwsYrrwZuLwpeCnfrb4aZtxNJ7qacp1AS+5YiDMSPbyzciqne4BV78B9y3u/UsiPLWuF9cglVhIIHJt1vwmRTm/c0zDfNGHzdqMj/bufXvz6+uObtTuhGX3PTHo1AISWeTbJ21cEM8hvcc9BpXQJZ/3s4TVDNxsc4AoR6di82P10uOtCnryjnSoqRKX44BFhaTrT5Nq6UeeGyBkUTEPHmcFjJ79BjsrOiGbkzTwBaLu8sS2dYWD/vTEb+t1rqXpZFKhcBt4k5fPFzvhvLIgBHckQqNCOD2s4e0e4oOtJCKkM2uk530uqyP0KW0E4a2uCbH39fOc3vZfjjfukyTwlYzHBaQuMziXGRPlnkuc3YP0z1E6G2yRUXaLpgT7193qnzVepUdVawAhwmiI8NmvJt/3GdLh8Ao6uG97+vJuUGwu2lpUj655W5kvCdNPzSlo0ei5SUMrLiia+N4BDhVxYVlEb895SsfFp7SZWeWbWm4dPBW2bd7HZOnpiQ0135GCPCA9uEtdOgkjjacFLQKJNPchwxFz/VpGHXY8zDlrRMrGkC5HzMW3r2WgY1Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(356005)(82310400005)(36860700001)(2906002)(336012)(47076005)(426003)(83380400001)(316002)(4326008)(70586007)(508600001)(70206006)(8676002)(36756003)(16526019)(7696005)(186003)(2616005)(26005)(86362001)(6666004)(4744005)(1076003)(40460700003)(5660300002)(81166007)(8936002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 00:29:28.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4947416-0ceb-4f39-5572-08da29775d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: ckoenig.leichtzumerken@gmail.com, Felix.Kuehling@amd.com,
 Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To cleanup the BOs of bo_list which have got user pages.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 44dcbef80229..ccde951244f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -543,7 +543,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 					GFP_KERNEL | __GFP_ZERO);
 		if (!e->user_pages) {
 			DRM_ERROR("kvmalloc_array failure\n");
-			return -ENOMEM;
+			r = -ENOMEM;
+			goto out_free_user_pages;
 		}
 
 		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);
-- 
2.35.1

