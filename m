Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1146606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ah94uZxn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716DA10FFD5;
	Thu,  5 Nov 2026 03:06:57 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8467610F3C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=try+p4BhndicKt5edfyZGKu9B9oJgDMAICuYK++0ME87VXF2xcApR68kXV8uNtcmkw8T2sbSuXgGjQU22x7858TTaEu455bGPDHmZSo/0nw1UxCPlMlJefiH0F5OS64LhrnMxf+td3ddPprQJf8rUZTICqUB2BaBmXeAw63ELmrUj+Ns/5kwqnAknQu78ifMlkfZUmyV4k0pAM0Sw4LDhz8b47m8+TrKMHN9Hx9/XRO//e/l7WEZQQxbMJN3Npz5psw47/WZp8UhY3vY5+oz/B8MvQWNJaxWU6AXhhnfzjmEFvlUt++xuDhrsOCPID3q9MYBOjQdt4kcxgaiPgDjNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajHpNIxuslRoejyB93qFdoLIRnzQGtGpal3EKy/1VqY=;
 b=wgDhc3JJ/w+Tzm4Y8UCjAVDyXL2MHhEeOTzM2B358/u/iJsgnEAgrwT8FaKyhXrkpyFt1TFijKdjMgpDANKB0Hvs34NgsB3AWTn0zU54PNweaOG9Q/Xxnprx9wFYwWdB4pX/HVFNEdYLs4jbQku7Eto8+8DvDS6K3vj77sOwBlL2Ng2Z6yXFcqi/QL7bIFAtL8asi5URzUNMaE3WmG/PXmzC9P6erPk8vblZoqhMKUvl1kqjTMqRBCxMyeov2utyAi13DfmLgqa9bJu/3kSFEdRAVDWcXJinllzAwYde3ZXV63t5k1tVA1NmiS3ccMaA3dEIF9Lla9RWhJAxmvzJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajHpNIxuslRoejyB93qFdoLIRnzQGtGpal3EKy/1VqY=;
 b=Ah94uZxnYLIi1ao3H6d1MmeEhZzya50MHFb2Qn1AF4yLnuGFWZug4wWlKMP/RqSY9kv9Da1+uZcKv68vGnh0jadRHsn/Z08foylTnGXoAPPGVw33ylfvmzQQf2zQmdPg/Nsh45HgZHo0uHNrlVe1Z0O2OP68eyZyUd32wu4KxRs=
Received: from CH2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:5a::25)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 03:06:47 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::59) by CH2PR08CA0015.outlook.office365.com
 (2603:10b6:610:5a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:06:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:40 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:38 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 11/13] drm/amdgpu/userq: reset the gfx engine when a gfx
 user queue reset fails
Date: Thu, 5 Nov 2026 11:05:53 +0800
Message-ID: <20261105030612.726542-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: e6516e34-8eeb-4530-09dd-08df3ae9d3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|56012099006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: EFw1x2TGSau5EEOSsmR844ML5+iSSL85c0p85kWwxRB8kE8WzxOEXXdtrKimQQfwJgUymfBzrtCJmQO528Z8a7q0bmcihxdos5oeU14OJedQMYJmDB5RRFN/hofCD2M7Kwo6gGQzPvur7N+YreV6YuzvCGRhCjzJF4gIpkzAJL0wEWFbgagNAIDSwzOvboBf0+9oNpH46+mt+eyHXT40yGWGAPfuqDHlwjg+lU9ssefrrr4KdGtVKPAW7va72oVTA4QDFnx/7R5j7Mo8ZORQJT15Vfa1ZYKEQiUSLBbMIOVaqk8X8bsaT2GIK8EI++KOoUDkQf9k45hv+NJyXJKQMcET1tnHniYXvVa52k8eo/cAS2Q6oLafKW08n0mts503NWp471inLEAuZz22YGVTlLNfZYqEq4gxUPOGkAQgtX7FUOhsMv9va0vpvA67ao6qAntH05GYYGlWXrrZxaOgZxjpUNimYMJ/L7OLDMpXWP1zyA3AtoaarYDm/JNFKb5953JYEKIXCdNzKeRD8xI9YqxYquyTdIHoynqzpSy2A32P2Z1dP69AcXp/5SHHHuQUGNYSoJQXHAwM1O5Y9bPEbT7No6RDhCYu/tmbkU+PP2fKzAItD+sPZUZlRDmqIw8mRWe2MTgKbMsejzDXV1xcuBJad9YESuUmUlQWkQq4dMBMXQeaLkycgMdibl+Ty03GMpK2x9Vc6dSL7MGAo1SrVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zFsFLpWqoe+A/cub4BJ6Au2aJhxDaboAv6KKJBDrMSnoH3u0MmJa1q92Izrio42BKf+/xTxJ0rEN5hG1W7l4m4wdjE7dlSahd6nBcum11dxeCjJnOl1dS/uV4PESxPSeDBTP7nThkwyZPsK5qZJkygN/rIo2Ujg6k7rJ0cE5lrK9dytqLziNNOP5Te4GOWMbD6Ifu/vNTYZUBtZZj45/rKb7cYSpZpjnW/kiCo/GzIOBm0Z5eB099hHRw4wKn+FdiRkeDBhYV95c7rexQSOkRsc6ULKYWaMgW7rQ6XMHhp5He+57xqtpzHgD1AaHakzDQu1waqBUuZhLtop0/aTLxB5bLUp/ysaAmKnYDNeoUMc7ix6+Apam/fX5XpJTaSWJLnn/Fx8mvjfFWQ/0c3ehrhiwoIXVnAirrdk6AFfTvmORZA28zMKiHppuO5/hxBHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:46.5854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6516e34-8eeb-4530-09dd-08df3ae9d3df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

When neither the queue nor the pipe reset recovered a gfx user queue,
fall back to a soft reset of the gfx engine before a full reset, when
the GFX IP supports it. A hung kernel gfx queue gets there through the
IP block soft reset of the job timeout handler; a user queue has no
kernel ring, so call amdgpu_device_ip_soft_reset() directly, with the
gfx ring type and no guilty ring.

The hung queue can't be unmapped before the reset: pass it to the engine
reset, which unmaps it once the reset cleared its HQD, and hangs it,
while the other gfx user queues keep their state.

v4: Call amdgpu_device_ip_soft_reset(), which now takes the ring type
    (Timur).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 27 +++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..4f2dea21ad54 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -235,11 +235,25 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
+/* The hung queue can't be unmapped now: the engine reset unmaps it after. */
+static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queue)
+{
+	return amdgpu_device_ip_soft_reset(queue->userq_mgr->adev,
+					   AMDGPU_RING_TYPE_GFX, NULL, NULL, queue);
+}
+
+static bool mes_userq_gfx_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return adev->gfx.gfx_supported_reset &
+	       AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
+	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -248,8 +262,10 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	/* A GFX pipe reset also affects the kernel rings on that pipe. */
 	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
 	    adev->gfx.funcs->detect_hung_queue &&
-	    amdgpu_gfx_me_pipe_reset_supported(adev))
-		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+		goto out;
+	}
 
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
@@ -277,7 +293,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return mes_userq_reset_hw(queue, &queue_input);
+	r = mes_userq_reset_hw(queue, &queue_input);
+out:
+	if (r && queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    mes_userq_gfx_engine_reset_supported(adev))
+		r = mes_userq_reset_gfx_engine(queue);
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.50.1

