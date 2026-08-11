Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444ACC5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 19:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBD610ED85;
	Tue, 11 Aug 2026 19:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOy59bm1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C45110ED87
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 19:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8N0ik+QUGw9MmI/ewhUCKYZQwKSh14fxR4amvFT/P6Pt2NZ+KzRIhVRK0E1OaYpYSBpknQWMXjL/LxaGx52rjQbui72cBRg1e4py9/byEM0N91woktwmSzgiLeGEzQ9IS8bGPtZKplc4E2LJ3Df2RNlYkyJQ8V7rJQ07+5XTYXZkmMyMy5GJSvv8AfLwDJI9nuQaj2jANaancGDGH/zCuh0laVjWwvaxU5tBvp96Cv+g7wlvOCkuCv5ULuNP6tUy5yeUqWet6cqqoBvzKFs213qtugHTz3SnbIrz/Rj6RCGBY0WhSSJVOJ2si649PtoB0gMMQLWe49VRxJufcPyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjuo44GGqwyzCokE2znRsdgw7ijwo8pHcJ22ok9qJuM=;
 b=R8RbMilyA37bu41Sprh27oK6dFYBhmz3r5gP6rBO0MWcMHeLRHdyk7sOha/RlgdtodqgaVOL9rXCI/ka/v2E2sj4SyKvhZRMTow8K8kARIHfLnX2usFL6DWqw14p+ax8mkVeE68mCEZvt57u2QXDKxLE6DiqwXpnab8v+c8hlAO5Rg1hyScnbtDKNadEQb3eQIZCwu2ulDicWA3t1U2bzP78r0YbTWQ4ZhYA+Qvna39DfQ8UvPr+dGr3iF6lYs80IDHraA23VJTaJYFG47iTyh8ra89cQDDatofUDZ6wEg59djho9W0bDinonK1cDU/noiCxaVsr91Fgu4PD81fOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjuo44GGqwyzCokE2znRsdgw7ijwo8pHcJ22ok9qJuM=;
 b=JOy59bm1Cl6WuaERjg4i2qn3ZG2B7t5T+5g2DSLqu5cEsbhltEN5oPSnnBT8E4OlQ9WMok4lAEwkuKIlK36aP631J68aL3/V5XEhCK1sK4S9l6JO91O2/tYiaXODzwb99tjp5/L8d5Rg+fpgeXooLr9Wh8f4Hbfkk9j6j4tPlpM=
Received: from PH2PEPF00003858.namprd17.prod.outlook.com (2603:10b6:518:1::7a)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 19:54:34 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2a01:111:f403:f90f::5) by PH2PEPF00003858.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 19:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 19:54:33 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:54:31 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Set queue reset method for GC 12.1
Date: Tue, 11 Aug 2026 15:54:08 -0400
Message-ID: <20260811195408.1000488-2-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811195408.1000488-1-amber.lin@amd.com>
References: <20260811195408.1000488-1-amber.lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2b6e82-c9e5-42dd-9680-08def7e25d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gsB8n/ZNm6Y18q+Y0dWkaUZw+/pXBbIWNloA6o1ok3HOFmaoJh9nqkNgTINHHk5O3ThxRwkmufxmLINkqBSmzfJWx0TfC609UF/Q+590cCu027Ooo3WrBnaKaiPaojTah5yLndQr0DJIVXeJ1IItwtJmG3xzscBMpCFc0d4ZszA0dI07chmMb6OIgHIVPKvyuMIiWB5rNX2vueYeFDwrAb/bxxMwEaDD5NCLLZ3tl5QRK5Kq49nMWol32txk2EVjJgZiJU6Of5MvQUA5a7dlIXBI6ESmvRe1qIL1UAX8waw3RncypUggPhxUvlG1KUyhCTXN00DkquayVGvxH1uun4EVZhhQBDzvrZ8Yo5H7MBnY2hoJtPhPlLr2jBA1j9koZKdxttfHpZFX50e6TGnAHh5Dte6+4+mNK/V2r0N5Vt7DzTIciPB1JHR3whK5ZCn1oh17x1wnueu6ngl9kVAUcXy3iu6WnR9MYlBhD2CF36K4T7L5mWrzSpt3WnRwhfExHxlwdi3NRwqICGvN7M18qi7NBiZO3/2r3B+10mxxcihwfqCYAojIulepiH8xNEcWWyxGfzKb2ViSRHlHt+L6+MzHaR6YBYE//piDjLRfq/TZtCOyr1zZN8ehBmTLj7LOCqfacXr/rbXV/aWbvRq1DaSGL1oBYMT5Ik6XAEZ8t2wbrdXfHWTKd2c9uRM49Fd6geF0cnFYlemDFNfKQscM/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJHiJlZDlW3iYSgdeq/hBUYCjfVH6u7KHROat50K3Excc9scXO9gwZoe5zhOc6058FgrXmSDleJME/TDKVSypIxt7VvU7E/TuU2ZlIDKCSEN5ceE4MEGoh4F6e/0t0XPXQ5f1ZcY/PtpvZHW1hZdSr7jBN1e4KcsWxEacbkF/PZCkFRfljrBFI+ht/tAuA8geHH0IPL7sw0QBbJFcsyGccZ5CFe9f8EIgMPXCllxAN65etcvShEGpIbkTKoaMlyO4rJt8pJWxJMmXLP5zehum8lJc4qqhS3vhL31wNwDN56h3QKDNGUaH4C14fBVGB+ZMRKj4RpSvt9PHAxmuz8xivohxfbYYpEj3sCIprQ067yKZqqCh31LlLOoECiRZ/fBLQjlqLWmgAQU0QNdUNVB24tVhK24cyaJKfXLQKZR2+3rtnlJvsPnlndnox/qjx+0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:54:33.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2b6e82-c9e5-42dd-9680-08def7e25d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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

EXplicitely setting use_mmio_for_reset = false in gfx_v12_1_sw_init for
using MES to perform queue/pipe reset

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index e49d8a79045c..6635fa9eaae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1560,6 +1560,9 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_1_alloc_ip_dump(adev);
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = false;
+
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
 	return 0;
-- 
2.43.0

