Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A59BCD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B944010E76D;
	Mon, 18 May 2026 09:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3eQU2sm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA44510E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 09:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6zsstvj8b4hCGgOLXTxztL8lx2iW6nTk3LhuBghmXllb6WeC3fEVGRznmGAnIOjrLNscTnFGSqjTt4iH1560g5aILLirWde1evXgAJuR4wo+U8oZGVgzvoAaZ11stxA3JD1icicqxBI4GCadzvG2WPoZM3X4znPMYtRz4f9HHpCzqEzp/iWaQDvXgK6qA19l85pQAkFZUyCh0AWKVa2s+R85yNRSrDkC5vhHcXpnShxOYJKMXCjlDBGFKJQBfwG/nuHgnFc6kxcsZDeBV6lD//7M/3iwi2npSwkxUAGMWG9q/Se4u/Inr0lV8qo7Mwg0XjveQfMFx+R1J7M05gscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzAWZD31jjKMKZPoEfjhAuiKwEVax6tnVf8hMlnOzOk=;
 b=ij19GZkEwTSmJm5aH4WnJAjb2lfJDRv7F4WdWb9wTXzg/YulPsqHGUNgMf6qGGezAAfNCl5LJ5oRvrskh301/EubgWANeNlbQ5TC87mQTMfa6i0PFJ06Kyg92LMxTj1hs8VpMEdeye3GzbN0CHrUHHs94KhvsUUcW9H1ZR9R0hUJXQHZ7hyogykNq34UXuiRI8bgXWaPqg0NE7Q+8TPshIq5AyRCadWqHUwQ2AuM2X3+UPOA5s6p8CdJEfiTHzcRzXAHcRQakNaBQa7TVMUIotgkRSJ/mDra1MvxhQu2tWrwi9tdgSqT26WUFi02de1C8i6hoKZAUeZrSKcPmxKL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzAWZD31jjKMKZPoEfjhAuiKwEVax6tnVf8hMlnOzOk=;
 b=q3eQU2smSwy/4v2fXn43HXfIga9103VILJDQPMnroXFNiguYH1/jGSDdcW9ofANaNYcuNVe08+O7daFZrzw7j6zAyr96KR+CmhpKuS5RM6H2D7Pt1OkfIB0nC7jv/ye86GZAu7AUb5I5PcMOZiN1SEpPFRF3NZTab8D1OxkcJLo=
Received: from BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) by DM4PR12MB6446.namprd12.prod.outlook.com
 (2603:10b6:8:be::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 09:41:44 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::85) by BL0PR1501CA0009.outlook.office365.com
 (2603:10b6:207:17::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 09:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:41:43 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 04:41:41 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: fix potential overflow in fs_info.debugfs_name
Date: Mon, 18 May 2026 17:40:17 +0800
Message-ID: <20260518094021.280968-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4e7536-9c84-4931-b855-08deb4c1abfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: lcS+QcyvGWmpyGN42LyLqaT33hUCjmVqdyZ9Zk1yGoxqNzw8znCaEeb52KHTYAF6LOJkJwubwFbYKkga/fITec57wYWysRGGOD1GwNaafzLvxbed5JB6lNSHhg/LU1hl/QJ3l+t40ohT72T+3MSL1wCrSsb1iRSgaZrsVMfw5p/EuxTZDgCYMmJ9s6klCphk4CCO30oHbl2T/QtkpymVQx2UcBvoWkZeWQ5JjGgog7ULoh2i2gUl8l2FVEDVSDF7gcjl5Ubd9px/YyiIFeiPFb4EC9VEC8iLAmyTmBD7fILQ5CYJWGvKjIXqJED+F9lRDRssTWtU9hxLkvQzfi7ymdDIoLfmOxbeB8+fgJzNv+c1QkKOqKYBRe4xARF0lCEtYqzZt0Ml5UCGljWWJ54EFPxGurM2pjqIFunxLWjdQgCRCyzf0ZBeQ2SEnyIyfijVuVVAzdGuUoKPe6pLhQ7baoFqFehTC5egOABC0K+8T9fWx4P08s9A2S+PZBQ8jci71i4QugH4KnX5l2FAK9T/+SYId0ULtR+iNHJ/AYVnm4V+2VuesqWWFhDprbehhp/ssJwsnnE4/17FTybjvzz8dBIjn/4gWOp+GjYR5wi0FmsL8+80HFQLIZ9bdFtYxR6lKFFMA3cU3b0tZJex3sjzweQnswKI4ngrwz3FQdZdWjAsDgIcZNAoKjD1HkxD0HbRWEl6imgUf9EluvRvDGhoI3lajGC5xjxuTSLo7FSv/8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PjAYNJ3Wov+2RduY7Q+yGx6QAXuR9S64zOl8ubB+uGBph8i4VdZHxYRn49iXt5Xa3l15kUWfypQDvGVkf0+sHowmkjxgAD/qZhBOIoOX6uQT2Nce1HAIr+9KqohC15afyNsVGuIZHhxq3QOGMgSE7fc/818HwP+LOMcNHp9LZBDU8a3Nn2roRethAcEZ5sqtUeS+1C3z0hZPvRQsXGuIraGGVRU41QUUj/M/gZwkJjD0LTzim8wrlU/CbLhuyCc4bt3eVMYDYcQLAk6OzJKs2FWSk5Y9EebrLdQpyU/vDv9fHklsBqNOdltXHM7lvYKo189NVuBsIRatxB/clIMwIN+tkGNi2MvGfGf1iszMn3gVIDLBJR32Tmo+nhAh1Bvlna65JGKcxaaJ3l8vT2ezhvlccga5h20wDXxAXELU+xmGxaaFkS+uBHUodT2SoOoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:41:43.9979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4e7536-9c84-4931-b855-08deb4c1abfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

Use snprintf() with sizeof(fs_info.debugfs_name) so a long RAS block
name plus the "_err_inject" suffix cannot overflow the 32-byte buffer.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c38af6d3599e..57f13ad5605a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2280,7 +2280,8 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
 	list_for_each_entry(obj, &con->head, node) {
 		if (amdgpu_ras_is_supported(adev, obj->head.block) &&
 			(obj->attr_inuse == 1)) {
-			sprintf(fs_info.debugfs_name, "%s_err_inject",
+			snprintf(fs_info.debugfs_name, sizeof(fs_info.debugfs_name),
+					"%s_err_inject",
 					get_ras_block_str(&obj->head));
 			fs_info.head = obj->head;
 			amdgpu_ras_debugfs_create(adev, &fs_info, dir);
-- 
2.43.0

