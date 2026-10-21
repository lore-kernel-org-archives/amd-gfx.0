Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5878606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SLRFdpv5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D9710F9C8;
	Wed, 21 Oct 2026 13:16:17 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BA510E326
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE2ztLllC03v+Kkq/PybRRcFoQbNFGcQk9KjgCjHapWh2Q9HHByktGFQwOaHMLl0n9fxa+CKPPEiOHEb9pd+4FVHgbmdXyV1uMxizXiFd+SeVwViVTOVg4qdMZ0Jv0g/IDtcZMto44bpr/fyrJkswj9x1SM3ryu1F9Dnt8zlRSfB0LRbZ8mhJRbLCmpw341ow/z5SKxTSmFpKNr2HiSah/c+tKjpPbt15kQa8G18CHbIdIOaAfSEh6MjeM/7esbkMt/FJp7lWzco+9LnjzW65fOvqdw1CqJjHRnI26fydCl/FEOodtX+UnNi9KjALQhVU/NsjdsIAXKLKJ2YTp37aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEqBWnSnlVFz7k6rvW5UKN1yw9XBYpPiaQZnVKb1bTE=;
 b=fs2k27yibc677zd4Mx/54ptCInypyLH9Lv2uC+hW3cOtoEaTCbFLQlBaQLt/AHiacRIOAl1rlEJKlodc0TOUGZGsy1327vd+0924Yy4uWeSq8LS9cPiq1OGXP31OdWNpCl6z5t8q9E8nQSOvpyZSBnvrYkfZAmGfUdc7m3EJMyhS7rASLpndOsEAjyuFRohad/h83GTJYm+xjTr7XpT871ZiJ9WgbDH/tkx2Vv2h7LO0YLmrVv5tgnfX/vGXxm6UXr6Lb5EZ/nSZs2j6jNoCZGtWbWHFebcjQEuw/1aKIe06FKAMUQVGgJTvNWD3khroyo4NS1rNjLEaub8tDypKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEqBWnSnlVFz7k6rvW5UKN1yw9XBYpPiaQZnVKb1bTE=;
 b=SLRFdpv5o58DcMefwHemae2sz5i1JuyDGMmevxS47rU/3q3YKUdNSPNWfwPzemZ5mBNYxlprR3BUppVg+2tU0DMNWJdyDQaaDePXg6wmGoCIfspQfxSb/8muDI2IQkpt3zvfV9q1ZNgoXf0vnx/JAkT+Wgr1iaz5y1iAsly21Nk=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:16:00 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::38) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 13:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:15:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/gfx11: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:42 -0400
Message-ID: <20261021131545.1962601-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abb2379-0368-40cf-adbf-08df2f757322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VZkh7F9heVjo5bggyf291pOENwD3FTnyeBcj6LZXMs5g+WlkPni4MODzwyTgp67ZLdcKDuACqnQP+K6SVi4NPgqBEkiQ0rmpOSRE14ntaUFRnDkSJtrNUKxSSjMvimPWKRJ8MvF032We0GCQ8tMKx1md0FWVCSwZyyTJj6aYMv8PRoxBoKLgtgteeyn7tGFyNcEheC0SmPa4Sv4q3HwiV9Rf+V2qObbPBRf9hVIZdziT3Ruc6vfFPRfO6MZwIdRgpbZ6s+4+PGAS2hHZYD4w0ndcPvDD6LOTOG1CXyParFfZxCWI9gxeam6iyBNlh9Xi0DNCn43fnEUSueCiazFOtbyymye4cThQizF+yLJnfhzsukG+xqIzZ+XAHlIqOoMDOedD8XagDc/9SEY+F2CQdIG4a0JUmfYP8asxlQPbHDrlkxOezohzzzJ4wIgMnCB7l89WGyK7ZfuIzgR87GTrvxZfp82nPhtQSVXCdL4UQxHoRTRB4n35kAykaBPMWHNAgdBWj9OemyGR2ALDnAJmWmKkz6SzPU2tCDmiHbxv37xegSWLnVCubatJK5K9I8gqu83+0skHbXn20DrbNPrZ2qjAWmk6gmmYon23QMGTeqjrX3tChhXAfJQf2YyIiiRwl5+UenSJ9W+09U8RZ7e6lHj3piPiYyXZ9f0L4iYCiUaVdRpB45iTEFeS0+lS9Zx5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oWxo3rQMjndKcHvv/jX2z8yp4w6lfyQEqECwba9z69ghECwXWVN/O8iwOlOTkJhc/Hp7tx3Mz2E/2WjeZD5Rig7pbHXs0onX08Vb88o3PYa7Jr3aH9kTv3PVIEP3BtPdljtfazwUttI8hr/XfutA7R1bNFunP9bneQdDUj31vM/qAUyS+NE6QkIN474rlo4pyBvTnWY5fTyiNz9MloG0hFOU7IsKjdShYVXaaF/OUADIwIUCxlgxrSIpYCc2PsuVzUZZdT/xfbRK7hJnIV+hOVV9QMBNsFPDPwMzwKoDU9mZJpZriy1X98EQu30A/YSuqf9LHwTqw9LDrb0+g9PsfMzHtHgegvt523WTg4U18leyGI0AeEiItXQsobDqimZbCRu1IEVzL9xpjGW+AfrKP2SF/NFjzygYlljMVg2c5K5d82ehBqZuMJ9ngmpZbLKU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:15:59.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abb2379-0368-40cf-adbf-08df2f757322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56f..d44d21c0c332f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4238,6 +4238,12 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set up time quantum */
 	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 20);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_DURATION, 10);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
 	/* set up gfx hqd base. this is similar as CP_RB_BASE */
@@ -4509,7 +4515,12 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	tmp = REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	/* increase the duration of a high priority kernel queue */
+	if (prop->kernel_queue &&
+	    (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	mqd->cp_hqd_active = prop->hqd_active;
-- 
2.56.0

