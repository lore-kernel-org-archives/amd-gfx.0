Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE22CDB466
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7803210E564;
	Mon, 22 Jun 2026 08:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5RGGzpn5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D2F10E577
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn3kkXUmb6kt5naQDNTxV58DtE4x5gvlmC5T1lll+uSIWDIsuqbIRAt9Hqa3BQItkavO0kZQo/FQdWUogO8Xy+MJV3hTHeQumdavWCUsHZY4Xp7ns53IZU/e58gX1J+1djJvmpfDDhYYZk3pv4Rbxqj/qlWEFTYG7gjQoFpnqJq4MG7n+DRWG0MRr8GXOpAI0zV6g63RCgzdENng00SK8x0m8mo+AtEF594HrcPRpvNTy5+7SMzJwCh1NSLbLO3HMOVC6j1Q1vtVkkV3nRLdWDjkXurZvM8wbIHuJI1RC6ytx53iQlBES1XfdVSfkT7+/tH3k8W9UFdeaGeY6Vt0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naNDdB/+/wf5P/vcSMCIvfWR8+vDbh4hhOC7FFT63LE=;
 b=bIX0w1S09X5uwTK7uuTKnF65L6aOok/aGMpCkWbnFGy6wKlZlXnlsbFqZVncnjAAKtEFv47DBW4Uk/hHA881+aitLmEH7DN1mbts7d7VuaAzlcg7zZvfFI5pyEEhhU6paoa3AgxYkta6jXw78/l5OGs5tcz01NiAnSag5M0Vz3N04zeK4aIN9zq4WbqcwRJurQy4M8dlsS3gnfEcFTHnbRkuUeWw7LuJBTV+DIW/IEavJT+wl6VsKEs5oy+GMkwubt2+Xi3VxMUlkTtVIGaHvQN6TNLBfrJ++ilh7DVdDmPjysCC9jc9dSITHSdMwU1YHOr6wq8RmVkXXYNPA3Jukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naNDdB/+/wf5P/vcSMCIvfWR8+vDbh4hhOC7FFT63LE=;
 b=5RGGzpn5HCGG7adbfIaw9ULO+2eTNRrXx0B4AQ+Y/Dak0ngb2PZ0nHzXUzKUvMMAlA1IFOT9JRJr2MxhG1p9y9VHkhMndn+v1ccBotdU1PTulBXO+3dvhyxBAGRMZavlKD+b7aers8JRT+GyAstWq4x1yNuKCjEWBVBcwjcg2kU=
Received: from CY5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:930:10::11)
 by DS4PR12MB9706.namprd12.prod.outlook.com (2603:10b6:8:277::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:45:57 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::98) by CY5PR16CA0019.outlook.office365.com
 (2603:10b6:930:10::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:57 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:54 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 24/48] drm/amdgpu: add the macro definition of
 UMC_V12_0_PER_CHANNEL_OFFSET
Date: Mon, 22 Jun 2026 16:44:26 +0800
Message-ID: <d3ae8da226d20a095987a26c26ee918cb1923a76.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS4PR12MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 182c27c2-8f80-437a-df2f-08ded03aad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Hs1nchE1acT11WFoC0v2HW03rJ43Yn7LdbdQjanT0Zabxilsviarf6WpXjmc5gC0hPbs4cOUSqgjXvDdjA0dVzvM8s9bpc5IkNgqVsBEj+Z23gSqTS23GfoHwV7EcFaGzwSyr2G1oGnGIjRZKvos2AhQR5kQ5EGO4j1uNqYtf1qu7lzaRjBJpA7ilEMWzzPpv/jwvMSlDxvYKotFmAKDMRRB4ZhxZa2a3RFSMetKMs1LDJ25qV/mgv/w9CyWrHwQoiQz1yzjdkqKzKnQSzW/IWK+rJ5Y3knZljxa/7qlvlYHEaAzP6rmirM/vM0N1BeZceMsFpj5Ff9HruQTuWb2asvuKD8/gGmwtNqge4Z3C9GodbWysMPHutxcLLZi48you70OJEWL+u7duij1wC/CJwcDWMXkgpUzI25RAsw4uDSo8lck8+/IL2XTyagG4SYSDXk14Ygg1drYO9YlVLx1NjMsLaV6WjOr9Oq0N39dn8Pkzw2MBoY24hanAjEaQuEvdjU0iJLuR9AOyUVjv8gKSGrxaT8YwZF8f+UyI49GN84XGi8G62ag8Ppms21F3MXt+7TaTuLZFfIAu7XkdPe6lZQrlNWRIPdiKFmTN2tDi8OipyA7CwXN6BnmUBmiLZ7WWpYqn5qicdxHzQgg8R2QFbDswP7jo8G9AT8HWqykmW4pXhc5jx9kwmcSGyqK0bbYtYvHi/GHMb1knNUjf/h+OA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HhEtL7qOoyJfGgQ1JG3jhV+cL1sZGw9mD/B3Plhi8+Gd2fKrgf/ADvuJ/RVBsI3nUJG/GD8od3AvHzyTshwNhS6tKqt9KXZTNORCn9TG8+xMzHx9YdyXa/VALfuWxa45gzWvnZCZ8H6h+sNwR9UjfTlDU4HrDOM1TAcV93yDELlERruIfqFXFEPZDuKdERXLp4Qs6sWUmGMtvU89Dbz4TdlTM7AUGtXqrrjtcAWGoc4GVgtulMEM9hVUNnJH+dUBI0pV7ST093+XQaUyGnDon5mLB8bHr8D0F59mC7aVXVcj5do2qCpcMPlRyQYERgZ9ekAFD4p2X/bBIusSp+jGGOPpy92mVUBLVyqOkn7NMAzoODZXI5oniVBb72cW01hBB0RqST1p+jFP5+i8CSV44XA56jPg9pH33oljwK4xeTEHa6Xophk0lzA6+ieTcy68
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:57.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182c27c2-8f80-437a-df2f-08ded03aad9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9706
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

Add the macro definition of UMC_V12_0_PER_CHANNEL_OFFSET for subsequent
use.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
index 8a35ad856165..650b5f1f22f7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
@@ -290,6 +290,8 @@
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
 
+/* UMC register per channel offset */
+#define UMC_V12_0_PER_CHANNEL_OFFSET    0x400
 
 /* C2, C3, C4, R13, four MCA bits are looped in page retirement */
 #define UMC_V12_0_RETIRE_LOOP_BITS 4
-- 
2.34.1

