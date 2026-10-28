Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9ED606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bJlXGn/C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979A610FA8B;
	Wed, 28 Oct 2026 08:57:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F93B10FA7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUkBKK8/0CJ+6/JkwZ+GTFz/xGj/e2JQFFn7hGIcoAJxRvjtAyfRafaXzNdlEBrFgNWK7aHYS5a2KDM55NaOo06fkk2JJnRktGOGqWU1nMgyQC1/KQuiBrAgSFw07HPWpgdgdT299XaWmV6w45A54NHTG3RXaD/EaHYOvKyf9ZmzS5wTGKq+I3OR7VhG2hVYJT70PdtTXy3us2g8XAIfvI5zp9qolRwXLyHCGm6se+MFjS0gOwPyjjUzBqRfrXuW4PGdeiJ2K1YDdfpchYglDMUu1aNyirwkgOStQIpA6+nTszwkh1h2tfITz8Pq11C+B257ATx6RGTi3jd9Wn11Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdIyMHp7pF9twvD0sq6hHnS3Pf6IWwwE7S4REp2+n+I=;
 b=D6VwS58J864p1Ao4DXCuaCd2msCOnVM1mSOTtZGJJdKqXpUnGjC8SiviQctcqvT8LVrcbjmWR3VEfjP2jPsmOaCeAoxZGRr7p9QW58SwIMmrs0dI3wPfWsC9HrEymarjADVqNtPc7AbZ7y2BOKz/4ZciCF6YDduEHw7rT6WwMy/tVB3U8EnEzl5CLZ+z29faO1t6cLI40A9l2g4yy8Q6YCjUvMZ7hCyayb9RtjReyWnlsLYHmyzNLZBnGdDUh7NCVBHB3Db5hdAvCQYbxo7HcxzwSPJ9ka0j8B3zvyYPeSL4+82AG5V+eoTTt6epIQIS+mNUSQaNaJkhMab1bI1u4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdIyMHp7pF9twvD0sq6hHnS3Pf6IWwwE7S4REp2+n+I=;
 b=bJlXGn/CbhPMbtoH2+wdEaI3bUQKbqKL0GtHcPFyyX0l0sAdX4SktBDoow69wx06Rb2m2/nFPlXG7u6oA0TDK8PRIYokD6MN+kRDYv7dKp9PkfkywMaYkQAw9HaoD6hFGmUCLaDTx8eR1+4r7+8NwslNJcWhxVptztu8htAnvTw=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:57:48 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::82) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 04/15] drm/amdgpu/gfx: add a reset_engine callback
Date: Wed, 28 Oct 2026 16:56:35 +0800
Message-ID: <20261028085736.3808569-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: bc82279f-c091-4593-c990-08df34d18a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +lYdTX0aWnV0xfKdv9nfg6uh9OLr/xn4w26TOCeYGowII/Q5HOLO27A+mm269Xfs6S3ObUNDET1+62mRN3oJbLYHIEf6xS84TsNFgTXQaG7U+DRFqDHcSHtowIrQIX+e7pwKrAY6UDYKFrRcn+pnYSNnR2dwEJiTXREDBYljbCo9Bh6Evtkvis8SbhAwqihMuwPGfzR2yxxh17XbAQ+T/sooBiS4dHkZJryek8Hu0eOeiVAIinm7mTTm/4bbxwH5/C/eWCelQ+uNf2itHE3Yl8pz2vQLXdWpUGn2WBXJMpk4cMVX4vDmAPmZfX5KDxqnUmTaiEsa73WOELWgSd2CiUE0sdRG3Ht2GnzEZzRxKcZ/sNHSkr157O66LtO3b49OlxQALpW5l3BrSk1J36N8IYb7bf37x25DEP3gEzTWtfca+H9RU2JkwgoIA9VmFTUWHu7XsUnXdbH7fccdSe4RmT3jyHCvpn10thP8CbNYKwyk0GVHqFebXlkDLEeSuIYXxnCO4CEyXHN1ZcAKEStKhdfgZo169dv+CSMXeFO5vfm8Y/h8GKDlrsWRPqh0s6ULbsPvtU4qEH3gCSgPP+uMYDr7tXkEnsMwFCqkjTdxeOVZCcGF1Z8PC0H6M/0OAd2poS9XgbDbBQV+XcLziZsY2dNa6FkaQRTs8cSexH4x7ITGO4cEMbpxsH0oX6it0ZS5SIf86LoW2KbinaLtli6Xgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3oD3ZjJjp9yaA+ggpCeKgQGR41OwVAdFbL6CMIpNKBL6WFb8WVWwRAhFPfydlk7YzV0o3FNrizLN0jOWd1mFg0rJqC2exKP0kgtdjcGmCV0l7ElDeWsh5oq7j1jFeQGwQyrD7PCY4wjA+04OYBo7tPp6TbohW+B1kkcptI43F6OpqFIxDqgx+WjeA0qQ64fpP08BlxChAYGo+3tGmDQqkQPxeaI4uU5xWqh/dnH9Ve55RCA+Gz/w+VhTVCL/hPaHjupcMwscMjQbktpzEB7mt9gzlVVYGtwi8gJUFwJCWTRxMAp65X+5DP8i14UIA9U1EEf7J6YIpxfgdmapP3SAJ18r9Wd0xutJpAu/uYUlYhYshEusDP76fMArohiILul8jmNFdacRCZHUNXX5gM6cuSCJb2e6WZa97Nk0eOp6zvq9q4JWC8QhG/bXrBWzo0Kl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:48.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc82279f-c091-4593-c990-08df34d18a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

Some gfx hangs can't be recovered by a queue or a pipe reset, eg. a CP
front-end stuck in the middle of a packet. They currently end in a full
GPU reset, and VRAM is lost. Resetting only the graphics engine is
enough for them, and the compute engine isn't reset.

Add an optional reset_engine callback to amdgpu_gfx_funcs for the
hardware part of such a reset: it resets the CP of one engine of the GFX
IP and maps the kernel queues of that engine again. A later patch builds
the soft_reset_engine() IP block callback of the gfx IPs around it.

v3: Take enum amd_ip_engine, called by the soft_reset_engine() IP block
    callback (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..8d7bd7057666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -35,6 +35,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_ring_mux.h"
 #include "amdgpu_xcp.h"
+#include "amd_shared.h"
 
 struct amdgpu_usermode_queue;
 
@@ -376,6 +377,9 @@ struct amdgpu_gfx_funcs {
 	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
 	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
 				  u32 *me, u32 *pipe, u32 *queue);
+	/* reset the CP of one engine and map its kernel queues again */
+	int (*reset_engine)(struct amdgpu_device *adev,
+			    enum amd_ip_engine engine);
 };
 
 struct sq_work {
-- 
2.50.1

