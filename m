Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A930606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JkxZS1vH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14E910F8CA;
	Wed, 11 Nov 2026 01:42:05 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FF210F8CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRBzWkawgU6gL6yLyCeO9fWmuThOUIf+ing+D5e50OSEExX9celAWjPxl8LDK+nPM5GfHpwqO+f0fZHLBPr5YGaJFQI3HWihoXEtdQH8AInXIa/rh/YP112g+qna3KWbY4J0xTklx3/1RJH1m0Kv8h15IPZJKqY9RPBXTbkfTf5PVn5X2WVHvPWZVzkofqvHg5JolAj5U+kdL/FtIaDA2eoXkm36HefniFE2r7fI7DYRvMWo3I1Wt5lXpEIgH9BNFL/PnFMqnEGbEvWIAtMHcXukPsJo8XndRsFYo2O9ww/BUaLkEmFnQ8b1JlNR9ruJT5FVp1/wHLEr4sbT6V05kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v163QBaZS5qrzCeQd3yPMSkAlEantP3eRQwRydDTjo=;
 b=u0Gxqg8G1DqP+JtKr1P+bgcMKMa7Gm+rv3PAXne0w65bMzMhckEmtzunE79NyxtLvwzszJBMFP8DdteJQvhZTR2m0Qu8HPFvvXhp8PwxrP9SUV5aaFtAzGuOeqbRJKXejwmOoqa4BRTOHe5FjLyyCsNeWWukqtHrj92c9879Iou6fjrw4ytQjoHezk54AqZC7PPjlcQZOqf9fzwe1KJt0aQoeJ2SQot2bFSyGu4vKIlqO2JjZDORSo7P10PjouIFLDZhrM0NQ8oeHvVUxlc6lSPpZJkuJq7FKcGFERIYUcUa2vqj1B+YRg0h2rCpKxQ0ASke//CWKptgIXMqL8aSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v163QBaZS5qrzCeQd3yPMSkAlEantP3eRQwRydDTjo=;
 b=JkxZS1vHXXLDbS9wCwgsM74RbQLLkelr0XjYp4gBJu2teTNqWRXcwYn7yi/eluIF2A51aHcgq+Dn7NYDda4cqenO9PHJfF2WBZ8EiooOO7855aFvQO6Z6dbKbYvbB/o8xJoZCYoYHHA7qoBxqOjsDUUDX5m4qdIglcHzumR1Wnk=
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:41:55 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::48) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.7 via Frontend Transport; Wed, 11
 Nov 2026 01:41:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:54 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:51 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 24/74] drm/amd/display: Enable SST PCON FRL DSC passthrough
Date: Wed, 11 Nov 2026 09:28:30 +0800
Message-ID: <20261111014100.3596072-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6937eb74-6de5-4567-1887-08df3f94f7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261009223027099003|56012099006|11063799006|261021123027099003|261026121527099003|261021121427099003|261102123227099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: +5Jbf+gsl2Qb+LatYH7FPNOTgqYuNW+YxK89gu5VtAI0MrmuDlvui6n8XeV+kbWCanQSeJlWUuoOopGQlN2vj8fc/VbK9j/QnQbgJvRREcwXQ1aSW6UYLtoEqrzoejPZbGtwT/wWSbTICWjHFKhgD33UfulQ6SLl6D3TbC5cvqxu3b4GxweffwS88995kLnidzlHTBB+WQXlNM/6yeXwvFmqR9yRXCX9JhgLOgMXp+QtYxb6NdcMdbufRA8gLsZ5O1Dw98LlUtaR/u6OiJR3e87fdlOvedDXl5h08pyXHiaRa58rG317Zme9mu8VZ1yHmsu+n3r8YAgvUO0FIm6wMDe1zbnk0dNSS9uT8O6RAyOd4rUCN7Aq/zTlza5UApQqtDZYxcnRRwbahs3qDlBE3vCt+Qp6jB/zE+rstcFWhAc9Rrj8OCvFdBc+EjB7QkvTU1tf21kf9YXosHS9voBE+FCC8ivuWYqLperk+SjKOMEhPgr7NBC9UZX+EYbVAash0+zQ7JjpNIYw7lk/3pdvDdcEE2ewm6m36UhbraGE87kE3eCYfDn5C48/Ly8Qb2adZ9/2NkWmzA8Mb4es9nr1OAsrm5NI83IXFl20Z7iI4vxDELLJ+V6OA4ewf+cyZhy2+Amj+TyyjzKRR7kY/OtT6PxwxIsolwyjbCbYeTh32ZakeW7XxtMRBtv6hsiAll05jU47pjCPXVnWiaWrVtXYJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A2JK89O691DBMXnCYswMOl2s7zOJXVKgDvF8N1mBZ6Uobp5E732ncUyw5g8YTe9N3a1TUacoTLR+jlPGoYZeqQ//GPbFuj06kZ6kIw64VwBfXmoYF9f1yO3m/JoWeNPpGPqsybqplU6gSk8QKev8gjHV3/Pn/ePDYuiRZ+gUfjk6dNeO9ozmLYdpobWkAVBNFVm0iY/3iRkVVoVDgndrF+tZy+YFi94CX8+UwLM6e8y2dQx2LcLluMPY0F60nCOAoM5AcLStSNF71Yjjjt/lyzpqCh+/O9cq7tVS9Bssta42GEcjVcHchIdRiEkWxqLjioNkimHWnwc7/n0qMdhUfud7e9kytybtCrp41EQGT7p8sfPAh5KZd6gFj12jLaALs3phMB6x2MUWtBkWwQaC2y/h2FOA61agNKrT30iDVZ9wKBI7T73Dmjj+iB4p2obQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:55.1512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6937eb74-6de5-4567-1887-08df3f94f7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
The SST DSC passthrough to FRL endpoint is not activated yet,
that leads to an FRL sink received DSC_DECODING
instead of DSC_PASSTHROUGH even when the stream selected FRL DSC.

[How]
Make the SST PCON path unconditional and select DSC_PASSTHROUGH when
DSC is enabled for an FRL stream. Preserve the existing default
DSC_DECODING and DSC_DISABLE values for non-FRL enable and disable
operations.

Cc: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3067ac5bb0cd..6192c0f6086d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1022,10 +1022,15 @@ bool dm_helpers_dp_write_dsc_enable(
 				   "SST_DSC Send DSC %s to SST RX\n",
 				   enable_dsc ? "enable" : "disable");
 		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
+			if (enable && stream->timing.dsc_cfg.is_frl)
+				enable_dsc = DSC_PASSTHROUGH;
+
 			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 			drm_dbg_dp(dev,
-				   "SST_DSC Send DSC %s to DP-HDMI PCON\n",
-				   enable_dsc ? "enable" : "disable");
+				   "SST_DSC Send DSC %s to %s\n",
+				   enable_dsc ? "enable" : "disable",
+				   stream->timing.dsc_cfg.is_frl ? "HDMI FRL RX" :
+				   "DP-HDMI PCON");
 		}
 	}
 
-- 
2.43.0

