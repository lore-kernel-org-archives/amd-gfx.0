Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950DAD3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3606610E48E;
	Mon,  8 Dec 2025 17:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zzb60Z5D";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB9110E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrJ2jty/dL93bapN2SXL9JipzHZG+FIM5Xhwmiu4vRlaTtLoypZTmaLujq02V1yoLfB33YqWKk4YtQedEG3FhFs2yM3pVanuJhrxZQM2icVDUAjlVPx9n2MGbwfd8hlWcBsuH37iwCNukFhlPsuhBCaVys9m6b8ESC1x2DsDzPidtwXwWmlcnO5sphmnjV66IgN1lNIRH9DyijbngpAXq0bEMkp+ftNB82AxFOKs/nIuAxsVM0yQVehTgfta/rnMHuE7cF7qXzUHyUzmr6PU8j8vyupDs83bypsyEF2g7Y7XXfpjB8n9r0AprHzXjAluEYhaMnA0lRkKgaSIECmyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YROP7fnG+L/kaR15rZmJmAHwkOV9OPDOXLYVTY9WKVE=;
 b=GdD+43dqyEc36bbNSaMjYEhMVaTp3NmJhxOUEdnrwk6M3u5SofHglxKepsEZHOeBaB6Ocj/te65grwKrorhUCmliIEYcpSxsyesHtsbaIrT0lx7WwQFT/zuV4v82QqNFob7NcZS1oqw7xDEGY4Le41doTZUjlVziVVESUncbYY6K3WR/iLiyjZscf+ap4SBMtJrlESr2OUSMkZXqgjsqnvgbouNVX5aemEcj7aGeR9snessOQX0DEavLB0pJiZ0vhRiQxPqla6os1xVFt67/vopGGCCSY8bkZ75pS3rKSeq1Bb6cBVyTJNDLsh0IqZjaF/tn512RVqF57E0QVAtTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YROP7fnG+L/kaR15rZmJmAHwkOV9OPDOXLYVTY9WKVE=;
 b=Zzb60Z5Dk4lvVR46nA4nzBeyZsHuCPjGeOrAbwVjnmSIl//VEFngDik/6cCv5gFQ5Iv6P9zzgrhMVUWeo7vlCC1QRx2AI32ggAFNxcNXXUiVmkPoX3ttytACShTnr05Oe7ZFMG2GBspNQklDATY5IiW8Jwb8rvsbSfz0jFEsQwM=
