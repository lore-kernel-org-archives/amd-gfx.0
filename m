Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E168AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D62910EE80;
	Fri, 18 Feb 2022 16:59:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D9610EE4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6py46BNhq3/p3rP0/1zM0zLo5kun+lyukuZnffGfX/RLaQL1R1yKhnqKfcJyEGEh1LbzN41KNpaG5YunyprKlKobwx3deLJ9JGnfEg9hR/wN/Ejs3k4oOnbg87aiQCuj9wbuosVXjqmQ5xvvffevrY9F9k0t9P/8coMjCkB2a5hTxkvIJVux+cdqj2zTjD+mClTlHi6VLcyBAdwidcwgAv0UpU2ue11vZ7HGyg0MqBBjYJ2wVNUsGolJ2f123vgezwgc5XsStiFPW4coadSihZ17LsZ2w0ZbPKOahNMkV4FGk2tGX48+YOEKbgu1BewuNOT+kBhGY4Ds7458PYJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6V4UVasCsaBjfB3kcuQy57rbHhvcee7V29v7yDPRWA=;
 b=XS73faPQ3+uGomeiiKMBTPFwxUbgF1qvIyhwxIGrQpuuBXnNQVM8L4/obOrcka0VxyBVuYPfSsmHRExw/CkcWbZ1XB9yxiJ4WH7tSZd0CRJWlBaXnKMznqxBougiIMYDas3F5emUeRItLSvCvhvrmlhH/SmIrL6CiTm3Ep2X4auu60lMRX0zR6C0xj0k6fM7ws7tmWIpoqtSacAPme9PfTvb5TAiYW0RQoh+nUgsqLYNxukHeriIyggGlRJ4s2/hBn31KNONiV7rPi5DtdGGxEKfh/wdoZjBxtWeppJg3ic/EqdlxPngyARvumPKI3rf//txNzMknuSCKUKqsGRY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6V4UVasCsaBjfB3kcuQy57rbHhvcee7V29v7yDPRWA=;
 b=SJBohLLqPMwfTXAQ/xN6INkCHCPeWdBWHkzvAc9I/8AhdhcBfzjhsunlzx1DLXb3Q8B2vrffGDgT5x9gQ0CB9MpISFPWmeCS8FwV/ygeIVku4wm9GQdZczU2AsVoaVRldv3RBn2h3BQp7sRSJlFZhZyufXwCexJ6aGfeszYs6p8=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by MN2PR12MB4535.namprd12.prod.outlook.com (2603:10b6:208:267::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 16:59:15 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::f3) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Add DCN315 Command Table Helper
Date: Fri, 18 Feb 2022 11:58:50 -0500
Message-ID: <20220218165854.1417733-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1969053c-f362-4d25-3ac7-08d9f2fffe79
X-MS-TrafficTypeDiagnostic: MN2PR12MB4535:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4535BB41E755CD9F5EFB9E98F7379@MN2PR12MB4535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I29uJ17Gzf/O6G+wp3JALRWj3CXPFnHwunxUdAAWDQoRlu0hYw8ryaAvYGdKbnmq1sb2VUq2/cIbDkQP/N71VbdfFsj7TsFIgL/4jXFvzEcCbydYbRjf0jU7isR4rBVMYCNik5I22k63UcQm/W6pROWazdqG4XRZpaBZq7Wi4bfcyFfP77zM+yBAQhxAcalYsbU4t3QYIPvENBxkebsUtWLleFJM8ndZ5rUV+u70mB3iYw3QPb5FAoiiV7slAJ9DQ3Ccvs9P8fiN1saptXS0fYmySoEvUa28s8VW8ZOzLqrAzyv7zBLd09WracoGIofNcqP1xZs41VttVB7SJeam3GKKfDzyFcMbpGa25uHakaSkZm5FJ8AL9XK3KHKcmVCWlGCn/O17nA8miQ6BAuJBX6KfwErke4mB8E0GBn2pCxqp9vFNhzNgK0htonviwNtGSkrl3YYR9Ut+QnoF8ZmKnwsxJ0YYKYKGpo5ojYfcHUoD/BgM3ArX8+UxxR4awfjrOWGWq4I23YRzp7ramJbug6Wb5WcfXoGWUYckBgOhvxqPNZrf1UVc2AyE2/xBO0wBXicnvrz6Kd4jclWRcewa8ZQ5yWD31PVHAO8fo4ZQ56JS3gBYzk82h3SE9w2Wer5aMkWitO9r4uYz1UvwpvfQBTyzj3oB/kV76P8JT7nSHL6I8F0OI9zoeAj0UabG3VwxeLZjnZNAiuwaq7wmMCrskw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(26005)(5660300002)(186003)(36860700001)(47076005)(8936002)(2906002)(82310400004)(6666004)(16526019)(1076003)(426003)(336012)(4744005)(356005)(70206006)(4326008)(8676002)(508600001)(70586007)(81166007)(6916009)(54906003)(40460700003)(316002)(2616005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:14.7857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1969053c-f362-4d25-3ac7-08d9f2fffe79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4535
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Add vbios table support for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index d0fcfb158436..dd9704ef4ccc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -76,6 +76,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
 	case DCN_VERSION_3_1:
+	case DCN_VERSION_3_15:
 	case DCN_VERSION_3_16:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-- 
2.35.1

