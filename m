Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9FC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7604210E390;
	Wed, 17 Jul 2024 19:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JkCjFRh5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D85CB10E390
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAPSPXKin4SRM0gOtPvKxB+Zi/bCyhTm61Wf99n2MtlSiiMrO9sQ1PZgOXaBXMGE2IGXEEOJpShzvuapie708WbSEEl7ejMUvp5BwrYGcLX7aGVU324Kqz66g52WSG+Ot3v1DSGEDMsa6kj9ITosYq3HXkaBR42biD6OAR+rOzXKxyobOHCYplZUShWz23SswwY1kYMENQRKVI4eqEMIW72Bj5JsTZyQE/lk3AodYHHXEf26aTeLjLcjWzWlVWJ1Ib2tvpNjYbixGafWhGRR83MX+fxIpnVz8LZTIBpUKdfSCqsOn1XCG6FIAKSUdHE96Ofgt9x6bg6N+yGII7ieZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+qlUfOyM//fJbLgwyBgzRddDSpj2Eir7DRynnyMMRU=;
 b=F4VlUsJsngdkzvUAe9MdZN6ppRmKNlxu/vJ6UMzof3fXfUoI+idYlXTn3Sn//jJIEY7aZfNSNSy1O8dGE9PGSEWyyR5Ull5srbokoR245Ut1yFHwK2pnaHDkgZbRCnw9mGaFtxm7YskV6+zzfFvQih/eFF+GPw9ivcFNk8iJ8qQQgp6GtN53SzyS4Xmvq4I5DI5Upt6X3bNBDiQWF1zWv0lL73Emx6l0eQ18RfKsFvlGywS751g5WiwfkeNF0mGkCCh5+oNJypOpdrR4dxzQ2d1bPAyry1SrQ+hBSMWopJ0ZlYH/5RTv+FSDEA3QFHlIgnGevVK28j2XteevQLk4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+qlUfOyM//fJbLgwyBgzRddDSpj2Eir7DRynnyMMRU=;
 b=JkCjFRh5WCg9ua3JqkNgdnCkNp6BIA5dSuHs4prbqAoIyZzJ724bZ8rlZhyZUmP1nnWozqjCRdFekpWq8ee/4A81/KbwgioC+ySMx8siWurEwaCPG/HArwUPb/vkRYiT1Qo+Li9sRTOtj2rGTY5GR+fVslqJrW0O3y307s4FCbQ=