Received: from SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:56 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::cd) by SJ0PR03CA0129.outlook.office365.com
 (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Set xcp id for mes ring
Date: Mon, 8 Dec 2025 12:17:14 -0500
Message-ID: <20251208171720.153355-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d65581-ee25-459b-23c5-08de367dba4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?slrq78FJGIoHtwpikuVtfWBl0uNx+yj5k7THsgUCR5HRIjXGo0E8svUPC04Z?=
 =?us-ascii?Q?dDUhzIljn8HkzdtbgAZakc1u5+I26AABfql4IFGkUVrYyLqeU4pp4ZlrNytP?=
 =?us-ascii?Q?b/QVLSCV5QI65CblziIorPwmB87z6lPFMLUKfSK5y7Wk0tm2VbnDlvDWyDuH?=
 =?us-ascii?Q?+UwfzdaJofWOB71v+5ePSoDL6J6q1jRi3qpzdz+8urXnyLHFsh1ovdvC+F7O?=
 =?us-ascii?Q?mrJ3XUhmCPAyGwbpHd2sS0HrBakPXzMpQw6DFw2RF3wJJJj8e7QFkoDXO9Ez?=
 =?us-ascii?Q?OrrE5YEWQ1W+MDb7nkS2bavKNNHTiH7Zd2/1kQMP3bYivnWQ1sr30LZKMrfb?=
 =?us-ascii?Q?VmnSbZLCn4MD1NDU9s8ijY5fkbEp7D4UCaJlvRKbJ1B7Pc+YfNU7/Y80e5tO?=
 =?us-ascii?Q?Ve/UbWIZclm90+xjiM42m/EnbuLRn7XqfDxss5zvi1hHxd+Th1ZCsfoUMEOK?=
 =?us-ascii?Q?ziNl2/Z/ym1HZf9NF1IViC2Ksd7SIfj/sk+6+XKr7BwEHnAv7yMunBa51vTn?=
 =?us-ascii?Q?610TlRIb6A1YCzqdG/KU459e2dGCQwEoC+svZ1rG8c+PBpJ555C8URMcwgPz?=
 =?us-ascii?Q?cqFmpS8tB4bM41EC2txFILkZpiJA0HEnh+ytMAZCe0YQqLixJPnjjPsKNAw1?=
 =?us-ascii?Q?8c6OfPGcUtC3z5CBFU3PM/1W1hnTCg4CACPcmFsnf6J3dhOedGLfRY4/bpU4?=
 =?us-ascii?Q?PDb22EIsPO5X4rokGXjVSkCO5cDGdwt6n1gDMXtgYkMtm8n1EvBDgcyBKM4r?=
 =?us-ascii?Q?zlwApJp7KOsoaiBGsRlCC3SRzC/dMJGC9+kE0wYPe/ChoUcwYsVppmeaWUEv?=
 =?us-ascii?Q?w6c1e4pvYNbRSmsN4L/6p/p+EzmcVrs6ULyX7pVkQjVN3aTFrF5FZ9Zrt+z3?=
 =?us-ascii?Q?N3SaJ+MmIdQQrsx/RreIycaw5Bnxd8W5DfmnU9AEwROhJF+NVNqXk1GhA6Cz?=
 =?us-ascii?Q?SFhxoylPGK/crgGnRWSY3w/0LEcFXtq2uawNvANWix5EBJdQif3EXhMpxEZO?=
 =?us-ascii?Q?MqQFNiP12CXJ4EywBOnqOjHmdQWGzzCLTXkpNWRHwUZrEtDTeMY6EW+8wRMf?=
 =?us-ascii?Q?9/sblAJoHUvtEElHFoTI3p7DSYAV1PvNtJRL0a+RJVuCGM7xRDYdh+neFT+u?=
 =?us-ascii?Q?sDf0H5FaGqFQrHmTfrdYvbp9Wsh9Jd2rRfRvUMLJhC9DyWrA2rnzEputqdfG?=
 =?us-ascii?Q?26pEWJQbVZE0g5YjVo5ZAOLXPKu9SV6Vbh8ezltFLneDU5qEDWmmUPxeMo+0?=
 =?us-ascii?Q?UCCMC+VwoSRHAqIaJfuGmJLVV+jKdTsXndDWlmfyAxCJj7PX+VOWzKMkXyD6?=
 =?us-ascii?Q?f53mQ0SsgWcswZsRTlTr/AScNGE1NCEg3v7vs9BVcoL8r1c/75qgEk0MJQ+H?=
 =?us-ascii?Q?1TPJIZ75H72KUQ4RHx1zjSa+670F+OxjcXNQXqrSCat4OdVPuh/OWiFXqEcD?=
 =?us-ascii?Q?n6rXF61e5iSYvqdgIK9ynV+CdjNsl+xRdQfUgczhXJZLLJREkzQ/NCtDzowy?=
 =?us-ascii?Q?Y6QSVK6SMz7E2qRc9expUqi9C/aI1DkBP+w7scHemIheFVLGfvdItDdG2y2B?=
 =?us-ascii?Q?15XNOvGdBH5A7Aw0ago=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:55.6140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d65581-ee25-459b-23c5-08de367dba4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Set xcp id for mes ring

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 1083db8cea2eb..73250ab45f202 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -540,6 +540,7 @@ static void amdgpu_set_xcp_id(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_GFX:
 	case AMDGPU_RING_TYPE_COMPUTE:
 	case AMDGPU_RING_TYPE_KIQ:
+	case AMDGPU_RING_TYPE_MES:
 		ip_blk = AMDGPU_XCP_GFX;
 		break;
 	case AMDGPU_RING_TYPE_SDMA:
-- 
2.51.1

