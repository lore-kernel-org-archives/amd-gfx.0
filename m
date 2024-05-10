Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C9CC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 15:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFBF10E573;
	Fri, 10 May 2024 15:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OG/x/m9H";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3338C10E573
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 15:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6r7JR6BfFa3/bPUQML86x+T+shci6AF9Q7RRZO7ufmtv6UK1+1WLKM9b77L3pGi20mjh/dlmpnfiJZvv3uVHdaDTfZVnBbhjHB54Mdd6xpOICCmNI+FHBiRpkYOD5I165ogXh3ayiYXP8RupEZ2XuWbHCTeqWS9Os8qnnSHOK+0hOy634ivcvk/UyAYsvpbvBbgx00GKWYLmUMUOfdYp7SLLnKPvkVFOsfetZ96lkhqDd1uei+A93gaZl6FRisEbxWJ/njoBAEB3AfQP6g/+P5etOT0AvE0KdjtgSUQzW6jIT4u4c0JYgZha5GuF6/JyB5u0K3qQT9Sm75Bw2xiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79IlxVOKw9h61iQKI6jstWxXti8+PXBYQUK2A1d3UWg=;
 b=jFPmXMW00E05iTlW0glVDj/A+gjw8SRPlULbX/Oxs54wtYWI347463QQLL5hlPi7G/j9aW4/phI82b0rDpPUzuZ2Te2BhFhBzuW92Y4CLzt1qg266xEy+DAslcVZiGNJsM9wzBS2gx1fD8MtkX9jPaInpM9fxxBzY7Zzy2U8Uy9v3So9IF3sbRa4dkE99vpqqJk7sPaXBLB8qkreM3+Mw6oAejPKqvfkS/tvnss7VMzD/pH6Ad8QLVXcHoPk+w3XT5J1pj6g7i56cmdbRqlOz/ttedqWDiNGR0fdhsHsjax9ZUjCQU7FzIK1XbIceQdPXbkjahhARdZc1NL2ltVwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79IlxVOKw9h61iQKI6jstWxXti8+PXBYQUK2A1d3UWg=;
 b=OG/x/m9HoG5ak5HGY+jg9OxSqzjWtsOCzSLkFJjREan+plLwDXPMwfpzIsoOD7rluk8Zo9CTwY06JqWO4QjQLA7XKOHYpvuWuREms3UvaKqpAv+IKyll3pLv/qlIWfmxuO3/VqWA0OGmnd0A4GubKGX3TzRSMk4QcewCNnXpbKE=
Received: from CY5P221CA0083.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::17) by
 SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Fri, 10 May 2024 15:04:54 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::a4) by CY5P221CA0083.outlook.office365.com
 (2603:10b6:930:9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Fri, 10 May 2024 15:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 15:04:54 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 10:04:53 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Sreekant Somasekharan
 <sreekant.somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: Add GFX1201 to svm_range_get_pte_flags function
Date: Fri, 10 May 2024 11:04:29 -0400
Message-ID: <20240510150429.538312-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 845137c3-a3ca-4764-49c3-08dc71028c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W7fcKnSn9143/LAG/F9DZ3V1tPeNXRQ8ue26r99H12T8vu0GrPTW92ML9m4g?=
 =?us-ascii?Q?uoV4PdC1LN32d1MYrenB3vDePnH9TEsqIh5G076OJknnwlycCsfw2g4Zi+T7?=
 =?us-ascii?Q?A7SgrQgO2kETrv79iHUpD7ywvu3c2LYuxwSeFA2NpHvAXBb7JeBT84QEzqIM?=
 =?us-ascii?Q?N6F2Od72Te2wfmtC0e/RPzKN/wDvvaYpGipicF8aioFMdc//ZZClt8HnkjO6?=
 =?us-ascii?Q?hv4VHJlYuGwWcm2MmKngVTFunBK8q6bpZ7TY+jG0XqUm8HLMnFNzH7nmy89F?=
 =?us-ascii?Q?i2K3CTYOzmZFX2YhPG7xqwo+sNpuVuJYuCfiGMG5aAeuPzYLpJWQbKEks5rw?=
 =?us-ascii?Q?9W1n81OhJ7XLK5C+rWk0A/r7LzmdFlGNFZTyzmN/nnAnXZQ5VVu7J4KA0kk+?=
 =?us-ascii?Q?OcB6UxFayk/JnQZF3y/I05aGuuqTufKqJFfm9UM9DEynOtpOha4rOxaxKsSm?=
 =?us-ascii?Q?4dcUc5ocYdgDEPLcsynzJfhgudv78imNSQV2G8vlzyrDSTTwKhWRDxYVSjTM?=
 =?us-ascii?Q?p1VNHe22KlubJbf2zsussZ/PrIDAG8M+pdDf+bAR2SZoOcK9XKkwk5kabshW?=
 =?us-ascii?Q?RzEy/Vdz8EItztwpY1WKvy9/Cnz2+btrDYjm5Chw5J1DR3p3Vrn8MErfrIKo?=
 =?us-ascii?Q?l13H6eF13/6lI6bk/Z/KgUmJ8KCyAMAHX1NVBDOLOrNJZlxa2k8W4sSQPPEn?=
 =?us-ascii?Q?2ykKJjQPVcx+mLDnzx3RuP7l/4cLw3kQyXf29g4foHqyTgAF3y+2/+uDQPBu?=
 =?us-ascii?Q?lTc5IPeYKUASOsApa135ZAUp9eJWV8qajfIaIESTbqwTxmUOAIuRsyCnxvyu?=
 =?us-ascii?Q?iCMl2RpSKfxfp8lTP4NdZ15+kuE4IeYFBQXOjXKTJ+mbmwTojHf0FY/Plc9Z?=
 =?us-ascii?Q?k2cVWOhn/Ni05+vID0Xs8HlSIpz+Yp5al045fkibda9uJcTeA+XYGrFvm/Cf?=
 =?us-ascii?Q?W/m1fCfdgr7mciKj/+oB1JVIvNuFZvJCvq0vjQKgAoD4lJzSaaIJX+i5d99H?=
 =?us-ascii?Q?ZQYyZS0c9oetEThX3sFJIOov7AMreZP35LzGaDGfB0qSHWRfla4S3yPt3psN?=
 =?us-ascii?Q?o/VB/7e7Cu3JBj1hGmYJYla/fXUI71+dxbqN2zG7l9/1NNdfMrPvWEB1gY3Z?=
 =?us-ascii?Q?pmfll07LTBUfZljhTqjeY0ug6JOTWWlH+/TJaJud1gzcZ6mPR2h1j743o2F5?=
 =?us-ascii?Q?PI6EULGfpUjfh7Vr/DxAGJ7D2yyWrZwql87Vzt6AoumT2xbyQXhyyg7pUVam?=
 =?us-ascii?Q?0dm8fu98eKNnWEuNUdsvQX5AGbllUWWbEFQdjA5SPzlYZ7pW651hBlgtRBgJ?=
 =?us-ascii?Q?zV5+75BibrPt0R+SaLrTRpN2xprYi+lPB4Ek79iRVgcqGjvo5u4H8p+VkXfZ?=
 =?us-ascii?Q?Qc7/yB8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 15:04:54.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845137c3-a3ca-4764-49c3-08dc71028c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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

GFX1201 was missed in the commit below. Adding it in.

'Fixes: 7c06cc729edc ("drm/amdkfd: mark GFX12 system and peer
GPU memory mappings as MTYPE_NC")'
Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b1ec7ef844ab..28c2c1b66226 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1250,6 +1250,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_node != node)
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-- 
2.34.1

