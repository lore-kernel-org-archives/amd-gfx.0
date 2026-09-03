Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C31BC624DE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 20:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8979210E464;
	Thu,  3 Sep 2026 20:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="490njt2a";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61AF10E464
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 20:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRENF87RYWTCYeok+HtzQlyZqMFakNzMD1ZLa2UG6laPr7gufTfJr6dkMKV+ZucntHzfGP3ULM2j1Rh76XR32ueBgQfEj72XzK2QDKUkyavmHwU07NkYaw89JeTKGRr293OC/ynKsTpakDa2Vp+pnz6Jg0EASDFrkEB61WrQwSCLHpCS7N/RvYqcuoBU/qycLdJ4GNwnT+LquEJIiV8C1745xVO93pYgIacF7BxQRq+oCHqntvAHByuxj3XH8DjG0A6QO3YbUBqa2JwzQ1IRa0c7TC4Iexy/V3MI+Pdy8VEkqH17dEaXZQrwcB0nZYt6azG9dc+AZ2pWpDV2ItMISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uDzGDTchxhWPJgAFk9ZAHg5QvFCHEt1oUhYrTBQaCU=;
 b=jF9mM821+DQEDtTu6qbuChzGPWuJMSLoNO71PhN7b1w/hprL+GHFECKh0jbTUhRQvruyfCFOUQsICou2hSiOVvq9KBuAtUVuWIM839X/cznBDRku5ZSkwUpKu5ZM0aq/uwvXagAsAihVkSeL4fms2T4bqrIvadaR6f9Z65naZfg8N2KzDpjQtQR+9ll+FWP9SmNcD2kFw1kwpD7JbsX7+FSSP1ajeWCaoJB7iuEu7HY+43hZVrxuKYVZ9uE1B3t30qU2LbpVv7WshFEIAUJeVeR8WvFW+C1rInF8GXMrEM0CpQ/TZe11sAgR1CHrzPGLW3MC6I3Co7AFT3zwzD5a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uDzGDTchxhWPJgAFk9ZAHg5QvFCHEt1oUhYrTBQaCU=;
 b=490njt2aoyhfqyP7O1goJ/YWSFo8pxvVTOFYfHG76+04TaygAJ9wPBvtHWPQY8GWqR07gWepJCP86xsOjhZunwMZ2IJ9Rt8gJaHraVctTAfhm8kmKKt2NY3ptejkYpLVYLpLYBHm53cerIR0rShqYsBWanaeTdCGHY/Nl/MCn6o=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:48:56 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::70) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 20:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 20:48:56 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 15:48:55 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Reset UALink connection on failed
 TLB-shootdown send
Date: Thu, 3 Sep 2026 16:48:41 -0400
Message-ID: <20260903204841.3485963-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903204841.3485963-1-mukul.joshi@amd.com>
References: <20260903204841.3485963-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: f641696e-fe01-4b9d-c46d-08df09fcc5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: NFusWJul/fGhS54Aq0WmY/wrmaaga+AXfVEN21qvpbpeKmkfgKZtp3CbzQwI3AVzjKvEo8Dqh1PIu+8ljq51rQiJIMTkbINCkYZzRZd0LA891zQaSMc8lpMizqTVfyo6C6bVsKp08kbAIZ9GdA7gQBC426fbFBOb2VU6cl+gVai1hjQNMlwo9QoQec7aqVk+H9O27y0dXDz2QubEK2qxe6AUhFFBCdKbPt1LytZ/Yatf8wceWWqGO93q1nRHP0T6U2hJ7QOyM7j1x2hjobFFHFmhtVHpQnhaAIXzF4H+o10BI697Mzvj1pdvU3z7MPog73oT2ViFxz4/6GNDIAuZlI1XMWF2j922atKrN25L5m92gSCMeIjYKQ4cl90heL41cqQP5/h5n0rXNrPazVtF/TBTa7W1TmPIb0hhe5BuvcjubyGEmgBrwFL9J7wKnLx1ze1m/B+5aZ/kKzKDcdgr8jwhv923DLWAA5zIsYEIfDwnJskH2tIE+Nzj/RcD6PGSeLci7nygd9Dm+VYTV4RfH0mHcIOVOKKVPFnXIAo//26j7e0L6VdyZt9AiL/OLYO3bLAHTfdMzwcTDpqdZ85fF3mhERunfaSlvgOmKFsTEdzPfCKtRjoOtsbuvTzOG4i1RE6xPpHmvP6TQCzwhTGfsyKPKLfoteOpZDbQS7WnmsZ73repjm5EnEworjasE6BK+EMDbg2M56ZPpD4LZM+pFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ay2Zx+E5ipZ73t67aIAj1ac1xivOd1kJBSsuoVzbymdgJ+PhQdhDSIULjxPWt5g5Tex2f8Jomziwz/hBdKXLvMOsvPie0Or+F9Q0mBYlyi31JU30pDUpx4Lbh6axMubUmc36DtilW7yp8Z1VnsACU529IO3c8LC4uDZmvtqTkSCWZdVNrocQGTy9bKAM2Ez9luePziseMTutrbGMa184l8V29EAr5o76vTNbYa4VtsaM4xfXSK0SXpVHhDE3mKpp6GuJaeWQEtdhFl2ExN9aN4Cs4GoFC/G4tHDkW+oWy7VCQa3nz3Xo9Cd97ty9LxYiIARf6izxrmYvzJoqLFYbhCp+/n03RdcdeqKrdXtli3NbXjrD4j1ZtEHzvVwL9O3+mpf5CrX9muMt8a2I8n2As1s7L9h2Jhd5E7E0DvIStaeyROYVEHpuLjf/Nya3/sz7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:48:56.7324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f641696e-fe01-4b9d-c46d-08df09fcc5f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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

If sending TLB shootdown to a remote GPU fails, reset the connection and
mark the connection as NOT_READY.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f5865c5fe93e..5b3c7f62c34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2681,10 +2681,19 @@ static void amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
 		r = amdgpu_ualink_remote_shootdown(adev, remote_acc_id,
 					npa_addr, size,
 					AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN);
-		if (r)
+		if (r) {
 			dev_err(adev->dev,
 				"EXP-CLEANUP: TLB shootdown send failed to remote:%u\n",
 				remote_acc_id);
+
+			/* Send failed: mark the connection NOT_READY so the
+			 * rest of this cleanup (and other cleanups) skip the
+			 * unreachable peer via amdgpu_ualink_check_conn_ready().
+			 */
+			amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
+						AMDGPU_UALINK_CONN_NOT_READY,
+						imp_entry->generation_count);
+		}
 	}
 }
 
-- 
2.54.0

