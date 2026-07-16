Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30199C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A6B10F1AF;
	Thu, 16 Jul 2026 02:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSXNAoj1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19B210F1AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Laer8svG4WyeK0XiWKB9EoTjwKlr2pE8oE10dTkbi5Id9TBIMc5LXA4O2odXS28uBXhWOGTJv5E0XDOK01cNIov1OOEWpeJuDSqG3c187T9xlpLq03RziTMTWXJx6vwU00OjAA1DQ1zgiQK2bRaMqoS6uyC/92k7dPF4O5zLUrhDY5AIYe7v85SqolcEJ8ltnN/IDfD4hLK1QyZS1D7arjwZTfqkQkriDm7fVWLZU8E8JGExApEagx/UyWzeM/e/8sruPAEuzzidI1GR+X2Agq7l0gdrdoGZCdDTd1RT3eouMjR1UWfbnc0eWSjUhl602UsOB6riLS+JS9SNnjYVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOyN94mA8AAuRra6/yylhXsgLy3rC8uNPdvSXboNKys=;
 b=bJWjM56GhiHc5rcrLF8MzWBWfhwhGZ+SAJoQC43gFVTsfyz5psjZR+qQ70HdEpFRRY/uZNZIoT4cqB39SxQ5VSdgHkI/Akqd8YqWmmhJL58zERxosOuEwdWE0m40qzwzDsrP4ONtlcDqXy8Tcstj+Osri5YELe9oFrORFajbkka0emvuJICuKmn7GpNxTHRXSD5PY50QnHz+ph8HOyz8zTatbl+voZ4VJ8bcxu8T5L8F2NyHdYG8knsTcl/oK6zRfXKGP18lc73DMp9/kKU3TD6t8ccsYmtNW2xQ4go6AMh2lKA3Z4u4Axz9xVSwa3TRi/UPmDMAlqR+WCoGS85+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOyN94mA8AAuRra6/yylhXsgLy3rC8uNPdvSXboNKys=;
 b=lSXNAoj1jfe/ojZ7D4oqGqa5BsSgI4clES8jtStgWHoYcldykKwBhll0IWHY4gg8ouZwKfbYIXil7QfDZhQmIJHlbIVqpzRy6tNuiQo8G76V+6VVhQzgxa77wrhxCfClJBaFW+qCuGiJK8g180GQi4C1+u09UsanzGpkIRZMcHI=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 02:56:14 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6f) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 02:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 02:56:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 21:56:10 -0500
Received: from dev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 21:56:08 -0500
From: Bob Zhou <bobzhou2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Bob Zhou <bobzhou2@amd.com>
Subject: [PATCH v2] drm/amdgpu: skip clearing empty freed VM list on GEM close
Date: Thu, 16 Jul 2026 10:56:08 +0800
Message-ID: <20260716025608.1247345-1-bobzhou2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b047e1-a8fc-4872-e7e7-08dee2e5cc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: yzmqPvL6Jw7Rb+RhXgVSEEpeI+ImsSkTURy99do5ODd3OTLUCT9bi74u3kulOgGHwmEs1qZSBifT7Hcpz98KrssRfhBDm5jj0AjmThkMX3iladBZt1FW0rHnmEoW+Y7296HFrSpg6FVfjG23NRSHAW1yByoW3TOgVtBW9pL6FPRCBKE45fnm1N/sN5PtvSkAuqfJISE4L+Q73iZOXU3ZM7r1lxmnaaLxOBoUdVoNrY1NzU3KnirN7wOewDT5dp6eDqKMtHYPOnSnp993U3K5UlKtgTklsySOLwxczHOm/SHZ+imrKgsq8tMeR1dax7k2gzWeAUSG92YJ3R925KNJQoTgHkxBHBS5jfMGYPIMsA/qtPJ+zO0PFECNvYyOgayj9Pz4ldZwmzfsZ4PLzrH5KmjTDGTt4+1cmSN+t42TbMeBKIZGlJ1IP5TC7bW5fXOfcctlpN09kfQ56jbH0U4ld7gz1lbjRFt+PRKkvdwEfjmHVSXPiJjN4+zE8J2d3E7gWy8HUg0t65kLCBJM8Iwphvw4EevcSi7WtBSeduYaD6BC4qb2ewvuuRHdOaMoFIs4a3WuL1OVX+8HEfNW8V47RneRVmXkxDKLOXPMuRHCwTna6uoo2LTvdtCbrRvGkqKMAkDi9XDd2z9aHcxbXwDqppe/a69GfSA4ShK6+f54J12N5kbplbnZtz01AhQJNTMnATDLzTklEMmsRbglEb1w3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ajmAMVQolLrn4kxkJYDKDrgtQxAn8Vs5ptp3ILy/l7QDyct2jFfkXsEwzimX/kjWWZNae0W3fLnDNI5+9aolG8KBxvYWT2syGHJ1jBtLJE4gDugJb9uxfaB6OmGcACb4Am8fhpdjUTvu4UfI+nI8N3jzXTQpztLlS1GCigpYTEu+pA3nYnOxLb2Cppf0KYAwKECi3WbjKxA5d/m+oKKIStrzQT4zbumwhZUE4DyVAGUcJd8NX8xQUFg00Fy6G5WfWXQC13Ibc8mgshFJFo2lbM96QWbIR01YWsGA3+8KQN5+HrRvEu49bBsSHE3CKON1fbfQgggLlBpI8/Bz4YVUyZf+k0dyaVOzYHlG184Baqqxp13Ko4+h6e2CzWH7fw9ZbZOemvrwTPmOWwBkF68u8YCy+xMAChRObzu4pnqxMypJgLLb0rkXqvuBYsTdwlyf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:56:13.8403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b047e1-a8fc-4872-e7e7-08dee2e5cc7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

amdgpu_vm_clear_freed() allocates an amdgpu_sync object and walks the VM
reservation fences via amdgpu_sync_resv() before checking whether vm->freed
has anything to clear. Return early when the list is empty to skip this
overhead on a hot path (every GEM close and command submission).

Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 157d4168907ce..eb6a70fe79ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1553,6 +1553,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct amdgpu_sync sync;
 	int r;
 
+	if (list_empty(&vm->freed))
+		return 0;
 
 	/*
 	 * Implicitly sync to command submissions in the same VM before
-- 
2.34.1

