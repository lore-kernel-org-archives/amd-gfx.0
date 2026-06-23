Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FC4CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 09:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C893D10EA3A;
	Tue, 23 Jun 2026 09:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlo6H7Ax";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91AD10EA3A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 09:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECM3ZSL4LgzAZbBpjKsLFP0z7DbVndGm7skRvh2EXhFl5+Y1yV+snc+bXnJjvQXgWLM36a+MoPltD9ev0Hkl6lQW7VXRLNgfYMmQo3cBKIkJtEQ1FmhdQ/dRgysjqSjsUv7PhM/5g6lIeZ6YEJQwn3EqvhyofeUWbNkrQ5HEV1jsR5nBSLj2NiACCSQ0eigvbA5VSo+5E3qnlekv9Qe+JF8AFnD2uVhCwz4mrrwWP0NUUvwIOy24DdeFaOjTpaJtr1qjqEoQVHxoasXLH9FmRZoW9BpVs2G4N/m+Bm4ECD1NpdCDunbbTghJmvIzWQ++q+oaa8FISX1qu5DyjIdrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOlkcDBh6V7JDr/WyC2knp6p/7y7p7/cB1x5SN2LGlk=;
 b=WNaBeqO6hd2fL06NgkaliTUBCVwYN1IRkcYeBpLzBNCRbEduneaS35JXTvhGySq2LXe52ZFUmBLMOJjctcVfOh9Ww845m6dB23hFp8at37TmYIVTKunuuzRMpVSVuJAixc2XLlhSEhXRO1Ik5SzSPUBWb3bkWyuI7hJY1aZwqEP057nLclWH5YwkWyVDY5sMJG9M+DWuT1PLjilENAf/rj+2JX6IQrSsKcrPBgNFowIf25CUJrpqsxJiiT8XQzgCT7cL07GbBdLMJdsZyshwGpBWGpEDRmvtSEcoCjSX2aXS47fZuEVUfTOZKD+qgNGOnSrLiKiMPfM/4YvXveGAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOlkcDBh6V7JDr/WyC2knp6p/7y7p7/cB1x5SN2LGlk=;
 b=mlo6H7AxAzRqP0WeGfrcDZ60HBGtBsKm4oFhrpLUXoNuBB7+wn9AEnAw3r3acA5dPY3qvA/fOsm4PFS06eQXX1BvLFd7JXcCz5FdMaAZKn9Z73VBLRDOsQVdLeCeHs+yHor/G+7PG4Yp5qaIsvKEJGhrHvOaNJAjVm5Eu+O0fFg=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:31:58 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::24) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 23 Jun 2026 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:31:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 04:31:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 04:31:50 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix mes fw version for queue reset
Date: Tue, 23 Jun 2026 17:29:39 +0800
Message-ID: <20260623093150.256288-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: c0394865-cc28-4b24-1b7f-08ded10a4597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /r8wkXDlkmEiVT76D5jsk8j+4GunC7WHYWPGDRZUmNj58KqIRirEP64qr60pAE4IQzM4+WVJ5WcrPS5uffwXOkDN0eS2+lXTEZcldo1a+ipW29DdOYS7oT1UAZ2IAVowm1lno8Iz7I2GVX7IfJCwXhmzNdF6Um2OpFZWjXumB+bIxENT/uNXnQ7SAo6YerttleQiJMKcgIpYy8xrlpNR+kxyGF0U0TeKPr/T+eQEllEZEPCB7TfntEJ9m8mWv6JnrC8YJxiBrxzzPvWIQaG3DShT7PH19uLK7AXLSp82R2O066MCpBlPHUuVbpPd7FVdAqaZjaEJ3F4CtD1/2bO9t45xT0s+yc8Jp2iyF7DVmjdh3h3gWYQklFCsVji0z09PUti7Wdr1dOLLyOg/WjMPQBt7HvRdLTHLR96H4JWarGn5e/J1I3eBLwiq7/DBOS6lR+D2ZaL2yb4Z+YEMDPBBBfZbY3V2gYBsHi50Z40ybk9w/zPf8pX//ue0mw/XpBLnaQTmdrBkSUh9btsB0fsmD4KFuil5SNp6i/mHNGGtMgQ9eGVOlrbX1lBGeJI/IdB/uBYRkgDyFS3v3XEXxpgpg29GLBK4yCUxMR1dnJUWf+YX6Qoxbc3UmVRPcS6ZktM/0WWlgOqQQhx5xCKGZaTTWYoNqIEHcecw/IygUiCwp5t8kkdw8nJsKyQMp18ROGQPK8uk/dqFi5xpCo000DEvzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y1t4bgZhEbyiJUJlSCF9PqhlvTOsStxPDqghZV7ot2IzpTd73dKtJStNBRNxgjELx86zUIWco+hcK0iaOt/0lL+oXiV8m5GjkBCV0gHf/yhboblz7vIQnnaTSZH8h6st266dJFRCkkAAPoc1tXxxmJKHT+R0CamRe/PYr0v2wJl4zLfMHSDVvWDdxDQvVLOKaiRNvn2F4iFiIf380qhDWVu0Hn6iRunCVBi7ER7SGCETJ+LtC/EQ3rTsJheDnsVD4BXA/P7aIGvdj39UMs2Sv9PNWo1re/OXiXdSdpXjUHmYWOqIsBclOlwlutnCu4KKEBANCnhVKV/vVLUHL6yiJDxmURCxf5XBAA4CUUHDNPtTPJ3Ezn2bvMuW77yb8RTqeycMPU0dYLNrdDm9Fb3uj9B6sod1OdSYUh5MINF7FnJGvVHO0LfNu2TnWy+PgebJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:31:57.9580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0394865-cc28-4b24-1b7f-08ded10a4597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

MES 12.0 0x8d advertised per-queue reset, but the MES reset API excution timeout randomly,
and the kernel falls back to a full GPU reset. The working reset lands in MES fw 0x91;

Fixes: f67c8180c9ef ("drm/amdgpu: Add gfx12.0.1 adev to queue reset support")

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 6c0dde3786e3..ab974ea659a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -869,7 +869,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
 	u32 mes_sched = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
 
 	return (ip_maj == 11 && mes_sched >= 0x8c) ||
-		((ip_maj == 12 && ip_min == 0) && mes_sched >= 0x8d) ||
+		((ip_maj == 12 && ip_min == 0) && mes_sched >= 0x91) ||
 		((ip_maj == 12 && ip_min == 1) && mes_sched >= 0x73);
 }
 
-- 
2.49.0