Received: from CH0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:610:e4::23)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 19:39:42 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::65) by CH0PR03CA0198.outlook.office365.com
 (2603:10b6:610:e4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:41 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>,
 "Chaitanya Dhere" <chaitanya.dhere@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Remove ASSERT if significance is zero
 in math_ceil2
Date: Wed, 17 Jul 2024 19:38:44 +0000
Message-ID: <20240717193901.8821-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 456b97f7-076e-4428-bd29-08dca6983433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKuR30FVLwgc1X7xLoo3QNW3UTxbXKBlYtN/GXF4xqGYq5M8PNvg9DgKKVIe?=
 =?us-ascii?Q?5eLorNOordmUjWQBo7aIJOznVzK143+yfNWEbX/BCnYjWD/Nj3O12dVjJQW7?=
 =?us-ascii?Q?/opQrzalyzRrjUhFczZlQv/eMxvfNNbJAWwYt1kH+FmrayismqqogHqz6U0a?=
 =?us-ascii?Q?A18aVGzWa9tgX4T+FzvYMUv1F8la03V73aqjzNtnBHtCGDfd79hEmafunmag?=
 =?us-ascii?Q?+XEHe9rYTmvihtA8yt3DTODRAUUHGxM+zb2qAoPdZFUnvn+XlbVxg9dj/MDj?=
 =?us-ascii?Q?xeWHuENIUuNnBQ8+OEGAzuq6nwVeZsHOD0hKlza/gsERtjL4xN4CQ3bF6krn?=
 =?us-ascii?Q?g/zXjXIFcwcMaMkPvuNTYz12Zct/NkOyQBCLx/cU7JQ1wnDIzjOTzpGuLQel?=
 =?us-ascii?Q?NS6AMgam8VWSRAWGiZImYF3b3mohLj5Q8nl8werM9kHzzQoFKNZVlWplHkC2?=
 =?us-ascii?Q?pH2bEVi6D3tNjlA3gkvgxU1EKdKE3easgdwACG6R6zaq8ncChs41ReBzDy6+?=
 =?us-ascii?Q?+2J3NRq68OHdAHRTq0Pl6SeEgWDrI3TZeZpsn6u+dlR6jx8ebP3JEPQR33LH?=
 =?us-ascii?Q?TJVRQytG1hsdMhPin3odNp87GdIqAx7WhPkOIokiJKfZYEjmYCpa+6z/Pd40?=
 =?us-ascii?Q?xIrwCEFzHoqvs0D956OW/VVuUbtg5RVtQpZf2r0+gNlzPX8pVPbZrKg7N1WQ?=
 =?us-ascii?Q?xLKI7v57C5kZ/N+k8u04wIHAOBVG9tKLhbgot9999Vwj5SKDzMil7m94zh40?=
 =?us-ascii?Q?y0YBEC0SUcxSgLfHjVX+IySG3o4HxGSRbWOiUGLuVAJZ50+Dm1R13vP/lPYi?=
 =?us-ascii?Q?pfXCYDtRzdh8npkyqv1yMrOhOsbmhH5IqY31X9jTD3eHjRuBxI1x0lOlhZZl?=
 =?us-ascii?Q?V1syM82k72COoEAZ32WUO1HUSQr4wxJXwhUDEyRrN3aVMGZyNPMCD+GC3TR6?=
 =?us-ascii?Q?Sz4TNcUD7FbpVdvGi3YD5nc5ONc2UEJPcAElwE/q/0ursv785ANO8sioFcBR?=
 =?us-ascii?Q?lj2XfjRyMKGR7d+6b3H00qYTmfmAoRpzUoyjkGstKb23je8V8ozYQjDP2p/c?=
 =?us-ascii?Q?5FfBJQ3Ujr5ajYfSv7K/CRECRC4r1cJQCJw49bKqB+PgnrEDuVM+tSEIkYQI?=
 =?us-ascii?Q?QGkqBN7wftAWIN1xxwO+LddZYoeshSjknTLM5ve5KPJT4FlK6q8CUZVYe348?=
 =?us-ascii?Q?lcjPQBo/l4dDsAJHXlhebISW/LU9iVPMahZGE2wGeu46jjYZDwhVSamWwbFP?=
 =?us-ascii?Q?6sY+LMHiZvTujT8Gj99DSJVIwa9AKbTXATQXyz7tU69NQjRJzM7NO401mT5z?=
 =?us-ascii?Q?cNtYrR3G7PApzXkPPz4EMMmoCNuZ5OzEl2ad5FGJwOmFmMBfSNblV1izFGQN?=
 =?us-ascii?Q?zDIkW/y48yeNL7LCQhZTsvsb6YuWaZ4xl96bcI193uJR5G0dU8TqsqTDjnrp?=
 =?us-ascii?Q?lQMeGoQXBGJX/2uCjXjQxrlp27OtIpIn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:41.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456b97f7-076e-4428-bd29-08dca6983433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

In the DML math_ceil2 function, there is one ASSERT if the significance
is equal to zero. However, significance might be equal to zero
sometimes, and this is not an issue for a ceil function, but the current
ASSERT will trigger warnings in those cases. This commit removes the
ASSERT if the significance is equal to zero to avoid unnecessary noise.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c   | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
index 4822dbcc86bb..e17b5ceba447 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_standalone_libraries/lib_float_math.c
@@ -63,8 +63,6 @@ double math_ceil(const double arg)
 
 double math_ceil2(const double arg, const double significance)
 {
-	ASSERT(significance != 0);
-
 	return ((int)(arg / significance + 0.99999)) * significance;
 }
 
-- 
2.39.2

