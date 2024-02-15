Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA413C48BF2
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C8510E4CF;
	Thu, 15 Feb 2024 20:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2uuoCBi5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65E610E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REiPf6PjD3YK/560hwIZs9cCK21snCRSViAe4mjpLxzOknUgmw1x7/oIGgOq3FKBBhVKfNC4phMiufdx9dOtbawfF/+2plSJBfdSzw9zBWoFHJ4IcuY65bnuXdHB+6pBxV+S6NJCxlRB/D8ReiLjKztIDMAJK9aPB3RaknM9ClQ3s+/GTzLpmS96vDetDqBVuhgwGALPsqi7y8j5En23V2Pk96dtbl0EolntnkWgmrT6whF+WLMXnC/IdweA68JxJT+2V20kbthg8G9OnRthc5ELIykYO3BfcpoTIxxcUzDNigTRM2uUljtMy9vs/sL8K43XVktmmAXlQL1te5cXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fikwYkN1V0vm+3g9/KFQKyESpzlAcuA7cs0cd7jMhAE=;
 b=jpowaUq2jTfTUJ997Mei/ZymvZLVGCUb1hxf5Ga6mGN9LcD+rFErt9yscDT/aEwxSQLQAhoSIpJ9/7UGqWF/JYOWyGjZvQdbm0V9YwvuvPsXhJpOQLsH0Falgna9yTdP0DysnENzvtxMFjKyIY9O2b5B4eVGIZvbzJaz8aVcHgLWVda/9cUVWLXkyT3OkphB1u7bDSwbxWPr7UOhnmC1f+nNbkRSfSOh2Z+TVYB6NctpO1Q00xHv/pe2E75Naqkn5uJzwMktFfvbSbimVqX+zzZf/B+MC0E6+vOE/asszXURSExguTwoWufuwfLDbEicmJFATUMWOem53Fi/hCROOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fikwYkN1V0vm+3g9/KFQKyESpzlAcuA7cs0cd7jMhAE=;
 b=2uuoCBi5uqUTHWM47lwE621SHPlvRX6L1jAiqGTI0lwZlK/GxlH5tGBldZC96ZSVK+Xl8V2+j7DPviocexg0ftmulloGdkACCmhQbjkG6LFzRrOOQFxDygW/HYo2n0fYT+0+3Ll72YHCzL1k/WAJHDteqH5hsthsZjacpOR1T9E=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Thu, 15 Feb 2024 20:40:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::fe) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: add mes firmware support for GC 11.5.1
Date: Thu, 15 Feb 2024 15:39:50 -0500
Message-ID: <20240215203955.415314-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 01684410-85b4-4b69-685c-08dc2e665451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fucz20b7A6SfbT03EkAeyiV15wZicy2a79QghH4P62/1Nu2o+NRC6wRVxiwKdMBnJAM9LsWv6ZlKelBSfvXB7QSQLBS3OEeLTZtWRYGHo5JtY5eIlE44L03ohrKuHF4nQnEk8dmEMcCuWBtQRgbL/ibvz/Vvw4kNgHmT8TZoxLclOSVlDp0V6JY3Ut6551SxI7s1E2B/cqwppJ+VBxQx88MgQN+Bh5rTHwGSKOGo0Peqhbv1rUYCbQsVp/HdwtrWdyOdhK3An3Uf+9kyygnDkPydiV0oXGR+lNt7M/LW4LC0W6cEdCQQIWPH2iW6N3IWAhsIaV01gdoxA6/eemTyi0uZ8cmtCxLA8CuHoW6Mp0fncwxVNN6cRtFYlh7mY3EAPkMZEgnXjSTsU2KNDEHKsIukjHpE3a/CPzpOBAJhlp0rH87HdnK5qhzvhrf+91UAJ54LdOJ6u6mH+dVGE/m0tDZh4/Pb1Qe9QW/3eb788FwwcruB5St7HIviQZGGoWFTTF+kWtQQ16+VrnbGxCpcgopZDE/6rfYs6kfJcN3x3s5JI1sE/8zXutMBJHK1Fr/10DoyJqlxI6k8lmQ4SauNToUJwurdhbZFBg0oge8DNXjDUAnPAbIEY4X2m9e99o6ofiOP+Uokz0UItEvf1Wfg71G6WevHGOR7NV260r7amFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(36860700004)(64100799003)(46966006)(40470700004)(6666004)(316002)(54906003)(4744005)(5660300002)(2906002)(70206006)(70586007)(8936002)(86362001)(8676002)(4326008)(16526019)(6916009)(478600001)(36756003)(41300700001)(1076003)(2616005)(26005)(356005)(82740400003)(426003)(336012)(7696005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:21.4054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01684410-85b4-4b69-685c-08dc2e665451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add MES PIPE0 and PIPE1 firmware support for gc_11_5_1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..b127ddf1c807 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -49,6 +49,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes1.bin");
 
 
 static int mes_v11_0_hw_fini(void *handle);
-- 
2.42.0

