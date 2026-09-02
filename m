Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C60DC624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C374010F1B3;
	Wed,  2 Sep 2026 12:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lT3LKRnI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382FF10F1B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4z0qKz5565gLOnTXDOhxAha74yx1GMScRHw0RvLRkjCOGPDT4CdN0AuEm5VI+9d1NCCaJfrhMYOQ4UCHQt8/vVw5DGXjTVAhzZspZXG6ZWMCIEzRrlEL0loiTc0/cdEDuog6n/vtY5v3hNEtCm17FhD9MLu/Wsx3ijMth5orfaUdKPmaV9His72x6ZC8+9JQ5BOfMvOu2UbYTBofNVtN1Sl8xYBN3tGi7M1VE4PpQHt3VnyhPid13/37OUuv4dFfqEPwl2Z6a4qbkf9OGgvWG4/9SnsY9D2NrAErl1XlGPYPLYDLEJey+jUGg6nRQm6i0dwAIgUnGmchhT3Ks93aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SBDsLfFXhZIrKvHCQoYvKmHnP/d4Mp+bVF8I/bNQpc=;
 b=fJGZgDBarchYV0wtBJ5xxUP7Qt7C/VfqEff0g5v2qFYzbVy5SlEjLUxDxpTCqREozmJ2Y7xMOJus5FbZAB2rJzoq0A9ay7PHA/gWlWAyNyM0c0ApQAOzICZIkOsHiHOmuLFa/FhPqH5uAxgPwPR8dnyY8Xfh0nvQR2ehtDLrDCz2afsCjortD4gQfge+dnX6pU5SLxgJoPPTInMiWBXuSh9nAIwof7xZ01Zz7gBw3a8nNb2Mu+fjzsaSYCFCCEABHLQf72tvkU77DgSa9/UdaRYcM9IX075ybQiV6y4VvUYLRHua0LrtJznbM/Xo5ndG0JIFjNkMfZbtkDXZ77YtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SBDsLfFXhZIrKvHCQoYvKmHnP/d4Mp+bVF8I/bNQpc=;
 b=lT3LKRnIRtRb77GX72fVxgQ3N3x+bjWjOmaOLwz/k2sOj+LmIMpioY9mT5v3cFtwilYRcRdXwugzHVFeP7aXLFJYkkTzWu+Izh4Sp+pKVR30rGIIJzCl6dnZ8EH6qw1bPsDCd4U4dXPsMZ198jZwmUQx3YmsvxDPrqhb/B6xGPU=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 2 Sep
 2026 12:50:43 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:b5:cafe::45) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 12:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:40 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 18/18] drm/amdgpu: stop the userq submission prior to removing
 userq
Date: Wed, 2 Sep 2026 20:50:01 +0800
Message-ID: <20260902125001.621629-18-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec99992-5583-4b54-4f6b-08df08f0cc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9MX9qjESRP2uTv1kUAL7kuBdCMAtQNfZagm488fWyJY2c7g3GpBhZPqz/eLwqfkny6T2m7Gv9loQ3OJVyB2bDY82q6mV592MZHULNUSB4CsfHvHqi1KCxDIX4LUpQTXPK3bBZKz33gNzM4NJTfliJKU2v8Axun0AOtUC2FJs7IljEj3WHrTh/aGe3yXQ5f1RKVNOn8lofoxDwr6X6+3MZYGn7uFvqjXnVQAnzN6IsjTLLPWMJMugPpgnK8JxpZlRauIYLGoxQGFfaBnH4Be+NpMKpjo4ri497L1qauaZTeeqzHI7XZfQczR7iNe9L3RIGtdOaZu9SSLX0mZPRE0tjIRJBFEwtoq//2eCFwvDhdOn3LmWvAwN4C8VpL9nKKMN8WpjP2gQB2bd/mfBN4Zc5bUlpzwlG6bUJ7NKCoXum1Rbe08kr7QdDOQEmBxSh9QxyJviEq2xoSMVqUHDiqAiw+hJEqSjmcVIJjUKsqduW2eqzsyWnLDO64zQ0RrFao+HyAsOIk/7C0pqc7GFVHwyAOM3M4LBHQf2y96PnzTfxMt0rglKBmw8I0dI8aS23SQlaRei9u1PVcUEb5zlr4mgKOnLw2qScGF3V5qCw5SaJD2ecb7FaB3oDpxUCP4UKwQmlBghkFzJwADmce90cVVLO84ahZpdThkG3eaplnQo+q1jMTGb6fzHCXBEk+5DgFEXDsnADwGGFwQuD1De+S2vuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7RyEOLDowiuSr+DVgeLN2lc6POII013VhBEwgYUQXrENER7YAU/F3sIQA0meOKk66tSjM3d8kUJjLiJo0ibBFWoZwOBuW+g4b7uBvoNkQk4mPcYkQ8NGTpv4MSFYU3BT0dB65mBvaOv20FEPPj8n//UwPp4HLxNx/4sJlkBhyxDdFSlJbGB2hSxvgJlpRFDmaMkSeHEbFKV9zWwYlxvrXiQ/GPUC3zOxwzcQEdT1uDYGcYlf+ZCPopwg9s+KLJhFTOEgugehF35sAllqgBjDvUh4nsVldt74mL/kk7C8FyMIuVaPmmZodtL3gPGaufvEO1ZnpS9arUlbpO9UId1DrYfQHLUy1Ex0BLk3AROs1uLGooDDKf3NRBkvw5q44fB6za0hFH6GQoCoXxEFslSOqJBWE9N3X8/Xtxpxd8kjOuw07/6KlxgKW1sph821lOOl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:42.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec99992-5583-4b54-4f6b-08df08f0cc6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

Stop the userq submission prior to removing userq in the
amdgpu_userq_pre_reset().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a7d5ca741a3b..c60365bbd7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1540,6 +1540,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 
+	amdgpu_mes_suspend(adev, 0);
+
 	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
@@ -1587,6 +1589,6 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
-
+	amdgpu_mes_resume(adev, 0);
 	return r;
 }
-- 
2.34.1

