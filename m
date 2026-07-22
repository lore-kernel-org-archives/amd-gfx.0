Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E577CC4451C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 03:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1982510E3EF;
	Wed, 22 Jul 2026 03:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1OccJ95";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B9A10E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 03:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCFmGIdvG9JdNIHkyYF01FTMolOiiCeR7pig0aUv37OaXWMV6NO73sZXVdctKfShSx9alE55to0COWGrVzxiRX21dZG+zZ/5Afs2ceTw1j2YWQXXhQeas4Mq6MQa4n2z7CVLzUFYqrBcFJZWnl8P8Xoiz8w1gvXN4tb9vxkNAJ0rXRTiVKRWFkjSE+ccs4GDfv4KQ1IHMwkr92W+FK7IWMFtuTsCReZ/CV2PiiOIGTnnCc1nDhZzCLo08jOsb5GvP3F2r/2oR0r3YK8hTSuvxdud8Uh1WBtDFC9smWHWXWVP5hPLcIwuDylHJWsIi+prNemguKQu50HW1w9TDSzavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=HU0siLw50lBvv0IG/ilSWTpiiTDr9/1YlD8BwIPtbGZ0uhwfZcDbfT0TUeCdXjttK9TOURKYbNamIVNxUbzFkkvv1xIt/osr0UgktQWNNUZFOjybyXIoM+PS2BPw9GhYwjHkVaJXfVAJG4usgcpyYJp+P9RosNTq39PVhaAynHLvDhRq7S2oDBhS6Jwg9gX+GQQivT/SMZDITcTUJDiL/CDXTLxNHyoFAn6OvUHOv5TPWP3oD4jRfvF9cmv91Qq4k+MJu2oGBIFvFh5ZWssrR946/cCBlcSpkuSk9JPDAgGmsTvN+t2a1XqkQbojlWwrx9L+7rylQrprJYyEls7UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiQ+iZX9wNdjl40SU36d7Mu3U1O0Ezct0Lg6QIBDT+8=;
 b=g1OccJ95F9RpqMvA1GlhH8YzgVw6ErWKvOU+1DBdqpTGNrCN3W0qhiw+4wN9LDbBOBRuUeBcRVBNpA15wBT66UcWqfhTfs0K3EWm/9wLu7A6deUIBGVRp1TpcNpeB88P0kRZIX60S49ie5D4eVjvB/fQWT3P3pglgy3PmGIjFqs=
Received: from CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 03:21:56 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::80) by CH0PR03CA0086.outlook.office365.com
 (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 03:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 03:21:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 22:21:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 21 Jul 2026 22:21:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: track faulted gfx user-queue slots
Date: Wed, 22 Jul 2026 11:21:13 +0800
Message-ID: <20260722032152.2904563-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a05451-6f54-4f13-56d8-08dee7a061c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q3eZJ+Urinej67jEUUE97IwSBQDWEbZHIXvPOPHFxvo/KyQsWm+wP4qclhECXsfIcyZc3TIjZbq84vAAjzgOffkmYao5S+tV9d5RkIrSlmRjdMA03S1sCklmXaqpiRq4jAaraxgjfWJ37jEZrUNHg77Ki7B98xiYlr+R9zGx4p8P7k3i/ur1GXzysfJraU5MdZATmpznm16OMIir4o1oqB1Rss+3nqMyUsHsnbb6jQLOlFFypbQ7XQKDVUcsfoEc9LxbKP/HFy2ZcJZgFp13L8nf+DMvXHxrtdVvJj9ckYdNcJVxYXsP/IrKU3AY5QNKYqsCMThootjxpZ2PujsuloB1QtSsiiehok/AV76H2+ByIIKbaAC3mdQFXRO4n8aTzu5tm9a0/wqV6pLuJuHiMW/wphLmoNL+KTTwkOebi3M4ItBmuEly9PLUOE/VQDEEI5pyGAi1qDKoL75S4lw1QNs9TBS+wsLOWoSF37cHjeC8qctCbyE7o+NkKd/BRJ3fSLXeXDkeE0QoqxsPed6clkVpIxH4nyCl/LcPgKQ/QNgUwIY1ItYQ/fMkliCgcPgOGvuzFcVKe2qTzhF1yh2RK2ptImsN5nNV+NPZiYX1fCOygsnn19mrirbJ9wRx/EzNf/z9aW4F4yQwGNFxBVVplaTvnb+GezLNyfjxzm1xtLQrvGJCFwbL6+dL0ntR8B/aUhEkqH0NMKqKjT4cp5+ZDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rdvu1Tg75guo+T9JaH3yBxATXq5mV22IiOAWXgYzLvPkrhGkJoT5mxKNjcpZ4QxoZScjZZIB0K+8BqcjuNRvN4zzoMCmLCj02+ovO3M5rQJDubdxRb8w8T3sqqDKc7CnmU+9DLSY0pRsS3TKTq9M2hMtUQTO6Iu4LHCu2lIcWrDpGq2+3IzD2k7+D9TEOQLNKBsubeSvAPPmx9DE9vimFrcNtEPRfg7YoKwfLlaRqhRdXP3f8tOey8J+b03NaS6jd019ttgB3Z7m/p/uNfqvKYeTA2b7oR0t8gV5Rksvb9k3UqXQhMyhjXIZpFJ13x28hZ74X9+YuwMmymXC3yGWqBDQb3GvZBXgJBnNOuG/CXgtm7pIbMZiD3f22oNdOog9yQ16w/55xU2tbrIiuQpaoyHaa85aXRt0YF8OOX42JuSZJCJI+O/pN8hCt9xNPBC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:21:55.3696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a05451-6f54-4f13-56d8-08dee7a061c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

A gfx priv/bad-op fault IV carries only the HW slot (ring_id), not the
faulting user queue's doorbell. Add userq_priv_fault_slots (an atomic
bitmap of faulted slots, so concurrent faults are not dropped) and
userq_priv_fault_work to struct amdgpu_gfx; a worker drains the bitmap
and reads the doorbell back from each HQD to locate and reset the queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..f83afa7e0aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -535,6 +535,9 @@ struct amdgpu_gfx {
 	struct mutex                    userq_sch_mutex;
 	u64				userq_sch_req_count[MAX_XCP];
 	bool				userq_sch_inactive[MAX_XCP];
+	/* atomic bitmap of faulted gfx UQ slots (index = pipe | queue << 2) */
+	unsigned long			userq_priv_fault_slots;
+	struct work_struct		userq_priv_fault_work;
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
-- 
2.49.0

