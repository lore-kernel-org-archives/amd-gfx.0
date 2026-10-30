Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C32606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QDjIoGNZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF5F112658;
	Fri, 30 Oct 2026 06:31:39 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79424112642
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUKwsaxgtH/yfmJdBj7AcY7up2hAwKEqtwiRKczCZ4TfPIX9zYsU/lAPDg0SnBQeHxymSNMYd29Q0yah1P7D5za0LVLVkN4snyTFG0Xg7/pMQUSFWO9VF1ayxmH8/nZ4lhasbTJ3FutGbPHLtln5LBx/wwW6MpNyLFL/dGuSQ/sEn37TrWL+/GpLzqG8vyDxs1JcD/SfVYPE6w+C70BLAyVMFGcr7drSE/m1ApfQMBQ/aKqLtEDlcGDdGgZ6LjJsFDAcUYvn706pWU/qF+0vLLxxWvm705PrAOo2P4cgftFjqV7NCnzEYHhbOnbOfieCuC5shdQe6Sv/Xghqwj+gaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCBVpPcLU5Zzg5wwE/tUotT5NKQGRUHFT/xDdvRzNq0=;
 b=eFt1MwISaG0lQUPs7d9DWnbkHbrzpklmrURz7dTzgOKbZBtI6eT5l4qtojMkMTWC/8++UEw2fHj+1AZSFy55p6jYz9I6NxO4QeirnUU/OqigxGVlj8KvyJ4HyZM8XCMV1s1Xu7Hvw/Cle4yemBHrPZZ4lNXqW6ZzuUyFcV94MiBo/rrPbmWBO7Yy3Jt9TAYCVLoHVaPPkZC/euGPtSHaD/QOr8qMlU2dUy7HSNb1mEOu20oobSt46skddRGMFJlhGlGs4TRHt1ieUfu927fyL1SUZGoML3RzoF9dKElN2qYvAGaBMdQlCrE18X1wTV4sagsFtZBuFTel1SQTNkW+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCBVpPcLU5Zzg5wwE/tUotT5NKQGRUHFT/xDdvRzNq0=;
 b=QDjIoGNZVye9pHFD3wLhnv1LvWGNot/TMNbFKVr70tYotDwJ+w1zFN/idm6yaTdWEDyBwd8RbKTbwkFhFE6bGf6kYwpdLHG5oBvWYBR4K7Q32/Y440j8en4D2iz35C8EDFDMTF1YaWEWu1nljvK2h4hLMDjJAorq14iLu77ZlmM=
Received: from CY8P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::15)
 by SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 06:31:25 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::21) by CY8P220CA0018.outlook.office365.com
 (2603:10b6:930:46::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 06:31:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:24 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:22 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 11/13] drm/amdgpu/gfx12: keep CWSR registers when
 modify mqd
Date: Fri, 30 Oct 2026 14:31:39 +0800
Message-ID: <20261030063141.2773032-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fa6e80-f474-4c2b-612a-08df364f6b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: at8u/DLnOHk42pBw/D9jV8zRzft1bHvpXaAUxPkwzb1MGhT1vIlExutskQVmGbbsIyARO+tWz2RGSnEvMEYkbpCBNx7WZPmKvFm3CJQvv39nflOtzUcIiXFnPqZ70EMkcHlvV6oA2cpR08eXLLOLkpgKAkysx+MM159BKZ5EFKgLN8Rgog/uUf4LMQtnFNDAsr3WMUw+B+M/Q0GjQxBbKx13kY1vPZcwR3JKpapG/jO5Vvy6T18LgV88pZWBf5KVe7WaFSWa7X5qVk09oqHVZfDFBfxMVEiiFwUjYFS/lFUi4365t5I/GnJCp54Eo2xUwCFycyo/lRPAwmeEIQPcRHnBQU3yYexzzx1sqxphZD/ANGC8LdsskFXMkG9XBqfCHmbcQQ1k2yufiphc+E4ehFINg7DEofkoK6qOSF/V7ynwkiRAFlbgt3VQxiQ20Bs0oqojdIMqa28BHgvRnKXk0VsdHsTj6vnFDII9n0vFwvjWOyb4MDFS1j7ChArltBIxYcs0UpPgZt37QiNoNd4+2Ytc4FA+QX3Fj1MJRPIou4MwkZHdURNJ1TZlbv/aKUJZj6K6WEqsvm+piaS8yc3acBj34DBQzbSA5Rr/88upTaydTAziP2k5CZHgTg7vUq/jloxj8oS50zW8zbzzHulUpBf5neRn5LOwMIwEikknTHl5a9OnJyRC/qqejL1F1x6H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FDN9ArNN8HXw6IhY/rJBUUT8n0Dmz6NLX329TE3zMzxewQ0nDzioayRdJDdc23XVAP6WHZqGGsVcV6XV2npbZeXYkTKwjDwGCInN8XjqXbOdwgSsOudcbpbSBQcj0soaf5Mn6VKdDF6zkO4FNt+f5gQu4XtPRQv6AbWO35bNOoKNl28E14psk/A8OL+ZYhaxX+wJknrOQA/1rK2M+MMvLgrJ1mD/6ptfRbUCnRJFKxCb6hffrBobCAlAUa2c72HRdhQdcGBTAWUUukbvlxCseviwagDi+FcBYLIsG6+QVyblNPG3kc9ifdS+82G1gETBparsFmEZA0WH47F2AQJYfNXRaziB2cA/b+0UCK0KYWi84dQm9y7J6Q67tyCyjiQG4DruYjsuutpD+rJNLMf0coW7UjziplWQgXHtwo+TLGqybUnn9RMVg3mk01o5AYvW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:24.3352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa6e80-f474-4c2b-612a-08df364f6b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit keeps CWSR registers when init_mqd
with modify == true

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fe6e9ac7b170..e49c1f55e34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3313,8 +3313,11 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			upper_32_bits(prop->ctx_save_area_addr);
 		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
 		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
-		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
-		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+		/* MODIFY keeps the firmware-saved CWSR offsets; otherwise reset them */
+		if (!prop->modify) {
+			mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+			mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+		}
 	}
 
 	return 0;
-- 
2.53.0

